Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268163AbUIWQhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268163AbUIWQhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUIWQhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:37:46 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:33513 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268117AbUIWQgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:36:11 -0400
Date: Fri, 24 Sep 2004 01:32:13 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
To: anil.s.keshavamurthy@intel.com
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [PATCH][2/4] Add arch_register_node() for ia64
Message-Id: <20040924013213.00004a83.tokunaga.keiich@jp.fujitsu.com>
In-Reply-To: <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	<20040920094719.H14208@unix-os.sc.intel.com>
	<20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.3.0; Win32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Name: numa_hp_ia64.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Description:
Add arch_register_node() to arch/ia64/kernel/topology.c.  The
topology.c has been introduced by Anil (Intel).

Thanks,
Keiichiro Tokunaga
---

 linux-2.6.9-rc2-fix-kei/arch/ia64/kernel/acpi.c     |    1 +
 linux-2.6.9-rc2-fix-kei/arch/ia64/kernel/topology.c |   18 +++++++++++++++---
 linux-2.6.9-rc2-fix-kei/include/asm-ia64/numa.h     |    3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff -puN arch/ia64/kernel/acpi.c~numa_hp_ia64 arch/ia64/kernel/acpi.c
--- linux-2.6.9-rc2-fix/arch/ia64/kernel/acpi.c~numa_hp_ia64	2004-09-24 00:14:56.062297005 +0900
+++ linux-2.6.9-rc2-fix-kei/arch/ia64/kernel/acpi.c	2004-09-24 00:14:56.069132982 +0900
@@ -362,6 +362,7 @@ int __devinitdata pxm_to_nid_map[MAX_PXM
 int __initdata nid_to_pxm_map[MAX_NUMNODES];
 static struct acpi_table_slit __initdata *slit_table;
 
+EXPORT_SYMBOL(pxm_to_nid_map);
 /*
  * ACPI 2.0 SLIT (System Locality Information Table)
  * http://devresource.hp.com/devresource/Docs/TechPapers/IA64/slit.pdf
diff -puN arch/ia64/kernel/topology.c~numa_hp_ia64 arch/ia64/kernel/topology.c
--- linux-2.6.9-rc2-fix/arch/ia64/kernel/topology.c~numa_hp_ia64	2004-09-24 00:14:56.064250141 +0900
+++ linux-2.6.9-rc2-fix-kei/arch/ia64/kernel/topology.c	2004-09-24 00:14:56.070109550 +0900
@@ -21,8 +21,9 @@
 #include <asm/mmzone.h>
 #include <asm/numa.h>
 #include <asm/cpu.h>
-
 #ifdef CONFIG_NUMA
+#include <asm/numa.h>
+
 static struct node *sysfs_nodes;
 #endif
 static struct ia64_cpu *sysfs_cpus;
@@ -37,6 +38,18 @@ int arch_register_cpu(int num)
 
 	return register_cpu(&sysfs_cpus[num].cpu, num, parent);
 }
+#ifdef CONFIG_NUMA
+int arch_register_node(int num) {
+	return register_node(&sysfs_nodes[num],num,0);
+}
+int arch_unregister_node(int num) {
+	unregister_node(&sysfs_nodes[num],0);
+	return 0;
+}
+
+EXPORT_SYMBOL(arch_register_node);
+EXPORT_SYMBOL(arch_unregister_node);
+#endif /*CONFIG_NUMA*/
 
 #ifdef CONFIG_HOTPLUG_CPU
 
@@ -69,7 +82,7 @@ static int __init topology_init(void)
 	memset(sysfs_nodes, 0, sizeof(struct node) * MAX_NUMNODES);
 
 	for (i = 0; i < numnodes; i++)
-		if ((err = register_node(&sysfs_nodes[i], i, 0)))
+ 		if ((err = arch_register_node(i)))
 			goto out;
 #endif
 
@@ -86,5 +99,4 @@ static int __init topology_init(void)
 out:
 	return err;
 }
-
 __initcall(topology_init);
diff -puN include/asm-ia64/numa.h~numa_hp_ia64 include/asm-ia64/numa.h
--- linux-2.6.9-rc2-fix/include/asm-ia64/numa.h~numa_hp_ia64	2004-09-24 00:14:56.066203277 +0900
+++ linux-2.6.9-rc2-fix-kei/include/asm-ia64/numa.h	2004-09-24 00:14:56.070109550 +0900
@@ -65,8 +65,9 @@ extern int paddr_to_nid(unsigned long pa
 
 #define local_nodeid (cpu_to_node_map[smp_processor_id()])
 
+extern int arch_register_node(int num);
+extern int arch_unregister_node(int num);
 #else /* !CONFIG_NUMA */
-
 #define paddr_to_nid(addr)	0
 
 #endif /* CONFIG_NUMA */

_
