Return-Path: <linux-kernel-owner+w=401wt.eu-S1751376AbXAFMYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbXAFMYu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 07:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbXAFMYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 07:24:50 -0500
Received: from smtp.telefonica.net ([213.4.149.66]:20481 "EHLO
	ctsmtpout4.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751376AbXAFMYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 07:24:50 -0500
From: Jose Alberto Reguero <jareguero@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add suport for Marvell 88SE6121 in pata_marvell
Date: Sat, 6 Jan 2007 13:24:47 +0100
User-Agent: KMail/1.9.5
Cc: Jose Alberto Reguero <jareguero@telefonica.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PU5nFvVbQYNE3ui"
Message-Id: <200701061324.47993.jareguero@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PU5nFvVbQYNE3ui
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Marvell 88SE6121 is a ahci controller, but I can't make it work with the achi 
driver.
This part:

+       else if (pdev->device == 0x6121) {
+               mmio_base = pci_iomap(pdev, 5, 0);
+               if (mmio_base == NULL) {
+                       return -ENOMEM;
+               }
+               /* turn on legacy mode */
+               writel(0, mmio_base + 0x04);
+               (void) readl(mmio_base + 0x04); /* flush */
+       }

put the ahci in legacy mode and work with pata_marvell.
Perhaps someone else can make it work whith the ahci driver.

Jose Alberto

--Boundary-00=_PU5nFvVbQYNE3ui
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pata_marvell.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pata_marvell.diff"

--- linux-2.6.20-rc3/drivers/ata/pata_marvell.c	2007-01-01 01:53:20.000000000 +0100
+++ linux-2.6.20-rc3.new/drivers/ata/pata_marvell.c	2007-01-06 12:33:03.000000000 +0100
@@ -49,7 +49,7 @@
 	devices = readl(barp + 0x0C);
 	pci_iounmap(pdev, barp);
 	
-	if ((pdev->device == 0x6145) && (ap->port_no == 0) &&
+	if (((pdev->device == 0x6145) || (pdev->device == 0x6121)) && (ap->port_no == 0) &&
 	    (!(devices & 0x10)))	/* PATA enable ? */
 		return -ENOENT;
 
@@ -181,9 +181,19 @@
 	};
 	struct ata_port_info *port_info[2] = { &info, &info_sata };
 	int n_port = 2;
+	void __iomem *mmio_base;
 
 	if (pdev->device == 0x6101)
 		n_port = 1;
+	else if (pdev->device == 0x6121) {
+		mmio_base = pci_iomap(pdev, 5, 0);
+		if (mmio_base == NULL) {
+			return -ENOMEM;
+		}
+		/* turn on legacy mode */
+		writel(0, mmio_base + 0x04);
+		(void) readl(mmio_base + 0x04);	/* flush */
+	}
 
 	return ata_pci_init_one(pdev, port_info, n_port);
 }
@@ -191,6 +201,7 @@
 static const struct pci_device_id marvell_pci_tbl[] = {
 	{ PCI_DEVICE(0x11AB, 0x6101), },
 	{ PCI_DEVICE(0x11AB, 0x6145), },
+	{ PCI_DEVICE(0x11AB, 0x6121), },
 	{ }	/* terminate list */
 };
 

--Boundary-00=_PU5nFvVbQYNE3ui--
