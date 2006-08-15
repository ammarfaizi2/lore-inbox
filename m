Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWHOW4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWHOW4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 18:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWHOW4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 18:56:43 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:31189 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750796AbWHOW4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 18:56:41 -0400
Date: Tue, 15 Aug 2006 17:56:18 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>, Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Message-Id: <20060815225618.17433.84777.sendpatch@wildcat>
In-Reply-To: <20060815225607.17433.32727.sendpatch@wildcat>
References: <20060815225607.17433.32727.sendpatch@wildcat>
Subject: [PATCH 2/2] Simple shared page tables
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The actual shared page table patches

------------------------

Diffstat:

 arch/i386/Kconfig             |    7 
 arch/s390/Kconfig             |    7 
 arch/x86_64/Kconfig           |    7 
 fs/proc/proc_misc.c           |    6 
 fs/proc/task_mmu.c            |    7 
 include/asm-generic/pgtable.h |   31 +++
 include/linux/mm.h            |   10 -
 include/linux/mmzone.h        |    3 
 include/linux/ptshare.h       |   69 ++++++++
 include/linux/rmap.h          |    2 
 include/linux/sched.h         |    5 
 mm/Makefile                   |    1 
 mm/filemap_xip.c              |    3 
 mm/fremap.c                   |    3 
 mm/memory.c                   |    8 -
 mm/mmap.c                     |    7 
 mm/mprotect.c                 |    8 -
 mm/mremap.c                   |    3 
 mm/ptshare.c                  |  332 ++++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c                     |   18 +-
 mm/vmstat.c                   |    3 
 21 files changed, 524 insertions(+), 16 deletions(-)

------------------------

--- 2.6.18-rc4-macro/./arch/i386/Kconfig	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./arch/i386/Kconfig	2006-08-07 19:28:56.000000000 -0500
@@ -539,6 +539,13 @@ config X86_PAE
 	default y
 	select RESOURCES_64BIT
 
+config PTSHARE
+	bool "Share page tables"
+	default y
+	help
+	  Turn on sharing of page tables between processes for large shared
+	  memory regions.
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
--- 2.6.18-rc4-macro/./arch/s390/Kconfig	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./arch/s390/Kconfig	2006-08-07 19:28:56.000000000 -0500
@@ -219,6 +219,13 @@ config WARN_STACK_SIZE
 
 source "mm/Kconfig"
 
+config PTSHARE
+	bool "Share page tables"
+	default y
+	help
+	  Turn on sharing of page tables between processes for large shared
+	  memory regions.
+
 comment "I/O subsystem configuration"
 
 config MACHCHK_WARNING
--- 2.6.18-rc4-macro/./arch/x86_64/Kconfig	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./arch/x86_64/Kconfig	2006-08-07 19:28:56.000000000 -0500
@@ -321,6 +321,13 @@ config NUMA_EMU
 	  into virtual nodes when booted with "numa=fake=N", where N is the
 	  number of nodes. This is only useful for debugging.
 
+config PTSHARE
+	bool "Share page tables"
+	default y
+	help
+	  Turn on sharing of page tables between processes for large shared
+	  memory regions.
+
 config ARCH_DISCONTIGMEM_ENABLE
        bool
        depends on NUMA
