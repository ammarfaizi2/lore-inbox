Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVJJSj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVJJSj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 14:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVJJSj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 14:39:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:56784 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751170AbVJJSj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 14:39:59 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200510101839.j9AIdpo0008398@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : ioc4 serial support - mostly cleanup
To: linux-kernel@vger.kernel.org
Date: Mon, 10 Oct 2005 13:39:51 -0500 (CDT)
Cc: akpm@osdl.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Various small mods for the Altix ioc4 serial driver - mostly cleanup:
- remove UIF_INITIALIZED usage
- use the 'lock' from uart_port
- better multiple card support


Signed-off-by: Patrick Gefre <pfg@sgi.com>

---

diffstat

 ioc4_serial.c |   80 +++++++++++++++++++++++++++++++---------------------------
 1 files changed, 44 insertions(+), 36 deletions(-)


Index: linux/drivers/serial/ioc4_serial.c
===================================================================
--- linux.orig/drivers/serial/ioc4_serial.c	2005-09-13 04:01:54.000000000 -0500
+++ linux/drivers/serial/ioc4_serial.c	2005-10-04 11:27:42.894430606 -0500
@@ -308,6 +308,8 @@
 typedef void ioc4_intr_func_f(void *, uint32_t);
 typedef ioc4_intr_func_f *ioc4_intr_func_t;
 
+static unsigned int Num_of_ioc4_cards;
+
 /* defining this will get you LOTS of great debug info */
 //#define DEBUG_INTERRUPTS
 #define DPRINT_CONFIG(_x...)	;
@@ -317,7 +319,8 @@
 #define WAKEUP_CHARS	256
 
 /* number of characters we want to transmit to the lower level at a time */
-#define IOC4_MAX_CHARS	128
+#define IOC4_MAX_CHARS	256
+#define IOC4_FIFO_CHARS	255
 
 /* Device name we're using */
 #define DEVICE_NAME	"ttyIOC"
@@ -1050,6 +1053,7 @@
 			return -ENOMEM;
 		}
 		memset(port, 0, sizeof(struct ioc4_port));
+		spin_lock_init(&port->ip_lock);
 
 		/* we need to remember the previous ones, to point back to
 		 * them farther down - setting up the ring buffers.
@@ -1703,12 +1707,14 @@
 		baud = 9600;
 
 	if (!the_port->fifosize)
-		the_port->fifosize = IOC4_MAX_CHARS;
+		the_port->fifosize = IOC4_FIFO_CHARS;
 	the_port->timeout = ((the_port->fifosize * HZ * bits) / (baud / 10));
 	the_port->timeout += HZ / 50;	/* Add .02 seconds of slop */
 
 	the_port->ignore_status_mask = N_ALL_INPUT;
 
+	info->tty->low_latency = 1;
+
 	if (I_IGNPAR(info->tty))
 		the_port->ignore_status_mask &= ~(N_PARITY_ERROR
 						| N_FRAMING_ERROR);
@@ -1754,7 +1760,6 @@
  */
 static inline int ic4_startup_local(struct uart_port *the_port)
 {
-	int retval = 0;
 	struct ioc4_port *port;
 	struct uart_info *info;
 
@@ -1766,9 +1771,6 @@
 		return -1;
 
 	info = the_port->info;
-	if (info->flags & UIF_INITIALIZED) {
-		return retval;
-	}
 
 	if (info->tty) {
 		set_bit(TTY_IO_ERROR, &info->tty->flags);
@@ -1787,7 +1789,6 @@
 	/* set the speed of the serial port */
 	ioc4_change_speed(the_port, info->tty->termios, (struct termios *)0);
 
-	info->flags |= UIF_INITIALIZED;
 	return 0;
 }
 
@@ -1797,9 +1798,13 @@
  */
 static void ioc4_cb_output_lowat(struct ioc4_port *port)
 {
+	unsigned long pflags;
+
 	/* ip_lock is set on the call here */
 	if (port->ip_port) {
+		spin_lock_irqsave(&port->ip_port->lock, pflags);
 		transmit_chars(port->ip_port);
+		spin_unlock_irqrestore(&port->ip_port->lock, pflags);
 	}
 }
 
@@ -2076,8 +2081,7 @@
 	 * available data as long as it returns some.
 	 */
 	/* Re-arm the timer */
-	writel(port->ip_rx_cons | IOC4_SRCIR_ARM,
-			&port->ip_serial_regs->srcir);
+	writel(port->ip_rx_cons | IOC4_SRCIR_ARM, &port->ip_serial_regs->srcir);
 
 	prod_ptr = readl(&port->ip_serial_regs->srpir) & PROD_CONS_MASK;
 	cons_ptr = port->ip_rx_cons;
@@ -2311,6 +2315,7 @@
 	}
 	return total;
 }
+
 /**
  * receive_chars - upper level read. Called with ip_lock.
  * @the_port: port to read from
@@ -2319,9 +2324,11 @@
 {
 	struct tty_struct *tty;
 	unsigned char ch[IOC4_MAX_CHARS];
-	int read_count, request_count;
+	int read_count, request_count = IOC4_MAX_CHARS;
 	struct uart_icount *icount;
 	struct uart_info *info = the_port->info;
+	int flip = 0;
+	unsigned long pflags;
 
 	/* Make sure all the pointers are "good" ones */
 	if (!info)
@@ -2329,16 +2336,17 @@
 	if (!info->tty)
 		return;
 
