Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWANMqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWANMqi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWANMqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:46:15 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:12194 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751196AbWANMqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:46:06 -0500
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Date: Sat, 14 Jan 2006 14:46:05 +0200
Message-Id: <20060114122436.009168000@localhost>
References: <20060114122249.246354000@localhost>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [patch 07/10] slab: reduce inlining
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manfred Spraul <manfred@colorfullife.com>

Reduce the amount of inline functions in slab to the functions that
are used in the hot path:

  - no inline for debug functions
  - no __always_inline, inline is already __always_inline
  - remove inline from a few numa support functions.

Before:

   text    data     bss     dec     hex filename
  13588     752      48   14388    3834 mm/slab.o (defconfig)
  16671    2492      48   19211    4b0b mm/slab.o (numa)

After:

   text    data     bss     dec     hex filename
  13366     752      48   14166    3756 mm/slab.o (defconfig)
  16230    2492      48   18770    4952 mm/slab.o (numa)

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -335,7 +335,7 @@ static __always_inline int index_of(cons
 #define INDEX_AC index_of(sizeof(struct arraycache_init))
 #define INDEX_L3 index_of(sizeof(struct kmem_list3))
 
-static inline void kmem_list3_init(struct kmem_list3 *parent)
+static void kmem_list3_init(struct kmem_list3 *parent)
 {
 	INIT_LIST_HEAD(&parent->slabs_full);
 	INIT_LIST_HEAD(&parent->slabs_partial);
@@ -814,7 +814,7 @@ static struct array_cache *alloc_arrayca
 }
 
 #ifdef CONFIG_NUMA
-static inline struct array_cache **alloc_alien_cache(int node, int limit)
+static struct array_cache **alloc_alien_cache(int node, int limit)
 {
 	struct array_cache **ac_ptr;
 	int memsize = sizeof(void *) * MAX_NUMNODES;
@@ -841,7 +841,7 @@ static inline struct array_cache **alloc
 	return ac_ptr;
 }
 
-static inline void free_alien_cache(struct array_cache **ac_ptr)
+static void free_alien_cache(struct array_cache **ac_ptr)
 {
 	int i;
 
@@ -854,8 +854,8 @@ static inline void free_alien_cache(stru
 	kfree(ac_ptr);
 }
 
-static inline void __drain_alien_cache(kmem_cache_t *cachep,
-				       struct array_cache *ac, int node)
+static void __drain_alien_cache(kmem_cache_t *cachep,
+				struct array_cache *ac, int node)
 {
 	struct kmem_list3 *rl3 = cachep->nodelists[node];
 
@@ -1531,7 +1531,7 @@ static void slab_destroy(kmem_cache_t *c
 
 /* For setting up all the kmem_list3s for cache whose buffer_size is same
    as size of kmem_list3. */
-static inline void set_up_list3s(kmem_cache_t *cachep, int index)
+static void set_up_list3s(kmem_cache_t *cachep, int index)
 {
 	int node;
 
@@ -1934,7 +1934,7 @@ static void check_spinlock_acquired(kmem
 #endif
 }
 
-static inline void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
+static void check_spinlock_acquired_node(kmem_cache_t *cachep, int node)
 {
 #ifdef CONFIG_SMP
 	check_irq_off();

--

