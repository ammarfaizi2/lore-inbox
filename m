Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWKIThO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWKIThO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWKITgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:36:54 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:48373 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030421AbWKITgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:36:41 -0500
From: Balbir Singh <balbir@in.ibm.com>
To: Linux MM <linux-mm@kvack.org>
Cc: dev@openvz.org, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       haveblue@us.ibm.com, rohitseth@google.com,
       Balbir Singh <balbir@in.ibm.com>
Date: Fri, 10 Nov 2006 01:06:00 +0530
Message-Id: <20061109193600.21437.74220.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
Subject: [RFC][PATCH 4/8] RSS controller accounting
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Account RSS usage of a task and the associated container. The definition
of RSS was debated and discussed in the following thread

	http://lkml.org/lkml/2006/10/10/130


The code tracks all resident pages (including shared pages) as RSS. This patch
can easily adapt to the definition of RSS that will be agreed upon. This
implementation provides a proof of concept RSS controller.

The accounting is inspired from Rohit Seth's container patches.

TODO's

1. Merge file_rss and anon_rss tracking with the current rss tracking to
   maximize code reuse
2. Add/remove RSS tracking as the definition of RSS evolves


Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/memctlr.h    |   26 +++++++++++
 include/linux/rmap.h       |    2 
 include/linux/sched.h      |   11 +++++
 kernel/fork.c              |    6 ++
 kernel/res_group/memctlr.c |   99 +++++++++++++++++++++++++++++++++++++++++++--
 mm/rmap.c                  |    6 ++
 6 files changed, 145 insertions(+), 5 deletions(-)

diff -puN include/linux/sched.h~container-memctlr-acct include/linux/sched.h
--- linux-2.6.19-rc2/include/linux/sched.h~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
+++ linux-2.6.19-rc2-balbir/include/linux/sched.h	2006-11-09 21:46:22.000000000 +0530
@@ -88,6 +88,10 @@ struct sched_param {
 struct exec_domain;
 struct futex_pi_state;
 
+struct memctlr;
+struct container;
+struct mem_counter;
+
 /*
  * List of flags we want to share for kernel threads,
  * if only because they are not used by them anyway.
@@ -355,6 +359,13 @@ struct mm_struct {
 	/* aio bits */
 	rwlock_t		ioctx_list_lock;
 	struct kioctx		*ioctx_list;
+#ifdef CONFIG_RES_GROUPS_MEMORY
+	struct container	*container;
+	/*
+	 * Try and merge anon and file rss accounting
+	 */
+	struct mem_counter	*counter;
+#endif
 };
 
 struct sighand_struct {
diff -puN kernel/res_group/memctlr.c~container-memctlr-acct kernel/res_group/memctlr.c
--- linux-2.6.19-rc2/kernel/res_group/memctlr.c~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/res_group/memctlr.c	2006-11-09 21:47:06.000000000 +0530
@@ -37,6 +37,8 @@ static struct resource_group *root_rgrou
 static const char version[] = "0.01";
 static struct memctlr *memctlr_root;
 
+#define MEMCTLR_MAGIC	0xdededede
+
 struct mem_counter {
 	atomic_long_t	rss;
 };
@@ -49,6 +51,7 @@ struct memctlr {
 	/* Statistics */
 	int successes;
 	int failures;
+	int magic;
 };
 
 struct res_controller memctlr_rg;
@@ -66,12 +69,91 @@ static struct memctlr *get_memctlr(struc
 								&memctlr_rg));
 }
 
