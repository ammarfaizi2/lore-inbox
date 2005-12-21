Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbVLUBhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVLUBhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbVLUBhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:37:46 -0500
Received: from fmr21.intel.com ([143.183.121.13]:31653 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932235AbVLUBhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:37:45 -0500
Date: Tue, 20 Dec 2005 17:37:41 -0800
From: Yanmin Zhang <ymzhang@unix-os.sc.intel.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org
Cc: yanmin.zhang@intel.com, suresh.b.siddha@intel.com, rajesh.shah@intel.com,
       venkatesh.pallipadi@intel.com
Subject: [PATCH v2:1/3]Export cpu topology by sysfs
Message-ID: <20051220173741.A18484@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

The patches export the cpu topology info through sysfs.
Based on the opinions of Nathan, Andi, Paul and Venki, I revised the patches.
I really appreciate their good comments.

1) The main exportation logic is implemented arch-independently. The specific
architectures just need to provides 5 defines; My thread patch provides the
defines for i386, x86_64, and ia64. Other architectures need provide their own
defines.
2) Add a new document;
3) Current i386 and x86_64 architectures don't save thread_id and don't show
thread_id in /proc/cpuinfo. my patches fix it.

The first patch against kernel 2.6.15-rc5 is to save thread_id and show it
in /proc/cpuinfo for i386 architecture.

Signed-off-by: Zhang, Yanmin <yanmin.zhang@intel.com>

#diffstat collect_thread_id_2.6.15-rc5_i386.patch
 arch/i386/kernel/cpu/common.c |   10 +++++++++-
 arch/i386/kernel/cpu/proc.c   |    2 ++
 arch/i386/kernel/smpboot.c    |    3 +++
 include/asm-i386/processor.h  |    1 +
 4 files changed, 15 insertions, 1 deletion

---

diff -Nraup linux-2.6.15-rc5/arch/i386/kernel/cpu/common.c linux-2.6.15-rc5_thread_id_i386/arch/i386/kernel/cpu/common.c
--- linux-2.6.15-rc5/arch/i386/kernel/cpu/common.c	2005-12-13 23:07:34.000000000 +0800
+++ linux-2.6.15-rc5_thread_id_i386/arch/i386/kernel/cpu/common.c	2005-12-16 12:32:48.000000000 +0800
@@ -443,7 +443,7 @@ void __devinit identify_cpu(struct cpuin
 void __devinit detect_ht(struct cpuinfo_x86 *c)
 {
 	u32 	eax, ebx, ecx, edx;
-	int 	index_msb, core_bits;
+	int 	index_msb, core_bits, thread_bits;
 	int 	cpu = smp_processor_id();
 
 	cpuid(1, &eax, &ebx, &ecx, &edx);
@@ -483,6 +483,14 @@ void __devinit detect_ht(struct cpuinfo_
 		if (c->x86_max_cores > 1)
 			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
 			       cpu_core_id[cpu]);
+
+		thread_bits = index_msb;
+		cpu_thread_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, 0) &
+						((1 << thread_bits) - 1);
+
+		if (smp_num_siblings > 1)
+			printk(KERN_INFO  "CPU: Processor Thread ID: %d\n",
+				cpu_thread_id[cpu]);
 	}
 }
 #endif
diff -Nraup linux-2.6.15-rc5/arch/i386/kernel/cpu/proc.c linux-2.6.15-rc5_thread_id_i386/arch/i386/kernel/cpu/proc.c
--- linux-2.6.15-rc5/arch/i386/kernel/cpu/proc.c	2005-12-13 23:07:34.000000000 +0800
+++ linux-2.6.15-rc5_thread_id_i386/arch/i386/kernel/cpu/proc.c	2005-12-16 11:56:17.000000000 +0800
@@ -100,6 +100,8 @@ static int show_cpuinfo(struct seq_file 
 		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[n]);
 		seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	}
+	if (smp_num_siblings > 1)
+		seq_printf(m, "thread id\t: %d\n", cpu_thread_id[n]);
 #endif
 	
 	/* We use exception 16 if we have hardware math and we've either seen it or the CPU claims it is internal */
diff -Nraup linux-2.6.15-rc5/arch/i386/kernel/smpboot.c linux-2.6.15-rc5_thread_id_i386/arch/i386/kernel/smpboot.c
--- linux-2.6.15-rc5/arch/i386/kernel/smpboot.c	2005-12-13 23:07:34.000000000 +0800
+++ linux-2.6.15-rc5_thread_id_i386/arch/i386/kernel/smpboot.c	2005-12-16 11:00:28.000000000 +0800
@@ -72,6 +72,9 @@ int phys_proc_id[NR_CPUS] __read_mostly 
 /* Core ID of each logical CPU */
 int cpu_core_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
 
+/* Thread ID of each logical CPU */
+int cpu_thread_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
+
 /* representing HT siblings of each logical CPU */
 cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(cpu_sibling_map);
diff -Nraup linux-2.6.15-rc5/include/asm-i386/processor.h linux-2.6.15-rc5_thread_id_i386/include/asm-i386/processor.h
--- linux-2.6.15-rc5/include/asm-i386/processor.h	2005-12-13 23:07:39.000000000 +0800
+++ linux-2.6.15-rc5_thread_id_i386/include/asm-i386/processor.h	2005-12-16 11:02:21.000000000 +0800
@@ -101,6 +101,7 @@ extern struct cpuinfo_x86 cpu_data[];
 
 extern	int phys_proc_id[NR_CPUS];
 extern	int cpu_core_id[NR_CPUS];
+extern	int cpu_thread_id[NR_CPUS];
 extern char ignore_fpu_irq;
 
 extern void identify_cpu(struct cpuinfo_x86 *);
