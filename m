Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269927AbRHJPRz>; Fri, 10 Aug 2001 11:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269928AbRHJPRr>; Fri, 10 Aug 2001 11:17:47 -0400
Received: from smtp.awc.net ([216.205.112.6]:49672 "EHLO mx-a.awc.net")
	by vger.kernel.org with ESMTP id <S269927AbRHJPRe>;
	Fri, 10 Aug 2001 11:17:34 -0400
For: <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
From: Caleb Tennis <caleb@aei-tech.com>
Organization: Analytical Engineering, Inc.
To: linux-kernel@vger.kernel.org
Subject: [PATCH] serial.c to support ConnectTech Blueheat PCI
Date: Fri, 10 Aug 2001 10:19:08 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081010190800.03758@pete.aei-tech.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My first attempt at a patch - this fix was actually supported by ConnectTech
but for an older version of the serial driver - this patch brings it up to
date with changes made to the kernel since 2.2.

This patch was applied to a 2.4.7 kernel.

Caleb

--- ./drivers/char/serial_orig.bak	Fri Aug 10 08:22:13 2001
+++ ./drivers/char/serial.c	Fri Aug 10 09:41:36 2001
@@ -57,10 +57,12 @@
  * 10/00: add in optional software flow control for serial console.
  *	  Kanoj Sarcar <kanoj@sgi.com>  (Modified by Theodore Ts'o)
  *
+ *  8/01: added support for ConnectTech Blueheat PCI boards (RS485
+ *        support) <caleb@aei-tech.com>
  */

-static char *serial_version = "5.05c";
-static char *serial_revdate = "2001-07-08";
+static char *serial_version = "5.05d";
+static char *serial_revdate = "2001-08-10";

 /*
  * Serial driver configuration section.  Here are the various options:
@@ -1417,6 +1419,9 @@
 	 */
 	mod_timer(&serial_timer, jiffies + 2*HZ/100);

+	if (state->lmode_fn)
+	  (state->lmode_fn)(state,TIOCSER485SET,NULL);
+
 	/*
 	 * Set up the tty->alt_speed kludge
 	 */
@@ -2523,6 +2528,7 @@
 		    unsigned int cmd, unsigned long arg)
 {
 	struct async_struct * info = (struct async_struct *)tty->driver_data;
+	struct serial_state * state = info->state;
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct icount;
 	unsigned long flags;
@@ -2580,6 +2586,10 @@
 				 (tmp ? CLOCAL : 0));
 			return 0;
 #endif
+	case TIOCSER485GET:
+	case TIOCSER485SET:
+	  if (state->lmode_fn)
+	    return (state->lmode_fn)(state, cmd, (unsigned int *) arg);
 		case TIOCMGET:
 			return get_modem_info(info, (unsigned int *) arg);
 		case TIOCMBIS:
@@ -3985,6 +3995,7 @@
 		if (line < 0)
 			break;
 		rs_table[line].baud_base = base_baud;
+		rs_table[line].lmode_fn = board->lmode_fn;
 		rs_table[line].dev = dev;
 	}
 }
