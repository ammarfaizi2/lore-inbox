Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUKBNn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUKBNn6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUKBNn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:43:57 -0500
Received: from [212.209.10.221] ([212.209.10.221]:46036 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S262963AbUKBNFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:05:09 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: [PATCH 7/10] CRIS architecture update - Console
Date: Tue, 2 Nov 2004 14:04:48 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C748B@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01DD_01C4C0E4.EA6E2520"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01DD_01C4C0E4.EA6E2520
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added handling of console kernel command line options.

Signed-Off-By: starvik@axis.com

/Mikael

------=_NextPart_000_01DD_01C4C0E4.EA6E2520
Content-Type: application/octet-stream;
	name="cris269_7.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cris269_7.patch"

diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/debugport.c =
lx25/arch/cris/arch-v10/kernel/debugport.c=0A=
--- ../linux/arch/cris/arch-v10/kernel/debugport.c	Mon Oct 18 23:53:07 =
2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/debugport.c	Thu Oct 21 09:26:16 2004=0A=
@@ -12,6 +12,21 @@=0A=
  *    init_etrax_debug()=0A=
  *=0A=
  * $Log: debugport.c,v $=0A=
+ * Revision 1.19  2004/10/21 07:26:16  starvik=0A=
+ * Made it possible to specify console settings on kernel command line.=0A=
+ *=0A=
+ * Revision 1.18  2004/10/19 13:07:37  starvik=0A=
+ * Merge of Linux 2.6.9=0A=
+ *=0A=
+ * Revision 1.17  2004/09/29 10:33:46  starvik=0A=
+ * Resolved a dealock when printing debug from kernel.=0A=
+ *=0A=
+ * Revision 1.16  2004/08/24 06:12:19  starvik=0A=
+ * Whitespace cleanup=0A=
+ *=0A=
+ * Revision 1.15  2004/08/16 12:37:19  starvik=0A=
+ * Merge of Linux 2.6.8=0A=
+ *=0A=
  * Revision 1.14  2004/05/17 13:11:29  starvik=0A=
  * Disable DMA until real serial driver is up=0A=
  *=0A=
@@ -73,111 +88,275 @@=0A=
 #include <asm/arch/svinto.h>=0A=
 #include <asm/io.h>             /* Get SIMCOUT. */=0A=
 =0A=
-/* Which serial-port is our debug port ? */=0A=
+struct dbg_port=0A=
+{=0A=
+  unsigned int index;=0A=
+  const volatile unsigned* read;=0A=
+  volatile char* write;=0A=
+  volatile unsigned* xoff;=0A=
+  volatile char* baud;=0A=
+  volatile char* tr_ctrl;=0A=
+  volatile char* rec_ctrl;=0A=
+  unsigned long irq;=0A=
+  unsigned int started;=0A=
+  unsigned long baudrate;=0A=
+  unsigned char parity;=0A=
+  unsigned int bits;=0A=
+};=0A=
 =0A=
-#if defined(CONFIG_ETRAX_DEBUG_PORT0) || =
defined(CONFIG_ETRAX_DEBUG_PORT_NULL)=0A=
-#define DEBUG_PORT_IDX 0=0A=
-#define DEBUG_OCMD R_DMA_CH6_CMD=0A=
-#define DEBUG_FIRST R_DMA_CH6_FIRST=0A=
-#define DEBUG_OCLRINT R_DMA_CH6_CLR_INTR=0A=
-#define DEBUG_STATUS R_DMA_CH6_STATUS=0A=
-#define DEBUG_READ R_SERIAL0_READ=0A=
-#define DEBUG_WRITE R_SERIAL0_TR_DATA=0A=
-#define DEBUG_TR_CTRL R_SERIAL0_TR_CTRL=0A=
-#define DEBUG_REC_CTRL R_SERIAL0_REC_CTRL=0A=
-#define DEBUG_IRQ IO_STATE(R_IRQ_MASK1_SET, ser0_data, set)=0A=
-#define DEBUG_DMA_IRQ_CLR IO_STATE(R_IRQ_MASK2_CLR, dma6_descr, clr)=0A=
-#endif=0A=
+struct dbg_port ports[]=3D=0A=
+{=0A=
+  {=0A=
+    0,=0A=
+    R_SERIAL0_READ,=0A=
+    R_SERIAL0_TR_DATA,=0A=
+    R_SERIAL0_XOFF,=0A=
+    R_SERIAL0_BAUD,=0A=
+    R_SERIAL0_TR_CTRL,=0A=
+    R_SERIAL0_REC_CTRL,=0A=
+    IO_STATE(R_IRQ_MASK1_SET, ser0_data, set)=0A=
+  },=0A=
+  {=0A=
+    1,=0A=
+    R_SERIAL1_READ,=0A=
+    R_SERIAL1_TR_DATA,=0A=
+    R_SERIAL1_XOFF,=0A=
+    R_SERIAL1_BAUD,=0A=
+    R_SERIAL1_TR_CTRL,=0A=
+    R_SERIAL1_REC_CTRL,=0A=
+    IO_STATE(R_IRQ_MASK1_SET, ser1_data, set)=0A=
+  },=0A=
+  {=0A=
+    2,=0A=
+    R_SERIAL2_READ,=0A=
+    R_SERIAL2_TR_DATA,=0A=
+    R_SERIAL2_XOFF,=0A=
+    R_SERIAL2_BAUD,=0A=
+    R_SERIAL2_TR_CTRL,=0A=
+    R_SERIAL2_REC_CTRL,=0A=
+    IO_STATE(R_IRQ_MASK1_SET, ser2_data, set)=0A=
+  },=0A=
+  {=0A=
+    3,=0A=
+    R_SERIAL3_READ,=0A=
+    R_SERIAL3_TR_DATA,=0A=
+    R_SERIAL3_XOFF,=0A=
+    R_SERIAL3_BAUD,=0A=
+    R_SERIAL3_TR_CTRL,=0A=
+    R_SERIAL3_REC_CTRL,=0A=
+    IO_STATE(R_IRQ_MASK1_SET, ser3_data, set)=0A=
+  }=0A=
+};=0A=
 =0A=
-#ifdef CONFIG_ETRAX_DEBUG_PORT1=0A=
-#define DEBUG_PORT_IDX 1=0A=
-#define DEBUG_OCMD R_DMA_CH8_CMD=0A=
-#define DEBUG_FIRST R_DMA_CH8_FIRST=0A=
-#define DEBUG_OCLRINT R_DMA_CH8_CLR_INTR=0A=
-#define DEBUG_STATUS R_DMA_CH8_STATUS=0A=
-#define DEBUG_READ R_SERIAL1_READ=0A=
-#define DEBUG_WRITE R_SERIAL1_TR_DATA=0A=
-#define DEBUG_TR_CTRL R_SERIAL1_TR_CTRL=0A=
-#define DEBUG_REC_CTRL R_SERIAL1_REC_CTRL=0A=
-#define DEBUG_IRQ IO_STATE(R_IRQ_MASK1_SET, ser1_data, set)=0A=
-#define DEBUG_DMA_IRQ_CLR IO_STATE(R_IRQ_MASK2_CLR, dma8_descr, clr)=0A=
-#endif=0A=
+static struct tty_driver *serial_driver;=0A=
 =0A=
-#ifdef CONFIG_ETRAX_DEBUG_PORT2=0A=
-#define DEBUG_PORT_IDX 2=0A=
-#define DEBUG_OCMD R_DMA_CH2_CMD=0A=
-#define DEBUG_FIRST R_DMA_CH2_FIRST=0A=
-#define DEBUG_OCLRINT R_DMA_CH2_CLR_INTR=0A=
-#define DEBUG_STATUS R_DMA_CH2_STATUS=0A=
-#define DEBUG_READ R_SERIAL2_READ=0A=
-#define DEBUG_WRITE R_SERIAL2_TR_DATA=0A=
-#define DEBUG_TR_CTRL R_SERIAL2_TR_CTRL=0A=
-#define DEBUG_REC_CTRL R_SERIAL2_REC_CTRL=0A=
-#define DEBUG_IRQ IO_STATE(R_IRQ_MASK1_SET, ser2_data, set)=0A=
-#define DEBUG_DMA_IRQ_CLR IO_STATE(R_IRQ_MASK2_CLR, dma2_descr, clr)=0A=
+struct dbg_port* port =3D=0A=
+#if defined(CONFIG_ETRAX_DEBUG_PORT0)=0A=
+  &ports[0];=0A=
+#elif defined(CONFIG_ETRAX_DEBUG_PORT1)=0A=
+  &ports[1];=0A=
+#elif defined(CONFIG_ETRAX_DEBUG_PORT2)=0A=
+  &ports[2];=0A=
+#elif defined(CONFIG_ETRAX_DEBUG_PORT3)=0A=
+  &ports[3];=0A=
+#else=0A=
+  NULL;=0A=
 #endif=0A=
+/* Used by serial.c to register a debug_write_function so that the =
normal=0A=
+ * serial driver is used for kernel debug output=0A=
+ */=0A=
+typedef int (*debugport_write_function)(int i, const char *buf, =
unsigned int len);=0A=
 =0A=
-#ifdef CONFIG_ETRAX_DEBUG_PORT3=0A=
-#define DEBUG_PORT_IDX 3=0A=
-#define DEBUG_OCMD R_DMA_CH4_CMD=0A=
-#define DEBUG_FIRST R_DMA_CH4_FIRST=0A=
-#define DEBUG_OCLRINT R_DMA_CH4_CLR_INTR=0A=
-#define DEBUG_STATUS R_DMA_CH4_STATUS=0A=
-#define DEBUG_READ R_SERIAL3_READ=0A=
-#define DEBUG_WRITE R_SERIAL3_TR_DATA=0A=
-#define DEBUG_TR_CTRL R_SERIAL3_TR_CTRL=0A=
-#define DEBUG_REC_CTRL R_SERIAL3_REC_CTRL=0A=
-#define DEBUG_IRQ IO_STATE(R_IRQ_MASK1_SET, ser3_data, set)=0A=
-#define DEBUG_DMA_IRQ_CLR IO_STATE(R_IRQ_MASK2_CLR, dma4_descr, clr)=0A=
-#endif=0A=
+debugport_write_function debug_write_function =3D NULL;=0A=
 =0A=
-#define MIN_SIZE 32 /* Size that triggers the FIFO to flush characters =
to interface */=0A=
+static void=0A=
+start_port(void)=0A=
+{=0A=
+	unsigned long rec_ctrl =3D 0;=0A=
+	unsigned long tr_ctrl =3D 0;=0A=
 =0A=
-static struct tty_driver *serial_driver;=0A=
+	if (!port)=0A=
+		return;=0A=
 =0A=
-typedef int (*debugport_write_function)(int i, const char *buf, =
unsigned int len);=0A=
+	if (port->started)=0A=
+		return;=0A=
+	port->started =3D 1;=0A=
+=0A=
+	if (port->index =3D=3D 0)=0A=
+	{=0A=
+		genconfig_shadow &=3D ~IO_MASK(R_GEN_CONFIG, dma6);=0A=
+		genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma6, unused);=0A=
+	}=0A=
+	else if (port->index =3D=3D 1)=0A=
+	{=0A=
+		genconfig_shadow &=3D ~IO_MASK(R_GEN_CONFIG, dma8);=0A=
+		genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma8, usb);=0A=
+	}=0A=
+	else if (port->index =3D=3D 2)=0A=
+	{=0A=
+		genconfig_shadow &=3D ~IO_MASK(R_GEN_CONFIG, dma2);=0A=
+		genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma2, par0);=0A=
+		genconfig_shadow &=3D ~IO_MASK(R_GEN_CONFIG, dma3);=0A=
+		genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma3, par0);=0A=
+		genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, ser2, select);=0A=
+	}=0A=
+	else=0A=
+	{=0A=
+		genconfig_shadow &=3D ~IO_MASK(R_GEN_CONFIG, dma4);=0A=
+		genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma4, par1);=0A=
+		genconfig_shadow &=3D ~IO_MASK(R_GEN_CONFIG, dma5);=0A=
+		genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma5, par1);=0A=
+		genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, ser3, select);=0A=
+	}=0A=
 =0A=
