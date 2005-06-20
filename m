Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVFUCyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVFUCyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVFUCyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 22:54:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:13796 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261669AbVFTW7i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:59:38 -0400
Cc: tokunaga.keiich@jp.fujitsu.com
Subject: [PATCH] Driver core: unregister_node() for hotplug use
In-Reply-To: <11193083671865@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 15:59:27 -0700
Message-Id: <1119308367735@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Driver core: unregister_node() for hotplug use

This adds a generic function 'unregister_node()'.
It is used to remove objects of a node going away
for hotplug.  All the devices on the node must be
unregistered before calling this function.

Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff -puN drivers/base/node.c~numa_hp_base drivers/base/node.c

---
commit 4b45099b75832434c5113b9aed1499f8a69d13d5
tree dbb6cf4a3937120be0cfd6f4699926fa4689ac8d
parent f409661877a25d11c2495bcd879807f17c286684
author Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com> Sun, 08 May 2005 21:28:53 +0900
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:29 -0700

 drivers/base/node.c  |   20 ++++++++++++++++++--
 include/linux/node.h |    1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -136,7 +136,7 @@ static SYSDEV_ATTR(distance, S_IRUGO, no
  *
  * Initialize and register the node device.
  */
-int __init register_node(struct node *node, int num, struct node *parent)
+int register_node(struct node *node, int num, struct node *parent)
 {
 	int error;
 
@@ -153,8 +153,24 @@ int __init register_node(struct node *no
 	return error;
 }
 
+/**
+ * unregister_node - unregister a node device
+ * @node: node going away
+ *
+ * Unregisters a node device @node.  All the devices on the node must be
+ * unregistered before calling this function.
+ */
+void unregister_node(struct node *node)
+{
+	sysdev_remove_file(&node->sysdev, &attr_cpumap);
+	sysdev_remove_file(&node->sysdev, &attr_meminfo);
+	sysdev_remove_file(&node->sysdev, &attr_numastat);
+	sysdev_remove_file(&node->sysdev, &attr_distance);
+
+	sysdev_unregister(&node->sysdev);
+}
 
-int __init register_node_type(void)
+static int __init register_node_type(void)
 {
 	return sysdev_class_register(&node_class);
 }
diff --git a/include/linux/node.h b/include/linux/node.h
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -27,6 +27,7 @@ struct node {
 };
 
 extern int register_node(struct node *, int, struct node *);
+extern void unregister_node(struct node *node);
 
 #define to_node(sys_device) container_of(sys_device, struct node, sysdev)
 

