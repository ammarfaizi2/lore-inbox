Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276673AbRJPUkA>; Tue, 16 Oct 2001 16:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276682AbRJPUju>; Tue, 16 Oct 2001 16:39:50 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:39689 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276673AbRJPUjl>;
	Tue, 16 Oct 2001 16:39:41 -0400
Date: Tue, 16 Oct 2001 18:39:59 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <linux-mm@kvack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] hogstop for 2.4.12-ac3
Message-ID: <Pine.LNX.4.33L.0110161747130.6440-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch attempts to stop slow down heavy memory allocators
before the system runs really low on ram, so the other programs
in the system can run smoother during higher system loads.

This patch does the following things to achieve that:

1) instead of a simple reschedule, call try_to_free_pages()
   from __alloc_pages() once all zones have less than
   zone->pages_low freeable, this not only has the effect
   of memory allocators being slowed down, but it will also
   mean they are virtually certain of the fact that they'll
   get their memory afte _one_ call to try_to_free_pages(),
   instead of "hitting the wall"

2) removing the "penalise the process allocating memory" from
   swap_out(); while this code swaps out memory from the
   current process, it is almost certain to _increase_ the
   allocation rate by this process, which would only make
   things worse for the other processes

As usual, the latest version of my pathes can be found on
http://www.surriel.com/patches/ and tests under various
workloads and on various system types are very welcome ...


regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/



--- linux-2.4.12-ac3/mm/page_alloc.c.orig	Tue Oct 16 15:56:38 2001
+++ linux-2.4.12-ac3/mm/page_alloc.c	Tue Oct 16 16:58:17 2001
@@ -346,22 +346,15 @@
 	 * We wake up kswapd, in the hope that kswapd will
 	 * resolve this situation before memory gets tight.
 	 *
-	 * We also yield the CPU, because that:
-	 * - gives kswapd a chance to do something
-	 * - slows down allocations, in particular the
-	 *   allocations from the fast allocator that's
-	 *   causing the problems ...
-	 * - ... which minimises the impact the "bad guys"
-	 *   have on the rest of the system
-	 * - if we don't have __GFP_IO set, kswapd may be
-	 *   able to free some memory we can't free ourselves
+	 * We'll also help a bit trying to free pages, this
+	 * way statistics will make sure really fast allocators
+	 * are slowed down more than slow allocators and other
+	 * programs in the system shouldn't be impacted as much
+	 * by the hogs.
 	 */
 	wakeup_kswapd();
-	if (gfp_mask & __GFP_WAIT) {
-		__set_current_state(TASK_RUNNING);
-		current->policy |= SCHED_YIELD;
-		schedule();
-	}
+	if ((gfp_mask & __GFP_WAIT) && !(current->flags & PF_MEMALLOC))
+		try_to_free_pages(gfp_mask);

 	/*
 	 * After waking up kswapd, we try to allocate a page
@@ -431,8 +424,13 @@
 		 * do not have __GFP_FS set it's possible we cannot make
 		 * any progress freeing pages, in that case it's better
 		 * to give up than to deadlock the kernel looping here.
+		 *
+		 * NFS: we must yield the CPU (to rpciod) to avoid deadlock.
 		 */
 		if (gfp_mask & __GFP_WAIT) {
+			__set_current_state(TASK_RUNNING);
+			current->policy |= SCHED_YIELD;
+			schedule();
 			if (!order || free_shortage()) {
 				int progress = try_to_free_pages(gfp_mask);
 				if (progress || (gfp_mask & __GFP_FS))
--- linux-2.4.12-ac3/mm/vmscan.c.orig	Tue Oct 16 15:56:38 2001
+++ linux-2.4.12-ac3/mm/vmscan.c	Tue Oct 16 17:04:44 2001
@@ -399,11 +399,7 @@
 	int retval = 0;
 	struct mm_struct *mm = current->mm;

-	/* Always start by trying to penalize the process that is allocating memory */
-	if (mm)
-		retval = swap_out_mm(mm, swap_amount(mm));
-
-	/* Then, look at the other mm's */
+	/* Scan part of the process virtual memory. */
 	counter = (mmlist_nr << SWAP_SHIFT) >> priority;
 	do {
 		spin_lock(&mmlist_lock);

