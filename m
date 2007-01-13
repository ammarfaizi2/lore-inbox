Return-Path: <linux-kernel-owner+w=401wt.eu-S1161207AbXAMDYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbXAMDYa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbXAMDYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:24:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:46571 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161204AbXAMDY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:24:28 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20070113011208.9449.4985.sendpatchset@linux.site>
In-Reply-To: <20070113011159.9449.4327.sendpatchset@linux.site>
References: <20070113011159.9449.4327.sendpatchset@linux.site>
Subject: [patch 1/10] fs: libfs buffered write leak fix
Date: Sat, 13 Jan 2007 04:24:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simple_prepare_write and nobh_prepare_write leak uninitialised kernel data.
Fix the former, make a note of the latter. Several other filesystems seem
to be iffy here, too.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/fs/libfs.c
===================================================================
--- linux-2.6.orig/fs/libfs.c
+++ linux-2.6/fs/libfs.c
@@ -327,32 +327,35 @@ int simple_readpage(struct file *file, s
 int simple_prepare_write(struct file *file, struct page *page,
 			unsigned from, unsigned to)
 {
-	if (!PageUptodate(page)) {
-		if (to - from != PAGE_CACHE_SIZE) {
-			void *kaddr = kmap_atomic(page, KM_USER0);
-			memset(kaddr, 0, from);
-			memset(kaddr + to, 0, PAGE_CACHE_SIZE - to);
-			flush_dcache_page(page);
-			kunmap_atomic(kaddr, KM_USER0);
-		}
+	if (PageUptodate(page))
+		return 0;
+
+	if (to - from != PAGE_CACHE_SIZE) {
+		clear_highpage(page);
+		flush_dcache_page(page);
 		SetPageUptodate(page);
 	}
+
 	return 0;
 }
 
 int simple_commit_write(struct file *file, struct page *page,
-			unsigned offset, unsigned to)
+			unsigned from, unsigned to)
 {
-	struct inode *inode = page->mapping->host;
-	loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
-
-	/*
-	 * No need to use i_size_read() here, the i_size
-	 * cannot change under us because we hold the i_mutex.
-	 */
-	if (pos > inode->i_size)
-		i_size_write(inode, pos);
-	set_page_dirty(page);
+	if (to > from) {
+		struct inode *inode = page->mapping->host;
+		loff_t pos = ((loff_t)page->index << PAGE_CACHE_SHIFT) + to;
+
+		if (to - from == PAGE_CACHE_SIZE)
+			SetPageUptodate(page);
+		/*
+		 * No need to use i_size_read() here, the i_size
+		 * cannot change under us because we hold the i_mutex.
+		 */
+		if (pos > inode->i_size)
+			i_size_write(inode, pos);
+		set_page_dirty(page);
+	}
 	return 0;
 }
 
Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -2344,6 +2344,8 @@ int nobh_prepare_write(struct page *page
 
 	if (is_mapped_to_disk)
 		SetPageMappedToDisk(page);
+
+	/* XXX: information leak vs read(2) */
 	SetPageUptodate(page);
 
 	/*
