Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVIMIsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVIMIsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVIMIsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:48:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:1760 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751142AbVIMIsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:48:12 -0400
Date: Tue, 13 Sep 2005 14:17:52 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20050913084752.GC4474@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20050912031636.GB16758@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 11, 2005 at 11:16:36PM -0400, Theodore Ts'o wrote:
> On Sun, Sep 11, 2005 at 05:30:46PM +0530, Dipankar Sarma wrote:
> > Do you have the /proc/sys/fs/dentry-state output when such lowmem
> > shortage happens ?
> 
> Not yet, but the situation occurs on my laptop about 2 or 3 times
> (when I'm not travelling and so it doesn't get rebooted).  So
> reproducing it isn't utterly trivial, but it's does happen often
> enough that it should be possible to get the necessary data.
> 
> > This is a problem that Bharata has been investigating at the moment.
> > But he hasn't seen anything that can't be cured by a small memory
> > pressure - IOW, dentries do get freed under memory pressure. So
> > your case might be very useful. Bharata is maintaing an instrumentation
> > patch to collect more information and an alternative dentry aging patch 
> > (using rbtree). Perhaps you could try with those.
> 
> Send it to me, and I'd be happy to try either the instrumentation
> patch or the dentry aging patch.
> 

Ted,

I am sending two patches here.

First is dentry_stats patch which collects some dcache statistics
and puts it into /proc/meminfo. This patch provides information 
about how dentries are distributed in dcache slab pages, how many
free and in use dentries are present in dentry_unused lru list and
how prune_dcache() performs with respect to freeing the requested
number of dentries.

Second is Sonny Rao's rbtree dentry reclaim patch which is an attempt
to improve this dcache fragmentation problem.

These patches apply on 2.6.13-rc7 and 2.6.13 cleanly.

Could you please apply the dcache_stats patch and check if the problem
can be reproduced. When that happens, could you please capture the 
/proc/meminfo, /proc/sys/fs/dentry-state and /proc/slabinfo.

It would be nice if you could also try the rbtree patch to check if
it improves the situation. rbtree patch applies on top of the stats
patch.

Regards,
Bharata.

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dcache_stats.patch"



This patch obtains some statistics about dcache and exports it as
part of /proc/meminfo.

The following data is collected:

1. A count of pages with 1,2,3,... dentries.

2. Number of dentries requested for freeing and the actual number
of dentries freed during the last invocation of prune_dcache.

3. Information about dcache lru list: number of inuse, free,
referenced and total dentries.

Original Author: Dave Hansen <haveblue@us.ibm.com>

Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 arch/i386/mm/init.c    |    8 +++++++
 fs/dcache.c            |   56 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/proc/proc_misc.c    |   27 +++++++++++++++++++++++
 include/linux/dcache.h |   11 +++++++++
 include/linux/mm.h     |    3 ++
 mm/bootmem.c           |    4 +++
 6 files changed, 109 insertions(+)

diff -puN include/linux/mm.h~dcache_stats include/linux/mm.h
--- linux-2.6.13-rc7/include/linux/mm.h~dcache_stats	2005-09-12 10:57:52.000000000 +0530
+++ linux-2.6.13-rc7-bharata/include/linux/mm.h	2005-09-13 11:21:52.601920944 +0530
@@ -225,6 +225,9 @@ struct page {
 					 * to show when page is mapped
 					 * & limit reverse map searches.
 					 */
+	int nr_dentry;			/* Number of dentries in this page */
+	spinlock_t nr_dentry_lock;
+
 	unsigned long private;		/* Mapping-private opaque data:
 					 * usually used for buffer_heads
 					 * if PagePrivate set; used for
diff -puN arch/i386/mm/init.c~dcache_stats arch/i386/mm/init.c
--- linux-2.6.13-rc7/arch/i386/mm/init.c~dcache_stats	2005-09-12 10:57:52.000000000 +0530
+++ linux-2.6.13-rc7-bharata/arch/i386/mm/init.c	2005-09-13 11:22:29.357333272 +0530
@@ -272,6 +272,7 @@ void __init one_highpage_init(struct pag
 		set_page_count(page, 1);
 		__free_page(page);
 		totalhigh_pages++;
+		spin_lock_init(&page->nr_dentry_lock);
 	} else
 		SetPageReserved(page);
 }
@@ -669,6 +670,7 @@ static int noinline do_test_wp_bit(void)
 void free_initmem(void)
 {
 	unsigned long addr;
+	struct page *page;
 
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
@@ -676,6 +678,8 @@ void free_initmem(void)
 		set_page_count(virt_to_page(addr), 1);
 		memset((void *)addr, 0xcc, PAGE_SIZE);
 		free_page(addr);
+		page = virt_to_page(addr);
+		spin_lock_init(&page->nr_dentry_lock);
 		totalram_pages++;
 	}
 	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (__init_end - __init_begin) >> 10);
@@ -684,12 +688,16 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
+	struct page *page;
+
 	if (start < end)
 		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
+		page = virt_to_page(start);
+		spin_lock_init(&page->nr_dentry_lock);
 		totalram_pages++;
 	}
 }
diff -puN fs/dcache.c~dcache_stats fs/dcache.c
--- linux-2.6.13-rc7/fs/dcache.c~dcache_stats	2005-09-12 10:57:52.000000000 +0530
+++ linux-2.6.13-rc7-bharata/fs/dcache.c	2005-09-13 12:27:07.079829848 +0530
@@ -33,6 +33,7 @@
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/pagemap.h>
 
 /* #define DCACHE_DEBUG 1 */
 
@@ -69,12 +70,48 @@ struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
 };
 
