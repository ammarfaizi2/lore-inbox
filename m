Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269889AbUJSWrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269889AbUJSWrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270060AbUJSWrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:47:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:64393 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270101AbUJSWqY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:24 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257332039@kroah.com>
Date: Tue, 19 Oct 2004 15:42:13 -0700
Message-Id: <109822573337@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.10, 2004/10/06 11:32:56-07:00, greg@kroah.com

[PATCH] PCI: delete the pci_find_class() function as it's unsafe in hotpluggable systems.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/search.c |   40 ----------------------------------------
 include/linux/pci.h  |    4 ----
 2 files changed, 44 deletions(-)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	2004-10-19 15:27:05 -07:00
+++ b/drivers/pci/search.c	2004-10-19 15:27:05 -07:00
@@ -307,45 +307,6 @@
 	return dev;
 }
 
-
-/**
- * pci_find_class - begin or continue searching for a PCI device by class
- * @class: search for a PCI device with this class designation
- * @from: Previous PCI device found in search, or %NULL for new search.
- *
- * Iterates through the list of known PCI devices.  If a PCI device is
- * found with a matching @class, a pointer to its device structure is
- * returned.  Otherwise, %NULL is returned.
- * A new search is initiated by passing %NULL to the @from argument.
- * Otherwise if @from is not %NULL, searches continue from next device
- * on the global list.
- *
- * NOTE: Do not use this function anymore, use pci_get_class() instead, as
- * the pci device returned by this function can disappear at any moment in
- * time.
- */
-struct pci_dev *
-pci_find_class(unsigned int class, const struct pci_dev *from)
-{
-	struct list_head *n;
-	struct pci_dev *dev;
-
-	WARN_ON(in_interrupt());
-	spin_lock(&pci_bus_lock);
-	n = from ? from->global_list.next : pci_devices.next;
-
-	while (n && (n != &pci_devices)) {
-		dev = pci_dev_g(n);
-		if (dev->class == class)
-			goto exit;
-		n = n->next;
-	}
-	dev = NULL;
-exit:
-	spin_unlock(&pci_bus_lock);
-	return dev;
-}
-
 /**
  * pci_get_class - begin or continue searching for a PCI device by class
  * @class: search for a PCI device with this class designation
@@ -384,7 +345,6 @@
 }
 
 EXPORT_SYMBOL(pci_find_bus);
-EXPORT_SYMBOL(pci_find_class);
 EXPORT_SYMBOL(pci_find_device);
 EXPORT_SYMBOL(pci_find_device_reverse);
 EXPORT_SYMBOL(pci_find_slot);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:27:05 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:27:05 -07:00
@@ -719,7 +719,6 @@
 
 struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
-struct pci_dev *pci_find_class (unsigned int class, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
 int pci_find_ext_capability (struct pci_dev *dev, int cap);
@@ -878,9 +877,6 @@
 _PCI_NOP_ALL(write,)
 
 static inline struct pci_dev *pci_find_device(unsigned int vendor, unsigned int device, const struct pci_dev *from)
-{ return NULL; }
-
-static inline struct pci_dev *pci_find_class(unsigned int class, const struct pci_dev *from)
 { return NULL; }
 
 static inline struct pci_dev *pci_find_slot(unsigned int bus, unsigned int devfn)

