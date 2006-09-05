Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965176AbWIEPwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWIEPwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 11:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWIEPwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 11:52:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20716 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965176AbWIEPv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 11:51:58 -0400
Subject: [PATCH RFC]: New termios take 2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Sep 2006 17:14:43 +0100
Message-Id: <1157472883.9018.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second revision of the improved termios facilities. 

The following extra features are now handled
- Architectures which already have i/ospeed fields and need no new ioctl
- Independent input and output baud rate
- Weirdo speed table for the sparc (Dave *has* to be different)
- Passes a basic test suite
- stty/gtty emulation now correctly handles speeds [it was a one liner
ok]

To make this work on your architecture you must have the following bit
fields defined

CIBAUD		Mask of input speed bits
IBSHIFT		Such that (CBAUD << IBSHIFT) is CIBAUD
		with the same bit meanings for both fields
BOTHER		An unused speed field setting

struct termios_v1 - the existing "old" termios structure
struct termios - the new exciting termios structure with
c_ispeed/c_ospeed. Should start matching the old structure.

user_termios_to_kernel_termios_v1
kernel_termios_to_user_termios_v1
		Copiers for the old termios structure

I intend to submit this to Andrew fairly soon so if you are an
architecture maintainer please provide me the defines for your platform
or I'll make some up and that might not be the best choice 8)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/epca.c linux-2.6.18-rc5-mm1/drivers/char/epca.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/epca.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/epca.c	2006-09-01 13:52:19.000000000 +0100
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
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/generic_serial.c linux-2.6.18-rc5-mm1/drivers/char/generic_serial.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/generic_serial.c	2006-08-30 18:27:18.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/generic_serial.c	2006-09-01 13:52:24.000000000 +0100
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/hvcs.c linux-2.6.18-rc5-mm1/drivers/char/hvcs.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/hvcs.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/hvcs.c	2006-09-01 13:52:32.000000000 +0100
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/hvsi.c linux-2.6.18-rc5-mm1/drivers/char/hvsi.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/hvsi.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/hvsi.c	2006-09-01 13:52:32.000000000 +0100
@@ -1159,6 +1159,8 @@
 	hvsi_driver->type = TTY_DRIVER_TYPE_SYSTEM;
 	hvsi_driver->init_termios = tty_std_termios;
 	hvsi_driver->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL;
+	hvsi_driver->init_termios.c_ispeed = 9600;
+	hvsi_driver->init_termios.c_ospeed = 9600;
 	hvsi_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(hvsi_driver, &hvsi_ops);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/istallion.c linux-2.6.18-rc5-mm1/drivers/char/istallion.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/istallion.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/istallion.c	2006-09-01 13:52:32.000000000 +0100
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/moxa.c linux-2.6.18-rc5-mm1/drivers/char/moxa.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/moxa.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/moxa.c	2006-09-01 13:52:32.000000000 +0100
@@ -260,7 +260,7 @@
 static void MoxaPortDisable(int);
 static long MoxaPortGetMaxBaud(int);
 static long MoxaPortSetBaud(int, long);
-static int MoxaPortSetTermio(int, struct termios *);
+static int MoxaPortSetTermio(int, struct termios *, speed_t);
 static int MoxaPortGetLineOut(int, int *, int *);
 static void MoxaPortLineCtrl(int, int, int);
 static void MoxaPortFlowCtrl(int, int, int, int, int, int);
@@ -351,6 +351,8 @@
 	moxaDriver->init_termios.c_oflag = 0;
 	moxaDriver->init_termios.c_cflag = B9600 | CS8 | CREAD | CLOCAL | HUPCL;
 	moxaDriver->init_termios.c_lflag = 0;
+	moxaDriver->init_termios.c_ispeed = 9600;
+	moxaDriver->init_termios.c_ospeed = 9600;
 	moxaDriver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(moxaDriver, &moxa_ops);
 
@@ -986,7 +988,7 @@
 	if (ts->c_iflag & IXANY)
 		xany = 1;
 	MoxaPortFlowCtrl(ch->port, rts, cts, txflow, rxflow, xany);
