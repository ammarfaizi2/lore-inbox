Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267460AbUIWWbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267460AbUIWWbI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUIWW3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:29:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3757 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267460AbUIWWZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:25:51 -0400
Date: Thu, 23 Sep 2004 15:26:40 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, hannal@us.ibm.com, kernel-janitors@lists.osdl.org,
       davej@codemonkey.org.uk, hpa@zytor.com
Subject: [PATCH 2.6.9-rc2-mm2] Create new function to see if pci dev is present
Message-ID: <2480000.1095978400@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg asked in a previous janitors thread:
"What we need is a simple "Is this pci device present right now" type
function, to solve the mess that logic like this needs."

OK. How about this one? It uses pci_get_device but instead of returning
the dev it returns 1 if the device is present and 0 if it isnt. This take the
burdon off the driver from having to know when to use pci_dev_put or
not and should be cleaner for future maintenance work.

Ive tested it with two patches that will follow.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
----

diff -Nrup linux-2.6.9-rc2-mm2cln/drivers/pci/search.c linux-2.6.9-rc2-mm2patch/drivers/pci/search.c
--- linux-2.6.9-rc2-mm2cln/drivers/pci/search.c	2004-09-23 11:49:04.000000000 -0700
+++ linux-2.6.9-rc2-mm2patch/drivers/pci/search.c	2004-09-23 15:03:58.000000000 -0700
@@ -271,6 +271,30 @@ pci_get_device(unsigned int vendor, unsi
 	return pci_get_subsys(vendor, device, PCI_ANY_ID, PCI_ANY_ID, from);
 }
 
+/**
+ * pci_dev_present - Returns 1 if device is present, 0 if device is not.
+ * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
+ * @from: Previous PCI device found in search, or %NULL for new search.
+ *
+ * If pci_get_device returns a pci_dev pointer then the device exists and the
+ * reference count is decremented before returning 1. If pci_get_device
+ * returns %NULL then 0 is returned to indicate the device was not
+ * present. Obvious fact: You do not have a reference to the device so if
+ * it is removed from the system before this function returns the value
+ * will be stale. 
+ */
+int 
+pci_dev_present(unsigned int vendor, unsigned int device, struct pci_dev *from)
+{
+	struct pci_dev *dev;
+	dev = pci_get_device(vendor, device, from);
+	if (dev){
+		pci_dev_put(dev);
+		return 1;
+	}
+	return 0;
+}
 
 /**
  * pci_find_device_reverse - begin or continue searching for a PCI device by vendor/device id
@@ -352,3 +376,5 @@ EXPORT_SYMBOL(pci_get_device);
 EXPORT_SYMBOL(pci_get_subsys);
 EXPORT_SYMBOL(pci_get_slot);
 EXPORT_SYMBOL(pci_get_class);
+EXPORT_SYMBOL(pci_dev_present);
+
diff -Nrup linux-2.6.9-rc2-mm2cln/include/linux/pci.h linux-2.6.9-rc2-mm2patch/include/linux/pci.h
--- linux-2.6.9-rc2-mm2cln/include/linux/pci.h	2004-09-23 11:49:27.000000000 -0700
+++ linux-2.6.9-rc2-mm2patch/include/linux/pci.h	2004-09-23 15:03:01.000000000 -0700
@@ -733,6 +733,8 @@ struct pci_dev *pci_get_subsys (unsigned
 struct pci_dev *pci_get_slot (struct pci_bus *bus, unsigned int devfn);
 struct pci_dev *pci_get_class (unsigned int class, struct pci_dev *from);
 
+int pci_dev_present(unsigned int vendor, unsigned int device, struct pci_dev *from);
+
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
 int pci_bus_read_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 *val);
@@ -900,6 +902,9 @@ unsigned int ss_vendor, unsigned int ss_
 static inline struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from)
 { return NULL; }
 
+static inline int pci_dev_present(unsigned int vendor, unsigned int device, struct pci_dev *from)
+{return -1; }
+
 static inline void pci_set_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }





