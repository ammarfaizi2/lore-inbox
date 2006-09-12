Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWILP60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWILP60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWILP6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:58:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54191 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030236AbWILP55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:57:57 -0400
Subject: [PATCH] serial: Fix up offenders peering at baud bits directly,
	corrected
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 17:21:15 +0100
Message-Id: <1158078075.6780.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop some other people peering into the baud bits on their own and make
them use the tty_get_baud_rate() helper as a preperation for the move to
the new termios. Corrected dependancy previous one had on new termios
structs

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/char/moxa.c linux-2.6.18-rc6-mm1/drivers/char/moxa.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/char/moxa.c	2006-09-11 17:00:09.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/char/moxa.c	2006-09-11 17:18:31.000000000 +0100
@@ -260,7 +260,7 @@
 static void MoxaPortDisable(int);
 static long MoxaPortGetMaxBaud(int);
 static long MoxaPortSetBaud(int, long);
-static int MoxaPortSetTermio(int, struct termios *);
+static int MoxaPortSetTermio(int, struct termios *, speed_t);
 static int MoxaPortGetLineOut(int, int *, int *);
 static void MoxaPortLineCtrl(int, int, int);
 static void MoxaPortFlowCtrl(int, int, int, int, int, int);
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/char/mxser.c linux-2.6.18-rc6-mm1/drivers/char/mxser.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/char/mxser.c	2006-09-11 17:00:09.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/char/mxser.c	2006-09-11 17:18:38.000000000 +0100
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
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/char/riscom8.c linux-2.6.18-rc6-mm1/drivers/char/riscom8.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/char/riscom8.c	2006-09-11 17:00:09.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/char/riscom8.c	2006-09-11 17:18:45.000000000 +0100
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