-	MoxaPortSetTermio(ch->port, ts);
+	MoxaPortSetTermio(ch->port, ts, tty_get_baud_rate(tty));
 }
 
 static int block_till_ready(struct tty_struct *tty, struct file *filp,
@@ -1900,9 +1902,10 @@
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
@@ -2182,11 +2185,10 @@
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
@@ -2221,78 +2223,10 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/mxser.c linux-2.6.18-rc5-mm1/drivers/char/mxser.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/mxser.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/mxser.c	2006-09-01 13:52:32.000000000 +0100
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
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/pty.c linux-2.6.18-rc5-mm1/drivers/char/pty.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/pty.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/pty.c	2006-09-01 13:52:32.000000000 +0100
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/riscom8.c linux-2.6.18-rc5-mm1/drivers/char/riscom8.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/riscom8.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/riscom8.c	2006-09-01 13:52:48.000000000 +0100
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/rocket.c linux-2.6.18-rc5-mm1/drivers/char/rocket.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/rocket.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/rocket.c	2006-09-01 13:52:48.000000000 +0100
@@ -2436,6 +2436,8 @@
 	rocket_driver->init_termios = tty_std_termios;
 	rocket_driver->init_termios.c_cflag =
 	    B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	rocket_driver->init_termios.c_ispeed = 9600;
+	rocket_driver->init_termios.c_ospeed = 9600;
 #ifdef ROCKET_SOFT_FLOW
 	rocket_driver->flags |= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/ser_a2232.c linux-2.6.18-rc5-mm1/drivers/char/ser_a2232.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/ser_a2232.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/ser_a2232.c	2006-09-01 13:52:48.000000000 +0100
@@ -695,6 +695,8 @@
 	a2232_driver->init_termios = tty_std_termios;
 	a2232_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	a2232_driver->init_termios.c_ispeed = 9600;
+	a2232_driver->init_termios.c_ospeed = 9600;
 	a2232_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(a2232_driver, &a2232_ops);
 	if ((error = tty_register_driver(a2232_driver))) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/specialix.c linux-2.6.18-rc5-mm1/drivers/char/specialix.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/specialix.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/specialix.c	2006-09-01 13:52:48.000000000 +0100
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
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/stallion.c linux-2.6.18-rc5-mm1/drivers/char/stallion.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/stallion.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/stallion.c	2006-09-01 13:52:48.000000000 +0100
@@ -146,6 +146,8 @@
 static struct termios		stl_deftermios = {
 	.c_cflag	= (B9600 | CS8 | CREAD | HUPCL | CLOCAL),
 	.c_cc		= INIT_C_CC,
+	.c_ispeed	= 9600,
+	.c_ospeed	= 9600,
 };
 
 /*
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/sx.c linux-2.6.18-rc5-mm1/drivers/char/sx.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/sx.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/sx.c	2006-09-01 13:52:48.000000000 +0100
@@ -2263,6 +2263,8 @@
 	sx_driver->init_termios = tty_std_termios;
 	sx_driver->init_termios.c_cflag =
 	  B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	sx_driver->init_termios.c_ispeed = 9600;
+	sx_driver->init_termios.c_ospeed = 9600;
 	sx_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(sx_driver, &sx_ops);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/synclink.c linux-2.6.18-rc5-mm1/drivers/char/synclink.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/synclink.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/synclink.c	2006-09-01 13:52:48.000000000 +0100
@@ -4404,6 +4404,8 @@
 	serial_driver->init_termios = tty_std_termios;
 	serial_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	serial_driver->init_termios.c_ispeed = 9600;
+	serial_driver->init_termios.c_ospeed = 9600;
 	serial_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(serial_driver, &mgsl_ops);
 	if ((rc = tty_register_driver(serial_driver)) < 0) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/synclink_gt.c linux-2.6.18-rc5-mm1/drivers/char/synclink_gt.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/synclink_gt.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/synclink_gt.c	2006-09-01 13:52:48.000000000 +0100
@@ -3537,6 +3537,8 @@
 	serial_driver->init_termios = tty_std_termios;
 	serial_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	serial_driver->init_termios.c_ispeed = 9600;
+	serial_driver->init_termios.c_ospeed = 9600;
 	serial_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(serial_driver, &ops);
 	if ((rc = tty_register_driver(serial_driver)) < 0) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/synclinkmp.c linux-2.6.18-rc5-mm1/drivers/char/synclinkmp.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/synclinkmp.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/synclinkmp.c	2006-09-01 13:52:48.000000000 +0100
@@ -4033,6 +4033,8 @@
 	serial_driver->init_termios = tty_std_termios;
 	serial_driver->init_termios.c_cflag =
 		B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	serial_driver->init_termios.c_ispeed = 9600;
+	serial_driver->init_termios.c_ospeed = 9600;
 	serial_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(serial_driver, &ops);
 	if ((rc = tty_register_driver(serial_driver)) < 0) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/tty_io.c linux-2.6.18-rc5-mm1/drivers/char/tty_io.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/tty_io.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/tty_io.c	2006-09-04 14:04:43.000000000 +0100
@@ -115,7 +115,9 @@
 	.c_cflag = B38400 | CS8 | CREAD | HUPCL,
 	.c_lflag = ISIG | ICANON | ECHO | ECHOE | ECHOK |
 		   ECHOCTL | ECHOKE | IEXTEN,
-	.c_cc = INIT_C_CC
+	.c_cc = INIT_C_CC,
+	.c_ispeed = 38400,
+	.c_ospeed = 38400
 };
 
 EXPORT_SYMBOL(tty_std_termios);
@@ -1251,6 +1253,22 @@
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
+	tty->termios->c_ispeed = tty_termios_input_baud_rate(tty->termios);
+	tty->termios->c_ospeed = tty_termios_baud_rate(tty->termios);
+	mutex_unlock(&tty->termios_mutex);
+}
 	
 /**
  *	do_tty_hangup		-	actual handler for hangup events
@@ -1338,11 +1356,7 @@
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
@@ -1649,8 +1663,10 @@
 	ssize_t ret = 0, written = 0;
 	unsigned int chunk;
 	
-	/* FIXME: O_NDELAY ... */
-	if (mutex_lock_interruptible(&tty->atomic_write_lock)) {
+	if (file->f_flags & O_NONBLOCK) {
+		if (!mutex_trylock(&tty->atomic_write_lock))
+			return -EWOULDBLOCK;
+	} else if (mutex_lock_interruptible(&tty->atomic_write_lock)) {
 		return -ERESTARTSYS;
 	}
 
@@ -1987,6 +2003,9 @@
 		*ltp_loc = ltp;
 	tty->termios = *tp_loc;
 	tty->termios_locked = *ltp_loc;
+	/* Compatibility until drivers always set this */
+	tty->termios->c_ispeed = tty_termios_input_baud_rate(tty->termios);
+	tty->termios->c_ospeed = tty_termios_baud_rate(tty->termios);
 	driver->refcount++;
 	tty->count++;
 
@@ -3213,14 +3232,16 @@
 			clear_bit(TTY_EXCLUSIVE, &tty->flags);
 			return 0;
 		case TIOCNOTTY:
-			/* FIXME: taks lock or tty_mutex ? */
+			/* FIXME: need to extend locking to avoid ->leader race I think */
 			if (current->signal->tty != tty)
 				return -ENOTTY;
 			if (current->signal->leader)
 				disassociate_ctty(0);
-			task_lock(current);
-			current->signal->tty = NULL;
-			task_unlock(current);
+			else {	/* Not a leader, just clear ->tty */
+				mutex_lock(&tty_mutex);
+				current->signal->tty = NULL;
+				mutex_unlock(&tty_mutex);
+			}
 			return 0;
 		case TIOCSCTTY:
 			return tiocsctty(tty, arg);
@@ -3240,7 +3261,8 @@
 			return tioclinux(tty, arg);
 #endif
 		/*
-		 * Break handling
+		 * Break handling: Serialization needs thought and POSIX
+		 * checking.
 		 */
 		case TIOCSBRK:	/* Turn break on, unconditionally */
 			tty->driver->break_ctl(tty, -1);
@@ -3453,83 +3475,6 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/tty_ioctl.c linux-2.6.18-rc5-mm1/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/tty_ioctl.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/tty_ioctl.c	2006-09-01 13:59:10.000000000 +0100
@@ -36,6 +36,7 @@
 #define TERMIOS_FLUSH	1
 #define TERMIOS_WAIT	2
 #define TERMIOS_TERMIO	4
+#define TERMIOS_OLD	8
 
 
 /**
@@ -105,8 +106,198 @@
 	for (i=0; i < NCCS; i++)
 		termios->c_cc[i] = locked->c_cc[i] ?
 			old->c_cc[i] : termios->c_cc[i];
+	/* FIXME: What should we do for i/ospeed */
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
+#ifndef __sparc__
+static const tcflag_t baud_bits[] = {
+	B0, B50, B75, B110, B134, B150, B200, B300, B600,
+	B1200, B1800, B2400, B4800, B9600, B19200, B38400,
+	B57600, B115200, B230400, B460800, B500000, B576000,
+	B921600, B1000000, B1152000, B1500000, B2000000, B2500000,
+	B3000000, B3500000, B4000000
+};
+#else
+static const tcflag_t baud_bits[] = {
+	B0, B50, B75, B110, B134, B150, B200, B300, B600,
+	B1200, B1800, B2400, B4800, B9600, B19200, B38400,
+	B57600, B115200, B230400, B460800, B76800, B153600,
+	B307200, B614400, B921600
+};
+#endif	
+
+static int n_baud_table = ARRAY_SIZE(baud_table);
+
+/**
+ *	tty_termios_baud_rate
+ *	@termios: termios structure
+ *
+ *	Convert termios baud rate data into a speed. This should be called
+ *	with the termios lock held if this termios is a terminal termios
+ *	structure. May change the termios data. Device drivers can call this
+ *	function but should use ->c_[io]speed directly as they are updated.
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
+ *	tty_termios_input_baud_rate
+ *	@termios: termios structure
+ *
+ *	Convert termios baud rate data into a speed. This should be called
+ *	with the termios lock held if this termios is a terminal termios
+ *	structure. May change the termios data. Device drivers can call this
+ *	function but should use ->c_[io]speed directly as they are updated.
+ *
+ *	Locking: none
+ */
+ 
+speed_t tty_termios_input_baud_rate(struct termios *termios)
+{
+	unsigned int cbaud;
+	
+	cbaud = (termios->c_cflag >> IBSHIFT) & CBAUD;
+	
+	if (cbaud == B0)
+		return tty_termios_baud_rate(termios);
+
+	/* Magic token for arbitary speed via c_ispeed*/
+	if (cbaud == BOTHER)
+		return termios->c_ispeed;
+
+	if (cbaud & CBAUDEX) {
+		cbaud &= ~CBAUDEX;
+
+		if (cbaud < 1 || cbaud + 15 > n_baud_table)
+			termios->c_cflag &= ~(CBAUDEX << IBSHIFT);
+		else
+			cbaud += 15;
+	}
+	return baud_table[cbaud];
+}
+
+EXPORT_SYMBOL(tty_termios_input_baud_rate);
+
+/**
+ *	tty_termios_encode_baud_rate
+ *	@termios: termios structure
+ *	@ispeed: input speed
+ *	@ospeed: output speed
+ *
+ *	Encode the speeds set into the passed termios structure. This is
+ *	used as a library helper for drivers os that they can report back
+ *	the actual speed selected when it differs from the speed requested
+ *
+ *	For now input and output speed must agree.
+ *
+ *	Locking: Caller should hold termios lock. This is already held
+ *	when calling this function from the driver termios handler.
+ */
+ 
+void tty_termios_encode_baud_rate(struct termios *termios, speed_t ibaud, speed_t obaud)
+{
+	int i = 0;
+	int ifound = 0, ofound = 0;
+		
+	termios->c_ispeed = ibaud;
+	termios->c_ospeed = obaud;
+
+	termios->c_cflag &= ~CBAUD;
+	/* Identical speed means no input encoding (ie B0 << IBSHIFT)*/
+	if (termios->c_ispeed == termios->c_ospeed)
+		ifound = 1;
+	
+	do {
+		if (obaud == baud_table[i]) {
+			termios->c_cflag |= baud_bits[i];
+			ofound = 1;
+			/* So that if ibaud == obaud we don't set it */
+			continue;
+		}
+		if (ibaud == baud_table[i]) {
+			termios->c_cflag |= (baud_bits[i] << IBSHIFT);
+			ifound = 1;
+		}
+	}
+	while(++i < n_baud_table);
+	
+	if (!ofound)
+		termios->c_cflag |= BOTHER;
+	if (!ifound)
+		termios->c_cflag |= (BOTHER << IBSHIFT);
+}
+ 
+EXPORT_SYMBOL_GPL(tty_termios_encode_baud_rate);
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
@@ -207,12 +398,24 @@
 		if (user_termio_to_kernel_termios(&tmp_termios,
 						(struct termio __user *)arg))
 			return -EFAULT;
+#ifdef TCGETS2		
+	} else if (opt & TERMIOS_OLD) {
+		memcpy(&tmp_termios, tty->termios, sizeof(struct termios));
+		if (user_termios_to_kernel_termios_1(&tmp_termios,
+						(struct termios_v1 __user *)arg))
+			return -EFAULT;
+#endif		
 	} else {
 		if (user_termios_to_kernel_termios(&tmp_termios,
 						(struct termios __user *)arg))
 			return -EFAULT;
 	}
 
+	/* If old style Bfoo values are used then load c_ispeed/c_ospeed with the real speed
+	   so its unconditionally usable */
+	tmp_termios.c_ispeed = tty_termios_input_baud_rate(&tmp_termios);
+	tmp_termios.c_ospeed = tty_termios_baud_rate(&tmp_termios);
+
 	ld = tty_ldisc_ref(tty);
 	
 	if (ld != NULL) {
@@ -286,8 +489,8 @@
 	struct sgttyb tmp;
 
 	mutex_lock(&tty->termios_mutex);
-	tmp.sg_ispeed = 0;
-	tmp.sg_ospeed = 0;
+	tmp.sg_ispeed = tty->c_ispeed;
+	tmp.sg_ospeed = tty->c_ospeed;
 	tmp.sg_erase = tty->termios->c_cc[VERASE];
 	tmp.sg_kill = tty->termios->c_cc[VKILL];
 	tmp.sg_flags = get_sgflags(tty);
@@ -351,6 +554,8 @@
 	termios.c_cc[VERASE] = tmp.sg_erase;
 	termios.c_cc[VKILL] = tmp.sg_kill;
 	set_sgflags(&termios, tmp.sg_flags);
+	/* Try and encode into Bfoo format */	
+	tty_termios_encode_baud_rate(&termios, termios.c_ispeed, termios.c_ospeed);
 	mutex_unlock(&tty->termios_mutex);
 	change_termios(tty, &termios);
 	return 0;
@@ -423,24 +628,28 @@
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
@@ -477,16 +686,33 @@
 		case TIOCSLTC:
 			return set_ltchars(real_tty, p);
 #endif
+		case TCSETSF:
+			return set_termios(real_tty, p,  TERMIOS_FLUSH | TERMIOS_WAIT | TERMIOS_OLD);
+		case TCSETSW:
+			return set_termios(real_tty, p, TERMIOS_WAIT | TERMIOS_OLD);
+		case TCSETS:
+			return set_termios(real_tty, p, TERMIOS_OLD);
+#ifndef TCGETS2
+		case TCGETS:
+			if (kernel_termios_to_user_termios_1((struct termios __user *)arg, real_tty->termios))
+				return -EFAULT;
+			return 0;
+#else
 		case TCGETS:
+			if (kernel_termios_to_user_termios_1((struct termios_v1 __user *)arg, real_tty->termios))
+				return -EFAULT;
+			return 0;
+		case TCGETS2:
 			if (kernel_termios_to_user_termios((struct termios __user *)arg, real_tty->termios))
 				return -EFAULT;
 			return 0;
-		case TCSETSF:
+		case TCSETSF2:
 			return set_termios(real_tty, p,  TERMIOS_FLUSH | TERMIOS_WAIT);
-		case TCSETSW:
+		case TCSETSW2:
 			return set_termios(real_tty, p, TERMIOS_WAIT);
-		case TCSETS:
+		case TCSETS2:
 			return set_termios(real_tty, p, 0);
+#endif			
 		case TCGETA:
 			return get_termio(real_tty, p);
 		case TCSETAF:
@@ -514,11 +740,11 @@
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
@@ -574,6 +800,7 @@
 		{
 			int pktmode;
 
+			/* FIXME: audit tty->packet locking */
 			if (tty->driver->type != TTY_DRIVER_TYPE_PTY ||
 			    tty->driver->subtype != PTY_TYPE_MASTER)
 				return -ENOTTY;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/char/vme_scc.c linux-2.6.18-rc5-mm1/drivers/char/vme_scc.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/char/vme_scc.c	2006-09-01 13:39:04.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/char/vme_scc.c	2006-09-01 13:52:57.000000000 +0100
@@ -153,6 +153,8 @@
 	scc_driver->init_termios = tty_std_termios;
 	scc_driver->init_termios.c_cflag =
 	  B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	scc_driver->init_termios.c_ispeed = 9600;
+	scc_driver->init_termios.c_ospeed = 9600;
 	scc_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(scc_driver, &scc_ops);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/serial/crisv10.c linux-2.6.18-rc5-mm1/drivers/serial/crisv10.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/serial/crisv10.c	2006-09-01 13:39:13.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/serial/crisv10.c	2006-09-01 13:54:06.000000000 +0100
@@ -4877,6 +4877,8 @@
 	driver->init_termios = tty_std_termios;
 	driver->init_termios.c_cflag =
 		B115200 | CS8 | CREAD | HUPCL | CLOCAL; /* is normally B9600 default... */
+	driver->init_termios.c_ispeed = 115200;
+	driver->init_termios.c_ospeed = 115200;
 	driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	driver->termios = serial_termios;
 	driver->termios_locked = serial_termios_locked;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/drivers/serial/serial_core.c linux-2.6.18-rc5-mm1/drivers/serial/serial_core.c
--- linux.vanilla-2.6.18-rc5-mm1/drivers/serial/serial_core.c	2006-09-01 13:39:13.000000000 +0100
+++ linux-2.6.18-rc5-mm1/drivers/serial/serial_core.c	2006-09-01 13:54:06.000000000 +0100
@@ -2184,6 +2184,7 @@
 	normal->subtype		= SERIAL_TYPE_NORMAL;
 	normal->init_termios	= tty_std_termios;
 	normal->init_termios.c_cflag = B9600 | CS8 | CREAD | HUPCL | CLOCAL;
+	normal->init_termios.c_ispeed = normal->init_termios.c_ospeed = 9600;
 	normal->flags		= TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
 	normal->driver_state    = drv;
 	tty_set_operations(normal, &uart_ops);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-alpha/termbits.h linux-2.6.18-rc5-mm1/include/asm-alpha/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-alpha/termbits.h	2006-08-30 18:27:49.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-alpha/termbits.h	2006-09-01 13:54:42.000000000 +0100
@@ -21,10 +21,15 @@
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_cc[NCCS];		/* control characters */
 	cc_t c_line;			/* line discipline (== c_cc[19]) */
+	/* These two are not used in the old termios support but are in the
+	   new termios and will be valid if speed is BOTHER (itself not valid
+	   in old termios */
 	speed_t c_ispeed;		/* input speed */
 	speed_t c_ospeed;		/* output speed */
 };
 
+#define _HAVE_NO_TERMIOS_COMPAT
+
 /* c_cc characters */
 #define VEOF 0
 #define VEOL 1
@@ -134,6 +139,7 @@
 #define B3000000  00034
 #define B3500000  00035
 #define B4000000  00036
+#define BOTHER    00037		/* Other baud rate via _ispeed/_ospeed */
 
 #define CSIZE	00001400
 #define   CS5	00000000
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-cris/ioctls.h linux-2.6.18-rc5-mm1/include/asm-cris/ioctls.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-cris/ioctls.h	2006-08-30 18:27:50.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-cris/ioctls.h	2006-09-01 13:54:42.000000000 +0100
@@ -48,6 +48,11 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TCGETS2		_IOR('T',0x2A, struct termios)
+#define TCSETS2		_IOW('T',0x2B, struct termios)
+#define TCSETSW2	_IOW('T',0x2C, struct termios)
+#define TCSETSF2	_IOW('T',0x2D, struct termios)
+
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-cris/termbits.h linux-2.6.18-rc5-mm1/include/asm-cris/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-cris/termbits.h	2006-08-30 18:27:50.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-cris/termbits.h	2006-09-01 13:54:42.000000000 +0100
@@ -10,6 +10,15 @@
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
@@ -17,6 +26,8 @@
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
 	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
 };
 
 /* c_cc characters */
@@ -144,6 +155,7 @@
 #define HUPCL	0002000
 #define CLOCAL	0004000
 #define CBAUDEX 0010000
+#define	 BOTHER  0010000		/* non standard rate */
 #define  B57600  0010001
 #define  B115200 0010002
 #define  B230400 0010003
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-cris/termios.h linux-2.6.18-rc5-mm1/include/asm-cris/termios.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-cris/termios.h	2006-08-30 18:27:50.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-cris/termios.h	2006-09-01 13:54:42.000000000 +0100
@@ -99,6 +99,8 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios_1))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios_1))
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-i386/ioctls.h linux-2.6.18-rc5-mm1/include/asm-i386/ioctls.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-i386/ioctls.h	2006-08-30 18:27:50.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-i386/ioctls.h	2006-09-01 13:54:42.000000000 +0100
@@ -47,6 +47,12 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+
+#define TCGETS2		_IOR('T',0x2A, struct termios)
+#define TCSETS2		_IOW('T',0x2B, struct termios)
+#define TCSETSW2	_IOW('T',0x2C, struct termios)
+#define TCSETSF2	_IOW('T',0x2D, struct termios)
+
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-i386/termbits.h linux-2.6.18-rc5-mm1/include/asm-i386/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-i386/termbits.h	2006-08-30 18:27:50.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-i386/termbits.h	2006-09-01 13:54:42.000000000 +0100
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
@@ -133,10 +146,12 @@
 #define  B3000000 0010015
 #define  B3500000 0010016
 #define  B4000000 0010017
