Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTLDXcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTLDXcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:32:16 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:45020
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S263734AbTLDXcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:32:10 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A34060@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.23 add serial driver support for Macrolink MCCS-H car
	ds
Date: Thu, 4 Dec 2003 15:32:23 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3BABE.DEA8E8B0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3BABE.DEA8E8B0
Content-Type: text/plain;
	charset="iso-8859-1"

Hi again Marcelo,

(Looks like the mailer smashed the longer lines in the patch text.
Here it is again as an attached file.)

This patch adds support to the generic serial driver for the Macrolink
MCCS-H 8/16-port CompactPCI serial cards, which use XR16C864 UARTs and the
PLX 9030 PCI 2.2 interface chip.  No changes are made to existing serial
driver logic.  No new logic is added beyond the card's own initialization
function.  UARTs are detected as XR16850, which is close enough. 

For kernel version 2.4.23. Please apply.

Thanks,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------


------_=_NextPart_000_01C3BABE.DEA8E8B0
Content-Type: application/octet-stream;
	name="patch-mccsh-2.4.23"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-mccsh-2.4.23"

diff -urN -X dontdiff.txt linux-2.4.23/drivers/char/serial.c =
linux-2.4.23-ml/drivers/char/serial.c=0A=
--- linux-2.4.23/drivers/char/serial.c	Thu Dec  4 10:58:33 2003=0A=
+++ linux-2.4.23-ml/drivers/char/serial.c	Thu Dec  4 11:36:41 2003=0A=
@@ -4297,6 +4297,31 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static int __devinit=0A=
+pci_mccsh_fn(struct pci_dev *dev, struct pci_board *board, int =
enable)=0A=
+{=0A=
+	u8 *b0, *b3;	/* BAR0: PLX 9030, BAR3: card level regs */=0A=
+=0A=
+	b0 =3D ioremap(pci_resource_start(dev, 0), 0x80);=0A=
+	b3 =3D ioremap(pci_resource_start(dev, 3), 0x80);=0A=
+	/* Set LED color & irq pacing (4?=3Dgrn,0?=3Dyel,?2=3D256us min =
interval) */=0A=
+	/* Enable or disable Enhanced mode and PLX 9030 PCI interrupts. */=0A=
+	if (enable) {=0A=
+		writel(readl(b0 + 0x54) | 0x04000000, b0 + 0x54); /* GPIO8=3D1 */=0A=
+		writew(0x42, b3 + 0xa); /* LED=3Dgreen, max irq pace=3D256us */=0A=
+		writew(0, b3 + 0x2);	/* clear any pending irq */=0A=
+		writel((readl(b0 + 0x4c) | 0x40), b0 + 0x4c); /* PCI_IRQ=3D1 */=0A=
+	} else {=0A=
+		writel((readl(b0 + 0x4c) & ~0x40), b0 + 0x4c); /* PCI_IRQ=3D0 */=0A=
+		writew(0, b3 + 0x2);	/* clear any pending irq */=0A=
+		writew(0x00, b3 + 0xa); /* LED=3Dyellow, no irq pace limit */=0A=
+		writel(readl(b0 + 0x54) & ~0x04000000, b0 + 0x54); /* GPIO8=3D0 =
*/=0A=
+	}=0A=
+	iounmap(b3);=0A=
+	iounmap(b0);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * This is the configuration table for all of the PCI serial boards=0A=
  * which we support.  It is directly indexed by the pci_board_num_t =
enum=0A=
@@ -4346,6 +4371,9 @@=0A=
 	pbn_b2_bt_4_115200,=0A=
 	pbn_b2_bt_2_921600,=0A=
 =0A=
+	pbn_b5_8_1843200,=0A=
+	pbn_b5_16_1843200,=0A=
+=0A=
 	pbn_panacom,=0A=
 	pbn_panacom2,=0A=
 	pbn_panacom4,=0A=
@@ -4428,6 +4456,11 @@=0A=
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 115200 }, /* =
pbn_b2_bt_4_115200 */=0A=
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* =
pbn_b2_bt_2_921600 */=0A=
 =0A=
