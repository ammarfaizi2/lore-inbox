Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbULHNgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbULHNgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbULHNgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:36:42 -0500
Received: from users.linvision.com ([62.58.92.114]:61670 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261213AbULHN3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:29:37 -0500
Date: Wed, 8 Dec 2004 14:29:32 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, Eric Wood <eric@interplas.com>,
       bmckinlay@perle.com, tmckinlay@perle.com
Subject: [PATCH] Specialix/IO8
Message-ID: <20041208132932.GA19937@bitwizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Patrick van de Lageweg <patrick@bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch converts all save_flags/restore_flags to the new 
spin_lick_irqsave/spin_unlock_irqrestore calls, as well as some
other 2.6.X cleanups. This allows the "io8+" driver to become 
SMP safe. 

The large size of this patch comes mostly from the added 
debug features.


Signed-off-by: Patrick vd Lageweg <patrick@bitwizard.nl>
Signed-off-by: Rogier Wolff <R.E.Wolff@BitWizard.nl>

	
	Patrick

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-08122004-2.6.10-rc3-specialix"

diff -u -r linux-2.6.10-rc3-clean/drivers/char/Kconfig linux-2.6.10-rc3-specialix/drivers/char/Kconfig
--- linux-2.6.10-rc3-clean/drivers/char/Kconfig	Fri Dec  3 15:13:32 2004
+++ linux-2.6.10-rc3-specialix/drivers/char/Kconfig	Fri Dec  3 15:19:23 2004
@@ -264,7 +264,7 @@
 
 config SPECIALIX
 	tristate "Specialix IO8+ card support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD
 	help
 	  This is a driver for the Specialix IO8+ multiport card (both the
 	  ISA and the PCI version) which gives you many serial ports. You
diff -u -r linux-2.6.10-rc3-clean/drivers/char/specialix.c linux-2.6.10-rc3-specialix/drivers/char/specialix.c
--- linux-2.6.10-rc3-clean/drivers/char/specialix.c	Fri Dec  3 15:13:33 2004
+++ linux-2.6.10-rc3-specialix/drivers/char/specialix.c	Fri Dec  3 15:19:23 2004
@@ -66,7 +66,7 @@
  * 
  */
 
-#define VERSION "1.10"
+#define VERSION "1.11"
 
 
 /*
@@ -99,6 +99,44 @@
 #include "cd1865.h"
 
 
+/* 
+   This driver can spew a whole lot of debugging output at you. If you
+   need maximum performance, you should disable the DEBUG define. To
+   aid in debugging in the field, I'm leaving the compile-time debug
+   features enabled, and disable them "runtime". That allows me to
+   instruct people with problems to enable debugging without requiring
+   them to recompile... 
+*/
+#define DEBUG
+
+static int sx_debug;
+static int sx_rxfifo = SPECIALIX_RXFIFO;
+
+#ifdef DEBUG
+#define dprintk(f, str...) if (sx_debug & f) printk (str)
+#else
+#define dprintk(f, str...) /* nothing */
+#endif
+
+#define SX_DEBUG_FLOW    0x0001
+#define SX_DEBUG_DATA    0x0002
+#define SX_DEBUG_PROBE   0x0004
+#define SX_DEBUG_CHAN    0x0008
+#define SX_DEBUG_INIT    0x0010
+#define SX_DEBUG_RX      0x0020
+#define SX_DEBUG_TX      0x0040
+#define SX_DEBUG_IRQ     0x0080
+#define SX_DEBUG_OPEN    0x0100
+#define SX_DEBUG_TERMIOS 0x0200
+#define SX_DEBUG_SIGNALS 0x0400
+#define SX_DEBUG_FIFO    0x0800
+
+
+#define func_enter() dprintk (SX_DEBUG_FLOW, "io8: enter %s\n",__FUNCTION__)
+#define func_exit()  dprintk (SX_DEBUG_FLOW, "io8: exit  %s\n", __FUNCTION__)
+
+#define jiffies_from_ms(a) ((((a) * HZ)/1000)+1)
+
 
 /* Configurable options: */
 
@@ -110,6 +148,12 @@
    requiring attention, the timer doesn't help either. */
 #undef SPECIALIX_TIMER
 
+#ifdef SPECIALIX_TIMER
+static int sx_poll = HZ;
+#endif
+
+
+
 /* 
  * The following defines are mostly for testing purposes. But if you need
  * some nice reporting in your syslog, you can define them also.
@@ -254,11 +298,17 @@
 /* Wait for Channel Command Register ready */
 static inline void sx_wait_CCR(struct specialix_board  * bp)
 {
-	unsigned long delay;
+	unsigned long delay, flags;
+	unsigned char ccr;
 
-	for (delay = SX_CCR_TIMEOUT; delay; delay--) 
-		if (!sx_in(bp, CD186x_CCR))
+	for (delay = SX_CCR_TIMEOUT; delay; delay--) {
+		spin_lock_irqsave(&bp->lock, flags);
+		ccr = sx_in(bp, CD186x_CCR);
+		spin_unlock_irqrestore(&bp->lock, flags);
+		if (!ccr)
 			return;
+		udelay (1);
+	}
 	
 	printk(KERN_ERR "sx%d: Timeout waiting for CCR.\n", board_No(bp));
 }
@@ -268,10 +318,17 @@
 static inline void sx_wait_CCR_off(struct specialix_board  * bp)
 {
 	unsigned long delay;
+	unsigned char crr;
+	unsigned long flags;
 
-	for (delay = SX_CCR_TIMEOUT; delay; delay--) 
-		if (!sx_in_off(bp, CD186x_CCR))
+	for (delay = SX_CCR_TIMEOUT; delay; delay--) {
+		spin_lock_irqsave(&bp->lock, flags);
+		crr = sx_in_off(bp, CD186x_CCR);
+		spin_unlock_irqrestore(&bp->lock, flags);
+		if (!crr)
 			return;
+		udelay (1);
+	}
 	
 	printk(KERN_ERR "sx%d: Timeout waiting for CCR.\n", board_No(bp));
 }
@@ -319,6 +376,7 @@
 {
 	int virq;
 	int i;
+	unsigned long flags;
 
 	if (bp->flags & SX_BOARD_IS_PCI) 
 		return 1;
@@ -331,11 +389,12 @@
 	default: printk (KERN_ERR "Speclialix: cannot set irq to %d.\n", bp->irq);
 	         return 0;
 	}
-
+	spin_lock_irqsave(&bp->lock, flags);
 	for (i=0;i<2;i++) {
 		sx_out(bp, CD186x_CAR, i);
 		sx_out(bp, CD186x_MSVRTS, ((virq >> i) & 0x1)? MSVR_RTS:0);
 	}
+	spin_unlock_irqrestore(&bp->lock, flags);
 	return 1;
 }
 
@@ -346,14 +405,14 @@
 	unsigned long flags;
 	int scaler;
 	int rv = 1;
-	
-	save_flags(flags); cli();
 
+	func_enter ();
 	sx_wait_CCR_off(bp);			   /* Wait for CCR ready        */
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out_off(bp, CD186x_CCR, CCR_HARDRESET);      /* Reset CD186x chip          */
-	sti();
+	spin_unlock_irqrestore(&bp->lock, flags);
 	sx_long_delay(HZ/20);                      /* Delay 0.05 sec            */
-	cli();
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out_off(bp, CD186x_GIVR, SX_ID);             /* Set ID for this chip      */
 	sx_out_off(bp, CD186x_GICR, 0);                 /* Clear all bits            */
 	sx_out_off(bp, CD186x_PILR1, SX_ACK_MINT);      /* Prio for modem intr       */
@@ -367,6 +426,7 @@
 
 	sx_out_off(bp, CD186x_PPRH, scaler >> 8);
 	sx_out_off(bp, CD186x_PPRL, scaler & 0xff);
+	spin_unlock_irqrestore(&bp->lock, flags);
 
 	if (!sx_set_irq (bp)) {
 		/* Figure out how to pass this along... */
@@ -374,7 +434,7 @@
 		rv = 0;
 	}
 
-	restore_flags(flags);
+	func_exit ();
 	return rv;
 }
 
@@ -383,12 +443,16 @@
 {
 	int i;
 	int t;
+	unsigned long flags;
 
+	spin_lock_irqsave(&bp->lock, flags);
 	for (i=0, t=0;i<8;i++) {
 		sx_out_off (bp, CD186x_CAR, i);
 		if (sx_in_off (bp, reg) & bit) 
 			t |= 1 << i;
 	}
+	spin_unlock_irqrestore(&bp->lock, flags);
+
 	return t;
 }
 
@@ -396,15 +460,22 @@
 #ifdef SPECIALIX_TIMER
 void missed_irq (unsigned long data)
 {
-	if (sx_in ((struct specialix_board *)data, CD186x_SRSR) &  
+	unsigned char irq;
+	unsigned long flags;
+	struct specialix_board  *bp = (struct specialix_board *)data;
+
+	spin_lock_irqsave(&bp->lock, flags);
+	irq = sx_in ((struct specialix_board *)data, CD186x_SRSR) &  
 	                                            (SRSR_RREQint |
 	                                             SRSR_TREQint |
-	                                             SRSR_MREQint)) {
+	                                             SRSR_MREQint);
+	spin_unlock_irqrestore(&bp->lock, flags);
+	if (irq) {
 		printk (KERN_INFO "Missed interrupt... Calling int from timer. \n");
 		sx_interrupt (((struct specialix_board *)data)->irq, 
-		              NULL, NULL);
+		              (void*)data, NULL);
 	}
