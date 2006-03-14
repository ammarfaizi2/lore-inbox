Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752254AbWCNRCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbWCNRCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbWCNRCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:02:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44956 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752260AbWCNRCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:02:05 -0500
Date: Tue, 14 Mar 2006 12:01:53 -0500
From: Dave Jones <davej@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: signal_cache slab corruption.
Message-ID: <20060314170153.GB32080@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hugh Dickins <hugh@veritas.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060313181524.GA26234@redhat.com> <Pine.LNX.4.61.0603140921270.5164@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603140921270.5164@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 09:22:35AM +0000, Hugh Dickins wrote:
 > On Mon, 13 Mar 2006, Dave Jones wrote:
 > 
 > > I got into the office today to find my workstation that was running
 > > a kernel based on .16rc5-git9 was totally unresponsive.
 > > After rebooting, I found this in the logs.
 > > 
 > > slab signal_cache: invalid slab found in partial list at ffff8100e3a48080 (11/11).
 > > slab signal_cache: invalid slab found in partial list at ffff81007ecc6100 (11/11).
 > > slab: Internal list corruption detected in cache 'signal_cache'(11), slabp ffff810037ec0998(12). Hexdump:
 > > 
 > > 000: c0 60 d9 7e 00 81 ff ff 00 61 cc 7e 00 81 ff ff
 > > 010: a8 09 ec 37 00 81 ff ff a8 09 ec 37 00 81 ff ff
 > > 020: 0c 00 00 00 00 00 00 00 57 d0 1d 07 01 00 00 00
 > > 030: 00 00 00 00
 > > ----------- [cut here ] --------- [please bite here ] ---------
 > > Kernel BUG at mm/slab.c:2598
 > 
 > Dave, please post the diff -u between your mm/slab.c and the -rc5-git9
 > mm/slab.c (or any other vanilla version): you've got your own debugging
 > enabled, which means we can't decipher this properly.  (Not that I'm
 > expecting to do any better myself than with previous slab corruptions.)

The big diff is the 'check redzone of unfreed slabs every 5s' patch.
Other than that, there's just the single-bit corruption detector.

		Dave

--- 16/mm/slab.c	2006-03-13 16:40:07.000000000 -0500
+++ linux-2.6.15.noarch/mm/slab.c	2006-03-14 12:00:17.000000000 -0500
@@ -202,7 +202,7 @@
 
 typedef unsigned int kmem_bufctl_t;
 #define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
-#define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
+#define BUFCTL_ALLOC	(((kmem_bufctl_t)(~0U))-1)
 #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
 
 /* Max number of objs-per-slab for caches which use off-slab slabs.
@@ -431,6 +431,11 @@ struct kmem_cache {
 	 */
 	int obj_offset;
 	int obj_size;
+
+	/*
+	 * Time for next cache verification.
+	 */
+	unsigned long next_verify;
 #endif
 };
 
