Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbREPBeF>; Tue, 15 May 2001 21:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbREPBdz>; Tue, 15 May 2001 21:33:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29445 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261758AbREPBdk>;
	Tue, 15 May 2001 21:33:40 -0400
Date: Tue, 15 May 2001 22:33:22 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.5-pre2 mm/filemap.c
Message-ID: <Pine.LNX.4.21.0105152231410.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here are a filemap.c fix and a slight addition, with the first
fix changed as discussed by email.
 
1) __find_page_nolock should only set the referenced bit
   on an active page, otherwise a number of subsequent
   reads from the same page within one page scan interval
   can SEVERELY mess up page aging to the disadvantage of
   the other pages in the system ...
   just setting the referenced bit on the page makes the
   aging a lot fairer
 
2) in drop_behind() we first increase the page age and
   will then proceed to deactivate the page again; better
   have a simpler help function for this ... note that this
   help function could also be used for eg. ->writepage()
   write clustering code

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)



--- linux-2.4.5-pre2/mm/filemap.c.orig	Tue May 15 22:00:15 2001
+++ linux-2.4.5-pre2/mm/filemap.c	Tue May 15 22:08:04 2001
@@ -284,6 +284,34 @@
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
@@ -298,14 +326,9 @@
 		if (page->index == offset)
 			break;
 	}
-	/*
-	 * Touching the page may move it to the active list.
-	 * If we end up with too few inactive pages, we wake
-	 * up kswapd.
-	 */
-	age_page_up(page);
-	if (inactive_shortage() > inactive_target / 2 && free_shortage())
-			wakeup_kswapd();
+	/* Mark the page referenced, kswapd will find it later. */
+	SetPageReferenced(page);
+
 not_found:
 	return page;
 }
@@ -762,7 +785,6 @@
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
-	struct page **hash;
 	struct page *page;
 	unsigned long start;
 
@@ -783,8 +805,7 @@
 	 */
 	spin_lock(&pagecache_lock);
 	while (--index >= start) {
-		hash = page_hash(mapping, index);
-		page = __find_page_nolock(mapping, index, *hash);
+		page = __find_page_simple(mapping, index);
 		if (!page)
 			break;
 		deactivate_page(page);