-	missed_irq_timer.expires = jiffies + HZ;
+	missed_irq_timer.expires = jiffies + sx_poll;
 	add_timer (&missed_irq_timer);
 }
 #endif
@@ -422,8 +493,12 @@
 	int rev;
 	int chip;
 
-	if (sx_check_io_range(bp)) 
+	func_enter ();
+
+	if (sx_check_io_range(bp)) {
+		func_exit ();
 		return 1;
+	}
 
 	/* Are the I/O ports here ? */
 	sx_out_off(bp, CD186x_PPRL, 0x5a);
@@ -438,6 +513,7 @@
 	if ((val1 != 0x5a) || (val2 != 0xa5)) {
 		printk(KERN_INFO "sx%d: specialix IO8+ Board at 0x%03x not found.\n",
 		       board_No(bp), bp->base);
+		func_exit ();
 		return 1;
 	}
 
@@ -445,10 +521,9 @@
 	   identification */
 	val1 = read_cross_byte (bp, CD186x_MSVR, MSVR_DSR);
 	val2 = read_cross_byte (bp, CD186x_MSVR, MSVR_RTS);
-#ifdef SPECIALIX_DEBUG
-	printk (KERN_DEBUG "sx%d: DSR lines are: %02x, rts lines are: %02x\n", 
+	dprintk (SX_DEBUG_INIT, "sx%d: DSR lines are: %02x, rts lines are: %02x\n", 
 	        board_No(bp),  val1, val2);
-#endif
+
 	/* They managed to switch the bit order between the docs and
 	   the IO8+ card. The new PCI card now conforms to old docs.
 	   They changed the PCI docs to reflect the situation on the
@@ -457,6 +532,7 @@
 	if (val1 != val2) {
 		printk(KERN_INFO "sx%d: specialix IO8+ ID %02x at 0x%03x not found (%02x).\n",
 		       board_No(bp), val2, bp->base, val1);
+		func_exit ();
 		return 1;
 	}
 
@@ -473,21 +549,19 @@
 		sx_long_delay(HZ/20);	       		
 		irqs = probe_irq_off(irqs);
 
-#if SPECIALIX_DEBUG > 2
-		printk (KERN_DEBUG "SRSR = %02x, ",  sx_in(bp, CD186x_SRSR));
-		printk (           "TRAR = %02x, ",  sx_in(bp, CD186x_TRAR));
-		printk (           "GIVR = %02x, ",  sx_in(bp, CD186x_GIVR));
-		printk (           "GICR = %02x, ",  sx_in(bp, CD186x_GICR));
-		printk (           "\n");
-#endif
+		dprintk (SX_DEBUG_INIT, "SRSR = %02x, ", sx_in(bp, CD186x_SRSR));
+		dprintk (SX_DEBUG_INIT, "TRAR = %02x, ", sx_in(bp, CD186x_TRAR));
+		dprintk (SX_DEBUG_INIT, "GIVR = %02x, ", sx_in(bp, CD186x_GIVR));
+		dprintk (SX_DEBUG_INIT, "GICR = %02x, ", sx_in(bp, CD186x_GICR));
+		dprintk (SX_DEBUG_INIT, "\n");
+
 		/* Reset CD186x again      */
 		if (!sx_init_CD186x(bp)) {
 			/* Hmmm. This is dead code anyway. */
 		}
-#if SPECIALIX_DEBUG > 2
-		printk (KERN_DEBUG "val1 = %02x, val2 = %02x, val3 = %02x.\n", 
+
+		dprintk (SX_DEBUG_INIT "val1 = %02x, val2 = %02x, val3 = %02x.\n", 
 		        val1, val2, val3); 
-#endif
 	
 	}
 	
@@ -495,6 +569,7 @@
 	if (irqs <= 0) {
 		printk(KERN_ERR "sx%d: Can't find IRQ for specialix IO8+ board at 0x%03x.\n",
 		       board_No(bp), bp->base);
+		func_exit ();
 		return 1;
 	}
 #endif
@@ -504,6 +579,7 @@
 #endif
 	/* Reset CD186x again  */
 	if (!sx_init_CD186x(bp)) {
+		func_exit ();
 		return -EIO;
 	}
 
@@ -528,15 +604,13 @@
 	default:chip=-1;rev='x';
 	}
 
-#if SPECIALIX_DEBUG > 2
-	printk (KERN_DEBUG " GFCR = 0x%02x\n", sx_in_off(bp, CD186x_GFRCR) );
-#endif
+	dprintk (SX_DEBUG_INIT, " GFCR = 0x%02x\n", sx_in_off(bp, CD186x_GFRCR) );
 
 #ifdef SPECIALIX_TIMER
 	init_timer (&missed_irq_timer);
 	missed_irq_timer.function = missed_irq;
 	missed_irq_timer.data = (unsigned long) bp;
-	missed_irq_timer.expires = jiffies + HZ;
+	missed_irq_timer.expires = jiffies + sx_poll;
 	add_timer (&missed_irq_timer);
 #endif
 
@@ -545,6 +619,7 @@
 	       bp->base, bp->irq,
 	       chip, rev);
 
+	func_exit ();
 	return 0;
 }
 
@@ -555,8 +630,12 @@
 
 static inline void sx_mark_event(struct specialix_port * port, int event)
 {
+	func_enter ();
+
 	set_bit(event, &port->event);
 	schedule_work(&port->tqueue);
+
+	func_exit ();
 }
 
 
@@ -564,12 +643,17 @@
 					       unsigned char const * what)
 {
 	unsigned char channel;
-	struct specialix_port * port;
-	
+	struct specialix_port * port = NULL;
+
 	channel = sx_in(bp, CD186x_GICR) >> GICR_CHAN_OFF;
+	dprintk (SX_DEBUG_CHAN, "channel: %d\n", channel);
 	if (channel < CD186x_NCH) {
 		port = &sx_port[board_No(bp) * SX_NPORT + channel];
+		dprintk (SX_DEBUG_CHAN, "port: %d %p flags: 0x%x\n",board_No(bp) * SX_NPORT + channel,  port, port->flags & ASYNC_INITIALIZED);
+
 		if (port->flags & ASYNC_INITIALIZED) {
+			dprintk (SX_DEBUG_CHAN, "port: %d %p\n", channel, port);
+			func_exit ();
 			return port;
 		}
 	}
@@ -586,43 +670,51 @@
 	unsigned char status;
 	unsigned char ch;
 
-	if (!(port = sx_get_port(bp, "Receive")))
-		return;
+	func_enter ();
 
-	tty = port->tty;
-	if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
-		printk(KERN_INFO "sx%d: port %d: Working around flip buffer overflow.\n",
-		       board_No(bp), port_No(port));
+	port = sx_get_port(bp, "Receive");
+	if (!port) {
+		dprintk (SX_DEBUG_RX, "Hmm, couldn't find port.\n"); 
+		func_exit ();
 		return;
 	}
+	tty = port->tty;
+	dprintk (SX_DEBUG_RX, "port: %p count: %d BUFF_SIZE: %d\n", 
+		 port,  tty->flip.count, TTY_FLIPBUF_SIZE);
 	
-#ifdef SX_REPORT_OVERRUN	
 	status = sx_in(bp, CD186x_RCSR);
+
+	dprintk (SX_DEBUG_RX, "status: 0x%x\n", status);
 	if (status & RCSR_OE) {
 		port->overrun++;
-#if SPECIALIX_DEBUG 
-		printk(KERN_DEBUG "sx%d: port %d: Overrun. Total %ld overruns.\n", 
+		dprintk(SX_DEBUG_FIFO, "sx%d: port %d: Overrun. Total %ld overruns.\n", 
 		       board_No(bp), port_No(port), port->overrun);
-#endif		
 	}
 	status &= port->mark_mask;
-#else	
-	status = sx_in(bp, CD186x_RCSR) & port->mark_mask;
-#endif	
+
+	/* This flip buffer check needs to be below the reading of the
+	   status register to reset the chip's IRQ.... */
+	if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
+		dprintk(SX_DEBUG_FIFO, "sx%d: port %d: Working around flip buffer overflow.\n",
+		       board_No(bp), port_No(port)); 
+		func_exit ();
+		return;
+	}
+	
 	ch = sx_in(bp, CD186x_RDR);
 	if (!status) {
+		func_exit ();
 		return;
 	}
 	if (status & RCSR_TOUT) {
 		printk(KERN_INFO "sx%d: port %d: Receiver timeout. Hardware problems ?\n", 
 		       board_No(bp), port_No(port));
+		func_exit ();
 		return;
 		
 	} else if (status & RCSR_BREAK) {
-#ifdef SPECIALIX_DEBUG
-		printk(KERN_DEBUG "sx%d: port %d: Handling break...\n",
+		dprintk(SX_DEBUG_RX, "sx%d: port %d: Handling break...\n",
 		       board_No(bp), port_No(port));
-#endif
 		*tty->flip.flag_buf_ptr++ = TTY_BREAK;
 		if (port->flags & ASYNC_SAK)
 			do_SAK(tty);
@@ -642,6 +734,8 @@
 	*tty->flip.char_buf_ptr++ = ch;
 	tty->flip.count++;
 	schedule_delayed_work(&tty->flip.work, 1);
+
+	func_exit ();
 }
 
 
@@ -650,17 +744,19 @@
 	struct specialix_port *port;
 	struct tty_struct *tty;
 	unsigned char count;
+
+	func_enter ();
 	
-	if (!(port = sx_get_port(bp, "Receive")))
+	if (!(port = sx_get_port(bp, "Receive"))) {
+		dprintk (SX_DEBUG_RX, "Hmm, couldn't find port.\n"); 
+		func_exit ();
 		return;
-	
+	}
 	tty = port->tty;
 	
 	count = sx_in(bp, CD186x_RDCR);
-	
-#ifdef SX_REPORT_FIFO
+	dprintk (SX_DEBUG_RX, "port: %p: count: %d\n", port, count);
 	port->hits[count > 8 ? 9 : count]++;
-#endif	
 	
 	while (count--) {
 		if (tty->flip.count >= TTY_FLIPBUF_SIZE) {
@@ -673,6 +769,8 @@
 		tty->flip.count++;
 	}
 	schedule_delayed_work(&tty->flip.work, 1);
+
+	func_exit ();
 }
 
 
@@ -681,11 +779,13 @@
 	struct specialix_port *port;
 	struct tty_struct *tty;
 	unsigned char count;
-	
-	
-	if (!(port = sx_get_port(bp, "Transmit")))
+
+	func_enter ();
+	if (!(port = sx_get_port(bp, "Transmit"))) {
+		func_exit ();
 		return;
-	
+	}
+	dprintk (SX_DEBUG_TX, "port: %p\n", port);
 	tty = port->tty;
 	
 	if (port->IER & IER_TXEMPTY) {
@@ -693,6 +793,7 @@
 		sx_out(bp, CD186x_CAR, port_No(port));
 		port->IER &= ~IER_TXEMPTY;
 		sx_out(bp, CD186x_IER, port->IER);
+		func_exit ();
 		return;
 	}
 	
@@ -701,6 +802,7 @@
 		sx_out(bp, CD186x_CAR, port_No(port));
 		port->IER &= ~IER_TXRDY;
 		sx_out(bp, CD186x_IER, port->IER);
+		func_exit ();
 		return;
 	}
 	
@@ -725,6 +827,8 @@
 			sx_out(bp, CD186x_CCR, CCR_CORCHG2);
 			port->break_length = 0;
 		}
+
+		func_exit ();
 		return;
 	}
 	
@@ -743,6 +847,8 @@
 	}
 	if (port->xmit_cnt <= port->wakeup_chars)
 		sx_mark_event(port, RS_EVENT_WRITE_WAKEUP);
+
+	func_exit ();
 }
 
 
@@ -751,10 +857,9 @@
 	struct specialix_port *port;
 	struct tty_struct *tty;
 	unsigned char mcr;
-
-#ifdef SPECIALIX_DEBUG
-	printk (KERN_DEBUG "Modem intr. ");
-#endif
+	int msvr_cd;
+	
+	dprintk (SX_DEBUG_SIGNALS, "Modem intr. ");
 	if (!(port = sx_get_port(bp, "Modem")))
 		return;
 	
@@ -764,18 +869,13 @@
 	printk ("mcr = %02x.\n", mcr);
 
 	if ((mcr & MCR_CDCHG)) {
-#ifdef SPECIALIX_DEBUG 
-		printk (KERN_DEBUG "CD just changed... ");
-#endif
-		if (sx_in(bp, CD186x_MSVR) & MSVR_CD) {
-#ifdef SPECIALIX_DEBUG
-			printk ( "Waking up guys in open.\n");
-#endif
+		dprintk (SX_DEBUG_SIGNALS, "CD just changed... ");
+		msvr_cd = sx_in(bp, CD186x_MSVR) & MSVR_CD;
+		if (msvr_cd) {
+			dprintk (SX_DEBUG_SIGNALS, "Waking up guys in open.\n");
 			wake_up_interruptible(&port->open_wait);
 		} else {
-#ifdef SPECIALIX_DEBUG
-			printk ( "Sending HUP.\n");
-#endif
+			dprintk (SX_DEBUG_SIGNALS, "Sending HUP.\n");
 			schedule_work(&port->tqueue_hangup);
 		}
 	}
@@ -820,13 +920,18 @@
 	struct specialix_board *bp;
 	unsigned long loop = 0;
 	int saved_reg;
+	unsigned long flags;
+
+	func_enter ();
 
 	bp = dev_id;
-	
+	spin_lock_irqsave(&bp->lock, flags);
+
+	dprintk (SX_DEBUG_FLOW, "enter %s port %d room: %ld\n", __FUNCTION__, port_No(sx_get_port(bp, "INT")), SERIAL_XMIT_SIZE - sx_get_port(bp, "ITN")->xmit_cnt - 1);
 	if (!bp || !(bp->flags & SX_BOARD_ACTIVE)) {
-#ifdef SPECIALIX_DEBUG 
-		printk (KERN_DEBUG "sx: False interrupt. irq %d.\n", irq);
-#endif
+		dprintk (SX_DEBUG_IRQ, "sx: False interrupt. irq %d.\n", irq);
+		spin_unlock_irqrestore(&bp->lock, flags);
+		func_exit ();
 		return IRQ_NONE;
 	}
 
@@ -844,8 +949,8 @@
 			else if (ack == (SX_ID | GIVR_IT_REXC))
 				sx_receive_exc(bp);
 			else
-				printk(KERN_ERR "sx%d: Bad receive ack 0x%02x.\n",
-				       board_No(bp), ack);
+				printk(KERN_ERR "sx%d: status: 0x%x Bad receive ack 0x%02x.\n",
+				       board_No(bp), status, ack);
 		
 		} else if (status & SRSR_TREQint) {
 			ack = sx_in(bp, CD186x_TRAR);
@@ -853,16 +958,16 @@
 			if (ack == (SX_ID | GIVR_IT_TX))
 				sx_transmit(bp);
 			else
-				printk(KERN_ERR "sx%d: Bad transmit ack 0x%02x.\n",
-				       board_No(bp), ack);
+				printk(KERN_ERR "sx%d: status: 0x%x Bad transmit ack 0x%02x. port: %d\n",
+				       board_No(bp), status, ack, port_No (sx_get_port (bp, "Int")));
 		} else if (status & SRSR_MREQint) {
 			ack = sx_in(bp, CD186x_MRAR);
 
 			if (ack == (SX_ID | GIVR_IT_MODEM)) 
 				sx_check_modem(bp);
 			else
-				printk(KERN_ERR "sx%d: Bad modem ack 0x%02x.\n",
-				       board_No(bp), ack);
+				printk(KERN_ERR "sx%d: status: 0x%x Bad modem ack 0x%02x.\n",
+				       board_No(bp), status, ack);
 		
 		} 
 
@@ -870,6 +975,8 @@
 	}
 	bp->reg = saved_reg;
 	outb (bp->reg, bp->base + SX_ADDR_REG);
+	spin_unlock_irqrestore(&bp->lock, flags);
+	func_exit ();
 	return IRQ_HANDLED;
 }
 
@@ -880,21 +987,37 @@
 
 void turn_ints_off (struct specialix_board *bp)
 {
+	unsigned long flags;
+	func_enter ();
+
 	if (bp->flags & SX_BOARD_IS_PCI) {
 		/* This was intended for enabeling the interrupt on the
 		 * PCI card. However it seems that it's already enabled
 		 * and as PCI interrupts can be shared, there is no real
 		 * reason to have to turn it off. */
 	}
+
+	spin_lock_irqsave(&bp->lock, flags);
 	(void) sx_in_off (bp, 0); /* Turn off interrupts. */
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	func_exit ();
 }
 
 void turn_ints_on (struct specialix_board *bp)
 {
+	unsigned long flags;
+
+	func_enter ();
+
 	if (bp->flags & SX_BOARD_IS_PCI) {
 		/* play with the PCI chip. See comment above. */
 	}
+	spin_lock_irqsave(&bp->lock, flags);
 	(void) sx_in (bp, 0); /* Turn ON interrupts. */
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	func_exit ();
 }
 
 
@@ -924,18 +1047,23 @@
 /* Called with disabled interrupts */
 static inline void sx_shutdown_board(struct specialix_board *bp)
 {
-	if (!(bp->flags & SX_BOARD_ACTIVE))
+	func_enter ();
+
+	if (!(bp->flags & SX_BOARD_ACTIVE)) {
+		func_exit ();
 		return;
-	
+	}
+
 	bp->flags &= ~SX_BOARD_ACTIVE;
 	
-#if SPECIALIX_DEBUG > 2
-	printk ("Freeing IRQ%d for board %d.\n", bp->irq, board_No (bp));
-#endif
+	dprintk (SX_DEBUG_IRQ, "Freeing IRQ%d for board %d.\n", 
+		 bp->irq, board_No (bp));
 	free_irq(bp->irq, bp);
 
 	turn_ints_off (bp);
 
+
+	func_exit ();
 }
 
 
@@ -951,13 +1079,19 @@
 	unsigned char cor1 = 0, cor3 = 0;
 	unsigned char mcor1 = 0, mcor2 = 0;
 	static unsigned long again;
