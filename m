Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWC3L4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWC3L4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWC3L4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:56:23 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:55237 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932082AbWC3L4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:56:11 -0500
Date: Thu, 30 Mar 2006 20:55:35 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:003/004]Unify pxm_to_node id ver.4. (for x86-64)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060330204245.A4F5.Y-GOTO@jp.fujitsu.com>
References: <20060330204245.A4F5.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060330205337.A4FB.Y-GOTO@jp.fujitsu.com>
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

Index: pxm_ver4/arch/x86_64/mm/srat.c
===================================================================
--- pxm_ver4.orig/arch/x86_64/mm/srat.c	2006-03-30 09:35:03.000000000 +0900
+++ pxm_ver4/arch/x86_64/mm/srat.c	2006-03-30 18:50:33.847831171 +0900
@@ -22,35 +22,15 @@
 static struct acpi_table_slit *acpi_slit;
 
 static nodemask_t nodes_parsed __initdata;
-static nodemask_t nodes_found __initdata;
 static struct bootnode nodes[MAX_NUMNODES] __initdata;
-static u8 pxm2node[256] = { [0 ... 255] = 0xff };
 
 /* Too small nodes confuse the VM badly. Usually they result
    from BIOS bugs. */
 #define NODE_MIN_SIZE (4*1024*1024)
 
-static int node_to_pxm(int n);
-
-int pxm_to_node(int pxm)
-{
-	if ((unsigned)pxm >= 256)
-		return -1;
-	/* Extend 0xff to (int)-1 */
-	return (signed char)pxm2node[pxm];
-}
-
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
@@ -292,17 +272,6 @@ int __init acpi_scan_nodes(unsigned long
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
Index: pxm_ver4/include/asm-x86_64/numa.h
===================================================================
--- pxm_ver4.orig/include/asm-x86_64/numa.h	2006-03-30 09:35:13.000000000 +0900
+++ pxm_ver4/include/asm-x86_64/numa.h	2006-03-30 18:50:33.885917108 +0900
@@ -8,7 +8,6 @@ struct bootnode {
 };
 
 extern int compute_hash_shift(struct bootnode *nodes, int numnodes);
-extern int pxm_to_node(int nid);
 
 #define ZONE_ALIGN (1UL << (MAX_ORDER+PAGE_SHIFT))
 

-- 
Yasunori Goto 


