Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVDAXzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVDAXzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVDAXtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:49:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:25564 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262807AbVDAXsJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:09 -0500
Cc: matthew@wil.cx
Subject: [PATCH] PCI busses are structs, not integers
In-Reply-To: <11123992711084@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:52 -0800
Message-Id: <11123992723300@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.13, 2005/03/17 14:31:48-08:00, matthew@wil.cx

[PATCH] PCI busses are structs, not integers

PCI busses are structs, not integers.  Fix pcibus_to_cpumask to take
a struct.  NB changing it from a macro to an inline function would
require serious include file surgery.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 arch/x86_64/kernel/pci-gart.c |    2 +-
 drivers/pci/pci-sysfs.c       |    2 +-
 drivers/pci/probe.c           |    2 +-
 include/asm-i386/topology.h   |    7 ++++---
 include/asm-x86_64/topology.h |    3 +--
 5 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/arch/x86_64/kernel/pci-gart.c b/arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	2005-04-01 15:35:55 -08:00
+++ b/arch/x86_64/kernel/pci-gart.c	2005-04-01 15:35:55 -08:00
@@ -193,7 +193,7 @@
 	int node;
 	if (dev->bus == &pci_bus_type) {
 		cpumask_t mask;
-		mask = pcibus_to_cpumask(to_pci_dev(dev)->bus->number);
+		mask = pcibus_to_cpumask(to_pci_dev(dev)->bus);
 		node = cpu_to_node(first_cpu(mask));
 	} else
 		node = numa_node_id();
diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	2005-04-01 15:35:55 -08:00
+++ b/drivers/pci/pci-sysfs.c	2005-04-01 15:35:55 -08:00
@@ -46,7 +46,7 @@
 
 static ssize_t local_cpus_show(struct device *dev, char *buf)
 {		
-	cpumask_t mask = pcibus_to_cpumask(to_pci_dev(dev)->bus->number);
+	cpumask_t mask = pcibus_to_cpumask(to_pci_dev(dev)->bus);
 	int len = cpumask_scnprintf(buf, PAGE_SIZE-2, mask);
 	strcat(buf,"\n"); 
 	return 1+len;
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-04-01 15:35:55 -08:00
+++ b/drivers/pci/probe.c	2005-04-01 15:35:55 -08:00
@@ -80,7 +80,7 @@
  */
 static ssize_t pci_bus_show_cpuaffinity(struct class_device *class_dev, char *buf)
 {
-	cpumask_t cpumask = pcibus_to_cpumask((to_pci_bus(class_dev))->number);
+	cpumask_t cpumask = pcibus_to_cpumask(to_pci_bus(class_dev));
 	int ret;
 
 	ret = cpumask_scnprintf(buf, PAGE_SIZE, cpumask);
diff -Nru a/include/asm-i386/topology.h b/include/asm-i386/topology.h
--- a/include/asm-i386/topology.h	2005-04-01 15:35:55 -08:00
+++ b/include/asm-i386/topology.h	2005-04-01 15:35:55 -08:00
@@ -60,11 +60,12 @@
 	return first_cpu(mask);
 }
 
-/* Returns the number of the node containing PCI bus 'bus' */
-static inline cpumask_t pcibus_to_cpumask(int bus)
+/* Returns the number of the node containing PCI bus number 'busnr' */
+static inline cpumask_t __pcibus_to_cpumask(int busnr)
 {
-	return node_to_cpumask(mp_bus_id_to_node[bus]);
+	return node_to_cpumask(mp_bus_id_to_node[busnr]);
 }
+#define pcibus_to_cpumask(bus)	__pcibus_to_cpumask(bus->number)
 
 /* sched_domains SD_NODE_INIT for NUMAQ machines */
 #define SD_NODE_INIT (struct sched_domain) {		\
diff -Nru a/include/asm-x86_64/topology.h b/include/asm-x86_64/topology.h
--- a/include/asm-x86_64/topology.h	2005-04-01 15:35:55 -08:00
+++ b/include/asm-x86_64/topology.h	2005-04-01 15:35:55 -08:00
@@ -35,8 +35,7 @@
 	cpus_and(res, busmask, online);
 	return res;
 }
-/* broken generic file uses #ifndef later on this */
-#define pcibus_to_cpumask(bus) __pcibus_to_cpumask(bus)
+#define pcibus_to_cpumask(bus) __pcibus_to_cpumask(bus->number)
 
 #ifdef CONFIG_NUMA
 /* sched_domains SD_NODE_INIT for x86_64 machines */

