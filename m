Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbUDHX1p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbUDHX1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:27:45 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:993 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261753AbUDHX1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:27:20 -0400
Subject: 2.6.5-rc3-mm4 x86_64 sched domains patch
From: Darren Hart <dvhltc@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: piggin@cyberone.com.au, ak@suse.de, Martin J Bligh <mjbligh@us.ibm.com>,
       Rick Lindsley <ricklind@us.ibm.com>, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1081466480.10774.0.camel@farah>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Apr 2004 16:22:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current default implementations of arch_init_sched_domains
constructs either a flat or two level topolology.  The two level
topology is built if CONFIG_NUMA is set.  It seems that CONFIG_NUMA is
not the appropriate flag to use for constructing a two level topology
since some architectures which define CONFIG_NUMA would be better served
with a flat topology.  x86_64 for example will construct a two level
topology with one CPU per node, causing performance problems because
balancing within nodes is pointless and balancing across nodes doesn't
occur as often.

This patch introduces a new CONFIG_SCHED_NUMA flag and uses it to decide
between a flat or two level topology of sched_domains.  The patch is
minimally invasive as it primarily modifies Kconfig files and sets the
appropriate default (off for x86_64, on for everything that used to
export CONFIG_NUMA) and should only change the sched_domains topology
constructed on x86_64 systems.  I have verified this on a 4 node x86
NUMAQ, but need someone to test x86_64.

This patch is intended as a quick fix for the x86_64 problem, and
doesn't solve the problem of how to build generic sched domain
topologies.  We can certainly conceive of various topologies for x86
systems, so even arch specific topologies may not be sufficient.  Would
sub-arch (ie NUMAQ) be the right way to handle different topologies, or
will we be able to autodiscover the appropriate topology?  I will be
looking into this more, but thought some might benefit from an immediate
x86_64 fix.  I am very interested in hearing your ideas on this.

Regards,

Darren Hart


diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-rc3-mm4/arch/alpha/Kconfig linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/alpha/Kconfig
--- linux-2.6.5-rc3-mm4/arch/alpha/Kconfig	2004-04-02 06:42:46.000000000 -0800
+++ linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/alpha/Kconfig	2004-04-02 16:16:58.000000000 -0800
@@ -519,6 +519,14 @@ config NUMA
 	  Access).  This option is for configuring high-end multiprocessor
 	  server machines.  If in doubt, say N.
 
+config SCHED_NUMA
+       bool "Two level sched domains"
+       depends on NUMA
+       default y
+       help
+         Enable two level sched domains hierarchy.
+         Say Y if unsure.
+
 # LARGE_VMALLOC is racy, if you *really* need it then fix it first
 config ALPHA_LARGE_VMALLOC
 	bool
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-rc3-mm4/arch/i386/Kconfig linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/i386/Kconfig
--- linux-2.6.5-rc3-mm4/arch/i386/Kconfig	2004-04-02 06:42:52.000000000 -0800
+++ linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/i386/Kconfig	2004-04-07 11:57:41.000000000 -0700
@@ -772,6 +772,14 @@ config NUMA
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
 
+config SCHED_NUMA
+       bool "Two level sched domains"
+       depends on NUMA
+       default y
+       help
+         Enable two level sched domains hierarchy.
+         Say Y if unsure.
+
 # Need comments to help the hapless user trying to turn on NUMA support
 comment "NUMA (NUMA-Q) requires SMP, 64GB highmem support"
 	depends on X86_NUMAQ && (!HIGHMEM64G || !SMP)
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-rc3-mm4/arch/ia64/Kconfig linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/ia64/Kconfig
--- linux-2.6.5-rc3-mm4/arch/ia64/Kconfig	2004-04-02 06:42:52.000000000 -0800
+++ linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/ia64/Kconfig	2004-04-02 16:16:57.000000000 -0800
@@ -172,6 +172,14 @@ config NUMA
 	  Access).  This option is for configuring high-end multiprocessor
 	  server systems.  If in doubt, say N.
 
+config SCHED_NUMA
+       bool "Two level sched domains"
+       depends on NUMA
+       default y
+       help
+         Enable two level sched domains hierarchy.
+         Say Y if unsure.
+
 config VIRTUAL_MEM_MAP
 	bool "Virtual mem map"
 	default y if !IA64_HP_SIM
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-rc3-mm4/arch/mips/Kconfig linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/mips/Kconfig
--- linux-2.6.5-rc3-mm4/arch/mips/Kconfig	2004-04-02 06:42:46.000000000 -0800
+++ linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/mips/Kconfig	2004-04-02 16:16:58.000000000 -0800
@@ -337,6 +337,14 @@ config NUMA
 	  Access).  This option is for configuring high-end multiprocessor
 	  server machines.  If in doubt, say N.
 
