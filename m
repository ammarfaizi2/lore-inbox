Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290782AbSAaAs5>; Wed, 30 Jan 2002 19:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290783AbSAaAsx>; Wed, 30 Jan 2002 19:48:53 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:36557 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290782AbSAaAsb>; Wed, 30 Jan 2002 19:48:31 -0500
Date: Thu, 31 Jan 2002 01:48:17 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Slab cache name fixes / reiserfs boot bug fix.
Message-ID: <20020131014816.A1017@averell>
In-Reply-To: <20020131002937.A1372@averell> <Pine.LNX.4.33.0201301548100.14950-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201301548100.14950-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 12:52:45AM +0100, Linus Torvalds wrote:
> Why not just do
> 
> 	#define VEC(x)	{ x, "biovec-" #x }
> 	static const struct {
> 		int size, char *name;
> 	} bvec_pools[BIOVEC_NR_POOLS] = {
> 		VEC(1), VEC(4), VEC(16),
> 		VEC(64), VEC(128), VEC(256)
> 	};
> 
> and then register them with a nice
> 
> 	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
> 		bp->slab = kmem_cache_create(
> 			bvec_pools[i].name,
> 			bvec_pools[i].size,
> 		...
> 
> which is just simpler and doesn't have issues like fixed 16-byte arrays
> etc.

I reworked the patch now according to your suggestions. It'll use slightly
more cache now, but should be easier readable, has no fixed size char arrays
and is indeed cleaner.  I kept the kmalloc slab names out of line for 
cache reasons, but replaced the char array there with pointers to .text
strings. 

Thanks,
-Andi


--- linux-2.5.3-work/fs/bio.c-SLABNAME	Tue Jan 15 17:53:31 2002
+++ linux-2.5.3-work/fs/bio.c	Thu Jan 31 01:40:37 2002
@@ -33,20 +33,24 @@
 
 struct biovec_pool {
 	int size;
+	char *name; 
 	kmem_cache_t *slab;
 	mempool_t *pool;
 };
 
-static struct biovec_pool bvec_array[BIOVEC_NR_POOLS];
-
 /*
  * if you change this list, also change bvec_alloc or things will
  * break badly! cannot be bigger than what you can fit into an
  * unsigned short
  */
-static const int bvec_pool_sizes[BIOVEC_NR_POOLS] = { 1, 4, 16, 64, 128, 256 };
 
-#define BIO_MAX_PAGES	(bvec_pool_sizes[BIOVEC_NR_POOLS - 1])
+#define BV(x) { x, "biovec-" #x }
+static struct biovec_pool bvec_array[BIOVEC_NR_POOLS] = { 
+	BV(1), BV(4), BV(16), BV(64), BV(128), BV(256)
+}; 
+#undef BV
+
+#define BIO_MAX_PAGES	(bvec_array[BIOVEC_NR_POOLS - 1].size)
 
 static void *slab_pool_alloc(int gfp_mask, void *data)
 {
@@ -64,7 +68,7 @@
 	struct bio_vec *bvl;
 
 	/*
-	 * see comment near bvec_pool_sizes define!
+	 * see comment near bvec_array define!
 	 */
 	switch (nr) {
 		case   1        : *idx = 0; break;
@@ -452,21 +456,17 @@
 
 static void __init biovec_init_pool(void)
 {
-	char name[16];
 	int i, size;
 
-	memset(&bvec_array, 0, sizeof(bvec_array));
-
 	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
 		struct biovec_pool *bp = bvec_array + i;
 
-		size = bvec_pool_sizes[i] * sizeof(struct bio_vec);
+		size = bp->size * sizeof(struct bio_vec);
 
 		printk("biovec: init pool %d, %d entries, %d bytes\n", i,
-						bvec_pool_sizes[i], size);
+						bp->size, size);
 
-		snprintf(name, sizeof(name) - 1,"biovec-%d",bvec_pool_sizes[i]);
-		bp->slab = kmem_cache_create(name, size, 0,
+		bp->slab = kmem_cache_create(bp->name, size, 0,
 						SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!bp->slab)
 			panic("biovec: can't init slab cache\n");
@@ -474,7 +474,7 @@
 					slab_pool_free, bp->slab);
 		if (!bp->pool)
 			panic("biovec: can't init mempool\n");
-		bp->size = size;
+		bp->size = size;	
 	}
 }
 
--- linux-2.5.3-work/mm/slab.c-SLABNAME	Tue Jan 15 17:53:36 2002
+++ linux-2.5.3-work/mm/slab.c	Thu Jan 31 01:36:21 2002
@@ -186,8 +186,6 @@
  * manages a cache.
  */
 
-#define CACHE_NAMELEN	20	/* max name length for a slab cache */
-
 struct kmem_cache_s {
 /* 1) each alloc & free */
 	/* full, partial first, then free */
@@ -225,7 +223,7 @@
 	unsigned long		failures;
 
 /* 3) cache creation/removal */
-	char			name[CACHE_NAMELEN];
+	const char		*name;
 	struct list_head	next;
 #ifdef CONFIG_SMP
 /* 4) per-cpu data */
@@ -335,6 +333,7 @@
 	kmem_cache_t	*cs_dmacachep;
 } cache_sizes_t;
 
+/* These are the default caches for kmalloc. Custom caches can have other sizes. */
 static cache_sizes_t cache_sizes[] = {
 #if PAGE_SIZE == 4096
 	{    32,	NULL, NULL},
@@ -353,6 +352,29 @@
 	{131072,	NULL, NULL},
 	{     0,	NULL, NULL}
 };
+/* Must match cache_sizes above. Out of line to keep cache footprint low. */
+#define CN(x) { x, x " (DMA)" }
+static struct { 
+	char *name; 
+	char *name_dma;
+} cache_names[] = { 
+#if PAGE_SIZE == 4096
+	CN("size-32"),
+#endif
+	CN("size-64"),
+	CN("size-128"),
+	CN("size-256"),
+	CN("size-512"),
+	CN("size-1024"),
+	CN("size-2048"),
+	CN("size-4096"),
+	CN("size-8192"),
+	CN("size-16384"),
+	CN("size-32768"),
+	CN("size-65536"),
+	CN("size-131072")
+}; 
+#undef CN
 
 /* internal cache of cache description objs */
 static kmem_cache_t cache_cache = {
@@ -437,7 +459,6 @@
 void __init kmem_cache_sizes_init(void)
 {
 	cache_sizes_t *sizes = cache_sizes;
-	char name[20];
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
 	 * page orders on machines with more than 32MB of memory.
@@ -450,9 +471,9 @@
 		 * eliminates "false sharing".
 		 * Note for systems short on memory removing the alignment will
 		 * allow tighter packing of the smaller caches. */
-		sprintf(name,"size-%Zd",sizes->cs_size);
 		if (!(sizes->cs_cachep =
-			kmem_cache_create(name, sizes->cs_size,
+			kmem_cache_create(cache_names[sizes-cache_sizes].name, 
+					  sizes->cs_size,
 					0, SLAB_HWCACHE_ALIGN, NULL, NULL))) {
 			BUG();
 		}
@@ -462,9 +483,10 @@
 			offslab_limit = sizes->cs_size-sizeof(slab_t);
 			offslab_limit /= 2;
 		}
-		sprintf(name, "size-%Zd(DMA)",sizes->cs_size);
-		sizes->cs_dmacachep = kmem_cache_create(name, sizes->cs_size, 0,
-			      SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
+		sizes->cs_dmacachep = kmem_cache_create(
+		    cache_names[sizes-cache_sizes].name_dma, 
+			sizes->cs_size, 0,
+			SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!sizes->cs_dmacachep)
 			BUG();
 		sizes++;
@@ -604,6 +626,11 @@
  * Cannot be called within a int, but can be interrupted.
  * The @ctor is run when new pages are allocated by the cache
  * and the @dtor is run before the pages are handed back.
+ *
+ * @name must be valid until the cache is destroyed. This implies that
+ * the module calling this has to destroy the cache before getting 
+ * unloaded.
+ * 
  * The flags are
  *
  * %SLAB_POISON - Poison the slab with a known test pattern (a5a5a5a5)
@@ -632,7 +659,6 @@
 	 * Sanity checks... these are all serious usage bugs.
 	 */
 	if ((!name) ||
-		((strlen(name) >= CACHE_NAMELEN - 1)) ||
 		in_interrupt() ||
 		(size < BYTES_PER_WORD) ||
 		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
@@ -797,8 +823,7 @@
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
 	cachep->ctor = ctor;
 	cachep->dtor = dtor;
-	/* Copy name over so we don't have problems with unloaded modules */
-	strcpy(cachep->name, name);
+	cachep->name = name;
 
 #ifdef CONFIG_SMP
 	if (g_cpucache_up)
@@ -811,10 +836,20 @@
 
 		list_for_each(p, &cache_chain) {
 			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
-
-			/* The name field is constant - no lock needed. */
-			if (!strcmp(pc->name, name))
-				BUG();
+			char tmp;
+			/* This happens when the module gets unloaded and doesn't
+			   destroy its slab cache and noone else reuses the vmalloc
+			   area of the module. Print a warning. */
+			if (__get_user(tmp,pc->name)) { 
+				printk("SLAB: cache with size %d has lost its name\n", 
+					pc->objsize); 
+				continue; 
+			} 	
+			if (!strcmp(pc->name,name)) { 
+				printk("kmem_cache_create: duplicate cache %s\n",name); 
+				up(&cache_chain_sem); 
+				BUG(); 
+			}	
 		}
 	}
 
@@ -1878,6 +1913,7 @@
 		unsigned long	num_objs;
 		unsigned long	active_slabs = 0;
 		unsigned long	num_slabs;
+		const char *name; 
 		cachep = list_entry(p, kmem_cache_t, next);
 
 		spin_lock_irq(&cachep->spinlock);
@@ -1906,8 +1942,15 @@
 		num_slabs+=active_slabs;
 		num_objs = num_slabs*cachep->num;
 
+		name = cachep->name; 
+		{
+		char tmp; 
+		if (__get_user(tmp, name)) 
+			name = "broken"; 
+		} 	
+
 		len += sprintf(page+len, "%-17s %6lu %6lu %6u %4lu %4lu %4u",
-			cachep->name, active_objs, num_objs, cachep->objsize,
+			name, active_objs, num_objs, cachep->objsize,
 			active_slabs, num_slabs, (1<<cachep->gfporder));
 
 #if STATS
--- linux-2.5.3-work/drivers/scsi/scsi.c-SLABNAME	Tue Jan 15 17:53:29 2002
+++ linux-2.5.3-work/drivers/scsi/scsi.c	Thu Jan 31 01:35:16 2002
@@ -87,13 +87,16 @@
 
 struct scsi_host_sg_pool {
 	int size;
+	char *name; 
 	kmem_cache_t *slab;
 	mempool_t *pool;
 };
 
-static const int scsi_host_sg_pool_sizes[SG_MEMPOOL_NR] = { 8, 16, 32, 64, MAX_PHYS_SEGMENTS };
-struct scsi_host_sg_pool scsi_sg_pools[SG_MEMPOOL_NR];
-
+#define SP(x) { x, "sgpool-" #x } 
+struct scsi_host_sg_pool scsi_sg_pools[SG_MEMPOOL_NR] = { 
+	SP(8), SP(16), SP(32), SP(64), SP(MAX_PHYS_SEGMENTS)
+}; 	
+#undef SP 	
 /*
    static const char RCSid[] = "$Header: /vger/u4/cvs/linux/drivers/scsi/scsi.c,v 1.38 1997/01/19 23:07:18 davem Exp $";
  */
@@ -2489,7 +2492,6 @@
 static int __init init_scsi(void)
 {
 	struct proc_dir_entry *generic;
-	char name[16];
 	int i;
 
 	printk(KERN_INFO "SCSI subsystem driver " REVISION "\n");
@@ -2499,18 +2501,15 @@
 	 */
 	for (i = 0; i < SG_MEMPOOL_NR; i++) {
 		struct scsi_host_sg_pool *sgp = scsi_sg_pools + i;
-		int size = scsi_host_sg_pool_sizes[i] * sizeof(struct scatterlist);
+		int size = sgp->size * sizeof(struct scatterlist);
 
-		snprintf(name, sizeof(name) - 1, "sgpool-%d", scsi_host_sg_pool_sizes[i]);
-		sgp->slab = kmem_cache_create(name, size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+		sgp->slab = kmem_cache_create(sgp->name, size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!sgp->slab)
 			panic("SCSI: can't init sg slab\n");
 
 		sgp->pool = mempool_create(SG_MEMPOOL_SIZE, scsi_pool_alloc, scsi_pool_free, sgp->slab);
 		if (!sgp->pool)
 			panic("SCSI: can't init sg mempool\n");
-
-		sgp->size = size;
 	}
 
 	/*
