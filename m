Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSHCTY0>; Sat, 3 Aug 2002 15:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSHCTY0>; Sat, 3 Aug 2002 15:24:26 -0400
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:19104 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S316548AbSHCTYH>; Sat, 3 Aug 2002 15:24:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slablru for linux-2.5 bk tree
Date: Sat, 3 Aug 2002 15:27:14 -0400
X-Mailer: KMail [version 1.4]
References: <Pine.LNX.4.44.0207282324340.872-100000@home.transmeta.com> <200208011942.49342.tomlins@cam.org> <3D49C951.AB7C527E@zip.com.au>
In-Reply-To: <3D49C951.AB7C527E@zip.com.au>
Cc: Andrew Morton <akpm@zip.com.au>, Rik van Riel <riel@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208031527.15093.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here the slablru patch ported to 2.5.30.  Thanks go out to Andrew Morton for
his gentle help improving the patch, to  Craig Kulesa for the initial port to 
2.5-full-rmap and to Rik van Riel for proding me to move the pages to the lru.

This version changes a few things
1.  The api for kmem_cache_create was changed (2.5 only) to pass the pruner 
     callback (Andrew's suggestion).  This means we can scrap the kmem_set_pruner 
     function.
2.  The locking in two functions was changed to protect us in interrupts - there
      was a small window for deadlocks (Andrew again).  
3.  I also added shmem to the list of caches using the age_icache_memory callback. 
     The inodes will get pruned without it but at a much slower (and unfair) rate.
4.  The patch now handles caches where gfporder != 0 more fairly.  It now uses
     the first page of these slabs for reference bit seting and testing.  Older versions
     of the patch pruned these slabs too quickly.
5.  The inactive list is used to store slab pages.  With the aa+rmap vm this works 
     more effectively.
6.  It contains the fixes found with slablru for 2.5-full-rmap for SMP and dquota.

I have also updated the 2.4 version of the patch which can be pulled from
bk://casa.dyndns.org:3334/linux-2.4-rmap
Rik can we get this into your 2.4 rmap tree?

I tested with 2.5.29+ up to Trond's RCP fix, since 2.5.30 stalls my box at 
boot (It seems I get 'impossible' results from ide dma...).

This is posted so the patch can get wider testing.   Once Andrew, Rik and friends
are happy we can push to towards Linus.

Comments,
Ed Tomlinson

--------
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.484   -> 1.487  
#	       fs/nfs/read.c	1.15    -> 1.16   
#	      fs/ufs/super.c	1.25    -> 1.27   
#	net/ipv4/netfilter/ip_conntrack_core.c	1.10    -> 1.11   
#	     fs/adfs/super.c	1.18    -> 1.20   
#	      kernel/ksyms.c	1.111   -> 1.113  
#	     fs/sysv/inode.c	1.22    -> 1.24   
#	         fs/buffer.c	1.136   -> 1.137  
#	   fs/jffs2/malloc.c	1.5     -> 1.6    
#	net/core/neighbour.c	1.7     -> 1.8    
#	drivers/ieee1394/eth1394.c	1.1     -> 1.2    
#	     fs/jbd/revoke.c	1.9     -> 1.10   
#	       kernel/fork.c	1.57    -> 1.58   
#	drivers/block/ll_rw_blk.c	1.98    -> 1.99   
#	          fs/fcntl.c	1.12    -> 1.13   
#	          fs/dquot.c	1.44    -> 1.45   
#	    fs/smbfs/inode.c	1.27    -> 1.29   
#	         fs/dcache.c	1.29    -> 1.31   
#	         mm/vmscan.c	1.88    -> 1.89   
#	  net/ipv4/af_inet.c	1.14    -> 1.15   
#	     fs/ntfs/super.c	1.117   -> 1.119  
#	    fs/jbd/journal.c	1.20    -> 1.21   
#	     fs/devfs/base.c	1.48    -> 1.49   
#	   net/core/skbuff.c	1.13    -> 1.14   
#	net/bluetooth/af_bluetooth.c	1.4     -> 1.5    
#	      fs/nfs/write.c	1.24    -> 1.25   
#	  drivers/md/raid5.c	1.37    -> 1.38   
#	    net/ipv6/route.c	1.8     -> 1.9    
#	 arch/i386/mm/init.c	1.23    -> 1.24   
#	    lib/radix-tree.c	1.5     -> 1.6    
#	drivers/ieee1394/ieee1394_core.c	1.15    -> 1.16   
#	      fs/efs/super.c	1.12    -> 1.14   
#	net/decnet/dn_table.c	1.3     -> 1.4    
#	  net/ipv6/ip6_fib.c	1.4     -> 1.5    
#	      net/ipv4/tcp.c	1.25    -> 1.26   
#	        fs/dnotify.c	1.5     -> 1.6    
#	arch/cris/drivers/usb-host.c	1.10    -> 1.11   
#	     fs/qnx4/inode.c	1.21    -> 1.23   
#	    fs/jffs2/super.c	1.18    -> 1.20   
#	       fs/char_dev.c	1.4     -> 1.5    
#	     fs/proc/inode.c	1.14    -> 1.16   
#	      fs/hfs/super.c	1.17    -> 1.19   
#	       kernel/user.c	1.4     -> 1.5    
#	        net/socket.c	1.24    -> 1.25   
#	   fs/nfs/pagelist.c	1.5     -> 1.6    
#	 net/ipv4/inetpeer.c	1.3     -> 1.4    
#	     kernel/signal.c	1.24    -> 1.25   
#	      fs/bfs/inode.c	1.18    -> 1.20   
#	          mm/shmem.c	1.69    -> 1.70   
#	arch/arm/mach-arc/mm.c	1.5     -> 1.6    
#	      net/atm/clip.c	1.4     -> 1.5    
#	      fs/fat/inode.c	1.42    -> 1.44   
#	 fs/reiserfs/super.c	1.50    -> 1.52   
#	      fs/jfs/super.c	1.19    -> 1.21   
#	include/linux/slab.h	1.12    -> 1.14   
#	     net/ipv4/ipmr.c	1.9     -> 1.10   
#	 net/ipv4/fib_hash.c	1.2     -> 1.3    
#	    net/ipx/af_spx.c	1.9     -> 1.10   
#	    fs/ncpfs/inode.c	1.27    -> 1.29   
#	     fs/coda/inode.c	1.20    -> 1.22   
#	 drivers/scsi/scsi.c	1.34    -> 1.35   
#	    fs/minix/inode.c	1.26    -> 1.28   
#	 net/ipv6/af_inet6.c	1.9     -> 1.10   
#	     fs/hpfs/super.c	1.17    -> 1.19   
#	            fs/bio.c	1.22    -> 1.23   
#	 fs/jffs/inode-v23.c	1.35    -> 1.36   
#	  net/unix/af_unix.c	1.24    -> 1.25   
#	      fs/namespace.c	1.27    -> 1.28   
#	      fs/udf/super.c	1.25    -> 1.27   
#	     fs/ext2/super.c	1.28    -> 1.30   
#	    fs/romfs/inode.c	1.21    -> 1.23   
#	     fs/affs/super.c	1.26    -> 1.28   
#	     net/core/sock.c	1.10    -> 1.11   
#	           mm/slab.c	1.26    -> 1.29   
#	      fs/nfs/inode.c	1.47    -> 1.49   
#	fs/intermezzo/dcache.c	1.5     -> 1.6    
#	fs/freevxfs/vxfs_super.c	1.10    -> 1.12   
#	drivers/usb/host/uhci-hcd.c	1.9     -> 1.10   
#	     fs/ext3/super.c	1.28    -> 1.30   
#	           mm/rmap.c	1.7     -> 1.8    
#	          fs/locks.c	1.23    -> 1.24   
#	net/decnet/dn_route.c	1.4     -> 1.5    
#	    fs/isofs/inode.c	1.23    -> 1.25   
#	          fs/inode.c	1.67    -> 1.69   
#	    net/ipv4/route.c	1.16    -> 1.17   
#	include/linux/dcache.h	1.14    -> 1.15   
#	  fs/smbfs/request.c	1.1     -> 1.2    
#	      fs/block_dev.c	1.78    -> 1.79   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/01	ed@oscar.et.ca	1.485
# slablru_30-2a
# --------------------------------------------
#
diff -Nru a/include/linux/slab.h b/include/linux/slab.h
--- a/include/linux/slab.h	Fri Aug  2 15:50:10 2002
+++ b/include/linux/slab.h	Fri Aug  2 15:50:10 2002
@@ -49,12 +49,32 @@
 extern void kmem_cache_init(void);
 extern void kmem_cache_sizes_init(void);
 
+typedef int (*kmem_pruner_t)(kmem_cache_t *, int, int);
+
 extern kmem_cache_t *kmem_find_general_cachep(size_t, int gfpflags);
-extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long,
+extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long, 
+				       kmem_pruner_t,
 				       void (*)(void *, kmem_cache_t *, unsigned long),
 				       void (*)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
+
+extern int kmem_do_prunes(int);
+extern int kmem_count_page(struct page *, int);
+#define kmem_touch_page(addr)                 SetPageReferenced(virt_to_page(addr));
+
+/* shrink a slab */
+extern int kmem_shrink_slab(struct page *);
+
+/* dcache prune ( defined in linux/fs/dcache.c) */
+extern int age_dcache_memory(kmem_cache_t *, int, int);
+
+/* icache prune (defined in linux/fs/inode.c) */
+extern int age_icache_memory(kmem_cache_t *, int, int);
+
+/* quota cache prune (defined in linux/fs/dquot.c) */
+extern int age_dqcache_memory(kmem_cache_t *, int, int);
+
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
 extern unsigned int kmem_cache_size(kmem_cache_t *);
diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Fri Aug  2 15:50:11 2002
+++ b/mm/slab.c	Fri Aug  2 15:50:11 2002
@@ -215,6 +215,8 @@
 	kmem_cache_t		*slabp_cache;
 	unsigned int		growing;
 	unsigned int		dflags;		/* dynamic flags */
+	kmem_pruner_t		pruner;		/* shrink callback */
+	int 			count;		/* count used to trigger shrink */
 
 	/* constructor func */
 	void (*ctor)(void *, kmem_cache_t *, unsigned long);
@@ -253,10 +255,12 @@
 
 /* c_dflags (dynamic flags). Need to hold the spinlock to access this member */
 #define	DFLGS_GROWN	0x000001UL	/* don't reap a recently grown */
+#define	DFLGS_NONLRU	0x000002UL	/* there are reciently allocated 
+					   non lru pages in this cache */
 
 #define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
 #define	OPTIMIZE(x)	((x)->flags & CFLGS_OPTIMIZE)
-#define	GROWN(x)	((x)->dlags & DFLGS_GROWN)
+#define	GROWN(x)	((x)->dflags & DFLGS_GROWN)
 
 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
@@ -412,6 +416,59 @@
 static void enable_cpucache (kmem_cache_t *cachep);
 static void enable_all_cpucaches (void);
 #endif
+ 
+/* 
+ * Used by shrink_cache to determine caches that need pruning.
+ */
+int kmem_count_page(struct page *page, int ref)
+{
+	kmem_cache_t *cachep = GET_PAGE_CACHE(page);
+	slab_t *slabp = GET_PAGE_SLAB(page);
+	int ret = 0;
+	if (cachep->gfporder) {
+		struct page *bpage = virt_to_page(slabp->s_mem - slabp->colouroff);
+		if (bpage != page)
+			return 0;
+	}
+	spin_lock_irq(&cachep->spinlock);
+	if (cachep->pruner != NULL) {
+		cachep->count += slabp->inuse;
+		ret = !slabp->inuse;
+	} else 
+		ret = !ref && !slabp->inuse;
+	spin_unlock_irq(&cachep->spinlock);
+	return ret;
+}
+
+
+/* Call the prune functions to age pruneable caches */
+int kmem_do_prunes(int gfp_mask) 
+{
+	struct list_head *p;
+	int nr;
+
+        if (gfp_mask & __GFP_WAIT)
+                down(&cache_chain_sem);
+        else
+                if (down_trylock(&cache_chain_sem))
+                        return 0;
+
+        list_for_each(p,&cache_chain) {
+                kmem_cache_t *cachep = list_entry(p, kmem_cache_t, next);
+		if (cachep->pruner != NULL) {
+			spin_lock_irq(&cachep->spinlock);
+			nr = cachep->count;
+			cachep->count = 0;
+			spin_unlock_irq(&cachep->spinlock);
+			if (nr > 0)
+				(*cachep->pruner)(cachep, nr, gfp_mask);
+
+		}
+	}
+        up(&cache_chain_sem);
+	return 1;
+}
+
 
 /* Cal the num objs, wastage, and bytes left over for a given slab size. */
 static void kmem_cache_estimate (unsigned long gfporder, size_t size,
@@ -451,8 +508,7 @@
 
 	kmem_cache_estimate(0, cache_cache.objsize, 0,
 			&left_over, &cache_cache.num);
-	if (!cache_cache.num)
-		BUG();
+	BUG_ON(!cache_cache.num);
 
 	cache_cache.colour = left_over/cache_cache.colour_off;
 	cache_cache.colour_next = 0;
@@ -477,12 +533,10 @@
 		 * eliminates "false sharing".
 		 * Note for systems short on memory removing the alignment will
 		 * allow tighter packing of the smaller caches. */
-		if (!(sizes->cs_cachep =
+		BUG_ON(!(sizes->cs_cachep =
 			kmem_cache_create(cache_names[sizes-cache_sizes].name, 
-					  sizes->cs_size,
-					0, SLAB_HWCACHE_ALIGN, NULL, NULL))) {
-			BUG();
-		}
+				sizes->cs_size,
+				0, SLAB_HWCACHE_ALIGN, NULL, NULL, NULL)));
 
 		/* Inc off-slab bufctl limit until the ceiling is hit. */
 		if (!(OFF_SLAB(sizes->cs_cachep))) {
@@ -490,11 +544,10 @@
 			offslab_limit /= 2;
 		}
 		sizes->cs_dmacachep = kmem_cache_create(
-		    cache_names[sizes-cache_sizes].name_dma, 
+			cache_names[sizes-cache_sizes].name_dma, 
 			sizes->cs_size, 0,
-			SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
-		if (!sizes->cs_dmacachep)
-			BUG();
+			SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
+		BUG_ON(!sizes->cs_dmacachep);
 		sizes++;
 	} while (sizes->cs_size);
 }
