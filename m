Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUBTTUW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUBTTLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:11:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:486 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261284AbUBTTGZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:06:25 -0500
Subject: Re: [PATCH] PCI update for 2.6.3
In-Reply-To: <10773039773934@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 20 Feb 2004 11:06:18 -0800
Message-Id: <10773039782824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.58.3, 2004/02/18 11:16:24-08:00, willy@debian.org

[PATCH] PCI: Fix pci_bus_find_capability()

pci_bus_find_capability() is currently broken.  It checks the wrong
device's hdr_type for being a cardbus bridge or not.  This patch pulls
the guts of pci_bus_find_capability() and pci_find_capability() into a
new function __pci_bus_find_cap() and changes these two functions to
call it.


 drivers/pci/pci.c |   94 +++++++++++++++++++++---------------------------------
 1 files changed, 38 insertions(+), 56 deletions(-)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Fri Feb 20 10:45:15 2004
+++ b/drivers/pci/pci.c	Fri Feb 20 10:45:15 2004
@@ -67,6 +67,39 @@
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
@@ -94,34 +127,7 @@
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
@@ -139,35 +145,11 @@
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

