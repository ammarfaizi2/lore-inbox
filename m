Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276612AbRJKRk1>; Thu, 11 Oct 2001 13:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276622AbRJKRkR>; Thu, 11 Oct 2001 13:40:17 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:47781
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S276612AbRJKRkI>; Thu, 11 Oct 2001 13:40:08 -0400
Date: Thu, 11 Oct 2001 13:40:28 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com
Subject: [PATCH] buffermem counter tweaks in proc
Message-ID: <1358720000.1002822028@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello everyone,

A few people have seen free report bogus numbers for the number of used
buffers in the output of free.

Andrea pointed out this was probably because we now increment 
both buffermem_pages and page_cache_size when getblk triggers 
a page allocation.

This patch tweaks /proc/meminfo to deal take that into account:

-chris

--- l-2.4.12/fs/proc/proc_misc.c Sun, 23 Sep 2001 20:11:16 -0400 
+++ l-2.4.12/fs/proc/proc_misc.c Wed, 10 Oct 2001 13:12:26 -0400 
@@ -140,6 +140,7 @@
 {
 	struct sysinfo i;
 	int len;
+	int pg_size ;
 
 /*
  * display in kilobytes.
@@ -148,12 +149,14 @@
 #define B(x) ((unsigned long long)(x) << PAGE_SHIFT)
 	si_meminfo(&i);
 	si_swapinfo(&i);
+	pg_size = atomic_read(&page_cache_size) - i.bufferram ;
+
 	len = sprintf(page, "        total:    used:    free:  shared: buffers:  cached:\n"
 		"Mem:  %8Lu %8Lu %8Lu %8Lu %8Lu %8Lu\n"
 		"Swap: %8Lu %8Lu %8Lu\n",
 		B(i.totalram), B(i.totalram-i.freeram), B(i.freeram),
 		B(i.sharedram), B(i.bufferram),
-		B(atomic_read(&page_cache_size)), B(i.totalswap),
+		B(pg_size), B(i.totalswap),
 		B(i.totalswap-i.freeswap), B(i.freeswap));
 	/*
 	 * Tagged format, for easy grepping and expansion.
@@ -179,7 +182,7 @@
 		K(i.freeram),
 		K(i.sharedram),
 		K(i.bufferram),
-		K(atomic_read(&page_cache_size) - swapper_space.nrpages),
+		K(pg_size - swapper_space.nrpages),
 		K(swapper_space.nrpages),
 		K(nr_active_pages),
 		K(nr_inactive_pages),