--- 2.6.18-rc4-macro/./fs/proc/proc_misc.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./fs/proc/proc_misc.c	2006-08-15 10:15:09.000000000 -0500
@@ -169,6 +169,9 @@ static int meminfo_read_proc(char *page,
 		"Mapped:       %8lu kB\n"
 		"Slab:         %8lu kB\n"
 		"PageTables:   %8lu kB\n"
+#ifdef CONFIG_PTSHARE
+		"SharedPTE:    %8lu kB\n"
+#endif
 		"NFS Unstable: %8lu kB\n"
 		"Bounce:       %8lu kB\n"
 		"CommitLimit:  %8lu kB\n"
@@ -195,6 +198,9 @@ static int meminfo_read_proc(char *page,
 		K(global_page_state(NR_FILE_MAPPED)),
 		K(global_page_state(NR_SLAB)),
 		K(global_page_state(NR_PAGETABLE)),
+#ifdef CONFIG_PTSHARE
+		K(global_page_state(NR_SHAREDPTE)),
+#endif
 		K(global_page_state(NR_UNSTABLE_NFS)),
 		K(global_page_state(NR_BOUNCE)),
 		K(allowed),
--- 2.6.18-rc4-macro/./fs/proc/task_mmu.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./fs/proc/task_mmu.c	2006-08-15 15:41:06.000000000 -0500
@@ -43,6 +43,9 @@ char *task_mem(struct mm_struct *mm, cha
 		"VmStk:\t%8lu kB\n"
 		"VmExe:\t%8lu kB\n"
 		"VmLib:\t%8lu kB\n"
+#ifdef CONFIG_PTSHARE
+		"VmSHPT:\t%8lu kB\n"
+#endif
 		"VmPTE:\t%8lu kB\n",
 		hiwater_vm << (PAGE_SHIFT-10),
 		(total_vm - mm->reserved_vm) << (PAGE_SHIFT-10),
@@ -51,7 +54,11 @@ char *task_mem(struct mm_struct *mm, cha
 		total_rss << (PAGE_SHIFT-10),
 		data << (PAGE_SHIFT-10),
 		mm->stack_vm << (PAGE_SHIFT-10), text, lib,
+#ifdef CONFIG_PTSHARE
+		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_shpte) >> 10,
+#endif
 		(PTRS_PER_PTE*sizeof(pte_t)*mm->nr_ptes) >> 10);
+
 	return buffer;
 }
 
--- 2.6.18-rc4-macro/./include/asm-generic/pgtable.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./include/asm-generic/pgtable.h	2006-08-07 19:28:56.000000000 -0500
@@ -127,6 +127,16 @@ do {									\
 })
 #endif
 
+#ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH_ALL
+#define ptep_clear_flush_all(__vma, __address, __ptep)			\
+({									\
+	pte_t __pte;							\
+	__pte = ptep_get_and_clear((__vma)->vm_mm, __address, __ptep);	\
+	flush_tlb_all();				\
+	__pte;								\
+})
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
@@ -164,6 +174,27 @@ static inline void ptep_set_wrprotect(st
 #endif
 
 /*
+ * Some architectures might need flushes when higher levels of page table
+ * are unshared.
+ */
+
+#ifndef __HAVE_ARCH_PMD_CLEAR_FLUSH
+#define pmd_clear_flush(__mm, __addr, __pmd)				\
+({									\
+	pmd_clear(__pmd);						\
+	flush_tlb_all();						\
+})
+#endif
+
+#ifndef __HAVE_ARCH_PUD_CLEAR_FLUSH
+#define pud_clear_flush(__mm, __addr, __pud)				\
+({									\
+	pud_clear(__pud);						\
+	flush_tlb_all();						\
+})
+#endif
+
+/*
  * When walking page tables, get the address of the next boundary,
  * or the end address of the range if that comes earlier.  Although no
  * vma end wraps to 0, rounded up __boundary may wrap to 0 throughout.
--- 2.6.18-rc4-macro/./include/linux/mm.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./include/linux/mm.h	2006-08-07 19:28:56.000000000 -0500
@@ -245,7 +245,7 @@ struct page {
 						 * see PAGE_MAPPING_ANON below.
 						 */
 	    };
-#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
+#if (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS) || defined(CONFIG_PTSHARE)
 	    spinlock_t ptl;
 #endif
 	};
@@ -826,19 +826,19 @@ static inline pmd_t *pmd_alloc(struct mm
 }
 #endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
 
-#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
+#if (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS) || defined(CONFIG_PTSHARE)
 /*
  * We tuck a spinlock to guard each pagetable page into its struct page,
  * at page->private, with BUILD_BUG_ON to make sure that this will not
  * overflow into the next struct page (as it might with DEBUG_SPINLOCK).
  * When freeing, reset page->mapping so free_pages_check won't complain.
  */
-#define __pte_lockptr(page)	&((page)->ptl)
+#define __pt_lockptr(page)	&((page)->ptl)
 #define pte_lock_init(_page)	do {					\
-	spin_lock_init(__pte_lockptr(_page));				\
+	spin_lock_init(__pt_lockptr(_page));				\
 } while (0)
 #define pte_lock_deinit(page)	((page)->mapping = NULL)
