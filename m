Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031335AbWKUTgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031335AbWKUTgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 14:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031337AbWKUTgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 14:36:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:28380 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1031335AbWKUTgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 14:36:50 -0500
Date: Tue, 21 Nov 2006 11:36:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC 1/7] Remove declaration of sighand_cachep from slab.h
In-Reply-To: <20061121000743.bb9ea2d0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611211133300.30133@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
 <20061118054347.8884.36259.sendpatchset@schroedinger.engr.sgi.com>
 <20061118172739.30538d16.sfr@canb.auug.org.au>
 <Pine.LNX.4.64.0611200817020.16173@schroedinger.engr.sgi.com>
 <20061121000743.bb9ea2d0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006, Andrew Morton wrote:

> Use `struct kmem_cache' instead of `kmem_cache_t' and lo, you can
> forward-declare it in the header file without having to include slab.h.
> 
> Patches which rid us of kmem_cache_t are always welcome..

Ok. So this patch would be acceptable?


Remore kmem_cache_t from mm.

This patch removed all uses of kmem_cache_t from the code in mm/*.
The typedef is replaced with a define to allow other code to compile.

Signed-off-by: Christophh Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.19-rc5-mm2.orig/include/linux/slab.h	2006-11-17 23:19:18.000000000 -0600
+++ linux-2.6.19-rc5-mm2/include/linux/slab.h	2006-11-21 13:25:40.094576808 -0600
@@ -9,7 +9,8 @@
 
 #if	defined(__KERNEL__)
 
-typedef struct kmem_cache kmem_cache_t;
+/* Remove this after all occurrences of kmem_cache_t have been removed */
+#define kmem_cache_t struct kmem_cache
 
 #include	<linux/gfp.h>
 #include	<linux/init.h>
@@ -57,23 +58,24 @@ typedef struct kmem_cache kmem_cache_t;
 /* prototypes */
 extern void __init kmem_cache_init(void);
 
-extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long,
-				       void (*)(void *, kmem_cache_t *, unsigned long),
-				       void (*)(void *, kmem_cache_t *, unsigned long));
-extern void kmem_cache_destroy(kmem_cache_t *);
-extern int kmem_cache_shrink(kmem_cache_t *);
-extern void *kmem_cache_alloc(kmem_cache_t *, gfp_t);
+extern struct kmem_cache *kmem_cache_create(const char *,
+		size_t, size_t, unsigned long,
+		void (*)(void *, struct kmem_cache *, unsigned long),
+		void (*)(void *, struct kmem_cache *, unsigned long));
+extern void kmem_cache_destroy(struct kmem_cache *);
+extern int kmem_cache_shrink(struct kmem_cache *);
+extern void *kmem_cache_alloc(struct kmem_cache *, gfp_t);
 extern void *kmem_cache_zalloc(struct kmem_cache *, gfp_t);
-extern void kmem_cache_free(kmem_cache_t *, void *);
-extern unsigned int kmem_cache_size(kmem_cache_t *);
-extern const char *kmem_cache_name(kmem_cache_t *);
+extern void kmem_cache_free(struct kmem_cache *, void *);
+extern unsigned int kmem_cache_size(struct kmem_cache *);
+extern const char *kmem_cache_name(struct kmem_cache *);
 
 /* Size description struct for general caches. */
 struct cache_sizes {
 	size_t		 cs_size;
-	kmem_cache_t	*cs_cachep;
+	struct kmem_cache *cs_cachep;
 #ifdef CONFIG_ZONE_DMA
-	kmem_cache_t	*cs_dmacachep;
+	struct kmem_cache *cs_dmacachep;
 #else
 #define cs_dmacachep cs_cachep
 #endif
@@ -215,7 +217,7 @@ extern unsigned int ksize(const void *);
 extern int slab_is_available(void);
 
 #ifdef CONFIG_NUMA
-extern void *kmem_cache_alloc_node(kmem_cache_t *, gfp_t flags, int node);
+extern void *kmem_cache_alloc_node(struct kmem_cache *, gfp_t flags, int node);
 extern void *__kmalloc_node(size_t size, gfp_t flags, int node);
 
 static inline void *kmalloc_node(size_t size, gfp_t flags, int node)
@@ -241,7 +243,8 @@ found:
 	return __kmalloc_node(size, flags, node);
 }
 #else