+static void memctlr_init_mem_counter(struct mem_counter *counter)
+{
+	atomic_long_set(&counter->rss, 0);
+}
+
+int mm_init_mem_counter(struct mm_struct *mm)
+{
+	mm->counter = kmalloc(sizeof(struct mem_counter), GFP_KERNEL);
+	if (!mm->counter)
+		return -ENOMEM;
+	memctlr_init_mem_counter(mm->counter);
+	return 0;
+}
+
+void mm_free_mem_counter(struct mm_struct *mm)
+{
+	kfree(mm->counter);
+}
+
+void mm_assign_container(struct mm_struct *mm, struct task_struct *p)
+{
+	rcu_read_lock();
+	mm->container = rcu_dereference(p->container);
+	rcu_read_unlock();
+}
+
+static inline struct memctlr *get_memctlr_from_page(struct page *page)
+{
+	struct resource_group *rgroup;
+	struct memctlr *res;
+
+	/*
+	 * Is the resource groups infrastructure initialized?
+	 */
+	if (!memctlr_root)
+		return NULL;
+
+	rcu_read_lock();
+	rgroup = (struct resource_group *)rcu_dereference(current->container);
+	rcu_read_unlock();
+
+	res = get_memctlr(rgroup);
+	if (!res)
+		return NULL;
+
+	BUG_ON(res->magic != MEMCTLR_MAGIC);
+	return res;
+}
+
+
+void memctlr_inc_rss(struct page *page)
+{
+	struct memctlr *res;
+
+	res = get_memctlr_from_page(page);
+	if (!res)
+		return;
+
+	atomic_long_inc(&current->mm->counter->rss);
+	atomic_long_inc(&res->counter.rss);
+}
+
+void memctlr_dec_rss(struct page *page)
+{
+	struct memctlr *res;
+
+	res = get_memctlr_from_page(page);
+	if (!res)
+		return;
+
+	atomic_long_dec(&res->counter.rss);
+
+	if ((current->flags & PF_EXITING) && !current->mm)
+		return;
+	atomic_long_dec(&current->mm->counter->rss);
+}
+
 static void memctlr_init_new(struct memctlr *res)
 {
 	res->shares.min_shares = SHARE_DONT_CARE;
 	res->shares.max_shares = SHARE_DONT_CARE;
 	res->shares.child_shares_divisor = SHARE_DEFAULT_DIVISOR;
 	res->shares.unused_min_shares = SHARE_DEFAULT_DIVISOR;
+
+	memctlr_init_mem_counter(&res->counter);
 }
 
 static struct res_shares *memctlr_alloc_instance(struct resource_group *rgroup)
@@ -83,6 +165,7 @@ static struct res_shares *memctlr_alloc_
 		return NULL;
 	res->rgroup = rgroup;
 	memctlr_init_new(res);
