Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTFKDgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 23:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTFKDgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 23:36:19 -0400
Received: from bsd.ite.com.tw ([210.208.198.222]:37384 "EHLO bsd.ite.com.tw")
	by vger.kernel.org with ESMTP id S264069AbTFKDgK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 23:36:10 -0400
From: Ted.Wen@ite.com.tw
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: [PATCH] ITE887x parport_serial driver
Date: Wed, 11 Jun 2003 11:49:47 +0800
Message-ID: <DC62C613C2F7274C9D361EA476413476437546@itemail1.internal.ite.com.tw>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ITE887x parport_serial driver
Thread-Index: AcMvzID9YyBKYcKuRVyIm88215eQGw==
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I patched the 887x driver last month , but with something not well..I patch it again.
 I is very kind of  Zwane Mwaikambo to give me a big help .
The patch with two files , remove parport setting from parport_pc.c and 
   add parport and serial setting to parport_serial.c.
ITE887x is a pci card with parport and serial , five types:
8871: 1 parport
8872: 1 parport , 2 serial .
8873: 1 serial.
8874: 2 serial.
8875: 1 parport.
All of their dendor and device id is 1283 : 8872 ,
but we can recognize the type by other way after initialize the card .

In parport_serial , I request a irq and request region to initialize 887x ,
so I must run a additional ite887x_removecheck function to check it.
Some type of 887x  only with serial or only with parport , so that 
sometimes the port num would be 0 .
 I want the driver can proceed with runing even the card with no parport , or with on serial.
( the original driver return -ENODEV while fail in parport_register or serial_register )
 I set success = 1 while the port num =0 in the tables , to avoid fail from parport register or serial register.

I also fix a bug while printk the parport information.
The original driver printk parport_serial_pci_tb[i].vendor , 
  the index "i" is be used to cards[i].....but parport_serial_pci_tbl and cards are not match.
The bug will show wrong message wile printk parport information,
 so I fix it to be dev->vendor , to show the correct message.





--- parport_pc.c	2002-11-29 07:53:14.000000000 +0800
+++ /parport_pc_ite887x.c	2003-05-27 14:32:37.000000000 +0800
@@ -2436,103 +2436,6 @@
 
 #ifdef CONFIG_PCI
 
-/* ITE support maintained by Rich Liu <richliu@poorman.org> */
-static int __devinit sio_ite_8872_probe (struct pci_dev *pdev, int autoirq,
-					 int autodma)
-{
-	short inta_addr[6] = { 0x2A0, 0x2C0, 0x220, 0x240, 0x1E0 };
-	u32 ite8872set;
-	u32 ite8872_lpt, ite8872_lpthi;
-	u8 ite8872_irq, type;
-	int irq;
-	int i;
-
-	DPRINTK (KERN_DEBUG "sio_ite_8872_probe()\n");
-	
-	// make sure which one chip
-	for(i = 0; i < 5; i++) {
-		if (check_region (inta_addr[i], 0x8) >= 0) {
-			int test;
-			pci_write_config_dword (pdev, 0x60,
-						0xe7000000 | inta_addr[i]);
-			pci_write_config_dword (pdev, 0x78,
-						0x00000000 | inta_addr[i]);
-			test = inb (inta_addr[i]);
-			if (test != 0xff) break;
-		}
-	}
-	if(i >= 5) {
-		printk (KERN_INFO "parport_pc: cannot find ITE8872 INTA\n");
-		return 0;
-	}
-
-	type = inb (inta_addr[i] + 0x18);
-	type &= 0x0f;
-
-	switch (type) {
-	case 0x2:
-		printk (KERN_INFO "parport_pc: ITE8871 found (1P)\n");
-		ite8872set = 0x64200000;
-		break;
-	case 0xa:
-		printk (KERN_INFO "parport_pc: ITE8875 found (1P)\n");
-		ite8872set = 0x64200000;
-		break;
-	case 0xe:
-		printk (KERN_INFO "parport_pc: ITE8872 found (2S1P)\n");
-		ite8872set = 0x64e00000;
-		break;
-	case 0x6:
-		printk (KERN_INFO "parport_pc: ITE8873 found (1S)\n");
-		return 0;
-	case 0x8:
-		DPRINTK (KERN_DEBUG "parport_pc: ITE8874 found (2S)\n");
-		return 0;
-	default:
-		printk (KERN_INFO "parport_pc: unknown ITE887x\n");
-		printk (KERN_INFO "parport_pc: please mail 'lspci -nvv' "
-			"output to Rich.Liu@ite.com.tw\n");
-		return 0;
-	}
-
-	pci_read_config_byte (pdev, 0x3c, &ite8872_irq);
-	pci_read_config_dword (pdev, 0x1c, &ite8872_lpt);
-	ite8872_lpt &= 0x0000ff00;
-	pci_read_config_dword (pdev, 0x20, &ite8872_lpthi);
-	ite8872_lpthi &= 0x0000ff00;
-	pci_write_config_dword (pdev, 0x6c, 0xe3000000 | ite8872_lpt);
-	pci_write_config_dword (pdev, 0x70, 0xe3000000 | ite8872_lpthi);
-	pci_write_config_dword (pdev, 0x80, (ite8872_lpthi<<16) | ite8872_lpt);
-	// SET SPP&EPP , Parallel Port NO DMA , Enable All Function
-	// SET Parallel IRQ
-	pci_write_config_dword (pdev, 0x9c,
-				ite8872set | (ite8872_irq * 0x11111));
-
-	DPRINTK (KERN_DEBUG "ITE887x: The IRQ is %d.\n", ite8872_irq);
-	DPRINTK (KERN_DEBUG "ITE887x: The PARALLEL I/O port is 0x%x.\n",
-		 ite8872_lpt);
-	DPRINTK (KERN_DEBUG "ITE887x: The PARALLEL I/O porthi is 0x%x.\n",
-		 ite8872_lpthi);
-
-	/* Let the user (or defaults) steer us away from interrupts */
-	irq = ite8872_irq;
-	if (autoirq != PARPORT_IRQ_AUTO)
-		irq = PARPORT_IRQ_NONE;
-
-	if (parport_pc_probe_port (ite8872_lpt, ite8872_lpthi,
-				   irq, PARPORT_DMA_NONE, NULL)) {
-		printk (KERN_INFO
-			"parport_pc: ITE 8872 parallel port: io=0x%X",
-			ite8872_lpt);
-		if (irq != PARPORT_IRQ_NONE)
-			printk (", irq=%d", irq);
-		printk ("\n");
-		return 1;
-	}
-
-	return 0;
-}
-
 /* Via support maintained by Jeff Garzik <jgarzik@mandrakesoft.com> */
 static int __devinit sio_via_686a_probe (struct pci_dev *pdev, int autoirq,
 					 int autodma)
