Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271356AbTHHOCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271357AbTHHOCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:02:20 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:31469 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S271356AbTHHOCG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:02:06 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: David Woodhouse <dwmw2@infradead.org>
To: Yury Umanets <umka@namesys.com>
Cc: Daniel Egger <degger@fhm.edu>, Nikita Danilov <Nikita@Namesys.COM>,
       Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1059301810.17567.98.camel@haron.namesys.com>
References: <3F1EF7DB.2010805@namesys.com>
	 <1059062380.29238.260.camel@sonja>
	 <16160.4704.102110.352311@laputa.namesys.com>
	 <1059093594.29239.314.camel@sonja>
	 <16161.10863.793737.229170@laputa.namesys.com>
	 <1059142851.6962.18.camel@sonja>
	 <1059143985.19594.3.camel@haron.namesys.com>
	 <1059181687.10059.5.camel@sonja>
	 <1059203990.21910.13.camel@haron.namesys.com>
	 <1059228808.10692.7.camel@sonja>
	 <1059231274.28094.40.camel@haron.namesys.com>
	 <1059232897.10692.37.camel@sonja>
	 <1059301810.17567.98.camel@haron.namesys.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1060351312.25209.468.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Fri, 08 Aug 2003 15:01:52 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-27 at 11:30, Yury Umanets wrote:
> I thought, if blocks lie side by side, as current block allocator does,
> this increases probability of flash block device cache hitting (take a
> look to drivers/mtd/mtdblock.c), what is definitely good. Isn't it?

Please do not use the word 'good' in the same sentence as mtdblock.

The mtdblock device is fundamentally not suitable for use in production
in write mode -- by design. 

'Normal' file systems such as ext3/reiser{fs,4} do not operate on flash
directly. Flash is _different_ -- you can't atomically overwrite
small-sized 'sectors', and you have to care about wear levelling.

There are two types of flash. On the original and more common NOR flash,
the 'erase blocks' are typically of the order of 64KiB in size -- they
start off filled with 0xFF, and you can clear bits individually until
you're bored or they're all set to zero. At which point you can erase
the _whole_ eraseblock back to all ones again.

On the newer and cheaper NAND flash, there are more restrictions. The
eraseblocks are smaller (typ. 8KiB) and it's subdivided into 'pages' of
typ. 512 bytes -- while with NOR flash you can clear bits individually
in as many cycles as you like, with NAND you have a limited number of
write cycles to any given 'page', after which point current leakage
causes the contents of that page to become undefined.

Neither of these are suitable for use directly as a block device. You
need some kind of 'translation layer' to make them emulate a hard drive
in some way. Such a translation layer will ideally also handle wear
levelling and bad block management for you.

The most naïve such 'translation layer' is that implemented in
mtdblock.c. Upon a write request, it reads the eraseblock containing the
512-byte sector to be changed, modifies the in-memory copy, then erases
the flash eraseblock and writes it back again. There is some caching
present to prevent subsequent writes within the _same_ eraseblock from
causing more than one erase cycle, but there's no wear levelling and no
bad block management. There's a 1:1 mapping from 'logical' addresses
within the fake block device and physical addresses on the flash. 

If you lose power or crash between the 'erase' and 'writeback' portions
of the above-described read/modify/erase/writeback cycle, you have lost
not only the contents of the sector you were trying to modify, but also
the 128KiB in which it was resident. This is _really_ not a good idea.
The mtdblock device should be used only for read-only operation (e.g.
with cramfs) in production, and for writing only during setup.

There also exist some more complicated 'translation layers', which are
basically pseudo-filesystems used to emulate a block device using flash
as backing store. They perform their own wear levelling and journalling
to ensure reliability. The ones supported by Linux are FTL (used for NOR
flash especially in PCMCIA devices) and NFTL (used on the NAND flash
found in DiskOnChip devices). Although these aren't _fundamentally_
broken as mtdblock is, they are still somewhat suboptimal. There's a
SmartMedia translation layer (SM is basically just NAND flash) too,
which nobody's bothered to implement yet.

They still need to do some form of garbage-collection, copying around
still-valid sectors from one place on the physical medium to another, to
allow an eraseblock which contained some obsolete data to be completely
obsoleted and hence erased to free up usable space. However, the block
device layer is never told by the file system when a sector is no longer
used -- so if you fill the file system with data then 'rm -rf *', the
_block_ device will still think it's entirely full of data, and
carefully copy that data around the physical medium for you in case you
want it back.

Also, your file system needs its _own_ journalling to ensure data
integrity at the higher level, since the block device 'translation
layer' only ensures the same form of data integrity that a normal hard
drive would achieve, and nothing more. So you (the file system) end up
writing data (or at least metadata) changes out to the physical medium
twice, once to the 'journal' on the faked block device, and once to the
real location on the faked block device, while the underlying
'translation layer' is performing its own journalling underneath you to
ensure integrity too. This is far from ideal for flash wear. 

Hence the development of JFFS, JFFS2 and YAFFS -- file systems which
operate directly on the flash chips rather than introducing the
suboptimal 'fake' block devices. This isn't DOS any more -- we don't
need to provide INT 13h Disk BIOS emulation and then expect everyone to
use FAT atop it :)

For flash you can access directly as _flash_, a file system specifically
designed for the purpose is the better approach. JFFS2 performance is
being improved, and YAFFS (and soon YAFFS2) take different approaches to
the problem. 

Some devices, however, are made of flash but do their best to hide it
from you.

CompactFlash may have flash internally but to all extents and purposes,
as far as the computer can tell, it really is a (somewhat unreliable)
IDE drive. It has a 'translation layer' built into its black box -- you
can't tell whether it does its own wear levelling or not, but in the
majority of cases we suspect not. Anecdotal evidence is that its
internal firmware also tends to get the journalling part of the
'translation layer' wrong too, and can get its internal
'pseudo-filesystem' into an inconsistent state from which it cannot
recover. Of course, since you can't access the flash directly from
software, you cannot do anything but bin the unit when this happens. I
assume the usb-storage devices are very similar.

The practice of using JFFS2 on CF (and other real block devices) isn't
really something I encourage, but it seems to have happened because
there isn't a 'real' block device based file system which is
powerfail-save, optimised for space and which uses compression. If
reiser4 can fill that gap, that would be pleasing to me.

-- 
dwmw2

