Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290590AbSBLAov>; Mon, 11 Feb 2002 19:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290645AbSBLAoo>; Mon, 11 Feb 2002 19:44:44 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:1033 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S290590AbSBLAod>; Mon, 11 Feb 2002 19:44:33 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7693@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Russell King'" <linux@arm.linux.org.uk>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial driver 2.4.18-pre9
Date: Mon, 11 Feb 2002 16:44:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1B35E.6D158870"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1B35E.6D158870
Content-Type: text/plain;
	charset="iso-8859-1"

Hi Russell,

This patch adds support to the generic serial driver for Macrolink MCCS and
MCCR CompactPCI async serial cards. It also fixes a few bugs that only
affect memory mapped devices. It was based on the files in 2.4.18pre9.

Comments and scrutiny are welcome.

Best regards,
Ed Vance
---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

 <<patch_serial_2_4_18pre9>> 

------_=_NextPart_000_01C1B35E.6D158870
Content-Type: application/octet-stream;
	name="patch_serial_2_4_18pre9"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch_serial_2_4_18pre9"

diff -urN -X dontdiff.txt linux-2.4.18-pre9/drivers/char/serial.c =
pre9-ml/drivers/char/serial.c=0A=
--- linux-2.4.18-pre9/drivers/char/serial.c	Mon Feb 11 12:23:00 2002=0A=
+++ pre9-ml/drivers/char/serial.c	Mon Feb 11 16:12:08 2002=0A=
@@ -57,10 +57,13 @@=0A=
  * 10/00: add in optional software flow control for serial console.=0A=
  *	  Kanoj Sarcar <kanoj@sgi.com>  (Modified by Theodore Ts'o)=0A=
  *=0A=
+ * 11/01: add basic support for Macrolink MCCR and MCCS cards.=0A=
+ *        Ed Vance <edv@macrolink.com>=0A=
+ *=0A=
  */=0A=
 =0A=
-static char *serial_version =3D "5.05c";=0A=
-static char *serial_revdate =3D "2001-07-08";=0A=
+static char *serial_version =3D "5.05c-ml";=0A=
+static char *serial_revdate =3D "2001-11-27";=0A=
 =0A=
 /*=0A=
  * Serial driver configuration section.  Here are the various =
options:=0A=
@@ -1391,6 +1394,8 @@=0A=
 		if (state->irq !=3D 0)=0A=
 			info->MCR |=3D UART_MCR_OUT2;=0A=
 	}=0A=
+	if (info->flags & ASYNC_FORCE_OUT2)=0A=
+		info->MCR |=3D UART_MCR_OUT2;=0A=
 	info->MCR |=3D ALPHA_KLUDGE_MCR; 		/* Don't ask */=0A=
 	serial_outp(info, UART_MCR, info->MCR);=0A=
 	=0A=
@@ -1529,6 +1534,9 @@=0A=
 	} else=0A=
 #endif=0A=
 		info->MCR &=3D ~UART_MCR_OUT2;=0A=
+=0A=
+	if (info->flags & ASYNC_FORCE_OUT2)=0A=
+		info->MCR |=3D UART_MCR_OUT2;=0A=
 	info->MCR |=3D ALPHA_KLUDGE_MCR; 		/* Don't ask */=0A=
 	=0A=
 	/* disable break condition */=0A=
@@ -2342,6 +2350,8 @@=0A=
 		return -EINVAL;=0A=
 	}=0A=
 	save_flags(flags); cli();=0A=
+	if (info->flags & ASYNC_FORCE_OUT2)=0A=
+		info->MCR |=3D UART_MCR_OUT2;=0A=
 	info->MCR |=3D ALPHA_KLUDGE_MCR; 		/* Don't ask */=0A=
 	serial_out(info, UART_MCR, info->MCR);=0A=
 	restore_flags(flags);=0A=
@@ -3249,10 +3259,12 @@=0A=
 =0A=
 	ret =3D sprintf(buf, "%d: uart:%s port:%lX irq:%d",=0A=
 		      state->line, uart_config[state->type].name, =0A=
-		      state->port, state->irq);=0A=
+		      (state->port ? state->port : (long)state->iomem_base),=0A=
+		      state->irq);=0A=
 =0A=
