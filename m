Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUHQP1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUHQP1f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268299AbUHQPYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:24:25 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:56028 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S268285AbUHQPPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:15:22 -0400
Message-ID: <412220D5.2020403@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:14:29 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [2/10]
Content-Type: multipart/mixed;
	boundary="------------050405060307040101070100"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050405060307040101070100
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------050405060307040101070100
Content-Type: text/plain;
	name="gcc34_inline_02.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_02.diff"

--- 28p1/drivers/char/mxser.c~	2004-08-16 20:12:59.000000000 +0300
+++ 28p1/drivers/char/mxser.c	2004-08-16 21:17:23.000000000 +0300
@@ -1385,66 +1385,6 @@
 	wake_up_interruptible(&info->open_wait);
 }
 
-/*
- * This is the serial driver's generic interrupt routine
- */
-static void mxser_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	int status, i;
-	struct mxser_struct *info;
-	struct mxser_struct *port;
-	int max, irqbits, bits, msr;
-	int pass_counter = 0;
-
-	port = 0;
-	for (i = 0; i < MXSER_BOARDS; i++) {
-		if (dev_id == &(mxvar_table[i * MXSER_PORTS_PER_BOARD])) {
-			port = dev_id;
-			break;
-		}
-	}
-
-	if (i == MXSER_BOARDS)
-		return;
-	if (port == 0)
-		return;
-	max = mxser_numports[mxsercfg[i].board_type];
-
-	while (1) {
-		irqbits = inb(port->vector) & port->vectormask;
-		if (irqbits == port->vectormask)
-			break;
-		for (i = 0, bits = 1; i < max; i++, irqbits |= bits, bits <<= 1) {
-			if (irqbits == port->vectormask)
-				break;
-			if (bits & irqbits)
-				continue;
-			info = port + i;
-			if (!info->tty ||
-			  (inb(info->base + UART_IIR) & UART_IIR_NO_INT))
-				continue;
-			status = inb(info->base + UART_LSR) & info->read_status_mask;
-			if (status & UART_LSR_DR)
-				mxser_receive_chars(info, &status);
-			msr = inb(info->base + UART_MSR);
-			if (msr & UART_MSR_ANY_DELTA)
-				mxser_check_modem_status(info, msr);
-			if (status & UART_LSR_THRE) {
-/* 8-2-99 by William
-   if ( info->x_char || (info->xmit_cnt > 0) )
- */
-				mxser_transmit_chars(info);
-			}
-		}
-		if (pass_counter++ > MXSER_ISR_PASS_LIMIT) {
-#if 0
-			printk("MOXA Smartio/Indusrtio family driver interrupt loop break\n");
-#endif
-			break;	/* Prevent infinite loops */
-		}
-	}
-}
-
 static inline void mxser_receive_chars(struct mxser_struct *info,
 					 int *status)
 {
@@ -1487,44 +1427,6 @@
 
 }
 
-static inline void mxser_transmit_chars(struct mxser_struct *info)
-{
-	int count, cnt;
-
-	if (info->x_char) {
-		outb(info->x_char, info->base + UART_TX);
-		info->x_char = 0;
-		mxvar_log.txcnt[info->port]++;
-		return;
-	}
-	if ((info->xmit_cnt <= 0) || info->tty->stopped ||
-	    info->tty->hw_stopped) {
-		info->IER &= ~UART_IER_THRI;
-		outb(info->IER, info->base + UART_IER);
-		return;
-	}
-	cnt = info->xmit_cnt;
-	count = info->xmit_fifo_size;
-	do {
-		outb(info->xmit_buf[info->xmit_tail++], info->base + UART_TX);
-		info->xmit_tail = info->xmit_tail & (SERIAL_XMIT_SIZE - 1);
-		if (--info->xmit_cnt <= 0)
-			break;
-	} while (--count > 0);
-	mxvar_log.txcnt[info->port] += (cnt - info->xmit_cnt);
-
-	if (info->xmit_cnt < WAKEUP_CHARS) {
-		set_bit(MXSER_EVENT_TXLOW, &info->event);
-		MOD_INC_USE_COUNT;
-		if (schedule_task(&info->tqueue) == 0)
-		    MOD_DEC_USE_COUNT;
-	}
-	if (info->xmit_cnt <= 0) {
-		info->IER &= ~UART_IER_THRI;
-		outb(info->IER, info->base + UART_IER);
-	}
-}
-
 static inline void mxser_check_modem_status(struct mxser_struct *info,
 					      int status)
 {
@@ -1572,6 +1474,104 @@
 	}
 }
 
