Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263037AbVALHIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbVALHIY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVALHHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:07:24 -0500
Received: from cantor.suse.de ([195.135.220.2]:1974 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263014AbVALHEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:04:41 -0500
Date: Wed, 12 Jan 2005 08:04:39 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org, akpm@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz
Subject: [PATCH] [3/4] x86_64: Fix NUMA hash setup
Message-ID: <20050112070439.GD532@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NUMA hash setup on x86-64

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/mm/k8topology.c
===================================================================
--- linux.orig/arch/x86_64/mm/k8topology.c	2005-01-12 06:49:42.%N +0100
+++ linux/arch/x86_64/mm/k8topology.c	2005-01-12 07:43:50.%N +0100
@@ -148,7 +148,7 @@
 	if (!found)
 		return -1; 
 
-	memnode_shift = compute_hash_shift(nodes);
+	memnode_shift = compute_hash_shift(nodes, numnodes);
 	if (memnode_shift < 0) { 
 		printk(KERN_ERR "No NUMA node hash function found. Contact maintainer\n"); 
 		return -1; 
Index: linux/arch/x86_64/mm/srat.c
===================================================================
--- linux.orig/arch/x86_64/mm/srat.c	2005-01-12 04:15:43.%N +0100
+++ linux/arch/x86_64/mm/srat.c	2005-01-12 07:44:23.%N +0100
@@ -166,7 +166,7 @@
 	int i;
 	if (acpi_numa <= 0)
 		return -1;
-	memnode_shift = compute_hash_shift(nodes);
+	memnode_shift = compute_hash_shift(nodes, nodes_weight(nodes_parsed));
 	if (memnode_shift < 0) {
 		printk(KERN_ERR
 		     "SRAT: No NUMA node hash function found. Contact maintainer\n");
Index: linux/include/asm-x86_64/numa.h
===================================================================
--- linux.orig/include/asm-x86_64/numa.h	2005-01-09 18:19:35.%N +0100
+++ linux/include/asm-x86_64/numa.h	2005-01-12 07:42:42.%N +0100
@@ -8,7 +8,7 @@
 	u64 start,end; 
 };
 
-extern int compute_hash_shift(struct node *nodes);
+extern int compute_hash_shift(struct node *nodes, int numnodes);
 
 #define ZONE_ALIGN (1UL << (MAX_ORDER+PAGE_SHIFT))
 
Index: linux/arch/x86_64/mm/numa.c
===================================================================
--- linux.orig/arch/x86_64/mm/numa.c	2005-01-12 06:47:00.%N +0100
+++ linux/arch/x86_64/mm/numa.c	2005-01-12 07:46:05.%N +0100
@@ -34,9 +34,7 @@
 
 int numa_off __initdata;
 
-unsigned long nodes_present; 
-
-int __init compute_hash_shift(struct node *nodes)
+int __init compute_hash_shift(struct node *nodes, int numnodes)
 {
 	int i; 
 	int shift = 24;
@@ -45,7 +43,7 @@
 	/* When in doubt use brute force. */
 	while (shift < 48) { 
 		memset(memnodemap,0xff,sizeof(*memnodemap) * NODEMAPSIZE); 
-		for_each_online_node(i) {
+		for (i = 0; i < numnodes; i++) {
 			if (nodes[i].start == nodes[i].end) 
 				continue;
 			for (addr = nodes[i].start; 
@@ -188,7 +186,7 @@
  		       (nodes[i].end - nodes[i].start) >> 20);
 		node_set_online(i);
  	}
- 	memnode_shift = compute_hash_shift(nodes);
+ 	memnode_shift = compute_hash_shift(nodes, numa_fake);
  	if (memnode_shift < 0) {
  		memnode_shift = 0;
  		printk(KERN_ERR "No NUMA hash function found. Emulation disabled.\n");
