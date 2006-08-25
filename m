Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWHYOzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWHYOzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWHYOyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:54:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13217 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030241AbWHYOyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:54:15 -0400
Subject: New serial speed handling: First implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 16:15:53 +0100
Message-Id: <1156518953.3007.247.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enclosed is a draft patch for the serial update which implements
arbitary speeds in the core and fixes up some drivers.

What needs doing:

Architecture Maintainer
-----------------------
	Define struct termios_v1 to be the existing "old style" termios
structure
	Create a struct termios which adds speed_t type fields for c_ispeed and
c_ospeed. You may wish to follow the glibc struct termios for
simplicity.
	Find an unused speed value and define it for other (BOTHER). For most
platforms CBAUDEX|0 is unused.
	Add ioctl values for TCGETS2/TCSETS2/TCSETSW2/TCSETSF2 to match the
existing TCGETS/SETS ioctls but with struct termios (the new version)
	Add user_termios_to_kernel_termios_1 and the reverse for copying old
style termios structures


Driver Author
-------------
	From the point this change goes into the base kernel the baud rate is
always in tty->termios.c_ispeed (input rate) and tty->termios.c_ospeed
(output rate). tty_get_baud_rate() will continue to give the correct
answer but does not allow for differing input/output rates if your
hardware can do it. Please move to using ispeed/ospeed directly.
	In your speed changing routine set the baud rates to the one you set if
it differs from the requested speed. If you need to change it then - set
the c_cflags CBAUD bits either to the Bxxx version of the speed or
BOTHER and set c_ispeed/c_ospeed appropriately. If a lot of people need
this I will add a helper.
	In your init_termios ensure that you set valid c_ispeed/c_ospeed values
to match the termios structure Bxxx value you are currently specifiying.


Compatibility
-------------
	tty_get_baud_rate() remains doing the right thing
	Peeking at CBAUD bits works for "old" speeds still
	All the application functionality will continue with the
cfget/set*speed functions in glibc
	For the moment the code handles anything except a pty (all ptys are
sorted) which forgets to set c_ispeed/c_ospeed on its init_termios. That
will become a warning in time.


Thanks to Roland for reviewing ideas and pointing out CBAUDEX|0.


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/epca.c linux-2.6.18-rc4-mm2/drivers/char/epca.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/epca.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/epca.c	2006-08-25 14:56:58.000000000 +0100
@@ -1240,6 +1240,8 @@
 	pc_driver->init_termios.c_oflag = 0;
 	pc_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | CLOCAL | HUPCL;
 	pc_driver->init_termios.c_lflag = 0;
+	pc_driver->init_termios.c_ispeed = 9600;
+	pc_driver->init_termios.c_ospeed = 9600;
 	pc_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(pc_driver, &pc_ops);
 
@@ -1254,6 +1256,8 @@
 	pc_info->init_termios.c_oflag = 0;
 	pc_info->init_termios.c_lflag = 0;
 	pc_info->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL;
+	pc_info->init_termios.c_ispeed = 9600;
+	pc_info->init_termios.c_ospeed = 9600;
 	pc_info->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(pc_info, &info_ops);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/generic_serial.c linux-2.6.18-rc4-mm2/drivers/char/generic_serial.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/generic_serial.c	2006-08-21 14:17:16.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/generic_serial.c	2006-08-25 14:18:47.000000000 +0100
@@ -746,11 +746,9 @@
 		gs_dprintk (GS_DEBUG_TERMIOS, "termios structure (%p):\n", tiosp);
 	}
 
-#if 0
 	/* This is an optimization that is only allowed for dumb cards */
 	/* Smart cards require knowledge of iflags and oflags too: that 
 	   might change hardware cooking mode.... */
-#endif
 	if (old_termios) {
 		if(   (tiosp->c_iflag == old_termios->c_iflag)
 		   && (tiosp->c_oflag == old_termios->c_oflag)
@@ -774,14 +772,7 @@
 		if(!memcmp(tiosp->c_cc, old_termios->c_cc, NCC)) printk("c_cc changed\n");
 	}
 
-	baudrate = tiosp->c_cflag & CBAUD;
-	if (baudrate & CBAUDEX) {
-		baudrate &= ~CBAUDEX;
-		if ((baudrate < 1) || (baudrate > 4))
-			tiosp->c_cflag &= ~CBAUDEX;
-		else
-			baudrate += 15;
-	}
+	baudrate = tty_get_baud_rate(tty);
 
 	baudrate = gs_baudrates[baudrate];
 	if ((tiosp->c_cflag & CBAUD) == B38400) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/hvcs.c linux-2.6.18-rc4-mm2/drivers/char/hvcs.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/hvcs.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/hvcs.c	2006-08-25 14:19:19.000000000 +0100
@@ -196,7 +196,9 @@
 	.c_iflag = IGNBRK | IGNPAR,
 	.c_oflag = OPOST,
 	.c_cflag = B38400 | CS8 | CREAD | HUPCL,
-	.c_cc = INIT_C_CC
+	.c_cc = INIT_C_CC,
+	.c_ispeed = 38400,
+	.c_ospeed = 38400
 };
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/hvsi.c linux-2.6.18-rc4-mm2/drivers/char/hvsi.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/hvsi.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/hvsi.c	2006-08-25 14:20:15.000000000 +0100
@@ -1159,6 +1159,8 @@
 	hvsi_driver->type = TTY_DRIVER_TYPE_SYSTEM;
 	hvsi_driver->init_termios = tty_std_termios;
 	hvsi_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL;
