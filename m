Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967367AbWLDVpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967367AbWLDVpu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967368AbWLDVpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:45:50 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:36971 "EHLO Smtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S967367AbWLDVps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:45:48 -0500
Date: Mon, 04 Dec 2006 22:34:29 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] SLAB : use a multiply instead of a divide in obj_to_index()
In-reply-to: <20061204114954.165107b6.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Message-id: <45749465.6030601@cosmosbay.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_VYUTwkPzJJ5nzL31hKogig)"
References: <4564C28B.30604@redhat.com>
 <200612041741.51846.dada1@cosmosbay.com>
 <Pine.LNX.4.64.0612040852250.31485@schroedinger.engr.sgi.com>
 <200612041918.29682.dada1@cosmosbay.com>
 <20061204114954.165107b6.akpm@osdl.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_VYUTwkPzJJ5nzL31hKogig)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Thank you Andrew for your comments, here is a new version of the patch that 
should take them into account.

Maybe it should be split into two different patches ?

One introducing include/linux/reciprocal_div.h and lib/reciprocal_div.c, one 
using them in slab ?


[PATCH] SLAB : use a multiply instead of a divide in obj_to_index()

When some objects are allocated by one CPU but freed by another CPU we can
consume lot of cycles doing divides in obj_to_index().

(Typical load on a dual processor machine where network interrupts are handled
by one particular CPU (allocating skbufs), and the other CPU is running the
application (consuming and freeing skbufs))

Here on one production server (dual-core AMD Opteron 285), I noticed this
divide took 1.20 % of CPU_CLK_UNHALTED events in kernel. But Opteron are
quite modern cpus and the divide is much more expensive on oldest
architectures :

On a 200 MHz sparcv9 machine, the division takes 64 cycles instead of 1 cycle
for a multiply.

Doing some math, we can use a reciprocal multiplication instead of a divide.

If we want to compute V = (A / B)  (A and B being u32 quantities)
we can instead use :

V = ((u64)A * RECIPROCAL(B)) >> 32 ;

where RECIPROCAL(B) is precalculated to ((1LL << 32) + (B - 1)) / B

Note :

I wrote pure C code for clarity. gcc output for i386 is not optimal but
acceptable :

mull   0x14(%ebx)
mov    %edx,%eax // part of the >> 32
xor     %edx,%edx // useless
mov    %eax,(%esp) // could be avoided
mov    %edx,0x4(%esp) // useless
mov    (%esp),%ebx

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--Boundary_(ID_VYUTwkPzJJ5nzL31hKogig)
Content-type: text/plain; name=reciprocal_division.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=reciprocal_division.patch

--- linux-2.6.19/include/linux/reciprocal_div.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-ed/include/linux/reciprocal_div.h	2006-12-04 23:12:34.000000000 +0100
@@ -0,0 +1,30 @@
+#ifndef _LINUX_RECIPROCAL_DIV_H
+#define _LINUX_RECIPROCAL_DIV_H
+
+/*
+ * This file describes reciprocical division.
+ *
+ * This optimizes the (A/B) problem, when A and B are two u32
+ * and B is a known value (but not known at compile time)
+ *
+ * The math principle used is :
+ *   Let RECIPROCAL_VALUE(B) be (((1LL << 32) + (B - 1))/ B)
+ *   Then A / B = (u32)(((u64)(A) * (R)) >> 32)
+ *
+ * This replaces a divide by a multiply (and a shift), and
+ * is generally less expensive in CPU cycles.
+ */
+
+/*
+ * Computes the reciprocal value (R) for the value B of the divisor.
+ * Should not be called before each reciprocal_divide(),
+ * or else the performance is slower than a normal divide.
+ */
+extern u32 reciprocal_value(u32 B);
+
+
+static inline u32 reciprocal_divide(u32 A, u32 R)
+{
+	return (u32)(((u64)A * R) >> 32);
+}
+#endif
--- linux-2.6.19/lib/reciprocal_div.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-ed/lib/reciprocal_div.c	2006-12-04 23:18:54.000000000 +0100
@@ -0,0 +1,10 @@
+#include <linux/types.h>
+#include <asm/div64.h>
+#include <linux/reciprocal_div.h>
+
+u32 reciprocal_value(u32 k)
+{
+	u64 val = (1LL << 32) + (k - 1);
+	do_div(val, k);
+	return (u32)val;
+}
--- linux-2.6.19/lib/Makefile	2006-12-04 23:12:30.000000000 +0100
+++ linux-2.6.19-ed/lib/Makefile	2006-12-04 23:15:14.000000000 +0100
@@ -5,7 +5,7 @@
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o irq_regs.o
+	 sha1.o irq_regs.o reciprocal_div.o
 
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
--- linux-2.6.19/mm/slab.c	2006-12-04 22:51:42.000000000 +0100
+++ linux-2.6.19-ed/mm/slab.c	2006-12-04 23:13:42.000000000 +0100
@@ -107,6 +107,7 @@
 #include	<linux/mempolicy.h>
 #include	<linux/mutex.h>
 #include	<linux/rtmutex.h>
+#include	<linux/reciprocal_div.h>
 
 #include	<asm/uaccess.h>
 #include	<asm/cacheflush.h>
@@ -385,6 +386,7 @@ struct kmem_cache {
 	unsigned int shared;
 
 	unsigned int buffer_size;
+	u32 reciprocal_buffer_size;
 /* 3) touched by every alloc & free from the backend */
 	struct kmem_list3 *nodelists[MAX_NUMNODES];
 
@@ -626,10 +628,17 @@ static inline void *index_to_obj(struct 
 	return slab->s_mem + cache->buffer_size * idx;
 }
 
-static inline unsigned int obj_to_index(struct kmem_cache *cache,
-					struct slab *slab, void *obj)
+/*
+ * We want to avoid an expensive divide : (offset / cache->buffer_size)
+ *   Using the fact that buffer_size is a constant for a particular cache,
+ *   we can replace (offset / cache->buffer_size) by
+ *   reciprocal_divide(offset, cache->reciprocal_buffer_size)
+ */
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct slab *slab, void *obj)
 {
-	return (unsigned)(obj - slab->s_mem) / cache->buffer_size;
+	unsigned int offset = (obj - slab->s_mem);
+	return reciprocal_divide(offset, cache->reciprocal_buffer_size);
 }
 
 /*
@@ -1400,6 +1409,8 @@ void __init kmem_cache_init(void)
 
 	cache_cache.buffer_size = ALIGN(cache_cache.buffer_size,
 					cache_line_size());
+	cache_cache.reciprocal_buffer_size =
+		reciprocal_value(cache_cache.buffer_size);
 
 	for (order = 0; order < MAX_ORDER; order++) {
 		cache_estimate(order, cache_cache.buffer_size,
@@ -2297,6 +2308,7 @@ kmem_cache_create (const char *name, siz
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
 	cachep->buffer_size = size;
+	cachep->reciprocal_buffer_size = reciprocal_value(size);
 
 	if (flags & CFLGS_OFF_SLAB) {
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);

--Boundary_(ID_VYUTwkPzJJ5nzL31hKogig)--