-#define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CIBAUD	  002003600000	/* input baud rate */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
+#define IBSHIFT	  8		/* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define ISIG	0000001
 #define ICANON	0000002
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-i386/termios.h linux-2.6.18-rc5-mm1/include/asm-i386/termios.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-i386/termios.h	2006-08-30 18:27:50.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-i386/termios.h	2006-09-01 13:54:42.000000000 +0100
@@ -99,6 +99,8 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios_1))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios_1))
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-ia64/ioctls.h linux-2.6.18-rc5-mm1/include/asm-ia64/ioctls.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-ia64/ioctls.h	2006-08-30 18:27:50.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-ia64/ioctls.h	2006-09-01 13:54:42.000000000 +0100
@@ -53,6 +53,11 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TCGETS2		_IOR('T',0x2A, struct termios)
+#define TCSETS2		_IOW('T',0x2B, struct termios)
+#define TCSETSW2	_IOW('T',0x2C, struct termios)
+#define TCSETSF2	_IOW('T',0x2D, struct termios)
+
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-ia64/termbits.h linux-2.6.18-rc5-mm1/include/asm-ia64/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-ia64/termbits.h	2006-08-30 18:27:52.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-ia64/termbits.h	2006-09-01 13:54:42.000000000 +0100
@@ -17,6 +17,15 @@
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
@@ -24,6 +33,8 @@
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
 	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
 };
 
 /* c_cc characters */
