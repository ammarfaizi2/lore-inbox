Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbUJXJpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUJXJpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbUJXJpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:45:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24199 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261407AbUJXJnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:43:19 -0400
Date: Sun, 24 Oct 2004 05:42:24 -0400
From: Nathan Lynch <nathanl@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, rusty@rustcorp.com.au, mochel@digitalimplant.org,
       Nathan Lynch <nathanl@austin.ibm.com>, anton@samba.org
Message-Id: <20041024094606.28808.7701.89376@biclops>
In-Reply-To: <20041024094551.28808.28284.87316@biclops>
References: <20041024094551.28808.28284.87316@biclops>
Subject: [RFC/PATCH 2/4] drivers/base/node.c changes for dynamic cpu registration
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Register numa node system devices in the core code instead of leaving
it to the architecture.  Add an array of MAX_NUMNODES node devices and
register those which are online at boot.  Create sysfs symlinks to
each node's cpu devices.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN drivers/base/node.c~move-node-sysdev-registration-to-core drivers/base/node.c
--- 2.6.10-rc1/drivers/base/node.c~move-node-sysdev-registration-to-core	2004-10-24 03:52:53.000000000 -0500
+++ 2.6.10-rc1-nathanl/drivers/base/node.c	2004-10-24 03:52:53.000000000 -0500
@@ -9,7 +9,9 @@
 #include <linux/node.h>
 #include <linux/hugetlb.h>
 #include <linux/cpumask.h>
+#include <linux/nodemask.h>
 #include <linux/topology.h>
+#include <linux/cpu.h>
 
 static struct sysdev_class node_class = {
 	set_kset_name("node"),
@@ -133,9 +135,65 @@ int __init register_node(struct node *no
 	return error;
 }
 
+static struct node *node_devices;
+
+static int node_cpu_add_dev (struct sys_device * sys_dev)
+{
+	unsigned int cpu = sys_dev->id;
+	int ret, node = cpu_to_node(cpu);
+
+	ret = sysfs_create_link(&node_devices[node].sysdev.kobj,
+				&sys_dev->kobj,
+				kobject_name(&sys_dev->kobj));
+	return ret;
+}
+
+static int node_cpu_remove_dev (struct sys_device * sys_dev)
+{
+	unsigned int cpu = sys_dev->id;
+	int node = cpu_to_node(cpu);
+
+	sysfs_remove_link(&node_devices[node].sysdev.kobj,
+				kobject_name(&sys_dev->kobj));
+	return 0;
+
+}
+
+/* Methods for notifying us when cpus are added and removed */
+static struct sysdev_driver node_cpu_sysdev_driver = {
+	.add		= node_cpu_add_dev,
+	.remove		= node_cpu_remove_dev,
+};
 
 int __init register_node_type(void)
 {
-	return sysdev_class_register(&node_class);
+	int i, ret = 0;
+	size_t size = sizeof(*node_devices) * num_online_nodes();
+
+	sysdev_class_register(&node_class);
+
+	node_devices = kmalloc(size, GFP_KERNEL);
+	if (!node_devices)
+		return -ENOMEM;
+
+	memset(node_devices, 0, size);
+
+	for_each_online_node(i) {
+		int pnum = parent_node(i);
+		struct node *parent = NULL;
+
+		if (pnum != i)
+			parent = &node_devices[pnum];
+
+		ret = register_node(&node_devices[i], i, parent);
+
+		if (ret)
+			goto out;
+	}
+
+	ret = sysdev_driver_register(&cpu_sysdev_class,
+				     &node_cpu_sysdev_driver);
+out:
+	return ret;
 }
 postcore_initcall(register_node_type);

_
