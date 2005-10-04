Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVJDNgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVJDNgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVJDNgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:36:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:1499 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932347AbVJDNgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:36:50 -0400
Date: Tue, 4 Oct 2005 19:06:35 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Marcelo <marcelo.tosatti@cyclades.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: shrinkable cache statistics [was Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough]
Message-ID: <20051004133635.GA23575@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050914230843.GA11748@dmt.cnet> <20050915093945.GD3869@in.ibm.com> <20050915132910.GA6806@dmt.cnet> <20051002163229.GB5190@in.ibm.com> <20051002200640.GB9865@xeon.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20051002200640.GB9865@xeon.cnet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Marcelo,

Here's my next attempt in breaking the "slabs_scanned" from /proc/vmstat
into meaningful per cache statistics. Now I have the statistics counters
as percpu. [an issue remaining is that there are more than one cache as
part of mbcache and they all have a common shrinker routine and I am
displaying the collective shrinker stats info on each of them in
/proc/slabinfo ==> some kind of duplication]

With this patch (and my earlier dcache stats patch) I observed some
interesting results with the following test scenario on a 8cpu p3 box:

- Ran an application which consumes 40% of the total memory.
- Ran dbench on tmpfs with 128 clients twice (serially).
- Ran a find on a ext3 partition having ~9.5million entries (files and
  directories included)

At the end of this run, I have the following results:

[root@llm09 bharata]# cat /proc/meminfo
MemTotal:      3872528 kB
MemFree:       1420940 kB
Buffers:        714068 kB
Cached:          21536 kB
SwapCached:       2264 kB
Active:        1672680 kB
Inactive:       637460 kB
HighTotal:     3014616 kB
HighFree:      1411740 kB
LowTotal:       857912 kB
LowFree:          9200 kB
SwapTotal:     2096472 kB
SwapFree:      2051408 kB
Dirty:             172 kB
Writeback:           0 kB
Mapped:        1583680 kB
Slab:           119564 kB
CommitLimit:   4032736 kB
Committed_AS:  1647260 kB
PageTables:       2248 kB
VmallocTotal:   114680 kB
VmallocUsed:      1264 kB
VmallocChunk:   113384 kB
nr_dentries/page        nr_pages        nr_inuse
         0              0               0
         1              5               2
         2              12              4
         3              26              9
         4              46              18
         5              76              40
         6              82              47
         7              91              59
         8              122             93
         9              114             102
        10              142             136
        11              138             185
        12              118             164
        13              128             206
        14              126             208
        15              120             219
        16              136             261
        17              159             315
        18              145             311
        19              179             379
        20              192             407
        21              256             631
        22              286             741
        23              316             816
        24              342             934
        25              381             1177
        26              664             2813
        27              0               0
        28              0               0
        29              0               0
Total:                  4402            10277
dcache lru: total 75369 inuse 3599

[Here,
nr_dentries/page - Number of dentries per page
nr_pages - Number of pages with given number of dentries
nr_inuse - Number of inuse dentries in those pages.
Eg: From the above data, there are 26 pages with 3 dentries each
and out of 78 total dentries in these 3 pages, 9 dentries are in use.]

[root@llm09 bharata]# grep shrinker /proc/slabinfo
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : shrinker stat <nr requested> <nr freed>
ext3_xattr             0      0     48   78    1 : tunables  120   60    8 : slabdata      0      0      0 : shrinker stat       0       0
dquot                  0      0    160   24    1 : tunables  120   60    8 : slabdata      0      0      0 : shrinker stat       0       0
inode_cache         1301   1390    400   10    1 : tunables   54   27    8 : slabdata    139    139      0 : shrinker stat  682752  681900
dentry_cache       82110 114452    152   26    1 : tunables  120   60    8 : slabdata   4402   4402      0 : shrinker stat 1557760  760100

[root@llm09 bharata]# grep slabs_scanned /proc/vmstat
slabs_scanned 2240512

[root@llm09 bharata]# cat /proc/sys/fs/dentry-state
82046   75369   45      0       3599    0
[The order of dentry-state o/p is like this:
total dentries in dentry hash list, total dentries in lru list, age limit,
want_pages, inuse dentries in lru list, dummy]

So, we can see that with low memory pressure, even though the
shrinker runs on dcache repeatedly, not many dentries are freed
by dcache. And dcache lru list still has huge number of free
dentries.

Regards,
Bharata.

--ikeVEW9yuYc//A+q
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
 include/linux/mm.h   |   39 ++++++++++++++++++++++++++++++++++++++-
 include/linux/slab.h |    3 +++
 mm/slab.c            |   15 +++++++++++++++
 mm/vmscan.c          |   23 +++++++++++------------
 8 files changed, 78 insertions(+), 16 deletions(-)

