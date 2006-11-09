Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030438AbWKITh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWKITh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbWKIThT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:37:19 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:65415 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030402AbWKITg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:36:59 -0500
From: Balbir Singh <balbir@in.ibm.com>
To: Linux MM <linux-mm@kvack.org>
Cc: dev@openvz.org, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, rohitseth@google.com,
       Balbir Singh <balbir@in.ibm.com>
Date: Fri, 10 Nov 2006 01:06:36 +0530
Message-Id: <20061109193636.21437.11778.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
Subject: [RFC][PATCH 8/8] RSS controller support reclamation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Reclaim memory as we hit the max_shares limit. The code for reclamation
is inspired from Dave Hansen's challenged memory controller and from the
shrink_all_memory() code

Reclamation can be triggered from two paths

1. While incrementing the RSS, we hit the limit of the container
2. A container is resized, such that it's new limit is below its current
   RSS

In (1) reclamation takes place in the background.

TODO's

1. max_shares currently works like a soft limit. The RSS can grow beyond it's
   limit. One possible fix is to introduce a soft limit (reclaim when the
   container hits the soft limit) and fail when we hit the hard limit

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/memctlr.h    |   17 ++++++
 kernel/fork.c              |    1 
 kernel/res_group/memctlr.c |  116 ++++++++++++++++++++++++++++++++++++++-------
 mm/rmap.c                  |   72 +++++++++++++++++++++++++++
 mm/vmscan.c                |   72 +++++++++++++++++++++++++++
 5 files changed, 260 insertions(+), 18 deletions(-)

diff -puN mm/vmscan.c~container-memctlr-reclaim mm/vmscan.c
--- linux-2.6.19-rc2/mm/vmscan.c~container-memctlr-reclaim	2006-11-09 22:21:11.000000000 +0530
+++ linux-2.6.19-rc2-balbir/mm/vmscan.c	2006-11-09 22:21:11.000000000 +0530
@@ -36,6 +36,8 @@
 #include <linux/rwsem.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/container.h>
+#include <linux/memctlr.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -65,6 +67,9 @@ struct scan_control {
 	int swappiness;
 
 	int all_unreclaimable;
