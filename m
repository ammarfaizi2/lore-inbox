Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTBXJxg>; Mon, 24 Feb 2003 04:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTBXJxg>; Mon, 24 Feb 2003 04:53:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17924 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266064AbTBXJxd>; Mon, 24 Feb 2003 04:53:33 -0500
Date: Mon, 24 Feb 2003 10:03:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
Message-ID: <20030224100342.A27610@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>
References: <20030223173441.D20405@flint.arm.linux.org.uk> <20030224054830.GA31528@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030224054830.GA31528@kroah.com>; from greg@kroah.com on Sun, Feb 23, 2003 at 09:48:31PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 09:48:31PM -0800, Greg KH wrote:
> I like the patch, nice job.  If you don't mind, I'll add it to my tree,
> fix up all of the pci hotplug drivers, and then send all of that off to
> Linus.  Is that ok?

Here's the updated patch:

- Scott spotted a leak my handling of procfs wrt buses.
- I've also killed pci_remove_device() entirely - it is now inlined.
- After one of Alan's mails, I decided that pci_remove_behind_bridge()
  is a much better name than pci_remove_all_bus_devices()

--- orig/drivers/pci/hotplug.c	Tue Feb 11 16:10:23 2003
+++ linux/drivers/pci/hotplug.c	Mon Feb 24 09:58:53 2003
@@ -10,6 +10,7 @@
 #define DBG(x...)
 #endif
 
+static void pci_free_resources(struct pci_dev *dev);
 
 #ifdef CONFIG_HOTPLUG
 int pci_hotplug (struct device *dev, char **envp, int num_envp,
@@ -224,7 +225,13 @@
 	if (pci_is_dev_in_use(dev)) {
 		return -EBUSY;
 	}
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
@@ -272,15 +279,33 @@
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
@@ -288,9 +313,33 @@
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
--- orig/include/linux/pci.h	Fri Feb 21 19:48:58 2003
+++ linux/include/linux/pci.h	Mon Feb 24 09:52:51 2003
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

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

