Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUHHVmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUHHVmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 17:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUHHVmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 17:42:15 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:39559 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263962AbUHHVl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 17:41:26 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Tim Wright'" <timw@splhi.com>, "'Martin Mares'" <mj@ucw.cz>
Cc: "'Joerg Schilling'" <schilling@fokus.fraunhofer.de>,
       <James.Bottomley@steeleye.com>, <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Sun, 8 Aug 2004 14:42:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1091899593.20043.14.camel@kryten.internal.splhi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcR8pAAEpGt4aEPFTFGZuYjXeTYr1gA5441w
Message-Id: <S263962AbUHHVl0/20040808214126Z+128@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg has done a horrible job explaining how Solaris uses path_to_inst. The
notion that every storage device gets a controller, target and lun is just
horribly incorrect. Besides, he has way too much ego to think that anyone is
going to actually listen to him, he just does Solaris a disservice IMHO.

For instance, consider a modern scsi tape drive, connected via a SAN switch,
to a fibre-channel host bus adapter on the end system. The st (scsi tape)
driver will enumerate the devices if they haven't already been enumerated
(that's what path_to_inst is for) when you ask the system to reconfigure
devices (with devfsadm or a reconfigure boot like boot -r).

The tape drives are merely given an index, i.e. /dev/rmt/0, /dev/rmt/1,
etc.. The instance numbers are assigned and tracked by path_to_inst to add
some sanity for system administrators. It simply tracks the location of a
card in a system, to instance numbers that were assigned the first time a
card was added to a system. This allows me to remove a scsi or network card,
reboot the system, then later when I receive the new part, replace it and
the instance numbers will never move around. Here are a couple real-world
examples:

My last laptop had not built in NIC, but the docking station did. The
docking station had a 3com 3c950 NIC built in. I also had a 3com cardbus NIC
in the system as well.

If the system was undocked, the cardbus nic was eth0. Every time you docked
the laptop, the docking station NIC became eth0.

Path_to_inst solves this because it would track bus <bus>, slot <slot>, card
type <type>, driver <which driver> to the number it was enumerated at on the
first boot. Thereafter, when the system would enumerate devices, it would
compare the devices found with the file /etc/path_to_inst. This way, it
would not collapse the device numbering just because a NIC had been removed.
It assumes that you don't want software that relies on such numbering
(software RAID or cluster software for instance) to break horribly because a
scsi or network card was removed.

In the earlier example on how tape devices are enumerated. If I remove
/dev/rmt/2, on the next reboot, /dev/rmt/3 does not become /dev/rmt/2. If I
truly want /dev/rmt/3 to become /dev/rmt/2, then I need to prune dangling
links from path_to_inst via an option to the devfsadm command (-C I think).

Fibre Channel cards absolutely add some burdon beyond the physical location
of the card when trying to track devices. This boils down to the way you
bind to devices. This means part of the burdon of making device name
assignments not move around across reboots are on the writer of the device
driver.

The emulex and jaycor (JNI) host bus adapters for fibre channel and
arbitrated loop allow you to bind to devices in many ways. If you bind on
target, and a device is replaced, then the devices are going to move around
possibly on every reboot, simply because the devices will be enumerated in
the order they are seen by the SAN switch. If a device takes a little longer
than normal to be seen by the switch, it will be seen in a new order on the
following reboot and the host is none the wiser. This won't be a problem
with hard drives as their LUN is probably fixed, but the target is
meaningless for devices on a SAN, you can pick whatever target you want.

If you bind on world-wide-port-name, you can track devices by what port they
are plugged into. If you do this, you are placing trust that devices will
not be detected in different orders behind that port. If that port is a
fibre adapter on an EMC storage array, this is fine because each drive slot
is tied to a unique LUN number, but if this is a tape drive, the device
orders can still move around.

If you bind on world-wide-node-name you are binding against the actual
device. This is better for tape drives, but if you need to replace one, you
won't get your old number unless you reboot because most vendors will not
reset the wwn for you.

JNI cooked up a cool way to identify devices in a fabric that allows tape
drives to be hot-swapped called the port id. This is for loop devices only,
but it's pretty cool.

The port id is a combination of which switch domain, alpa and drive id. It
allows tape drives that are on a fabric to be hot swapped and not lose their
device index from the host perspective.

Anyway, the point of my digression is, yes not all device numbering schemes
will fit into the model of path_to_inst completely, but I have seen it save
many junior admins when working with low cost software RAID solutions that
keep track of devices based on their device paths. When the junior admin
plays musical cards, etc.. the path_to_inst file can be used to piece the
puzzle back together as long as they didn't play musical drives as well.

--Buddy







-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Tim Wright
Sent: Saturday, August 07, 2004 10:27 AM
To: Martin Mares
Cc: Joerg Schilling; James.Bottomley@steeleye.com; axboe@suse.de;
linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices

On Fri, 2004-08-06 at 17:14, Martin Mares wrote:
> Hello!
> 
> > I see always the same answers from Linux people who don't know anyrthing
than
> > their belly button :-(
> > 
> > Chek Solaris to see that your statements are wrong.
> 
> Well, so could you please enlighten the Linux people and say in a couple
> of words how it could be done?
> 
> 				Have a nice fortnight

I can offer reasons as to why it cannot :-)

The path_to_inst stuff assumes a simple physical bus topology. It is
completely unsuited to e.g. a fibre-channel fabric. It is also unsuited
to iSCSI - my disks aren't attached to eth0, they're attached to
whichever interface has a route to the server. It's also worthless for
USB. The controller, bus and target are meaningless - the target number
is dynamically assigned at plugin so giving a name to controller 0, bus
0 target 3 is utterly pointless.

Linux and/or associated drivers has mechanisms to handle consistent
naming for a number of these (WWPN-binding for FC, similar device
binding of the unique ids for iSCSI, the hotplug infrastructure for usb
etc.). All of these map devices to consistent device names in /dev. The
"Unix" way of accessing devices has always been via names in /dev. I
completely fail to understand why Joerg wants to try to force a naming
model that is both alien to the native systems (I want /dev/cdrw on
Linux; I probably want D: on Windows or something like that), and is
inadequate to the task if you move beyond the simple world of parallel
SCSI.

Tim

-- 
Tim Wright <timw@splhi.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

