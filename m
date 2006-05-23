Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWEWWod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWEWWod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWEWWod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:44:33 -0400
Received: from smtp-out.google.com ([216.239.45.12]:12824 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932259AbWEWWod
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:44:33 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=NJG53OA17erXiRXq78oG85ZNBQdKjYwnSuxqfphgCS0Qx7ldPW2rvjaf5Jxb8qmf3
	8yh+uaV4cl/RBytRB56GA==
Subject: [PATCH]x86_64: moving phys_proc_id and cpu_core_id to cpuinfo_x86
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Google Inc
Date: Tue, 23 May 2006 15:43:46 -0700
Message-Id: <1148424226.5959.18.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Most of the fields of cpuinfo are defined in cpuinfo_x86 structure.
This patch moves the phys_proc_id and cpu_core_id for each processor to
cpuinfo_x86 structure as well.

-rohit


Signed-off-by: Rohit Seth <rohitseth@google.com>


 arch/x86_64/kernel/mce_amd.c                    |   10 ++++-----
 arch/x86_64/kernel/setup.c                      |   25 +++++++++++-------------
 arch/x86_64/kernel/smpboot.c                    |   14 ++++---------
 include/asm-x86_64/processor.h 		 |    4 +++
 include/asm-x86_64/smp.h       		 |    2 -
 include/asm-x86_64/topology.h 			 |    6 +----
 6 files changed, 28 insertions(+), 33 deletions(-)



diff -Naru linux-2.6.17-rc4.org/include/asm-x86_64/processor.h linux-2.6.17-rc4/include/asm-x86_64/processor.h
--- linux-2.6.17-rc4.org/include/asm-x86_64/processor.h	2006-05-22 16:22:51.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-x86_64/processor.h	2006-05-22 16:31:27.000000000 -0700
@@ -70,7 +70,11 @@
 	cpumask_t llc_shared_map;	/* cpus sharing the last level cache */
 #endif
 	__u8	apicid;
+#ifdef CONFIG_SMP
 	__u8	booted_cores;	/* number of cores as seen by OS */
+	__u8	phys_proc_id;	/* Physical Processor id. */
+	__u8	cpu_core_id;	/* Core id. */
+#endif
 } ____cacheline_aligned;
 
 #define X86_VENDOR_INTEL 0
diff -Naru linux-2.6.17-rc4.org/include/asm-x86_64/smp.h linux-2.6.17-rc4/include/asm-x86_64/smp.h
--- linux-2.6.17-rc4.org/include/asm-x86_64/smp.h	2006-05-22 16:22:51.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-x86_64/smp.h	2006-05-22 16:16:52.000000000 -0700
@@ -54,8 +54,6 @@
 
 extern cpumask_t cpu_sibling_map[NR_CPUS];
 extern cpumask_t cpu_core_map[NR_CPUS];
-extern u8 phys_proc_id[NR_CPUS];
-extern u8 cpu_core_id[NR_CPUS];
 extern u8 cpu_llc_id[NR_CPUS];
 
 #define SMP_TRAMPOLINE_BASE 0x6000
diff -Naru linux-2.6.17-rc4.org/include/asm-x86_64/topology.h linux-2.6.17-rc4/include/asm-x86_64/topology.h
--- linux-2.6.17-rc4.org/include/asm-x86_64/topology.h	2006-05-22 16:22:51.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-x86_64/topology.h	2006-05-23 10:42:34.000000000 -0700
@@ -58,10 +58,8 @@
 #endif
 
 #ifdef CONFIG_SMP
-#define topology_physical_package_id(cpu)				\
-	(phys_proc_id[cpu] == BAD_APICID ? -1 : phys_proc_id[cpu])
-#define topology_core_id(cpu)						\
-	(cpu_core_id[cpu] == BAD_APICID ? 0 : cpu_core_id[cpu])
+#define topology_physical_package_id(cpu)	(cpu_data[cpu].phys_proc_id)
+#define topology_core_id(cpu)			(cpu_data[cpu].cpu_core_id)
 #define topology_core_siblings(cpu)		(cpu_core_map[cpu])
 #define topology_thread_siblings(cpu)		(cpu_sibling_map[cpu])
 #endif
