Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSHBMnD>; Fri, 2 Aug 2002 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSHBMnD>; Fri, 2 Aug 2002 08:43:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59364 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313711AbSHBMm7>; Fri, 2 Aug 2002 08:42:59 -0400
Date: Fri, 2 Aug 2002 18:16:28 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@kernel.org
Subject: Re: [PATCH] Bio Traversal Changes (Patch 2/4: biotr8-blkusers.diff)
Message-ID: <20020802181628.B1859@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20020802180513.A1802@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020802180513.A1802@in.ibm.com>; from suparna@in.ibm.com on Fri, Aug 02, 2002 at 06:05:13PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corresponding modifications needed in code above block layer
to account for bio traversal changes, mainly ensuring correct 
bi_voffset initialization when setting up bios.


diff -ur linux-2.5.30-pure/fs/direct-io.c linux-2.5.30-bio/fs/direct-io.c
--- linux-2.5.30-pure/fs/direct-io.c	Fri Aug  2 10:08:29 2002
+++ linux-2.5.30-bio/fs/direct-io.c	Fri Aug  2 10:42:13 2002
@@ -193,6 +193,9 @@
 
 	bio->bi_vcnt = bio->bi_idx;
 	bio->bi_idx = 0;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 	bio->bi_private = dio;
 	atomic_inc(&dio->bio_count);
 	submit_bio(dio->rw, bio);
diff -ur linux-2.5.30-pure/fs/jfs/jfs_logmgr.c linux-2.5.30-bio/fs/jfs/jfs_logmgr.c
--- linux-2.5.30-pure/fs/jfs/jfs_logmgr.c	Sat Jul 27 08:28:38 2002
+++ linux-2.5.30-bio/fs/jfs/jfs_logmgr.c	Fri Aug  2 10:42:13 2002
@@ -1817,6 +1817,9 @@
 	bio->bi_vcnt = 1;
 	bio->bi_idx = 0;
 	bio->bi_size = LOGPSIZE;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
@@ -1959,6 +1962,9 @@
 	bio->bi_vcnt = 1;
 	bio->bi_idx = 0;
 	bio->bi_size = LOGPSIZE;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
diff -ur linux-2.5.30-pure/fs/mpage.c linux-2.5.30-bio/fs/mpage.c
--- linux-2.5.30-pure/fs/mpage.c	Sat Jul 27 08:28:32 2002
+++ linux-2.5.30-bio/fs/mpage.c	Fri Aug  2 10:42:13 2002
@@ -82,6 +82,9 @@
 {
 	bio->bi_vcnt = bio->bi_idx;
 	bio->bi_idx = 0;
+	bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+	bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 	bio->bi_end_io = mpage_end_io_read;
 	if (rw == WRITE)
 		bio->bi_end_io = mpage_end_io_write;
diff -ur linux-2.5.30-pure/mm/page_io.c linux-2.5.30-bio/mm/page_io.c
--- linux-2.5.30-pure/mm/page_io.c	Fri Aug  2 10:08:31 2002
+++ linux-2.5.30-bio/mm/page_io.c	Fri Aug  2 10:42:13 2002
@@ -42,6 +42,9 @@
 		bio->bi_vcnt = 1;
 		bio->bi_idx = 0;
 		bio->bi_size = PAGE_SIZE;
+		bio->bi_voffset = __BVEC_START(bio)->bv_offset;
+		bio->bi_endvoffset = __BVEC_END(bio)->bv_offset +
+		__BVEC_END(bio)->bv_len;
 		bio->bi_end_io = end_io;
 	}
 	return bio;
