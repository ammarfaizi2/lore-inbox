Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVJQFle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVJQFle (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 01:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVJQFle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 01:41:34 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:62571 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932210AbVJQFle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 01:41:34 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch 0/8] Nesting class_device patches that actually work
Date: Mon, 17 Oct 2005 00:41:29 -0500
User-Agent: KMail/1.8.2
Cc: Greg KH <gregkh@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>
References: <20051013020844.GA31732@kroah.com> <d120d5000510141002v67a06900m219b47246c1d92c1@mail.gmail.com> <20051015150855.GA7625@vrfy.org>
In-Reply-To: <20051015150855.GA7625@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510170041.30671.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 October 2005 10:08, Kay Sievers wrote:
> On Fri, Oct 14, 2005 at 12:02:30PM -0500, Dmitry Torokhov wrote:
> > 
> > Does anyone know how many of these we have?
> 
> A lot! From general distro specific system-management to subsystem specific
> setup tools and tons of udev rules... There is definitely no chance to break
> /sys/class in _all_ subsystems by introducing subdirectories.
> 
> > We are moving /sys/block
> > to /sys/class so many of these will require upgrades anyway.
> 
> If needed, there can be a link from /sys/block to /sys/class/block and it
> will look exactly like is is today.
> 

We could also add links in the form of:

	/sys/class/<subsystem>/<nested_class> ->
			/sys/class/<subsystem>_<nested_class>

to keep compatibility with nested classes too to give userspace
a chance to catch up...

> > Could libsysfs hide some of the changes?
> 
> Not without hardcoding susbsystem-specific knowledge/translation into it, which
> will not happen and will be definitely the wrong way to solve such a thing.
> Only the block-move case could be easily covered by libsysfs as it is already
> prepared to do this and "block" is a "class" from the first version of
> libsysfs on.
> 

OK..

> > Btw, is your proposal with moving it all into /sys/device less drastic?
> 
> Definitely, cause it keeps all the curent api! The only difference is that class-devices
> are reached by symlinks instead of real directories. The pathes to the devices are
> the same!
> 

OK..

> > > It invents artificial subclass names below a "master" class, which
> > > is absolutely not needed.
> > >
> > 
> > I really do not see why you think that "ieee1394_node" and
> > "ieee1394_transport" are natural names while "ieee1394/node" and
> > "ieee1394/transport" are "artificial".
> 
> Well, all three classes are different kind of devices. All devices are at the
> same level, which I absolutely like. You propose an artificial "hierarchy of
> classes" or a "superclass", which will break everything and give us no advantage,
> I think.
> 

Call it "subsystem" actually.

> > > It creates the magic "interfaces" directory, which is confusing, cause
> > > it classifies devices by itself.
> > >
> > 
> > Why is "interfaces" is more magic than "wireless"? Is it just the name
> > that is confusing? We could call it "netifs", "netdevs", "devices" -
> > just pick a name you like better.
> 
> Cause "interfaces" is a classification by itself and this is wrong! If
> you give one of your "subclass devices" an interface, let's say "input0"
> will get a device node to talk to the low-level device, where do you
> want to stick it then? You will move the device around to the
> "interface" directory? That breaks the api!
>

No, not at all. The input0 will get a new interface, blahdevX, exactly
like eventX, mouseX, jsX, tsX, etc. and it will go into "interfaces".
input0 itself will stay in /sys/class/input/devices.

> Take a step back and look what a kernel interface is about. It is to
> give userland a unified view to devices. The internal kernel structure
> like "bus", "class", "bus_device", "class_device" are in no way interesting
> for userspace. It's a kernel implementation detail.
> 
> All we want are DEVICES! And from devices we want:
>   - a classification:    /sys/class/<name>
>   - the properties:      attribute files to read values or to invoke actions
>   - the dependency tree: /sys/devices/<device1>/<device2>
> Any mix between any of the three things is completely wrong, makes it hard to
> read and can never provide a stable device interface.
> 

Yes, I agree that we should have device tree in /sys/devices. But I do not
think that flat classification is sufficient. Right now it is not enough
and we compensate for it with names.

-- 
Dmitry
