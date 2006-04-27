Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWD0Ls2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWD0Ls2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 07:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWD0Ls2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 07:48:28 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36060 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964986AbWD0Ls1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 07:48:27 -0400
Date: Thu, 27 Apr 2006 20:49:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] register hot-added memory to iomem resource
Message-Id: <20060427204904.5037f6ea.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch registers hot-added memory to iomem_resource.
By this, /proc/iomem can show hot-added memory.
This patch is against 2.6.17-rc2-mm1.

Note: kdump uses /proc/iomem to catch memory range when it is installed.
      So, kdump should be re-installed after /proc/iomem change.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.17-rc2-mm1/mm/memory_hotplug.c
===================================================================
--- linux-2.6.17-rc2-mm1.orig/mm/memory_hotplug.c	2006-04-27 18:00:17.000000000 +0900
+++ linux-2.6.17-rc2-mm1/mm/memory_hotplug.c	2006-04-27 20:21:32.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/memory_hotplug.h>
 #include <linux/highmem.h>
 #include <linux/vmalloc.h>
+#include <linux/ioport.h>
 
 #include <asm/tlbflush.h>
 
@@ -188,6 +189,27 @@
 	return;
 }
 
+/* add this memory to iomem resource */
+static void register_memory_resource(u64 start, u64 size)
+{
+	struct resource *res;
+
+	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
+	BUG_ON(!res);
+
+	res->name = "System RAM";
+	res->start = start;
+	res->end = start + size - 1;
+	res->flags = IORESOURCE_MEM;
+	if (request_resource(&iomem_resource, res) < 0) {
+		printk("System RAM resource %llx - %llx cannot be added\n",
+		(unsigned long long)res->start, (unsigned long long)res->end);
+		kfree(res);
+	}
+}
+
+
+
 int add_memory(int nid, u64 start, u64 size)
 {
 	pg_data_t *pgdat = NULL;
@@ -213,6 +235,9 @@
 	/* we online node here. we have no error path from here. */
 	node_set_online(nid);
 
+	/* register this memory as resource */
+	register_memory_resource(start, size);
+
 	return ret;
 error:
 	/* rollback pgdat allocation and others */

