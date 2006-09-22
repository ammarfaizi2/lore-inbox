Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWIVGXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWIVGXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIVGXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:23:49 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:3719 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750746AbWIVGXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:23:48 -0400
Date: Fri, 22 Sep 2006 15:27:02 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "tony.luck@intel.com" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, GOTO <y-goto@jp.fujitsu.com>
Subject: [BUGFIX][PATCH] cpu to node relationship fixup take2 [2/2] map cpu
 to node
Message-Id: <20060922152702.4b01c192.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assume that a cpu is *physically* offlined at boot time...

Because smpboot.c::smp_boot_cpu_map() canoot find cpu's sapicid,
numa.c::build_cpu_to_node_map() cannot build cpu<->node map for
offlined cpu.

For such cpus, cpu_to_node map should be fixed at cpu-hot-add.
This mapping should be done before cpu onlining.

This patch also handles cpu hotremove case.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


 arch/ia64/kernel/numa.c     |   34 +++++++++++++++++++++++++++++++---
 arch/ia64/kernel/topology.c |    6 +++++-
 include/asm-ia64/numa.h     |    4 ++++
 3 files changed, 40 insertions(+), 4 deletions(-)

Index: linux-2.6.18/arch/ia64/kernel/numa.c
===================================================================
--- linux-2.6.18.orig/arch/ia64/kernel/numa.c	2006-09-22 14:22:44.000000000 +0900
+++ linux-2.6.18/arch/ia64/kernel/numa.c	2006-09-22 14:44:46.000000000 +0900
@@ -29,6 +29,36 @@
 
 cpumask_t node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
 
+void __cpuinit map_cpu_to_node(int cpu, int nid)
+{
+	int oldnid;
+	if (nid < 0) { /* just initialize by zero */
+		cpu_to_node_map[cpu] = 0;
+		return;
+	}
+	/* sanity check first */
+	oldnid = cpu_to_node_map[cpu];
+	if (cpu_isset(cpu, node_to_cpu_mask[oldnid])) {
+		return; /* nothing to do */
+	}
+	/* we don't have cpu-driven node hot add yet...
+	   In usual case, node is created from SRAT at boot time. */
+	if (!node_online(nid))
+		nid = first_online_node;
+	cpu_to_node_map[cpu] = nid;
+	cpu_set(cpu, node_to_cpu_mask[nid]);
+	return;
+}
+
+void __cpuinit unmap_cpu_from_node(int cpu, int nid)
+{
+	WARN_ON(!cpu_isset(cpu, node_to_cpu_mask[nid]));
+	WARN_ON(cpu_to_node_map[cpu] != nid);
+	cpu_to_node_map[cpu] = 0;
+	cpu_clear(cpu, node_to_cpu_mask[nid]);
+}
+
+
 /**
  * build_cpu_to_node_map - setup cpu to node and node to cpumask arrays
  *
@@ -49,8 +79,6 @@
 				node = node_cpuid[i].nid;
 				break;
 			}
-		cpu_to_node_map[cpu] = (node >= 0) ? node : 0;
-		if (node >= 0)
-			cpu_set(cpu, node_to_cpu_mask[node]);
+		map_cpu_to_node(cpu, node);
 	}
 }
Index: linux-2.6.18/include/asm-ia64/numa.h
===================================================================
--- linux-2.6.18.orig/include/asm-ia64/numa.h	2006-09-22 14:22:44.000000000 +0900
+++ linux-2.6.18/include/asm-ia64/numa.h	2006-09-22 14:25:07.000000000 +0900
@@ -64,6 +64,10 @@
 
 #define local_nodeid (cpu_to_node_map[smp_processor_id()])
 
+extern void map_cpu_to_node(int cpu, int nid);
+extern void unmap_cpu_from_node(int cpu, int nid);
+
+
 #else /* !CONFIG_NUMA */
 
 #define paddr_to_nid(addr)	0
Index: linux-2.6.18/arch/ia64/kernel/topology.c
===================================================================
--- linux-2.6.18.orig/arch/ia64/kernel/topology.c	2006-09-22 14:22:44.000000000 +0900
+++ linux-2.6.18/arch/ia64/kernel/topology.c	2006-09-22 14:25:07.000000000 +0900
@@ -36,6 +36,9 @@
 	 */
 	if (!can_cpei_retarget() && is_cpu_cpei_target(num))
 		sysfs_cpus[num].cpu.no_control = 1;
+#ifdef CONFIG_NUMA
+	map_cpu_to_node(num, node_cpuid[num].nid);
+#endif
 #endif
 
 	return register_cpu(&sysfs_cpus[num].cpu, num);
@@ -45,7 +48,8 @@
 
 void arch_unregister_cpu(int num)
 {
-	return unregister_cpu(&sysfs_cpus[num].cpu);
+	unregister_cpu(&sysfs_cpus[num].cpu);
+	unmap_cpu_from_node(num, cpu_to_node(num));
 }
 EXPORT_SYMBOL(arch_register_cpu);
 EXPORT_SYMBOL(arch_unregister_cpu);