+	hvsi_driver->init_termios.c_ispeed = 9600;
+	hvsi_driver->init_termios.c_ospeed = 9600;
 	hvsi_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(hvsi_driver, &hvsi_ops);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/istallion.c linux-2.6.18-rc4-mm2/drivers/char/istallion.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/istallion.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/istallion.c	2006-08-25 14:24:27.000000000 +0100
@@ -197,6 +197,8 @@
 static struct termios		stli_deftermios = {
 	.c_cflag	= (B9600 | CS8 | CREAD | HUPCL | CLOCAL),
 	.c_cc		= INIT_C_CC,
+	.c_ispeed	= 9600,
+	.c_ospeed	= 9600,
 };
 
 /*
@@ -612,16 +614,6 @@
 #define	MINOR2BRD(min)		(((min) & 0xc0) >> 6)
 #define	MINOR2PORT(min)		((min) & 0x3f)
 
-/*
- *	Define a baud rate table that converts termios baud rate selector
- *	into the actual baud rate value. All baud rate calculations are based
- *	on the actual baud rate required.
- */
-static unsigned int	stli_baudrates[] = {
-	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 115200, 230400, 460800, 921600
-};
-
 /*****************************************************************************/
 
 /*
@@ -2747,15 +2739,7 @@
 /*
  *	Start of by setting the baud, char size, parity and stop bit info.
  */
