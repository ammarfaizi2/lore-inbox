Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbWCWHth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbWCWHth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 02:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbWCWHth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 02:49:37 -0500
Received: from science.horizon.com ([192.35.100.1]:54064 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965251AbWCWHtg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 02:49:36 -0500
Date: 23 Mar 2006 02:49:29 -0500
Message-ID: <20060323074929.26749.qmail@science.horizon.com>
From: linux@horizon.com
To: kalin@thinrope.net, linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I thought that journaling filesystems happen to overwrite exactly the same
> place (where the journal is) many times... Am I mistaken?

Sort of.  The journal is much larger than a signle block, and used
circularly, but it does get on average more traffic than the rest of
the disk.

> So the effect is what we had for floppies (some many years ago) where sector
> 0 and others where FAT structure was kept were overused and start giving
> errors - so the only solution was to throw away that floppy.
>
> Hard disks had the same problem, but they have algorithms to relocate bad
> clusters.

Actually, hard drives shouldn't have the same problem.  The key difference
is that, on a floppy, the head touches the media, causing wear wherever
it hangs out.  The head is very smooth, so it's minor, but it happens.

On a hard drive, the head never touches the media.  There is no wear.
The magnetic writing happens across a very small air gap, and nobody's
ever found a wearout mechanism for the magnetizing part of things, so you
should be able to overwrite a single sector every rotation of the drive
(120 times a second) for the lifetime of the drive (years).

> So do these "leveling algorithms" refer to the same? Relocating bad cells?
> If not, you can see how a journaling system can fry a CF card quickly.

They do that, but they're also cleverer.  Since flash media have no
seek time, there's no reason that the sector number as specified by the
computer needs to have anything to do with the physical location of the
bits on the flash, and they don't.  If you write to the same sector over
and over, a flash memory device will do the write to different parts of
the memory chip every time.

This is called "wear leveling" - trying to use all of the chip an equal
amount.  You'll see in high-density NAND flash systems there are actually
528 bytes per "sector".  The extra 16 bytes are used to record:
- Whether this sector is still good or not
- The number of times this sector has been written
- The logical sector number of the data here

On startup, the first thing a thumb drive or CompactFlash card does is
read the extra 16 bytes from every sector and build a translation map,
so when a request for a given logical sector comes in, it knows where
to find it.  Note that there are more sectors on the ROM than on the
hard drive it emulates, so there's always some spare space.

Further, when writing, occasionally a sector that's just sitting there
not bothering anyone is copied, so that the flash it occupied can be
used by faster-changing data.

(This is all complicated by the fact that, while you can *write* one
528-byte sector at a time, you can only write to an erased sector,
and erases operate in bigger chunks, often about 8K.  Thus, it's not
physically possible to overwrite a 512-byte sector in place, even if
you wanted to!  So the controller is continuously picking an 8K chunk
to re-use, copying any live data to a new chunk, and erasing it so
it's available.  For highest speed, you want to pick chunks to recycle
that are mostly dead stale data, but for wear-leveling, you want to pick
chunks that have a low cycle count.  So you do a mix.)

See http://www.st.com/stonline/products/literature/ds/10058.htm and
the various pages and papers linked to it for more detailed info.
(Not necessarily the best-written or easiest to understand, but it's
straight from a ROM manufacturer.)


As for the average lifetime, typical specs are either 10K, 100K or 1
million writes per sector.  Basically, low-, normal- and high-endurance.
Low-endurance is used for program memory, where you might reflash it a
few times in the field, but aren't going to be using it continuously.
100K writes is the standard for data memory.

The denser the memory is, the lower the numbers tend to be.  But you
also have a bigger pool to spread the writes across.  Some folks use
multi-level cell memories, where instead of writing just 0 or 1, they add
1/3 and 2/3 values.  That fits twice as many bits in, but wears out faster
as it takes less degradation of the cell to read back the wrong value.

With perfect wear leveling, a 1 GB flash memory can thus have 100 TB
written to it before bad sectors start becoming a problem.  (And if you
allowed more spare sectors to start with, you would have more time.
One reason to integrate this into the file system and not emulate a
fixed-size disk.)

Assuming 10 MB/sec write speed (typical for a USB thumb drive) that
would require 10^7 seconds (115 days) of continuous full-speed writing.

So yes, a thumb drive isn't the best choice for on-line transaction
processing.  But with less than 24x7 usage, it'll last many years.


Note that, assuming a decent wear-leveling algorithm (admittedly, a big
IF for some of the cheaper stuff out there!) it doesn't matter which
sectors you write that 100 TB to.  It could be all the boot sector,
or sequential overwrites of the whole drive.
