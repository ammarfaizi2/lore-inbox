Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUIWQha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUIWQha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUIWQh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:37:29 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50819 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268107AbUIWQfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:35:24 -0400
Date: Fri, 24 Sep 2004 01:31:23 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
To: anil.s.keshavamurthy@intel.com
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [PATCH][1/4] Add unregister_node() to drivers/base/node.c
Message-Id: <20040924013123.000067cd.tokunaga.keiich@jp.fujitsu.com>
In-Reply-To: <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
References: <20040920092520.A14208@unix-os.sc.intel.com>
	<20040920094719.H14208@unix-os.sc.intel.com>
	<20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.3.0; Win32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Name: numa_hp_base.patch
Status: Tested on 2.6.9-rc2
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Description:
Create unregister_node() that removes corresponding sysfs directory
and files from /sys/devices/system/node/ at hot-removal time.

Thanks,
Keiichiro Tokunaga
---

 linux-2.6.9-rc2-fix-kei/drivers/base/node.c  |   16 +++++++++++++++-
 linux-2.6.9-rc2-fix-kei/include/linux/node.h |    1 +
 linux-2.6.9-rc2-fix-kei/mm/page_alloc.c      |    2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
--- linux-2.6.9-rc2-fix/drivers/base/node.c~numa_hp_base	2004-09-24 00:14:55.659950914 +0900
+++ linux-2.6.9-rc2-fix-kei/drivers/base/node.c	2004-09-24 00:14:55.668740028 +0900
@@ -117,7 +117,7 @@ static SYSDEV_ATTR(numastat, S_IRUGO, no
  *
  * Initialize and register the node device.
  */
-int __init register_node(struct node *node, int num, struct node *parent)
+int register_node(struct node *node, int num, struct node *parent)
 {
 	int error;
 
@@ -132,6 +132,16 @@ int __init register_node(struct node *no
 	}
 	return error;
 }
+void  unregister_node(struct node *node, struct node *parent)
+{
+	if (node == NULL) {
+		printk("unregister_node: node is null.");
+		return;
+	}
+	sysdev_remove_file(&node->sysdev, &attr_cpumap);
+	sysdev_remove_file(&node->sysdev, &attr_meminfo);
+	sysdev_unregister(&node->sysdev);
+}
 
 
 int __init register_node_type(void)
@@ -139,3 +149,7 @@ int __init register_node_type(void)
 	return sysdev_class_register(&node_class);
 }
 postcore_initcall(register_node_type);
+
+
+EXPORT_SYMBOL(register_node);
+EXPORT_SYMBOL(unregister_node);
diff -puN include/linux/node.h~numa_hp_base include/linux/node.h
--- linux-2.6.9-rc2-fix/include/linux/node.h~numa_hp_base	2004-09-24 00:14:55.664833755 +0900
+++ linux-2.6.9-rc2-fix-kei/include/linux/node.h	2004-09-24 00:14:55.669716596 +0900
@@ -27,6 +27,7 @@ struct node {
 };
 
 extern int register_node(struct node *, int, struct node *);
+extern void  unregister_node(struct node *node, struct node *parent);
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 
diff -puN mm/page_alloc.c~numa_hp_base mm/page_alloc.c
--- linux-2.6.9-rc2-fix/mm/page_alloc.c~numa_hp_base	2004-09-24 00:14:55.666786892 +0900
+++ linux-2.6.9-rc2-fix-kei/mm/page_alloc.c	2004-09-24 00:14:55.670693164 +0900
@@ -14,6 +14,7 @@
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
  */
 
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/stddef.h>
 #include <linux/mm.h>
@@ -44,6 +45,7 @@ int sysctl_lower_zone_protection = 0;
 
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
+EXPORT_SYMBOL(node_online_map);
 
 /*
  * Used by page_zone() to look up the address of the struct zone whose

_
