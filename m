Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758661AbWK1NU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758661AbWK1NU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 08:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758662AbWK1NU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 08:20:56 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:61956 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1758661AbWK1NUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 08:20:54 -0500
Date: Tue, 28 Nov 2006 13:20:45 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Thiemo Seufer <ths@networkno.de>
cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.18] dz: Fixes to make it work
In-Reply-To: <20061124151205.GA927@networkno.de>
Message-ID: <Pine.LNX.4.64N.0611281304450.9362@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0611241420500.20948@blysk.ds.pg.gda.pl>
 <20061124151205.GA927@networkno.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This a set of fixes mostly to make the driver actually work:

1. Actually select the line for setting parameters and receiver
   disable/enable.
2. Select the line for receive and transmit interrupt handling correctly.
3. Report the transmitter empty state correctly.
4. Set the I/O type of ports correctly.
5. Perform polled transmission correctly.
6. Don't fix the console line at ttyS3.
7. Magic SysRq support.
8. Various small bits here and there.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
On Fri, 24 Nov 2006, Thiemo Seufer wrote:

> > @@ -46,23 +38,11 @@ extern void dz_serial_console_init(void)
> >  
> >  int __init rs_init(void)
> >  {
> > -
> > -#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
> > +#ifdef ONFIG_ZS
>           ^
> Minor typo. :-)

 Thanks for spotting it.

 Tested with a DECstation 2100 (thanks Flo for making this possible) and a 
DECstation 5000/200 (thanks Karel).

 Please apply.

  Maciej

patch-2.6.18-dz-14
diff -up --recursive --new-file linux-2.6.18.macro/drivers/char/decserial.c linux-2.6.18/drivers/char/decserial.c
--- linux-2.6.18.macro/drivers/char/decserial.c	2006-09-20 03:42:06.000000000 +0000
+++ linux-2.6.18/drivers/char/decserial.c	2006-11-23 18:29:38.000000000 +0000
@@ -23,20 +23,12 @@
 extern int zs_init(void);
 #endif
 
-#ifdef CONFIG_DZ
-extern int dz_init(void);
-#endif
-
 #ifdef CONFIG_SERIAL_CONSOLE
 
 #ifdef CONFIG_ZS
 extern void zs_serial_console_init(void);
 #endif
 
-#ifdef CONFIG_DZ
-extern void dz_serial_console_init(void);
-#endif
-
 #endif
 
 /* rs_init - starts up the serial interface -
@@ -46,23 +38,11 @@ extern void dz_serial_console_init(void)
 
 int __init rs_init(void)
 {
-
-#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
+#ifdef CONFIG_ZS
     if (IOASIC)
 	return zs_init();
-    else
-	return dz_init();
-#else
-
-#ifdef CONFIG_ZS
-    return zs_init();
-#endif
-
-#ifdef CONFIG_DZ
-    return dz_init();
-#endif
-
 #endif
+    return -ENXIO;
 }
 
 __initcall(rs_init);
@@ -76,21 +56,9 @@ __initcall(rs_init);
  */
 static int __init decserial_console_init(void)
 {
-#if defined(CONFIG_ZS) && defined(CONFIG_DZ)
+#ifdef CONFIG_ZS
     if (IOASIC)
 	zs_serial_console_init();
-    else
-	dz_serial_console_init();
-#else
-
-#ifdef CONFIG_ZS
-    zs_serial_console_init();
-#endif
-
-#ifdef CONFIG_DZ
-    dz_serial_console_init();
-#endif
-
 #endif
     return 0;
 }