-debugport_write_function debug_write_function =3D NULL;=0A=
+	*R_GEN_CONFIG =3D genconfig_shadow;=0A=
+=0A=
+	*port->xoff =3D=0A=
+		IO_STATE(R_SERIAL0_XOFF, tx_stop, enable) |=0A=
+		IO_STATE(R_SERIAL0_XOFF, auto_xoff, disable) |=0A=
+		IO_FIELD(R_SERIAL0_XOFF, xoff_char, 0);=0A=
+=0A=
+	switch (port->baudrate)=0A=
+	{=0A=
+	case 0:=0A=
+	case 115200:=0A=
+		*port->baud =3D=0A=
+		  IO_STATE(R_SERIAL0_BAUD, tr_baud, c115k2Hz) |=0A=
+		  IO_STATE(R_SERIAL0_BAUD, rec_baud, c115k2Hz);=0A=
+		break;=0A=
+	case 1200:=0A=
+		*port->baud =3D=0A=
+		  IO_STATE(R_SERIAL0_BAUD, tr_baud, c1200Hz) |=0A=
+		  IO_STATE(R_SERIAL0_BAUD, rec_baud, c1200Hz);=0A=
+		break;=0A=
+	case 2400:=0A=
+		*port->baud =3D=0A=
+		  IO_STATE(R_SERIAL0_BAUD, tr_baud, c2400Hz) |=0A=
+		  IO_STATE(R_SERIAL0_BAUD, rec_baud, c2400Hz);=0A=
+		break;=0A=
+	case 4800:=0A=
+		*port->baud =3D=0A=
+		  IO_STATE(R_SERIAL0_BAUD, tr_baud, c4800Hz) |=0A=
+		  IO_STATE(R_SERIAL0_BAUD, rec_baud, c4800Hz);=0A=
+		break;=0A=
+	case 9600:=0A=
+		*port->baud =3D=0A=
+		  IO_STATE(R_SERIAL0_BAUD, tr_baud, c9600Hz) |=0A=
+		  IO_STATE(R_SERIAL0_BAUD, rec_baud, c9600Hz);=0A=
+		  break;=0A=
+	case 19200:=0A=
+		*port->baud =3D=0A=
+		  IO_STATE(R_SERIAL0_BAUD, tr_baud, c19k2Hz) |=0A=
+		  IO_STATE(R_SERIAL0_BAUD, rec_baud, c19k2Hz);=0A=
+		 break;=0A=
+	case 38400:=0A=
+		*port->baud =3D=0A=
+		  IO_STATE(R_SERIAL0_BAUD, tr_baud, c38k4Hz) |=0A=
+		  IO_STATE(R_SERIAL0_BAUD, rec_baud, c38k4Hz);=0A=
+		break;=0A=
+	case 57600:=0A=
+		*port->baud =3D=0A=
+		  IO_STATE(R_SERIAL0_BAUD, tr_baud, c57k6Hz) |=0A=
+		  IO_STATE(R_SERIAL0_BAUD, rec_baud, c57k6Hz);=0A=
+		break;=0A=
+	default:=0A=
+		*port->baud =3D=0A=
+		  IO_STATE(R_SERIAL0_BAUD, tr_baud, c115k2Hz) |=0A=
+		  IO_STATE(R_SERIAL0_BAUD, rec_baud, c115k2Hz);=0A=
+		  break;=0A=
+        } =0A=
+         =0A=
+	if (port->parity =3D=3D 'E') {=0A=
+		rec_ctrl =3D =0A=
+		  IO_STATE(R_SERIAL0_REC_CTRL, rec_par, even) |=0A=
+		  IO_STATE(R_SERIAL0_REC_CTRL, rec_par_en, enable);=0A=
+		tr_ctrl =3D=0A=
+		  IO_STATE(R_SERIAL0_TR_CTRL, tr_par, even) |=0A=
+		  IO_STATE(R_SERIAL0_TR_CTRL, tr_par_en, enable);	=0A=
+	} else if (port->parity =3D=3D 'O') {=0A=
+		rec_ctrl =3D =0A=
+		  IO_STATE(R_SERIAL0_REC_CTRL, rec_par, odd) |=0A=
+		  IO_STATE(R_SERIAL0_REC_CTRL, rec_par_en, enable);=0A=
+		tr_ctrl =3D=0A=
+		  IO_STATE(R_SERIAL0_TR_CTRL, tr_par, odd) |=0A=
+		  IO_STATE(R_SERIAL0_TR_CTRL, tr_par_en, enable);=0A=
+	} else {=0A=
+		rec_ctrl =3D =0A=
+		  IO_STATE(R_SERIAL0_REC_CTRL, rec_par, even) |=0A=
+		  IO_STATE(R_SERIAL0_REC_CTRL, rec_par_en, disable);=0A=
+		tr_ctrl =3D=0A=
+		  IO_STATE(R_SERIAL0_TR_CTRL, tr_par, even) |=0A=
+		  IO_STATE(R_SERIAL0_TR_CTRL, tr_par_en, disable);	=0A=
+	}=0A=
+=0A=
+	if (port->bits =3D=3D 7)=0A=
+	{=0A=
+		rec_ctrl |=3D IO_STATE(R_SERIAL0_REC_CTRL, rec_bitnr, rec_7bit);=0A=
+		tr_ctrl |=3D IO_STATE(R_SERIAL0_TR_CTRL, tr_bitnr, tr_7bit);=0A=
+	}=0A=
+	else=0A=
+	{=0A=
+		rec_ctrl |=3D IO_STATE(R_SERIAL0_REC_CTRL, rec_bitnr, rec_8bit);=0A=
+		tr_ctrl |=3D IO_STATE(R_SERIAL0_TR_CTRL, tr_bitnr, tr_8bit);=0A=
+	}=0A=
+	 =0A=
+	*port->rec_ctrl =3D=0A=
+		IO_STATE(R_SERIAL0_REC_CTRL, dma_err, stop) |=0A=
+		IO_STATE(R_SERIAL0_REC_CTRL, rec_enable, enable) |=0A=
+		IO_STATE(R_SERIAL0_REC_CTRL, rts_, active) |=0A=
+		IO_STATE(R_SERIAL0_REC_CTRL, sampling, middle) |=0A=
+		IO_STATE(R_SERIAL0_REC_CTRL, rec_stick_par, normal) |=0A=
+		rec_ctrl;=0A=
+=0A=
+	*port->tr_ctrl =3D=0A=
+		IO_FIELD(R_SERIAL0_TR_CTRL, txd, 0) |=0A=
+		IO_STATE(R_SERIAL0_TR_CTRL, tr_enable, enable) |=0A=
+		IO_STATE(R_SERIAL0_TR_CTRL, auto_cts, disabled) |=0A=
+		IO_STATE(R_SERIAL0_TR_CTRL, stop_bits, one_bit) |=0A=
+		IO_STATE(R_SERIAL0_TR_CTRL, tr_stick_par, normal) |=0A=
+		tr_ctrl;=0A=
+}=0A=
 =0A=
 static void=0A=
 console_write_direct(struct console *co, const char *buf, unsigned int =
len)=0A=
 {=0A=
 	int i;=0A=
+	unsigned long flags;=0A=
+	local_irq_save(flags);=0A=
 	/* Send data */=0A=
 	for (i =3D 0; i < len; i++) {=0A=
 		/* Wait until transmitter is ready and send.*/=0A=
-		while(!(*DEBUG_READ & IO_MASK(R_SERIAL0_READ, tr_ready)));=0A=
-                *DEBUG_WRITE =3D buf[i];=0A=
+		while (!(*port->read & IO_MASK(R_SERIAL0_READ, tr_ready)))=0A=
+			;=0A=
+		*port->write =3D buf[i];=0A=
 	}=0A=
+	local_irq_restore(flags);=0A=
 }=0A=
 =0A=
