Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288932AbSAIRmR>; Wed, 9 Jan 2002 12:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288896AbSAIRmJ>; Wed, 9 Jan 2002 12:42:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:41344 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288951AbSAIRlz>; Wed, 9 Jan 2002 12:41:55 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201091741.g09HfAI17240@eng2.beaverton.ibm.com>
Subject: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, andrea@suse.de
Date: Wed, 9 Jan 2002 09:41:10 -0800 (PST)
Cc: pbadari@us.ibm.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a 2.4.17 patch for doing PAGE_SIZE IO on raw devices. Instead 
of doing 512 byte buffer heads, the patch does 4K buffer heads. This
patch significantly reduced CPU overhead and increased IO throughput
in our database benchmark runs. (CPU went from 45% busy to 6% busy).

Could you please consider this for 2.4.18 release ? If you need the
patch on 2.4.18-preX, I can make one quickly.


NOTES:

1) wait_kio() no longer uses "size" argument. But I have not removed
   the arg, to minimize the diffs.

2) I do not like adding a new routine "submit_bh_blknr()" which is
   one line change from submit_bh(). Is there a better solution ?
   I have version of the patch which sets b_rsector to 0xffffffff
   in brw_kiovec() and check for this in submit_bh(). But I don't
   really like that hack. 

Thanks,
Badari

diff -Nur -X dontdiff linux/drivers/block/ll_rw_blk.c linux-2417vary/drivers/block/ll_rw_blk.c
--- linux/drivers/block/ll_rw_blk.c	Mon Oct 29 12:11:17 2001
+++ linux-2417vary/drivers/block/ll_rw_blk.c	Wed Jan  9 15:47:05 2002
@@ -915,6 +915,38 @@
 	}
 }
 
+/*
+ * submit_bh_blknr() - same as submit_bh() except that b_rsector is
+ * set to b_blocknr. Used for RAW VARY.
+ */
+void submit_bh_blknr(int rw, struct buffer_head * bh)
+{
+	int count = bh->b_size >> 9;
+
+	if (!test_bit(BH_Lock, &bh->b_state))
+		BUG();
+
+	set_bit(BH_Req, &bh->b_state);
+
+	/*
+	 * First step, 'identity mapping' - RAID or LVM might
+	 * further remap this.
+	 */
+	bh->b_rdev = bh->b_dev;
+	bh->b_rsector = bh->b_blocknr;
+
+	generic_make_request(rw, bh);
+
+	switch (rw) {
+		case WRITE:
+			kstat.pgpgout += count;
+			break;
+		default:
+			kstat.pgpgin += count;
+			break;
+	}
+}
+
 /**
  * ll_rw_block: low-level access to block devices
  * @rw: whether to %READ or %WRITE or maybe %READA (readahead)
diff -Nur -X dontdiff linux/drivers/char/raw.c linux-2417vary/drivers/char/raw.c
--- linux/drivers/char/raw.c	Sat Sep 22 20:35:43 2001
+++ linux-2417vary/drivers/char/raw.c	Wed Jan  9 16:05:37 2002
@@ -350,8 +350,12 @@
 
 		for (i=0; i < blocks; i++) 
 			iobuf->blocks[i] = blocknr++;
+
+		iobuf->dovary = 1;
 		
 		err = brw_kiovec(rw, 1, &iobuf, dev, iobuf->blocks, sector_size);
+
+		iobuf->dovary = 0;
 
 		if (rw == READ && err > 0)
 			mark_dirty_kiobuf(iobuf, err);
diff -Nur -X dontdiff linux/fs/buffer.c linux-2417vary/fs/buffer.c
--- linux/fs/buffer.c	Wed Jan  9 15:52:19 2002
+++ linux-2417vary/fs/buffer.c	Wed Jan  9 16:28:56 2002
@@ -2071,11 +2071,11 @@
 	err = 0;
 
 	for (i = nr; --i >= 0; ) {
-		iosize += size;
 		tmp = bh[i];
 		if (buffer_locked(tmp)) {
 			wait_on_buffer(tmp);
 		}
+		iosize += tmp->b_size;
 		
 		if (!buffer_uptodate(tmp)) {
 			/* We are traversing bh'es in reverse order so
@@ -2118,6 +2118,7 @@
 	struct kiobuf *	iobuf = NULL;
 	struct page *	map;
 	struct buffer_head *tmp, **bhs = NULL;
+	int		iosize = size;
 
 	if (!nr)
 		return 0;
@@ -2154,7 +2155,7 @@
 			}
 			
 			while (length > 0) {
-				blocknr = b[bufind++];
+				blocknr = b[bufind];
 				if (blocknr == -1UL) {
 					if (rw == READ) {
 						/* there was an hole in the filesystem */
@@ -2167,9 +2168,15 @@
 					} else
 						BUG();
 				}
+				if (iobuf->dovary) {
+					iosize = PAGE_SIZE - offset;
+					if (iosize > length)
+						iosize = length;
+				}
+				bufind += (iosize/size);
 				tmp = bhs[bhind++];
 
-				tmp->b_size = size;
+				tmp->b_size = iosize;
 				set_bh_page(tmp, map, offset);
 				tmp->b_this_page = tmp;
 
@@ -2185,7 +2192,10 @@
 					set_bit(BH_Uptodate, &tmp->b_state);
 
 				atomic_inc(&iobuf->io_count);
-				submit_bh(rw, tmp);
+				if (iobuf->dovary) 
+					submit_bh_blknr(rw, tmp);
+				else 
+					submit_bh(rw, tmp);
 				/* 
 				 * Wait for IO if we have got too much 
 				 */
@@ -2200,8 +2210,8 @@
 				}
 
 			skip_block:
-				length -= size;
-				offset += size;
+				length -= iosize;
+				offset += iosize;
 
 				if (offset >= PAGE_SIZE) {
 					offset = 0;
diff -Nur -X dontdiff linux/include/linux/iobuf.h linux-2417vary/include/linux/iobuf.h
--- linux/include/linux/iobuf.h	Thu Nov 22 11:46:26 2001
+++ linux-2417vary/include/linux/iobuf.h	Wed Jan  9 16:09:08 2002
@@ -44,7 +44,8 @@
 
 	struct page **	maplist;
 
-	unsigned int	locked : 1;	/* If set, pages has been locked */
+	unsigned int	locked : 1,	/* If set, pages has been locked */
+			dovary : 1;	/* If set, do PAGE_SIZE length IO */
 	
 	/* Always embed enough struct pages for atomic IO */
 	struct page *	map_array[KIO_STATIC_PAGES];
