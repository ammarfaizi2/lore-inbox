Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTE0GxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 02:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTE0GxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 02:53:12 -0400
Received: from bsd.ite.com.tw ([210.208.198.222]:56327 "EHLO bsd.ite.com.tw")
	by vger.kernel.org with ESMTP id S262328AbTE0GxE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 02:53:04 -0400
From: Ted.Wen@ite.com.tw
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] ITE_887x parport and serial driver
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Tue, 27 May 2003 15:06:04 +0800
Message-ID: <DC62C613C2F7274C9D361EA476413476392C25@itemail1.internal.ite.com.tw>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ITE_887x parport and serial driver
Thread-Index: AcMkHm8k+bXlQJmxQsS6GJ8FK2uIhw==
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

887x  driver patch, the patch modity parport_pc.c and parport_serial.c
I remove the driver from parport_pc.c then combine serial port to parport_serial.c. 
887x is a parport + serial ports pci card , and the type is from 8871 to 8875. 
All the vendor: device id are 1283:8872 , 
(8871 ~ 8875 use the same vendor:device id  1283:8872)



--- parport_pc.c	2002-11-29 07:53:14.000000000 +0800
+++ parport_pc_887x.c	2003-05-27 14:32:37.000000000 +0800
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













--- parport_serial.c	2002-08-03 08:39:44.000000000 +0800
+++ parport_serial_887x.c	2003-05-27 14:25:49.000000000 +0800
@@ -29,8 +29,160 @@
 
 #include <asm/serial.h>
 