-	if (!state->port || (state->type =3D=3D PORT_UNKNOWN)) {=0A=
-		ret +=3D sprintf(buf+ret, "\n");=0A=
+	if ((!state->port && !state->iomem_base) ||=0A=
+	    (state->type =3D=3D PORT_UNKNOWN)) {=0A=
+		ret +=3D sprintf(buf+ret, " \n");=0A=
 		return ret;=0A=
 	}=0A=
 =0A=
@@ -3914,8 +3926,11 @@=0A=
   =0A=
 	port =3D  pci_resource_start(dev, base_idx) + offset;=0A=
 =0A=
+	if (board->uart_offset =3D=3D 0)=0A=
+		board->uart_offset =3D 8;=0A=
+=0A=
 	if ((board->flags & SPCI_FL_BASE_TABLE) =3D=3D 0)=0A=
-		port +=3D idx * (board->uart_offset ? board->uart_offset : 8);=0A=
+		port +=3D idx * board->uart_offset;=0A=
 =0A=
 	if (IS_PCI_REGION_IOPORT(dev, base_idx)) {=0A=
 		req->port =3D port;=0A=
@@ -3925,6 +3940,13 @@=0A=
 			req->port_high =3D 0;=0A=
 		return 0;=0A=
 	}=0A=
+=0A=
+	/* MCCR io_mem: only 4 ports mapped into each 1K block */=0A=
+	if (dev->subsystem_vendor =3D=3D PCI_VENDOR_ID_MACROLINK &&=0A=
+	    dev->subsystem_device >> 8 =3D=3D PCI_DEVICE_ID_MACROLINK_MCCR >> =
8) {=0A=
+		port -=3D (idx / 4) * (board->uart_offset * 4);=0A=
+		port +=3D (idx / 4) * 1024;=0A=
+	}=0A=
 	req->io_type =3D SERIAL_IO_MEM;=0A=
 	req->iomem_base =3D ioremap(port, board->uart_offset);=0A=
 	req->iomem_reg_shift =3D board->reg_shift;=0A=
@@ -4006,6 +4028,12 @@=0A=
 		printk("Setup PCI/PNP port: port %x, irq %d, type %d\n",=0A=
 		       serial_req.port, serial_req.irq, serial_req.io_type);=0A=
 #endif=0A=
+		/* Detect MCCS card. Must always assert OUT2 */=0A=
+		if (dev->subsystem_vendor =3D=3D PCI_VENDOR_ID_MACROLINK &&=0A=
+		    dev->subsystem_device >> 8 =3D=3D =0A=
+		                 PCI_DEVICE_ID_MACROLINK_MCCS >> 8) {=0A=
+			serial_req.flags |=3D ASYNC_FORCE_OUT2;=0A=
+		}=0A=
 		line =3D register_serial(&serial_req);=0A=
 		if (line < 0)=0A=
 			break;=0A=
@@ -4224,6 +4252,71 @@=0A=
 }=0A=
 =0A=
 /*=0A=
+ * Set front panel LED to green if enabled, to yellow if disabled.=0A=
+ * LED control is 16PCI954 MIC reg bits 23-20 in BAR3 +4 (memory).=0A=
+ * Preserve the state of the other writable bits in the MIC reg.=0A=
+ */=0A=
+static int __devinit=0A=
+pci_mccr_fn(struct pci_dev *dev, struct pci_board *board, int =
enable)=0A=
+{=0A=
+	u32 tmp;=0A=
+	char *p;=0A=
+=0A=
+	p =3D ioremap(pci_resource_start(dev, 3), 0x80);=0A=
+	tmp =3D readl(p + 4);=0A=
+	tmp &=3D ~(0xf << 20);=0A=
+	tmp |=3D (enable ? 0xb : 0xa) << 20;=0A=
+	writel(tmp, p + 4);=0A=
+	iounmap(p);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Set the front panel LED green (enable) or yellow (disable) via=0A=
+ * bits 7-6 of 16-bit status register at BAR3 +0xa (memory).=0A=
+ * Enable or disable card interrupts with the PCI Interrupt Enable=0A=
+ * bit 6 in the PLX 9050 INTCSR register at BAR0 +0x4c (memory).=0A=
+=0A=
+ */=0A=
+static int __devinit=0A=
+pci_mccs_fn(struct pci_dev *dev, struct pci_board *board, int =
enable)=0A=
+{=0A=
+	int j;=0A=
+	u32 tmp;=0A=
+	u8 *p;=0A=
+=0A=
+	/* Wake UART and set prescalar to x1 */=0A=
+	/* Set all UART MCR bit 3 to avoid interrupt storm */=0A=
+	p =3D ioremap(pci_resource_start(dev, 5), board->num_ports * 8);=0A=
+	for (j=3D0; j < board->num_ports; j++) {=0A=
+		writeb(0xBF, p + (j * 8) + UART_LCR);	/* enh regs */=0A=
+		writeb(UART_EFR_ECB, p + (j * 8) + UART_EFR); /* enable */=0A=
+		writeb(0x00, p + (j * 8) + UART_LCR);	/* gen regs */=0A=
+		writeb(UART_MCR_OUT2, p + (j * 8) + UART_MCR); /* x1,out2 */=0A=
+		writeb(0xBF, p + (j * 8) + UART_LCR);	/* enh regs */=0A=
+		writeb(0x00, p + (j * 8) + UART_EFR);	/* latch x1 */=0A=
+		writeb(0x00, p + (j * 8) + UART_LCR);	/* gen regs */=0A=
+	} =0A=
+	iounmap(p);=0A=
+=0A=
+	p =3D ioremap(pci_resource_start(dev, 3), 0x80);=0A=
+	writew(0, p + 0x2);		/* clear pending interrupt */=0A=
+	tmp =3D enable ? 0x42 : 0x00;=0A=
+	writew(tmp, p + 0xa);		/* Set front panel LED color */=0A=
+	iounmap(p);=0A=
+=0A=
+	p =3D ioremap(pci_resource_start(dev, 0), 0x80);=0A=
+	tmp =3D readl(p + 0x4c);=0A=
+	tmp &=3D ~(0x40);=0A=
+	if (enable)=0A=
+		tmp |=3D 0x40;=0A=
+	writel(tmp, p + 0x4c);		/* (En/Dis)able card interrupt */=0A=
+	iounmap(p);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
  * This is the configuration table for all of the PCI serial boards=0A=
  * which we support.  It is directly indexed by the pci_board_num_t =
enum=0A=
  * value, which is encoded in the pci_device_id PCI probe table's=0A=
@@ -4297,6 +4390,15 @@=0A=
 	pbn_computone_4,=0A=
 	pbn_computone_6,=0A=
 	pbn_computone_8,=0A=
+=0A=
+	pbn_ml_mccs_8,=0A=
+	pbn_ml_mccs_16,=0A=
+	pbn_ml_mccs_8_hs,=0A=
+	pbn_ml_mccs_16_hs,=0A=
+	pbn_ml_mccr_8_p0,=0A=
+	pbn_ml_mccr_8_p4,=0A=
+	pbn_ml_mccr_16_p0,=0A=
+	pbn_ml_mccr_16_p4,=0A=
 };=0A=
 =0A=
 static struct pci_board pci_boards[] __devinitdata =3D {=0A=
@@ -4401,6 +4503,23 @@=0A=
 		0x40, 2, NULL, 0x200 },=0A=
 	{ SPCI_FL_BASE0, 8, 921600, /* IOMEM */		   /* pbn_computone_8 */=0A=
 		0x40, 2, NULL, 0x200 },=0A=
+=0A=
+	{ SPCI_FL_BASE5, 8, 921600,   /* IOMEM */	/* pbn_ml_mccs_8 */=0A=
+		8, 0, pci_mccs_fn },=0A=
+	{ SPCI_FL_BASE5, 16, 921600,  /* IOMEM */	/* pbn_ml_mccs_16 */=0A=
+                8, 0, pci_mccs_fn },=0A=
+	{ SPCI_FL_BASE5, 8, 921600,   /* IOMEM */	/* pbn_ml_mccs_8_hs */=0A=
+                8, 0, pci_mccs_fn },=0A=
+	{ SPCI_FL_BASE5, 16, 921600,  /* IOMEM */	/* pbn_ml_mccs_16_hs */=0A=
+                8, 0, pci_mccs_fn },=0A=
+	{ SPCI_FL_BASE1, 4, 3125000,  /* IOMEM */	/* pbn_ml_mccr_8_p0 */=0A=
+                0x20, 2 },=0A=
+	{ SPCI_FL_BASE1, 4, 3125000,  /* IOMEM */	/* pbn_ml_mccr_8_p4 */=0A=
+                0x20, 2, pci_mccr_fn },=0A=
+	{ SPCI_FL_BASE1, 4, 3125000,  /* IOMEM */	/* pbn_ml_mccr_16_p0 */=0A=
+                0x20, 2 },=0A=
+	{ SPCI_FL_BASE1, 12, 3125000, /* IOMEM */	/* pbn_ml_mccr_16_p4 */=0A=
+                0x20, 2, pci_mccr_fn },=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -4632,6 +4751,41 @@=0A=
 		PCI_SUBVENDOR_ID_CHASE_PCIRAS,=0A=
 		PCI_SUBDEVICE_ID_CHASE_PCIRAS8, 0, 0, =0A=
 		pbn_b2_8_460800 },=0A=
+	/* Macrolink 8/16-port CompactPCI serial cards. */=0A=
+	/* Must precede all other PLX_9050 cards with   */=0A=
+        /* subvendor and subdevice set to PCI_ANY_ID.   */=0A=
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCS8, 0, 0,=0A=
+		pbn_ml_mccs_8 },=0A=
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCS, 0, 0,=0A=
+		pbn_ml_mccs_16 },=0A=
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCS8H, 0, 0,=0A=
+		pbn_ml_mccs_8_hs },=0A=
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCSH, 0, 0,=0A=
+		pbn_ml_mccs_16_hs },=0A=
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCR8, 0, 0,	/* fn0: p0-3 */=0A=
+		pbn_ml_mccr_8_p0 },=0A=
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCR8, 0, 0,	/* fn1: p4-7 */=0A=
+		pbn_ml_mccr_8_p4 },=0A=
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCR, 0, 0,	/* fn0: p0-3 */=0A=
+		pbn_ml_mccr_16_p0 },=0A=
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,=0A=
+		PCI_VENDOR_ID_MACROLINK,=0A=
+		PCI_DEVICE_ID_MACROLINK_MCCR, 0, 0,	/* fn1: p4-15 */=0A=
+		pbn_ml_mccr_16_p4 },=0A=
 	/* Megawolf Romulus PCI Serial Card, from Mike Hudson */=0A=
 	/* (Exoray@isys.ca) */=0A=
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_ROMULUS,=0A=
@@ -5708,6 +5862,7 @@=0A=
 #if defined(ENABLE_SERIAL_PCI) || defined(ENABLE_SERIAL_PNP)=0A=
 		if (rs_table[i].iomem_base)=0A=
 			iounmap(rs_table[i].iomem_base);=0A=