+atomic_t nr_dentry[30]; /* I have seen a max of 27 dentries in a page */
+struct lru_dentry_stat lru_dentry_stat;
+DEFINE_SPINLOCK(prune_dcache_lock);
+
+void get_dstat_info(void)
+{
+	struct dentry *dentry;
+
+	lru_dentry_stat.nr_total = lru_dentry_stat.nr_inuse = 0;
+	lru_dentry_stat.nr_ref = lru_dentry_stat.nr_free = 0;
+
+	spin_lock(&dcache_lock);
+	list_for_each_entry(dentry, &dentry_unused, d_lru) {
+		if (atomic_read(&dentry->d_count))
+			lru_dentry_stat.nr_inuse++;
+		if (dentry->d_flags & DCACHE_REFERENCED)
+			lru_dentry_stat.nr_ref++;
+	}
+	lru_dentry_stat.nr_total = dentry_stat.nr_unused;
+	lru_dentry_stat.nr_free = lru_dentry_stat.nr_total -
+		lru_dentry_stat.nr_inuse;
+	spin_unlock(&dcache_lock);
+}
+
 static void d_callback(struct rcu_head *head)
 {
 	struct dentry * dentry = container_of(head, struct dentry, d_rcu);
+	unsigned long flags;
+	struct page *page;
 
 	if (dname_external(dentry))
 		kfree(dentry->d_name.name);
+
+	page = virt_to_page(dentry);
+	spin_lock_irqsave(&page->nr_dentry_lock, flags);
+	atomic_dec(&nr_dentry[page->nr_dentry]);
+	if (--page->nr_dentry != 0)
+		atomic_inc(&nr_dentry[page->nr_dentry]);
+	BUG_ON(atomic_read(&nr_dentry[page->nr_dentry]) < 0);
+	BUG_ON(page->nr_dentry > 29);
+	spin_unlock_irqrestore(&page->nr_dentry_lock, flags);
+
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
@@ -393,6 +430,9 @@ static inline void prune_one_dentry(stru
  
 static void prune_dcache(int count)
 {
+	int nr_requested = count;
+	int nr_freed = 0;
+
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
 		struct dentry *dentry;
@@ -427,8 +467,13 @@ static void prune_dcache(int count)
 			continue;
 		}
 		prune_one_dentry(dentry);
+		nr_freed++;
 	}
 	spin_unlock(&dcache_lock);
+	spin_lock(&prune_dcache_lock);
+	lru_dentry_stat.dprune_req = nr_requested;
+	lru_dentry_stat.dprune_freed = nr_freed;
+	spin_unlock(&prune_dcache_lock);
 }
 
 /*
@@ -720,6 +765,8 @@ struct dentry *d_alloc(struct dentry * p
 {
 	struct dentry *dentry;
 	char *dname;
+	unsigned long flags;
+	struct page *page;
 
 	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
 	if (!dentry)
@@ -769,6 +816,15 @@ struct dentry *d_alloc(struct dentry * p
 	dentry_stat.nr_dentry++;
 	spin_unlock(&dcache_lock);
 
+	page = virt_to_page(dentry);
+	spin_lock_irqsave(&page->nr_dentry_lock, flags);
+	if (page->nr_dentry != 0)
+		atomic_dec(&nr_dentry[page->nr_dentry]);
+	atomic_inc(&nr_dentry[++page->nr_dentry]);
+	BUG_ON(atomic_read(&nr_dentry[page->nr_dentry]) < 0);
+	BUG_ON(page->nr_dentry > 29);
+	spin_unlock_irqrestore(&page->nr_dentry_lock, flags);
+
 	return dentry;
 }
 
diff -puN fs/proc/proc_misc.c~dcache_stats fs/proc/proc_misc.c
--- linux-2.6.13-rc7/fs/proc/proc_misc.c~dcache_stats	2005-09-12 10:57:52.000000000 +0530
+++ linux-2.6.13-rc7-bharata/fs/proc/proc_misc.c	2005-09-13 11:49:43.460911768 +0530
@@ -45,6 +45,7 @@
 #include <linux/sysrq.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/dcache.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -115,6 +116,9 @@ static int uptime_read_proc(char *page, 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+extern atomic_t nr_dentry[];
+extern spinlock_t prune_dcache_lock;
+
 static int meminfo_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -128,6 +132,7 @@ static int meminfo_read_proc(char *page,
 	unsigned long allowed;
 	struct vmalloc_info vmi;
 	long cached;
+	int j, total_dcache_pages = 0;
 
 	get_page_state(&ps);
 	get_zone_counts(&active, &inactive, &free);
@@ -200,6 +205,28 @@ static int meminfo_read_proc(char *page,
 		vmi.largest_chunk >> 10
 		);
 
+		for (j =0; j < 30; j++) {
+			len += sprintf(page + len, "pages_with_[%2d]_dentries: %d\n",
+					j, atomic_read(&nr_dentry[j]));
+			total_dcache_pages += atomic_read(&nr_dentry[j]);
+		}
+		len += sprintf(page + len, "dcache_pages total: %d\n",
+			total_dcache_pages);
+
+		spin_lock(&prune_dcache_lock);
+		len += sprintf(page + len, "prune_dcache: requested  %d freed %d\n",
+			lru_dentry_stat.dprune_req, lru_dentry_stat.dprune_freed);
+		spin_unlock(&prune_dcache_lock);
+
+		get_dstat_info();
+		len += sprintf(page + len, "dcache lru list data:\n"
+			"dentries total: %d\n"
+			"dentries in_use: %d\n"
+			"dentries free: %d\n"
+			"dentries referenced: %d\n",
+			lru_dentry_stat.nr_total, lru_dentry_stat.nr_inuse,
+			lru_dentry_stat.nr_free, lru_dentry_stat.nr_ref);
+
 		len += hugetlb_report_meminfo(page + len);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
diff -puN mm/bootmem.c~dcache_stats mm/bootmem.c
--- linux-2.6.13-rc7/mm/bootmem.c~dcache_stats	2005-09-12 10:57:52.000000000 +0530
+++ linux-2.6.13-rc7-bharata/mm/bootmem.c	2005-09-13 11:26:31.358543496 +0530
@@ -291,12 +291,14 @@ static unsigned long __init free_all_boo
 			page = pfn_to_page(pfn);
 			count += BITS_PER_LONG;
 			__ClearPageReserved(page);
+			spin_lock_init(&page->nr_dentry_lock);
 			order = ffs(BITS_PER_LONG) - 1;
 			set_page_refs(page, order);
 			for (j = 1; j < BITS_PER_LONG; j++) {
 				if (j + 16 < BITS_PER_LONG)
 					prefetchw(page + j + 16);
 				__ClearPageReserved(page + j);
+				spin_lock_init(&((page + j)->nr_dentry_lock));
 			}
 			__free_pages(page, order);
 			i += BITS_PER_LONG;
@@ -311,6 +313,7 @@ static unsigned long __init free_all_boo
 					__ClearPageReserved(page);
 					set_page_refs(page, 0);
 					__free_page(page);
+					spin_lock_init(&page->nr_dentry_lock);
 				}
 			}
 		} else {
@@ -331,6 +334,7 @@ static unsigned long __init free_all_boo
 		__ClearPageReserved(page);
 		set_page_count(page, 1);
 		__free_page(page);
+		spin_lock_init(&page->nr_dentry_lock);
 	}
 	total += count;
 	bdata->node_bootmem_map = NULL;
diff -puN include/linux/dcache.h~dcache_stats include/linux/dcache.h
--- linux-2.6.13-rc7/include/linux/dcache.h~dcache_stats	2005-09-12 17:30:01.000000000 +0530
+++ linux-2.6.13-rc7-bharata/include/linux/dcache.h	2005-09-13 12:27:07.080829696 +0530
@@ -46,6 +46,17 @@ struct dentry_stat_t {
 };
 extern struct dentry_stat_t dentry_stat;
 
+struct lru_dentry_stat {
+	int nr_total;
+	int nr_inuse;
+	int nr_ref;
+	int nr_free;
+	int dprune_req;
+	int dprune_freed;
+};
+extern struct lru_dentry_stat lru_dentry_stat;
+extern void get_dstat_info(void);
+
 /* Name hashing routines. Initial hash value */
 /* Hash courtesy of the R5 hash in reiserfs modulo sign bits */
 #define init_name_hash()		0
