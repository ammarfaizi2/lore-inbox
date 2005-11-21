Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVKUVSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVKUVSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750700AbVKUVSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:18:03 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:63175 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750736AbVKUVSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:18:00 -0500
Date: Mon, 21 Nov 2005 13:17:41 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       Joe Perches <joe@perches.com>
Subject: Re: [PATCH] slab: minor cleanup to kmem_cache_alloc_node
In-Reply-To: <1132607272.19332.7.camel@localhost>
Message-ID: <Pine.LNX.4.62.0511211314560.10768@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.62.0511210919001.6497@graphe.net>  <1132598194.8972.4.camel@localhost>
  <Pine.LNX.4.62.0511211145500.7813@schroedinger.engr.sgi.com>
 <1132607272.19332.7.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Pekka Enberg wrote:

> Hi,
> 
> On Mon, 2005-11-21 at 11:47 -0800, Christoph Lameter wrote:
> > Remove the gotos. Something like this. It would be nice if we could remove 
> > the printk. Hmm....
> 
> Definite improvement to my patch. I think I like Joe's suggestion 
> better, though. (Any mistakes in the following are mine.)

If we drop the printk then this may be even simpler

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm2/mm/slab.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/mm/slab.c	2005-11-21 13:16:07.000000000 -0800
+++ linux-2.6.15-rc1-mm2/mm/slab.c	2005-11-21 13:16:59.000000000 -0800
@@ -2890,21 +2890,14 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	unsigned long save_flags;
 	void *ptr;
 
-	if (nodeid == -1)
-		return __cache_alloc(cachep, flags);
-
-	if (unlikely(!cachep->nodelists[nodeid])) {
-		/* Fall back to __cache_alloc if we run into trouble */
-		printk(KERN_WARNING "slab: not allocating in inactive node %d for cache %s\n", nodeid, cachep->name);
-		return __cache_alloc(cachep,flags);
-	}
-
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-	if (nodeid == numa_node_id())
+
+	if (nodeid == -1 || nodeid == numa_node_id() || !cachep->nodelists[nodeid])
 		ptr = ____cache_alloc(cachep, flags);
 	else
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
+
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
 