@@ -127,6 +138,7 @@
 #define HUPCL	0002000
 #define CLOCAL	0004000
 #define CBAUDEX 0010000
+#define	   BOTHER 0010000		/* non standard rate */
 #define    B57600 0010001
 #define   B115200 0010002
 #define   B230400 0010003
@@ -146,6 +158,8 @@
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
+#define IBSHIFT	  8		/* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define ISIG	0000001
 #define ICANON	0000002
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-ia64/termios.h linux-2.6.18-rc5-mm1/include/asm-ia64/termios.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-ia64/termios.h	2006-08-30 18:27:52.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-ia64/termios.h	2006-09-01 13:54:42.000000000 +0100
@@ -105,6 +105,8 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC);	\
 })
 
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios_1))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios_1))
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-mips/ioctls.h linux-2.6.18-rc5-mm1/include/asm-mips/ioctls.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-mips/ioctls.h	2006-08-30 18:27:53.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-mips/ioctls.h	2006-09-01 13:54:42.000000000 +0100
@@ -102,4 +102,10 @@
 #define TIOCGHAYESESP	0x5493 /* Get Hayes ESP configuration */
 #define TIOCSHAYESESP	0x5494 /* Set Hayes ESP configuration */
 
+#define TCGETS2		_IOR('T',0x95, struct termios)
+#define TCSETS2		_IOW('T',0x96, struct termios)
+#define TCSETSW2	_IOW('T',0x97, struct termios)
+#define TCSETSF2	_IOW('T',0x98, struct termios)
+
+
 #endif /* __ASM_IOCTLS_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-mips/termbits.h linux-2.6.18-rc5-mm1/include/asm-mips/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-mips/termbits.h	2006-08-30 18:27:54.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-mips/termbits.h	2006-09-01 13:54:42.000000000 +0100
