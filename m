Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbUKIL0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbUKIL0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUKIL0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:26:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:54542 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261511AbUKILKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:10:47 -0500
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
	status changes.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20041109012212.463009c7.akpm@osdl.org>
References: <1099659997.20469.71.camel@localhost.localdomain>
	 <20041109012212.463009c7.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 09 Nov 2004 11:07:17 +0000
Message-Id: <1099998437.6081.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 01:22 -0800, Andrew Morton wrote:
> David Woodhouse <dwmw2@infradead.org> wrote:
> >
> > We weren't flushing the TX FIFO on 8250 uarts when uart_flush_buffer()
> >  was called. This adds a flush_buffer() method to the uart_port
> >  operations and calls it from uart_flush_buffer().
> 
> Your patch makes my computer stop working, which saddens me.

> Maybe the lock which uart_flush_buffer() takes is the same as the lock
> which serial8250_flush_buffer() takes?

Er, yes it is, sorry. This version should make you less unhappy:

===== drivers/char/tty_io.c 1.152 vs edited =====
--- 1.152/drivers/char/tty_io.c	Mon Oct 25 21:06:49 2004
+++ edited/drivers/char/tty_io.c	Fri Nov  5 13:03:32 2004
@@ -720,6 +720,26 @@
 EXPORT_SYMBOL_GPL(tty_wakeup);
 
 /**
+ *	tty_status_change -	notify of line status changes
+ *	@tty: terminal
+ *
+ *	Helper for informing the line discipline that the modem
+ *	status lines may have changed.
+ */
+
+void tty_status_changed(struct tty_struct *tty)
+{
+	struct tty_ldisc *ld = tty_ldisc_ref(tty);
+	if(ld) {
+		if(ld->status_changed)
+			ld->status_changed(tty);
+		tty_ldisc_deref(ld);
+	}
+}
+
+EXPORT_SYMBOL_GPL(tty_status_changed);
+
+/**
  *	tty_ldisc_flush	-	flush line discipline queue
  *	@tty: tty
  *
===== drivers/serial/8250.c 1.77 vs edited =====
--- 1.77/drivers/serial/8250.c	Mon Oct 25 13:05:26 2004
+++ edited/drivers/serial/8250.c	Tue Nov  9 11:05:15 2004
@@ -356,6 +356,20 @@
 	}
 }
 
+static void serial8250_flush_buffer(struct uart_port *port)
+{
+	struct uart_8250_port *up = (struct uart_8250_port *)port;
+	unsigned long flags;
+	unsigned char fcr;
+
+	if (!up->capabilities & UART_CAP_FIFO)
+		return;
+
+	fcr = serial_inp(up, UART_FCR);
+	fcr |= UART_FCR_CLEAR_XMIT;
+	serial_outp(up, UART_FCR, fcr);
+}
+	
 /*
  * IER sleep support.  UARTs which have EFRs need the "extended
  * capability" bit enabled.  Note that on XR16C850s, we need to
@@ -1120,7 +1134,7 @@
 	if (status & UART_MSR_DCTS)
 		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port);
 }
 
 /*
@@ -1940,6 +1954,7 @@
 
 static struct uart_ops serial8250_pops = {
 	.tx_empty	= serial8250_tx_empty,
+	.flush_buffer	= serial8250_flush_buffer,
 	.set_mctrl	= serial8250_set_mctrl,
 	.get_mctrl	= serial8250_get_mctrl,
 	.stop_tx	= serial8250_stop_tx,
===== drivers/serial/amba-pl010.c 1.23 vs edited =====
--- 1.23/drivers/serial/amba-pl010.c	Wed Apr 14 17:31:16 2004
+++ edited/drivers/serial/amba-pl010.c	Fri Nov  5 13:03:32 2004
@@ -277,7 +277,7 @@
 	if (delta & UART01x_FR_CTS)
 		uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
 
-	wake_up_interruptible(&uap->port.info->delta_msr_wait);
+	uart_status_changed(&uap->port);
 }
 
 static irqreturn_t pl010_int(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/serial/amba-pl011.c 1.4 vs edited =====
--- 1.4/drivers/serial/amba-pl011.c	Tue Oct  5 11:04:12 2004
+++ edited/drivers/serial/amba-pl011.c	Fri Nov  5 13:03:32 2004
@@ -240,7 +240,7 @@
 	if (delta & UART01x_FR_CTS)
 		uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
 
-	wake_up_interruptible(&uap->port.info->delta_msr_wait);
+	uart_status_changed(&uap->port);
 }
 
 static irqreturn_t pl011_int(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/serial/au1x00_uart.c 1.3 vs edited =====
--- 1.3/drivers/serial/au1x00_uart.c	Sat Oct 23 00:06:15 2004
+++ edited/drivers/serial/au1x00_uart.c	Fri Nov  5 13:03:32 2004
@@ -375,7 +375,7 @@
 	if (status & UART_MSR_DCTS)
 		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port);
 }
 
 /*
===== drivers/serial/icom.c 1.2 vs edited =====
--- 1.2/drivers/serial/icom.c	Wed Oct 20 09:37:15 2004
+++ edited/drivers/serial/icom.c	Fri Nov  5 13:03:32 2004
@@ -692,8 +692,8 @@
 			uart_handle_cts_change(&icom_port->uart_port,
 					       delta_status & ICOM_CTS);
 
-		wake_up_interruptible(&icom_port->uart_port.info->
-				      delta_msr_wait);
+		uart_status_changed(&icom_port->uart_port);
+
 		old_status = status;
 	}
 	spin_unlock(&icom_port->uart_port.lock);
===== drivers/serial/ip22zilog.c 1.1 vs edited =====
--- 1.1/drivers/serial/ip22zilog.c	Thu Feb 19 03:42:44 2004
+++ edited/drivers/serial/ip22zilog.c	Fri Nov  5 13:03:32 2004
@@ -383,7 +383,7 @@
 			uart_handle_cts_change(&up->port,
 					       (status & CTS));
 
-		wake_up_interruptible(&up->port.info->delta_msr_wait);
+		uart_status_changed(&up->port.info);
 	}
 
 	up->prev_status = status;
===== drivers/serial/pmac_zilog.c 1.15 vs edited =====
--- 1.15/drivers/serial/pmac_zilog.c	Wed Oct 20 09:37:15 2004
+++ edited/drivers/serial/pmac_zilog.c	Fri Nov  5 13:03:32 2004
@@ -361,7 +361,7 @@
 			uart_handle_cts_change(&uap->port,
 					       !(status & CTS));
 
-		wake_up_interruptible(&uap->port.info->delta_msr_wait);
+		uart_status_changed(&uap->port.info);
 	}
 
 	uap->prev_status = status;
===== drivers/serial/pxa.c 1.5 vs edited =====
--- 1.5/drivers/serial/pxa.c	Tue Sep 28 20:35:56 2004
+++ edited/drivers/serial/pxa.c	Fri Nov  5 13:03:32 2004
@@ -251,7 +251,7 @@
 	if (status & UART_MSR_DCTS)
 		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port.info);
 }
 
 /*
===== drivers/serial/sa1100.c 1.26 vs edited =====
--- 1.26/drivers/serial/sa1100.c	Fri Apr  9 22:55:47 2004
+++ edited/drivers/serial/sa1100.c	Fri Nov  5 13:03:32 2004
@@ -120,7 +120,7 @@
 	if (changed & TIOCM_CTS)
 		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);
 
-	wake_up_interruptible(&sport->port.info->delta_msr_wait);
+	uart_status_changed(&sport->port);
 }
 
 /*
===== drivers/serial/serial_core.c 1.92 vs edited =====
--- 1.92/drivers/serial/serial_core.c	Thu Oct 21 18:03:22 2004
+++ edited/drivers/serial/serial_core.c	Fri Nov  5 13:03:32 2004
@@ -567,6 +567,8 @@
 
 	spin_lock_irqsave(&port->lock, flags);
 	uart_circ_clear(&state->info->xmit);
+	if (port->ops->flush_buffer)
+		port->ops->flush_buffer(port);
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_wakeup(tty);
 }
===== drivers/serial/serial_lh7a40x.c 1.1 vs edited =====
--- 1.1/drivers/serial/serial_lh7a40x.c	Sat Jun  5 11:30:48 2004
+++ edited/drivers/serial/serial_lh7a40x.c	Fri Nov  5 13:03:32 2004
@@ -263,7 +263,7 @@
 	if (delta & CTS)
 		uart_handle_cts_change (port, status & CTS);
 
-	wake_up_interruptible (&port->info->delta_msr_wait);
+	uart_status_changed(port);
 }
 
 static irqreturn_t lh7a40xuart_int (int irq, void* dev_id,
===== drivers/serial/sunsab.c 1.35 vs edited =====
--- 1.35/drivers/serial/sunsab.c	Thu Aug 26 23:38:22 2004
+++ edited/drivers/serial/sunsab.c	Fri Nov  5 13:03:32 2004
@@ -305,7 +305,7 @@
 		up->port.icount.dsr++;
 	}
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port.info);
 }
 
 static irqreturn_t sunsab_interrupt(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/serial/sunsu.c 1.45 vs edited =====
--- 1.45/drivers/serial/sunsu.c	Mon Sep 20 21:46:03 2004
+++ edited/drivers/serial/sunsu.c	Fri Nov  5 13:03:32 2004
@@ -453,7 +453,7 @@
 	if (status & UART_MSR_DCTS)
 		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port.info);
 }
 
 static irqreturn_t sunsu_serial_interrupt(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/serial/sunzilog.c 1.46 vs edited =====
--- 1.46/drivers/serial/sunzilog.c	Mon Sep 20 21:46:03 2004
+++ edited/drivers/serial/sunzilog.c	Fri Nov  5 13:03:32 2004
@@ -464,7 +464,7 @@
 			uart_handle_cts_change(&up->port,
 					       (status & CTS));
 
-		wake_up_interruptible(&up->port.info->delta_msr_wait);
+		uart_status_changed(&up->port.info);
 	}
 
 	up->prev_status = status;
===== drivers/serial/uart00.c 1.17 vs edited =====
--- 1.17/drivers/serial/uart00.c	Thu Apr 29 13:14:52 2004
+++ edited/drivers/serial/uart00.c	Fri Nov  5 13:03:32 2004
@@ -249,7 +249,7 @@
 	if (status & UART_MSR_DCTS_MSK)
 		uart_handle_cts_change(port, status & UART_MSR_CTS_MSK);
 
-	wake_up_interruptible(&port->info->delta_msr_wait);
+	uart_status_changed(port);
 }
 
 static irqreturn_t uart00_int(int irq, void *dev_id, struct pt_regs *regs)
===== include/linux/serial_core.h 1.43 vs edited =====
--- 1.43/include/linux/serial_core.h	Tue Sep 14 01:23:24 2004
+++ edited/include/linux/serial_core.h	Fri Nov  5 13:03:32 2004
@@ -108,6 +108,7 @@
  */
 struct uart_ops {
 	unsigned int	(*tx_empty)(struct uart_port *);
+	void		(*flush_buffer)(struct uart_port *);
 	void		(*set_mctrl)(struct uart_port *, unsigned int mctrl);
 	unsigned int	(*get_mctrl)(struct uart_port *);
 	void		(*stop_tx)(struct uart_port *, unsigned int tty_stop);
@@ -448,6 +449,16 @@
 			}
 		}
 	}