+// ITE8872 ITE8872
+int ite8872parportnum,ite8872comnum,ITEBOARDNUMBER;
+u32 ITE8872_INTC[8];
+u8 ITE8872_IRQ[8];
+
+void ite8872_requestirq(int irq,void *dev_id,struct pt_regs *regs){
+	u8 itmp;
+	int i=0;
+	/* measure which INTC went to control */
+	for(i=0;i<8;i++) 
+	  if(irq == ITE8872_IRQ[i]) 
+	 {	
+	/* clean ITE8872 interrupt */
+	itmp = inb(ITE8872_INTC[i]+2);
+	if (itmp&&0xf) 
+	 {
+	  outb(itmp,ITE8872_INTC[i]+2);
+	  break;
+	 }
+	}
+}
+
+
+/*
+Integrated Technology Express, Inc.
+IT887x Device Driver
+*/
+int __devinit
+pci_ite8872_fn(struct pci_dev *pcidev, int autoirq, int autodma)
+{
+	int result;
+	short INTA_Addr[8]={ 0x2a0,0x2c0,0x220,0x240,0x1E0,0x200,0x280};
+	u32 j=0,u32Tmp,itmp,ITE8872_COM1,ITE8872_COM2,ITE8872SET=0x64E00000,set60,set78,ite8872_lpt,ite8872_lpthi;
+
+	pci_read_config_dword(pcidev, 0x60,&set60);
+	pci_read_config_dword(pcidev, 0x78,&set78);
+
+	for(j=0; j<7; j++)
+   	if(check_region(INTA_Addr[j], 0x8) >=0){
+		pci_write_config_dword(pcidev, 0x60,0xE7000000|INTA_Addr[j]);
+			pci_write_config_dword(pcidev, 0x78,0x00000000|INTA_Addr[j]);
+        		itmp = inb( INTA_Addr[j]);
+        		if( itmp != 0xFF ) break;
+       	}
+      	
+	if( j>=7 ){
+       		printk(KERN_INFO "ITE8872 INTA cannot find.\n");
+       		return 0;
+       	}
+	//Detect the type of 887x
+	itmp = INTA_Addr[j];
+	u32Tmp = inb(itmp+0x18);
+	u32Tmp &= 0x0F;
+	switch(u32Tmp){
+		case 0x2:
+			printk(KERN_INFO "ITE887x: ITE8871 found , Parallel*1 \n");
+			ITE8872SET = 0x64200000;
+			ite8872comnum = 0;
+			ite8872parportnum=1;
+			request_region(INTA_Addr[j],0x8,"ite8871");
+			break;
+		case 0xA:
+			printk(KERN_INFO "ITE887x: ITE8875 found , Parallel*1 \n");
+			ITE8872SET = 0x64200000;
+			ite8872comnum = 0;
+			ite8872parportnum=1;
+			request_region(INTA_Addr[j],0x8,"ite8875");
+			break;
+		case 0xE:
+			printk(KERN_INFO "ITE887x: ITE8872 found , Serial *2 , Parallel*1 \n");
+			ite8872comnum = 2;
+			ite8872parportnum=1;
+			ITE8872SET=0x64E00000;
+			request_region(INTA_Addr[j],0x8,"ite8872");
+			break;
+		case 0x6:
+			printk(KERN_INFO "ITE887x: ITE8873 found , Serial *1 \n");
+			ite8872comnum = 1;
+			ite8872parportnum=0;
+			ITE8872SET=0x64800000;
+			request_region(INTA_Addr[j],0x8,"ite8873");
+			break;
+		case 0x8:
+			printk(KERN_INFO "ITE887x: ITE8874 found , Serial *2 \n");
+			ite8872comnum = 2;
+			ite8872parportnum=0;
+			ITE8872SET=0x64C00000;
+			request_region(INTA_Addr[j],0x8,"ite8874");
+			break;
+		default:
+			ite8872comnum = 0;
+			ite8872parportnum=0;
+			printk(KERN_INFO "ITE887x: unknow ITE887x \n");
+			printk(KERN_INFO "ITE887x: please mail lspci -nvv output to ted.wen@ite.com.tw\n");
+			pci_write_config_dword(pcidev, 0x60,set60);
+			pci_write_config_dword(pcidev, 0x78,set78);
+			return 0;
+			break;
+	}
+	ITE8872_IRQ[ITEBOARDNUMBER]=pcidev->irq;
+	printk(KERN_INFO "ITE887X_IRQ : %d \n", ITE8872_IRQ[ITEBOARDNUMBER]);
+	result = request_irq(ITE8872_IRQ[ITEBOARDNUMBER],ite8872_requestirq,SA_SHIRQ,"ite8872",pcidev);
+	if(result){
+	printk(KERN_INFO "ITE887x: can't get assign irq :%x \n",ITE8872_IRQ[ITEBOARDNUMBER]);
+		return 0;
+	 }
+	
+	//INTC
+	pci_read_config_dword( pcidev, 0x10, &ITE8872_INTC[ITEBOARDNUMBER]);
+	ITE8872_INTC[ITEBOARDNUMBER] &= 0x0000FF00;
+	pci_write_config_dword( pcidev, 0x60, 0xE5000000|ITE8872_INTC[ITEBOARDNUMBER] );
+	pci_write_config_dword( pcidev, 0x78, ITE8872_INTC[ITEBOARDNUMBER] );
+
+	if (ite8872comnum>=1){
+	//COM1
+	pci_read_config_dword( pcidev, 0x14,&ITE8872_COM1);
+	ITE8872_COM1 &= 0x0000FF00;
+	pci_write_config_dword( pcidev, 0x64, 0xE3000000|ITE8872_COM1);
+
+	//COM2
+	if(ite8872comnum == 2){
+	pci_read_config_dword( pcidev, 0x18,&ITE8872_COM2);
+	ITE8872_COM2 &= 0x0000FF00;
+	pci_write_config_dword( pcidev, 0x68, 0xE3000000|ITE8872_COM2);
+	}
+	else	ITE8872_COM2 = 0;
+	
+	pci_write_config_dword( pcidev, 0x7C, (ITE8872_COM2<<16)|(ITE8872_COM1) );
+	}
+
+	if (ite8872parportnum>=1){
+	pci_read_config_dword (pcidev, 0x1c, &ite8872_lpt);
+	ite8872_lpt &= 0x0000ff00;
+	pci_read_config_dword (pcidev, 0x20, &ite8872_lpthi);
+	ite8872_lpthi &= 0x0000ff00;
+	pci_write_config_dword (pcidev, 0x6c, 0xe3000000 | ite8872_lpt);
+	pci_write_config_dword (pcidev, 0x70, 0xe3000000 | ite8872_lpthi);
+	pci_write_config_dword (pcidev, 0x80, (ite8872_lpthi<<16) | ite8872_lpt);
+	printk (KERN_INFO "ITE887x: The PARALLEL I/O port is 0x%x.\n",
+		 ite8872_lpt);
+	printk (KERN_INFO "ITE887x: The PARALLEL I/O porthi is 0x%x.\n",
+		 ite8872_lpthi);
+	}
+	// 9C write enable UART , IRQ Function
+	pci_write_config_dword( pcidev, 0x9c,ITE8872SET|(0x11111*ITE8872_IRQ[ITEBOARDNUMBER]));
+	// Add next interface
+	ITEBOARDNUMBER++;
+       return 0;
+}
+
+
 enum parport_pc_pci_cards {
-	titan_110l = 0,
+	ite_8872 = 0,
+	titan_110l,
 	titan_210l,
 	avlab_1s1p,
 	avlab_1s1p_650,
@@ -68,6 +220,7 @@
 	 * is non-zero we couldn't use any of the ports. */
 	void (*postinit_hook) (struct pci_dev *pdev, int failed);
 } cards[] __devinitdata = {
+	/* ite_8872	 */		{ 1, { { 3, 4}, },pci_ite8872_fn },
 	/* titan_110l */		{ 1, { { 3, -1 }, } },
 	/* titan_210l */		{ 1, { { 3, -1 }, } },
 	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
@@ -88,6 +241,8 @@
 
 static struct pci_device_id parport_serial_pci_tbl[] __devinitdata = {
 	/* PCI cards */
+	{ PCI_VENDOR_ID_ITE, PCI_DEVICE_ID_ITE_8872,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0,	ite_8872 },
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_110L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
@@ -169,6 +324,7 @@
 // Cards not tested are marked n/t
 // If you have one of these cards and it works for you, please tell me..
 
+/* ite_8872	 */     { SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 115200 },
 /* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
 /* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
 /* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
@@ -267,6 +423,8 @@
 	int k;
 	int success = 0;
 
+if ((dev->vendor==0x1283 && dev->device==0x8872) && ite8872comnum == 0)
+return 0;
 	priv->ser = *board;
 	if (board->init_fn && ((board->init_fn) (dev, board, 1) != 0))
 		return 1;
@@ -308,6 +466,8 @@
 	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
 		return -ENODEV;
 
+if ((dev->vendor==0x1283 && dev->device==0x8872) && ite8872parportnum == 0)
+return 0;
 	for (n = 0; n < cards[i].numports; n++) {
 		struct parport *port;
 		int lo = cards[i].addr[n].lo;


