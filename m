Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVDAURi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVDAURi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVDAUPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:15:51 -0500
Received: from waste.org ([216.27.176.166]:8849 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262869AbVDAUGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:06:40 -0500
Date: Fri, 1 Apr 2005 12:06:37 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove all kernel bugs
Message-ID: <20050401200637.GF15453@waste.org>
References: <20050401090744.GD15453@waste.org> <20050401013454.1205a3f5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401013454.1205a3f5.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 01:34:54AM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > I've been sitting on this patch for a while, figured it's high time I
> >  shared it with the world. This patch eliminates all kernel bugs, trims
> >  about 35k off the typical kernel, and makes the system slightly
> >  faster. The patch is against the latest bk snapshot, please apply.
> 
> ho-hum, more ifdefs.
> 
> How's about you nuke PAGE_BUG first?  Just replace it with BUG() everywhere.
> 
> Or do it as a later patch - doesn't matter much I guess.

With pleasure.

Exterminate PAGE_BUG.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: af/include/asm-sh64/bug.h
===================================================================
--- af.orig/include/asm-sh64/bug.h	2005-04-01 11:17:38.000000000 -0800
+++ af/include/asm-sh64/bug.h	2005-04-01 11:17:40.000000000 -0800
@@ -17,10 +17,6 @@
 		BUG(); \
 } while(0)
 
-#define PAGE_BUG(page) do { \
-	BUG(); \
-} while (0)
-
 #define WARN_ON(condition) do { \
 	if (unlikely((condition)!=0)) { \
 		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); \
Index: af/fs/buffer.c
===================================================================
--- af.orig/fs/buffer.c	2005-04-01 11:17:38.000000000 -0800
+++ af/fs/buffer.c	2005-04-01 11:17:40.000000000 -0800
@@ -2078,8 +2078,7 @@ int block_read_full_page(struct page *pa
 	int nr, i;
 	int fully_mapped = 1;
 
-	if (!PageLocked(page))
-		PAGE_BUG(page);
+	BUG_ON(!PageLocked(page));
 	blocksize = 1 << inode->i_blkbits;
 	if (!page_has_buffers(page))
 		create_empty_buffers(page, blocksize, 0);
Index: af/fs/afs/file.c
===================================================================
--- af.orig/fs/afs/file.c	2005-04-01 11:17:38.000000000 -0800
+++ af/fs/afs/file.c	2005-04-01 11:17:40.000000000 -0800
@@ -131,8 +131,7 @@ static int afs_file_readpage(struct file
 
 	vnode = AFS_FS_I(inode);
 
-	if (!PageLocked(page))
-		PAGE_BUG(page);
+	BUG_ON(!PageLocked(page));
 
 	ret = -ESTALE;
 	if (vnode->flags & AFS_VNODE_DELETED)
Index: af/include/asm-generic/bug.h
===================================================================
--- af.orig/include/asm-generic/bug.h	2005-04-01 11:17:38.000000000 -0800
+++ af/include/asm-generic/bug.h	2005-04-01 11:17:40.000000000 -0800
@@ -12,13 +12,6 @@
 } while (0)
 #endif
 
-#ifndef HAVE_ARCH_PAGE_BUG
-#define PAGE_BUG(page) do { \
-	printk("page BUG for page at %p\n", page); \
-	BUG(); \
-} while (0)
-#endif
-
 #ifndef HAVE_ARCH_BUG_ON
 #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
 #endif
@@ -37,10 +30,6 @@
 #define BUG()
 #endif
 
-#ifndef HAVE_ARCH_PAGE_BUG
-#define PAGE_BUG(page) do { if (page) ; } while (0)
-#endif
-
 #ifndef HAVE_ARCH_BUG_ON
 #define BUG_ON(condition) do { if (condition) ; } while(0)
 #endif
