Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262368AbSJJW6H>; Thu, 10 Oct 2002 18:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262337AbSJJW6H>; Thu, 10 Oct 2002 18:58:07 -0400
Received: from packet.digeo.com ([12.110.80.53]:20415 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262368AbSJJW6F>;
	Thu, 10 Oct 2002 18:58:05 -0400
Message-ID: <3DA6074E.9678657B@digeo.com>
Date: Thu, 10 Oct 2002 16:03:42 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 - kernel NULL pointer
References: <200210102254.g9AMsgH08119@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 23:03:42.0162 (UTC) FILETIME=[46F29320:01C270B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White wrote:
> 
> System is 2-CPU PIII
> Attempting to start the SAP DB. Get this msg:
> SAP cannot open the sys devspace (which is on filesystem)
> DB setup does include one raw partition.
> Further details upon request
> cliffw
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> ...
>  [<c01711a9>] generic_file_direct_IO+0x59/0x73

The raw driver was broken by the NFS direct IO merge.  It's
unbroken in Linus' current tree.   And some additional fixes
are needed on top of that.


--- 2.5.41/fs/direct-io.c~dio-bio-add-fix-1	Thu Oct 10 15:21:51 2002
+++ 2.5.41-akpm/fs/direct-io.c	Thu Oct 10 15:52:50 2002
@@ -388,7 +388,7 @@ static void dio_prep_bio(struct dio *dio
 /*
  * There is no bio.  Make one now.
  */
-static int dio_new_bio(struct dio *dio)
+static int dio_new_bio(struct dio *dio, sector_t blkno)
 {
 	sector_t sector;
 	int ret, nr_pages;
@@ -396,7 +396,7 @@ static int dio_new_bio(struct dio *dio)
 	ret = dio_bio_reap(dio);
 	if (ret)
 		goto out;
-	sector = dio->next_block_in_bio << (dio->blkbits - 9);
+	sector = blkno << (dio->blkbits - 9);
 	nr_pages = min(dio->pages_left, bio_get_nr_vecs(dio->map_bh.b_bdev));
 	BUG_ON(nr_pages <= 0);
 	ret = dio_bio_alloc(dio, dio->map_bh.b_bdev, sector, nr_pages);
@@ -408,22 +408,28 @@ out:
 
 static int
 dio_bio_add_page(struct dio *dio, struct page *page,
-		unsigned int bv_len, unsigned int bv_offset)
+		unsigned int bv_len, unsigned int bv_offset, sector_t blkno)
 {
 	int ret = 0;
 
 	if (bv_len == 0) 
 		goto out;
 
+	/* Take a ref against the page each time it is placed into a BIO */
 	page_cache_get(page);
 	if (bio_add_page(dio->bio, page, bv_len, bv_offset)) {
 		dio_bio_submit(dio);
-		ret = dio_new_bio(dio);
+		ret = dio_new_bio(dio, blkno);
 		if (ret == 0) {
 			ret = bio_add_page(dio->bio, page, bv_len, bv_offset);
 			BUG_ON(ret != 0);
+		} else {
+			/* The page didn't make it into a BIO */
+			page_cache_release(page);
 		}
 	}
+
+	/* Drop the ref which was taken in get_user_pages() */
 	page_cache_release(page);
 	dio->pages_left--;
 out:
@@ -460,6 +466,7 @@ int do_direct_IO(struct dio *dio)
 		int new_page;	/* Need to insert this page into the BIO? */
 		unsigned int bv_offset;
 		unsigned int bv_len;
+		sector_t curr_blkno;
 
 		page = dio_get_page(dio);
 		if (IS_ERR(page)) {
@@ -470,6 +477,7 @@ int do_direct_IO(struct dio *dio)
 		new_page = 1;
 		bv_offset = 0;
 		bv_len = 0;
+		curr_blkno = 0;
 		while (block_in_page < blocks_per_page) {
 			unsigned this_chunk_bytes;	/* # of bytes mapped */
 			unsigned this_chunk_blocks;	/* # of blocks */
@@ -494,7 +502,7 @@ int do_direct_IO(struct dio *dio)
 
 			dio_prep_bio(dio);
 			if (dio->bio == NULL) {
-				ret = dio_new_bio(dio);
+				ret = dio_new_bio(dio, dio->next_block_in_bio);
 				if (ret)
 					goto out;
 				new_page = 1;
@@ -503,6 +511,7 @@ int do_direct_IO(struct dio *dio)
 			if (new_page) {
 				bv_len = 0;
 				bv_offset = block_in_page << blkbits;
+				curr_blkno = dio->next_block_in_bio;
 				new_page = 0;
 			}
 
@@ -530,7 +539,7 @@ next_block:
 			if (dio->block_in_file == dio->final_block_in_request)
 				break;
 		}
-		ret = dio_bio_add_page(dio, page, bv_len, bv_offset);
+		ret = dio_bio_add_page(dio, page, bv_len, bv_offset, curr_blkno);
 		if (ret)
 			goto out;
 		block_in_page = 0;

.
