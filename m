Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268889AbUHLXWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268889AbUHLXWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUHLXWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:22:36 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:11965 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268888AbUHLXV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:21:59 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Paul Blazejowski <diffie@gmail.com>
Subject: Re: 2.6.8-rc4-mm1
Date: Thu, 12 Aug 2004 17:21:46 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <9dda3492040812114929cf8dcc@mail.gmail.com>
In-Reply-To: <9dda3492040812114929cf8dcc@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408121721.46807.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 August 2004 12:49 pm, Paul Blazejowski wrote:
> I managed to caputre the serial console output of the boot process
> with the error. Below is the full log.

Thank you very much for the pictures and the transcript.  I found a
couple bugs in the iteraid driver.  Could you please try the attached
patch?

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
+++ 2.6.8-rc4-mm1/drivers/scsi/iteraid.c	2004-08-12 17:18:19.419922969 -0600
@@ -4798,6 +4798,7 @@
 			       pAdap->name);
 			return -1;
 		}
+		printk("%s: IRQ %d for device at %s\n", __FUNCTION__, pAdap->irq, pci_name(pPciDev));
 		pAdap->irqOwned = pAdap->irq;
 	}
 
@@ -4901,12 +4902,17 @@
 		if (PCI_FUNC(pPciDev->devfn))
 			continue;
 
+		if (pci_enable_device(pPciDev))
+			continue;
+
+		printk("%s: device at %s\n", __FUNCTION__, pci_name(pPciDev));
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
@@ -5016,6 +5022,7 @@
 		if (pAdap->IDEChannel != NULL) {
 			kfree(pAdap->IDEChannel);
 		}
+		pci_disable_device(pAdap->pci_dev);
 		if (pAdap != NULL) {
 			kfree(pAdap);
 		}