Index: af/fs/jffs2/file.c
===================================================================
--- af.orig/fs/jffs2/file.c	2005-04-01 11:17:38.000000000 -0800
+++ af/fs/jffs2/file.c	2005-04-01 11:17:40.000000000 -0800
@@ -79,8 +79,7 @@ static int jffs2_do_readpage_nolock (str
 
 	D2(printk(KERN_DEBUG "jffs2_do_readpage_nolock(): ino #%lu, page at offset 0x%lx\n", inode->i_ino, pg->index << PAGE_CACHE_SHIFT));
 
-	if (!PageLocked(pg))
-                PAGE_BUG(pg);
+	BUG_ON(!PageLocked(pg));
 
 	pg_buf = kmap(pg);
 	/* FIXME: Can kmap fail? */
Index: af/include/asm-cris/page.h
===================================================================
--- af.orig/include/asm-cris/page.h	2005-04-01 11:17:38.000000000 -0800
+++ af/include/asm-cris/page.h	2005-04-01 11:17:40.000000000 -0800
@@ -77,10 +77,6 @@ typedef struct { unsigned long pgprot; }
   printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
 } while (0)
 
-#define PAGE_BUG(page) do { \
-         BUG(); \
-} while (0)
-
 /* Pure 2^n version of get_order */
 static inline int get_order(unsigned long size)
 {
Index: af/fs/udf/file.c
===================================================================
--- af.orig/fs/udf/file.c	2005-04-01 11:17:38.000000000 -0800
+++ af/fs/udf/file.c	2005-04-01 11:17:40.000000000 -0800
@@ -49,8 +49,7 @@ static int udf_adinicb_readpage(struct f
 	struct inode *inode = page->mapping->host;
 	char *kaddr;
 
-	if (!PageLocked(page))
-		PAGE_BUG(page);
+	BUG_ON(!PageLocked(page));
 
 	kaddr = kmap(page);
 	memset(kaddr, 0, PAGE_CACHE_SIZE);
@@ -67,8 +66,7 @@ static int udf_adinicb_writepage(struct 
 	struct inode *inode = page->mapping->host;
 	char *kaddr;
 
-	if (!PageLocked(page))
-		PAGE_BUG(page);
+	BUG_ON(!PageLocked(page));
 
 	kaddr = kmap(page);
 	memcpy(UDF_I_DATA(inode) + UDF_I_LENEATTR(inode), kaddr, inode->i_size);
Index: af/fs/udf/inode.c
===================================================================
--- af.orig/fs/udf/inode.c	2005-04-01 11:17:38.000000000 -0800
+++ af/fs/udf/inode.c	2005-04-01 11:17:40.000000000 -0800
@@ -167,8 +167,8 @@ void udf_expand_file_adinicb(struct inod
 	}
 
 	page = grab_cache_page(inode->i_mapping, 0);
-	if (!PageLocked(page))
-		PAGE_BUG(page);
+	BUG_ON(!PageLocked(page));
+
 	if (!PageUptodate(page))
 	{
 		kaddr = kmap(page);
Index: af/arch/arm26/mm/small_page.c
===================================================================
--- af.orig/arch/arm26/mm/small_page.c	2005-04-01 11:17:38.000000000 -0800
+++ af/arch/arm26/mm/small_page.c	2005-04-01 11:17:40.000000000 -0800
@@ -92,8 +92,7 @@ static unsigned long __get_small_page(in
 		page = list_entry(order->queue.next, struct page, lru);
 again:
 #ifdef PEDANTIC
-		if (USED_MAP(page) & ~order->all_used)
-			PAGE_BUG(page);
+		BUG_ON(USED_MAP(page) & ~order->all_used);
 #endif
 		offset = ffz(USED_MAP(page));
 		SET_USED(page, offset);
@@ -141,8 +140,7 @@ static void __free_small_page(unsigned l
 			goto non_small;
 
 #ifdef PEDANTIC
-		if (USED_MAP(page) & ~order->all_used)
-			PAGE_BUG(page);
+		BUG_ON(USED_MAP(page) & ~order->all_used);
 #endif
 
 		spage = spage >> order->shift;
Index: af/mm/filemap.c
===================================================================
--- af.orig/mm/filemap.c	2005-04-01 11:17:38.000000000 -0800
+++ af/mm/filemap.c	2005-04-01 11:17:40.000000000 -0800
@@ -123,8 +123,7 @@ void remove_from_page_cache(struct page 
 {
 	struct address_space *mapping = page->mapping;
 
-	if (unlikely(!PageLocked(page)))
-		PAGE_BUG(page);
+	BUG_ON(!PageLocked(page));
 
 	write_lock_irq(&mapping->tree_lock);
 	__remove_from_page_cache(page);


-- 
Mathematics is the supreme nostalgia of our time.
