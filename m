Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVERVlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVERVlZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVERVlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:41:25 -0400
Received: from graphe.net ([209.204.138.32]:40971 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262215AbVERVky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:40:54 -0400
Date: Wed, 18 May 2005 14:40:36 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Christoph Lameter <clameter@engr.sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       shai@scalex86.org, steiner@sgi.com
Subject: Re: NUMA aware slab allocator V3
In-Reply-To: <428BB05B.6090704@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0505181439080.10598@graphe.net>
References: <Pine.LNX.4.58.0505110816020.22655@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0505161046430.1653@schroedinger.engr.sgi.com> 
 <714210000.1116266915@flay> <200505161410.43382.jbarnes@virtuousgeek.org> 
 <740100000.1116278461@flay>  <Pine.LNX.4.62.0505161713130.21512@graphe.net>
 <1116289613.26955.14.camel@localhost> <428A800D.8050902@us.ibm.com>
 <Pine.LNX.4.62.0505171648370.17681@graphe.net> <428B7B16.10204@us.ibm.com>
 <Pine.LNX.4.62.0505181046320.20978@schroedinger.engr.sgi.com>
 <428BB05B.6090704@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Matthew Dobson wrote:

> I can't promise anything, but if you send me the latest version of your
> patch (preferably with the loops fixed to eliminate the possibility of it
> accessing an unavailable/unusable node), I can build & boot it on a PPC64
> box and see what happens.

Ok. Maybe one of the other issues addressed will fix the issue.

------------------

Fixes to the slab allocator in 2.6.12-rc4-mm2

- Remove MAX_NUMNODES check
- use for_each_node/cpu
- Fix determination of INDEX_AC

Signed-off-by: Christoph Lameter <christoph@lameter.com>
Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>

Index: linux-2.6.12-rc4/mm/slab.c
===================================================================
--- linux-2.6.12-rc4.orig/mm/slab.c	2005-05-17 02:20:02.000000000 +0000
+++ linux-2.6.12-rc4/mm/slab.c	2005-05-18 21:36:51.000000000 +0000
@@ -108,17 +108,6 @@
 #include	<asm/page.h>
 
 /*
- * Some Linux kernels currently have weird notions of NUMA. Make sure that
- * there is only a single node if CONFIG_NUMA is not set. Remove this check
- * after the situation has stabilized.
- */
-#ifndef CONFIG_NUMA
-#if MAX_NUMNODES != 1
-#error "Broken Configuration: CONFIG_NUMA not set but MAX_NUMNODES !=1 !!"
-#endif
-#endif
-
-/*
  * DEBUG	- 1 for kmem_cache_create() to honour; SLAB_DEBUG_INITIAL,
  *		  SLAB_RED_ZONE & SLAB_POISON.
  *		  0 for faster, smaller code (especially in the critical paths).
@@ -341,7 +330,7 @@
 	}
 }
 
-#define INDEX_AC index_of(sizeof(struct array_cache))
+#define INDEX_AC index_of(sizeof(struct arraycache_init))
 #define INDEX_L3 index_of(sizeof(struct kmem_list3))
 
 #ifdef CONFIG_NUMA
@@ -800,7 +789,7 @@
 		limit = 12;
 	ac_ptr = kmalloc_node(memsize, GFP_KERNEL, node);
 	if (ac_ptr) {
-		for (i = 0; i < MAX_NUMNODES; i++) {
+		for_each_node(i) {
 			if (i == node) {
 				ac_ptr[i] = NULL;
 				continue;
@@ -823,7 +812,7 @@
 
 	if (!ac_ptr)
 		return;
-	for (i = 0; i < MAX_NUMNODES; i++)
+	for_each_node(i)
 		kfree(ac_ptr[i]);
 
 	kfree(ac_ptr);
@@ -847,7 +836,7 @@
 	struct array_cache *ac;
 	unsigned long flags;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_node(i) {
 		ac = l3->alien[i];
 		if (ac) {
 			spin_lock_irqsave(&ac->lock, flags);
@@ -1197,7 +1186,7 @@
 	 * Register the timers that return unneeded
 	 * pages to gfp.
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_cpu(cpu) {
 		if (cpu_online(cpu))
 			start_cpu_timer(cpu);
 	}
@@ -1986,7 +1975,7 @@
 	drain_cpu_caches(cachep);
 
 	check_irq_on();
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_node(i) {
 		l3 = cachep->nodelists[i];
 		if (l3) {
 			spin_lock_irq(&l3->list_lock);
@@ -2064,11 +2053,11 @@
 	/* no cpu_online check required here since we clear the percpu
 	 * array on cpu offline and set this to NULL.
 	 */
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		kfree(cachep->array[i]);
 
 	/* NUMA: free the list3 structures */
-	for (i = 0; i < MAX_NUMNODES; i++) {
+	for_each_node(i) {
 		if ((l3 = cachep->nodelists[i])) {
 			kfree(l3->shared);
 #ifdef CONFIG_NUMA
@@ -2975,7 +2964,7 @@
 	if (!pdata)
 		return NULL;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		if (!cpu_possible(i))
 			continue;
 		pdata->ptrs[i] = kmalloc_node(size, GFP_KERNEL,
@@ -3075,7 +3064,7 @@
 	int i;
 	struct percpu_data *p = (struct percpu_data *) (~(unsigned long) objp);
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		if (!cpu_possible(i))
 			continue;
 		kfree(p->ptrs[i]);
@@ -3189,7 +3178,7 @@
 	struct kmem_list3 *l3;
 	int err = 0;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		if (cpu_online(i)) {
 			struct array_cache *nc = NULL, *new;
 #ifdef CONFIG_NUMA
@@ -3280,7 +3269,7 @@
 	int i, err;
 
 	memset(&new.new,0,sizeof(new.new));
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		if (cpu_online(i)) {
 			new.new[i] = alloc_arraycache(i, limit, batchcount);
 			if (!new.new[i]) {
@@ -3302,7 +3291,7 @@
 	cachep->shared = shared;
 	spin_unlock_irq(&cachep->spinlock);
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		struct array_cache *ccold = new.new[i];
 		if (!ccold)
 			continue;
