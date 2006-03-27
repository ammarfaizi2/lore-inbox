Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWC0LnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWC0LnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 06:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWC0LnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 06:43:24 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30885 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750914AbWC0LnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 06:43:23 -0500
Date: Mon, 27 Mar 2006 17:18:13 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dcache leak in 2.6.16-git8
Message-ID: <20060327114813.GA11352@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <200603270750.28174.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <200603270750.28174.ak@suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 27, 2006 at 07:50:20AM +0200, Andi Kleen wrote:
> 
> A 2GB x86-64 desktop system here is currently swapping itself to death after
> a few days uptime.
> 
> Some investigation shows this:
> 
> inode_cache         1287   1337    568    7    1 : tunables   54   27    8 : slabdata    191    191      0
> dentry_cache      1867436 1867643    208   19    1 : tunables  120   60    8 : slabdata  98297  98297      0
> 

Would it be possible to try out this experimental patch which
gets some stats from the dentry cache ?

Patch 1: dcache_stats.patch
	- shows some dentry cache stats in /proc/meminfo.

Patch 2: cache_shrink_stats.patch (currently in mm)
	- applies on top of the 1st patch; shows the of shrinking of
	slab caches in /proc/slabinfo.

The patches are against 2.6.16-git8. I have just verified that these
work on x86_64. Haven't really stress tested to check if they hold for
reasonable time.

Regards,
Bharata.

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dcache_stats.patch"



This patch collects a few statistics from the dcache and exports it
as part of /proc/meminfo.

A typical dcache stats output from /proc/meminfo looks like this:

--------- /proc/meminfo data start -------------

nr_dentries/page        nr_pages        nr_inuse
         0              0               0
         1              7               3
         2              1               1
         3              3               6
         4              1               2
         5              5               8
         6              4               9
         7              1               1
         8              4               4
         9              4               18
        10              3               4
        11              6               16
        12              2               6
        13              3               13
        14              2               9
        15              2               13
        16              6               28
        17              2               9
        18              1               2
        19              0               0
        20              1               3
        21              2               16
        22              2               20
        23              2               14
        24              18              116
        25              20              148
        26              218             2041
        27              0               0
        28              0               0
        29              0               0
Total:                  320             2510
dcache lru: total 4869 inuse 117

--------- /proc/meminfo data end ---------------

Here,

nr_dentries/page - Number of dentries per page
nr_pages - Number of pages with given number of dentries
nr_inuse - Number of inuse dentries in those pages.
Eg: From the above data, there are 3 pages with 3 dentries each
and out of 9 total dentries in these 3 pages, 6 dentries are in use.

The number of dentries in lru list and number of inuse dentries
in them are also listed at the end.

Original Author: Dave Hansen <haveblue@us.ibm.com>

Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 arch/i386/mm/init.c    |    4 +
 arch/x86_64/mm/init.c  |    8 +++
 fs/dcache.c            |  105 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/proc/proc_misc.c    |   19 ++++++++
 include/linux/dcache.h |   11 ++++-
 include/linux/mm.h     |    3 +
 mm/page_alloc.c        |    2 
 7 files changed, 150 insertions(+), 2 deletions(-)

diff -puN arch/i386/mm/init.c~dcache_stats arch/i386/mm/init.c
--- linux-2.6.16-git8/arch/i386/mm/init.c~dcache_stats	2006-03-27 13:50:02.000000000 +0530
+++ linux-2.6.16-git8-bharata/arch/i386/mm/init.c	2006-03-27 13:50:02.000000000 +0530
@@ -273,6 +273,7 @@ static void __meminit free_new_highpage(
 	init_page_count(page);
 	__free_page(page);
 	totalhigh_pages++;
+	spin_lock_init(&page->dcount_lock);
 }
 
 void __init add_one_highpage_init(struct page *page, int pfn, int bad_ppro)
