Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316587AbSFFBCw>; Wed, 5 Jun 2002 21:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSFFBCv>; Wed, 5 Jun 2002 21:02:51 -0400
Received: from h-64-105-34-84.SNVACAID.covad.net ([64.105.34.84]:36552 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316587AbSFFBCu>; Wed, 5 Jun 2002 21:02:50 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 5 Jun 2002 18:02:43 -0700
Message-Id: <200206060102.SAA00659@adam.yggdrasil.com>
To: akpm@zip.com.au
Subject: Re: Patch: linux-2.5.20/fs/bio.c - ll_rw_kio made incorrect assumptions about queue handler's capabilities
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:
>What particular problem are you trying to solve here?

	In 2.5.20, ll_rw_kio could submit bio's that are too
big for the underlying queue to handle (they might have more
sectors than q->max_sectors, more iovec's than q->max_phys_segments
or q->max_hw_segments).

	As a hypothetical example, suppose that ll_rw_kio is
called to copy 148kB of data (37 4kB pages on x86) to a Compaq
Smart2 raid controller.  Assume also that the pages are not
contiguous in physical memory and there is no iommu to make them
look contiguous to a DMA device, so there will be no merging.

	In this example, ll_rw_kio in linux-2.5.20 would handle this
call by building a single bio with 37 iovec's and pass it in a single
call to submit_bio.  Nothing in the request merging code in
drivers/block/ll_rw_blk.c will break up this bio.  blk_recount_segments
will fill in bio->bi_phys_segments and bio->bi_hw_segments as 37
(because there is no merging to make it any smaller).
blk_recalc_rq_segments will then set rq->nr_phys_segments to 37
(the request will contain only this one bio, becasue bio->bi_phys_segments
already excceds q->max_phys_segments).

	Eventually, do_cciss_request (in drivers/block/cciss.c) will
extract the request containing the bio with bio->bi_phys_segments == 37.
request and generate a kernel panic because the number of segements
exceeds 32.  In the case of linux-2.5.20/drivers/block/cciss.c, this
happens around line 1799:

        creq = elv_next_request(q);
        if (creq->nr_phys_segments > MAXSGENTRIES)
                BUG();


Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