@@ -510,7 +563,9 @@
 
 __initcall(kmem_cpucache_init);
 
-/* Interface to system's page allocator. No need to hold the cache-lock.
+/*
+ * Interface to system's page allocator. No need to hold the cache-lock.
+ * Call with pagemap_lru_lock held
  */
 static inline void * kmem_getpages (kmem_cache_t *cachep, unsigned long flags)
 {
@@ -532,7 +587,8 @@
 	return addr;
 }
 
-/* Interface to system's page release. */
+/* Interface to system's page release. 
+ * Normally called with pagemap_lru_lock held */
 static inline void kmem_freepages (kmem_cache_t *cachep, void *addr)
 {
 	unsigned long i = (1<<cachep->gfporder);
@@ -545,6 +601,10 @@
 	 */
 	while (i--) {
 		ClearPageSlab(page);
+		if (TestClearPageLRU(page))
+			del_page_from_inactive_list(page);
+		ClearPageReferenced(page);
+		ClearPageActive(page);
 		page++;
 	}
 	free_pages((unsigned long)addr, cachep->gfporder);
@@ -577,9 +637,11 @@
 }
 #endif
 
+
 /* Destroy all the objs in a slab, and release the mem back to the system.
  * Before calling the slab must have been unlinked from the cache.
  * The cache-lock is not held/needed.
+ * pagemap_lru_lock should be held for kmem_freepages
  */
 static void kmem_slab_destroy (kmem_cache_t *cachep, slab_t *slabp)
 {
@@ -593,11 +655,9 @@
 			void* objp = slabp->s_mem+cachep->objsize*i;
 #if DEBUG
 			if (cachep->flags & SLAB_RED_ZONE) {
-				if (*((unsigned long*)(objp)) != RED_MAGIC1)
-					BUG();
-				if (*((unsigned long*)(objp + cachep->objsize
-						-BYTES_PER_WORD)) != RED_MAGIC1)
-					BUG();
+				BUG_ON(*((unsigned long*)(objp)) != RED_MAGIC1);
+				BUG_ON(*((unsigned long*)(objp + cachep->objsize
+					-BYTES_PER_WORD)) != RED_MAGIC1);
 				objp += BYTES_PER_WORD;
 			}
 #endif
@@ -607,9 +667,8 @@
 			if (cachep->flags & SLAB_RED_ZONE) {
 				objp -= BYTES_PER_WORD;
 			}	
-			if ((cachep->flags & SLAB_POISON)  &&
-				kmem_check_poison_obj(cachep, objp))
-				BUG();
+			BUG_ON((cachep->flags & SLAB_POISON)  &&
+				kmem_check_poison_obj(cachep, objp));
 #endif
 		}
 	}
@@ -625,6 +684,7 @@
  * @size: The size of objects to be created in this cache.
  * @offset: The offset to use within the page.
  * @flags: SLAB flags
+ * @thepruner: a callback to prune entries for ageable caches
  * @ctor: A constructor for the objects.
  * @dtor: A destructor for the objects.
  *
@@ -654,7 +714,8 @@
  */
 kmem_cache_t *
 kmem_cache_create (const char *name, size_t size, size_t offset,
-	unsigned long flags, void (*ctor)(void*, kmem_cache_t *, unsigned long),
+	unsigned long flags, kmem_pruner_t thepruner,
+	void (*ctor)(void*, kmem_cache_t *, unsigned long),
 	void (*dtor)(void*, kmem_cache_t *, unsigned long))
 {
 	const char *func_nm = KERN_ERR "kmem_create: ";
@@ -664,13 +725,12 @@
 	/*
 	 * Sanity checks... these are all serious usage bugs.
 	 */
-	if ((!name) ||
+	BUG_ON((!name) ||
 		in_interrupt() ||
 		(size < BYTES_PER_WORD) ||
 		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
 		(dtor && !ctor) ||
-		(offset < 0 || offset > size))
-			BUG();
+		(offset < 0 || offset > size));
 
 #if DEBUG
 	if ((flags & SLAB_DEBUG_INITIAL) && !ctor) {
@@ -700,8 +760,7 @@
 	 * Always checks flags, a caller might be expecting debug
 	 * support which isn't available.
 	 */
-	if (flags & ~CREATE_MASK)
-		BUG();
+	BUG_ON(flags & ~CREATE_MASK);
 
 	/* Get cache's description obj. */
 	cachep = (kmem_cache_t *) kmem_cache_alloc(&cache_cache, SLAB_KERNEL);
@@ -816,6 +875,8 @@
 		flags |= CFLGS_OPTIMIZE;
 
 	cachep->flags = flags;
+	cachep->pruner = thepruner;
+	cachep->count = 0;
 	cachep->gfpflags = 0;
 	if (flags & SLAB_CACHE_DMA)
 		cachep->gfpflags |= GFP_DMA;
@@ -909,8 +970,7 @@
 	func(arg);
 	local_irq_enable();
 
-	if (smp_call_function(func, arg, 1, 1))
-		BUG();
+	BUG_ON(smp_call_function(func, arg, 1, 1));
 }
 typedef struct ccupdate_struct_s
 {
@@ -958,15 +1018,15 @@
 #define drain_cpu_caches(cachep)	do { } while (0)
 #endif
 
-static int __kmem_cache_shrink(kmem_cache_t *cachep)
+
+/* 
+ * Worker function for freeing slab caches; returns number of pages freed.
+ * Caller must hold pagemap_lru_lock
+ */
+static int __kmem_cache_shrink_locked(kmem_cache_t *cachep)
 {
 	slab_t *slabp;
-	int ret;
-
-	drain_cpu_caches(cachep);
-
-	spin_lock_irq(&cachep->spinlock);
-
+	int ret = 0;
 	/* If the cache is growing, stop shrinking. */
 	while (!cachep->growing) {
 		struct list_head *p;
@@ -977,17 +1037,32 @@
 
 		slabp = list_entry(cachep->slabs_free.prev, slab_t, list);
 #if DEBUG
-		if (slabp->inuse)
-			BUG();
+		BUG_ON(slabp->inuse);
 #endif
 		list_del(&slabp->list);
 
 		spin_unlock_irq(&cachep->spinlock);
 		kmem_slab_destroy(cachep, slabp);
+		ret++;
 		spin_lock_irq(&cachep->spinlock);
 	}
-	ret = !list_empty(&cachep->slabs_full) || !list_empty(&cachep->slabs_partial);
+	return ret;
+}
+	
+
+static int __kmem_cache_shrink(kmem_cache_t *cachep)
+{
+	int ret;
+
+	drain_cpu_caches(cachep);
+
+	spin_lock(&pagemap_lru_lock);
+	spin_lock_irq(&cachep->spinlock);
+	__kmem_cache_shrink_locked(cachep);
+	ret = !list_empty(&cachep->slabs_full) || 
+		!list_empty(&cachep->slabs_partial);
 	spin_unlock_irq(&cachep->spinlock);
+	spin_unlock(&pagemap_lru_lock);
 	return ret;
 }
 
@@ -1000,12 +1075,46 @@
  */
 int kmem_cache_shrink(kmem_cache_t *cachep)
 {
-	if (!cachep || in_interrupt() || !is_chained_kmem_cache(cachep))
-		BUG();
-
+	BUG_ON(!cachep || in_interrupt() || !is_chained_kmem_cache(cachep));
 	return __kmem_cache_shrink(cachep);
 }
 
+
+/* 
+ * Used by shrnk_cache to try to shrink a cache.  The method
+ * we use to shrink depends on if we have added pages since
+ * the last time we shrunk this cache. 
+ * - shrink works and we return the pages shrunk
+ * - shrink fails because the slab is in use, we return 0
+ * called with pagemap_lru_lock held.
+ */
+int kmem_shrink_slab(struct page *page)
+{
+	kmem_cache_t *cachep = GET_PAGE_CACHE(page);
+	slab_t *slabp = GET_PAGE_SLAB(page);
+
+	spin_lock_irq(&cachep->spinlock);
+	if (!slabp->inuse) {
+	 	if (!cachep->growing) {
+			if (cachep->dflags & DFLGS_NONLRU) {
+				int nr = __kmem_cache_shrink_locked(cachep);
+				cachep->dflags &= ~DFLGS_NONLRU;
+				spin_unlock_irq(&cachep->spinlock);
+				return nr<<cachep->gfporder;
+			} else {
+				list_del(&slabp->list);
+				spin_unlock_irq(&cachep->spinlock);
+				kmem_slab_destroy(cachep, slabp);
+				return 1<<cachep->gfporder;
+			}
+			BUG_ON(PageActive(page));
+		}
+	}
+	spin_unlock_irq(&cachep->spinlock);
+	return 0; 
+}
+
+
 /**
  * kmem_cache_destroy - delete a cache
  * @cachep: the cache to destroy
@@ -1023,8 +1132,7 @@
  */
 int kmem_cache_destroy (kmem_cache_t * cachep)
 {
-	if (!cachep || in_interrupt() || cachep->growing)
-		BUG();
+	BUG_ON(!cachep || in_interrupt() || cachep->growing);
 
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
@@ -1112,11 +1220,9 @@
 			/* need to poison the objs */
 			kmem_poison_obj(cachep, objp);
 		if (cachep->flags & SLAB_RED_ZONE) {
-			if (*((unsigned long*)(objp)) != RED_MAGIC1)
-				BUG();
-			if (*((unsigned long*)(objp + cachep->objsize -
-					BYTES_PER_WORD)) != RED_MAGIC1)
-				BUG();
+			BUG_ON(*((unsigned long*)(objp)) != RED_MAGIC1);
+			BUG_ON(*((unsigned long*)(objp + cachep->objsize -
+				BYTES_PER_WORD)) != RED_MAGIC1);
 		}
 #endif
 		slab_bufctl(slabp)[i] = i+1;
@@ -1135,15 +1241,14 @@
 	struct page	*page;
 	void		*objp;
 	size_t		 offset;
-	unsigned int	 i, local_flags;
+	unsigned int	 i, local_flags, locked = 0;
 	unsigned long	 ctor_flags;
 	unsigned long	 save_flags;
 
 	/* Be lazy and only check for valid flags here,
  	 * keeping it out of the critical path in kmem_cache_alloc().
 	 */
-	if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
-		BUG();
+	BUG_ON(flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW));
 	if (flags & SLAB_NO_GROW)
 		return 0;
 
@@ -1153,8 +1258,7 @@
 	 * in kmem_cache_alloc(). If a caller is seriously mis-behaving they
 	 * will eventually be caught here (where it matters).
 	 */
-	if (in_interrupt() && (flags & __GFP_WAIT))
-		BUG();
+	BUG_ON(in_interrupt() && (flags & __GFP_WAIT));
 
 	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
 	local_flags = (flags & SLAB_LEVEL_MASK);
@@ -1192,6 +1296,19 @@
 	if (!(objp = kmem_getpages(cachep, flags)))
 		goto failed;
 
+	/* 
+	 * We want the pagemap_lru_lock, in UP spin locks to not 
+	 * protect us in interrupt context...  In SMP they do but,
+	 * optimizating for speed, we process if we do not get it. 
+	 */
+	if (!(cachep->flags & SLAB_NO_REAP)) {
+#ifdef CONFIG_SMP
+		locked = spin_trylock(&pagemap_lru_lock);
+#else
+		locked = !in_interrupt() && spin_trylock(&pagemap_lru_lock);
+#endif
+	}
+
 	/* Get slab management. */
 	if (!(slabp = kmem_cache_slabmgmt(cachep, objp, offset, local_flags)))
 		goto opps1;
@@ -1203,9 +1320,17 @@
 		SET_PAGE_CACHE(page, cachep);
 		SET_PAGE_SLAB(page, slabp);
 		SetPageSlab(page);
+		if (locked) { 
+			set_page_count(page, 1);
+			TestSetPageLRU(page);
+			add_page_to_inactive_list(page);
+		}
 		page++;
 	} while (--i);
 
+	if (locked)
+		spin_unlock(&pagemap_lru_lock);
+
 	kmem_cache_init_objs(cachep, slabp, ctor_flags);
 
 	spin_lock_irqsave(&cachep->spinlock, save_flags);
@@ -1216,10 +1341,15 @@
 	STATS_INC_GROWN(cachep);
 	cachep->failures = 0;
 
+	/* The pagemap_lru_lock was not quickly/safely available */
+	if (!locked && !(cachep->flags & SLAB_NO_REAP))
+		cachep->dflags |= DFLGS_NONLRU;
+
 	spin_unlock_irqrestore(&cachep->spinlock, save_flags);
 	return 1;
 opps1:
-	kmem_freepages(cachep, objp);
+	/* do not use kmem_freepages - we are not in the lru yet... */      
+	free_pages((unsigned long)objp, cachep->gfporder);
 failed:
 	spin_lock_irqsave(&cachep->spinlock, save_flags);
 	cachep->growing--;
@@ -1241,15 +1371,12 @@
 	int i;
 	unsigned int objnr = (objp-slabp->s_mem)/cachep->objsize;
 
-	if (objnr >= cachep->num)
-		BUG();
-	if (objp != slabp->s_mem + objnr*cachep->objsize)
-		BUG();
+	BUG_ON(objnr >= cachep->num);
+	BUG_ON(objp != slabp->s_mem + objnr*cachep->objsize);
 
 	/* Check slab's freelist to see if this obj is there. */
 	for (i = slabp->free; i != BUFCTL_END; i = slab_bufctl(slabp)[i]) {
-		if (i == objnr)
-			BUG();
+		BUG_ON(i == objnr);
 	}
 	return 0;
 }
