Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291397AbSAaXOh>; Thu, 31 Jan 2002 18:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291394AbSAaXO0>; Thu, 31 Jan 2002 18:14:26 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:39089 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291393AbSAaXN6>; Thu, 31 Jan 2002 18:13:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stefani Seibold <stefani@seibold.net>
To: rmk@arm.linux.org.uk
Subject: fix for shared interrupt in serial i/o
Date: Fri, 1 Feb 2002 00:12:33 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
Message-ID: <16WQOh-04YPE8C@fmrl10.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

the serial driver in linux seems to have some troubles with
shared serial interrupts in all know linux kernel.

There is a build in support for shared irqs, but this would
fail under some circumstance.

The problem is the stupid edge triggered interrupt signal
used in standard ibm pc.

The loop for handling shared irq for serial ports, would look
on each com port, if a interrupt is pending. This would be
done as long, as all com ports on this irq line will report
"nothing to do".

But if a port will have something to do again, after it was
checked, this could kill the whole communication on the
IRQ line.

Have a look on this small example (can only correct viewed 
with non-proportional font):

Time-->

IRQ Signale ____----------------
PORT A      ____----___---------
PORT B      _____----___________
PORT C      _____--_____________

Test Port   ____ABCABCAB________ 
Found IRQ       +++++--- 
                       ^
                all ports processed, shared irq handler exit


The port A raise the irq, and the shared irq handler will do its
job. Port A will be checked and processed, in the meantime port
B and C will also raised.
Than Port B will checked and processed and same for port C.
Port C IRQ well go down. Port A is checked and processed again,
and the IRQ Signal of PORT A will go down too. The same for the
port B.
Port C has nothing to do, also Port A. But after checking the
Port A, it will raise again the IRQ, but the shared interrupt
handler cannot recognize this.
So Port B will be checked, and all Ports seems to be processed,
because any port reported "nothing to do", at the time there was
accessed.
The shared interrupt handler leaved and the irq signal continues
to stay high. On an edge triggered interrupt like in the standard
pc, the interrupt will never occur again.
                 
My fix switches off all interrupts of the com ports on this
irq line and switch it on again, after all com ports are processed.

Have a look on the next example, including the fix:


Time-->

IRQ Signale ____-________-...
PORT A      ____-----___--...
PORT B      ______----____...
PORT C      ______--______...

Test Port   ____ ABCABCAB ...
Found IRQ        +++++--- 
                ^        ^
       Disable IRQ     Enable IRQ

You can see, the IRQ Signal will raise again, after all com ports
are processed, because port A has something to do. This will trigger
the interrupt controller again.

I don't know, who is currently the maintainer of the serial driver.
Can anybody can tell me ;-)

The fix also includes a small patch, to make low_latency also a
flag to parameter the fifo trigger level to 1 (makes the hardware
low latency too), a backport from 2.4.x changes, and a more precise
timeout calculation. 

If you like the patch, please apply it. I can make also this patch for
kernel 2.4 and 2.5 available, if somebody want apply it to this
kernel tree.

Greetings,
Stefani

Here comes the patch:
-----------------------------------
--- linux.old/drivers/char/serial.c	Sun Mar 25 18:37:31 2001
+++ linux.new/drivers/char/serial.c	Fri Jan 25 16:21:34 2002
@@ -32,6 +32,12 @@
  *  4/98: Added changes to support the ARM architecture proposed by
  * 	  Russell King
  *
+ *  1/02  Fixed CONFIG_SERIAL_SHARE_IRQ support, so it doesn't matter
+ *        if it the interrupt is edge or level triggered
+ *        Merge some kernel 2.4 bug fixes
+ *        and  done some perfomance optimations
+ *        Stefani Seibold <Stefani@Seibold.net>
+ *
  * This module exports the following rs232 io functions:
  *
  *	int rs_init(void);
@@ -218,6 +224,14 @@
 static struct termios *serial_termios[NR_PORTS];
 static struct termios *serial_termios_locked[NR_PORTS];
 
+/*
+ * return values for
+ * receive_chars(), check_modem_status() and transmit_chars()
+ */
+#define F_SER_NOACTION	0	/* if no bit is set, then nothing was to do */
+#define F_SER_PROCESSED	1	/* call was succesfully processed */
+#define F_SER_IER	2	/* ier shadow register in async_struct changed */ 
+
 #ifndef MIN
 #define MIN(a,b)	((a) < (b) ? (a) : (b))
 #endif
@@ -381,39 +395,49 @@
 	mark_bh(SERIAL_BH);
 }
 
