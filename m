Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290741AbSA3XaL>; Wed, 30 Jan 2002 18:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290742AbSA3X3w>; Wed, 30 Jan 2002 18:29:52 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:49554 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290741AbSA3X3r>; Wed, 30 Jan 2002 18:29:47 -0500
Date: Thu, 31 Jan 2002 00:29:37 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Slab cache name fixes / reiserfs boot bug fix.
Message-ID: <20020131002937.A1372@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

As discussed earlier this patch cleans up the way the names of slab
caches are stored. The caller is now expected to keep the storage,
instead of copying and arbitarily imposing a name length limit on the
slab names. This fixes the reiserfs boot time BUG() that is still in 2.5.3.

I had to fix some callers that were creating cache names on the stack,
that is why the patch is a bit larger. 

I didn't audit the complete tree that modules do always destroy their caches
on unloading, when they do not do it this patch will hopefully detect it
on the next cat /proc/slabinfo (and otherwise not care as it was the situation
before). 

I addressed all the criticisms that came to earlier versions of the patch,
except for the one that proposed to "strdup" the name because that would have
needed a custom allocator just for that (kmem_cache_create cannot use kmalloc)

Patch against 2.5.3. Please apply.

Thanks,
-Andi


--- linux-2.5.3-work/fs/bio.c-SLABNAME	Tue Jan 15 17:53:31 2002
+++ linux-2.5.3-work/fs/bio.c	Wed Jan 30 23:50:57 2002
@@ -45,6 +45,7 @@
  * unsigned short
  */
 static const int bvec_pool_sizes[BIOVEC_NR_POOLS] = { 1, 4, 16, 64, 128, 256 };
+static char bvec_pool_names[BIOVEC_NR_POOLS][16];
 
 #define BIO_MAX_PAGES	(bvec_pool_sizes[BIOVEC_NR_POOLS - 1])
 
