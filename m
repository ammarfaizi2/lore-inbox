Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbRE1AOf>; Sun, 27 May 2001 20:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbRE1AOZ>; Sun, 27 May 2001 20:14:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56848 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262887AbRE1AOK>;
	Sun, 27 May 2001 20:14:10 -0400
Date: Mon, 28 May 2001 02:14:21 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch][rfc]: highmem block support
Message-ID: <20010528021421.D9102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Given the recent talk about highmem deadlocking x86 machines, I decided
to backport my 2.5 stuff to be somewhat non-intrusive and apply to
recent 2.4 kernel. It enables x86 machines to do I/O on highmem pages,
typically this means up to 4GB.

There are two parts:

- zone-dma32-4. Add extra memory zone, to cover the range that PCI can
  DMA to safely.  So when we are not eating pages from the reserved
  highmem pool, we can alloc a highmem page as bounce instead of always
  going to low memory.

- block-highmem-1. The actual patch to enable block I/O to highmem.

It will only work on x86 right now, the other architectures that have
similar mapping restrictions need to define page_to_bus, the appropriate
zone sizing at init time (look at the x86 changes), the KM_BH_IRQ kmap
type, and the set_bh_sg bh -> scatterlist mapper. Maybe a bit more, I
forget :-)

Is it worth it? Yes! If you look at profiling numbers for even just a
1GB machine (which then has only 128MB of highmem), the bounce copying
of pages has an even higher cost than the I/O scheduler queue scan. In
fact, it scores 3rd for ticks for a single dbench run.

This 2.4 version is designed to have _minimal_ impact on existing
drivers, so if they don't explicitly enable highmem I/O it should work
just like it did before.

What works? IDE works in DMA (duh) and PIO maps highmem pages
temporarily if it needs to. Note that highmem I/O is only enabled if DMA
is enabled, and if DMA gets disabled we set normal highmem bounce
behaviour again. So the PIO mappings only happen if a DMA enabled host
falls back to PIO. The IDE low level drivers need to set hwif->highmem
to enable the functionality, and even so it's just set for ATA disks.
SCSI works too, there's a similar can_dma32 host flag that needs to be
set. I just enabled it on aic7xxx (new) and sym53c8xx, you need to add
the one-liner to other drivers if you want to test. This version is not
tested as well as the stuff it's ported from, but at least that version
passes hours of cerberus testing. So it should be stable and safe to
try.

Random comments:

- SCSI always uses scatter/gather even for single segments, it makes it
  easier to verify it's right. If we run out of mem for the sg tables,
  we do revert to a non-sg single-segment request, and highmem pages are
  mapped. Performance is down the drain in this case anyway, so it
  should be ok.

- The additions to scatterlist are a bit of a hack, however it's part of
  the 'keep the impact and changes small' solution. The current
  scatterlist is not of much use on highmem... Oh, and the highmem
  stuff should just be hidden for non-highmem compiles.

That's it for now, get the two patches from:

*.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5/

-- 
Jens Axboe

