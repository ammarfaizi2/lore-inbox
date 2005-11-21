Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVKUVHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKUVHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVKUVHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:07:55 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16011 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750708AbVKUVHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:07:54 -0500
Subject: Re: [PATCH] slab: minor cleanup to kmem_cache_alloc_node
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       Joe Perches <joe@perches.com>
In-Reply-To: <Pine.LNX.4.62.0511211145500.7813@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0511211627460.18869@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.62.0511210919001.6497@graphe.net>
	 <1132598194.8972.4.camel@localhost>
	 <Pine.LNX.4.62.0511211145500.7813@schroedinger.engr.sgi.com>
Date: Mon, 21 Nov 2005 23:07:52 +0200
Message-Id: <1132607272.19332.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-11-21 at 11:47 -0800, Christoph Lameter wrote:
> Remove the gotos. Something like this. It would be nice if we could remove 
> the printk. Hmm....

Definite improvement to my patch. I think I like Joe's suggestion 
better, though. (Any mistakes in the following are mine.)

			Pekka

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -2866,21 +2866,16 @@ void *kmem_cache_alloc_node(kmem_cache_t
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
+	if (nodeid == -1 || nodeid == numa_node_id())
 		ptr = ____cache_alloc(cachep, flags);
-	else
+	else if (likely(cachep->nodelists[nodeid]))
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
+	else
+		ptr = ____cache_alloc(cachep, flags);
+
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));
 


