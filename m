Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbTJWNcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 09:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTJWNcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 09:32:43 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:49373
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263556AbTJWNch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 09:32:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Autoregulate vm swappiness 2.6.0-test8
Date: Thu, 23 Oct 2003 23:37:50 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_um9l/znox2X6Nuc"
Message-Id: <200310232337.50538.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_um9l/znox2X6Nuc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The vm_swappiness dial in 2.6 was never quite the right setting without me 
constantly changing it depending on the workload. If I was copying large 
files or encoding video it was best at 0. If I was using lots of applications 
it was best much higher. Furthermore it depended on the amount of ram in the 
machine I was using. This patch was done just for fun a while back but it 
turned out to be quite effectual so I thought I'd make it available for the 
wider community to play with. Do whatever you like with it.

This patch autoregulates the vm_swappiness dial in 2.6 by making it equal to 
the percentage of physical ram consumed by application pages. 

This has the effect of preventing applications from being swapped out if the 
ram is filling up with cached data. 

Conversely, if many applications are in ram the swappiness increases which 
means the application currently in use gets to stay in physical ram while 
other less used applications are swapped out. 

For desktop enthusiasts this means if you are copying large files around like 
ISO images or leave your machine unattended for a while it will not swap out 
your applications. Conversely if the machine has a lot of applications 
currently loaded it will give the currently running applications preference 
and swap out the less used ones.

The performance effect on larger boxes seems to be either unchanged or slight 
improvement (1%) in database benchmarks.

The value in vm_swappiness is updated only when the vm is under pressure to 
swap and you can check the last vm_swappiness value under pressure by
cat /proc/sys/vm/swappiness

Manually setting the swappiness with this patch in situ has no effect. This 
patch has been heavily tested without noticable harm. Note I am not sure of 
the best way to do this so it may look rather crude.

Patch against 2.6.0-test8

Con

--Boundary-00=_um9l/znox2X6Nuc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-test8-am"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="patch-test8-am"

--- linux-2.6.0-test8-base/mm/vmscan.c	2003-10-19 20:24:36.000000000 +1000
+++ linux-2.6.0-test8-am/mm/vmscan.c	2003-10-22 17:56:18.501329888 +1000
@@ -47,7 +47,7 @@
 /*
  * From 0 .. 100.  Higher means more swappy.
  */
-int vm_swappiness = 60;
+int vm_swappiness = 0;
 static long total_memory;
 
 #ifdef ARCH_HAS_PREFETCH
@@ -595,11 +595,13 @@ refill_inactive_zone(struct zone *zone, 
 	int pgmoved;
 	int pgdeactivate = 0;
 	int nr_pages = nr_pages_in;
+	int pg_size;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
 	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
 	struct page *page;
 	struct pagevec pvec;
+	struct sysinfo i;
 	int reclaim_mapped = 0;
 	long mapped_ratio;
 	long distress;
@@ -642,6 +644,16 @@ refill_inactive_zone(struct zone *zone, 
 	mapped_ratio = (ps->nr_mapped * 100) / total_memory;
 
 	/*
+	 * Autoregulate vm_swappiness to be application pages % -ck.
+	 */
+	si_meminfo(&i);
+	si_swapinfo(&i);
+	pg_size = get_page_cache_size() - i.bufferram ;
+	vm_swappiness = 100 - (((i.freeram + i.bufferram +
+		(pg_size - swapper_space.nrpages)) * 100) /
+		(i.totalram ? i.totalram : 1));
+
+	/*
 	 * Now decide how much we really want to unmap some pages.  The mapped
 	 * ratio is downgraded - just because there's a lot of mapped memory
 	 * doesn't necessarily mean that page reclaim isn't succeeding.

--Boundary-00=_um9l/znox2X6Nuc--

