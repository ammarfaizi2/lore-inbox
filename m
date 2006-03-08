Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWCHNoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWCHNoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWCHNoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:44:12 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55708 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030179AbWCHNnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:43:16 -0500
Date: Wed, 08 Mar 2006 22:43:12 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 017/017](RFC) Memory hotplug for new nodes v.3. (arch_register_node() for ia64)
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308214141.0044.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is to create sysfs file for new node.
It adds arch specific functions 'arch_register_node()'
and 'arch_unregister_node()' to IA64 to call the generic
function 'register_node()' and 'unregister_node()' respectively.

(Each arch defines like sysfs_nodes[] to describe its nodes
 topology. I'm not sure they can be merged as generic code.)

Signed-off-by: Keiichiro Tokunaga <tokuanga.keiich@jp.fujitsu.com>
Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat6/arch/ia64/kernel/topology.c
===================================================================
--- pgdat6.orig/arch/ia64/kernel/topology.c	2006-03-06 18:25:31.000000000 +0900
+++ pgdat6/arch/ia64/kernel/topology.c	2006-03-06 18:26:33.000000000 +0900
@@ -65,6 +65,21 @@ EXPORT_SYMBOL(arch_register_cpu);
 EXPORT_SYMBOL(arch_unregister_cpu);
 #endif /*CONFIG_HOTPLUG_CPU*/
 
+#ifdef CONFIG_NUMA
+int arch_register_node(int num)
+{
+	if (sysfs_nodes[num].sysdev.id == num)
+		return 0;
+
+	return register_node(&sysfs_nodes[num], num, 0);
+}
+
+void arch_unregister_node(int num)
+{
+	unregister_node(&sysfs_nodes[num]);
+	sysfs_nodes[num].sysdev.id = -1;
+}
+#endif
 
 static int __init topology_init(void)
 {
Index: pgdat6/include/asm-ia64/numa.h
===================================================================
--- pgdat6.orig/include/asm-ia64/numa.h	2006-03-06 18:24:01.000000000 +0900
+++ pgdat6/include/asm-ia64/numa.h	2006-03-06 18:26:33.000000000 +0900
@@ -23,6 +23,9 @@
 
 #include <asm/mmzone.h>
 
+extern int arch_register_node(int num);
+extern void arch_unregister_node(int num);
+
 extern u8 cpu_to_node_map[NR_CPUS] __cacheline_aligned;
 extern cpumask_t node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
 

-- 
Yasunori Goto 


