Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSFDAnB>; Mon, 3 Jun 2002 20:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315718AbSFDAnA>; Mon, 3 Jun 2002 20:43:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39429 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315547AbSFDAm7>;
	Mon, 3 Jun 2002 20:42:59 -0400
Message-ID: <3CFC0CC2.D69F2C57@zip.com.au>
Date: Mon, 03 Jun 2002 17:41:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Kees Bakker <kees.bakker@xs4all.nl>, Patrick Mochel <mochel@osdl.org>,
        Anton Altaparmakov <aia21@cantab.net>,
        Anton Blanchard <anton@samba.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [patch] PCI device matching fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new pci_device_probe() is always passing the zeroeth
entry in the id_table to the device's probe method.  It
needs to scan that table for the correct ID first.

This fixes the recent 3c59x strangenesses.


--- 2.5.20/drivers/pci/pci-driver.c~pci-scan	Mon Jun  3 17:37:59 2002
+++ 2.5.20-akpm/drivers/pci/pci-driver.c	Mon Jun  3 17:38:03 2002
@@ -38,12 +38,19 @@ pci_match_device(const struct pci_device
 static int pci_device_probe(struct device * dev)
 {
 	int error = 0;
+	struct pci_driver *drv;
+	struct pci_dev *pci_dev;
 
-	struct pci_driver * drv = list_entry(dev->driver,struct pci_driver,driver);
-	struct pci_dev * pci_dev = list_entry(dev,struct pci_dev,dev);
+	drv = list_entry(dev->driver, struct pci_driver, driver);
+	pci_dev = list_entry(dev, struct pci_dev, dev);
 
-	if (drv->probe)
-		error = drv->probe(pci_dev,drv->id_table);
+	if (drv->probe) {
+		const struct pci_device_id *id;
+
+		id = pci_match_device(drv->id_table, pci_dev);
+		if (id)
+			error = drv->probe(pci_dev, id);
+	}
 	return error > 0 ? 0 : -ENODEV;
 }
 

-
