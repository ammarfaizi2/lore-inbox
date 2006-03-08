Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWCHNle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWCHNle (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWCHNle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:41:34 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:9370 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751374AbWCHNlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:41:21 -0500
Date: Wed, 08 Mar 2006 22:41:19 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 002/017](RFC) Memory hotplug for new nodes v.3. (change name old add_memory() to arch_add_memory()) 
Cc: linux-ia64@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308212547.0026.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes name of old add_memory() to arch_add_memory.
and use node id to get pgdat for the node at NODE_DATA().

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat6/arch/i386/mm/init.c
===================================================================
--- pgdat6.orig/arch/i386/mm/init.c	2006-03-06 19:16:38.000000000 +0900
+++ pgdat6/arch/i386/mm/init.c	2006-03-06 19:34:53.000000000 +0900
@@ -652,7 +652,7 @@ void __init mem_init(void)
  * memory to the highmem for now.
  */
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-int add_memory(u64 start, u64 size)
+int arch_add_memory(int nid, u64 start, u64 size)
 {
 	struct pglist_data *pgdata = &contig_page_data;
 	struct zone *zone = pgdata->node_zones + MAX_NR_ZONES-1;
Index: pgdat6/arch/ia64/mm/init.c
===================================================================
--- pgdat6.orig/arch/ia64/mm/init.c	2006-03-06 19:16:38.000000000 +0900
+++ pgdat6/arch/ia64/mm/init.c	2006-03-06 19:34:53.000000000 +0900
@@ -646,7 +646,7 @@ void online_page(struct page *page)
 	num_physpages++;
 }
 
-int add_memory(u64 start, u64 size)
+int arch_add_memory(int nid, u64 start, u64 size)
 {
 	pg_data_t *pgdat;
 	struct zone *zone;
@@ -654,7 +654,7 @@ int add_memory(u64 start, u64 size)
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
-	pgdat = NODE_DATA(0);
+	pgdat = NODE_DATA(nid);
 
 	zone = pgdat->node_zones + ZONE_NORMAL;
 	ret = __add_pages(zone, start_pfn, nr_pages);
Index: pgdat6/arch/powerpc/mm/mem.c
===================================================================
--- pgdat6.orig/arch/powerpc/mm/mem.c	2006-03-06 19:16:38.000000000 +0900
+++ pgdat6/arch/powerpc/mm/mem.c	2006-03-06 19:34:53.000000000 +0900
@@ -114,15 +114,13 @@ void online_page(struct page *page)
 	num_physpages++;
 }
 
-int __devinit add_memory(u64 start, u64 size)
+int __devinit arch_add_memory(int nid, u64 start, u64 size)
 {
 	struct pglist_data *pgdata;
 	struct zone *zone;
-	int nid;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
-	nid = hot_add_scn_to_nid(start);
 	pgdata = NODE_DATA(nid);
 
 	start = __va(start);
Index: pgdat6/arch/x86_64/mm/init.c
===================================================================
--- pgdat6.orig/arch/x86_64/mm/init.c	2006-03-06 19:16:38.000000000 +0900
+++ pgdat6/arch/x86_64/mm/init.c	2006-03-06 19:34:53.000000000 +0900
@@ -493,9 +493,9 @@ void online_page(struct page *page)
 	num_physpages++;
 }
 
-int add_memory(u64 start, u64 size)
+int arch_add_memory(int nid, u64 start, u64 size)
 {
-	struct pglist_data *pgdat = NODE_DATA(0);
+	struct pglist_data *pgdat = NODE_DATA(nid);
 	struct zone *zone = pgdat->node_zones + MAX_NR_ZONES-2;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;

-- 
Yasunori Goto 


