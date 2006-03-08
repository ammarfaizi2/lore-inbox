Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWCHNlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWCHNlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWCHNlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:41:16 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:41657 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751374AbWCHNlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:41:15 -0500
Date: Wed, 08 Mar 2006 22:41:10 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Joel Schopp <jschopp@austin.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH: 001/017](RFC) Memory hotplug for new nodes v.3. (Generic code of pgdat alloc)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060308212442.0024.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds node-hot-add support to add_memory().

node hotadd uses this sequence.
1. allocate pgdat.
2. refresh NODE_DATA()
3. call free_area_init_node() to initialize
4. create sysfs entry
5. add memory (old add_memory())
6. set node online
7. run kswapd for new node.
(8). update zonelist after pages are onlined. (This is in other patch due to
   update phase is difference.)

Note:
  To make common function as much as possible, 
  there is 2 changes from v2.
    - The old add_memory(), which is defiend by each archs,
      is renamed to arch_add_memory(). New add_memory becomes
      caller of arch dependent function as a common code.
  
    - This patch changes add_memory()'s interface
        From: add_memory(start, end)
        TO  : add_memory(nid, start, end).
      It was cause of similar code that finding node id from
      physical address is inside of old add_memory() on each arch. 
      
      In addition, acpi memory hotplug driver can find node id easier.
      In v2, it must walk DSDT'S _CRS by matching physical address to
      get the handle of its memory device, then get _PXM and node id.
      Because input is just physical address. 
      However, in v3, the acpi driver can use handle to get _PXM and node id
      for the new memory device. It can pass just node id to add_memory().


Fix interface of arch_add_memory() is in next patche.

Signed-off-by: Yasunori Goto     <y-goto@jp.fujitsu.com>
Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: pgdat7/mm/memory_hotplug.c
===================================================================
--- pgdat7.orig/mm/memory_hotplug.c	2006-03-08 20:33:44.000000000 +0900
+++ pgdat7/mm/memory_hotplug.c	2006-03-08 20:35:48.000000000 +0900
@@ -135,3 +135,71 @@ int online_pages(unsigned long pfn, unsi
 
 	return 0;
 }
+
+static pg_data_t *hotadd_new_pgdat(int nid, u64 start)
+{
+	struct pglist_data *pgdat;
+	unsigned long zones_size[MAX_NR_ZONES] = {0};
+	unsigned long zholes_size[MAX_NR_ZONES] = {0};
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+
+	pgdat = arch_alloc_nodedata(nid);
+	if (!pgdat)
+		return NULL;
+
+	arch_refresh_nodedata(nid, pgdat);
+
+	/* we can use NODE_DATA(nid) from here */
+
+	/* init node's zones as empty zones, we don't have any present pages.*/
+	free_area_init_node(nid, pgdat, zones_size, start_pfn, zholes_size);
+
+	/*
+         * register this node to sysfs.
+         * this is depends on topology. So each arch has its own.
+         */
+	arch_register_node(nid);
+
+	return pgdat;
+}
+
+void rollback_node_hotadd(int nid, pg_data_t *pgdat)
+{
+	arch_refresh_nodedata(nid, NULL);
+	arch_free_nodedata(pgdat);
+	return;
+}
+
+int add_memory(int nid, u64 start, u64 end)
+{
+	pg_data_t *pgdat = NULL;
+	int new_pgdat = 0;
+	int ret;
+
+	if (!node_online(nid)) {
+		pgdat = hotadd_new_pgdat(nid, start);
+		if (!pgdat)
+			return -ENOMEM;
+		new_pgdat = 1;
+		ret = kswapd_run(nid);
+		if (ret)
+			goto error;
+	}
+	/* call arch's memory hotadd */
+	ret = arch_add_memory(nid, start, end);
+
+	if (!ret < 0)
+		goto error;
+
+	/* we online node here. we have no error path from here. */
+	node_set_online(nid);
+
+	return ret;
+error:
+	/* rollback pgdat allocation and others */
+	if (new_pgdat)
+		rollback_node_hotadd(nid, pgdat);
+
+	return ret;
+}
+
Index: pgdat7/include/linux/memory_hotplug.h
===================================================================
--- pgdat7.orig/include/linux/memory_hotplug.h	2006-03-08 20:35:02.000000000 +0900
+++ pgdat7/include/linux/memory_hotplug.h	2006-03-08 20:35:48.000000000 +0900
@@ -59,7 +59,8 @@ extern int add_one_highpage(struct page 
 /* need some defines for these for archs that don't support it */
 extern void online_page(struct page *page);
 /* VM interface that may be used by firmware interface */
-extern int add_memory(u64 start, u64 size);
+extern int add_memory(int nid, u64 start, u64 size);
+extern int arch_add_memory(int nid, u64 start, u64 size);
 extern int remove_memory(u64 start, u64 size);
 extern int online_pages(unsigned long, unsigned long);
 

-- 
Yasunori Goto 