-	
-	if (!(tty = port->tty) || !tty->termios)
+	unsigned long flags;
+
+	func_enter ();
+
+	if (!(tty = port->tty) || !tty->termios) {
+		func_exit ();
 		return;
+	}
 
 	port->IER  = 0;
 	port->COR2 = 0;
 	/* Select port on the board */
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CAR, port_No(port));
 
 	/* The Specialix board doens't implement the RTS lines.
@@ -966,9 +1100,8 @@
 		port->MSVR = MSVR_DTR | (sx_in(bp, CD186x_MSVR) & MSVR_RTS);
 	else
 		port->MSVR =  (sx_in(bp, CD186x_MSVR) & MSVR_RTS);
-#ifdef DEBUG_SPECIALIX
-	printk (KERN_DEBUG "sx: got MSVR=%02x.\n", port->MSVR);
-#endif
+	spin_unlock_irqrestore(&bp->lock, flags);
+	dprintk (SX_DEBUG_TERMIOS, "sx: got MSVR=%02x.\n", port->MSVR);
 	baud = C_BAUD(tty);
 	
 	if (baud & CBAUDEX) {
@@ -988,17 +1121,15 @@
 	
 	if (!baud_table[baud]) {
 		/* Drop DTR & exit */
-#ifdef SPECIALIX_DEBUG
-		printk (KERN_DEBUG "Dropping DTR...  Hmm....\n");
-#endif
+		dprintk (SX_DEBUG_TERMIOS, "Dropping DTR...  Hmm....\n");
 		if (!SX_CRTSCTS (tty)) {
 			port -> MSVR &= ~ MSVR_DTR;
+			spin_lock_irqsave(&bp->lock, flags);
 			sx_out(bp, CD186x_MSVR, port->MSVR );
+			spin_unlock_irqrestore(&bp->lock, flags);
 		} 
-#ifdef DEBUG_SPECIALIX
 		else
-			printk (KERN_DEBUG "Can't drop DTR: no DTR.\n");
-#endif
+			dprintk (SX_DEBUG_TERMIOS, "Can't drop DTR: no DTR.\n");
 		return;
 	} else {
 		/* Set DTR on */
@@ -1037,12 +1168,12 @@
 			        port_No (port), tmp);
 		}
 	}
-
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_RBPRH, (tmp >> 8) & 0xff); 
 	sx_out(bp, CD186x_TBPRH, (tmp >> 8) & 0xff); 
 	sx_out(bp, CD186x_RBPRL, tmp & 0xff); 
 	sx_out(bp, CD186x_TBPRL, tmp & 0xff);
-
+	spin_unlock_irqrestore(&bp->lock, flags);
 	if (port->custom_divisor) {
 		baud = (SX_OSCFREQ + port->custom_divisor/2) / port->custom_divisor;
 		baud = ( baud + 5 ) / 10;
@@ -1057,8 +1188,9 @@
 	/* Receiver timeout will be transmission time for 1.5 chars */
 	tmp = (SPECIALIX_TPS + SPECIALIX_TPS/2 + baud/2) / baud;
 	tmp = (tmp > 0xff) ? 0xff : tmp;
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_RTPR, tmp);
-	
+	spin_unlock_irqrestore(&bp->lock, flags);
 	switch (C_CSIZE(tty)) {
 	 case CS5:
 		cor1 |= COR1_5BITS;
@@ -1105,7 +1237,9 @@
 		port->IER |= IER_DSR | IER_CTS;
 		mcor1 |= MCOR1_DSRZD | MCOR1_CTSZD;
 		mcor2 |= MCOR2_DSROD | MCOR2_CTSOD;
+		spin_lock_irqsave(&bp->lock, flags);
 		tty->hw_stopped = !(sx_in(bp, CD186x_MSVR) & (MSVR_CTS|MSVR_DSR));
+		spin_unlock_irqrestore(&bp->lock, flags);
 #else
 		port->COR2 |= COR2_CTSAE; 
 #endif
@@ -1117,10 +1251,12 @@
 		cor3 |= (COR3_FCT | COR3_SCDE);
 		if (I_IXANY(tty))
 			port->COR2 |= COR2_IXM;
+		spin_lock_irqsave(&bp->lock, flags);
 		sx_out(bp, CD186x_SCHR1, START_CHAR(tty));
 		sx_out(bp, CD186x_SCHR2, STOP_CHAR(tty));
 		sx_out(bp, CD186x_SCHR3, START_CHAR(tty));
 		sx_out(bp, CD186x_SCHR4, STOP_CHAR(tty));
+		spin_unlock_irqrestore(&bp->lock, flags);
 	}
 	if (!C_CLOCAL(tty)) {
 		/* Enable CD check */
@@ -1134,27 +1270,33 @@
 		port->IER |= IER_RXD;
 	
 	/* Set input FIFO size (1-8 bytes) */
-	cor3 |= SPECIALIX_RXFIFO; 
+	cor3 |= sx_rxfifo; 
 	/* Setting up CD186x channel registers */
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_COR1, cor1);
 	sx_out(bp, CD186x_COR2, port->COR2);
 	sx_out(bp, CD186x_COR3, cor3);
+	spin_unlock_irqrestore(&bp->lock, flags);
 	/* Make CD186x know about registers change */
 	sx_wait_CCR(bp);
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CCR, CCR_CORCHG1 | CCR_CORCHG2 | CCR_CORCHG3);
 	/* Setting up modem option registers */
-#ifdef DEBUG_SPECIALIX
-	printk ("Mcor1 = %02x, mcor2 = %02x.\n", mcor1, mcor2);
-#endif
+	dprintk (SX_DEBUG_TERMIOS, "Mcor1 = %02x, mcor2 = %02x.\n", mcor1, mcor2);
 	sx_out(bp, CD186x_MCOR1, mcor1);
 	sx_out(bp, CD186x_MCOR2, mcor2);
+	spin_unlock_irqrestore(&bp->lock, flags);
 	/* Enable CD186x transmitter & receiver */
 	sx_wait_CCR(bp);
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CCR, CCR_TXEN | CCR_RXEN);
 	/* Enable interrupts */
 	sx_out(bp, CD186x_IER, port->IER);
 	/* And finally set the modem lines... */
 	sx_out(bp, CD186x_MSVR, port->MSVR);
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	func_exit ();
 }
 
 
@@ -1162,37 +1304,44 @@
 static int sx_setup_port(struct specialix_board *bp, struct specialix_port *port)
 {
 	unsigned long flags;
-	
-	if (port->flags & ASYNC_INITIALIZED)
+
+	func_enter ();
+
+	if (port->flags & ASYNC_INITIALIZED) {
+		func_exit ();
 		return 0;
+	}
 	
 	if (!port->xmit_buf) {
 		/* We may sleep in get_zeroed_page() */
 		unsigned long tmp;
 		
-		if (!(tmp = get_zeroed_page(GFP_KERNEL)))
+		if (!(tmp = get_zeroed_page(GFP_KERNEL))) {
+			func_exit ();
 			return -ENOMEM;
+		}
 
 		if (port->xmit_buf) {
 			free_page(tmp);
+			func_exit ();
 			return -ERESTARTSYS;
 		}
 		port->xmit_buf = (unsigned char *) tmp;
 	}
 		
-	save_flags(flags); cli();
-		
+	spin_lock_irqsave(&port->lock, flags);
+
 	if (port->tty) 
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
-		
-	if (port->count == 1) 
-		bp->count++;
-		
+
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
 	sx_change_speed(bp, port);
 	port->flags |= ASYNC_INITIALIZED;
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
 		
-	restore_flags(flags);
+	func_exit ();
 	return 0;
 }
 
@@ -1201,62 +1350,54 @@
 static void sx_shutdown_port(struct specialix_board *bp, struct specialix_port *port)
 {
 	struct tty_struct *tty;
+	int i;
+	unsigned long flags;
 	
-	if (!(port->flags & ASYNC_INITIALIZED)) 
+	func_enter ();
+
+	if (!(port->flags & ASYNC_INITIALIZED)) {
+		func_exit ();
 		return;
+	}
 	
-#ifdef SX_REPORT_OVERRUN
-	printk(KERN_INFO "sx%d: port %d: Total %ld overruns were detected.\n",
-	       board_No(bp), port_No(port), port->overrun);
-#endif	
-#ifdef SX_REPORT_FIFO
-	{
-		int i;
-		
-		printk(KERN_INFO "sx%d: port %d: FIFO hits [ ",
-		       board_No(bp), port_No(port));
+	if (sx_debug & SX_DEBUG_FIFO) {
+		dprintk(SX_DEBUG_FIFO, "sx%d: port %d: %ld overruns, FIFO hits [ ",
+			board_No(bp), port_No(port), port->overrun);
 		for (i = 0; i < 10; i++) {
-			printk("%ld ", port->hits[i]);
+			dprintk(SX_DEBUG_FIFO, "%ld ", port->hits[i]);
 		}
-		printk("].\n");
+		dprintk(SX_DEBUG_FIFO, "].\n");
 	}
-#endif	
+
 	if (port->xmit_buf) {
 		free_page((unsigned long) port->xmit_buf);
 		port->xmit_buf = NULL;
 	}
 
 	/* Select port */
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CAR, port_No(port));
 
 	if (!(tty = port->tty) || C_HUPCL(tty)) {
 		/* Drop DTR */
 		sx_out(bp, CD186x_MSVDTR, 0);
 	}
-	
+	spin_unlock_irqrestore(&bp->lock, flags);
 	/* Reset port */
 	sx_wait_CCR(bp);
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CCR, CCR_SOFTRESET);
 	/* Disable all interrupts from this port */
 	port->IER = 0;
 	sx_out(bp, CD186x_IER, port->IER);