+	res->magic = MEMCTLR_MAGIC;
 	if (is_res_group_root(rgroup)) {
 		root_rgroup = rgroup;
 		memctlr_root = res;
@@ -93,7 +176,7 @@ static struct res_shares *memctlr_alloc_
 
 static void memctlr_free_instance(struct res_shares *shares)
 {
-	struct memctlr *res, *parres;
+	struct memctlr *res;
 
 	res = get_memctlr_from_shares(shares);
 	BUG_ON(!res);
@@ -108,12 +191,19 @@ static void memctlr_free_instance(struct
 static ssize_t memctlr_show_stats(struct res_shares *shares, char *buf,
 					size_t len)
 {
-	int i = 0;
+	int i = 0, j = 0;
+	struct memctlr *res;
+
+	res = get_memctlr_from_shares(shares);
+	BUG_ON(!res);
 
-	i += snprintf(buf, len, "Accounting will be added soon\n");
+	i = snprintf(buf, len, "RSS Pages %ld\n",
+			atomic_long_read(&res->counter.rss));
 	buf += i;
 	len -= i;
-	return i;
+	j += i;
+
+	return j;
 }
 
 struct res_controller memctlr_rg = {
@@ -142,5 +232,6 @@ void __exit memctlr_exit(void)
 	BUG_ON(rc != 0);
 }
 
+
 module_init(memctlr_init);
 module_exit(memctlr_exit);
diff -puN include/linux/memctlr.h~container-memctlr-acct include/linux/memctlr.h
--- linux-2.6.19-rc2/include/linux/memctlr.h~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
+++ linux-2.6.19-rc2-balbir/include/linux/memctlr.h	2006-11-09 21:46:22.000000000 +0530
@@ -26,6 +26,32 @@
 
 #ifdef CONFIG_RES_GROUPS_MEMORY
 #include <linux/res_group_rc.h>
+
+extern int mm_init_mem_counter(struct mm_struct *mm);
+extern void mm_assign_container(struct mm_struct *mm, struct task_struct *p);
+extern void memctlr_inc_rss(struct page *page);
+extern void memctlr_dec_rss(struct page *page);
+extern void mm_free_mem_counter(struct mm_struct *mm);
+
+#else /* CONFIG_RES_GROUPS_MEMORY */
+
+void memctlr_inc_rss(struct page *page)
+{}
+
+void memctlr_dec_rss(struct page *page)
+{}
+
+int mm_init_mem_counter(struct mm_struct *mm)
+{
+	return 0;
+}
+
+void mm_assign_container(struct mm_struct *mm, struct task_struct *p)
+{}
+
+void mm_free_mem_counter(struct mm_struct *mm)
+{}
+
 #endif /* CONFIG_RES_GROUPS_MEMORY */
 
 #endif /* _LINUX_MEMCTRL_H */
diff -puN kernel/fork.c~container-memctlr-acct kernel/fork.c
--- linux-2.6.19-rc2/kernel/fork.c~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/fork.c	2006-11-09 21:46:22.000000000 +0530
@@ -49,6 +49,7 @@
 #include <linux/taskstats_kern.h>
 #include <linux/random.h>
 #include <linux/numtasks.h>
+#include <linux/memctlr.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -340,11 +341,14 @@ static struct mm_struct * mm_init(struct
 	mm->ioctx_list = NULL;
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->cached_hole_size = ~0UL;
+	if (mm_init_mem_counter(mm) < 0)
+		goto mem_fail;
 
 	if (likely(!mm_alloc_pgd(mm))) {
 		mm->def_flags = 0;
 		return mm;
 	}
+mem_fail:
 	free_mm(mm);
 	return NULL;
 }
@@ -372,6 +376,7 @@ struct mm_struct * mm_alloc(void)
 void fastcall __mmdrop(struct mm_struct *mm)
 {
 	BUG_ON(mm == &init_mm);
+	mm_free_mem_counter(mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
 	free_mm(mm);
@@ -544,6 +549,7 @@ static int copy_mm(unsigned long clone_f
 
 good_mm:
 	tsk->mm = mm;
+	mm_assign_container(mm, tsk);
 	tsk->active_mm = mm;
 	return 0;
 
diff -puN mm/rmap.c~container-memctlr-acct mm/rmap.c
--- linux-2.6.19-rc2/mm/rmap.c~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
+++ linux-2.6.19-rc2-balbir/mm/rmap.c	2006-11-09 21:46:22.000000000 +0530
@@ -537,6 +537,7 @@ void page_add_anon_rmap(struct page *pag
 	if (atomic_inc_and_test(&page->_mapcount))
 		__page_set_anon_rmap(page, vma, address);
 	/* else checking page index and mapping is racy */
+	memctlr_inc_rss(page);
 }
 
 /*
@@ -553,6 +554,7 @@ void page_add_new_anon_rmap(struct page 
 {
 	atomic_set(&page->_mapcount, 0); /* elevate count by 1 (starts at -1) */
 	__page_set_anon_rmap(page, vma, address);
+	memctlr_inc_rss(page);
 }
 
 /**
@@ -565,6 +567,7 @@ void page_add_file_rmap(struct page *pag
 {
 	if (atomic_inc_and_test(&page->_mapcount))
 		__inc_zone_page_state(page, NR_FILE_MAPPED);
+	memctlr_inc_rss(page);
 }
 
 /**
@@ -596,8 +599,9 @@ void page_remove_rmap(struct page *page)
 		if (page_test_and_clear_dirty(page))
 			set_page_dirty(page);
 		__dec_zone_page_state(page,
-				PageAnon(page) ? NR_ANON_PAGES : NR_FILE_MAPPED);
+				PageAnon(page) ?  NR_ANON_PAGES : NR_FILE_MAPPED);
 	}
+	memctlr_dec_rss(page, mm);
 }
 
 /*
diff -puN include/linux/rmap.h~container-memctlr-acct include/linux/rmap.h
--- linux-2.6.19-rc2/include/linux/rmap.h~container-memctlr-acct	2006-11-09 21:46:22.000000000 +0530
+++ linux-2.6.19-rc2-balbir/include/linux/rmap.h	2006-11-09 21:46:22.000000000 +0530
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/spinlock.h>
+#include <linux/memctlr.h>
 
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
@@ -84,6 +85,7 @@ void page_remove_rmap(struct page *);
 static inline void page_dup_rmap(struct page *page)
 {
 	atomic_inc(&page->_mapcount);
+	memctlr_inc_rss(page);
 }
 
 /*
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