@@ -27,6 +27,15 @@
  * replacement for it in struct termio
  */
 #define NCCS	23
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
@@ -34,6 +43,8 @@
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
 	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
 };
 
 /* c_cc characters */
@@ -148,6 +159,7 @@
 #define HUPCL	0002000		/* Hang up on last close.  */
 #define CLOCAL	0004000		/* Ignore modem status lines.  */
 #define CBAUDEX 0010000
+#define	   BOTHER 0010000		/* non standard rate */
 #define    B57600 0010001
 #define   B115200 0010002
 #define   B230400 0010003
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-mips/termios.h linux-2.6.18-rc5-mm1/include/asm-mips/termios.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-mips/termios.h	2006-08-30 18:27:54.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-mips/termios.h	2006-09-01 13:54:42.000000000 +0100
@@ -140,6 +140,8 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios_1))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios_1))
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-parisc/ioctls.h linux-2.6.18-rc5-mm1/include/asm-parisc/ioctls.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-parisc/ioctls.h	2006-08-30 18:27:54.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-parisc/ioctls.h	2006-09-01 13:54:42.000000000 +0100
@@ -46,6 +46,12 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	_IOR('T', 20, int) /* Return the session ID of FD */
+
+#define TCGETS2		_IOR('T',0x2A, struct termios)
+#define TCSETS2		_IOW('T',0x2B, struct termios)
+#define TCSETSW2	_IOW('T',0x2C, struct termios)
+#define TCSETSF2	_IOW('T',0x2D, struct termios)
+
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-parisc/termbits.h linux-2.6.18-rc5-mm1/include/asm-parisc/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-parisc/termbits.h	2006-08-30 18:27:54.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-parisc/termbits.h	2006-09-01 13:54:42.000000000 +0100
@@ -8,6 +8,16 @@
 typedef unsigned int	tcflag_t;
 
 #define NCCS 19