+		rs_table[i].flags &=3D ~ASYNC_FORCE_OUT2;=0A=
 #endif=0A=
 	}=0A=
 #if defined(ENABLE_SERIAL_PCI) || defined(ENABLE_SERIAL_PNP)=0A=
@@ -5976,7 +6131,11 @@=0A=
 	serial_out(info, UART_DLM, quot >> 8);		/* MS of divisor */=0A=
 	serial_out(info, UART_LCR, cval);		/* reset DLAB */=0A=
 	serial_out(info, UART_IER, 0);=0A=
-	serial_out(info, UART_MCR, UART_MCR_DTR | UART_MCR_RTS);=0A=
+	info->MCR =3D UART_MCR_DTR | UART_MCR_RTS;=0A=
+	if (info->flags & ASYNC_FORCE_OUT2)=0A=
+		info->MCR |=3D UART_MCR_OUT2;=0A=
+	info->MCR |=3D ALPHA_KLUDGE_MCR; 		/* Don't ask */=0A=
+	serial_out(info, UART_MCR, info->MCR);=0A=
 =0A=
 	/*=0A=
 	 *	If we read 0xff from the LSR, there is no UART here.=0A=
diff -urN -X dontdiff.txt linux-2.4.18-pre9/drivers/pci/pci.ids =
pre9-ml/drivers/pci/pci.ids=0A=
--- linux-2.4.18-pre9/drivers/pci/pci.ids	Mon Feb 11 12:23:03 2002=0A=
+++ pre9-ml/drivers/pci/pci.ids	Mon Feb 11 15:02:06 2002=0A=
@@ -1560,9 +1560,14 @@=0A=
 	0001  i960 PCI bus interface=0A=
 	1076  VScom 800 8 port serial adaptor=0A=
 	1077  VScom 400 4 port serial adaptor=0A=
+	9030  PCI <-> IOBus Bridge (Hot Swap)=0A=
+		15ed 1002  Macrolink MCCS 8-port Serial (Hot Swap)=0A=
+		15ed 1003  Macrolink MCCS 16-port Serial (Hot Swap)=0A=
 	9036  9036=0A=
 	9050  PCI <-> IOBus Bridge=0A=
 		10b5 2273  SH-ARC SoHard ARCnet card=0A=
+		15ed 1000  Macrolink MCCS 8-port Serial=0A=
+		15ed 1001  Macrolink MCCS 16-port Serial=0A=
 		d84d 4006  EX-4006 1P=0A=
 		d84d 4008  EX-4008 1P EPP/ECP=0A=
 		d84d 4014  EX-4014 2P=0A=
@@ -3952,6 +3957,12 @@=0A=
 1413  Addonics=0A=
 1414  Microsoft Corporation=0A=
 1415  Oxford Semiconductor Ltd=0A=
+	9501  16PCI954 Function 0=0A=
+		15ed 2000  Macrolink MCCR Serial p0-3 of 8=0A=
+		15ed 2001  Macrolink MCCR Serial p0-3 of 16=0A=
+	9511  16PCI954 Function 1=0A=
+		15ed 2000  Macrolink MCCR Serial p4-7 of 8=0A=
+		15ed 2001  Macrolink MCCR Serial p4-15 of 16=0A=
 1416  Multiwave Innovation pte Ltd=0A=
 1417  Convergenet Technologies Inc=0A=
 1418  Kyushu electronics systems Inc=0A=
diff -urN -X dontdiff.txt linux-2.4.18-pre9/include/linux/pci_ids.h =
pre9-ml/include/linux/pci_ids.h=0A=
--- linux-2.4.18-pre9/include/linux/pci_ids.h	Mon Feb 11 12:23:08 =
2002=0A=
+++ pre9-ml/include/linux/pci_ids.h	Mon Feb 11 15:02:06 2002=0A=
@@ -764,6 +764,7 @@=0A=
 #define PCI_DEVICE_ID_PLX_SPCOM200	0x1103=0A=
 #define PCI_DEVICE_ID_PLX_DJINN_ITOO	0x1151=0A=
 #define PCI_DEVICE_ID_PLX_R753		0x1152=0A=
+#define PCI_DEVICE_ID_PLX_9030		0x9030=0A=
 #define PCI_DEVICE_ID_PLX_9050		0x9050=0A=
 #define PCI_DEVICE_ID_PLX_9060		0x9060=0A=
 #define PCI_DEVICE_ID_PLX_9060ES	0x906E=0A=
@@ -1518,6 +1519,14 @@=0A=
 #define PCI_VENDOR_ID_PDC		0x15e9=0A=
 #define PCI_DEVICE_ID_PDC_1841		0x1841=0A=
 =0A=
+#define PCI_VENDOR_ID_MACROLINK		0x15ed=0A=
+#define PCI_DEVICE_ID_MACROLINK_MCCS8	0x1000=0A=
+#define PCI_DEVICE_ID_MACROLINK_MCCS	0x1001=0A=
+#define PCI_DEVICE_ID_MACROLINK_MCCS8H	0x1002=0A=
+#define PCI_DEVICE_ID_MACROLINK_MCCSH	0x1003=0A=
+#define PCI_DEVICE_ID_MACROLINK_MCCR8	0x2000=0A=
+#define PCI_DEVICE_ID_MACROLINK_MCCR	0x2001=0A=
+=0A=
 #define PCI_VENDOR_ID_SYMPHONY		0x1c1c=0A=
 #define PCI_DEVICE_ID_SYMPHONY_101	0x0001=0A=
 =0A=
diff -urN -X dontdiff.txt linux-2.4.18-pre9/include/linux/serial.h =
pre9-ml/include/linux/serial.h=0A=
--- linux-2.4.18-pre9/include/linux/serial.h	Mon Feb 11 13:34:57 =
2002=0A=
+++ pre9-ml/include/linux/serial.h	Mon Feb 11 15:02:06 2002=0A=
@@ -142,7 +142,8 @@=0A=
 #define ASYNC_CONS_FLOW		0x00800000 /* flow control for console  */=0A=
 =0A=
 #define ASYNC_BOOT_ONLYMCA	0x00400000 /* Probe only if MCA bus */=0A=
