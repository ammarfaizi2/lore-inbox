Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264258AbUKATlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUKATlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267484AbUKATfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:35:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60102 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S291942AbUKATan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:30:43 -0500
Date: Mon, 1 Nov 2004 19:30:21 GMT
Message-Id: <200411011930.iA1JULvA023219@warthog.cambridge.redhat.com>
From: dhowells@redhat.com
To: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com
cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: [PATCH 9/14] FRV: CONFIG_MMU fixes
In-Reply-To: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds dependencies on CONFIG_MMU being #defined in some extra
places that need it.

Signed-Off-By: dhowells@redhat.com
---
diffstat frv-mmu-fixes-2610rc1bk10.diff
 fs/proc/kcore.c     |    2 ++
 fs/proc/proc_misc.c |    8 ++++++++
 include/linux/mm.h  |    5 +++++
 init/Kconfig        |    4 ++--
 init/main.c         |    2 ++
 kernel/sysctl.c     |    2 ++
 mm/Makefile         |    4 ++--
 7 files changed, 23 insertions(+), 4 deletions(-)

diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/kcore.c linux-2.6.10-rc1-bk10-frv/fs/proc/kcore.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/kcore.c	2004-09-16 12:06:14.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/fs/proc/kcore.c	2004-11-01 11:47:04.872656796 +0000
@@ -344,6 +344,7 @@
 		if (m == NULL) {
 			if (clear_user(buffer, tsz))
 				return -EFAULT;
+#ifdef CONFIG_MMU
 		} else if ((start >= VMALLOC_START) && (start < VMALLOC_END)) {
 			char * elf_buf;
 			struct vm_struct *m;
@@ -389,6 +390,7 @@
 				return -EFAULT;
 			}
 			kfree(elf_buf);
