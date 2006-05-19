Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWESKTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWESKTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWESKTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:19:05 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:52107 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932255AbWESKTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 06:19:04 -0400
Date: Fri, 19 May 2006 19:18:20 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Register sysfs file for hotpluged new node take 2.
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060518143742.E2FB.Y-GOTO@jp.fujitsu.com>
References: <20060518143742.E2FB.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060519191327.9265.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew-san.

Sorry. I realize that I forgot to remove old sysfs structure of node for ia64
in yesterday's patch. :-(

Please apply this too.

-------------

Creating sysfs file for node is consolidated as generic code 
by creating registrer_one_node() and node_devices[]. 
But, ia64's boot time code remains old sysfs_nodes structure
as an arch dependent code. This is to remove it.

This patch is for 2.6.17-rc4-mm1 with 
  + register-sysfs-file-for-hotpluged-new-node.patch

I tested this on Tiger4 box with my multi nodes emulation.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

-------------

 arch/ia64/kernel/topology.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

Index: pgdat14/arch/ia64/kernel/topology.c
===================================================================
--- pgdat14.orig/arch/ia64/kernel/topology.c	2006-05-19 14:54:37.000000000 +0900
+++ pgdat14/arch/ia64/kernel/topology.c	2006-05-19 15:16:09.000000000 +0900
@@ -26,9 +26,6 @@
 #include <asm/numa.h>
 #include <asm/cpu.h>
 
-#ifdef CONFIG_NUMA
-static struct node *sysfs_nodes;
-#endif
 static struct ia64_cpu *sysfs_cpus;
 
 int arch_register_cpu(int num)
@@ -36,7 +33,7 @@ int arch_register_cpu(int num)
 	struct node *parent = NULL;
 	
 #ifdef CONFIG_NUMA
-	parent = &sysfs_nodes[cpu_to_node(num)];
+	parent = &node_devices[cpu_to_node(num)];
 #endif /* CONFIG_NUMA */
 
 #if defined (CONFIG_ACPI) && defined (CONFIG_HOTPLUG_CPU)
@@ -59,7 +56,7 @@ void arch_unregister_cpu(int num)
 
 #ifdef CONFIG_NUMA
 	int node = cpu_to_node(num);
-	parent = &sysfs_nodes[node];
+	parent = &node_devices[node];
 #endif /* CONFIG_NUMA */
 
 	return unregister_cpu(&sysfs_cpus[num].cpu, parent);
@@ -74,17 +71,11 @@ static int __init topology_init(void)
 	int i, err = 0;
 
 #ifdef CONFIG_NUMA
-	sysfs_nodes = kzalloc(sizeof(struct node) * MAX_NUMNODES, GFP_KERNEL);
-	if (!sysfs_nodes) {
-		err = -ENOMEM;
-		goto out;
-	}
-
 	/*
 	 * MCD - Do we want to register all ONLINE nodes, or all POSSIBLE nodes?
 	 */
 	for_each_online_node(i) {
-		if ((err = register_node(&sysfs_nodes[i], i, 0)))
+		if ((err = register_one_node(i)))
 			goto out;
 	}
 #endif

-- 
Yasunori Goto 


