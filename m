Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316780AbSFQGwj>; Mon, 17 Jun 2002 02:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316777AbSFQGwE>; Mon, 17 Jun 2002 02:52:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29710 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316778AbSFQGt0>;
	Mon, 17 Jun 2002 02:49:26 -0400
Message-ID: <3D0D8768.90C71B84@zip.com.au>
Date: Sun, 16 Jun 2002 23:53:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 16/19] clean up alloc_buffer_head()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



alloc_bufer_head() does not need the additional argument - GFP_NOFS is
always correct.



--- 2.5.22/fs/buffer.c~cleanup-alloc_buffer_head	Sun Jun 16 23:12:52 2002
+++ 2.5.22-akpm/fs/buffer.c	Sun Jun 16 23:22:44 2002
@@ -947,12 +947,12 @@ void invalidate_inode_buffers(struct ino
  * the size of each buffer.. Use the bh->b_this_page linked list to
  * follow the buffers created.  Return NULL if unable to create more
  * buffers.
- * The async flag is used to differentiate async IO (paging, swapping)
- * from ordinary buffer allocations, and only async requests are allowed
- * to sleep waiting for buffer heads. 
+ *
+ * The retry flag is used to differentiate async IO (paging, swapping)
+ * which may not fail from ordinary buffer allocations.
  */
 static struct buffer_head *
-create_buffers(struct page * page, unsigned long size, int async)
+create_buffers(struct page * page, unsigned long size, int retry)
 {
 	struct buffer_head *bh, *head;
 	long offset;
@@ -961,7 +961,7 @@ try_again:
 	head = NULL;
 	offset = PAGE_SIZE;
 	while ((offset -= size) >= 0) {
-		bh = alloc_buffer_head(async);
+		bh = alloc_buffer_head();
 		if (!bh)
 			goto no_grow;
 
@@ -998,7 +998,7 @@ no_grow:
 	 * become available.  But we don't want tasks sleeping with 
 	 * partially complete buffers, so all were released above.
 	 */
-	if (!async)
+	if (!retry)
 		return NULL;
 
 	/* We're _really_ low on memory. Now we just
@@ -2396,7 +2396,7 @@ asmlinkage long sys_bdflush(int func, lo
 static kmem_cache_t *bh_cachep;
 static mempool_t *bh_mempool;
 
-struct buffer_head *alloc_buffer_head(int async)
+struct buffer_head *alloc_buffer_head(void)
 {
 	return mempool_alloc(bh_mempool, GFP_NOFS);
 }
--- 2.5.22/fs/jbd/journal.c~cleanup-alloc_buffer_head	Sun Jun 16 23:12:52 2002
+++ 2.5.22-akpm/fs/jbd/journal.c	Sun Jun 16 23:12:52 2002
@@ -463,7 +463,7 @@ int journal_write_metadata_buffer(transa
 	 * Right, time to make up the new buffer_head.
 	 */
 	do {
-		new_bh = alloc_buffer_head(0);
+		new_bh = alloc_buffer_head();
 		if (!new_bh) {
 			printk (KERN_NOTICE "%s: ENOMEM at alloc_buffer_head, "
 				"trying again.\n", __FUNCTION__);
--- 2.5.22/include/linux/buffer_head.h~cleanup-alloc_buffer_head	Sun Jun 16 23:12:52 2002
+++ 2.5.22-akpm/include/linux/buffer_head.h	Sun Jun 16 23:22:44 2002
@@ -164,7 +164,7 @@ void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
 struct buffer_head * __bread(struct block_device *, int, int);
 void wakeup_bdflush(void);
-struct buffer_head *alloc_buffer_head(int async);
+struct buffer_head *alloc_buffer_head(void);
 void free_buffer_head(struct buffer_head * bh);
 void FASTCALL(unlock_buffer(struct buffer_head *bh));
 

-
