Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUHGWOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUHGWOS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUHGWOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:14:17 -0400
Received: from zero.aec.at ([193.170.194.10]:37892 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264479AbUHGWOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:14:14 -0400
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow to disable shmem.o 
From: Andi Kleen <ak@muc.de>
Date: Sun, 08 Aug 2004 00:14:09 +0200
Message-ID: <m3vffulhou.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch allows to not compile mm/shmem.o in. It is now dependent on
CONFIG_TMPFS, which is the main user. This allows shrinking the kernel
a bit more when needed. Disabling TMPFS disables the mmap
MAP_ANONYMOUS|MAP_SHARED functionality now. That's ok, because Linux
2.2 also didn't have it iirc. To make sure this doesn't happen by
accident I made the TMPFS configuration dependent on CONFIG_EMBEDDED.
This means a normal configuration enables TMPFS, which is ok 
since it is only minor additional overhead to shmem.o and also quite
useful for shared memory.

Patch for 2.6.7, but applies with some offsets to 2.6.8rc3

-Andi

diff -u linux-2.6.7-boot64/drivers/char/mem.c-SHMEM linux-2.6.7-boot64/drivers/char/mem.c
diff -u linux-2.6.7-boot64/include/linux/mm.h-SHMEM linux-2.6.7-boot64/include/linux/mm.h
--- linux-2.6.7-boot64/include/linux/mm.h-SHMEM	2004-06-16 12:23:40.000000000 +0200
+++ linux-2.6.7-boot64/include/linux/mm.h	2004-08-08 00:06:04.000000000 +0200
@@ -496,7 +496,15 @@
 					unsigned long addr);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
 void shmem_lock(struct file * file, int lock);
+
+#ifdef CONFIG_TMPFS
 int shmem_zero_setup(struct vm_area_struct *);
+#else
+static inline int shmem_zero_setup(struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+#endif
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
diff -u linux-2.6.7-boot64/include/linux/swap.h-SHMEM linux-2.6.7-boot64/include/linux/swap.h
--- linux-2.6.7-boot64/include/linux/swap.h-SHMEM	2004-06-16 12:23:41.000000000 +0200
+++ linux-2.6.7-boot64/include/linux/swap.h	2004-08-08 00:07:23.000000000 +0200
@@ -177,8 +177,15 @@
 extern int vm_swappiness;
 
 #ifdef CONFIG_MMU
+#ifdef CONFIG_TMPFS
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);
+#else
+static inline int shmem_unuse(swp_entry_t entry, struct page *page)
+{
+	return 0;
+}
+#endif
 #endif /* CONFIG_MMU */
 
 extern void swap_unplug_io_fn(struct backing_dev_info *, struct page *);
diff -u linux-2.6.7-boot64/fs/Kconfig-SHMEM linux-2.6.7-boot64/fs/Kconfig
--- linux-2.6.7-boot64/fs/Kconfig-SHMEM	2004-06-16 12:23:18.000000000 +0200
+++ linux-2.6.7-boot64/fs/Kconfig	2004-08-08 00:07:46.000000000 +0200
@@ -914,7 +914,8 @@
 	  extended attributes for file security labels, say N.
 
 config TMPFS
-	bool "Virtual memory file system support (former shm fs)"
+	bool "Virtual memory file system support (former shm fs)" if EMBEDDED
+	default y
 	help
 	  Tmpfs is a file system which keeps all files in virtual memory.
 
diff -u linux-2.6.7-boot64/mm/Makefile-SHMEM linux-2.6.7-boot64/mm/Makefile
--- linux-2.6.7-boot64/mm/Makefile-SHMEM	2004-06-16 12:23:42.000000000 +0200
+++ linux-2.6.7-boot64/mm/Makefile	2004-08-07 23:57:49.000000000 +0200
@@ -5,13 +5,14 @@
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
 			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   shmem.o vmalloc.o
+			   vmalloc.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o prio_tree.o \
 			   readahead.o slab.o swap.o truncate.o vmscan.o \
 			   $(mmu-y)
 
+obj-$(CONFIG_TMPFS)	+= shmem.o
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o


