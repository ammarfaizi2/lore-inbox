Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbUAHEE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 23:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUAHEE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 23:04:26 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:4224
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S263618AbUAHEEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 23:04:24 -0500
Date: Wed, 7 Jan 2004 23:04:16 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Ruben Garcia <ruben@ugr.es>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] Re: loop device changes the block size and causes misaligned accesses to the real device, which can't be processed
Message-ID: <20040108040414.GA5017@fukurou.paranoiacs.org>
Mail-Followup-To: Ruben Garcia <ruben@ugr.es>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
References: <3FFC3BF4.6080105@ugr.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFC3BF4.6080105@ugr.es>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jan 2004 18:03:48 +0100, Ruben Garcia wrote:
> The loop device advertises a block size of 1024 even when configured 
> over a cdrom.
> 
> When burning a ext2 on a cd, and mounting it directly, I get:
> 
> blocksize=2048;
> 
> when I losetup /dev/loop0 /dev/cdrom, and then try to mount, I get:
> 
> blocksize=1024; and then misaligned transfer; this results in not being 
> able to read the superblock.
> 
> The loop device should be changed to export the same blocksize of the 
> underlying device

Huh, if you look at loop.c it appears to do that already (line 735) but
it doesn't. This patch makes it so.

--- linux-2.6.0/drivers/block/loop.c-orig	2004-01-07 22:47:37.755375858 -0500
+++ linux-2.6.0/drivers/block/loop.c	2004-01-07 22:48:04.990990082 -0500
@@ -732,8 +732,6 @@
 	mapping_set_gfp_mask(inode->i_mapping,
 			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 
-	set_blocksize(bdev, lo_blocksize);
-
 	lo->lo_bio = lo->lo_biotail = NULL;
 
 	/*
@@ -749,6 +747,7 @@
 	if (S_ISBLK(inode->i_mode)) {
 		request_queue_t *q = bdev_get_queue(lo_device);
 
+		blk_queue_hardsect_size(lo->lo_queue, q->hardsect_size);
 		blk_queue_max_sectors(lo->lo_queue, q->max_sectors);
 		blk_queue_max_phys_segments(lo->lo_queue,q->max_phys_segments);
 		blk_queue_max_hw_segments(lo->lo_queue, q->max_hw_segments);
@@ -757,6 +756,8 @@
 		blk_queue_merge_bvec(lo->lo_queue, q->merge_bvec_fn);
 	}
 
+	set_blocksize(bdev, lo_blocksize);
+
 	kernel_thread(loop_thread, lo, CLONE_KERNEL);
 	down(&lo->lo_sem);
 
HTH,

-- 
Ben Slusky                      | The doctors x-rayed my head
sluskyb@paranoiacs.org          | and found nothing.
sluskyb@stwing.org              |               -Dizzy Dean
PGP keyID ADA44B3B      
