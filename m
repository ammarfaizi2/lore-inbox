Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270143AbUJSXfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270143AbUJSXfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270157AbUJSXdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:33:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:11402 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270143AbUJSWqe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:34 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257321860@kroah.com>
Date: Tue, 19 Oct 2004 15:42:12 -0700
Message-Id: <10982257321011@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.6, 2004/10/06 11:20:05-07:00, greg@kroah.com

[PATCH] PCI: add pci_get_class() to make a safe pci_find_class() like call.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/pci.txt |    5 +++--
 drivers/pci/search.c  |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h   |    4 ++++
 3 files changed, 45 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt	2004-10-19 15:27:27 -07:00
+++ b/Documentation/pci.txt	2004-10-19 15:27:27 -07:00
@@ -146,7 +146,7 @@
 
 Searching by class ID (iterate in a similar way):
 
-	pci_find_class(CLASS_ID, dev)
+	pci_get_class(CLASS_ID, dev)
 
 Searching by both vendor/device and subsystem vendor/device ID:
 
@@ -281,5 +281,6 @@
 pci_for_each_bus()		Superseded by pci_find_next_bus()
 pci_find_device()		Superseded by pci_get_device()
 pci_find_subsys()		Superseded by pci_get_subsys()
-pcibios_find_class()		Superseded by pci_find_class()
+pcibios_find_class()		Superseded by pci_get_class()
+pci_find_class()		Superseded by pci_get_class()
 pci_(read|write)_*_nodev()	Superseded by pci_bus_(read|write)_*()
diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	2004-10-19 15:27:27 -07:00
+++ b/drivers/pci/search.c	2004-10-19 15:27:27 -07:00
@@ -348,6 +348,43 @@
 	return dev;
 }
 
+/**
+ * pci_get_class - begin or continue searching for a PCI device by class
+ * @class: search for a PCI device with this class designation
+ * @from: Previous PCI device found in search, or %NULL for new search.
+ *
+ * Iterates through the list of known PCI devices.  If a PCI device is
+ * found with a matching @class, the reference count to the device is
+ * incremented and a pointer to its device structure is returned.
+ * Otherwise, %NULL is returned.
+ * A new search is initiated by passing %NULL to the @from argument.
+ * Otherwise if @from is not %NULL, searches continue from next device
+ * on the global list.  The reference count for @from is always decremented
+ * if it is not %NULL.
+ */
+struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from)
+{
+	struct list_head *n;
+	struct pci_dev *dev;
+
+	WARN_ON(in_interrupt());
+	spin_lock(&pci_bus_lock);
+	n = from ? from->global_list.next : pci_devices.next;
+
+	while (n && (n != &pci_devices)) {
+		dev = pci_dev_g(n);
+		if (dev->class == class)
+			goto exit;
+		n = n->next;
+	}
+	dev = NULL;
+exit:
+	pci_dev_put(from);
+	dev = pci_dev_get(dev);
+	spin_unlock(&pci_bus_lock);
+	return dev;
+}
+
 EXPORT_SYMBOL(pci_find_bus);
 EXPORT_SYMBOL(pci_find_class);
 EXPORT_SYMBOL(pci_find_device);
@@ -356,3 +393,4 @@
 EXPORT_SYMBOL(pci_get_device);
 EXPORT_SYMBOL(pci_get_subsys);
 EXPORT_SYMBOL(pci_get_slot);
+EXPORT_SYMBOL(pci_get_class);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:27:27 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:27:27 -07:00
@@ -730,6 +730,7 @@
 				unsigned int ss_vendor, unsigned int ss_device,
 				struct pci_dev *from);
 struct pci_dev *pci_get_slot (struct pci_bus *bus, unsigned int devfn);
+struct pci_dev *pci_get_class (unsigned int class, struct pci_dev *from);
 
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
@@ -890,6 +891,9 @@
 
 static inline struct pci_dev *pci_get_subsys (unsigned int vendor, unsigned int device,
 unsigned int ss_vendor, unsigned int ss_device, struct pci_dev *from)
+{ return NULL; }
+
+static inline struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from)
 { return NULL; }
 
 static inline void pci_set_master(struct pci_dev *dev) { }

