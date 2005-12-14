Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVLNRYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVLNRYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVLNRYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:24:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28425 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932124AbVLNRYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:24:51 -0500
Date: Wed, 14 Dec 2005 17:24:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20051214172445.GF7124@flint.arm.linux.org.uk>
Mail-Followup-To: Meelis Roos <mroos@linux.ee>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <1134573803.25663.35.camel@localhost.localdomain> <20051214160700.7348A14BEA@rhn.tartu-labor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214160700.7348A14BEA@rhn.tartu-labor>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 06:07:00PM +0200, Meelis Roos wrote:
> AC> The receive_chars function is designed to handle the case where the port
> AC> is jammed full on by aborting after 256 characters in one IRQ.
> AC> Unfortunately the author of this code forgot that some systems are level
> AC> triggered. On these systems the IRQ simply gets invoked again and the
> AC> count loop just makes the problem take longer to clear.
> 
> Could this be connected wiht the massive amount of these messages when
> I use minicom on a PC to see another computers serial console?
> 
> serial8250: too much work for irq4
> 
> I've seen this on different PC-s, PIIX3+K6 and ICH2+Celeron are the
> last ones that I certainly remember behaving like this.

Hmm, possibly, but could you apply this patch and provide the resulting
messages please?  It'll probably cause some character loss when it
decides to dump some debugging.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/drivers/serial/8250.c linux/drivers/serial/8250.c
--- orig/drivers/serial/8250.c	Mon Apr  4 22:54:05 2005
+++ linux/drivers/serial/8250.c	Mon Apr 11 15:39:33 2005
@@ -69,7 +69,8 @@ unsigned int share_irqs = SERIAL8250_SHA
 #define DEBUG_INTR(fmt...)	do { } while (0)
 #endif
 
-#define PASS_LIMIT	256
+//#define PASS_LIMIT	256
+#define PASS_LIMIT	32
 
 /*
  * We default to IRQ0 for the "no irq" hack.   Some
@@ -135,6 +137,18 @@ struct uart_8250_port {
 	 */
 	void			(*pm)(struct uart_port *port,
 				      unsigned int state, unsigned int old);
+
+	struct log {
+		unsigned long	jiffies;
+		unsigned char	type;
+		unsigned char	num;
+		unsigned char	unused[2];
+		unsigned char	lsr_b;
+		unsigned char	iir_b;
+		unsigned char	lsr_e;
+		unsigned char	iir_e;
+	} log[64];
+	unsigned char		log_idx;
 };
 
 struct irq_info {
@@ -1284,6 +1304,8 @@ serial8250_handle_port(struct uart_8250_
 {
 	unsigned int status = serial_inp(up, UART_LSR);
 
+	up->log[up->log_idx].lsr_b = status;
+
 	DEBUG_INTR("status = %x...", status);
 
 	if (status & UART_LSR_DR)
@@ -1291,6 +1313,8 @@ serial8250_handle_port(struct uart_8250_
 	check_modem_status(up);
 	if (status & UART_LSR_THRE)
 		transmit_chars(up);
+
+	up->log[up->log_idx].lsr_e = status;
 }
 
 /*
@@ -1318,6 +1342,7 @@ static irqreturn_t serial8250_interrupt(
 	spin_lock(&i->lock);
 
 	l = i->head;
+ again:
 	do {
 		struct uart_8250_port *up;
 		unsigned int iir;
@@ -1325,6 +1350,12 @@ static irqreturn_t serial8250_interrupt(
 		up = list_entry(l, struct uart_8250_port, list);
 
 		iir = serial_in(up, UART_IIR);
+
+		up->log[up->log_idx].jiffies = jiffies;
+		up->log[up->log_idx].type = 0;
+		up->log[up->log_idx].num = pass_counter;
+		up->log[up->log_idx].iir_b = iir;
+
 		if (!(iir & UART_IIR_NO_INT)) {
 			spin_lock(&up->port.lock);
 			serial8250_handle_port(up, regs);
@@ -1336,16 +1367,62 @@ static irqreturn_t serial8250_interrupt(
 		} else if (end == NULL)
 			end = l;
 
+		up->log[up->log_idx].iir_e = serial_in(up, UART_IIR);
+		up->log_idx = (up->log_idx + 1) & 63;
+
 		l = l->next;
 
 		if (l == i->head && pass_counter++ > PASS_LIMIT) {
 			/* If we hit this, we're dead. */
 			printk(KERN_ERR "serial8250: too much work for "
 				"irq%d\n", irq);
+			goto debug;
 			break;
 		}
 	} while (l != end);
 
+	if (handled)
+		goto out;
+
+	/*
+	 * We didn't recognise the interrupt.  This could be because the
+	 * port raised a receiver interrupt, but left the IIR indicating
+	 * no interrupt pending.  Scan all ports on this interrupt and
+	 * rely upon the LSR only.  Luckily this seems to be rare, but
+	 * does happen with 16550As. --rmk
+	 */
+	l = i->head;
+	do {
+		struct uart_8250_port *up;
+
+		up = list_entry(l, struct uart_8250_port, list);
+		spin_lock(&up->port.lock);
+		serial8250_handle_port(up, regs);
+		spin_unlock(&up->port.lock);
+		l = l->next;
+	} while (l != i->head);
+	goto again;
+
+ debug:
+	l = i->head;
+	do {
+		struct uart_8250_port *up = list_entry(l, struct uart_8250_port, list);
+		int i;
+
+		printk("serial8250: port %p(%d)\n", up, up->port.line);
+		for (i = 0; i < 64; i++)
+			printk("%d: jif=%08lx type=%02x num=%02x iir=%02x lsr=%02x => iir=%02x lsr=%02x\n", i,
+				up->log[(up->log_idx + i) & 63].jiffies,
+				up->log[(up->log_idx + i) & 63].type,
+				up->log[(up->log_idx + i) & 63].num,
+				up->log[(up->log_idx + i) & 63].iir_b,
+				up->log[(up->log_idx + i) & 63].lsr_b,
+				up->log[(up->log_idx + i) & 63].iir_e,
+				up->log[(up->log_idx + i) & 63].lsr_e);
+		l = l->next;
+	} while (l != i->head);
+
+ out:
 	spin_unlock(&i->lock);
 
 	DEBUG_INTR("end.\n");



-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
