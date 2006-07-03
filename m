Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWGCAuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWGCAuV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWGCAuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:50:21 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:21980 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750736AbWGCAuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:50:20 -0400
Message-Id: <20060703004056.029311000@myri.com>
References: <20060703003959.942374000@myri.com>
User-Agent: quilt/0.45-1
Date: Sun, 02 Jul 2006 20:40:03 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch 4/7] Rename PCI_CAP_ID_HT_IRQCONF into PCI_CAP_ID_HT
Content-Disposition: inline; filename=04-rename_pci_cap_id_ht_irqconf.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0x08 is the HT capability, while PCI_CAP_ID_HT_IRQCONF would be
the subtype 0x80 that mpic_scan_ht_pic() uses.
Rename PCI_CAP_ID_HT_IRQCONF into PCI_CAP_ID_HT.

And by the way, use it in the ipath driver instead of defining its
own HT_CAPABILITY_ID.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 arch/powerpc/sysdev/mpic.c                |    2 +-
 drivers/infiniband/hw/ipath/ipath_ht400.c |    5 ++---
 include/linux/pci_regs.h                  |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

Index: linux-git/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-git.orig/arch/powerpc/sysdev/mpic.c	2006-07-02 11:41:33.000000000 -0400
+++ linux-git/arch/powerpc/sysdev/mpic.c	2006-07-02 11:41:40.000000000 -0400
@@ -249,7 +249,7 @@
 	for (pos = readb(devbase + PCI_CAPABILITY_LIST); pos != 0;
 	     pos = readb(devbase + pos + PCI_CAP_LIST_NEXT)) {
 		u8 id = readb(devbase + pos + PCI_CAP_LIST_ID);
-		if (id == PCI_CAP_ID_HT_IRQCONF) {
+		if (id == PCI_CAP_ID_HT) {
 			id = readb(devbase + pos + 3);
 			if (id == 0x80)
 				break;
Index: linux-git/include/linux/pci_regs.h
===================================================================
--- linux-git.orig/include/linux/pci_regs.h	2006-07-02 11:41:33.000000000 -0400
+++ linux-git/include/linux/pci_regs.h	2006-07-02 11:41:40.000000000 -0400
@@ -196,7 +196,7 @@
 #define  PCI_CAP_ID_MSI		0x05	/* Message Signalled Interrupts */
 #define  PCI_CAP_ID_CHSWP	0x06	/* CompactPCI HotSwap */
 #define  PCI_CAP_ID_PCIX	0x07	/* PCI-X */
-#define  PCI_CAP_ID_HT_IRQCONF	0x08	/* HyperTransport IRQ Configuration */
+#define  PCI_CAP_ID_HT		0x08	/* HyperTransport */
 #define  PCI_CAP_ID_VNDR	0x09	/* Vendor specific capability */
 #define  PCI_CAP_ID_SHPC 	0x0C	/* PCI Standard Hot-Plug Controller */
 #define  PCI_CAP_ID_EXP 	0x10	/* PCI Express */
Index: linux-git/drivers/infiniband/hw/ipath/ipath_ht400.c
===================================================================
--- linux-git.orig/drivers/infiniband/hw/ipath/ipath_ht400.c	2006-07-02 11:42:39.000000000 -0400
+++ linux-git/drivers/infiniband/hw/ipath/ipath_ht400.c	2006-07-02 11:43:09.000000000 -0400
@@ -742,7 +742,6 @@
 	return 0;
 }
 
-#define HT_CAPABILITY_ID   0x08	/* HT capabilities not defined in kernel */
 #define HT_INTR_DISC_CONFIG  0x80	/* HT interrupt and discovery cap */
 #define HT_INTR_REG_INDEX    2	/* intconfig requires indirect accesses */
 
@@ -973,7 +972,7 @@
 	 * do this early, before we ever enable errors or hardware errors,
 	 * mostly to avoid causing the chip to enter freeze mode.
 	 */
-	pos = pci_find_capability(pdev, HT_CAPABILITY_ID);
+	pos = pci_find_capability(pdev, PCI_CAP_ID_HT);
 	if (!pos) {
 		ipath_dev_err(dd, "Couldn't find HyperTransport "
 			      "capability; no interrupts\n");
@@ -996,7 +995,7 @@
 		else if (cap_type == HT_INTR_DISC_CONFIG)
 			ihandler = set_int_handler(dd, pdev, pos);
 	} while ((pos = pci_find_next_capability(pdev, pos,
-						 HT_CAPABILITY_ID)));
+						 PCI_CAP_ID_HT)));
 
 	if (!ihandler) {
 		ipath_dev_err(dd, "Couldn't find interrupt handler in "

