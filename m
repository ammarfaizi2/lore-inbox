Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbUCIXbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUCIXbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:31:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:15826 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262410AbUCIX05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:26:57 -0500
Subject: [PATCH] pmac_zilog 2/2 : Fix various bugs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078874617.9746.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Mar 2004 10:23:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes possible lockups in pmac_zilog when beeing flooded
with incoming data (not that other serial drivers share the same race,
I told Russel about it already). It also fixes some SCC initialization
problems, add some PM callback, and fix the irda setup code.

Please apply,
Ben.

diff -Nru a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
--- a/drivers/serial/pmac_zilog.c	Wed Mar 10 10:18:32 2004
+++ b/drivers/serial/pmac_zilog.c	Wed Mar 10 10:18:32 2004
@@ -35,6 +35,7 @@
  */
 
 #undef DEBUG
+#undef DEBUG_HARD
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -61,21 +62,17 @@
 #include <asm/pmac_feature.h>
 #include <asm/dbdma.h>
 #include <asm/macio.h>
+#include <asm/semaphore.h>
 
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 
 #include "pmac_zilog.h"
 
-#if defined(CONFIG_SERIAL_PMACZILOG_CONSOLE) && defined(CONFIG_PPC64)
-#define HAS_SCCDBG
-extern int sccdbg;
-#endif
-
 /* Not yet implemented */
 #undef HAS_DBDMA
 
-static char version[] __initdata = "pmac_zilog.c 0.5a (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
+static char version[] __initdata = "pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("Driver for the PowerMac serial ports.");
 MODULE_LICENSE("GPL");
@@ -89,6 +86,15 @@
  */
 static struct uart_pmac_port	pmz_ports[MAX_ZS_PORTS];
 static int			pmz_ports_count;
+static DECLARE_MUTEX(pmz_irq_sem);
+
+static struct uart_driver pmz_uart_reg = {
+	.owner		=	THIS_MODULE,
+	.driver_name	=	"ttyS",
+	.devfs_name	=	"tts/",
+	.dev_name	=	"ttyS",
+	.major		=	TTY_MAJOR,
+};
 
 
 /* 
@@ -100,6 +106,9 @@
 {
 	int i;
 
+	if (ZS_IS_ASLEEP(uap))
+		return;
+
 	/* Let pending transmits finish.  */
 	for (i = 0; i < 1000; i++) {
 		unsigned char stat = read_zsreg(uap, R1);
@@ -125,8 +134,15 @@
 	write_zsreg(uap, R10, regs[R10]);
 
 	/* Set TX/RX controls sans the enable bits.  */
-	write_zsreg(uap, R3, regs[R3] & ~RxENABLE);
-	write_zsreg(uap, R5, regs[R5] & ~TxENABLE);
+       	write_zsreg(uap, R3, regs[R3] & ~RxENABLE);
+       	write_zsreg(uap, R5, regs[R5] & ~TxENABLE);
+
+	/* now set R7 "prime" on ESCC */
+	write_zsreg(uap, R15, regs[R15] | EN85C30);
+	write_zsreg(uap, R7, regs[R7P]);
+
+	/* make sure we use R7 "non-prime" on ESCC */
+	write_zsreg(uap, R15, regs[R15] & ~EN85C30);
 
 	/* Synchronous mode config.  */
 	write_zsreg(uap, R6, regs[R6]);
@@ -145,9 +161,6 @@
 	/* Now rewrite R14, with BRENAB (if set).  */
 	write_zsreg(uap, R14, regs[R14]);
 
-	/* External status interrupt control.  */
-	write_zsreg(uap, R15, regs[R15]);
-
 	/* Reset external status interrupts.  */
 	write_zsreg(uap, R0, RES_EXT_INT);
 	write_zsreg(uap, R0, RES_EXT_INT);
@@ -183,43 +196,90 @@
 	}
 }
 
-static void pmz_receive_chars(struct uart_pmac_port *uap, struct pt_regs *regs)
+static struct tty_struct *pmz_receive_chars(struct uart_pmac_port *uap,
+					    struct pt_regs *regs)
 {
-	struct tty_struct *tty = uap->port.info->tty;	/* XXX info==NULL? */
+	struct tty_struct *tty = NULL;
+	unsigned char ch, r1, drop, error;
+	int loops = 0;
+
+ retry:
+	/* The interrupt can be enabled when the port isn't open, typically
+	 * that happens when using one port is open and the other closed (stale
+	 * interrupt) or when one port is used as a console.
+	 */
+	if (!ZS_IS_OPEN(uap)) {
+		pmz_debug("pmz: draining input\n");
+		/* Port is closed, drain input data */
+		for (;;) {
+			if ((++loops) > 1000)
+				goto flood;
+			(void)read_zsreg(uap, R1);
+			write_zsreg(uap, R0, ERR_RES);
+			(void)read_zsdata(uap);
+			ch = read_zsreg(uap, R0);
+			if (!(ch & Rx_CH_AV))
+				break;
+		}
+		return NULL;
+	}
+
+	/* Sanity check, make sure the old bug is no longer happening */
+	if (uap->port.info == NULL || uap->port.info->tty == NULL) {
+		WARN_ON(1);
+		(void)read_zsdata(uap);
+		return NULL;
+	}
+	tty = uap->port.info->tty;
 
 	while (1) {
-		unsigned char ch, r1;
+		error = 0;
+		drop = 0;
 
 		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
+			/* Have to drop the lock here */
+			pmz_debug("pmz: flip overflow\n");
+			spin_unlock(&uap->port.lock);
 			tty->flip.work.func((void *)tty);
+			spin_lock(&uap->port.lock);
 			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-				/* XXX Ignores SysRq when we need it most. Fix. */
-				return;	
+				drop = 1;
+			if (ZS_IS_ASLEEP(uap))
+				return 0;
+			if (!ZS_IS_OPEN(uap))
+				goto retry;
 		}
 
 		r1 = read_zsreg(uap, R1);
+		ch = read_zsdata(uap);
+
 		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR)) {
 			write_zsreg(uap, R0, ERR_RES);
 			zssync(uap);
 		}
 
-		ch = read_zsdata(uap);
 		ch &= uap->parity_mask;
-		if (ch == 0 && uap->prev_status & BRK_ABRT) {
+		if (ch == 0 && uap->prev_status & BRK_ABRT)
 			r1 |= BRK_ABRT;
-			printk("rx break\n");
-		}
 
 		/* A real serial line, record the character and status.  */
+		if (drop)
+			goto next_char;
+
 		*tty->flip.char_buf_ptr = ch;
 		*tty->flip.flag_buf_ptr = TTY_NORMAL;
 		uap->port.icount.rx++;
+
 		if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR | BRK_ABRT)) {
+			error = 1;
 			if (r1 & BRK_ABRT) {
+				pmz_debug("pmz: got break !\n");
 				r1 &= ~(PAR_ERR | CRC_ERR);
 				uap->port.icount.brk++;
-				if (uart_handle_break(&uap->port))
+				if (uart_handle_break(&uap->port)) {
+					pmz_debug("pmz: do handle break !\n");
 					goto next_char;
+				}
 			}
 			else if (r1 & PAR_ERR)
 				uap->port.icount.parity++;
@@ -235,8 +295,10 @@
 			else if (r1 & CRC_ERR)
 				*tty->flip.flag_buf_ptr = TTY_FRAME;
 		}
