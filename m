Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTFEUqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbTFEUqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:46:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:34706 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264864AbTFEUp6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:45:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548468771865@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.70
In-Reply-To: <10548468773655@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 14:01:17 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1314, 2003/06/05 12:04:02-07:00, greg@kroah.com

[PATCH] PCI: add pci_find_device_reverse() for users of pci_find_each_dev_reverse() to use


 drivers/pci/search.c |   29 +++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 +
 2 files changed, 30 insertions(+)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Thu Jun  5 13:52:57 2003
+++ b/drivers/pci/search.c	Thu Jun  5 13:52:57 2003
@@ -118,6 +118,34 @@
 
 
 /**
+ * pci_find_device_reverse - begin or continue searching for a PCI device by vendor/device id
+ * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
+ * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
+ * @from: Previous PCI device found in search, or %NULL for new search.
+ *
+ * Iterates through the list of known PCI devices in the reverse order of pci_find_device().
+ * If a PCI device is found with a matching @vendor and @device, a pointer to
+ * its device structure is returned.  Otherwise, %NULL is returned.
+ * A new search is initiated by passing %NULL to the @from argument.
+ * Otherwise if @from is not %NULL, searches continue from previous device on the global list.
+ */
+struct pci_dev *
+pci_find_device_reverse(unsigned int vendor, unsigned int device, const struct pci_dev *from)
+{
+	struct list_head *n = from ? from->global_list.prev : pci_devices.prev;
+
+	while (n != &pci_devices) {
+		struct pci_dev *dev = pci_dev_g(n);
+		if ((vendor == PCI_ANY_ID || dev->vendor == vendor) &&
+		    (device == PCI_ANY_ID || dev->device == device))
+			return dev;
+		n = n->prev;
+	}
+	return NULL;
+}
+
+
+/**
  * pci_find_class - begin or continue searching for a PCI device by class
  * @class: search for a PCI device with this class designation
  * @from: Previous PCI device found in search, or %NULL for new search.
@@ -146,5 +174,6 @@
 EXPORT_SYMBOL(pci_find_bus);
 EXPORT_SYMBOL(pci_find_class);
 EXPORT_SYMBOL(pci_find_device);
+EXPORT_SYMBOL(pci_find_device_reverse);
 EXPORT_SYMBOL(pci_find_slot);
 EXPORT_SYMBOL(pci_find_subsys);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Jun  5 13:52:57 2003
+++ b/include/linux/pci.h	Thu Jun  5 13:52:57 2003
@@ -564,6 +564,7 @@
 /* Generic PCI functions exported to card drivers */
 
 struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
+struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_subsys (unsigned int vendor, unsigned int device,
 				 unsigned int ss_vendor, unsigned int ss_device,
 				 const struct pci_dev *from);