-	
+	spin_unlock_irqrestore(&bp->lock, flags);
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
 	port->flags &= ~ASYNC_INITIALIZED;
 	
-	if (--bp->count < 0) {
-		printk(KERN_ERR "sx%d: sx_shutdown_port: bad board count: %d\n",
-		       board_No(bp), bp->count);
-		bp->count = 0;
-	}
-	
-	/*
-	 * If this is the last opened port on the board
-	 * shutdown whole board
-	 */
 	if (!bp->count) 
 		sx_shutdown_board(bp);
+	func_exit ();
 }
 
 	
@@ -1268,6 +1409,9 @@
 	int    retval;
 	int    do_clocal = 0;
 	int    CD;
+	unsigned long flags;
+
+	func_enter ();
 
 	/*
 	 * If the device is in the middle of being closed, then block
@@ -1275,10 +1419,13 @@
 	 */
 	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&port->close_wait);
-		if (port->flags & ASYNC_HUP_NOTIFY)
+		if (port->flags & ASYNC_HUP_NOTIFY) {
+			func_exit ();
 			return -EAGAIN;
-		else
+		} else {
+			func_exit ();
 			return -ERESTARTSYS;
+		}
 	}
 	
 	/*
@@ -1288,6 +1435,7 @@
 	if ((filp->f_flags & O_NONBLOCK) ||
 	    (tty->flags & (1 << TTY_IO_ERROR))) {
 		port->flags |= ASYNC_NORMAL_ACTIVE;
+		func_exit ();
 		return 0;
 	}
 
@@ -1303,13 +1451,14 @@
 	 */
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
-	cli();
-	if (!tty_hung_up_p(filp))
+	spin_lock_irqsave(&port->lock, flags); 
+	if (!tty_hung_up_p(filp)) {
 		port->count--;
-	sti();
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
 	port->blocked_open++;
 	while (1) {
-		cli();
+		spin_lock_irqsave(&bp->lock, flags);
 		sx_out(bp, CD186x_CAR, port_No(port));
 		CD = sx_in(bp, CD186x_MSVR) & MSVR_CD;
 		if (SX_CRTSCTS (tty)) {
@@ -1320,8 +1469,8 @@
 			/* Activate DTR */
 			port->MSVR |= MSVR_DTR;
 			sx_out (bp, CD186x_MSVR, port->MSVR);
-		} 
-		sti();
+		}
+		spin_unlock_irqrestore(&bp->lock, flags);
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (tty_hung_up_p(filp) ||
 		    !(port->flags & ASYNC_INITIALIZED)) {
@@ -1340,15 +1489,22 @@
 		}
 		schedule();
 	}
-	current->state = TASK_RUNNING;
+
+	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
-	if (!tty_hung_up_p(filp))
+	spin_lock_irqsave(&port->lock, flags);
+	if (!tty_hung_up_p(filp)) {
 		port->count++;
+	}
 	port->blocked_open--;
-	if (retval)
+	spin_unlock_irqrestore(&port->lock, flags);
+	if (retval) {
+		func_exit ();
 		return retval;
-	
+	}	
+
 	port->flags |= ASYNC_NORMAL_ACTIVE;
+	func_exit ();
 	return 0;
 }	
 
@@ -1359,36 +1515,55 @@
 	int error;
 	struct specialix_port * port;
 	struct specialix_board * bp;
-	
+	int i; 
+	unsigned long flags;
+
+	func_enter ();
+
 	board = SX_BOARD(tty->index);
 
-	if (board >= SX_NBOARD || !(sx_board[board].flags & SX_BOARD_PRESENT))
+	if (board >= SX_NBOARD || !(sx_board[board].flags & SX_BOARD_PRESENT)) {
+		func_exit ();
 		return -ENODEV;
+	}
 	
 	bp = &sx_board[board];
 	port = sx_port + board * SX_NPORT + SX_PORT(tty->index);
+	port->overrun = 0;
+	for (i = 0; i < 10; i++) 
+		port->hits[i]=0;
 
-#ifdef DEBUG_SPECIALIX
-	printk (KERN_DEBUG "Board = %d, bp = %p, port = %p, portno = %d.\n", 
+	dprintk (SX_DEBUG_OPEN, "Board = %d, bp = %p, port = %p, portno = %d.\n", 
 	        board, bp, port, SX_PORT(tty->index));
-#endif
 
-	if (sx_paranoia_check(port, tty->name, "sx_open"))
+	if (sx_paranoia_check(port, tty->name, "sx_open")) {
+		func_enter ();
 		return -ENODEV;
+	}
 
-	if ((error = sx_setup_board(bp)))
+	if ((error = sx_setup_board(bp))) {
+		func_exit ();
 		return error;
+	}
 
+	spin_lock_irqsave(&bp->lock, flags);
 	port->count++;
+	bp->count++;
 	tty->driver_data = port;
 	port->tty = tty;
+	spin_unlock_irqrestore(&bp->lock, flags);
 
-	if ((error = sx_setup_port(bp, port))) 
+	if ((error = sx_setup_port(bp, port))) {
+		func_enter ();
 		return error;
+	}
 	
-	if ((error = block_til_ready(tty, filp, port)))
+	if ((error = block_til_ready(tty, filp, port))) {
+		func_enter ();
 		return error;
+	}
 
+	func_exit ();
 	return 0;
 }
 
@@ -1400,12 +1575,16 @@
 	unsigned long flags;
 	unsigned long timeout;
 	
-	if (!port || sx_paranoia_check(port, tty->name, "close"))
+	func_enter ();
+	if (!port || sx_paranoia_check(port, tty->name, "close")) {
+		func_exit ();
 		return;
-	
-	save_flags(flags); cli();
+	}
+	spin_lock_irqsave(&port->lock, flags);
+
 	if (tty_hung_up_p(filp)) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
+		func_exit ();
 		return;
 	}
 	
@@ -1416,13 +1595,14 @@
 		       board_No(bp), port->count);
 		port->count = 1;
 	}
-	if (--port->count < 0) {
-		printk(KERN_ERR "sx%d: sx_close: bad port count for tty%d: %d\n",
-		       board_No(bp), port_No(port), port->count);
-		port->count = 0;
-	}
-	if (port->count) {
-		restore_flags(flags);
+
+	if (port->count > 1) {
+		port->count--;
+		bp->count--;
+
+		spin_unlock_irqrestore(&port->lock, flags);
+
+		func_exit ();
 		return;
 	}
 	port->flags |= ASYNC_CLOSING;
@@ -1431,20 +1611,26 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+	spin_unlock_irqrestore(&port->lock, flags);
+	dprintk (SX_DEBUG_OPEN, "Closing\n");
+	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE) {
 		tty_wait_until_sent(tty, port->closing_wait);
+	}
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
 	 * interrupt driver to stop checking the data ready bit in the
 	 * line status register.
 	 */
+	dprintk (SX_DEBUG_OPEN, "Closed\n");
 	port->IER &= ~IER_RXD;
 	if (port->flags & ASYNC_INITIALIZED) {
 		port->IER &= ~IER_TXRDY;
 		port->IER |= IER_TXEMPTY;
+		spin_lock_irqsave(&bp->lock, flags);
 		sx_out(bp, CD186x_CAR, port_No(port));
 		sx_out(bp, CD186x_IER, port->IER);
+		spin_unlock_irqrestore(&bp->lock, flags);
 		/*
 		 * Before we drop DTR, make sure the UART transmitter
 		 * has completely drained; this is especially
@@ -1452,6 +1638,7 @@
 		 */
 		timeout = jiffies+HZ;
 		while(port->IER & IER_TXEMPTY) {
+			set_current_state (TASK_INTERRUPTIBLE);
 			msleep_interruptible(jiffies_to_msecs(port->timeout));
 			if (time_after(jiffies, timeout)) {
 				printk (KERN_INFO "Timeout waiting for close\n");
@@ -1460,13 +1647,27 @@
 		}
 
 	}
+
+	if (--bp->count < 0) {
+		printk(KERN_ERR "sx%d: sx_shutdown_port: bad board count: %d port: %d\n",
+		       board_No(bp), bp->count, tty->index);
+		bp->count = 0;
+	}
+	if (--port->count < 0) {
+		printk(KERN_ERR "sx%d: sx_close: bad port count for tty%d: %d\n",
+		       board_No(bp), port_No(port), port->count);
+		port->count = 0;
+	}
+
 	sx_shutdown_port(bp, port);
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
 	tty_ldisc_flush(tty);
+	spin_lock_irqsave(&port->lock, flags);
 	tty->closing = 0;
 	port->event = 0;
 	port->tty = NULL;
+	spin_unlock_irqrestore(&port->lock, flags);	
 	if (port->blocked_open) {
 		if (port->close_delay) {
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
@@ -1475,7 +1676,8 @@
 	}
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
 	wake_up_interruptible(&port->close_wait);
-	restore_flags(flags);
+
+	func_exit ();
 }
 
 
@@ -1486,42 +1688,48 @@
 	struct specialix_board *bp;
 	int c, total = 0;
 	unsigned long flags;
-				
-	if (sx_paranoia_check(port, tty->name, "sx_write"))
+			
+	func_enter ();
+	if (sx_paranoia_check(port, tty->name, "sx_write")) {
+		func_exit ();
 		return 0;
+	}
 	
 	bp = port_Board(port);
 
-	if (!tty || !port->xmit_buf || !tmp_buf)
+	if (!tty || !port->xmit_buf || !tmp_buf) {
+		func_exit ();
 		return 0;
+	}
 
-	save_flags(flags);
 	while (1) {
-		cli();
+		spin_lock_irqsave(&port->lock, flags);
 		c = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 				   SERIAL_XMIT_SIZE - port->xmit_head));
 		if (c <= 0) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&port->lock, flags);
 			break;
 		}
 		memcpy(port->xmit_buf + port->xmit_head, buf, c);
 		port->xmit_head = (port->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 		port->xmit_cnt += c;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 
 		buf += c;
 		count -= c;
 		total += c;
 	}
 
