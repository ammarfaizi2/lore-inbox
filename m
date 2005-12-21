Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVLUBrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVLUBrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLUBrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:47:52 -0500
Received: from fmr23.intel.com ([143.183.121.15]:47519 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932241AbVLUBrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:47:51 -0500
Date: Tue, 20 Dec 2005 17:47:50 -0800
From: Yanmin Zhang <ymzhang@unix-os.sc.intel.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linux-ia64@vger.kernel.org
Cc: yanmin.zhang@intel.com, suresh.b.siddha@intel.com, rajesh.shah@intel.com,
       venkatesh.pallipadi@intel.com
Subject: [PATCH v2:2/3]Export cpu topology by sysfs
Message-ID: <20051220174750.A19129@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang, Yanmin <yanmin.zhang@intel.com>

The second patch against kernel 2.6.15-rc5 is to save thread_id and show it
in /proc/cpuinfo for x86_64 architecture.

Signed-off-by: Zhang, Yanmin <yanmin.zhang@intel.com>

#diffstat collect_thread_id_2.6.15-rc5_x86_64.patch
 arch/x86_64/kernel/setup.c   |   13 ++++++++++++-
 arch/x86_64/kernel/smpboot.c |    2 ++
 include/asm-x86_64/smp.h     |    1 +
 3 files changed, 15 insertions, 1 deletion

---

diff -Nraup linux-2.6.15-rc5/arch/x86_64/kernel/setup.c linux-2.6.15-rc5_thread_id/arch/x86_64/kernel/setup.c
--- linux-2.6.15-rc5/arch/x86_64/kernel/setup.c	2005-12-13 23:07:35.000000000 +0800
+++ linux-2.6.15-rc5_thread_id/arch/x86_64/kernel/setup.c	2005-12-16 11:55:05.000000000 +0800
@@ -888,7 +888,7 @@ static void __cpuinit detect_ht(struct c
 {
 #ifdef CONFIG_SMP
 	u32 	eax, ebx, ecx, edx;
-	int 	index_msb, core_bits;
+	int 	index_msb, core_bits, thread_bits;
 	int 	cpu = smp_processor_id();
 
 	cpuid(1, &eax, &ebx, &ecx, &edx);
@@ -928,6 +928,13 @@ static void __cpuinit detect_ht(struct c
 		if (c->x86_max_cores > 1)
 			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
 			       cpu_core_id[cpu]);
+
+		thread_bits = index_msb;
+		cpu_thread_id[cpu] = phys_pkg_id(0) & ((1 << thread_bits) - 1);
+
+		if (smp_num_siblings > 1)
+			printk(KERN_INFO  "CPU: Processor Thread ID: %d\n",
+			       cpu_thread_id[cpu]);
 	}
 #endif
 }
@@ -1272,6 +1279,10 @@ static int show_cpuinfo(struct seq_file 
 		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[cpu]);
 		seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	}
+	if (smp_num_siblings > 1) {
+		int cpu = c - cpu_data;
+		seq_printf(m, "thread id\t: %d\n", cpu_thread_id[cpu]);
+	}
 #endif	
 
 	seq_printf(m,
diff -Nraup linux-2.6.15-rc5/arch/x86_64/kernel/smpboot.c linux-2.6.15-rc5_thread_id/arch/x86_64/kernel/smpboot.c
--- linux-2.6.15-rc5/arch/x86_64/kernel/smpboot.c	2005-12-13 23:07:35.000000000 +0800
+++ linux-2.6.15-rc5_thread_id/arch/x86_64/kernel/smpboot.c	2005-12-16 10:29:09.000000000 +0800
@@ -66,6 +66,8 @@ int smp_num_siblings = 1;
 u8 phys_proc_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
 /* core ID of each logical CPU */
 u8 cpu_core_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
+/* thread ID of each logical CPU */
+u8 cpu_thread_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map __read_mostly;
diff -Nraup linux-2.6.15-rc5/include/asm-x86_64/smp.h linux-2.6.15-rc5_thread_id/include/asm-x86_64/smp.h
--- linux-2.6.15-rc5/include/asm-x86_64/smp.h	2005-12-13 23:07:39.000000000 +0800
+++ linux-2.6.15-rc5_thread_id/include/asm-x86_64/smp.h	2005-12-16 10:30:02.000000000 +0800
@@ -55,6 +55,7 @@ extern cpumask_t cpu_sibling_map[NR_CPUS
 extern cpumask_t cpu_core_map[NR_CPUS];
 extern u8 phys_proc_id[NR_CPUS];
 extern u8 cpu_core_id[NR_CPUS];
+extern u8 cpu_thread_id[NR_CPUS];
 
 #define SMP_TRAMPOLINE_BASE 0x6000
 
