Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267454AbUIMOdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267454AbUIMOdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 10:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUIMOch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 10:32:37 -0400
Received: from zero.aec.at ([193.170.194.10]:49157 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267454AbUIMO2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:28:22 -0400
To: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Move domain setup and add dual core support.
From: Andi Kleen <ak@muc.de>
Date: Mon, 13 Sep 2004 16:28:16 +0200
Message-ID: <m3vfeigs5b.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried to readd the AMD dual core support that got dropped
when arch/x86_64/kernel/domain.c was removed. It basically needs
to check a magic flag and use a different initializer for 
SMT siblings. 

It was a bit difficult to implement this in the old copy
without copying the standard initializer. I didn't want to
do that because it would have been too mainteance intensive.

What this patch does is to move the standard SD_* initializers
into a new include/linux/sched-domains.h header file. 
This way the architecture can freely access the structure
and base its decisions on the default. It also can actually
see the structures, that's useful if you want to change it
in a function, not a macro.

Then it adds a new SD_DUALCORE_INIT with some dual core 
defaults. I didn't do any testing on those, it's more
a starting point for future tuning. Currently it is a
mix between the values for normal hosts and SMT siblings.

And it adds a new layer to SD_SMT_INIT to allow easy overwriting
from asm/processor.h

Patch is for 2.6.9rc1-bk19. It's much smaller than it looks,
most of it is just moving code from sched.c to sched-domains.h

Signed-off-by: Andi Kleen <ak@muc.de>

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2004-09-12 23:15:35.%N +0200
+++ linux/kernel/sched.c	2004-09-13 15:16:51.%N +0200
@@ -43,6 +43,7 @@
 #include <linux/kthread.h>
 #include <linux/seq_file.h>
 #include <linux/times.h>
+#include <linux/sched-domains.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -289,140 +290,6 @@
 
 static DEFINE_PER_CPU(struct runqueue, runqueues);
 
-/*
- * sched-domains (multiprocessor balancing) declarations:
- */
-#ifdef CONFIG_SMP
-#define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
-
-#define SD_BALANCE_NEWIDLE	1	/* Balance when about to become idle */
-#define SD_BALANCE_EXEC		2	/* Balance on exec */
-#define SD_WAKE_IDLE		4	/* Wake to idle CPU on task wakeup */
-#define SD_WAKE_AFFINE		8	/* Wake task to waking CPU */
-#define SD_WAKE_BALANCE		16	/* Perform balancing at task wakeup */
-#define SD_SHARE_CPUPOWER	32	/* Domain members share cpu power */
-
-struct sched_group {
-	struct sched_group *next;	/* Must be a circular list */
-	cpumask_t cpumask;
-
-	/*
-	 * CPU power of this group, SCHED_LOAD_SCALE being max power for a
-	 * single CPU. This should be read only (except for setup). Although
-	 * it will need to be written to at cpu hot(un)plug time, perhaps the
-	 * cpucontrol semaphore will provide enough exclusion?
-	 */
-	unsigned long cpu_power;
-};
-
-struct sched_domain {
-	/* These fields must be setup */
-	struct sched_domain *parent;	/* top domain must be null terminated */
-	struct sched_group *groups;	/* the balancing groups of the domain */
-	cpumask_t span;			/* span of all CPUs in this domain */
-	unsigned long min_interval;	/* Minimum balance interval ms */
-	unsigned long max_interval;	/* Maximum balance interval ms */
-	unsigned int busy_factor;	/* less balancing by factor if busy */
-	unsigned int imbalance_pct;	/* No balance until over watermark */
-	unsigned long long cache_hot_time; /* Task considered cache hot (ns) */
-	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
-	unsigned int per_cpu_gain;	/* CPU % gained by adding domain cpus */
-	int flags;			/* See SD_* */
-
-	/* Runtime fields. */
-	unsigned long last_balance;	/* init to jiffies. units in jiffies */
-	unsigned int balance_interval;	/* initialise to 1. units in ms. */
-	unsigned int nr_balance_failed; /* initialise to 0 */
-
-#ifdef CONFIG_SCHEDSTATS
-	/* load_balance() stats */
-	unsigned long lb_cnt[MAX_IDLE_TYPES];
-	unsigned long lb_failed[MAX_IDLE_TYPES];
-	unsigned long lb_imbalance[MAX_IDLE_TYPES];
-	unsigned long lb_nobusyg[MAX_IDLE_TYPES];
-	unsigned long lb_nobusyq[MAX_IDLE_TYPES];
-
-	/* sched_balance_exec() stats */
-	unsigned long sbe_attempts;
-	unsigned long sbe_pushed;
-
-	/* try_to_wake_up() stats */
-	unsigned long ttwu_wake_affine;
-	unsigned long ttwu_wake_balance;
-#endif
-};
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
-	.flags			= SD_BALANCE_NEWIDLE	\
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
-	.cache_hot_time		= (5*1000000/2),	\
-	.cache_nice_tries	= 1,			\
-	.per_cpu_gain		= 100,			\
-	.flags			= SD_BALANCE_NEWIDLE	\
-				| SD_BALANCE_EXEC	\
-				| SD_WAKE_AFFINE	\
-				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
-	.balance_interval	= 1,			\
-	.nr_balance_failed	= 0,			\
-}
-
-/* Arch can override this macro in processor.h */
-#if defined(CONFIG_NUMA) && !defined(SD_NODE_INIT)
-#define SD_NODE_INIT (struct sched_domain) {		\
-	.span			= CPU_MASK_NONE,	\
-	.parent			= NULL,			\
-	.groups			= NULL,			\
-	.min_interval		= 8,			\
-	.max_interval		= 32,			\
-	.busy_factor		= 32,			\
-	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
-	.cache_nice_tries	= 1,			\
-	.per_cpu_gain		= 100,			\
-	.flags			= SD_BALANCE_EXEC	\
-				| SD_WAKE_BALANCE,	\
-	.last_balance		= jiffies,		\
-	.balance_interval	= 1,			\
-	.nr_balance_failed	= 0,			\
-}
-#endif
-#endif /* ARCH_HAS_SCHED_TUNE */
-#endif
-
-
 #define for_each_domain(cpu, domain) \
 	for (domain = cpu_rq(cpu)->sd; domain; domain = domain->parent)
 