@@ -1258,11 +1385,9 @@
 static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
 {
 	if (flags & SLAB_DMA) {
-		if (!(cachep->gfpflags & GFP_DMA))
-			BUG();
+		BUG_ON(!(cachep->gfpflags & GFP_DMA));
 	} else {
-		if (cachep->gfpflags & GFP_DMA)
-			BUG();
+		BUG_ON(cachep->gfpflags & GFP_DMA);
 	}
 }
 
@@ -1284,18 +1409,20 @@
 		list_del(&slabp->list);
 		list_add(&slabp->list, &cachep->slabs_full);
 	}
+	if (unlikely(cachep->gfporder)) {
+		void *objb = slabp->s_mem-slabp->colouroff;
+		kmem_touch_page(objb);
+	} else
+		kmem_touch_page(objp);
 #if DEBUG
 	if (cachep->flags & SLAB_POISON)
-		if (kmem_check_poison_obj(cachep, objp))
-			BUG();
+		BUG_ON(kmem_check_poison_obj(cachep, objp));
 	if (cachep->flags & SLAB_RED_ZONE) {
 		/* Set alloc red-zone, and check old one. */
-		if (xchg((unsigned long *)objp, RED_MAGIC2) !=
-							 RED_MAGIC1)
-			BUG();
-		if (xchg((unsigned long *)(objp+cachep->objsize -
-			  BYTES_PER_WORD), RED_MAGIC2) != RED_MAGIC1)
-			BUG();
+		BUG_ON(xchg((unsigned long *)objp, RED_MAGIC2) !=
+		       RED_MAGIC1);
+		BUG_ON(xchg((unsigned long *)(objp+cachep->objsize -
+					      BYTES_PER_WORD), RED_MAGIC2) != RED_MAGIC1);
 		objp += BYTES_PER_WORD;
 	}
 #endif
@@ -1473,13 +1600,11 @@
 
 	if (cachep->flags & SLAB_RED_ZONE) {
 		objp -= BYTES_PER_WORD;
-		if (xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2)
-			/* Either write before start, or a double free. */
-			BUG();
-		if (xchg((unsigned long *)(objp+cachep->objsize -
-				BYTES_PER_WORD), RED_MAGIC1) != RED_MAGIC2)
-			/* Either write past end, or a double free. */
-			BUG();
+		BUG_ON(xchg((unsigned long *)objp, RED_MAGIC1) != RED_MAGIC2);
+		/* Either write before start, or a double free. */
+		BUG_ON(xchg((unsigned long *)(objp+cachep->objsize -
+			BYTES_PER_WORD), RED_MAGIC1) != RED_MAGIC2);
+		/* Either write past end, or a double free. */
 	}
 	if (cachep->flags & SLAB_POISON)
 		kmem_poison_obj(cachep, objp);
@@ -1617,8 +1742,7 @@
 	unsigned long flags;
 #if DEBUG
 	CHECK_PAGE(objp);
-	if (cachep != GET_PAGE_CACHE(virt_to_page(objp)))
-		BUG();
+	BUG_ON(cachep != GET_PAGE_CACHE(virt_to_page(objp)));
 #endif
 
 	local_irq_save(flags);
@@ -1823,8 +1947,7 @@
 		while (p != &searchp->slabs_free) {
 			slabp = list_entry(p, slab_t, list);
 #if DEBUG
-			if (slabp->inuse)
-				BUG();
+			BUG_ON(slabp->inuse);
 #endif
 			full_free++;
 			p = p->next;
@@ -1864,6 +1987,7 @@
 
 	spin_lock_irq(&best_cachep->spinlock);
 perfect:
+	spin_lock(&pagemap_lru_lock);
 	/* free only 50% of the free slabs */
 	best_len = (best_len + 1)/2;
 	for (scan = 0; scan < best_len; scan++) {
@@ -1876,8 +2000,7 @@
 			break;
 		slabp = list_entry(p,slab_t,list);
 #if DEBUG
-		if (slabp->inuse)
-			BUG();
+		BUG_ON(slabp->inuse);
 #endif
 		list_del(&slabp->list);
 		STATS_INC_REAPED(best_cachep);
@@ -1889,6 +2012,7 @@
 		kmem_slab_destroy(best_cachep, slabp);
 		spin_lock_irq(&best_cachep->spinlock);
 	}
+	spin_unlock(&pagemap_lru_lock);
 	spin_unlock_irq(&best_cachep->spinlock);
 	ret = scan * (1 << best_cachep->gfporder);
 out:
@@ -1962,22 +2086,19 @@
 	num_slabs = 0;
 	list_for_each(q,&cachep->slabs_full) {
 		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse != cachep->num)
-			BUG();
+		BUG_ON(slabp->inuse != cachep->num);
 		active_objs += cachep->num;
 		active_slabs++;
 	}
 	list_for_each(q,&cachep->slabs_partial) {
 		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse == cachep->num || !slabp->inuse)
-			BUG();
+		BUG_ON(slabp->inuse == cachep->num || !slabp->inuse);
 		active_objs += slabp->inuse;
 		active_slabs++;
 	}
 	list_for_each(q,&cachep->slabs_free) {
 		slabp = list_entry(q, slab_t, list);
-		if (slabp->inuse)
-			BUG();
+		BUG_ON(slabp->inuse);
 		num_slabs++;
 	}
 	num_slabs+=active_slabs;
diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Fri Aug  2 15:50:09 2002
+++ b/mm/vmscan.c	Fri Aug  2 15:50:09 2002
@@ -104,6 +104,19 @@
 			continue;
 
 		/*
+		 * For slab pages, use kmem_count_page to increment the aging
+		 * counter for the cache and to tell us if we should try to 
+		 * free the slab.  Use kmem_shrink_slab to free the slab and
+		 * stop if we are done.
+		 */
+		if (unlikely(PageSlab(page))) {
+			if (kmem_count_page(page, TestClearPageReferenced(page))) 
+				if ((nr_pages -= kmem_shrink_slab(page)) <= 0)
+					goto out;
+			continue;
+		}
+
+		/*
 		 * swap activity never enters the filesystem and is safe
 		 * for GFP_NOFS allocations.
 		 */
@@ -137,7 +150,7 @@
 		 * the active list.
 		 */
 		pte_chain_lock(page);
-		if (page_referenced(page) && page_mapping_inuse(page)) {
+		if (page_referenced(page) && (PageSlab(page) || page_mapping_inuse(page)) ) {
 			del_page_from_inactive_list(page);
 			add_page_to_active_list(page);
 			pte_chain_unlock(page);
@@ -367,10 +380,6 @@
 	struct page_state ps;
 	int max_scan;
 
-	nr_pages -= kmem_cache_reap(gfp_mask);
-	if (nr_pages <= 0)
-		return 0;
-
 	nr_pages = chunk_size;
 
 	/*
@@ -380,22 +389,17 @@
 	ratio = (unsigned long)nr_pages * ps.nr_active /
 				((ps.nr_inactive | 1) * 2);
 	refill_inactive(ratio);
+	/* refill_freelist(); */
+
 	max_scan = ps.nr_inactive / priority;
 	nr_pages = shrink_cache(nr_pages, classzone,
 				gfp_mask, priority, max_scan);
+	kmem_do_prunes(gfp_mask);
 	if (nr_pages <= 0)
 		return 0;
 
 	wakeup_bdflush();
 
-	shrink_dcache_memory(priority, gfp_mask);
-
-	/* After shrinking the dcache, get rid of unused inodes too .. */
-	shrink_icache_memory(1, gfp_mask);
-#ifdef CONFIG_QUOTA
-	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
-#endif
-
 	return nr_pages;
 }
 
@@ -411,6 +415,13 @@
 		if (nr_pages <= 0)
 			return 1;
 	} while (--priority);
