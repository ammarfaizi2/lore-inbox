Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUGZSy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUGZSy3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 14:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbUGZSy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 14:54:29 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35998 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266181AbUGZQ4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 12:56:21 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [PATCH] physid for nodes
Date: Mon, 26 Jul 2004 09:51:27 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PaTBBjdbiudNemV"
Message-Id: <200407260951.27968.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_PaTBBjdbiudNemV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's the node physid patch refreshed against the latest BK bits.  It works 
ok for nodes, but I'm wondering what to do about other devices.  Is there a 
structure that we could embed the physid string into that would apply to PCI 
devices, busses, CPUs, and memory?  Or should we just add the strings on a 
case-by-case basis?

The ia64 bits also need to be abstracted out...

Thanks,
Jesse

--Boundary-00=_PaTBBjdbiudNemV
Content-Type: text/plain;
  charset="us-ascii";
  name="node-physid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="node-physid.patch"

===== arch/ia64/mm/numa.c 1.7 vs edited =====
--- 1.7/arch/ia64/mm/numa.c	2004-02-03 21:35:17 -08:00
+++ edited/arch/ia64/mm/numa.c	2004-07-26 09:42:34 -07:00
@@ -19,6 +19,8 @@
 #include <linux/bootmem.h>
 #include <asm/mmzone.h>
 #include <asm/numa.h>
+#include <asm/sn/nodepda.h>
+#include <asm/sn/module.h>
 
 static struct node *sysfs_nodes;
 static struct cpu *sysfs_cpus;
@@ -48,6 +50,12 @@
 			break;
 
 	return (i < num_node_memblks) ? node_memblk[i].nid : (num_node_memblks ? -1 : 0);
+}
+
+void node_to_physid(int node, char *buf)
+{
+	struct nodepda_s *nodeinfo = NODEPDA(node);
+	format_module_id(buf, nodeinfo->module->id, MODULE_FORMAT_BRIEF);
 }
 
 static int __init topology_init(void)
===== drivers/base/node.c 1.22 vs edited =====
--- 1.22/drivers/base/node.c	2004-06-27 00:19:31 -07:00
+++ edited/drivers/base/node.c	2004-07-26 09:43:07 -07:00
@@ -101,6 +101,17 @@
 }
 static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
+static ssize_t node_read_physid(struct sys_device * dev, char * buf)
+{
+	struct node *node_dev = to_node(dev);
+	int len;
+
+	len = snprintf(buf, NODE_MAX_PHYSID + 1, "%s\n", node_dev->physid);
+	return len;
+}
+
+static SYSDEV_ATTR(physid,S_IRUGO,node_read_physid,NULL);
+
 /*
  * register_node - Setup a driverfs device for a node.
  * @num - Node number to use when creating the device.
@@ -112,6 +123,7 @@
 	int error;
 
 	node->cpumap = node_to_cpumask(num);
+	node_to_physid(num, node->physid);
 	node->sysdev.id = num;
 	node->sysdev.cls = &node_class;
 	error = sysdev_register(&node->sysdev);
@@ -120,6 +132,7 @@
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
 		sysdev_create_file(&node->sysdev, &attr_meminfo);
 		sysdev_create_file(&node->sysdev, &attr_numastat);
+		sysdev_create_file(&node->sysdev, &attr_physid);
 	}
 	return error;
 }
===== include/asm-ia64/topology.h 1.10 vs edited =====
--- 1.10/include/asm-ia64/topology.h	2004-02-03 21:35:17 -08:00
+++ edited/include/asm-ia64/topology.h	2004-07-26 09:41:24 -07:00
@@ -45,6 +45,8 @@
 
 void build_cpu_to_node_map(void);
 
+extern void node_to_physid(int node, char *buf);
+
 #endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
===== include/asm-ia64/sn/module.h 1.15 vs edited =====
--- 1.15/include/asm-ia64/sn/module.h	2004-06-07 08:45:42 -07:00
+++ edited/include/asm-ia64/sn/module.h	2004-07-26 09:43:29 -07:00
@@ -8,6 +8,7 @@
 #ifndef _ASM_IA64_SN_MODULE_H
 #define _ASM_IA64_SN_MODULE_H
 
+#include <asm/sn/sgi.h>
 #include <asm/sn/klconfig.h>
 #include <asm/sn/ksys/elsc.h>
 
===== include/linux/node.h 1.5 vs edited =====
--- 1.5/include/linux/node.h	2003-08-18 19:46:23 -07:00
+++ edited/include/linux/node.h	2004-07-26 09:41:26 -07:00
@@ -22,8 +22,11 @@
 #include <linux/sysdev.h>
 #include <linux/cpumask.h>
 
+#define NODE_MAX_PHYSID 80
+
 struct node {
 	cpumask_t cpumap;	/* Bitmap of CPUs on the Node */
+	char physid[NODE_MAX_PHYSID]; /* Physical ID of node */
 	struct sys_device	sysdev;
 };
 

--Boundary-00=_PaTBBjdbiudNemV--
