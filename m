Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263184AbREWRpY>; Wed, 23 May 2001 13:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263185AbREWRpO>; Wed, 23 May 2001 13:45:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15876 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263184AbREWRo5>; Wed, 23 May 2001 13:44:57 -0400
Date: Wed, 23 May 2001 14:44:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Stephen C. Tweedie" <sct@redhat.com>,
        <arjanv@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] inode & dentry cache balancing
Message-ID: <Pine.LNX.4.33.0105231433420.311-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch simplifies the if-else conditions in
do_try_to_free_pages() to the extent where it actually
balances the normal pages against the inode & dentry caches
again.

Note that the strange if-else around kmem_cache_reap() isn't
needed either, since page_launder() will, in the first loop,
free the buffer heads that are needed for the second loop and
for shrink_{icache,dcache}_memory() ... and if it doesn't we
still have enough IO outstanding to keep the IO subsystem busy
so it shouldn't matter either.

Please apply for the next -pre or -ac kernel...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.5-pre3/mm/vmscan.c.orig	Wed May 23 14:09:23 2001
+++ linux-2.4.5-pre3/mm/vmscan.c	Wed May 23 14:19:32 2001
@@ -865,14 +865,18 @@

 	/*
 	 * If we're low on free pages, move pages from the
-	 * inactive_dirty list to the inactive_clean list.
+	 * inactive_dirty list to the inactive_clean list
+	 * and shrink the inode and dentry caches.
 	 *
 	 * Usually bdflush will have pre-cleaned the pages
 	 * before we get around to moving them to the other
 	 * list, so this is a relatively cheap operation.
 	 */
-	if (free_shortage())
+	if (free_shortage()) {
 		ret += page_launder(gfp_mask, user);
+		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
+		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
+	}

 	/*
 	 * If needed, we move pages from the active list
@@ -882,21 +886,10 @@
 		ret += refill_inactive(gfp_mask, user);

 	/*
-	 * Delete pages from the inode and dentry caches and
-	 * reclaim unused slab cache if memory is low.
+	 * If we're still short on free pages, reclaim unused
+	 * slab cache memory.
 	 */
 	if (free_shortage()) {
-		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
-		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
-	} else {
-		/*
-		 * Illogical, but true. At least for now.
-		 *
-		 * If we're _not_ under shortage any more, we
-		 * reap the caches. Why? Because a noticeable
-		 * part of the caches are the buffer-heads,
-		 * which we'll want to keep if under shortage.
-		 */
 		kmem_cache_reap(gfp_mask);
 	}