+
+	/* 
+	 * perform full reap before concluding we are oom
+	 */
+	nr_pages -= kmem_cache_reap(gfp_mask);
+	if (nr_pages <= 0)
+		return 1;
 
 	/*
 	 * Hmm.. Cache shrink failed - time to kill something?
diff -Nru a/arch/arm/mach-arc/mm.c b/arch/arm/mach-arc/mm.c
--- a/arch/arm/mach-arc/mm.c	Fri Aug  2 15:50:10 2002
+++ b/arch/arm/mach-arc/mm.c	Fri Aug  2 15:50:10 2002
@@ -173,13 +173,13 @@
 {
 	pte_cache = kmem_cache_create("pte-cache",
 				sizeof(pte_t) * PTRS_PER_PTE,
-				0, 0, pte_cache_ctor, NULL);
+				0, 0, NULL, pte_cache_ctor, NULL);
 	if (!pte_cache)
 		BUG();
 
 	pgd_cache = kmem_cache_create("pgd-cache", MEMC_TABLE_SIZE +
 				sizeof(pgd_t) * PTRS_PER_PGD,
-				0, 0, pgd_cache_ctor, NULL);
+				0, 0, NULL, pgd_cache_ctor, NULL);
 	if (!pgd_cache)
 		BUG();
 }
diff -Nru a/arch/cris/drivers/usb-host.c b/arch/cris/drivers/usb-host.c
--- a/arch/cris/drivers/usb-host.c	Fri Aug  2 15:50:10 2002
+++ b/arch/cris/drivers/usb-host.c	Fri Aug  2 15:50:10 2002
@@ -2330,7 +2330,7 @@
 	hc = kmalloc(sizeof(etrax_hc_t), GFP_KERNEL);
 
 	/* We use kmem_cache_* to make sure that all DMA desc. are dword aligned */
-	usb_desc_cache = kmem_cache_create("usb_desc_cache", sizeof(USB_EP_Desc_t), 0, 0, 0, 0);
+	usb_desc_cache = kmem_cache_create("usb_desc_cache", sizeof(USB_EP_Desc_t), 0, 0, NULL, NULL, NULL);
 	if (!usb_desc_cache) {
 		panic("USB Desc Cache allocation failed !!!\n");
 	}
diff -Nru a/arch/i386/mm/init.c b/arch/i386/mm/init.c
--- a/arch/i386/mm/init.c	Fri Aug  2 15:50:10 2002
+++ b/arch/i386/mm/init.c	Fri Aug  2 15:50:10 2002
@@ -483,7 +483,7 @@
          * PAE pgds must be 16-byte aligned:
          */
         pae_pgd_cachep = kmem_cache_create("pae_pgd", 32, 0,
-                SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN, NULL, NULL);
+                SLAB_HWCACHE_ALIGN | SLAB_MUST_HWCACHE_ALIGN, NULL, NULL, NULL);
         if (!pae_pgd_cachep)
                 panic("init_pae(): Cannot alloc pae_pgd SLAB cache");
 }
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Fri Aug  2 15:50:09 2002
+++ b/drivers/block/ll_rw_blk.c	Fri Aug  2 15:50:09 2002
@@ -2052,7 +2052,7 @@
 
 	request_cachep = kmem_cache_create("blkdev_requests",
 					   sizeof(struct request),
-					   0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+					   0, SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 
 	if (!request_cachep)
 		panic("Can't create request pool slab cache\n");
diff -Nru a/drivers/ieee1394/eth1394.c b/drivers/ieee1394/eth1394.c
--- a/drivers/ieee1394/eth1394.c	Fri Aug  2 15:50:09 2002
+++ b/drivers/ieee1394/eth1394.c	Fri Aug  2 15:50:09 2002
@@ -715,7 +715,7 @@
 static int __init ether1394_init_module (void)
 {
 	packet_task_cache = kmem_cache_create("packet_task", sizeof(struct packet_task),
-					      0, 0, NULL, NULL);
+					      0, 0, NULL, NULL, NULL);
 
 	/* Register ourselves as a highlevel driver */
 	hl_handle = hpsb_register_highlevel (ETHER1394_DRIVER_NAME, &hl_ops);
diff -Nru a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
--- a/drivers/ieee1394/ieee1394_core.c	Fri Aug  2 15:50:10 2002
+++ b/drivers/ieee1394/ieee1394_core.c	Fri Aug  2 15:50:10 2002
@@ -972,7 +972,7 @@
 static int __init ieee1394_init(void)
 {
 	hpsb_packet_cache = kmem_cache_create("hpsb_packet", sizeof(struct hpsb_packet),
-					      0, 0, NULL, NULL);
+					      0, 0, NULL, NULL, NULL);
 
 	ieee1394_devfs_handle = devfs_mk_dir(NULL, "ieee1394", NULL);
 
diff -Nru a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c	Fri Aug  2 15:50:10 2002
+++ b/drivers/md/raid5.c	Fri Aug  2 15:50:10 2002
@@ -277,7 +277,7 @@
 
 	sc = kmem_cache_create(conf->cache_name, 
 			       sizeof(struct stripe_head)+(devs-1)*sizeof(struct r5dev),
-			       0, 0, NULL, NULL);
+			       0, 0, NULL, NULL, NULL);
 	if (!sc)
 		return 1;
 	conf->slab_cache = sc;
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Fri Aug  2 15:50:10 2002
+++ b/drivers/scsi/scsi.c	Fri Aug  2 15:50:10 2002
@@ -2532,7 +2532,7 @@
 		struct scsi_host_sg_pool *sgp = scsi_sg_pools + i;
 		int size = sgp->size * sizeof(struct scatterlist);
 
