Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932782AbWE0B43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782AbWE0B43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 21:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWE0B43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 21:56:29 -0400
Received: from smtp-out.google.com ([216.239.45.12]:40614 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751750AbWE0B42 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 21:56:28 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=tOAnMyg0THijUDeekrJ8oEi9zPX8UDP2z6U7plS0/FLUtV1d+rAgjmXCBJ3eK1OLB
	+/Cfi2eSzjHiMphksr3qQ==
Subject: [PATCH] i386: moving phys_proc_id and cpu_core_id to cpuinfo_x86
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 26 May 2006 18:55:38 -0700
Message-Id: <1148694938.5384.4.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Moving the phys_core_id and cpu_core_id to cpuinfo_x86 structure.
Similar patch for x86_64 is already accepted by Andi earlier this week.

-rohit

Signed-off-by: Rohit Seth <rohitseth@google.com>

 arch/i386/kernel/cpu/amd.c                    |    6 +++---
 arch/i386/kernel/cpu/common.c                 |   10 +++++-----
 arch/i386/kernel/cpu/proc.c                   |    4 ++--
 arch/i386/kernel/smpboot.c                    |   16 +++++-----------
 include/asm-i386/processor.h 		       |    8 +++++---
 include/asm-i386/topology.h                   |    6 ++----
 6 files changed, 22 insertions(+), 28 deletions(-)



diff -Naru linux-2.6.17-rc4.org/include/asm-i386/processor.h linux-2.6.17-rc4/include/asm-i386/processor.h
--- linux-2.6.17-rc4.org/include/asm-i386/processor.h	2006-05-22 16:22:51.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-i386/processor.h	2006-05-26 18:42:15.000000000 -0700
@@ -72,8 +72,12 @@
 	cpumask_t llc_shared_map;	/* cpus sharing the last level cache */
 #endif
 	unsigned char x86_max_cores;	/* cpuid returned max cores value */
-	unsigned char booted_cores;	/* number of cores as seen by OS */
 	unsigned char apicid;
+#ifdef CONFIG_SMP
+	unsigned char booted_cores;	/* number of cores as seen by OS */
+	__u8 phys_proc_id; 		/* Physical processor id. */
+	__u8 cpu_core_id;  		/* Core id */
+#endif
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define X86_VENDOR_INTEL 0
@@ -105,8 +109,6 @@
 #define current_cpu_data boot_cpu_data
 #endif
 
-extern	int phys_proc_id[NR_CPUS];
-extern	int cpu_core_id[NR_CPUS];
 extern	int cpu_llc_id[NR_CPUS];
 extern char ignore_fpu_irq;
 
diff -Naru linux-2.6.17-rc4.org/include/asm-i386/topology.h linux-2.6.17-rc4/include/asm-i386/topology.h
--- linux-2.6.17-rc4.org/include/asm-i386/topology.h	2006-05-22 16:22:51.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-i386/topology.h	2006-05-26 18:24:57.000000000 -0700
@@ -28,10 +28,8 @@
 #define _ASM_I386_TOPOLOGY_H
 
 #ifdef CONFIG_X86_HT
-#define topology_physical_package_id(cpu)				\
-	(phys_proc_id[cpu] == BAD_APICID ? -1 : phys_proc_id[cpu])
-#define topology_core_id(cpu)						\
-	(cpu_core_id[cpu] == BAD_APICID ? 0 : cpu_core_id[cpu])
+#define topology_physical_package_id(cpu)	(cpu_data[cpu].phys_proc_id)
+#define topology_core_id(cpu)			(cpu_data[cpu].cpu_core_id)
 #define topology_core_siblings(cpu)		(cpu_core_map[cpu])
 #define topology_thread_siblings(cpu)		(cpu_sibling_map[cpu])
 #endif
--- linux-2.6.17-rc4.org/arch/i386/kernel/smpboot.c	2006-05-22 16:22:50.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/smpboot.c	2006-05-26 18:32:17.000000000 -0700
@@ -66,12 +66,6 @@
 EXPORT_SYMBOL(smp_num_siblings);
 #endif
 
-/* Package ID of each logical CPU */
-int phys_proc_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
-
-/* Core ID of each logical CPU */
-int cpu_core_id[NR_CPUS] __read_mostly = {[0 ... NR_CPUS-1] = BAD_APICID};
-
 /* Last level cache ID of each logical CPU */
 int cpu_llc_id[NR_CPUS] __cpuinitdata = {[0 ... NR_CPUS-1] = BAD_APICID};
 
@@ -470,8 +464,8 @@
 
 	if (smp_num_siblings > 1) {
 		for_each_cpu_mask(i, cpu_sibling_setup_map) {
-			if (phys_proc_id[cpu] == phys_proc_id[i] &&
-			    cpu_core_id[cpu] == cpu_core_id[i]) {
+			if (c[cpu].phys_proc_id == c[i].phys_proc_id &&
+			    c[cpu].cpu_core_id == c[i].cpu_core_id) {
 				cpu_set(i, cpu_sibling_map[cpu]);
 				cpu_set(cpu, cpu_sibling_map[i]);
 				cpu_set(i, cpu_core_map[cpu]);
@@ -498,7 +492,7 @@
 			cpu_set(i, c[cpu].llc_shared_map);
 			cpu_set(cpu, c[i].llc_shared_map);
 		}
-		if (phys_proc_id[cpu] == phys_proc_id[i]) {
+		if (c[cpu].phys_proc_id == c[i].phys_proc_id) {
 			cpu_set(i, cpu_core_map[cpu]);
 			cpu_set(cpu, cpu_core_map[i]);
 			/*
@@ -1337,8 +1331,8 @@
 		cpu_clear(cpu, cpu_sibling_map[sibling]);
 	cpus_clear(cpu_sibling_map[cpu]);
 	cpus_clear(cpu_core_map[cpu]);
-	phys_proc_id[cpu] = BAD_APICID;
-	cpu_core_id[cpu] = BAD_APICID;
+	c[cpu].phys_proc_id = 0;
+	c[cpu].cpu_core_id = 0;
 	cpu_clear(cpu, cpu_sibling_setup_map);
 }
 
--- linux-2.6.17-rc4.org/arch/i386/kernel/cpu/proc.c	2006-05-22 16:22:50.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/cpu/proc.c	2006-05-26 18:21:18.000000000 -0700
@@ -109,9 +109,9 @@
 		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);
 #ifdef CONFIG_X86_HT
 	if (c->x86_max_cores * smp_num_siblings > 1) {
-		seq_printf(m, "physical id\t: %d\n", phys_proc_id[n]);
+		seq_printf(m, "physical id\t: %d\n", c->phys_proc_id);
 		seq_printf(m, "siblings\t: %d\n", cpus_weight(cpu_core_map[n]));
-		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[n]);
+		seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
 		seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	}
 #endif
--- linux-2.6.17-rc4.org/arch/i386/kernel/cpu/common.c	2006-05-22 16:22:50.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/cpu/common.c	2006-05-26 18:31:56.000000000 -0700
@@ -317,7 +317,7 @@
 	early_intel_workaround(c);
 
 #ifdef CONFIG_X86_HT
-	phys_proc_id[smp_processor_id()] = (cpuid_ebx(1) >> 24) & 0xff;
+	c->phys_proc_id = (cpuid_ebx(1) >> 24) & 0xff;
 #endif
 }
 
@@ -496,10 +496,10 @@
 		}
 
 		index_msb = get_count_order(smp_num_siblings);
-		phys_proc_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
+		c->phys_proc_id = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);
 
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
-		       phys_proc_id[cpu]);
+		       c->phys_proc_id);
 
 		smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
@@ -507,12 +507,12 @@
 
 		core_bits = get_count_order(c->x86_max_cores);
 
-		cpu_core_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb) &
+		c->cpu_core_id = phys_pkg_id((ebx >> 24) & 0xFF, index_msb) &
 					       ((1 << core_bits) - 1);
 
 		if (c->x86_max_cores > 1)
 			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
-			       cpu_core_id[cpu]);
+			       c->cpu_core_id);
 	}
 }
 #endif
--- linux-2.6.17-rc4.org/arch/i386/kernel/cpu/amd.c	2006-05-22 16:22:50.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/cpu/amd.c	2006-05-26 18:22:11.000000000 -0700
@@ -233,10 +233,10 @@
 		unsigned bits = 0;
 		while ((1 << bits) < c->x86_max_cores)
 			bits++;
-		cpu_core_id[cpu] = phys_proc_id[cpu] & ((1<<bits)-1);
-		phys_proc_id[cpu] >>= bits;
+		c->cpu_core_id = c->phys_proc_id & ((1<<bits)-1);
+		c->phys_proc_id >>= bits;
 		printk(KERN_INFO "CPU %d(%d) -> Core %d\n",
-		       cpu, c->x86_max_cores, cpu_core_id[cpu]);
+		       cpu, c->x86_max_cores, c->cpu_core_id);
 	}
 #endif
 


