Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUBJScx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUBJSa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:30:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2271 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266205AbUBJS2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:28:04 -0500
Date: Tue, 10 Feb 2004 18:28:03 +0000
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] Fix pci_bus_find_capability()
Message-ID: <20040210182803.GH13351@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg.  pci_bus_find_capability() is currently broken.  It checks the
wrong device's hdr_type for being a cardbus bridge or not.  This patch
pulls the guts of pci_bus_find_capability() and pci_find_capability()
into a new function __pci_bus_find_cap() and changes these two functions
to call it.

Index: drivers/pci/pci.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/pci.c,v
retrieving revision 1.4
diff -u -p -r1.4 pci.c
--- a/drivers/pci/pci.c	8 Oct 2003 20:52:35 -0000	1.4
+++ b/drivers/pci/pci.c	10 Feb 2004 18:01:13 -0000
@@ -67,6 +67,39 @@ pci_max_busnr(void)
 	return max;
 }
 
+static int __pci_bus_find_cap(struct pci_bus *bus, unsigned int devfn, u8 hdr_type, int cap)
+{
+	u16 status;
+	u8 pos, id;
+	int ttl = 48;
+
+	pci_bus_read_config_word(bus, devfn, PCI_STATUS, &status);
+	if (!(status & PCI_STATUS_CAP_LIST))
+		return 0;
+
+	switch (hdr_type) {
+	case PCI_HEADER_TYPE_NORMAL:
+	case PCI_HEADER_TYPE_BRIDGE:
+		pci_bus_read_config_byte(bus, devfn, PCI_CAPABILITY_LIST, &pos);
+		break;
+	case PCI_HEADER_TYPE_CARDBUS:
+		pci_bus_read_config_byte(bus, devfn, PCI_CB_CAPABILITY_LIST, &pos);
+		break;
+	default:
+		return 0;
+	}
+	while (ttl-- && pos >= 0x40) {
+		pos &= ~3;
+		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID, &id);
+		if (id == 0xff)
+			break;
+		if (id == cap)
+			return pos;
+		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_NEXT, &pos);
+	}
+	return 0;
+}
+
 /**
  * pci_find_capability - query for devices' capabilities 
  * @dev: PCI device to query
@@ -94,34 +127,7 @@ pci_max_busnr(void)
 int
 pci_find_capability(struct pci_dev *dev, int cap)
 {
-	u16 status;
-	u8 pos, id;
-	int ttl = 48;
-
-	pci_read_config_word(dev, PCI_STATUS, &status);
-	if (!(status & PCI_STATUS_CAP_LIST))
-		return 0;
-	switch (dev->hdr_type) {
-	case PCI_HEADER_TYPE_NORMAL:
-	case PCI_HEADER_TYPE_BRIDGE:
-		pci_read_config_byte(dev, PCI_CAPABILITY_LIST, &pos);
-		break;
-	case PCI_HEADER_TYPE_CARDBUS:
-		pci_read_config_byte(dev, PCI_CB_CAPABILITY_LIST, &pos);
-		break;
-	default:
-		return 0;
-	}
-	while (ttl-- && pos >= 0x40) {
-		pos &= ~3;
-		pci_read_config_byte(dev, pos + PCI_CAP_LIST_ID, &id);
-		if (id == 0xff)
-			break;
-		if (id == cap)
-			return pos;
-		pci_read_config_byte(dev, pos + PCI_CAP_LIST_NEXT, &pos);
-	}
-	return 0;
+	return __pci_bus_find_cap(dev->bus, dev->devfn, dev->hdr_type, cap);
 }
 
 /**
@@ -139,35 +145,11 @@ pci_find_capability(struct pci_dev *dev,
  */
 int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap)
 {
-	u16 status;
-	u8 pos, id;
-	int ttl = 48;
-	struct pci_dev *dev = bus->self;
+	u8 hdr_type;
 
-	pci_bus_read_config_word(bus, devfn, PCI_STATUS, &status);
-	if (!(status & PCI_STATUS_CAP_LIST))
-		return 0;
-	switch (dev->hdr_type) {
-	case PCI_HEADER_TYPE_NORMAL:
-	case PCI_HEADER_TYPE_BRIDGE:
-		pci_bus_read_config_byte(bus, devfn, PCI_CAPABILITY_LIST, &pos);
-		break;
-	case PCI_HEADER_TYPE_CARDBUS:
-		pci_bus_read_config_byte(bus, devfn, PCI_CB_CAPABILITY_LIST, &pos);
-		break;
-	default:
-		return 0;
-	}
-	while (ttl-- && pos >= 0x40) {
-		pos &= ~3;
-		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID, &id);
-		if (id == 0xff)
-			break;
-		if (id == cap)
-			return pos;
-		pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_NEXT, &pos);
-	}
-	return 0;
+	pci_bus_read_config_byte(bus, devfn, PCI_HEADER_TYPE, &hdr_type);
+
+	return __pci_bus_find_cap(bus, devfn, hdr_type & 0x7f, cap);
 }
 
 /**

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