+#endif
 		} else {
 			if (kern_addr_valid(start)) {
 				unsigned long n;
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/proc_misc.c linux-2.6.10-rc1-bk10-frv/fs/proc/proc_misc.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/fs/proc/proc_misc.c	2004-11-01 11:45:28.000000000 +0000
+++ linux-2.6.10-rc1-bk10-frv/fs/proc/proc_misc.c	2004-11-01 11:47:04.873656713 +0000
@@ -100,6 +100,7 @@
 	unsigned long largest_chunk;
 };
 
+#ifdef CONFIG_MMU
 static struct vmalloc_info get_vmalloc_info(void)
 {
 	unsigned long prev_end = VMALLOC_START;
@@ -129,6 +130,7 @@
 	read_unlock(&vmlist_lock);
 	return vmi;
 }
+#endif
 
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
@@ -176,10 +178,16 @@
 	allowed = ((totalram_pages - hugetlb_total_pages())
 		* sysctl_overcommit_ratio / 100) + total_swap_pages;
 
+#ifdef CONFIG_MMU
 	vmtot = (VMALLOC_END-VMALLOC_START)>>10;
 	vmi = get_vmalloc_info();
 	vmi.used >>= 10;
 	vmi.largest_chunk >>= 10;
+#else
+	vmtot = 0;
+	vmi.used = 0;
+	vmi.largest_chunk = 0;
+#endif
 
 	/*
 	 * Tagged format, for easy grepping and expansion.
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/mm.h linux-2.6.10-rc1-bk10-frv/include/linux/mm.h
--- /warthog/kernels/linux-2.6.10-rc1-bk10/include/linux/mm.h	2004-11-01 11:45:33.371274107 +0000
+++ linux-2.6.10-rc1-bk10-frv/include/linux/mm.h	2004-11-01 14:16:26.408497251 +0000
@@ -58,6 +58,7 @@
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
  */
+#ifdef CONFIG_MMU
 struct vm_area_struct {
 	struct mm_struct * vm_mm;	/* The address space we belong to. */
 	unsigned long vm_start;		/* Our start address within vm_mm. */
@@ -658,12 +688,14 @@
 	for (prio_tree_iter_init(iter, root, begin, end), vma = NULL;	\
 		(vma = vma_prio_tree_next(vma, iter)); )
 
+#ifdef CONFIG_MMU
 static inline void vma_nonlinear_insert(struct vm_area_struct *vma,
 					struct list_head *list)
 {
 	vma->shared.vm_set.parent = NULL;
 	list_add_tail(&vma->shared.vm_set.list, list);
 }
+#endif
 
 /* mmap.c */
 extern void vma_adjust(struct vm_area_struct *vma, unsigned long start,
@@ -780,6 +812,7 @@
 }
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_MMU
 static inline void vm_stat_account(struct vm_area_struct *vma)
 {
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
@@ -791,6 +824,7 @@
 	__vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file,
 							-vma_pages(vma));
 }
+#endif
 
 #ifndef CONFIG_DEBUG_PAGEALLOC
 static inline void
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/init/main.c linux-2.6.10-rc1-bk10-frv/init/main.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/init/main.c	2004-11-01 11:45:34.000000000 +0000
+++ linux-2.6.10-rc1-bk10-frv/init/main.c	2004-11-01 11:47:05.147633905 +0000
@@ -550,8 +478,10 @@
 		late_time_init();
 	calibrate_delay();
 	pidmap_init();
+#ifdef CONFIG_MMU
 	pgtable_cache_init();
 	prio_tree_init();
+#endif
 	anon_vma_init();
 #ifdef CONFIG_X86
 	if (efi_enabled)
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/init/Kconfig linux-2.6.10-rc1-bk10-frv/init/Kconfig
--- /warthog/kernels/linux-2.6.10-rc1-bk10/init/Kconfig	2004-11-01 11:45:34.655167224 +0000
+++ linux-2.6.10-rc1-bk10-frv/init/Kconfig	2004-11-01 14:22:25.047043376 +0000
@@ -316,8 +316,8 @@
 	  If unsure, say N.
 
 config SHMEM
-	default y
-	bool "Use full shmem filesystem" if EMBEDDED && MMU
+	bool "Use full shmem filesystem"
+	default y if EMBEDDED && MMU
 	help
 	  The shmem is an internal filesystem used to manage shared memory.
 	  It is backed by swap and manages resource limits. It is also exported
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/sysctl.c linux-2.6.10-rc1-bk10-frv/kernel/sysctl.c
--- /warthog/kernels/linux-2.6.10-rc1-bk10/kernel/sysctl.c	2004-11-01 11:45:34.879148578 +0000
+++ linux-2.6.10-rc1-bk10-frv/kernel/sysctl.c	2004-11-01 11:47:05.181631075 +0000
@@ -755,6 +755,7 @@
 		.strategy	= &sysctl_intvec,
 		.extra1		= &zero,
 	},
+#ifdef CONFIG_MMU
 	{
 		.ctl_name	= VM_MAX_MAP_COUNT,
 		.procname	= "max_map_count",
@@ -763,6 +764,7 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec
 	},
+#endif
 	{
 		.ctl_name	= VM_LAPTOP_MODE,
 		.procname	= "laptop_mode",
diff -uNr /warthog/kernels/linux-2.6.10-rc1-bk10/mm/Makefile linux-2.6.10-rc1-bk10-frv/mm/Makefile
--- /warthog/kernels/linux-2.6.10-rc1-bk10/mm/Makefile	2004-10-19 10:42:19.000000000 +0100
+++ linux-2.6.10-rc1-bk10-frv/mm/Makefile	2004-11-01 14:18:47.213937144 +0000
@@ -5,10 +5,10 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   vmalloc.o
+			   vmalloc.o prio_tree.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
-			   page_alloc.o page-writeback.o pdflush.o prio_tree.o \
+			   page_alloc.o page-writeback.o pdflush.o \
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   $(mmu-y)
 