+
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
@@ -15,6 +25,8 @@
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
 	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
 };
 
 /* c_cc characters */
@@ -119,6 +131,7 @@
 #define HUPCL   0002000
 #define CLOCAL  0004000
 #define CBAUDEX 0010000
+#define    BOTHER 0010000
 #define    B57600 0010001
 #define   B115200 0010002
 #define   B230400 0010003
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-parisc/termios.h linux-2.6.18-rc5-mm1/include/asm-parisc/termios.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-parisc/termios.h	2006-08-30 18:27:54.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-parisc/termios.h	2006-09-01 13:54:42.000000000 +0100
@@ -98,6 +98,8 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios_1))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios_1))
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-powerpc/termbits.h linux-2.6.18-rc5-mm1/include/asm-powerpc/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-powerpc/termbits.h	2006-08-30 18:27:54.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-powerpc/termbits.h	2006-09-01 13:54:42.000000000 +0100
@@ -139,6 +139,7 @@
 #define B3000000  00034
 #define B3500000  00035
 #define B4000000  00036
+#define BOTHER	  00037
 
 #define CSIZE	00001400
 #define   CS5	00000000
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc/ioctls.h linux-2.6.18-rc5-mm1/include/asm-sparc/ioctls.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc/ioctls.h	2006-08-30 18:27:55.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-sparc/ioctls.h	2006-09-01 13:54:42.000000000 +0100
@@ -11,10 +11,10 @@
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)
-#define TCGETS		_IOR('T', 8, struct termios)
-#define TCSETS		_IOW('T', 9, struct termios)
-#define TCSETSW		_IOW('T', 10, struct termios)
-#define TCSETSF		_IOW('T', 11, struct termios)
+#define TCGETS		_IOR('T', 8, struct termios_v1)
+#define TCSETS		_IOW('T', 9, struct termios_v1)
+#define TCSETSW		_IOW('T', 10, struct termios_v1)
+#define TCSETSF		_IOW('T', 11, struct termios_v1)
 
 /* Note that all the ioctls that are not available in Linux have a 
  * double underscore on the front to: a) avoid some programs to
@@ -99,6 +99,10 @@
 #define TIOCGSERIAL	0x541E
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
+#define TCGETS2		_IOR('T',0x2A, struct termios)
+#define TCSETS2		_IOW('T',0x2B, struct termios)
+#define TCSETSW2	_IOW('T',0x2C, struct termios)
+#define TCSETSF2	_IOW('T',0x2D, struct termios)
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc/termbits.h linux-2.6.18-rc5-mm1/include/asm-sparc/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc/termbits.h	2006-08-30 18:27:55.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-sparc/termbits.h	2006-09-01 13:54:42.000000000 +0100
@@ -17,20 +17,34 @@
 	unsigned char c_cc[NCC];	/* control characters */
 };
 
