Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317360AbSFGWMe>; Fri, 7 Jun 2002 18:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317362AbSFGWMd>; Fri, 7 Jun 2002 18:12:33 -0400
Received: from h-64-105-137-63.SNVACAID.covad.net ([64.105.137.63]:17041 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317360AbSFGWMb>; Fri, 7 Jun 2002 18:12:31 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 7 Jun 2002 15:12:26 -0700
Message-Id: <200206072212.PAA06870@adam.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's bigger than queue could handle
Cc: axboe@suse.de, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>+int bio_max_iovecs(request_queue_t *q, int *iovec_size)
>+{
>+       unsigned max_iovecs = min(q->max_phys_segments, q->max_hw_segments);

>It seems that this test will significantly reduce the max BIO
>size for some devices.  What's the thinking here?

	When you submit a bio with n iovecs, there is no guarantee
that any of those will have contiguous underlying physical addresses
or or that any of those addresses that can be made contiguous from the
view of a DMA device (most architectures lack an iommu anyhow, and
there is no guarantee that there would be enough entries available in
the iommu to do this, and I vaguely recal that existing iommu's have a
small number of entries, like 8 or 16).  This is true even when each
of the iovecs covers exactly one full page.

	Since there is no guarantee that any of these bios can be
merged in the general case, bio submitters have to ensure that
the number of IO vectors in each bio does not exeed q->max_phys_segments
*and* does not exceed q->max_hw_segments.  Otherwise, the request that
finally gets to the device driver may exceed the drivers capabilities.

	Of course, in cases where the bios happen to point to
physically contiguous memory, the request merging code will notice and
remerge the bios.  Since the bios generated from a big mpage or
ll_rw_kio call are already going to be pretty big, the overhead of the
bio merging code will be very small in proportion to the amount of
data being transferred.

	By the way, if you know something more about the block of
memory that you are writing, then you may be able to build bigger
bios.  For example, if you are writing a single contiguous range, then
you might be able to build bigger bios (limited by
q->max_segment_size, something that I should make bio_max_iovecs also
consider).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
