Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314502AbSEUNLB>; Tue, 21 May 2002 09:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSEUNK7>; Tue, 21 May 2002 09:10:59 -0400
Received: from imladris.infradead.org ([194.205.184.45]:24589 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314502AbSEUNKG>; Tue, 21 May 2002 09:10:06 -0400
Date: Tue, 21 May 2002 14:10:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] buffermem_pages removal (3/5)
Message-ID: <20020521141003.C15796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is a bit more controveral as it may break stupid userlevel
programs:  remove the 'Buffers' field from /proc/meminfo and make
the Cached field show the full pagecache size instead of subtracting
the block-device backed pages.

All /proc/meminfo-using programs I have (free, top) still work fine.


--- 1.24/fs/proc/proc_misc.c	Fri May  3 07:01:31 2002
+++ edited/fs/proc/proc_misc.c	Tue May 21 14:28:39 2002
@@ -130,7 +130,6 @@
 {
 	struct sysinfo i;
 	int len;
-	int pg_size ;
 	struct page_state ps;
 
 	get_page_state(&ps);
@@ -140,7 +139,6 @@
 #define K(x) ((x) << (PAGE_SHIFT - 10))
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	pg_size = get_page_cache_size() - i.bufferram ;
 
 	/*
 	 * Tagged format, for easy grepping and expansion.
@@ -149,7 +147,6 @@
 		"MemTotal:     %8lu kB\n"
 		"MemFree:      %8lu kB\n"
 		"MemShared:    %8lu kB\n"
-		"Buffers:      %8lu kB\n"
 		"Cached:       %8lu kB\n"
 		"SwapCached:   %8lu kB\n"
 		"Active:       %8u kB\n"
@@ -165,8 +162,7 @@
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
-		K(i.bufferram),
-		K(pg_size - swapper_space.nrpages),
+		K(ps.nr_pagecache-swapper_space.nrpages),
 		K(swapper_space.nrpages),
 		K(nr_active_pages),
 		K(nr_inactive_pages),