+	spin_lock_irqsave(&the_port->lock, pflags);
 	tty = info->tty;
 
-	request_count = TTY_FLIPBUF_SIZE - tty->flip.count - 1;
+	if (request_count > TTY_FLIPBUF_SIZE - tty->flip.count)
+		request_count = TTY_FLIPBUF_SIZE - tty->flip.count;
 
 	if (request_count > 0) {
-		if (request_count > IOC4_MAX_CHARS - 2)
-			request_count = IOC4_MAX_CHARS - 2;
 		icount = &the_port->icount;
 		read_count = do_read(the_port, ch, request_count);
 		if (read_count > 0) {
+			flip = 1;
 			memcpy(tty->flip.char_buf_ptr, ch, read_count);
 			memset(tty->flip.flag_buf_ptr, TTY_NORMAL, read_count);
 			tty->flip.char_buf_ptr += read_count;
@@ -2347,7 +2355,11 @@
 			icount->rx += read_count;
 		}
 	}
-	tty_flip_buffer_push(tty);
+
+	spin_unlock_irqrestore(&the_port->lock, pflags);
+
+	if (flip)
+		tty_flip_buffer_push(tty);
 }
 
 /**
@@ -2405,18 +2417,14 @@
 
 	info = the_port->info;
 
-	if (!(info->flags & UIF_INITIALIZED))
-		return;
-
 	wake_up_interruptible(&info->delta_msr_wait);
 
 	if (info->tty)
 		set_bit(TTY_IO_ERROR, &info->tty->flags);
 
-	spin_lock_irqsave(&port->ip_lock, port_flags);
+	spin_lock_irqsave(&the_port->lock, port_flags);
 	set_notification(port, N_ALL, 0);
-	info->flags &= ~UIF_INITIALIZED;
-	spin_unlock_irqrestore(&port->ip_lock, port_flags);
+	spin_unlock_irqrestore(&the_port->lock, port_flags);
 }
 
 /**
@@ -2475,12 +2483,10 @@
 static void ic4_start_tx(struct uart_port *the_port)
 {
 	struct ioc4_port *port = get_ioc4_port(the_port);
-	unsigned long flags;
 
 	if (port) {
-		spin_lock_irqsave(&port->ip_lock, flags);
-		transmit_chars(the_port);
-		spin_unlock_irqrestore(&port->ip_lock, flags);
+		set_notification(port, N_OUTPUT_LOWAT, 1);
+		enable_intrs(port, port->ip_hooks->intr_tx_mt);
 	}
 }
 
@@ -2522,9 +2528,9 @@
 	}
 
 	/* Start up the serial port */
-	spin_lock_irqsave(&port->ip_lock, port_flags);
+	spin_lock_irqsave(&the_port->lock, port_flags);
 	retval = ic4_startup_local(the_port);
-	spin_unlock_irqrestore(&port->ip_lock, port_flags);
+	spin_unlock_irqrestore(&the_port->lock, port_flags);
 	return retval;
 }
 
@@ -2539,12 +2545,11 @@
 ic4_set_termios(struct uart_port *the_port,
 		struct termios *termios, struct termios *old_termios)
 {
-	struct ioc4_port *port = get_ioc4_port(the_port);
 	unsigned long port_flags;
 
-	spin_lock_irqsave(&port->ip_lock, port_flags);
+	spin_lock_irqsave(&the_port->lock, port_flags);
 	ioc4_change_speed(the_port, termios, old_termios);
-	spin_unlock_irqrestore(&port->ip_lock, port_flags);
+	spin_unlock_irqrestore(&the_port->lock, port_flags);
 }
 
 /**
@@ -2619,24 +2624,25 @@
 				__FUNCTION__, (void *)the_port,
 				(void *)port));
 
-		spin_lock_init(&the_port->lock);
 		/* membase, iobase and mapbase just need to be non-0 */
 		the_port->membase = (unsigned char __iomem *)1;
-		the_port->line = the_port->iobase = ii;
+		the_port->iobase = (pdev->bus->number << 16) |  ii;
+		the_port->line = (Num_of_ioc4_cards << 2) | ii;
 		the_port->mapbase = 1;
 		the_port->type = PORT_16550A;
-		the_port->fifosize = IOC4_MAX_CHARS;
+		the_port->fifosize = IOC4_FIFO_CHARS;
 		the_port->ops = &ioc4_ops;
 		the_port->irq = control->ic_irq;
 		the_port->dev = &pdev->dev;
+		spin_lock_init(&the_port->lock);
 		if (uart_add_one_port(&ioc4_uart, the_port) < 0) {
 			printk(KERN_WARNING
-				       "%s: unable to add port %d\n",
-				       __FUNCTION__, the_port->line);
+		           "%s: unable to add port %d bus %d\n",
+			       __FUNCTION__, the_port->line, pdev->bus->number);
 		} else {
 			DPRINT_CONFIG(
-				    ("IOC4 serial driver port %d irq = %d\n",
-				       the_port->line, the_port->irq));
+			    ("IOC4 serial port %d irq = %d, bus %d\n",
+			       the_port->line, the_port->irq, pdev->bus->number));
 		}
 		/* all ports are rs232 for now */
 		ioc4_set_proto(port, PROTO_RS232);
@@ -2746,6 +2752,8 @@
 	if ((ret = ioc4_serial_core_attach(idd->idd_pdev)))
 		goto out4;
 
+	Num_of_ioc4_cards++;
+
 	return ret;
 
 	/* error exits that give back resources */