+	{ SPCI_FL_BASE5, 8, 1843200,  /* IOMEM */	/* pbn_b5_8_1843200 */=0A=
+                8, 0, pci_mccsh_fn },=0A=
+	{ SPCI_FL_BASE5, 16, 1843200, /* IOMEM */	/* pbn_b5_16_1843200 */=0A=
+                8, 0, pci_mccsh_fn },=0A=
+=0A=
 	{ SPCI_FL_BASE2, 2, 921600, /* IOMEM */		   /* pbn_panacom */=0A=
 		0x400, 7, pci_plx9050_fn },=0A=
 	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_panacom2 =
*/=0A=
@@ -4667,6 +4700,15 @@=0A=
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, =0A=
 		pbn_b2_8_115200 },=0A=
 =0A=
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCS8H, 0, 0,=0A=
+		pbn_b5_8_1843200 },=0A=
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCSH, 0, 0,=0A=
+		pbn_b5_16_1843200 },=0A=
+=0A=
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_GTEK_SERIAL2,=0A=
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,=0A=
 		pbn_b2_bt_2_115200 },=0A=
diff -urN -X dontdiff.txt linux-2.4.23/include/linux/pci_ids.h =
linux-2.4.23-ml/include/linux/pci_ids.h=0A=
--- linux-2.4.23/include/linux/pci_ids.h	Fri Nov 28 10:26:21 2003=0A=
+++ linux-2.4.23-ml/include/linux/pci_ids.h	Thu Dec  4 11:36:41 2003=0A=
@@ -864,6 +864,7 @@=0A=
 #define PCI_DEVICE_ID_PLX_SPCOM200	0x1103=0A=
 #define PCI_DEVICE_ID_PLX_DJINN_ITOO	0x1151=0A=
 #define PCI_DEVICE_ID_PLX_R753		0x1152=0A=
+#define PCI_DEVICE_ID_PLX_9030		0x9030=0A=
 #define PCI_DEVICE_ID_PLX_9050		0x9050=0A=
 #define PCI_DEVICE_ID_PLX_9060		0x9060=0A=
 #define PCI_DEVICE_ID_PLX_9060ES	0x906E=0A=
@@ -1685,6 +1686,10 @@=0A=
 #define PCI_VENDOR_ID_PDC		0x15e9=0A=
 #define PCI_DEVICE_ID_PDC_ADMA100	0x1841=0A=
 =0A=
+#define PCI_VENDOR_ID_MACROLINK		0x15ed=0A=
+#define PCI_DEVICE_ID_MACROLINK_MCCS8H	0x1002=0A=
+#define PCI_DEVICE_ID_MACROLINK_MCCSH	0x1003=0A=
+=0A=
 #define PCI_VENDOR_ID_ALTIMA		0x173b=0A=
 #define PCI_DEVICE_ID_ALTIMA_AC1000	0x03e8=0A=
 #define PCI_DEVICE_ID_ALTIMA_AC1001	0x03e9=0A=
diff -urN -X dontdiff.txt linux-2.4.23/include/linux/serialP.h =
linux-2.4.23-ml/include/linux/serialP.h=0A=
--- linux-2.4.23/include/linux/serialP.h	Fri Aug  2 17:39:45 2002=0A=
+++ linux-2.4.23-ml/include/linux/serialP.h	Thu Dec  4 11:36:41 2003=0A=
@@ -170,6 +170,7 @@=0A=
 #define SPCI_FL_BASE2	0x0002=0A=
 #define SPCI_FL_BASE3	0x0003=0A=
 #define SPCI_FL_BASE4	0x0004=0A=
+#define SPCI_FL_BASE5	0x0005=0A=
 #define SPCI_FL_GET_BASE(x)	(x & SPCI_FL_BASE_MASK)=0A=
 =0A=
 #define SPCI_FL_IRQ_MASK       (0x0007 << 4)=0A=

------_=_NextPart_000_01C3BABE.DEA8E8B0--
