Return-Path: <linux-kernel-owner+w=401wt.eu-S1760288AbWLKIWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760288AbWLKIWj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 03:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762648AbWLKIWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 03:22:39 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:47522 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760288AbWLKIWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 03:22:38 -0500
Date: Mon, 11 Dec 2006 17:20:52 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [Patch](memory hotplug) Fix compile error for i386 with NUMA config
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64N.0612102351280.9898@attu4.cs.washington.edu>
References: <20061211115829.AD68.Y-GOTO@jp.fujitsu.com> <Pine.LNX.4.64N.0612102351280.9898@attu4.cs.washington.edu>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20061211171544.AD72.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.27 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > No.
> > Other arch's arch_add_memory() and remove_memory() have been already
> > used for NUMA case too. But i386 didn't do it because just 
> > contig_page_data is used. 
> > Current NODE_DATA() macro is defined both case appropriately.
> > So, this #ifdef is redundant now.
> > 
> 
> Then I assume the comment directly above this change is also redundant 
> since it explicitly states that the following code is for the non-NUMA 
> case.

Ahhhhh. Yes indeed.

Here is fixed patch. Thanks for your comment.

Bye.


-------

This patch is to fix compile error when config memory hotplug
with numa on i386.

The cause of compile error was missing of arch_add_memory(), remove_memory(),
and memory_add_physaddr_to_nid().

This is for 2.6.19, and I tested no compile error of it.

Please apply.

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>

---
 arch/i386/mm/discontig.c |   17 +++++++++++++++++
 arch/i386/mm/init.c      |    9 +--------
 2 files changed, 18 insertions(+), 8 deletions(-)

Index: linux-2.6.19/arch/i386/mm/init.c
===================================================================
--- linux-2.6.19.orig/arch/i386/mm/init.c	2006-12-09 17:42:06.000000000 +0900
+++ linux-2.6.19/arch/i386/mm/init.c	2006-12-11 16:58:49.000000000 +0900
@@ -675,16 +675,10 @@
 #endif
 }
 
-/*
- * this is for the non-NUMA, single node SMP system case.
- * Specifically, in the case of x86, we will always add
- * memory to the highmem for now.
- */
 #ifdef CONFIG_MEMORY_HOTPLUG
-#ifndef CONFIG_NEED_MULTIPLE_NODES
 int arch_add_memory(int nid, u64 start, u64 size)
 {
-	struct pglist_data *pgdata = &contig_page_data;
+	struct pglist_data *pgdata = NODE_DATA(nid);
 	struct zone *zone = pgdata->node_zones + ZONE_HIGHMEM;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
@@ -697,7 +691,6 @@
 	return -EINVAL;
 }
 #endif
-#endif
 
 kmem_cache_t *pgd_cache;
 kmem_cache_t *pmd_cache;
Index: linux-2.6.19/arch/i386/mm/discontig.c
===================================================================
--- linux-2.6.19.orig/arch/i386/mm/discontig.c	2006-12-09 17:42:06.000000000 +0900
+++ linux-2.6.19/arch/i386/mm/discontig.c	2006-12-09 17:58:32.000000000 +0900
@@ -405,3 +405,20 @@
 	totalram_pages += totalhigh_pages;
 #endif
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+/* This is the case that there is no _PXM on DSDT for added memory */
+int memory_add_physaddr_to_nid(u64 addr)
+{
+	int nid;
+	unsigned long pfn = addr >> PAGE_SHIFT;
+
+	for (nid = 0; nid < MAX_NUMNODES; nid++){
+		if (node_start_pfn[nid] <= pfn &&
+		    pfn < node_end_pfn[nid])
+			return nid;
+	}
+
+	return 0;
+}
+#endif

-- 
Yasunori Goto 