_

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rbtree_dcache_reclaim.patch"



This patch maintains the dentries in a red black tree. RB tree is
scanned in-order and dentries are put into the end of LRU list
to increase the chances of freeing a dentries of a given page.

Original Author: Santhosh Rao <raosanth@us.ibm.com>

Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 fs/dcache.c            |  143 +++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |    2 
 2 files changed, 141 insertions(+), 4 deletions(-)

diff -puN fs/dcache.c~rbtree_dcache_reclaim fs/dcache.c
--- linux-2.6.13-rc7/fs/dcache.c~rbtree_dcache_reclaim	2005-09-13 12:11:11.279133640 +0530
+++ linux-2.6.13-rc7-bharata/fs/dcache.c	2005-09-13 12:15:02.732947312 +0530
@@ -34,6 +34,7 @@
 #include <linux/swap.h>
 #include <linux/bootmem.h>
 #include <linux/pagemap.h>
+#include <linux/rbtree.h>
 
 /* #define DCACHE_DEBUG 1 */
 
@@ -70,6 +71,50 @@ struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
 };
 
+static struct rb_root dentry_tree = RB_ROOT;
+
+#define RB_NONE (2)
+#define ON_RB(node)	((node)->rb_color != RB_NONE)
+#define RB_CLEAR(node)	((node)->rb_color = RB_NONE )
+  
+
+/* take a dentry safely off the rbtree */
+static void drb_delete(struct dentry* dentry)
+{
+	if (ON_RB(&dentry->d_rb)) {
+		rb_erase(&dentry->d_rb, &dentry_tree);
+		RB_CLEAR(&dentry->d_rb);
+	} else {
+		/* All allocated dentry objs should be in the tree */
+		BUG_ON(1);
+	}
+}
+
+static  struct dentry * drb_insert(struct dentry * dentry)
+{
+	struct rb_node ** p = &dentry_tree.rb_node;
+	struct rb_node * parent = NULL;
+	struct rb_node * node    = &dentry->d_rb;
+	struct dentry  * cur    = NULL;
+
+	while (*p) {
+		parent = *p;
+		cur = rb_entry(parent, struct dentry, d_rb);
+
+		if (dentry < cur)
+			p = &(*p)->rb_left;
+		else if (dentry > cur)
+			p = &(*p)->rb_right;
+		else {
+			return cur;
+		}
+	}
+
+	rb_link_node(node, parent, p);
+	rb_insert_color(node,&dentry_tree); 
+	return NULL;
+}
+
 atomic_t nr_dentry[30]; /* I have seen a max of 27 dentries in a page */
 struct lru_dentry_stat lru_dentry_stat;
 DEFINE_SPINLOCK(prune_dcache_lock);
