Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTFJTpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTFJToN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:44:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16805 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264039AbTFJSi6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:38:58 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709701662@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270970689@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:30 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1386, 2003/06/10 10:30:30-07:00, greg@kroah.com

[PATCH] PCI: add pci_find_next_bus() function to prevent people from walking pci bus lists themselves.


 drivers/pci/search.c |   25 ++++++++++++++++++++++---
 include/linux/pci.h  |    1 +
 2 files changed, 23 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Tue Jun 10 11:15:57 2003
+++ b/drivers/pci/search.c	Tue Jun 10 11:15:57 2003
@@ -29,10 +29,10 @@
 struct pci_bus *
 pci_find_bus(unsigned char busnr)
 {
-	struct pci_bus* bus;
+	struct pci_bus* bus = NULL;
 	struct pci_bus* tmp_bus;
 
-	pci_for_each_bus(bus) {
+	while ((bus = pci_find_next_bus(bus)) != NULL)  {
 		tmp_bus = pci_do_find_bus(bus, busnr);
 		if(tmp_bus)
 			return tmp_bus;
@@ -41,6 +41,26 @@
 }
 
 /**
+ * pci_find_next_bus - begin or continue searching for a PCI bus
+ * @from: Previous PCI bus found, or %NULL for new search.
+ *
+ * Iterates through the list of known PCI busses.  A new search is
+ * initiated by passing %NULL to the @from argument.  Otherwise if
+ * @from is not %NULL, searches continue from next device on the
+ * global list.
+ */
+struct pci_bus * 
+pci_find_next_bus(const struct pci_bus *from)
+{
+	struct list_head *n = from ? from->node.next : pci_root_buses.next;
+	struct pci_bus *b = NULL;
+
+	if (n != &pci_root_buses)
+		b = pci_bus_b(n);
+	return b;
+}
+
+/**
  * pci_find_slot - locate PCI device from a given PCI slot
  * @bus: number of PCI bus on which desired PCI device resides
  * @devfn: encodes number of PCI slot in which the desired PCI 
@@ -96,7 +116,6 @@
 	}
 	return NULL;
 }
-
 
 /**
  * pci_find_device - begin or continue searching for a PCI device by vendor/device id
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Tue Jun 10 11:15:57 2003
+++ b/include/linux/pci.h	Tue Jun 10 11:15:57 2003
@@ -568,6 +568,7 @@
 struct pci_dev *pci_find_class (unsigned int class, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
+struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
 
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);