-static void =0A=
+static void=0A=
 console_write(struct console *co, const char *buf, unsigned int len)=0A=
 {=0A=
-	unsigned long flags;=0A=
-#ifdef CONFIG_ETRAX_DEBUG_PORT_NULL=0A=
-        /* no debug printout at all */=0A=
-        return;=0A=
-#endif=0A=
+	if (!port)=0A=
+		return;=0A=
 =0A=
 #ifdef CONFIG_SVINTO_SIM=0A=
 	/* no use to simulate the serial debug output */=0A=
-	SIMCOUT(buf,len);=0A=
+	SIMCOUT(buf, len);=0A=
 	return;=0A=
 #endif=0A=
 =0A=
+	start_port();=0A=
+=0A=
 #ifdef CONFIG_ETRAX_KGDB=0A=
 	/* kgdb needs to output debug info using the gdb protocol */=0A=
 	putDebugString(buf, len);=0A=
 	return;=0A=
 #endif=0A=
 =0A=
-	local_irq_save(flags);=0A=
 	if (debug_write_function)=0A=
-		if (debug_write_function(co->index, buf, len))=0A=
-			return;=0A=
-	console_write_direct(co, buf, len);=0A=
-	local_irq_restore(flags);=0A=
+		debug_write_function(co->index, buf, len);=0A=
+	else=0A=
+		console_write_direct(co, buf, len);=0A=
 }=0A=
 =0A=
 /* legacy function */=0A=
