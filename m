Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWBJOWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWBJOWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWBJOWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:22:20 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:19345 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932108AbWBJOVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:21:52 -0500
Date: Fri, 10 Feb 2006 23:21:23 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Subject: [RFC/PATCH: 007/010] Memory hotplug for new nodes with pgdat allocation. (pgdat link insert)
Cc: x86-64 Discuss <discuss@x86-64.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060210224529.C53E.Y-GOTO@jp.fujitsu.com>
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

This is small lazy patch instead of them.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Index: pgdat2/arch/ia64/mm/discontig.c
===================================================================
--- pgdat2.orig/arch/ia64/mm/discontig.c	2006-02-10 17:40:05.000000000 +0900
+++ pgdat2/arch/ia64/mm/discontig.c	2006-02-10 19:42:27.000000000 +0900
@@ -384,7 +384,7 @@ static void __init *memory_less_node_all
  * pgdat_insert - insert the pgdat into global pgdat_list
  * @pgdat: the pgdat for a node.
  */
-static void __init pgdat_insert(pg_data_t *pgdat)
+void __meminit pgdat_insert(pg_data_t *pgdat)
 {
 	pg_data_t *prev = NULL, *next;
 
Index: pgdat2/arch/ia64/mm/init.c
===================================================================
--- pgdat2.orig/arch/ia64/mm/init.c	2006-02-10 17:29:30.000000000 +0900
+++ pgdat2/arch/ia64/mm/init.c	2006-02-10 19:42:41.000000000 +0900
@@ -647,6 +647,8 @@ void online_page(struct page *page)
 	num_physpages++;
 }
 
+extern void __meminit pgdat_insert(pg_data_t *pgdat);
+
 int add_memory(u64 start, u64 size)
 {
 	pg_data_t *pgdat;
@@ -663,6 +665,7 @@ int add_memory(u64 start, u64 size)
 
 	if (!node_online(node)){
 		ret = new_pgdat_init(node, start_pfn, nr_pages);
+		pgdat_insert(NODE_DATA(node));
 		if (ret)
 			return ret;
 

-- 
Yasunori Goto 


