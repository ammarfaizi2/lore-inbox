Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVKUSgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVKUSgh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVKUSgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:36:37 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:42119 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932408AbVKUSgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:36:37 -0500
Subject: Re: [PATCH] slab: minor cleanup to kmem_cache_alloc_node
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com
In-Reply-To: <Pine.LNX.4.62.0511210919001.6497@graphe.net>
References: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.62.0511210919001.6497@graphe.net>
Date: Mon, 21 Nov 2005 20:36:34 +0200
Message-Id: <1132598194.8972.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 09:21 -0800, Christoph Lameter wrote:
> On Mon, 21 Nov 2005, Pekka J Enberg wrote:
> 
> > This patch gets rid of one if-else statement by moving current node allocation
> > check at the beginning of kmem_cache_alloc_node().
> 
> The problem with this is that the numa_node may change if irqs are still 
> active and your patch moves the check for the numa node outside of the 
> section where irqs are enabled.
> 
> You could move the check for -1 into the section where interrupts are 
> disabled.

So we could do something like the following. Unfortunately it does not
seem much of an improvement... Thoughts?

			Pekka

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -2866,21 +2866,23 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	unsigned long save_flags;
 	void *ptr;
 
-	if (nodeid == -1)
-		return __cache_alloc(cachep, flags);
+	cache_alloc_debugcheck_before(cachep, flags);
+	local_irq_save(save_flags);
+
+	if (nodeid == -1 || nodeid == numa_node_id()) {
+		ptr = ____cache_alloc(cachep, flags);
+		goto out;
+	}
 
 	if (unlikely(!cachep->nodelists[nodeid])) {
 		/* Fall back to __cache_alloc if we run into trouble */
 		printk(KERN_WARNING "slab: not allocating in inactive node %d for cache %s\n", nodeid, cachep->name);
-		return __cache_alloc(cachep,flags);
+		ptr = ____cache_alloc(cachep,flags);
+		goto out;
 	}
 
-	cache_alloc_debugcheck_before(cachep, flags);
-	local_irq_save(save_flags);
-	if (nodeid == numa_node_id())
-		ptr = ____cache_alloc(cachep, flags);
-	else
-		ptr = __cache_alloc_node(cachep, flags, nodeid);
+	ptr = __cache_alloc_node(cachep, flags, nodeid);
+  out:
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
 


