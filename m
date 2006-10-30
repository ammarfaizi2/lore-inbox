Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWJ3OP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWJ3OP2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWJ3OP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:15:28 -0500
Received: from verein.lst.de ([213.95.11.210]:57814 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751662AbWJ3OP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:15:27 -0500
Date: Mon, 30 Oct 2006 15:15:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, linux-mm@kvack.org
Subject: [PATCH 2/3] add dev_to_node()
Message-ID: <20061030141501.GC7164@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davem suggested to get the node-affinity information directly from
struct device instead of having the caller extreact it from the
pci_dev.  This patch adds dev_to_node() to the topology API for that.
The implementation is rather ugly as we need to compare the bus
operations which we can't do inline in a header without pulling all
kinds of mess in.

Thus provide an out of line dev_to_node for ppc and let everyone else
use the dummy variant in asm-generic.h for now.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/include/asm-generic/topology.h
===================================================================
--- linux-2.6.orig/include/asm-generic/topology.h	2006-10-10 14:53:52.000000000 +0200
+++ linux-2.6/include/asm-generic/topology.h	2006-10-30 13:42:22.000000000 +0100
@@ -45,11 +45,14 @@
 #define pcibus_to_node(node)	(-1)
 #endif
 
+#ifndef dev_to_node
+#define dev_to_node(dev)	(-1)
+#endif
+
 #ifndef pcibus_to_cpumask
 #define pcibus_to_cpumask(bus)	(pcibus_to_node(bus) == -1 ? \
 					CPU_MASK_ALL : \
 					node_to_cpumask(pcibus_to_node(bus)) \
 				)
 #endif
-
 #endif /* _ASM_GENERIC_TOPOLOGY_H */
Index: linux-2.6/include/asm-powerpc/topology.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/topology.h	2006-10-10 14:53:52.000000000 +0200
+++ linux-2.6/include/asm-powerpc/topology.h	2006-10-30 14:03:44.000000000 +0100
@@ -5,6 +5,7 @@
 
 struct sys_device;
 struct device_node;
+struct device;
 
 #ifdef CONFIG_NUMA
 
@@ -33,6 +34,7 @@
 
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *bus);
+int dev_to_node(struct device *dev);
 
 #define pcibus_to_cpumask(bus)	(pcibus_to_node(bus) == -1 ? \
 					CPU_MASK_ALL : \
Index: linux-2.6/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci_64.c	2006-10-23 17:21:43.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/pci_64.c	2006-10-30 14:02:40.000000000 +0100
@@ -1424,4 +1424,12 @@
 	return phb->node;
 }
 EXPORT_SYMBOL(pcibus_to_node);
+
+int dev_to_node(struct device *dev)
+{
+	if (dev->bus == &pci_bus_type)
+		return pcibus_to_node(to_pci_dev(dev)->bus);
+	return -1;
+}
+EXPORT_SYMBOL(dev_to_node);
 #endif
