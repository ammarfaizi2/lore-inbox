Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWBQNdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWBQNdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWBQNaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:30:14 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:12753 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964907AbWBQNaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:30:04 -0500
Date: Fri, 17 Feb 2006 22:29:35 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 009/012] Memory hotplug for new nodes v.2 (pgdat link insert)
Cc: Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060217213711.407A.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is to insert pgdat to its link.
To be honest, I would like remove this pgdat link, and
I posted patches to remove it for a long time ago to -mm.

http://marc.theaimsgroup.com/?l=linux-mm&m=112808582217281&w=2
http://marc.theaimsgroup.com/?l=linux-mm&m=112808582227966&w=2

But, it might have influence against performance for big NUMA box.
So, I should check it.
However, I'm very hard to access big NUMA box. Our machine is 
divided as small partitioned for test of each team inside of fujitsu
every time. Sigh. :-(. 

This is lazy patch instead of them.
To use this code for x86_64, this code is moved to generic place.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


Index: pgdat3/arch/ia64/mm/discontig.c
===================================================================
--- pgdat3.orig/arch/ia64/mm/discontig.c	2006-02-17 16:52:52.000000000 +0900
+++ pgdat3/arch/ia64/mm/discontig.c	2006-02-17 18:35:33.000000000 +0900
@@ -381,31 +381,6 @@ static void __init *memory_less_node_all
 }
 
 /**
- * pgdat_insert - insert the pgdat into global pgdat_list
- * @pgdat: the pgdat for a node.
- */
-static void __init pgdat_insert(pg_data_t *pgdat)
-{
-	pg_data_t *prev = NULL, *next;
-
-	for_each_pgdat(next)
-		if (pgdat->node_id < next->node_id)
-			break;
-		else
-			prev = next;
-
-	if (prev) {
-		prev->pgdat_next = pgdat;
-		pgdat->pgdat_next = next;
-	} else {
-		pgdat->pgdat_next = pgdat_list;
-		pgdat_list = pgdat;
-	}
-
-	return;
-}
-
-/**
  * memory_less_nodes - allocate and initialize CPU only nodes pernode
  *	information.
  */
Index: pgdat3/mm/page_alloc.c
===================================================================
--- pgdat3.orig/mm/page_alloc.c	2006-02-17 16:52:50.000000000 +0900
+++ pgdat3/mm/page_alloc.c	2006-02-17 16:52:53.000000000 +0900
@@ -1575,6 +1575,31 @@ void show_free_areas(void)
 	show_swap_cache_info();
 }
 
+/**
+ * pgdat_insert - insert the pgdat into global pgdat_list
+ * @pgdat: the pgdat for a node.
+ */
+void __meminit pgdat_insert(pg_data_t *pgdat)
+{
+	pg_data_t *prev = NULL, *next;
+
+	for_each_pgdat(next)
+		if (pgdat->node_id < next->node_id)
+			break;
+		else
+			prev = next;
+
+	if (prev) {
+		prev->pgdat_next = pgdat;
+		pgdat->pgdat_next = next;
+	} else {
+		pgdat->pgdat_next = pgdat_list;
+		pgdat_list = pgdat;
+	}
+
+	return;
+}
+
 /*
  * Builds allocation fallback zone lists.
  *
Index: pgdat3/mm/memory_hotplug.c
===================================================================
--- pgdat3.orig/mm/memory_hotplug.c	2006-02-17 16:52:50.000000000 +0900
+++ pgdat3/mm/memory_hotplug.c	2006-02-17 16:52:53.000000000 +0900
@@ -57,6 +57,7 @@ static int __add_section(struct zone *zo
 	return register_new_memory(__pfn_to_section(phys_start_pfn));
 }
 
+extern void __meminit pgdat_insert(pg_data_t *pgdat);
 extern int kswapd(void *);
 int new_pgdat_init(int nid, unsigned long start_pfn, unsigned long nr_pages)
 {
@@ -89,6 +90,7 @@ int new_pgdat_init(int nid, unsigned lon
 
 	pgdat->kswapd = p;
 	node_set_online(nid);
+	pgdat_insert(pgdat);
 	arch_register_node(nid);
 
 	return 0;
Index: pgdat3/include/linux/mmzone.h
===================================================================
--- pgdat3.orig/include/linux/mmzone.h	2006-02-17 16:52:50.000000000 +0900
+++ pgdat3/include/linux/mmzone.h	2006-02-17 18:39:48.000000000 +0900
@@ -650,6 +650,7 @@ void sparse_init(void);
 
 void memory_present(int nid, unsigned long start, unsigned long end);
 unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
+extern void __meminit pgdat_insert(pg_data_t *);
 
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */

-- 
Yasunori Goto 


