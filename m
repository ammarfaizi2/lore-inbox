Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUAEWTp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUAEWS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:18:58 -0500
Received: from CPE-24-163-213-29.mn.rr.com ([24.163.213.29]:11694 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S265963AbUAEWSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:18:00 -0500
Subject: Re: udev and devfs - The final word
From: Shawn <core@enodev.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.58.0401051224480.2153@home.osdl.org>
References: <20040104034934.A3669@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
	 <20040104142111.A11279@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
	 <20040104230104.A11439@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
	 <20040105030737.GA29964@nevyn.them.org>
	 <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
	 <20040105132756.A975@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401050749490.21265@home.osdl.org>
	 <20040105205228.A1092@pclin040.win.tue.nl>
	 <Pine.LNX.4.58.0401051224480.2153@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073341077.21797.17.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 16:17:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus is correct. I say this somewhat because I find his arguments to
make perfect sense in a philosophical way, but more because it is his
kernel.

Anyway, I'll weigh in with my 0.02 pesos:
Right now, as things are, hardware devices' numbers are not very stable
as it is. Detection order can and will change, and you should not rely
on them being the same. PERIOD.

Having said that, I will say that they are /somewhat/ stable. You can,
in general, say 'fdisk /dev/hdb' and be editing the same block device's
partition table... That is, if nothing has changed in the BIOS or
hardware or kernel or....

Now, correct me if I'm wrong, but I don't believe we are expecting
device numbers to change nearly every time you reboot given there are no
hardware changes with a dynamic numbering scheme, right?

I would, as an admin, have need for distinguishing between my 4
identical SATA hard drives with identical partition tables without
having to resort to examining UUIDs, serial number or FS labels by hand,
especially if I dd(1) stuff between them. I understand this is not as
simple as with ide(0-N)(pri|sec)(master|slave) (ignoring that ide(0-N)
could be detected in arbitrary order) as SATA is different.

As an admin, would I at least theoretically have /some/ consistency if
merely for my own sanity when dealing with block devices by hand (I do
need to setup LVM stuff from time to time)??

On Mon, 2004-01-05 at 14:38, Linus Torvalds wrote:
> On Mon, 5 Jan 2004, Andries Brouwer wrote:
> > 
> > > udev can then use those serial numbers to have a stable pathname
> > 
> > True. Provided that it knows how to get them.
> 
> And that is the _only_ thing that the "device number" actually is. It is a 
> cookie that the kernel has allocated for the device that the kernel knows 
> about. Nothing more.
> 
> Go back and read my emails. Device numbers cannot have any meaning, they 
> literally are _only_ useful as cookies. 
> 
> > The kernel driver knew all about the device.
> 
> No. The kernel driver knows _of_ the device, it does not know "all about"  
> the device. And that's a big difference.
> 
> Quite often the kernel only knows that it found "a device". It has very
> limited knowledge about what the device is, and what it can do. That's why 
> we have tools like "smartd" etc, that know a lot more about devices than 
> the kernel often does.
> 
> In particular, the kernel driver knows _nothing_ about potential serial
> numbers or how to read them for different classes of devices.
> 
> > Must udev also know all about all possible devices? Do I/O to these devices?
> > Or must sysfs export all data that could possibly be used?
> 
> There is nothing to export. You seem to imply that the kernel somehow
> knows more than user space, but the reverse is generally true. 
> 
> In particular, the kernel should never have policy encoded in it, and 
> naming of a device is about pretty much nothing _but_ policy. Stuff that 
> the kernel literally has _zero_ knowledged about.
> 
> Yes, the kernel knows the physical location, but that doesn't actually 
> help the kernel itself. It's exported through sysfs, yes, and udev, 
> together with the hotplug stuff, can be used to make up the "stable name". 
> 
> Have you even _tried_ udev? Udev can do exactly things like find UUID's 
> off disks - something the kernel doesn't have a _clue_ about. When the 
> kernel sees a disk, it's just a disk. The kernel doesn't know if there is 
> an UUID embedded on the disk, and the kernel SHOULD NOT HAVE A POLICY to 
> try to find one.
> 
> But for user space, the thing is trivially done: the kernel will notify
> user space about the fact that it found a device (without necessarily
> knowing what the heck the device is - quite common with USB or specialty
> SCSI devices). The kernel pretty much doesn't know _anything_ about things
> like laser range finders, cameras etc. It ends up classifying the device 
> on a very rough level, nothing more.
> 
> And without knowing practically _anythign_ about the device, it still has
> to allocate a device number. Exactly so that somebody else can come around
> and poke at it, and maybe know that "ahh, this device is a USB-attached
> camera" or similar.
> 
> Do you not see that fundamental issue? The kernel has to allocate a number 
> before a UUID or anythign else is necessarily available. 
> 
> The UUID/serial number/type policy comes _later_.
> 
> 		Linus
