Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbTFUMpy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 08:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTFUMpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 08:45:53 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:3076 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265181AbTFUMpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 08:45:51 -0400
Date: Sat, 21 Jun 2003 16:59:48 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] PCI: fix non-hotplug build
Message-ID: <20030621165948.A913@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current BK won't build when CONFIG_HOTPLUG is not set due to
undefined references to pci_destroy_dev in hotplug.c.
I think it makes sense to not compile hotplug.c in this case at all.
Also, this allows to get rid of several function which are unused
in non-hotplug kernel.

Tested on Alpha.

Ivan.

--- 2.5/drivers/pci/Makefile	Tue Jun 17 08:20:22 2003
+++ linux/drivers/pci/Makefile	Sat Jun 21 16:53:28 2003
@@ -3,14 +3,15 @@
 #
 
 obj-y		+= access.o bus.o probe.o pci.o pool.o quirks.o \
-			names.o pci-driver.o search.o hotplug.o \
-			pci-sysfs.o
+			names.o pci-driver.o search.o pci-sysfs.o
 obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64
 obj-$(CONFIG_PCI) += setup-res.o
 endif
+
+obj-$(CONFIG_HOTPLUG) += hotplug.o
 
 # Build the PCI Hotplug drivers if we were asked to
 obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
--- 2.5/drivers/pci/pci-driver.c	Sat Jun 21 15:22:41 2003
+++ linux/drivers/pci/pci-driver.c	Sat Jun 21 16:21:38 2003
@@ -486,6 +486,14 @@ void pci_dev_put(struct pci_dev *dev)
 		put_device(&dev->dev);
 }
 
+#ifndef CONFIG_HOTPLUG
+int pci_hotplug (struct device *dev, char **envp, int num_envp,
+		 char *buffer, int buffer_size)
+{
+	return -ENODEV;
+}
+#endif
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
--- 2.5/drivers/pci/hotplug.c	Sat Jun 21 15:22:40 2003
+++ linux/drivers/pci/hotplug.c	Sat Jun 21 16:19:49 2003
@@ -12,7 +12,6 @@
 
 static void pci_free_resources(struct pci_dev *dev);
 
-#ifdef CONFIG_HOTPLUG
 int pci_hotplug (struct device *dev, char **envp, int num_envp,
 		 char *buffer, int buffer_size)
 {
@@ -209,16 +208,6 @@ int pci_remove_device_safe(struct pci_de
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
 
-#else /* CONFIG_HOTPLUG */
-
-int pci_hotplug (struct device *dev, char **envp, int num_envp,
-		 char *buffer, int buffer_size)
-{
-	return -ENODEV;
-}
-
-#endif /* CONFIG_HOTPLUG */
-
 static void
 pci_free_resources(struct pci_dev *dev)
 {
@@ -283,7 +272,5 @@ void pci_remove_behind_bridge(struct pci
 	}
 }
 
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_remove_bus_device);
 EXPORT_SYMBOL(pci_remove_behind_bridge);
-#endif