-	cli();
+	spin_lock_irqsave(&bp->lock, flags);
 	if (port->xmit_cnt && !tty->stopped && !tty->hw_stopped &&
 	    !(port->IER & IER_TXRDY)) {
 		port->IER |= IER_TXRDY;
 		sx_out(bp, CD186x_CAR, port_No(port));
 		sx_out(bp, CD186x_IER, port->IER);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
+	func_exit ();
+
 	return total;
 }
 
@@ -1530,24 +1738,36 @@
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	unsigned long flags;
+	struct specialix_board  * bp;
+	
+	func_enter ();
 
-	if (sx_paranoia_check(port, tty->name, "sx_put_char"))
+	if (sx_paranoia_check(port, tty->name, "sx_put_char")) {
+		func_exit ();
 		return;
-
-	if (!tty || !port->xmit_buf)
+	}
+	dprintk (SX_DEBUG_TX, "check tty: %p %p\n", tty, port->xmit_buf);
+	if (!tty || !port->xmit_buf) {
+		func_exit ();
 		return;
+	}
+	bp = port_Board(port);
+	spin_lock_irqsave(&port->lock, flags);
 
-	save_flags(flags); cli();
-	
-	if (port->xmit_cnt >= SERIAL_XMIT_SIZE - 1) {
-		restore_flags(flags);
+	dprintk (SX_DEBUG_TX, "xmit_cnt: %d xmit_buf: %p\n", port->xmit_cnt, port->xmit_buf);
+	if ((port->xmit_cnt >= SERIAL_XMIT_SIZE - 1) || (!port->xmit_buf)) {
+		spin_unlock_irqrestore(&port->lock, flags);
+		dprintk (SX_DEBUG_TX, "Exit size\n");
+		func_exit ();
 		return;
 	}
-
+	dprintk (SX_DEBUG_TX, "Handle xmit: %p %p\n", port, port->xmit_buf);
 	port->xmit_buf[port->xmit_head++] = ch;
 	port->xmit_head &= SERIAL_XMIT_SIZE - 1;
 	port->xmit_cnt++;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	func_exit ();
 }
 
 
@@ -1555,19 +1775,26 @@
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	unsigned long flags;
-				
-	if (sx_paranoia_check(port, tty->name, "sx_flush_chars"))
+	struct specialix_board  * bp = port_Board(port);
+
+	func_enter ();
+
+	if (sx_paranoia_check(port, tty->name, "sx_flush_chars")) {
+		func_exit ();
 		return;
-	
+	}
 	if (port->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped ||
-	    !port->xmit_buf)
+	    !port->xmit_buf) {
+		func_exit ();
 		return;
-
-	save_flags(flags); cli();
+	}
+	spin_lock_irqsave(&bp->lock, flags);
 	port->IER |= IER_TXRDY;
 	sx_out(port_Board(port), CD186x_CAR, port_No(port));
 	sx_out(port_Board(port), CD186x_IER, port->IER);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	func_exit ();
 }
 
 
@@ -1575,13 +1802,19 @@
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	int	ret;
-				
-	if (sx_paranoia_check(port, tty->name, "sx_write_room"))
+			
+	func_enter ();
+	
+	if (sx_paranoia_check(port, tty->name, "sx_write_room")) {
+		func_exit ();
 		return 0;
+	}
 
 	ret = SERIAL_XMIT_SIZE - port->xmit_cnt - 1;
 	if (ret < 0)
 		ret = 0;
+
+	func_exit ();
 	return ret;
 }
 
@@ -1589,10 +1822,14 @@
 static int sx_chars_in_buffer(struct tty_struct *tty)
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
-				
-	if (sx_paranoia_check(port, tty->name, "sx_chars_in_buffer"))
-		return 0;
+			
+	func_enter ();
 	
+	if (sx_paranoia_check(port, tty->name, "sx_chars_in_buffer")) {
+		func_exit ();
+		return 0;
+	}
+	func_exit ();
 	return port->xmit_cnt;
 }
 
@@ -1601,16 +1838,22 @@
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	unsigned long flags;
-				
-	if (sx_paranoia_check(port, tty->name, "sx_flush_buffer"))
+	struct specialix_board  * bp;
+			
+	func_enter ();
+
+	if (sx_paranoia_check(port, tty->name, "sx_flush_buffer")) {
+		func_exit ();
 		return;
+	}
 
-	save_flags(flags); cli();
+	bp = port_Board(port);
+	spin_lock_irqsave(&port->lock, flags);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-	restore_flags(flags);
-	
+	spin_unlock_irqrestore(&port->lock, flags);
 	tty_wakeup(tty);
-	wake_up_interruptible(&tty->write_wait);
+
+	func_exit ();
 }
 
 
@@ -1622,19 +1865,21 @@
 	unsigned int result;
 	unsigned long flags;
 
-	if (sx_paranoia_check(port, tty->name, __FUNCTION__))
+	func_enter ();
+
+	if (sx_paranoia_check(port, tty->name, __FUNCTION__)) {
+		func_exit ();
 		return -ENODEV;
+	}
 
 	bp = port_Board(port);
-	save_flags(flags); cli();
+	spin_lock_irqsave (&bp->lock, flags);
 	sx_out(bp, CD186x_CAR, port_No(port));
 	status = sx_in(bp, CD186x_MSVR);
-	restore_flags(flags);
-#ifdef DEBUG_SPECIALIX
-	printk (KERN_DEBUG "Got msvr[%d] = %02x, car = %d.\n", 
+	spin_unlock_irqrestore(&bp->lock, flags);
+	dprintk (SX_DEBUG_INIT, "Got msvr[%d] = %02x, car = %d.\n", 
 		port_No(port), status, sx_in (bp, CD186x_CAR));
-	printk (KERN_DEBUG "sx_port = %p, port = %p\n", sx_port, port);
-#endif
+	dprintk (SX_DEBUG_INIT, "sx_port = %p, port = %p\n", sx_port, port);
 	if (SX_CRTSCTS(port->tty)) {
 		result  = /*   (status & MSVR_RTS) ? */ TIOCM_DTR /* : 0) */ 
 		          |   ((status & MSVR_DTR) ? TIOCM_RTS : 0)
@@ -1649,6 +1894,8 @@
 		          |   ((status & MSVR_CTS) ? TIOCM_CTS : 0);
 	}
 
+	func_exit ();
+
 	return result;
 }
 
@@ -1660,12 +1907,16 @@
 	unsigned long flags;
 	struct specialix_board *bp;
 
-	if (sx_paranoia_check(port, tty->name, __FUNCTION__))
+	func_enter ();
+
+	if (sx_paranoia_check(port, tty->name, __FUNCTION__)) {
+		func_exit ();
 		return -ENODEV;
+	}
 
 	bp = port_Board(port);
 
