Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290625AbSAYTt0>; Fri, 25 Jan 2002 14:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290711AbSAYTtR>; Fri, 25 Jan 2002 14:49:17 -0500
Received: from ns.suse.de ([213.95.15.193]:56074 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290625AbSAYTtM>;
	Fri, 25 Jan 2002 14:49:12 -0500
Date: Fri, 25 Jan 2002 20:49:11 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Levon <movement@marcelothewonderpenguin.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
Message-ID: <20020125204911.A17190@wotan.suse.de>
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 10:08:56AM -0800, Linus Torvalds wrote:
> 
> On Fri, 25 Jan 2002, John Levon wrote:
> >
> > please apply this too then.
> 
> I would prefer instead just avoiding the copy altogether, and just save
> the name pointer - with no length restrictions.
> 
> Right now the code has the comment
> 
>    /* Copy name over so we don't have problems with unloaded modules */
> 
> but that was written before "kmem_cache_destroy()" existed, and we should
> long ago have fixed any modules that don't properly destroy their caches
> when they exit (and yes, I know the difference between "should" and "did",
> but that's not an excuse for a bad interface).

This patch implements your suggestion. It works for me, but I haven't audited
the whole tree if they do kmem_cache_destroy as needed. It tries to avoid
oopses for unmapped or bogus names on /proc/slabinfo reading at least. Also 
fixes an warning in slab.c

-Andi

Index: mm/slab.c
===================================================================
RCS file: /cvs/linux/mm/slab.c,v
retrieving revision 1.66
diff -u -u -r1.66 slab.c
--- mm/slab.c	2002/01/08 16:00:20	1.66
+++ mm/slab.c	2002/01/25 19:47:20
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
+#define CN(x) { x, x ## "(DMA)" }
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
@@ -810,11 +832,8 @@
 		struct list_head *p;
 
 		list_for_each(p, &cache_chain) {
-			kmem_cache_t *pc = list_entry(p, kmem_cache_t, next);
-
-			/* The name field is constant - no lock needed. */
-			if (!strcmp(pc->name, name))
-				BUG();
+			kmem_cache_t *pc;
+			pc = list_entry(p, kmem_cache_t, next);
 		}
 	}
 
@@ -1878,6 +1897,7 @@
 		unsigned long	num_objs;
 		unsigned long	active_slabs = 0;
 		unsigned long	num_slabs;
+		const char *name; 
 		cachep = list_entry(p, kmem_cache_t, next);
 
 		spin_lock_irq(&cachep->spinlock);
@@ -1906,8 +1926,15 @@
 		num_slabs+=active_slabs;
 		num_objs = num_slabs*cachep->num;
 
+		name = cachep->name; 
+		{
+		char tmp; 
+		if (get_user(tmp, name)) 
+			name = "broken"; 
+		} 	
+
 		len += sprintf(page+len, "%-17s %6lu %6lu %6u %4lu %4lu %4u",
-			cachep->name, active_objs, num_objs, cachep->objsize,
+			name, active_objs, num_objs, cachep->objsize,
 			active_slabs, num_slabs, (1<<cachep->gfporder));
 
 #if STATS