-static _INLINE_ void receive_chars(struct async_struct *info,
-				 int *status)
+static _INLINE_ int receive_chars(struct async_struct *info)
 {
 	struct tty_struct *tty = info->tty;
 	unsigned char ch;
 	int ignored = 0;
 	struct	async_icount *icount;
+	int status;
+
+	if ((info->IER & (UART_IER_RLSI | UART_IER_RDI))==0)
+		return F_SER_NOACTION;
+
+	status = serial_inp(info, UART_LSR);
+
+	if ((status & (UART_LSR_DR | UART_LSR_BI | UART_LSR_PE | UART_LSR_FE | UART_LSR_OE)) == 0)
+		return F_SER_NOACTION;
 
 	icount = &info->state->icount;
 	do {
 		ch = serial_inp(info, UART_RX);
-		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
+		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+			printk("TTY_FLIPBUF_SIZE\n");
 			break;
+		}
 		*tty->flip.char_buf_ptr = ch;
 		icount->rx++;
 		
 #ifdef SERIAL_DEBUG_INTR
-		printk("DR%02x:%02x...", ch, *status);
+		printk("DR%02x:%02x...", ch, status);
 #endif
 		*tty->flip.flag_buf_ptr = 0;
-		if (*status & (UART_LSR_BI | UART_LSR_PE |
+		if (status & (UART_LSR_BI | UART_LSR_PE |
 			       UART_LSR_FE | UART_LSR_OE)) {
 			/*
 			 * For statistics only
 			 */
-			if (*status & UART_LSR_BI) {
-				*status &= ~(UART_LSR_FE | UART_LSR_PE);
+			if (status & UART_LSR_BI) {
+				status &= ~(UART_LSR_FE | UART_LSR_PE);
 				icount->brk++;
-			} else if (*status & UART_LSR_PE)
+			} else if (status & UART_LSR_PE)
 				icount->parity++;
-			else if (*status & UART_LSR_FE)
+			else if (status & UART_LSR_FE)
 				icount->frame++;
-			if (*status & UART_LSR_OE)
+			if (status & UART_LSR_OE)
 				icount->overrun++;
 
 			/*
@@ -421,25 +445,25 @@
 			 * ignored, and mask off conditions which
 			 * should be ignored.
 			 */
-			if (*status & info->ignore_status_mask) {
+			if (status & info->ignore_status_mask) {
 				if (++ignored > 100)
 					break;
 				goto ignore_char;
 			}
-			*status &= info->read_status_mask;
+			status &= info->read_status_mask;
 		
-			if (*status & (UART_LSR_BI)) {
+			if (status & (UART_LSR_BI)) {
 #ifdef SERIAL_DEBUG_INTR
 				printk("handling break....");
 #endif
 				*tty->flip.flag_buf_ptr = TTY_BREAK;
 				if (info->flags & ASYNC_SAK)
 					do_SAK(tty);
-			} else if (*status & UART_LSR_PE)
+			} else if (status & UART_LSR_PE)
 				*tty->flip.flag_buf_ptr = TTY_PARITY;
-			else if (*status & UART_LSR_FE)
+			else if (status & UART_LSR_FE)
 				*tty->flip.flag_buf_ptr = TTY_FRAME;
-			if (*status & UART_LSR_OE) {
+			if (status & UART_LSR_OE) {
 				/*
 				 * Overrun is special, since it's
 				 * reported immediately, and doesn't
@@ -457,28 +481,38 @@
 		tty->flip.char_buf_ptr++;
 		tty->flip.count++;
 	ignore_char:
-		*status = serial_inp(info, UART_LSR);
-	} while (*status & UART_LSR_DR);
+		status = serial_inp(info, UART_LSR);
+	} while (status & (UART_LSR_DR | UART_LSR_BI | UART_LSR_PE | UART_LSR_FE | UART_LSR_OE));
 	tty_flip_buffer_push(tty);
+
+	return F_SER_PROCESSED;
 }
 
-static _INLINE_ void transmit_chars(struct async_struct *info, int *intr_done)
+static _INLINE_ int transmit_chars(struct async_struct *info)
 {
 	int count;
-	
+	int status;
+
+	if ((info->IER & UART_IER_THRI)==0)
+		return F_SER_NOACTION;
+
+	status = serial_inp(info, UART_LSR);
+
+	if ((status & UART_LSR_THRE)==0)
+		return F_SER_NOACTION;
+
+#ifdef SERIAL_DEBUG_INTR
+	printk("THRE status=%x...", status);
+#endif
 	if (info->x_char) {
 		serial_outp(info, UART_TX, info->x_char);
 		info->state->icount.tx++;
 		info->x_char = 0;
-		if (intr_done)
-			*intr_done = 0;
-		return;
+		return F_SER_PROCESSED;
 	}
-	if ((info->xmit_cnt <= 0) || info->tty->stopped ||
-	    info->tty->hw_stopped) {
+	if ((info->xmit_cnt <= 0) || info->tty->stopped || info->tty->hw_stopped) {
 		info->IER &= ~UART_IER_THRI;
-		serial_out(info, UART_IER, info->IER);
-		return;
+		return F_SER_IER;
 	}
 	
 	count = info->xmit_fifo_size;
@@ -496,20 +530,24 @@
 #ifdef SERIAL_DEBUG_INTR
 	printk("THRE...");
 #endif
-	if (intr_done)
-		*intr_done = 0;
-
 	if (info->xmit_cnt <= 0) {
 		info->IER &= ~UART_IER_THRI;
-		serial_out(info, UART_IER, info->IER);
+		return F_SER_PROCESSED|F_SER_IER;
 	}
+	return F_SER_PROCESSED;
 }
 
-static _INLINE_ void check_modem_status(struct async_struct *info)
+static _INLINE_ int check_modem_status(struct async_struct *info)
 {
 	int	status;
 	struct	async_icount *icount;
+	int	ret;
 	
+	if ((info->IER & UART_IER_MSI)==0)
+		return  F_SER_NOACTION;
+
+	ret=F_SER_NOACTION;
+
 	status = serial_in(info, UART_MSR);
 
 	if (status & UART_MSR_ANY_DELTA) {
@@ -530,6 +568,8 @@
 		if (status & UART_MSR_DCTS)
 			icount->cts++;
 		wake_up_interruptible(&info->delta_msr_wait);
+
+		ret|=F_SER_PROCESSED;
 	}
 
 	if ((info->flags & ASYNC_CHECK_CD) && (status & UART_MSR_DDCD)) {
@@ -556,9 +596,8 @@
 #endif
 				info->tty->hw_stopped = 0;
 				info->IER |= UART_IER_THRI;
-				serial_out(info, UART_IER, info->IER);
+				ret|=F_SER_IER|F_SER_PROCESSED;
 				rs_sched_event(info, RS_EVENT_WRITE_WAKEUP);
-				return;
 			}
 		} else {
 			if (!(status & UART_MSR_CTS)) {
@@ -567,19 +606,20 @@
 #endif
 				info->tty->hw_stopped = 1;
 				info->IER &= ~UART_IER_THRI;
-				serial_out(info, UART_IER, info->IER);
+				ret|=F_SER_IER|F_SER_PROCESSED;
 			}
 		}
 	}
+	return ret;
 }
 
 #ifdef CONFIG_SERIAL_SHARE_IRQ
+
 /*
  * This is the serial driver's generic interrupt routine
  */
 static void rs_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
-	int status;
 	struct async_struct * info;
 	int pass_counter = 0;
 	struct async_struct *end_mark = 0;
@@ -588,14 +628,18 @@
 	struct rs_multiport_struct *multi;
 #endif
 
-#ifdef SERIAL_DEBUG_INTR
+#ifndef SERIAL_DEBUG_INTR
 	printk("rs_interrupt(%d)...", irq);
 #endif
 	
-	info = IRQ_ports[irq];
-	if (!info)
+	if (!IRQ_ports[irq])
 		return;
 	
+	for(info=IRQ_ports[irq];info;info=info->next_port)
+		serial_out(info, UART_IER, 0);
+
+	info = IRQ_ports[irq];
+
 #ifdef CONFIG_SERIAL_MULTIPORT	
 	multi = &rs_multiport[irq];
 	if (multi->port_monitor)
@@ -603,8 +647,7 @@
 #endif
 
 	do {
-		if (!info->tty ||
-		    (serial_in(info, UART_IIR) & UART_IIR_NO_INT)) {
+		if (!info->tty || (receive_chars(info)|check_modem_status(info)|transmit_chars(info))==F_SER_NOACTION) {
 			if (!end_mark)
 				end_mark = info;
 			goto next;
@@ -613,16 +656,6 @@
 
 		info->last_active = jiffies;
 
-		status = serial_inp(info, UART_LSR);
-#ifdef SERIAL_DEBUG_INTR
-		printk("status = %x...", status);
-#endif
-		if (status & UART_LSR_DR)
-			receive_chars(info, &status);
-		check_modem_status(info);
-		if (status & UART_LSR_THRE)
-			transmit_chars(info, 0);
-
 	next:
 		info = info->next_port;
 		if (!info) {
@@ -642,7 +675,10 @@
 		       info->state->irq, first_multi,
 		       inb(multi->port_monitor));
 #endif
-#ifdef SERIAL_DEBUG_INTR
+	for(info=IRQ_ports[irq];info;info=info->next_port)
+		serial_out(info, UART_IER, info->IER);
+
+#ifndef SERIAL_DEBUG_INTR
 	printk("end.\n");
 #endif
 }
@@ -654,7 +690,6 @@
  */
 static void rs_interrupt_single(int irq, void *dev_id, struct pt_regs * regs)
 {
-	int status;
 	int pass_counter = 0;
 	struct async_struct * info;
 #ifdef CONFIG_SERIAL_MULTIPORT	
@@ -665,7 +700,7 @@
 #ifdef SERIAL_DEBUG_INTR
 	printk("rs_interrupt_single(%d)...", irq);
 #endif
-	
+
 	info = IRQ_ports[irq];
 	if (!info || !info->tty)
 		return;
@@ -677,15 +712,9 @@
 #endif
 
 	do {
-		status = serial_inp(info, UART_LSR);
-#ifdef SERIAL_DEBUG_INTR
-		printk("status = %x...", status);
-#endif
-		if (status & UART_LSR_DR)
-			receive_chars(info, &status);
-		check_modem_status(info);
-		if (status & UART_LSR_THRE)
-			transmit_chars(info, 0);
+		if ((receive_chars(info)|check_modem_status(info)|transmit_chars(info))&F_SER_IER)
+			serial_out(info, UART_IER, info->IER);
+
 		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
 #if 0
 			printk("rs_single loop break.\n");
@@ -693,6 +722,7 @@
 			break;
 		}
 	} while (!(serial_in(info, UART_IIR) & UART_IIR_NO_INT));
+
 	info->last_active = jiffies;
 #ifdef CONFIG_SERIAL_MULTIPORT	
 	if (multi->port_monitor)
@@ -711,7 +741,6 @@
  */
 static void rs_interrupt_multi(int irq, void *dev_id, struct pt_regs * regs)
 {
-	int status;
 	struct async_struct * info;
 	int pass_counter = 0;
 	int first_multi= 0;
@@ -740,15 +769,8 @@
 
 		info->last_active = jiffies;
 
-		status = serial_inp(info, UART_LSR);
-#ifdef SERIAL_DEBUG_INTR
-		printk("status = %x...", status);
-#endif
-		if (status & UART_LSR_DR)
-			receive_chars(info, &status);
-		check_modem_status(info);
-		if (status & UART_LSR_THRE)
-			transmit_chars(info, 0);
+		if ((receive_chars(info)|check_modem_status(info)|transmit_chars(info))&F_SER_IER)
+			serial_out(info, UART_IER, info->IER);
 
 	next:
 		info = info->next_port;
@@ -1317,18 +1339,19 @@
 	if (!quot)
 		quot = baud_base / 9600;
 	info->quot = quot;
-	info->timeout = ((info->xmit_fifo_size*HZ*bits*quot) / baud_base);
-	info->timeout += HZ/50;		/* Add .02 seconds of slop */
+	info->timeout = ((info->xmit_fifo_size*HZ*bits+(baud_base/quot-1))*quot) / baud_base;
 
 	/* Set up FIFO's */
 	if (uart_config[info->state->type].flags & UART_USE_FIFO) {
-		if ((info->state->baud_base / quot) < 2400)
+		if (((info->state->baud_base / quot) < 2400) || (info->flags & ASYNC_LOW_LATENCY))
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
-		else
+		else {
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_8;
+
+			if (info->state->type == PORT_16750)
+				fcr |= UART_FCR7_64BYTE;
+		}
 	}
-	if (info->state->type == PORT_16750)
-		fcr |= UART_FCR7_64BYTE;
 	
 	/* CTS flow control flag and modem status interrupts */
 	info->IER &= ~UART_IER_MSI;
@@ -1788,6 +1811,8 @@
  */
 static int get_lsr_info(struct async_struct * info, unsigned int *value)
 {
+#define CIRC_CNT(head,tail,size) (((head) - (tail)) & ((size)-1))
+
 	unsigned char status;
 	unsigned int result;
 	unsigned long flags;
@@ -1796,6 +1821,13 @@
 	status = serial_in(info, UART_LSR);
 	restore_flags(flags);
 	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
+
+	if (info->x_char || 
+	    ((CIRC_CNT(info->xmit_head, info->xmit_tail,
+       		       SERIAL_XMIT_SIZE) > 0) &&
+     	     !info->tty->stopped && !info->tty->hw_stopped))
+		result &= ~TIOCSER_TEMT;
+
 	return put_user(result,value);
 }
 
@@ -2367,7 +2399,7 @@
 	 * Note: we have to use pretty tight timings here to satisfy
 	 * the NIST-PCTS.
 	 */
-	char_time = (info->timeout - HZ/50) / info->xmit_fifo_size;
+	char_time = info->timeout / info->xmit_fifo_size;
 	char_time = char_time / 5;
 	if (char_time == 0)
 		char_time = 1;

