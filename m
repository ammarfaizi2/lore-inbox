Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUCSSxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263063AbUCSSxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:53:48 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:11508 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263059AbUCSSxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:53:42 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Exporting physical topology information
Date: Fri, 19 Mar 2004 10:53:38 -0800
User-Agent: KMail/1.6.1
References: <20040317213714.GD23195@localhost> <200403190951.52899.jbarnes@sgi.com> <20040319175957.GB10432@kroah.com>
In-Reply-To: <20040319175957.GB10432@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403191053.38131.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 March 2004 9:59 am, Greg KH wrote:
> Hm, that looks to violate the "one value per file" mandate of sysfs,
> right?  Right now PCI Hotplug slots have a LED on them that you can

Yeah... my original patch to implement node physids used the Altix
module id, which looks like rrrtss, where rrr is a rack id, t is a
brick type, and ss is the rack slot, e.g. 001c12, so it was one value.
The example above was just brainstorming, I'm sure there are better
ways to do it.

> flash from userspace to help locate the physical slot that you want to
> change.  I also know of large PCI drawers that have LEDs that flash to
> locate them.

Yeah, that makes things easy, but it would be nice to cover CPUs and
memory banks too, so you can go remove the DIMM with a persistent
single or double bit error, or a CPU with a bad cache or whatever.  I
imagine some hardware has blinking lights for that too.

> Also, this is _very_ hardware/platform specific.  If you want to try to
> implement this, I'd be interested in what the patch would look like.

Here's the (very platform specific) patch I did for Altix, just to see
what it would look like, and to solicit comments.  There's some other
per-node stuff that would be nice to have available to userspace too,
mostly for administrative purposes, like the chipset revision and
type, firmware revision, and other hardware specific details.  One way
to export that sort of thing is with some sort of arbitrary data blob,
but like you said, that violates the sysfs one file, one value
principle.

Thanks,
Jesse


===== arch/ia64/mm/numa.c 1.6 vs edited =====
--- 1.6/arch/ia64/mm/numa.c	Sun Jan 11 22:54:38 2004
+++ edited/arch/ia64/mm/numa.c	Fri Jan 23 11:56:48 2004
@@ -20,6 +20,8 @@
 #include <linux/bootmem.h>
 #include <asm/mmzone.h>
 #include <asm/numa.h>
+#include <asm/sn/nodepda.h>
+#include <asm/sn/module.h>
 
 static struct memblk *sysfs_memblks;
 static struct node *sysfs_nodes;
@@ -50,6 +52,13 @@
 			break;
 
 	return (i < num_memblks) ? node_memblk[i].nid : (num_memblks ? -1 : 0);
+}
+
+void node_to_physid(int node, char *buf)
+{
+	struct nodepda_s *nodeinfo = NODEPDA(node);
+
+	format_module_id(buf, nodeinfo->module->id, MODULE_FORMAT_BRIEF);
 }
 
 static int __init topology_init(void)
===== drivers/base/node.c 1.16 vs edited =====
--- 1.16/drivers/base/node.c	Mon Dec 29 13:37:47 2003
+++ edited/drivers/base/node.c	Fri Jan 23 12:25:44 2004
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
 	error = sys_device_register(&node->sysdev);
@@ -74,6 +86,7 @@
 	if (!error){
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
 		sysdev_create_file(&node->sysdev, &attr_meminfo);
+		sysdev_create_file(&node->sysdev, &attr_physid);
 	}
 	return error;
 }
===== include/asm-ia64/topology.h 1.9 vs edited =====
--- 1.9/include/asm-ia64/topology.h	Wed Jun 18 18:38:50 2003
+++ edited/include/asm-ia64/topology.h	Fri Jan 23 11:40:51 2004
@@ -60,6 +60,8 @@
 
 void build_cpu_to_node_map(void);
 
+extern void node_to_physid(int node, char *buf);
+
 #endif /* CONFIG_NUMA */
 
 #include <asm-generic/topology.h>
===== include/asm-ia64/sn/module.h 1.10 vs edited =====
--- 1.10/include/asm-ia64/sn/module.h	Sun Jan 18 22:36:15 2004
+++ edited/include/asm-ia64/sn/module.h	Fri Jan 23 11:38:34 2004
@@ -14,6 +14,7 @@
 
 
 #include <linux/config.h>
+#include <asm/sn/sgi.h>
 #include <asm/sn/klconfig.h>
 #include <asm/sn/ksys/elsc.h>
 
===== include/linux/node.h 1.5 vs edited =====
--- 1.5/include/linux/node.h	Mon Aug 18 19:46:23 2003
+++ edited/include/linux/node.h	Fri Jan 23 11:32:44 2004
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
 

