Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUIJSha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUIJSha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 14:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUIJSha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 14:37:30 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:1513 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S267509AbUIJShX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 14:37:23 -0400
Subject: [patch 1/2] uml-patch-smp-compile
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it,
       sonny@burdell.org
From: blaisorblade_spam@yahoo.it
Date: Fri, 10 Sep 2004 19:15:40 +0200
Message-Id: <20040910171541.09134C751@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Sonny Rao <sonny@burdell.org>
Make the SMP code compile, at least, to make testing possible, and remove
its dependency on CONFIG_BROKEN.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Kconfig           |    1 -
 uml-linux-2.6.8.1-paolo/arch/um/kernel/smp.c      |    8 +++++++-
 uml-linux-2.6.8.1-paolo/include/asm-um/smp.h      |    2 ++
 uml-linux-2.6.8.1-paolo/include/asm-um/spinlock.h |    6 ++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/smp.c~uml-patch-smp-compile arch/um/kernel/smp.c
--- uml-linux-2.6.8.1/arch/um/kernel/smp.c~uml-patch-smp-compile	2004-08-29 14:40:54.845873936 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/kernel/smp.c	2004-08-29 14:40:54.849873328 +0200
@@ -29,9 +29,11 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_ga
 #include "os.h"
 
 /* CPU online map, set by smp_boot_cpus */
-unsigned long cpu_online_map = CPU_MASK_NONE;
+cpumask_t cpu_online_map = CPU_MASK_NONE;
+cpumask_t cpu_possible_map = CPU_MASK_NONE;
 
 EXPORT_SYMBOL(cpu_online_map);
+EXPORT_SYMBOL(cpu_possible_map);
 
 /* Per CPU bogomips and other parameters
  * The only piece used here is the ipi pipe, which is set before SMP is
@@ -126,6 +128,10 @@ void smp_prepare_cpus(unsigned int maxcp
 	struct task_struct *idle;
 	unsigned long waittime;
 	int err, cpu, me = smp_processor_id();
+	int i;
+
+	for (i = 0; i < ncpus; ++i)
+		cpu_set(i, cpu_possible_map);
 
 	cpu_clear(me, cpu_online_map);
 	cpu_set(me, cpu_online_map);
diff -puN include/asm-um/smp.h~uml-patch-smp-compile include/asm-um/smp.h
--- uml-linux-2.6.8.1/include/asm-um/smp.h~uml-patch-smp-compile	2004-08-29 14:40:54.846873784 +0200
+++ uml-linux-2.6.8.1-paolo/include/asm-um/smp.h	2004-08-29 14:40:54.850873176 +0200
@@ -9,6 +9,8 @@
 #include "linux/cpumask.h"
 
 extern cpumask_t cpu_online_map;
+extern cpumask_t cpu_possible_map;
+
 
 #define smp_processor_id() (current_thread->cpu)
 #define cpu_logical_map(n) (n)
diff -puN /dev/null include/asm-um/spinlock.h
--- /dev/null	2004-06-25 17:47:25.000000000 +0200
+++ uml-linux-2.6.8.1-paolo/include/asm-um/spinlock.h	2004-08-29 14:40:54.850873176 +0200
@@ -0,0 +1,6 @@
+#ifndef __UM_SPINLOCK_H
+#define __UM_SPINLOCK_H
+
+#include "asm/arch/spinlock.h"
+
+#endif
diff -puN arch/um/Kconfig~uml-patch-smp-compile arch/um/Kconfig
--- uml-linux-2.6.8.1/arch/um/Kconfig~uml-patch-smp-compile	2004-08-29 14:40:54.847873632 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig	2004-08-29 14:40:54.850873176 +0200
@@ -155,7 +155,6 @@ config HOST_2G_2G
 
 config UML_SMP
 	bool "Symmetric multi-processing support"
-	depends on BROKEN
 	help
         This option enables UML SMP support.  UML implements virtual SMP by
         allowing as many processes to run simultaneously on the host as
_