-	save_flags(flags); cli();
+	spin_lock_irqsave(&port->lock, flags);
    /*	if (set & TIOCM_RTS)
 		port->MSVR |= MSVR_RTS; */
    /*   if (set & TIOCM_DTR)
@@ -1690,10 +1941,12 @@
 		if (clear & TIOCM_DTR)
 			port->MSVR &= ~MSVR_DTR;
 	}
-
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CAR, port_No(port));
 	sx_out(bp, CD186x_MSVR, port->MSVR);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+	func_exit ();
 	return 0;
 }
 
@@ -1703,17 +1956,25 @@
 	struct specialix_board *bp = port_Board(port);
 	unsigned long flags;
 	
-	save_flags(flags); cli();
+	func_enter ();
+
+	spin_lock_irqsave (&port->lock, flags);
 	port->break_length = SPECIALIX_TPS / HZ * length;
 	port->COR2 |= COR2_ETC;
 	port->IER  |= IER_TXRDY;
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CAR, port_No(port));
 	sx_out(bp, CD186x_COR2, port->COR2);
 	sx_out(bp, CD186x_IER, port->IER);
+	spin_unlock_irqrestore(&bp->lock, flags);
+	spin_unlock_irqrestore (&port->lock, flags);
 	sx_wait_CCR(bp);
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CCR, CCR_CORCHG2);
+	spin_unlock_irqrestore(&bp->lock, flags);
 	sx_wait_CCR(bp);
-	restore_flags(flags);
+
+	func_exit ();
 }
 
 
@@ -1723,10 +1984,19 @@
 	struct serial_struct tmp;
 	struct specialix_board *bp = port_Board(port);
 	int change_speed;
-	unsigned long flags;
-	
-	if (copy_from_user(&tmp, newinfo, sizeof(tmp)))
+
+	func_enter ();
+	/*
+	error = verify_area(VERIFY_READ, (void *) newinfo, sizeof(tmp));
+	if (error) {
+		func_exit ();
+		return error;
+	}
+	*/
+	if (copy_from_user(&tmp, newinfo, sizeof(tmp))) {
+		func_enter ();
 		return -EFAULT;
+	}
 	
 #if 0	
 	if ((tmp.irq != bp->irq) ||
@@ -1735,8 +2005,10 @@
 	    (tmp.baud_base != (SX_OSCFREQ + CD186x_TPC/2) / CD186x_TPC) ||
 	    (tmp.custom_divisor != 0) ||
 	    (tmp.xmit_fifo_size != CD186x_NFIFO) ||
-	    (tmp.flags & ~SPECIALIX_LEGAL_FLAGS))
+	    (tmp.flags & ~SPECIALIX_LEGAL_FLAGS)) {
+		func_exit ();
 		return -EINVAL;
+	}
 #endif	
 
 	change_speed = ((port->flags & ASYNC_SPD_MASK) !=
@@ -1747,8 +2019,10 @@
 		if ((tmp.close_delay != port->close_delay) ||
 		    (tmp.closing_wait != port->closing_wait) ||
 		    ((tmp.flags & ~ASYNC_USR_MASK) !=
-		     (port->flags & ~ASYNC_USR_MASK)))
+		     (port->flags & ~ASYNC_USR_MASK))) {
+			func_exit ();
 			return -EPERM;
+		}
 		port->flags = ((port->flags & ~ASYNC_USR_MASK) |
 		                  (tmp.flags & ASYNC_USR_MASK));
 		port->custom_divisor = tmp.custom_divisor;
@@ -1760,10 +2034,9 @@
 		port->custom_divisor = tmp.custom_divisor;
 	}
 	if (change_speed) {
-		save_flags(flags); cli();
 		sx_change_speed(bp, port);
-		restore_flags(flags);
 	}
+	func_exit ();
 	return 0;
 }
 
@@ -1773,7 +2046,16 @@
 {
 	struct serial_struct tmp;
 	struct specialix_board *bp = port_Board(port);
+	//	int error;
 	
+	func_enter ();
+
+	/*
+	error = verify_area(VERIFY_WRITE, (void *) retinfo, sizeof(tmp));
+	if (error)
+		return error;
+	*/
+
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.type = PORT_CIRRUS;
 	tmp.line = port - sx_port;
@@ -1785,8 +2067,12 @@
 	tmp.closing_wait = port->closing_wait * HZ/100;
 	tmp.custom_divisor =  port->custom_divisor;
 	tmp.xmit_fifo_size = CD186x_NFIFO;
-	if (copy_to_user(retinfo, &tmp, sizeof(tmp)))
+	if (copy_to_user(retinfo, &tmp, sizeof(tmp))) {
+		func_exit ();
 		return -EFAULT;
+	}
+
+	func_exit ();
 	return 0;
 }
 
@@ -1797,44 +2083,63 @@
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	int retval;
 	void __user *argp = (void __user *)arg;
-				
-	if (sx_paranoia_check(port, tty->name, "sx_ioctl"))
+		
+	func_enter ();
+	
+	if (sx_paranoia_check(port, tty->name, "sx_ioctl")) {
+		func_exit ();
 		return -ENODEV;
+	}
 	
 	switch (cmd) {
 	 case TCSBRK:	/* SVID version: non-zero arg --> no break */
 		retval = tty_check_change(tty);
-		if (retval)
+		if (retval) {
+			func_exit ();
 			return retval;
+		}
 		tty_wait_until_sent(tty, 0);
 		if (!arg)
 			sx_send_break(port, HZ/4);	/* 1/4 second */
 		return 0;
 	 case TCSBRKP:	/* support for POSIX tcsendbreak() */
 		retval = tty_check_change(tty);
-		if (retval)
+		if (retval) {
+			func_exit ();
 			return retval;
+		}
 		tty_wait_until_sent(tty, 0);
 		sx_send_break(port, arg ? arg*(HZ/10) : HZ/4);
+		func_exit ();
 		return 0;
 	 case TIOCGSOFTCAR:
-		if (put_user(C_CLOCAL(tty)?1:0, (unsigned long __user *)argp))
-			return -EFAULT;
+		 if (put_user(C_CLOCAL(tty)?1:0, (unsigned long __user *)argp)) {
+			 func_exit ();
+			 return -EFAULT;
+		 }
+		 func_exit ();
 		return 0;
 	 case TIOCSSOFTCAR:
-		if (get_user(arg, (unsigned long __user *) argp))
-			return -EFAULT;
+		 if (get_user(arg, (unsigned long __user *) argp)) {
+			 func_exit ();
+			 return -EFAULT;
+		 }
 		tty->termios->c_cflag =
 			((tty->termios->c_cflag & ~CLOCAL) |
 			(arg ? CLOCAL : 0));
+		func_exit ();
 		return 0;
-	 case TIOCGSERIAL:	
+	 case TIOCGSERIAL:
+		 func_exit ();
 		return sx_get_serial_info(port, argp);
 	 case TIOCSSERIAL:	
+		 func_exit ();
 		return sx_set_serial_info(port, argp);
 	 default:
+		 func_exit ();
 		return -ENOIOCTLCMD;
 	}
+	func_exit ();
 	return 0;
 }
 
@@ -1844,14 +2149,16 @@
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
-				
-	if (sx_paranoia_check(port, tty->name, "sx_throttle"))
+		
+	func_enter ();
+		
+	if (sx_paranoia_check(port, tty->name, "sx_throttle")) {
+		func_exit ();
 		return;
+	}
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
-
 	/* Use DTR instead of RTS ! */
 	if (SX_CRTSCTS (tty)) 
 		port->MSVR &= ~MSVR_DTR;
@@ -1863,14 +2170,22 @@
 		printk (KERN_ERR "sx%d: Need to throttle, but can't (hardware hs is off)\n",
 	                 port_No (port));
 	}
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CAR, port_No(port));
+	spin_unlock_irqrestore(&bp->lock, flags);
 	if (I_IXOFF(tty)) {
+		spin_unlock_irqrestore(&bp->lock, flags);
 		sx_wait_CCR(bp);
+		spin_lock_irqsave(&bp->lock, flags);
 		sx_out(bp, CD186x_CCR, CCR_SSCH2);
+		spin_unlock_irqrestore(&bp->lock, flags);
 		sx_wait_CCR(bp);
 	}
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_MSVR, port->MSVR);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	func_exit ();
 }
 
 
@@ -1879,26 +2194,39 @@
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
+
+	func_enter ();
 				
-	if (sx_paranoia_check(port, tty->name, "sx_unthrottle"))
+	if (sx_paranoia_check(port, tty->name, "sx_unthrottle")) {
+		func_exit ();
 		return;
+	}
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&port->lock, flags);
 	/* XXXX Use DTR INSTEAD???? */
 	if (SX_CRTSCTS(tty)) {
 		port->MSVR |= MSVR_DTR;
 	} /* Else clause: see remark in "sx_throttle"... */
-
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CAR, port_No(port));
+	spin_unlock_irqrestore(&bp->lock, flags);
 	if (I_IXOFF(tty)) {
+		spin_unlock_irqrestore(&port->lock, flags);
 		sx_wait_CCR(bp);
+		spin_lock_irqsave(&bp->lock, flags);
 		sx_out(bp, CD186x_CCR, CCR_SSCH1);
+		spin_unlock_irqrestore(&bp->lock, flags);
 		sx_wait_CCR(bp);
+		spin_lock_irqsave(&port->lock, flags);
 	}
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_MSVR, port->MSVR);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	func_exit ();
 }
 
 
@@ -1907,17 +2235,25 @@
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
-				
-	if (sx_paranoia_check(port, tty->name, "sx_stop"))
-		return;
+			
+	func_enter ();
 	
+	if (sx_paranoia_check(port, tty->name, "sx_stop")) {
+		func_exit ();
+		return;
+	}
+
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&port->lock, flags);
 	port->IER &= ~IER_TXRDY;
+	spin_lock_irqsave(&bp->lock, flags);
 	sx_out(bp, CD186x_CAR, port_No(port));
 	sx_out(bp, CD186x_IER, port->IER);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&bp->lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	func_exit ();
 }
 
 
@@ -1926,19 +2262,27 @@
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	struct specialix_board *bp;
 	unsigned long flags;
+
+	func_enter ();
 				
-	if (sx_paranoia_check(port, tty->name, "sx_start"))
+	if (sx_paranoia_check(port, tty->name, "sx_start")) {
+		func_exit ();
 		return;
+	}
 	
 	bp = port_Board(port);
 	