-#define pte_lockptr(mm, pmd)	({(void)(mm); __pte_lockptr(pmd_page(*(pmd)));})
+#define pte_lockptr(mm, pmd)	({(void)(mm); __pt_lockptr(pmd_page(*(pmd)));})
 #else
 /*
  * We use mm->page_table_lock to guard all pagetable pages of the mm.
--- 2.6.18-rc4-macro/./include/linux/mmzone.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./include/linux/mmzone.h	2006-08-15 10:14:04.000000000 -0500
@@ -65,6 +65,9 @@ enum zone_stat_item {
 	NUMA_LOCAL,		/* allocation from local node */
 	NUMA_OTHER,		/* allocation from other node */
 #endif
+#ifdef CONFIG_PTSHARE
+	NR_SHAREDPTE,		/* Number of shared page table pages */
+#endif
 	NR_VM_ZONE_STAT_ITEMS };
 
 struct per_cpu_pages {
--- 2.6.18-rc4-macro/./include/linux/rmap.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./include/linux/rmap.h	2006-08-07 19:28:56.000000000 -0500
@@ -96,7 +96,7 @@ int try_to_unmap(struct page *, int igno
  * Called from mm/filemap_xip.c to unmap empty zero page
  */
 pte_t *page_check_address(struct page *, struct mm_struct *,
-				unsigned long, spinlock_t **);
+				unsigned long, spinlock_t **, int *);
 
 /*
  * Used by swapoff to help locate where page is expected in vma.
--- 2.6.18-rc4-macro/./include/linux/sched.h	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./include/linux/sched.h	2006-08-15 14:05:41.000000000 -0500
@@ -257,7 +257,7 @@ arch_get_unmapped_area_topdown(struct fi
 extern void arch_unmap_area(struct mm_struct *, unsigned long);
 extern void arch_unmap_area_topdown(struct mm_struct *, unsigned long);
 
-#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
+#if (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS) || defined(CONFIG_PTSHARE)
 /*
  * The mm counters are not protected by its page_table_lock,
  * so must be incremented atomically.
@@ -333,6 +333,9 @@ struct mm_struct {
 	unsigned long start_code, end_code, start_data, end_data;
 	unsigned long start_brk, brk, start_stack;
 	unsigned long arg_start, arg_end, env_start, env_end;
+#ifdef CONFIG_PTSHARE
+	unsigned long nr_shpte;
+#endif
 
 	unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
--- 2.6.18-rc4-macro/./include/linux/ptshare.h	1969-12-31 18:00:00.000000000 -0600
+++ 2.6.18-rc4-shpt/./include/linux/ptshare.h	2006-08-07 19:57:56.000000000 -0500
@@ -0,0 +1,69 @@
+#ifndef _LINUX_PTSHARE_H
+#define _LINUX_PTSHARE_H
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2005
+ *
+ * Author: Dave McCracken <dmccr@us.ibm.com>
+ */
+
+#undef	PT_DEBUG
+
+#ifdef CONFIG_PTSHARE
+static inline int pt_is_shared(struct page *page)
+{
+	return (page_mapcount(page) > 0);
+}
+
+static inline int pt_is_shared_pte(pmd_t pmdval)
+{
+	struct page *page;
+
+	page = pmd_page(pmdval);
+	return pt_is_shared(page);
+}
+
+static inline void pt_increment_share(struct page *page)
+{
+	atomic_inc(&page->_mapcount);
+}
+
+static inline void pt_decrement_share(struct page *page)
+{
+	atomic_dec(&page->_mapcount);
+}
+
+extern pte_t *pt_share_pte(struct vm_area_struct *vma, pmd_t *pmd, 
+			   unsigned long address);
+
+extern void pt_unshare_range(struct mm_struct *mm, unsigned long address,
+			     unsigned long end);
+
+extern int pt_check_unshare_pte(struct mm_struct *mm, unsigned long address,
+				pmd_t *pmd);
+
+#else /* CONFIG_PTSHARE */
+#define pt_is_shared(page)	(0)
+#define pt_is_shared_pte(pmdval)	(0)
+#define pt_increment_share(page)
+#define pt_decrement_share(page)
+#define	pt_share_pte(vma, pmd, address)	pte_alloc_map(vma->vm_mm, pmd, address)
+#define pt_unshare_range(mm, address, end)
+#define pt_check_unshare_pte(mm, address, pmd)	(0)
+#endif /* CONFIG_PTSHARE */
+
+#endif /* _LINUX_PTSHARE_H */
--- 2.6.18-rc4-macro/./mm/Makefile	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./mm/Makefile	2006-08-07 19:28:56.000000000 -0500
@@ -23,4 +23,5 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_PTSHARE) += ptshare.o
 
