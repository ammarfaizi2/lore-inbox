Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWIWAIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWIWAIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 20:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWIWAIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 20:08:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964947AbWIWAID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 20:08:03 -0400
Date: Fri, 22 Sep 2006 17:07:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       "tony.luck@intel.com" <tony.luck@intel.com>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, GOTO <y-goto@jp.fujitsu.com>
Subject: Re: [BUGFIX][PATCH] cpu to node relationship fixup take2 [1/2]
 acpi_map_cpu2node
Message-Id: <20060922170743.169ad3d3.akpm@osdl.org>
In-Reply-To: <20060922170604.745d662a.akpm@osdl.org>
References: <20060922152447.42a83860.kamezawa.hiroyu@jp.fujitsu.com>
	<20060922170604.745d662a.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 17:06:04 -0700
Andrew Morton <akpm@osdl.org> wrote:

> cpu-to-node-relationship-fixup-map-cpu-to-node.patch

From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Assume that a cpu is *physically* offlined at boot time...

Because smpboot.c::smp_boot_cpu_map() canoot find cpu's sapicid,
numa.c::build_cpu_to_node_map() cannot build cpu<->node map for
offlined cpu.

For such cpus, cpu_to_node map should be fixed at cpu-hot-add.
This mapping should be done before cpu onlining.

This patch also handles cpu hotremove case.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ia64/kernel/numa.c     |   34 +++++++++++++++++++++++++++++++---
 arch/ia64/kernel/topology.c |    6 +++++-
 include/asm-ia64/numa.h     |    4 ++++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff -puN arch/ia64/kernel/numa.c~cpu-to-node-relationship-fixup-map-cpu-to-node arch/ia64/kernel/numa.c
--- a/arch/ia64/kernel/numa.c~cpu-to-node-relationship-fixup-map-cpu-to-node
+++ a/arch/ia64/kernel/numa.c
@@ -29,6 +29,36 @@ EXPORT_SYMBOL(cpu_to_node_map);
 
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
@@ -49,8 +79,6 @@ void __init build_cpu_to_node_map(void)
 				node = node_cpuid[i].nid;
 				break;
 			}
-		cpu_to_node_map[cpu] = (node >= 0) ? node : 0;
-		if (node >= 0)
-			cpu_set(cpu, node_to_cpu_mask[node]);
+		map_cpu_to_node(cpu, node);
 	}
 }
diff -puN arch/ia64/kernel/topology.c~cpu-to-node-relationship-fixup-map-cpu-to-node arch/ia64/kernel/topology.c
--- a/arch/ia64/kernel/topology.c~cpu-to-node-relationship-fixup-map-cpu-to-node
+++ a/arch/ia64/kernel/topology.c
@@ -36,6 +36,9 @@ int arch_register_cpu(int num)
 	 */
 	if (!can_cpei_retarget() && is_cpu_cpei_target(num))
 		sysfs_cpus[num].cpu.no_control = 1;
+#ifdef CONFIG_NUMA
+	map_cpu_to_node(num, node_cpuid[num].nid);
+#endif
 #endif
 
 	return register_cpu(&sysfs_cpus[num].cpu, num);
@@ -45,7 +48,8 @@ int arch_register_cpu(int num)
 
 void arch_unregister_cpu(int num)
 {
-	return unregister_cpu(&sysfs_cpus[num].cpu);
+	unregister_cpu(&sysfs_cpus[num].cpu);
+	unmap_cpu_from_node(num, cpu_to_node(num));
 }
 EXPORT_SYMBOL(arch_register_cpu);
 EXPORT_SYMBOL(arch_unregister_cpu);
diff -puN include/asm-ia64/numa.h~cpu-to-node-relationship-fixup-map-cpu-to-node include/asm-ia64/numa.h
--- a/include/asm-ia64/numa.h~cpu-to-node-relationship-fixup-map-cpu-to-node
+++ a/include/asm-ia64/numa.h
@@ -64,6 +64,10 @@ extern int paddr_to_nid(unsigned long pa
 
 #define local_nodeid (cpu_to_node_map[smp_processor_id()])
 
+extern void map_cpu_to_node(int cpu, int nid);
+extern void unmap_cpu_from_node(int cpu, int nid);
+
+
 #else /* !CONFIG_NUMA */
 
 #define paddr_to_nid(addr)	0
_

