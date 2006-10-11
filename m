Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161421AbWJKVIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161421AbWJKVIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161428AbWJKVIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:08:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:26018 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161431AbWJKVIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:08:10 -0400
Date: Wed, 11 Oct 2006 14:07:34 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, tony.luck@intel.com,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 45/67] cpu to node relationship fixup: map cpu to node
Message-ID: <20061011210734.GT16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="cpu-to-node-relationship-fixup-map-cpu-to-node.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Assume that a cpu is *physically* offlined at boot time...

Because smpboot.c::smp_boot_cpu_map() canoot find cpu's sapicid,
numa.c::build_cpu_to_node_map() cannot build cpu<->node map for
offlined cpu.

For such cpus, cpu_to_node map should be fixed at cpu-hot-add.
This mapping should be done before cpu onlining.

This patch also handles cpu hotremove case.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/ia64/kernel/numa.c     |   34 +++++++++++++++++++++++++++++++---
 arch/ia64/kernel/topology.c |    4 +++-
 include/asm-ia64/numa.h     |    6 ++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

--- linux-2.6.18.orig/arch/ia64/kernel/numa.c
+++ linux-2.6.18/arch/ia64/kernel/numa.c
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
--- linux-2.6.18.orig/arch/ia64/kernel/topology.c
+++ linux-2.6.18/arch/ia64/kernel/topology.c
@@ -36,6 +36,7 @@ int arch_register_cpu(int num)
 	 */
 	if (!can_cpei_retarget() && is_cpu_cpei_target(num))
 		sysfs_cpus[num].cpu.no_control = 1;
+	map_cpu_to_node(num, node_cpuid[num].nid);
 #endif
 
 	return register_cpu(&sysfs_cpus[num].cpu, num);
@@ -45,7 +46,8 @@ int arch_register_cpu(int num)
 
 void arch_unregister_cpu(int num)
 {
-	return unregister_cpu(&sysfs_cpus[num].cpu);
+	unregister_cpu(&sysfs_cpus[num].cpu);
+	unmap_cpu_from_node(num, cpu_to_node(num));
 }
 EXPORT_SYMBOL(arch_register_cpu);
 EXPORT_SYMBOL(arch_unregister_cpu);
--- linux-2.6.18.orig/include/asm-ia64/numa.h
+++ linux-2.6.18/include/asm-ia64/numa.h
@@ -64,7 +64,13 @@ extern int paddr_to_nid(unsigned long pa
 
 #define local_nodeid (cpu_to_node_map[smp_processor_id()])
 
+extern void map_cpu_to_node(int cpu, int nid);
+extern void unmap_cpu_from_node(int cpu, int nid);
+
+
 #else /* !CONFIG_NUMA */
+#define map_cpu_to_node(cpu, nid)	do{}while(0)
+#define unmap_cpu_from_node(cpu, nid)	do{}while(0)
 
 #define paddr_to_nid(addr)	0
 

--
