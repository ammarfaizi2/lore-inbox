Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264380AbTFECFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTFECFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:05:01 -0400
Received: from granite.he.net ([216.218.226.66]:59142 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264380AbTFECCE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:02:04 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787473162@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787472263@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1254.4.9, 2003/06/03 23:33:47-07:00, greg@kroah.com

[PATCH] PCI: remove CONFIG_PROC_FS checks in .c files.


 drivers/pci/bus.c                      |    2 --
 drivers/pci/hotplug.c                  |    8 --------
 drivers/pci/hotplug/cpci_hotplug_pci.c |    3 +--
 drivers/pci/pci.h                      |    8 ++++++++
 drivers/pci/proc.c                     |    1 -
 5 files changed, 9 insertions(+), 13 deletions(-)


diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	Wed Jun  4 18:11:47 2003
+++ b/drivers/pci/bus.c	Wed Jun  4 18:11:47 2003
@@ -94,9 +94,7 @@
 
 		device_add(&dev->dev);
 		list_add_tail(&dev->global_list, &pci_devices);
-#ifdef CONFIG_PROC_FS
 		pci_proc_attach_device(dev);
-#endif
 		pci_create_sysfs_dev_files(dev);
 
 	}
diff -Nru a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c	Wed Jun  4 18:11:47 2003
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c	Wed Jun  4 18:11:47 2003
@@ -398,9 +398,8 @@
 	child = pci_find_bus(max + 1);
 	if (!child)
 		return -ENODEV;
-#ifdef CONFIG_PROC_FS
 	pci_proc_attach_bus(child);
-#endif
+
 	/*
 	 * Update parent bridge's subordinate field if there were more bridges
 	 * behind the bridge that was scanned.
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Wed Jun  4 18:11:47 2003
+++ b/drivers/pci/hotplug.c	Wed Jun  4 18:11:47 2003
@@ -190,9 +190,7 @@
 	list_del(&dev->bus_list);
 	list_del(&dev->global_list);
 	pci_free_resources(dev);
-#ifdef CONFIG_PROC_FS
 	pci_proc_detach_device(dev);
-#endif
 	return 0;
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
@@ -237,10 +235,7 @@
 		struct pci_bus *b = dev->subordinate;
 
 		pci_remove_behind_bridge(dev);
-
-#ifdef CONFIG_PROC_FS
 		pci_proc_detach_bus(b);
-#endif
 
 		list_del(&b->node);
 		kfree(b);
@@ -251,10 +246,7 @@
 	list_del(&dev->bus_list);
 	list_del(&dev->global_list);
 	pci_free_resources(dev);
-#ifdef CONFIG_PROC_FS
 	pci_proc_detach_device(dev);
-#endif
-
 	pci_put_dev(dev);
 }
 
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Wed Jun  4 18:11:47 2003
+++ b/drivers/pci/pci.h	Wed Jun  4 18:11:47 2003
@@ -9,10 +9,18 @@
 				  void (*alignf)(void *, struct resource *,
 					  	 unsigned long, unsigned long),
 				  void *alignf_data);
+/* PCI /proc functions */
+#ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);
 extern int pci_proc_detach_device(struct pci_dev *dev);
 extern int pci_proc_attach_bus(struct pci_bus *bus);
 extern int pci_proc_detach_bus(struct pci_bus *bus);
+#else
+static inline int pci_proc_attach_device(struct pci_dev *dev) { return 0; }
+static inline int pci_proc_detach_device(struct pci_dev *dev) { return 0; }
+static inline int pci_proc_attach_bus(struct pci_bus *bus) { return 0; }
+static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
+#endif
 
 /* Functions for PCI Hotplug drivers to use */
 extern struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
diff -Nru a/drivers/pci/proc.c b/drivers/pci/proc.c
--- a/drivers/pci/proc.c	Wed Jun  4 18:11:47 2003
+++ b/drivers/pci/proc.c	Wed Jun  4 18:11:47 2003
@@ -599,7 +599,6 @@
 
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_proc_attach_device);
-EXPORT_SYMBOL(pci_proc_detach_device);
 EXPORT_SYMBOL(pci_proc_attach_bus);
 EXPORT_SYMBOL(pci_proc_detach_bus);
 EXPORT_SYMBOL(proc_bus_pci_dir);

