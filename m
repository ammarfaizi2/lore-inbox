Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132435AbRA3Ttk>; Tue, 30 Jan 2001 14:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132487AbRA3Ttb>; Tue, 30 Jan 2001 14:49:31 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:65021 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132435AbRA3Tt1>; Tue, 30 Jan 2001 14:49:27 -0500
Date: Tue, 30 Jan 2001 17:48:35 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.1 find_page_nolock fixes
Message-ID: <Pine.LNX.4.21.0101301728520.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the patch below contains 3 small changes to mm/filemap.c:

1. replace the aging in __find_page_nolock() with setting
   PageReferenced(), otherwise a large number of small
   reads from (or writes to) a page can drive up the page
   age unfairly

2. remove the wakeup of kswapd from __find_page_nolock(),
   the wakeup condition is complex and leaving out the
   wakeup has no influence on any workload I tested in
   the last few weeks

3. add a __find_page_simple(), which is like __find_page_nolock()
   but only needs 2 arguments and doesn't touch the page ... this
   can be used by IO clustering and other things that really don't
   want to influence page aging, removing the 3rd argument also
   keeps things simple


More trivial and tested patches will follow RSN, time to
improve some VM stuff in 2.4.2-pre1  ;)

One more complex patch for page_launder() will also follow,
but not before I get around to testing it a bit on my boxes
here ... that patch should result in more smooth IO behaviour
because it corrects some of the thinkos that are currently
in page_launder()

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/



--- mm/filemap.c.orig	Tue Jan 30 17:02:23 2001
+++ mm/filemap.c	Tue Jan 30 17:25:29 2001
@@ -286,6 +286,34 @@
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
@@ -301,13 +329,14 @@
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
@@ -735,7 +764,6 @@
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
-	struct page **hash;
 	struct page *page;
 	unsigned long start;
 
@@ -756,8 +784,7 @@
 	 */
 	spin_lock(&pagecache_lock);
 	while (--index >= start) {
-		hash = page_hash(mapping, index);
-		page = __find_page_nolock(mapping, index, *hash);
+		page = __find_page_simple(mapping, index);
 		if (!page)
 			break;
 		deactivate_page(page);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
