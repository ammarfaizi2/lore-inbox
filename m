Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUJAW1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUJAW1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUJAW1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:27:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:13295 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266876AbUJAWVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:21:18 -0400
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
In-Reply-To: <78560000.1096611330@[10.10.2.4]>
References: <1096420339.15060.139.camel@arrakis>
	 <415BC0BC.6040902@yahoo.com.au><1096569412.20097.13.camel@arrakis>
	 <20040930122312.3f09ed73.akpm@osdl.org>  <78560000.1096611330@[10.10.2.4]>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1096669257.20964.66.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 01 Oct 2004 15:20:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 23:15, Martin J. Bligh wrote:
> --Andrew Morton <akpm@osdl.org> wrote (on Thursday, September 30, 2004 12:23:12 -0700):
> 
> > Matthew Dobson <colpatch@us.ibm.com> wrote:
> >> 
> >> I would like to try to get this in before then, unless this will really
> >>  make things difficult for you.
> > 
> > It's about three weeks late for 2.6.9.  I already have a string of CPU
> > scheduler patches awaiting the 2.6.10 stream and once we're at -rc2 we
> > really should only be looking at bugfixes.
> 
> Yup, seems a bit late for that, but early 2.6.10 would be nice if possible?
>  
> > Grumble, mutter..  it looks like one of those "if it compiled, it works"
> > things.  Problem is, any time anyone touches that particular piece of the
> > kernel, half the architectures stop compiing.
> 
> I tested it - worked for me ;-)
> 
> This is the first step to getting the arches to actually use the flexibility
> we had, and stop Andi complaining the scheduler is tuned for one arch rather
> than another ;-) These params definitely need to be per arch/subarch, and
> probably some other ones too, but this seems like a good start.
> 
> M.

Martin, Andi, Andrew & anyone else still reading this thread,
Here's yet another version of a patch to implement per-arch SD_*_INITs. 
This follows the same basic idea of my last patch, but 
1) defines an arch-specific SD_NODE_INIT for the 4 NUMA arches (i386,
x86_64, IA64 & PPC64), 
2) defines *default* SD_CPU_INIT & SD_SIBLING_INIT for *all* arches,
with the possibility of them being overridden by simply defining an
arch-specific version in include/asm/topology.h.

The motivation behind the third version of this patch is that Martin
feels that there should be no "default" NUMA initializer because NUMA
characteristics are *very* arch/platform specific, and hence a "default"
NUMA initializer can only lead to confusion.  I agree with most of that,
but don't quite see as much harm in having a default as he does. 
Nevertheless, to keep him quiet, I've run up this version of the patch. 
Martin, please run this through your magic test suite and make sure I
didn't break anything trivial.

[mcd@arrakis source]$ diffstat ~/linux/patches/sched_domains/per_arch-SD_INIT.patch
 arch/ia64/kernel/domain.c     |    1
 include/asm-i386/topology.h   |   20 +++++++++++
 include/asm-ia64/processor.h  |   21 -----------
 include/asm-ia64/topology.h   |   20 +++++++++++
 include/asm-ppc64/topology.h  |   20 +++++++++++
 include/asm-x86_64/topology.h |   22 ++++++++++++
 include/linux/sched.h         |   74 +-----------------------------------------
 include/linux/topology.h      |   72 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 156 insertions(+), 94 deletions(-)


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
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-i386/topology.h	2004-10-01 15:06:30.000000000 -0700
@@ -72,6 +72,26 @@ static inline cpumask_t pcibus_to_cpumas
 /* Cross-node load balancing interval. */
 #define NODE_BALANCE_RATE 100
 
+/* sched_domains SD_NODE_INIT for NUMAQ machines */
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
+
 #else /* !CONFIG_NUMA */
 /*
  * Other i386 platforms should define their own version of the 
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
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/asm-ppc64/topology.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-ppc64/topology.h
--- linux-2.6.9-rc2-mm4/include/asm-ppc64/topology.h	2004-08-13 22:38:08.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-ppc64/topology.h	2004-10-01 15:07:24.000000000 -0700
@@ -40,6 +40,26 @@ static inline int node_to_first_cpu(int 
 /* Cross-node load balancing interval. */
 #define NODE_BALANCE_RATE 10
 
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
+
 #else /* !CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.9-rc2-mm4/include/asm-x86_64/topology.h linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-x86_64/topology.h
--- linux-2.6.9-rc2-mm4/include/asm-x86_64/topology.h	2004-09-16 15:02:46.000000000 -0700
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/asm-x86_64/topology.h	2004-10-01 15:07:35.000000000 -0700
@@ -34,6 +34,28 @@ static inline cpumask_t __pcibus_to_cpum
 
 #define NODE_BALANCE_RATE 30	/* CHECKME */ 
 
+#ifdef CONFIG_NUMA
+/* sched_domains SD_NODE_INIT for x86_64 machines */
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
+
 #endif
 
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
+++ linux-2.6.9-rc2-mm4+per_arch-SD_INITs/include/linux/topology.h	2004-10-01 15:15:56.000000000 -0700
@@ -61,4 +61,76 @@ static inline int __next_node_with_cpus(
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
 #endif
 
+/*
+ * Below are the 3 major initializers used in building sched_domains:
+ * SD_SIBLING_INIT, for SMT domains
+ * SD_CPU_INIT, for SMP domains
+ * SD_NODE_INIT, for NUMA domains
+ *
+ * Any architecture that cares to do any tuning to these values should do so 
+ * by defining their own arch-specific initializer in include/asm/topology.h.
+ * A definition there will automagically override these default initializers 
+ * and allow arch-specific performance tuning of sched_domains.
+ */
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
+#error Please define an appropriate SD_NODE_INIT in include/asm/topology.h!!!
+#endif
+#endif /* CONFIG_NUMA */
+
 #endif /* _LINUX_TOPOLOGY_H */


