Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbTGDCAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbTGDB7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:59:03 -0400
Received: from granite.he.net ([216.218.226.66]:25614 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265658AbTGDByy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:54 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845532660@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845524168@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1365, 2003/07/03 15:51:15-07:00, willy@debian.org

[PATCH] PCI: pci_find_bus needs a domain
Give pci_find_bus a domain argument and move its declaration to <linux/pci.h>


 drivers/pci/hotplug/acpiphp_glue.c     |    2 +-
 drivers/pci/hotplug/cpci_hotplug_pci.c |    2 +-
 drivers/pci/hotplug/ibmphp_core.c      |    6 +++---
 drivers/pci/pci.h                      |    1 -
 drivers/pci/search.c                   |   18 ++++++++++--------
 include/linux/pci.h                    |    1 +
 6 files changed, 16 insertions(+), 14 deletions(-)


diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Thu Jul  3 18:17:01 2003
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Thu Jul  3 18:17:01 2003
@@ -385,7 +385,7 @@
 	bridge->seg = seg;
 	bridge->bus = bus;
 
-	bridge->pci_bus = pci_find_bus(bus);
+	bridge->pci_bus = pci_find_bus(seg, bus);
 
 	bridge->res_lock = SPIN_LOCK_UNLOCKED;
 
diff -Nru a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c	Thu Jul  3 18:17:01 2003
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c	Thu Jul  3 18:17:01 2003
@@ -395,7 +395,7 @@
 
 	/* Scan behind bridge */
 	n = pci_scan_bridge(bus, dev, max, 2);
-	child = pci_find_bus(max + 1);
+	child = pci_find_bus(0, max + 1);
 	if (!child)
 		return -ENODEV;
 	pci_proc_attach_bus(child);
diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	Thu Jul  3 18:17:01 2003
+++ b/drivers/pci/hotplug/ibmphp_core.c	Thu Jul  3 18:17:01 2003
@@ -774,7 +774,7 @@
 	struct pci_dev *dev;
 	u16 l;
 
-	if (pci_find_bus(busno) || !(ibmphp_find_same_bus_num (busno)))
+	if (pci_find_bus(0, busno) || !(ibmphp_find_same_bus_num (busno)))
 		return 1;
 
 	bus = kmalloc (sizeof (*bus), GFP_KERNEL);
@@ -819,7 +819,7 @@
 		func->dev = pci_find_slot (func->busno, PCI_DEVFN(func->device, func->function));
 
 	if (func->dev == NULL) {
-		struct pci_bus *bus = pci_find_bus(func->busno);
+		struct pci_bus *bus = pci_find_bus(0, func->busno);
 		if (!bus)
 			return 0;
 
@@ -1335,7 +1335,7 @@
 		goto exit;
 	}
 
-	bus = pci_find_bus(0);
+	bus = pci_find_bus(0, 0);
 	if (!bus) {
 		err ("Can't find the root pci bus, can not continue\n");
 		rc = -ENODEV;
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Thu Jul  3 18:17:01 2003
+++ b/drivers/pci/pci.h	Thu Jul  3 18:17:01 2003
@@ -29,7 +29,6 @@
 extern unsigned char pci_max_busnr(void);
 extern unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 extern int pci_bus_find_capability (struct pci_bus *bus, unsigned int devfn, int cap);
-extern struct pci_bus *pci_find_bus(unsigned char busnr);
 
 struct pci_dev_wrapped {
 	struct pci_dev	*dev;
diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Thu Jul  3 18:17:01 2003
+++ b/drivers/pci/search.c	Thu Jul  3 18:17:01 2003
@@ -31,22 +31,24 @@
 }
 
 /**
- * pci_find_bus - locate PCI bus from a given bus number
+ * pci_find_bus - locate PCI bus from a given domain and bus number
+ * @domain: number of PCI domain to search
  * @busnr: number of desired PCI bus
  *
- * Given a PCI bus number, the desired PCI bus is located in system
- * global list of PCI buses.  If the bus is found, a pointer to its
+ * Given a PCI bus number and domain number, the desired PCI bus is located
+ * in the global list of PCI buses.  If the bus is found, a pointer to its
  * data structure is returned.  If no bus is found, %NULL is returned.
  */
-struct pci_bus *
-pci_find_bus(unsigned char busnr)
+struct pci_bus * pci_find_bus(int domain, int busnr)
 {
-	struct pci_bus* bus = NULL;
-	struct pci_bus* tmp_bus;
+	struct pci_bus *bus = NULL;
+	struct pci_bus *tmp_bus;
 
 	while ((bus = pci_find_next_bus(bus)) != NULL)  {
+		if (pci_domain_nr(bus) != domain)
+			continue;
 		tmp_bus = pci_do_find_bus(bus, busnr);
-		if(tmp_bus)
+		if (tmp_bus)
 			return tmp_bus;
 	}
 	return NULL;
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jul  3 18:17:01 2003
+++ b/include/linux/pci.h	Thu Jul  3 18:17:01 2003
@@ -543,6 +543,7 @@
 
 /* Generic PCI functions used internally */
 
+extern struct pci_bus *pci_find_bus(int domain, int busnr);
 int pci_bus_exists(const struct list_head *list, int nr);
 struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata);
 static inline struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata)

