Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSFDQZx>; Tue, 4 Jun 2002 12:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSFDQZw>; Tue, 4 Jun 2002 12:25:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34066 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314938AbSFDQZr>;
	Tue, 4 Jun 2002 12:25:47 -0400
Date: Tue, 4 Jun 2002 17:25:48 +0100
From: Matthew Wilcox <willy@debian.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [PATCH] Add support for HP Diva serial ports
Message-ID: <20020604172548.Q10366@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds support for HP's Diva chip.  Please apply for 2.4

diff -urNX ../dontdiff linux-ia64/drivers/char/serial.c linux-generic/drivers/char/serial.c
--- linux-ia64/drivers/char/serial.c	Sat May 18 11:58:49 2002
+++ linux-generic/drivers/char/serial.c	Tue May 28 09:42:58 2002
@@ -3912,6 +3919,25 @@
 		
 	}
   
+	/* HP's Diva chip puts the 4th/5th serial port further out, and
+	 * some serial ports are supposed to be hidden on certain models.
+	 */
+	if (dev->vendor == PCI_VENDOR_ID_HP &&
+			dev->device == PCI_DEVICE_ID_HP_SAS) {
+		switch (dev->subsystem_device) {
+		case 0x104B: /* Maestro */
+			if (idx == 3) idx++;
+			break;
+		case 0x1282: /* Everest / Longs Peak */
+			if (idx > 0) idx++;
+			if (idx > 2) idx++;
+			break;
+		}
+		if (idx > 2) {
+			offset = 0x18;
+		}
+	}
+
 	port =  pci_resource_start(dev, base_idx) + offset;
 
 	if ((board->flags & SPCI_FL_BASE_TABLE) == 0)
@@ -4215,6 +4241,40 @@
 	return 0;
 }
 
+/*
+ * HP's Remote Management Console.  The Diva chip came in several
+ * different versions.  N-class, L2000 and A500 have two Diva chips, each
+ * with 3 UARTs (the third UART on the second chip is unused).  Superdome
+ * and Keystone have one Diva chip with 3 UARTs.  Some later machines have
+ * one Diva chip, but it has been expanded to 5 UARTs.
+ */
+static int __devinit
+pci_hp_diva(struct pci_dev *dev, struct pci_board *board, int enable)
+{
+	if (!enable)
+		return 0;
+
+	switch (dev->subsystem_device) {
+	case 0x1049: /* Prelude Diva 1 */
+	case 0x1223: /* Superdome */
+	case 0x1226: /* Keystone */
+	case 0x1282: /* Everest / Longs Peak */
+		board->num_ports = 3;
+		break;
+	case 0x104A: /* Prelude Diva 2 */
+		board->num_ports = 2;
+		break;
+	case 0x104B: /* Maestro */
+		board->num_ports = 4;
+		break;
+	case 0x1227: /* Powerbar */
+		board->num_ports = 1;
+		break;
+	}
+
+	return 0;
+}
+
 static int __devinit
 pci_xircom_fn(struct pci_dev *dev, struct pci_board *board, int enable)
 {
@@ -4258,6 +4317,7 @@
 	pbn_b1_4_1382400,
 	pbn_b1_8_1382400,
 
+	pbn_b2_1_115200,
 	pbn_b2_8_115200,
 	pbn_b2_4_460800,
 	pbn_b2_8_460800,
@@ -4278,6 +4338,7 @@
 	pbn_timedia,
 	pbn_intel_i960,
 	pbn_sgi_ioc3,
+	pbn_hp_diva,
 #ifdef CONFIG_DDB5074
 	pbn_nec_nile4,
 #endif
@@ -4336,6 +4397,7 @@
 	{ SPCI_FL_BASE1, 4, 1382400 },		/* pbn_b1_4_1382400 */
 	{ SPCI_FL_BASE1, 8, 1382400 },		/* pbn_b1_8_1382400 */
 
+	{ SPCI_FL_BASE2, 1, 115200 },		/* pbn_b2_1_115200 */
 	{ SPCI_FL_BASE2, 8, 115200 },		/* pbn_b2_8_115200 */
 	{ SPCI_FL_BASE2, 4, 460800 },		/* pbn_b2_4_460800 */
 	{ SPCI_FL_BASE2, 8, 460800 },		/* pbn_b2_8_460800 */
@@ -4366,6 +4428,7 @@
 		8<<2, 2, pci_inteli960ni_fn, 0x10000},
 	{ SPCI_FL_BASE0 | SPCI_FL_IRQRESOURCE,		   /* pbn_sgi_ioc3 */
 		1, 458333, 0, 0, 0, 0x20178 },
+	{ SPCI_FL_BASE0, 5, 115200, 8, 0, pci_hp_diva, 0},   /* pbn_hp_diva */
 #ifdef CONFIG_DDB5074
 	/*
 	 * NEC Vrc-5074 (Nile 4) builtin UART.
@@ -4864,6 +5012,14 @@
 		0xFF00, 0, 0, 0,
 		pbn_sgi_ioc3 },
 
+	/* HP Diva card */
+	{	PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_SAS,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_hp_diva },
+	{	PCI_VENDOR_ID_HP, 0x1290,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
+
 #ifdef CONFIG_DDB5074
 	/*
 	 * NEC Vrc-5074 (Nile 4) builtin UART.

-- 
Revolutions do not require corporate support.