+static inline void mxser_transmit_chars(struct mxser_struct *info)
+{
+	int count, cnt;
+
+	if (info->x_char) {
+		outb(info->x_char, info->base + UART_TX);
+		info->x_char = 0;
+		mxvar_log.txcnt[info->port]++;
+		return;
+	}
+	if ((info->xmit_cnt <= 0) || info->tty->stopped ||
+	    info->tty->hw_stopped) {
+		info->IER &= ~UART_IER_THRI;
+		outb(info->IER, info->base + UART_IER);
+		return;
+	}
+	cnt = info->xmit_cnt;
+	count = info->xmit_fifo_size;
+	do {
+		outb(info->xmit_buf[info->xmit_tail++], info->base + UART_TX);
+		info->xmit_tail = info->xmit_tail & (SERIAL_XMIT_SIZE - 1);
+		if (--info->xmit_cnt <= 0)
+			break;
+	} while (--count > 0);
+	mxvar_log.txcnt[info->port] += (cnt - info->xmit_cnt);
+
+	if (info->xmit_cnt < WAKEUP_CHARS) {
+		set_bit(MXSER_EVENT_TXLOW, &info->event);
+		MOD_INC_USE_COUNT;
+		if (schedule_task(&info->tqueue) == 0)
+		    MOD_DEC_USE_COUNT;
+	}
+	if (info->xmit_cnt <= 0) {
+		info->IER &= ~UART_IER_THRI;
+		outb(info->IER, info->base + UART_IER);
+	}
+}
+
+/*
+ * This is the serial driver's generic interrupt routine
+ */
+static void mxser_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int status, i;
+	struct mxser_struct *info;
+	struct mxser_struct *port;
+	int max, irqbits, bits, msr;
+	int pass_counter = 0;
+
+	port = 0;
+	for (i = 0; i < MXSER_BOARDS; i++) {
+		if (dev_id == &(mxvar_table[i * MXSER_PORTS_PER_BOARD])) {
+			port = dev_id;
+			break;
+		}
+	}
+
+	if (i == MXSER_BOARDS)
+		return;
+	if (port == 0)
+		return;
+	max = mxser_numports[mxsercfg[i].board_type];
+
+	while (1) {
+		irqbits = inb(port->vector) & port->vectormask;
+		if (irqbits == port->vectormask)
+			break;
+		for (i = 0, bits = 1; i < max; i++, irqbits |= bits, bits <<= 1) {
+			if (irqbits == port->vectormask)
+				break;
+			if (bits & irqbits)
+				continue;
+			info = port + i;
+			if (!info->tty ||
+			  (inb(info->base + UART_IIR) & UART_IIR_NO_INT))
+				continue;
+			status = inb(info->base + UART_LSR) & info->read_status_mask;
+			if (status & UART_LSR_DR)
+				mxser_receive_chars(info, &status);
+			msr = inb(info->base + UART_MSR);
+			if (msr & UART_MSR_ANY_DELTA)
+				mxser_check_modem_status(info, msr);
+			if (status & UART_LSR_THRE) {
+/* 8-2-99 by William
+   if ( info->x_char || (info->xmit_cnt > 0) )
+ */
+				mxser_transmit_chars(info);
+			}
+		}
+		if (pass_counter++ > MXSER_ISR_PASS_LIMIT) {
+#if 0
+			printk("MOXA Smartio/Indusrtio family driver interrupt loop break\n");
+#endif
+			break;	/* Prevent infinite loops */
+		}
+	}
+}
+
 static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
 				 struct mxser_struct *info)
 {
--- 28p1/drivers/char/istallion.c~	2004-08-16 20:12:59.000000000 +0300
+++ 28p1/drivers/char/istallion.c	2004-08-16 21:27:24.000000000 +0300
@@ -4546,6 +4546,26 @@
 /*****************************************************************************/
 
 /*
+ *	Find the next available board number that is free.
+ */
+
+static inline int stli_getbrdnr()
+{
+	int	i;
+
+	for (i = 0; (i < STL_MAXBRDS); i++) {
+		if (stli_brds[i] == (stlibrd_t *) NULL) {
+			if (i >= stli_nrbrds)
+				stli_nrbrds = i + 1;
+			return(i);
+		}
+	}
+	return(-1);
+}
+
+/*****************************************************************************/
+
+/*
  *	Probe around and try to find any EISA boards in system. The biggest
  *	problem here is finding out what memory address is associated with
  *	an EISA board after it is found. The registers of the ECPE and
@@ -4625,26 +4645,6 @@
 
 /*****************************************************************************/
 
-/*
- *	Find the next available board number that is free.
- */
-
-static inline int stli_getbrdnr()
-{
-	int	i;
-
-	for (i = 0; (i < STL_MAXBRDS); i++) {
-		if (stli_brds[i] == (stlibrd_t *) NULL) {
-			if (i >= stli_nrbrds)
-				stli_nrbrds = i + 1;
-			return(i);
-		}
-	}
-	return(-1);
-}
-
-/*****************************************************************************/
-
 #ifdef	CONFIG_PCI
 
 /*
--- 28p1/drivers/char/ip2main.c~	2004-08-16 20:12:59.000000000 +0300
+++ 28p1/drivers/char/ip2main.c	2004-08-16 21:41:24.000000000 +0300
@@ -282,8 +282,8 @@
 static void ip2_interrupt(int irq, void *dev_id, struct pt_regs * regs);
 static void ip2_poll(unsigned long arg);
 static inline void service_all_boards(void);
-static inline void do_input(i2ChanStrPtr pCh);
-static inline void do_status(i2ChanStrPtr pCh);
+static void do_input(i2ChanStrPtr pCh);
+static void do_status(i2ChanStrPtr pCh);
 
 static void ip2_wait_until_sent(PTTY,int);
 
@@ -1433,7 +1433,7 @@
 	ip2trace (ITRC_NO_PORT, ITRC_INTR, ITRC_RETURN, 0 );
 }
 
-static inline void 
+static void 
 do_input( i2ChanStrPtr pCh )
 {
 	unsigned long flags;
@@ -1468,7 +1468,7 @@
 	}
 }
 
-static inline void
+static void
 do_status( i2ChanStrPtr pCh )
 {
 	int status;

--------------050405060307040101070100--
