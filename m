Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268131AbUI2BMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268131AbUI2BMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 21:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUI2BMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 21:12:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:45965 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268131AbUI2BMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 21:12:34 -0400
Subject: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au, "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1096420339.15060.139.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 28 Sep 2004 18:12:20 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA64 already has their own version of SD_NODE_INIT, tuned for their
extremely large machines.  I think that all arches would benefit from
having their own, arch-specific SD_NODE_INIT initializer, rather than
the one-size-fits-all variant we've got now.

This patch just creates one instance of SD_NODE_INIT per architecture in
the arch's include/asm/topology.h file.  IA64's wasn't defined there, so
for consistency I moved it.  Also, in each topology.h file I touched, I
removed the NODE_BALANCE_RATE definition since a grep of the -mm tree
revealed that it is defined all over the place, but no longer used. 
This patch does NOT attempt any actual tuning of the values.  Every
architecture has the same values as the current one-size-fits-all
version.  Anyone who is interested in the 4 main NUMA arches (i386,
ia64, x86_64 & ppc64) please test this and feel free to send me any
"tweaked" values that might help performance for your arch.

Compiled and booted on i386 and x86_64.

[mcd@arrakis source]$ diffstat ~/linux/patches/sched_domains/per_arch-SD_INIT.patch
 arch/ia64/kernel/domain.c     |    1
 include/asm-i386/topology.h   |   49 +++++++++++++++++++++++++++++++++++-------
 include/asm-ia64/processor.h  |   21 ------------------
 include/asm-ia64/topology.h   |   23 +++++++++++++++++--
 include/asm-ppc64/topology.h  |   21 ++++++++++++++++--
 include/asm-x86_64/topology.h |   22 ++++++++++++++++++
 include/linux/sched.h         |   21 ++----------------
 7 files changed, 104 insertions(+), 54 deletions(-)

-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/arch/ia64/kernel/domain.c linux-2.6.9-rc2-mm4+per_arch-SD_INITs/arch/ia64/kernel/domain.c
--- linux-2.6.9-rc2-mm4/arch/ia64/kernel/domain.c	2004-09-27 15:57:19.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/arch/ia64/kernel/domain.c	2004-09-27 17:42:59.000000000 -0700
@@ -11,7 +11,6 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/topology.h>
-#include <asm/processor.h>
 
 #define SD_NODES_PER_DOMAIN 6
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/asm-i386/topology.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-i386/topology.h
--- linux-2.6.9-rc2-mm4/include/asm-i386/topology.h	2004-09-16 15:02:45.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-i386/topology.h	2004-09-27 17:38:45.000000000 -0700
@@ -69,17 +69,50 @@ static inline cpumask_t pcibus_to_cpumas
 /* Node-to-Node distance */
 #define node_distance(from, to) ((from) != (to))
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 100
+#ifdef CONFIG_X86_NUMAQ
+/* sched_domains SD_NODE_INIT for IBM/Sequent NUMAQ machines */
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 8,			\
+	.max_interval		= 32,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+#else
+/* sched_domains SD_NODE_INIT for other i386 NUMA machines */
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 8,			\
+	.max_interval		= 32,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+#endif /* CONFIG_X86_NUMAQ */
 
 #else /* !CONFIG_NUMA */
-/*
- * Other i386 platforms should define their own version of the 
- * above macros here.
- */
-
 #include <asm-generic/topology.h>
-
 #endif /* CONFIG_NUMA */
 
 #endif /* _ASM_I386_TOPOLOGY_H */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/asm-ia64/processor.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-ia64/processor.h
--- linux-2.6.9-rc2-mm4/include/asm-ia64/processor.h	2004-09-27 15:57:51.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-ia64/processor.h	2004-09-27 17:40:05.000000000 -0700
@@ -337,27 +337,6 @@ struct task_struct;
 /* Prepare to copy thread state - unlazy all lazy status */
 #define prepare_to_copy(tsk)	do { } while (0)
 