-	pp->baudout = tiosp->c_cflag & CBAUD;
-	if (pp->baudout & CBAUDEX) {
-		pp->baudout &= ~CBAUDEX;
-		if ((pp->baudout < 1) || (pp->baudout > 4))
-			tiosp->c_cflag &= ~CBAUDEX;
-		else
-			pp->baudout += 15;
-	}
-	pp->baudout = stli_baudrates[pp->baudout];
+	pp->baudout = tty_get_baud_rate(portp->tty);
 	if ((tiosp->c_cflag & CBAUD) == B38400) {
 		if ((portp->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
 			pp->baudout = 57600;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/moxa.c linux-2.6.18-rc4-mm2/drivers/char/moxa.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/moxa.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/moxa.c	2006-08-25 14:57:25.000000000 +0100
@@ -259,7 +259,7 @@
 static void MoxaPortDisable(int);
 static long MoxaPortGetMaxBaud(int);
 static long MoxaPortSetBaud(int, long);
-static int MoxaPortSetTermio(int, struct termios *);
+static int MoxaPortSetTermio(int, struct termios *, speed_t);
 static int MoxaPortGetLineOut(int, int *, int *);
 static void MoxaPortLineCtrl(int, int, int);
 static void MoxaPortFlowCtrl(int, int, int, int, int, int);
@@ -350,6 +350,8 @@
 	moxaDriver->init_termios.c_oflag = 0;
 	moxaDriver->init_termios.c_cflag = B9600 | CS8 | CREAD | CLOCAL | HUPCL;
 	moxaDriver->init_termios.c_lflag = 0;
+	moxaDriver->init_termios.c_ispeed = 9600;
+	moxaDriver->init_termios.c_ospeed = 9600;
 	moxaDriver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(moxaDriver, &moxa_ops);
 
@@ -985,7 +987,7 @@
 	if (ts->c_iflag & IXANY)
 		xany = 1;
 	MoxaPortFlowCtrl(ch->port, rts, cts, txflow, rxflow, xany);
-	MoxaPortSetTermio(ch->port, ts);
+	MoxaPortSetTermio(ch->port, ts, tty_get_baud_rate(tty));
 }
 
 static int block_till_ready(struct tty_struct *tty, struct file *filp,
@@ -1897,9 +1899,10 @@
  *
  *      Function 12:    Configure the port.
  *      Syntax:
- *      int  MoxaPortSetTermio(int port, struct termios *termio);
+ *      int  MoxaPortSetTermio(int port, struct termios *termio, speed_t baud);
  *           int port           : port number (0 - 127)
  *           struct termios * termio : termio structure pointer
+ *	     speed_t baud	: baud rate
  *
  *           return:    -1      : this port is invalid or termio == NULL
  *                      0       : setting O.K.
@@ -2179,11 +2182,10 @@
 	return (baud);
 }
 
-int MoxaPortSetTermio(int port, struct termios *termio)
+int MoxaPortSetTermio(int port, struct termios *termio, speed_t baud)
 {
 	void __iomem *ofsAddr;
 	tcflag_t cflag;
-	long baud;
 	tcflag_t mode = 0;
 
 	if (moxaChkPort[port] == 0 || termio == 0)
@@ -2218,78 +2220,10 @@
 		mode |= MX_PARNONE;
 
 	moxafunc(ofsAddr, FC_SetDataMode, (ushort) mode);
-
-	cflag &= (CBAUD | CBAUDEX);
-#ifndef B921600
-#define	B921600	(B460800+1)
-#endif
-	switch (cflag) {
-	case B921600:
-		baud = 921600L;
-		break;
-	case B460800:
-		baud = 460800L;
-		break;
-	case B230400:
-		baud = 230400L;
-		break;
-	case B115200:
-		baud = 115200L;
-		break;
-	case B57600:
-		baud = 57600L;
-		break;
-	case B38400:
-		baud = 38400L;
-		break;
-	case B19200:
-		baud = 19200L;
-		break;
-	case B9600:
-		baud = 9600L;
-		break;
-	case B4800:
-		baud = 4800L;
-		break;
-	case B2400:
-		baud = 2400L;
-		break;
-	case B1800:
-		baud = 1800L;
-		break;
-	case B1200:
-		baud = 1200L;
-		break;
-	case B600:
-		baud = 600L;
-		break;
-	case B300:
-		baud = 300L;
-		break;
-	case B200:
-		baud = 200L;
-		break;
-	case B150:
-		baud = 150L;
-		break;
-	case B134:
-		baud = 134L;
-		break;
-	case B110:
-		baud = 110L;
-		break;
-	case B75:
-		baud = 75L;
-		break;
-	case B50:
-		baud = 50L;
-		break;
-	default:
-		baud = 0;
-	}
+	
 	if ((moxa_boards[port / MAX_PORTS_PER_BOARD].boardType == MOXA_BOARD_C320_ISA) ||
 	    (moxa_boards[port / MAX_PORTS_PER_BOARD].boardType == MOXA_BOARD_C320_PCI)) {
-		if (baud == 921600L)
+		if (baud >= 921600L)
 			return (-1);
 	}
 	MoxaPortSetBaud(port, baud);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/mxser.c linux-2.6.18-rc4-mm2/drivers/char/mxser.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/mxser.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/mxser.c	2006-08-25 14:29:16.000000000 +0100
@@ -748,6 +748,8 @@
 	mxvar_sdriver->subtype = SERIAL_TYPE_NORMAL;
 	mxvar_sdriver->init_termios = tty_std_termios;
 	mxvar_sdriver->init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
+	mxvar_sdriver->init_termios.c_ispeed = 9600;
+	mxvar_sdriver->init_termios.c_ospeed = 9600;
 	mxvar_sdriver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(mxvar_sdriver, &mxser_ops);
 	mxvar_sdriver->ttys = mxvar_tty;
@@ -2540,71 +2542,7 @@
 #define B921600 (B460800 +1)
 #endif
 	if (mxser_set_baud_method[info->port] == 0) {
-		switch (cflag & (CBAUD | CBAUDEX)) {
-		case B921600:
-			baud = 921600;
-			break;
-		case B460800:
-			baud = 460800;
-			break;
-		case B230400:
-			baud = 230400;
-			break;
-		case B115200:
-			baud = 115200;
-			break;
-		case B57600:
-			baud = 57600;
-			break;
-		case B38400:
-			baud = 38400;
-			break;
-		case B19200:
-			baud = 19200;
-			break;
-		case B9600:
-			baud = 9600;
-			break;
-		case B4800:
-			baud = 4800;
-			break;
-		case B2400:
-			baud = 2400;
-			break;
-		case B1800:
-			baud = 1800;
-			break;
-		case B1200:
-			baud = 1200;
-			break;
-		case B600:
-			baud = 600;
-			break;
-		case B300:
-			baud = 300;
-			break;
-		case B200:
-			baud = 200;
-			break;
-		case B150:
-			baud = 150;
-			break;
-		case B134:
-			baud = 134;
-			break;
-		case B110:
-			baud = 110;
-			break;
-		case B75:
-			baud = 75;
-			break;
-		case B50:
-			baud = 50;
-			break;
-		default:
-			baud = 0;
-			break;
-		}
+		baud = tty_get_baud_rate(info->tty);
 		mxser_set_baud(info, baud);
 	}
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/pty.c linux-2.6.18-rc4-mm2/drivers/char/pty.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/pty.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/pty.c	2006-08-25 14:54:27.000000000 +0100
@@ -272,6 +272,8 @@
 	pty_driver->init_termios.c_oflag = 0;
 	pty_driver->init_termios.c_cflag = B38400 | CS8 | CREAD;
 	pty_driver->init_termios.c_lflag = 0;
+	pty_driver->init_termios.c_ispeed = 38400;
+	pty_driver->init_termios.c_ospeed = 38400;
 	pty_driver->flags = TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_REAL_RAW;
 	pty_driver->other = pty_slave_driver;
 	tty_set_operations(pty_driver, &pty_ops);
@@ -286,6 +288,8 @@
 	pty_slave_driver->subtype = PTY_TYPE_SLAVE;
 	pty_slave_driver->init_termios = tty_std_termios;
 	pty_slave_driver->init_termios.c_cflag = B38400 | CS8 | CREAD;
+	pty_slave_driver->init_termios.c_ispeed = 38400;
+	pty_slave_driver->init_termios.c_ospeed = 38400;
 	pty_slave_driver->flags = TTY_DRIVER_RESET_TERMIOS |
 					TTY_DRIVER_REAL_RAW;
 	pty_slave_driver->other = pty_driver;
@@ -366,6 +370,8 @@
 	ptm_driver->init_termios.c_oflag = 0;
 	ptm_driver->init_termios.c_cflag = B38400 | CS8 | CREAD;
 	ptm_driver->init_termios.c_lflag = 0;
+	ptm_driver->init_termios.c_ispeed = 38400;
+	ptm_driver->init_termios.c_ospeed = 38400;
 	ptm_driver->flags = TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_REAL_RAW |
 		TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_DEVPTS_MEM;
 	ptm_driver->other = pts_driver;
@@ -381,6 +387,8 @@
 	pts_driver->subtype = PTY_TYPE_SLAVE;
 	pts_driver->init_termios = tty_std_termios;
 	pts_driver->init_termios.c_cflag = B38400 | CS8 | CREAD;
+	pts_driver->init_termios.c_ispeed = 38400;
+	pts_driver->init_termios.c_ospeed = 38400;
 	pts_driver->flags = TTY_DRIVER_RESET_TERMIOS | TTY_DRIVER_REAL_RAW |
 		TTY_DRIVER_DYNAMIC_DEV | TTY_DRIVER_DEVPTS_MEM;
 	pts_driver->other = ptm_driver;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/riscom8.c linux-2.6.18-rc4-mm2/drivers/char/riscom8.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/riscom8.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/riscom8.c	2006-08-25 14:33:48.000000000 +0100
@@ -675,26 +675,12 @@
 	port->COR2 = 0;
 	port->MSVR = MSVR_RTS;
 	
-	baud = C_BAUD(tty);
-	
-	if (baud & CBAUDEX) {
-		baud &= ~CBAUDEX;
-		if (baud < 1 || baud > 2) 
-			port->tty->termios->c_cflag &= ~CBAUDEX;
-		else
-			baud += 15;
-	}
-	if (baud == 15)  {
-		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-			baud ++;
-		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-			baud += 2;
-	}
+	baud = tty_get_baud_rate(tty);
 	
 	/* Select port on the board */
 	rc_out(bp, CD180_CAR, port_No(port));
 	
-	if (!baud_table[baud])  {
+	if (!baud)  {
 		/* Drop DTR & exit */
 		bp->DTR |= (1u << port_No(port));
 		rc_out(bp, RC_DTR, bp->DTR);
@@ -710,7 +696,7 @@
 	 */
 	
 	/* Set baud rate for port */
-	tmp = (((RC_OSCFREQ + baud_table[baud]/2) / baud_table[baud] +
+	tmp = (((RC_OSCFREQ + baud/2) / baud +
 		CD180_TPC/2) / CD180_TPC);
 
 	rc_out(bp, CD180_RBPRH, (tmp >> 8) & 0xff); 
@@ -718,7 +704,7 @@
 	rc_out(bp, CD180_RBPRL, tmp & 0xff); 
 	rc_out(bp, CD180_TBPRL, tmp & 0xff);
 	
-	baud = (baud_table[baud] + 5) / 10;   /* Estimated CPS */
+	baud = (baud + 5) / 10;   /* Estimated CPS */
 	
 	/* Two timer ticks seems enough to wakeup something like SLIP driver */
 	tmp = ((baud + HZ/2) / HZ) * 2 - CD180_NFIFO;		
@@ -1640,6 +1626,8 @@
 	riscom_driver->init_termios = tty_std_termios;
 	riscom_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	riscom_driver->init_termios.c_ispeed = 9600;
+	riscom_driver->init_termios.c_ospeed = 9600;
 	riscom_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(riscom_driver, &riscom_ops);
 	if ((error = tty_register_driver(riscom_driver)))  {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/rocket.c linux-2.6.18-rc4-mm2/drivers/char/rocket.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/rocket.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/rocket.c	2006-08-25 14:34:54.000000000 +0100
@@ -2436,6 +2436,8 @@
 	rocket_driver->init_termios = tty_std_termios;
 	rocket_driver->init_termios.c_cflag =
 	    B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	rocket_driver->init_termios.c_ispeed = 9600;
+	rocket_driver->init_termios.c_ospeed = 9600;
 #ifdef ROCKET_SOFT_FLOW
 	rocket_driver->flags |= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/ser_a2232.c linux-2.6.18-rc4-mm2/drivers/char/ser_a2232.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/ser_a2232.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/ser_a2232.c	2006-08-25 14:35:30.000000000 +0100
@@ -695,6 +695,8 @@
 	a2232_driver->init_termios = tty_std_termios;
 	a2232_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	a2232_driver->init_termios.c_ispeed = 9600;
+	a2232_driver->init_termios.c_ospeed = 9600;
 	a2232_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(a2232_driver, &a2232_ops);
 	if ((error = tty_register_driver(a2232_driver))) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/specialix.c linux-2.6.18-rc4-mm2/drivers/char/specialix.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/specialix.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/specialix.c	2006-08-25 14:37:42.000000000 +0100
@@ -1087,24 +1087,16 @@
 		port->MSVR =  (sx_in(bp, CD186x_MSVR) & MSVR_RTS);
 	spin_unlock_irqrestore(&bp->lock, flags);
 	dprintk (SX_DEBUG_TERMIOS, "sx: got MSVR=%02x.\n", port->MSVR);
-	baud = C_BAUD(tty);
+	baud = tty_get_baud_rate(tty);
 
-	if (baud & CBAUDEX) {
-		baud &= ~CBAUDEX;
-		if (baud < 1 || baud > 2)
-			port->tty->termios->c_cflag &= ~CBAUDEX;
-		else
-			baud += 15;
-	}
-	if (baud == 15) {
+	if (baud == 38400) {
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
 			baud ++;
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
 			baud += 2;
 	}
 
-
-	if (!baud_table[baud]) {
+	if (!baud) {
 		/* Drop DTR & exit */
 		dprintk (SX_DEBUG_TERMIOS, "Dropping DTR...  Hmm....\n");
 		if (!SX_CRTSCTS (tty)) {
@@ -1134,7 +1126,7 @@
 		                  "This is an untested option, please be carefull.\n",
 		                  port_No (port), tmp);
 	else
-		tmp = (((SX_OSCFREQ + baud_table[baud]/2) / baud_table[baud] +
+		tmp = (((SX_OSCFREQ + baud/2) / baud +
 		         CD186x_TPC/2) / CD186x_TPC);
 
 	if ((tmp < 0x10) && time_before(again, jiffies)) {
@@ -2420,6 +2412,8 @@
 	specialix_driver->init_termios = tty_std_termios;
 	specialix_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	specialix_driver->init_termios.c_ispeed = 9600;
+	specialix_driver->init_termios.c_ospeed = 9600;
 	specialix_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(specialix_driver, &sx_ops);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/stallion.c linux-2.6.18-rc4-mm2/drivers/char/stallion.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/stallion.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/stallion.c	2006-08-25 14:41:06.000000000 +0100
@@ -146,6 +146,8 @@
 static struct termios		stl_deftermios = {
 	.c_cflag	= (B9600 | CS8 | CREAD | HUPCL | CLOCAL),
 	.c_cc		= INIT_C_CC,
+	.c_ispeed	= 9600,
+	.c_ospeed	= 9600,
 };
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/sx.c linux-2.6.18-rc4-mm2/drivers/char/sx.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/sx.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/sx.c	2006-08-25 14:43:48.000000000 +0100
@@ -2263,6 +2263,8 @@
 	sx_driver->init_termios = tty_std_termios;
 	sx_driver->init_termios.c_cflag =
 	  B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	sx_driver->init_termios.c_ispeed = 9600;
+	sx_driver->init_termios.c_ospeed = 9600;
 	sx_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(sx_driver, &sx_ops);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/synclink.c linux-2.6.18-rc4-mm2/drivers/char/synclink.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/synclink.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/synclink.c	2006-08-25 14:48:40.000000000 +0100
@@ -4404,6 +4404,8 @@
 	serial_driver->init_termios = tty_std_termios;
 	serial_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	serial_driver->init_termios.c_ispeed = 9600;
+	serial_driver->init_termios.c_ospeed = 9600;
 	serial_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(serial_driver, &mgsl_ops);
 	if ((rc = tty_register_driver(serial_driver)) < 0) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/synclink_gt.c linux-2.6.18-rc4-mm2/drivers/char/synclink_gt.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/synclink_gt.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/synclink_gt.c	2006-08-25 14:48:33.000000000 +0100
@@ -3537,6 +3537,8 @@
 	serial_driver->init_termios = tty_std_termios;
 	serial_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	serial_driver->init_termios.c_ispeed = 9600;
+	serial_driver->init_termios.c_ospeed = 9600;
 	serial_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(serial_driver, &ops);
 	if ((rc = tty_register_driver(serial_driver)) < 0) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/synclinkmp.c linux-2.6.18-rc4-mm2/drivers/char/synclinkmp.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/synclinkmp.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/synclinkmp.c	2006-08-25 14:49:17.000000000 +0100
@@ -4033,6 +4033,8 @@
 	serial_driver->init_termios = tty_std_termios;
 	serial_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	serial_driver->init_termios.c_ispeed = 9600;
+	serial_driver->init_termios.c_ospeed = 9600;
 	serial_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(serial_driver, &ops);
 	if ((rc = tty_register_driver(serial_driver)) < 0) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/tty_io.c linux-2.6.18-rc4-mm2/drivers/char/tty_io.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/tty_io.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/tty_io.c	2006-08-25 14:53:55.000000000 +0100
@@ -1250,6 +1250,21 @@
 }
 
 EXPORT_SYMBOL_GPL(tty_ldisc_flush);
+
+/**
+ *	tty_reset_termios	-	reset terminal state
+ *	@tty: tty to reset
+ *
+ *	Restore a terminal to the driver default state
+ */
+ 
+static void tty_reset_termios(struct tty_struct *tty)
+{
+	mutex_lock(&tty->termios_mutex);
+	*tty->termios = tty->driver->init_termios;
+	tty->termios->c_ispeed = tty->termios->c_ospeed = tty_get_baud_rate(tty);
+	mutex_unlock(&tty->termios_mutex);
+}
 	
 /**
  *	do_tty_hangup		-	actual handler for hangup events
@@ -1337,11 +1352,7 @@
 	 * N_TTY.
 	 */
 	if (tty->driver->flags & TTY_DRIVER_RESET_TERMIOS)
-	{
-		mutex_lock(&tty->termios_mutex);
-		*tty->termios = tty->driver->init_termios;
-		mutex_unlock(&tty->termios_mutex);
-	}
+		tty_reset_termios(tty);
 	
 	/* Defer ldisc switch */
 	/* tty_deferred_ldisc_switch(N_TTY);
@@ -1986,6 +1999,8 @@
 		*ltp_loc = ltp;
 	tty->termios = *tp_loc;
 	tty->termios_locked = *ltp_loc;
+	/* Compatibility until drivers always set this */
+	tty->termios->c_ispeed = tty->termios->c_ospeed = tty_get_baud_rate(tty);
 	driver->refcount++;
 	tty->count++;
 
@@ -3448,83 +3469,6 @@
 	tty_ldisc_deref(disc);
 }
 
-/*
- * Routine which returns the baud rate of the tty
- *
- * Note that the baud_table needs to be kept in sync with the
- * include/asm/termbits.h file.
- */
-static int baud_table[] = {
-	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
-	9600, 19200, 38400, 57600, 115200, 230400, 460800,
-#ifdef __sparc__
-	76800, 153600, 307200, 614400, 921600
-#else
-	500000, 576000, 921600, 1000000, 1152000, 1500000, 2000000,
-	2500000, 3000000, 3500000, 4000000
-#endif
-};
-
-static int n_baud_table = ARRAY_SIZE(baud_table);
-
-/**
- *	tty_termios_baud_rate
- *	@termios: termios structure
- *
- *	Convert termios baud rate data into a speed. This should be called
- *	with the termios lock held if this termios is a terminal termios
- *	structure. May change the termios data.
- *
- *	Locking: none
- */
- 
-int tty_termios_baud_rate(struct termios *termios)
-{
-	unsigned int cbaud;
-	
-	cbaud = termios->c_cflag & CBAUD;
-
-	if (cbaud & CBAUDEX) {
-		cbaud &= ~CBAUDEX;
-
-		if (cbaud < 1 || cbaud + 15 > n_baud_table)
-			termios->c_cflag &= ~CBAUDEX;
-		else
-			cbaud += 15;
-	}
-	return baud_table[cbaud];
-}
-
-EXPORT_SYMBOL(tty_termios_baud_rate);
-
-/**
- *	tty_get_baud_rate	-	get tty bit rates
- *	@tty: tty to query
- *
- *	Returns the baud rate as an integer for this terminal. The
- *	termios lock must be held by the caller and the terminal bit
- *	flags may be updated.
- *
- *	Locking: none
- */
- 
-int tty_get_baud_rate(struct tty_struct *tty)
-{
-	int baud = tty_termios_baud_rate(tty->termios);
-
-	if (baud == 38400 && tty->alt_speed) {
-		if (!tty->warned) {
-			printk(KERN_WARNING "Use of setserial/setrocket to "
-					    "set SPD_* flags is deprecated\n");
-			tty->warned = 1;
-		}
-		baud = tty->alt_speed;
-	}
-	
-	return baud;
-}
-
-EXPORT_SYMBOL(tty_get_baud_rate);
 
 /**
  *	tty_flip_buffer_push	-	terminal
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/tty_ioctl.c linux-2.6.18-rc4-mm2/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/tty_ioctl.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/tty_ioctl.c	2006-08-25 11:53:29.000000000 +0100
@@ -36,6 +36,7 @@
 #define TERMIOS_FLUSH	1
 #define TERMIOS_WAIT	2
 #define TERMIOS_TERMIO	4
+#define TERMIOS_OLD	8
 
 
 /**
@@ -107,6 +108,90 @@
 			old->c_cc[i] : termios->c_cc[i];
 }
 
+/*
+ * Routine which returns the baud rate of the tty
+ *
+ * Note that the baud_table needs to be kept in sync with the
+ * include/asm/termbits.h file.
+ */
+static const speed_t baud_table[] = {
+	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
+	9600, 19200, 38400, 57600, 115200, 230400, 460800,
+#ifdef __sparc__
+	76800, 153600, 307200, 614400, 921600
+#else
+	500000, 576000, 921600, 1000000, 1152000, 1500000, 2000000,
+	2500000, 3000000, 3500000, 4000000
+#endif
+};
+
+static int n_baud_table = ARRAY_SIZE(baud_table);
+
+/**
+ *	tty_termios_baud_rate
+ *	@termios: termios structure
+ *
+ *	Convert termios baud rate data into a speed. This should be called
+ *	with the termios lock held if this termios is a terminal termios
+ *	structure. May change the termios data.
+ *
+ *	Directional speed is not yet supported.
+ *
+ *	Locking: none
+ */
+ 
+speed_t tty_termios_baud_rate(struct termios *termios)
+{
+	unsigned int cbaud;
+	
+	cbaud = termios->c_cflag & CBAUD;
+
+	/* Magic token for arbitary speed via c_ispeed/c_ospeed */	
+	if (cbaud == BOTHER)
+		return termios->c_ospeed;
+
+	if (cbaud & CBAUDEX) {
+		cbaud &= ~CBAUDEX;
+
+		if (cbaud < 1 || cbaud + 15 > n_baud_table)
+			termios->c_cflag &= ~CBAUDEX;
+		else
+			cbaud += 15;
+	}
+	return baud_table[cbaud];
+}
+
+EXPORT_SYMBOL(tty_termios_baud_rate);
+
+/**
+ *	tty_get_baud_rate	-	get tty bit rates
+ *	@tty: tty to query
+ *
+ *	Returns the baud rate as an integer for this terminal. The
+ *	termios lock must be held by the caller and the terminal bit
+ *	flags may be updated.
+ *
+ *	Locking: none
+ */
+ 
+speed_t tty_get_baud_rate(struct tty_struct *tty)
+{
+	speed_t baud = tty_termios_baud_rate(tty->termios);
+
+	if (baud == 38400 && tty->alt_speed) {
+		if (!tty->warned) {
+			printk(KERN_WARNING "Use of setserial/setrocket to "
+					    "set SPD_* flags is deprecated\n");
+			tty->warned = 1;
+		}
+		baud = tty->alt_speed;
+	}
+	
+	return baud;
+}
+
+EXPORT_SYMBOL(tty_get_baud_rate);
+
 /**
  *	change_termios		-	update termios values
  *	@tty: tty to update
@@ -207,10 +292,20 @@
 		if (user_termio_to_kernel_termios(&tmp_termios,
 						(struct termio __user *)arg))
 			return -EFAULT;
+		tmp_termios.c_ispeed = tmp_termios.c_ospeed = tty_termios_baud_rate(&tmp_termios);
+	} else if (opt & TERMIOS_OLD) {
+		memcpy(&tmp_termios, tty->termios, sizeof(struct termios));
+		if (user_termios_to_kernel_termios_1(&tmp_termios,
+						(struct termios __user *)arg))
+			return -EFAULT;
+		tmp_termios.c_ispeed = tmp_termios.c_ospeed = tty_termios_baud_rate(&tmp_termios);
 	} else {
 		if (user_termios_to_kernel_termios(&tmp_termios,
 						(struct termios __user *)arg))
 			return -EFAULT;
+		/* If old style Bfoo values are used then load c_ispeed/c_ospeed with the real speed
+		   so its unconditionally usable */
+		tmp_termios.c_ispeed = tmp_termios.c_ospeed = tty_termios_baud_rate(&tmp_termios);
 	}
 
 	ld = tty_ldisc_ref(tty);
@@ -286,8 +381,8 @@
 	struct sgttyb tmp;
 
 	mutex_lock(&tty->termios_mutex);
-	tmp.sg_ispeed = 0;
-	tmp.sg_ospeed = 0;
+	tmp.sg_ispeed = tty_get_baud_rate(tty);
+	tmp.sg_ospeed = tty_get_baud_rate(tty);
 	tmp.sg_erase = tty->termios->c_cc[VERASE];
 	tmp.sg_kill = tty->termios->c_cc[VKILL];
 	tmp.sg_flags = get_sgflags(tty);
@@ -351,6 +446,11 @@
 	termios.c_cc[VERASE] = tmp.sg_erase;
 	termios.c_cc[VKILL] = tmp.sg_kill;
 	set_sgflags(&termios, tmp.sg_flags);
+	
+	termios.c_ispeed = sgttyb->sg_ispeed;
+	termios.c_ospeed = sgttyb->sg_ospeed;
+	termios.c_cflags &= ~CBAUD;
+	termios.c_cflags |= BOTHER;
 	mutex_unlock(&tty->termios_mutex);
 	change_termios(tty, &termios);
 	return 0;
@@ -423,24 +523,28 @@
  *
  *	Send a high priority character to the tty even if stopped
  *
- *	Locking: none
- *
- *	FIXME: overlapping calls with start/stop tty lose state of tty
+ *	Locking: none for xchar method, write ordering for write method.
  */
 
-static void send_prio_char(struct tty_struct *tty, char ch)
+static int send_prio_char(struct tty_struct *tty, char ch)
 {
 	int	was_stopped = tty->stopped;
 
 	if (tty->driver->send_xchar) {
 		tty->driver->send_xchar(tty, ch);
-		return;
+		return 0;
 	}
+	
+	if (mutex_lock_interruptible(&tty->atomic_write_lock))
+		return -ERESTARTSYS;
+		
 	if (was_stopped)
 		start_tty(tty);
 	tty->driver->write(tty, &ch, 1);
 	if (was_stopped)
 		stop_tty(tty);
+	mutex_unlock(&tty->atomic_write_lock);
+	return 0;
 }
 
 int n_tty_ioctl(struct tty_struct * tty, struct file * file,
@@ -478,14 +582,24 @@
 			return set_ltchars(real_tty, p);
 #endif
 		case TCGETS:
-			if (kernel_termios_to_user_termios((struct termios __user *)arg, real_tty->termios))
+			if (kernel_termios_to_user_termios_1((struct termios __user *)arg, real_tty->termios))
 				return -EFAULT;
 			return 0;
 		case TCSETSF:
-			return set_termios(real_tty, p,  TERMIOS_FLUSH | TERMIOS_WAIT);
+			return set_termios(real_tty, p,  TERMIOS_FLUSH | TERMIOS_WAIT | TERMIOS_OLD);
 		case TCSETSW:
-			return set_termios(real_tty, p, TERMIOS_WAIT);
+			return set_termios(real_tty, p, TERMIOS_WAIT | TERMIOS_OLD);
 		case TCSETS:
+			return set_termios(real_tty, p, TERMIOS_OLD);
+		case TCGETS2:
+			if (kernel_termios_to_user_termios((struct termios __user *)arg, real_tty->termios))
+				return -EFAULT;
+			return 0;
+		case TCSETSF2:
+			return set_termios(real_tty, p,  TERMIOS_FLUSH | TERMIOS_WAIT);
+		case TCSETSW2:
+			return set_termios(real_tty, p, TERMIOS_WAIT);
+		case TCSETS2:
 			return set_termios(real_tty, p, 0);
 		case TCGETA:
 			return get_termio(real_tty, p);
@@ -514,11 +628,11 @@
 				break;
 			case TCIOFF:
 				if (STOP_CHAR(tty) != __DISABLED_CHAR)
-					send_prio_char(tty, STOP_CHAR(tty));
+					return send_prio_char(tty, STOP_CHAR(tty));
 				break;
 			case TCION:
 				if (START_CHAR(tty) != __DISABLED_CHAR)
-					send_prio_char(tty, START_CHAR(tty));
+					return send_prio_char(tty, START_CHAR(tty));
 				break;
 			default:
 				return -EINVAL;
@@ -574,6 +688,7 @@
 		{
 			int pktmode;
 
+			/* FIXME: audit tty->packet locking */
 			if (tty->driver->type != TTY_DRIVER_TYPE_PTY ||
 			    tty->driver->subtype != PTY_TYPE_MASTER)
 				return -ENOTTY;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/char/vme_scc.c linux-2.6.18-rc4-mm2/drivers/char/vme_scc.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/char/vme_scc.c	2006-08-21 14:18:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/char/vme_scc.c	2006-08-25 14:50:20.000000000 +0100
@@ -153,6 +153,8 @@
 	scc_driver->init_termios = tty_std_termios;
 	scc_driver->init_termios.c_cflag =
 	  B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	scc_driver->init_termios.c_ispeed = 9600;
+	scc_driver->init_termios.c_ospeed = 9600;
 	scc_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(scc_driver, &scc_ops);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/serial/crisv10.c linux-2.6.18-rc4-mm2/drivers/serial/crisv10.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/serial/crisv10.c	2006-08-21 14:18:54.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/serial/crisv10.c	2006-08-25 13:58:48.000000000 +0100
@@ -4877,6 +4877,8 @@
 	driver->init_termios = tty_std_termios;
 	driver->init_termios.c_cflag =
 		B115200 | CS8 | CREAD | HUPCL | CLOCAL; /* is normally B9600 default... */
+	driver->init_termios.c_ispeed = 115200;
+	driver->init_termios.c_ospeed = 115200;
 	driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	driver->termios = serial_termios;
 	driver->termios_locked = serial_termios_locked;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/drivers/serial/serial_core.c linux-2.6.18-rc4-mm2/drivers/serial/serial_core.c
--- linux.vanilla-2.6.18-rc4-mm2/drivers/serial/serial_core.c	2006-08-21 14:18:54.000000000 +0100
+++ linux-2.6.18-rc4-mm2/drivers/serial/serial_core.c	2006-08-25 14:10:53.000000000 +0100
@@ -2170,6 +2170,7 @@
 	normal->subtype		= SERIAL_TYPE_NORMAL;
 	normal->init_termios	= tty_std_termios;
 	normal->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	normal->init_termios.c_ispeed = normal->init_termios.c_ospeed = 9600;
 	normal->flags		= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	normal->driver_state    = drv;
 	tty_set_operations(normal, &uart_ops);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/ioctls.h linux-2.6.18-rc4-mm2/include/asm-i386/ioctls.h
--- linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/ioctls.h	2006-08-21 14:17:52.000000000 +0100
+++ linux-2.6.18-rc4-mm2/include/asm-i386/ioctls.h	2006-08-25 11:23:20.000000000 +0100
@@ -47,6 +47,12 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+
+#define TCGETS2		0x542A
+#define TCSETS2		0x542B
+#define TCSETSW2	0x542C
+#define TCSETSF2	0x542D
+
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/termbits.h linux-2.6.18-rc4-mm2/include/asm-i386/termbits.h
--- linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/termbits.h	2006-08-21 14:17:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/include/asm-i386/termbits.h	2006-08-25 11:21:16.000000000 +0100
@@ -8,6 +8,16 @@
 typedef unsigned int	tcflag_t;
 
 #define NCCS 19
+
+struct termios_v1 {			/* Deprecated termios */
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+};
+
 struct termios {
 	tcflag_t c_iflag;		/* input mode flags */
 	tcflag_t c_oflag;		/* output mode flags */
@@ -15,6 +25,8 @@
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
 	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
 };
 
 /* c_cc characters */
@@ -118,6 +130,7 @@
 #define HUPCL	0002000
 #define CLOCAL	0004000
 #define CBAUDEX 0010000
+#define	   BOTHER 0010000		/* non standard rate */
 #define    B57600 0010001
 #define   B115200 0010002
 #define   B230400 0010003
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/termios.h linux-2.6.18-rc4-mm2/include/asm-i386/termios.h
--- linux.vanilla-2.6.18-rc4-mm2/include/asm-i386/termios.h	2006-08-21 14:17:53.000000000 +0100
+++ linux-2.6.18-rc4-mm2/include/asm-i386/termios.h	2006-08-25 11:29:34.000000000 +0100
@@ -99,6 +99,8 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios_1))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios_1))
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/asm-x86_64/ioctls.h linux-2.6.18-rc4-mm2/include/asm-x86_64/ioctls.h
--- linux.vanilla-2.6.18-rc4-mm2/include/asm-x86_64/ioctls.h	2006-08-21 14:17:55.000000000 +0100
+++ linux-2.6.18-rc4-mm2/include/asm-x86_64/ioctls.h	2006-08-25 11:23:45.000000000 +0100
@@ -46,6 +46,12 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+
+#define TCGETS2		0x542A
+#define TCSETS2		0x542B
+#define TCSETSW2	0x542C
+#define TCSETSF2	0x542D
+
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/asm-x86_64/termbits.h linux-2.6.18-rc4-mm2/include/asm-x86_64/termbits.h
--- linux.vanilla-2.6.18-rc4-mm2/include/asm-x86_64/termbits.h	2006-08-21 14:17:55.000000000 +0100
+++ linux-2.6.18-rc4-mm2/include/asm-x86_64/termbits.h	2006-08-25 11:21:05.000000000 +0100
@@ -8,6 +8,15 @@
 typedef unsigned int	tcflag_t;
 
 #define NCCS 19
+struct termios_v1 {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+};
+
 struct termios {
 	tcflag_t c_iflag;		/* input mode flags */
 	tcflag_t c_oflag;		/* output mode flags */
@@ -15,8 +24,11 @@
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
 	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
 };
 
+
 /* c_cc characters */
 #define VINTR 0
 #define VQUIT 1
@@ -118,6 +130,7 @@
 #define HUPCL	0002000
 #define CLOCAL	0004000
 #define CBAUDEX 0010000
+#define	   BOTHER 0010000		/* non standard rate */
 #define    B57600 0010001
 #define   B115200 0010002
 #define   B230400 0010003
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/asm-x86_64/termios.h linux-2.6.18-rc4-mm2/include/asm-x86_64/termios.h
--- linux.vanilla-2.6.18-rc4-mm2/include/asm-x86_64/termios.h	2006-08-21 14:17:55.000000000 +0100
+++ linux-2.6.18-rc4-mm2/include/asm-x86_64/termios.h	2006-08-25 11:54:05.000000000 +0100
@@ -98,6 +98,8 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios_v1))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios_v1))
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm2/include/linux/tty.h linux-2.6.18-rc4-mm2/include/linux/tty.h
--- linux.vanilla-2.6.18-rc4-mm2/include/linux/tty.h	2006-08-21 14:18:57.000000000 +0100
+++ linux-2.6.18-rc4-mm2/include/linux/tty.h	2006-08-25 11:52:15.000000000 +0100
@@ -294,8 +294,8 @@
 extern void do_SAK(struct tty_struct *tty);
 extern void disassociate_ctty(int priv);
 extern void tty_flip_buffer_push(struct tty_struct *tty);
-extern int tty_get_baud_rate(struct tty_struct *tty);
-extern int tty_termios_baud_rate(struct termios *termios);
+extern speed_t tty_get_baud_rate(struct tty_struct *tty);
+extern speed_t tty_termios_baud_rate(struct termios *termios);
 
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);