+}
+
+/**
+ *	uart_status_changed - notify ldisc of a change of modem status lines
+ *	@post: uart_port structure for the open port
+ */
+static inline void uart_status_changed(struct uart_port *port)
+{
+	tty_status_changed(port->info->tty);
+	wake_up_interruptible(&port->info->delta_msr_wait);
 }
 
 /*
===== include/linux/tty.h 1.30 vs edited =====
--- 1.30/include/linux/tty.h	Thu Oct 21 18:03:22 2004
+++ edited/include/linux/tty.h	Fri Nov  5 13:03:32 2004
@@ -374,6 +374,7 @@
 extern void tty_ldisc_put(int);
 
 extern void tty_wakeup(struct tty_struct *tty);
+extern void tty_status_changed(struct tty_struct *tty);
 extern void tty_ldisc_flush(struct tty_struct *tty);
 
 struct semaphore;
===== include/linux/tty_ldisc.h 1.7 vs edited =====
--- 1.7/include/linux/tty_ldisc.h	Thu Oct 21 18:03:22 2004
+++ edited/include/linux/tty_ldisc.h	Fri Nov  5 13:03:32 2004
@@ -102,6 +102,11 @@
  *	cease I/O to the tty driver. Can sleep. The driver should
  *	seek to perform this action quickly but should wait until
  *	any pending driver I/O is completed.
+ *
+ * void (*status_changed)(struct tty_struct *)
+ *
+ *	Called when the modem status lines (CTS, DSR, DCD etc.) are
+ *	changed. May not sleep. 
  */
 
 #include <linux/fs.h>
@@ -138,6 +143,7 @@
 			       char *fp, int count);
 	int	(*receive_room)(struct tty_struct *);
 	void	(*write_wakeup)(struct tty_struct *);
+	void	(*status_changed)(struct tty_struct *);
 
 	struct  module *owner;
 	

-- 
dwmw2

