Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbUCQVhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 16:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUCQVhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 16:37:37 -0500
Received: from galileo.bork.org ([66.11.174.156]:16778 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S262087AbUCQVhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 16:37:14 -0500
Date: Wed, 17 Mar 2004 16:37:14 -0500
From: Martin Hicks <mort@wildopensource.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Subject: Exporting physical topology information
Message-ID: <20040317213714.GD23195@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

I'm trying to figure out what the best way is to export a minimal amount
of physical topology information to userland.  Would it be acceptable to
export this kind of information with sysfs?

I'm not proposing that we build an entire physical topology tree in
sysfs, but just providing an attribute file.  The two most obvious
examples of where this would be useful is for nodes and pci busses.  The
Altix platform is a modular system with CPU bricks and IO bricks.  We
currently have no method for locating where "node0" is, nor do we have a
method for locating pci bus 0000:20, for example.

If we could physically locate a PCI bus, then it would be much easier
to (for example) locate our defective SCSI disk that is target4 on the
SCSI controller that is on pci bus 0000:20.

The attached patch, care of Jesse Barnes, exports a physid attribute for
each node, which indicates the physical location of the node.  Altix
specific.

thanks
mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="physid.patch"

===== arch/ia64/mm/numa.c 1.7 vs edited =====
--- 1.7/arch/ia64/mm/numa.c	Tue Feb  3 21:35:17 2004
+++ edited/arch/ia64/mm/numa.c	Mon Mar 15 11:14:51 2004
@@ -19,6 +19,8 @@
 #include <linux/bootmem.h>
 #include <asm/mmzone.h>
 #include <asm/numa.h>
+#include <asm/sn/nodepda.h>
+#include <asm/sn/module.h>
 
 static struct node *sysfs_nodes;
 static struct cpu *sysfs_cpus;
@@ -48,6 +50,13 @@
 			break;
 
 	return (i < num_node_memblks) ? node_memblk[i].nid : (num_node_memblks ? -1 : 0);
+}
+
+void node_to_physid(int node, char *buf)
+{
+     struct nodepda_s *nodeinfo = NODEPDA(node);
+
+     format_module_id(buf, nodeinfo->module->id, MODULE_FORMAT_BRIEF);
 }
 
 static int __init topology_init(void)
===== drivers/base/node.c 1.18 vs edited =====
--- 1.18/drivers/base/node.c	Thu Feb 12 22:35:40 2004
+++ edited/drivers/base/node.c	Mon Mar 15 11:12:14 2004
@@ -56,6 +56,17 @@
 static SYSDEV_ATTR(meminfo,S_IRUGO,node_read_meminfo,NULL);
 
 
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
@@ -67,6 +78,7 @@
 	int error;
 
 	node->cpumap = node_to_cpumask(num);
+	node_to_physid(num, node->physid);
 	node->sysdev.id = num;
 	node->sysdev.cls = &node_class;
 	error = sysdev_register(&node->sysdev);
@@ -74,6 +86,7 @@
 	if (!error){
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
 		sysdev_create_file(&node->sysdev, &attr_meminfo);
+		sysdev_create_file(&node->sysdev, &attr_physid);
 	}
 	return error;
 }
===== include/asm-ia64/topology.h 1.10 vs edited =====
--- 1.10/include/asm-ia64/topology.h	Tue Feb  3 21:35:17 2004
+++ edited/include/asm-ia64/topology.h	Mon Mar 15 11:12:15 2004
@@ -45,6 +45,8 @@
 
 void build_cpu_to_node_map(void);
 
+extern void node_to_physid(int node, char *buf);
+
 #endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
===== include/linux/node.h 1.5 vs edited =====
--- 1.5/include/linux/node.h	Mon Aug 18 19:46:23 2003
+++ edited/include/linux/node.h	Mon Mar 15 11:12:17 2004
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
 

--nFreZHaLTZJo0R7j--
