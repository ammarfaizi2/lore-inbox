Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTJOSdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTJOScz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:32:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27866 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263961AbTJOScQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:32:16 -0400
Date: Wed, 15 Oct 2003 19:32:13 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] pci_get_slot()
Message-ID: <20031015183213.GG16535@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus.

tg3.c has a bug where it can find the wrong 5704 peer on a machine with
PCI domains.  The problem is that pci_find_slot() can't distinguish
whether it has the correct domain or not.

This patch fixes that problem by introducing pci_get_slot() and converts
tg3 to use it.  It also fixes another problem where tg3 wouldn't find
a peer on function 7 (0 to <8, not 0 to <7).

Index: linux-2.6/drivers/net/tg3.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/net/tg3.c,v
retrieving revision 1.5
diff -u -p -r1.5 tg3.c
--- linux-2.6/drivers/net/tg3.c	8 Sep 2003 21:42:12 -0000	1.5
+++ linux-2.6/drivers/net/tg3.c	15 Oct 2003 18:18:28 -0000
@@ -7462,23 +7462,24 @@ static char * __devinit tg3_phy_string(s
 
 static struct pci_dev * __devinit tg3_find_5704_peer(struct tg3 *tp)
 {
-	struct pci_dev *peer = NULL;
-	unsigned int func;
+	struct pci_dev *peer;
+	unsigned int func, devnr = tp->pdev->devfn & ~7;
 
-	for (func = 0; func < 7; func++) {
-		unsigned int devfn = tp->pdev->devfn;
-
-		devfn &= ~7;
-		devfn |= func;
-
-		if (devfn == tp->pdev->devfn)
-			continue;
-		peer = pci_find_slot(tp->pdev->bus->number, devfn);
-		if (peer)
+	for (func = 0; func < 8; func++) {
+		peer = pci_get_slot(tp->pdev->bus, devnr | func);
+		if (peer && peer != tp->pdev)
 			break;
+		pci_dev_put(peer);
 	}
 	if (!peer || peer == tp->pdev)
 		BUG();
+
+	/*
+	 * We don't need to keep the refcount elevated; there's no way
+	 * to remove one half of this device without removing the other
+	 */
+	pci_dev_put(peer);
+
 	return peer;
 }
 
Index: linux-2.6/drivers/pci/search.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/search.c,v
retrieving revision 1.1
diff -u -p -r1.1 search.c
--- linux-2.6/drivers/pci/search.c	29 Jul 2003 17:01:25 -0000	1.1
+++ linux-2.6/drivers/pci/search.c	15 Oct 2003 18:18:28 -0000
@@ -104,6 +104,41 @@ pci_find_slot(unsigned int bus, unsigned
 }
 
 /**
+ * pci_get_slot - locate PCI device for a given PCI slot
+ * @bus: PCI bus on which desired PCI device resides
+ * @devfn: encodes number of PCI slot in which the desired PCI 
+ * device resides and the logical device number within that slot 
+ * in case of multi-function devices.
+ *
+ * Given a PCI bus and slot/function number, the desired PCI device 
+ * is located in the list of PCI devices.
+ * If the device is found, its reference count is increased and this
+ * function returns a pointer to its data structure.  The caller must
+ * decrement the reference count by calling pci_dev_put().
+ * If no device is found, %NULL is returned.
+ */
+struct pci_dev * pci_get_slot(struct pci_bus *bus, unsigned int devfn)
+{
+	struct list_head *tmp;
+	struct pci_dev *dev;
+
+	WARN_ON(in_interrupt());
+	spin_lock(&pci_bus_lock);
+
+	list_for_each(tmp, &bus->children) {
+		dev = pci_dev_b(tmp);
+		if (dev->devfn == devfn)
+			goto out;
+	}
+
+	dev = NULL;
+ out:
+	pci_dev_get(dev);
+	spin_unlock(&pci_bus_lock);
+	return dev;
+}
+
+/**
  * pci_find_subsys - begin or continue searching for a PCI device by vendor/subvendor/device/subdevice id
  * @vendor: PCI vendor id to match, or %PCI_ANY_ID to match all vendor ids
  * @device: PCI device id to match, or %PCI_ANY_ID to match all device ids
@@ -319,3 +354,4 @@ EXPORT_SYMBOL(pci_find_slot);
 EXPORT_SYMBOL(pci_find_subsys);
 EXPORT_SYMBOL(pci_get_device);
 EXPORT_SYMBOL(pci_get_subsys);
+EXPORT_SYMBOL(pci_get_slot);
Index: linux-2.6/include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/pci.h,v
retrieving revision 1.5
diff -u -p -r1.5 pci.h
--- linux-2.6/include/linux/pci.h	8 Oct 2003 20:53:03 -0000	1.5
+++ linux-2.6/include/linux/pci.h	15 Oct 2003 18:18:34 -0000
@@ -607,6 +607,8 @@ struct pci_dev *pci_get_device (unsigned
 struct pci_dev *pci_get_subsys (unsigned int vendor, unsigned int device,
 				unsigned int ss_vendor, unsigned int ss_device,
 				struct pci_dev *from);
+struct pci_dev *pci_get_slot (struct pci_bus *bus, unsigned int devfn);
+
 int pci_bus_read_config_byte (struct pci_bus *bus, unsigned int devfn, int where, u8 *val);
 int pci_bus_read_config_word (struct pci_bus *bus, unsigned int devfn, int where, u16 *val);
 int pci_bus_read_config_dword (struct pci_bus *bus, unsigned int devfn, int where, u32 *val);

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
