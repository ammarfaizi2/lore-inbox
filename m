Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWIVGVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWIVGVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWIVGVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:21:40 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:32910 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750704AbWIVGVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:21:38 -0400
Date: Fri, 22 Sep 2006 15:24:47 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "tony.luck@intel.com" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, GOTO <y-goto@jp.fujitsu.com>
Subject: [BUGFIX][PATCH] cpu to node relationship fixup take2 [1/2]
 acpi_map_cpu2node
Message-Id: <20060922152447.42a83860.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I rewrote the whoe patch..

Problem description:
We have additional_cpus= option for allocating possible_cpus. But nid for
possible cpus are not fixed at boot time. cpus which is offlined at boot 
or cpus which is not on SRAT is not tied to its node.
This will cause panic at cpu onlining.

Changelog V1 -> V2
- divded patch into 2 pathces.
- move cpu_to_node relationship fixup before cpu onlining.

Tested on ia64/NUMA system, which has *physical* node-hot-add function.

Future work:  node-hot-add by cpu-hot-add.

-Kame

==
In usual, pxm_to_nid() mapping is fixed at boot time by SRAT.

But, unfortunatelly, some system (my system!) do not include
full SRAT table for possible cpus. (Then, I use additiona_cpus= option.)

For such possible cpus, pxm<->nid should be fixed at hot-add.
We now have acpi_map_pxm_to_node() which is also used at boot. It's suitable
here.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 arch/ia64/kernel/acpi.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: linux-2.6.18/arch/ia64/kernel/acpi.c
===================================================================
--- linux-2.6.18.orig/arch/ia64/kernel/acpi.c	2006-09-22 13:39:12.000000000 +0900
+++ linux-2.6.18/arch/ia64/kernel/acpi.c	2006-09-22 14:24:48.000000000 +0900
@@ -771,16 +771,19 @@
 {
 #ifdef CONFIG_ACPI_NUMA
 	int pxm_id;
+	int nid;
 
 	pxm_id = acpi_get_pxm(handle);
-
 	/*
-	 * Assuming that the container driver would have set the proximity
-	 * domain and would have initialized pxm_to_node(pxm_id) && pxm_flag
+	 * We don't have cpu-only-node hotadd. But if the system equips
+	 * SRAT table, pxm is already found and node is ready.
+  	 * So, just pxm_to_nid(pxm) is OK.
+	 * This code here is for the system which doesn't have full SRAT
+  	 * table for possible cpus.
 	 */
-	node_cpuid[cpu].nid = (pxm_id < 0) ? 0 : pxm_to_node(pxm_id);
-
+	nid = acpi_map_pxm_to_node(pxm_id);
 	node_cpuid[cpu].phys_id = physid;
+	node_cpuid[cpu].nid = nid;
 #endif
 	return (0);
 }

