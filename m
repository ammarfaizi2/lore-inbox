Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSFTSMB>; Thu, 20 Jun 2002 14:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSFTSMA>; Thu, 20 Jun 2002 14:12:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24335 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315278AbSFTSL6>; Thu, 20 Jun 2002 14:11:58 -0400
Date: Thu, 20 Jun 2002 11:11:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Martin Schwenke <martin@meltin.net>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <20020620165553.GA16897@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0206201046340.8225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jun 2002, Andries Brouwer wrote:
>
> At present this does not look very useful, but it may have future.

Nobody is actually using it yet, so there hasn't been much feedback (and,
for the same reason, not much reason for driver writers to care -
everything that shows up there now ends up being pretty much built by the
bus that contains the devices rather than any device-specific information
itself).

> But there is a pressing present problem. What name do my devices have?
> I plug in a SmartMedia card reader. It will become some SCSI device.

That's a user-space issue, the kernel is not going to make any policy.
We've seen where policy takes us with devfs.

User space is notified of new devices through /sbin/hotplug (another thing
that USB and PCI do correctly, and SCSI doesn't do), which is really quite
orthogonal to driverfs. You can use one without the other, and in fact
today many people _do_ use /sbin/hotplug without actually using driverfs.

The /sbin/hotplug interface gives enough information that you can load
drivers (if the kernel couldn't figure it out on its own using existing
drivers), set up devices (network device routing, but possibly also
automated partitioning, or bus scanning).

But driverfs also gives information that /sbin/hotplug doesn't:

 - existing devices (ie for "events" that happened before boot, including
   obviously non-hotpluggable stuff)

 - relationships between them (ie the hierarchy)

 - relationships between devices and drivers (this is not made available
   yet, although the infrastructure is there: the idea is that you can see
   which driver handles a device, but also which devices a driver handles)

 - relationships between devices and things like the networking layer (ie
   the interface quite naturally extends to doing things like symlinks
   like "/devices/networking/eth0 -> /devices/root/pci0/00:1e.0/04:04.0"

In other words, it's just a way of exposing information that the kernel
already has, and that the kernel has to have _anyway_.

It also has the _potential_ to allow users to create their own
relationships. In particular, it should be rather easy to expose a symlink
to the "canonical name" in the kernel, and have a device manager that just
walks the devices in /devices, and updates them so that you get things
like

 - my SCSI controller:

	/devices/root/pci0/00:02.0/02:1f.0/03:07.0

 - bus 1 on that controller:

	[..]/02:1f.0/03:07.0/bus1/

 - id 2 on that controller:

	[..]/02:1f.0/03:07.0/bus1/id2

 - lun 0 on that controller

	[..]/02:1f.0/03:07.0/bus1/id2/lun0/

 - partition 1 on that disk

	[..]/03:07.0/bus1/id2/lun0/part1/

 - linkage to the "old name" world, with permissions:

	[..]/lun0/part1/traditional -> /dev/sdb1

(whether that "traditional name" linkage is done automatically by the
kernel using the canonical names, or by /sbin/hotplug together with a
bootup script, is an implementation detail. Because I would personally
prefer to avoid the naming flamewar, I'd prefer it to be in user space,
but I won't scream _too_ loudly if the kernel defaults at least the
standard names on its own.

These are all things that the kernel already knows about, they just
haven't had "struct device"s associated with them.

> Of course file system names are free, so instead of asking what sdX
> this device is, I should ask what major:minor this device is.

That is quite possible, and it all fits very well into the structure.

NOTE NOTE NOTE! Driverfs on _purpose_ does not handle permissions, and
has rather long names (you need long names if they are meaningful). That
means that it is _not_ a replacement for /dev itself. It's not meant to
be, and it really shouldn't be. Think of it as nothing but a virtual
filesystem that exposes _kernel_level_ relationships between devices.

Nothing more, nothing less.

But "what major/minor is this device on" is definitely such a kernel-level
relationship.

> In other words, there is the difficult naming problem,
> but there is also the translation problem. The user does
> not recognize the device as USB device 04e6:0005:...
> She thinks of this thing as her DaneElec card reader.

Note that the _user_ really shouldn't use driverfs directly.

If you reall ysee it as a way for the kernel to expose it's relationships,
you realize that it's useful for things like device managers, and for
whatever random system program that wants to find out about the hw layout.
Installers, and yes, things like CD recorder programs etc.

The user should generally only interact indirectly with it. Possibly
through a nice graphical user interface that uses the relationships to let
the user select a printer (instead of "lp0", you can show what printers
are in the system, what names they reported etc).

Is this something unique to driverfs? No. We _do_ have things like
/proc/scsi and /proc/ide etc, and they obviously work for most things. But
they are all ad-hoc, and they _cannot_ be anything else than ad-hoc
without some structure to glue them together.

driverfs _is_ that structure. And it isn't much else.

> That information is not easily obtainable without his patch.
> I do not see that driverfs provides such information.

But you caould come up with a diverfs-based patch that _also_ easily
obtains all the same information, and does it in a format that when the
same information is relevant in IDE disks, IT CAN LOOK THE SAME!

That's really the whole point. A clearinghouse for information.

		Linus
>


