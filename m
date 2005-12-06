Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbVLFWwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbVLFWwt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVLFWwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:52:49 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16263 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965038AbVLFWwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:52:47 -0500
Date: Tue, 6 Dec 2005 14:52:33 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/3] Framework for accurate node based statistics
In-Reply-To: <20051206200607.GY11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512061447590.20377@schroedinger.engr.sgi.com>
References: <20051206182843.19188.82045.sendpatchset@schroedinger.engr.sgi.com>
 <20051206183524.GU11190@wotan.suse.de> <Pine.LNX.4.62.0512061105220.19475@schroedinger.engr.sgi.com>
 <20051206192603.GX11190@wotan.suse.de> <Pine.LNX.4.62.0512061131500.19637@schroedinger.engr.sgi.com>
 <20051206200607.GY11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Andi Kleen wrote:

> Ok we'll need a local64_t then. No big deal - can be easily added.
> Or perhaps better a long_local_t so that 32bit doesn't need to
> pay the cost.

I jusw saw that ia64 already has local_t as 64 bit, so that is no problem 
for us. Here is a patch that would convert the framework to use local_t.
Is that okay?

The problem with this solution is that the use of local_t will lead to the 
use of atomic operations (in case the preemption status is unknown). It 
may be better to use atomic operations and simply drop the per_cpu stuff. 
That way the summing of the per cpu variables is avoided and the 
stats are accurate in real time.

Seems that local.h is rarely used. There was an obvious mistake in there 
for ia64.

Index: linux-2.6.15-rc5/mm/page_alloc.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/page_alloc.c	2005-12-06 10:13:49.000000000 -0800
+++ linux-2.6.15-rc5/mm/page_alloc.c	2005-12-06 14:43:41.000000000 -0800
@@ -560,26 +560,25 @@ static int rmqueue_bulk(struct zone *zon
 static spinlock_t node_stat_lock;
 unsigned long vm_stat_global[NR_STAT_ITEMS];
 unsigned long vm_stat_node[MAX_NUMNODES][NR_STAT_ITEMS];
-int vm_stat_diff[NR_CPUS][MAX_NUMNODES][NR_STAT_ITEMS];
+DEFINE_PER_CPU(local_t [MAX_NUMNODES][NR_STAT_ITEMS], vm_stat_diff);
 
 void refresh_vm_stats(void) {
-	int cpu;
 	int node;
 	int i;
 
 	spin_lock(&node_stat_lock);
 
-	cpu = get_cpu();
 	for_each_online_node(node)
 		for(i = 0; i < NR_STAT_ITEMS; i++) {
-			int * p = vm_stat_diff[cpu][node]+i;
-			if (*p) {
-				vm_stat_node[node][i] += *p;
-				vm_stat_global[i] += *p;
-				*p = 0;
+			long v;
+
+			v = cpu_local_read(vm_stat_diff[node][i]);
+			if (v) {
+				vm_stat_node[node][i] += v;
+				vm_stat_global[i] += v;
+				cpu_local_set(vm_stat_diff[node][i], 0);
 			}
 		}
-	put_cpu();
 
 	spin_unlock(&node_stat_lock);
 }
Index: linux-2.6.15-rc5/include/linux/page-flags.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/page-flags.h	2005-12-06 10:15:59.000000000 -0800
+++ linux-2.6.15-rc5/include/linux/page-flags.h	2005-12-06 14:47:03.000000000 -0800
@@ -8,6 +8,7 @@
 #include <linux/percpu.h>
 #include <linux/cache.h>
 #include <asm/pgtable.h>
+#include <asm/local.h>
 
 /*
  * Various page->flags bits:
@@ -169,12 +170,19 @@ enum node_stat_item { NR_MAPPED, NR_PAGE
 
 extern unsigned long vm_stat_global[NR_STAT_ITEMS];
 extern unsigned long vm_stat_node[MAX_NUMNODES][NR_STAT_ITEMS];
-extern int vm_stat_diff[NR_CPUS][MAX_NUMNODES][NR_STAT_ITEMS];
+DECLARE_PER_CPU(local_t [MAX_NUMNODES][NR_STAT_ITEMS], vm_stat_diff);
 
 static inline void mod_node_page_state(int node, enum node_stat_item item, int delta)
 {
-	vm_stat_diff[get_cpu()][node][item] += delta;
-	put_cpu();
+	cpu_local_add(delta, vm_stat_diff[node][item]);
+}
+
+/*
+ * For use when we know that preemption is disabled. Avoids atomic operations.
+ */
+static inline void __mod_node_page_state(int node, enum node_stat_item item, int delta)
+{
+	__local_add(delta, &__get_cpu_var(vm_stat_diff[node][item]));
 }
 
 #define inc_node_page_state(node, item) mod_node_page_state(node, item, 1)
Index: linux-2.6.15-rc5/include/asm-ia64/local.h
===================================================================
--- linux-2.6.15-rc5.orig/include/asm-ia64/local.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5/include/asm-ia64/local.h	2005-12-06 14:39:47.000000000 -0800
@@ -17,7 +17,7 @@ typedef struct {
 #define local_set(l, i)	atomic64_set(&(l)->val, i)
 #define local_inc(l)	atomic64_inc(&(l)->val)
 #define local_dec(l)	atomic64_dec(&(l)->val)
-#define local_add(l)	atomic64_add(&(l)->val)
+#define local_add(i, l)	atomic64_add((i), &(l)->val)
 #define local_sub(l)	atomic64_sub(&(l)->val)
 
 /* Non-atomic variants, i.e., preemption disabled and won't be touched in interrupt, etc.  */
