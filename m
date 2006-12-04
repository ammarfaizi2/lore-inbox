Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937222AbWLDSSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937222AbWLDSSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937067AbWLDSSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:18:15 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:59764 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937223AbWLDSSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:18:14 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] SLAB : use a multiply instead of a divide in obj_to_index()
Date: Mon, 4 Dec 2006 19:18:29 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
References: <4564C28B.30604@redhat.com> <200612041741.51846.dada1@cosmosbay.com> <Pine.LNX.4.64.0612040852250.31485@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0612040852250.31485@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1ZGdFPS0j5drwDN"
Message-Id: <200612041918.29682.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_1ZGdFPS0j5drwDN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 04 December 2006 17:55, Christoph Lameter wrote:
> Could you generalize the reciprocal thingy so that the division
> can be used from other parts of the kernel as well? It would be useful to
> separately get some cycle counts on a regular division compared with your
> division. If that shows benefit then we may think about using it in the
> kernel. I am a bit surprised that this is still an issue on modern cpus.

OK I added a new include file, I am not sure it is the best way...

Well, AFAIK this particular divide is the only one that hurts performance o=
n=20
my machines.

Do you have in mind another spot in kernel where we could use this reciproc=
al=20
divide as well ?

Yes divide complexity is still an issue with modern CPUS :=20
elapsed time for 10^9 loops on Pentium M 1.6 Ghz
24 s for the version using divides
3.8 s for the version using multiplies

[PATCH] SLAB : use a multiply instead of a divide in obj_to_index()

When some objects are allocated by one CPU but freed by another CPU we can=
=20
consume lot of cycles doing divides in obj_to_index().

(Typical load on a dual processor machine where network interrupts are hand=
led=20
by one particular CPU (allocating skbufs), and the other CPU is running the=
=20
application (consuming and freeing skbufs))

Here on one production server (dual-core AMD Opteron 285), I noticed this=20
divide took 1.20 % of CPU_CLK_UNHALTED events in kernel. But Opteron are=20
quite modern cpus and the divide is much more expensive on oldest=20
architectures :

On a 200 MHz sparcv9 machine, the division takes 64 cycles instead of 1 cyc=
le=20
for a multiply.

Doing some math, we can use a reciprocal multiplication instead of a divide.

If we want to compute V =3D (A / B) =A0(A and B being u32 quantities)
we can instead use :

V =3D ((u64)A * RECIPROCAL(B)) >> 32 ;

where RECIPROCAL(B) is precalculated to ((1LL << 32) + (B - 1)) / B

Note :

I wrote pure C code for clarity. gcc output for i386 is not optimal but=20
acceptable :

mull =A0 0x14(%ebx)
mov =A0 =A0%edx,%eax // part of the >> 32
xor =A0 =A0 %edx,%edx // useless=20
mov =A0 =A0%eax,(%esp) // could be avoided
mov =A0 =A0%edx,0x4(%esp) // useless
mov =A0 =A0(%esp),%ebx

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_1ZGdFPS0j5drwDN
Content-Type: text/plain;
  charset="iso-8859-1";
  name="slab_avoid_divides.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="slab_avoid_divides.patch"

--- linux-2.6.19/include/linux/reciprocal_div.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-ed/include/linux/reciprocal_div.h	2006-12-04 19:01:44.000000000 +0100
@@ -0,0 +1,30 @@
+#ifndef _LINUX_RECIPROCAL_DIV_H
+#define _LINUX_RECIPROCAL_DIV_H
+
+/*
+ * Define the reciprocal value of B so that
+ * ((u32)A / (u32)B) can be replaced by :
+ * (((u64)A * RECIPROCAL_VALUE(B)) >> 32)
+ * If RECIPROCAL_VALUE(B) is precalculated, we change a divide by a multiply
+ */
+#define RECIPROCAL_VALUE(B) (u32)(((1LL << 32) + ((B) - 1))/ (B))
+
+static inline u32 reciprocal_value(unsigned int k)
+{
+	if (__builtin_constant_p(k))
+		return RECIPROCAL_VALUE(k);
+	else {
+		u64 val = (1LL << 32) + (k - 1);
+		do_div(val, k);
+		return (u32)val;
+	}
+}
+
+/*
+ * We want to avoid an expensive divide : (A / B)
+ * If B is known in advance, its reciprocal R can be precalculated/stored.
+ * then  (A / B)  =  (u32)(((u64)(A) * (R)) >> 32)
+ */
+#define RECIPROCAL_DIVIDE(A, R) (u32)(((u64)(A) * (R)) >> 32)
+
+#endif
--- linux-2.6.19/mm/slab.c	2006-12-04 11:50:19.000000000 +0100
+++ linux-2.6.19-ed/mm/slab.c	2006-12-04 19:03:42.000000000 +0100
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
+	unsigned int reciprocal_buffer_size;
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
+ *   RECIPROCAL_DIVIDE(offset, cache->reciprocal_buffer_size)
+ */
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct slab *slab, void *obj)
 {
-	return (unsigned)(obj - slab->s_mem) / cache->buffer_size;
+	unsigned int offset = (obj - slab->s_mem);
+	return RECIPROCAL_DIVIDE(offset, cache->reciprocal_buffer_size);
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

--Boundary-00=_1ZGdFPS0j5drwDN--
