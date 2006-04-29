Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWD2BVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWD2BVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 21:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWD2BVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 21:21:30 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:48842 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750869AbWD2BV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 21:21:28 -0400
Message-Id: <20060429011908.790087000@localhost.localdomain>
References: <20060429011827.502138000@localhost.localdomain>
Date: Sat, 29 Apr 2006 03:18:30 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 3/4] powerpc: Allow devices to register with numa topology
Content-Disposition: inline; filename=spufs-node-to-nid-2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Kerr <jk@ozlabs.org>

Change of_node_to_nid() to traverse the device tree, looking for a numa
id. Cell uses this to assign ids to SPUs, which are children of the CPU
node. Existing users of of_node_to_nid() are altered to use
of_node_to_nid_single(), which doesn't do the traversal.

Export an attach_sysdev_to_node() function, allowing system devices (eg.
SPUs) to link themselves into the numa topology in sysfs.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/mm/numa.c
===================================================================
--- linus-2.6.orig/arch/powerpc/mm/numa.c	2006-04-29 01:50:25.000000000 +0200
+++ linus-2.6/arch/powerpc/mm/numa.c	2006-04-29 02:02:28.000000000 +0200
@@ -194,7 +194,7 @@
 /* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
  * info is found.
  */
-static int of_node_to_nid(struct device_node *device)
+static int of_node_to_nid_single(struct device_node *device)
 {
 	int nid = -1;
 	unsigned int *tmp;
@@ -216,6 +216,28 @@
 	return nid;
 }
 
+/* Walk the device tree upwards, looking for an associativity id */
+int of_node_to_nid(struct device_node *device)
+{
+	struct device_node *tmp;
+	int nid = -1;
+
+	of_node_get(device);
+	while (device) {
+		nid = of_node_to_nid_single(device);
+		if (nid != -1)
+			break;
+
+	        tmp = device;
+		device = of_get_parent(tmp);
+		of_node_put(tmp);
+	}
+	of_node_put(device);
+
+	return nid;
+}
+EXPORT_SYMBOL_GPL(of_node_to_nid);
+
 /*
  * In theory, the "ibm,associativity" property may contain multiple
  * associativity lists because a resource may be multiply connected
@@ -300,7 +322,7 @@
 		goto out;
 	}
 
-	nid = of_node_to_nid(cpu);
+	nid = of_node_to_nid_single(cpu);
 
 	if (nid < 0 || !node_online(nid))
 		nid = any_online_node(NODE_MASK_ALL);
@@ -393,7 +415,7 @@
 
 		cpu = find_cpu_node(i);
 		BUG_ON(!cpu);
-		nid = of_node_to_nid(cpu);
+		nid = of_node_to_nid_single(cpu);
 		of_node_put(cpu);
 
 		/*
@@ -437,7 +459,7 @@
 		 * have associativity properties.  If none, then
 		 * everything goes to default_nid.
 		 */
-		nid = of_node_to_nid(memory);
+		nid = of_node_to_nid_single(memory);
 		if (nid < 0)
 			nid = default_nid;
 		node_set_online(nid);
@@ -776,7 +798,7 @@
 ha_new_range:
 		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
 		size = read_n_cells(n_mem_size_cells, &memcell_buf);
-		nid = of_node_to_nid(memory);
+		nid = of_node_to_nid_single(memory);
 
 		/* Domains not present at boot default to 0 */
 		if (nid < 0 || !node_online(nid))
Index: linus-2.6/include/asm-powerpc/topology.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/topology.h	2006-04-29 01:50:25.000000000 +0200
+++ linus-2.6/include/asm-powerpc/topology.h	2006-04-29 02:02:28.000000000 +0200
@@ -4,6 +4,9 @@
 
 #include <linux/config.h>
 
+struct sys_device;
+struct device_node;
+
 #ifdef CONFIG_NUMA
 
 #include <asm/mmzone.h>
@@ -27,6 +30,8 @@
 	return first_cpu(tmp);
 }
 
+int of_node_to_nid(struct device_node *device);
+
 #define pcibus_to_node(node)    (-1)
 #define pcibus_to_cpumask(bus)	(cpu_online_map)
 
@@ -57,10 +62,29 @@
 
 extern void __init dump_numa_cpu_topology(void);
 
+extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
+extern void sysfs_remove_device_from_node(struct sys_device *dev, int nid);
+
 #else
 
+static inline int of_node_to_nid(struct device_node *device)
+{
+	return 0;
+}
+
 static inline void dump_numa_cpu_topology(void) {}
 
+static inline int sysfs_add_device_to_node(struct sys_device *dev, int nid)
+{
+	return 0;
+}
+
+static inline void sysfs_remove_device_from_node(struct sys_device *dev,
+						int nid)
+{
+}
+
+
 #include <asm-generic/topology.h>
 
 #endif /* CONFIG_NUMA */
Index: linus-2.6/arch/powerpc/kernel/sysfs.c
===================================================================
--- linus-2.6.orig/arch/powerpc/kernel/sysfs.c	2006-04-29 01:50:25.000000000 +0200
+++ linus-2.6/arch/powerpc/kernel/sysfs.c	2006-04-29 02:02:28.000000000 +0200
@@ -322,13 +322,31 @@
 		}
 	}
 }
+
+int sysfs_add_device_to_node(struct sys_device *dev, int nid)
+{
+	struct node *node = &node_devices[nid];
+	return sysfs_create_link(&node->sysdev.kobj, &dev->kobj,
+			kobject_name(&dev->kobj));
+}
+
+void sysfs_remove_device_from_node(struct sys_device *dev, int nid)
+{
+	struct node *node = &node_devices[nid];
+	sysfs_remove_link(&node->sysdev.kobj, kobject_name(&dev->kobj));
+}
+
 #else
 static void register_nodes(void)
 {
 	return;
 }
+
 #endif
 
+EXPORT_SYMBOL_GPL(sysfs_add_device_to_node);
+EXPORT_SYMBOL_GPL(sysfs_remove_device_from_node);
+
 /* Only valid if CPU is present. */
 static ssize_t show_physical_id(struct sys_device *dev, char *buf)
 {

--

