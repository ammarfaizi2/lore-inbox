Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319057AbSH2AOZ>; Wed, 28 Aug 2002 20:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319059AbSH2AOZ>; Wed, 28 Aug 2002 20:14:25 -0400
Received: from verein.lst.de ([212.34.181.86]:62221 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S319057AbSH2AOY>;
	Wed, 28 Aug 2002 20:14:24 -0400
Date: Thu, 29 Aug 2002 02:18:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] inline grab_cache_page
Message-ID: <20020829021841.A9792@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's nothing but a wrapper for slightly different parameters around
find_or_create pages.  Also some external code (e.g. XFS) want the
latter exported to control the gfp_mask.


--- linux-2.4.20-pre4/include/linux/pagemap.h	Tue Aug  6 11:27:18 2002
+++ linux/include/linux/pagemap.h	Sun Aug 25 19:32:11 2002
@@ -97,7 +97,15 @@ static inline void wait_on_page(struct p
 		___wait_on_page(page);
 }
 
-extern struct page * grab_cache_page (struct address_space *, unsigned long);
+/*
+ * Returns locked page at given index in given cache, creating it if needed.
+ */
+static inline struct page *grab_cache_page(struct address_space *mapping, unsigned long index)
+{
+	return find_or_create_page(mapping, index, mapping->gfp_mask);
+}
+
+
 extern struct page * grab_cache_page_nowait (struct address_space *, unsigned long);
 
 typedef int filler_t(void *, struct page*);
--- linux-2.4.20-pre4/kernel/ksyms.c	Tue Aug 13 15:56:05 2002
+++ linux/kernel/ksyms.c	Sun Aug 25 19:32:04 2002
@@ -261,7 +262,7 @@ EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
 EXPORT_SYMBOL(__find_get_page);
 EXPORT_SYMBOL(__find_lock_page);
-EXPORT_SYMBOL(grab_cache_page);
+EXPORT_SYMBOL(find_or_create_page);
 EXPORT_SYMBOL(grab_cache_page_nowait);
 EXPORT_SYMBOL(read_cache_page);
 EXPORT_SYMBOL(set_page_dirty);
--- linux-2.4.20-pre4/mm/filemap.c	Tue Aug 20 11:37:00 2002
+++ linux/mm/filemap.c	Tue Aug 20 11:39:48 2002
@@ -1029,15 +1029,6 @@ struct page * find_or_create_page(struct
 }
 
 /*
- * Returns locked page at given index in given cache, creating it if needed.
- */
-struct page *grab_cache_page(struct address_space *mapping, unsigned long index)
-{
-	return find_or_create_page(mapping, index, mapping->gfp_mask);
-}
-
-
-/*
  * Same as grab_cache_page, but do not wait if the page is unavailable.
  * This is intended for speculative data generators, where the data can
  * be regenerated if the page couldn't be grabbed.  This routine should