@@ -2643,7 +2546,6 @@
 
 enum parport_pc_sio_types {
 	sio_via_686a = 0,	/* Via VT82C686A motherboard Super I/O */
-	sio_ite_8872,
 	last_sio
 };
 
@@ -2652,7 +2554,6 @@
 	int (*probe) (struct pci_dev *pdev, int autoirq, int autodma);
 } parport_pc_superio_info[] __devinitdata = {
 	{ sio_via_686a_probe, },
-	{ sio_ite_8872_probe, },
 };
 
 
@@ -2773,8 +2674,6 @@
 static struct pci_device_id parport_pc_pci_tbl[] __devinitdata = {
 	/* Super-IO onboard chips */
 	{ 0x1106, 0x0686, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sio_via_686a },
-	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8872,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, sio_ite_8872 },
 
 	/* PCI cards */
 	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1P_10x,
















--- parport_serial.c	2003-06-11 10:57:11.000000000 +0800
+++ parport_serial_ite887x.c	2003-06-11 10:56:25.000000000 +0800
@@ -29,6 +29,15 @@
 
 #include <asm/serial.h>
 
+/*
+ * ITE 887x 
+ */
+int ITEBOARDNUMBER = 0, ite887x_index, rm_ite = 0;
+u32 ITE887x_INTC[8];
+u16 ITE887x_INTA[8];
+u8 ITE887x_IRQ[8];
+int __devinit pci_ite887x_fn(struct pci_dev *dev, int autoirq, int autodma);
+
 enum parport_pc_pci_cards {
 	titan_110l = 0,
 	titan_210l,
@@ -46,6 +55,7 @@
 	siig_2p1s_20x,
 	siig_1s1p_20x,
 	siig_2s1p_20x,
+	ite_887x,
 };
 
 
@@ -84,6 +94,7 @@
 	/* siig_2p1s_20x */		{ 2, { { 1, 2 }, { 3, 4 }, } },
 	/* siig_1s1p_20x */		{ 1, { { 1, 2 }, } },
 	/* siig_2s1p_20x */		{ 1, { { 2, 3 }, } },
+	/* ite_887x      */  		{ 0, { { 3, 4 }, }, pci_ite887x_fn }, 
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] __devinitdata = {
@@ -132,6 +143,8 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
 	{ PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_850,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, siig_2s1p_20x },
+	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8872,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, ite_887x},
 
 	{ 0, } /* terminate list */
 };
@@ -185,6 +198,7 @@
 /* siig_2p1s_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
 /* siig_1s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
 /* siig_2s1p_20x */	{ SPCI_FL_BASE0, 1, 921600, 0, 0, siig20x_init_fn },