+config SCHED_NUMA
+       bool "Two level sched domains"
+       depends on NUMA
+       default y
+       help
+         Enable two level sched domains hierarchy.
+         Say Y if unsure.
+
 config MAPPED_KERNEL
 	bool "Mapped kernel support"
 	depends on SGI_IP27
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-rc3-mm4/arch/ppc64/Kconfig linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/ppc64/Kconfig
--- linux-2.6.5-rc3-mm4/arch/ppc64/Kconfig	2004-04-02 06:42:52.000000000 -0800
+++ linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/ppc64/Kconfig	2004-04-02 16:16:59.000000000 -0800
@@ -173,6 +173,14 @@ config NUMA
 	bool "NUMA support"
 	depends on DISCONTIGMEM
 
+config SCHED_NUMA
+       bool "Two level sched domains"
+       depends on NUMA
+       default y
+       help
+         Enable two level sched domains hierarchy.
+         Say Y if unsure.
+
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
 	depends on SMP
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-rc3-mm4/arch/x86_64/Kconfig linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/x86_64/Kconfig
--- linux-2.6.5-rc3-mm4/arch/x86_64/Kconfig	2004-04-02 06:42:52.000000000 -0800
+++ linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/arch/x86_64/Kconfig	2004-04-02 16:17:00.000000000 -0800
@@ -261,6 +261,14 @@ config NUMA
        depends on K8_NUMA
        default y
 
+config SCHED_NUMA
+       bool "Two level sched domains"
+       depends on NUMA
+       default n
+       help
+         Enable two level sched domains hierarchy.
+         Say N if unsure.
+
 config HAVE_DEC_LOCK
 	bool
 	depends on SMP
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-rc3-mm4/include/linux/sched.h linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/include/linux/sched.h
--- linux-2.6.5-rc3-mm4/include/linux/sched.h	2004-04-02 06:42:53.000000000 -0800
+++ linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/include/linux/sched.h	2004-04-02 16:17:01.000000000 -0800
@@ -623,7 +623,7 @@ struct sched_domain {
 	.nr_balance_failed	= 0,			\
 }
 
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_SCHED_NUMA
 /* Common values for NUMA nodes */
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
@@ -656,7 +656,7 @@ static inline int set_cpus_allowed(task_
 
 extern unsigned long long sched_clock(void);
 
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_SCHED_NUMA
 extern void sched_balance_exec(void);
 #else
 #define sched_balance_exec()   {}
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-rc3-mm4/kernel/sched.c linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/kernel/sched.c
--- linux-2.6.5-rc3-mm4/kernel/sched.c	2004-04-02 06:42:53.000000000 -0800
+++ linux-2.6.5-rc3-mm4-x86_64_arch_sched_domain/kernel/sched.c	2004-04-07 11:50:11.000000000 -0700
@@ -42,7 +42,7 @@
 #include <linux/percpu.h>
 #include <linux/kthread.h>
 
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_SCHED_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
 #else
 #define cpu_to_node_mask(cpu) (cpu_online_map)
@@ -1142,7 +1142,7 @@ enum idle_type
 };
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_SCHED_NUMA
 /*
  * If dest_cpu is allowed for this process, migrate the task to it.
  * This is accomplished by forcing the cpu_allowed mask to only
@@ -1241,7 +1241,7 @@ void sched_balance_exec(void)
 out:
 	put_cpu();
 }
-#endif /* CONFIG_NUMA */
+#endif /* CONFIG_SCHED_NUMA */
 
 /*
  * double_lock_balance - lock the busiest runqueue, this_rq is locked already.
@@ -3461,7 +3461,7 @@ extern void __init arch_init_sched_domai
 #else
 static struct sched_group sched_group_cpus[NR_CPUS];
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_SCHED_NUMA
 static struct sched_group sched_group_nodes[MAX_NUMNODES];
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
 static void __init arch_init_sched_domains(void)
@@ -3532,7 +3532,7 @@ static void __init arch_init_sched_domai
 	}
 }
 
-#else /* !CONFIG_NUMA */
+#else /* !CONFIG_SCHED_NUMA */
 static void __init arch_init_sched_domains(void)
 {
 	int i;
@@ -3570,7 +3570,7 @@ static void __init arch_init_sched_domai
 	}
 }
 
-#endif /* CONFIG_NUMA */
+#endif /* CONFIG_SCHED_NUMA */
 #endif /* ARCH_HAS_SCHED_DOMAIN */
 
 #define SCHED_DOMAIN_DEBUG

