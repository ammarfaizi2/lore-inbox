Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270198AbUJSW4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270198AbUJSW4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270048AbUJSWsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:48:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:65161 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270103AbUJSWqY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:24 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257371954@kroah.com>
Date: Tue, 19 Oct 2004 15:42:17 -0700
Message-Id: <10982257372797@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.43, 2004/10/06 13:05:22-07:00, greg@kroah.com

[PATCH] PCI: Create new function to see if a pci device is present

This is needed to help get rid of the pci_find_device() usage in the tree.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-driver.c |   21 ---------------------
 drivers/pci/pci.h        |   21 +++++++++++++++++++++
 drivers/pci/search.c     |   34 ++++++++++++++++++++++++++++++++++
 include/linux/pci.h      |    3 +++
 4 files changed, 58 insertions(+), 21 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-10-19 15:23:49 -07:00
+++ b/drivers/pci/pci-driver.c	2004-10-19 15:23:49 -07:00
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
--- a/drivers/pci/pci.h	2004-10-19 15:23:49 -07:00
+++ b/drivers/pci/pci.h	2004-10-19 15:23:49 -07:00
@@ -63,3 +63,24 @@
 
 extern int pciehp_msi_quirk;
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
--- a/drivers/pci/search.c	2004-10-19 15:23:49 -07:00
+++ b/drivers/pci/search.c	2004-10-19 15:23:49 -07:00
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
--- a/include/linux/pci.h	2004-10-19 15:23:49 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:23:49 -07:00
@@ -730,6 +730,7 @@
 				struct pci_dev *from);
 struct pci_dev *pci_get_slot (struct pci_bus *bus, unsigned int devfn);
 struct pci_dev *pci_get_class (unsigned int class, struct pci_dev *from);
+int pci_dev_present(const struct pci_device_id *ids);
 
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
@@ -891,6 +892,8 @@
 
 static inline struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from)
 { return NULL; }
+static inline int pci_dev_present(const struct pci_device_id *ids)
+{ return 0; }
 
 static inline void pci_set_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }

