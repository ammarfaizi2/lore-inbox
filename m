Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWDXGOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWDXGOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 02:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWDXGOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 02:14:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23968 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750825AbWDXGON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 02:14:13 -0400
Date: Mon, 24 Apr 2006 16:14:03 +1000
From: David Chinner <dgc@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Direct I/O bio size regression
Message-ID: <20060424061403.GF611708@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The change introduced here in 2.6.15:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=defd94b75409b983f94548ea2f52ff5787ddb848

sets the request queue max_sector size unconditionally to 1024 sectors in
blk_queue_max_sectors() even if the underlying hardware can support a larger
number of sectors.

Hence when building direct I/O bios, we have the situation where:

	- dio_new_bio() limits bio vector size artifically to
	  1024 sectors / page size because bio_get_nr_vecs()
	  is used q->max_sectors to size the new bio; and
	- dio_bio_add_page() limits the total bio size to 1024
	  sectors because bio_add_page() now uses q->max_sectors
	  to limit the size of the bio.
	  
Therefore, we can't build direct I/Os larger than 1024 sectors even
if the hardware supports large I/Os.  This is a regression as before
this mod we were able to issue direct I/Os limited by either the
maximum number of vectors in an bio or the hardware limits.

The patch below (against 2.6.16) allows direct I/O to build bios as
large as the underlying hardware will allow.

Signed-off-by: Dave Chinner <dgc@sgi.com>
---
 bio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.x-xfs-new/fs/bio.c
===================================================================
--- 2.6.x-xfs-new.orig/fs/bio.c	2006-02-06 11:57:50.000000000 +1100
+++ 2.6.x-xfs-new/fs/bio.c	2006-04-24 15:46:16.849484424 +1000
@@ -304,7 +304,7 @@ int bio_get_nr_vecs(struct block_device 
 	request_queue_t *q = bdev_get_queue(bdev);
 	int nr_pages;
 
-	nr_pages = ((q->max_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	nr_pages = ((q->max_hw_sectors << 9) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	if (nr_pages > q->max_phys_segments)
 		nr_pages = q->max_phys_segments;
 	if (nr_pages > q->max_hw_segments)
@@ -446,7 +446,7 @@ int bio_add_page(struct bio *bio, struct
 		 unsigned int offset)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-	return __bio_add_page(q, bio, page, len, offset, q->max_sectors);
+	return __bio_add_page(q, bio, page, len, offset, q->max_hw_sectors);
 }
 
 struct bio_map_data {
