Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266884AbRGFWc5>; Fri, 6 Jul 2001 18:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266882AbRGFWcr>; Fri, 6 Jul 2001 18:32:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14863 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266879AbRGFWc3>; Fri, 6 Jul 2001 18:32:29 -0400
Date: Fri, 6 Jul 2001 19:32:22 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hugh@veritas.com>
Subject: [PATCH #2] OOM kill trigger
Message-ID: <Pine.LNX.4.33L.0107061930390.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As Hugh pointed out, the info on how many pages we have in the
swap cache is (of course) present in the swapper_space structure.

Patch has been shrunk accordingly...

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.6/mm/oom_kill.c.orig	Fri Jul  6 17:32:58 2001
+++ linux-2.4.6/mm/oom_kill.c	Fri Jul  6 19:19:25 2001
@@ -191,11 +191,28 @@
  */
 int out_of_memory(void)
 {
+	long cache_mem, limit;
+
 	/* Enough free memory?  Not OOM. */
 	if (nr_free_pages() > freepages.min)
 		return 0;

 	if (nr_free_pages() + nr_inactive_clean_pages() > freepages.low)
+		return 0;
+
+	/*
+	 * If the buffer and page cache (excluding swap cache) are over
+	 * their (/proc tunable) minimum, we're still not OOM.  We test
+	 * this to make sure we don't return OOM when the system simply
+	 * has a hard time with the cache.
+	 */
+	cache_mem = atomic_read(&page_cache_size);
+	cache_mem += atomic_read(&buffermem_pages);
+	cache_mem -= swapper_space.nrpages;
+	limit = (page_cache.min_percent + buffer_mem.min_percent);
+	limit *= num_physpages / 100;
+
+	if (cache_mem > limit)
 		return 0;

 	/* Enough swap space left?  Not OOM. */

