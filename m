Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVBLDfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVBLDfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVBLDcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:32:02 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38826 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262389AbVBLD00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:26:26 -0500
Date: Fri, 11 Feb 2005 19:26:20 -0800 (PST)
From: Ray Bryant <raybry@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>, Hugh DIckins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcello@cyclades.com>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
In-Reply-To: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
Subject: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration -- sys_page_migrate
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the sys_page_migrate() system call:

sys_page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);

Its intent is to cause the pages in the range given that are found on
old_nodes[i] to be moved to new_nodes[i].  Count is the the number of
entries in these two arrays of short.

Restrictions and limitations of this version:

(1)  va_start and va_end must be mapped by the same vma.  (The user
     can read /proc/pid/maps to find out the appropriate vma ranges.)
     This could easily be generalized, but has not been done for the
     moment.

(2)  There is no capability or authority checking being done here.
     Any process can migrate any other process.  This will be fixed
     in a future version, once we agree on what the authority model
     should be.

(3)  Eventually, we plan on adding a page_migrate entry to the 
     vm_operations_struct.  The problem is, in general, that only
     the object itself knows how to migrate its pages.  For the
     moment, we are only handling the case of anonymous private
     and memory mapped files, which handles practially all known
     cases, but there are som other cases that are peculiar to
     SN2 hardware that are not handled by the present code (e. g.
     fetch & op storage).  So for now, it is sufficient for us
     to test vma->vm_ops pointer; if this is null we are in the
     anonymoust private case, elsewise we are in the mapped file
     case.  The mapped file case handles mapped files, shared
     anonymouse storage, and shared segments.


Signed-off-by:Ray Bryant <raybry@sgi.com>

Index: linux-2.6.11-rc2-mm2/arch/ia64/kernel/entry.S
===================================================================
--- linux-2.6.11-rc2-mm2.orig/arch/ia64/kernel/entry.S	2005-02-11 08:18:58.000000000 -0800
+++ linux-2.6.11-rc2-mm2/arch/ia64/kernel/entry.S	2005-02-11 16:07:27.000000000 -0800
@@ -1581,6 +1581,6 @@ sys_call_table:
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
-	data8 sys_ni_syscall
+	data8 sys_page_migrate                  // 1279
 
 	.org sys_call_table + 8*NR_syscalls	// guard against failures to increase NR_syscalls
Index: linux-2.6.11-rc2-mm2/mm/mmigrate.c
===================================================================
--- linux-2.6.11-rc2-mm2.orig/mm/mmigrate.c	2005-02-11 16:07:27.000000000 -0800
+++ linux-2.6.11-rc2-mm2/mm/mmigrate.c	2005-02-11 16:10:13.000000000 -0800
@@ -588,6 +588,228 @@ int try_to_migrate_pages(struct list_hea
 	return nr_busy;
 }
 