@@ -746,12 +747,15 @@ void mark_rodata_ro(void)
 void free_init_pages(char *what, unsigned long begin, unsigned long end)
 {
 	unsigned long addr;
+	struct page *page;
 
 	for (addr = begin; addr < end; addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
 		init_page_count(virt_to_page(addr));
 		memset((void *)addr, 0xcc, PAGE_SIZE);
 		free_page(addr);
+		page = virt_to_page(addr);
+		spin_lock_init(&page->dcount_lock);
 		totalram_pages++;
 	}
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
diff -puN fs/dcache.c~dcache_stats fs/dcache.c
--- linux-2.6.16-git8/fs/dcache.c~dcache_stats	2006-03-27 13:50:02.000000000 +0530
+++ linux-2.6.16-git8-bharata/fs/dcache.c	2006-03-27 16:52:38.000000000 +0530
@@ -33,6 +33,7 @@
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/pagemap.h>
 
 /* #define DCACHE_DEBUG 1 */
 
@@ -69,12 +70,68 @@ struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
 };
 
+atomic_t nr_dpages[MAX_DENTRIES_PER_PAGE];
+atomic_t nr_dinuse[MAX_DENTRIES_PER_PAGE];
+
+static void dcache_update_stats(struct dentry *dentry, int op)
+{
+	struct page *page;
+	unsigned long flags;
+
+	page = virt_to_page(dentry);
+	spin_lock_irqsave(&page->dcount_lock, flags);
+	if (op) {
+		atomic_inc(&nr_dinuse[page->dcount]);
+		page->d_inuse_count++;
+		BUG_ON(page->d_inuse_count > page->dcount);
+	} else {
+		atomic_dec(&nr_dinuse[page->dcount]);
+		page->d_inuse_count--;
+		BUG_ON(page->d_inuse_count < 0);
+	}
+	spin_unlock_irqrestore(&page->dcount_lock, flags);
+}
+
+/*
+ * should be called with dcache_lock held
+ */
+void get_dcache_lru(void)
+{
+	struct dentry *dentry;
+
+	spin_lock(&dcache_lock);
+	dentry_stat.nr_lru_inuse = 0;
+	list_for_each_entry(dentry, &dentry_unused, d_lru) {
+		if (atomic_read(&dentry->d_count))
+			dentry_stat.nr_lru_inuse++;
+	}
+	spin_unlock(&dcache_lock);
+}
+
 static void d_callback(struct rcu_head *head)
 {
 	struct dentry * dentry = container_of(head, struct dentry, d_u.d_rcu);
+	unsigned long flags;
+	struct page *page;
 
 	if (dname_external(dentry))
 		kfree(dentry->d_name.name);
+
+	page = virt_to_page(dentry);
+	spin_lock_irqsave(&page->dcount_lock, flags);
+	/* dec the number of pages with old dcount */
+	atomic_dec(&nr_dpages[page->dcount]);
+	/* dec the inuse count for pages with old dcount */
+	atomic_sub(page->d_inuse_count, &nr_dinuse[page->dcount]);
+	if (--page->dcount != 0) {
+		/* inc the number of pages with new dcount */
+		atomic_inc(&nr_dpages[page->dcount]);
+		/* inc the inuse count for pages with new dcount */
+		atomic_add(page->d_inuse_count, &nr_dinuse[page->dcount]);
+	}
+	BUG_ON(page->dcount < 0);
+	spin_unlock_irqrestore(&page->dcount_lock, flags);
+
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
@@ -161,6 +218,8 @@ repeat:
 		return;
 	}
 
+	dcache_update_stats(dentry, 0);
+
 	/*
 	 * AV: ->d_delete() is _NOT_ allowed to block now.
 	 */
@@ -267,6 +326,12 @@ int d_invalidate(struct dentry * dentry)
 
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
+	/*
+	 * TODO: Is it possible for the count to go from 0 to 1 here ?
+	 * If so update the dentry inuse counter.
+	 */
+	if (!atomic_read(&dentry->d_count))
+		dcache_update_stats(dentry, 1);
 	atomic_inc(&dentry->d_count);
 	if (!list_empty(&dentry->d_lru)) {
 		dentry_stat.nr_unused--;
@@ -572,6 +637,7 @@ resume:
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_u.d_child);
 		next = tmp->next;
 