-		sgp->slab = kmem_cache_create(sgp->name, size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+		sgp->slab = kmem_cache_create(sgp->name, size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 		if (!sgp->slab)
 			panic("SCSI: can't init sg slab\n");
 
diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	Fri Aug  2 15:50:11 2002
+++ b/drivers/usb/host/uhci-hcd.c	Fri Aug  2 15:50:11 2002
@@ -2553,7 +2553,7 @@
 #endif
 
 	uhci_up_cachep = kmem_cache_create("uhci_urb_priv",
-		sizeof(struct urb_priv), 0, 0, NULL, NULL);
+		sizeof(struct urb_priv), 0, 0, NULL, NULL, NULL);
 	if (!uhci_up_cachep)
 		goto up_failed;
 
diff -Nru a/fs/adfs/super.c b/fs/adfs/super.c
--- a/fs/adfs/super.c	Fri Aug  2 15:50:09 2002
+++ b/fs/adfs/super.c	Fri Aug  2 15:50:09 2002
@@ -234,7 +234,7 @@
 	adfs_inode_cachep = kmem_cache_create("adfs_inode_cache",
 					     sizeof(struct adfs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (adfs_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/affs/super.c b/fs/affs/super.c
--- a/fs/affs/super.c	Fri Aug  2 15:50:10 2002
+++ b/fs/affs/super.c	Fri Aug  2 15:50:10 2002
@@ -117,7 +117,7 @@
 	affs_inode_cachep = kmem_cache_create("affs_inode_cache",
 					     sizeof(struct affs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (affs_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/bfs/inode.c b/fs/bfs/inode.c
--- a/fs/bfs/inode.c	Fri Aug  2 15:50:10 2002
+++ b/fs/bfs/inode.c	Fri Aug  2 15:50:10 2002
@@ -240,6 +240,7 @@
 	bfs_inode_cachep = kmem_cache_create("bfs_inode_cache",
 					     sizeof(struct bfs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
+					     age_icache_memory,
 					     init_once, NULL);
 	if (bfs_inode_cachep == NULL)
 		return -ENOMEM;
diff -Nru a/fs/bio.c b/fs/bio.c
--- a/fs/bio.c	Fri Aug  2 15:50:10 2002
+++ b/fs/bio.c	Fri Aug  2 15:50:10 2002
@@ -470,7 +470,7 @@
 						bp->size, size);
 
 		bp->slab = kmem_cache_create(bp->name, size, 0,
-						SLAB_HWCACHE_ALIGN, NULL, NULL);
+						SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 		if (!bp->slab)
 			panic("biovec: can't init slab cache\n");
 		bp->pool = mempool_create(BIO_POOL_SIZE, slab_pool_alloc,
@@ -484,7 +484,7 @@
 static int __init init_bio(void)
 {
 	bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
-					SLAB_HWCACHE_ALIGN, NULL, NULL);
+					SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!bio_slab)
 		panic("bio: can't create slab cache\n");
 	bio_pool = mempool_create(BIO_POOL_SIZE, slab_pool_alloc, slab_pool_free, bio_slab);
diff -Nru a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	Fri Aug  2 15:50:11 2002
+++ b/fs/block_dev.c	Fri Aug  2 15:50:11 2002
@@ -249,8 +249,8 @@
 
 	bdev_cachep = kmem_cache_create("bdev_cache",
 					 sizeof(struct block_device),
-					 0, SLAB_HWCACHE_ALIGN, init_once,
-					 NULL);
+					 0, SLAB_HWCACHE_ALIGN, 
+				         NULL, init_once, NULL);
 	if (!bdev_cachep)
 		panic("Cannot create bdev_cache SLAB cache");
 	err = register_filesystem(&bd_type);
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Fri Aug  2 15:50:09 2002
+++ b/fs/buffer.c	Fri Aug  2 15:50:09 2002
@@ -2550,7 +2550,7 @@
 
 	bh_cachep = kmem_cache_create("buffer_head",
 			sizeof(struct buffer_head), 0,
-			SLAB_HWCACHE_ALIGN, init_buffer_head, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, init_buffer_head, NULL);
 	bh_mempool = mempool_create(MAX_UNUSED_BUFFERS, bh_mempool_alloc,
 				bh_mempool_free, NULL);
 	for (i = 0; i < ARRAY_SIZE(bh_wait_queue_heads); i++)
diff -Nru a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	Fri Aug  2 15:50:10 2002
+++ b/fs/char_dev.c	Fri Aug  2 15:50:10 2002
@@ -46,8 +46,8 @@
 
 	cdev_cachep = kmem_cache_create("cdev_cache",
 					 sizeof(struct char_device),
-					 0, SLAB_HWCACHE_ALIGN, init_once,
-					 NULL);
+					 0, SLAB_HWCACHE_ALIGN, NULL,
+					 init_once, NULL);
 	if (!cdev_cachep)
 		panic("Cannot create cdev_cache SLAB cache");
 }
diff -Nru a/fs/coda/inode.c b/fs/coda/inode.c
--- a/fs/coda/inode.c	Fri Aug  2 15:50:10 2002
+++ b/fs/coda/inode.c	Fri Aug  2 15:50:10 2002
@@ -73,9 +73,10 @@
 	coda_inode_cachep = kmem_cache_create("coda_inode_cache",
 					     sizeof(struct coda_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (coda_inode_cachep == NULL)
 		return -ENOMEM;
+
 	return 0;
 }
 
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Fri Aug  2 15:50:09 2002
+++ b/fs/dcache.c	Fri Aug  2 15:50:09 2002
@@ -123,8 +123,7 @@
 		return;
 
 	/* dput on a free dentry? */
-	if (!list_empty(&dentry->d_lru))
-		BUG();
+	BUG_ON(!list_empty(&dentry->d_lru));
 	/*
 	 * AV: ->d_delete() is _NOT_ allowed to block now.
 	 */
@@ -329,12 +328,11 @@
 void prune_dcache(int count)
 {
 	spin_lock(&dcache_lock);
-	for (;;) {
+	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
 
 		tmp = dentry_unused.prev;
-
 		if (tmp == &dentry_unused)
 			break;
 		list_del_init(tmp);
@@ -349,12 +347,8 @@
 		dentry_stat.nr_unused--;
 
 		/* Unused dentry with a count? */
-		if (atomic_read(&dentry->d_count))
-			BUG();
-
+		BUG_ON(atomic_read(&dentry->d_count));
 		prune_one_dentry(dentry);
-		if (!--count)
-			break;
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -573,19 +567,10 @@
 
 /*
  * This is called from kswapd when we think we need some
- * more memory, but aren't really sure how much. So we
- * carefully try to free a _bit_ of our dcache, but not
- * too much.
- *
- * Priority:
- *   1 - very urgent: shrink everything
- *  ...
- *   6 - base-level: try to shrink a bit.
+ * more memory. 
  */
-int shrink_dcache_memory(int priority, unsigned int gfp_mask)
+int age_dcache_memory(kmem_cache_t *cachep, int entries, int gfp_mask)
 {
-	int count = 0;
-
 	/*
 	 * Nasty deadlock avoidance.
 	 *
@@ -600,11 +585,11 @@
 	if (!(gfp_mask & __GFP_FS))
 		return 0;
 
-	count = dentry_stat.nr_unused / priority;
+	if (entries > dentry_stat.nr_unused)
+		entries = dentry_stat.nr_unused;
 
-	prune_dcache(count);
-	kmem_cache_shrink(dentry_cache);
-	return 0;
+	prune_dcache(entries);
+	return entries;
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
@@ -686,7 +671,7 @@
  
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
-	if (!list_empty(&entry->d_alias)) BUG();
+	BUG_ON(!list_empty(&entry->d_alias));
 	spin_lock(&dcache_lock);
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
@@ -985,7 +970,7 @@
 void d_rehash(struct dentry * entry)
 {
 	struct list_head *list = d_hash(entry->d_parent, entry->d_name.hash);
-	if (!list_empty(&entry->d_hash)) BUG();
+	BUG_ON(!list_empty(&entry->d_hash));
 	spin_lock(&dcache_lock);
 	list_add(&entry->d_hash, list);
 	spin_unlock(&dcache_lock);
@@ -1341,7 +1326,7 @@
 					 sizeof(struct dentry),
 					 0,
 					 SLAB_HWCACHE_ALIGN,
-					 NULL, NULL);
+					 age_dcache_memory, NULL, NULL);
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
 
@@ -1401,22 +1386,23 @@
 {
 	names_cachep = kmem_cache_create("names_cache", 
 			PATH_MAX, 0, 
-			SLAB_HWCACHE_ALIGN, NULL, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!names_cachep)
 		panic("Cannot create names SLAB cache");
 
 	filp_cachep = kmem_cache_create("filp", 
 			sizeof(struct file), 0,
-			SLAB_HWCACHE_ALIGN, NULL, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if(!filp_cachep)
 		panic("Cannot create filp SLAB cache");
 
 #if defined (CONFIG_QUOTA)
 	dquot_cachep = kmem_cache_create("dquot", 
 			sizeof(struct dquot), sizeof(unsigned long) * 4,
-			SLAB_HWCACHE_ALIGN, NULL, NULL);
+			SLAB_HWCACHE_ALIGN, age_dqcache_memory, NULL, NULL);
 	if (!dquot_cachep)
 		panic("Cannot create dquot SLAB cache");
+	
 #endif
 
 	dcache_init(mempages);
diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Fri Aug  2 15:50:10 2002
+++ b/fs/devfs/base.c	Fri Aug  2 15:50:10 2002
@@ -3452,7 +3452,7 @@
 	    DEVFS_NAME, DEVFS_VERSION);
     devfsd_buf_cache = kmem_cache_create ("devfsd_event",
 					  sizeof (struct devfsd_buf_entry),
-					  0, 0, NULL, NULL);
+					  0, 0, NULL, NULL, NULL);
     if (!devfsd_buf_cache) OOPS ("(): unable to allocate event slab\n");
 #ifdef CONFIG_DEVFS_DEBUG
     devfs_debug = devfs_debug_init;
diff -Nru a/fs/dnotify.c b/fs/dnotify.c
--- a/fs/dnotify.c	Fri Aug  2 15:50:10 2002
+++ b/fs/dnotify.c	Fri Aug  2 15:50:10 2002
@@ -149,7 +149,7 @@
 static int __init dnotify_init(void)
 {
 	dn_cache = kmem_cache_create("dnotify cache",
-		sizeof(struct dnotify_struct), 0, 0, NULL, NULL);
+		sizeof(struct dnotify_struct), 0, 0, NULL, NULL, NULL);
 	if (!dn_cache)
 		panic("cannot create dnotify slab cache");
 	return 0;
diff -Nru a/fs/dquot.c b/fs/dquot.c
--- a/fs/dquot.c	Fri Aug  2 15:50:09 2002
+++ b/fs/dquot.c	Fri Aug  2 15:50:09 2002
@@ -480,26 +480,18 @@
 
 /*
  * This is called from kswapd when we think we need some
- * more memory, but aren't really sure how much. So we
- * carefully try to free a _bit_ of our dqcache, but not
- * too much.
- *
- * Priority:
- *   1 - very urgent: shrink everything
- *   ...
- *   6 - base-level: try to shrink a bit.
+ * more memory
  */
 
-int shrink_dqcache_memory(int priority, unsigned int gfp_mask)
+int age_dqcache_memory(kmem_cache_t *cachep, int entries, int gfp_mask)
 {
-	int count = 0;
+	if (entries > dqstats.free_dquots)
+		entries = dqstats.free_dquots;
 
 	lock_kernel();
-	count = dqstats.free_dquots / priority;
-	prune_dqcache(count);
+	prune_dqcache(entries);
 	unlock_kernel();
-	kmem_cache_shrink(dquot_cachep);
-	return 0;
+	return entries;
 }
 
 /*
diff -Nru a/fs/efs/super.c b/fs/efs/super.c
--- a/fs/efs/super.c	Fri Aug  2 15:50:10 2002
+++ b/fs/efs/super.c	Fri Aug  2 15:50:10 2002
@@ -58,6 +58,7 @@
 	efs_inode_cachep = kmem_cache_create("efs_inode_cache",
 					     sizeof(struct efs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
+					     age_icache_memory,
 					     init_once, NULL);
 	if (efs_inode_cachep == NULL)
 		return -ENOMEM;
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Fri Aug  2 15:50:10 2002
+++ b/fs/ext2/super.c	Fri Aug  2 15:50:10 2002
@@ -181,7 +181,7 @@
 	ext2_inode_cachep = kmem_cache_create("ext2_inode_cache",
 					     sizeof(struct ext2_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (ext2_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Fri Aug  2 15:50:11 2002
+++ b/fs/ext3/super.c	Fri Aug  2 15:50:11 2002
@@ -476,7 +476,7 @@
 	ext3_inode_cachep = kmem_cache_create("ext3_inode_cache",
 					     sizeof(struct ext3_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (ext3_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	Fri Aug  2 15:50:10 2002
+++ b/fs/fat/inode.c	Fri Aug  2 15:50:10 2002
@@ -597,6 +597,7 @@
 	fat_inode_cachep = kmem_cache_create("fat_inode_cache",
 					     sizeof(struct msdos_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
+					     age_icache_memory,
 					     init_once, NULL);
 	if (fat_inode_cachep == NULL)
 		return -ENOMEM;
diff -Nru a/fs/fcntl.c b/fs/fcntl.c
--- a/fs/fcntl.c	Fri Aug  2 15:50:09 2002
+++ b/fs/fcntl.c	Fri Aug  2 15:50:09 2002
@@ -562,7 +562,7 @@
 static int __init fasync_init(void)
 {
 	fasync_cache = kmem_cache_create("fasync_cache",
-		sizeof(struct fasync_struct), 0, 0, NULL, NULL);
+		sizeof(struct fasync_struct), 0, 0, NULL, NULL, NULL);
 	if (!fasync_cache)
 		panic("cannot create fasync slab cache");
 	return 0;
diff -Nru a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
--- a/fs/freevxfs/vxfs_super.c	Fri Aug  2 15:50:11 2002
+++ b/fs/freevxfs/vxfs_super.c	Fri Aug  2 15:50:11 2002
@@ -246,9 +246,10 @@
 vxfs_init(void)
 {
 	vxfs_inode_cachep = kmem_cache_create("vxfs_inode",
-			sizeof(struct vxfs_inode_info), 0, 0, NULL, NULL);
-	if (vxfs_inode_cachep)
+			sizeof(struct vxfs_inode_info), 0, 0, age_icache_memory, NULL, NULL);
+	if (vxfs_inode_cachep) {
 		return (register_filesystem(&vxfs_fs_type));
+	}
 	return -ENOMEM;
 }
 
diff -Nru a/fs/hfs/super.c b/fs/hfs/super.c
--- a/fs/hfs/super.c	Fri Aug  2 15:50:10 2002
+++ b/fs/hfs/super.c	Fri Aug  2 15:50:10 2002
@@ -72,6 +72,7 @@
 	hfs_inode_cachep = kmem_cache_create("hfs_inode_cache",
 					     sizeof(struct hfs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
+					     age_icache_memory,
 					     init_once, NULL);
 	if (hfs_inode_cachep == NULL)
 		return -ENOMEM;
diff -Nru a/fs/hpfs/super.c b/fs/hpfs/super.c
--- a/fs/hpfs/super.c	Fri Aug  2 15:50:10 2002
+++ b/fs/hpfs/super.c	Fri Aug  2 15:50:10 2002
@@ -186,7 +186,7 @@
 	hpfs_inode_cachep = kmem_cache_create("hpfs_inode_cache",
 					     sizeof(struct hpfs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (hpfs_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Fri Aug  2 15:50:11 2002
+++ b/fs/inode.c	Fri Aug  2 15:50:11 2002
@@ -387,10 +387,11 @@
 
 	count = 0;
 	entry = inode_unused.prev;
-	while (entry != &inode_unused)
-	{
+	for(; goal; goal--) {
 		struct list_head *tmp = entry;
 
+		if (entry == &inode_unused)
+			break;
 		entry = entry->prev;
 		inode = INODE(tmp);
 		if (inode->i_state & (I_FREEING|I_CLEAR|I_LOCK))
@@ -404,8 +405,6 @@
 		list_add(tmp, freeable);
 		inode->i_state |= I_FREEING;
 		count++;
-		if (!--goal)
-			break;
 	}
 	inodes_stat.nr_unused -= count;
 	spin_unlock(&inode_lock);
@@ -415,19 +414,10 @@
 
 /*
  * This is called from kswapd when we think we need some
- * more memory, but aren't really sure how much. So we
- * carefully try to free a _bit_ of our icache, but not
- * too much.
- *
- * Priority:
- *   1 - very urgent: shrink everything
- *  ...
- *   6 - base-level: try to shrink a bit.
+ * more memory. 
  */
-int shrink_icache_memory(int priority, int gfp_mask)
+int age_icache_memory(kmem_cache_t *cachep, int entries, int gfp_mask)
 {
-	int count = 0;
-
 	/*
 	 * Nasty deadlock avoidance..
 	 *
@@ -438,12 +428,13 @@
 	if (!(gfp_mask & __GFP_FS))
 		return 0;
 
-	count = inodes_stat.nr_unused / priority;
+	if (entries > inodes_stat.nr_unused)
+		entries = inodes_stat.nr_unused;
 
-	prune_icache(count);
-	kmem_cache_shrink(inode_cachep);
-	return 0;
+	prune_icache(entries);
+	return entries;
 }
+EXPORT_SYMBOL(age_icache_memory);
 
 /*
  * Called with the inode lock held.
@@ -1107,8 +1098,8 @@
 
 	/* inode slab cache */
 	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
-					 0, SLAB_HWCACHE_ALIGN, init_once,
-					 NULL);
+					 0, SLAB_HWCACHE_ALIGN, age_icache_memory,
+					 init_once, NULL);
 	if (!inode_cachep)
 		panic("cannot create inode slab cache");
 }
diff -Nru a/fs/intermezzo/dcache.c b/fs/intermezzo/dcache.c
--- a/fs/intermezzo/dcache.c	Fri Aug  2 15:50:11 2002
+++ b/fs/intermezzo/dcache.c	Fri Aug  2 15:50:11 2002
@@ -127,7 +127,7 @@
                 kmem_cache_create("presto_cache",
                                   sizeof(struct presto_dentry_data), 0,
                                   SLAB_HWCACHE_ALIGN, NULL,
-                                  NULL);
+                                  NULL, NULL);
         EXIT;
 }
 
diff -Nru a/fs/isofs/inode.c b/fs/isofs/inode.c
--- a/fs/isofs/inode.c	Fri Aug  2 15:50:11 2002
+++ b/fs/isofs/inode.c	Fri Aug  2 15:50:11 2002
@@ -111,7 +111,7 @@
 	isofs_inode_cachep = kmem_cache_create("isofs_inode_cache",
 					     sizeof(struct iso_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (isofs_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/jbd/journal.c b/fs/jbd/journal.c
--- a/fs/jbd/journal.c	Fri Aug  2 15:50:10 2002
+++ b/fs/jbd/journal.c	Fri Aug  2 15:50:10 2002
@@ -1569,6 +1569,7 @@
 				sizeof(struct journal_head),
 				0,		/* offset */
 				0,		/* flags */
+				NULL,		/* pruner */
 				NULL,		/* ctor */
 				NULL);		/* dtor */
 	retval = 0;
diff -Nru a/fs/jbd/revoke.c b/fs/jbd/revoke.c
--- a/fs/jbd/revoke.c	Fri Aug  2 15:50:09 2002
+++ b/fs/jbd/revoke.c	Fri Aug  2 15:50:09 2002
@@ -163,13 +163,13 @@
 {
 	revoke_record_cache = kmem_cache_create("revoke_record",
 					   sizeof(struct jbd_revoke_record_s),
-					   0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+					   0, SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (revoke_record_cache == 0)
 		return -ENOMEM;
 
 	revoke_table_cache = kmem_cache_create("revoke_table",
 					   sizeof(struct jbd_revoke_table_s),
-					   0, 0, NULL, NULL);
+					   0, 0, NULL, NULL, NULL);
 	if (revoke_table_cache == 0) {
 		kmem_cache_destroy(revoke_record_cache);
 		revoke_record_cache = NULL;
diff -Nru a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
--- a/fs/jffs/inode-v23.c	Fri Aug  2 15:50:10 2002
+++ b/fs/jffs/inode-v23.c	Fri Aug  2 15:50:10 2002
@@ -1796,9 +1796,9 @@
 	jffs_proc_root = proc_mkdir("jffs", proc_root_fs);
 #endif
 	fm_cache = kmem_cache_create("jffs_fm", sizeof(struct jffs_fm),
-				     0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+				     0, SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	node_cache = kmem_cache_create("jffs_node",sizeof(struct jffs_node),
-				       0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+				       0, SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	return register_filesystem(&jffs_fs_type);
 }
 
diff -Nru a/fs/jffs2/malloc.c b/fs/jffs2/malloc.c
--- a/fs/jffs2/malloc.c	Fri Aug  2 15:50:09 2002
+++ b/fs/jffs2/malloc.c	Fri Aug  2 15:50:09 2002
@@ -37,43 +37,43 @@
 {
 	full_dnode_slab = kmem_cache_create("jffs2_full_dnode", 
 					    sizeof(struct jffs2_full_dnode),
-					    0, JFFS2_SLAB_POISON, NULL, NULL);
+					    0, JFFS2_SLAB_POISON, NULL, NULL, NULL);
 	if (!full_dnode_slab)
 		goto err;
 
 	raw_dirent_slab = kmem_cache_create("jffs2_raw_dirent",
 					    sizeof(struct jffs2_raw_dirent),
-					    0, JFFS2_SLAB_POISON, NULL, NULL);
+					    0, JFFS2_SLAB_POISON, NULL, NULL, NULL);
 	if (!raw_dirent_slab)
 		goto err;
 
 	raw_inode_slab = kmem_cache_create("jffs2_raw_inode",
 					   sizeof(struct jffs2_raw_inode),
-					   0, JFFS2_SLAB_POISON, NULL, NULL);
+					   0, JFFS2_SLAB_POISON, NULL, NULL, NULL);
 	if (!raw_inode_slab)
 		goto err;
 
 	tmp_dnode_info_slab = kmem_cache_create("jffs2_tmp_dnode",
 						sizeof(struct jffs2_tmp_dnode_info),
-						0, JFFS2_SLAB_POISON, NULL, NULL);
+						0, JFFS2_SLAB_POISON, NULL, NULL, NULL);
 	if (!tmp_dnode_info_slab)
 		goto err;
 
 	raw_node_ref_slab = kmem_cache_create("jffs2_raw_node_ref",
 					      sizeof(struct jffs2_raw_node_ref),
-					      0, JFFS2_SLAB_POISON, NULL, NULL);
+					      0, JFFS2_SLAB_POISON, NULL, NULL, NULL);
 	if (!raw_node_ref_slab)
 		goto err;
 
 	node_frag_slab = kmem_cache_create("jffs2_node_frag",
 					   sizeof(struct jffs2_node_frag),
-					   0, JFFS2_SLAB_POISON, NULL, NULL);
+					   0, JFFS2_SLAB_POISON, NULL, NULL, NULL);
 	if (!node_frag_slab)
 		goto err;
 
 	inode_cache_slab = kmem_cache_create("jffs2_inode_cache",
 					     sizeof(struct jffs2_inode_cache),
-					     0, JFFS2_SLAB_POISON, NULL, NULL);
+					     0, JFFS2_SLAB_POISON, NULL, NULL, NULL);
 	if (inode_cache_slab)
 		return 0;
  err:
diff -Nru a/fs/jffs2/super.c b/fs/jffs2/super.c
--- a/fs/jffs2/super.c	Fri Aug  2 15:50:10 2002
+++ b/fs/jffs2/super.c	Fri Aug  2 15:50:10 2002
@@ -299,7 +299,7 @@
 	jffs2_inode_cachep = kmem_cache_create("jffs2_i",
 					     sizeof(struct jffs2_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     jffs2_i_init_once, NULL);
+					     age_icache_memory, jffs2_i_init_once, NULL);
 	if (!jffs2_inode_cachep) {
 		printk(KERN_ERR "JFFS2 error: Failed to initialise inode cache\n");
 		return -ENOMEM;
diff -Nru a/fs/jfs/super.c b/fs/jfs/super.c
--- a/fs/jfs/super.c	Fri Aug  2 15:50:10 2002
+++ b/fs/jfs/super.c	Fri Aug  2 15:50:10 2002
@@ -399,7 +399,7 @@
 	jfs_inode_cachep =
 	    kmem_cache_create("jfs_ip",
 			    sizeof(struct jfs_inode_info),
-			    0, 0, init_once, NULL);
+			    0, 0, age_icache_memory, init_once, NULL);
 	if (jfs_inode_cachep == NULL)
 		return -ENOMEM;
 
diff -Nru a/fs/locks.c b/fs/locks.c
--- a/fs/locks.c	Fri Aug  2 15:50:11 2002
+++ b/fs/locks.c	Fri Aug  2 15:50:11 2002
@@ -1884,7 +1884,7 @@
 static int __init filelock_init(void)
 {
 	filelock_cache = kmem_cache_create("file_lock_cache",
-			sizeof(struct file_lock), 0, 0, init_once, NULL);
+			sizeof(struct file_lock), 0, 0, NULL, init_once, NULL);
 	if (!filelock_cache)
 		panic("cannot create file lock slab cache");
 	return 0;
diff -Nru a/fs/minix/inode.c b/fs/minix/inode.c
--- a/fs/minix/inode.c	Fri Aug  2 15:50:10 2002
+++ b/fs/minix/inode.c	Fri Aug  2 15:50:10 2002
@@ -79,7 +79,7 @@
 	minix_inode_cachep = kmem_cache_create("minix_inode_cache",
 					     sizeof(struct minix_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (minix_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Fri Aug  2 15:50:10 2002
+++ b/fs/namespace.c	Fri Aug  2 15:50:10 2002
@@ -1046,7 +1046,7 @@
 	int i;
 
 	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct vfsmount),
-					0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+					0, SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!mnt_cache)
 		panic("Cannot create vfsmount cache");
 
diff -Nru a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
--- a/fs/ncpfs/inode.c	Fri Aug  2 15:50:10 2002
+++ b/fs/ncpfs/inode.c	Fri Aug  2 15:50:10 2002
@@ -69,7 +69,7 @@
 	ncp_inode_cachep = kmem_cache_create("ncp_inode_cache",
 					     sizeof(struct ncp_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (ncp_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/nfs/inode.c b/fs/nfs/inode.c
--- a/fs/nfs/inode.c	Fri Aug  2 15:50:11 2002
+++ b/fs/nfs/inode.c	Fri Aug  2 15:50:11 2002
@@ -1318,7 +1318,7 @@
 	nfs_inode_cachep = kmem_cache_create("nfs_inode_cache",
 					     sizeof(struct nfs_inode),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (nfs_inode_cachep == NULL)
 		return -ENOMEM;
 
diff -Nru a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
--- a/fs/nfs/pagelist.c	Fri Aug  2 15:50:10 2002
+++ b/fs/nfs/pagelist.c	Fri Aug  2 15:50:10 2002
@@ -492,7 +492,7 @@
 	nfs_page_cachep = kmem_cache_create("nfs_page",
 					    sizeof(struct nfs_page),
 					    0, SLAB_HWCACHE_ALIGN,
-					    NULL, NULL);
+					    NULL, NULL, NULL);
 	if (nfs_page_cachep == NULL)
 		return -ENOMEM;
 
diff -Nru a/fs/nfs/read.c b/fs/nfs/read.c
--- a/fs/nfs/read.c	Fri Aug  2 15:50:09 2002
+++ b/fs/nfs/read.c	Fri Aug  2 15:50:09 2002
@@ -492,7 +492,7 @@
 	nfs_rdata_cachep = kmem_cache_create("nfs_read_data",
 					     sizeof(struct nfs_read_data),
 					     0, SLAB_HWCACHE_ALIGN,
-					     NULL, NULL);
+					     NULL, NULL, NULL);
 	if (nfs_rdata_cachep == NULL)
 		return -ENOMEM;
 
diff -Nru a/fs/nfs/write.c b/fs/nfs/write.c
--- a/fs/nfs/write.c	Fri Aug  2 15:50:10 2002
+++ b/fs/nfs/write.c	Fri Aug  2 15:50:10 2002
@@ -1317,7 +1317,7 @@
 	nfs_wdata_cachep = kmem_cache_create("nfs_write_data",
 					     sizeof(struct nfs_write_data),
 					     0, SLAB_HWCACHE_ALIGN,
-					     NULL, NULL);
+					     NULL, NULL, NULL);
 	if (nfs_wdata_cachep == NULL)
 		return -ENOMEM;
 
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Fri Aug  2 15:50:09 2002
+++ b/fs/ntfs/super.c	Fri Aug  2 15:50:09 2002
@@ -1654,7 +1654,7 @@
 
 	ntfs_attr_ctx_cache = kmem_cache_create(ntfs_attr_ctx_cache_name,
 			sizeof(attr_search_context), 0 /* offset */,
-			SLAB_HWCACHE_ALIGN, NULL /* ctor */, NULL /* dtor */);
+			SLAB_HWCACHE_ALIGN, NULL, NULL /* ctor */, NULL /* dtor */);
 	if (!ntfs_attr_ctx_cache) {
 		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
 				ntfs_attr_ctx_cache_name);
@@ -1663,7 +1663,7 @@
 
 	ntfs_name_cache = kmem_cache_create(ntfs_name_cache_name,
 			(NTFS_MAX_NAME_LEN+1) * sizeof(uchar_t), 0,
-			SLAB_HWCACHE_ALIGN, NULL, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!ntfs_name_cache) {
 		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
 				ntfs_name_cache_name);
@@ -1671,7 +1671,8 @@
 	}
 
 	ntfs_inode_cache = kmem_cache_create(ntfs_inode_cache_name,
-			sizeof(ntfs_inode), 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+			sizeof(ntfs_inode), 0, SLAB_HWCACHE_ALIGN,
+			age_icache_memory, NULL, NULL);
 	if (!ntfs_inode_cache) {
 		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
 				ntfs_inode_cache_name);
@@ -1680,7 +1681,7 @@
 
 	ntfs_big_inode_cache = kmem_cache_create(ntfs_big_inode_cache_name,
 			sizeof(big_ntfs_inode), 0, SLAB_HWCACHE_ALIGN,
-			ntfs_big_inode_init_once, NULL);
+			age_icache_memory, ntfs_big_inode_init_once, NULL);
 	if (!ntfs_big_inode_cache) {
 		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
 				ntfs_big_inode_cache_name);
diff -Nru a/fs/proc/inode.c b/fs/proc/inode.c
--- a/fs/proc/inode.c	Fri Aug  2 15:50:10 2002
+++ b/fs/proc/inode.c	Fri Aug  2 15:50:10 2002
@@ -111,7 +111,7 @@
 	proc_inode_cachep = kmem_cache_create("proc_inode_cache",
 					     sizeof(struct proc_inode),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (proc_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/qnx4/inode.c b/fs/qnx4/inode.c
--- a/fs/qnx4/inode.c	Fri Aug  2 15:50:10 2002
+++ b/fs/qnx4/inode.c	Fri Aug  2 15:50:10 2002
@@ -544,7 +544,7 @@
 	qnx4_inode_cachep = kmem_cache_create("qnx4_inode_cache",
 					     sizeof(struct qnx4_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (qnx4_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Fri Aug  2 15:50:10 2002
+++ b/fs/reiserfs/super.c	Fri Aug  2 15:50:10 2002
@@ -434,7 +434,7 @@
 	reiserfs_inode_cachep = kmem_cache_create("reiser_inode_cache",
 					     sizeof(struct reiserfs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (reiserfs_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/romfs/inode.c b/fs/romfs/inode.c
--- a/fs/romfs/inode.c	Fri Aug  2 15:50:10 2002
+++ b/fs/romfs/inode.c	Fri Aug  2 15:50:10 2002
@@ -572,7 +572,7 @@
 	romfs_inode_cachep = kmem_cache_create("romfs_inode_cache",
 					     sizeof(struct romfs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (romfs_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/smbfs/inode.c b/fs/smbfs/inode.c
--- a/fs/smbfs/inode.c	Fri Aug  2 15:50:09 2002
+++ b/fs/smbfs/inode.c	Fri Aug  2 15:50:09 2002
@@ -78,7 +78,7 @@
 	smb_inode_cachep = kmem_cache_create("smb_inode_cache",
 					     sizeof(struct smb_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (smb_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/smbfs/request.c b/fs/smbfs/request.c
--- a/fs/smbfs/request.c	Fri Aug  2 15:50:11 2002
+++ b/fs/smbfs/request.c	Fri Aug  2 15:50:11 2002
@@ -37,7 +37,7 @@
 	req_cachep = kmem_cache_create("smb_request",
 				       sizeof(struct smb_request), 0,
 				       SMB_SLAB_DEBUG | SLAB_HWCACHE_ALIGN,
-				       NULL, NULL);
+				       NULL, NULL, NULL);
 	if (req_cachep == NULL)
 		return -ENOMEM;
 
diff -Nru a/fs/sysv/inode.c b/fs/sysv/inode.c
--- a/fs/sysv/inode.c	Fri Aug  2 15:50:09 2002
+++ b/fs/sysv/inode.c	Fri Aug  2 15:50:09 2002
@@ -325,7 +325,7 @@
 {
 	sysv_inode_cachep = kmem_cache_create("sysv_inode_cache",
 			sizeof(struct sysv_inode_info), 0,
-			SLAB_HWCACHE_ALIGN, init_once, NULL);
+			SLAB_HWCACHE_ALIGN, age_icache_memory, init_once, NULL);
 	if (!sysv_inode_cachep)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/udf/super.c b/fs/udf/super.c
--- a/fs/udf/super.c	Fri Aug  2 15:50:10 2002
+++ b/fs/udf/super.c	Fri Aug  2 15:50:10 2002
@@ -141,7 +141,7 @@
 	udf_inode_cachep = kmem_cache_create("udf_inode_cache",
 					     sizeof(struct udf_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (udf_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/fs/ufs/super.c b/fs/ufs/super.c
--- a/fs/ufs/super.c	Fri Aug  2 15:50:09 2002
+++ b/fs/ufs/super.c	Fri Aug  2 15:50:09 2002
@@ -1010,7 +1010,7 @@
 	ufs_inode_cachep = kmem_cache_create("ufs_inode_cache",
 					     sizeof(struct ufs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (ufs_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h	Fri Aug  2 15:50:11 2002
+++ b/include/linux/dcache.h	Fri Aug  2 15:50:11 2002
@@ -184,15 +184,10 @@
 #define shrink_dcache() prune_dcache(0)
 struct zone_struct;
 /* dcache memory management */
-extern int shrink_dcache_memory(int, unsigned int);
 extern void prune_dcache(int);
 
 /* icache memory management (defined in linux/fs/inode.c) */
-extern int shrink_icache_memory(int, int);
 extern void prune_icache(int);
-
-/* quota cache memory management (defined in linux/fs/dquot.c) */
-extern int shrink_dqcache_memory(int, unsigned int);
 
 /* only used at mount-time */
 extern struct dentry * d_alloc_root(struct inode *);
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Aug  2 15:50:09 2002
+++ b/kernel/fork.c	Fri Aug  2 15:50:09 2002
@@ -85,7 +85,7 @@
 	task_struct_cachep =
 		kmem_cache_create("task_struct",
 				  sizeof(struct task_struct),0,
-				  SLAB_HWCACHE_ALIGN, NULL, NULL);
+				  SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!task_struct_cachep)
 		panic("fork_init(): cannot create task_struct SLAB cache");
 
@@ -888,31 +888,31 @@
 {
 	sigact_cachep = kmem_cache_create("signal_act",
 			sizeof(struct signal_struct), 0,
-			SLAB_HWCACHE_ALIGN, NULL, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!sigact_cachep)
 		panic("Cannot create signal action SLAB cache");
 
 	files_cachep = kmem_cache_create("files_cache", 
 			 sizeof(struct files_struct), 0, 
-			 SLAB_HWCACHE_ALIGN, NULL, NULL);
+			 SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!files_cachep) 
 		panic("Cannot create files SLAB cache");
 
 	fs_cachep = kmem_cache_create("fs_cache", 
 			 sizeof(struct fs_struct), 0, 
-			 SLAB_HWCACHE_ALIGN, NULL, NULL);
+			 SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!fs_cachep) 
 		panic("Cannot create fs_struct SLAB cache");
  
 	vm_area_cachep = kmem_cache_create("vm_area_struct",
 			sizeof(struct vm_area_struct), 0,
-			SLAB_HWCACHE_ALIGN, NULL, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if(!vm_area_cachep)
 		panic("vma_init: Cannot alloc vm_area_struct SLAB cache");
 
 	mm_cachep = kmem_cache_create("mm_struct",
 			sizeof(struct mm_struct), 0,
-			SLAB_HWCACHE_ALIGN, NULL, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if(!mm_cachep)
 		panic("vma_init: Cannot alloc mm_struct SLAB cache");
 }
diff -Nru a/kernel/signal.c b/kernel/signal.c
--- a/kernel/signal.c	Fri Aug  2 15:50:10 2002
+++ b/kernel/signal.c	Fri Aug  2 15:50:10 2002
@@ -43,7 +43,7 @@
 		kmem_cache_create("sigqueue",
 				  sizeof(struct sigqueue),
 				  __alignof__(struct sigqueue),
-				  SIG_SLAB_DEBUG, NULL, NULL);
+				  SIG_SLAB_DEBUG, NULL, NULL, NULL);
 	if (!sigqueue_cachep)
 		panic("signals_init(): cannot create sigqueue SLAB cache");
 }
diff -Nru a/kernel/user.c b/kernel/user.c
--- a/kernel/user.c	Fri Aug  2 15:50:10 2002
+++ b/kernel/user.c	Fri Aug  2 15:50:10 2002
@@ -118,7 +118,7 @@
 
 	uid_cachep = kmem_cache_create("uid_cache", sizeof(struct user_struct),
 				       0,
-				       SLAB_HWCACHE_ALIGN, NULL, NULL);
+				       SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if(!uid_cachep)
 		panic("Cannot create uid taskcount SLAB cache\n");
 
diff -Nru a/lib/radix-tree.c b/lib/radix-tree.c
--- a/lib/radix-tree.c	Fri Aug  2 15:50:10 2002
+++ b/lib/radix-tree.c	Fri Aug  2 15:50:10 2002
@@ -293,7 +293,7 @@
 {
 	radix_tree_node_cachep = kmem_cache_create("radix_tree_node",
 			sizeof(struct radix_tree_node), 0,
-			SLAB_HWCACHE_ALIGN, radix_tree_node_ctor, NULL);
+			SLAB_HWCACHE_ALIGN, NULL, radix_tree_node_ctor, NULL);
 	if (!radix_tree_node_cachep)
 		panic ("Failed to create radix_tree_node cache\n");
 	radix_tree_node_pool = mempool_create(512, radix_tree_node_pool_alloc,
diff -Nru a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c	Fri Aug  2 15:50:11 2002
+++ b/mm/rmap.c	Fri Aug  2 15:50:11 2002
@@ -400,6 +400,7 @@
 						0,
 						0,
 						NULL,
+						NULL,
 						NULL);
 
 	if (!pte_chain_cache)
diff -Nru a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c	Fri Aug  2 15:50:10 2002
+++ b/mm/shmem.c	Fri Aug  2 15:50:10 2002
@@ -1507,7 +1507,7 @@
 	shmem_inode_cachep = kmem_cache_create("shmem_inode_cache",
 					     sizeof(struct shmem_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     age_icache_memory, init_once, NULL);
 	if (shmem_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/net/atm/clip.c b/net/atm/clip.c
--- a/net/atm/clip.c	Fri Aug  2 15:50:10 2002
+++ b/net/atm/clip.c	Fri Aug  2 15:50:10 2002
@@ -751,5 +751,5 @@
 {
 	clip_tbl.lock = RW_LOCK_UNLOCKED;
 	clip_tbl.kmem_cachep = kmem_cache_create(clip_tbl.id,
-	    clip_tbl.entry_size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	    clip_tbl.entry_size, 0, SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 }
diff -Nru a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
--- a/net/bluetooth/af_bluetooth.c	Fri Aug  2 15:50:10 2002
+++ b/net/bluetooth/af_bluetooth.c	Fri Aug  2 15:50:10 2002
@@ -328,7 +328,7 @@
 	/* Init socket cache */
 	bluez_sock_cache = kmem_cache_create("bluez_sock",
 			sizeof(struct bluez_sock), 0,
-			SLAB_HWCACHE_ALIGN, 0, 0);
+			SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 
 	if (!bluez_sock_cache) {
 		BT_ERR("BlueZ socket cache creation failed");
diff -Nru a/net/core/neighbour.c b/net/core/neighbour.c
--- a/net/core/neighbour.c	Fri Aug  2 15:50:09 2002
+++ b/net/core/neighbour.c	Fri Aug  2 15:50:09 2002
@@ -1146,7 +1146,7 @@
 						     (tbl->entry_size +
 						      15) & ~15,
 						     0, SLAB_HWCACHE_ALIGN,
-						     NULL, NULL);
+						     NULL, NULL, NULL);
 #ifdef CONFIG_SMP
 	tasklet_init(&tbl->gc_task, SMP_TIMER_NAME(neigh_periodic_timer),
 		     (unsigned long)tbl);
diff -Nru a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c	Fri Aug  2 15:50:10 2002
+++ b/net/core/skbuff.c	Fri Aug  2 15:50:10 2002
@@ -1191,7 +1191,7 @@
 					      sizeof(struct sk_buff),
 					      0,
 					      SLAB_HWCACHE_ALIGN,
-					      skb_headerinit, NULL);
+					      NULL, skb_headerinit, NULL);
 	if (!skbuff_head_cache)
 		panic("cannot create skbuff cache");
 
diff -Nru a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c	Fri Aug  2 15:50:10 2002
+++ b/net/core/sock.c	Fri Aug  2 15:50:10 2002
@@ -633,7 +633,7 @@
 void __init sk_init(void)
 {
 	sk_cachep = kmem_cache_create("sock", sizeof(struct sock), 0,
-				      SLAB_HWCACHE_ALIGN, 0, 0);
+				      SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!sk_cachep)
 		printk(KERN_CRIT "sk_init: Cannot create sock SLAB cache!");
 
diff -Nru a/net/decnet/dn_route.c b/net/decnet/dn_route.c
--- a/net/decnet/dn_route.c	Fri Aug  2 15:50:11 2002
+++ b/net/decnet/dn_route.c	Fri Aug  2 15:50:11 2002
@@ -1238,7 +1238,7 @@
 	dn_dst_ops.kmem_cachep = kmem_cache_create("dn_dst_cache",
 						   sizeof(struct dn_route),
 						   0, SLAB_HWCACHE_ALIGN,
-						   NULL, NULL);
+						   NULL, NULL, NULL);
 
 	if (!dn_dst_ops.kmem_cachep)
 		panic("DECnet: Failed to allocate dn_dst_cache\n");
diff -Nru a/net/decnet/dn_table.c b/net/decnet/dn_table.c
--- a/net/decnet/dn_table.c	Fri Aug  2 15:50:10 2002
+++ b/net/decnet/dn_table.c	Fri Aug  2 15:50:10 2002
@@ -888,7 +888,7 @@
 	dn_hash_kmem = kmem_cache_create("dn_fib_info_cache",
 					sizeof(struct dn_fib_info),
 					0, SLAB_HWCACHE_ALIGN,
-					NULL, NULL);
+					NULL, NULL, NULL);
 }
 
 void __exit dn_fib_table_cleanup(void)
diff -Nru a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Fri Aug  2 15:50:09 2002
+++ b/net/ipv4/af_inet.c	Fri Aug  2 15:50:09 2002
@@ -1142,13 +1142,13 @@
 
 	tcp_sk_cachep = kmem_cache_create("tcp_sock",
 					  sizeof(struct tcp_sock), 0,
-					  SLAB_HWCACHE_ALIGN, 0, 0);
+					  SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	udp_sk_cachep = kmem_cache_create("udp_sock",
 					  sizeof(struct udp_sock), 0,
-					  SLAB_HWCACHE_ALIGN, 0, 0);
+					  SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	raw4_sk_cachep = kmem_cache_create("raw4_sock",
 					   sizeof(struct raw_sock), 0,
-					   SLAB_HWCACHE_ALIGN, 0, 0);
+					   SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!tcp_sk_cachep || !udp_sk_cachep || !raw4_sk_cachep)
 		printk(KERN_CRIT
 		       "inet_init: Can't create protocol sock SLAB caches!\n");
diff -Nru a/net/ipv4/fib_hash.c b/net/ipv4/fib_hash.c
--- a/net/ipv4/fib_hash.c	Fri Aug  2 15:50:10 2002
+++ b/net/ipv4/fib_hash.c	Fri Aug  2 15:50:10 2002
@@ -899,7 +899,7 @@
 		fn_hash_kmem = kmem_cache_create("ip_fib_hash",
 						 sizeof(struct fib_node),
 						 0, SLAB_HWCACHE_ALIGN,
-						 NULL, NULL);
+						 NULL, NULL, NULL);
 
 	tb = kmalloc(sizeof(struct fib_table) + sizeof(struct fn_hash), GFP_KERNEL);
 	if (tb == NULL)
diff -Nru a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
--- a/net/ipv4/inetpeer.c	Fri Aug  2 15:50:10 2002
+++ b/net/ipv4/inetpeer.c	Fri Aug  2 15:50:10 2002
@@ -125,7 +125,7 @@
 	peer_cachep = kmem_cache_create("inet_peer_cache",
 			sizeof(struct inet_peer),
 			0, SLAB_HWCACHE_ALIGN,
-			NULL, NULL);
+			NULL, NULL, NULL);
 
 	/* All the timers, started at system startup tend
 	   to synchronize. Perturb it a bit.
diff -Nru a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
--- a/net/ipv4/ipmr.c	Fri Aug  2 15:50:10 2002
+++ b/net/ipv4/ipmr.c	Fri Aug  2 15:50:10 2002
@@ -1750,7 +1750,7 @@
 	mrt_cachep = kmem_cache_create("ip_mrt_cache",
 				       sizeof(struct mfc_cache),
 				       0, SLAB_HWCACHE_ALIGN,
-				       NULL, NULL);
+				       NULL, NULL, NULL);
 	init_timer(&ipmr_expire_timer);
 	ipmr_expire_timer.function=ipmr_expire_process;
 	register_netdevice_notifier(&ip_mr_notifier);
diff -Nru a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
--- a/net/ipv4/netfilter/ip_conntrack_core.c	Fri Aug  2 15:50:09 2002
+++ b/net/ipv4/netfilter/ip_conntrack_core.c	Fri Aug  2 15:50:09 2002
@@ -1352,7 +1352,7 @@
 
 	ip_conntrack_cachep = kmem_cache_create("ip_conntrack",
 	                                        sizeof(struct ip_conntrack), 0,
-	                                        SLAB_HWCACHE_ALIGN, NULL, NULL);
+	                                        SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
 	if (!ip_conntrack_cachep) {
 		printk(KERN_ERR "Unable to create ip_conntrack slab cache\n");
 		vfree(ip_conntrack_hash);
diff -Nru a/net/ipv4/route.c b/net/ipv4/route.c
--- a/net/ipv4/route.c	Fri Aug  2 15:50:11 2002
+++ b/net/ipv4/route.c	Fri Aug  2 15:50:11 2002
@@ -2467,7 +2467,7 @@
 	ipv4_dst_ops.kmem_cachep = kmem_cache_create("ip_dst_cache",
 						     sizeof(struct rtable),
 						     0, SLAB_HWCACHE_ALIGN,
-						     NULL, NULL);
+						     NULL, NULL, NULL);
 
 	if (!ipv4_dst_ops.kmem_cachep)
 		panic("IP: failed to allocate ip_dst_cache\n");
diff -Nru a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c	Fri Aug  2 15:50:10 2002
+++ b/net/ipv4/tcp.c	Fri Aug  2 15:50:10 2002
@@ -2569,21 +2569,21 @@
 	tcp_openreq_cachep = kmem_cache_create("tcp_open_request",
 						   sizeof(struct open_request),
 					       0, SLAB_HWCACHE_ALIGN,
-					       NULL, NULL);
+					       NULL, NULL, NULL);
 	if (!tcp_openreq_cachep)
 		panic("tcp_init: Cannot alloc open_request cache.");
 
 	tcp_bucket_cachep = kmem_cache_create("tcp_bind_bucket",
 					      sizeof(struct tcp_bind_bucket),
 					      0, SLAB_HWCACHE_ALIGN,
-					      NULL, NULL);
+					      NULL, NULL, NULL);
 	if (!tcp_bucket_cachep)
 		panic("tcp_init: Cannot alloc tcp_bind_bucket cache.");
 
 	tcp_timewait_cachep = kmem_cache_create("tcp_tw_bucket",
 						sizeof(struct tcp_tw_bucket),
 						0, SLAB_HWCACHE_ALIGN,
-						NULL, NULL);
+						NULL, NULL, NULL);
 	if (!tcp_timewait_cachep)
 		panic("tcp_init: Cannot alloc tcp_tw_bucket cache.");
 
diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	Fri Aug  2 15:50:10 2002
+++ b/net/ipv6/af_inet6.c	Fri Aug  2 15:50:10 2002
@@ -655,13 +655,13 @@
 	/* allocate our sock slab caches */
         tcp6_sk_cachep = kmem_cache_create("tcp6_sock",
 					   sizeof(struct tcp6_sock), 0,
-                                           SLAB_HWCACHE_ALIGN, 0, 0);
+                                           SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
         udp6_sk_cachep = kmem_cache_create("udp6_sock",
 					   sizeof(struct udp6_sock), 0,
-                                           SLAB_HWCACHE_ALIGN, 0, 0);
+                                           SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
         raw6_sk_cachep = kmem_cache_create("raw6_sock",
 					   sizeof(struct raw6_sock), 0,
-                                           SLAB_HWCACHE_ALIGN, 0, 0);
+                                           SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
         if (!tcp6_sk_cachep || !udp6_sk_cachep || !raw6_sk_cachep)
                 printk(KERN_CRIT __FUNCTION__
                         ": Can't create protocol sock SLAB caches!\n");
diff -Nru a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
--- a/net/ipv6/ip6_fib.c	Fri Aug  2 15:50:10 2002
+++ b/net/ipv6/ip6_fib.c	Fri Aug  2 15:50:10 2002
@@ -1218,7 +1218,7 @@
 		fib6_node_kmem = kmem_cache_create("fib6_nodes",
 						   sizeof(struct fib6_node),
 						   0, SLAB_HWCACHE_ALIGN,
-						   NULL, NULL);
+						   NULL, NULL, NULL);
 }
 
 #ifdef MODULE
diff -Nru a/net/ipv6/route.c b/net/ipv6/route.c
--- a/net/ipv6/route.c	Fri Aug  2 15:50:10 2002
+++ b/net/ipv6/route.c	Fri Aug  2 15:50:10 2002
@@ -1919,7 +1919,7 @@
 	ip6_dst_ops.kmem_cachep = kmem_cache_create("ip6_dst_cache",
 						     sizeof(struct rt6_info),
 						     0, SLAB_HWCACHE_ALIGN,
-						     NULL, NULL);
+						     NULL, NULL, NULL);
 	fib6_init();
 #ifdef 	CONFIG_PROC_FS
 	proc_net_create("ipv6_route", 0, rt6_proc_info);
diff -Nru a/net/ipx/af_spx.c b/net/ipx/af_spx.c
--- a/net/ipx/af_spx.c	Fri Aug  2 15:50:10 2002
+++ b/net/ipx/af_spx.c	Fri Aug  2 15:50:10 2002
@@ -873,7 +873,7 @@
         spx_family_ops.sk_cachep = kmem_cache_create("spx_sock",
                                                       spx_family_ops.sk_size,
                                                       0, SLAB_HWCACHE_ALIGN,
-                                                      0, 0);
+                                                      NULL, NULL, NULL);
         if (!spx_family_ops.sk_cachep)
                 printk(KERN_CRIT __FUNCTION__
                         ": Cannot create spx_sock SLAB cache!\n");
diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c	Fri Aug  2 15:50:10 2002
+++ b/net/socket.c	Fri Aug  2 15:50:10 2002
@@ -305,7 +305,7 @@
 	sock_inode_cachep = kmem_cache_create("sock_inode_cache",
 					     sizeof(struct socket_alloc),
 					     0, SLAB_HWCACHE_ALIGN,
-					     init_once, NULL);
+					     NULL, init_once, NULL);
 	if (sock_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
diff -Nru a/net/unix/af_unix.c b/net/unix/af_unix.c
--- a/net/unix/af_unix.c	Fri Aug  2 15:50:10 2002
+++ b/net/unix/af_unix.c	Fri Aug  2 15:50:10 2002
@@ -1885,7 +1885,7 @@
         /* allocate our sock slab cache */
         unix_sk_cachep = kmem_cache_create("unix_sock",
 					   sizeof(struct unix_sock), 0,
-					   SLAB_HWCACHE_ALIGN, 0, 0);
+					   SLAB_HWCACHE_ALIGN, NULL, NULL, NULL);
         if (!unix_sk_cachep)
                 printk(KERN_CRIT
                         "af_unix_init: Cannot create unix_sock SLAB cache!\n");

--------


