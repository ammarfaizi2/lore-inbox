Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTLDWts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 17:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTLDWts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 17:49:48 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:55726
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S263660AbTLDWtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 17:49:25 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A3405F@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.23 add serial driver support for Macrolink MCCS-H car
	ds
Date: Thu, 4 Dec 2003 14:49:38 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

This patch adds support to the generic serial driver for the Macrolink
MCCS-H 8/16-port CompactPCI serial cards, which use XR16C864 UARTs and the
PLX 9030 PCI 2.2 interface chip.  No changes are made to existing serial
driver logic.  No new logic is added beyond the card's own initialization
function.  UARTs are detected as XR16850, which is close enough. 

For kernel version 2.4.23. Please apply.

Thanks,
Ed

diff -urN -X dontdiff.txt linux-2.4.23/drivers/char/serial.c
linux-2.4.23-ml/drivers/char/serial.c
--- linux-2.4.23/drivers/char/serial.c	Thu Dec  4 10:58:33 2003
+++ linux-2.4.23-ml/drivers/char/serial.c	Thu Dec  4 11:36:41 2003
@@ -4297,6 +4297,31 @@
 	return 0;
 }
 
+static int __devinit
+pci_mccsh_fn(struct pci_dev *dev, struct pci_board *board, int enable)
+{
+	u8 *b0, *b3;	/* BAR0: PLX 9030, BAR3: card level regs */
+
+	b0 = ioremap(pci_resource_start(dev, 0), 0x80);
+	b3 = ioremap(pci_resource_start(dev, 3), 0x80);
+	/* Set LED color & irq pacing (4?=grn,0?=yel,?2=256us min interval)
*/
+	/* Enable or disable Enhanced mode and PLX 9030 PCI interrupts. */
+	if (enable) {
+		writel(readl(b0 + 0x54) | 0x04000000, b0 + 0x54); /* GPIO8=1
*/
+		writew(0x42, b3 + 0xa); /* LED=green, max irq pace=256us */
+		writew(0, b3 + 0x2);	/* clear any pending irq */
+		writel((readl(b0 + 0x4c) | 0x40), b0 + 0x4c); /* PCI_IRQ=1
*/
+	} else {
+		writel((readl(b0 + 0x4c) & ~0x40), b0 + 0x4c); /* PCI_IRQ=0
*/
+		writew(0, b3 + 0x2);	/* clear any pending irq */
+		writew(0x00, b3 + 0xa); /* LED=yellow, no irq pace limit */
+		writel(readl(b0 + 0x54) & ~0x04000000, b0 + 0x54); /*
GPIO8=0 */
+	}
+	iounmap(b3);
+	iounmap(b0);
+	return 0;
+}
+
 /*
  * This is the configuration table for all of the PCI serial boards
  * which we support.  It is directly indexed by the pci_board_num_t enum
@@ -4346,6 +4371,9 @@
 	pbn_b2_bt_4_115200,
 	pbn_b2_bt_2_921600,
 
+	pbn_b5_8_1843200,
+	pbn_b5_16_1843200,
+
 	pbn_panacom,
 	pbn_panacom2,
 	pbn_panacom4,
@@ -4428,6 +4456,11 @@
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 115200 }, /*
pbn_b2_bt_4_115200 */
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600 }, /*
pbn_b2_bt_2_921600 */
 
+	{ SPCI_FL_BASE5, 8, 1843200,  /* IOMEM */	/* pbn_b5_8_1843200
*/
+                8, 0, pci_mccsh_fn },
+	{ SPCI_FL_BASE5, 16, 1843200, /* IOMEM */	/* pbn_b5_16_1843200
*/
+                8, 0, pci_mccsh_fn },
+
 	{ SPCI_FL_BASE2, 2, 921600, /* IOMEM */		   /* pbn_panacom */
 		0x400, 7, pci_plx9050_fn },
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_panacom2
*/
@@ -4667,6 +4700,15 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
 		pbn_b2_8_115200 },
 
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+		PCI_VENDOR_ID_MACROLINK,
+		PCI_DEVICE_ID_MACROLINK_MCCS8H, 0, 0,
+		pbn_b5_8_1843200 },
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+		PCI_VENDOR_ID_MACROLINK,
+		PCI_DEVICE_ID_MACROLINK_MCCSH, 0, 0,
+		pbn_b5_16_1843200 },
+
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_GTEK_SERIAL2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b2_bt_2_115200 },
diff -urN -X dontdiff.txt linux-2.4.23/include/linux/pci_ids.h
linux-2.4.23-ml/include/linux/pci_ids.h
--- linux-2.4.23/include/linux/pci_ids.h	Fri Nov 28 10:26:21 2003
+++ linux-2.4.23-ml/include/linux/pci_ids.h	Thu Dec  4 11:36:41 2003
@@ -864,6 +864,7 @@
 #define PCI_DEVICE_ID_PLX_SPCOM200	0x1103
 #define PCI_DEVICE_ID_PLX_DJINN_ITOO	0x1151
 #define PCI_DEVICE_ID_PLX_R753		0x1152
+#define PCI_DEVICE_ID_PLX_9030		0x9030
 #define PCI_DEVICE_ID_PLX_9050		0x9050
 #define PCI_DEVICE_ID_PLX_9060		0x9060
 #define PCI_DEVICE_ID_PLX_9060ES	0x906E
@@ -1685,6 +1686,10 @@
 #define PCI_VENDOR_ID_PDC		0x15e9
 #define PCI_DEVICE_ID_PDC_ADMA100	0x1841
 
+#define PCI_VENDOR_ID_MACROLINK		0x15ed
+#define PCI_DEVICE_ID_MACROLINK_MCCS8H	0x1002
+#define PCI_DEVICE_ID_MACROLINK_MCCSH	0x1003
+
 #define PCI_VENDOR_ID_ALTIMA		0x173b
 #define PCI_DEVICE_ID_ALTIMA_AC1000	0x03e8
 #define PCI_DEVICE_ID_ALTIMA_AC1001	0x03e9
diff -urN -X dontdiff.txt linux-2.4.23/include/linux/serialP.h
linux-2.4.23-ml/include/linux/serialP.h
--- linux-2.4.23/include/linux/serialP.h	Fri Aug  2 17:39:45 2002
+++ linux-2.4.23-ml/include/linux/serialP.h	Thu Dec  4 11:36:41 2003
@@ -170,6 +170,7 @@
 #define SPCI_FL_BASE2	0x0002
 #define SPCI_FL_BASE3	0x0003
 #define SPCI_FL_BASE4	0x0004
+#define SPCI_FL_BASE5	0x0005
 #define SPCI_FL_GET_BASE(x)	(x & SPCI_FL_BASE_MASK)
 
 #define SPCI_FL_IRQ_MASK       (0x0007 << 4)
