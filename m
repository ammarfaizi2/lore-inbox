Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWFHTxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWFHTxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 15:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWFHTxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 15:53:33 -0400
Received: from smtp-out.google.com ([216.239.45.12]:50314 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964952AbWFHTxd
	(ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 15:53:33 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=J0XK197M8roVGqk4Wmeqvs10r8GNEkN+2E5tQjN5zZaHg15Y70/cZkjq1RSDm1u7W
	rF2PwTq1/67h954SGQkfQ==
Subject: [PATCH]:x86_64 setup.c - printing cmp related boottime information
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 08 Jun 2006 12:53:23 -0700
Message-Id: <1149796403.24364.7.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Getting phys_proc_id and cpu_core_id information to be printed at boot
time for AMD processors.  Also matching the Node related boot time
information that gets printed for Intel and AMD processors for NUMA
configurations.

Signed-off-by: Rohit Seth <rohitseth@google.com>

 arch/x86_64/kernel/setup.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

--- linux-2.6.17-rc5-mm3.org/arch/x86_64/kernel/setup.c	2006-06-05 11:08:38.000000000 -0700
+++ linux-2.6.17-rc5-mm3/arch/x86_64/kernel/setup.c	2006-06-08 12:39:34.000000000 -0700
@@ -922,15 +922,13 @@
  	}
 	numa_set_node(cpu, node);
 
-  	printk(KERN_INFO "CPU %d/%x(%d) -> Node %d -> Core %d\n",
-  			cpu, apicid, c->x86_max_cores, node, c->cpu_core_id);
+	printk(KERN_INFO "CPU %d/%x -> Node %d\n", cpu, apicid, node);
 #endif
 #endif
 }
 
-static int __init init_amd(struct cpuinfo_x86 *c)
+static void __init init_amd(struct cpuinfo_x86 *c)
 {
-	int r;
 	unsigned level;
 
 #ifdef CONFIG_SMP
@@ -963,8 +961,8 @@
 	if (c->x86 >= 6)
 		set_bit(X86_FEATURE_FXSAVE_LEAK, &c->x86_capability);
 
-	r = get_model_name(c);
-	if (!r) { 
+	level = get_model_name(c);
+	if (!level) { 
 		switch (c->x86) { 
 		case 15:
 			/* Should distinguish Models here, but this is only
@@ -985,8 +983,6 @@
 
 	/* Fix cpuid4 emulation for more */
 	num_cache_leaves = 3;
-
-	return r;
 }
 
 static void __cpuinit detect_ht(struct cpuinfo_x86 *c)
@@ -998,8 +994,10 @@
 	cpuid(1, &eax, &ebx, &ecx, &edx);
 
 
-	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
+	if (!cpu_has(c, X86_FEATURE_HT))
 		return;
+ 	if (cpu_has(c, X86_FEATURE_CMP_LEGACY))
+		goto out;
 
 	smp_num_siblings = (ebx & 0xff0000) >> 16;
 
@@ -1016,9 +1014,6 @@
 		index_msb = get_count_order(smp_num_siblings);
 		c->phys_proc_id = phys_pkg_id(index_msb);
 
-		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
-		       c->phys_proc_id);
-
 		smp_num_siblings = smp_num_siblings / c->x86_max_cores;
 
 		index_msb = get_count_order(smp_num_siblings) ;
@@ -1027,11 +1022,13 @@
 
 		c->cpu_core_id = phys_pkg_id(index_msb) &
 					       ((1 << core_bits) - 1);
-
-		if (c->x86_max_cores > 1)
-			printk(KERN_INFO  "CPU: Processor Core ID: %d\n",
-			       c->cpu_core_id);
 	}
+out:
+	if ((c->x86_max_cores * smp_num_siblings) > 1) {
+		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n", c->phys_proc_id);
+		printk(KERN_INFO  "CPU: Processor Core ID: %d\n", c->cpu_core_id);
+	}
+
 #endif
 }
 
@@ -1058,16 +1055,17 @@
 #ifdef CONFIG_NUMA
 	unsigned node;
 	int cpu = smp_processor_id();
+	int apicid = hard_smp_processor_id();
 
 	/* Don't do the funky fallback heuristics the AMD version employs
 	   for now. */
-	node = apicid_to_node[hard_smp_processor_id()];
+	node = apicid_to_node[apicid];
 	if (node == NUMA_NO_NODE)
 		node = first_node(node_online_map);
 	numa_set_node(cpu, node);
 
 	if (acpi_numa > 0)
-		printk(KERN_INFO "CPU %d -> Node %d\n", cpu, node);
+		printk(KERN_INFO "CPU %d/%x -> Node %d\n", cpu, apicid, node);
 #endif
 }
 


