Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUHMPxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUHMPxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUHMPxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:53:18 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:60859 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S266034AbUHMPxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:53:12 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] iteraid: pci_enable_device() for IRQ routing
Date: Fri, 13 Aug 2004 09:53:03 -0600
User-Agent: KMail/1.6.2
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Paul Blazejowski <diffie@gmail.com>, "Randy.Dunlap" <rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408130953.03714.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iteraid: add pci_enable_device() and fix IRQ truncation.

Thanks to Paul Blazejowski for reporting a boot-time panic and verifying
that this patch fixes it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

--- 2.6.8-rc4-mm1/drivers/scsi/iteraid.h.orig	2004-08-12 16:50:38.483419878 -0600
+++ 2.6.8-rc4-mm1/drivers/scsi/iteraid.h	2004-08-12 17:16:08.569338635 -0600
@@ -1203,8 +1203,8 @@
 typedef struct _Adapter {
 	char *name;		/* Adapter's name               */
 	u8 num_channels;	/* How many channels support    */
-	u8 irq;			/* irq number                   */
-	u8 irqOwned;		/* If any irq is use            */
+	unsigned int irq;	/* irq number                   */
+	unsigned int irqOwned;	/* If any irq is use            */
 	u8 pci_bus;		/* PCI bus number               */
 	u8 devfn;		/* Device and function number   */
 	u8 offline;		/* On line or off line          */
--- 2.6.8-rc4-mm1/drivers/scsi/iteraid.c.orig	2004-08-12 16:43:38.700221895 -0600
+++ 2.6.8-rc4-mm1/drivers/scsi/iteraid.c	2004-08-13 09:44:47.057869796 -0600
@@ -4901,12 +4901,16 @@
 		if (PCI_FUNC(pPciDev->devfn))
 			continue;
 
+		if (pci_enable_device(pPciDev))
+			continue;
+
 		/*
 		 * Allocate memory for Adapter.
 		 */
 		pAdap = (PITE_ADAPTER) kmalloc(sizeof(ITE_ADAPTER), GFP_ATOMIC);
 		if (pAdap == NULL) {
 			printk("iteraid_detect: pAdap allocate failed.\n");
+			pci_disable_device(pPciDev);
 			continue;
 		}
 		memset(pAdap, 0, sizeof(ITE_ADAPTER));
@@ -5016,6 +5020,7 @@
 		if (pAdap->IDEChannel != NULL) {
 			kfree(pAdap->IDEChannel);
 		}
+		pci_disable_device(pAdap->pci_dev);
 		if (pAdap != NULL) {
 			kfree(pAdap);
 		}