-#define NCCS 17
-struct termios {
+#define NCCS_V1 17
+struct termios_v1 {
 	tcflag_t c_iflag;		/* input mode flags */
 	tcflag_t c_oflag;		/* output mode flags */
 	tcflag_t c_cflag;		/* control mode flags */
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
+	cc_t c_cc[NCCS_V1];		/* control characters */
+/* We need this old compat _x_cc bits as its used to compute the ioctl number */
 #ifdef __KERNEL__
-#define SIZEOF_USER_TERMIOS sizeof (struct termios) - (2*sizeof (cc_t))
+// #define SIZEOF_USER_TERMIOS sizeof (struct termios) - (2*sizeof (cc_t))
 	cc_t _x_cc[2];                  /* We need them to hold vmin/vtime */
 #endif
 };
 
+#define NCCS 19
+
+struct termios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR    0
 #define VQUIT    1
@@ -147,6 +161,7 @@
 #define HUPCL	  0x00000400
 #define CLOCAL	  0x00000800
 #define CBAUDEX   0x00001000
+#define  BOTHER   0x00001000
 /* We'll never see these speeds with the Zilogs, but for completeness... */
 #define  B57600   0x00001001
 #define  B115200  0x00001002
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc/termios.h linux-2.6.18-rc5-mm1/include/asm-sparc/termios.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc/termios.h	2006-08-30 18:27:55.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-sparc/termios.h	2006-09-01 13:54:42.000000000 +0100
@@ -124,14 +124,14 @@
 	0; \
 })
 
