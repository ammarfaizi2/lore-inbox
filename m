Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163488AbWLGWJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163488AbWLGWJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163489AbWLGWJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:09:04 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:3792 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163488AbWLGWJD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:09:03 -0500
Message-ID: <45789124.1070207@mvista.com>
Date: Thu, 07 Dec 2006 14:09:40 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: new procfs memory analysis feature
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

    this implements a feature for memory analysis tools to go along with 
smaps.
It shows reference counts for individual pages instead of aggregate 
totals for a given VMA.
It helps memory analysis tools determine how well pages are being 
shared, or not,
in a shared libraries, etc.

   The per page information is presented in /proc/<pid>/pagemaps.

Signed-off-by: David SIngleton <dsingleton@mvista.com>
Signed-off-by: Joe Green <jgreen@mvista.com>

 Documentation/filesystems/proc.txt |    3 -
 fs/proc/base.c                     |   15 +++++
 fs/proc/internal.h                 |    5 -
 fs/proc/task_mmu.c                 |  110 
+++++++++++++++++++++++++++++++++++++ 4 files changed, 128 
insertions(+), 5 deletions(-)

Index: linux-2.6.18/Documentation/filesystems/proc.txt
===================================================================
--- linux-2.6.18.orig/Documentation/filesystems/proc.txt
+++ linux-2.6.18/Documentation/filesystems/proc.txt
@@ -128,12 +128,13 @@ Table 1-1: Process specific entries in /
  fd      Directory, which contains all file descriptors
  maps   Memory maps to executables and library files           (2.4)
  mem     Memory held by this process
+ pagemaps Based on maps, presents page ref counts for each mapped file
  root   Link to the root directory of this process
+ smaps  Extension based on maps, presenting the rss size for each 
mapped file
  stat    Process status
  statm   Process memory status information
  status  Process status in human readable form
  wchan   If CONFIG_KALLSYMS is set, a pre-decoded wchan
- smaps  Extension based on maps, presenting the rss size for each 
mapped file
 ..............................................................................

 For example, to get the status information of a process, all you have 
to do is
Index: linux-2.6.18/fs/proc/base.c
===================================================================
--- linux-2.6.18.orig/fs/proc/base.c
+++ linux-2.6.18/fs/proc/base.c
@@ -182,6 +182,11 @@ enum pid_directory_inos {
        PROC_TID_OOM_SCORE,
        PROC_TID_OOM_ADJUST,

+#ifdef CONFIG_MMU
+       PROC_TGID_PAGEMAPS,
+       PROC_TID_PAGEMAPS,
+#endif
+
        /* Add new entries before this */
        PROC_TID_FD_DIR = 0x8000,       /* 0x8000-0xffff */
 };
@@ -240,6 +245,9 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_AUDITSYSCALL
        E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_MMU
+       E(PROC_TGID_PAGEMAPS,  "pagemaps", S_IFREG|S_IRUGO),
+#endif
        {0,0,NULL,0}
 };
 static struct pid_entry tid_base_stuff[] = {
@@ -282,6 +290,9 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_AUDITSYSCALL
        E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
+#ifdef CONFIG_MMU
+       E(PROC_TID_PAGEMAPS,   "pagemaps", S_IFREG|S_IRUGO),
+#endif
        {0,0,NULL,0}
 };

@@ -1769,6 +1780,10 @@ static struct dentry *proc_pident_lookup
                case PROC_TGID_SMAPS:
                        inode->i_fop = &proc_smaps_operations;
                        break;
+               case PROC_TID_PAGEMAPS:
+               case PROC_TGID_PAGEMAPS:
+                       inode->i_fop = &proc_pagemaps_operations;
+                       break;
 #endif
                case PROC_TID_MOUNTSTATS:
                case PROC_TGID_MOUNTSTATS:
