Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbULWWoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbULWWoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 17:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbULWWod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 17:44:33 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:32205 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261324AbULWWll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 17:41:41 -0500
Subject: [RFC PATCH 5/10] Replace 'numnodes' with 'node_online_map' - m32r
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: LSE Tech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1103838712.3945.12.camel@arrakis>
References: <1103838712.3945.12.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103841695.3945.27.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 14:41:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5/10 - Replace numnodes with node_online_map for m32r

[mcd@arrakis node_online_map]$ diffstat arch-m32r.patch
 kernel/setup.c |    4 +++-
 mm/discontig.c |    6 +++---
 mm/init.c      |    6 +++---
 3 files changed, 9 insertions(+), 7 deletions(-)


-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/m32r/kernel/setup.c linux-2.6.10-rc3-mm1-nom.m32r/arch/m32r/kernel/setup.c
--- linux-2.6.10-rc3-mm1/arch/m32r/kernel/setup.c	2004-12-13 16:23:17.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.m32r/arch/m32r/kernel/setup.c	2004-12-15 15:50:49.000000000 -0800
@@ -251,7 +251,9 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 #ifdef CONFIG_DISCONTIGMEM
-	numnodes = 2;
+	nodes_clear(node_online_map);
+	node_set_online(0);
+	node_set_online(1);
 #endif	/* CONFIG_DISCONTIGMEM */
 
 	init_mm.start_code = (unsigned long) _text;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/m32r/mm/discontig.c linux-2.6.10-rc3-mm1-nom.m32r/arch/m32r/mm/discontig.c
--- linux-2.6.10-rc3-mm1/arch/m32r/mm/discontig.c	2004-12-13 16:23:19.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.m32r/arch/m32r/mm/discontig.c	2004-12-14 11:57:17.000000000 -0800
@@ -75,7 +75,7 @@ unsigned long __init setup_memory(void)
 
 	mem_prof_init();
 
-	for (nid = 0 ; nid < numnodes ; nid++) {
+	for_each_online_node(nid) {
 		mp = &mem_prof[nid];
 		NODE_DATA(nid)=(pg_data_t *)&m32r_node_data[nid];
 		NODE_DATA(nid)->bdata = &node_bdata[nid];
@@ -135,12 +135,12 @@ unsigned long __init zone_sizes_init(voi
 	mem_prof_t *mp;
 
 	pgdat_list = NULL;
-	for (nid = numnodes - 1 ; nid >= 0 ; nid--) {
+	for (nid = num_online_nodes() - 1 ; nid >= 0 ; nid--) {
 		NODE_DATA(nid)->pgdat_next = pgdat_list;
 		pgdat_list = NODE_DATA(nid);
 	}
 
-	for (nid = 0 ; nid < numnodes ; nid++) {
+	for_each_online_node(nid) {
 		mp = &mem_prof[nid];
 		for (i = 0 ; i < MAX_NR_ZONES ; i++) {
 			zones_size[i] = 0;
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc3-mm1/arch/m32r/mm/init.c linux-2.6.10-rc3-mm1-nom.m32r/arch/m32r/mm/init.c
--- linux-2.6.10-rc3-mm1/arch/m32r/mm/init.c	2004-12-13 16:23:19.000000000 -0800
+++ linux-2.6.10-rc3-mm1-nom.m32r/arch/m32r/mm/init.c	2004-12-14 11:57:17.000000000 -0800
@@ -153,7 +153,7 @@ int __init reservedpages_count(void)
 	int reservedpages, nid, i;
 
 	reservedpages = 0;
-	for (nid = 0 ; nid < numnodes ; nid++)
+	for_each_online_node(nid)
 		for (i = 0 ; i < MAX_LOW_PFN(nid) - START_PFN(nid) ; i++)
 			if (PageReserved(NODE_DATA(nid)->node_mem_map + i))
 				reservedpages++;
@@ -174,7 +174,7 @@ void __init mem_init(void)
 #endif
 
 	num_physpages = 0;
-	for (nid = 0 ; nid < numnodes ; nid++)
+	for_each_online_node(nid)
 		num_physpages += MAX_LOW_PFN(nid) - START_PFN(nid) + 1;
 
 	num_physpages -= hole_pages;
@@ -193,7 +193,7 @@ void __init mem_init(void)
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
 	/* this will put all low memory onto the freelists */
-	for (nid = 0 ; nid < numnodes ; nid++)
+	for_each_online_node(nid)
 		totalram_pages += free_all_bootmem_node(NODE_DATA(nid));
 
 	reservedpages = reservedpages_count() - hole_pages;