--- linux-2.6.17-rc4.org/arch/x86_64/kernel/smpboot.c	2006-05-22 16:22:50.000000000 -0700
+++ linux-2.6.17-rc4/arch/x86_64/kernel/smpboot.c	2006-05-23 10:39:40.000000000 -0700
@@ -63,10 +63,6 @@
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
-/* Package ID of each logical CPU */
-u8 phys_proc_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
-/* core ID of each logical CPU */
-u8 cpu_core_id[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 /* Last level cache ID of each logical CPU */
 u8 cpu_llc_id[NR_CPUS] __cpuinitdata  = {[0 ... NR_CPUS-1] = BAD_APICID};
@@ -472,8 +468,8 @@
 
 	if (smp_num_siblings > 1) {
 		for_each_cpu_mask(i, cpu_sibling_setup_map) {
-			if (phys_proc_id[cpu] == phys_proc_id[i] &&
-			    cpu_core_id[cpu] == cpu_core_id[i]) {
+			if (c[cpu].phys_proc_id == c[i].phys_proc_id &&
+			    c[cpu].cpu_core_id == c[i].cpu_core_id) {
 				cpu_set(i, cpu_sibling_map[cpu]);
 				cpu_set(cpu, cpu_sibling_map[i]);
 				cpu_set(i, cpu_core_map[cpu]);
@@ -500,7 +496,7 @@
 			cpu_set(i, c[cpu].llc_shared_map);
 			cpu_set(cpu, c[i].llc_shared_map);
 		}
-		if (phys_proc_id[cpu] == phys_proc_id[i]) {
+		if (c[cpu].phys_proc_id == c[i].phys_proc_id) {
 			cpu_set(i, cpu_core_map[cpu]);
 			cpu_set(cpu, cpu_core_map[i]);
 			/*
@@ -1199,8 +1195,8 @@
 		cpu_clear(cpu, cpu_sibling_map[sibling]);
 	cpus_clear(cpu_sibling_map[cpu]);
 	cpus_clear(cpu_core_map[cpu]);
-	phys_proc_id[cpu] = BAD_APICID;
-	cpu_core_id[cpu] = BAD_APICID;
+	c[cpu].phys_proc_id = 0;
+	c[cpu].cpu_core_id = 0;
 	cpu_clear(cpu, cpu_sibling_setup_map);
 }
 
--- linux-2.6.17-rc4.org/arch/x86_64/kernel/setup.c	2006-05-22 16:22:50.000000000 -0700
+++ linux-2.6.17-rc4/arch/x86_64/kernel/setup.c	2006-05-22 16:20:55.000000000 -0700
@@ -879,12 +879,12 @@
 		bits++;
 
 	/* Low order bits define the core id (index of core in socket) */
-	cpu_core_id[cpu] = phys_proc_id[cpu] & ((1 << bits)-1);
+	c->cpu_core_id = c->phys_proc_id & ((1 << bits)-1);
 	/* Convert the APIC ID into the socket ID */
-	phys_proc_id[cpu] = phys_pkg_id(bits);
+	c->phys_proc_id = phys_pkg_id(bits);
 
 #ifdef CONFIG_NUMA
-  	node = phys_proc_id[cpu];
+  	node = c->phys_proc_id;
  	if (apicid_to_node[apicid] != NUMA_NO_NODE)
  		node = apicid_to_node[apicid];
  	if (!node_online(node)) {
@@ -897,7 +897,7 @@
  		   but in the same order as the HT nodeids.
  		   If that doesn't result in a usable node fall back to the
  		   path for the previous case.  */
- 		int ht_nodeid = apicid - (phys_proc_id[0] << bits);
+ 		int ht_nodeid = apicid - (cpu_data[0].phys_proc_id << bits);
  		if (ht_nodeid >= 0 &&
  		    apicid_to_node[ht_nodeid] != NUMA_NO_NODE)
  			node = apicid_to_node[ht_nodeid];
@@ -908,7 +908,7 @@
 	numa_set_node(cpu, node);
 
   	printk(KERN_INFO "CPU %d/%x(%d) -> Node %d -> Core %d\n",
-  			cpu, apicid, c->x86_max_cores, node, cpu_core_id[cpu]);
+  			cpu, apicid, c->x86_max_cores, node, c->cpu_core_id);
 #endif
 #endif
 }
@@ -978,7 +978,6 @@
 #ifdef CONFIG_SMP
 	u32 	eax, ebx, ecx, edx;
 	int 	index_msb, core_bits;
-	int 	cpu = smp_processor_id();
 
 	cpuid(1, &eax, &ebx, &ecx, &edx);
 
@@ -999,10 +998,10 @@
 		}
 
 		index_msb = get_count_order(smp_num_siblings);
-		phys_proc_id[cpu] = phys_pkg_id(index_msb);
+		c->phys_proc_id = phys_pkg_id(index_msb);
 
 		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
-		       phys_proc_id[cpu]);
+		       c->phys_proc_id);
 
 		smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
@@ -1010,12 +1009,12 @@
 
 		core_bits = get_count_order(c->x86_max_cores);
 
-		cpu_core_id[cpu] = phys_pkg_id(index_msb) &
+		c->cpu_core_id = phys_pkg_id(index_msb) &
 					       ((1 << core_bits) - 1);
 
 		if (c->x86_max_cores > 1)
 			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
-			       cpu_core_id[cpu]);
+			       c->cpu_core_id);
 	}
 #endif
 }