@@ -194,10 +373,10 @@=0A=
 getDebugChar(void)=0A=
 {=0A=
 	unsigned long readval;=0A=
-	=0A=
+=0A=
 	do {=0A=
-		readval =3D *DEBUG_READ;=0A=
-	} while(!(readval & IO_MASK(R_SERIAL0_READ, data_avail)));=0A=
+		readval =3D *port->read;=0A=
+	} while (!(readval & IO_MASK(R_SERIAL0_READ, data_avail)));=0A=
 =0A=
 	return (readval & IO_MASK(R_SERIAL0_READ, data_in));=0A=
 }=0A=
@@ -207,9 +386,9 @@=0A=
 void=0A=
 putDebugChar(int val)=0A=
 {=0A=
-	while(!(*DEBUG_READ & IO_MASK(R_SERIAL0_READ, tr_ready))) ;=0A=
-;=0A=
-	*DEBUG_WRITE =3D val;=0A=
+	while (!(*port->read & IO_MASK(R_SERIAL0_READ, tr_ready)))=0A=
+		;=0A=
+	*port->write =3D val;=0A=
 }=0A=
 =0A=
 /* Enable irq for receiving chars on the debug port, used by kgdb */=0A=
@@ -217,68 +396,127 @@=0A=
 void=0A=
 enableDebugIRQ(void)=0A=
 {=0A=
-	*R_IRQ_MASK1_SET =3D DEBUG_IRQ;=0A=
+	*R_IRQ_MASK1_SET =3D port->irq;=0A=
 	/* use R_VECT_MASK directly, since we really bypass Linux normal=0A=
 	 * IRQ handling in kgdb anyway, we don't need to use enable_irq=0A=
 	 */=0A=
 	*R_VECT_MASK_SET =3D IO_STATE(R_VECT_MASK_SET, serial, set);=0A=
 =0A=
-	*DEBUG_REC_CTRL =3D IO_STATE(R_SERIAL0_REC_CTRL, rec_enable, enable);=0A=
+	*port->rec_ctrl =3D IO_STATE(R_SERIAL0_REC_CTRL, rec_enable, enable);=0A=
 }=0A=
 =0A=
 static struct tty_driver*=0A=