diff -up --recursive --new-file linux-2.6.18.macro/drivers/serial/dz.c linux-2.6.18/drivers/serial/dz.c
--- linux-2.6.18.macro/drivers/serial/dz.c	2006-09-20 03:42:06.000000000 +0000
+++ linux-2.6.18/drivers/serial/dz.c	2006-11-23 18:27:06.000000000 +0000
@@ -1,11 +1,13 @@
 /*
- * dz.c: Serial port driver for DECStations equiped
+ * dz.c: Serial port driver for DECstations equipped
  *       with the DZ chipset.
  *
  * Copyright (C) 1998 Olivier A. D. Lebaillif
  *
  * Email: olivier.lebaillif@ifrsys.com
  *
+ * Copyright (C) 2004, 2006  Maciej W. Rozycki
+ *
  * [31-AUG-98] triemer
  * Changed IRQ to use Harald's dec internals interrupts.h
  * removed base_addr code - moving address assignment to setup.c
@@ -26,10 +28,16 @@
 
 #undef DEBUG_DZ
 
+#if defined(CONFIG_SERIAL_DZ_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/console.h>
+#include <linux/sysrq.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
@@ -45,14 +53,10 @@
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-#define CONSOLE_LINE (3)	/* for definition of struct console */
-
 #include "dz.h"
 
-#define DZ_INTR_DEBUG 1
-
 static char *dz_name = "DECstation DZ serial driver version ";