@@ -4138,6 +4149,131 @@
 }

 /*
+ * These functions allow for setting for half, full, and slave duplex on
+ * ConnectTech Blueheat PCI multiport boards.  cti485 does the work.
+ * _2 and _4 do checking for the hybrid boards.
+ * They rely on the fact that the ports will start at a 256 aligned
+ * address to calculate which port on the board it is.
+ */
+
+static int pci_cti485_fn(struct serial_state *state, int ioctl,
+			 unsigned int *value) {
+
+        static unsigned char done_init = 0;
+	struct async_struct *info;
+	unsigned char port_offset;
+	unsigned char portmask;
+	unsigned char txctl_offset;
+	unsigned char rxctl_offset;
+	unsigned char differ_offset;
+	unsigned char bits;
+	unsigned long flags;
+
+	if (ioctl == TIOCSER485GET)
+		return put_user(state->lmode, value);
+
+	info = state->info;
+	port_offset = state->port % 0x100;
+	portmask = 1 << port_offset / 0x08;
+	txctl_offset = 0x6c - port_offset;
+	rxctl_offset = 0x70 - port_offset;
+
+	save_flags(flags); cli();
+	if (value)
+		state->lmode = *value;
+	else if (!done_init) {
+		differ_offset = 0x74 - port_offset;
+		bits = serial_in(info, differ_offset);
+		switch (bits) {
+			case 0x03:
+				state->lmode = TIOCSER485SLAVEMULTIPLEX;
+				break;
+			default:
+				state->lmode = TIOCSER485FULLDUPLEX;
+				break;
+		}
+	}
+	done_init = 1;
+	bits = serial_in(info, txctl_offset);
+	switch (state->lmode) {
+		default:
+		case TIOCSER485FULLDUPLEX:
+			bits &= ~portmask;
+			serial_out(info, txctl_offset, bits);
+
+			bits = serial_in(info, rxctl_offset);
+			bits |= portmask;
+			serial_out(info, rxctl_offset, bits);
+
+			serial_out(info, UART_LCR, 0xbf);
+			bits = serial_in(info, UART_FCTR);
+			bits &= ~UART_FCTR_TX_INT;
+			serial_out(info, UART_FCTR, bits);
+			serial_out(info, UART_LCR, 0);
+
+			restore_flags(flags);
+			return put_user(1, value);
+		case TIOCSER485HALFDUPLEX:
+			bits |= portmask;
+			serial_out(info, txctl_offset, bits);
+
+			bits = serial_in(info, rxctl_offset);
+			bits &= ~portmask;
+			serial_out(info, rxctl_offset, bits);
+
+			serial_out(info, UART_LCR, 0xbf);
+			bits = serial_in(info, UART_FCTR);
+			bits |= UART_FCTR_TX_INT;
+			serial_out(info, UART_FCTR, bits);
+			serial_out(info, UART_LCR, 0);
+
+			restore_flags(flags);
+			return put_user(1, value);
+		case TIOCSER485SLAVEMULTIPLEX:
+			bits |= portmask;
+			serial_out(info, txctl_offset, bits);
+
+			bits = serial_in(info, rxctl_offset);
+			bits |= portmask;
+			serial_out(info, rxctl_offset, bits);
+
+			serial_out(info, UART_LCR, 0xbf);
+			bits = serial_in(info, UART_FCTR);
+			bits |= UART_FCTR_TX_INT;
+			serial_out(info, UART_FCTR, bits);
+			serial_out(info, UART_LCR, 0);
+
+			restore_flags(flags);
+			return put_user(1, value);
+	}
+
+	restore_flags(flags);
+	return -EINVAL;
+}
+
+static int pci_cti485_4_fn(struct serial_state *state, int ioctl,
+			   unsigned int *value) {
+	int port = state->port;
+	int board_num = (port % 0x100) / 0x08;
+
+	if (board_num < 4)
+		return -ENOSYS;
+
+	return pci_cti485_fn(state, ioctl, value);
+}
+
+static int pci_cti485_2_fn(struct serial_state *state, int ioctl,
+			   unsigned int *value) {
+	int port = state->port;
+	int board_num = (port % 0x100) / 0x08;
+
+	if (board_num < 2)
+		return -ENOSYS;
+
+	return pci_cti485_fn(state, ioctl, value);
+}
+
+/*
  * Timedia has an explosion of boards, and to avoid the PCI table from
  * growing *huge*, we use this function to collapse some 70 entries
  * in the PCI table into one, for sanity's and compactness's sake.
@@ -4227,7 +4363,10 @@

 	pbn_b1_2_921600,
 	pbn_b1_4_921600,
+	pbn_b1_4_2_921600,     /* Added for 232/485 hybrid boards */
 	pbn_b1_8_921600,
+	pbn_b1_8_4_921600,     /* Added for 232/485 hybrid boards */
+	pbn_b1_8_2_921600,     /* Added for 232/485 hybrid boards */

 	pbn_b1_2_1382400,
 	pbn_b1_4_1382400,
@@ -4303,9 +4442,18 @@
 	{ SPCI_FL_BASE1, 4, 115200 },		/* pbn_b1_4_115200 */
 	{ SPCI_FL_BASE1, 8, 115200 },		/* pbn_b1_8_115200 */

-	{ SPCI_FL_BASE1, 2, 921600 },		/* pbn_b1_2_921600 */
-	{ SPCI_FL_BASE1, 4, 921600 },		/* pbn_b1_4_921600 */
-	{ SPCI_FL_BASE1, 8, 921600 },		/* pbn_b1_8_921600 */
+	{ SPCI_FL_BASE1, 2, 921600,		/* pbn_b1_2_921600 */
+	  0, 0, NULL, 0, pci_cti485_fn },
+	{ SPCI_FL_BASE1, 4, 921600,		/* pbn_b1_4_921600 */
+	  0, 0, NULL, 0, pci_cti485_fn },
+	{ SPCI_FL_BASE1, 4, 921600,             /* pbn_b1_4_2_921600 */
+	  0, 0, NULL, 0, pci_cti485_2_fn },
+	{ SPCI_FL_BASE1, 8, 921600,		/* pbn_b1_8_921600 */
+	  0, 0, NULL, 0, pci_cti485_fn },
+	{ SPCI_FL_BASE1, 8, 921600,
+	  0, 0, NULL, 0, pci_cti485_4_fn },       /* pbn_b1_8_4_921600 */
+	{ SPCI_FL_BASE1, 8, 921600,
+	  0, 0, NULL, 0, pci_cti485_2_fn },       /* pbn_b1_8_2_921600 */

 	{ SPCI_FL_BASE1, 2, 1382400 },		/* pbn_b1_2_1382400 */
 	{ SPCI_FL_BASE1, 4, 1382400 },		/* pbn_b1_4_1382400 */
@@ -4515,7 +4663,7 @@
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4, 0, 0,
-		pbn_b1_8_921600 },
+		pbn_b1_8_4_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485, 0, 0,
@@ -4523,7 +4671,7 @@
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2, 0, 0,
-		pbn_b1_4_921600 },
+		pbn_b1_4_2_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485, 0, 0,
@@ -4531,7 +4679,7 @@
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6, 0, 0,
-		pbn_b1_8_921600 },
+		pbn_b1_8_2_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1, 0, 0,

--- ./include/linux/serialP_orig.bak	Fri Aug 10 09:44:02 2001
+++ ./include/linux/serialP.h	Fri Aug 10 09:51:09 2001
@@ -51,6 +51,9 @@
 	struct termios		normal_termios;
 	struct termios		callout_termios;
 	int	io_type;
+	int (*lmode_fn)(struct serial_state *state, int ioctl,
+			unsigned int *value);
+	int lmode;
 	struct async_struct *info;
 	struct pci_dev	*dev;
 };
@@ -150,6 +153,8 @@
 	int (*init_fn)(struct pci_dev *dev, struct pci_board *board,
 			int enable);
 	int first_uart_offset;
+	int (*lmode_fn)(struct serial_state *state, int ioctl,
+			unsigned int *value);
 };

 struct pci_board_inst {

--- ./include/asm-i386/ioctls_orig.bak	Fri Aug 10 09:48:31 2001
+++ ./include/asm-i386/ioctls.h	Fri Aug 10 09:47:42 2001
@@ -68,6 +68,14 @@
 #define TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
 #define TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */

+#define TIOCSER485SET   0x5460  /* Set the 485 line */
+#define TIOCSER485GET   0x5461  /* Get the 485 line */
+
+#define TIOCSER485FULLDUPLEX		0
+#define TIOCSER485HALFDUPLEX		1
+#define TIOCSER485SLAVEMULTIPLEX	2
+
+
 /* Used for packet mode */
 #define TIOCPKT_DATA		 0
 #define TIOCPKT_FLUSHREAD	 1

--
Caleb Tennis
Analytical Engineering
2555 Technology Blvd
Columbus, IN 47201

-------------------------------------------------------

-- 
Caleb Tennis
Analytical Engineering
2555 Technology Blvd
Columbus, IN 47201