+
+	int overlimit;
+	void *container;	/* Added as void * to avoid #ifdef's */
 };
 
 /*
@@ -811,6 +816,10 @@ force_reclaim_mapped:
 		cond_resched();
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
+		if (!memctlr_page_reclaim(page, sc->container, sc->overlimit)) {
+			list_add(&page->lru, &l_active);
+			continue;
+		}
 		if (page_mapped(page)) {
 			if (!reclaim_mapped ||
 			    (total_swap_pages == 0 && PageAnon(page)) ||
@@ -1008,6 +1017,8 @@ unsigned long try_to_free_pages(struct z
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
 		.may_swap = 1,
 		.swappiness = vm_swappiness,
+		.overlimit = SC_OVERLIMIT_NONE,
+		.container = NULL,
 	};
 
 	count_vm_event(ALLOCSTALL);
@@ -1104,6 +1115,8 @@ static unsigned long balance_pgdat(pg_da
 		.may_swap = 1,
 		.swap_cluster_max = SWAP_CLUSTER_MAX,
 		.swappiness = vm_swappiness,
+		.overlimit = SC_OVERLIMIT_NONE,
+		.container = NULL,
 	};
 
 loop_again:
@@ -1324,7 +1337,7 @@ void wakeup_kswapd(struct zone *zone, in
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) || defined(CONFIG_RES_GROUPS_MEMORY)
 /*
  * Helper function for shrink_all_memory().  Tries to reclaim 'nr_pages' pages
  * from LRU lists system-wide, for given pass and priority, and returns the
@@ -1368,7 +1381,60 @@ static unsigned long shrink_all_zones(un
 
 	return ret;
 }
+#endif
 
+#ifdef CONFIG_RES_GROUPS_MEMORY
+/*
+ * Modelled after shrink_all_memory
+ */
+unsigned long memctlr_shrink_container_memory(unsigned long nr_pages,
+						struct container *container,
+						int overlimit)
+{
+	unsigned long lru_pages;
+	unsigned long ret = 0;
+	int pass;
+	struct zone *zone;
+	struct scan_control sc = {
+		.gfp_mask = GFP_KERNEL,
+		.may_swap = 0,
+		.swap_cluster_max = nr_pages,
+		.may_writepage = 1,
+		.swappiness = vm_swappiness,
+		.overlimit = overlimit,
+		.container = container,
+	};
+
+	lru_pages = 0;
+	for_each_zone(zone)
+		lru_pages += zone->nr_active + zone->nr_inactive;
+
+	for (pass = 0; pass < 5; pass++) {
+		int prio;
+
+		/* Force reclaiming mapped pages in the passes #3 and #4 */
+		if (pass > 2) {
+			sc.may_swap = 1;
+			sc.swappiness = 100;
+		}
+
+		for (prio = DEF_PRIORITY; prio >= 0; prio--) {
+			unsigned long nr_to_scan = nr_pages - ret;
+
+			sc.nr_scanned = 0;
+			ret += shrink_all_zones(nr_to_scan, prio, pass, &sc);
+			if (ret >= nr_pages)
+				break;
+
+			if (sc.nr_scanned && prio < DEF_PRIORITY - 2)
+				blk_congestion_wait(WRITE, HZ / 10);
+		}
+	}
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM
 /*
  * Try to free `nr_pages' of memory, system-wide, and return the number of
  * freed pages.
@@ -1390,6 +1456,8 @@ unsigned long shrink_all_memory(unsigned
 		.swap_cluster_max = nr_pages,
 		.may_writepage = 1,
 		.swappiness = vm_swappiness,
+		.overlimit = SC_OVERLIMIT_NONE,
+		.container = NULL,
 	};
 
 	current->reclaim_state = &reclaim_state;
@@ -1585,6 +1653,8 @@ static int __zone_reclaim(struct zone *z
 					SWAP_CLUSTER_MAX),
 		.gfp_mask = gfp_mask,
 		.swappiness = vm_swappiness,
+		.overlimit = SC_OVERLIMIT_NONE,
+		.container = NULL,
 	};
 	unsigned long slab_reclaimable;
 
diff -puN kernel/res_group/memctlr.c~container-memctlr-reclaim kernel/res_group/memctlr.c
--- linux-2.6.19-rc2/kernel/res_group/memctlr.c~container-memctlr-reclaim	2006-11-09 22:21:11.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/res_group/memctlr.c	2006-11-09 22:21:11.000000000 +0530
@@ -33,6 +33,7 @@
 #include <linux/memctlr.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
+#include <linux/workqueue.h>
 #include <asm/pgtable.h>
 
 static const char res_ctlr_name[] = "memctlr";
@@ -40,7 +41,10 @@ static struct resource_group *root_rgrou
 static const char version[] = "0.05";
 static struct memctlr *memctlr_root;
 
-#define MEMCTLR_MAGIC	0xdededede
+static void memctlr_callback(void *data);
+static atomic_long_t failed_inc_rss;
+static atomic_long_t failed_dec_rss;
+
 
 struct mem_counter {
 	atomic_long_t	rss;
@@ -57,9 +61,12 @@ struct memctlr {
 	int magic;
 	spinlock_t lock;
 	long nr_pages;
+	int reclaim_in_progress;
 };
 
 struct res_controller memctlr_rg;
+static DECLARE_WORK(memctlr_work, memctlr_callback, NULL);
+#define MEMCTLR_MAGIC	0xdededede
 
 static struct memctlr *get_memctlr_from_shares(struct res_shares *shares)
 {
@@ -96,7 +103,7 @@ void mm_free_mem_counter(struct mm_struc
 void mm_assign_container(struct mm_struct *mm, struct task_struct *p)
 {
 	rcu_read_lock();
-	mm->container = rcu_dereference(p->container);
+	rcu_assign_pointer(mm->container, rcu_dereference(p->container));
 	rcu_read_unlock();
 }
 
@@ -123,38 +130,64 @@ static inline struct memctlr *get_task_m
 	return res;
 }
 
-
-void memctlr_inc_rss_mm(struct page *page, struct mm_struct *mm)
+static void memctlr_callback(void *data)
 {
-	struct memctlr *res;
+	struct memctlr *res = (struct memctlr *)data;
+	long rss;
+	unsigned long nr_shrink = 0;
 
-	res = get_task_memctlr(current);
-	if (!res) {
-		printk(KERN_INFO "inc_rss no res set *---*\n");
-		return;
-	}
+	BUG_ON(!res);
 
 	spin_lock(&res->lock);
-	atomic_long_inc(&mm->counter->rss);
-	atomic_long_inc(&res->counter.rss);
+	rss = atomic_long_read(&res->counter.rss);
+	if ((rss > res->nr_pages) && (res->nr_pages > 0))
+		nr_shrink = rss - ((res->nr_pages * 4) / 5);
+	spin_unlock(&res->lock);
+
+	if (nr_shrink)
+		memctlr_shrink_container_memory(nr_shrink, res->rgroup,
+						SC_OVERLIMIT_ONE);
+	spin_lock(&res->lock);
+	res->reclaim_in_progress = 0;
 	spin_unlock(&res->lock);
 }
 
-void memctlr_inc_rss(struct page *page)
+void memctlr_inc_rss_mm(struct page *page, struct mm_struct *mm)
 {
 	struct memctlr *res;
-	struct mm_struct *mm = get_task_mm(current);
+	long rss;
 
 	res = get_task_memctlr(current);
 	if (!res) {
-		printk(KERN_INFO "inc_rss no res set *---*\n");
+		atomic_long_inc(&failed_inc_rss);
 		return;
 	}
 
 	spin_lock(&res->lock);
 	atomic_long_inc(&mm->counter->rss);
 	atomic_long_inc(&res->counter.rss);
+	rss = atomic_long_read(&res->counter.rss);
+	if ((res->nr_pages < rss) && (res->nr_pages > 0)) {
+		/*
+		 * Reclaim if we exceed our limit
+		 * Schedule a job to do so
+	 	*/
+		if (res->reclaim_in_progress)
+			goto done;
+		res->reclaim_in_progress = 1;
+		spin_unlock(&res->lock);
+		PREPARE_WORK(&memctlr_work, memctlr_callback, res);
+		schedule_work(&memctlr_work);
+		return;
+	}
+done:
 	spin_unlock(&res->lock);
+}
+
+void memctlr_inc_rss(struct page *page)
+{
+	struct mm_struct *mm = get_task_mm(current);
+	memctlr_inc_rss_mm(page, mm);
 	mmput(mm);
 }
 
@@ -162,9 +195,9 @@ void memctlr_dec_rss(struct page *page, 
 {
 	struct memctlr *res;
 
-	res = get_task_memctlr(current);
+	res = get_memctlr(mm->container);
 	if (!res) {
-		printk(KERN_INFO "dec_rss no res set *---*\n");
+		atomic_long_inc(&failed_dec_rss);
 		return;
 	}
 
@@ -183,6 +216,7 @@ static void memctlr_init_new(struct memc
 
 	memctlr_init_mem_counter(&res->counter);
 	res->nr_pages = SHARE_DONT_CARE;
+	res->reclaim_in_progress = 0;
 	spin_lock_init(&res->lock);
 }
 
@@ -200,6 +234,7 @@ static struct res_shares *memctlr_alloc_
 		root_rgroup = rgroup;
 		memctlr_root = res;
 		res->nr_pages = nr_free_pages();
+		res->shares.max_shares = SHARE_DEFAULT_DIVISOR;
 		printk("Memory Controller version %s\n", version);
 	}
 	return &res->shares;
@@ -355,6 +390,20 @@ static ssize_t memctlr_show_stats(struct
 	buf += i;
 	len -= i;
 	j += i;
+
+	i = snprintf(buf, len, "Failed INC RSS Pages %ld\n",
+			atomic_long_read(&failed_inc_rss));
+
+	buf += i;
+	len -= i;
+	j += i;
+
+	i = snprintf(buf, len, "Failed DEC RSS Pages %ld\n",
+			atomic_long_read(&failed_dec_rss));
+
+	buf += i;
+	len -= i;
+	j += i;
 	return j;
 }
 
@@ -421,6 +470,8 @@ static void recalc_and_propagate(struct 
 	int child_divisor;
 	u64 numerator;
 	struct memctlr *child_res;
+	long rss;
+	unsigned long nr_shrink = 0;
 
 	if (parres) {
 		if (res->shares.max_shares == SHARE_DONT_CARE ||
@@ -445,6 +496,35 @@ static void recalc_and_propagate(struct 
 		recalc_and_propagate(child_res, res);
 	}
 
+	/*
+	 * Reclaim if our limit was shrunk
+	 */
+	spin_lock(&res->lock);
+	rss = atomic_long_read(&res->counter.rss);
+	if ((rss > res->nr_pages) && (res->nr_pages > 0))
+		nr_shrink = rss - ((res->nr_pages * 4) / 5);
+	spin_unlock(&res->lock);
+
+	if (nr_shrink)
+		memctlr_shrink_container_memory(nr_shrink, NULL,
+						SC_OVERLIMIT_ALL);
+}
+
+int memctlr_over_limit(struct container *container)
+{
+	struct resource_group *rgroup = container;
+	struct memctlr *res;
+	int ret = 0;
+
+	res = get_memctlr(rgroup);
+	if (!res)
+		return ret;
+
+	spin_lock(&res->lock);
+	if (atomic_long_read(&res->counter.rss) > res->nr_pages)
+		ret = 1;
+	spin_unlock(&res->lock);
+	return ret;
 }
 
 static void memctlr_shares_changed(struct res_shares *shares)
@@ -477,6 +557,8 @@ int __init memctlr_init(void)
 {
 	if (memctlr_rg.ctlr_id != NO_RES_ID)
 		return -EBUSY;	/* already registered */
+	atomic_long_set(&failed_inc_rss, 0);
+	atomic_long_set(&failed_dec_rss, 0);
 	return register_controller(&memctlr_rg);
 }
 
diff -puN include/linux/memctlr.h~container-memctlr-reclaim include/linux/memctlr.h
--- linux-2.6.19-rc2/include/linux/memctlr.h~container-memctlr-reclaim	2006-11-09 22:21:11.000000000 +0530
+++ linux-2.6.19-rc2-balbir/include/linux/memctlr.h	2006-11-09 22:21:11.000000000 +0530
@@ -34,6 +34,12 @@ extern void memctlr_inc_rss_mm(struct pa
 extern void memctlr_dec_rss(struct page *page, struct mm_struct *mm);
 extern void mm_free_mem_counter(struct mm_struct *mm);
 extern int  proc_memacct(struct task_struct *task, char *buffer);
+extern unsigned long memctlr_shrink_container_memory(unsigned long nr_pages,
+						struct container *container,
+						int overlimit);
+extern int memctlr_page_reclaim(struct page *page, void *container,
+				int overlimit);
+extern int memctlr_over_limit(struct container *container);
 
 #else /* CONFIG_RES_GROUPS_MEMORY */
 
@@ -54,9 +60,20 @@ int mm_init_mem_counter(struct mm_struct
 void mm_assign_container(struct mm_struct *mm, struct task_struct *p)
 {}
 
+int memctlr_page_reclaim(struct page *page, void *container, int overlimit)
+{
+	return 1;
+}
+
 void mm_free_mem_counter(struct mm_struct *mm)
 {}
 
 #endif /* CONFIG_RES_GROUPS_MEMORY */
 
+enum {
+	SC_OVERLIMIT_NONE,	/* The scan is container independent */
+	SC_OVERLIMIT_ONE,	/* Scan the one container specified */
+	SC_OVERLIMIT_ALL,	/* Scan all containers */
+};
+
 #endif /* _LINUX_MEMCTRL_H */
diff -puN mm/rmap.c~container-memctlr-reclaim mm/rmap.c
--- linux-2.6.19-rc2/mm/rmap.c~container-memctlr-reclaim	2006-11-09 22:21:11.000000000 +0530
+++ linux-2.6.19-rc2-balbir/mm/rmap.c	2006-11-09 22:21:11.000000000 +0530
@@ -604,6 +604,78 @@ void page_remove_rmap(struct page *page,
 	memctlr_dec_rss(page, mm);
 }
 
+#ifdef CONFIG_RES_GROUPS_MEMORY
+/*
+ * Can we push this code down to try_to_unmap()?
+ */
+int memctlr_page_reclaim(struct page *page, void *container, int overlimit)
+{
+	int ret = 0;
+
+	if (overlimit == SC_OVERLIMIT_NONE)
+		return 1;
+	if (container == NULL && overlimit != SC_OVERLIMIT_ALL)
+		return 1;
+
+	if (!page_mapped(page))
+		return 0;
+
+	if (PageAnon(page)) {
+		struct anon_vma *anon_vma;
+		struct vm_area_struct *vma;
+
+		anon_vma = page_lock_anon_vma(page);
+		if (!anon_vma)
+			return 0;
+
+		list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
+			if (memctlr_over_limit(vma->vm_mm->container) &&
+				((container == vma->vm_mm->container) ||
+				  (overlimit == SC_OVERLIMIT_ALL))) {
+				ret = 1;
+				break;
+			}
+		}
+		spin_unlock(&anon_vma->lock);
+	} else {
+		struct address_space *mapping = page_mapping(page);
+		pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+		struct vm_area_struct *vma;
+		struct prio_tree_iter iter;
+
+		if (!mapping)
+			return 0;
+
+		spin_lock(&mapping->i_mmap_lock);
+		vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff,
+								pgoff) {
+			if (memctlr_over_limit(vma->vm_mm->container) &&
+				((container == vma->vm_mm->container) ||
+				  (overlimit == SC_OVERLIMIT_ALL))) {
+				ret = 1;
+				break;
+			}
+		}
+		if (ret)
+			goto done;
+
+		list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
+					shared.vm_set.list) {
+			if (memctlr_over_limit(vma->vm_mm->container) &&
+				((container == vma->vm_mm->container) ||
+				  (overlimit == SC_OVERLIMIT_ALL))) {
+				ret = 1;
+				break;
+			}
+		}
+done:
+		spin_unlock(&mapping->i_mmap_lock);
+	}
+
+	return ret;
+}
+#endif
+
 /*
  * Subfunctions of try_to_unmap: try_to_unmap_one called
  * repeatedly from either try_to_unmap_anon or try_to_unmap_file.
diff -puN kernel/fork.c~container-memctlr-reclaim kernel/fork.c
--- linux-2.6.19-rc2/kernel/fork.c~container-memctlr-reclaim	2006-11-09 22:21:11.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/fork.c	2006-11-09 22:21:11.000000000 +0530
@@ -364,6 +364,7 @@ struct mm_struct * mm_alloc(void)
 	if (mm) {
 		memset(mm, 0, sizeof(*mm));
 		mm = mm_init(mm);
+		mm_assign_container(mm, current);
 	}
 	return mm;
 }
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
