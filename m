Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbVAQWna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVAQWna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbVAQWYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:24:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:48551 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262923AbVAQWCA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:00 -0500
Cc: johnrose@austin.ibm.com
Subject: [PATCH] PCI: fix release_pcibus_dev() crash
In-Reply-To: <11059993132995@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 14:01:53 -0800
Message-Id: <11059993132086@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.8, 2005/01/14 15:59:20-08:00, johnrose@austin.ibm.com

[PATCH] PCI: fix release_pcibus_dev() crash

During the course of a hotplug removal of a PCI bus, release_pcibus_dev()
attempts to remove attribute files from a kobject directory that no longer
exists.  This patch moves these calls to pci_remove_bus(), where they can work
as intended.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci.h    |    2 ++
 drivers/pci/probe.c  |   10 +++-------
 drivers/pci/remove.c |   13 ++++++++-----
 3 files changed, 13 insertions(+), 12 deletions(-)


diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	2005-01-17 13:55:30 -08:00
+++ b/drivers/pci/pci.h	2005-01-17 13:55:30 -08:00
@@ -59,12 +59,14 @@
 extern int pci_visit_dev(struct pci_visit *fn,
 			 struct pci_dev_wrapped *wrapped_dev,
 			 struct pci_bus_wrapped *wrapped_parent);
+extern void pci_remove_legacy_files(struct pci_bus *bus);
 
 /* Lock for read/write access to pci device and bus lists */
 extern spinlock_t pci_bus_lock;
 
 extern int pcie_mch_quirk;
 extern struct device_attribute pci_dev_attrs[];
+extern struct class_device_attribute class_device_attr_cpuaffinity;
 
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-01-17 13:55:30 -08:00
+++ b/drivers/pci/probe.c	2005-01-17 13:55:30 -08:00
@@ -62,7 +62,7 @@
 	}
 }
 
-static void pci_remove_legacy_files(struct pci_bus *b)
+void pci_remove_legacy_files(struct pci_bus *b)
 {
 	class_device_remove_bin_file(&b->class_dev, b->legacy_io);
 	class_device_remove_bin_file(&b->class_dev, b->legacy_mem);
@@ -70,7 +70,7 @@
 }
 #else /* !HAVE_PCI_LEGACY */
 static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
-static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
+void pci_remove_legacy_files(struct pci_bus *bus) { return; }
 #endif /* HAVE_PCI_LEGACY */
 
 /*
@@ -86,7 +86,7 @@
 		buf[ret++] = '\n';
 	return ret;
 }
-static CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
+CLASS_DEVICE_ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpuaffinity, NULL);
 
 /*
  * PCI Bus Class
@@ -95,10 +95,6 @@
 {
 	struct pci_bus *pci_bus = to_pci_bus(class_dev);
 
-	pci_remove_legacy_files(pci_bus);
-	class_device_remove_file(&pci_bus->class_dev,
-				 &class_device_attr_cpuaffinity);
-	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
 	if (pci_bus->bridge)
 		put_device(pci_bus->bridge);
 	kfree(pci_bus);
diff -Nru a/drivers/pci/remove.c b/drivers/pci/remove.c
--- a/drivers/pci/remove.c	2005-01-17 13:55:30 -08:00
+++ b/drivers/pci/remove.c	2005-01-17 13:55:30 -08:00
@@ -61,15 +61,18 @@
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
 
-void pci_remove_bus(struct pci_bus *b)
+void pci_remove_bus(struct pci_bus *pci_bus)
 {
-	pci_proc_detach_bus(b);
+	pci_proc_detach_bus(pci_bus);
 
 	spin_lock(&pci_bus_lock);
-	list_del(&b->node);
+	list_del(&pci_bus->node);
 	spin_unlock(&pci_bus_lock);
-
-	class_device_unregister(&b->class_dev);
+	pci_remove_legacy_files(pci_bus);
+	class_device_remove_file(&pci_bus->class_dev,
+		&class_device_attr_cpuaffinity);
+	sysfs_remove_link(&pci_bus->class_dev.kobj, "bridge");
+	class_device_unregister(&pci_bus->class_dev);
 }
 EXPORT_SYMBOL(pci_remove_bus);
 

