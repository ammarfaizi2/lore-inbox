Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132266AbRACP3n>; Wed, 3 Jan 2001 10:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132320AbRACP3d>; Wed, 3 Jan 2001 10:29:33 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:50158 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132266AbRACP3S>; Wed, 3 Jan 2001 10:29:18 -0500
Date: Wed, 3 Jan 2001 12:57:55 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] drop-behind fix for generic_file_write
Message-ID: <Pine.LNX.4.21.0101031256040.1403-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Alan,

the following (trivial) patch fixes drop-behind behaviour
in generic_file_write to only drop fully written pages.

This increases performance in dbench by about 8% (as
measured by Daniel Phillips) and should get rid of the
logfile bottleneck Ingo Molnar found with the drop-behind
call in generic_file_write in TUX tests.

Please apply this (trivial) patch for 2.4.0.

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/



--- linux-2.4.0-prerelease/mm/filemap.c.orig	Wed Jan  3 12:52:13 2001
+++ linux-2.4.0-prerelease/mm/filemap.c	Wed Jan  3 12:54:05 2001
@@ -2496,7 +2496,7 @@
 	}
 
 	while (count) {
-		unsigned long bytes, index, offset;
+		unsigned long bytes, index, offset, partial = 0;
 		char *kaddr;
 
 		/*
@@ -2506,8 +2506,10 @@
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count)
+		if (bytes > count) {
 			bytes = count;
+			partial = 1;
+		}
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2549,9 +2551,17 @@
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
