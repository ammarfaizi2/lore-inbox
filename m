Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbTFJUiG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTFJUcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:32:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21423 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263971AbTFJShX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:23 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709663992@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270966633@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:26 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1337, 2003/06/09 15:48:21-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/net/dgrs.c


 drivers/net/dgrs.c |   80 +++++++++++++++++++++++++----------------------------
 1 files changed, 38 insertions(+), 42 deletions(-)


diff -Nru a/drivers/net/dgrs.c b/drivers/net/dgrs.c
--- a/drivers/net/dgrs.c	Tue Jun 10 11:21:04 2003
+++ b/drivers/net/dgrs.c	Tue Jun 10 11:21:04 2003
@@ -1356,55 +1356,51 @@
 	uint	irq;
 	uint	plxreg;
 	uint	plxdma;
+	struct pci_dev *pdev = NULL;
 
 	/*
 	 *	First, check for PCI boards
 	 */
-	if (pci_present())
+	while ((pdev = pci_find_device(SE6_PCI_VENDOR_ID, SE6_PCI_DEVICE_ID, pdev)) != NULL)
 	{
-		struct pci_dev *pdev = NULL;
+		/*
+		 * Get and check the bus-master and latency values.
+		 * Some PCI BIOSes fail to set the master-enable bit,
+		 * and the latency timer must be set to the maximum
+		 * value to avoid data corruption that occurs when the
+		 * timer expires during a transfer.  Yes, it's a bug.
+		 */
+		if (pci_enable_device(pdev))
+			continue;
+		pci_set_master(pdev);
+
+		plxreg = pci_resource_start (pdev, 0);
+		io = pci_resource_start (pdev, 1);
+		mem = pci_resource_start (pdev, 2);
+		pci_read_config_dword(pdev, 0x30, &plxdma);
+		irq = pdev->irq;
+		plxdma &= ~15;
+
+		/*
+		 * On some BIOSES, the PLX "expansion rom" (used for DMA)
+		 * address comes up as "0".  This is probably because
+		 * the BIOS doesn't see a valid 55 AA ROM signature at
+		 * the "ROM" start and zeroes the address.  To get
+		 * around this problem the SE-6 is configured to ask
+		 * for 4 MB of space for the dual port memory.  We then
+		 * must set its range back to 2 MB, and use the upper
+		 * half for DMA register access
+		 */
+		OUTL(io + PLX_SPACE0_RANGE, 0xFFE00000L);
+		if (plxdma == 0)
+			plxdma = mem + (2048L * 1024L);
+		pci_write_config_dword(pdev, 0x30, plxdma + 1);
+		pci_read_config_dword(pdev, 0x30, &plxdma);
+		plxdma &= ~15;
 
-		while ((pdev = pci_find_device(SE6_PCI_VENDOR_ID, SE6_PCI_DEVICE_ID, pdev)) != NULL)
-		{
-			/*
-			 * Get and check the bus-master and latency values.
-			 * Some PCI BIOSes fail to set the master-enable bit,
-			 * and the latency timer must be set to the maximum
-			 * value to avoid data corruption that occurs when the
-			 * timer expires during a transfer.  Yes, it's a bug.
-			 */
-			if (pci_enable_device(pdev))
-				continue;
-			pci_set_master(pdev);
+		dgrs_found_device(io, mem, irq, plxreg, plxdma);
 
-			plxreg = pci_resource_start (pdev, 0);
-			io = pci_resource_start (pdev, 1);
-			mem = pci_resource_start (pdev, 2);
-			pci_read_config_dword(pdev, 0x30, &plxdma);
-			irq = pdev->irq;
-			plxdma &= ~15;
-
-			/*
-			 * On some BIOSES, the PLX "expansion rom" (used for DMA)
-			 * address comes up as "0".  This is probably because
-			 * the BIOS doesn't see a valid 55 AA ROM signature at
-			 * the "ROM" start and zeroes the address.  To get
-			 * around this problem the SE-6 is configured to ask
-			 * for 4 MB of space for the dual port memory.  We then
-			 * must set its range back to 2 MB, and use the upper
-			 * half for DMA register access
-			 */
-			OUTL(io + PLX_SPACE0_RANGE, 0xFFE00000L);
-			if (plxdma == 0)
-				plxdma = mem + (2048L * 1024L);
-			pci_write_config_dword(pdev, 0x30, plxdma + 1);
-			pci_read_config_dword(pdev, 0x30, &plxdma);
-			plxdma &= ~15;
-
-			dgrs_found_device(io, mem, irq, plxreg, plxdma);
-
-			cards_found++;
-		}
+		cards_found++;
 	}
 
 	/*

