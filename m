Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbWKITgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbWKITgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 14:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWKITgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 14:36:38 -0500
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:56308 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030421AbWKITg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 14:36:28 -0500
From: Balbir Singh <balbir@in.ibm.com>
To: Linux MM <linux-mm@kvack.org>
Cc: dev@openvz.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       rohitseth@google.com, Balbir Singh <balbir@in.ibm.com>
Date: Fri, 10 Nov 2006 01:06:09 +0530
Message-Id: <20061109193609.21437.82971.sendpatchset@balbir.in.ibm.com>
In-Reply-To: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
Subject: [RFC][PATCH 5/8] RSS controller task migration support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Support migration of tasks across groups. Migration uses the accounting
information tracked in the mm_struct to add/delete RSS from the container as
a process migrates from one container to the next.

This patch also adds a /proc/<tid>/memacct interface for debugging purposes.
/proc/<tid>/memacct prints the rss of the task

1. As accounted by the patches
2. By walking the page tables of the process


Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 fs/proc/base.c             |    4 
 include/linux/memctlr.h    |    9 +
 include/linux/rmap.h       |    6 -
 kernel/res_group/memctlr.c |  228 ++++++++++++++++++++++++++++++++++++++++++---
 mm/filemap_xip.c           |    2 
 mm/fremap.c                |    2 
 mm/memory.c                |    6 -
 mm/rmap.c                  |    6 -
 8 files changed, 236 insertions(+), 27 deletions(-)

diff -puN kernel/res_group/memctlr.c~container-memctlr-task-migration kernel/res_group/memctlr.c
--- linux-2.6.19-rc2/kernel/res_group/memctlr.c~container-memctlr-task-migration	2006-11-09 21:56:49.000000000 +0530
+++ linux-2.6.19-rc2-balbir/kernel/res_group/memctlr.c	2006-11-09 21:56:49.000000000 +0530
@@ -31,10 +31,12 @@
 #include <linux/module.h>
 #include <linux/res_group_rc.h>
 #include <linux/memctlr.h>
+#include <linux/mm.h>
+#include <asm/pgtable.h>
 
 static const char res_ctlr_name[] = "memctlr";
 static struct resource_group *root_rgroup;
-static const char version[] = "0.01";
+static const char version[] = "0.05";
 static struct memctlr *memctlr_root;
 
 #define MEMCTLR_MAGIC	0xdededede
@@ -52,6 +54,7 @@ struct memctlr {
 	int successes;
 	int failures;
 	int magic;
+	spinlock_t lock;
 };
 
 struct res_controller memctlr_rg;
@@ -95,7 +98,7 @@ void mm_assign_container(struct mm_struc
 	rcu_read_unlock();
 }
 
-static inline struct memctlr *get_memctlr_from_page(struct page *page)
+static inline struct memctlr *get_task_memctlr(struct task_struct *p)
 {
 	struct resource_group *rgroup;
 	struct memctlr *res;
@@ -107,7 +110,7 @@ static inline struct memctlr *get_memctl
 		return NULL;
 
 	rcu_read_lock();
-	rgroup = (struct resource_group *)rcu_dereference(current->container);
+	rgroup = (struct resource_group *)rcu_dereference(p->container);
 	rcu_read_unlock();
 
 	res = get_memctlr(rgroup);
@@ -119,31 +122,54 @@ static inline struct memctlr *get_memctl
 }
 
 
-void memctlr_inc_rss(struct page *page)
+void memctlr_inc_rss_mm(struct page *page, struct mm_struct *mm)
 {
 	struct memctlr *res;
 
-	res = get_memctlr_from_page(page);
-	if (!res)
+	res = get_task_memctlr(current);
+	if (!res) {
+		printk(KERN_INFO "inc_rss no res set *---*\n");
 		return;
+	}
 
-	atomic_long_inc(&current->mm->counter->rss);
+	spin_lock(&res->lock);
+	atomic_long_inc(&mm->counter->rss);
 	atomic_long_inc(&res->counter.rss);
+	spin_unlock(&res->lock);
 }
 