--- 2.6.18-rc4-macro/./mm/filemap_xip.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./mm/filemap_xip.c	2006-08-07 19:28:56.000000000 -0500
@@ -174,6 +174,7 @@ __xip_unmap (struct address_space * mapp
 	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
+	int shared;
 	spinlock_t *ptl;
 	struct page *page;
 
@@ -184,7 +185,7 @@ __xip_unmap (struct address_space * mapp
 			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		BUG_ON(address < vma->vm_start || address >= vma->vm_end);
 		page = ZERO_PAGE(address);
-		pte = page_check_address(page, mm, address, &ptl);
+		pte = page_check_address(page, mm, address, &ptl, &shared);
 		if (pte) {
 			/* Nuke the page table entry. */
 			flush_cache_page(vma, address, pte_pfn(*pte));
--- 2.6.18-rc4-macro/./mm/fremap.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./mm/fremap.c	2006-08-07 19:28:56.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/rmap.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
 
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -200,6 +201,8 @@ asmlinkage long sys_remap_file_pages(uns
 				has_write_lock = 1;
 				goto retry;
 			}
+			pt_unshare_range(mm, vma->vm_start, vma->vm_end);
+
 			mapping = vma->vm_file->f_mapping;
 			spin_lock(&mapping->i_mmap_lock);
 			flush_dcache_mmap_lock(mapping);
--- 2.6.18-rc4-macro/./mm/memory.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./mm/memory.c	2006-08-15 15:13:51.000000000 -0500
@@ -49,6 +49,7 @@
 #include <linux/module.h>
 #include <linux/delayacct.h>
 #include <linux/init.h>
+#include <linux/ptshare.h>
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
@@ -145,6 +146,8 @@ static inline void free_pmd_range(struct
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
+		if (pt_check_unshare_pte(tlb->mm, addr, pmd))
+			continue;
 		free_pte_range(tlb, pmd);
 	} while (pmd++, addr = next, addr != end);
 
@@ -626,6 +629,9 @@ static unsigned long zap_pte_range(struc
 	int file_rss = 0;
 	int anon_rss = 0;
 
+	if (pt_check_unshare_pte(mm, addr, pmd))
+		return end;
+
 	pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	do {
 		pte_t ptent = *pte;
@@ -2340,7 +2346,7 @@ int __handle_mm_fault(struct mm_struct *
 	pmd = pmd_alloc(mm, pud, address);
 	if (!pmd)
 		return VM_FAULT_OOM;
-	pte = pte_alloc_map(mm, pmd, address);
+	pte = pt_share_pte(vma, pmd, address);
 	if (!pte)
 		return VM_FAULT_OOM;
 
--- 2.6.18-rc4-macro/./mm/mmap.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./mm/mmap.c	2006-08-07 19:34:05.000000000 -0500
@@ -25,6 +25,7 @@
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
 #include <linux/rmap.h>
+#include <linux/ptshare.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1039,6 +1040,7 @@ munmap_back:
 			vm_flags |= VM_ACCOUNT;
 		}
 	}
+	pt_unshare_range(mm, addr, addr + len);
 
 	/*
 	 * Can we just expand an old private anonymous mapping?
@@ -1950,6 +1952,9 @@ void exit_mmap(struct mm_struct *mm)
 	unsigned long nr_accounted = 0;
 	unsigned long end;
 
+	/* We need this semaphore to protect against page table sharing */
+	down_write(&mm->mmap_sem);
+
 	lru_add_drain();
 	flush_cache_mm(mm);
 	tlb = tlb_gather_mmu(mm, 1);
@@ -1959,6 +1964,7 @@ void exit_mmap(struct mm_struct *mm)
 	vm_unacct_memory(nr_accounted);
 	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, 0);
 	tlb_finish_mmu(tlb, 0, end);
+	up_write(&mm->mmap_sem);
 
 	/*
 	 * Walk the list again, actually closing and freeing it,
@@ -1967,7 +1973,6 @@ void exit_mmap(struct mm_struct *mm)
 	while (vma)
 		vma = remove_vma(vma);
 
-	BUG_ON(mm->nr_ptes > (FIRST_USER_ADDRESS+PMD_SIZE-1)>>PMD_SHIFT);
 }
 
 /* Insert vm structure into process list sorted by address
--- 2.6.18-rc4-macro/./mm/mprotect.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./mm/mprotect.c	2006-08-07 19:28:56.000000000 -0500
@@ -21,6 +21,7 @@
 #include <linux/syscalls.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/ptshare.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
@@ -133,6 +134,8 @@ mprotect_fixup(struct vm_area_struct *vm
 		return 0;
 	}
 
+	pt_unshare_range(mm, start, end);
+
 	/*
 	 * If we make a private mapping writable we increase our commit;
 	 * but (without finer accounting) cannot reduce our commit if we
@@ -144,8 +147,9 @@ mprotect_fixup(struct vm_area_struct *vm
 	if (newflags & VM_WRITE) {
 		if (!(oldflags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
 			charged = nrpages;
-			if (security_vm_enough_memory(charged))
+			if (security_vm_enough_memory(charged)) {
 				return -ENOMEM;
+			}
 			newflags |= VM_ACCOUNT;
 		}
 	}
@@ -182,7 +186,7 @@ success:
 	if (vma->vm_ops && vma->vm_ops->page_mkwrite)
 		mask &= ~VM_SHARED;
 
-	newprot = protection_map[newflags & mask];
+ 	newprot = protection_map[newflags & mask];
 
 	/*
 	 * vm_flags and vm_page_prot are protected by the mmap_sem
--- 2.6.18-rc4-macro/./mm/mremap.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./mm/mremap.c	2006-08-07 19:28:56.000000000 -0500
@@ -18,6 +18,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/ptshare.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -178,6 +179,8 @@ static unsigned long move_vma(struct vm_
 	if (!new_vma)
 		return -ENOMEM;
 
+	pt_unshare_range(mm, old_addr, old_addr + old_len);
+
 	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len);
 	if (moved_len < old_len) {
 		/*
--- 2.6.18-rc4-macro/./mm/rmap.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./mm/rmap.c	2006-08-07 19:28:56.000000000 -0500
@@ -53,6 +53,7 @@
 #include <linux/rmap.h>
 #include <linux/rcupdate.h>
 #include <linux/module.h>
+#include <linux/ptshare.h>
 
 #include <asm/tlbflush.h>
 
@@ -248,7 +249,8 @@ unsigned long page_address_in_vma(struct
  * On success returns with pte mapped and locked.
  */
 pte_t *page_check_address(struct page *page, struct mm_struct *mm,
-			  unsigned long address, spinlock_t **ptlp)
+			  unsigned long address, spinlock_t **ptlp,
+			  int *shared)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -275,6 +277,9 @@ pte_t *page_check_address(struct page *p
 		return NULL;
 	}
 
+	if (pt_is_shared_pte(*pmd))
+		(*shared)++;
+
 	ptl = pte_lockptr(mm, pmd);
 	spin_lock(ptl);
 	if (pte_present(*pte) && page_to_pfn(page) == pte_pfn(*pte)) {
@@ -295,6 +300,7 @@ static int page_referenced_one(struct pa
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
 	pte_t *pte;
+	int shared;
 	spinlock_t *ptl;
 	int referenced = 0;
 
@@ -302,7 +308,7 @@ static int page_referenced_one(struct pa
 	if (address == -EFAULT)
 		goto out;
 
-	pte = page_check_address(page, mm, address, &ptl);
+	pte = page_check_address(page, mm, address, &ptl, &shared);
 	if (!pte)
 		goto out;
 
@@ -547,6 +553,7 @@ static int try_to_unmap_one(struct page 
 	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
+	int shared = 0;
 	spinlock_t *ptl;
 	int ret = SWAP_AGAIN;
 
@@ -554,7 +561,7 @@ static int try_to_unmap_one(struct page 
 	if (address == -EFAULT)
 		goto out;
 
-	pte = page_check_address(page, mm, address, &ptl);
+	pte = page_check_address(page, mm, address, &ptl, &shared);
 	if (!pte)
 		goto out;
 
@@ -571,7 +578,10 @@ static int try_to_unmap_one(struct page 
 
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address, page_to_pfn(page));
-	pteval = ptep_clear_flush(vma, address, pte);
+	if (shared)
+		pteval = ptep_clear_flush_all(vma, address, pte);
+	else
+		pteval = ptep_clear_flush(vma, address, pte);
 
 	/* Move the dirty bit to the physical page now the pte is gone. */
 	if (pte_dirty(pteval))
--- 2.6.18-rc4-macro/./mm/vmstat.c	2006-08-06 13:20:11.000000000 -0500
+++ 2.6.18-rc4-shpt/./mm/vmstat.c	2006-08-15 16:32:59.000000000 -0500
@@ -402,6 +402,9 @@ static char *vmstat_text[] = {
 	"numa_local",
 	"numa_other",
 #endif
+#ifdef CONFIG_PTSHARE
+	"nr_sharedpte",
+#endif
 
 #ifdef CONFIG_VM_EVENT_COUNTERS
 	"pgpgin",
--- 2.6.18-rc4-macro/./mm/ptshare.c	1969-12-31 18:00:00.000000000 -0600
+++ 2.6.18-rc4-shpt/./mm/ptshare.c	2006-08-15 16:41:49.000000000 -0500
@@ -0,0 +1,332 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2005
+ *
+ * Author: Dave McCracken <dmccr@us.ibm.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/prio_tree.h>
+#include <linux/mm.h>
+#include <linux/ptshare.h>
+
+#include <asm/tlbflush.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+#define VM_PGEND(vma)	(((vma->vm_end - vma->vm_start) >> PAGE_SHIFT) -1)
+
+#define	VMFLAG_COMPARE	(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)
+
+#undef	PT_DEBUG
+
+static inline void pt_unshare_pte(struct mm_struct *mm, pmd_t *pmd,
+				  unsigned long address)
+{
+	struct page *page;
+	spinlock_t *ptl;
+
+	if (pmd_present(*pmd)) {
+		page = pmd_page(*pmd);
+		ptl = __pt_lockptr(page);
+		spin_lock(ptl);
+		if (pt_is_shared(page)) {
+#ifdef PT_DEBUG
+			printk(KERN_DEBUG "Force unshare pte for %s[%d] at address 0x%lx\n",
+			       current->comm, current->pid, address);
+#endif
+			pt_decrement_share(page);
+			mm->nr_shpte--;
+			mm->nr_ptes--;
+			if (!pt_is_shared(page))
+				dec_zone_page_state(page, NR_SHAREDPTE);
+			pmd_clear_flush(mm, address, pmd);
+		}
+		spin_unlock(ptl);
+	}
+}
+
+#ifndef __PAGETABLE_PMD_FOLDED
+static void pt_unshare_pmd(struct mm_struct *mm, pud_t *pud, unsigned long address,
+			   unsigned long end)
+{
+	pmd_t *pmd;
+
+	if (!pud_present(*pud))
+	    return;
+
+	pmd = pmd_offset(pud, address);
+	end = pud_addr_end(address, end);
+	while (address < end) {
+		pt_unshare_pte(mm, pmd, address);
+		pmd++;
+		address += PMD_SIZE;
+	}
+}
+
+#ifndef __PAGETABLE_PUD_FOLDED
+static void pt_unshare_pud(struct mm_struct *mm, pgd_t *pgd, unsigned long address,
+			   unsigned long end)
+{
+	pud_t *pud;
+
+	if (!pgd_present(*pgd))
+	    return;
+
+	pud = pud_offset(pgd, address);
+	end = pgd_addr_end(address, end);
+	while (address < end) {
+		pt_unshare_pmd(mm, pud, address, end);
+		pud++;
+		address += PUD_SIZE;
+	}
+}
+#endif /* __PAGETABLE_PUD_FOLDED */
+#endif /* __PAGETABLE_PMD_FOLDED */
+
+void pt_unshare_range(struct mm_struct *mm, unsigned long address,
+		      unsigned long end)
+{
+	pgd_t *pgd;
+
+	pgd = pgd_offset(mm, address);
+
+	spin_lock(&mm->page_table_lock);
+	while (address < end) {
+#ifdef __PAGETABLE_PMD_FOLDED
+		pt_unshare_pte(mm, (pmd_t *)pgd, address);
+#else
+#ifdef __PAGETABLE_PUD_FOLDED
+		pt_unshare_pmd(mm, (pud_t *)pgd, address, end);
+#else
+		pt_unshare_pud(mm, pgd, address, end);
+#endif
+#endif
+		pgd++;
+		address += PGDIR_SIZE;
+	}
+	spin_unlock(&mm->page_table_lock);
+}
+
+static int pt_shareable_flags(struct vm_area_struct *vma)
+{
+	/* We can't share anonymous memory */
+	if (!vma->vm_file || vma->anon_vma)
+		return 0;
+
+	/* No sharing of nonlinear areas */
+	if (vma->vm_flags & (VM_NONLINEAR|VM_PFNMAP|VM_INSERTPAGE|VM_HUGETLB))
+		return 0;
+
+	/* Shared mappings are shareable */
+	if (vma->vm_flags & VM_SHARED)
+		return 1;
+
+	/* We can't share if it's writeable or might have been writeable */
+	if (vma->vm_flags & VM_WRITE)
+		return 0;
+
+	/* What's left is read-only, which is shareable */
+	return 1;
+}
+
+static int pt_shareable_range(struct vm_area_struct *vma, unsigned long address,
+			      unsigned long mask)
+{
+	unsigned long base = address & mask;
+	unsigned long end = base + ~mask;
+	struct vm_area_struct *prev = vma;
+
+	/* We can share if the vma spans the entire page */
+	if ((vma->vm_start <= base) &&
+	    (vma->vm_end > end))
+		return 1;
+
+	/* We can share if the page only contains that vma */
+	while ((vma = vma->vm_next)) {
+		if (vma->vm_start > end)
+			break;
+		/* No access vmas don't count since they don't use the page table */
+		if (vma->vm_flags & (VM_READ|VM_WRITE|VM_EXEC))
+			return 0;
+	}
+	while (1) {
+		vma = prev;
+		BUG_ON(find_vma_prev(vma->vm_mm, vma->vm_start, &prev) != vma);
+		if (!prev)
+			break;
+		if (prev->vm_end < base)
+			break;
+		if (prev->vm_flags & (VM_READ|VM_WRITE|VM_EXEC))
+			return 0;
+	}
+	return 1;
+}
+
+static struct vm_area_struct *next_shareable_vma(struct vm_area_struct *vma,
+						 struct vm_area_struct *svma,
+						 struct prio_tree_iter *iter)
+{
+	struct mm_struct *smm;
+
+	while ((svma = vma_prio_tree_next(svma, iter))) {
+		if (svma == vma)
+			continue;
+
+		smm = svma->vm_mm;
+		/* Skip this one if the mm is doing something to its vmas */
+		if (unlikely(!down_read_trylock(&smm->mmap_sem)))
+			continue;
+
+		if ((vma->vm_flags&VMFLAG_COMPARE) != (svma->vm_flags&VMFLAG_COMPARE))
+			goto next;
+
+		if ((vma->vm_start != svma->vm_start) ||
+		    (vma->vm_end != svma->vm_end) ||
+		    (vma->vm_pgoff != svma->vm_pgoff))
+			goto next;
+
+		return svma;
+
+	    next:
+		up_read(&smm->mmap_sem);
+	}
+	return NULL;
+}
+
+pte_t *pt_share_pte(struct vm_area_struct *vma, pmd_t *pmd, unsigned long address)
+{
+	struct prio_tree_iter iter;
+	struct mm_struct *mm = vma->vm_mm, *smm;
+	struct vm_area_struct *svma = NULL;
+	pgd_t *spgd, spgde;
+	pud_t *spud, spude;
+	pmd_t *spmd, spmde;
+	pte_t *pte;
+	spinlock_t *ptl = NULL;
+	struct page *page = NULL;
+	struct address_space *mapping;
+	int was_shared;
+
+	pmd_clear(&spmde);
+	if (pmd_none(*pmd) &&
+	    pt_shareable_flags(vma) &&
+	    pt_shareable_range(vma, address, PMD_MASK)) {
+#ifdef PT_DEBUG2
+		printk(KERN_DEBUG "Looking for shareable pte page at address 0x%lx\n",
+		       address);
+#endif
+		mapping = vma->vm_file->f_dentry->d_inode->i_mapping;
+		spin_lock(&mapping->i_mmap_lock);
+		prio_tree_iter_init(&iter, &mapping->i_mmap,
+				    vma->vm_pgoff, VM_PGEND(vma));
+
+		while ((svma = next_shareable_vma(vma, svma, &iter))) {
+			smm = svma->vm_mm;
+
+			if (!pt_shareable_range(svma, address, PMD_MASK))
+				goto next;
+
+			spgd = pgd_offset(smm, address);
+			spgde = *spgd;
+			if (!pgd_present(spgde))
+				goto next;
+
+			spud = pud_offset(&spgde, address);
+			spude = *spud;
+			if (!pud_present(spude))
+				goto next;
+
+			spmd = pmd_offset(&spude, address);
+			spmde = *spmd;
+			if (pmd_present(spmde))
+				goto found;
+
+		    next:
+			up_read(&smm->mmap_sem);
+		}
+		spin_unlock(&mapping->i_mmap_lock);
+		goto notfound;
+
+found:
+		/* Found a shareable page */
+		spin_lock(&mm->page_table_lock);
+
+		page = pmd_page(spmde);
+		ptl = __pt_lockptr(page);
+		spin_lock(ptl);
+		was_shared = pt_is_shared(page);
+		pt_increment_share(page);
+
+		/* We have the page.  Now we can release the locks on the other mm */
+		up_read(&smm->mmap_sem);
+		spin_unlock(&mapping->i_mmap_lock);
+
+		/* Check to make sure no one else filled it already */
+		if (pmd_none(*pmd)) {
+#ifdef PT_DEBUG
+			printk(KERN_DEBUG "Sharing pte for %s[%d] at address 0x%lx\n",
+			       current->comm, current->pid, address);
+#endif
+			pmd_populate(mm, pmd, page);
+			mm->nr_shpte++;
+			mm->nr_ptes++;
+			if (!was_shared)
+				inc_zone_page_state(page, NR_SHAREDPTE);
+		} else
+			pt_decrement_share(page);
+
+		spin_unlock(ptl);
+		spin_unlock(&mm->page_table_lock);
+	}
+notfound:
+	pte = pte_alloc_map(mm, pmd, address);
+
+	return pte;
+}
+
+/*
+ *  Check whether this pmd entry points to a shared pte page.  If it does,
+ *  unshare it by removing the entry and decrementing the share count in the
+ *  page.  This effectively gives away the pte page to whoever else is sharing
+ *  it.  This process will then allocate a new pte page on the next fault.
+ */
+int pt_check_unshare_pte(struct mm_struct *mm, unsigned long address, pmd_t *pmd)
+{
+	struct page *page;
+	spinlock_t *ptl;
+	int ret = 0;
+
+	page = pmd_page(*pmd);
+	ptl = __pt_lockptr(page);
+	spin_lock(ptl);
+	/* Check under the lock */
+	if (pt_is_shared(page)) {
+#ifdef PT_DEBUG
+		printk(KERN_DEBUG "Unshare pte for %s[%d] at address 0x%lx\n",
+		       current->comm, current->pid, address);
+#endif
+		pt_decrement_share(page);
+		mm->nr_shpte--;
+		mm->nr_ptes--;
+		if (!pt_is_shared(page))
+			dec_zone_page_state(page, NR_SHAREDPTE);
+		pmd_clear_flush(mm, address, pmd);
+		ret = 1;
+	}
+	spin_unlock(ptl);
+	return ret;
+}
