Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWBHGnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWBHGnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWBHGnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38275 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161012AbWBHGnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:03 -0500
Message-Id: <20060208064914.995774000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:21 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "Andi Kleen" <ak@suse.de>
Subject: [PATCH 18/23] [PATCH] x86_64: Clear more state when ignoring empty node in SRAT parsing
Content-Disposition: inline; filename=x86_64-clear-more-state-when-ignoring-empty-node-in-srat-parsing.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Fix boot failures on systems with bad PXMs.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/x86_64/mm/srat.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)

Index: linux-2.6.15.3/arch/x86_64/mm/srat.c
===================================================================
--- linux-2.6.15.3.orig/arch/x86_64/mm/srat.c
+++ linux-2.6.15.3/arch/x86_64/mm/srat.c
@@ -25,6 +25,10 @@ static nodemask_t nodes_found __initdata
 static struct node nodes[MAX_NUMNODES] __initdata;
 static __u8  pxm2node[256] = { [0 ... 255] = 0xff };
 
+/* Too small nodes confuse the VM badly. Usually they result
+   from BIOS bugs. */
+#define NODE_MIN_SIZE (4*1024*1024)
+
 static int node_to_pxm(int n);
 
 int pxm_to_node(int pxm)
@@ -168,22 +172,32 @@ acpi_numa_memory_affinity_init(struct ac
 	       nd->start, nd->end);
 }
 
+static void unparse_node(int node)
+{
+	int i;
+	node_clear(node, nodes_parsed);
+	for (i = 0; i < MAX_LOCAL_APIC; i++) {
+		if (apicid_to_node[i] == node)
+			apicid_to_node[i] = NUMA_NO_NODE;
+	}
+}
+
 void __init acpi_numa_arch_fixup(void) {}
 
 /* Use the information discovered above to actually set up the nodes. */
 int __init acpi_scan_nodes(unsigned long start, unsigned long end)
 {
 	int i;
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+ 		cutoff_node(i, start, end);
+		if ((nodes[i].end - nodes[i].start) < NODE_MIN_SIZE)
+			unparse_node(i);
+ 	}
+
 	if (acpi_numa <= 0)
 		return -1;
 
-	/* First clean up the node list */
-	for_each_node_mask(i, nodes_parsed) {
-		cutoff_node(i, start, end);
-		if (nodes[i].start == nodes[i].end)
-			node_clear(i, nodes_parsed);
-	}
-
 	memnode_shift = compute_hash_shift(nodes, nodes_weight(nodes_parsed));
 	if (memnode_shift < 0) {
 		printk(KERN_ERR

--