-		if (uart_handle_sysrq_char(&uap->port, ch, regs))
+		if (uart_handle_sysrq_char(&uap->port, ch, regs)) {
+			pmz_debug("pmz: sysrq swallowed the char\n");
 			goto next_char;
+		}
 
 		if (uap->port.ignore_status_mask == 0xff ||
 		    (r1 & uap->port.ignore_status_mask) == 0) {
@@ -252,12 +314,27 @@
 			tty->flip.count++;
 		}
 	next_char:
+		/* We can get stuck in an infinite loop getting char 0 when the
+		 * line is in a wrong HW state, we break that here.
+		 * When that happens, I disable the receive side of the driver.
+		 * Note that what I've been experiencing is a real irq loop where
+		 * I'm getting flooded regardless of the actual port speed.
+		 * Something stange is going on with the HW
+		 */
+		if ((++loops) > 1000)
+			goto flood;
 		ch = read_zsreg(uap, R0);
 		if (!(ch & Rx_CH_AV))
 			break;
 	}
 
-	tty_flip_buffer_push(tty);
+	return tty;
+ flood:
+	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
+	write_zsreg(uap, R1, uap->curregs[R1]);
+	zssync(uap);
+	dev_err(&uap->dev->ofdev.dev, "pmz: rx irq flood !\n");
+	return tty;
 }
 
 static void pmz_status_handle(struct uart_pmac_port *uap, struct pt_regs *regs)
@@ -268,16 +345,7 @@
 	write_zsreg(uap, R0, RES_EXT_INT);
 	zssync(uap);
 
