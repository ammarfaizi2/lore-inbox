Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbRBJWy0>; Sat, 10 Feb 2001 17:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBJWyQ>; Sat, 10 Feb 2001 17:54:16 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:6639 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129595AbRBJWyI>; Sat, 10 Feb 2001 17:54:08 -0500
Date: Sat, 10 Feb 2001 20:53:59 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.0-ac8/9  page_launder() fix
Message-ID: <Pine.LNX.4.21.0102102051450.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the patch below should make page_launder() more well-behaved
than it is in -ac8 and -ac9 ... note, however, that this thing
is still completely untested and only in theory makes page_launder
behave better ;)

Since there seems to be a lot of VM testing going on at the
moment I thought I might as well send it out now so I can get
some feedback before I get into the airplane towards sweden
tomorrow...

cheers,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.1-ac8/mm/vmscan.c.orig	Fri Feb  9 15:04:16 2001
+++ linux-2.4.1-ac8/mm/vmscan.c	Sat Feb 10 20:50:40 2001
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
@@ -636,14 +639,16 @@
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
@@ -667,6 +672,7 @@
 	/*
 	 * Return the amount of pages we freed or made freeable.
 	 */
+out:
 	return freed_pages + flushed_pages;
 }
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
