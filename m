Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTFWXsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbTFWXqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:46:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:49584 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264831AbTFWXpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:45:50 -0400
Date: Mon, 23 Jun 2003 16:59:10 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI fixes for 2.5.73
Message-ID: <20030623235910.GB12207@kroah.com>
References: <20030623235852.GA12207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623235852.GA12207@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1348.14.1, 2003/06/23 11:44:52-07:00, ink@jurassic.park.msu.ru

[PATCH] PCI: fix non-hotplug build

Current BK won't build when CONFIG_HOTPLUG is not set due to
undefined references to pci_destroy_dev in hotplug.c.
I think it makes sense to not compile hotplug.c in this case at all.
Also, this allows to get rid of several function which are unused
in non-hotplug kernel.

Tested on Alpha.


 drivers/pci/Makefile     |    5 +++--
 drivers/pci/hotplug.c    |   13 -------------
 drivers/pci/pci-driver.c |    8 ++++++++
 3 files changed, 11 insertions(+), 15 deletions(-)


diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Mon Jun 23 16:54:07 2003
+++ b/drivers/pci/Makefile	Mon Jun 23 16:54:07 2003
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
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Mon Jun 23 16:54:07 2003
+++ b/drivers/pci/hotplug.c	Mon Jun 23 16:54:07 2003
@@ -12,7 +12,6 @@
 
 static void pci_free_resources(struct pci_dev *dev);
 
-#ifdef CONFIG_HOTPLUG
 int pci_hotplug (struct device *dev, char **envp, int num_envp,
 		 char *buffer, int buffer_size)
 {
@@ -209,16 +208,6 @@
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
@@ -283,7 +272,5 @@
 	}
 }
 
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_remove_bus_device);
 EXPORT_SYMBOL(pci_remove_behind_bridge);
-#endif
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Mon Jun 23 16:54:07 2003
+++ b/drivers/pci/pci-driver.c	Mon Jun 23 16:54:07 2003
@@ -486,6 +486,14 @@
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
