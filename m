Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbUCIX2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbUCIX2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:28:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:15570 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262408AbUCIX0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:26:55 -0500
Subject: [PATCH] pmac_zillog 1/2 : Cosmetic only, change "up" to "uap" to
	avoid collision
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078874616.9750.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 10:23:38 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does cosmetic changes the pmac_zilog, changing the use
of "up" as an identifier in favor "uap" to avoid collision with
semaphores, use proper debug macros, and a few other cosmetic bits.
 
Please apply before next one.

Ben.

diff -Nru a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
--- a/drivers/serial/pmac_zilog.c	Wed Mar 10 10:18:07 2004
+++ b/drivers/serial/pmac_zilog.c	Wed Mar 10 10:18:07 2004
@@ -31,7 +31,7 @@
  *
  * TODO:   - Add DMA support
  *         - Defer port shutdown to a few seconds after close
- *         - maybe put something right into up->clk_divisor
+ *         - maybe put something right into uap->clk_divisor
  */
 
 #undef DEBUG
@@ -96,71 +96,71 @@
  * This function must only be called when the TX is not busy.  The UART
  * port lock must be held and local interrupts disabled.
  */
-static void pmz_load_zsregs(struct uart_pmac_port *up, u8 *regs)
+static void pmz_load_zsregs(struct uart_pmac_port *uap, u8 *regs)
 {
 	int i;
 
 	/* Let pending transmits finish.  */
 	for (i = 0; i < 1000; i++) {
-		unsigned char stat = read_zsreg(up, R1);
+		unsigned char stat = read_zsreg(uap, R1);
 		if (stat & ALL_SNT)
 			break;
 		udelay(100);
 	}
 
-	ZS_CLEARERR(up);
-	zssync(up);
-	ZS_CLEARFIFO(up);
-	zssync(up);
-	ZS_CLEARERR(up);
+	ZS_CLEARERR(uap);
+	zssync(uap);
+	ZS_CLEARFIFO(uap);
+	zssync(uap);
+	ZS_CLEARERR(uap);
 
 	/* Disable all interrupts.  */
-	write_zsreg(up, R1,
+	write_zsreg(uap, R1,
 		    regs[R1] & ~(RxINT_MASK | TxINT_ENAB | EXT_INT_ENAB));
 
 	/* Set parity, sync config, stop bits, and clock divisor.  */
-	write_zsreg(up, R4, regs[R4]);
+	write_zsreg(uap, R4, regs[R4]);
 
 	/* Set misc. TX/RX control bits.  */
-	write_zsreg(up, R10, regs[R10]);
+	write_zsreg(uap, R10, regs[R10]);
 
 	/* Set TX/RX controls sans the enable bits.  */
-	write_zsreg(up, R3, regs[R3] & ~RxENABLE);
-	write_zsreg(up, R5, regs[R5] & ~TxENABLE);
+	write_zsreg(uap, R3, regs[R3] & ~RxENABLE);
+	write_zsreg(uap, R5, regs[R5] & ~TxENABLE);
 
 	/* Synchronous mode config.  */
-	write_zsreg(up, R6, regs[R6]);
-	write_zsreg(up, R7, regs[R7]);
+	write_zsreg(uap, R6, regs[R6]);
+	write_zsreg(uap, R7, regs[R7]);
 
 	/* Disable baud generator.  */
-	write_zsreg(up, R14, regs[R14] & ~BRENAB);
+	write_zsreg(uap, R14, regs[R14] & ~BRENAB);
 
 	/* Clock mode control.  */
-	write_zsreg(up, R11, regs[R11]);
+	write_zsreg(uap, R11, regs[R11]);
 
 	/* Lower and upper byte of baud rate generator divisor.  */
-	write_zsreg(up, R12, regs[R12]);
-	write_zsreg(up, R13, regs[R13]);
+	write_zsreg(uap, R12, regs[R12]);
+	write_zsreg(uap, R13, regs[R13]);
 	
 	/* Now rewrite R14, with BRENAB (if set).  */
-	write_zsreg(up, R14, regs[R14]);
+	write_zsreg(uap, R14, regs[R14]);
 
 	/* External status interrupt control.  */
-	write_zsreg(up, R15, regs[R15]);
+	write_zsreg(uap, R15, regs[R15]);
 
 	/* Reset external status interrupts.  */
-	write_zsreg(up, R0, RES_EXT_INT);
-	write_zsreg(up, R0, RES_EXT_INT);
+	write_zsreg(uap, R0, RES_EXT_INT);
+	write_zsreg(uap, R0, RES_EXT_INT);
 
 	/* Rewrite R3/R5, this time without enables masked.  */
-	write_zsreg(up, R3, regs[R3]);
-	write_zsreg(up, R5, regs[R5]);
+	write_zsreg(uap, R3, regs[R3]);
+	write_zsreg(uap, R5, regs[R5]);
 
 	/* Rewrite R1, this time without IRQ enabled masked.  */
-	write_zsreg(up, R1, regs[R1]);
+	write_zsreg(uap, R1, regs[R1]);
 
 	/* Enable interrupts */
-	write_zsreg(up, R9, regs[R9]);
+	write_zsreg(uap, R9, regs[R9]);
 }
 
 /* 
@@ -171,21 +171,21 @@
  *
  * The UART port lock must be held and local interrupts disabled.
  */
-static void pmz_maybe_update_regs(struct uart_pmac_port *up)
+static void pmz_maybe_update_regs(struct uart_pmac_port *uap)
 {
-       	if (!ZS_REGS_HELD(up)) {
-		if (ZS_TX_ACTIVE(up)) {
-			up->flags |= PMACZILOG_FLAG_REGS_HELD;
+       	if (!ZS_REGS_HELD(uap)) {
+		if (ZS_TX_ACTIVE(uap)) {
+			uap->flags |= PMACZILOG_FLAG_REGS_HELD;
 		} else {
-			pr_debug("pmz: maybe_update_regs: updating\n");
-			pmz_load_zsregs(up, up->curregs);
+			pmz_debug("pmz: maybe_update_regs: updating\n");
+			pmz_load_zsregs(uap, uap->curregs);
 		}
 	}
 }
 
-static void pmz_receive_chars(struct uart_pmac_port *up, struct pt_regs *regs)
+static void pmz_receive_chars(struct uart_pmac_port *uap, struct pt_regs *regs)
 {
-	struct tty_struct *tty = up->port.info->tty;	/* XXX info==NULL? */
+	struct tty_struct *tty = uap->port.info->tty;	/* XXX info==NULL? */
 
 	while (1) {
 		unsigned char ch, r1;
@@ -197,15 +197,15 @@
 				return;	
 		}
 
-		r1 = read_zsreg(up, R1);
+		r1 = read_zsreg(uap, R1);
 		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR)) {
-			write_zsreg(up, R0, ERR_RES);
-			zssync(up);
+			write_zsreg(uap, R0, ERR_RES);
+			zssync(uap);
 		}
 
-		ch = read_zsdata(up);
-		ch &= up->parity_mask;
-		if (ch == 0 && up->prev_status & BRK_ABRT) {
+		ch = read_zsdata(uap);
+		ch &= uap->parity_mask;
+		if (ch == 0 && uap->prev_status & BRK_ABRT) {
 			r1 |= BRK_ABRT;
 			printk("rx break\n");
 		}
@@ -213,21 +213,21 @@
 		/* A real serial line, record the character and status.  */
 		*tty->flip.char_buf_ptr = ch;
 		*tty->flip.flag_buf_ptr = TTY_NORMAL;
-		up->port.icount.rx++;
+		uap->port.icount.rx++;
 		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR | BRK_ABRT)) {
 			if (r1 & BRK_ABRT) {
 				r1 &= ~(PAR_ERR | CRC_ERR);
-				up->port.icount.brk++;
-				if (uart_handle_break(&up->port))
+				uap->port.icount.brk++;
+				if (uart_handle_break(&uap->port))
 					goto next_char;
 			}
 			else if (r1 & PAR_ERR)
-				up->port.icount.parity++;
+				uap->port.icount.parity++;
 			else if (r1 & CRC_ERR)
-				up->port.icount.frame++;
+				uap->port.icount.frame++;
 			if (r1 & Rx_OVR)
-				up->port.icount.overrun++;
-			r1 &= up->port.read_status_mask;
+				uap->port.icount.overrun++;
+			r1 &= uap->port.read_status_mask;
 			if (r1 & BRK_ABRT)
 				*tty->flip.flag_buf_ptr = TTY_BREAK;
 			else if (r1 & PAR_ERR)
@@ -235,11 +235,11 @@
 			else if (r1 & CRC_ERR)
 				*tty->flip.flag_buf_ptr = TTY_FRAME;
 		}
-		if (uart_handle_sysrq_char(&up->port, ch, regs))
+		if (uart_handle_sysrq_char(&uap->port, ch, regs))
 			goto next_char;
 
-		if (up->port.ignore_status_mask == 0xff ||
-		    (r1 & up->port.ignore_status_mask) == 0) {
+		if (uap->port.ignore_status_mask == 0xff ||
+		    (r1 & uap->port.ignore_status_mask) == 0) {
 			tty->flip.flag_buf_ptr++;
 			tty->flip.char_buf_ptr++;
 			tty->flip.count++;
@@ -252,7 +252,7 @@
 			tty->flip.count++;
 		}
 	next_char:
-		ch = read_zsreg(up, R0);
+		ch = read_zsreg(uap, R0);
 		if (!(ch & Rx_CH_AV))
 			break;
 	}
@@ -260,16 +260,16 @@
 	tty_flip_buffer_push(tty);
 }
 
