Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUC2MY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUC2MXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:23:33 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:23481 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262866AbUC2MQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:16:00 -0500
Date: Mon, 29 Mar 2004 04:15:04 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: ppc64 changes from Matthew's nodemask_t Patch 4/7
 [13/22]
Message-Id: <20040329041504.689996d5.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_13_of_22 - Matthew Dobson's [PATCH]_nodemask_t_pp64_changes_[4_7]
	Changes to ppc64 specific code.  Untested.
	Code review & testing requested.

diffstat Patch_13_of_22:
 kernel/smp.c     |   20 +++++++++-----------
 mm/hugetlbpage.c |   10 +++++-----
 mm/init.c        |    2 +-
 mm/numa.c        |   11 ++++++-----
 4 files changed, 21 insertions(+), 22 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1719  -> 1.1720 
#	arch/ppc64/mm/hugetlbpage.c	1.8     -> 1.9    
#	arch/ppc64/mm/init.c	1.63    -> 1.64   
#	arch/ppc64/mm/numa.c	1.20    -> 1.21   
#	arch/ppc64/kernel/smp.c	1.57    -> 1.58   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1720
# Matthew Dobson's [PATCH]_nodemask_t_pp64_changes_[4_7] of 18 Mar 2004:
#   Changes to ppc64 specific code.  Untested.
#   Code review & testing requested.
# --------------------------------------------
#
diff -Nru a/arch/ppc64/kernel/smp.c b/arch/ppc64/kernel/smp.c
--- a/arch/ppc64/kernel/smp.c	Mon Mar 29 01:03:52 2004
+++ b/arch/ppc64/kernel/smp.c	Mon Mar 29 01:03:52 2004
@@ -737,19 +737,17 @@
 	int i;
 	int ret;
 
-	for (i = 0; i < MAX_NUMNODES; i++) {
-		if (node_online(i)) {
-			int p_node = parent_node(i);
-			struct node *parent = NULL;
+	for_each_online_node(i) {
+		int p_node = parent_node(i);
+		struct node *parent = NULL;
 
-			if (p_node != i)
-				parent = &node_devices[p_node];
+		if (p_node != i)
+			parent = &node_devices[p_node];
 
-			ret = register_node(&node_devices[i], i, parent);
-			if (ret)
-				printk(KERN_WARNING "register_nodes: "
-				       "register_node %d failed (%d)", i, ret);
-		}
+		ret = register_node(&node_devices[i], i, parent);
+		if (ret)
+			printk(KERN_WARNING "register_nodes: "
+			       "register_node %d failed (%d)", i, ret);
 	}
 }
 #else
diff -Nru a/arch/ppc64/mm/hugetlbpage.c b/arch/ppc64/mm/hugetlbpage.c
--- a/arch/ppc64/mm/hugetlbpage.c	Mon Mar 29 01:03:52 2004
+++ b/arch/ppc64/mm/hugetlbpage.c	Mon Mar 29 01:03:52 2004
@@ -56,10 +56,10 @@
 	if (!largepage_roundrobin)
 		nid = numa_node_id();
 
-	for (i = 0; i < numnodes; i++) {
+	for_each_online_node(i) {
 		if (!list_empty(&hugepage_freelists[nid]))
 			break;
-		nid = (nid + 1) % numnodes;
+		nid = (nid + 1) % num_online_nodes();
 	}
 
 	if (!list_empty(&hugepage_freelists[nid])) {
@@ -68,7 +68,7 @@
 	}
 
 	if (largepage_roundrobin)
-		nid = (nid + 1) % numnodes;
+		nid = (nid + 1) % num_online_nodes();
 
 	return page;
 }
@@ -83,7 +83,7 @@
 		return NULL;
 
 	nid = page_zone(page)->zone_pgdat->node_id;
-	nid = (nid + 1) % numnodes;
+	nid = (nid + 1) % num_online_nodes();
 	return page;
 }
 
@@ -871,7 +871,7 @@
 	struct page *page;
 
 	if (cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE) {
-		for (i = 0; i < MAX_NUMNODES; ++i)
+		for_each_node(i)
 			INIT_LIST_HEAD(&hugepage_freelists[i]);
 
 		for (i = 0; i < htlbpage_max; ++i) {
diff -Nru a/arch/ppc64/mm/init.c b/arch/ppc64/mm/init.c
--- a/arch/ppc64/mm/init.c	Mon Mar 29 01:03:52 2004
+++ b/arch/ppc64/mm/init.c	Mon Mar 29 01:03:52 2004
@@ -639,7 +639,7 @@
 {
 	int nid;
 
-        for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		if (node_data[nid].node_spanned_pages != 0) {
 			printk("freeing bootmem node %x\n", nid);
 			totalram_pages +=
diff -Nru a/arch/ppc64/mm/numa.c b/arch/ppc64/mm/numa.c
--- a/arch/ppc64/mm/numa.c	Mon Mar 29 01:03:52 2004
+++ b/arch/ppc64/mm/numa.c	Mon Mar 29 01:03:52 2004
@@ -101,7 +101,7 @@
 			numa_domain = 0;
 		}
 
-		if (numa_domain >= MAX_NUMNODES)
+		if (!node_possible(numa_domain))
 			BUG();
 
 		node_set_online(numa_domain);
@@ -157,7 +157,7 @@
 			numa_domain = 0;
 		}
 
-		if (numa_domain >= MAX_NUMNODES)
+		if (!node_possible(numa_domain))
 			BUG();
 
 		if (max_domain < numa_domain)
@@ -198,7 +198,8 @@
 			goto new_range;
 	}
 
-	numnodes = max_domain + 1;
+	for(i = 0; i <= max_domain; i++)
+		node_set_online(i);
 
 	return 0;
 err:
@@ -242,7 +243,7 @@
 	if (parse_numa_properties())
 		setup_nonnuma();
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_paddr, end_paddr;
 		int i;
 		unsigned long bootmem_paddr;
@@ -329,7 +330,7 @@
 	memset(zones_size, 0, sizeof(zones_size));
 	memset(zholes_size, 0, sizeof(zholes_size));
 
-	for (nid = 0; nid < numnodes; nid++) {
+	for_each_online_node(nid) {
 		unsigned long start_pfn;
 		unsigned long end_pfn;
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
