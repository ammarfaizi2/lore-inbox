Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVADVvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVADVvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 16:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbVADVqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 16:46:08 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:28153 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262273AbVADVkg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:40:36 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050104214054.21749.48616.58958@localhost.localdomain>
In-Reply-To: <20050104214048.21749.85722.89116@localhost.localdomain>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
Subject: [PATCH 1/7] ppc: remove cli()/sti() in arch/ppc/4xx_io/serial_sicc.c
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 15:40:34 -0600
Date: Tue, 4 Jan 2005 15:40:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/ppc/4xx_io/serial_sicc.c linux-2.6.10-mm1/arch/ppc/4xx_io/serial_sicc.c
--- linux-2.6.10-mm1-original/arch/ppc/4xx_io/serial_sicc.c	2004-12-24 16:33:49.000000000 -0500
+++ linux-2.6.10-mm1/arch/ppc/4xx_io/serial_sicc.c	2005-01-03 19:55:54.048289892 -0500
@@ -385,9 +385,9 @@
     struct SICC_info *info = tty->driver_data;
     unsigned long flags;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
     siccuart_disable_tx_interrupt(info);
-    restore_flags(flags);
+    local_irq_restore(flags);
 }
 
 static void siccuart_start(struct tty_struct *tty)
@@ -395,11 +395,11 @@
     struct SICC_info *info = tty->driver_data;
     unsigned long flags;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
     if (info->xmit.head != info->xmit.tail
         && info->xmit.buf)
         siccuart_enable_tx_interrupt(info);
-    restore_flags(flags);
+    local_irq_restore(flags);
 }
 
 
@@ -604,7 +604,7 @@
 	return -ENOMEM;
     }
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 
     if (info->xmit.buf)
         free_page(page);
@@ -688,12 +688,12 @@
     siccuart_enable_rx_interrupt(info);
 
     info->flags |= ASYNC_INITIALIZED;
-    restore_flags(flags);
+    local_irq_restore(flags);
     return 0;
 
 
 errout:
-    restore_flags(flags);
+    local_irq_restore(flags);
     return retval;
 }
 
@@ -708,7 +708,7 @@
     if (!(info->flags & ASYNC_INITIALIZED))
         return;
 
-    save_flags(flags); cli(); /* Disable interrupts */
+    local_irq_save(flags); /* Disable interrupts */
 
     /*
      * clear delta_msr_wait queue to avoid mem leaks: we may free the irq
@@ -746,7 +746,7 @@
 
     info->flags &= ~ASYNC_INITIALIZED;
 
-    restore_flags(flags);
+    local_irq_restore(flags);
 }
 
 
@@ -869,7 +869,7 @@
     }
 
     /* first, disable everything */
-    save_flags(flags); cli();
+    local_irq_save(flags);
 
     old_rcr = readb(info->port->uart_base + BL_SICC_RCR);
     old_tcr = readb(info->port->uart_base + BL_SICC_TxCR);
@@ -881,7 +881,7 @@
     /*RLBtrace (&ppc403Chan0, 0x2000000c, 0, 0);*/
 
 
-    restore_flags(flags);
+    local_irq_restore(flags);
 
 
     /* Set baud rate */
@@ -909,12 +909,12 @@
     if (!tty || !info->xmit.buf)
         return;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
     if (CIRC_SPACE(info->xmit.head, info->xmit.tail, SICC_XMIT_SIZE) != 0) {
         info->xmit.buf[info->xmit.head] = ch;
         info->xmit.head = (info->xmit.head + 1) & (SICC_XMIT_SIZE - 1);
     }
-    restore_flags(flags);
+    local_irq_restore(flags);
 }
 
 static void siccuart_flush_chars(struct tty_struct *tty)
@@ -928,9 +928,9 @@
         || !info->xmit.buf)
         return;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
     siccuart_enable_tx_interrupt(info);
-    restore_flags(flags);
+    local_irq_restore(flags);
 }
 
 static int siccuart_write(struct tty_struct *tty,
@@ -943,8 +943,7 @@
     if (!tty || !info->xmit.buf || !tmp_buf)
         return 0;
 
-    save_flags(flags);
-    cli();
+    local_irq_save(flags);
     while (1) {
         c = CIRC_SPACE_TO_END(info->xmit.head,
                       info->xmit.tail,
@@ -960,7 +959,7 @@
         count -= c;
         ret += c;
     }
-    restore_flags(flags);
+    local_irq_restore(flags);
     if (info->xmit.head != info->xmit.tail
         && !tty->stopped
         && !tty->hw_stopped)
@@ -988,9 +987,9 @@
     unsigned long flags;
 
     pr_debug("siccuart_flush_buffer(%d) called\n", tty->index);
-    save_flags(flags); cli();
+    local_irq_save(flags);
     info->xmit.head = info->xmit.tail = 0;
-    restore_flags(flags);
+    local_irq_restore(flags);
     wake_up_interruptible(&tty->write_wait);
     if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
         tty->ldisc.write_wakeup)
@@ -1019,10 +1018,10 @@
         siccuart_send_xchar(tty, STOP_CHAR(tty));
 
     if (tty->termios->c_cflag & CRTSCTS) {
-        save_flags(flags); cli();
+        local_irq_save(flags);
         info->mctrl &= ~TIOCM_RTS;
         info->port->set_mctrl(info->port, info->mctrl);
-        restore_flags(flags);
+        local_irq_restore(flags);
     }
 }
 
