Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292979AbSCDXEn>; Mon, 4 Mar 2002 18:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292978AbSCDXEi>; Mon, 4 Mar 2002 18:04:38 -0500
Received: from zok.SGI.COM ([204.94.215.101]:38893 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292964AbSCDXEW>;
	Mon, 4 Mar 2002 18:04:22 -0500
Date: Mon, 4 Mar 2002 15:03:19 -0800 (PST)
From: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Stephan von Krawczynski <skraw@ithnet.com>, <riel@conectiva.com.br>,
        <phillips@bonn-fries.net>, <davidsen@tmr.com>, <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020304230603.O20606@dualathlon.random>
Message-ID: <Pine.LNX.4.33.0203041447450.17847-100000@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Andrea Arcangeli wrote:

> On Mon, Mar 04, 2002 at 10:46:54AM -0800, Martin J. Bligh wrote:
> > >> 2) We can do local per-node scanning - no need to bounce
> > >> information to and fro across the interconnect just to see what's
> > >> worth swapping out.
> > >
> > > Well, you can achieve this by "attaching" the nodes' local memory
> > > (zone) to its cpu and let the vm work preferably only on these attached
> > > zones (regarding the list scanning and the like). This way you have no
> > > interconnect traffic generated. But this is in no way related to rmap.
> > >
> > >> I can't see any way to fix this without some sort of rmap - any
> > >> other suggestions as to how this might be done?
> > >
> > > As stated above: try to bring in per-node zones that are preferred by their cpu. This can work equally well for UP,SMP and NUMA (maybe even for cluster).
> > > UP=every zone is one or more preferred zone(s)
> > > SMP=every zone is one or more preferred zone(s)
> > > NUMA=every cpu has one or more preferred zone(s), but can walk the whole zone-list if necessary.
> > >
> > > Preference is implemented as simple list of cpu-ids attached to every
> > > memory zone.  This is for being able to see the whole picture. Every
> > > cpu has a private list of (preferred) zones which is used by vm for the
> > > scanning jobs (swap et al). This way there is no need to touch interconnection.
> > > If you are really in a bad situation you can alway go back to the global
> > > list and do whatever is needed.
> >
> > As I understand the current code (ie this may be totally wrong ;-) ) I think
> > we already pretty much have what you're suggesting. There's one (or more)
> > zone per node chained off the pgdata_t, and during memory allocation we
> > try to scan through the zones attatched to the local node first. The problem
>
> yes, also make sure to keep this patch from SGI applied, it's very
> important to avoid memory balancing if there's still free memory in the
> other zones:
>
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1/20_numa-mm-1
This patch is included (in a slightly different form) in the 2.4.17
discontig patch (http://sourceforge.net/projects/discontig).
But martin may need another patch to apply. With the current
implementation of __alloc_pages, we have 2 problems :
1) A node is not emptied before moving to the following node
2) If none of the zones on a node have more freepages than min(defined as
   min+= z->pages_low), we start looking on the following node, instead of
   trying harder on the same node.

I have a patch that tries to fix these problems. Of course this patch
makes sense only with either the discontig patch or the SGI patch Andrea
mentioned applied. I'd appreciate your feedback on this piece of code.

This patch is against 2.4.19-pre2:

