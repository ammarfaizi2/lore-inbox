Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUI1R1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUI1R1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbUI1R1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:27:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:56228 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267882AbUI1R0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:26:38 -0400
Date: Tue, 28 Sep 2004 10:24:26 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       davej@codemonkey.org.uk, hpa@zytor.com, kernel-janitors@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>
Subject: Re: Create new function to see if pci dev is present
Message-ID: <20040928172426.GA29529@kroah.com>
References: <2480000.1095978400@w-hlinder.beaverton.ibm.com> <20040924200231.A30391@infradead.org> <20040924211912.GC7619@kroah.com> <1096059645.10797.1.camel@localhost.localdomain> <20040926141002.GA24942@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040926141002.GA24942@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 07:10:02AM -0700, Greg KH wrote:
> > If you are taking that path then make it take a pci_device_id table.
> > That makes it behave like other interfaces of the same form, and makes
> > the implementation remarkably trivial.
> 
> Ah, yes, that is a very good idea.  Here's just such an implementation
> (compile tested, nothing else, still need to add comments describing the
> function...)  Does everyone like this interface?  Hanna, look ok to you?

Ok, here's the patch that I applied to my trees, and I'll follow this up
with a conversion of Hanna's two patches that I respun to use the new
parameters of this function.

thanks,

greg k-h

----
PCI: Create new function to see if a pci device is present

This is needed to help get rid of the pci_find_device() usage in the tree.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-09-28 10:21:02 -07:00
+++ b/drivers/pci/pci-driver.c	2004-09-28 10:21:02 -07:00
@@ -14,27 +14,6 @@
  *  Registration of PCI drivers and handling of hot-pluggable devices.
  */
 
-/**
- * pci_match_one_device - Tell if a PCI device structure has a matching
- *                        PCI device id structure
- * @id: single PCI device id structure to match
- * @dev: the PCI device structure to match against
- * 
- * Returns the matching pci_device_id structure or %NULL if there is no match.
- */
-
-static inline const struct pci_device_id *
-pci_match_one_device(const struct pci_device_id *id, const struct pci_dev *dev)
-{
-	if ((id->vendor == PCI_ANY_ID || id->vendor == dev->vendor) &&
-	    (id->device == PCI_ANY_ID || id->device == dev->device) &&
-	    (id->subvendor == PCI_ANY_ID || id->subvendor == dev->subsystem_vendor) &&
-	    (id->subdevice == PCI_ANY_ID || id->subdevice == dev->subsystem_device) &&
-	    !((id->class ^ dev->class) & id->class_mask))
-		return id;
-	return NULL;
-}
-
 /*
  * Dynamic device IDs are disabled for !CONFIG_HOTPLUG
  */
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	2004-09-28 10:21:02 -07:00
+++ b/drivers/pci/pci.h	2004-09-28 10:21:02 -07:00
@@ -66,3 +66,24 @@
 extern int pcie_mch_quirk;
 extern void pcie_rootport_aspm_quirk(struct pci_dev *pdev);
 extern struct device_attribute pci_dev_attrs[];
+
+/**
+ * pci_match_one_device - Tell if a PCI device structure has a matching
+ *                        PCI device id structure
+ * @id: single PCI device id structure to match
+ * @dev: the PCI device structure to match against
+ * 
+ * Returns the matching pci_device_id structure or %NULL if there is no match.
+ */
+static inline const struct pci_device_id *
+pci_match_one_device(const struct pci_device_id *id, const struct pci_dev *dev)
+{
+	if ((id->vendor == PCI_ANY_ID || id->vendor == dev->vendor) &&
+	    (id->device == PCI_ANY_ID || id->device == dev->device) &&
+	    (id->subvendor == PCI_ANY_ID || id->subvendor == dev->subsystem_vendor) &&
+	    (id->subdevice == PCI_ANY_ID || id->subdevice == dev->subsystem_device) &&
+	    !((id->class ^ dev->class) & id->class_mask))
+		return id;
+	return NULL;
+}
+
diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	2004-09-28 10:21:02 -07:00
+++ b/drivers/pci/search.c	2004-09-28 10:21:02 -07:00
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include "pci.h"
 
 spinlock_t pci_bus_lock = SPIN_LOCK_UNLOCKED;
 
@@ -343,6 +344,39 @@
 	spin_unlock(&pci_bus_lock);
 	return dev;
 }
+
+/**
+ * pci_dev_present - Returns 1 if device matching the device list is present, 0 if not.
+ * @ids: A pointer to a null terminated list of struct pci_device_id structures
+ * that describe the type of PCI device the caller is trying to find.
+ *
+ * Obvious fact: You do not have a reference to any device that might be found
+ * by this function, so if that device is removed from the system right after
+ * this function is finished, the value will be stale.  Use this function to
+ * find devices that are usually built into a system, or for a general hint as
+ * to if another device happens to be present at this specific moment in time.
+ */
+int pci_dev_present(const struct pci_device_id *ids)
+{
+	struct pci_dev *dev;
+	int found = 0;
+
+	WARN_ON(in_interrupt());
+	spin_lock(&pci_bus_lock);
+	while (ids->vendor || ids->subvendor || ids->class_mask) {
+		list_for_each_entry(dev, &pci_devices, global_list) {
+			if (pci_match_one_device(ids, dev)) {
+				found = 1;
+				goto exit;
+			}
+		}
+		ids++;
+	}
+exit:				
+	spin_unlock(&pci_bus_lock);
+	return found;
+}
+EXPORT_SYMBOL(pci_dev_present);
 
 EXPORT_SYMBOL(pci_find_bus);
 EXPORT_SYMBOL(pci_find_device);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-09-28 10:21:02 -07:00
+++ b/include/linux/pci.h	2004-09-28 10:21:02 -07:00
@@ -733,6 +733,7 @@
 				struct pci_dev *from);
 struct pci_dev *pci_get_slot (struct pci_bus *bus, unsigned int devfn);
 struct pci_dev *pci_get_class (unsigned int class, struct pci_dev *from);
+int pci_dev_present(const struct pci_device_id *ids);
 
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
@@ -900,6 +901,8 @@
 
 static inline struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from)
 { return NULL; }
+static inline int pci_dev_present(const struct pci_device_id *ids)
+{ return 0; }
 
 static inline void pci_set_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
