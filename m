Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279829AbRKFRjY>; Tue, 6 Nov 2001 12:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279853AbRKFRjP>; Tue, 6 Nov 2001 12:39:15 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46076 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S279852AbRKFRjF>;
	Tue, 6 Nov 2001 12:39:05 -0500
Date: Tue, 06 Nov 2001 11:38:58 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Don't include highmem in task limit calculation
Message-ID: <7580000.1005068338@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The calculation of the max number of tasks in fork_init currently uses the
total amount of memory in the machine.  Since the resources it's actually
using per task come from kernel memory, this is wrong.  The number it
should use is the size of the normal memory pool.

To fix this I've added a variable num_mappedpages that represents the
amount of mapped memory the kernel can use.  This means each architecture
can tune it based on its own memory layout.  My patch only sets this for
the i386 architecture, and if it's not set just uses num_physpages.  This
means architectures that don't need highmem can just ignore it.

I also only pass this changed number to fork_init(), but the code in
start_kernel() also calls vfs_caches_init(), buffer_init(), and
page_cache_init().  If any of these should really be limiting their scaling
based on kernel mapped memory those calls should also be changed.

The patch is below.

Dave McCracken 

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

----------------------

--- linux-2.4.14/./init/main.c	Fri Oct 12 12:17:15 2001
+++ linux-2.4.14-test/./init/main.c	Tue Nov  6 10:24:19 2001
@@ -542,7 +542,6 @@
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
-	unsigned long mempages;
 	extern char saved_command_line[];
 /*
  * Interrupts are still disabled. Do necessary setups, then
@@ -591,14 +590,23 @@
 #endif
 	mem_init();
 	kmem_cache_sizes_init();
-	mempages = num_physpages;
 
-	fork_init(mempages);
+	/*
+	 * For architectures that have highmem, num_mappedpages represents
+	 * the amount of memory the kernel can use.  For other architectures
+	 * it's the same as the total pages.  We need both numbers because
+	 * some subsystems need to initialize base on how much memory the
+	 * kernel can use.
+	 */
+	if (num_mappedpages == 0)
+		num_mappedpages = num_physpages;
+
+	fork_init(num_mappedpages);
 	proc_caches_init();
-	vfs_caches_init(mempages);
-	buffer_init(mempages);
-	page_cache_init(mempages);
+	vfs_caches_init(num_physpages);
+	buffer_init(num_physpages);
+	page_cache_init(num_physpages);
 #if defined(CONFIG_ARCH_S390)
 	ccwcache_init();
 #endif
--- linux-2.4.14/./mm/memory.c	Sun Nov  4 11:29:14 2001
+++ linux-2.4.14-test/./mm/memory.c	Tue Nov  6 10:20:39 2001
@@ -51,6 +51,7 @@
 
 unsigned long max_mapnr;
 unsigned long num_physpages;
+unsigned long num_mappedpages;
 void * high_memory;
 struct page *highmem_start_page;
 
--- linux-2.4.14/./include/linux/mm.h	Mon Nov  5 14:42:15 2001
+++ linux-2.4.14-test/./include/linux/mm.h	Tue Nov  6 10:32:42 2001
@@ -15,6 +15,7 @@
 
 extern unsigned long max_mapnr;
 extern unsigned long num_physpages;
+extern unsigned long num_mappedpages;
 extern void * high_memory;
 extern int page_cluster;
 /* The inactive_clean lists are per zone. */
--- linux-2.4.14/./arch/i386/mm/init.c	Thu Sep 20 21:59:20 2001
+++ linux-2.4.14-test/./arch/i386/mm/init.c	Tue Nov  6 10:26:02 2001
@@ -450,8 +450,9 @@
 #ifdef CONFIG_HIGHMEM
 	highmem_start_page = mem_map + highstart_pfn;
 	max_mapnr = num_physpages = highend_pfn;
+	num_mappedpages = max_low_pfn;
 #else
-	max_mapnr = num_physpages = max_low_pfn;
+	max_mapnr = num_mappedpages = num_physpages = max_low_pfn;
 #endif
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
 