-static void pmz_status_handle(struct uart_pmac_port *up, struct pt_regs *regs)
+static void pmz_status_handle(struct uart_pmac_port *uap, struct pt_regs *regs)
 {
 	unsigned char status;
 
-	status = read_zsreg(up, R0);
-	write_zsreg(up, R0, RES_EXT_INT);
-	zssync(up);
+	status = read_zsreg(uap, R0);
+	write_zsreg(uap, R0, RES_EXT_INT);
+	zssync(uap);
 
 #ifdef HAS_SCCDBG
-	if (sccdbg && (status & BRK_ABRT) && !(up->prev_status & BRK_ABRT)) {
+	if (sccdbg && (status & BRK_ABRT) && !(uap->prev_status & BRK_ABRT)) {
 #ifdef CONFIG_XMON
 		extern void xmon(struct pt_regs *);
 		xmon(regs);
@@ -277,33 +277,33 @@
 	}
 #endif /* HAS_SCCDBG */
 
-	if (ZS_WANTS_MODEM_STATUS(up)) {
+	if (ZS_WANTS_MODEM_STATUS(uap)) {
 		if (status & SYNC_HUNT)
-			up->port.icount.dsr++;
+			uap->port.icount.dsr++;
 
 		/* The Zilog just gives us an interrupt when DCD/CTS/etc. change.
 		 * But it does not tell us which bit has changed, we have to keep
 		 * track of this ourselves.
 		 */
-		if ((status & DCD) ^ up->prev_status)
-			uart_handle_dcd_change(&up->port,
+		if ((status & DCD) ^ uap->prev_status)
+			uart_handle_dcd_change(&uap->port,
 					       (status & DCD));
-		if ((status & CTS) ^ up->prev_status)
-			uart_handle_cts_change(&up->port,
+		if ((status & CTS) ^ uap->prev_status)
+			uart_handle_cts_change(&uap->port,
 					       (status & CTS));
 
-		wake_up_interruptible(&up->port.info->delta_msr_wait);
+		wake_up_interruptible(&uap->port.info->delta_msr_wait);
 	}
 
-	up->prev_status = status;
+	uap->prev_status = status;
 }
 
-static void pmz_transmit_chars(struct uart_pmac_port *up)
+static void pmz_transmit_chars(struct uart_pmac_port *uap)
 {
 	struct circ_buf *xmit;
 
-	if (ZS_IS_CONS(up)) {
-		unsigned char status = read_zsreg(up, R0);
+	if (ZS_IS_CONS(uap)) {
+		unsigned char status = read_zsreg(uap, R0);
 
 		/* TX still busy?  Just wait for the next TX done interrupt.
 		 *
@@ -317,75 +317,75 @@
 			return;
 	}
 
-	up->flags &= ~PMACZILOG_FLAG_TX_ACTIVE;
+	uap->flags &= ~PMACZILOG_FLAG_TX_ACTIVE;
 
-	if (ZS_REGS_HELD(up)) {
-		pmz_load_zsregs(up, up->curregs);
-		up->flags &= ~PMACZILOG_FLAG_REGS_HELD;
+	if (ZS_REGS_HELD(uap)) {
+		pmz_load_zsregs(uap, uap->curregs);
+		uap->flags &= ~PMACZILOG_FLAG_REGS_HELD;
 	}
 
-	if (ZS_TX_STOPPED(up)) {
-		up->flags &= ~PMACZILOG_FLAG_TX_STOPPED;
+	if (ZS_TX_STOPPED(uap)) {
+		uap->flags &= ~PMACZILOG_FLAG_TX_STOPPED;
 		goto ack_tx_int;
 	}
 
-	if (up->port.x_char) {
-		up->flags |= PMACZILOG_FLAG_TX_ACTIVE;
-		write_zsdata(up, up->port.x_char);
-		zssync(up);
-		up->port.icount.tx++;
-		up->port.x_char = 0;
+	if (uap->port.x_char) {
+		uap->flags |= PMACZILOG_FLAG_TX_ACTIVE;
+		write_zsdata(uap, uap->port.x_char);
+		zssync(uap);
+		uap->port.icount.tx++;
+		uap->port.x_char = 0;
 		return;
 	}
 
-	if (up->port.info == NULL)
+	if (uap->port.info == NULL)
 		goto ack_tx_int;
-	xmit = &up->port.info->xmit;
+	xmit = &uap->port.info->xmit;
 	if (uart_circ_empty(xmit)) {
-		uart_write_wakeup(&up->port);
+		uart_write_wakeup(&uap->port);
 		goto ack_tx_int;
 	}
-	if (uart_tx_stopped(&up->port))
+	if (uart_tx_stopped(&uap->port))
 		goto ack_tx_int;
 
-	up->flags |= PMACZILOG_FLAG_TX_ACTIVE;
-	write_zsdata(up, xmit->buf[xmit->tail]);
-	zssync(up);
+	uap->flags |= PMACZILOG_FLAG_TX_ACTIVE;
+	write_zsdata(uap, xmit->buf[xmit->tail]);
+	zssync(uap);
 
 	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-	up->port.icount.tx++;
+	uap->port.icount.tx++;
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&up->port);
+		uart_write_wakeup(&uap->port);
 
 	return;
 
 ack_tx_int:
-	write_zsreg(up, R0, RES_Tx_P);
-	zssync(up);
+	write_zsreg(uap, R0, RES_Tx_P);
+	zssync(uap);
 }
 
 /* Hrm... we register that twice, fixme later.... */
 static irqreturn_t pmz_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	struct uart_pmac_port *up = dev_id;
+	struct uart_pmac_port *uap = dev_id;
 	struct uart_pmac_port *up_a;
 	struct uart_pmac_port *up_b;
 	int rc = IRQ_NONE;
 	u8 r3;
 
-	up_a = ZS_IS_CHANNEL_A(up) ? up : up->mate;
+	up_a = ZS_IS_CHANNEL_A(uap) ? uap : uap->mate;
 	up_b = up_a->mate;
        
        	spin_lock(&up_a->port.lock);
-	r3 = read_zsreg(up, R3);
-	pr_debug("pmz_irq: %x\n", r3);
+	r3 = read_zsreg(uap, R3);
+	pmz_debug("pmz_irq: %x\n", r3);
 
        	/* Channel A */
        	if (r3 & (CHAEXT | CHATxIP | CHARxIP)) {
 		write_zsreg(up_a, R0, RES_H_IUS);
 		zssync(up_a);		
-		pr_debug("pmz: irq channel A: %x\n", r3);
+		pmz_debug("pmz: irq channel A: %x\n", r3);
        		if (r3 & CHAEXT)
        			pmz_status_handle(up_a, regs);
 		if (r3 & CHARxIP)
@@ -400,7 +400,7 @@
 	if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
 		write_zsreg(up_b, R0, RES_H_IUS);
 		zssync(up_b);
-		pr_debug("pmz: irq channel B: %x\n", r3);
+		pmz_debug("pmz: irq channel B: %x\n", r3);
        		if (r3 & CHBEXT)
        			pmz_status_handle(up_b, regs);
        	       	if (r3 & CHBRxIP)
@@ -418,14 +418,14 @@
 /*
  * Peek the status register, lock not held by caller
  */
-static inline u8 pmz_peek_status(struct uart_pmac_port *up)
+static inline u8 pmz_peek_status(struct uart_pmac_port *uap)
 {
 	unsigned long flags;
 	u8 status;
 	
-	spin_lock_irqsave(&up->port.lock, flags);
-	status = read_zsreg(up, R0);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	spin_lock_irqsave(&uap->port.lock, flags);
+	status = read_zsreg(uap, R0);
+	spin_unlock_irqrestore(&uap->port.lock, flags);
 
 	return status;
 }
@@ -452,16 +452,16 @@
  */
 static void pmz_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct uart_pmac_port *up = to_pmz(port);
+	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char set_bits, clear_bits;
 
         /* Do nothing for irda for now... */
-	if (ZS_IS_IRDA(up))
+	if (ZS_IS_IRDA(uap))
 		return;
 
 	set_bits = clear_bits = 0;
 
-	if (ZS_IS_INTMODEM(up)) {
+	if (ZS_IS_INTMODEM(uap)) {
 		if (mctrl & TIOCM_RTS)
 			set_bits |= RTS;
 		else
@@ -473,10 +473,10 @@
 		clear_bits |= DTR;
 
 	/* NOTE: Not subject to 'transmitter active' rule.  */ 
-	up->curregs[R5] |= set_bits;
-	up->curregs[R5] &= ~clear_bits;
-	write_zsreg(up, R5, up->curregs[R5]);
-	zssync(up);
+	uap->curregs[R5] |= set_bits;
+	uap->curregs[R5] &= ~clear_bits;
+	write_zsreg(uap, R5, uap->curregs[R5]);
+	zssync(uap);
 }
 
 /* 
@@ -519,15 +519,15 @@
  */
 static void pmz_start_tx(struct uart_port *port, unsigned int tty_start)
 {
-	struct uart_pmac_port *up = to_pmz(port);
+	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char status;
 
-	pr_debug("pmz: start_tx()\n");
+	pmz_debug("pmz: start_tx()\n");
 
-	up->flags |= PMACZILOG_FLAG_TX_ACTIVE;
-	up->flags &= ~PMACZILOG_FLAG_TX_STOPPED;
+	uap->flags |= PMACZILOG_FLAG_TX_ACTIVE;
+	uap->flags &= ~PMACZILOG_FLAG_TX_STOPPED;
 
-	status = read_zsreg(up, R0);
+	status = read_zsreg(uap, R0);
 
 	/* TX busy?  Just wait for the TX done interrupt.  */
 	if (!(status & Tx_BUF_EMP))
@@ -537,22 +537,22 @@
 	 * IRQ sending engine.
 	 */
 	if (port->x_char) {
-		write_zsdata(up, port->x_char);
-		zssync(up);
+		write_zsdata(uap, port->x_char);
+		zssync(uap);
 		port->icount.tx++;
 		port->x_char = 0;
 	} else {
 		struct circ_buf *xmit = &port->info->xmit;
 
-		write_zsdata(up, xmit->buf[xmit->tail]);
-		zssync(up);
+		write_zsdata(uap, xmit->buf[xmit->tail]);
+		zssync(uap);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 
 		if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-			uart_write_wakeup(&up->port);
+			uart_write_wakeup(&uap->port);
 	}
-	pr_debug("pmz: start_tx() done.\n");
+	pmz_debug("pmz: start_tx() done.\n");
 }
 
 /* 
@@ -562,18 +562,18 @@
  */
 static void pmz_stop_rx(struct uart_port *port)
 {
-	struct uart_pmac_port *up = to_pmz(port);
+	struct uart_pmac_port *uap = to_pmz(port);
 
-	if (ZS_IS_CONS(up))
+	if (ZS_IS_CONS(uap))
 		return;
 
-	pr_debug("pmz: stop_rx()()\n");
+	pmz_debug("pmz: stop_rx()()\n");
 
 	/* Disable all RX interrupts.  */
-	up->curregs[R1] &= ~RxINT_MASK;
-	pmz_maybe_update_regs(up);
+	uap->curregs[R1] &= ~RxINT_MASK;
+	pmz_maybe_update_regs(uap);
 
-	pr_debug("pmz: stop_rx() done.\n");
+	pmz_debug("pmz: stop_rx() done.\n");
 }
 
 /* 
@@ -582,15 +582,15 @@
  */
 static void pmz_enable_ms(struct uart_port *port)
 {
-	struct uart_pmac_port *up = to_pmz(port);
+	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char new_reg;
 
-	new_reg = up->curregs[R15] | (DCDIE | SYNCIE | CTSIE);
-	if (new_reg != up->curregs[R15]) {
-		up->curregs[R15] = new_reg;
+	new_reg = uap->curregs[R15] | (DCDIE | SYNCIE | CTSIE);
+	if (new_reg != uap->curregs[R15]) {
+		uap->curregs[R15] = new_reg;
 
 		/* NOTE: Not subject to 'transmitter active' rule.  */ 
-		write_zsreg(up, R15, up->curregs[R15]);
+		write_zsreg(uap, R15, uap->curregs[R15]);
 	}
 }
 
@@ -600,7 +600,7 @@
  */
 static void pmz_break_ctl(struct uart_port *port, int break_state)
 {
-	struct uart_pmac_port *up = to_pmz(port);
+	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char set_bits, clear_bits, new_reg;
 	unsigned long flags;
 
@@ -613,12 +613,12 @@
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	new_reg = (up->curregs[R5] | set_bits) & ~clear_bits;
-	if (new_reg != up->curregs[R5]) {
-		up->curregs[R5] = new_reg;
+	new_reg = (uap->curregs[R5] | set_bits) & ~clear_bits;
+	if (new_reg != uap->curregs[R5]) {
+		uap->curregs[R5] = new_reg;
 
 		/* NOTE: Not subject to 'transmitter active' rule.  */ 
-		write_zsreg(up, R5, up->curregs[R5]);
+		write_zsreg(uap, R5, uap->curregs[R5]);
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -630,18 +630,18 @@
  * Returns the number of milliseconds we should wait before
  * trying to use the port.
  */
-static int pmz_set_scc_power(struct uart_pmac_port *up, int state)
+static int pmz_set_scc_power(struct uart_pmac_port *uap, int state)
 {
 	int delay = 0;
 
 	if (state) {
 		pmac_call_feature(
-			PMAC_FTR_SCC_ENABLE, up->node, up->port_type, 1);
-		if (ZS_IS_INTMODEM(up)) {
+			PMAC_FTR_SCC_ENABLE, uap->node, uap->port_type, 1);
+		if (ZS_IS_INTMODEM(uap)) {
 			pmac_call_feature(
-				PMAC_FTR_MODEM_ENABLE, up->node, 0, 1);
+				PMAC_FTR_MODEM_ENABLE, uap->node, 0, 1);
 			delay = 2500;	/* wait for 2.5s before using */
-		} else if (ZS_IS_IRDA(up))
+		} else if (ZS_IS_IRDA(uap))
 			mdelay(50);	/* Do better here once the problems
 			                 * with blocking have been ironed out
 			                 */
@@ -649,12 +649,12 @@
 		/* TODO: Make that depend on a timer, don't power down
 		 * immediately
 		 */
-		if (ZS_IS_INTMODEM(up)) {
+		if (ZS_IS_INTMODEM(uap)) {
 			pmac_call_feature(
-				PMAC_FTR_MODEM_ENABLE, up->node, 0, 0);
+				PMAC_FTR_MODEM_ENABLE, uap->node, 0, 0);
 		}
 		pmac_call_feature(
-			PMAC_FTR_SCC_ENABLE, up->node, up->port_type, 0);
+			PMAC_FTR_SCC_ENABLE, uap->node, uap->port_type, 0);
 	}
 	return delay;
 }
@@ -665,7 +665,7 @@
  *
  * The following sequence prevents a problem that is seen with O'Hare ASICs
  * (most versions -- also with some Heathrow and Hydra ASICs) where a zero
- * at the input to the receiver becomes 'stuck' and locks up the receiver.
+ * at the input to the receiver becomes 'stuck' and locks uap the receiver.
  * This problem can occur as a result of a zero bit at the receiver input
  * coincident with any of the following events:
  *
@@ -679,91 +679,91 @@
  * the SCC in synchronous loopback mode with a fast clock before programming
  * any of the asynchronous modes.
  */
-static void pmz_fix_zero_bug_scc(struct uart_pmac_port *up)
+static void pmz_fix_zero_bug_scc(struct uart_pmac_port *uap)
 {
-	write_zsreg(up, 9, ZS_IS_CHANNEL_A(up) ? CHRA : CHRB);
-	zssync(up);
+	write_zsreg(uap, 9, ZS_IS_CHANNEL_A(uap) ? CHRA : CHRB);
+	zssync(uap);
 	udelay(10);
-	write_zsreg(up, 9, (ZS_IS_CHANNEL_A(up) ? CHRA : CHRB) | NV);
-	zssync(up);
+	write_zsreg(uap, 9, (ZS_IS_CHANNEL_A(uap) ? CHRA : CHRB) | NV);
+	zssync(uap);
 
-	write_zsreg(up, 4, (X1CLK | EXTSYNC));
+	write_zsreg(uap, 4, (X1CLK | EXTSYNC));
 
 	/* I think this is wrong....but, I just copying code....
 	*/
-	write_zsreg(up, 3, (8 & ~RxENABLE));
+	write_zsreg(uap, 3, (8 & ~RxENABLE));
 
-	write_zsreg(up, 5, (8 & ~TxENABLE));
-	write_zsreg(up, 9, NV);	/* Didn't we already do this? */
-	write_zsreg(up, 11, (RCBR | TCBR));
-	write_zsreg(up, 12, 0);
-	write_zsreg(up, 13, 0);
-	write_zsreg(up, 14, (LOOPBAK | SSBR));
-	write_zsreg(up, 14, (LOOPBAK | SSBR | BRENAB));
-	write_zsreg(up, 3, (8 | RxENABLE));
-	write_zsreg(up, 0, RES_EXT_INT);
-	write_zsreg(up, 0, RES_EXT_INT);	/* to kill some time */
+	write_zsreg(uap, 5, (8 & ~TxENABLE));
+	write_zsreg(uap, 9, NV);	/* Didn't we already do this? */
+	write_zsreg(uap, 11, (RCBR | TCBR));
+	write_zsreg(uap, 12, 0);
+	write_zsreg(uap, 13, 0);
+	write_zsreg(uap, 14, (LOOPBAK | SSBR));
+	write_zsreg(uap, 14, (LOOPBAK | SSBR | BRENAB));
+	write_zsreg(uap, 3, (8 | RxENABLE));
+	write_zsreg(uap, 0, RES_EXT_INT);
+	write_zsreg(uap, 0, RES_EXT_INT);	/* to kill some time */
 
 	/* The channel should be OK now, but it is probably receiving
 	 * loopback garbage.
 	 * Switch to asynchronous mode, disable the receiver,
 	 * and discard everything in the receive buffer.
 	 */
-	write_zsreg(up, 9, NV);
-	write_zsreg(up, 4, PAR_ENAB);
-	write_zsreg(up, 3, (8 & ~RxENABLE));
-
-	while (read_zsreg(up, 0) & Rx_CH_AV) {
-		(void)read_zsreg(up, 8);
-		write_zsreg(up, 0, RES_EXT_INT);
-		write_zsreg(up, 0, ERR_RES);
+	write_zsreg(uap, 9, NV);
+	write_zsreg(uap, 4, PAR_ENAB);
+	write_zsreg(uap, 3, (8 & ~RxENABLE));
+
+	while (read_zsreg(uap, 0) & Rx_CH_AV) {
+		(void)read_zsreg(uap, 8);
+		write_zsreg(uap, 0, RES_EXT_INT);
+		write_zsreg(uap, 0, ERR_RES);
 	}
 }
 
 /*
- * Real startup routine, powers up the hardware and sets up
+ * Real startup routine, powers uap the hardware and sets uap
  * the SCC. Returns a delay in ms where you need to wait before
  * actually using the port, this is typically the internal modem
  * powerup delay. This routine expect the lock to be taken.
  */
-static int __pmz_startup(struct uart_pmac_port *up)
+static int __pmz_startup(struct uart_pmac_port *uap)
 {
 	int pwr_delay = 0;
 
-	memset(&up->curregs, 0, sizeof(up->curregs));
+	memset(&uap->curregs, 0, sizeof(uap->curregs));
 
-	/* Power up the SCC & underlying hardware (modem/irda) */
-	pwr_delay = pmz_set_scc_power(up, 1);
+	/* Power uap the SCC & underlying hardware (modem/irda) */
+	pwr_delay = pmz_set_scc_power(uap, 1);
 
 	/* Nice buggy HW ... */
-	pmz_fix_zero_bug_scc(up);
+	pmz_fix_zero_bug_scc(uap);
 
 	/* Reset the chip */
-	write_zsreg(up, 9, ZS_IS_CHANNEL_A(up) ? CHRA : CHRB);
-	zssync(up);
+	write_zsreg(uap, 9, ZS_IS_CHANNEL_A(uap) ? CHRA : CHRB);
+	zssync(uap);
 	udelay(10);
-	write_zsreg(up, 9, 0);
-	zssync(up);
+	write_zsreg(uap, 9, 0);
+	zssync(uap);
 
 	/* Clear the interrupt registers */
-	write_zsreg(up, R1, 0);
-	write_zsreg(up, R0, ERR_RES);
-	write_zsreg(up, R0, ERR_RES);
-	write_zsreg(up, R0, RES_H_IUS);
-	write_zsreg(up, R0, RES_H_IUS);
+	write_zsreg(uap, R1, 0);
+	write_zsreg(uap, R0, ERR_RES);
+	write_zsreg(uap, R0, ERR_RES);
+	write_zsreg(uap, R0, RES_H_IUS);
+	write_zsreg(uap, R0, RES_H_IUS);
 
 	/* Remember status for DCD/CTS changes */
-	up->prev_status = read_zsreg(up, R0);
+	uap->prev_status = read_zsreg(uap, R0);
 
 	/* Enable receiver and transmitter.  */
-	up->curregs[R3] |= RxENABLE;
-	up->curregs[R5] |= TxENABLE | RTS | DTR;
+	uap->curregs[R3] |= RxENABLE;
+	uap->curregs[R5] |= TxENABLE | RTS | DTR;
 
 	/* Master interrupt enable */
-	up->curregs[R9] |= NV | MIE;
+	uap->curregs[R9] |= NV | MIE;
 
-	up->curregs[R1] |= EXT_INT_ENAB | INT_ALL_Rx | TxINT_ENAB;
-       	pmz_maybe_update_regs(up);
+	uap->curregs[R1] |= EXT_INT_ENAB | INT_ALL_Rx | TxINT_ENAB;
+       	pmz_maybe_update_regs(uap);
 
 	return pwr_delay;
 }
@@ -774,22 +774,23 @@
  */
 static int pmz_startup(struct uart_port *port)
 {
-	struct uart_pmac_port *up = to_pmz(port);
+	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned long flags;
 	int pwr_delay = 0;
 
-	pr_debug("pmz: startup()\n");
+	pmz_debug("pmz: startup()\n");
 
 	/* A console is never powered down */
-	if (!ZS_IS_CONS(up)) {
+	if (!ZS_IS_CONS(uap)) {
 		spin_lock_irqsave(&port->lock, flags);
-		pwr_delay = __pmz_startup(up);
+		pwr_delay = __pmz_startup(uap);
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 	
-	if (request_irq(up->port.irq, pmz_interrupt, SA_SHIRQ, "PowerMac Zilog", up)) {
-		printk(KERN_ERR "Unable to register zs interrupt handler.\n");
-		pmz_set_scc_power(up, 0);
+	if (request_irq(uap->port.irq, pmz_interrupt, SA_SHIRQ, "PowerMac Zilog", uap)) {
+		dev_err(&uap->dev->ofdev.dev,
+			"Unable to register zs interrupt handler.\n");
+		pmz_set_scc_power(uap, 0);
 		return -ENXIO;
 	}
 
@@ -797,155 +798,154 @@
 	 * smarter later on
 	 */
 	if (pwr_delay != 0) {
-		pr_debug("pmz: delaying %d ms\n", pwr_delay);
+		pmz_debug("pmz: delaying %d ms\n", pwr_delay);
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout((pwr_delay * HZ)/1000);
 	}
 
-	pr_debug("pmz: startup() done.\n");
+	pmz_debug("pmz: startup() done.\n");
 
 	return 0;
 }
 
 static void pmz_shutdown(struct uart_port *port)
 {
-	struct uart_pmac_port *up = to_pmz(port);
+	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned long flags;
 
-	pr_debug("pmz: shutdown()\n");
+	pmz_debug("pmz: shutdown()\n");
 
 	/* Release interrupt handler */
-       	free_irq(up->port.irq, up);
+       	free_irq(uap->port.irq, uap);
 
-	if (ZS_IS_CONS(up))
+	if (ZS_IS_CONS(uap))
 		return;
 
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable receiver and transmitter.  */
-	up->curregs[R3] &= ~RxENABLE;
-	up->curregs[R5] &= ~TxENABLE;
+	uap->curregs[R3] &= ~RxENABLE;
+	uap->curregs[R5] &= ~TxENABLE;
 
 	/* Disable all interrupts and BRK assertion.  */
-	up->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
-	up->curregs[R5] &= ~SND_BRK;
-	pmz_maybe_update_regs(up);
+	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
+	uap->curregs[R5] &= ~SND_BRK;
+	pmz_maybe_update_regs(uap);
 
 	/* Shut the chip down */
-	pmz_set_scc_power(up, 0);
+	pmz_set_scc_power(uap, 0);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	pr_debug("pmz: shutdown() done.\n");
+	pmz_debug("pmz: shutdown() done.\n");
 }
 
 /* Shared by TTY driver and serial console setup.  The port lock is held
  * and local interrupts are disabled.
  */
-static void
-pmz_convert_to_zs(struct uart_pmac_port *up, unsigned int cflag,
-		       unsigned int iflag, int baud)
+static void pmz_convert_to_zs(struct uart_pmac_port *uap, unsigned int cflag,
+			      unsigned int iflag, int baud)
 {
 	int brg;
 
 	switch (baud) {
 	case ZS_CLOCK/16:	/* 230400 */
-		up->curregs[R4] = X16CLK;
-		up->curregs[R11] = 0;
+		uap->curregs[R4] = X16CLK;
+		uap->curregs[R11] = 0;
 		break;
 	case ZS_CLOCK/32:	/* 115200 */
-	        up->curregs[R4] = X32CLK;
-		up->curregs[R11] = 0;
+	        uap->curregs[R4] = X32CLK;
+		uap->curregs[R11] = 0;
 		break;
 	default:
-		up->curregs[R4] = X16CLK;
-		up->curregs[R11] = TCBR | RCBR;
+		uap->curregs[R4] = X16CLK;
+		uap->curregs[R11] = TCBR | RCBR;
 		brg = BPS_TO_BRG(baud, ZS_CLOCK / 16);
-		up->curregs[R12] = (brg & 255);
-		up->curregs[R13] = ((brg >> 8) & 255);
-		up->curregs[R14] = BRENAB;
+		uap->curregs[R12] = (brg & 255);
+		uap->curregs[R13] = ((brg >> 8) & 255);
+		uap->curregs[R14] = BRENAB;
 	}
 
 	/* Character size, stop bits, and parity. */
-	up->curregs[3] &= ~RxN_MASK;
-	up->curregs[5] &= ~TxN_MASK;
+	uap->curregs[3] &= ~RxN_MASK;
+	uap->curregs[5] &= ~TxN_MASK;
 
 	switch (cflag & CSIZE) {
 	case CS5:
-		up->curregs[3] |= Rx5;
-		up->curregs[5] |= Tx5;
-		up->parity_mask = 0x1f;
+		uap->curregs[3] |= Rx5;
+		uap->curregs[5] |= Tx5;
+		uap->parity_mask = 0x1f;
 		break;
 	case CS6:
-		up->curregs[3] |= Rx6;
-		up->curregs[5] |= Tx6;
-		up->parity_mask = 0x3f;
+		uap->curregs[3] |= Rx6;
+		uap->curregs[5] |= Tx6;
+		uap->parity_mask = 0x3f;
 		break;
 	case CS7:
-		up->curregs[3] |= Rx7;
-		up->curregs[5] |= Tx7;
-		up->parity_mask = 0x7f;
+		uap->curregs[3] |= Rx7;
+		uap->curregs[5] |= Tx7;
+		uap->parity_mask = 0x7f;
 		break;
 	case CS8:
 	default:
-		up->curregs[3] |= Rx8;
-		up->curregs[5] |= Tx8;
-		up->parity_mask = 0xff;
+		uap->curregs[3] |= Rx8;
+		uap->curregs[5] |= Tx8;
+		uap->parity_mask = 0xff;
 		break;
 	};
-	up->curregs[4] &= ~(SB_MASK);
+	uap->curregs[4] &= ~(SB_MASK);
 	if (cflag & CSTOPB)
-		up->curregs[4] |= SB2;
+		uap->curregs[4] |= SB2;
 	else
-		up->curregs[4] |= SB1;
+		uap->curregs[4] |= SB1;
 	if (cflag & PARENB)
-		up->curregs[4] |= PAR_ENAB;
+		uap->curregs[4] |= PAR_ENAB;
 	else
-		up->curregs[4] &= ~PAR_ENAB;
+		uap->curregs[4] &= ~PAR_ENAB;
 	if (!(cflag & PARODD))
-		up->curregs[4] |= PAR_EVEN;
+		uap->curregs[4] |= PAR_EVEN;
 	else
-		up->curregs[4] &= ~PAR_EVEN;
+		uap->curregs[4] &= ~PAR_EVEN;
 
-	up->port.read_status_mask = Rx_OVR;
+	uap->port.read_status_mask = Rx_OVR;
 	if (iflag & INPCK)
-		up->port.read_status_mask |= CRC_ERR | PAR_ERR;
+		uap->port.read_status_mask |= CRC_ERR | PAR_ERR;
 	if (iflag & (BRKINT | PARMRK))
-		up->port.read_status_mask |= BRK_ABRT;
+		uap->port.read_status_mask |= BRK_ABRT;
 
-	up->port.ignore_status_mask = 0;
+	uap->port.ignore_status_mask = 0;
 	if (iflag & IGNPAR)
-		up->port.ignore_status_mask |= CRC_ERR | PAR_ERR;
+		uap->port.ignore_status_mask |= CRC_ERR | PAR_ERR;
 	if (iflag & IGNBRK) {
-		up->port.ignore_status_mask |= BRK_ABRT;
+		uap->port.ignore_status_mask |= BRK_ABRT;
 		if (iflag & IGNPAR)
-			up->port.ignore_status_mask |= Rx_OVR;
+			uap->port.ignore_status_mask |= Rx_OVR;
 	}
 
 	if ((cflag & CREAD) == 0)
-		up->port.ignore_status_mask = 0xff;
+		uap->port.ignore_status_mask = 0xff;
 }
 
-static void pmz_irda_rts_pulses(struct uart_pmac_port *up, int w)
+static void pmz_irda_rts_pulses(struct uart_pmac_port *uap, int w)
 {
 	udelay(w);
-	write_zsreg(up, 5, Tx8 | TxENABLE);
-	zssync(up);
+	write_zsreg(uap, 5, Tx8 | TxENABLE);
+	zssync(uap);
 	udelay(2);
-	write_zsreg(up, 5, Tx8 | TxENABLE | RTS);
-	zssync(up);
+	write_zsreg(uap, 5, Tx8 | TxENABLE | RTS);
+	zssync(uap);
 	udelay(8);
-	write_zsreg(up, 5, Tx8 | TxENABLE);
-	zssync(up);
+	write_zsreg(uap, 5, Tx8 | TxENABLE);
+	zssync(uap);
 	udelay(4);
-	write_zsreg(up, 5, Tx8 | TxENABLE | RTS);
-	zssync(up);
+	write_zsreg(uap, 5, Tx8 | TxENABLE | RTS);
+	zssync(uap);
 }
 
 /*
  * Set the irda codec on the imac to the specified baud rate.
  */
-static void pmz_irda_setup(struct uart_pmac_port *up, int cflags)
+static void pmz_irda_setup(struct uart_pmac_port *uap, int cflags)
 {
 	int code, speed, t;
 
@@ -955,14 +955,14 @@
 	code = 0x4d + B115200 - speed;
 
 	/* disable serial interrupts and receive DMA */
-	write_zsreg(up, 1, up->curregs[1] & ~0x9f);
+	write_zsreg(uap, 1, uap->curregs[1] & ~0x9f);
 
 	/* wait for transmitter to drain */
 	t = 10000;
-	while ((read_zsreg(up, R0) & Tx_BUF_EMP) == 0
-	       || (read_zsreg(up, R1) & ALL_SNT) == 0) {
+	while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0
+	       || (read_zsreg(uap, R1) & ALL_SNT) == 0) {
 		if (--t <= 0) {
-			printk(KERN_ERR "transmitter didn't drain\n");
+			dev_err(&uap->dev->ofdev.dev, "transmitter didn't drain\n");
 			return;
 		}
 		udelay(10);
@@ -970,103 +970,105 @@
 	udelay(100);
 
 	/* set to 8 bits, no parity, 19200 baud, RTS on, DTR off */
-	write_zsreg(up, R4, X16CLK | SB1);
-	write_zsreg(up, R11, TCBR | RCBR);
+	write_zsreg(uap, R4, X16CLK | SB1);
+	write_zsreg(uap, R11, TCBR | RCBR);
 	t = BPS_TO_BRG(19200, ZS_CLOCK/16);
-	write_zsreg(up, R12, t);
-	write_zsreg(up, R13, t >> 8);
-	write_zsreg(up, R14, BRENAB);
-	write_zsreg(up, R3, Rx8 | RxENABLE);
-	write_zsreg(up, R5, Tx8 | TxENABLE | RTS);
-	zssync(up);
+	write_zsreg(uap, R12, t);
+	write_zsreg(uap, R13, t >> 8);
+	write_zsreg(uap, R14, BRENAB);
+	write_zsreg(uap, R3, Rx8 | RxENABLE);
+	write_zsreg(uap, R5, Tx8 | TxENABLE | RTS);
+	zssync(uap);
 
 	/* set TxD low for ~104us and pulse RTS */
 	udelay(1000);
-	write_zsdata(up, 0xfe);
-	pmz_irda_rts_pulses(up, 150);
-	pmz_irda_rts_pulses(up, 180);
-	pmz_irda_rts_pulses(up, 50);
+	write_zsdata(uap, 0xfe);
+	pmz_irda_rts_pulses(uap, 150);
+	pmz_irda_rts_pulses(uap, 180);
+	pmz_irda_rts_pulses(uap, 50);
 	udelay(100);
 
 	/* assert DTR, wait 30ms, talk to the chip */
-	write_zsreg(up, R5, Tx8 | TxENABLE | RTS | DTR);
-	zssync(up);
+	write_zsreg(uap, R5, Tx8 | TxENABLE | RTS | DTR);
+	zssync(uap);
 	mdelay(30);
-	while (read_zsreg(up, R0) & Rx_CH_AV)
-		read_zsdata(up);
+	while (read_zsreg(uap, R0) & Rx_CH_AV)
+		read_zsdata(uap);
 
-	write_zsdata(up, 1);
+	write_zsdata(uap, 1);
 	t = 1000;
-	while ((read_zsreg(up, R0) & Rx_CH_AV) == 0) {
+	while ((read_zsreg(uap, R0) & Rx_CH_AV) == 0) {
 		if (--t <= 0) {
-			printk(KERN_ERR "irda_setup timed out on 1st byte\n");
+			dev_err(&uap->dev->ofdev.dev,
+				"irda_setup timed out on 1st byte\n");
 			goto out;
 		}
 		udelay(10);
 	}
-	t = read_zsdata(up);
+	t = read_zsdata(uap);
 	if (t != 4)
-		printk(KERN_ERR "irda_setup 1st byte = %x\n", t);
+		dev_err(&uap->dev->ofdev.dev, "irda_setup 1st byte = %x\n", t);
 
-	write_zsdata(up, code);
+	write_zsdata(uap, code);
 	t = 1000;
-	while ((read_zsreg(up, R0) & Rx_CH_AV) == 0) {
+	while ((read_zsreg(uap, R0) & Rx_CH_AV) == 0) {
 		if (--t <= 0) {
-			printk(KERN_ERR "irda_setup timed out on 2nd byte\n");
+			dev_err(&uap->dev->ofdev.dev,
+				"irda_setup timed out on 2nd byte\n");
 			goto out;
 		}
 		udelay(10);
 	}
-	t = read_zsdata(up);
+	t = read_zsdata(uap);
 	if (t != code)
-		printk(KERN_ERR "irda_setup 2nd byte = %x (%x)\n", t, code);
+		dev_err(&uap->dev->ofdev.dev,
+			"irda_setup 2nd byte = %x (%x)\n", t, code);
 
 	/* Drop DTR again and do some more RTS pulses */
  out:
 	udelay(100);
-	write_zsreg(up, R5, Tx8 | TxENABLE | RTS);
-	pmz_irda_rts_pulses(up, 80);
+	write_zsreg(uap, R5, Tx8 | TxENABLE | RTS);
+	pmz_irda_rts_pulses(uap, 80);
 
 	/* We should be right to go now.  We assume that load_zsregs
-	   will get called soon to load up the correct baud rate etc. */
-	up->curregs[R5] = (up->curregs[R5] | RTS) & ~DTR;
+	   will get called soon to load uap the correct baud rate etc. */
+	uap->curregs[R5] = (uap->curregs[R5] | RTS) & ~DTR;
 }
 
 /* The port lock is not held.  */
-static void
-pmz_set_termios(struct uart_port *port, struct termios *termios,
-		     struct termios *old)
+static void pmz_set_termios(struct uart_port *port, struct termios *termios,
+			    struct termios *old)
 {
-	struct uart_pmac_port *up = to_pmz(port);
+	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned long flags;
 	int baud;
 
-	pr_debug("pmz: set_termios()\n");
+	pmz_debug("pmz: set_termios()\n");
 
 	baud = uart_get_baud_rate(port, termios, old, 1200, 230400);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	spin_lock_irqsave(&uap->port.lock, flags);
 
-	pmz_convert_to_zs(up, termios->c_cflag, termios->c_iflag, baud);
+	pmz_convert_to_zs(uap, termios->c_cflag, termios->c_iflag, baud);
 
-	if (UART_ENABLE_MS(&up->port, termios->c_cflag)) {
-		up->curregs[R15] |= DCDIE | SYNCIE | CTSIE;
-		up->flags |= PMACZILOG_FLAG_MODEM_STATUS;
+	if (UART_ENABLE_MS(&uap->port, termios->c_cflag)) {
+		uap->curregs[R15] |= DCDIE | SYNCIE | CTSIE;
+		uap->flags |= PMACZILOG_FLAG_MODEM_STATUS;
 	} else {
-		up->curregs[R15] &= ~(DCDIE | SYNCIE | CTSIE);
-		up->flags &= ~PMACZILOG_FLAG_MODEM_STATUS;
+		uap->curregs[R15] &= ~(DCDIE | SYNCIE | CTSIE);
+		uap->flags &= ~PMACZILOG_FLAG_MODEM_STATUS;
 	}
 
 	/* set the irda codec to the right rate */
-	if (ZS_IS_IRDA(up))
-		pmz_irda_setup(up, termios->c_cflag);
+	if (ZS_IS_IRDA(uap))
+		pmz_irda_setup(uap, termios->c_cflag);
 
 	/* Load registers to the chip */
-	pmz_maybe_update_regs(up);
+	pmz_maybe_update_regs(uap);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	spin_unlock_irqrestore(&uap->port.lock, flags);
 
-	pr_debug("pmz: set_termios() done.\n");
+	pmz_debug("pmz: set_termios() done.\n");
 }
 
 static const char *pmz_type(struct uart_port *port)
@@ -1121,9 +1123,9 @@
  * Unlike sunzilog, we don't need to pre-init the spinlock as we don't
  * register our console before uart_add_one_port() is called
  */
-static int __init pmz_init_port(struct uart_pmac_port *up)
+static int __init pmz_init_port(struct uart_pmac_port *uap)
 {
-	struct device_node *np = up->node;
+	struct device_node *np = uap->node;
 	char *conn;
 	struct slot_names_prop {
 		int	count;
@@ -1134,35 +1136,35 @@
 	/*
 	 * Request & map chip registers
 	 */
-	up->port.mapbase = np->addrs[0].address;
-	up->port.membase = ioremap(up->port.mapbase, 0x1000);
+	uap->port.mapbase = np->addrs[0].address;
+	uap->port.membase = ioremap(uap->port.mapbase, 0x1000);
       
-	up->control_reg = (volatile u8 *)up->port.membase;
-	up->data_reg = up->control_reg + 0x10;
+	uap->control_reg = (volatile u8 *)uap->port.membase;
+	uap->data_reg = uap->control_reg + 0x10;
 	
 	/*
 	 * Request & map DBDMA registers
 	 */
 #ifdef HAS_DBDMA
 	if (np->n_addrs >= 3 && np->n_intrs >= 3)
-		up->flags |= PMACZILOG_FLAG_HAS_DMA;
+		uap->flags |= PMACZILOG_FLAG_HAS_DMA;
 #endif	
-	if (ZS_HAS_DMA(up)) {
-		up->tx_dma_regs = (volatile struct dbdma_regs *)
+	if (ZS_HAS_DMA(uap)) {
+		uap->tx_dma_regs = (volatile struct dbdma_regs *)
 			ioremap(np->addrs[np->n_addrs - 2].address, 0x1000);
-		if (up->tx_dma_regs == NULL) {	
-			up->flags &= ~PMACZILOG_FLAG_HAS_DMA;
+		if (uap->tx_dma_regs == NULL) {	
+			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
 		}
-		up->rx_dma_regs = (volatile struct dbdma_regs *)
+		uap->rx_dma_regs = (volatile struct dbdma_regs *)
 			ioremap(np->addrs[np->n_addrs - 1].address, 0x1000);
-		if (up->rx_dma_regs == NULL) {	
-			iounmap((void *)up->tx_dma_regs);
-			up->flags &= ~PMACZILOG_FLAG_HAS_DMA;
+		if (uap->rx_dma_regs == NULL) {	
+			iounmap((void *)uap->tx_dma_regs);
+			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
 			goto no_dma;
 		}
-		up->tx_dma_irq = np->intrs[1].line;
-		up->rx_dma_irq = np->intrs[2].line;
+		uap->tx_dma_irq = np->intrs[1].line;
+		uap->rx_dma_irq = np->intrs[2].line;
 	}
 no_dma:
 
@@ -1170,22 +1172,22 @@
 	 * Detect port type
 	 */
 	if (device_is_compatible(np, "cobalt"))
-		up->flags |= PMACZILOG_FLAG_IS_INTMODEM;
+		uap->flags |= PMACZILOG_FLAG_IS_INTMODEM;
 	conn = get_property(np, "AAPL,connector", &len);
 	if (conn && (strcmp(conn, "infrared") == 0))
-		up->flags |= PMACZILOG_FLAG_IS_IRDA;
-	up->port_type = PMAC_SCC_ASYNC;
+		uap->flags |= PMACZILOG_FLAG_IS_IRDA;
+	uap->port_type = PMAC_SCC_ASYNC;
 	/* 1999 Powerbook G3 has slot-names property instead */
 	slots = (struct slot_names_prop *)get_property(np, "slot-names", &len);
 	if (slots && slots->count > 0) {
 		if (strcmp(slots->name, "IrDA") == 0)
-			up->flags |= PMACZILOG_FLAG_IS_IRDA;
+			uap->flags |= PMACZILOG_FLAG_IS_IRDA;
 		else if (strcmp(slots->name, "Modem") == 0)
-			up->flags |= PMACZILOG_FLAG_IS_INTMODEM;
+			uap->flags |= PMACZILOG_FLAG_IS_INTMODEM;
 	}
-	if (ZS_IS_IRDA(up))
-		up->port_type = PMAC_SCC_IRDA;
-	if (ZS_IS_INTMODEM(up)) {
+	if (ZS_IS_IRDA(uap))
+		uap->port_type = PMAC_SCC_IRDA;
+	if (ZS_IS_INTMODEM(uap)) {
 		struct device_node* i2c_modem = find_devices("i2c-modem");
 		if (i2c_modem) {
 			char* mid = get_property(i2c_modem, "modem-id", NULL);
@@ -1196,7 +1198,7 @@
 			case 0x08 :
 			case 0x0b :
 			case 0x0c :
-				up->port_type = PMAC_SCC_I2S1;
+				uap->port_type = PMAC_SCC_I2S1;
 			}
 			printk(KERN_INFO "pmac_zilog: i2c-modem detected, id: %d\n",
 				mid ? (*mid) : 0);
@@ -1208,13 +1210,13 @@
 	/*
 	 * Init remaining bits of "port" structure
 	 */
-	up->port.iotype = SERIAL_IO_MEM;
-	up->port.irq = np->intrs[0].line;
-	up->port.uartclk = ZS_CLOCK;
-	up->port.fifosize = 1;
-	up->port.ops = &pmz_pops;
-	up->port.type = PORT_PMAC_ZILOG;
-	up->port.flags = 0;
+	uap->port.iotype = SERIAL_IO_MEM;
+	uap->port.irq = np->intrs[0].line;
+	uap->port.uartclk = ZS_CLOCK;
+	uap->port.fifosize = 1;
+	uap->port.ops = &pmz_pops;
+	uap->port.type = PORT_PMAC_ZILOG;
+	uap->port.flags = 0;
 
 	return 0;
 }
@@ -1222,13 +1224,13 @@
 /*
  * Get rid of a port on module removal
  */
-static void pmz_dispose_port(struct uart_pmac_port *up)
+static void pmz_dispose_port(struct uart_pmac_port *uap)
 {
 	struct device_node *np;
 
-	iounmap((void *)up->control_reg);
-	np = up->node;
-	up->node = NULL;
+	iounmap((void *)uap->control_reg);
+	np = uap->node;
+	uap->node = NULL;
 	of_node_put(np);
 }
 
@@ -1243,15 +1245,15 @@
 	 */
 	for (i = 0; i < MAX_ZS_PORTS; i++)
 		if (pmz_ports[i].node == mdev->ofdev.node) {
-			struct uart_pmac_port *up = &pmz_ports[i];
+			struct uart_pmac_port *uap = &pmz_ports[i];
 
-			up->dev = mdev;
-			dev_set_drvdata(&mdev->ofdev.dev, up);
-			if (macio_request_resources(up->dev, "pmac_zilog"))
+			uap->dev = mdev;
+			dev_set_drvdata(&mdev->ofdev.dev, uap);
+			if (macio_request_resources(uap->dev, "pmac_zilog"))
 				printk(KERN_WARNING "%s: Failed to request resource, port still active\n",
-				       up->node->name);
+				       uap->node->name);
 			else
-				up->flags |= PMACZILOG_FLAG_RSRC_REQUESTED;				
+				uap->flags |= PMACZILOG_FLAG_RSRC_REQUESTED;				
 			return 0;
 		}
 	return -ENODEV;
@@ -1263,17 +1265,17 @@
  */
 static int pmz_detach(struct macio_dev *mdev)
 {
-	struct uart_pmac_port	*up = dev_get_drvdata(&mdev->ofdev.dev);
+	struct uart_pmac_port	*uap = dev_get_drvdata(&mdev->ofdev.dev);
 	
-	if (!up)
+	if (!uap)
 		return -ENODEV;
 
-	if (up->flags & PMACZILOG_FLAG_RSRC_REQUESTED) {
-		macio_release_resources(up->dev);
-		up->flags &= ~PMACZILOG_FLAG_RSRC_REQUESTED;
+	if (uap->flags & PMACZILOG_FLAG_RSRC_REQUESTED) {
+		macio_release_resources(uap->dev);
+		uap->flags &= ~PMACZILOG_FLAG_RSRC_REQUESTED;
 	}
 	dev_set_drvdata(&mdev->ofdev.dev, NULL);
-	up->dev = NULL;
+	uap->dev = NULL;
 	
 	return 0;
 }
@@ -1438,7 +1440,7 @@
 
 	/* 
 	 * First, we need to do a direct OF-based probe pass. We
-	 * do that because we want serial console up before the
+	 * do that because we want serial console uap before the
 	 * macio stuffs calls us back, and since that makes it
 	 * easier to pass the proper number of channels to
 	 * uart_register_driver()
@@ -1490,33 +1492,33 @@
  */
 static void pmz_console_write(struct console *con, const char *s, unsigned int count)
 {
-	struct uart_pmac_port *up = &pmz_ports[con->index];
+	struct uart_pmac_port *uap = &pmz_ports[con->index];
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	spin_lock_irqsave(&uap->port.lock, flags);
 
 	/* Turn of interrupts and enable the transmitter. */
-	write_zsreg(up, R1, up->curregs[1] & ~TxINT_ENAB);
-	write_zsreg(up, R5, up->curregs[5] | TxENABLE | RTS | DTR);
+	write_zsreg(uap, R1, uap->curregs[1] & ~TxINT_ENAB);
+	write_zsreg(uap, R5, uap->curregs[5] | TxENABLE | RTS | DTR);
 
 	for (i = 0; i < count; i++) {
 		/* Wait for the transmit buffer to empty. */
-		while ((read_zsreg(up, R0) & Tx_BUF_EMP) == 0)
+		while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
 			udelay(5);
-		write_zsdata(up, s[i]);
+		write_zsdata(uap, s[i]);
 		if (s[i] == 10) {
-			while ((read_zsreg(up, R0) & Tx_BUF_EMP) == 0)
+			while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0)
 				udelay(5);
-			write_zsdata(up, R13);
+			write_zsdata(uap, R13);
 		}
 	}
 
 	/* Restore the values in the registers. */
-	write_zsreg(up, R1, up->curregs[1]);
+	write_zsreg(uap, R1, uap->curregs[1]);
 	/* Don't disable the transmitter. */
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	spin_unlock_irqrestore(&uap->port.lock, flags);
 }
 
 /*
diff -Nru a/drivers/serial/pmac_zilog.h b/drivers/serial/pmac_zilog.h
--- a/drivers/serial/pmac_zilog.h	Wed Mar 10 10:18:07 2004
+++ b/drivers/serial/pmac_zilog.h	Wed Mar 10 10:18:07 2004
@@ -1,6 +1,8 @@
 #ifndef __PMAC_ZILOG_H__
 #define __PMAC_ZILOG_H__
 
+#define pmz_debug(fmt,arg...)	dev_dbg(&uap->dev->ofdev.dev, fmt, ## arg)
+
 /*
  * At most 2 ESCCs with 2 ports each
  */