-	save_flags(flags); cli();
+	spin_lock_irqsave(&port->lock, flags);
 	if (port->xmit_cnt && port->xmit_buf && !(port->IER & IER_TXRDY)) {
 		port->IER |= IER_TXRDY;
+		spin_lock_irqsave(&bp->lock, flags);
 		sx_out(bp, CD186x_CAR, port_No(port));
 		sx_out(bp, CD186x_IER, port->IER);
+		spin_unlock_irqrestore(&bp->lock, flags);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	func_exit ();
 }
 
 
@@ -1956,9 +2300,13 @@
 	struct specialix_port	*port = (struct specialix_port *) private_;
 	struct tty_struct	*tty;
 	
+	func_enter ();
+
 	tty = port->tty;
 	if (tty)
 		tty_hangup(tty);	/* FIXME: module removal race here */
+
+	func_exit ();
 }
 
 
@@ -1966,18 +2314,33 @@
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	struct specialix_board *bp;
-				
-	if (sx_paranoia_check(port, tty->name, "sx_hangup"))
+	unsigned long flags;
+			
+	func_enter ();
+	
+	if (sx_paranoia_check(port, tty->name, "sx_hangup")) {
+		func_exit ();
 		return;
+	}
 	
 	bp = port_Board(port);
 	
 	sx_shutdown_port(bp, port);
+	spin_lock_irqsave(&port->lock, flags);
 	port->event = 0;
+	bp->count -= port->count;
+	if (bp->count < 0) {
+		printk(KERN_ERR "sx%d: sx_hangup: bad board count: %d port: %d\n",
+			board_No(bp), bp->count, tty->index);
+		bp->count = 0;
+	}
 	port->count = 0;
 	port->flags &= ~ASYNC_NORMAL_ACTIVE;
 	port->tty = NULL;
+	spin_unlock_irqrestore(&port->lock, flags);
 	wake_up_interruptible(&port->open_wait);
+
+	func_exit ();
 }
 
 
@@ -1985,6 +2348,7 @@
 {
 	struct specialix_port *port = (struct specialix_port *)tty->driver_data;
 	unsigned long flags;
+	struct specialix_board  * bp;
 				
 	if (sx_paranoia_check(port, tty->name, "sx_set_termios"))
 		return;
@@ -1993,9 +2357,10 @@
 	    tty->termios->c_iflag == old_termios->c_iflag)
 		return;
 
-	save_flags(flags); cli();
+	bp = port_Board(port);
+	spin_lock_irqsave(&port->lock, flags);
 	sx_change_speed(port_Board(port), port);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) &&
 	    !(tty->termios->c_cflag & CRTSCTS)) {
@@ -2009,12 +2374,20 @@
 {
 	struct specialix_port	*port = (struct specialix_port *) private_;
 	struct tty_struct	*tty;
-	
-	if(!(tty = port->tty)) 
+
+	func_enter ();
+
+	if(!(tty = port->tty)) {
+		func_exit ();
 		return;
+	}
 
-	if (test_and_clear_bit(RS_EVENT_WRITE_WAKEUP, &port->event))
-		tty_wakeup(tty);
+	if (test_and_clear_bit(RS_EVENT_WRITE_WAKEUP, &port->event)) {
+ 		tty_wakeup(tty);
+		//wake_up_interruptible(&tty->write_wait);
+	}
+
+	func_exit ();
 }
 
 static struct tty_operations sx_ops = {
@@ -2042,15 +2415,19 @@
 	int error;
 	int i;
 
+	func_enter ();
+
 	specialix_driver = alloc_tty_driver(SX_NBOARD * SX_NPORT);
 	if (!specialix_driver) {
 		printk(KERN_ERR "sx: Couldn't allocate tty_driver.\n");
+		func_exit ();
 		return 1;
 	}
 	
 	if (!(tmp_buf = (unsigned char *) get_zeroed_page(GFP_KERNEL))) {
 		printk(KERN_ERR "sx: Couldn't get free page.\n");
 		put_tty_driver(specialix_driver);
+		func_exit ();
 		return 1;
 	}
 	specialix_driver->owner = THIS_MODULE;
@@ -2069,6 +2446,7 @@
 		free_page((unsigned long)tmp_buf);
 		printk(KERN_ERR "sx: Couldn't register specialix IO8+ driver, error = %d\n",
 		       error);
+		func_exit ();
 		return 1;
 	}
 	memset(sx_port, 0, sizeof(sx_port));
@@ -2080,17 +2458,23 @@
 		sx_port[i].closing_wait = 3000 * HZ/100;
 		init_waitqueue_head(&sx_port[i].open_wait);
 		init_waitqueue_head(&sx_port[i].close_wait);
+		sx_port[i].lock = SPIN_LOCK_UNLOCKED;
 	}
 	
+	func_exit ();
 	return 0;
 }
 
 
 static void sx_release_drivers(void)
 {
+	func_enter ();
+
 	free_page((unsigned long)tmp_buf);
 	tty_unregister_driver(specialix_driver);
 	put_tty_driver(specialix_driver);
+
+	func_exit ();
 }
 
 
@@ -2108,6 +2492,8 @@
 {
 	int i;
         
+	func_enter ();
+
 	for (i=0;i<SX_NBOARD;i++) {
 		sx_board[i].base = 0;
 	}
@@ -2118,6 +2504,8 @@
 		else
 			sx_board[i/2 -1].irq = ints[i];
 	}
+
+	func_exit ();
 }
 #endif
 
@@ -2129,6 +2517,8 @@
 	int i;
 	int found = 0;
 
+	func_enter ();
+
 	printk(KERN_INFO "sx: Specialix IO8+ driver v" VERSION ", (c) R.E.Wolff 1997/1998.\n");
 	printk(KERN_INFO "sx: derived from work (c) D.Gorodchanin 1994-1996.\n");
 #ifdef CONFIG_SPECIALIX_RTSCTS
@@ -2137,8 +2527,13 @@
 	printk (KERN_INFO "sx: DTR/RTS pin is RTS when CRTSCTS is on.\n");
 #endif
 	
-	if (sx_init_drivers()) 
+	for (i = 0; i < SX_NBOARD; i++)
+		sx_board[i].lock = SPIN_LOCK_UNLOCKED;
+
+	if (sx_init_drivers()) {
+		func_exit ();
 		return -EIO;
+	}
 
 	for (i = 0; i < SX_NBOARD; i++) 
 		if (sx_board[i].base && !sx_probe(&sx_board[i]))
@@ -2176,9 +2571,11 @@
 	if (!found) {
 		sx_release_drivers();
 		printk(KERN_INFO "sx: No specialix IO8+ boards detected.\n");
+		func_exit ();
 		return -EIO;
 	}
 
+	func_exit ();
 	return 0;
 }
 
@@ -2188,6 +2585,11 @@
 
 module_param_array(iobase, int, NULL, 0);
 module_param_array(irq, int, NULL, 0);
+module_param(sx_debug, int, 0);
+module_param(sx_rxfifo, int, 0);
+#ifdef SPECIALIX_TIMER
+module_param(sx_poll, int, 0);
+#endif
 
 /*
  * You can setup up to 4 boards.
@@ -2202,13 +2604,20 @@
 {
 	int i;
 
+	func_enter ();
+
+	init_MUTEX(&tmp_buf_sem); /* Init de the semaphore - pvdl */
+
 	if (iobase[0] || iobase[1] || iobase[2] || iobase[3]) {
 		for(i = 0; i < SX_NBOARD; i++) {
 			sx_board[i].base = iobase[i];
 			sx_board[i].irq = irq[i];
+			sx_board[i].count= 0;
 		}
 	}
 
+	func_exit ();
+
 	return specialix_init();
 }
 	
@@ -2216,6 +2625,8 @@
 {
 	int i;
 	
+	func_enter ();
+
 	sx_release_drivers();
 	for (i = 0; i < SX_NBOARD; i++)
 		if (sx_board[i].flags & SX_BOARD_PRESENT) 
@@ -2223,7 +2634,8 @@
 #ifdef SPECIALIX_TIMER
 	del_timer (&missed_irq_timer);
 #endif
-	
+
+	func_exit ();
 }
 
 module_init(specialix_init_module);
diff -u -r linux-2.6.10-rc3-clean/drivers/char/specialix_io8.h linux-2.6.10-rc3-specialix/drivers/char/specialix_io8.h
--- linux-2.6.10-rc3-clean/drivers/char/specialix_io8.h	Sat Aug 14 07:36:10 2004
+++ linux-2.6.10-rc3-specialix/drivers/char/specialix_io8.h	Fri Dec  3 15:19:23 2004
@@ -93,9 +93,11 @@
 	unsigned long   flags;
 	unsigned short	base;
 	unsigned char 	irq;
-	signed   char	count;
+	//signed   char	count;
+	int count;
 	unsigned char	DTR;
         int reg;
+	spinlock_t lock;
 };
 
 #define SX_BOARD_PRESENT	0x00000001
@@ -129,12 +131,9 @@
 	unsigned char		IER;
 	unsigned char		MSVR;
 	unsigned char		COR2;
-#ifdef SX_REPORT_OVERRUN
 	unsigned long		overrun;
-#endif	
-#ifdef SX_REPORT_FIFO
 	unsigned long		hits[10];
-#endif
+	spinlock_t lock;
 };
 
 #endif /* __KERNEL__ */

--3V7upXqbjpZ4EhLz--