@@ -1156,7 +1155,7 @@
 	}
 
 #ifdef CONFIG_SMP
-	phys_proc_id[smp_processor_id()] = (cpuid_ebx(1) >> 24) & 0xff;
+	c->phys_proc_id = (cpuid_ebx(1) >> 24) & 0xff;
 #endif
 }
 
@@ -1364,9 +1363,9 @@
 #ifdef CONFIG_SMP
 	if (smp_num_siblings * c->x86_max_cores > 1) {
 		int cpu = c - cpu_data;
-		seq_printf(m, "physical id\t: %d\n", phys_proc_id[cpu]);
+		seq_printf(m, "physical id\t: %d\n", c->phys_proc_id);
 		seq_printf(m, "siblings\t: %d\n", cpus_weight(cpu_core_map[cpu]));
-		seq_printf(m, "core id\t\t: %d\n", cpu_core_id[cpu]);
+		seq_printf(m, "core id\t\t: %d\n", c->cpu_core_id);
 		seq_printf(m, "cpu cores\t: %d\n", c->booted_cores);
 	}
 #endif	
--- linux-2.6.17-rc4.org/arch/x86_64/kernel/mce_amd.c	2006-05-22 16:22:50.000000000 -0700
+++ linux-2.6.17-rc4/arch/x86_64/kernel/mce_amd.c	2006-05-22 16:19:22.000000000 -0700
@@ -115,7 +115,7 @@
 		per_cpu(bank_map, cpu) |= (1 << bank);
 
 #ifdef CONFIG_SMP
-		if (shared_bank[bank] && cpu_core_id[cpu])
+		if (shared_bank[bank] && c->cpu_core_id)
 			continue;
 #endif
 
@@ -323,10 +323,10 @@
 	struct threshold_bank *b = NULL;
 
 #ifdef CONFIG_SMP
-	if (cpu_core_id[cpu] && shared_bank[bank]) {	/* symlink */
+	if (cpu_data[cpu].cpu_core_id && shared_bank[bank]) {	/* symlink */
 		char name[16];
 		unsigned lcpu = first_cpu(cpu_core_map[cpu]);
-		if (cpu_core_id[lcpu])
+		if (cpu_data[lcpu].cpu_core_id)
 			goto out;	/* first core not up yet */
 
 		b = per_cpu(threshold_banks, lcpu)[bank];
@@ -434,7 +434,7 @@
 	int bank, err = 0;
 	unsigned int lcpu = 0;
 
-	if (cpu_core_id[cpu])
+	if (cpu_data[cpu].cpu_core_id)
 		return 0;
 	for_each_cpu_mask(lcpu, cpu_core_map[cpu]) {
 		if (lcpu == cpu)
@@ -455,7 +455,7 @@
 {
 	int bank;
 	unsigned int lcpu = 0;
-	if (cpu_core_id[cpu])
+	if (cpu_data[cpu].cpu_core_id)
 		return;
 	for_each_cpu_mask(lcpu, cpu_core_map[cpu]) {
 		if (lcpu == cpu)


