Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUG2PKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUG2PKP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267611AbUG2PIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:08:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15868 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264299AbUG2OOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:14:33 -0400
Date: Thu, 29 Jul 2004 16:14:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: support@moxa.com.tw, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mxser.c: fix inlines (fwd)
Message-ID: <20040729141427.GY2349@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI:
The patch forwarded below is still required in 2.6.8-rc2-mm1.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Tue, 13 Jul 2004 02:20:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: support@moxa.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mxser.c: fix inlines

Trying to compile drivers/char/mxser.c with gcc 3.4 and
  # define inline         __inline__ __attribute__((always_inline))
results in the following compile error:

<--  snip  -->

...
  CC      drivers/char/mxser.o
drivers/char/mxser.c: In function `mxser_interrupt':
drivers/char/mxser.c:352: sorry, unimplemented: inlining failed in call 
to 'mxser_receive_chars': function body not available
drivers/char/mxser.c:1347: sorry, unimplemented: called from here
drivers/char/mxser.c:354: sorry, unimplemented: inlining failed in call 
to 'mxser_check_modem_status': function body not available
drivers/char/mxser.c:1350: sorry, unimplemented: called from here
drivers/char/mxser.c:353: sorry, unimplemented: inlining failed in call 
to 'mxser_transmit_chars': function body not available
drivers/char/mxser.c:1355: sorry, unimplemented: called from here
make[2]: *** [drivers/char/mxser.o] Error 1

<--  snip  -->


The patch below moves mxser_interrupt below the inline functions it 
uses.


An alternative approach would be to remove the inlines.


diffstat output:
 drivers/char/mxser.c |  128 +++++++++++++++++++++----------------------
 1 files changed, 64 insertions(+), 64 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full-gcc3.4/drivers/char/mxser.c.old	2004-07-13 02:12:23.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/drivers/char/mxser.c	2004-07-13 02:16:13.000000000 +0200
@@ -348,10 +348,10 @@
 static void mxser_stop(struct tty_struct *);
 static void mxser_start(struct tty_struct *);
 static void mxser_hangup(struct tty_struct *);
-static irqreturn_t mxser_interrupt(int, void *, struct pt_regs *);
 static inline void mxser_receive_chars(struct mxser_struct *, int *);
 static inline void mxser_transmit_chars(struct mxser_struct *);
 static inline void mxser_check_modem_status(struct mxser_struct *, int);
+static irqreturn_t mxser_interrupt(int, void *, struct pt_regs *);
 static int mxser_block_til_ready(struct tty_struct *, struct file *, struct mxser_struct *);
 static int mxser_startup(struct mxser_struct *);
 static void mxser_shutdown(struct mxser_struct *);
@@ -1302,69 +1302,6 @@
 	wake_up_interruptible(&info->open_wait);
 }
 
-/*
- * This is the serial driver's generic interrupt routine
- */
-static irqreturn_t mxser_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	int status, i;
-	struct mxser_struct *info;
-	struct mxser_struct *port;
-	int max, irqbits, bits, msr;
-	int pass_counter = 0;
-	int handled = 0;
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
-		return IRQ_NONE;
-	if (port == 0)
-		return IRQ_NONE;
-	max = mxser_numports[mxsercfg[i].board_type];
-
-	while (1) {
-		irqbits = inb(port->vector) & port->vectormask;
-		if (irqbits == port->vectormask)
-			break;
-		handled = 1;
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
-	return IRQ_RETVAL(handled);
-}
-
 static inline void mxser_receive_chars(struct mxser_struct *info,
 					 int *status)
 {
@@ -1485,6 +1422,69 @@
 	}
 }
 
+/*
+ * This is the serial driver's generic interrupt routine
+ */
+static irqreturn_t mxser_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int status, i;
+	struct mxser_struct *info;
+	struct mxser_struct *port;
+	int max, irqbits, bits, msr;
+	int pass_counter = 0;
+	int handled = 0;
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
+		return IRQ_NONE;
+	if (port == 0)
+		return IRQ_NONE;
+	max = mxser_numports[mxsercfg[i].board_type];
+
+	while (1) {
+		irqbits = inb(port->vector) & port->vectormask;
+		if (irqbits == port->vectormask)
+			break;
+		handled = 1;
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
+	return IRQ_RETVAL(handled);
+}
+
 static int mxser_block_til_ready(struct tty_struct *tty, struct file *filp,
 				 struct mxser_struct *info)
 {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

