Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWAWQ5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWAWQ5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWAWQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:57:22 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:40381 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964814AbWAWQ5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:57:22 -0500
Subject: [RFC/PATCH 2/3] slab: extract alloc_node_cache
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: manfred@colorfullife.com, christoph@lameter.com
Cc: linux-kernel@vger.kernel.org
Date: Mon, 23 Jan 2006 18:57:19 +0200
Message-Id: <1138035439.10527.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch removes duplicate code by extracting node_cache allocation
to alloc_node_cache function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -347,6 +347,16 @@ static void node_cache_init(struct node_
 	parent->free_touched = 0;
 }
 
+static struct node_cache *alloc_node_cache(int node)
+{
+	struct node_cache *node_cache;
+
+	node_cache = kmalloc_node(sizeof(*node_cache), GFP_KERNEL, node);
+	if (node_cache)
+		node_cache_init(node_cache);
+	return node_cache;
+}
+
 #define MAKE_LIST(cachep, listp, slab, nodeid)	\
 	do {	\
 		INIT_LIST_HEAD(listp);		\
@@ -907,7 +917,6 @@ static int __devinit cpuup_callback(stru
 	struct kmem_cache *cachep;
 	struct node_cache *node_cache = NULL;
 	int node = cpu_to_node(cpu);
-	int memsize = sizeof(struct node_cache);
 
 	switch (action) {
 	case CPU_UP_PREPARE:
@@ -924,10 +933,9 @@ static int __devinit cpuup_callback(stru
 			 * node has not already allocated this
 			 */
 			if (!cachep->nodelists[node]) {
-				if (!(node_cache = kmalloc_node(memsize,
-							GFP_KERNEL, node)))
+				node_cache = alloc_node_cache(node);
+				if (!node_cache)
 					goto bad;
-				node_cache_init(node_cache);
 				node_cache->next_reap = jiffies + REAPTIMEOUT_LIST3 +
 				    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 
@@ -1891,14 +1899,9 @@ kmem_cache_create (const char *name, siz
 			} else {
 				int node;
 				for_each_online_node(node) {
-
 					cachep->nodelists[node] =
-					    kmalloc_node(sizeof
-							 (struct node_cache),
-							 GFP_KERNEL, node);
+						alloc_node_cache(node);
 					BUG_ON(!cachep->nodelists[node]);
-					node_cache_init(cachep->
-							nodelists[node]);
 				}
 			}
 		}
@@ -3211,11 +3214,9 @@ static int alloc_node_caches(struct kmem
 			free_alien_cache(new_alien);
 			continue;
 		}
-		if (!(node_cache = kmalloc_node(sizeof(struct node_cache),
-					GFP_KERNEL, node)))
+		node_cache = alloc_node_cache(node);
+		if (!node_cache)
 			goto fail;
-
-		node_cache_init(node_cache);
 		node_cache->next_reap = jiffies + REAPTIMEOUT_LIST3 +
 		    ((unsigned long)cachep) % REAPTIMEOUT_LIST3;
 		node_cache->shared = new;


