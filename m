Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131428AbQLUWVK>; Thu, 21 Dec 2000 17:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131458AbQLUWVA>; Thu, 21 Dec 2000 17:21:00 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:45818 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131428AbQLUWUp>; Thu, 21 Dec 2000 17:20:45 -0500
Date: Thu, 21 Dec 2000 19:49:47 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] generic_file_map drop-behind fix
Message-ID: <Pine.LNX.4.21.0012211935470.1613-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

the attached patch (against 2.4.0-test12-pre3) should fix the
problem where generic_file_write() causes a page to be moved
to the inactive list when the program is still writing to it.

Does this patch fix the web benching bottleneck in tux2 ? ;)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


--- linux-2.4.0-test12-pre3/mm/filemap.c.orig	2000/12/21 18:20:17
+++ linux/mm/filemap.c	2000/12/21 21:31:39
@@ -2436,7 +2436,7 @@
 	}
 
 	while (count) {
-		unsigned long bytes, index, offset;
+		unsigned long bytes, index, offset, partial = 0;
 		char *kaddr;
 
 		/*
@@ -2446,8 +2446,10 @@
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count)
+		if (bytes > count) {
 			bytes = count;
+			partial = 1;
+		}
 
 		status = -ENOMEM;	/* we'll assign it later anyway */
 		page = __grab_cache_page(mapping, index, &cached_page);
@@ -2478,9 +2480,17 @@
 			buf += status;
 		}
 unlock:
-		/* Mark it unlocked again and drop the page.. */
+		/*
+		 * Mark it unlocked again and release the page.
+		 * In order to prevent large (fast) file writes
+		 * from causing too much memory pressure we move
+		 * completely written pages to the inactive list.
+		 * We do, however, try to keep the pages that may
+		 * still be written to (ie. partially written pages).
+		 */
 		UnlockPage(page);
-		deactivate_page(page);
+		if (!partial)
+			deactivate_page(page);
 		page_cache_release(page);
 
 		if (status < 0)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