+static int
+migrate_vma_common(struct list_head *page_list, short *node_map, int count)
+{
+	int pass=0, remains, migrated;
+	struct page *page;
+
+	while(pass<10) {
+
+		remains = try_to_migrate_pages(page_list, node_map);
+
+		if (remains < 0)
+			return remains;
+
+		migrated = 0;
+		if (!list_empty(page_list))
+			list_for_each_entry(page, page_list, lru)
+				migrated++;
+		else {
+			migrated = count;
+			break;
+		}
+
+		pass++;
+
+		migrated = count - migrated;
+
+		/* wait a bit and try again */
+		msleep(10);
+
+	}
+	return migrated;
+}
+
+static int
+migrate_mapped_file_vma(struct task_struct *task, struct mm_struct *mm,
+	              struct vm_area_struct *vma, size_t va_start,
+		      size_t va_end, short *node_map)
+{
+	struct page *page;
+	struct zone *zone;
+	struct address_space *as;
+	int count = 0, nid, ret;
+	LIST_HEAD(page_list);
+	long idx, start_idx, end_idx;
+
+	va_start = va_start & PAGE_MASK;
+	va_end   = va_end   & PAGE_MASK;
+	start_idx = (va_start - vma->vm_start) >> PAGE_SHIFT;
+	end_idx   = (va_end   - vma->vm_start) >> PAGE_SHIFT;
+
+	if (!vma->vm_file || !vma->vm_file->f_mapping)
+		BUG();
+
+	as = vma->vm_file->f_mapping;
+
+	for (idx = start_idx; idx <= end_idx; idx++) {
+		page = find_get_page(as, idx);
+		if (page) {
+			page_cache_release(page);
+
+			if (!page_mapcount(page) && !page->mapping)
+				BUG();
+
+			nid = page_to_nid(page);
+			if (node_map[nid] > 0) {
+				zone = page_zone(page);
+				spin_lock_irq(&zone->lru_lock);
+				if (PageLRU(page) && 
+				    __steal_page_from_lru(zone, page)) {
+					count++;
+					list_add(&page->lru, &page_list);
+				} else 
+					BUG();
+				spin_unlock_irq(&zone->lru_lock);
+			}
+		} 
+	}
+
+	ret = migrate_vma_common(&page_list, node_map, count);
+
+	return ret;
+
+}
+
+static int
+migrate_anon_private_vma(struct task_struct *task, struct mm_struct *mm,
+	              struct vm_area_struct *vma, size_t va_start,
+		      size_t va_end, short *node_map)
+{
+	struct page *page;
+	struct zone *zone;
+	unsigned long vaddr;
+	int count = 0, nid, ret;
+	LIST_HEAD(page_list);
+
+	va_start = va_start & PAGE_MASK;
+	va_end   = va_end   & PAGE_MASK;
+
+	for (vaddr=va_start; vaddr<=va_end; vaddr += PAGE_SIZE) {
+		spin_lock(&mm->page_table_lock);
+		page = follow_page(mm, vaddr, 0);
+		spin_unlock(&mm->page_table_lock);
+		/* 
+		 * follow_page has been observed to return pages with zero 
+		 * mapcount and NULL mapping.  Skip those pages as well
+		 */
+		if (page && page_mapcount(page) && page->mapping) {
+			nid = page_to_nid(page);
+			if (node_map[nid] > 0) {
+				zone = page_zone(page);
+				spin_lock_irq(&zone->lru_lock);
+				if (PageLRU(page) &&
+			     	    __steal_page_from_lru(zone, page)) {
+					count++;
+					list_add(&page->lru, &page_list);
+				} else
+					BUG();
+				spin_unlock_irq(&zone->lru_lock);
+			}
+		}
+	}
+
+	ret = migrate_vma_common(&page_list, node_map, count);
+
+	return ret;
+}
+
+void lru_add_drain_per_cpu(void *info) {
+	lru_add_drain();
+}
+
+asmlinkage long
+sys_page_migrate(const pid_t pid, size_t va_start, size_t va_end,
+		const int count, caddr_t old_nodes, caddr_t new_nodes)
+{
+	int i, ret = 0;
+	short *tmp_old_nodes;
+	short *tmp_new_nodes;
+	short *node_map;
+	struct task_struct *task;
+	struct mm_struct *mm = 0;
+	size_t size = count*sizeof(short);
+	struct vm_area_struct *vma, *vma2;
+
+
+	tmp_old_nodes = (short *) kmalloc(size, GFP_KERNEL);
+	tmp_new_nodes = (short *) kmalloc(size, GFP_KERNEL);
+	node_map = (short *) kmalloc(MAX_NUMNODES*sizeof(short), GFP_KERNEL);
+
+	if (!tmp_old_nodes || !tmp_new_nodes || !node_map) {
+		ret = -ENOMEM;
+		goto out_nodec;
+	}
+
+	if (copy_from_user(tmp_old_nodes, old_nodes, size) || 
+	    copy_from_user(tmp_new_nodes, new_nodes, size)) {
+		ret = -EFAULT;
+		goto out_nodec;
+	}
+
+	read_lock(&tasklist_lock);
+	task = find_task_by_pid(pid);
+	if (task) {
+		task_lock(task);
+		mm = task->mm;
+		if (mm)
+			atomic_inc(&mm->mm_users);
+		task_unlock(task);
+	} else {
+		ret = -ESRCH;
+		goto out_nodec;
+	}
+	read_unlock(&tasklist_lock);
+	if (!mm) {
+		ret = -EINVAL;
+		goto out_nodec;
+	}
+
+	/* 
+	 * for now, we require both the start and end addresses to
+	 * be mapped by the same vma.
+	 */
+	vma = find_vma(mm, va_start);
+	vma2 = find_vma(mm, va_end);
+	if (!vma || !vma2 || (vma != vma2)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* set up the node_map array */
+	for(i=0; i<MAX_NUMNODES; i++)
+		node_map[i] = -1;
+	for(i=0; i<count; i++)
+		node_map[tmp_old_nodes[i]] = tmp_new_nodes[i];
+
+	/* prepare for lru list manipulation */
+ 	smp_call_function(&lru_add_drain_per_cpu, NULL, 0, 1);
+	lru_add_drain();
+
+	/* actually do the migration */
+	if (vma->vm_ops)
+		ret = migrate_mapped_file_vma(task, mm, vma, va_start, va_end,
+			node_map);
+	else
+		ret = migrate_anon_private_vma(task, mm, vma, va_start, va_end,
+			node_map);
+
+out:
+	atomic_dec(&mm->mm_users);
+
+out_nodec:
+	if (tmp_old_nodes)
+		kfree(tmp_old_nodes);
+	if (tmp_new_nodes)
+		kfree(tmp_new_nodes);
+	if (node_map)
+		kfree(node_map);
+
+	return ret;
+
+}
+
 EXPORT_SYMBOL(generic_migrate_page);
 EXPORT_SYMBOL(migrate_page_common);
 EXPORT_SYMBOL(migrate_page_buffer);

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
