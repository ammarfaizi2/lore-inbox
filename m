Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269621AbUI3XsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbUI3XsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269622AbUI3XsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 19:48:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28571 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269621AbUI3Xrv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 19:47:51 -0400
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <20040930211228.GE28315@wotan.suse.de>
References: <1096420339.15060.139.camel@arrakis>
	 <415BC0BC.6040902@yahoo.com.au> <1096569412.20097.13.camel@arrakis>
	 <20040930204502.GD28315@wotan.suse.de> <1096578415.20964.9.camel@arrakis>
	 <20040930211228.GE28315@wotan.suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1096588051.20964.29.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 30 Sep 2004 16:47:32 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 14:12, Andi Kleen wrote:
> > Well, you can certainly base the x86_64 CMP values on the current
> > SD_SIBLING_INIT values.  Those are well publicized, see
> > include/linux/sched.h! ;)
> 
> Current BK has it in kernel/sched.c.

Fair enough.  I was thinking about the -mm tree. :)


> And it also broke NUMA kernels on UP, but that's a different issue.

What broke NUMA kernels on UP?  Are you talking about the cpu_online_map
vs. cpu_possible_map thing from a little bit ago?


> > I suppose it would be pretty trivial to define defaults in
> > include/asm-generic/topology.h, and allow arches that care to define
> > their own SD_*_INITs without disrupting anyone else.  Actually, that's
> > far better than what I've got now.  I'll run that patch up after the
> > meeting I'm currently late for and post it in a couple hours.
> 
> Full override isn't good imho because it could lead to bit rot, 
> better is to have defaults that can be used as a base, but tweaked.

I'm not sure why it would lead to bit rot?  Because every arch would
define their own initializers and not use the generic ones?  If so, we
could always rip them out...  I doubt that will happen, since I don't
foresee most arches caring enough to set up custom initializers. 
Especially since no one has done it yet, and some of the bigger arches
really need to.

I'm also not quite sure what you mean about using one common set
definitions as a base?  How would you tweak a generic SD_NODE_INIT
initializer without overriding it?

Here's a smaller patch (only compile tested) to implement this in a much
better way.  What it does is:

1) Rip SD_*_INIT definitions out of linux/sched.h and move them into
linux/topology.h and have linux/sched.h include linux/topology.h
2) Move IA64's arch-specific SD_NODE_INIT definition from
asm/processor.h to asm/topology.h.

This way, all an architecture has to do to set up their own
arch-specific initializers is define them in asm/topology.h.  It makes
it totally trivial for an arch to set this up without changing or
breaking anyone else's values.


[mcd@arrakis source]$ diffstat ~/linux/patches/sched_domains/per_arch-SD_INIT.patch
 arch/ia64/kernel/domain.c    |    1
 include/asm-ia64/processor.h |   21 -----------
 include/asm-ia64/topology.h  |   20 +++++++++++
 include/linux/sched.h        |   74 +---------------------------------------
 include/linux/topology.h     |   78 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 94 deletions(-)


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
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-ia64/topology.h	2004-09-30 16:06:47.000000000 -0700
@@ -45,6 +45,26 @@
 
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/linux/sched.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/linux/sched.h
--- linux-2.6.9-rc2-mm4/include/linux/sched.h	2004-09-27 15:57:56.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/linux/sched.h	2004-09-30 16:03:06.000000000 -0700
@@ -30,6 +30,7 @@
 #include <linux/completion.h>
 #include <linux/pid.h>
 #include <linux/percpu.h>
+#include <linux/topology.h>
 
 struct exec_domain;
 
@@ -486,78 +487,7 @@ extern cpumask_t cpu_isolated_map;
 extern void init_sched_build_groups(struct sched_group groups[],
 	                        cpumask_t span, int (*group_fn)(int cpu));
 extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
-#endif
-
-#ifndef ARCH_HAS_SCHED_TUNE
-#ifdef CONFIG_SCHED_SMT
-#define ARCH_HAS_SCHED_WAKE_IDLE
-/* Common values for SMT siblings */
-#define SD_SIBLING_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
-	.parent			= NULL,			\
-	.groups			= NULL,			\
-	.min_interval		= 1,			\
-	.max_interval		= 2,			\
-	.busy_factor		= 8,			\
-	.imbalance_pct		= 110,			\
-	.cache_hot_time		= 0,			\
-	.cache_nice_tries	= 0,			\
-	.per_cpu_gain		= 25,			\
-	.flags			= SD_LOAD_BALANCE	\
-				| SD_BALANCE_NEWIDLE	\
-				| SD_BALANCE_EXEC	\
-				| SD_WAKE_AFFINE	\
-				| SD_WAKE_IDLE		\
-				| SD_SHARE_CPUPOWER,	\
-	.last_balance		= jiffies,		\
-	.balance_interval	= 1,			\
-	.nr_balance_failed	= 0,			\
-}
-#endif
-
-/* Common values for CPUs */
-#define SD_CPU_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
-	.parent			= NULL,			\
-	.groups			= NULL,			\
-	.min_interval		= 1,			\
-	.max_interval		= 4,			\
-	.busy_factor		= 64,			\
-	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000/2),		\
-	.cache_nice_tries	= 1,			\
-	.per_cpu_gain		= 100,			\
-	.flags			= SD_LOAD_BALANCE	\
-				| SD_BALANCE_NEWIDLE	\
-				| SD_BALANCE_EXEC	\
-				| SD_WAKE_AFFINE	\
-				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
-	.balance_interval	= 1,			\
-	.nr_balance_failed	= 0,			\
-}
-
-#if defined(CONFIG_NUMA) && !defined(SD_NODE_INIT)
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
-#endif
-#endif /* ARCH_HAS_SCHED_TUNE */
+#endif /* ARCH_HAS_SCHED_DOMAIN */
 #endif /* CONFIG_SMP */
 
 
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/linux/topology.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/linux/topology.h
--- linux-2.6.9-rc2-mm4/include/linux/topology.h	2004-09-16 15:02:47.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/linux/topology.h	2004-09-30 16:27:43.000000000 -0700
@@ -61,4 +61,82 @@ static inline int __next_node_with_cpus(
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
 #endif
 
+#ifdef CONFIG_SCHED_SMT
+/* MCD - Do we really need this?  It is always on if CONFIG_SCHED_SMT is, 
+ * so can't we drop this in favor of CONFIG_SCHED_SMT?
+ */
+#define ARCH_HAS_SCHED_WAKE_IDLE
+/* Common values for SMT siblings */
+#ifndef SD_SIBLING_INIT
+#define SD_SIBLING_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 1,			\
+	.max_interval		= 2,			\
+	.busy_factor		= 8,			\
+	.imbalance_pct		= 110,			\
+	.cache_hot_time		= 0,			\
+	.cache_nice_tries	= 0,			\
+	.per_cpu_gain		= 25,			\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_NEWIDLE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_AFFINE	\
+				| SD_WAKE_IDLE		\
+				| SD_SHARE_CPUPOWER,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+#endif
+#endif /* CONFIG_SCHED_SMT */
+
+/* Common values for CPUs */
+#ifndef SD_CPU_INIT
+#define SD_CPU_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 1,			\
+	.max_interval		= 4,			\
+	.busy_factor		= 64,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (5*1000/2),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_LOAD_BALANCE	\
+				| SD_BALANCE_NEWIDLE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_AFFINE	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+#endif
+
+#ifdef CONFIG_NUMA
+#ifndef SD_NODE_INIT
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
+#endif
+#endif /* CONFIG_NUMA */
+
 #endif /* _LINUX_TOPOLOGY_H */


