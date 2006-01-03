Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWACU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWACU0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWACUZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:25:54 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38311 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964776AbWACUZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:25:42 -0500
Subject: [patch 2/9] slab: minor cleanup to kmem_cache_alloc_node
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, rostedt@goodmis.org, clameter@sgi.com,
       penberg@cs.helsinki.fi
Date: Tue, 03 Jan 2006 22:25:40 +0200
Message-Id: <1136319940.8629.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Lameter <clameter@engr.sgi.com>

This patch cleans up kmem_cache_alloc_node a bit.

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -2872,21 +2872,14 @@ void *kmem_cache_alloc_node(kmem_cache_t
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
 

--


