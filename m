Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264811AbTBYBPg>; Mon, 24 Feb 2003 20:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264820AbTBYBPP>; Mon, 24 Feb 2003 20:15:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:60175 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264919AbTBYBN5>;
	Mon, 24 Feb 2003 20:13:57 -0500
Subject: Re: [PATCH] PCI hotplug changes for 2.5.63
In-reply-to: <1046135763287@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Feb 2003 17:16 -0800
Message-id: <10461357663921@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1022.1.8, 2003/02/24 16:28:58-08:00, rmk@arm.linux.org.uk

[PATCH] PCI: Make hot unplugging of PCI buses work

Here's the updated patch:

- Scott spotted a leak my handling of procfs wrt buses.
- I've also killed pci_remove_device() entirely - it is now inlined.
- After one of Alan's mails, I decided that pci_remove_behind_bridge()
  is a much better name than pci_remove_all_bus_devices()


diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Mon Feb 24 17:15:33 2003
+++ b/drivers/pci/hotplug.c	Mon Feb 24 17:15:33 2003
@@ -10,6 +10,7 @@
 #define DBG(x...)
 #endif
 
+static void pci_free_resources(struct pci_dev *dev);
 
 #ifdef CONFIG_HOTPLUG
 int pci_hotplug (struct device *dev, char **envp, int num_envp,
@@ -185,7 +186,13 @@
 {
 	if (pci_dev_driver(dev))
 		return -EBUSY;
-	pci_remove_device(dev);
+	device_unregister(&dev->dev);
+	list_del(&dev->bus_list);
+	list_del(&dev->global_list);
+	pci_free_resources(dev);
+#ifdef CONFIG_PROC_FS
+	pci_proc_detach_device(dev);
+#endif
 	return 0;
 }
 EXPORT_SYMBOL(pci_remove_device_safe);
@@ -233,15 +240,33 @@
 }
 
 /**
- * pci_remove_device - remove a pci device
+ * pci_remove_bus_device - remove a PCI device and any children
  * @dev: the device to remove
  *
- * Delete the device structure from the device lists,
- * remove the /proc entry, and notify userspace (/sbin/hotplug).
+ * Remove a PCI device from the device lists, informing the drivers
+ * that the device has been removed.  We also remove any subordinate
+ * buses and children in a depth-first manner.
+ *
+ * For each device we remove, delete the device structure from the
+ * device lists, remove the /proc entry, and notify userspace
+ * (/sbin/hotplug).
  */
-void
-pci_remove_device(struct pci_dev *dev)
+void pci_remove_bus_device(struct pci_dev *dev)
 {
+	if (dev->subordinate) {
+		struct pci_bus *b = dev->subordinate;
+
+		pci_remove_behind_bridge(dev);
+
+#ifdef CONFIG_PROC_FS
+		pci_proc_detach_bus(b);
+#endif
+
+		list_del(&b->node);
+		kfree(b);
+		dev->subordinate = NULL;
+	}
+
 	device_unregister(&dev->dev);
 	list_del(&dev->bus_list);
 	list_del(&dev->global_list);
@@ -249,9 +274,33 @@
 #ifdef CONFIG_PROC_FS
 	pci_proc_detach_device(dev);
 #endif
+
+	kfree(dev);
+}
+
+/**
+ * pci_remove_behind_bridge - remove all devices behind a PCI bridge
+ * @dev: PCI bridge device
+ *
+ * Remove all devices on the bus, except for the parent bridge.
+ * This also removes any child buses, and any devices they may
+ * contain in a depth-first manner.
+ */
+void pci_remove_behind_bridge(struct pci_dev *dev)
+{
+	struct list_head *l, *n;
+
+	if (dev->subordinate) {
+		list_for_each_safe(l, n, &dev->subordinate->devices) {
+			struct pci_dev *dev = pci_dev_b(l);
+
+			pci_remove_bus_device(dev);
+		}
+	}
 }
 
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_insert_device);
-EXPORT_SYMBOL(pci_remove_device);
+EXPORT_SYMBOL(pci_remove_bus_device);
+EXPORT_SYMBOL(pci_remove_behind_bridge);
 #endif
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Mon Feb 24 17:15:33 2003
+++ b/include/linux/pci.h	Mon Feb 24 17:15:33 2003
@@ -645,7 +645,8 @@
 int pci_register_driver(struct pci_driver *);
 void pci_unregister_driver(struct pci_driver *);
 void pci_insert_device(struct pci_dev *, struct pci_bus *);
-void pci_remove_device(struct pci_dev *);
+void pci_remove_bus_device(struct pci_dev *);
+void pci_remove_behind_bridge(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);
 const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev);
 unsigned int pci_do_scan_bus(struct pci_bus *bus);

