Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWCQIX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWCQIX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 03:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWCQIXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 03:23:47 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:24273 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964942AbWCQIX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 03:23:28 -0500
Date: Fri, 17 Mar 2006 17:22:28 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH: 011/017]Memory hotplug for new nodes v.4.(start kswapd)
Cc: "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, linux-mm <linux-mm@kvack.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060317163538.C64D.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When node is hot-added, kswapd for the node should start.
This export kswapd start function as kswapd_run().


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 include/linux/swap.h |    5 +++++
 mm/vmscan.c          |   35 ++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 9 deletions(-)

Index: pgdat8/mm/vmscan.c
===================================================================
--- pgdat8.orig/mm/vmscan.c	2006-03-16 16:05:38.000000000 +0900
+++ pgdat8/mm/vmscan.c	2006-03-16 16:06:27.000000000 +0900
@@ -35,6 +35,7 @@
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1843,20 +1844,36 @@ static int __devinit cpu_callback(struct
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
Index: pgdat8/include/linux/swap.h
===================================================================
--- pgdat8.orig/include/linux/swap.h	2006-03-16 16:05:38.000000000 +0900
+++ pgdat8/include/linux/swap.h	2006-03-16 16:06:27.000000000 +0900
@@ -208,6 +208,11 @@ static inline int migrate_pages(struct l
 #define fail_migrate_page NULL
 #endif
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+/* start new kswapd for new node */
+extern int kswapd_run(int nid);
+#endif
+
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
 extern int shmem_unuse(swp_entry_t entry, struct page *page);

-- 
Yasunori Goto 


