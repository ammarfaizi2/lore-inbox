Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129490AbRBTSyT>; Tue, 20 Feb 2001 13:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129297AbRBTSyI>; Tue, 20 Feb 2001 13:54:08 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:38896 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129490AbRBTSxx>; Tue, 20 Feb 2001 13:53:53 -0500
Date: Tue, 20 Feb 2001 15:52:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] page_launder improvement for 2.4.1-ac19
Message-ID: <Pine.LNX.4.21.0102201547400.3674-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

the following patch makes kswapd always flush the right amount
of pages in page_launder()  (ie. the number of pages we need
to flush in order to work away the free shortage, minus the number
of swapouts already in flight).

This makes the system react better under write loads, because
user processes will have to go into try_to_free_pages() a lot
less themselves...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.1-ac19/mm/vmscan.c.orig	Tue Feb 20 15:30:44 2001
+++ linux-2.4.1-ac19/mm/vmscan.c	Tue Feb 20 15:31:24 2001
@@ -413,7 +413,7 @@
  * This code is heavily inspired by the FreeBSD source code. Thanks
  * go out to Matthew Dillon.
  *
- * XXX: restrict number of pageouts in flight...
+ * XXX: restrict number of pageouts in flight by ->writepage...
  */
 #define MAX_LAUNDER 		(1 << page_cluster)
 int page_launder(int gfp_mask, int user)
@@ -514,7 +514,10 @@
 			spin_unlock(&pagemap_lru_lock);
 
 			writepage(page);
-			flushed_pages++;
+			/* XXX: all ->writepage()s should use nr_async_pages */
+			if (!PageSwapCache(page))
+				flushed_pages++;
+			maxlaunder--;
 			page_cache_release(page);
 
 			/* And re-start the thing.. */
@@ -563,7 +566,8 @@
 			/* The buffers were not freed. */
 			if (!clearedbuf) {
 				add_page_to_inactive_dirty_list(page);
-				flushed_pages++;
+				if (wait)
+					flushed_pages++;
 
 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
@@ -636,14 +640,16 @@
 		 * with the paging load in the system and doesn't have
 		 * the IO storm problem, so it just flushes all pages
 		 * needed to fix the free shortage.
-		 *
-		 * XXX: keep track of nr_async_pages like the old swap
-		 * code did?
 		 */
-		if (user)
+		maxlaunder = shortage;
+		maxlaunder -= flushed_pages;
+		maxlaunder -= atomic_read(&nr_async_pages);
+	
+		if (maxlaunder <= 0)
+			goto out;
+
+		if (user && maxlaunder > MAX_LAUNDER)
 			maxlaunder = MAX_LAUNDER;
-		else
-			maxlaunder = shortage;
 
 		/*
 		 * If we are called by a user program, we need to free
@@ -667,6 +673,7 @@
 	/*
 	 * Return the amount of pages we freed or made freeable.
 	 */
+out:
 	return freed_pages + flushed_pages;
 }
 
--- linux-2.4.1-ac19/mm/page_io.c.orig	Tue Feb 20 15:31:51 2001
+++ linux-2.4.1-ac19/mm/page_io.c	Tue Feb 20 15:32:21 2001
@@ -69,7 +69,7 @@
 	} else {
 		return 0;
 	}
- 	if (!wait) {
+ 	if (!wait && rw == WRITE) {
  		SetPageDecrAfter(page);
  		atomic_inc(&nr_async_pages);
  	}