-#ifdef HAS_SCCDBG
-	if (sccdbg && (status & BRK_ABRT) && !(uap->prev_status & BRK_ABRT)) {
-#ifdef CONFIG_XMON
-		extern void xmon(struct pt_regs *);
-		xmon(regs);
-#endif
-	}
-#endif /* HAS_SCCDBG */
-
-	if (ZS_WANTS_MODEM_STATUS(uap)) {
+	if (ZS_IS_OPEN(uap) && ZS_WANTS_MODEM_STATUS(uap)) {
 		if (status & SYNC_HUNT)
 			uap->port.icount.dsr++;
 
@@ -302,6 +370,8 @@
 {
 	struct circ_buf *xmit;
 
+	if (ZS_IS_ASLEEP(uap))
+		return;
 	if (ZS_IS_CONS(uap)) {
 		unsigned char status = read_zsreg(uap, R0);
 
@@ -369,49 +439,62 @@
 static irqreturn_t pmz_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct uart_pmac_port *uap = dev_id;
-	struct uart_pmac_port *up_a;
-	struct uart_pmac_port *up_b;
+	struct uart_pmac_port *uap_a;
+	struct uart_pmac_port *uap_b;
 	int rc = IRQ_NONE;
+	struct tty_struct *tty;
 	u8 r3;
 
-	up_a = ZS_IS_CHANNEL_A(uap) ? uap : uap->mate;
-	up_b = up_a->mate;
+	uap_a = pmz_get_port_A(uap);
+	uap_b = uap_a->mate;
        
-       	spin_lock(&up_a->port.lock);
-	r3 = read_zsreg(uap, R3);
-	pmz_debug("pmz_irq: %x\n", r3);
+       	spin_lock(&uap_a->port.lock);
+	r3 = read_zsreg(uap_a, R3);
 
+#ifdef DEBUG_HARD
+	pmz_debug("irq, r3: %x\n", r3);
+#endif
        	/* Channel A */
+	tty = NULL;
        	if (r3 & (CHAEXT | CHATxIP | CHARxIP)) {
-		write_zsreg(up_a, R0, RES_H_IUS);
-		zssync(up_a);		
-		pmz_debug("pmz: irq channel A: %x\n", r3);
+		write_zsreg(uap_a, R0, RES_H_IUS);
+		zssync(uap_a);		
        		if (r3 & CHAEXT)
-       			pmz_status_handle(up_a, regs);
+       			pmz_status_handle(uap_a, regs);
 		if (r3 & CHARxIP)
-			pmz_receive_chars(up_a, regs);
+			tty = pmz_receive_chars(uap_a, regs);
        		if (r3 & CHATxIP)
-       			pmz_transmit_chars(up_a);
+       			pmz_transmit_chars(uap_a);
 	        rc = IRQ_HANDLED;
        	}
-       	spin_unlock(&up_a->port.lock);
-	
-       	spin_lock(&up_b->port.lock);
+       	spin_unlock(&uap_a->port.lock);
+	if (tty != NULL)
+		tty_flip_buffer_push(tty);
+
+	if (uap_b->node == NULL)
+		goto out;
+
+       	spin_lock(&uap_b->port.lock);
+	tty = NULL;
 	if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
-		write_zsreg(up_b, R0, RES_H_IUS);
-		zssync(up_b);
-		pmz_debug("pmz: irq channel B: %x\n", r3);
+		write_zsreg(uap_b, R0, RES_H_IUS);
+		zssync(uap_b);
        		if (r3 & CHBEXT)
-       			pmz_status_handle(up_b, regs);
+       			pmz_status_handle(uap_b, regs);
        	       	if (r3 & CHBRxIP)
-       			pmz_receive_chars(up_b, regs);
+       			pmz_receive_chars(uap_b, regs);
        		if (r3 & CHBTxIP)
-       			pmz_transmit_chars(up_b);
+       			pmz_transmit_chars(uap_b);
 	       	rc = IRQ_HANDLED;
        	}
-       	spin_unlock(&up_b->port.lock);
-
+       	spin_unlock(&uap_b->port.lock);
+	if (tty != NULL)
+		tty_flip_buffer_push(tty);
 
+ out:
+#ifdef DEBUG_HARD
+	pmz_debug("irq done.\n");
+#endif
 	return rc;
 }
 
@@ -436,8 +519,12 @@
  */
 static unsigned int pmz_tx_empty(struct uart_port *port)
 {
+	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char status;
 
+	if (ZS_IS_ASLEEP(uap) || uap->node == NULL)
+		return TIOCSER_TEMT;
+
 	status = pmz_peek_status(to_pmz(port));
 	if (status & Tx_BUF_EMP)
 		return TIOCSER_TEMT;
@@ -458,6 +545,10 @@
         /* Do nothing for irda for now... */
 	if (ZS_IS_IRDA(uap))
 		return;
+	/* We get called during boot with a port not up yet */
+	if (ZS_IS_ASLEEP(uap) ||
+	    !(ZS_IS_OPEN(uap) || ZS_IS_CONS(uap)))
+		return;
 
 	set_bits = clear_bits = 0;
 
@@ -475,7 +566,11 @@
 	/* NOTE: Not subject to 'transmitter active' rule.  */ 
 	uap->curregs[R5] |= set_bits;
 	uap->curregs[R5] &= ~clear_bits;
+	if (ZS_IS_ASLEEP(uap))
+		return;
 	write_zsreg(uap, R5, uap->curregs[R5]);
+	pmz_debug("pmz_set_mctrl: set bits: %x, clear bits: %x -> %x\n",
+		  set_bits, clear_bits, uap->curregs[R5]);
 	zssync(uap);
 }
 
@@ -486,9 +581,13 @@
  */
 static unsigned int pmz_get_mctrl(struct uart_port *port)
 {
+	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char status;
 	unsigned int ret;
 
+	if (ZS_IS_ASLEEP(uap) || uap->node == NULL)
+		return 0;
+
 	status = pmz_peek_status(to_pmz(port));
 
 	ret = 0;
@@ -527,6 +626,9 @@
 	uap->flags |= PMACZILOG_FLAG_TX_ACTIVE;
 	uap->flags &= ~PMACZILOG_FLAG_TX_STOPPED;
 
+	if (ZS_IS_ASLEEP(uap) || uap->node == NULL)
+		return;
+
 	status = read_zsreg(uap, R0);
 
 	/* TX busy?  Just wait for the TX done interrupt.  */
@@ -557,14 +659,15 @@
 
 /* 
  * Stop Rx side, basically disable emitting of
- * Rx interrupts on the port
+ * Rx interrupts on the port. We don't disable the rx
+ * side of the chip proper though
  * The port lock is held.
  */
 static void pmz_stop_rx(struct uart_port *port)
 {
 	struct uart_pmac_port *uap = to_pmz(port);
 
-	if (ZS_IS_CONS(uap))
+	if (ZS_IS_ASLEEP(uap) || uap->node == NULL)
 		return;
 
 	pmz_debug("pmz: stop_rx()()\n");
@@ -585,10 +688,14 @@
 	struct uart_pmac_port *uap = to_pmz(port);
 	unsigned char new_reg;
 
+	if (ZS_IS_IRDA(uap) || uap->node == NULL)
+		return;
 	new_reg = uap->curregs[R15] | (DCDIE | SYNCIE | CTSIE);
 	if (new_reg != uap->curregs[R15]) {
 		uap->curregs[R15] = new_reg;
 
+		if (ZS_IS_ASLEEP(uap))
+			return;
 		/* NOTE: Not subject to 'transmitter active' rule.  */ 
 		write_zsreg(uap, R15, uap->curregs[R15]);
 	}
@@ -604,6 +711,8 @@
 	unsigned char set_bits, clear_bits, new_reg;
 	unsigned long flags;
 
+	if (uap->node == NULL)
+		return;
 	set_bits = clear_bits = 0;
 
 	if (break_state)
@@ -618,6 +727,8 @@
 		uap->curregs[R5] = new_reg;
 
 		/* NOTE: Not subject to 'transmitter active' rule.  */ 
+		if (ZS_IS_ASLEEP(uap))
+			return;
 		write_zsreg(uap, R5, uap->curregs[R5]);
 	}
 
@@ -633,39 +744,39 @@
 static int pmz_set_scc_power(struct uart_pmac_port *uap, int state)
 {
 	int delay = 0;
+	int rc;
 
 	if (state) {
-		pmac_call_feature(
+		rc = pmac_call_feature(
 			PMAC_FTR_SCC_ENABLE, uap->node, uap->port_type, 1);
+		pmz_debug("port power on result: %d\n", rc);
 		if (ZS_IS_INTMODEM(uap)) {
-			pmac_call_feature(
+			rc = pmac_call_feature(
 				PMAC_FTR_MODEM_ENABLE, uap->node, 0, 1);
 			delay = 2500;	/* wait for 2.5s before using */
-		} else if (ZS_IS_IRDA(uap))
-			mdelay(50);	/* Do better here once the problems
-			                 * with blocking have been ironed out
-			                 */
+			pmz_debug("modem power result: %d\n", rc);
+		}
 	} else {
 		/* TODO: Make that depend on a timer, don't power down
 		 * immediately
 		 */
 		if (ZS_IS_INTMODEM(uap)) {
-			pmac_call_feature(
+			rc = pmac_call_feature(
 				PMAC_FTR_MODEM_ENABLE, uap->node, 0, 0);
+			pmz_debug("port power off result: %d\n", rc);
 		}
-		pmac_call_feature(
-			PMAC_FTR_SCC_ENABLE, uap->node, uap->port_type, 0);
+		pmac_call_feature(PMAC_FTR_SCC_ENABLE, uap->node, uap->port_type, 0);
 	}
 	return delay;
 }
 
 /*
  * FixZeroBug....Works around a bug in the SCC receving channel.
- * Taken from Darwin code, 15 Sept. 2000  -DanM
+ * Inspired from Darwin code, 15 Sept. 2000  -DanM
  *
  * The following sequence prevents a problem that is seen with O'Hare ASICs
  * (most versions -- also with some Heathrow and Hydra ASICs) where a zero
- * at the input to the receiver becomes 'stuck' and locks uap the receiver.
+ * at the input to the receiver becomes 'stuck' and locks up the receiver.
  * This problem can occur as a result of a zero bit at the receiver input
  * coincident with any of the following events:
  *
@@ -687,20 +798,17 @@
 	write_zsreg(uap, 9, (ZS_IS_CHANNEL_A(uap) ? CHRA : CHRB) | NV);
 	zssync(uap);
 
-	write_zsreg(uap, 4, (X1CLK | EXTSYNC));
-
-	/* I think this is wrong....but, I just copying code....
-	*/
-	write_zsreg(uap, 3, (8 & ~RxENABLE));
-
-	write_zsreg(uap, 5, (8 & ~TxENABLE));
+	write_zsreg(uap, 4, X1CLK | MONSYNC);
+	write_zsreg(uap, 3, Rx8);
+	write_zsreg(uap, 5, Tx8 | RTS);
 	write_zsreg(uap, 9, NV);	/* Didn't we already do this? */
-	write_zsreg(uap, 11, (RCBR | TCBR));
+	write_zsreg(uap, 11, RCBR | TCBR);
 	write_zsreg(uap, 12, 0);
 	write_zsreg(uap, 13, 0);
-	write_zsreg(uap, 14, (LOOPBAK | SSBR));
-	write_zsreg(uap, 14, (LOOPBAK | SSBR | BRENAB));
-	write_zsreg(uap, 3, (8 | RxENABLE));
+	write_zsreg(uap, 14, (LOOPBAK | BRSRC));
+	write_zsreg(uap, 14, (LOOPBAK | BRSRC | BRENAB));
+	write_zsreg(uap, 3, Rx8 | RxENABLE);
+	write_zsreg(uap, 0, RES_EXT_INT);
 	write_zsreg(uap, 0, RES_EXT_INT);
 	write_zsreg(uap, 0, RES_EXT_INT);	/* to kill some time */
 
@@ -710,8 +818,8 @@
 	 * and discard everything in the receive buffer.
 	 */
 	write_zsreg(uap, 9, NV);
-	write_zsreg(uap, 4, PAR_ENAB);
-	write_zsreg(uap, 3, (8 & ~RxENABLE));
+	write_zsreg(uap, 4, X16CLK | SB_MASK);
+	write_zsreg(uap, 3, Rx8);
 
 	while (read_zsreg(uap, 0) & Rx_CH_AV) {
 		(void)read_zsreg(uap, 8);
@@ -721,7 +829,7 @@
 }
 
 /*
- * Real startup routine, powers uap the hardware and sets uap
+ * Real startup routine, powers up the hardware and sets up
  * the SCC. Returns a delay in ms where you need to wait before
  * actually using the port, this is typically the internal modem
  * powerup delay. This routine expect the lock to be taken.
@@ -732,13 +840,14 @@
 
 	memset(&uap->curregs, 0, sizeof(uap->curregs));
 
-	/* Power uap the SCC & underlying hardware (modem/irda) */
+	/* Power up the SCC & underlying hardware (modem/irda) */
 	pwr_delay = pmz_set_scc_power(uap, 1);
 
 	/* Nice buggy HW ... */
 	pmz_fix_zero_bug_scc(uap);
 
-	/* Reset the chip */
+	/* Reset the channel */
+	uap->curregs[R9] = 0;
 	write_zsreg(uap, 9, ZS_IS_CHANNEL_A(uap) ? CHRA : CHRB);
 	zssync(uap);
 	udelay(10);
@@ -752,22 +861,47 @@
 	write_zsreg(uap, R0, RES_H_IUS);
 	write_zsreg(uap, R0, RES_H_IUS);
 
-	/* Remember status for DCD/CTS changes */
-	uap->prev_status = read_zsreg(uap, R0);
+	/* Setup some valid baud rate */
+	uap->curregs[R4] = X16CLK | SB1;
+	uap->curregs[R3] = Rx8;
+	uap->curregs[R5] = Tx8 | RTS;
+	if (!ZS_IS_IRDA(uap))
+		uap->curregs[R5] |= DTR;
+	uap->curregs[R12] = 0;
+	uap->curregs[R13] = 0;
+	uap->curregs[R14] = BRENAB;
 
-	/* Enable receiver and transmitter.  */
-	uap->curregs[R3] |= RxENABLE;
-	uap->curregs[R5] |= TxENABLE | RTS | DTR;
+	/* Clear handshaking */
+	uap->curregs[R15] = 0;
 
 	/* Master interrupt enable */
 	uap->curregs[R9] |= NV | MIE;
 
-	uap->curregs[R1] |= EXT_INT_ENAB | INT_ALL_Rx | TxINT_ENAB;
-       	pmz_maybe_update_regs(uap);
+	pmz_load_zsregs(uap, uap->curregs);
+
+	/* Enable receiver and transmitter.  */
+	write_zsreg(uap, R3, uap->curregs[R3] |= RxENABLE);
+	write_zsreg(uap, R5, uap->curregs[R5] |= TxENABLE);
+
+	/* Remember status for DCD/CTS changes */
+	uap->prev_status = read_zsreg(uap, R0);
+
 
 	return pwr_delay;
 }
 
+static void pmz_irda_reset(struct uart_pmac_port *uap)
+{
+	uap->curregs[R5] |= DTR;
+	write_zsreg(uap, R5, uap->curregs[R5]);
+	zssync(uap);
+	mdelay(110);
+	uap->curregs[R5] &= ~DTR;
+	write_zsreg(uap, R5, uap->curregs[R5]);
+	zssync(uap);
+	mdelay(10);
+}
+
 /*
  * This is the "normal" startup routine, using the above one
  * wrapped with the lock and doing a schedule delay
@@ -780,20 +914,35 @@
 
 	pmz_debug("pmz: startup()\n");
 
-	/* A console is never powered down */
+	if (ZS_IS_ASLEEP(uap))
+		return -EAGAIN;
+	if (uap->node == NULL)
+		return -ENODEV;
+
+	down(&pmz_irq_sem);
+
+	uap->flags |= PMACZILOG_FLAG_IS_OPEN;
+
+	/* A console is never powered down. Else, power up and
+	 * initialize the chip
+	 */
 	if (!ZS_IS_CONS(uap)) {
 		spin_lock_irqsave(&port->lock, flags);
 		pwr_delay = __pmz_startup(uap);
 		spin_unlock_irqrestore(&port->lock, flags);
-	}
-	
+	}	
+
+	pmz_get_port_A(uap)->flags |= PMACZILOG_FLAG_IS_IRQ_ON;
 	if (request_irq(uap->port.irq, pmz_interrupt, SA_SHIRQ, "PowerMac Zilog", uap)) {
 		dev_err(&uap->dev->ofdev.dev,
 			"Unable to register zs interrupt handler.\n");
 		pmz_set_scc_power(uap, 0);
+		up(&pmz_irq_sem);
 		return -ENXIO;
 	}
 
+	up(&pmz_irq_sem);
+
 	/* Right now, we deal with delay by blocking here, I'll be
 	 * smarter later on
 	 */
@@ -803,6 +952,18 @@
 		schedule_timeout((pwr_delay * HZ)/1000);
 	}
 
+	/* IrDA reset is done now */
+	if (ZS_IS_IRDA(uap))
+		pmz_irda_reset(uap);
+
+	/* Enable interrupts emission from the chip */
+	spin_lock_irqsave(&port->lock, flags);
+	uap->curregs[R1] |= INT_ALL_Rx | TxINT_ENAB;
+	if (!ZS_IS_EXTCLK(uap))
+		uap->curregs[R1] |= EXT_INT_ENAB;
+	write_zsreg(uap, R1, uap->curregs[R1]);
+       	spin_unlock_irqrestore(&port->lock, flags);
+
 	pmz_debug("pmz: startup() done.\n");
 
 	return 0;
@@ -815,20 +976,39 @@
 
 	pmz_debug("pmz: shutdown()\n");
 
+	if (uap->node == NULL)
+		return;
+
+	down(&pmz_irq_sem);
+
 	/* Release interrupt handler */
        	free_irq(uap->port.irq, uap);
 
-	if (ZS_IS_CONS(uap))
-		return;
-
 	spin_lock_irqsave(&port->lock, flags);
 
+	uap->flags &= ~PMACZILOG_FLAG_IS_OPEN;
+
+	if (!ZS_IS_OPEN(uap->mate))
+		pmz_get_port_A(uap)->flags &= ~PMACZILOG_FLAG_IS_IRQ_ON;
+
+	/* Disable interrupts */
+	if (!ZS_IS_ASLEEP(uap)) {
+		uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
+		write_zsreg(uap, R1, uap->curregs[R1]);
+		zssync(uap);
+	}
+
+	if (ZS_IS_CONS(uap) || ZS_IS_ASLEEP(uap)) {
+		spin_unlock_irqrestore(&port->lock, flags);
+		up(&pmz_irq_sem);
+		return;
+	}
+
 	/* Disable receiver and transmitter.  */
 	uap->curregs[R3] &= ~RxENABLE;
 	uap->curregs[R5] &= ~TxENABLE;
 
 	/* Disable all interrupts and BRK assertion.  */
-	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
 	uap->curregs[R5] &= ~SND_BRK;
 	pmz_maybe_update_regs(uap);
 
@@ -837,6 +1017,8 @@
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
+	up(&pmz_irq_sem);
+
 	pmz_debug("pmz: shutdown() done.\n");
 }
 
@@ -844,26 +1026,43 @@
  * and local interrupts are disabled.
  */
 static void pmz_convert_to_zs(struct uart_pmac_port *uap, unsigned int cflag,
-			      unsigned int iflag, int baud)
+			      unsigned int iflag, unsigned long baud)
 {
 	int brg;
 
-	switch (baud) {
-	case ZS_CLOCK/16:	/* 230400 */
-		uap->curregs[R4] = X16CLK;
-		uap->curregs[R11] = 0;
-		break;
-	case ZS_CLOCK/32:	/* 115200 */
-	        uap->curregs[R4] = X32CLK;
-		uap->curregs[R11] = 0;
-		break;
-	default:
-		uap->curregs[R4] = X16CLK;
-		uap->curregs[R11] = TCBR | RCBR;
-		brg = BPS_TO_BRG(baud, ZS_CLOCK / 16);
-		uap->curregs[R12] = (brg & 255);
-		uap->curregs[R13] = ((brg >> 8) & 255);
-		uap->curregs[R14] = BRENAB;
+
+	/* Switch to external clocking for IrDA high clock rates. That
+	 * code could be re-used for Midi interfaces with different
+	 * multipliers
+	 */
+	if (baud >= 115200 && ZS_IS_IRDA(uap)) {
+		uap->curregs[R4] = X1CLK;
+		uap->curregs[R11] = RCTRxCP | TCTRxCP;
+		uap->curregs[R14] = 0; /* BRG off */
+		uap->curregs[R12] = 0;
+		uap->curregs[R13] = 0;
+		uap->flags |= PMACZILOG_FLAG_IS_EXTCLK;
+	} else {
+		switch (baud) {
+		case ZS_CLOCK/16:	/* 230400 */
+			uap->curregs[R4] = X16CLK;
+			uap->curregs[R11] = 0;
+			uap->curregs[R14] = 0;
+			break;
+		case ZS_CLOCK/32:	/* 115200 */
+			uap->curregs[R4] = X32CLK;
+			uap->curregs[R11] = 0;
+			uap->curregs[R14] = 0;
+			break;
+		default:
+			uap->curregs[R4] = X16CLK;
+			uap->curregs[R11] = TCBR | RCBR;
+			brg = BPS_TO_BRG(baud, ZS_CLOCK / 16);
+			uap->curregs[R12] = (brg & 255);
+			uap->curregs[R13] = ((brg >> 8) & 255);
+			uap->curregs[R14] = BRENAB;
+		}
+		uap->flags &= ~PMACZILOG_FLAG_IS_EXTCLK;
 	}
 
 	/* Character size, stop bits, and parity. */
@@ -926,38 +1125,54 @@
 		uap->port.ignore_status_mask = 0xff;
 }
 
-static void pmz_irda_rts_pulses(struct uart_pmac_port *uap, int w)
-{
-	udelay(w);
-	write_zsreg(uap, 5, Tx8 | TxENABLE);
-	zssync(uap);
-	udelay(2);
-	write_zsreg(uap, 5, Tx8 | TxENABLE | RTS);
-	zssync(uap);
-	udelay(8);
-	write_zsreg(uap, 5, Tx8 | TxENABLE);
-	zssync(uap);
-	udelay(4);
-	write_zsreg(uap, 5, Tx8 | TxENABLE | RTS);
-	zssync(uap);
-}
 
 /*
  * Set the irda codec on the imac to the specified baud rate.
  */
-static void pmz_irda_setup(struct uart_pmac_port *uap, int cflags)
+static void pmz_irda_setup(struct uart_pmac_port *uap, unsigned long *baud)
 {
-	int code, speed, t;
-
-	speed = cflags & CBAUD;
-	if (speed < B2400 || speed > B115200)
-		return;
-	code = 0x4d + B115200 - speed;
+	u8 cmdbyte;
+	int t, version;
 
-	/* disable serial interrupts and receive DMA */
-	write_zsreg(uap, 1, uap->curregs[1] & ~0x9f);
+	switch (*baud) {
+	/* SIR modes */
+	case 2400:
+		cmdbyte = 0x53;
+		break;
+	case 4800:
+		cmdbyte = 0x52;
+		break;
+	case 9600:
+		cmdbyte = 0x51;
+		break;
+	case 19200:
+		cmdbyte = 0x50;
+		break;
+	case 38400:
+		cmdbyte = 0x4f;
+		break;
+	case 57600:
+		cmdbyte = 0x4e;
+		break;
+	case 115200:
+		cmdbyte = 0x4d;
+		break;
+	/* The FIR modes aren't really supported at this point, how
+	 * do we select the speed ? via the FCR on KeyLargo ?
+	 */
+	case 1152000:
+		cmdbyte = 0;
+		break;
+	case 4000000:
+		cmdbyte = 0;
+		break;
+	default: /* 9600 */
+		cmdbyte = 0x51;
+		*baud = 9600;
+		break;
+	}
 
-	/* wait for transmitter to drain */
+	/* Wait for transmitter to drain */
 	t = 10000;
 	while ((read_zsreg(uap, R0) & Tx_BUF_EMP) == 0
 	       || (read_zsreg(uap, R1) & ALL_SNT) == 0) {
@@ -967,113 +1182,170 @@
 		}
 		udelay(10);
 	}
-	udelay(100);
-
-	/* set to 8 bits, no parity, 19200 baud, RTS on, DTR off */
-	write_zsreg(uap, R4, X16CLK | SB1);
-	write_zsreg(uap, R11, TCBR | RCBR);
-	t = BPS_TO_BRG(19200, ZS_CLOCK/16);
-	write_zsreg(uap, R12, t);
-	write_zsreg(uap, R13, t >> 8);
-	write_zsreg(uap, R14, BRENAB);
-	write_zsreg(uap, R3, Rx8 | RxENABLE);
-	write_zsreg(uap, R5, Tx8 | TxENABLE | RTS);
-	zssync(uap);
 
-	/* set TxD low for ~104us and pulse RTS */
-	udelay(1000);
-	write_zsdata(uap, 0xfe);
-	pmz_irda_rts_pulses(uap, 150);
-	pmz_irda_rts_pulses(uap, 180);
-	pmz_irda_rts_pulses(uap, 50);
-	udelay(100);
+	/* Drain the receiver too */
+	t = 100;
+	(void)read_zsdata(uap);
+	(void)read_zsdata(uap);
+	(void)read_zsdata(uap);
+	mdelay(10);
+	while (read_zsreg(uap, R0) & Rx_CH_AV) {
+		read_zsdata(uap);
+		mdelay(10);
+		if (--t <= 0) {
+			dev_err(&uap->dev->ofdev.dev, "receiver didn't drain\n");
+			return;
+		}
+	}
 
-	/* assert DTR, wait 30ms, talk to the chip */
-	write_zsreg(uap, R5, Tx8 | TxENABLE | RTS | DTR);
+	/* Switch to command mode */
+	uap->curregs[R5] |= DTR;
+	write_zsreg(uap, R5, uap->curregs[R5]);
 	zssync(uap);
-	mdelay(30);
-	while (read_zsreg(uap, R0) & Rx_CH_AV)
-		read_zsdata(uap);
+       	mdelay(1);
 
+	/* Switch SCC to 19200 */
+	pmz_convert_to_zs(uap, CS8, 0, 19200);		
+	pmz_load_zsregs(uap, uap->curregs);
+       	mdelay(1);
+
+	/* Write get_version command byte */
 	write_zsdata(uap, 1);
-	t = 1000;
+	t = 5000;
 	while ((read_zsreg(uap, R0) & Rx_CH_AV) == 0) {
 		if (--t <= 0) {
 			dev_err(&uap->dev->ofdev.dev,
-				"irda_setup timed out on 1st byte\n");
+				"irda_setup timed out on get_version byte\n");
 			goto out;
 		}
 		udelay(10);
 	}
