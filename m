Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbUDNRY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUDNRY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:24:58 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:48007 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263354AbUDNRYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:24:43 -0400
Subject: Re: 2.6.5-rc3-mm4 x86_64 sched domains patch
From: Darren Hart <dvhltc@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, piggin@cyberone.com.au,
       Martin J Bligh <mjbligh@us.ibm.com>,
       Rick Lindsley <ricklind@us.ibm.com>, akpm@osdl.org
In-Reply-To: <20040414154456.78893f3f.ak@suse.de>
References: <1081466480.10774.0.camel@farah>
	 <20040414154456.78893f3f.ak@suse.de>
Content-Type: text/plain
Message-Id: <1081963459.2171.11.camel@farah>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Apr 2004 10:24:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 06:44, Andi Kleen wrote:
> On Thu, 08 Apr 2004 16:22:09 -0700
> Darren Hart <dvhltc@us.ibm.com> wrote:
> > This patch is intended as a quick fix for the x86_64 problem, and
> 
> Ingo's latest tweaks seemed to already cure STREAM, but some more
> tuning is probably a good idea agreed.
> ...
> The patch doesn't apply against 2.6.5-mm5 anymore. Can you generate a new patch? 
> I will test it then.

Find below the patch updated for akpm's 2.6.5-mm5-1.bz2 patch.  As with
the previous patch I verified it works properly on a 4 node, 16 CPU
NUMA-Q.  Please test both CONFIG_SCHED_NUMA=n (the improved case,
default) and CONFIG_SCHED_NUMA=y (pre-patch equivalent) on x86_64, and
thanks!

> 
> Also it will need merging with the patch that adds SMT support for IA32e machines
> on x86-64.

Where is this patch?

-- Darren





diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-mm5/arch/alpha/Kconfig linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/alpha/Kconfig
--- linux-2.6.5-mm5/arch/alpha/Kconfig	2004-04-03 19:37:40.000000000 -0800
+++ linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/alpha/Kconfig	2004-04-14 09:39:40.000000000 -0700
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
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-mm5/arch/i386/Kconfig linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/i386/Kconfig
--- linux-2.6.5-mm5/arch/i386/Kconfig	2004-04-14 09:37:40.000000000 -0700
+++ linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/i386/Kconfig	2004-04-14 09:39:40.000000000 -0700
@@ -724,6 +724,14 @@ config NUMA
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
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-mm5/arch/ia64/Kconfig linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/ia64/Kconfig
--- linux-2.6.5-mm5/arch/ia64/Kconfig	2004-04-14 09:37:41.000000000 -0700
+++ linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/ia64/Kconfig	2004-04-14 09:39:40.000000000 -0700
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
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-mm5/arch/mips/Kconfig linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/mips/Kconfig
--- linux-2.6.5-mm5/arch/mips/Kconfig	2004-04-03 19:37:06.000000000 -0800
+++ linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/mips/Kconfig	2004-04-14 09:39:40.000000000 -0700
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
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-mm5/arch/ppc64/Kconfig linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/ppc64/Kconfig
--- linux-2.6.5-mm5/arch/ppc64/Kconfig	2004-04-14 09:37:43.000000000 -0700
+++ linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/ppc64/Kconfig	2004-04-14 09:39:40.000000000 -0700
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
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-mm5/arch/x86_64/Kconfig linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/x86_64/Kconfig
--- linux-2.6.5-mm5/arch/x86_64/Kconfig	2004-04-14 09:37:46.000000000 -0700
+++ linux-2.6.5-mm5-x86_64_arch_sched_domain/arch/x86_64/Kconfig	2004-04-14 09:39:40.000000000 -0700
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
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-mm5/include/linux/sched.h linux-2.6.5-mm5-x86_64_arch_sched_domain/include/linux/sched.h
--- linux-2.6.5-mm5/include/linux/sched.h	2004-04-14 09:38:08.000000000 -0700
+++ linux-2.6.5-mm5-x86_64_arch_sched_domain/include/linux/sched.h	2004-04-14 09:41:35.000000000 -0700
@@ -670,7 +670,7 @@ struct sched_domain {
 	.nr_balance_failed	= 0,			\
 }
 
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_SCHED_NUMA
 /* Common values for NUMA nodes */
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
diff -aurpN -X /home/dvhart/.diff.exclude linux-2.6.5-mm5/kernel/sched.c linux-2.6.5-mm5-x86_64_arch_sched_domain/kernel/sched.c
--- linux-2.6.5-mm5/kernel/sched.c	2004-04-14 09:38:09.000000000 -0700
+++ linux-2.6.5-mm5-x86_64_arch_sched_domain/kernel/sched.c	2004-04-14 09:45:34.000000000 -0700
@@ -45,7 +45,7 @@
 #include <linux/seq_file.h>
 #include <linux/times.h>
 
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_SCHED_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
 #else
 #define cpu_to_node_mask(cpu) (cpu_online_map)
@@ -3735,7 +3735,7 @@ extern void __init arch_init_sched_domai
 #else
 static struct sched_group sched_group_cpus[NR_CPUS];
 static DEFINE_PER_CPU(struct sched_domain, cpu_domains);
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_SCHED_NUMA
 static struct sched_group sched_group_nodes[MAX_NUMNODES];
 static DEFINE_PER_CPU(struct sched_domain, node_domains);
 static void __init arch_init_sched_domains(void)
@@ -3806,7 +3806,7 @@ static void __init arch_init_sched_domai
 	}
 }
 
-#else /* !CONFIG_NUMA */
+#else /* !CONFIG_SCHED_NUMA */
 static void __init arch_init_sched_domains(void)
 {
 	int i;
@@ -3845,7 +3845,7 @@ static void __init arch_init_sched_domai
 	}
 }
 
-#endif /* CONFIG_NUMA */
+#endif /* CONFIG_SCHED_NUMA */
 #endif /* ARCH_HAS_SCHED_DOMAIN */
 
 #define SCHED_DOMAIN_DEBUG