+		spin_lock(&dentry->d_lock);
 		if (!list_empty(&dentry->d_lru)) {
 			dentry_stat.nr_unused--;
 			list_del_init(&dentry->d_lru);
@@ -585,6 +651,7 @@ resume:
 			dentry_stat.nr_unused++;
 			found++;
 		}
+		spin_unlock(&dentry->d_lock);
 
 		/*
 		 * We can return to the caller if we have found some (this
@@ -657,6 +724,7 @@ void shrink_dcache_anon(struct hlist_hea
 		spin_lock(&dcache_lock);
 		hlist_for_each(lp, head) {
 			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
+			spin_lock(&this->d_lock);
 			if (!list_empty(&this->d_lru)) {
 				dentry_stat.nr_unused--;
 				list_del_init(&this->d_lru);
@@ -671,6 +739,7 @@ void shrink_dcache_anon(struct hlist_hea
 				dentry_stat.nr_unused++;
 				found++;
 			}
+			spin_unlock(&this->d_lock);
 		}
 		spin_unlock(&dcache_lock);
 		prune_dcache(found);
@@ -713,6 +782,8 @@ struct dentry *d_alloc(struct dentry * p
 {
 	struct dentry *dentry;
 	char *dname;
+	unsigned long flags;
+	struct page *page;
 
 	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
 	if (!dentry)
@@ -764,6 +835,23 @@ struct dentry *d_alloc(struct dentry * p
 	dentry_stat.nr_dentry++;
 	spin_unlock(&dcache_lock);
 
+	page = virt_to_page(dentry);
+	spin_lock_irqsave(&page->dcount_lock, flags);
+	if (page->dcount != 0) {
+		/* dec the number of pages with old dcount*/
+		atomic_dec(&nr_dpages[page->dcount]);
+		/* dec the inuse count for pages with old dcount */
+		atomic_sub(page->d_inuse_count, &nr_dinuse[page->dcount]);
+	}
+	/* inc the number of pages with new dcount */
+	atomic_inc(&nr_dpages[++page->dcount]);
+	BUG_ON(page->dcount > MAX_DENTRIES_PER_PAGE);
+	/* inc the use count in the page */
+	page->d_inuse_count++;
+	/* inc the inuse count for pages with new dcount */
+	atomic_add(page->d_inuse_count, &nr_dinuse[page->dcount]);
+	spin_unlock_irqrestore(&page->dcount_lock, flags);
+
 	return dentry;
 }
 
@@ -1052,6 +1140,7 @@ struct dentry * __d_lookup(struct dentry
 	struct hlist_node *node;
 	struct dentry *dentry;
 
+	spin_lock(&dcache_lock);
 	rcu_read_lock();
 	
 	hlist_for_each_entry_rcu(dentry, node, head, d_hash) {
@@ -1089,6 +1178,12 @@ struct dentry * __d_lookup(struct dentry
 
 		if (!d_unhashed(dentry)) {
 			atomic_inc(&dentry->d_count);
+			/*
+			 * If this is a 0 to 1 d_count transition, we
+			 * need to increment the dentry inuse counter.
+			 */
+			if (atomic_read(&dentry->d_count) == 1)
+				dcache_update_stats(dentry, 1);
 			found = dentry;
 		}
 		spin_unlock(&dentry->d_lock);
@@ -1097,6 +1192,7 @@ next:
 		spin_unlock(&dentry->d_lock);
  	}
  	rcu_read_unlock();
+	spin_unlock(&dcache_lock);
 
  	return found;
 }
@@ -1584,10 +1680,19 @@ resume:
 			goto repeat;
 		}
 		atomic_dec(&dentry->d_count);
+		/*
+		 * If the count goes to zero here, decrement
+		 * the dentry inuse counter.
+		 * TODO: check if this is needed
+		 */
+		if (!atomic_read(&dentry->d_count))
+			dcache_update_stats(dentry, 0);
 	}
 	if (this_parent != root) {
 		next = this_parent->d_u.d_child.next;
 		atomic_dec(&this_parent->d_count);
+		if (!atomic_read(&this_parent->d_count))
+			dcache_update_stats(this_parent, 0);
 		this_parent = this_parent->d_parent;
 		goto resume;
 	}
