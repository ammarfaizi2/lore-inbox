Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316525AbSEWM1p>; Thu, 23 May 2002 08:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316471AbSEWM1m>; Thu, 23 May 2002 08:27:42 -0400
Received: from imladris.infradead.org ([194.205.184.45]:41738 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316525AbSEWM1G>; Thu, 23 May 2002 08:27:06 -0400
Date: Thu, 23 May 2002 13:27:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (6/10)
Message-ID: <20020523132700.G24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the 7 file that need it in mm/ include buffer_head.h directly.
Once again most files shouln't need it and want fixing.


--- 1.91/mm/filemap.c	Sun May 19 13:49:50 2002
+++ edited/mm/filemap.c	Thu May 23 13:19:05 2002
@@ -20,6 +20,16 @@
 #include <linux/iobuf.h>
 #include <linux/hash.h>
 #include <linux/writeback.h>
+/*
+ * This is needed for the following functions:
+ *  - try_to_release_page
+ *  - block_flushpage
+ *  - page_has_buffers
+ *  - generic_osync_inode
+ *
+ * FIXME: remove all knowledge of the buffer layer from this file
+ */
+#include <linux/buffer_head.h>
 
 #include <asm/uaccess.h>
 #include <asm/mman.h>
--- 1.6/mm/mempool.c	Sat Apr 27 01:55:07 2002
+++ edited/mm/mempool.c	Thu May 23 13:19:05 2002
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/mempool.h>
+#include <linux/buffer_head.h>		/* for wakeup_bdflush() */
 
 static void add_element(mempool_t *pool, void *element)
 {
--- 1.17/mm/page-writeback.c	Tue May 21 19:09:28 2002
+++ edited/mm/page-writeback.c	Thu May 23 13:19:05 2002
@@ -478,7 +478,10 @@
  *
  * For now, we treat swapper_space specially.  It doesn't use the normal
  * block a_ops.
+ *
+ * FIXME: this should move over to fs/buffer.c - buffer_heads have no business in mm/
  */
+#include <linux/buffer_head.h>
 int __set_page_dirty_buffers(struct page *page)
 {
 	struct address_space * const mapping = page->mapping;
--- 1.16/mm/page_io.c	Wed May 22 03:20:04 2002
+++ edited/mm/page_io.c	Thu May 23 13:19:05 2002
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/swapctl.h>
+#include <linux/buffer_head.h>		/* for brw_page() */
 
 #include <asm/pgtable.h>
 
--- 1.24/mm/swap_state.c	Sun May 19 13:49:48 2002
+++ edited/mm/swap_state.c	Thu May 23 13:19:05 2002
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
+#include <linux/buffer_head.h>	/* for block_sync_page()/block_flushpage() */
 
 #include <asm/pgtable.h>
 
--- 1.45/mm/swapfile.c	Wed May 22 17:48:14 2002
+++ edited/mm/swapfile.c	Thu May 23 13:19:05 2002
@@ -16,7 +16,7 @@
 #include <linux/namei.h>
 #include <linux/shm.h>
 #include <linux/blkdev.h>
-#include <linux/compiler.h>
+#include <linux/buffer_head.h>		/* for block_flushpage() */
 
 #include <asm/pgtable.h>
 
--- 1.71/mm/vmscan.c	Wed May 22 01:33:38 2002
+++ edited/mm/vmscan.c	Thu May 23 13:25:52 2002
@@ -22,8 +22,8 @@
 #include <linux/highmem.h>
 #include <linux/file.h>
 #include <linux/writeback.h>
-#include <linux/compiler.h>
 #include <linux/suspend.h>
+#include <linux/buffer_head.h>		/* for try_to_release_page() */
 
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