diff -puN mm/vmscan.c~cache_shrink_stats mm/vmscan.c
--- linux-2.6.14-rc2-shrink/mm/vmscan.c~cache_shrink_stats	2005-09-28 11:17:01.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/mm/vmscan.c	2005-10-04 15:27:52.000000000 +0530
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
 
diff -puN fs/inode.c~cache_shrink_stats fs/inode.c
--- linux-2.6.14-rc2-shrink/fs/inode.c~cache_shrink_stats	2005-09-28 11:25:58.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/fs/inode.c	2005-09-28 14:02:24.000000000 +0530
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
diff -puN fs/dquot.c~cache_shrink_stats fs/dquot.c
--- linux-2.6.14-rc2-shrink/fs/dquot.c~cache_shrink_stats	2005-09-28 11:28:51.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/fs/dquot.c	2005-09-28 14:06:13.000000000 +0530
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
diff -puN fs/dcache.c~cache_shrink_stats fs/dcache.c
--- linux-2.6.14-rc2-shrink/fs/dcache.c~cache_shrink_stats	2005-09-28 11:31:35.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/fs/dcache.c	2005-09-28 13:47:46.000000000 +0530
@@ -1668,6 +1668,7 @@ static void __init dcache_init_early(voi
 static void __init dcache_init(unsigned long mempages)
 {
 	int loop;
+	struct shrinker *shrinker;
 
 	/* 
 	 * A constructor could be added for stable state like the lists,
@@ -1680,7 +1681,8 @@ static void __init dcache_init(unsigned 
 					 SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
 					 NULL, NULL);
 	
-	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
+	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
+	kmem_set_shrinker(dentry_cache, shrinker);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff -puN mm/slab.c~cache_shrink_stats mm/slab.c
--- linux-2.6.14-rc2-shrink/mm/slab.c~cache_shrink_stats	2005-09-28 11:40:00.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/mm/slab.c	2005-10-04 14:09:53.000000000 +0530
@@ -400,6 +400,9 @@ struct kmem_cache_s {
 	/* de-constructor func */
 	void (*dtor)(void *, kmem_cache_t *, unsigned long);
 
+	/* shrinker data for this cache */
+	struct shrinker *shrinker;
+
 /* 4) cache creation/removal */
 	const char		*name;
 	struct list_head	next;
@@ -3363,6 +3366,7 @@ static void *s_start(struct seq_file *m,
 				" <error> <maxfreeable> <nodeallocs> <remotefrees>");
 		seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
+		seq_puts(m, " : shrinker stat <nr requested> <nr freed>");
 		seq_putc(m, '\n');
 	}
 	p = cache_chain.next;
@@ -3483,6 +3487,12 @@ static int s_show(struct seq_file *m, vo
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
@@ -3606,3 +3616,8 @@ char *kstrdup(const char *s, unsigned in
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
+
+void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker)
+{
+	cachep->shrinker = shrinker;
+}
diff -puN include/linux/mm.h~cache_shrink_stats include/linux/mm.h
--- linux-2.6.14-rc2-shrink/include/linux/mm.h~cache_shrink_stats	2005-09-28 12:41:09.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/include/linux/mm.h	2005-10-04 12:29:22.000000000 +0530
@@ -755,7 +755,44 @@ typedef int (*shrinker_t)(int nr_to_scan
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
--- linux-2.6.14-rc2-shrink/include/linux/slab.h~cache_shrink_stats	2005-09-28 13:52:53.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/include/linux/slab.h	2005-09-28 14:07:42.000000000 +0530
@@ -147,6 +147,9 @@ extern kmem_cache_t	*bio_cachep;
 
 extern atomic_t slab_reclaim_pages;
 
+struct shrinker;
+extern void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker);
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
diff -puN fs/mbcache.c~cache_shrink_stats fs/mbcache.c
--- linux-2.6.14-rc2-shrink/fs/mbcache.c~cache_shrink_stats	2005-10-04 13:47:35.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/fs/mbcache.c	2005-10-04 13:48:34.000000000 +0530
@@ -292,6 +292,8 @@ mb_cache_create(const char *name, struct
 	if (!cache->c_entry_cache)
 		goto fail;
 
+	kmem_set_shrinker(cache->c_entry_cache, mb_shrinker);
+
 	spin_lock(&mb_cache_spinlock);
 	list_add(&cache->c_cache_list, &mb_cache_list);
 	spin_unlock(&mb_cache_spinlock);
_

--ikeVEW9yuYc//A+q--
