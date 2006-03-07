Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWCGPsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWCGPsR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 10:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWCGPsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 10:48:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41914 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751256AbWCGPsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 10:48:16 -0500
Date: Tue, 7 Mar 2006 09:48:05 -0600
From: Jack Steiner <steiner@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] - Allocate larger cache_cache if order 0 fails
Message-ID: <20060307154805.GA3474@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kmem_cache_init() incorrectly assumes that the cache_cache object will
fit in an order 0 allocation. On very large systems, this is not
true. Change the code to try larger order allocations if order 0 fails.

	Signed-off-by: Jack Steiner <steiner@sgi.com>




Index: linux/mm/slab.c
===================================================================
--- linux.orig/mm/slab.c	2006-03-01 16:07:31.000000000 -0600
+++ linux/mm/slab.c	2006-03-03 13:21:52.000000000 -0600
@@ -1124,6 +1124,7 @@ void __init kmem_cache_init(void)
 	struct cache_sizes *sizes;
 	struct cache_names *names;
 	int i;
+	int order;
 
 	for (i = 0; i < NUM_INIT_LISTS; i++) {
 		kmem_list3_init(&initkmem_list3[i]);
@@ -1167,11 +1168,15 @@ void __init kmem_cache_init(void)
 
 	cache_cache.buffer_size = ALIGN(cache_cache.buffer_size, cache_line_size());
 
-	cache_estimate(0, cache_cache.buffer_size, cache_line_size(), 0,
-		       &left_over, &cache_cache.num);
+	for (order = 0; order < MAX_ORDER; order++) {
+		cache_estimate(order, cache_cache.buffer_size, cache_line_size(), 0,
+		       	&left_over, &cache_cache.num);
+		if (cache_cache.num)
+			break;
+	}
 	if (!cache_cache.num)
 		BUG();
-
+	cache_cache.gfporder = order;
 	cache_cache.colour = left_over / cache_cache.colour_off;
 	cache_cache.slab_size = ALIGN(cache_cache.num * sizeof(kmem_bufctl_t) +
 				      sizeof(struct slab), cache_line_size());
