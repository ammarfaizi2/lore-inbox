Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVJZEDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVJZEDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 00:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVJZEDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 00:03:11 -0400
Received: from [59.92.143.111] ([59.92.143.111]:4740 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932528AbVJZEDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 00:03:11 -0400
Date: Wed, 26 Oct 2005 09:32:37 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: [PATCH] slab cache shrinker statistics
Message-ID: <20051026040237.GB5103@in.ibm.com>
Reply-To: bharata@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,

Could you please consider including this patch into your mm tree ?

This patch collects data about how a shrinkable cache is behaving
over time. The number of objects scanned for shrinking
the cache and the actual number of objects freed are reported by
this patch as part of /proc/slabinfo. I have verified that adding
addtional elements to /proc/slabinfo isn't breaking slabtop.

I have made this patch on suggestions from Marcelo and he feels that
it is useful to have this in mm/mainline. This work started as an attempt
to break the slabs_scanned(from /proc/vmstat) into meaningful pieces
to reflect how individual cache behaves wrt memory reclaim.

A typical output from /proc/slabinfo after this patch looks like this:

[root@llm09 ~]# grep shrinker /proc/slabinfo
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>
 : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_s
labs> <sharedavail> : shrinker stat <nr requested> <nr freed>
ext3_xattr             0      0     48   78    1 : tunables  120   60    8 : sla
bdata      0      0      0 : shrinker stat       0       0
d_cursor               0      0     64   59    1 : tunables  120   60    8 : sla
bdata      0      0      0 : shrinker stat       0       0
dquot                  0      0    160   24    1 : tunables  120   60    8 : sla
bdata      0      0      0 : shrinker stat       0       0
inode_cache         1262   1400    400   10    1 : tunables   54   27    8 : sla
bdata    140    140      0 : shrinker stat  376704  380400
dentry_cache       10449  10504    152   26    1 : tunables  120   60    8 : sla
bdata    404    404      0 : shrinker stat  859136  401700

Note: mbcache maintains multiple caches with a single shrinker routine.
Hence with this patch, all caches which are part of mbcache (like ext3_xattr
above) will display the combined shrinker statistics of mbcache and not
the shrinker attempts of individual caches. Or should I just drop the
stats collection from mbcache ?

Regards,
Bharata.

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cache_shrink_stats.patch"


This patch adds two more fields to each entry of shrinkable cache
in /proc/slabinfo: the number of objects scanned for freeing and the
actual number of objects freed.

Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 fs/dcache.c          |    4 +++-
 fs/dquot.c           |    4 +++-
 fs/inode.c           |    4 +++-
 fs/mbcache.c         |    2 ++
 fs/reiser4/fsdata.c  |    2 ++
 include/linux/mm.h   |   39 ++++++++++++++++++++++++++++++++++++++-
 include/linux/slab.h |    3 +++
 mm/slab.c            |   16 ++++++++++++++++
 mm/vmscan.c          |   23 +++++++++++------------
 9 files changed, 81 insertions(+), 16 deletions(-)

diff -puN fs/dcache.c~cache_shrink_stats fs/dcache.c
--- linux-2.6.14-rc5-mm1/fs/dcache.c~cache_shrink_stats	2005-10-25 14:12:28.179785552 +0530
+++ linux-2.6.14-rc5-mm1-bharata/fs/dcache.c	2005-10-25 14:12:28.247775216 +0530
@@ -1832,6 +1832,7 @@ static void __init dcache_init_early(voi
 static void __init dcache_init(unsigned long mempages)
 {
 	int loop;
+	struct shrinker *shrinker;
 
 	/* 
 	 * A constructor could be added for stable state like the lists,
@@ -1844,7 +1845,8 @@ static void __init dcache_init(unsigned 
 					 SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
 					 NULL, NULL);
 	
-	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
+	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
+	kmem_set_shrinker(dentry_cache, shrinker);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff -puN fs/dquot.c~cache_shrink_stats fs/dquot.c
--- linux-2.6.14-rc5-mm1/fs/dquot.c~cache_shrink_stats	2005-10-25 14:12:28.183784944 +0530
+++ linux-2.6.14-rc5-mm1-bharata/fs/dquot.c	2005-10-25 14:12:28.249774912 +0530
@@ -1793,6 +1793,7 @@ static int __init dquot_init(void)
 {
 	int i;
 	unsigned long nr_hash, order;
+	struct shrinker *shrinker;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
@@ -1824,7 +1825,8 @@ static int __init dquot_init(void)
 	printk("Dquot-cache hash table entries: %ld (order %ld, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));
 
-	set_shrinker(DEFAULT_SEEKS, shrink_dqcache_memory);
+	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_dqcache_memory);
+	kmem_set_shrinker(dquot_cachep, shrinker);
 
 	return 0;
 }
diff -puN fs/inode.c~cache_shrink_stats fs/inode.c
--- linux-2.6.14-rc5-mm1/fs/inode.c~cache_shrink_stats	2005-10-25 14:12:28.201782208 +0530
+++ linux-2.6.14-rc5-mm1-bharata/fs/inode.c	2005-10-25 14:12:28.251774608 +0530
@@ -1357,11 +1357,13 @@ void __init inode_init_early(void)
 void __init inode_init(unsigned long mempages)
 {
 	int loop;
+	struct shrinker *shrinker;
 
 	/* inode slab cache */
 	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
 				0, SLAB_RECLAIM_ACCOUNT|SLAB_PANIC, init_once, NULL);
-	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
+	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
+	kmem_set_shrinker(inode_cachep, shrinker);
 
 	/* Hash may have been set up in inode_init_early */
 	if (!hashdist)
diff -puN fs/mbcache.c~cache_shrink_stats fs/mbcache.c
--- linux-2.6.14-rc5-mm1/fs/mbcache.c~cache_shrink_stats	2005-10-25 14:12:28.204781752 +0530
+++ linux-2.6.14-rc5-mm1-bharata/fs/mbcache.c	2005-10-25 14:12:28.252774456 +0530
@@ -292,6 +292,8 @@ mb_cache_create(const char *name, struct
 	if (!cache->c_entry_cache)
 		goto fail;
 
+	kmem_set_shrinker(cache->c_entry_cache, mb_shrinker);
+
 	spin_lock(&mb_cache_spinlock);
 	list_add(&cache->c_cache_list, &mb_cache_list);
 	spin_unlock(&mb_cache_spinlock);
diff -puN fs/reiser4/fsdata.c~cache_shrink_stats fs/reiser4/fsdata.c
--- linux-2.6.14-rc5-mm1/fs/reiser4/fsdata.c~cache_shrink_stats	2005-10-25 14:12:28.209780992 +0530
+++ linux-2.6.14-rc5-mm1-bharata/fs/reiser4/fsdata.c	2005-10-25 14:12:28.267772176 +0530
@@ -4,6 +4,7 @@
 #include "fsdata.h"
 #include "inode.h"
 
+#include <linux/slab.h>
 
 /* cache or dir_cursors */
 static kmem_cache_t *d_cursor_cache;
@@ -72,6 +73,7 @@ int init_d_cursor(void)
 	 */
 	d_cursor_shrinker = set_shrinker(DEFAULT_SEEKS << 3,
 					 d_cursor_shrink);
+	kmem_set_shrinker(d_cursor_cache, d_cursor_shrinker);
 	if (d_cursor_shrinker == NULL) {
 		destroy_reiser4_cache(&d_cursor_cache);
 		d_cursor_cache = NULL;
diff -puN include/linux/mm.h~cache_shrink_stats include/linux/mm.h
--- linux-2.6.14-rc5-mm1/include/linux/mm.h~cache_shrink_stats	2005-10-25 14:12:28.212780536 +0530
+++ linux-2.6.14-rc5-mm1-bharata/include/linux/mm.h	2005-10-25 14:12:28.254774152 +0530
@@ -759,7 +759,44 @@ typedef int (*shrinker_t)(int nr_to_scan
  */
 
 #define DEFAULT_SEEKS 2
-struct shrinker;
+
+struct shrinker_stats {
+	unsigned long nr_req; /* objs scanned for possible freeing */
+	unsigned long nr_freed; /* actual number of objects freed */
+};
+
+/*
+ * The list of shrinker callbacks used by to apply pressure to
+ * ageable caches.
+ */
+struct shrinker {
+	shrinker_t		shrinker;
+	struct list_head	list;
+	int			seeks;	/* seeks to recreate an obj */
+	long			nr;	/* objs pending delete */
+	struct shrinker_stats	*s_stats;
+};
+
+#define shrinker_stat_add(shrinker, field, addnd)		\
+	do {							\
+		preempt_disable();				\
+		(per_cpu_ptr(shrinker->s_stats,			\
+			smp_processor_id())->field += addnd);	\
+		preempt_enable();				\
+	} while (0)
+
+#define shrinker_stat_read(shrinker, field)				\
+({									\
+	typeof(shrinker->s_stats->field) res = 0;			\
+	int i;								\
+	for (i=0; i < NR_CPUS; i++) {					\
+		if (!cpu_possible(i))					\
+			continue;					\
+		res += per_cpu_ptr(shrinker->s_stats, i)->field;	\
+	}								\
+	res;								\
+})
+
 extern struct shrinker *set_shrinker(int, shrinker_t);
 extern void remove_shrinker(struct shrinker *shrinker);
 
diff -puN include/linux/slab.h~cache_shrink_stats include/linux/slab.h
--- linux-2.6.14-rc5-mm1/include/linux/slab.h~cache_shrink_stats	2005-10-25 14:12:28.215780080 +0530
+++ linux-2.6.14-rc5-mm1-bharata/include/linux/slab.h	2005-10-25 14:12:28.260773240 +0530
@@ -150,6 +150,9 @@ extern kmem_cache_t	*bio_cachep;
 
 extern atomic_t slab_reclaim_pages;
 
+struct shrinker;
+extern void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker);
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
diff -puN mm/slab.c~cache_shrink_stats mm/slab.c
--- linux-2.6.14-rc5-mm1/mm/slab.c~cache_shrink_stats	2005-10-25 14:12:28.220779320 +0530
+++ linux-2.6.14-rc5-mm1-bharata/mm/slab.c	2005-10-25 14:12:28.264772632 +0530
@@ -401,6 +401,9 @@ struct kmem_cache_s {
 	/* de-constructor func */
 	void (*dtor)(void *, kmem_cache_t *, unsigned long);
 
+	/* shrinker data for this cache */
+	struct shrinker *shrinker;
+
 /* 4) cache creation/removal */
 	const char		*name;
 	struct list_head	next;
@@ -3386,6 +3389,7 @@ static void *s_start(struct seq_file *m,
 				" <error> <maxfreeable> <nodeallocs> <remotefrees>");
 		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
+		seq_puts(m, " : shrinker stat <nr requested> <nr freed>");
 		seq_putc(m, '\n');
 	}
 	p = cache_chain.next;
@@ -3506,6 +3510,12 @@ static int s_show(struct seq_file *m, vo
 			allochit, allocmiss, freehit, freemiss);
 	}
 #endif
+	/* shrinker stats */
+	if (cachep->shrinker) {
+		seq_printf(m, " : shrinker stat %7lu %7lu",
+			shrinker_stat_read(cachep->shrinker, nr_req),
+			shrinker_stat_read(cachep->shrinker, nr_freed));
+	}
 	seq_putc(m, '\n');
 	spin_unlock_irq(&cachep->spinlock);
 	return 0;
@@ -3660,3 +3670,9 @@ char *kstrdup(const char *s, gfp_t gfp)
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
+
+void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker)
+{
+	cachep->shrinker = shrinker;
+}
+EXPORT_SYMBOL(kmem_set_shrinker);
diff -puN mm/vmscan.c~cache_shrink_stats mm/vmscan.c
--- linux-2.6.14-rc5-mm1/mm/vmscan.c~cache_shrink_stats	2005-10-25 14:12:28.223778864 +0530
+++ linux-2.6.14-rc5-mm1-bharata/mm/vmscan.c	2005-10-25 14:12:28.266772328 +0530
@@ -84,17 +84,6 @@ struct scan_control {
 	int swap_cluster_max;
 };
 
-/*
- * The list of shrinker callbacks used by to apply pressure to
- * ageable caches.
- */
-struct shrinker {
-	shrinker_t		shrinker;
-	struct list_head	list;
-	int			seeks;	/* seeks to recreate an obj */
-	long			nr;	/* objs pending delete */
-};
-
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
 #ifdef ARCH_HAS_PREFETCH
@@ -146,6 +135,11 @@ struct shrinker *set_shrinker(int seeks,
 	        shrinker->shrinker = theshrinker;
 	        shrinker->seeks = seeks;
 	        shrinker->nr = 0;
+		shrinker->s_stats = alloc_percpu(struct shrinker_stats);
+		if (!shrinker->s_stats) {
+			kfree(shrinker);
+			return NULL;
+		}
 	        down_write(&shrinker_rwsem);
 	        list_add_tail(&shrinker->list, &shrinker_list);
 	        up_write(&shrinker_rwsem);
@@ -162,6 +156,7 @@ void remove_shrinker(struct shrinker *sh
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
+	free_percpu(shrinker->s_stats);
 	kfree(shrinker);
 }
 EXPORT_SYMBOL(remove_shrinker);
@@ -221,8 +216,12 @@ static int shrink_slab(unsigned long sca
 			shrink_ret = (*shrinker->shrinker)(this_scan, gfp_mask);
 			if (shrink_ret == -1)
 				break;
-			if (shrink_ret < nr_before)
+			if (shrink_ret < nr_before) {
 				ret += nr_before - shrink_ret;
+				shrinker_stat_add(shrinker, nr_freed,
+					(nr_before - shrink_ret));
+			}
+			shrinker_stat_add(shrinker, nr_req, this_scan);
 			mod_page_state(slabs_scanned, this_scan);
 			total_scan -= this_scan;
 
_

--qMm9M+Fa2AknHoGS--
