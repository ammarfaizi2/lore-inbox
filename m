Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937116AbWLDQli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937116AbWLDQli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937118AbWLDQlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:41:37 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:58088 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937116AbWLDQlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:41:36 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] SLAB : use a multiply instead of a divide in obj_to_index()
Date: Mon, 4 Dec 2006 17:41:51 +0100
User-Agent: KMail/1.9.5
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
References: <4564C28B.30604@redhat.com> <4573B8DE.20205@redhat.com> <20061203222816.aaef93a3.akpm@osdl.org>
In-Reply-To: <20061203222816.aaef93a3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_P/EdF7aim38meWN"
Message-Id: <200612041741.51846.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_P/EdF7aim38meWN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

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

--Boundary-00=_P/EdF7aim38meWN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="slab_avoid_divides.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="slab_avoid_divides.patch"

--- linux-2.6.19/mm/slab.c	2006-12-04 11:50:19.000000000 +0100
+++ linux-2.6.19-ed/mm/slab.c	2006-12-04 17:25:02.000000000 +0100
@@ -371,6 +371,19 @@ static void kmem_list3_init(struct kmem_
 	} while (0)
 
 /*
+ * Define the reciprocal value of B so that
+ * ((u32)A / (u32)B) can be replaced by :
+ * (((u64)A * RECIPROCAL_VALUE(B)) >> 32)
+ * If RECIPROCAL_VALUE(B) is precalculated, we change a divide by a multiply
+ */
+static inline u32 reciprocal_value(unsigned int k)
+{
+	u64 val = (1LL << 32) + (k - 1);
+	do_div(val, k);
+	return (u32)val;
+}
+
+/*
  * struct kmem_cache
  *
  * manages a cache.
@@ -385,6 +398,7 @@ struct kmem_cache {
 	unsigned int shared;
 
 	unsigned int buffer_size;
+	unsigned int reciprocal_buffer_size;
 /* 3) touched by every alloc & free from the backend */
 	struct kmem_list3 *nodelists[MAX_NUMNODES];
 
@@ -626,10 +640,17 @@ static inline void *index_to_obj(struct 
 	return slab->s_mem + cache->buffer_size * idx;
 }
 
+/*
+ * We want to avoid an expensive divide : (offset / cache->buffer_size)
+ *   Using the fact that buffer_size is a constant for a particular cache,
+ *   we can replace (offset / cache->buffer_size) by
+ *   ((u64)offset * cache->reciprocal_buffer_size) >> 32
+ */
 static inline unsigned int obj_to_index(struct kmem_cache *cache,
 					struct slab *slab, void *obj)
 {
-	return (unsigned)(obj - slab->s_mem) / cache->buffer_size;
+	unsigned int offset = (obj - slab->s_mem);
+	return (u32)(((u64)offset * cache->reciprocal_buffer_size) >> 32);
 }
 
 /*
@@ -1400,6 +1421,8 @@ void __init kmem_cache_init(void)
 
 	cache_cache.buffer_size = ALIGN(cache_cache.buffer_size,
 					cache_line_size());
+	cache_cache.reciprocal_buffer_size =
+		reciprocal_value(cache_cache.buffer_size);
 
 	for (order = 0; order < MAX_ORDER; order++) {
 		cache_estimate(order, cache_cache.buffer_size,
@@ -2297,6 +2320,7 @@ kmem_cache_create (const char *name, siz
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
 	cachep->buffer_size = size;
+	cachep->reciprocal_buffer_size = reciprocal_value(size);
 
 	if (flags & CFLGS_OFF_SLAB) {
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);

--Boundary-00=_P/EdF7aim38meWN--