-static char *dz_version = "1.02";
+static char *dz_version = "1.03";
 
 struct dz_port {
 	struct uart_port	port;
@@ -61,22 +65,6 @@ struct dz_port {
 
 static struct dz_port dz_ports[DZ_NB_PORT];
 
-#ifdef DEBUG_DZ
-/*
- * debugging code to send out chars via prom
- */
-static void debug_console(const char *s, int count)
-{
-	unsigned i;
-
-	for (i = 0; i < count; i++) {
-		if (*s == 10)
-			prom_printf("%c", 13);
-		prom_printf("%c", *s++);
-	}
-}
-#endif
-
 /*
  * ------------------------------------------------------------
  * dz_in () and dz_out ()
@@ -90,6 +78,7 @@ static inline unsigned short dz_in(struc
 {
 	volatile unsigned short *addr =
 		(volatile unsigned short *) (dport->port.membase + offset);
+
 	return *addr;
 }
 
@@ -98,6 +87,7 @@ static inline void dz_out(struct dz_port
 {
 	volatile unsigned short *addr =
 		(volatile unsigned short *) (dport->port.membase + offset);
+
 	*addr = value;
 }
 
@@ -144,7 +134,7 @@ static void dz_stop_rx(struct uart_port 
 
 	spin_lock_irqsave(&dport->port.lock, flags);
 	dport->cflag &= ~DZ_CREAD;
-	dz_out(dport, DZ_LPR, dport->cflag);
+	dz_out(dport, DZ_LPR, dport->cflag | dport->port.line);
 	spin_unlock_irqrestore(&dport->port.lock, flags);
 }
 
@@ -155,14 +145,14 @@ static void dz_enable_ms(struct uart_por
 
 /*
  * ------------------------------------------------------------
- * Here starts the interrupt handling routines.  All of the
- * following subroutines are declared as inline and are folded
- * into dz_interrupt.  They were separated out for readability's
- * sake.
  *
- * Note: rs_interrupt() is a "fast" interrupt, which means that it
+ * Here start the interrupt handling routines.  All of the following
+ * subroutines are declared as inline and are folded into
+ * dz_interrupt.  They were separated out for readability's sake.
+ *
+ * Note: dz_interrupt() is a "fast" interrupt, which means that it
  * runs with interrupts turned off.  People who may want to modify
- * rs_interrupt() should try to keep the interrupt handler as fast as
+ * dz_interrupt() should try to keep the interrupt handler as fast as
  * possible.  After you are done making modifications, it is not a bad
  * idea to do:
  *
@@ -180,92 +170,74 @@ static void dz_enable_ms(struct uart_por
  * This routine deals with inputs from any lines.
  * ------------------------------------------------------------
  */
-static inline void dz_receive_chars(struct dz_port *dport)
+static inline void dz_receive_chars(struct dz_port *dport_in,
+				    struct pt_regs *regs)
 {
+	struct dz_port *dport;
 	struct tty_struct *tty = NULL;
 	struct uart_icount *icount;
-	int ignore = 0;
-	unsigned short status, tmp;
+	int lines_rx[DZ_NB_PORT] = { [0 ... DZ_NB_PORT - 1] = 0 };
+	unsigned short status;
 	unsigned char ch, flag;
+	int i;
 
-	/* this code is going to be a problem...
-	   the call to tty_flip_buffer is going to need
-	   to be rethought...
-	 */
-	do {
-		status = dz_in(dport, DZ_RBUF);
-
-		/* punt so we don't get duplicate characters */
-		if (!(status & DZ_DVAL))
-			goto ignore_char;
-
+	while ((status = dz_in(dport_in, DZ_RBUF)) & DZ_DVAL) {
+		dport = &dz_ports[LINE(status)];
+		tty = dport->port.info->tty;	/* point to the proper dev */
 
-		ch = UCHAR(status);	/* grab the char */
-		flag = TTY_NORMAL;
+		ch = UCHAR(status);		/* grab the char */
 
-#if 0
-		if (info->is_console) {
-			if (ch == 0)
-				return;		/* it's a break ... */
-		}
-#endif
-
-		tty = dport->port.info->tty;/* now tty points to the proper dev */
 		icount = &dport->port.icount;
-
-		if (!tty)
-			break;
-
 		icount->rx++;
 
-		/* keep track of the statistics */
-		if (status & (DZ_OERR | DZ_FERR | DZ_PERR)) {
-			if (status & DZ_PERR)	/* parity error */
-				icount->parity++;
-			else if (status & DZ_FERR)	/* frame error */
-				icount->frame++;
-			if (status & DZ_OERR)	/* overrun error */
-				icount->overrun++;
-
-			/*  check to see if we should ignore the character
-			   and mask off conditions that should be ignored
+		flag = TTY_NORMAL;
+		if (status & DZ_FERR) {		/* frame error */
+			/*
+			 * There is no separate BREAK status bit, so
+			 * treat framing errors as BREAKs for Magic SysRq
+			 * and SAK; normally, otherwise.
 			 */
-
-			if (status & dport->port.ignore_status_mask) {
-				if (++ignore > 100)
-					break;
-				goto ignore_char;
-			}
-			/* mask off the error conditions we want to ignore */
-			tmp = status & dport->port.read_status_mask;
-
-			if (tmp & DZ_PERR) {
-				flag = TTY_PARITY;
-#ifdef DEBUG_DZ
-				debug_console("PERR\n", 5);
-#endif
-			} else if (tmp & DZ_FERR) {
+			if (uart_handle_break(&dport->port))
+				continue;
+			if (dport->port.flags & UPF_SAK)
+				flag = TTY_BREAK;
+			else
 				flag = TTY_FRAME;
-#ifdef DEBUG_DZ
-				debug_console("FERR\n", 5);
-#endif
-			}
-			if (tmp & DZ_OERR) {
-#ifdef DEBUG_DZ
-				debug_console("OERR\n", 5);
-#endif
-				tty_insert_flip_char(tty, ch, flag);
-				ch = 0;
-				flag = TTY_OVERRUN;
-			}
+		} else if (status & DZ_OERR)	/* overrun error */
+			flag = TTY_OVERRUN;
+		else if (status & DZ_PERR)	/* parity error */
+			flag = TTY_PARITY;
+
+		/* keep track of the statistics */
+		switch (flag) {
+		case TTY_FRAME:
+			icount->frame++;
+			break;
+		case TTY_PARITY:
+			icount->parity++;
+			break;
+		case TTY_OVERRUN:
+			icount->overrun++;
+			break;
+		case TTY_BREAK:
+			icount->brk++;
+			break;
+		default:
+			break;
 		}
-		tty_insert_flip_char(tty, ch, flag);
-	      ignore_char:
-			;
-	} while (status & DZ_DVAL);
 
-	if (tty)
-		tty_flip_buffer_push(tty);
+		if (uart_handle_sysrq_char(&dport->port, ch, regs))
+			continue;
+
+		if ((status & dport->port.ignore_status_mask) == 0) {
+			uart_insert_char(&dport->port,
+					 status, DZ_OERR, ch, flag);
+			lines_rx[LINE(status)] = 1;
+		}
+	}
+	for (i = 0; i < DZ_NB_PORT; i++)
+		if (lines_rx[i])
+			tty_flip_buffer_push(dz_ports[i].port.info->tty);
 }
 
 /*
@@ -275,26 +247,32 @@ static inline void dz_receive_chars(stru
  * This routine deals with outputs to any lines.
  * ------------------------------------------------------------
  */
-static inline void dz_transmit_chars(struct dz_port *dport)
+static inline void dz_transmit_chars(struct dz_port *dport_in)
 {
-	struct circ_buf *xmit = &dport->port.info->xmit;
+	struct dz_port *dport;
+	struct circ_buf *xmit;
+	unsigned short status;
 	unsigned char tmp;
 
-	if (dport->port.x_char) {	/* XON/XOFF chars */
+	status = dz_in(dport_in, DZ_CSR);
+	dport = &dz_ports[LINE(status)];
+	xmit = &dport->port.info->xmit;
+
+	if (dport->port.x_char) {		/* XON/XOFF chars */
 		dz_out(dport, DZ_TDR, dport->port.x_char);
 		dport->port.icount.tx++;
 		dport->port.x_char = 0;
 		return;
 	}
-	/* if nothing to do or stopped or hardware stopped */
+	/* If nothing to do or stopped or hardware stopped. */
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&dport->port)) {
 		dz_stop_tx(&dport->port);
 		return;
 	}
 
 	/*
-	 * if something to do ... (rember the dz has no output fifo so we go
-	 * one char at a time :-<
+	 * If something to do... (remember the dz has no output fifo,
+	 * so we go one char at a time) :-<
 	 */
 	tmp = xmit->buf[xmit->tail];
 	xmit->tail = (xmit->tail + 1) & (DZ_XMIT_SIZE - 1);
@@ -304,23 +282,29 @@ static inline void dz_transmit_chars(str
 	if (uart_circ_chars_pending(xmit) < DZ_WAKEUP_CHARS)
 		uart_write_wakeup(&dport->port);
 
-	/* Are we done */
+	/* Are we are done. */
 	if (uart_circ_empty(xmit))
 		dz_stop_tx(&dport->port);
 }
 
 /*
  * ------------------------------------------------------------
- * check_modem_status ()
+ * check_modem_status()
  *
- * Only valid for the MODEM line duh !
+ * DS 3100 & 5100: Only valid for the MODEM line, duh!
+ * DS 5000/200: Valid for the MODEM and PRINTER line.
  * ------------------------------------------------------------
  */
 static inline void check_modem_status(struct dz_port *dport)
 {
+	/*
+	 * FIXME:
+	 * 1. No status change interrupt; use a timer.
+	 * 2. Handle the 3100/5000 as appropriate. --macro
+	 */
 	unsigned short status;
 
-	/* if not ne modem line just return */
+	/* If not the modem line just return.  */
 	if (dport->port.line != DZ_MODEM)
 		return;
 
@@ -341,21 +325,18 @@ static inline void check_modem_status(st
  */
 static irqreturn_t dz_interrupt(int irq, void *dev, struct pt_regs *regs)
 {
-	struct dz_port *dport;
+	struct dz_port *dport = (struct dz_port *)dev;
 	unsigned short status;
 
 	/* get the reason why we just got an irq */
-	status = dz_in((struct dz_port *)dev, DZ_CSR);
-	dport = &dz_ports[LINE(status)];
+	status = dz_in(dport, DZ_CSR);
 
-	if (status & DZ_RDONE)
-		dz_receive_chars(dport);
+	if ((status & (DZ_RDONE | DZ_RIE)) == (DZ_RDONE | DZ_RIE))
+		dz_receive_chars(dport, regs);
 
-	if (status & DZ_TRDY)
+	if ((status & (DZ_TRDY | DZ_TIE)) == (DZ_TRDY | DZ_TIE))
 		dz_transmit_chars(dport);
 
-	/* FIXME: what about check modem status??? --rmk */
-
 	return IRQ_HANDLED;
 }
 
@@ -367,13 +348,13 @@ static irqreturn_t dz_interrupt(int irq,
 
 static unsigned int dz_get_mctrl(struct uart_port *uport)
 {
+	/*
+	 * FIXME: Handle the 3100/5000 as appropriate. --macro
+	 */
 	struct dz_port *dport = (struct dz_port *)uport;
 	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
 
 	if (dport->port.line == DZ_MODEM) {
-		/*
-		 * CHECKME: This is a guess from the other code... --rmk
-		 */
 		if (dz_in(dport, DZ_MSR) & DZ_MODEM_DSR)
 			mctrl &= ~TIOCM_DSR;
 	}
@@ -383,6 +364,9 @@ static unsigned int dz_get_mctrl(struct 
 
 static void dz_set_mctrl(struct uart_port *uport, unsigned int mctrl)
 {
+	/*
+	 * FIXME: Handle the 3100/5000 as appropriate. --macro
+	 */
 	struct dz_port *dport = (struct dz_port *)uport;
 	unsigned short tmp;
 
@@ -409,13 +393,6 @@ static int dz_startup(struct uart_port *
 	unsigned long flags;
 	unsigned short tmp;
 
-	/* The dz lines for the mouse/keyboard must be
-	 * opened using their respective drivers.
-	 */
-	if ((dport->port.line == DZ_KEYBOARD) ||
-	    (dport->port.line == DZ_MOUSE))
-		return -ENODEV;
-
 	spin_lock_irqsave(&dport->port.lock, flags);
 
 	/* enable the interrupt and the scanning */
@@ -442,7 +419,8 @@ static void dz_shutdown(struct uart_port
 }
 
 /*
- * get_lsr_info - get line status register info
+ * -------------------------------------------------------------------
+ * dz_tx_empty() -- get the transmitter empty status
  *
  * Purpose: Let user call ioctl() to get info when the UART physically
  *          is emptied.  On bus types like RS485, the transmitter must
@@ -450,21 +428,28 @@ static void dz_shutdown(struct uart_port
  *          the transmit shift register is empty, not be done when the
  *          transmit holding register is empty.  This functionality
  *          allows an RS485 driver to be written in user space.
+ * -------------------------------------------------------------------
  */
 static unsigned int dz_tx_empty(struct uart_port *uport)
 {
 	struct dz_port *dport = (struct dz_port *)uport;
-	unsigned short status = dz_in(dport, DZ_LPR);
+	unsigned short tmp, mask = 1 << dport->port.line;
 
-	/* FIXME: this appears to be obviously broken --rmk. */
-	return status ? TIOCSER_TEMT : 0;
+	tmp = dz_in(dport, DZ_TCR);
+	tmp &= mask;
+
+	return tmp ? 0 : TIOCSER_TEMT;
 }
 
 static void dz_break_ctl(struct uart_port *uport, int break_state)
 {
+	/*
+	 * FIXME: Can't access BREAK bits in TDR easily;
+	 * reuse the code for polled TX. --macro
+	 */
 	struct dz_port *dport = (struct dz_port *)uport;
 	unsigned long flags;
-	unsigned short tmp, mask = 1 << uport->line;
+	unsigned short tmp, mask = 1 << dport->port.line;
 
 	spin_lock_irqsave(&uport->lock, flags);
 	tmp = dz_in(dport, DZ_TCR);
@@ -561,7 +546,7 @@ static void dz_set_termios(struct uart_p
 
 	spin_lock_irqsave(&dport->port.lock, flags);
 
-	dz_out(dport, DZ_LPR, cflag);
+	dz_out(dport, DZ_LPR, cflag | dport->port.line);
 	dport->cflag = cflag;
 
 	/* setup accept flag */
@@ -650,7 +635,7 @@ static void __init dz_init_ports(void)
 	for (i = 0, dport = dz_ports; i < DZ_NB_PORT; i++, dport++) {
 		spin_lock_init(&dport->port.lock);
 		dport->port.membase	= (char *) base;
-		dport->port.iotype	= UPIO_PORT;
+		dport->port.iotype	= UPIO_MEM;
 		dport->port.irq		= dec_interrupt[DEC_IRQ_DZ11];
 		dport->port.line	= i;
 		dport->port.fifosize	= 1;
@@ -662,10 +647,7 @@ static void __init dz_init_ports(void)
 static void dz_reset(struct dz_port *dport)
 {
 	dz_out(dport, DZ_CSR, DZ_CLR);
-
 	while (dz_in(dport, DZ_CSR) & DZ_CLR);
-		/* FIXME: cpu_relax? */
-
 	iob();
 
 	/* enable scanning */
@@ -673,26 +655,55 @@ static void dz_reset(struct dz_port *dpo
 }
 
 #ifdef CONFIG_SERIAL_DZ_CONSOLE
+/*
+ * -------------------------------------------------------------------
+ * dz_console_putchar() -- transmit a character
+ *
+ * Polled trasmission.  This is tricky.  We need to mask transmit
+ * interrupts so that they do not interfere, enable the transmitter
+ * for the line requested and then wait till the transmit scanner
+ * requests data for this line.  But it may request data for another
+ * line first, in which case we have to disable its transmitter and
+ * repeat waiting till our line pops up.  Only then the character may
+ * be transmitted.  Finally, the state of the transmitter mask is
+ * restored.  Welcome to the world of PDP-11!
+ * -------------------------------------------------------------------
+ */
 static void dz_console_putchar(struct uart_port *uport, int ch)
 {
 	struct dz_port *dport = (struct dz_port *)uport;
 	unsigned long flags;
-	int loops = 2500;
-	unsigned short tmp = (unsigned char)ch;
-	/* this code sends stuff out to serial device - spinning its
-	   wheels and waiting. */
+	unsigned short csr, tcr, trdy, mask;
+	int loops = 10000;
 
 	spin_lock_irqsave(&dport->port.lock, flags);
+	csr = dz_in(dport, DZ_CSR);
+	dz_out(dport, DZ_CSR, csr & ~DZ_TIE);
+	tcr = dz_in(dport, DZ_TCR);
+	tcr |= 1 << dport->port.line;
+	mask = tcr;
+	dz_out(dport, DZ_TCR, mask);
+	iob();
+	spin_unlock_irqrestore(&dport->port.lock, flags);
 
-	/* spin our wheels */
-	while (((dz_in(dport, DZ_CSR) & DZ_TRDY) != DZ_TRDY) && loops--)
-		/* FIXME: cpu_relax, udelay? --rmk */
-		;
+	while (loops--) {
+		trdy = dz_in(dport, DZ_CSR);
+		if (!(trdy & DZ_TRDY))
+			continue;
+		trdy = (trdy & DZ_TLINE) >> 8;
+		if (trdy == dport->port.line)
+			break;
+		mask &= ~(1 << trdy);
+		dz_out(dport, DZ_TCR, mask);
+		iob();
+		udelay(2);
+	}
 
-	/* Actually transmit the character. */
-	dz_out(dport, DZ_TDR, tmp);
+	if (loops)				/* Cannot send otherwise. */
+		dz_out(dport, DZ_TDR, ch);
 
-	spin_unlock_irqrestore(&dport->port.lock, flags);
+	dz_out(dport, DZ_TCR, tcr);
+	dz_out(dport, DZ_CSR, csr);
 }
 
 /*
@@ -703,11 +714,11 @@ static void dz_console_putchar(struct ua
  * The console must be locked when we get here.
  * -------------------------------------------------------------------
  */
-static void dz_console_print(struct console *cons,
+static void dz_console_print(struct console *co,
 			     const char *str,
 			     unsigned int count)
 {
-	struct dz_port *dport = &dz_ports[CONSOLE_LINE];
+	struct dz_port *dport = &dz_ports[co->index];
 #ifdef DEBUG_DZ
 	prom_printf((char *) str);
 #endif
@@ -716,49 +727,43 @@ static void dz_console_print(struct cons
 
 static int __init dz_console_setup(struct console *co, char *options)
 {
-	struct dz_port *dport = &dz_ports[CONSOLE_LINE];
+	struct dz_port *dport = &dz_ports[co->index];
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
-	int ret;
-	unsigned short mask, tmp;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
 	dz_reset(dport);
 
-	ret = uart_set_options(&dport->port, co, baud, parity, bits, flow);
-	if (ret == 0) {
-		mask = 1 << dport->port.line;
-		tmp = dz_in(dport, DZ_TCR);	/* read the TX flag */
-		if (!(tmp & mask)) {
-			tmp |= mask;		/* set the TX flag */
-			dz_out(dport, DZ_TCR, tmp);
-		}
-	}
-
-	return ret;
+	return uart_set_options(&dport->port, co, baud, parity, bits, flow);
 }
 
-static struct console dz_sercons =
-{
+static struct uart_driver dz_reg;
+static struct console dz_sercons = {
 	.name	= "ttyS",
 	.write	= dz_console_print,
 	.device	= uart_console_device,
 	.setup	= dz_console_setup,
-	.flags	= CON_CONSDEV | CON_PRINTBUFFER,
-	.index	= CONSOLE_LINE,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,
+	.data	= &dz_reg,
 };
 
-void __init dz_serial_console_init(void)
+static int __init dz_serial_console_init(void)
 {
-	dz_init_ports();
-
-	register_console(&dz_sercons);
+	if (!IOASIC) {
+		dz_init_ports();
+		register_console(&dz_sercons);
+		return 0;
+	} else
+		return -ENXIO;
 }
 
+console_initcall(dz_serial_console_init);
+
 #define SERIAL_DZ_CONSOLE	&dz_sercons
 #else
 #define SERIAL_DZ_CONSOLE	NULL
@@ -767,35 +772,29 @@ void __init dz_serial_console_init(void)
 static struct uart_driver dz_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-	.dev_name		= "ttyS%d",
+	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
 	.nr			= DZ_NB_PORT,
 	.cons			= SERIAL_DZ_CONSOLE,
 };
 
-int __init dz_init(void)
+static int __init dz_init(void)
 {
-	unsigned long flags;
 	int ret, i;
 
+	if (IOASIC)
+		return -ENXIO;
+
 	printk("%s%s\n", dz_name, dz_version);
 
 	dz_init_ports();
 
-	save_flags(flags);
-	cli();
-
 #ifndef CONFIG_SERIAL_DZ_CONSOLE
 	/* reset the chip */
 	dz_reset(&dz_ports[0]);
 #endif
 
-	/* order matters here... the trick is that flags
-	   is updated... in request_irq - to immediatedly obliterate
-	   it is unwise. */
-	restore_flags(flags);
-
 	if (request_irq(dz_ports[0].port.irq, dz_interrupt,
 			IRQF_DISABLED, "DZ", &dz_ports[0]))
 		panic("Unable to register DZ interrupt");
@@ -810,5 +809,7 @@ int __init dz_init(void)
 	return ret;
 }
 
+module_init(dz_init);
+
 MODULE_DESCRIPTION("DECstation DZ serial driver");
 MODULE_LICENSE("GPL");
diff -up --recursive --new-file linux-2.6.18.macro/drivers/serial/dz.h linux-2.6.18/drivers/serial/dz.h
--- linux-2.6.18.macro/drivers/serial/dz.h	2006-09-20 03:42:06.000000000 +0000
+++ linux-2.6.18/drivers/serial/dz.h	2006-11-23 18:27:06.000000000 +0000
@@ -1,20 +1,22 @@
 /*
- * dz.h: Serial port driver for DECStations equiped 
+ * dz.h: Serial port driver for DECstations equipped 
  *       with the DZ chipset.
  *
  * Copyright (C) 1998 Olivier A. D. Lebaillif 
  *             
  * Email: olivier.lebaillif@ifrsys.com
  *
+ * Copyright (C) 2004, 2006  Maciej W. Rozycki
  */
 #ifndef DZ_SERIAL_H
 #define DZ_SERIAL_H
 
 /*
- * Definitions for the Control and Status Received.
+ * Definitions for the Control and Status Register.
  */
 #define DZ_TRDY        0x8000                 /* Transmitter empty */
-#define DZ_TIE         0x4000                 /* Transmitter Interrupt Enable */
+#define DZ_TIE         0x4000                 /* Transmitter Interrupt Enbl */
+#define DZ_TLINE       0x0300                 /* Transmitter Line Number */
 #define DZ_RDONE       0x0080                 /* Receiver data ready */
 #define DZ_RIE         0x0040                 /* Receive Interrupt Enable */
 #define DZ_MSE         0x0020                 /* Master Scan Enable */
@@ -22,32 +24,44 @@
 #define DZ_MAINT       0x0008                 /* Loop Back Mode */
 
 /*
- * Definitions for the Received buffer. 
+ * Definitions for the Receiver Buffer Register. 
  */
-#define DZ_RBUF_MASK   0x00FF                 /* Data Mask in the Receive Buffer */
-#define DZ_LINE_MASK   0x0300                 /* Line Mask in the Receive Buffer */
+#define DZ_RBUF_MASK   0x00FF                 /* Data Mask */
+#define DZ_LINE_MASK   0x0300                 /* Line Mask */
 #define DZ_DVAL        0x8000                 /* Valid Data indicator */
 #define DZ_OERR        0x4000                 /* Overrun error indicator */
 #define DZ_FERR        0x2000                 /* Frame error indicator */
 #define DZ_PERR        0x1000                 /* Parity error indicator */
 
-#define LINE(x) (x & DZ_LINE_MASK) >> 8       /* Get the line number from the input buffer */
-#define UCHAR(x) (unsigned char)(x & DZ_RBUF_MASK)
+#define LINE(x) ((x & DZ_LINE_MASK) >> 8)     /* Get the line number
+                                                 from the input buffer */
+#define UCHAR(x) ((unsigned char)(x & DZ_RBUF_MASK))
 
 /*
- * Definitions for the Transmit Register.
+ * Definitions for the Transmit Control Register.
  */
 #define DZ_LINE_KEYBOARD 0x0001
 #define DZ_LINE_MOUSE    0x0002
 #define DZ_LINE_MODEM    0x0004
 #define DZ_LINE_PRINTER  0x0008
 
+#define DZ_MODEM_RTS     0x0800               /* RTS for the modem line (2) */
 #define DZ_MODEM_DTR     0x0400               /* DTR for the modem line (2) */
+#define DZ_PRINT_RTS     0x0200               /* RTS for the prntr line (3) */
+#define DZ_PRINT_DTR     0x0100               /* DTR for the prntr line (3) */
+#define DZ_LNENB         0x000f               /* Transmitter Line Enable */
 
 /*
  * Definitions for the Modem Status Register.
  */
+#define DZ_MODEM_RI      0x0800               /* RI for the modem line (2) */
+#define DZ_MODEM_CD      0x0400               /* CD for the modem line (2) */
 #define DZ_MODEM_DSR     0x0200               /* DSR for the modem line (2) */
+#define DZ_MODEM_CTS     0x0100               /* CTS for the modem line (2) */
+#define DZ_PRINT_RI      0x0008               /* RI for the printer line (3) */
+#define DZ_PRINT_CD      0x0004               /* CD for the printer line (3) */
+#define DZ_PRINT_DSR     0x0002               /* DSR for the prntr line (3) */
+#define DZ_PRINT_CTS     0x0001               /* CTS for the prntr line (3) */
 
 /*
  * Definitions for the Transmit Data Register.