-#define user_termios_to_kernel_termios(k, u) \
+#define user_termios_to_kernel_termios_v1(k, u) \
 ({ \
 	get_user((k)->c_iflag, &(u)->c_iflag); \
 	get_user((k)->c_oflag, &(u)->c_oflag); \
 	get_user((k)->c_cflag, &(u)->c_cflag); \
 	get_user((k)->c_lflag, &(u)->c_lflag); \
 	get_user((k)->c_line,  &(u)->c_line); \
-	copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
+	copy_from_user((k)->c_cc, (u)->c_cc, NCCS_V1); \
 	if((k)->c_lflag & ICANON) { \
 		get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
 		get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
@@ -142,14 +142,14 @@
 	0; \
 })
 
-#define kernel_termios_to_user_termios(u, k) \
+#define kernel_termios_to_user_termios_v1(u, k) \
 ({ \
 	put_user((k)->c_iflag, &(u)->c_iflag); \
 	put_user((k)->c_oflag, &(u)->c_oflag); \
 	put_user((k)->c_cflag, &(u)->c_cflag); \
 	put_user((k)->c_lflag, &(u)->c_lflag); \
 	put_user((k)->c_line, &(u)->c_line); \
-	copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
+	copy_to_user((u)->c_cc, (k)->c_cc, NCCS_V1); \
 	if(!((k)->c_lflag & ICANON)) { \
 		put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
 		put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
@@ -160,6 +160,9 @@
 	0; \
 })
 
+#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
+#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
+
 #endif	/* __KERNEL__ */
 
 #endif /* _SPARC_TERMIOS_H */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc64/ioctls.h linux-2.6.18-rc5-mm1/include/asm-sparc64/ioctls.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc64/ioctls.h	2006-08-30 18:27:55.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-sparc64/ioctls.h	2006-09-01 13:54:42.000000000 +0100
@@ -12,10 +12,10 @@
 #define TCSBRK		_IO('T', 5)
 #define TCXONC		_IO('T', 6)
 #define TCFLSH		_IO('T', 7)
-#define TCGETS		_IOR('T', 8, struct termios)
-#define TCSETS		_IOW('T', 9, struct termios)
-#define TCSETSW		_IOW('T', 10, struct termios)
-#define TCSETSF		_IOW('T', 11, struct termios)
+#define TCGETS		_IOR('T', 8, struct termios_v1)
+#define TCSETS		_IOW('T', 9, struct termios_v1)
+#define TCSETSW		_IOW('T', 10, struct termios_v1)
+#define TCSETSF		_IOW('T', 11, struct termios_v1)
 
 /* Note that all the ioctls that are not available in Linux have a 
  * double underscore on the front to: a) avoid some programs to
@@ -100,6 +100,10 @@
 #define TIOCGSERIAL	0x541E
 #define TIOCSSERIAL	0x541F
 #define TCSBRKP		0x5425
+#define TCGETS2		_IOR('T',0x2A, struct termios)
+#define TCSETS2		_IOW('T',0x2B, struct termios)
+#define TCSETSW2	_IOW('T',0x2C, struct termios)
+#define TCSETSF2	_IOW('T',0x2D, struct termios)
 #define TIOCSERCONFIG	0x5453
 #define TIOCSERGWILD	0x5454
 #define TIOCSERSWILD	0x5455
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc64/termbits.h linux-2.6.18-rc5-mm1/include/asm-sparc64/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc64/termbits.h	2006-08-30 18:27:55.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-sparc64/termbits.h	2006-09-01 13:54:42.000000000 +0100
@@ -19,20 +19,34 @@
 	unsigned char c_cc[NCC];	/* control characters */
 };
 
-#define NCCS 17
-struct termios {
+#define NCCS_v1 17
+struct termios_v1 {
 	tcflag_t c_iflag;		/* input mode flags */
 	tcflag_t c_oflag;		/* output mode flags */
 	tcflag_t c_cflag;		/* control mode flags */
 	tcflag_t c_lflag;		/* local mode flags */
 	cc_t c_line;			/* line discipline */
 	cc_t c_cc[NCCS];		/* control characters */
+/* We need this old compat _x_cc bits as its used to compute the ioctl number */
 #ifdef __KERNEL__
-#define SIZEOF_USER_TERMIOS sizeof (struct termios) - (2*sizeof (cc_t))
+//#define SIZEOF_USER_TERMIOS sizeof (struct termios) - (2*sizeof (cc_t))
 	cc_t _x_cc[2];                  /* We need them to hold vmin/vtime */
 #endif
 };
 
+#define NCCS 19
+
+struct termios {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 /* c_cc characters */
 #define VINTR    0
 #define VQUIT    1
@@ -149,6 +163,7 @@
 #define HUPCL	  0x00000400
 #define CLOCAL	  0x00000800
 #define CBAUDEX   0x00001000
+#define  BOTHER   0x00001000
 #define  B57600   0x00001001
 #define  B115200  0x00001002
 #define  B230400  0x00001003
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc64/termios.h linux-2.6.18-rc5-mm1/include/asm-sparc64/termios.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-sparc64/termios.h	2006-08-30 18:27:55.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-sparc64/termios.h	2006-09-01 13:54:42.000000000 +0100
@@ -133,7 +133,7 @@
 	err |= get_user((k)->c_cflag, &(u)->c_cflag); \
 	err |= get_user((k)->c_lflag, &(u)->c_lflag); \
 	err |= get_user((k)->c_line,  &(u)->c_line); \
-	err |= copy_from_user((k)->c_cc, (u)->c_cc, NCCS); \
+	err |= copy_from_user((k)->c_cc, (u)->c_cc, NCCS_V1); \
 	if((k)->c_lflag & ICANON) { \
 		err |= get_user((k)->c_cc[VEOF], &(u)->c_cc[VEOF]); \
 		err |= get_user((k)->c_cc[VEOL], &(u)->c_cc[VEOL]); \
@@ -152,7 +152,7 @@
 	err |= put_user((k)->c_cflag, &(u)->c_cflag); \
 	err |= put_user((k)->c_lflag, &(u)->c_lflag); \
 	err |= put_user((k)->c_line, &(u)->c_line); \
-	err |= copy_to_user((u)->c_cc, (k)->c_cc, NCCS); \
+	err |= copy_to_user((u)->c_cc, (k)->c_cc, NCCS_V1); \
 	if(!((k)->c_lflag & ICANON)) { \
 		err |= put_user((k)->c_cc[VMIN],  &(u)->c_cc[_VMIN]); \
 		err |= put_user((k)->c_cc[VTIME], &(u)->c_cc[_VTIME]); \
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-x86_64/ioctls.h linux-2.6.18-rc5-mm1/include/asm-x86_64/ioctls.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-x86_64/ioctls.h	2006-08-30 18:27:57.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-x86_64/ioctls.h	2006-09-01 13:54:56.000000000 +0100
@@ -46,6 +46,12 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+
+#define TCGETS2		_IOR('T',0x2A, struct termios)
+#define TCSETS2		_IOW('T',0x2B, struct termios)
+#define TCSETSW2	_IOW('T',0x2C, struct termios)
+#define TCSETSF2	_IOW('T',0x2D, struct termios)
+
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-x86_64/termbits.h linux-2.6.18-rc5-mm1/include/asm-x86_64/termbits.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-x86_64/termbits.h	2006-08-30 18:27:57.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-x86_64/termbits.h	2006-09-01 13:54:56.000000000 +0100
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
@@ -137,6 +150,8 @@
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
+#define IBSHIFT	  8		/* Shift from CBAUD to CIBAUD */
+
 /* c_lflag bits */
 #define ISIG	0000001
 #define ICANON	0000002
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/asm-x86_64/termios.h linux-2.6.18-rc5-mm1/include/asm-x86_64/termios.h
--- linux.vanilla-2.6.18-rc5-mm1/include/asm-x86_64/termios.h	2006-08-30 18:27:57.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/asm-x86_64/termios.h	2006-09-01 13:54:56.000000000 +0100
@@ -98,6 +98,8 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios_v1))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios_v1))
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/include/linux/tty.h linux-2.6.18-rc5-mm1/include/linux/tty.h
--- linux.vanilla-2.6.18-rc5-mm1/include/linux/tty.h	2006-09-01 13:39:20.000000000 +0100
+++ linux-2.6.18-rc5-mm1/include/linux/tty.h	2006-09-01 13:55:39.000000000 +0100
@@ -294,8 +294,9 @@
 extern void do_SAK(struct tty_struct *tty);
 extern void disassociate_ctty(int priv);
 extern void tty_flip_buffer_push(struct tty_struct *tty);
-extern int tty_get_baud_rate(struct tty_struct *tty);
-extern int tty_termios_baud_rate(struct termios *termios);
+extern speed_t tty_get_baud_rate(struct tty_struct *tty);
+extern speed_t tty_termios_baud_rate(struct termios *termios);
+extern speed_t tty_termios_input_baud_rate(struct termios *termios);
 
 extern struct tty_ldisc *tty_ldisc_ref(struct tty_struct *);
 extern void tty_ldisc_deref(struct tty_ldisc *);

