Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSFXTXb>; Mon, 24 Jun 2002 15:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315182AbSFXTXa>; Mon, 24 Jun 2002 15:23:30 -0400
Received: from waste.org ([209.173.204.2]:2523 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S315179AbSFXTX1>;
	Mon, 24 Jun 2002 15:23:27 -0400
Date: Mon, 24 Jun 2002 14:23:21 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'David Brownell'" <david-b@pacbell.net>,
       "'Nick Bellinger'" <nickb@attheoffice.org>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: driverfs is not for everything! (was: [PATCH] /proc/scsi/map )
In-Reply-To: <200206241809.g5OI9Ds02886@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0206241404020.9420-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, James Bottomley wrote:

> andrew.grover@intel.com said:
> > If a device can be accessed by multiple machines concurrently, it
> > should not be in driverfs.
>
> On that argument, we'll eliminate almost all Fibre Channel devices!
>
> I think the qualification for appearing in driverfs is actually possessing a
> driver.  Therefore, we accept FC and iSCSI.  Things which appear as
> FileSystems are debatable, but not anything which has a real device driver.

Between iSCSI and filesystems there's still MD, loopback, ramdisk, NBD,
LVM, and general partitioning. They all expose block devices and try their
damnedest to look like physical devices. If we're serious about using
driverfs as a system for unifying device detection ("show me all my disks,
please"), then these should all be in too.

And they raise some interesting problems. As pointed out earlier, iSCSI is
potentially multipath, as is LVM, NBD, and software RAID. Hardware RAID is
already multipath in some cases so our tree really ought to be a DAG.

And let's think about loopback a moment. It's potentially layered on top
of a filesystem, layered on top of a logical volume layered on top of SCSI
and ATA. Just from the power management perspective, to quiesce our
system, we'll have to know that we need to flush loop->fs->lvm->scsi/ata
before we can shut down whichever drive.

So to be done right, we need to pull filesystems into the tree too (rather
than just implicitly correlating against /proc/mounts).

> > We need a device tree to do PM. If driverfs's PM capabilities are hurt
> > because it doesn't stay true to that, then the featureitis has gone
> > too far.
>
> Perhaps it's more a question of whether power management belongs as an every
> unit item in driverfs.  As you say, we get problems where the device is shared
> between multiple computers.

And we already have a problem there for local SCSI - see OpenGFS which
lets you share a filesystem on a single SCSI bus. Admittedly, that's
rather sick, but not as appalling for FC, iSCSI, or NBD (or GFS's
internal equivalent).

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