--- linux-2.4.19-pre2/mm/page_alloc.c	Mon Mar  4 14:35:27 2002
+++ linux-2.4.19-pre2-sam/mm/page_alloc.c	Mon Mar  4 14:38:53 2002
@@ -339,68 +339,110 @@
  */
 struct page * __alloc_pages(unsigned int gfp_mask, unsigned int order, zonelist_t *zonelist)
 {
-	unsigned long min;
-	zone_t **zone, * classzone;
+	unsigned long min_low, min_min;
+	zone_t **zone, **current_zone, * classzone, *z;
 	struct page * page;
 	int freed;
-
+	struct pglist_data* current_node;
+
 	zone = zonelist->zones;
-	classzone = *zone;
-	min = 1UL << order;
-	for (;;) {
-		zone_t *z = *(zone++);
-		if (!z)
+	z = *zone;
+	for(;;){
+		/*
+		 * This loops scans all the zones
+		 */
+		min_low = 1UL << order;
+		current_node = z->zone_pgdat;
+		current_zone = zone;
+		classzone = z;
+		do{
+			/*
+			 * This loops scans all the zones of
+			 * the current node.
+			 */
+			min_low += z->pages_low;
+			if (z->free_pages > min_low) {
+				page = rmqueue(z, order);
+				if (page)
+					return page;
+			}
+			z = *(++zone);
+		}while(z && (z->zone_pgdat == current_node));
+		/*
+		 * The node is low on memory.
+		 * If this is the last node, then the
+		 * swap daemon is awaken.
+		 */
+
+		classzone->need_balance = 1;
+		mb();
+		if (!z && waitqueue_active(&kswapd_wait))
+			wake_up_interruptible(&kswapd_wait);
+
+		min_min = 1UL << order;
+
+		/*
+		 * We want to try again in the current node.
+		 */
+		zone = current_zone;
+		z = *zone;
+		do{
+			unsigned long local_min;
+			local_min = z->pages_min;
+			if (!(gfp_mask & __GFP_WAIT))
+				local_min >>= 2;
+			min_min += local_min;
+			if (z->free_pages > min_min) {
+				page = rmqueue(z, order);
+				if (page)
+					return page;
+			}
+			z = *(++zone);
+		}while(z && (z->zone_pgdat == current_node));
+
+		/*
+		 * If we are on the last node, and the current
+		 * process has not the correct flags, then it is
+		 * not allowed to empty the machine.
+		 */
+		if(!z && !(current->flags & (PF_MEMALLOC | PF_MEMDIE)))
 			break;

-		min += z->pages_low;
-		if (z->free_pages > min) {
+		zone = current_zone;
+		z = *zone;
+		do{
 			page = rmqueue(z, order);
 			if (page)
 				return page;
-		}
-	}
-
-	classzone->need_balance = 1;
-	mb();
-	if (waitqueue_active(&kswapd_wait))
-		wake_up_interruptible(&kswapd_wait);
-
-	zone = zonelist->zones;
-	min = 1UL << order;
-	for (;;) {
-		unsigned long local_min;
-		zone_t *z = *(zone++);
-		if (!z)
+			z = *(++zone);
+		}while(z && (z->zone_pgdat == current_node));
+
+		if(!z)
 			break;
-
-		local_min = z->pages_min;
-		if (!(gfp_mask & __GFP_WAIT))
-			local_min >>= 2;
-		min += local_min;
-		if (z->free_pages > min) {
-			page = rmqueue(z, order);
-			if (page)
-				return page;
-		}
 	}
-
-	/* here we're in the low on memory slow path */
-
+
 rebalance:
+	/*
+	 * We were not able to find enough memory.
+	 * Since the swap daemon has been waken up,
+	 * we might be able to find some pages.
+	 * If not, we need to balance the entire memory.
+	 */
+	classzone = *zonelist->zones;
 	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
 		zone = zonelist->zones;
 		for (;;) {
 			zone_t *z = *(zone++);
 			if (!z)
 				break;
-
+
 			page = rmqueue(z, order);
 			if (page)
 				return page;
 		}
 		return NULL;
 	}
-
+
 	/* Atomic allocations - we can't balance anything */
 	if (!(gfp_mask & __GFP_WAIT))
 		return NULL;
@@ -410,14 +452,14 @@
 		return page;

 	zone = zonelist->zones;
-	min = 1UL << order;
+	min_min = 1UL << order;
 	for (;;) {
 		zone_t *z = *(zone++);
 		if (!z)
 			break;

-		min += z->pages_min;
-		if (z->free_pages > min) {
+		min_min += z->pages_min;
+		if (z->free_pages > min_min) {
 			page = rmqueue(z, order);
 			if (page)
 				return page;