Index: linux-2.6.18/fs/proc/internal.h
===================================================================
--- linux-2.6.18.orig/fs/proc/internal.h
+++ linux-2.6.18/fs/proc/internal.h
@@ -40,10 +40,7 @@ extern int proc_pid_statm(struct task_st
 extern struct file_operations proc_maps_operations;
 extern struct file_operations proc_numa_maps_operations;
 extern struct file_operations proc_smaps_operations;
-
-extern struct file_operations proc_maps_operations;
-extern struct file_operations proc_numa_maps_operations;
-extern struct file_operations proc_smaps_operations;
+extern struct file_operations proc_pagemaps_operations;


 void free_proc_entry(struct proc_dir_entry *de);
Index: linux-2.6.18/fs/proc/task_mmu.c
===================================================================
--- linux-2.6.18.orig/fs/proc/task_mmu.c
+++ linux-2.6.18/fs/proc/task_mmu.c
@@ -436,6 +436,116 @@ static int do_maps_open(struct inode *in
        return ret;
 }

+static void pagemaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
+                               unsigned long addr, unsigned long end,
+                               struct seq_file *m)
+{
+       pte_t *pte, ptent;
+       spinlock_t *ptl;
+       struct page *page;
+       int mapcount = 0;
+
+       pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+       do {
+               ptent = *pte;
+               if (pte_present(ptent)) {
+                       page = vm_normal_page(vma, addr, ptent);
+                       if (page) {
+                               if (pte_dirty(ptent))
+                                       mapcount = -page_mapcount(page);
+                               else
+                                       mapcount = page_mapcount(page);
+                       } else {
+                               mapcount = 1;
+                       }
+               }
+               seq_printf(m, " %d", mapcount);
+
+       } while (pte++, addr += PAGE_SIZE, addr != end);
+       seq_putc(m, '\n');
+
+       pte_unmap_unlock(pte - 1, ptl);
+       cond_resched();
+
+}
+
+static inline void pagemaps_pmd_range(struct vm_area_struct *vma, pud_t 
*pud,
+                               unsigned long addr, unsigned long end,
+                               struct seq_file *m)
+{
+       pmd_t *pmd;
+       unsigned long next;
+
+       pmd = pmd_offset(pud, addr);
+       do {
+               next = pmd_addr_end(addr, end);
+               if (pmd_none_or_clear_bad(pmd))
+                       continue;
+               pagemaps_pte_range(vma, pmd, addr, next, m);
+       } while (pmd++, addr = next, addr != end);
+}
+
+static inline void pagemaps_pud_range(struct vm_area_struct *vma, pgd_t 
*pgd,
+                               unsigned long addr, unsigned long end,
+                               struct seq_file *m)
+{
+       pud_t *pud;
+       unsigned long next;
+
+       pud = pud_offset(pgd, addr);
+       do {
+               next = pud_addr_end(addr, end);
+               if (pud_none_or_clear_bad(pud))
+                       continue;
+               pagemaps_pmd_range(vma, pud, addr, next, m);
+       } while (pud++, addr = next, addr != end);
+}
+
+static inline void pagemaps_pgd_range(struct vm_area_struct *vma,
+                               unsigned long addr, unsigned long end,
+                               struct seq_file *m)
+{
+       pgd_t *pgd;
+       unsigned long next;
+
+       pgd = pgd_offset(vma->vm_mm, addr);
+       do {
+               next = pgd_addr_end(addr, end);
+               if (pgd_none_or_clear_bad(pgd))
+                       continue;
+               pagemaps_pud_range(vma, pgd, addr, next, m);
+       } while (pgd++, addr = next, addr != end);
+}
+
+static int show_pagemap(struct seq_file *m, void *v)
+{
+       struct vm_area_struct *vma = v;
+
+       show_map_internal(m, v, NULL);
+       if (vma->vm_mm && !is_vm_hugetlb_page(vma))
+               pagemaps_pgd_range(vma, vma->vm_start, vma->vm_end, m);
+       return 0;
+}
+
+static struct seq_operations proc_pid_pagemaps_op = {
+       .start  = m_start,
+       .next   = m_next,
+       .stop   = m_stop,
+       .show   = show_pagemap
+};
+
+static int pagemaps_open(struct inode *inode, struct file *file)
+{
+       return do_maps_open(inode, file, &proc_pid_pagemaps_op);
+}
+
+struct file_operations proc_pagemaps_operations = {
+       .open           = pagemaps_open,
+       .read           = seq_read,
+       .llseek         = seq_lseek,
+       .release        = seq_release_private,
+};
+
 static int maps_open(struct inode *inode, struct file *file)
 {
        return do_maps_open(inode, file, &proc_pid_maps_op);