@@ -446,6 +451,7 @@ struct kmem_cache {
  */
 #define REAPTIMEOUT_CPUC	(2*HZ)
 #define REAPTIMEOUT_LIST3	(4*HZ)
+#define REDZONETIMEOUT		(300*HZ)
 
 #if STATS
 #define	STATS_INC_ACTIVE(x)	((x)->num_active++)
@@ -1488,11 +1494,33 @@ static void poison_obj(struct kmem_cache
 static void dump_line(char *data, int offset, int limit)
 {
 	int i;
+	unsigned char total=0, bad_count=0;
 	printk(KERN_ERR "%03x:", offset);
 	for (i = 0; i < limit; i++) {
+		if (data[offset+i] != POISON_FREE) {
+			total += data[offset+i];
+			++bad_count;
+		}
 		printk(" %02x", (unsigned char)data[offset + i]);
 	}
 	printk("\n");
+	if (bad_count == 1) {
+		switch (total) {
+		case POISON_FREE ^ 0x01:
+		case POISON_FREE ^ 0x02:
+		case POISON_FREE ^ 0x04:
+		case POISON_FREE ^ 0x08:
+		case POISON_FREE ^ 0x10:
+		case POISON_FREE ^ 0x20:
+		case POISON_FREE ^ 0x40:
+		case POISON_FREE ^ 0x80:
+			printk (KERN_ERR "Single bit error detected. Possibly bad RAM.\n");
+#ifdef CONFIG_X86
+			printk (KERN_ERR "Run memtest86 or other memory test tool.\n");
+#endif
+			return;
+		}
+	}
 }
 #endif
 
@@ -1546,9 +1574,10 @@ static void check_poison_obj(struct kmem
 			/* Print header */
 			if (lines == 0) {
 				printk(KERN_ERR
-				       "Slab corruption: start=%p, len=%d\n",
-				       realobj, size);
+				       "Slab corruption: (%s) start=%p, len=%d\n",
+				       print_tainted(), realobj, size);
 				print_objinfo(cachep, objp, 0);
+				dump_stack();
 			}
 			/* Hexdump the affected line */
 			i = (i / 16) * 16;
@@ -2043,6 +2072,11 @@ kmem_cache_create (const char *name, siz
 		cachep->limit = BOOT_CPUCACHE_ENTRIES;
 	}
 
+#if DEBUG
+	cachep->next_verify = jiffies + REDZONETIMEOUT +
+		((unsigned long)cachep/L1_CACHE_BYTES)%REDZONETIMEOUT;
+#endif
+
 	/* cache setup completed, link it into the list */
 	list_add(&cachep->next, &cache_chain);
       oops:
@@ -2369,7 +2403,7 @@ static void *slab_get_obj(struct kmem_ca
 	slabp->inuse++;
 	next = slab_bufctl(slabp)[slabp->free];
 #if DEBUG
-	slab_bufctl(slabp)[slabp->free] = BUFCTL_FREE;
+	slab_bufctl(slabp)[slabp->free] = BUFCTL_ALLOC;
 	WARN_ON(slabp->nodeid != nodeid);
 #endif
 	slabp->free = next;
@@ -2386,7 +2420,7 @@ static void slab_put_obj(struct kmem_cac
 	/* Verify that the slab belongs to the intended node */
 	WARN_ON(slabp->nodeid != nodeid);
 
-	if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
+	if (slab_bufctl(slabp)[objnr] != BUFCTL_ALLOC) {
 		printk(KERN_ERR "slab: double free detected in cache "
 		       "'%s', objp %p\n", cachep->name, objp);
 		BUG();
@@ -3384,6 +3418,116 @@ static int alloc_kmemlist(struct kmem_ca
 	return err;
 }
 
+#if DEBUG
+
+static void verify_slab_redzone(struct kmem_cache *cache, struct slab *slab)
+{
+	int i;
+
+	if (!(cache->flags & SLAB_RED_ZONE))
+		return;
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	/* Page alloc debugging on for this cache. Mapping & Unmapping happens
+	 * without any locking, thus parallel checks are impossible.
+	 */
+	if ((cache->buffer_size % PAGE_SIZE) == 0 && OFF_SLAB(cache))
+		return;
+#endif
+
+	for (i = 0; i < cache->num; i++) {
+		unsigned long red1, red2;
+		void *obj = slab->s_mem + cache->buffer_size * i;
+
+		red1 = *dbg_redzone1(cache, obj);
+		red2 = *dbg_redzone2(cache, obj);
+
+		/* Simplest case: redzones marked as inactive.  */
+		if (red1 == RED_INACTIVE && red2 == RED_INACTIVE)
+			continue;
+
+		/*
+		 * Tricky case: if the bufctl value is BUFCTL_ALLOC, then
+		 * the object is either allocated or somewhere in a cpu
+		 * cache. The cpu caches are lockless and there might be
+		 * a concurrent alloc/free call, thus we must accept random
+		 * combinations of RED_ACTIVE and _INACTIVE
+		 */
+		if (slab_bufctl(slab)[i] == BUFCTL_ALLOC &&
+				(red1 == RED_INACTIVE || red1 == RED_ACTIVE) &&
+				(red2 == RED_INACTIVE || red2 == RED_ACTIVE))
+			continue;
+
+		printk(KERN_ERR "slab %s: redzone mismatch in slab %p,"
+		       " obj %p, bufctl 0x%lx\n", cache->name, slab, obj,
+		       slab_bufctl(slab)[i]);
+
+		print_objinfo(cache, obj, 2);
+	}
+}
+
+static void print_invalid_slab(const char *list_name, struct kmem_cache *cache,
+			       struct slab *slab)
+{
+	printk(KERN_ERR "slab %s: invalid slab found in %s list at %p (%d/%d).\n",
+	       cache->name, list_name, slab, slab->inuse, cache->num);
+}
+
+static void verify_nodelists(struct kmem_cache *cache,
+			     struct kmem_list3 *lists)
+{
+	struct list_head *q;
+	struct slab *slab;
+
+	list_for_each(q, &lists->slabs_full) {
+		slab = list_entry(q, struct slab, list);
+
+		if (slab->inuse != cache->num)
+			print_invalid_slab("full", cache, slab);
+
+		check_slabp(cache, slab);
+		verify_slab_redzone(cache, slab);
+	}
+	list_for_each(q, &lists->slabs_partial) {
+		slab = list_entry(q, struct slab, list);
+
+		if (slab->inuse == cache->num || slab->inuse == 0)
+			print_invalid_slab("partial", cache, slab);
+
+		check_slabp(cache, slab);
+		verify_slab_redzone(cache, slab);
+	}
+	list_for_each(q, &lists->slabs_free) {
+		slab = list_entry(q, struct slab, list);
+
+		if (slab->inuse != 0)
+			print_invalid_slab("free", cache, slab);
+
+		check_slabp(cache, slab);
+		verify_slab_redzone(cache, slab);
+	}
+}
+
+/*
+ * Perform a self test on all slabs from a cache
+ */
+static void verify_cache(struct kmem_cache *cache)
+{
+	int node;
+
+	check_spinlock_acquired(cache);
+
+	for_each_online_node(node) {
+		struct kmem_list3 *lists = cache->nodelists[node];
+
+		if (!lists)
+			continue;
+		verify_nodelists(cache, lists);
+	}
+}
+
+#endif
+
 struct ccupdate_struct {
 	struct kmem_cache *cachep;
 	struct array_cache *new[NR_CPUS];
@@ -3563,6 +3707,13 @@ static void cache_reap(void *unused)
 		drain_array_locked(searchp, cpu_cache_get(searchp), 0,
 				   numa_node_id());
 
+#if DEBUG
+		if (time_before(searchp->next_verify, jiffies)) {
+			searchp->next_verify = jiffies + REDZONETIMEOUT;
+			verify_cache(searchp);
+		}
+#endif
+
 		if (time_after(l3->next_reap, jiffies))
 			goto next_unlock;
 



-- 
http://www.codemonkey.org.uk
