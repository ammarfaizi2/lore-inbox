Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbUKXROm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbUKXROm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbUKXRDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:03:51 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61638 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262621AbUKXQ5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:57:32 -0500
Date: Wed, 24 Nov 2004 10:57:24 -0600
From: Jack Steiner <steiner@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] - Externel SLIT table information thru sysfs
Message-ID: <20041124165724.GA14544@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ACPI SLIT table provides useful information on internode distances.
Here is a patch to externalize the SLIT information. 

For example:

        # cd /sys/devices/system
        # find .
        ./node
        ./node/node5
        ./node/node5/distance
        ./node/node5/numastat
        ./node/node5/meminfo
        ./node/node5/cpumap

        # cat ./node/node0/distance
        10 20 64 42 42 22

        # cat node/*/distance
        10 20 64 42 42 22
        20 10 42 22 64 84
        64 42 10 20 22 42
        42 22 20 10 42 62
        42 64 22 42 10 20
        22 84 42 62 20 10





Signed-off-by: Jack Steiner <steiner@sgi.com>


Add SLIT (inter node distance) information to sysfs. 



Index: linux/drivers/base/node.c
===================================================================
--- linux.orig/drivers/base/node.c	2004-11-05 08:34:42.461312000 -0600
+++ linux/drivers/base/node.c	2004-11-05 15:56:23.345662000 -0600
@@ -111,6 +111,24 @@ static ssize_t node_read_numastat(struct
 }
 static SYSDEV_ATTR(numastat, S_IRUGO, node_read_numastat, NULL);
 
+static ssize_t node_read_distance(struct sys_device * dev, char * buf)
+{
+	int nid = dev->id;
+	int len = 0;
+	int i;
+
+	/* buf currently PAGE_SIZE, need ~4 chars per node */
+	BUILD_BUG_ON(NR_NODES*4 > PAGE_SIZE/2);
+
+	for (i = 0; i < numnodes; i++)
+		len += sprintf(buf + len, "%s%d", i ? " " : "", node_distance(nid, i));
+		
+	len += sprintf(buf + len, "\n");
+	return len;
+}
+static SYSDEV_ATTR(distance, S_IRUGO, node_read_distance, NULL);
+
+
 /*
  * register_node - Setup a driverfs device for a node.
  * @num - Node number to use when creating the device.
@@ -129,6 +147,7 @@ int __init register_node(struct node *no
 		sysdev_create_file(&node->sysdev, &attr_cpumap);
 		sysdev_create_file(&node->sysdev, &attr_meminfo);
 		sysdev_create_file(&node->sysdev, &attr_numastat);
+		sysdev_create_file(&node->sysdev, &attr_distance);
 	}
 	return error;
 }
Index: linux/include/asm-i386/topology.h
===================================================================
--- linux.orig/include/asm-i386/topology.h	2004-11-05 08:34:53.713053000 -0600
+++ linux/include/asm-i386/topology.h	2004-11-23 09:59:43.574062951 -0600
@@ -66,9 +66,6 @@ static inline cpumask_t pcibus_to_cpumas
 	return node_to_cpumask(mp_bus_id_to_node[bus]);
 }
 
-/* Node-to-Node distance */
-#define node_distance(from, to) ((from) != (to))
-
 /* sched_domains SD_NODE_INIT for NUMAQ machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
 	.span			= CPU_MASK_NONE,	\
Index: linux/include/linux/topology.h
===================================================================
--- linux.orig/include/linux/topology.h	2004-11-05 08:34:57.492932000 -0600
+++ linux/include/linux/topology.h	2004-11-23 10:03:26.700821978 -0600
@@ -55,7 +55,10 @@ static inline int __next_node_with_cpus(
 	for (node = 0; node < numnodes; node = __next_node_with_cpus(node))
 
 #ifndef node_distance
-#define node_distance(from,to)	((from) != (to))
+/* Conform to ACPI 2.0 SLIT distance definitions */
+#define LOCAL_DISTANCE		10
+#define REMOTE_DISTANCE		20
+#define node_distance(from,to)	((from) == (to) ? LOCAL_DISTANCE : REMOTE_DISTANCE)
 #endif
 #ifndef PENALTY_FOR_NODE_WITH_CPUS
 #define PENALTY_FOR_NODE_WITH_CPUS	(1)
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


