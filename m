Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVAHREx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVAHREx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 12:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVAHREx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 12:04:53 -0500
Received: from out005pub.verizon.net ([206.46.170.143]:44281 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S261219AbVAHRD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 12:03:59 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050108170415.32690.36069.48247@localhost.localdomain>
In-Reply-To: <20050108170406.32690.36989.11853@localhost.localdomain>
References: <20050108170406.32690.36989.11853@localhost.localdomain>
Subject: [RESEND] [PATCH 1/7] ppc: remove cli()/sti() in arch/ppc/4xx_io/serial_sicc.c
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [209.158.220.243] at Sat, 8 Jan 2005 11:03:55 -0600
Date: Sat, 8 Jan 2005 11:03:58 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace save_flags()/restore_flags() with spin_lock_irqsave()/spin_unlock_irqrestore()
and document reasons for using spinlocks.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/4xx_io/serial_sicc.c linux-2.6.10-mm1/arch/ppc/4xx_io/serial_sicc.c
--- linux-2.6.10-mm1-original/arch/ppc/4xx_io/serial_sicc.c	2004-12-24 16:33:49.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/4xx_io/serial_sicc.c	2005-01-07 19:12:42.043984196 -0500
@@ -264,6 +264,7 @@
     unsigned int        flags;
     int         count;
     struct SICC_info    *info;
+    spinlock_t		sicc_lock;
 };
 
 #define SICC_XMIT_SIZE 1024
@@ -385,9 +386,10 @@
     struct SICC_info *info = tty->driver_data;
     unsigned long flags;
 
-    save_flags(flags); cli();
+    /* disable interrupts while stopping serial port interrupts */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     siccuart_disable_tx_interrupt(info);
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
 }
 
 static void siccuart_start(struct tty_struct *tty)
@@ -395,11 +397,12 @@
     struct SICC_info *info = tty->driver_data;
     unsigned long flags;
 
-    save_flags(flags); cli();
+    /* disable interrupts while starting serial port interrupts */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     if (info->xmit.head != info->xmit.tail
         && info->xmit.buf)
         siccuart_enable_tx_interrupt(info);
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
 }
 
 
@@ -604,7 +607,8 @@
 	return -ENOMEM;
     }
 
-    save_flags(flags); cli();
+    /* lock access to info while doing setup */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
 
     if (info->xmit.buf)
         free_page(page);
@@ -688,12 +692,12 @@
     siccuart_enable_rx_interrupt(info);
 
     info->flags |= ASYNC_INITIALIZED;
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     return 0;
 
 
 errout:
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     return retval;
 }
 
@@ -708,7 +712,8 @@
     if (!(info->flags & ASYNC_INITIALIZED))
         return;
 
-    save_flags(flags); cli(); /* Disable interrupts */
+    /* lock while shutting down port */
+    spin_lock_irqsave(&info->state->sicc_lock,flags); /* Disable interrupts */
 
     /*
      * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
@@ -746,7 +751,7 @@
 
     info->flags &= ~ASYNC_INITIALIZED;
 
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
 }
 
 
@@ -868,8 +873,8 @@
             info->ignore_status_mask |=  _LSR_OE_MASK;
     }
 
-    /* first, disable everything */
-    save_flags(flags); cli();
+    /* disable interrupts while reading and clearing registers */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
 
     old_rcr = readb(info->port->uart_base + BL_SICC_RCR);
     old_tcr = readb(info->port->uart_base + BL_SICC_TxCR);
@@ -881,7 +886,7 @@
     /*RLBtrace (&ppc403Chan0, 0x2000000c, 0, 0);*/
 
 
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
 
 
     /* Set baud rate */
@@ -909,12 +914,13 @@
     if (!tty || !info->xmit.buf)
         return;
 