@@ -452,20 +453,20 @@
 
 static void __init biovec_init_pool(void)
 {
-	char name[16];
 	int i, size;
 
 	memset(&bvec_array, 0, sizeof(bvec_array));
 
 	for (i = 0; i < BIOVEC_NR_POOLS; i++) {
 		struct biovec_pool *bp = bvec_array + i;
+		char *name = bvec_pool_names[i]; 
 
 		size = bvec_pool_sizes[i] * sizeof(struct bio_vec);
 
 		printk("biovec: init pool %d, %d entries, %d bytes\n", i,
 						bvec_pool_sizes[i], size);
 
-		snprintf(name, sizeof(name) - 1,"biovec-%d",bvec_pool_sizes[i]);
+		sprintf(name, "biovec-%d",bvec_pool_sizes[i]);
 		bp->slab = kmem_cache_create(name, size, 0,
 						SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!bp->slab)
--- linux-2.5.3-work/mm/slab.c-SLABNAME	Tue Jan 15 17:53:36 2002
+++ linux-2.5.3-work/mm/slab.c	Thu Jan 31 00:22:13 2002
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
+	const char			*name;
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
@@ -353,6 +352,26 @@
 	{131072,	NULL, NULL},
 	{     0,	NULL, NULL}
 };
+/* Must match cache_sizes above. Out of line to keep cache footprint low. */
+#define CN(x) { x, x " (DMA)" }
+static char cache_names[][2][18] = { 
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
@@ -437,7 +456,6 @@
 void __init kmem_cache_sizes_init(void)
 {
 	cache_sizes_t *sizes = cache_sizes;
-	char name[20];
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
 	 * page orders on machines with more than 32MB of memory.
@@ -450,9 +468,9 @@
 		 * eliminates "false sharing".
 		 * Note for systems short on memory removing the alignment will
 		 * allow tighter packing of the smaller caches. */
-		sprintf(name,"size-%Zd",sizes->cs_size);
 		if (!(sizes->cs_cachep =
-			kmem_cache_create(name, sizes->cs_size,
+			kmem_cache_create(cache_names[sizes-cache_sizes][0], 
+					  sizes->cs_size,
 					0, SLAB_HWCACHE_ALIGN, NULL, NULL))) {
 			BUG();
 		}
@@ -462,9 +480,10 @@
 			offslab_limit = sizes->cs_size-sizeof(slab_t);
 			offslab_limit /= 2;
 		}
-		sprintf(name, "size-%Zd(DMA)",sizes->cs_size);
-		sizes->cs_dmacachep = kmem_cache_create(name, sizes->cs_size, 0,
-			      SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
+		sizes->cs_dmacachep = kmem_cache_create(
+		    cache_names[sizes-cache_sizes][1], 
+			sizes->cs_size, 0,
+			SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!sizes->cs_dmacachep)
 			BUG();
 		sizes++;
@@ -604,6 +623,11 @@
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
@@ -632,7 +656,6 @@
 	 * Sanity checks... these are all serious usage bugs.
 	 */
 	if ((!name) ||
-		((strlen(name) >= CACHE_NAMELEN - 1)) ||
 		in_interrupt() ||
 		(size < BYTES_PER_WORD) ||
 		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
@@ -797,8 +820,7 @@
 		cachep->slabp_cache = kmem_find_general_cachep(slab_size,0);
 	cachep->ctor = ctor;
 	cachep->dtor = dtor;
-	/* Copy name over so we don't have problems with unloaded modules */
-	strcpy(cachep->name, name);
+	cachep->name = name;
 
 #ifdef CONFIG_SMP
 	if (g_cpucache_up)
@@ -811,10 +833,20 @@
 
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
 
@@ -1878,6 +1910,7 @@
 		unsigned long	num_objs;
 		unsigned long	active_slabs = 0;
 		unsigned long	num_slabs;
+		const char *name; 
 		cachep = list_entry(p, kmem_cache_t, next);
 
 		spin_lock_irq(&cachep->spinlock);
@@ -1906,8 +1939,15 @@
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
--- linux-2.5.3-work/include/net/neighbour.h-SLABNAME	Wed Jan 30 22:44:34 2002
+++ linux-2.5.3-work/include/net/neighbour.h	Wed Jan 30 23:37:54 2002
@@ -147,7 +147,7 @@
 	int			(*pconstructor)(struct pneigh_entry *);
 	void			(*pdestructor)(struct pneigh_entry *);
 	void			(*proxy_redo)(struct sk_buff *skb);
-	char			*id;
+	char			id[20];
 	struct neigh_parms	parms;
 	/* HACK. gc_* shoul follow parms without a gap! */
 	int			gc_interval;
--- linux-2.5.3-work/drivers/scsi/scsi.c-SLABNAME	Tue Jan 15 17:53:29 2002
+++ linux-2.5.3-work/drivers/scsi/scsi.c	Thu Jan 31 00:08:06 2002
@@ -93,6 +93,7 @@
 
 static const int scsi_host_sg_pool_sizes[SG_MEMPOOL_NR] = { 8, 16, 32, 64, MAX_PHYS_SEGMENTS };
 struct scsi_host_sg_pool scsi_sg_pools[SG_MEMPOOL_NR];
+static char scsi_host_sg_names[SG_MEMPOOL_NR][18]; 
 
 /*
    static const char RCSid[] = "$Header: /vger/u4/cvs/linux/drivers/scsi/scsi.c,v 1.38 1997/01/19 23:07:18 davem Exp $";
@@ -2489,7 +2490,6 @@
 static int __init init_scsi(void)
 {
 	struct proc_dir_entry *generic;
-	char name[16];
 	int i;
 
 	printk(KERN_INFO "SCSI subsystem driver " REVISION "\n");
@@ -2498,10 +2498,11 @@
 	 * setup sg memory pools
 	 */
 	for (i = 0; i < SG_MEMPOOL_NR; i++) {
+		char *name = scsi_host_sg_names[i]; 
 		struct scsi_host_sg_pool *sgp = scsi_sg_pools + i;
 		int size = scsi_host_sg_pool_sizes[i] * sizeof(struct scatterlist);
 
-		snprintf(name, sizeof(name) - 1, "sgpool-%d", scsi_host_sg_pool_sizes[i]);
+		sprintf(name, "sgpool-%d", scsi_host_sg_pool_sizes[i]);
 		sgp->slab = kmem_cache_create(name, size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!sgp->slab)
 			panic("SCSI: can't init sg slab\n");
