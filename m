Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSEUNLc>; Tue, 21 May 2002 09:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314525AbSEUNLK>; Tue, 21 May 2002 09:11:10 -0400
Received: from imladris.infradead.org ([194.205.184.45]:25613 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314548AbSEUNKV>; Tue, 21 May 2002 09:10:21 -0400
Date: Tue, 21 May 2002 14:10:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] buffermem_pages removal (5/5)
Message-ID: <20020521141015.E15796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No more users of buffermem_pages are left, remove it.
While at it also remove some orphaned externs around it in swap.h


--- 1.102/fs/buffer.c	Mon May 20 15:40:11 2002
+++ edited/fs/buffer.c	Tue May 21 13:55:53 2002
@@ -36,9 +36,6 @@
 
 #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
 
-/* This is used by some architectures to estimate available memory. */
-atomic_t buffermem_pages = ATOMIC_INIT(0);
-
 /*
  * Hashed waitqueue_head's for wait_on_buffer()
  */
@@ -151,10 +148,6 @@
 static inline void
 __set_page_buffers(struct page *page, struct buffer_head *head)
 {
-	struct inode *inode = page->mapping->host;
-
-	if (inode && S_ISBLK(inode->i_mode))
-		atomic_inc(&buffermem_pages);
 	if (page_has_buffers(page))
 		buffer_error();
 	set_page_buffers(page, head);
@@ -164,14 +157,6 @@
 static inline void
 __clear_page_buffers(struct page *page)
 {
-	struct address_space *mapping = page->mapping;
-
-	if (mapping) {
-		struct inode *inode = mapping->host;
-
-		if (S_ISBLK(inode->i_mode))
-			atomic_dec(&buffermem_pages);
-	}
 	clear_page_buffers(page);
 	page_cache_release(page);
 }
--- 1.43/include/linux/swap.h	Mon May 20 17:07:21 2002
+++ edited/include/linux/swap.h	Tue May 21 14:35:22 2002
@@ -102,12 +102,8 @@
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
-extern unsigned long nr_buffermem_pages(void);
 extern int nr_active_pages;
 extern int nr_inactive_pages;
-extern atomic_t nr_async_pages;
-extern atomic_t buffermem_pages;
-extern spinlock_t pagecache_lock;
 extern void __remove_inode_page(struct page *);
 
 /* Incomplete types for prototype declarations: */
--- 1.57/mm/page_alloc.c	Sun May  5 18:56:08 2002
+++ edited/mm/page_alloc.c	Tue May 21 14:27:32 2002
@@ -569,11 +569,6 @@
 }
 #endif
 
-unsigned long nr_buffermem_pages(void)
-{
-	return atomic_read(&buffermem_pages);
-}
-
 /*
  * Accumulate the page_state information across all CPUs.
  * The result is unavoidably approximate - it can change