diff -puN fs/proc/proc_misc.c~dcache_stats fs/proc/proc_misc.c
--- linux-2.6.16-git8/fs/proc/proc_misc.c~dcache_stats	2006-03-27 13:50:02.000000000 +0530
+++ linux-2.6.16-git8-bharata/fs/proc/proc_misc.c	2006-03-27 14:31:49.000000000 +0530
@@ -46,6 +46,7 @@
 #include <linux/sysrq.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/dcache.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -128,6 +129,7 @@ static int meminfo_read_proc(char *page,
 	unsigned long allowed;
 	struct vmalloc_info vmi;
 	long cached;
+	int j, total_dpages = 0, total_inuse = 0;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
@@ -202,6 +204,23 @@ static int meminfo_read_proc(char *page,
 
 		len += hugetlb_report_meminfo(page + len);
 
+		len += sprintf(page + len, "nr_dentries/page\t"
+				"nr_pages\tnr_inuse\n");
+		for (j = 0; j < MAX_DENTRIES_PER_PAGE; j++) {
+			len += sprintf(page + len,
+				"\t%2d\t\t%d\t\t%d\n", j,
+				atomic_read(&nr_dpages[j]),
+				atomic_read(&nr_dinuse[j]));
+			total_dpages += atomic_read(&nr_dpages[j]);
+			total_inuse += atomic_read(&nr_dinuse[j]);
+		}
+		len += sprintf(page + len, "Total: \t\t\t%d\t\t%d\n",
+				total_dpages, total_inuse);
+		get_dcache_lru();
+		len += sprintf(page + len,
+			"dcache lru: total %d inuse %d\n",
+			dentry_stat.nr_unused, dentry_stat.nr_lru_inuse);
+
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
 }