-static inline void *kmem_cache_alloc_node(kmem_cache_t *cachep, gfp_t flags, int node)
+static inline void *kmem_cache_alloc_node(struct kmem_cache *cachep,
+						 gfp_t flags, int node)
 {
 	return kmem_cache_alloc(cachep, flags);
 }
@@ -252,10 +255,11 @@ static inline void *kmalloc_node(size_t 
 #endif
 
 extern int FASTCALL(kmem_cache_reap(int));
-extern int FASTCALL(kmem_ptr_validate(kmem_cache_t *cachep, void *ptr));
+extern int FASTCALL(kmem_ptr_validate(struct kmem_cache *cachep, void *ptr));
 
 struct shrinker;
-extern void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker);
+extern void kmem_set_shrinker(struct kmem_cache *cachep,
+					struct shrinker *shrinker);
 
 #else /* CONFIG_SLOB */
 
@@ -291,19 +295,19 @@ static inline void *kcalloc(size_t n, si
 #define kmalloc_track_caller kmalloc
 
 struct shrinker;
-static inline void kmem_set_shrinker(kmem_cache_t *cachep,
+static inline void kmem_set_shrinker(struct kmem_cache *cachep,
 				     struct shrinker *shrinker) {}
 
 #endif /* CONFIG_SLOB */
 
 /* System wide caches */
-extern kmem_cache_t	*vm_area_cachep;
-extern kmem_cache_t	*names_cachep;
-extern kmem_cache_t	*files_cachep;
-extern kmem_cache_t	*filp_cachep;
-extern kmem_cache_t	*fs_cachep;
-extern kmem_cache_t	*sighand_cachep;
-extern kmem_cache_t	*bio_cachep;
+extern struct kmem_cache	*vm_area_cachep;
+extern struct kmem_cache	*names_cachep;
+extern struct kmem_cache	*files_cachep;
+extern struct kmem_cache	*filp_cachep;
+extern struct kmem_cache	*fs_cachep;
+extern struct kmem_cache	*sighand_cachep;
+extern struct kmem_cache	*bio_cachep;
 
 #endif	/* __KERNEL__ */
 
Index: linux-2.6.19-rc5-mm2/mm/slab.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/mm/slab.c	2006-11-15 16:48:13.000000000 -0600
+++ linux-2.6.19-rc5-mm2/mm/slab.c	2006-11-21 13:21:50.009874395 -0600
@@ -4393,7 +4393,7 @@ unsigned int ksize(const void *objp)
 	return obj_size(virt_to_cache(objp));
 }
 
-void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker)
+void kmem_set_shrinker(struct kmem_cache *cachep, struct shrinker *shrinker)
 {
 	cachep->shrinker = shrinker;
 }
Index: linux-2.6.19-rc5-mm2/mm/swap_prefetch.c
===================================================================
--- linux-2.6.19-rc5-mm2.orig/mm/swap_prefetch.c	2006-11-15 16:48:13.000000000 -0600
+++ linux-2.6.19-rc5-mm2/mm/swap_prefetch.c	2006-11-21 13:22:56.496196955 -0600
@@ -39,7 +39,7 @@ struct swapped_root {
 	struct radix_tree_root	swap_tree;	/* Lookup tree of pages */
 	unsigned int		count;		/* Number of entries */
 	unsigned int		maxcount;	/* Maximum entries allowed */
-	kmem_cache_t		*cache;		/* Of struct swapped_entry */
+	struct kmem_cache	*cache;		/* Of struct swapped_entry */
 };
 
 static struct swapped_root swapped = {