-#define ASYNC_INTERNAL_FLAGS	0xFFC00000 /* Internal flags */=0A=
+#define ASYNC_FORCE_OUT2	0x00200000 /* Must always assert MCR OUT2 =
*/=0A=
+#define ASYNC_INTERNAL_FLAGS	0xFFE00000 /* Internal flags */=0A=
 =0A=
 /*=0A=
  * Multiport serial configuration structure --- external structure=0A=
diff -urN -X dontdiff.txt linux-2.4.18-pre9/include/linux/serialP.h =
pre9-ml/include/linux/serialP.h=0A=
--- linux-2.4.18-pre9/include/linux/serialP.h	Mon Feb 11 13:36:16 =
2002=0A=
+++ pre9-ml/include/linux/serialP.h	Mon Feb 11 15:02:06 2002=0A=
@@ -167,6 +167,7 @@=0A=
 #define SPCI_FL_BASE2	0x0002=0A=
 #define SPCI_FL_BASE3	0x0003=0A=
 #define SPCI_FL_BASE4	0x0004=0A=
+#define SPCI_FL_BASE5	0x0005=0A=
 #define SPCI_FL_GET_BASE(x)	(x & SPCI_FL_BASE_MASK)=0A=
 =0A=
 #define SPCI_FL_IRQ_MASK       (0x0007 << 4)=0A=

------_=_NextPart_000_01C1B35E.6D158870--
