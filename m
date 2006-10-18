Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423023AbWJRVts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423023AbWJRVts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423040AbWJRVtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:49:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:22205 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423023AbWJRVtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:49:46 -0400
Date: Wed, 18 Oct 2006 14:49:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Mackerras <paulus@samba.org>
cc: Will Schmidt <will_schmidt@vnet.ibm.com>, akpm@osdl.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
 <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
 <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape>
 <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
 <1161026409.31903.15.camel@farscape> <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
 <1161031821.31903.28.camel@farscape> <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is patch to add some printk to try to figure out what is going on. 
Run with this and send me the console output leading up to the failure.


Index: linux-2.6.19-rc2-mm1/mm/slab.c
===================================================================
--- linux-2.6.19-rc2-mm1.orig/mm/slab.c	2006-10-17 18:43:47.000000000 -0500
+++ linux-2.6.19-rc2-mm1/mm/slab.c	2006-10-18 16:47:42.904912835 -0500
@@ -2005,6 +2005,7 @@ static int setup_cpu_cache(struct kmem_c
 		return enable_cpucache(cachep);
 
 	if (g_cpucache_up == NONE) {
+		printk(KERN_CRIT "setup_cpu_cache: NONE\n");
 		/*
 		 * Note: the first kmem_cache_create must create the cache
 		 * that's used by kmalloc(24), otherwise the creation of
@@ -2023,6 +2024,7 @@ static int setup_cpu_cache(struct kmem_c
 		else
 			g_cpucache_up = PARTIAL_AC;
 	} else {
+		printk(KERN_CRIT "setup_cpu_cache: PARTIAL\n");
 		cachep->array[smp_processor_id()] =
 			kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
 
@@ -2219,6 +2221,7 @@ kmem_cache_create (const char *name, siz
 	align = ralign;
 
 	/* Get cache's description obj. */
+	printk(KERN_CRIT "Get cache descritor\n");
 	cachep = kmem_cache_zalloc(&cache_cache, SLAB_KERNEL);
 	if (!cachep)
 		goto oops;
@@ -3082,6 +3085,7 @@ static inline void *____cache_alloc(stru
 	void *objp;
 	struct array_cache *ac;
 
+	printk(KERN_CRIT "__cache_alloc\n");
 	check_irq_off();
 	ac = cpu_cache_get(cachep);
 	if (likely(ac->avail)) {
@@ -3135,6 +3139,7 @@ static void *alternate_node_alloc(struct
 {
 	int nid_alloc, nid_here;
 
+	printk(KERN_CRIT "alternate_node_alloc\n");
 	if (in_interrupt() || (flags & __GFP_THISNODE))
 		return NULL;
 	nid_alloc = nid_here = numa_node_id();
@@ -3160,6 +3165,7 @@ void *fallback_alloc(struct kmem_cache *
 	struct zone **z;
 	void *obj = NULL;
 
+	printk(KERN_CRIT "fallback_alloc\n");
 	for (z = zonelist->zones; *z && !obj; z++)
 		if (zone_idx(*z) <= ZONE_NORMAL &&
 				cpuset_zone_allowed(*z, flags))
@@ -3181,6 +3187,8 @@ static void *__cache_alloc_node(struct k
 	void *obj;
 	int x;
 
+	printk("__cache_alloc_node %d\n", nodeid);
+
 	l3 = cachep->nodelists[nodeid];
 	BUG_ON(!l3);
 
