Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129306AbRB1W6p>; Wed, 28 Feb 2001 17:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129309AbRB1W6g>; Wed, 28 Feb 2001 17:58:36 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:23600 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129306AbRB1W63>; Wed, 28 Feb 2001 17:58:29 -0500
Message-ID: <3A9D8252.BC805DE7@sgi.com>
Date: Wed, 28 Feb 2001 14:57:22 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.1 find_page_nolock fixes
Content-Type: multipart/mixed;
 boundary="------------3077F71220920572221EAA33"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3077F71220920572221EAA33
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Rik van Riel wrote:

> 
> 3. add a __find_page_simple(), which is like __find_page_nolock()
>    but only needs 2 arguments and doesn't touch the page ... this
>    can be used by IO clustering and other things that really don't
>    want to influence page aging, removing the 3rd argument also
>    keeps things simple
> 

We've used an exported version of __find_page_simple in XFS to good effect.
Following is a patch against 2.4.2 which is an extension of Rik's patch
to export find_get_page_simple(). Alan, if you want a patch against
the ac series please let me know.

thanks,

ananth.
--------------3077F71220920572221EAA33
Content-Type: text/plain; charset=us-ascii;
 name="page-simple.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="page-simple.patch"

diff -Naur ../../linux-2.4.2/linux/include/linux/pagemap.h ./include/linux/pagemap.h
--- ../../linux-2.4.2/linux/include/linux/pagemap.h	Wed Feb 21 16:10:01 2001
+++ ./include/linux/pagemap.h	Wed Feb 28 14:10:48 2001
@@ -71,6 +71,8 @@
 				     unsigned long offset, struct page **hash);
 extern struct page * __find_lock_page (struct address_space * mapping,
 				unsigned long index, struct page **hash);
+extern struct page * find_get_page_simple (struct address_space * mapping,
+				unsigned long index);
 extern void lock_page(struct page *page);
 #define find_lock_page(mapping, index) \
 		__find_lock_page(mapping, index, page_hash(mapping, index))
diff -Naur ../../linux-2.4.2/linux/kernel/ksyms.c ./kernel/ksyms.c
--- ../../linux-2.4.2/linux/kernel/ksyms.c	Fri Feb  9 11:29:44 2001
+++ ./kernel/ksyms.c	Wed Feb 28 14:09:51 2001
@@ -241,6 +241,7 @@
 EXPORT_SYMBOL(poll_freewait);
 EXPORT_SYMBOL(ROOT_DEV);
 EXPORT_SYMBOL(__find_lock_page);
+EXPORT_SYMBOL(find_get_page_simple);
 EXPORT_SYMBOL(grab_cache_page);
 EXPORT_SYMBOL(read_cache_page);
 EXPORT_SYMBOL(vfs_readlink);
diff -Naur ../../linux-2.4.2/linux/mm/filemap.c ./mm/filemap.c
--- ../../linux-2.4.2/linux/mm/filemap.c	Fri Feb 16 16:06:17 2001
+++ ./mm/filemap.c	Wed Feb 28 14:22:09 2001
@@ -285,6 +285,34 @@
 	spin_unlock(&pagecache_lock);
 }
 
+/*
+ * This function is pretty much like __find_page_nolock(), but it only
+ * requires 2 arguments and doesn't mark the page as touched, making it
+ * ideal for ->writepage() clustering and other places where you don't
+ * want to mark the page referenced.
+ *
+ * The caller needs to hold the pagecache_lock.
+ */
+struct page * __find_page_simple(struct address_space *mapping, unsigned long index)
+{
+	struct page * page = *page_hash(mapping, index);
+	goto inside;
+
+	for (;;) {
+		page = page->next_hash;
+inside:
+		if (!page)
+			goto not_found;
+		if (page->mapping != mapping)
+			continue;
+		if (page->index == index)
+			break;
+	}
+
+not_found:
+	return page;
+}
+
 static inline struct page * __find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
 {
 	goto inside;
@@ -300,13 +328,14 @@
 			break;
 	}
 	/*
-	 * Touching the page may move it to the active list.
-	 * If we end up with too few inactive pages, we wake
-	 * up kswapd.
+	 * Mark the page referenced, moving inactive pages to the
+	 * active list.
 	 */
-	age_page_up(page);
-	if (inactive_shortage() > inactive_target / 2 && free_shortage())
-			wakeup_kswapd();
+	if (!PageActive(page))
+		activate_page(page);
+	else
+		SetPageReferenced(page);
+
 not_found:
 	return page;
 }
@@ -679,6 +708,22 @@
 }
 
 /*
+ * Similar to find_get_page but with no VM side-effects such as aging.
+ */
+struct page * find_get_page_simple(struct address_space *mapping,
+			      unsigned long index)
+{
+	struct page *page;
+
+	spin_lock(&pagecache_lock);
+	page = __find_page_simple(mapping, index);
+	if (page)
+		page_cache_get(page);
+	spin_unlock(&pagecache_lock);
+	return page;
+}
+
+/*
  * Get the lock to a page atomically.
  */
 struct page * __find_lock_page (struct address_space *mapping,
@@ -734,7 +779,6 @@
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
-	struct page **hash;
 	struct page *page;
 	unsigned long start;
 
@@ -755,8 +799,7 @@
 	 */
 	spin_lock(&pagecache_lock);
 	while (--index >= start) {
-		hash = page_hash(mapping, index);
-		page = __find_page_nolock(mapping, index, *hash);
+		page = __find_page_simple(mapping, index);
 		if (!page)
 			break;
 		deactivate_page(page);

--------------3077F71220920572221EAA33--