@@ -1039,10 +1038,10 @@
     }
 
     if (tty->termios->c_cflag & CRTSCTS) {
-        save_flags(flags); cli();
+        local_irq_save(flags);
         info->mctrl |= TIOCM_RTS;
         info->port->set_mctrl(info->port, info->mctrl);
-        restore_flags(flags);
+        local_irq_restore(flags);
     }
 }
 
@@ -1181,9 +1180,9 @@
     unsigned int result, status;
     unsigned long flags;
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
     status = readb(info->port->uart_base +  BL_SICC_LSR);
-    restore_flags(flags);
+    local_irq_restore(flags);
     result = status & _LSR_TSR_EMPTY ? TIOCSER_TEMT : 0;
 
     /*
@@ -1234,10 +1233,10 @@
     default:
         return -EINVAL;
     }
-    save_flags(flags); cli();
+    local_irq_save(flags);
     if (old != info->mctrl)
         info->port->set_mctrl(info->port, info->mctrl);
-    restore_flags(flags);
+    local_irq_restore(flags);
     return 0;
 }
 
@@ -1248,14 +1247,14 @@
     unsigned int lcr_h;
 
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
     lcr_h = readb(info->port + BL_SICC_LSR);
     if (break_state == -1)
         lcr_h |=  _LSR_LB_MASK;
     else
         lcr_h &= ~_LSR_LB_MASK;
     writeb(lcr_h, info->port + BL_SICC_LSRS);
-    restore_flags(flags);
+    local_irq_restore(flags);
 }
 
 static int siccuart_ioctl(struct tty_struct *tty, struct file *file,
@@ -1303,9 +1302,9 @@
          *     RI where only 0->1 is counted.
          */
         case TIOCGICOUNT:
-            save_flags(flags); cli();
+            local_irq_save(flags);
             cnow = info->state->icount;
-            restore_flags(flags);
+            local_irq_restore(flags);
             icount.cts = cnow.cts;
             icount.dsr = cnow.dsr;
             icount.rng = cnow.rng;
@@ -1342,22 +1341,22 @@
     /* Handle transition to B0 status */
     if ((old_termios->c_cflag & CBAUD) &&
         !(cflag & CBAUD)) {
-        save_flags(flags); cli();
+        local_irq_save(flags);
         info->mctrl &= ~(TIOCM_RTS | TIOCM_DTR);
         info->port->set_mctrl(info->port, info->mctrl);
-        restore_flags(flags);
+        local_irq_restore(flags);
     }
 
     /* Handle transition away from B0 status */
     if (!(old_termios->c_cflag & CBAUD) &&
         (cflag & CBAUD)) {
-        save_flags(flags); cli();
+        local_irq_save(flags);
         info->mctrl |= TIOCM_DTR;
         if (!(cflag & CRTSCTS) ||
             !test_bit(TTY_THROTTLED, &tty->flags))
             info->mctrl |= TIOCM_RTS;
         info->port->set_mctrl(info->port, info->mctrl);
-        restore_flags(flags);
+        local_irq_restore(flags);
     }
 
     /* Handle turning off CRTSCTS */
@@ -1393,10 +1392,10 @@
 
     //pr_debug("siccuart_close() called\n");
 
-    save_flags(flags); cli();
+    local_irq_save(flags);
 
     if (tty_hung_up_p(filp)) {
-        restore_flags(flags);
+        local_irq_restore(flags);
         return;
     }
 
@@ -1416,11 +1415,11 @@
         state->count = 0;
     }
     if (state->count) {
-        restore_flags(flags);
+        local_irq_restore(flags);
         return;
     }
     info->flags |= ASYNC_CLOSING;
-    restore_flags(flags);
+    local_irq_restore(flags);
     /*
      * Now we wait for the transmit buffer to clear; and we notify
      * the line discipline to only process XON/XOFF characters.
@@ -1569,20 +1568,20 @@
      */
     retval = 0;
     add_wait_queue(&info->open_wait, &wait);
-    save_flags(flags); cli();
+    local_irq_save(flags);
     if (!tty_hung_up_p(filp)) {
         extra_count = 1;
         state->count--;
     }
-    restore_flags(flags);
+    local_irq_restore(flags);
     info->blocked_open++;
     while (1) {
-        save_flags(flags); cli();
+        local_irq_save(flags);
         if (tty->termios->c_cflag & CBAUD) {
             info->mctrl = TIOCM_DTR | TIOCM_RTS;
             info->port->set_mctrl(info->port, info->mctrl);
         }
-        restore_flags(flags);
+        local_irq_restore(flags);
         set_current_state(TASK_INTERRUPTIBLE);
         if (tty_hung_up_p(filp) ||
             !(info->flags & ASYNC_INITIALIZED)) {
