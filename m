Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276646AbRJPT2u>; Tue, 16 Oct 2001 15:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276650AbRJPT2b>; Tue, 16 Oct 2001 15:28:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57100 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S276646AbRJPT23>; Tue, 16 Oct 2001 15:28:29 -0400
Date: Tue, 16 Oct 2001 16:07:29 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>
Subject: [UNTESTED PATCH] Throttle VM allocators
Message-ID: <Pine.LNX.4.21.0110161600110.10214-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following patch will throttle VM allocators in case we are below a
given threshold of free memory. 

This will make hunger allocators throttle more page reclamation, giving us
a (hopefully) fair system wrt memory.

Please test this. I'm specially interested in interactivity during heavy
VM pressure.

Its against 2.4.12.

Thanks

diff -Nur linux.orig/mm/page_alloc.c linux/mm/page_alloc.c
--- linux.orig/mm/page_alloc.c	Thu Oct 11 16:04:56 2001
+++ linux/mm/page_alloc.c	Thu Oct 11 16:03:36 2001
@@ -228,6 +228,22 @@
 }
 #endif
 
+static inline int vm_throttle(zone_t *classzone, unsigned int gfp_mask, unsigned int order)
+{
+	int progress;
+	if (in_interrupt())
+		BUG();
+
+	current->allocation_order = order;
+	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;
+
+	progress = try_to_free_pages(classzone, gfp_mask, order);
+
+	current->flags &= ~(PF_MEMALLOC | PF_FREE_PAGES);
+
+	return progress;
+}
+
 static struct page * FASTCALL(balance_classzone(zone_t *, unsigned int, unsigned int, int *));
 static struct page * balance_classzone(zone_t * classzone, unsigned int gfp_mask, unsigned int order, int * freed)
 {
@@ -338,6 +354,16 @@
 	if (waitqueue_active(&kswapd_wait))
 		wake_up_interruptible(&kswapd_wait);
 
+	/* 
+	 * We're possibly going to eat memory from the min<->low
+	 * "reversed" area. Throttling page reclamation using
+	 * the allocators which reach this point will give us a 
+	 * fair system.
+	 */
+
+	if ((gfp_mask & __GFP_WAIT))
+		vm_throttle(classzone, gfp_mask, order);
+
 	zone = zonelist->zones;
 	for (;;) {
 		unsigned long min;
@@ -386,7 +412,7 @@
 		if (!z)
 			break;
 
-		if (zone_free_pages(z, order) > z->pages_min) {
+		if (zone_free_pages(z, order) > z->pages_low) {
 			page = rmqueue(z, order);
 			if (page)
 				return page;
@@ -394,7 +420,13 @@
 	}
 
 	/* Don't let big-order allocations loop */
-	if (order)
+	/* We have one special 1-order alloc user: fork().
+	 * It obviously cannot fail easily like other 
+	 * high order allocations. This could also be fixed
+	 * by having a __GFP_LOOP flag to indicate that the 
+	 * high order allocation is "critical". 
+	 */
+	if (order > 1)
 		return NULL;
 
 	/* Yield for kswapd, and try again */
diff -Nur linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Thu Oct 11 16:04:56 2001
+++ linux/mm/vmscan.c	Thu Oct 11 15:52:36 2001
@@ -558,13 +558,14 @@
 	int priority = DEF_PRIORITY;
 	int nr_pages = SWAP_CLUSTER_MAX;
 
-	do {
-		nr_pages = shrink_caches(priority, classzone, gfp_mask, nr_pages);
-		if (nr_pages <= 0)
-			return 1;
+	nr_pages = shrink_caches(priority, classzone, gfp_mask, nr_pages);
+	if (nr_pages <= 0)
+		return 1;
+
+	ret = (nr_pages < SWAP_CLUSTER_MAX);
+
+	ret |= swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
 
-		ret |= swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
-	} while (--priority);
 
 	return ret;
 }