-    save_flags(flags); cli();
+    /* lock info->xmit while adding character to tx buffer */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     if (CIRC_SPACE(info->xmit.head, info->xmit.tail, SICC_XMIT_SIZE) != 0) {
         info->xmit.buf[info->xmit.head] = ch;
         info->xmit.head = (info->xmit.head + 1) & (SICC_XMIT_SIZE - 1);
     }
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
 }
 
 static void siccuart_flush_chars(struct tty_struct *tty)
@@ -928,9 +934,10 @@
         || !info->xmit.buf)
         return;
 
-    save_flags(flags); cli();
+    /* disable interrupts while transmitting characters */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     siccuart_enable_tx_interrupt(info);
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
 }
 
 static int siccuart_write(struct tty_struct *tty,
@@ -943,8 +950,8 @@
     if (!tty || !info->xmit.buf || !tmp_buf)
         return 0;
 
-    save_flags(flags);
-    cli();
+    /* lock info->xmit while removing characters from buffer */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     while (1) {
         c = CIRC_SPACE_TO_END(info->xmit.head,
                       info->xmit.tail,
@@ -960,11 +967,11 @@
         count -= c;
         ret += c;
     }
-    restore_flags(flags);
     if (info->xmit.head != info->xmit.tail
         && !tty->stopped
         && !tty->hw_stopped)
         siccuart_enable_tx_interrupt(info);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     return ret;
 }
 
@@ -988,9 +995,10 @@
     unsigned long flags;
 
     pr_debug("siccuart_flush_buffer(%d) called\n", tty->index);
-    save_flags(flags); cli();
+    /* lock info->xmit while zeroing buffer counts */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     info->xmit.head = info->xmit.tail = 0;
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     wake_up_interruptible(&tty->write_wait);
     if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
         tty->ldisc.write_wakeup)
@@ -1019,10 +1027,11 @@
         siccuart_send_xchar(tty, STOP_CHAR(tty));
 
     if (tty->termios->c_cflag & CRTSCTS) {
-        save_flags(flags); cli();
+        /* disable interrupts while setting modem control lines */
+        spin_lock_irqsave(&info->state->sicc_lock,flags);
         info->mctrl &= ~TIOCM_RTS;
         info->port->set_mctrl(info->port, info->mctrl);
-        restore_flags(flags);
+        spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     }
 }
 
@@ -1039,10 +1048,11 @@
     }
 
     if (tty->termios->c_cflag & CRTSCTS) {
-        save_flags(flags); cli();
+        /* disable interrupts while setting modem control lines */
+        spin_lock_irqsave(&info->state->sicc_lock,flags);
         info->mctrl |= TIOCM_RTS;
         info->port->set_mctrl(info->port, info->mctrl);
-        restore_flags(flags);
+        spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     }
 }
 
@@ -1181,9 +1191,10 @@
     unsigned int result, status;
     unsigned long flags;
 
-    save_flags(flags); cli();
+    /* disable interrupts while reading status from port */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     status = readb(info->port->uart_base +  BL_SICC_LSR);
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     result = status & _LSR_TSR_EMPTY ? TIOCSER_TEMT : 0;
 
     /*
@@ -1234,10 +1245,11 @@
     default:
         return -EINVAL;
     }
-    save_flags(flags); cli();
+    /* disable interrupts while setting modem control lines */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     if (old != info->mctrl)
         info->port->set_mctrl(info->port, info->mctrl);
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     return 0;
 }
 
@@ -1248,14 +1260,15 @@
     unsigned int lcr_h;
 
 
