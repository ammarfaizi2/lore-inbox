Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbUKENSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbUKENSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 08:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbUKENRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 08:17:16 -0500
Received: from canuck.infradead.org ([205.233.218.70]:7430 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262678AbUKENLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 08:11:38 -0500
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
	status changes.
From: David Woodhouse <dwmw2@infradead.org>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1099659997.20469.71.camel@localhost.localdomain>
References: <1099659997.20469.71.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 13:08:51 +0000
Message-Id: <1099660132.20469.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-05 at 13:06 +0000, David Woodhouse wrote:
> We weren't flushing the TX FIFO on 8250 uarts when uart_flush_buffer()
> was called. This adds a flush_buffer() method to the uart_port
> operations and calls it from uart_flush_buffer().
> 
> This also adds a method to the line discipline which is called upon line
> status changes, and uses the helper function for that to clean up the
> uart hardware drivers slightly, removing the explicit wakeup on
> delta_msr_wait which is used for TIOCMIWAIT.
> 
> I'll be putting together a line discipline which actually needs this
> callback shortly.

Doh.

===== drivers/char/tty_io.c 1.152 vs edited =====
--- 1.152/drivers/char/tty_io.c	2004-10-25 21:06:49 +01:00
+++ edited/drivers/char/tty_io.c	2004-11-05 12:28:24 +00:00
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
===== drivers/serial/8250.c 1.89 vs edited =====
--- 1.89/drivers/serial/8250.c	2004-11-02 09:31:48 +00:00
+++ edited/drivers/serial/8250.c	2004-11-05 12:59:51 +00:00
@@ -351,6 +351,24 @@
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
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	fcr = serial_inp(up, UART_FCR);
+	fcr |= UART_FCR_CLEAR_XMIT;
+	serial_outp(up, UART_FCR, fcr);
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+	
 /*
  * IER sleep support.  UARTs which have EFRs need the "extended
  * capability" bit enabled.  Note that on XR16C850s, we need to
@@ -1115,7 +1133,7 @@
 	if (status & UART_MSR_DCTS)
 		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port);
 }
 
 /*
@@ -1916,6 +1934,7 @@
 
 static struct uart_ops serial8250_pops = {
 	.tx_empty	= serial8250_tx_empty,
+	.flush_buffer	= serial8250_flush_buffer,
 	.set_mctrl	= serial8250_set_mctrl,
 	.get_mctrl	= serial8250_get_mctrl,
 	.stop_tx	= serial8250_stop_tx,
===== drivers/serial/amba-pl010.c 1.23 vs edited =====
--- 1.23/drivers/serial/amba-pl010.c	2004-04-14 17:31:16 +01:00
+++ edited/drivers/serial/amba-pl010.c	2004-11-05 12:51:09 +00:00
@@ -277,7 +277,7 @@
 	if (delta & UART01x_FR_CTS)
 		uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
 
-	wake_up_interruptible(&uap->port.info->delta_msr_wait);
+	uart_status_changed(&uap->port);
 }
 
 static irqreturn_t pl010_int(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/serial/amba-pl011.c 1.5 vs edited =====
--- 1.5/drivers/serial/amba-pl011.c	2004-10-30 15:09:16 +01:00
+++ edited/drivers/serial/amba-pl011.c	2004-11-05 12:51:31 +00:00
@@ -240,7 +240,7 @@
 	if (delta & UART01x_FR_CTS)
 		uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
 
-	wake_up_interruptible(&uap->port.info->delta_msr_wait);
+	uart_status_changed(&uap->port);
 }
 
 static irqreturn_t pl011_int(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/serial/au1x00_uart.c 1.4 vs edited =====
--- 1.4/drivers/serial/au1x00_uart.c	2004-10-30 23:12:12 +01:00
+++ edited/drivers/serial/au1x00_uart.c	2004-11-05 12:51:57 +00:00
@@ -375,7 +375,7 @@
 	if (status & UART_MSR_DCTS)
 		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port);
 }
 
 /*
===== drivers/serial/icom.c 1.3 vs edited =====
--- 1.3/drivers/serial/icom.c	2004-11-01 12:29:39 +00:00
+++ edited/drivers/serial/icom.c	2004-11-05 12:52:33 +00:00
@@ -686,8 +686,8 @@
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
--- 1.1/drivers/serial/ip22zilog.c	2004-02-19 03:42:44 +00:00
+++ edited/drivers/serial/ip22zilog.c	2004-11-05 12:53:18 +00:00
@@ -383,7 +383,7 @@
 			uart_handle_cts_change(&up->port,
 					       (status & CTS));
 
-		wake_up_interruptible(&up->port.info->delta_msr_wait);
+		uart_status_changed(&up->port.info);
 	}
 
 	up->prev_status = status;
===== drivers/serial/pmac_zilog.c 1.16 vs edited =====
--- 1.16/drivers/serial/pmac_zilog.c	2004-11-01 12:29:40 +00:00
+++ edited/drivers/serial/pmac_zilog.c	2004-11-05 12:53:45 +00:00
@@ -361,7 +361,7 @@
 			uart_handle_cts_change(&uap->port,
 					       !(status & CTS));
 
-		wake_up_interruptible(&uap->port.info->delta_msr_wait);
+		uart_status_changed(&uap->port.info);
 	}
 
 	uap->prev_status = status;
===== drivers/serial/pxa.c 1.5 vs edited =====
--- 1.5/drivers/serial/pxa.c	2004-09-28 20:35:56 +01:00
+++ edited/drivers/serial/pxa.c	2004-11-05 12:54:06 +00:00
@@ -251,7 +251,7 @@
 	if (status & UART_MSR_DCTS)
 		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port.info);
 }
 
 /*
===== drivers/serial/sa1100.c 1.26 vs edited =====
--- 1.26/drivers/serial/sa1100.c	2004-04-09 22:55:47 +01:00
+++ edited/drivers/serial/sa1100.c	2004-11-05 12:54:32 +00:00
@@ -120,7 +120,7 @@
 	if (changed & TIOCM_CTS)
 		uart_handle_cts_change(&sport->port, status & TIOCM_CTS);
 
-	wake_up_interruptible(&sport->port.info->delta_msr_wait);
+	uart_status_changed(&sport->port);
 }
 
 /*
===== drivers/serial/serial_core.c 1.94 vs edited =====
--- 1.94/drivers/serial/serial_core.c	2004-11-01 12:29:41 +00:00
+++ edited/drivers/serial/serial_core.c	2004-11-05 12:35:05 +00:00
@@ -515,6 +515,8 @@
 
 	spin_lock_irqsave(&port->lock, flags);
 	uart_circ_clear(&state->info->xmit);
+	if (port->ops->flush_buffer)
+		port->ops->flush_buffer(port);
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_wakeup(tty);
 }
===== drivers/serial/serial_lh7a40x.c 1.1 vs edited =====
--- 1.1/drivers/serial/serial_lh7a40x.c	2004-06-05 11:30:48 +01:00
+++ edited/drivers/serial/serial_lh7a40x.c	2004-11-05 12:54:55 +00:00
@@ -263,7 +263,7 @@
 	if (delta & CTS)
 		uart_handle_cts_change (port, status & CTS);
 
-	wake_up_interruptible (&port->info->delta_msr_wait);
+	uart_status_changed(port);
 }
 
 static irqreturn_t lh7a40xuart_int (int irq, void* dev_id,
===== drivers/serial/sunsab.c 1.35 vs edited =====
--- 1.35/drivers/serial/sunsab.c	2004-08-26 23:38:22 +01:00
+++ edited/drivers/serial/sunsab.c	2004-11-05 12:55:15 +00:00
@@ -305,7 +305,7 @@
 		up->port.icount.dsr++;
 	}
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port.info);
 }
 
 static irqreturn_t sunsab_interrupt(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/serial/sunsu.c 1.46 vs edited =====
--- 1.46/drivers/serial/sunsu.c	2004-10-31 21:33:17 +00:00
+++ edited/drivers/serial/sunsu.c	2004-11-05 12:55:29 +00:00
@@ -452,7 +452,7 @@
 	if (status & UART_MSR_DCTS)
 		uart_handle_cts_change(&up->port, status & UART_MSR_CTS);
 
-	wake_up_interruptible(&up->port.info->delta_msr_wait);
+	uart_status_changed(&up->port.info);
 }
 
 static irqreturn_t sunsu_serial_interrupt(int irq, void *dev_id, struct pt_regs *regs)
===== drivers/serial/sunzilog.c 1.46 vs edited =====
--- 1.46/drivers/serial/sunzilog.c	2004-09-20 21:46:03 +01:00
+++ edited/drivers/serial/sunzilog.c	2004-11-05 12:55:46 +00:00
@@ -464,7 +464,7 @@
 			uart_handle_cts_change(&up->port,
 					       (status & CTS));
 
-		wake_up_interruptible(&up->port.info->delta_msr_wait);
+		uart_status_changed(&up->port.info);
 	}
 
 	up->prev_status = status;
===== drivers/serial/uart00.c 1.17 vs edited =====
--- 1.17/drivers/serial/uart00.c	2004-04-29 13:14:52 +01:00
+++ edited/drivers/serial/uart00.c	2004-11-05 12:56:06 +00:00
@@ -249,7 +249,7 @@
 	if (status & UART_MSR_DCTS_MSK)
 		uart_handle_cts_change(port, status & UART_MSR_CTS_MSK);
 
-	wake_up_interruptible(&port->info->delta_msr_wait);
+	uart_status_changed(port);
 }
 
 static irqreturn_t uart00_int(int irq, void *dev_id, struct pt_regs *regs)
===== include/linux/serial_core.h 1.45 vs edited =====
--- 1.45/include/linux/serial_core.h	2004-10-30 21:24:41 +01:00
+++ edited/include/linux/serial_core.h	2004-11-05 13:00:36 +00:00
@@ -111,6 +111,7 @@
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
--- 1.30/include/linux/tty.h	2004-10-21 18:03:22 +01:00
+++ edited/include/linux/tty.h	2004-11-05 12:38:02 +00:00
@@ -374,6 +374,7 @@
 extern void tty_ldisc_put(int);
 
 extern void tty_wakeup(struct tty_struct *tty);
+extern void tty_status_changed(struct tty_struct *tty);
 extern void tty_ldisc_flush(struct tty_struct *tty);
 
 struct semaphore;
===== include/linux/tty_ldisc.h 1.7 vs edited =====
--- 1.7/include/linux/tty_ldisc.h	2004-10-21 18:03:22 +01:00
+++ edited/include/linux/tty_ldisc.h	2004-11-05 12:08:29 +00:00
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

