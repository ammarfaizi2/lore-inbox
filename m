Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbRBCOJl>; Sat, 3 Feb 2001 09:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129051AbRBCOJb>; Sat, 3 Feb 2001 09:09:31 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:8196 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129040AbRBCOJO>;
	Sat, 3 Feb 2001 09:09:14 -0500
Date: Sat, 3 Feb 2001 15:09:05 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] /proc/sys/vm/max_map_count
Message-ID: <20010203150905.B1071@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few days ago, a colleague asked me for help with some malloc problem.
I applied my usual solution, efence, and found the bug. Then she ran a
larger simulation, and it promptly failed with ENOMEM. After a bit of
searching, I found that MAX_MAP_COUNT was the culprit, and that in
order to raise the limit, I had to rebuild the kernel and reboot the
machine. Reboot a Linux system to change one stupid little integer !
I felt very embarrassed ...

Okay, here's a patch for 2.4.1 that should prevent further humiliations
of that type from happening. (I'm now hitting a limit at around 229309
maps (~0.87GB), but that's something else. Test program to exercise
max_map_count at ftp://icaftp.epfl.ch/pub/people/almesber/junk/mm.c)

BTW, I've noticed that mm/mmap.c:sys_brk and do_brk both check
vm_enough_memory. Do we really need this ? Removing one of them may
make sys_brk about 2% faster ;-)

- Werner

------------------------------------ patch ------------------------------------

--- linux.orig/include/linux/sched.h	Tue Jan 30 08:24:56 2001
+++ linux/include/linux/sched.h	Sat Feb  3 14:29:41 2001
@@ -195,7 +195,9 @@
 }
 
 /* Maximum number of active map areas.. This is a random (large) number */
-#define MAX_MAP_COUNT	(65536)
+#define DEFAULT_MAX_MAP_COUNT	(65536)
+
+extern int max_map_count;
 
 /* Number of map areas at which the AVL tree is activated. This is arbitrary. */
 #define AVL_MIN_MAP_COUNT	32
--- linux.orig/include/linux/sysctl.h	Tue Jan 30 08:24:55 2001
+++ linux/include/linux/sysctl.h	Sat Feb  3 14:29:49 2001
@@ -132,7 +132,8 @@
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+	VM_MAX_MAP_COUNT=11,	/* int: Maximum number of active map areas */
 };
 
 
--- linux.orig/kernel/sysctl.c	Fri Dec 29 23:07:24 2000
+++ linux/kernel/sysctl.c	Sat Feb  3 14:28:05 2001
@@ -257,6 +257,8 @@
 	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
 	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_MAX_MAP_COUNT, "max_map_count",
+	 &max_map_count, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 
--- linux.orig/mm/mmap.c	Mon Jan 29 17:10:41 2001
+++ linux/mm/mmap.c	Sat Feb  3 14:28:49 2001
@@ -37,6 +37,7 @@
 };
 
 int sysctl_overcommit_memory;
+int max_map_count = DEFAULT_MAX_MAP_COUNT;
 
 /* Check that a process has enough memory to allocate a
  * new virtual mapping.
@@ -207,7 +208,7 @@
 		return -EINVAL;
 
 	/* Too many mappings? */
-	if (mm->map_count > MAX_MAP_COUNT)
+	if (mm->map_count > max_map_count)
 		return -ENOMEM;
 
 	/* mlock MCL_FUTURE? */
@@ -691,7 +692,7 @@
 
 	/* If we'll make "hole", check the vm areas limit */
 	if ((mpnt->vm_start < addr && mpnt->vm_end > addr+len)
-	    && mm->map_count >= MAX_MAP_COUNT)
+	    && mm->map_count >= max_map_count)
 		return -ENOMEM;
 
 	/*
@@ -809,7 +810,7 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
-	if (mm->map_count > MAX_MAP_COUNT)
+	if (mm->map_count > max_map_count)
 		return -ENOMEM;
 
 	if (!vm_enough_memory(len >> PAGE_SHIFT))
--- linux.orig/mm/filemap.c	Tue Jan 16 02:14:41 2001
+++ linux/mm/filemap.c	Sat Feb  3 14:18:02 2001
@@ -1923,7 +1923,7 @@
 	int error = 0;
 
 	/* This caps the number of vma's this process can own */
-	if (vma->vm_mm->map_count > MAX_MAP_COUNT)
+	if (vma->vm_mm->map_count > max_map_count)
 		return -ENOMEM;
 
 	if (start == vma->vm_start) {
--- linux.orig/Documentation/sysctl/vm.txt	Tue Aug  8 08:01:34 2000
+++ linux/Documentation/sysctl/vm.txt	Sat Feb  3 14:33:14 2001
@@ -21,6 +21,7 @@
 - buffermem
 - freepages
 - kswapd
+- max_map_count
 - overcommit_memory
 - page-cluster
 - pagecache
@@ -171,6 +172,19 @@
 and don't use much of it.
 
 Look at: mm/mmap.c::vm_enough_memory() for more information.
+
+==============================================================
+
+max_map_count:
+
+This file contains the maximum number of memory map areas a
+process may have. Memory map areas are used as a side-effect
+of calling malloc, directly by mmap and mprotect, and also
+when loading shared libraries.
+
+While most applications need less than a thousand maps,
+certain programs, particularly malloc debuggers, may consume 
+lots of them, e.g. up to one or two maps per allocation.
 
 ==============================================================
 
-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