+/* ite_887x 	 */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 0, 115200 },
 };
 
 struct parport_serial_private {
@@ -195,6 +209,165 @@
 	struct parport *port[PARPORT_MAX];
 };
 
+/*
+ * Integrated Technology Express, Inc. IT887x Device Driver 
+ */
+
+ite887x_removecheck(struct pci_dev *dev)
+{
+	if (dev->vendor == PCI_VENDOR_ID_ITE
+	    && dev->device == PCI_DEVICE_ID_ITE_8872) {
+		free_irq(dev->irq, dev);
+		release_region(ITE887x_INTA[rm_ite++], 0x8);
+	}
+}
+
+void ite887x_requestirq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	u8 itmp;
+	int i = 0;
+	/* measure which INTC went to control  */
+	for (i = 0; i < 8; i++)
+		if (irq == ITE887x_IRQ[i]) {
+			/* clean ITE887x interrupt  */
+			itmp = inb(ITE887x_INTC[i] + 2);
+			if (itmp && 0xf) {
+				outb(itmp, ITE887x_INTC[i] + 2);
+				break;
+			}
+		}
+}
+
+int __devinit pci_ite887x_fn(struct pci_dev *dev, int autoirq, int autodma)
+{
+	int result, ite887xcomnum = 0, ite887xparportnum = 0;
+	short INTA_Addr[8] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1E0, 0x200, 0x280 };
+	u32 j, u32Tmp, itmp, ITE887x_COM1, ITE887x_COM2, ITE887xSET = 0x64E00000, set60, set78, ite887x_lpt, ite887x_lpthi;
+
+	pci_read_config_dword(dev, 0x60, &set60);
+	pci_read_config_dword(dev, 0x78, &set78);
+
+	for (j = 0; j < 7; j++)
+		if (check_region(INTA_Addr[j], 0x8) >= 0) {
+			pci_write_config_dword(dev, 0x60, 0xE7000000 | INTA_Addr[j]);
+			pci_write_config_dword(dev, 0x78, 0x00000000 | INTA_Addr[j]);
+			itmp = inb(INTA_Addr[j]);
+			if (itmp != 0xFF)
+				break;
+		}
+
+	if (j >= 7) {
+		printk(KERN_INFO "ITE887x INTA cannot find.\n");
+		return 0;
+	}
+	/* Detect the type of 887x */
+	ITE887x_INTA[ITEBOARDNUMBER] = INTA_Addr[j];
+	itmp = INTA_Addr[j];
+	u32Tmp = inb(itmp + 0x18);
+	u32Tmp &= 0x0F;
+	switch (u32Tmp) {
+	case 0x2:
+		printk(KERN_INFO "ITE887x: ITE8871 found , Parallel*1 \n");
+		ITE887xSET = 0x64200000;
+		ite887xcomnum = 0;
+		ite887xparportnum = 1;
+		request_region(INTA_Addr[j], 0x8, "ite8871");
+		break;
+	case 0xA:
+		printk(KERN_INFO "ITE887x: ITE8875 found , Parallel*1 \n");
+		ITE887xSET = 0x64200000;
+		ite887xcomnum = 0;
+		ite887xparportnum = 1;
+		request_region(INTA_Addr[j], 0x8, "ite8875");
+		break;
+	case 0xE:
+		printk(KERN_INFO
+		       "ITE887x: ITE8872 found , Serial *2 , Parallel*1 \n");
+		ite887xcomnum = 2;
+		ite887xparportnum = 1;
+		ITE887xSET = 0x64E00000;
+		request_region(INTA_Addr[j], 0x8, "ite8872");
+		break;
+	case 0x6:
+		printk(KERN_INFO "ITE887x: ITE8873 found , Serial *1 \n");
+		ite887xcomnum = 1;
+		ite887xparportnum = 0;
+		ITE887xSET = 0x64800000;
+		request_region(INTA_Addr[j], 0x8, "ite8873");
+		break;
+	case 0x8:
+		printk(KERN_INFO "ITE887x: ITE8874 found , Serial *2 \n");
+		ite887xcomnum = 2;
+		ite887xparportnum = 0;
+		ITE887xSET = 0x64C00000;
+		request_region(INTA_Addr[j], 0x8, "ite8874");
+		break;
+	default:
+		ite887xcomnum = 0;
+		ite887xparportnum = 0;
+		printk(KERN_INFO "ITE887x: unknow ITE887x \n");
+		printk(KERN_INFO
+		       "ITE887x: please mail lspci -nvv output to ted.wen@ite.com.tw\n");
+		pci_write_config_dword(dev, 0x60, set60);
+		pci_write_config_dword(dev, 0x78, set78);
+		return 0;
+		break;
+	}
+	cards[ite887x_index].numports = ite887xparportnum;
+	pci_boards[ite887x_index].num_ports = ite887xcomnum;
+	ITE887x_IRQ[ITEBOARDNUMBER] = dev->irq;
+	printk(KERN_INFO "ITE887X_IRQ : %d \n", ITE887x_IRQ[ITEBOARDNUMBER]);
+	result = request_irq(ITE887x_IRQ[ITEBOARDNUMBER], ite887x_requestirq, SA_SHIRQ, "ite887x", dev);
+	if (result) {
+		printk(KERN_INFO "ITE887x: can't get assign irq :%x \n",
+		       ITE887x_IRQ[ITEBOARDNUMBER]);
+		return 0;
+	}
+
+	/* INTC */
+	pci_read_config_dword(dev, 0x10, &ITE887x_INTC[ITEBOARDNUMBER]);
+	ITE887x_INTC[ITEBOARDNUMBER] &= 0x0000FF00;
+	pci_write_config_dword(dev, 0x60, 0xE5000000 | ITE887x_INTC[ITEBOARDNUMBER]);
+	pci_write_config_dword(dev, 0x78, ITE887x_INTC[ITEBOARDNUMBER]);
+
+	if (ite887xcomnum >= 1) {
+		/* COM1 */
+		pci_read_config_dword(dev, 0x14, &ITE887x_COM1);
+		ITE887x_COM1 &= 0x0000FF00;
+		pci_write_config_dword(dev, 0x64, 0xE3000000 | ITE887x_COM1);
+
+		/* COM2 */
+		if (ite887xcomnum == 2) {
+			pci_read_config_dword(dev, 0x18, &ITE887x_COM2);
+			ITE887x_COM2 &= 0x0000FF00;
+			pci_write_config_dword(dev, 0x68, 0xE3000000 | ITE887x_COM2);
+		} else
+			ITE887x_COM2 = 0;
+
+		pci_write_config_dword(dev, 0x7C, (ITE887x_COM2 << 16) | (ITE887x_COM1));
+	}
+
+	/* Parport */
+	if (ite887xparportnum >= 1) {
+		pci_read_config_dword(dev, 0x1c, &ite887x_lpt);
+		ite887x_lpt &= 0x0000ff00;
+		pci_read_config_dword(dev, 0x20, &ite887x_lpthi);
+		ite887x_lpthi &= 0x0000ff00;
+		pci_write_config_dword(dev, 0x6c, 0xe3000000 | ite887x_lpt);
+		pci_write_config_dword(dev, 0x70, 0xe3000000 | ite887x_lpthi);
+		pci_write_config_dword(dev, 0x80, (ite887x_lpthi << 16) | ite887x_lpt);
+		printk(KERN_INFO "ITE887x: The PARALLEL I/O port is 0x%x.\n",
+		       ite887x_lpt);
+		printk(KERN_INFO "ITE887x: The PARALLEL I/O porthi is 0x%x.\n",
+		       ite887x_lpthi);
+	}
+	/* 9C write enable UART , IRQ Function */
+	pci_write_config_dword(dev, 0x9c, ITE887xSET | (0x11111 * ITE887x_IRQ[ITEBOARDNUMBER]));
+	/* Add next interface */
+	ITEBOARDNUMBER++;
+	return 0;
+}
+
 static int __devinit get_pci_port (struct pci_dev *dev,
 				   struct pci_board_no_ids *board,
 				   struct serial_struct *req,
@@ -276,6 +449,8 @@
 		base_baud = BASE_BAUD;
 	memset (&serial_req, 0, sizeof (serial_req));
 
+	if (board->num_ports == 0)
+		success = 1;
 	for (k = 0; k < board->num_ports; k++) {
 		int line;
 		serial_req.irq = dev->irq;
@@ -308,6 +483,8 @@
 	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
 		return -ENODEV;
 
+	if (cards[i].numports == 0)
+		success = 1;
 	for (n = 0; n < cards[i].numports; n++) {
 		struct parport *port;
 		int lo = cards[i].addr[n].lo;
@@ -324,8 +501,8 @@
 		/* TODO: test if sharing interrupts works */
 		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
 			"I/O at %#lx(%#lx)\n",
-			parport_serial_pci_tbl[i].vendor,
-			parport_serial_pci_tbl[i].device, io_lo, io_hi);
+			dev->vendor,
+			dev->device, io_lo, io_hi);
 		port = parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
 					      PARPORT_DMA_NONE, dev);
 		if (port) {
@@ -359,6 +536,7 @@
 		return err;
 	}
 
+	ite887x_index = id->driver_data;
 	if (parport_register (dev, id)) {
 		pci_set_drvdata (dev, NULL);
 		kfree (priv);
@@ -395,6 +573,7 @@
 	for (i = 0; i < priv->num_par; i++)
 		parport_pc_unregister_port (priv->port[i]);
 
+	ite887x_removecheck(dev);
 	kfree (priv);
 	return;
 }
