Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTFJT3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFJSj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:39:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5027 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264069AbTFJShg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:36 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709651054@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709651213@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:25 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1329, 2003/06/09 15:36:48-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/char/sx.c


 drivers/char/sx.c |  116 +++++++++++++++++++++++++++---------------------------
 1 files changed, 58 insertions(+), 58 deletions(-)


diff -Nru a/drivers/char/sx.c b/drivers/char/sx.c
--- a/drivers/char/sx.c	Tue Jun 10 11:21:40 2003
+++ b/drivers/char/sx.c	Tue Jun 10 11:21:40 2003
@@ -2460,69 +2460,68 @@
 	}
 
 #ifdef CONFIG_PCI
-	if (pci_present ()) {
 #ifndef TWO_ZERO
-		while ((pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
-		                                PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, 
-			                              pdev))) {
-			if (pci_enable_device(pdev))
-				continue;
+	while ((pdev = pci_find_device (PCI_VENDOR_ID_SPECIALIX, 
+					PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, 
+					      pdev))) {
+		if (pci_enable_device(pdev))
+			continue;
 #else
-			for (i=0;i< SX_NBOARDS;i++) {
-				if (pcibios_find_device (PCI_VENDOR_ID_SPECIALIX, 
-				                         PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, i,
-					                       &pci_bus, &pci_fun)) break;
+	for (i=0;i< SX_NBOARDS;i++) {
+		if (pcibios_find_device (PCI_VENDOR_ID_SPECIALIX, 
+					 PCI_DEVICE_ID_SPECIALIX_SX_XIO_IO8, i,
+					       &pci_bus, &pci_fun))
+			break;
 #endif
-			/* Specialix has a whole bunch of cards with
-			   0x2000 as the device ID. They say its because
-			   the standard requires it. Stupid standard. */
-			/* It seems that reading a word doesn't work reliably on 2.0.
-			   Also, reading a non-aligned dword doesn't work. So we read the
-			   whole dword at 0x2c and extract the word at 0x2e (SUBSYSTEM_ID)
-			   ourselves */
-			/* I don't know why the define doesn't work, constant 0x2c does --REW */ 
-			pci_read_config_dword (pdev, 0x2c, &tint);
-			tshort = (tint >> 16) & 0xffff;
-			sx_dprintk (SX_DEBUG_PROBE, "Got a specialix card: %x.\n", tint);
-			/* sx_dprintk (SX_DEBUG_PROBE, "pdev = %d/%d	(%x)\n", pdev, tint); */ 
-			if ((tshort != 0x0200) && (tshort != 0x0300)) {
-				sx_dprintk (SX_DEBUG_PROBE, "But it's not an SX card (%d)...\n", 
-				            tshort);
-				continue;
-			}
-			board = &boards[found];
+		/* Specialix has a whole bunch of cards with
+		   0x2000 as the device ID. They say its because
+		   the standard requires it. Stupid standard. */
+		/* It seems that reading a word doesn't work reliably on 2.0.
+		   Also, reading a non-aligned dword doesn't work. So we read the
+		   whole dword at 0x2c and extract the word at 0x2e (SUBSYSTEM_ID)
+		   ourselves */
+		/* I don't know why the define doesn't work, constant 0x2c does --REW */ 
+		pci_read_config_dword (pdev, 0x2c, &tint);
+		tshort = (tint >> 16) & 0xffff;
+		sx_dprintk (SX_DEBUG_PROBE, "Got a specialix card: %x.\n", tint);
+		/* sx_dprintk (SX_DEBUG_PROBE, "pdev = %d/%d	(%x)\n", pdev, tint); */ 
+		if ((tshort != 0x0200) && (tshort != 0x0300)) {
+			sx_dprintk (SX_DEBUG_PROBE, "But it's not an SX card (%d)...\n", 
+				    tshort);
+			continue;
+		}
+		board = &boards[found];
 
-			board->flags &= ~SX_BOARD_TYPE;
-			board->flags |= (tshort == 0x200)?SX_PCI_BOARD:
-			                                  SX_CFPCI_BOARD;
+		board->flags &= ~SX_BOARD_TYPE;
+		board->flags |= (tshort == 0x200)?SX_PCI_BOARD:
+						  SX_CFPCI_BOARD;
 
-			/* CF boards use base address 3.... */
-			if (IS_CF_BOARD (board))
-				board->hw_base = pci_resource_start (pdev, 3);
-			else
-				board->hw_base = pci_resource_start (pdev, 2);
-			board->base2 = 
-			board->base = (ulong) ioremap(board->hw_base, WINDOW_LEN (board));
-			if (!board->base) {
-				printk(KERN_ERR "ioremap failed\n");
-				/* XXX handle error */
-			}
-
-			/* Most of the stuff on the CF board is offset by
-			   0x18000 ....  */
-			if (IS_CF_BOARD (board)) board->base += 0x18000;
-
-			board->irq = pdev->irq;
-
-			sx_dprintk (SX_DEBUG_PROBE, "Got a specialix card: %x/%lx(%d) %x.\n", 
-			            tint, boards[found].base, board->irq, board->flags);
-
-			if (probe_sx (board)) {
-				found++;
-				fix_sx_pci (pdev, board);
-			} else 
-				iounmap ((char *) (board->base));
-		}
+		/* CF boards use base address 3.... */
+		if (IS_CF_BOARD (board))
+			board->hw_base = pci_resource_start (pdev, 3);
+		else
+			board->hw_base = pci_resource_start (pdev, 2);
+		board->base2 = 
+		board->base = (ulong) ioremap(board->hw_base, WINDOW_LEN (board));
+		if (!board->base) {
+			printk(KERN_ERR "ioremap failed\n");
+			/* XXX handle error */
+		}
+
+		/* Most of the stuff on the CF board is offset by
+		   0x18000 ....  */
+		if (IS_CF_BOARD (board)) board->base += 0x18000;
+
+		board->irq = pdev->irq;
+
+		sx_dprintk (SX_DEBUG_PROBE, "Got a specialix card: %x/%lx(%d) %x.\n", 
+			    tint, boards[found].base, board->irq, board->flags);
+
+		if (probe_sx (board)) {
+			found++;
+			fix_sx_pci (pdev, board);
+		} else 
+			iounmap ((char *) (board->base));
 	}
 #endif
 
@@ -2648,4 +2647,5 @@
 
 module_init(sx_init);
 module_exit(sx_exit);
+
 

