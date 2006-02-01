Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWBAMiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWBAMiD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 07:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbWBAMiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 07:38:02 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:24277 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932460AbWBAMh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 07:37:57 -0500
Date: Wed, 01 Feb 2006 21:36:49 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:003/004] Unify pxm_to_node id ver.2. (for x86_64)
Cc: Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       "Brown, Len" <len.brown@intel.com>, Bob Picco <bob.picco@hp.com>,
       Paul Jackson <pj@sgi.com>, Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.062
Message-Id: <20060201205337.41EC.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is to remove the code of pxm_to_node from x86-64 code.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


 arch/x86_64/mm/srat.c     |   33 +--------------------------------
 include/asm-x86_64/numa.h |    1 -
 2 files changed, 1 insertion(+), 33 deletions(-)

Index: pxm_ver2/arch/x86_64/mm/srat.c
===================================================================
--- pxm_ver2.orig/arch/x86_64/mm/srat.c	2006-02-01 18:53:45.000000000 +0900
+++ pxm_ver2/arch/x86_64/mm/srat.c	2006-02-01 18:54:25.000000000 +0900
@@ -22,31 +22,11 @@
 static struct acpi_table_slit *acpi_slit;
 
 static nodemask_t nodes_parsed __initdata;
-static nodemask_t nodes_found __initdata;
 static struct bootnode nodes[MAX_NUMNODES] __initdata;
-static u8 pxm2node[256] = { [0 ... 255] = 0xff };
-
-static int node_to_pxm(int n);
-
-int pxm_to_node(int pxm)
-{
-	if ((unsigned)pxm >= 256)
-		return -1;
-	/* Extend 0xff to (int)-1 */
-	return (signed char)pxm2node[pxm];
-}
 
 static __init int setup_node(int pxm)
 {
-	unsigned node = pxm2node[pxm];
-	if (node == 0xff) {
-		if (nodes_weight(nodes_found) >= MAX_NUMNODES)
-			return -1;
-		node = first_unset_node(nodes_found); 
-		node_set(node, nodes_found);
-		pxm2node[pxm] = node;
-	}
-	return pxm2node[pxm];
+	return acpi_map_pxm_to_node(pxm);
 }
 
 static __init int conflicting_nodes(unsigned long start, unsigned long end)
@@ -302,17 +282,6 @@ int __init acpi_scan_nodes(unsigned long
 	return 0;
 }
 
-static int node_to_pxm(int n)
-{
-       int i;
-       if (pxm2node[n] == n)
-               return n;
-       for (i = 0; i < 256; i++)
-               if (pxm2node[i] == n)
-                       return i;
-       return 0;
-}
-
 int __node_distance(int a, int b)
 {
 	int index;
Index: pxm_ver2/include/asm-x86_64/numa.h
===================================================================
--- pxm_ver2.orig/include/asm-x86_64/numa.h	2006-02-01 18:53:45.000000000 +0900
+++ pxm_ver2/include/asm-x86_64/numa.h	2006-02-01 18:54:25.000000000 +0900
@@ -9,7 +9,6 @@ struct bootnode { 
 };
 
 extern int compute_hash_shift(struct bootnode *nodes, int numnodes);
-extern int pxm_to_node(int nid);
 
 #define ZONE_ALIGN (1UL << (MAX_ORDER+PAGE_SHIFT))
 

-- 
Yasunori Goto 


