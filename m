Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbTDXNKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTDXNKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:10:51 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:6612 "EHLO gaston")
	by vger.kernel.org with ESMTP id S261999AbTDXNKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:10:50 -0400
Subject: [PATCH] Let ide interfaces choose a parent device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051190571.12880.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 15:22:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Right now, the parent struct device of IDE interfaces is forced to be
either the pci_dev or some not-yet implemented legacy node. This is
wrong as non-PCI ide interfaces may well hang off different bus types.
For PowerMac, for example, I'm defining a bus type for Apple's "MacIO"
ASIC and ide/ppc/pmac.c will hang off a device on that bus.

The following patch will let the HWIF fill the parent pointer and only
put it's "default" stuff in there if it's NULL.


--- 1.40/drivers/ide/ide-probe.c	Fri Apr 18 17:58:55 2003
+++ edited/drivers/ide/ide-probe.c	Thu Apr 24 15:15:15 2003
@@ -696,10 +696,12 @@
 	strncpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
 	snprintf(hwif->gendev.name,DEVICE_NAME_SIZE,"IDE Controller");
 	hwif->gendev.driver_data = hwif;
-	if (hwif->pci_dev)
-		hwif->gendev.parent = &hwif->pci_dev->dev;
-	else
-		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
+	if (hwif->gendev.parent == NULL) {
+		if (hwif->pci_dev)
+			hwif->gendev.parent = &hwif->pci_dev->dev;
+		else
+			hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
+	}
 	device_register(&hwif->gendev);
 
 	if (hwif->mmio == 2)


