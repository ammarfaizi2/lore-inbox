Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVJGMtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVJGMtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVJGMtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:49:49 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:43158 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932516AbVJGMtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:49:49 -0400
Date: Fri, 7 Oct 2005 15:49:47 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] vm - swap_prefetch-15
In-Reply-To: <200510072233.12216.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.58.0510071546540.8703@sbz-30.cs.Helsinki.FI>
References: <200510070001.01418.kernel@kolivas.org> <200510072208.01357.kernel@kolivas.org>
 <Pine.LNX.4.58.0510071511040.6755@sbz-30.cs.Helsinki.FI>
 <200510072233.12216.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005, Con Kolivas wrote:
> That will end up being far more intrusive than this version and __alloc_pages 
> would need more tests that affect every call to __alloc_pages which seems 
> much more expensive to me than exporting buffered_rmqueue and 
> zone_statistics, and the modified __alloc_pages will still be a much more 
> complicated function than prefetch_get_page. 

Short-term, perhaps. However, what you are doing is inventing your own 
page allocator which, I suspect, is more expensive in the long term.

Up to you of course and I am probably the wrong person to talk to about 
this. Never the less, here's a totally untested patch to do it.

			Pekka

Index: 2.6/include/linux/gfp.h
===================================================================
--- 2.6.orig/include/linux/gfp.h
+++ 2.6/include/linux/gfp.h
@@ -41,6 +41,7 @@ struct vm_area_struct;
 #define __GFP_NOMEMALLOC 0x10000u /* Don't use emergency reserves */
 #define __GFP_NORECLAIM  0x20000u /* No realy zone reclaim during allocation */
 #define __GFP_HARDWALL   0x40000u /* Enforce hardwall cpuset memory allocs */
+#define __GFP_NEVER_RECLAIM 0x80000u /* Never attempt to reclaim */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((1 << __GFP_BITS_SHIFT) - 1)
Index: 2.6/mm/page_alloc.c
===================================================================
--- 2.6.orig/mm/page_alloc.c
+++ 2.6/mm/page_alloc.c
@@ -778,6 +778,7 @@ __alloc_pages(unsigned int __nocast gfp_
 		struct zonelist *zonelist)
 {
 	const int wait = gfp_mask & __GFP_WAIT;
+	const int can_reclaim = !(gfp_mask & __GFP_NEVER_RECLAIM);
 	struct zone **zones, *z;
 	struct page *page;
 	struct reclaim_state reclaim_state;
@@ -812,7 +813,7 @@ restart:
 	 * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
 	 */
 	for (i = 0; (z = zones[i]) != NULL; i++) {
-		int do_reclaim = should_reclaim_zone(z, gfp_mask);
+		int do_reclaim = can_reclaim && should_reclaim_zone(z, gfp_mask);
 
 		if (!cpuset_zone_allowed(z, __GFP_HARDWALL))
 			continue;
@@ -840,6 +841,9 @@ zone_reclaim_retry:
 			goto got_pg;
 	}
 
+	if (unlikely(!can_reclaim))
+		goto out;
+
 	for (i = 0; (z = zones[i]) != NULL; i++)
 		wakeup_kswapd(z, order);
 
@@ -966,6 +970,7 @@ nopage:
 		dump_stack();
 		show_mem();
 	}
+out:
 	return NULL;
 got_pg:
 	zone_statistics(zonelist, z);