-	t = read_zsdata(uap);
-	if (t != 4)
-		dev_err(&uap->dev->ofdev.dev, "irda_setup 1st byte = %x\n", t);
+	version = read_zsdata(uap);
 
-	write_zsdata(uap, code);
-	t = 1000;
+	if (version < 4) {
+		dev_info(&uap->dev->ofdev.dev, "IrDA: dongle version %d not supported\n",
+			 version);
+		goto out;
+	}
+
+	/* Send speed mode */
+	write_zsdata(uap, cmdbyte);
+	t = 5000;
 	while ((read_zsreg(uap, R0) & Rx_CH_AV) == 0) {
 		if (--t <= 0) {
 			dev_err(&uap->dev->ofdev.dev,
-				"irda_setup timed out on 2nd byte\n");
+				"irda_setup timed out on speed mode byte\n");
 			goto out;
 		}
 		udelay(10);
 	}
 	t = read_zsdata(uap);
-	if (t != code)
+	if (t != cmdbyte)
 		dev_err(&uap->dev->ofdev.dev,
-			"irda_setup 2nd byte = %x (%x)\n", t, code);
+			"irda_setup speed mode byte = %x (%x)\n", t, cmdbyte);
+
+	dev_info(&uap->dev->ofdev.dev, "IrDA setup for %ld bps, dongle version: %d\n",
+		 *baud, version);
+
+	(void)read_zsdata(uap);
+	(void)read_zsdata(uap);
+	(void)read_zsdata(uap);
 