diff -puN include/linux/dcache.h~dcache_stats include/linux/dcache.h
--- linux-2.6.16-git8/include/linux/dcache.h~dcache_stats	2006-03-27 13:50:02.000000000 +0530
+++ linux-2.6.16-git8-bharata/include/linux/dcache.h	2006-03-27 13:50:02.000000000 +0530
@@ -38,10 +38,11 @@ struct qstr {
 
 struct dentry_stat_t {
 	int nr_dentry;
-	int nr_unused;
+	int nr_unused;		/* number of dentries in lru list */
 	int age_limit;          /* age in seconds */
 	int want_pages;         /* pages requested by system */
-	int dummy[2];
+	int nr_lru_inuse;	/* inuse dentries in lru */
+	int dummy[1];
 };
 extern struct dentry_stat_t dentry_stat;
 
@@ -235,6 +236,12 @@ extern int have_submounts(struct dentry 
  */
 extern void d_rehash(struct dentry *);
 
+/* dcache statistics */
+#define MAX_DENTRIES_PER_PAGE	30
+extern atomic_t nr_dpages[];
+extern atomic_t nr_dinuse[];
+extern void get_dcache_lru(void);
+
 /**
  * d_add - add dentry to hash queues
  * @entry: dentry to add
diff -puN include/linux/mm.h~dcache_stats include/linux/mm.h
--- linux-2.6.16-git8/include/linux/mm.h~dcache_stats	2006-03-27 13:50:02.000000000 +0530
+++ linux-2.6.16-git8-bharata/include/linux/mm.h	2006-03-27 16:52:38.000000000 +0530
@@ -224,6 +224,9 @@ struct page {
 					 * to show when page is mapped
 					 * & limit reverse map searches.
 					 */
+	int dcount;			/* Number of dentries in this page */
+	int d_inuse_count;		/* Number of inuse dentries */
+	spinlock_t dcount_lock;
 	union {
 	    struct {
 		unsigned long private;		/* Mapping-private opaque data:
diff -puN mm/page_alloc.c~dcache_stats mm/page_alloc.c
--- linux-2.6.16-git8/mm/page_alloc.c~dcache_stats	2006-03-27 14:11:41.000000000 +0530
+++ linux-2.6.16-git8-bharata/mm/page_alloc.c	2006-03-27 14:14:49.000000000 +0530
@@ -457,6 +457,7 @@ void fastcall __init __free_pages_bootme
 		__ClearPageReserved(page);
 		set_page_count(page, 0);
 		set_page_refcounted(page);
+		spin_lock_init(&page->dcount_lock);
 		__free_page(page);
 	} else {
 		int loop;
@@ -469,6 +470,7 @@ void fastcall __init __free_pages_bootme
 				prefetchw(p + 1);
 			__ClearPageReserved(p);
 			set_page_count(p, 0);
+			spin_lock_init(&p->dcount_lock);
 		}
 
 		set_page_refcounted(page);
diff -puN arch/x86_64/mm/init.c~dcache_stats arch/x86_64/mm/init.c
--- linux-2.6.16-git8/arch/x86_64/mm/init.c~dcache_stats	2006-03-27 14:21:04.000000000 +0530
+++ linux-2.6.16-git8-bharata/arch/x86_64/mm/init.c	2006-03-27 14:24:45.000000000 +0530
@@ -490,6 +490,7 @@ void online_page(struct page *page)
 	__free_page(page);
 	totalram_pages++;
 	num_physpages++;
+	spin_lock_init(&page->dcount_lock);
 }
 
 int add_memory(u64 start, u64 size)
@@ -588,6 +589,7 @@ void __init mem_init(void)
 void free_initmem(void)
 {
 	unsigned long addr;
+	struct page *page;
 
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
@@ -596,6 +598,8 @@ void free_initmem(void)
 		memset((void *)(addr & ~(PAGE_SIZE-1)), 0xcc, PAGE_SIZE); 
 		free_page(addr);
 		totalram_pages++;
+		page = virt_to_page(addr);
+		spin_lock_init(&page->dcount_lock);
 	}
 	memset(__initdata_begin, 0xba, __initdata_end - __initdata_begin);
 	printk ("Freeing unused kernel memory: %luk freed\n", (__init_end - __init_begin) >> 10);
@@ -627,6 +631,8 @@ void mark_rodata_ro(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
+	struct page *page;
+
 	if (start >= end)
 		return;
 	printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
@@ -635,6 +641,8 @@ void free_initrd_mem(unsigned long start
 		init_page_count(virt_to_page(start));
 		free_page(start);
 		totalram_pages++;
+		page = virt_to_page(start);
+		spin_lock_init(&page->dcount_lock);
 	}
 }
 #endif
_

--jRHKVT23PllUwdXP
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

diff -puN fs/dcache.c~cache_shrink_stats fs/dcache.c
--- linux-2.6.16-git8/fs/dcache.c~cache_shrink_stats	2006-03-27 15:24:33.000000000 +0530
+++ linux-2.6.16-git8-bharata/fs/dcache.c	2006-03-27 15:28:31.000000000 +0530
@@ -1778,6 +1778,7 @@ static void __init dcache_init_early(voi
 static void __init dcache_init(unsigned long mempages)
 {
 	int loop;
+	struct shrinker *shrinker;
 
 	/* 
 	 * A constructor could be added for stable state like the lists,
@@ -1790,7 +1791,8 @@ static void __init dcache_init(unsigned 
 					 SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
 					 NULL, NULL);
 	
-	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
+	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
+	kmem_set_shrinker(dentry_cache, shrinker);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff -puN fs/dquot.c~cache_shrink_stats fs/dquot.c
--- linux-2.6.16-git8/fs/dquot.c~cache_shrink_stats	2006-03-27 15:24:33.000000000 +0530
+++ linux-2.6.16-git8-bharata/fs/dquot.c	2006-03-27 15:24:33.000000000 +0530
@@ -1814,6 +1814,7 @@ static int __init dquot_init(void)
 {
 	int i;
 	unsigned long nr_hash, order;
+	struct shrinker *shrinker;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
@@ -1845,7 +1846,8 @@ static int __init dquot_init(void)
 	printk("Dquot-cache hash table entries: %ld (order %ld, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));
 
-	set_shrinker(DEFAULT_SEEKS, shrink_dqcache_memory);
+	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_dqcache_memory);
+	kmem_set_shrinker(dquot_cachep, shrinker);
 
 	return 0;
 }
diff -puN fs/inode.c~cache_shrink_stats fs/inode.c
--- linux-2.6.16-git8/fs/inode.c~cache_shrink_stats	2006-03-27 15:24:33.000000000 +0530
+++ linux-2.6.16-git8-bharata/fs/inode.c	2006-03-27 15:24:33.000000000 +0530
@@ -1373,11 +1373,13 @@ void __init inode_init_early(void)
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
--- linux-2.6.16-git8/fs/mbcache.c~cache_shrink_stats	2006-03-27 15:24:33.000000000 +0530
+++ linux-2.6.16-git8-bharata/fs/mbcache.c	2006-03-27 15:24:33.000000000 +0530
@@ -292,6 +292,8 @@ mb_cache_create(const char *name, struct
 	if (!cache->c_entry_cache)
 		goto fail;
 
+	kmem_set_shrinker(cache->c_entry_cache, mb_shrinker);
+
 	spin_lock(&mb_cache_spinlock);
 	list_add(&cache->c_cache_list, &mb_cache_list);
 	spin_unlock(&mb_cache_spinlock);
diff -puN include/linux/mm.h~cache_shrink_stats include/linux/mm.h
--- linux-2.6.16-git8/include/linux/mm.h~cache_shrink_stats	2006-03-27 15:24:33.000000000 +0530
+++ linux-2.6.16-git8-bharata/include/linux/mm.h	2006-03-27 15:24:33.000000000 +0530
@@ -789,7 +789,44 @@ typedef int (*shrinker_t)(int nr_to_scan
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
--- linux-2.6.16-git8/include/linux/slab.h~cache_shrink_stats	2006-03-27 15:24:33.000000000 +0530
+++ linux-2.6.16-git8-bharata/include/linux/slab.h	2006-03-27 15:24:33.000000000 +0530
@@ -187,6 +187,9 @@ extern kmem_cache_t	*bio_cachep;
 
 extern atomic_t slab_reclaim_pages;
 
+struct shrinker;
+extern void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker);
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
diff -puN mm/slab.c~cache_shrink_stats mm/slab.c
--- linux-2.6.16-git8/mm/slab.c~cache_shrink_stats	2006-03-27 15:24:33.000000000 +0530
+++ linux-2.6.16-git8-bharata/mm/slab.c	2006-03-27 15:28:01.000000000 +0530
@@ -403,6 +403,9 @@ struct kmem_cache {
 	/* de-constructor func */
 	void (*dtor) (void *, struct kmem_cache *, unsigned long);
 
+	/* shrinker data for this cache */
+	struct shrinker *shrinker;
+
 /* 5) cache creation/removal */
 	const char *name;
 	struct list_head next;
@@ -3671,6 +3674,7 @@ static void print_slabinfo_header(struct
 		 "<error> <maxfreeable> <nodeallocs> <remotefrees>");
 	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
 #endif
+		seq_puts(m, " : shrinker stat <nr requested> <nr freed>");
 	seq_putc(m, '\n');
 }
 
@@ -3799,6 +3803,12 @@ static int s_show(struct seq_file *m, vo
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
 	return 0;
 }
@@ -3897,3 +3907,8 @@ unsigned int ksize(const void *objp)
 
 	return obj_size(virt_to_cache(objp));
 }
+
+void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker)
+{
+	cachep->shrinker = shrinker;
+}
diff -puN mm/vmscan.c~cache_shrink_stats mm/vmscan.c
--- linux-2.6.16-git8/mm/vmscan.c~cache_shrink_stats	2006-03-27 15:24:33.000000000 +0530
+++ linux-2.6.16-git8-bharata/mm/vmscan.c	2006-03-27 15:30:49.000000000 +0530
@@ -63,17 +63,6 @@ struct scan_control {
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
@@ -125,6 +114,11 @@ struct shrinker *set_shrinker(int seeks,
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
@@ -141,6 +135,7 @@ void remove_shrinker(struct shrinker *sh
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
+	free_percpu(shrinker->s_stats);
 	kfree(shrinker);
 }
 EXPORT_SYMBOL(remove_shrinker);
@@ -212,8 +207,12 @@ unsigned long shrink_slab(unsigned long 
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

--jRHKVT23PllUwdXP--
