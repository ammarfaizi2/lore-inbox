Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTE2VHG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTE2VHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:07:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31472 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262955AbTE2VGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:06:25 -0400
Date: Thu, 29 May 2003 14:21:39 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: pcmcia oops (a real one! honest!)
Message-ID: <20030529212139.GA25971@kroah.com>
References: <20030528042610.GD6501@zip.com.au> <20030529090209.B12513@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529090209.B12513@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 09:02:09AM +0100, Russell King wrote:
> On Wed, May 28, 2003 at 02:26:10PM +1000, CaT wrote:
> > removed my xircom pcmcia realport card and put in another. End result was
> > total loss of ps2 keyboard functionality (everything else, inc the ps2 mouse
> > still works). I then removed the xircom card. The following was in dmesg:
> 
> I'm assuming that this is something Gregkh needs to look into and not
> myself; my guess is that it's related to the pci device accounting stuff.
> 
> Greg?

Yeah, it could be.  Cat, can you revert the following patch from your
tree and let me know if it fixes your problem or not?

thanks,

greg k-h



diff -Nru a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	Thu May 29 14:18:20 2003
+++ b/drivers/pci/bus.c	Thu May 29 14:18:20 2003
@@ -92,7 +92,7 @@
 		if (!list_empty(&dev->global_list))
 			continue;
 
-		device_register(&dev->dev);
+		device_add(&dev->dev);
 		list_add_tail(&dev->global_list, &pci_devices);
 #ifdef CONFIG_PROC_FS
 		pci_proc_attach_device(dev);
diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Thu May 29 14:18:20 2003
+++ b/drivers/pci/hotplug.c	Thu May 29 14:18:20 2003
@@ -275,7 +275,7 @@
 	pci_proc_detach_device(dev);
 #endif
 
-	kfree(dev);
+	pci_put_dev(dev);
 }
 
 /**
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu May 29 14:18:20 2003
+++ b/drivers/pci/pci-driver.c	Thu May 29 14:18:20 2003
@@ -199,6 +199,45 @@
 	return 0;
 }
 
+/**
+ * pci_get_dev - increments the reference count of the pci device structure
+ * @dev: the device being referenced
+ *
+ * Each live reference to a device should be refcounted.
+ *
+ * Drivers for PCI devices should normally record such references in
+ * their probe() methods, when they bind to a device, and release
+ * them by calling pci_put_dev(), in their disconnect() methods.
+ *
+ * A pointer to the device with the incremented reference counter is returned.
+ */
+struct pci_dev *pci_get_dev (struct pci_dev *dev)
+{
+	struct device *tmp;
+
+	if (!dev)
+		return NULL;
+
+	tmp = get_device(&dev->dev);
+	if (tmp)        
+		return to_pci_dev(tmp);
+	else
+		return NULL;
+}
+
+/**
+ * pci_put_dev - release a use of the pci device structure
+ * @dev: device that's been disconnected
+ *
+ * Must be called when a user of a device is finished with it.  When the last
+ * user of the device calls this function, the memory of the device is freed.
+ */
+void pci_put_dev(struct pci_dev *dev)
+{
+	if (dev)
+		put_device(&dev->dev);
+}
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
@@ -217,3 +256,5 @@
 EXPORT_SYMBOL(pci_unregister_driver);
 EXPORT_SYMBOL(pci_dev_driver);
 EXPORT_SYMBOL(pci_bus_type);
+EXPORT_SYMBOL(pci_get_dev);
+EXPORT_SYMBOL(pci_put_dev);
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Thu May 29 14:18:20 2003
+++ b/drivers/pci/probe.c	Thu May 29 14:18:20 2003
@@ -462,6 +462,21 @@
 	return 0;
 }
 
+/**
+ * pci_release_dev - free a pci device structure when all users of it are finished.
+ * @dev: device that's been disconnected
+ *
+ * Will be called only by the device core when all users of this pci device are
+ * done.
+ */
+static void pci_release_dev(struct device *dev)
+{
+	struct pci_dev *pci_dev;
+
+	pci_dev = to_pci_dev(dev);
+	kfree(pci_dev);
+}
+
 /*
  * Read the config data for a PCI device, sanity-check it
  * and fill in the dev structure...
@@ -506,6 +521,9 @@
 		kfree(dev);
 		return NULL;
 	}
+	device_initialize(&dev->dev);
+	dev->dev.release = pci_release_dev;
+	pci_get_dev(dev);
 
 	pci_name_device(dev);
 
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu May 29 14:18:20 2003
+++ b/include/linux/pci.h	Thu May 29 14:18:20 2003
@@ -556,6 +556,8 @@
 struct resource *pci_find_parent_resource(const struct pci_dev *dev, struct resource *res);
 int pci_setup_device(struct pci_dev *dev);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
+extern struct pci_dev *pci_get_dev(struct pci_dev *dev);
+extern void pci_put_dev(struct pci_dev *dev);
 
 /* Generic PCI functions exported to card drivers */
 
