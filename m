Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTFYKVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 06:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTFYKVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 06:21:11 -0400
Received: from 104ppp2.telegraph.spb.ru ([213.158.3.104]:128 "EHLO
	ku3.suxx.org") by vger.kernel.org with ESMTP id S264393AbTFYKVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 06:21:08 -0400
Date: Wed, 25 Jun 2003 14:29:07 +0400
From: Nikita Melnikov <slkw@sl.aanet.ru>
To: lkml <linux-kernel@vger.kernel.org>
Subject: pci_destroy_dev symbol when CONFIG_HOTPLUG is not set in 2.5.73
Message-ID: <20030625102907.GA23641@ku3>
Reply-To: Nikita Melnikov <slkw@sl.aanet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	If we don't have CONFIG_HOTPLUG make bzImage fails because it's
impossible to find pci_destroy_dev symbol. So this patch fixes
drivers/pci/hotplug.c.

----CUT----
--- hotplug.c	2003-06-25 14:12:21.000000000 +0400
+++ hotplug.c	2003-06-25 14:12:38.000000000 +0400
@@ -173,24 +173,6 @@
 }
 EXPORT_SYMBOL(pci_visit_dev);
 
-static void pci_destroy_dev(struct pci_dev *dev)
-{
-	pci_proc_detach_device(dev);
-	device_unregister(&dev->dev);
-
-	/* Remove the device from the device lists, and prevent any further
-	 * list accesses from this device */
-	spin_lock(&pci_bus_lock);
-	list_del(&dev->bus_list);
-	list_del(&dev->global_list);
-	dev->bus_list.next = dev->bus_list.prev = NULL;
-	dev->global_list.next = dev->global_list.prev = NULL;
-	spin_unlock(&pci_bus_lock);
-
-	pci_free_resources(dev);
-	pci_dev_put(dev);
-}
-
 /**
  * pci_remove_device_safe - remove an unused hotplug device
  * @dev: the device to remove
@@ -211,6 +193,25 @@
 
 #else /* CONFIG_HOTPLUG */
 
+static void pci_destroy_dev(struct pci_dev *dev)
+{
+	pci_proc_detach_device(dev);
+	device_unregister(&dev->dev);
+
+	/* Remove the device from the device lists, and prevent any further
+	 * list accesses from this device */
+	spin_lock(&pci_bus_lock);
+	list_del(&dev->bus_list);
+	list_del(&dev->global_list);
+	dev->bus_list.next = dev->bus_list.prev = NULL;
+	dev->global_list.next = dev->global_list.prev = NULL;
+	spin_unlock(&pci_bus_lock);
+
+	pci_free_resources(dev);
+	pci_dev_put(dev);
+}
+EXPORT_SYMBOL(pci_destroy_dev);
+
 int pci_hotplug (struct device *dev, char **envp, int num_envp,
 		 char *buffer, int buffer_size)
 {
----CUT----

PS: please CC: me, I'm not subscribed.

-- 
Nikita Melnikov
Don't beat me; this's my first post to linux-kernel! :-)
