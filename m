Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSFYQ5l>; Tue, 25 Jun 2002 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSFYQ5k>; Tue, 25 Jun 2002 12:57:40 -0400
Received: from waste.org ([209.173.204.2]:26545 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315628AbSFYQ5j>;
	Tue, 25 Jun 2002 12:57:39 -0400
Date: Tue, 25 Jun 2002 11:57:38 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Patrick Mochel <mochel@osdl.org>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <Pine.LNX.4.33.0206250824590.8496-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206251146440.9420-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002, Patrick Mochel wrote:

>
> On Fri, 21 Jun 2002, Oliver Xymoron wrote:
>
> > On Thu, 20 Jun 2002, Patrick Mochel wrote:
> >
> > > > But it was entierly behind me how to fit this
> > > > in to the sheme other sd@4,0:h,raw
> > > > OS-es are using. And finally how would one fit this in to the
> > > > partitioning shemes? For the system aprtitions are simply
> > > > block devices hanging off the corresponding block device.
> > >
> > > Partitions are purely logical entities on a physical disk. They have no
> > > presence in the physical device tree.
> >
> > As I raised elsewhere in this thread, the distinction between physical and
> > logical is troubling. Consider iSCSI, (aka SCSI-over-IP). It's analogous
> > to SCSI-over-Fibre Channel, except that rather than using an embedded FC
> > stack, it's using the kernel's IP stack. But it's every bit as much a SCSI
> > disk/tape/whatever as a local device. Ergo, it ought to show up in the
> > device tree so that it can be discovered in the same way. But where?
>
> An iSCSI device is a physical device; it just doesn't reside on the local
> system. We should represent the device in some physical form, since the
> logical class mappings do/will assume a mapping to a physical device.
>
> These devices are essentially children of the network via which they're
> attached. When devices are discovered, I'm assuming you can derive the
> network device through which you're communicating, so you can get enforce
> the ancestral relationship.

As you note below, it can be available on multiple interfaces. For maximal
confusion, it could be available on a regular NIC and an iSCSI offload
NIC, making it appear as a regular SCSI device (a case to bear in mind,
but one I doubt can be dealt with cleanly).

> You want the ancestral relationship for several reasons. You'd wouldn't
> power down such a device on PM transitions or during shutdown, but you
> would stop I/O transactions. The drivers for these devices should recogize
> it's a remote device and handlethis. And, if you were to remove the bridge
> device (the network card, etc), you want the devices behind it and their
> logical mappings to go away gracefully.

Ok, so what's your take on: NBD (iSCSI without all the SCSI crap),
software RAID, LVM, ramdisk, partitions (a degenerate case of volume
management), loopback, and filesystems. All but the last are block devices
that want to be treated just like disks and will want to know about things
like PM transitions, etc. Filesystems haven't made it into the tree
because we've got that info elsewhere and we've been assuming they're
leafnodes, but if we put loopback devices on top of them, that's no longer
the case. It'd be cleaner globally if this were all explicit in the driver
tree.

> Mulitpath devices, which you could easily have with multiple routes to the
> same IP address, are another issue that must be addressed. It hasn't yet,
> but we're getting closer...

Good to know it's on the radar..

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

