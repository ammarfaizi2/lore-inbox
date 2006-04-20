Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWDTKMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWDTKMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWDTKLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:11:53 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:14792 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750831AbWDTKL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:11:27 -0400
Date: Thu, 20 Apr 2006 19:10:22 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [Patch: 005/006] pgdat allocation for new node add (export kswapd start func)
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
References: <20060420185123.EE48.Y-GOTO@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060420190713.EE52.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When node is hot-added, kswapd for the node should start.
This export kswapd start function as kswapd_run() to use at add_memory().


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 include/linux/swap.h |    2 ++
 mm/vmscan.c          |   35 ++++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

Index: pgdat11/mm/vmscan.c
===================================================================
--- pgdat11.orig/mm/vmscan.c	2006-04-20 11:00:07.000000000 +0900
+++ pgdat11/mm/vmscan.c	2006-04-20 11:00:33.000000000 +0900
@@ -35,6 +35,7 @@
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1353,20 +1354,36 @@ static int __devinit cpu_callback(struct
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+/*
+ * This kswapd start function will be called by init and node-hot-add.
+ * On node-hot-add, kswapd will moved to proper cpus if cpus are hot-added.
+ */
+int kswapd_run(int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+	int ret = 0;
+
+	if (pgdat->kswapd)
+		return 0;
+
+	pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
+	if (pgdat->kswapd == ERR_PTR(-ENOMEM)) {
+		/* failure at boot is fatal */
+		BUG_ON(system_state == SYSTEM_BOOTING);
+		printk("faled to run kswapd on node %d\n",nid);
+		ret = -1;
+	}
+	return ret;
+}
+
 static int __init kswapd_init(void)
 {
-	pg_data_t *pgdat;
+	int nid;
 
 	swap_setup();
-	for_each_online_pgdat(pgdat) {
-		pid_t pid;
+	for_each_online_node(nid)
+ 		kswapd_run(nid);
 
-		pid = kernel_thread(kswapd, pgdat, CLONE_KERNEL);
-		BUG_ON(pid < 0);
-		read_lock(&tasklist_lock);
-		pgdat->kswapd = find_task_by_pid(pid);
-		read_unlock(&tasklist_lock);
-	}
 	total_memory = nr_free_pagecache_pages();
 	hotcpu_notifier(cpu_callback, 0);
 	return 0;
Index: pgdat11/include/linux/swap.h
===================================================================
--- pgdat11.orig/include/linux/swap.h	2006-04-20 11:00:07.000000000 +0900
+++ pgdat11/include/linux/swap.h	2006-04-20 11:00:33.000000000 +0900
@@ -212,6 +212,8 @@ static inline int zone_reclaim(struct zo
 }
 #endif
 
+extern int kswapd_run(int nid);
+
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);

-- 
Yasunori Goto 


