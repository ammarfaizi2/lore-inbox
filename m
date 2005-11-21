Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVKUTrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVKUTrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVKUTrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:47:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17849 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932446AbVKUTre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:47:34 -0500
Date: Mon, 21 Nov 2005 11:47:12 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: [PATCH] slab: minor cleanup to kmem_cache_alloc_node
In-Reply-To: <1132598194.8972.4.camel@localhost>
Message-ID: <Pine.LNX.4.62.0511211145500.7813@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.62.0511210919001.6497@graphe.net> <1132598194.8972.4.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Pekka Enberg wrote:

> On Mon, 2005-11-21 at 09:21 -0800, Christoph Lameter wrote:
> > You could move the check for -1 into the section where interrupts are 
> > disabled.
> So we could do something like the following. Unfortunately it does not
> seem much of an improvement... Thoughts?

Remove the gotos. Something like this. It would be nice if we could remove 
the printk. Hmm....

Index: linux-2.6.15-rc1-mm2/mm/slab.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/mm/slab.c	2005-11-21 10:51:03.000000000 -0800
+++ linux-2.6.15-rc1-mm2/mm/slab.c	2005-11-21 11:43:31.000000000 -0800
@@ -2890,21 +2890,20 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	unsigned long save_flags;
 	void *ptr;
 
-	if (nodeid == -1)
-		return __cache_alloc(cachep, flags);
+	cache_alloc_debugcheck_before(cachep, flags);
+	local_irq_save(save_flags);
 
-	if (unlikely(!cachep->nodelists[nodeid])) {
+	if (nodeid == -1 || nodeid == numa_node_id())
+		ptr = ____cache_alloc(cachep, flags);
+
+	else if (unlikely(!cachep->nodelists[nodeid])) {
 		/* Fall back to __cache_alloc if we run into trouble */
 		printk(KERN_WARNING "slab: not allocating in inactive node %d for cache %s\n", nodeid, cachep->name);
-		return __cache_alloc(cachep,flags);
-	}
+		ptr =  ____cache_alloc(cachep,flags);
 
-	cache_alloc_debugcheck_before(cachep, flags);
-	local_irq_save(save_flags);
-	if (nodeid == numa_node_id())
-		ptr = ____cache_alloc(cachep, flags);
-	else
+	} else
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
+
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
 