@@ -4470,7 +4337,7 @@
 		p = sd;
 		sd = &per_cpu(cpu_domains, i);
 		group = cpu_to_cpu_group(i);
-		*sd = SD_SIBLING_INIT;
+		*sd = REAL_SD_SIBLING_INIT;
 		sd->span = cpu_sibling_map[i];
 		cpus_and(sd->span, sd->span, cpu_default_map);
 		sd->parent = p;
Index: linux/include/asm-x86_64/processor.h
===================================================================
--- linux.orig/include/asm-x86_64/processor.h	2004-09-13 11:07:22.%N +0200
+++ linux/include/asm-x86_64/processor.h	2004-09-13 15:16:55.%N +0200
@@ -460,4 +460,10 @@
 
 #define cache_line_size() (boot_cpu_data.x86_cache_alignment)
 
+/* AMD dual cores look like SMT. Correct for this */
+#define REAL_SD_SIBLING_INIT 				\
+	((boot_cpu_data.x86_vendor != X86_VENDOR_AMD || \
+	 boot_cpu_has(X86_FEATURE_HTVALID)) ? 		\
+	 SD_SIBLING_INIT : SD_DUALCORE_INIT)
+
 #endif /* __ASM_X86_64_PROCESSOR_H */
Index: linux/include/linux/sched-domains.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/include/linux/sched-domains.h	2004-09-13 15:20:17.%N +0200
@@ -0,0 +1,174 @@
+#ifndef _SCHED_DOMAINS_H
+#define _SCHED_DOMAINS_H 1
+
+#include <linux/config.h>
+#include <asm/processor.h> /* arch can overwrite some things here */
+
+struct sched_domain {
+	/* These fields must be setup */
+	struct sched_domain *parent;	/* top domain must be null terminated */
+	struct sched_group *groups;	/* the balancing groups of the domain */
+	cpumask_t span;			/* span of all CPUs in this domain */
+	unsigned long min_interval;	/* Minimum balance interval ms */
+	unsigned long max_interval;	/* Maximum balance interval ms */
+	unsigned int busy_factor;	/* less balancing by factor if busy */
+	unsigned int imbalance_pct;	/* No balance until over watermark */
+	unsigned long long cache_hot_time; /* Task considered cache hot (ns) */
+	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
+	unsigned int per_cpu_gain;	/* CPU % gained by adding domain cpus */
+	int flags;			/* See SD_* */
+
+	/* Runtime fields. */
+	unsigned long last_balance;	/* init to jiffies. units in jiffies */
+	unsigned int balance_interval;	/* initialise to 1. units in ms. */
+	unsigned int nr_balance_failed; /* initialise to 0 */
+
+#ifdef CONFIG_SCHEDSTATS
+	/* load_balance() stats */
+	unsigned long lb_cnt[MAX_IDLE_TYPES];
+	unsigned long lb_failed[MAX_IDLE_TYPES];
+	unsigned long lb_imbalance[MAX_IDLE_TYPES];
+	unsigned long lb_nobusyg[MAX_IDLE_TYPES];
+	unsigned long lb_nobusyq[MAX_IDLE_TYPES];
+
+	/* sched_balance_exec() stats */
+	unsigned long sbe_attempts;
+	unsigned long sbe_pushed;
+
+	/* try_to_wake_up() stats */
+	unsigned long ttwu_wake_affine;
+	unsigned long ttwu_wake_balance;
+#endif
+};
+
+
+/*
+ * sched-domains (multiprocessor balancing) declarations:
+ */
+#ifdef CONFIG_SMP
+#define SCHED_LOAD_SCALE	128UL	/* increase resolution of load */
+
+#define SD_BALANCE_NEWIDLE	1	/* Balance when about to become idle */
+#define SD_BALANCE_EXEC		2	/* Balance on exec */
+#define SD_WAKE_IDLE		4	/* Wake to idle CPU on task wakeup */
+#define SD_WAKE_AFFINE		8	/* Wake task to waking CPU */
+#define SD_WAKE_BALANCE		16	/* Perform balancing at task wakeup */
+#define SD_SHARE_CPUPOWER	32	/* Domain members share cpu power */
+
+struct sched_group {
+	struct sched_group *next;	/* Must be a circular list */
+	cpumask_t cpumask;
+
+	/*
+	 * CPU power of this group, SCHED_LOAD_SCALE being max power for a
+	 * single CPU. This should be read only (except for setup). Although
+	 * it will need to be written to at cpu hot(un)plug time, perhaps the
+	 * cpucontrol semaphore will provide enough exclusion?
+	 */
+	unsigned long cpu_power;
+};
+
+#ifdef CONFIG_SCHED_SMT
+#define ARCH_HAS_SCHED_WAKE_IDLE
+/* Common values for SMT siblings */
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
+	.flags			= SD_BALANCE_NEWIDLE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_AFFINE	\
+				| SD_WAKE_IDLE		\
+				| SD_SHARE_CPUPOWER,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+#endif
+
+/* 
+   Initialization for dual core CPUs. 
+
+   Values not very well tested yet. Currently they are a mix between
+   the SMT siblings and a normal SMP CPU. Assumes dual core has a very
+   fast interconnect, but no shared cache. The values are a bit less
+   than for SMP ensure different sockets are used before using other
+   cores. This tries to maximize performance, for power saving a
+   different strategy may be better.
+ */
+
+#define SD_DUALCORE_INIT (struct sched_domain) {	\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 4,			\
+	.max_interval		= 16,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 115,			\
+	.cache_hot_time		= 1000000,		\
+	.cache_nice_tries	= 0,			\
+	.per_cpu_gain		= 95,			\
+	.flags			= SD_BALANCE_NEWIDLE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_AFFINE	\
+				| SD_WAKE_IDLE,		\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+
+#ifndef REAL_SD_SIBLING_INIT
+#define REAL_SD_SIBLING_INIT SD_SIBLING_INIT
+#endif
+
+/* Common values for CPUs */
+#define SD_CPU_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 1,			\
+	.max_interval		= 4,			\
+	.busy_factor		= 64,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (5*1000000/2),	\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_BALANCE_NEWIDLE	\
+				| SD_BALANCE_EXEC	\
+				| SD_WAKE_AFFINE	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+#endif
+
+/* Arch can override this macro in processor.h */
+#if defined(CONFIG_NUMA) && !defined(SD_NODE_INIT)
+#define SD_NODE_INIT (struct sched_domain) {		\
+	.span			= CPU_MASK_NONE,	\
+	.parent			= NULL,			\
+	.groups			= NULL,			\
+	.min_interval		= 8,			\
+	.max_interval		= 32,			\
+	.busy_factor		= 32,			\
+	.imbalance_pct		= 125,			\
+	.cache_hot_time		= (10*1000000),		\
+	.cache_nice_tries	= 1,			\
+	.per_cpu_gain		= 100,			\
+	.flags			= SD_BALANCE_EXEC	\
+				| SD_WAKE_BALANCE,	\
+	.last_balance		= jiffies,		\
+	.balance_interval	= 1,			\
+	.nr_balance_failed	= 0,			\
+}
+#endif
+
+#endif