-console_device(struct console *c, int *index)=0A=
+etrax_console_device(struct console* co, int *index)=0A=
 {=0A=
-	*index =3D c->index;=0A=
 	return serial_driver;=0A=
 }=0A=
 =0A=
-static int __init =0A=
+static int __init=0A=
 console_setup(struct console *co, char *options)=0A=
 {=0A=
-        return 0;=0A=
+	char* s;=0A=
+=0A=
+	if (options) {=0A=
+		port =3D &ports[co->index];=0A=
+		port->baudrate =3D 115200;=0A=
+                port->parity =3D 'N';=0A=
+                port->bits =3D 8;=0A=
+		port->baudrate =3D simple_strtoul(options, NULL, 10);=0A=
+		s =3D options;=0A=
+		while(*s >=3D '0' && *s <=3D '9')=0A=
+			s++;=0A=
+		if (*s) port->parity =3D *s++;=0A=
+		if (*s) port->bits   =3D *s++ - '0';=0A=
+		port->started =3D 0;=0A=
+		start_port();=0A=
+	}=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 static struct console sercons =3D {=0A=
-	.name    =3D "ttyS",=0A=
-	.write   =3D console_write,=0A=
-	.read    =3D NULL,=0A=
-	.device  =3D console_device,=0A=
-	.unblank =3D NULL,=0A=
-	.setup   =3D console_setup,=0A=
-	.flags   =3D CON_PRINTBUFFER,=0A=
-	.index   =3D DEBUG_PORT_IDX,=0A=
-	.cflag   =3D 0,=0A=
-	.next    =3D NULL=0A=
+	name : "ttyS",=0A=
+	write: console_write,=0A=
+	read : NULL,=0A=
+	device : etrax_console_device,=0A=
+	unblank : NULL,=0A=
+	setup : console_setup,=0A=
+	flags : CON_PRINTBUFFER,=0A=
+	index : -1,=0A=
+	cflag : 0,=0A=
+	next : NULL=0A=
+};=0A=
+static struct console sercons0 =3D {=0A=
+	name : "ttyS",=0A=
+	write: console_write,=0A=
+	read : NULL,=0A=
+	device : etrax_console_device,=0A=
+	unblank : NULL,=0A=
+	setup : console_setup,=0A=
+	flags : CON_PRINTBUFFER,=0A=
+	index : 0,=0A=
+	cflag : 0,=0A=
+	next : NULL=0A=
 };=0A=
 =0A=
+static struct console sercons1 =3D {=0A=
+	name : "ttyS",=0A=
+	write: console_write,=0A=
+	read : NULL,=0A=
+	device : etrax_console_device,=0A=
+	unblank : NULL,=0A=
+	setup : console_setup,=0A=
+	flags : CON_PRINTBUFFER,=0A=
+	index : 1,=0A=
+	cflag : 0,=0A=
+	next : NULL=0A=
+};=0A=
+static struct console sercons2 =3D {=0A=
+	name : "ttyS",=0A=
+	write: console_write,=0A=
+	read : NULL,=0A=
+	device : etrax_console_device,=0A=
+	unblank : NULL,=0A=
+	setup : console_setup,=0A=
+	flags : CON_PRINTBUFFER,=0A=
+	index : 2,=0A=
+	cflag : 0,=0A=
+	next : NULL=0A=
+};=0A=
+static struct console sercons3 =3D {=0A=
+	name : "ttyS",=0A=
+	write: console_write,=0A=
+	read : NULL,=0A=
+	device : etrax_console_device,=0A=
+	unblank : NULL,=0A=
+	setup : console_setup,=0A=
+	flags : CON_PRINTBUFFER,=0A=
+	index : 3,=0A=
+	cflag : 0,=0A=
+	next : NULL=0A=
+};=0A=
 /*=0A=
  *      Register console (for printk's etc)=0A=
  */=0A=
 =0A=
-void __init =0A=
+int __init=0A=
 init_etrax_debug(void)=0A=
 {=0A=
-#ifdef CONFIG_ETRAX_DEBUG_PORT_NULL=0A=
-	return;=0A=
-#endif=0A=
-=0A=
-#if DEBUG_PORT_IDX =3D=3D 0=0A=
-	genconfig_shadow &=3D  ~IO_MASK(R_GEN_CONFIG, dma6);=0A=
-	genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma6, unused);=0A=
-#elif DEBUG_PORT_IDX =3D=3D 1=0A=
-	genconfig_shadow &=3D  ~IO_MASK(R_GEN_CONFIG, dma8);=0A=
-	genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma8, usb);=0A=
-#elif DEBUG_PORT_IDX =3D=3D 2=0A=
-	genconfig_shadow &=3D  ~IO_MASK(R_GEN_CONFIG, dma2);=0A=
-	genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma2, par0);=0A=
-#elif DEBUG_PORT_IDX =3D=3D 3=0A=
-	genconfig_shadow &=3D  ~IO_MASK(R_GEN_CONFIG, dma4);=0A=
-	genconfig_shadow |=3D IO_STATE(R_GEN_CONFIG, dma4, par1);=0A=
-#endif=0A=
-	*R_GEN_CONFIG =3D genconfig_shadow;=0A=
-=0A=
-	register_console(&sercons);=0A=
+	static int first =3D 1;=0A=
+  =0A=
+	if (!first) {=0A=
+		if (!port) {=0A=
+			register_console(&sercons0);=0A=
+			register_console(&sercons1);=0A=
+			register_console(&sercons2);=0A=
+			register_console(&sercons3);=0A=
+			unregister_console(&sercons);=0A=
+		}=0A=
+		return 0;=0A=
+	}=0A=
+	first =3D 0;=0A=
+	if (port)=0A=
+		register_console(&sercons);=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 int __init=0A=
@@ -289,3 +527,4 @@=0A=
 		return -ENOMEM;=0A=
 	return 0;=0A=
 }=0A=
+=0A=
+__initcall(init_etrax_debug);=0A=

------=_NextPart_000_01DD_01C4C0E4.EA6E2520--

