Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbVALHEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbVALHEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVALHD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:03:29 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:5812 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263015AbVALHDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:03:01 -0500
Date: Wed, 12 Jan 2005 08:02:59 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org, akpm@osdl.org, discuss@x86-64.org, vandrove@vc.cvut.cz,
       linux-kernel@vger.kernel.org
Subject: [2/4] x86_64: Fix K8 NUMA parsing
Message-ID: <20050112070259.GC532@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix k8 NUMA discovery

Fix K8 node discovery after nodemask changes.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/mm/k8topology.c
===================================================================
--- linux.orig/arch/x86_64/mm/k8topology.c	2005-01-09 18:19:17.%N +0100
+++ linux/arch/x86_64/mm/k8topology.c	2005-01-12 06:49:42.%N +0100
@@ -47,6 +47,10 @@
 	int nodeid, i, nb; 
 	int found = 0;
 	u32 reg;
+	unsigned numnodes;
+	nodemask_t nodes_parsed;
+
+	nodes_clear(nodes_parsed);
 
 	nb = find_northbridge(); 
 	if (nb < 0) 
@@ -55,10 +59,9 @@
 	printk(KERN_INFO "Scanning NUMA topology in Northbridge %d\n", nb); 
 
 	reg = read_pci_config(0, nb, 0, 0x60); 
-	for (i = 0; i <= ((reg >> 4) & 7); i++)
-		node_set_online(i);
+	numnodes = ((reg >> 4) & 7) + 1;
 
-	printk(KERN_INFO "Number of nodes %d (%x)\n", num_online_nodes(), reg);
+	printk(KERN_INFO "Number of nodes %d\n", numnodes);
 
 	memset(&nodes,0,sizeof(nodes)); 
 	prevbase = 0;
@@ -70,11 +73,11 @@
 
 		nodeid = limit & 7; 
 		if ((base & 3) == 0) { 
-			if (i < num_online_nodes())
+			if (i < numnodes)
 				printk("Skipping disabled node %d\n", i); 
 			continue;
 		} 
-		if (nodeid >= num_online_nodes()) {
+		if (nodeid >= numnodes) {
 			printk("Ignoring excess node %d (%lx:%lx)\n", nodeid,
 			       base, limit); 
 			continue;
@@ -90,7 +93,7 @@
 			       nodeid, (base>>8)&3, (limit>>8) & 3); 
 			return -1; 
 		}	
-		if (node_online(nodeid)) { 
+		if (node_isset(nodeid, nodes_parsed)) { 
 			printk(KERN_INFO "Node %d already present. Skipping\n", 
 			       nodeid);
 			continue;
@@ -138,6 +141,8 @@
 		nodes[nodeid].end = limit;
 
 		prevbase = base;
+
+		node_set(nodeid, nodes_parsed);
 	} 
 
 	if (!found)
@@ -154,8 +159,8 @@
 		if (nodes[i].start != nodes[i].end) { 
 			/* assume 1:1 NODE:CPU */
 			cpu_to_node[i] = i; 
-		setup_node_bootmem(i, nodes[i].start, nodes[i].end); 
-	} 
+			setup_node_bootmem(i, nodes[i].start, nodes[i].end); 
+		} 
 	}
 
 	numa_init_array();
