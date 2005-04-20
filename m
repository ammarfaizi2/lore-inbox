Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVDTMKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVDTMKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVDTMKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:10:35 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:47597 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261542AbVDTMIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:08:22 -0400
Date: Wed, 20 Apr 2005 21:07:44 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: [RFC/PATCH] unregister_node() for hotplug use
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Message-id: <20050420210744.4013b3f8.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This is to add a generic function 'unregister_node()'.
It is used to remove objects of a node going away for
hotplug.  If CONFIG_HOTPLUG=y, it becomes available.
This is against 2.6.12-rc2-mm3.

Thanks,
Keiichiro Tokunaga

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
---

 linux-2.6.12-rc2-mm3-kei/drivers/base/node.c  |   29 ++++++++++++++++++++++++--
 linux-2.6.12-rc2-mm3-kei/include/linux/node.h |    6 ++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c
--- linux-2.6.12-rc2-mm3/drivers/base/node.c~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
+++ linux-2.6.12-rc2-mm3-kei/drivers/base/node.c	2005-04-14 20:49:37.000000000 +0900
@@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
  *
  * Initialize and register the node device.
  */
-int __init register_node(struct node *node, int num, struct node *parent)
+int __devinit register_node(struct node *node, int num, struct node *parent)
 {
 	int error;
 
@@ -145,6 +145,9 @@ int __init register_node(struct node *no
 	error = sysdev_register(&node->sysdev);
 
 	if (!error){
+		/*
+		 * If you add new object here, delete it when unregistering.
+		 */
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
 		sysdev_create_file(&node->sysdev, &attr_meminfo);
 		sysdev_create_file(&node->sysdev, &attr_numastat);
@@ -153,8 +156,30 @@ int __init register_node(struct node *no
 	return error;
 }
 
+/*
+ * unregister_node - Remove objects of a node going away from sysfs.
+ * @node - node going away
+ *
+ * This is used only for hotplug.
+ */
+#ifdef CONFIG_HOTPLUG
+void unregister_node(struct node *node)
+{
+	if (node == NULL)
+		return;
+
+	sysdev_remove_file(&node->sysdev, &attr_cpumap);
+	sysdev_remove_file(&node->sysdev, &attr_meminfo);
+	sysdev_remove_file(&node->sysdev, &attr_numastat);
+	sysdev_remove_file(&node->sysdev, &attr_distance);
+
+	sysdev_unregister(&node->sysdev);
+}
+EXPORT_SYMBOL(register_node);
+EXPORT_SYMBOL(unregister_node);
+#endif /* CONFIG_HOTPLUG */
 
-int __init register_node_type(void)
+static int __init register_node_type(void)
 {
 	return sysdev_class_register(&node_class);
 }
diff -puN include/linux/node.h~numa_hp_base include/linux/node.h
--- linux-2.6.12-rc2-mm3/include/linux/node.h~numa_hp_base	2005-04-14 20:49:37.000000000 +0900
+++ linux-2.6.12-rc2-mm3-kei/include/linux/node.h	2005-04-14 20:49:37.000000000 +0900
@@ -21,12 +21,16 @@
 
 #include <linux/sysdev.h>
 #include <linux/cpumask.h>
+#include <linux/module.h>
 
 struct node {
 	struct sys_device	sysdev;
 };
 
-extern int register_node(struct node *, int, struct node *);
+extern int __devinit register_node(struct node *, int, struct node *);
+#ifdef CONFIG_HOTPLUG
+extern void unregister_node(struct node *node);
+#endif
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 

_