@@ -232,6 +277,7 @@ kill_it: {
   		list_del(&dentry->d_child);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
 		/*drops the locks, at that point nobody can reach this dentry */
+		drb_delete(dentry);
 		dentry_iput(dentry);
 		parent = dentry->d_parent;
 		d_free(dentry);
@@ -407,6 +453,7 @@ static inline void prune_one_dentry(stru
 	__d_drop(dentry);
 	list_del(&dentry->d_child);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
+	drb_delete(dentry);
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
@@ -416,7 +463,7 @@ static inline void prune_one_dentry(stru
 }
 
 /**
- * prune_dcache - shrink the dcache
+ * prune_lru - shrink the lru list
  * @count: number of entries to try and free
  *
  * Shrink the dcache. This is done when we need
@@ -428,7 +475,7 @@ static inline void prune_one_dentry(stru
  * all the dentries are in use.
  */
  
-static void prune_dcache(int count)
+static void prune_lru(int count)
 {
 	int nr_requested = count;
 	int nr_freed = 0;
@@ -476,6 +523,93 @@ static void prune_dcache(int count)
 	spin_unlock(&prune_dcache_lock);
 }
 
+/**
+ * prune_dcache - try and "intelligently" shrink the dcache
+ * @requested - num of dentrys to try and free
+ *
+ * The basic strategy here is to scan through our tree of dentrys
+ * in-order and put them at the end of the lru - free list
+ * Why in-order?  Because, we want the chances of actually freeing
+ * all 15-27 (depending on arch) dentrys on a given page, instead
+ * of just in random lru order, which tends to lower dcache utilization
+ * and not free many pages.
+ */
+static void prune_dcache(unsigned  requested)
+{
+	/* ------ debug --------- */
+	//static int mod = 0;
+	//int flag = 0, removed = 0;
+	/* ------ debug --------- */
+
+	unsigned found = 0;
+	unsigned count;
+	struct rb_node * next;
+	struct dentry *dentry;
+#define NUM_LRU_PTRS 8
+	struct rb_node *lru_ptrs[NUM_LRU_PTRS];
+	struct list_head *cur;
+	int i;
+
+	spin_lock(&dcache_lock);
+	
+       	cur = dentry_unused.prev;
+
+	/* grab NUM_LRU_PTRS entrys off the end of lru list */
+	/* we'll use these as pseudo-random starting points in the tree */
+	for (i = 0 ; i < NUM_LRU_PTRS ; i++ ){
+		if ( cur == &dentry_unused ) {
+			/* if there aren't NUM_LRU_PTRS entrys, we probably
+			   can't even free a page now, give up */
+			spin_unlock(&dcache_lock);
+			return;
+		}
+		lru_ptrs[i] = &(list_entry(cur,struct dentry, d_lru)->d_rb); 
+		cur = cur->prev;
+	}
+	
+	i = 0;
+	
+	do {
+		count = 4 * PAGE_SIZE / sizeof(struct dentry) ; /* abitrary heuristic */
+		next = lru_ptrs[i];
+		for (; count ; count--) {
+			if( ! next ) {
+				//flag = 1;  /* ------ debug --------- */
+				break;
+			}
+			dentry = list_entry(next, struct dentry, d_rb);
+			next = rb_next(next);
+			prefetch(next);
+			if( ! list_empty( &dentry->d_lru) ) {
+				list_del_init(&dentry->d_lru);
+				dentry_stat.nr_unused--;
+			}
+			if (atomic_read(&dentry->d_count)) {
+				//removed++; 	/* ------ debug --------- */
+				continue;
+			} else {
+				list_add_tail(&dentry->d_lru, &dentry_unused);
+				dentry_stat.nr_unused++;
+				found++;
+			}
+		}
+		i++;
+	} while ( (found < requested / 2) && (i < NUM_LRU_PTRS ) );
+#undef NUM_LRU_PTRS
+
+	spin_unlock(&dcache_lock);
+	
+	/* ------ debug --------- */
+	//mod++;	
+	//if ( ! (mod & 64) ) {
+	//	mod = 0;
+	//	printk("prune_dcache: i %d flag %d, found %d removed %d\n",i,flag,found,removed);
+	//}
+	/* ------ debug --------- */
+
+	prune_lru(found);
+}
+
 /*
  * Shrink the dcache for the specified super block.
  * This allows us to unmount a device without disturbing
@@ -687,7 +821,7 @@ void shrink_dcache_parent(struct dentry 
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
+		prune_lru(found);
 }
 
 /**
@@ -725,7 +859,7 @@ void shrink_dcache_anon(struct hlist_hea
 			}
 		}
 		spin_unlock(&dcache_lock);
-		prune_dcache(found);
+		prune_lru(found);
 	} while(found);
 }
 
@@ -814,6 +948,7 @@ struct dentry *d_alloc(struct dentry * p
 	if (parent)
 		list_add(&dentry->d_child, &parent->d_subdirs);
 	dentry_stat.nr_dentry++;
+	drb_insert(dentry);
 	spin_unlock(&dcache_lock);
 
 	page = virt_to_page(dentry);
diff -puN include/linux/dcache.h~rbtree_dcache_reclaim include/linux/dcache.h
--- linux-2.6.13-rc7/include/linux/dcache.h~rbtree_dcache_reclaim	2005-09-13 12:11:11.284132880 +0530
+++ linux-2.6.13-rc7-bharata/include/linux/dcache.h	2005-09-13 12:11:11.306129536 +0530
@@ -9,6 +9,7 @@
 #include <linux/cache.h>
 #include <linux/rcupdate.h>
 #include <asm/bug.h>
+#include <linux/rbtree.h>
 
 struct nameidata;
 struct vfsmount;
@@ -104,6 +105,7 @@ struct dentry {
 	struct dentry *d_parent;	/* parent directory */
 	struct qstr d_name;
 
+	struct rb_node   d_rb;
 	struct list_head d_lru;		/* LRU list */
 	struct list_head d_child;	/* child of parent list */
 	struct list_head d_subdirs;	/* our children */
_

--tKW2IUtsqtDRztdT--