-	/* Drop DTR again and do some more RTS pulses */
  out:
-	udelay(100);
-	write_zsreg(uap, R5, Tx8 | TxENABLE | RTS);
-	pmz_irda_rts_pulses(uap, 80);
-
-	/* We should be right to go now.  We assume that load_zsregs
-	   will get called soon to load uap the correct baud rate etc. */
-	uap->curregs[R5] = (uap->curregs[R5] | RTS) & ~DTR;
+	/* Switch back to data mode */
+	uap->curregs[R5] &= ~DTR;
+	write_zsreg(uap, R5, uap->curregs[R5]);
+	zssync(uap);
+
+	(void)read_zsdata(uap);
+	(void)read_zsdata(uap);
+	(void)read_zsdata(uap);
 }
 
-/* The port lock is not held.  */
-static void pmz_set_termios(struct uart_port *port, struct termios *termios,
-			    struct termios *old)
+
+static void __pmz_set_termios(struct uart_port *port, struct termios *termios,
+			      struct termios *old)
 {
 	struct uart_pmac_port *uap = to_pmz(port);
-	unsigned long flags;
-	int baud;
+	unsigned long baud;
 
 	pmz_debug("pmz: set_termios()\n");
 
-	baud = uart_get_baud_rate(port, termios, old, 1200, 230400);
-
-	spin_lock_irqsave(&uap->port.lock, flags);
+	if (ZS_IS_ASLEEP(uap))
+		return;
 
-	pmz_convert_to_zs(uap, termios->c_cflag, termios->c_iflag, baud);
+	memcpy(&uap->termios_cache, termios, sizeof(struct termios));
 
-	if (UART_ENABLE_MS(&uap->port, termios->c_cflag)) {
-		uap->curregs[R15] |= DCDIE | SYNCIE | CTSIE;
-		uap->flags |= PMACZILOG_FLAG_MODEM_STATUS;
+	/* XXX Check which revs of machines actually allow 1 and 4Mb speeds
+	 * on the IR dongle. Note that the IRTTY driver currently doesn't know
+	 * about the FIR mode and high speed modes. So these are unused. For
+	 * implementing proper support for these, we should probably add some
+	 * DMA as well, at least on the Rx side, which isn't a simple thing
+	 * at this point.
+	 */
+	if (ZS_IS_IRDA(uap)) {
+		/* Calc baud rate */
+		baud = uart_get_baud_rate(port, termios, old, 1200, 4000000);
+		pmz_debug("pmz: switch IRDA to %ld bauds\n", baud);
+		/* Cet the irda codec to the right rate */
+		pmz_irda_setup(uap, &baud);
+		/* Set final baud rate */
+		pmz_convert_to_zs(uap, termios->c_cflag, termios->c_iflag, baud);
+		pmz_load_zsregs(uap, uap->curregs);
+		zssync(uap);
 	} else {
-		uap->curregs[R15] &= ~(DCDIE | SYNCIE | CTSIE);
-		uap->flags &= ~PMACZILOG_FLAG_MODEM_STATUS;
+		baud = uart_get_baud_rate(port, termios, old, 1200, 230400);
+		pmz_convert_to_zs(uap, termios->c_cflag, termios->c_iflag, baud);
+		/* Make sure modem status interrupts are correctly configured */
+		if (UART_ENABLE_MS(&uap->port, termios->c_cflag)) {
+			uap->curregs[R15] |= DCDIE | SYNCIE | CTSIE;
+			uap->flags |= PMACZILOG_FLAG_MODEM_STATUS;
+		} else {
+			uap->curregs[R15] &= ~(DCDIE | SYNCIE | CTSIE);
+			uap->flags &= ~PMACZILOG_FLAG_MODEM_STATUS;
+		}
+
+		/* Load registers to the chip */
+		pmz_maybe_update_regs(uap);
 	}
+	pmz_debug("pmz: set_termios() done.\n");
+}
 
-	/* set the irda codec to the right rate */
-	if (ZS_IS_IRDA(uap))
-		pmz_irda_setup(uap, termios->c_cflag);
+/* The port lock is not held.  */
+static void pmz_set_termios(struct uart_port *port, struct termios *termios,
+			    struct termios *old)
+{
+	struct uart_pmac_port *uap = to_pmz(port);
+	unsigned long flags;
 
-	/* Load registers to the chip */
-	pmz_maybe_update_regs(uap);
+	spin_lock_irqsave(&port->lock, flags);	
 
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	/* Disable IRQs on the port */
+	uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
+	write_zsreg(uap, R1, uap->curregs[R1]);
 
-	pmz_debug("pmz: set_termios() done.\n");
+	/* Setup new port configuration */
+	__pmz_set_termios(port, termios, old);
+
+	/* Re-enable IRQs on the port */
+	if (ZS_IS_OPEN(uap)) {
+		uap->curregs[R1] |= INT_ALL_Rx | TxINT_ENAB;
+		if (!ZS_IS_EXTCLK(uap))
+			uap->curregs[R1] |= EXT_INT_ENAB;
+		write_zsreg(uap, R1, uap->curregs[R1]);
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static const char *pmz_type(struct uart_port *port)
 {
-	return "PowerMac Zilog";
+	struct uart_pmac_port *uap = to_pmz(port);
+
+	if (ZS_IS_IRDA(uap))
+		return "Z85c30 ESCC - Infrared port";
+	else if (ZS_IS_INTMODEM(uap))
+		return "Z85c30 ESCC - Internal modem";
+	return "Z85c30 ESCC - Serial port";
 }
 
 /* We do not request/release mappings of the registers here, this
@@ -1218,6 +1490,12 @@
 	uap->port.type = PORT_PMAC_ZILOG;
 	uap->port.flags = 0;
 
+	/* Setup some valid baud rate information in the register
+	 * shadows so we don't write crap there before baud rate is
+	 * first initialized.
+	 */
+	pmz_convert_to_zs(uap, CS8, 0, 9600);
+
 	return 0;
 }
 
@@ -1250,7 +1528,8 @@
 			uap->dev = mdev;
 			dev_set_drvdata(&mdev->ofdev.dev, uap);
 			if (macio_request_resources(uap->dev, "pmac_zilog"))
-				printk(KERN_WARNING "%s: Failed to request resource, port still active\n",
+				printk(KERN_WARNING "%s: Failed to request resource"
+				       ", port still active\n",
 				       uap->node->name);
 			else
 				uap->flags |= PMACZILOG_FLAG_RSRC_REQUESTED;				
@@ -1280,6 +1559,123 @@
 	return 0;
 }
 
+
+static int pmz_suspend(struct macio_dev *mdev, u32 pm_state)
+{
+	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
+	struct uart_state *state = pmz_uart_reg.state + uap->port.line;
+	unsigned long flags;
+
+	if (uap == NULL)
+		return 0;
+
+	if (pm_state == mdev->ofdev.dev.power_state || pm_state < 2)
+		return 0;
+
+	down(&pmz_irq_sem);
+	down(&state->sem);
+
+	spin_lock_irqsave(&uap->port.lock, flags);
+
+	if (ZS_IS_OPEN(uap) || ZS_IS_CONS(uap)) {
+		/* Disable receiver and transmitter.  */
+		uap->curregs[R3] &= ~RxENABLE;
+		uap->curregs[R5] &= ~TxENABLE;
+
+		/* Disable all interrupts and BRK assertion.  */
+		uap->curregs[R1] &= ~(EXT_INT_ENAB | TxINT_ENAB | RxINT_MASK);
+		uap->curregs[R5] &= ~SND_BRK;
+		pmz_load_zsregs(uap, uap->curregs);
+		uap->flags |= PMACZILOG_FLAG_IS_ASLEEP;
+		mb();
+	}
+
+	spin_unlock_irqrestore(&uap->port.lock, flags);
+
+	if (ZS_IS_OPEN(uap) || ZS_IS_OPEN(uap->mate))
+		if (ZS_IS_ASLEEP(uap->mate) && ZS_IS_IRQ_ON(pmz_get_port_A(uap))) {
+			pmz_get_port_A(uap)->flags &= ~PMACZILOG_FLAG_IS_IRQ_ON;
+			disable_irq(uap->port.irq);
+		}
+
+	if (ZS_IS_CONS(uap))
+		uap->port.cons->flags &= ~CON_ENABLED;
+
+	/* Shut the chip down */
+	pmz_set_scc_power(uap, 0);
+
+	up(&state->sem);
+	up(&pmz_irq_sem);
+
+	mdev->ofdev.dev.power_state = pm_state;
+
+	return 0;
+}
+
+
+static int pmz_resume(struct macio_dev *mdev)
+{
+	struct uart_pmac_port *uap = dev_get_drvdata(&mdev->ofdev.dev);
+	struct uart_state *state = pmz_uart_reg.state + uap->port.line;
+	unsigned long flags;
+	int pwr_delay;
+
+	if (uap == NULL)
+		return 0;
+
+	if (mdev->ofdev.dev.power_state == 0)
+		return 0;
+	
+	down(&pmz_irq_sem);
+	down(&state->sem);
+
+	spin_lock_irqsave(&uap->port.lock, flags);
+	if (!ZS_IS_OPEN(uap) && !ZS_IS_CONS(uap)) {
+		spin_unlock_irqrestore(&uap->port.lock, flags);
+		goto bail;
+	}
+	pwr_delay = __pmz_startup(uap);
+
+	/* Take care of config that may have changed while asleep */
+	__pmz_set_termios(&uap->port, &uap->termios_cache, NULL);
+
+	if (ZS_IS_OPEN(uap)) {
+		/* Enable interrupts */		
+		uap->curregs[R1] |= INT_ALL_Rx | TxINT_ENAB;
+		if (!ZS_IS_EXTCLK(uap))
+			uap->curregs[R1] |= EXT_INT_ENAB;
+		write_zsreg(uap, R1, uap->curregs[R1]);
+	}
+
+	spin_unlock_irqrestore(&uap->port.lock, flags);
+
+	if (ZS_IS_CONS(uap))
+		uap->port.cons->flags |= CON_ENABLED;
+
+	/* Re-enable IRQ on the controller */
+	if (ZS_IS_OPEN(uap) && !ZS_IS_IRQ_ON(pmz_get_port_A(uap))) {
+		pmz_get_port_A(uap)->flags |= PMACZILOG_FLAG_IS_IRQ_ON;
+		enable_irq(uap->port.irq);
+	}
+
+	up(&state->sem);
+	up(&pmz_irq_sem);
+
+	/* Right now, we deal with delay by blocking here, I'll be
+	 * smarter later on
+	 */
+	if (pwr_delay != 0) {
+		pmz_debug("pmz: delaying %d ms\n", pwr_delay);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout((pwr_delay * HZ)/1000);
+	}
+
+ bail:
+	mdev->ofdev.dev.power_state = 0;
+
+	return 0;
+}
+
 /*
  * Probe all ports in the system and build the ports array, we register
  * with the serial layer at this point, the macio-type probing is only
@@ -1309,7 +1705,7 @@
 			else if (strncmp(np->name, "ch-b", 4) == 0)
 				node_b = of_node_get(np);
 		}
-		if (!node_a || !node_b) {
+		if (!node_a && !node_b) {
 			of_node_put(node_a);
 			of_node_put(node_b);
 			printk(KERN_ERR "pmac_zilog: missing node %c for escc %s\n",
@@ -1332,7 +1728,7 @@
 		 * Setup the ports for real
 		 */
 		rc = pmz_init_port(&pmz_ports[count]);
-		if (rc == 0)
+		if (rc == 0 && node_b != NULL)
 			rc = pmz_init_port(&pmz_ports[count+1]);
 		if (rc != 0) {
 			of_node_put(node_a);
@@ -1350,14 +1746,6 @@
 	return 0;
 }
 
-static struct uart_driver pmz_uart_reg = {
-	.owner		=	THIS_MODULE,
-	.driver_name	=	"ttyS",
-	.devfs_name	=	"tts/",
-	.dev_name	=	"ttyS",
-	.major		=	TTY_MAJOR,
-};
-
 #ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE
 
 static void pmz_console_write(struct console *con, const char *s, unsigned int count);
@@ -1402,6 +1790,7 @@
 	 */
 	for (i = 0; i < pmz_ports_count; i++) {
 		struct uart_pmac_port *uport = &pmz_ports[i];
+		/* NULL node may happen on wallstreet */
 		if (uport->node != NULL)
 			uart_add_one_port(&pmz_uart_reg, &uport->port);
 	}
@@ -1430,17 +1819,17 @@
 	.match_table	= pmz_match,
 	.probe		= pmz_attach,
 	.remove		= pmz_detach,
-//	.suspend	= pmz_suspend, *** NYI
-//	.resume		= pmz_resume,  *** NYI
+	.suspend	= pmz_suspend,
+       	.resume		= pmz_resume,
 };
 
 static int __init init_pmz(void)
 {
-	printk(KERN_DEBUG "%s\n", version);
+	printk(KERN_INFO "%s\n", version);
 
 	/* 
 	 * First, we need to do a direct OF-based probe pass. We
-	 * do that because we want serial console uap before the
+	 * do that because we want serial console up before the
 	 * macio stuffs calls us back, and since that makes it
 	 * easier to pass the proper number of channels to
 	 * uart_register_driver()
@@ -1526,6 +1915,7 @@
  */
 static int __init pmz_console_setup(struct console *co, char *options)
 {
+	struct uart_pmac_port *uap;
 	struct uart_port *port;
 	int baud = 38400;
 	int bits = 8;
@@ -1537,7 +1927,8 @@
 	 * XServe's default to 57600 bps
 	 */
 	if (machine_is_compatible("RackMac1,1")
-	 || machine_is_compatible("RackMac1,2"))
+	    || machine_is_compatible("RackMac1,2")
+	    || machine_is_compatible("MacRISC4"))
 	 	baud = 57600;
 
 	/*
@@ -1547,12 +1938,15 @@
 	 */
 	if (co->index >= pmz_ports_count)
 		co->index = 0;
-	port = &pmz_ports[co->index].port;
+	uap = &pmz_ports[co->index];
+	if (uap->node == NULL)
+		return -ENODEV;
+	port = &uap->port;
 
 	/*
 	 * Mark port as beeing a console
 	 */
-	port->flags |= PMACZILOG_FLAG_IS_CONS;
+	uap->flags |= PMACZILOG_FLAG_IS_CONS;
 
 	/*
 	 * Temporary fix for uart layer who didn't setup the spinlock yet
@@ -1562,7 +1956,7 @@
 	/*
 	 * Enable the hardware
 	 */
-	pwr_delay = __pmz_startup(&pmz_ports[co->index]);
+	pwr_delay = __pmz_startup(uap);
 	if (pwr_delay)
 		mdelay(pwr_delay);
 	
diff -Nru a/drivers/serial/pmac_zilog.h b/drivers/serial/pmac_zilog.h
--- a/drivers/serial/pmac_zilog.h	Wed Mar 10 10:18:32 2004
+++ b/drivers/serial/pmac_zilog.h	Wed Mar 10 10:18:32 2004
@@ -11,7 +11,7 @@
 /* 
  * We wrap our port structure around the generic uart_port.
  */
-#define NUM_ZSREGS    16
+#define NUM_ZSREGS    17
 
 struct uart_pmac_port {
 	struct uart_port		port;
@@ -43,6 +43,10 @@
 #define PMACZILOG_FLAG_IS_INTMODEM	0x00000200
 #define PMACZILOG_FLAG_HAS_DMA		0x00000400
 #define PMACZILOG_FLAG_RSRC_REQUESTED	0x00000800
+#define PMACZILOG_FLAG_IS_ASLEEP	0x00001000
+#define PMACZILOG_FLAG_IS_OPEN		0x00002000
+#define PMACZILOG_FLAG_IS_IRQ_ON	0x00004000
+#define PMACZILOG_FLAG_IS_EXTCLK	0x00008000
 
 	unsigned char			parity_mask;
 	unsigned char			prev_status;
@@ -54,10 +58,19 @@
 	unsigned int			rx_dma_irq;
 	volatile struct dbdma_regs	*tx_dma_regs;
 	volatile struct dbdma_regs	*rx_dma_regs;
+
+	struct termios			termios_cache;
 };
 
 #define to_pmz(p) ((struct uart_pmac_port *)(p))
 
+static inline struct uart_pmac_port *pmz_get_port_A(struct uart_pmac_port *uap)
+{
+	if (uap->flags & PMACZILOG_FLAG_IS_CHANNEL_A)
+		return uap;
+	return uap->mate;
+}
+
 /*
  * Register acessors. Note that we don't need to enforce a recovery
  * delay on PCI PowerMac hardware, it's dealt in HW by the MacIO chip,
@@ -122,6 +135,7 @@
 #define	R13	13
 #define	R14	14
 #define	R15	15
+#define	R7P	16
 
 #define	NULLCODE	0	/* Null Code */
 #define	POINT_HIGH	0x8	/* Select upper half of registers */
@@ -359,5 +373,9 @@
 #define ZS_IS_IRDA(UP)			((UP)->flags & PMACZILOG_FLAG_IS_IRDA)
 #define ZS_IS_INTMODEM(UP)	       	((UP)->flags & PMACZILOG_FLAG_IS_INTMODEM)
 #define ZS_HAS_DMA(UP)			((UP)->flags & PMACZILOG_FLAG_HAS_DMA)
+#define ZS_IS_ASLEEP(UP)       		((UP)->flags & PMACZILOG_FLAG_IS_ASLEEP)
+#define ZS_IS_OPEN(UP)       		((UP)->flags & PMACZILOG_FLAG_IS_OPEN)
+#define ZS_IS_IRQ_ON(UP)       		((UP)->flags & PMACZILOG_FLAG_IS_IRQ_ON)
+#define ZS_IS_EXTCLK(UP)       		((UP)->flags & PMACZILOG_FLAG_IS_EXTCLK)
 
 #endif /* __PMAC_ZILOG_H__ */


