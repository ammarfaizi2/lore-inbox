Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWC1KRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWC1KRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWC1KRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:17:33 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:58586 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751209AbWC1KRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:17:31 -0500
Date: Tue, 28 Mar 2006 19:17:14 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch:003/004]Unify pxm_to_node id ver.3.(for x86-64)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       ACPI-ML <linux-acpi@vger.kernel.org>, linux-ia64@vger.kernel.org,
       x86-64 Discuss <discuss@x86-64.org>
In-Reply-To: <20060328183058.CC46.Y-GOTO@jp.fujitsu.com>
References: <20060328183058.CC46.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060328191359.CC4C.Y-GOTO@jp.fujitsu.com>
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

Index: pxm_ver3/arch/x86_64/mm/srat.c
===================================================================
--- pxm_ver3.orig/arch/x86_64/mm/srat.c	2006-03-27 12:09:14.000000000 +0900
+++ pxm_ver3/arch/x86_64/mm/srat.c	2006-03-27 14:07:14.000000000 +0900
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
Index: pxm_ver3/include/asm-x86_64/numa.h
===================================================================
--- pxm_ver3.orig/include/asm-x86_64/numa.h	2006-03-27 12:09:17.000000000 +0900
+++ pxm_ver3/include/asm-x86_64/numa.h	2006-03-27 14:05:12.000000000 +0900
@@ -9,7 +9,6 @@ struct bootnode {
 };
 
 extern int compute_hash_shift(struct bootnode *nodes, int numnodes);
-extern int pxm_to_node(int nid);
 
 #define ZONE_ALIGN (1UL << (MAX_ORDER+PAGE_SHIFT))
 

-- 
Yasunori Goto 


