Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269537AbUIZOLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269537AbUIZOLF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 10:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269538AbUIZOLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 10:11:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:39660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269537AbUIZOKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 10:10:45 -0400
Date: Sun, 26 Sep 2004 07:10:02 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitors@lists.osdl.org, davej@codemonkey.org.uk, hpa@zytor.com
Subject: Re: [PATCH 2.6.9-rc2-mm2] Create new function to see if pci dev is present
Message-ID: <20040926141002.GA24942@kroah.com>
References: <2480000.1095978400@w-hlinder.beaverton.ibm.com> <20040924200231.A30391@infradead.org> <20040924211912.GC7619@kroah.com> <1096059645.10797.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096059645.10797.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 10:00:47PM +0100, Alan Cox wrote:
> On Gwe, 2004-09-24 at 22:19, Greg KH wrote:
> > > Please include subdevice/subvendor id
> > 
> > Good idea, but do you see any places in the kernel that would use those
> > fields, instead of always setting them to PCI_ANY_ID?
> 
> If you are taking that path then make it take a pci_device_id table.
> That makes it behave like other interfaces of the same form, and makes
> the implementation remarkably trivial.

Ah, yes, that is a very good idea.  Here's just such an implementation
(compile tested, nothing else, still need to add comments describing the
function...)  Does everyone like this interface?  Hanna, look ok to you?

thanks,

greg k-h

--- 1.42/drivers/pci/pci-driver.c	2004-09-22 16:24:29 -07:00
+++ edited/drivers/pci/pci-driver.c	2004-09-26 06:44:32 -07:00
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
===== drivers/pci/pci.h 1.18 vs edited =====
--- 1.18/drivers/pci/pci.h	2004-09-22 07:07:44 -07:00
+++ edited/drivers/pci/pci.h	2004-09-26 06:44:28 -07:00
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
===== drivers/pci/search.c 1.31 vs edited =====
--- 1.31/drivers/pci/search.c	2004-08-26 15:16:41 -07:00
+++ edited/drivers/pci/search.c	2004-09-26 07:02:57 -07:00
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include "pci.h"
 
 spinlock_t pci_bus_lock = SPIN_LOCK_UNLOCKED;
 
@@ -343,6 +344,29 @@
 	spin_unlock(&pci_bus_lock);
 	return dev;
 }
+
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
+
 
 EXPORT_SYMBOL(pci_find_bus);
 EXPORT_SYMBOL(pci_find_device);