-void memctlr_dec_rss(struct page *page)
+void memctlr_inc_rss(struct page *page)
 {
 	struct memctlr *res;
+	struct mm_struct *mm = get_task_mm(current);
 
-	res = get_memctlr_from_page(page);
-	if (!res)
+	res = get_task_memctlr(current);
+	if (!res) {
+		printk(KERN_INFO "inc_rss no res set *---*\n");
 		return;
+	}
 
-	atomic_long_dec(&res->counter.rss);
+	spin_lock(&res->lock);
+	atomic_long_inc(&mm->counter->rss);
+	atomic_long_inc(&res->counter.rss);
+	spin_unlock(&res->lock);
+	mmput(mm);
+}
 
-	if ((current->flags & PF_EXITING) && !current->mm)
+void memctlr_dec_rss(struct page *page, struct mm_struct *mm)
+{
+	struct memctlr *res;
+
+	res = get_task_memctlr(current);
+	if (!res) {
+		printk(KERN_INFO "dec_rss no res set *---*\n");
 		return;
-	atomic_long_dec(&current->mm->counter->rss);
+	}
+
+	spin_lock(&res->lock);
+	atomic_long_dec(&res->counter.rss);
+	atomic_long_dec(&mm->counter->rss);
+	spin_unlock(&res->lock);
 }
 
 static void memctlr_init_new(struct memctlr *res)
@@ -154,6 +180,7 @@ static void memctlr_init_new(struct memc
 	res->shares.unused_min_shares = SHARE_DEFAULT_DIVISOR;
 
 	memctlr_init_mem_counter(&res->counter);
+	spin_lock_init(&res->lock);
 }
 
 static struct res_shares *memctlr_alloc_instance(struct resource_group *rgroup)
@@ -188,6 +215,122 @@ static void memctlr_free_instance(struct
 	kfree(res);
 }
 
+static long count_pte_rss(struct vm_area_struct *vma, pmd_t *pmd,
+				unsigned long addr, unsigned long end)
+{
+	pte_t *pte;
+	long count = 0;
+
+	do {
+		pte = pte_offset_map(pmd, addr);
+		if (!pte_present(*pte))
+			continue;
+		count++;
+		pte_unmap(pte);
+	} while (pte++, addr += PAGE_SIZE, (addr != end));
+
+	return count;
+}
+
+static long count_pmd_rss(struct vm_area_struct *vma, pud_t *pud,
+				unsigned long addr, unsigned long end)
+{
+	pmd_t *pmd;
+	unsigned long next;
+	long count = 0;
+
+	pmd = pmd_offset(pud, addr);
+	do {
+		next = pmd_addr_end(addr, end);
+		if (pmd_none_or_clear_bad(pmd))
+			continue;
+		count += count_pte_rss(vma, pmd, addr, next);
+	} while (pmd++, addr = next, (addr != end));
+
+	return count;
+}
+
+static long count_pud_rss(struct vm_area_struct *vma, pgd_t *pgd,
+				unsigned long addr, unsigned long end)
+{
+	pud_t *pud;
+	unsigned long next;
+	long count = 0;
+
+	pud = pud_offset(pgd, addr);
+	do {
+		next = pud_addr_end(addr, end);
+		if (pud_none_or_clear_bad(pud))
+			continue;
+		count += count_pmd_rss(vma, pud, addr, next);
+	} while (pud++, addr = next, (addr != end));
+
+	return count;
+}
+
+static long count_pgd_rss(struct vm_area_struct *vma)
+{
+	unsigned long addr, next, end;
+	pgd_t *pgd;
+	long count = 0;
+
+	addr = vma->vm_start;
+	end = vma->vm_end;
+
+	pgd = pgd_offset(vma->vm_mm, addr);
+	do {
+		next = pgd_addr_end(addr, end);
+		if (pgd_none_or_clear_bad(pgd))
+			continue;
+		count += count_pud_rss(vma, pgd, addr, next);
+	} while (pgd++, addr = next, (addr != end));
+	return count;
+}
+
+static long count_rss(struct task_struct *p)
+{
+	int count = 0;
+	struct mm_struct *mm = get_task_mm(p);
+	struct vm_area_struct *vma = mm->mmap;
+
+	if (!mm)
+		return 0;
+
+	down_read(&mm->mmap_sem);
+	spin_lock(&mm->page_table_lock);
+
+	while (vma) {
+		count += count_pgd_rss(vma);
+		vma = vma->vm_next;
+	}
+
+	spin_unlock(&mm->page_table_lock);
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+	return count;
+}
+
+int  proc_memacct(struct task_struct *p, char *buf)
+{
+	int i = 0, j = 0;
+	struct mm_struct *mm = get_task_mm(p);
+
+	if (!mm)
+		return sprintf(buf, "no mm associated with the task\n");
+
+	i = sprintf(buf, "rss pages %ld\n",
+			atomic_long_read(&mm->counter->rss));
+	buf += i;
+	j += i;
+
+	i = sprintf(buf, "pg table walk rss pages %ld\n", count_rss(p));
+	buf += i;
+	j += i;
+
+	mmput(mm);
+	return j;
+}
+
 static ssize_t memctlr_show_stats(struct res_shares *shares, char *buf,
 					size_t len)
 {
@@ -206,12 +349,69 @@ static ssize_t memctlr_show_stats(struct
 	return j;
 }
 
+static void double_res_lock(struct memctlr *old, struct memctlr *new)
+{
+	BUG_ON(old == new);
+	if (&old->lock > &new->lock) {
+		spin_lock(&old->lock);
+		spin_lock(&new->lock);
+	} else {
+		spin_lock(&new->lock);
+		spin_lock(&old->lock);
+	}
+}
+
+static void double_res_unlock(struct memctlr *old, struct memctlr *new)
+{
+	BUG_ON(old == new);
+	if (&old->lock > &new->lock) {
+		spin_unlock(&new->lock);
+		spin_unlock(&old->lock);
+	} else {
+		spin_unlock(&old->lock);
+		spin_unlock(&new->lock);
+	}
+}
+
+static void memctlr_move_task(struct task_struct *p, struct res_shares *old,
+				struct res_shares *new)
+{
+	struct memctlr *oldres, *newres;
+	long rss_pages;
+
+	if (old == new)
+		return;
+
+	/*
+	 * If a task has no mm structure associated with it we have
+	 * nothing to do
+	 */
+	if (!old || !new)
+		return;
+
+	if (p->pid != p->tgid)
+		return;
+
+	oldres = get_memctlr_from_shares(old);
+	newres = get_memctlr_from_shares(new);
+
+	double_res_lock(oldres, newres);
+
+	rss_pages = atomic_long_read(&p->mm->counter->rss);
+	atomic_long_sub(rss_pages, &oldres->counter.rss);
+
+	mm_assign_container(p->mm, p);
+	atomic_long_add(rss_pages, &newres->counter.rss);
+
+	double_res_unlock(oldres, newres);
+}
+
 struct res_controller memctlr_rg = {
 	.name = res_ctlr_name,
 	.ctlr_id = NO_RES_ID,
 	.alloc_shares_struct = memctlr_alloc_instance,
 	.free_shares_struct = memctlr_free_instance,
-	.move_task = NULL,
+	.move_task = memctlr_move_task,
 	.shares_changed = NULL,
 	.show_stats = memctlr_show_stats,
 };
diff -puN fs/proc/base.c~container-memctlr-task-migration fs/proc/base.c
--- linux-2.6.19-rc2/fs/proc/base.c~container-memctlr-task-migration	2006-11-09 21:56:49.000000000 +0530
+++ linux-2.6.19-rc2-balbir/fs/proc/base.c	2006-11-09 21:56:49.000000000 +0530
@@ -72,6 +72,7 @@
 #include <linux/audit.h>
 #include <linux/poll.h>
 #include <linux/nsproxy.h>
+#include <linux/memctlr.h>
 #include "internal.h"
 
 /* NOTE:
@@ -1759,6 +1760,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_NUMA
 	REG("numa_maps",  S_IRUGO, numa_maps),
 #endif
+#ifdef CONFIG_RES_GROUPS_MEMORY
+	INF("memacct",	  S_IRUGO, memacct),
+#endif
 	REG("mem",        S_IRUSR|S_IWUSR, mem),
 #ifdef CONFIG_SECCOMP
 	REG("seccomp",    S_IRUSR|S_IWUSR, seccomp),
diff -puN include/linux/memctlr.h~container-memctlr-task-migration include/linux/memctlr.h
--- linux-2.6.19-rc2/include/linux/memctlr.h~container-memctlr-task-migration	2006-11-09 21:56:49.000000000 +0530
+++ linux-2.6.19-rc2-balbir/include/linux/memctlr.h	2006-11-09 21:56:49.000000000 +0530
@@ -30,15 +30,20 @@
 extern int mm_init_mem_counter(struct mm_struct *mm);
 extern void mm_assign_container(struct mm_struct *mm, struct task_struct *p);
 extern void memctlr_inc_rss(struct page *page);
-extern void memctlr_dec_rss(struct page *page);
+extern void memctlr_inc_rss_mm(struct page *page, struct mm_struct *mm);
+extern void memctlr_dec_rss(struct page *page, struct mm_struct *mm);
 extern void mm_free_mem_counter(struct mm_struct *mm);
+extern int  proc_memacct(struct task_struct *task, char *buffer);
 
 #else /* CONFIG_RES_GROUPS_MEMORY */
 
 void memctlr_inc_rss(struct page *page)
 {}
 
-void memctlr_dec_rss(struct page *page)
+void memctlr_inc_rss_mm(struct page *page, struct mm_struct *mm)
+{}
+
+void memctlr_dec_rss(struct page *page, struct mm_struct *mm)
 {}
 
 int mm_init_mem_counter(struct mm_struct *mm)
diff -puN mm/filemap_xip.c~container-memctlr-task-migration mm/filemap_xip.c
--- linux-2.6.19-rc2/mm/filemap_xip.c~container-memctlr-task-migration	2006-11-09 21:56:49.000000000 +0530
+++ linux-2.6.19-rc2-balbir/mm/filemap_xip.c	2006-11-09 21:56:49.000000000 +0530
@@ -189,7 +189,7 @@ __xip_unmap (struct address_space * mapp
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
 			pteval = ptep_clear_flush(vma, address, pte);
-			page_remove_rmap(page);
+			page_remove_rmap(page, mm);
 			dec_mm_counter(mm, file_rss);
 			BUG_ON(pte_dirty(pteval));
 			pte_unmap_unlock(pte, ptl);
diff -puN mm/fremap.c~container-memctlr-task-migration mm/fremap.c
--- linux-2.6.19-rc2/mm/fremap.c~container-memctlr-task-migration	2006-11-09 21:56:49.000000000 +0530
+++ linux-2.6.19-rc2-balbir/mm/fremap.c	2006-11-09 21:56:49.000000000 +0530
@@ -33,7 +33,7 @@ static int zap_pte(struct mm_struct *mm,
 		if (page) {
 			if (pte_dirty(pte))
 				set_page_dirty(page);
-			page_remove_rmap(page);
+			page_remove_rmap(page, mm);
 			page_cache_release(page);
 		}
 	} else {
diff -puN mm/memory.c~container-memctlr-task-migration mm/memory.c
--- linux-2.6.19-rc2/mm/memory.c~container-memctlr-task-migration	2006-11-09 21:56:49.000000000 +0530
+++ linux-2.6.19-rc2-balbir/mm/memory.c	2006-11-09 21:56:49.000000000 +0530
@@ -481,7 +481,7 @@ copy_one_pte(struct mm_struct *dst_mm, s
 	page = vm_normal_page(vma, addr, pte);
 	if (page) {
 		get_page(page);
-		page_dup_rmap(page);
+		page_dup_rmap(page, dst_mm);
 		rss[!!PageAnon(page)]++;
 	}
 
@@ -681,7 +681,7 @@ static unsigned long zap_pte_range(struc
 					mark_page_accessed(page);
 				file_rss--;
 			}
-			page_remove_rmap(page);
+			page_remove_rmap(page, mm);
 			tlb_remove_page(tlb, page);
 			continue;
 		}
@@ -1575,7 +1575,7 @@ gotten:
 	page_table = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (likely(pte_same(*page_table, orig_pte))) {
 		if (old_page) {
-			page_remove_rmap(old_page);
+			page_remove_rmap(old_page, mm);
 			if (!PageAnon(old_page)) {
 				dec_mm_counter(mm, file_rss);
 				inc_mm_counter(mm, anon_rss);
diff -puN mm/rmap.c~container-memctlr-task-migration mm/rmap.c
--- linux-2.6.19-rc2/mm/rmap.c~container-memctlr-task-migration	2006-11-09 21:56:49.000000000 +0530
+++ linux-2.6.19-rc2-balbir/mm/rmap.c	2006-11-09 21:56:49.000000000 +0530
@@ -576,7 +576,7 @@ void page_add_file_rmap(struct page *pag
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page)
+void page_remove_rmap(struct page *page, struct mm_struct *mm)
 {
 	if (atomic_add_negative(-1, &page->_mapcount)) {
 		if (unlikely(page_mapcount(page) < 0)) {
@@ -689,7 +689,7 @@ static int try_to_unmap_one(struct page 
 		dec_mm_counter(mm, file_rss);
 
 
-	page_remove_rmap(page);
+	page_remove_rmap(page, mm);
 	page_cache_release(page);
 
 out_unmap:
@@ -779,7 +779,7 @@ static void try_to_unmap_cluster(unsigne
 		if (pte_dirty(pteval))
 			set_page_dirty(page);
 
-		page_remove_rmap(page);
+		page_remove_rmap(page, mm);
 		page_cache_release(page);
 		dec_mm_counter(mm, file_rss);
 		(*mapcount)--;
diff -puN include/linux/rmap.h~container-memctlr-task-migration include/linux/rmap.h
--- linux-2.6.19-rc2/include/linux/rmap.h~container-memctlr-task-migration	2006-11-09 21:56:49.000000000 +0530
+++ linux-2.6.19-rc2-balbir/include/linux/rmap.h	2006-11-09 21:56:49.000000000 +0530
@@ -73,7 +73,7 @@ void __anon_vma_link(struct vm_area_stru
 void page_add_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *, unsigned long);
 void page_add_file_rmap(struct page *);
-void page_remove_rmap(struct page *);
+void page_remove_rmap(struct page *, struct mm_struct *);
 
 /**
  * page_dup_rmap - duplicate pte mapping to a page
@@ -82,10 +82,10 @@ void page_remove_rmap(struct page *);
  * For copy_page_range only: minimal extract from page_add_rmap,
  * avoiding unnecessary tests (already checked) so it's quicker.
  */
-static inline void page_dup_rmap(struct page *page)
+static inline void page_dup_rmap(struct page *page, struct mm_struct *mm)
 {
 	atomic_inc(&page->_mapcount);
-	memctlr_inc_rss(page);
+	memctlr_inc_rss_mm(page, mm);
 }
 
 /*
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
