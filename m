Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWANMqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWANMqG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWANMqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:46:06 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11682 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751171AbWANMqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:46:05 -0500
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Date: Sat, 14 Jan 2006 14:46:03 +0200
Message-Id: <20060114122410.207071000@localhost>
References: <20060114122249.246354000@localhost>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [patch 02/10] slab: minor cleanup to kmem_cache_alloc_node
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <clameter@engr.sgi.com>

This patch cleans up kmem_cache_alloc_node a bit.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -2916,27 +2916,18 @@ void *kmem_cache_alloc_node(kmem_cache_t
 	unsigned long save_flags;
 	void *ptr;
 
-	if (nodeid == -1)
-		return __cache_alloc(cachep, flags);
-
-	if (unlikely(!cachep->nodelists[nodeid])) {
-		/* Fall back to __cache_alloc if we run into trouble */
-		printk(KERN_WARNING
-		       "slab: not allocating in inactive node %d for cache %s\n",
-		       nodeid, cachep->name);
-		return __cache_alloc(cachep, flags);
-	}
-
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
-	if (nodeid == numa_node_id())
+
+	if (nodeid == -1 || nodeid == numa_node_id() ||
+	    !cachep->nodelists[nodeid])
 		ptr = ____cache_alloc(cachep, flags);
 	else
 		ptr = __cache_alloc_node(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
-	ptr =
-	    cache_alloc_debugcheck_after(cachep, flags, ptr,
-					 __builtin_return_address(0));
+
+	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr,
+					   __builtin_return_address(0));
 
 	return ptr;
 }

--