-#ifdef CONFIG_NUMA
-#define SD_NODE_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
-	.parent			= NULL,			\
-	.groups			= NULL,			\
-	.min_interval		= 80,			\
-	.max_interval		= 320,			\
-	.busy_factor		= 320,			\
-	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
-	.cache_nice_tries	= 1,			\
-	.per_cpu_gain		= 100,			\
-	.flags			= SD_LOAD_BALANCE	\
-				| SD_BALANCE_EXEC	\
-				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
-	.balance_interval	= 10,			\
-	.nr_balance_failed	= 0,			\
-}
-#endif
-
 /*
  * This is the mechanism for creating a new kernel thread.
  *
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/asm-ia64/topology.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-ia64/topology.h
--- linux-2.6.9-rc2-mm4/include/asm-ia64/topology.h	2004-08-13 22:36:11.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-ia64/topology.h	2004-09-27 17:40:55.000000000 -0700
@@ -40,11 +40,28 @@
  */
 #define node_to_first_cpu(node) (__ffs(node_to_cpumask(node)))
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
-
 void build_cpu_to_node_map(void);
 
+/* sched_domains SD_NODE_INIT for IA64 NUMA machines */
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 80,			\
+	.max_interval		= 320,			\
+	.busy_factor		= 320,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 10,			\
+	.nr_balance_failed	= 0,			\
+}
+
 #endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/asm-ppc64/topology.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-ppc64/topology.h
--- linux-2.6.9-rc2-mm4/include/asm-ppc64/topology.h	2004-08-13 22:38:08.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-ppc64/topology.h	2004-09-27 17:56:06.000000000 -0700
@@ -37,8 +37,25 @@ static inline int node_to_first_cpu(int 
 
 #define nr_cpus_node(node)	(nr_cpus_in_node[node])
 
-/* Cross-node load balancing interval. */
-#define NODE_BALANCE_RATE 10
+/* sched_domains SD_NODE_INIT for PPC64 machines */
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 8,			\
+	.max_interval		= 32,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
 
 #else /* !CONFIG_NUMA */
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/asm-x86_64/topology.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-x86_64/topology.h
--- linux-2.6.9-rc2-mm4/include/asm-x86_64/topology.h	2004-09-16 15:02:46.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-x86_64/topology.h	2004-09-28 15:45:38.000000000 -0700
@@ -32,7 +32,27 @@ static inline cpumask_t __pcibus_to_cpum
 /* broken generic file uses #ifndef later on this */
 #define pcibus_to_cpumask(bus) __pcibus_to_cpumask(bus)
 
-#define NODE_BALANCE_RATE 30	/* CHECKME */ 
+#ifdef CONFIG_NUMA
+/* sched_domains SD_NODE_INIT for X86_64 machines */
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 8,			\
+	.max_interval		= 32,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+#endif /* CONFIG_NUMA */
 
 #endif
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/linux/sched.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/linux/sched.h
--- linux-2.6.9-rc2-mm4/include/linux/sched.h	2004-09-27 15:57:56.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/linux/sched.h	2004-09-28 15:48:32.000000000 -0700
@@ -30,6 +30,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/topology.h>
 
 struct exec_domain;
 
@@ -538,25 +539,9 @@ extern void cpu_attach_domain(struct sch
 }
 
 #if defined(CONFIG_NUMA) && !defined(SD_NODE_INIT)
-#define SD_NODE_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
-	.parent			= NULL,			\
-	.groups			= NULL,			\
-	.min_interval		= 8,			\
-	.max_interval		= 32,			\
-	.busy_factor		= 32,			\
-	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000),		\
-	.cache_nice_tries	= 1,			\
-	.per_cpu_gain		= 100,			\
-	.flags			= SD_LOAD_BALANCE	\
-				| SD_BALANCE_EXEC	\
-				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
-	.balance_interval	= 1,			\
-	.nr_balance_failed	= 0,			\
-}
+#error Please define an appropriate SD_NODE_INIT in include/asm/topology.h
 #endif
+
 #endif /* ARCH_HAS_SCHED_TUNE */
 #endif /* CONFIG_SMP */
 