-    save_flags(flags); cli();
+    /* disable interrupts while setting break state */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     lcr_h = readb(info->port + BL_SICC_LSR);
     if (break_state == -1)
         lcr_h |=  _LSR_LB_MASK;
     else
         lcr_h &= ~_LSR_LB_MASK;
     writeb(lcr_h, info->port + BL_SICC_LSRS);
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
 }
 
 static int siccuart_ioctl(struct tty_struct *tty, struct file *file,
@@ -1303,9 +1316,10 @@
          *     RI where only 0->1 is counted.
          */
         case TIOCGICOUNT:
-            save_flags(flags); cli();
+            /* disable interrupts while getting interrupt count */
+            spin_lock_irqsave(&info->state->sicc_lock,flags);
             cnow = info->state->icount;
-            restore_flags(flags);
+            spin_unlock_irqrestore(&info->state->sicc_lock,flags);
             icount.cts = cnow.cts;
             icount.dsr = cnow.dsr;
             icount.rng = cnow.rng;
@@ -1342,22 +1356,24 @@
     /* Handle transition to B0 status */
     if ((old_termios->c_cflag & CBAUD) &&
         !(cflag & CBAUD)) {
-        save_flags(flags); cli();
+        /* disable interrupts while setting break state */
+        spin_lock_irqsave(&info->state->sicc_lock,flags);
         info->mctrl &= ~(TIOCM_RTS | TIOCM_DTR);
         info->port->set_mctrl(info->port, info->mctrl);
-        restore_flags(flags);
+        spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     }
 
     /* Handle transition away from B0 status */
     if (!(old_termios->c_cflag & CBAUD) &&
         (cflag & CBAUD)) {
-        save_flags(flags); cli();
+        /* disable interrupts while setting break state */
+        spin_lock_irqsave(&info->state->sicc_lock,flags);
         info->mctrl |= TIOCM_DTR;
         if (!(cflag & CRTSCTS) ||
             !test_bit(TTY_THROTTLED, &tty->flags))
             info->mctrl |= TIOCM_RTS;
         info->port->set_mctrl(info->port, info->mctrl);
-        restore_flags(flags);
+        spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     }
 
     /* Handle turning off CRTSCTS */
@@ -1393,11 +1409,11 @@
 
     //pr_debug("siccuart_close() called\n");
 
-    save_flags(flags); cli();
+    /* lock tty->driver_data while closing port */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
 
     if (tty_hung_up_p(filp)) {
-        restore_flags(flags);
-        return;
+        goto quick_close;
     }
 
     if ((tty->count == 1) && (state->count != 1)) {
@@ -1416,11 +1432,10 @@
         state->count = 0;
     }
     if (state->count) {
-        restore_flags(flags);
-        return;
+        goto quick_close;
     }
     info->flags |= ASYNC_CLOSING;
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     /*
      * Now we wait for the transmit buffer to clear; and we notify
      * the line discipline to only process XON/XOFF characters.
@@ -1458,6 +1473,11 @@
     }
     info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
     wake_up_interruptible(&info->close_wait);
+    return;
+
+quick_close:
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
+    return;
 }
 
 static void siccuart_wait_until_sent(struct tty_struct *tty, int timeout)
@@ -1569,20 +1589,22 @@
      */
     retval = 0;
     add_wait_queue(&info->open_wait, &wait);
-    save_flags(flags); cli();
+    /* lock while decrementing state->count */
+    spin_lock_irqsave(&info->state->sicc_lock,flags);
     if (!tty_hung_up_p(filp)) {
         extra_count = 1;
         state->count--;
     }
-    restore_flags(flags);
+    spin_unlock_irqrestore(&info->state->sicc_lock,flags);
     info->blocked_open++;
     while (1) {
-        save_flags(flags); cli();
+        /* disable interrupts while setting modem control lines */
+        spin_lock_irqsave(&info->state->sicc_lock,flags);
         if (tty->termios->c_cflag & CBAUD) {
             info->mctrl = TIOCM_DTR | TIOCM_RTS;
             info->port->set_mctrl(info->port, info->mctrl);
         }
-        restore_flags(flags);
+        spin_unlock_irqrestore(&info->state->sicc_lock,flags);
         set_current_state(TASK_INTERRUPTIBLE);
         if (tty_hung_up_p(filp) ||
             !(info->flags & ASYNC_INITIALIZED)) {
@@ -1753,6 +1775,7 @@
         state->line     = i;
         state->close_delay  = 5 * HZ / 10;
         state->closing_wait = 30 * HZ;
+	spin_lock_init(&state->sicc_lock);
     }
 
 
