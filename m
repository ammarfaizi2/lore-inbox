Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264667AbTE1Klk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbTE1Klj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:41:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:58076 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264667AbTE1Klh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:41:37 -0400
Date: Wed, 28 May 2003 16:35:53 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Inline vm_acct_memory
Message-ID: <20030528110552.GF5604@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
I found that inlining vm_acct_memory speeds up vm_enough_memory.  
Since vm_acct_memory is only called by vm_enough_memory,
theoritically inlining should help, and my tests proved so -- there was
an improvement of about 10 % in profile ticks (vm_enough_memory) on a 
4 processor PIII Xeon running kernbench.  Here is the patch.  Tested on 2.5.70

Thanks,
Kiran


D:
D: Patch inlines use of vm_acct_memory
D:

diff -ruN -X dontdiff linux-2.5.69/include/linux/mman.h linux-2.5.69-vm_acct_inline/include/linux/mman.h
--- linux-2.5.69/include/linux/mman.h	Mon May  5 05:23:02 2003
+++ linux-2.5.69-vm_acct_inline/include/linux/mman.h	Tue May 20 12:18:34 2003
@@ -2,6 +2,8 @@
 #define _LINUX_MMAN_H
 
 #include <linux/config.h>
+#include <linux/smp.h>
+#include <linux/percpu.h>
 
 #include <asm/atomic.h>
 #include <asm/mman.h>
@@ -13,7 +15,27 @@
 extern atomic_t vm_committed_space;
 
 #ifdef CONFIG_SMP
-extern void vm_acct_memory(long pages);
+DECLARE_PER_CPU(long, committed_space);
+
+/*
+ * We tolerate a little inaccuracy to avoid ping-ponging the counter between
+ * CPUs
+ */
+#define ACCT_THRESHOLD	max(16, NR_CPUS * 2)
+
+static void inline vm_acct_memory(long pages)
+{
+	long *local;
+
+	preempt_disable();
+	local = &__get_cpu_var(committed_space);
+	*local += pages;
+	if (*local > ACCT_THRESHOLD || *local < -ACCT_THRESHOLD) {
+		atomic_add(*local, &vm_committed_space);
+		*local = 0;
+	}
+	preempt_enable();
+}
 #else
 static inline void vm_acct_memory(long pages)
 {
diff -ruN -X dontdiff linux-2.5.69/mm/mmap.c linux-2.5.69-vm_acct_inline/mm/mmap.c
--- linux-2.5.69/mm/mmap.c	Mon May  5 05:23:32 2003
+++ linux-2.5.69-vm_acct_inline/mm/mmap.c	Tue May 20 12:05:36 2003
@@ -53,6 +53,10 @@
 int sysctl_overcommit_ratio = 50;	/* default is 50% */
 atomic_t vm_committed_space = ATOMIC_INIT(0);
 
+#ifdef CONFIG_SMP
+DEFINE_PER_CPU(long, committed_space) = 0;
+#endif
+
 /*
  * Check that a process has enough memory to allocate a new virtual
  * mapping. 1 means there is enough memory for the allocation to
diff -ruN -X dontdiff linux-2.5.69/mm/swap.c linux-2.5.69-vm_acct_inline/mm/swap.c
--- linux-2.5.69/mm/swap.c	Mon May  5 05:23:13 2003
+++ linux-2.5.69-vm_acct_inline/mm/swap.c	Tue May 20 11:50:59 2003
@@ -349,30 +349,6 @@
 }
 
 
-#ifdef CONFIG_SMP
-/*
- * We tolerate a little inaccuracy to avoid ping-ponging the counter between
- * CPUs
- */
-#define ACCT_THRESHOLD	max(16, NR_CPUS * 2)
-
-static DEFINE_PER_CPU(long, committed_space) = 0;
-
-void vm_acct_memory(long pages)
-{
-	long *local;
-
-	preempt_disable();
-	local = &__get_cpu_var(committed_space);
-	*local += pages;
-	if (*local > ACCT_THRESHOLD || *local < -ACCT_THRESHOLD) {
-		atomic_add(*local, &vm_committed_space);
-		*local = 0;
-	}
-	preempt_enable();
-}
-#endif
-
 
 /*
  * Perform any setup for the swap system
