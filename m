Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbVLWKlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbVLWKlw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 05:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbVLWKlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 05:41:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63246 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030480AbVLWKlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 05:41:52 -0500
Date: Fri, 23 Dec 2005 10:41:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20051223104146.GB22506@flint.arm.linux.org.uk>
Mail-Followup-To: Meelis Roos <mroos@linux.ee>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <1134573803.25663.35.camel@localhost.localdomain> <20051214160700.7348A14BEA@rhn.tartu-labor> <20051214172445.GF7124@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512212221310.651@math.ut.ee> <20051221221516.GK1736@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512221231430.6200@math.ut.ee> <20051222130744.GA31339@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512231117560.25532@math.ut.ee> <20051223093343.GA22506@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512231204290.8311@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0512231204290.8311@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 12:05:35PM +0200, Meelis Roos wrote:
> >Ok, please apply this patch on top of the previous and re-send the
> >kernel messages.  This will let us see what's going on with 'l' and
> >'end'.
> 
> >+		printk("serial8250: port %p(%d) head=%p end=%p\n", up, 
> >up->port.line, i->head, end);
> 
> replaced i->heqad with l because i is shadowed by a local variable here, 
> now it compiles.

Argh, fek fek fek.  The original debug patch contained some extra code
to try to combat a problem I've been seeing here, which is causing more
complaints from your machine.

Right, discard all the patches I sent previously and use this one.

Thanks.

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -69,7 +69,8 @@ static unsigned int share_irqs = SERIAL8
 #define DEBUG_INTR(fmt...)	do { } while (0)
 #endif
 
-#define PASS_LIMIT	256
+//#define PASS_LIMIT	256
+#define PASS_LIMIT	32
 
 /*
  * We default to IRQ0 for the "no irq" hack.   Some
@@ -135,6 +136,18 @@ struct uart_8250_port {
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
@@ -1284,6 +1297,8 @@ serial8250_handle_port(struct uart_8250_
 {
 	unsigned int status = serial_inp(up, UART_LSR);
 
+	up->log[up->log_idx].lsr_b = status;
+
 	DEBUG_INTR("status = %x...", status);
 
 	if (status & UART_LSR_DR)
@@ -1291,6 +1306,8 @@ serial8250_handle_port(struct uart_8250_
 	check_modem_status(up);
 	if (status & UART_LSR_THRE)
 		transmit_chars(up);
+
+	up->log[up->log_idx].lsr_e = status;
 }
 
 /*
@@ -1325,6 +1342,12 @@ static irqreturn_t serial8250_interrupt(
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
@@ -1336,21 +1359,45 @@ static irqreturn_t serial8250_interrupt(
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
-			break;
+			goto debug;
 		}
 	} while (l != end);
 
+ out:
 	spin_unlock(&i->lock);
 
 	DEBUG_INTR("end.\n");
 
 	return IRQ_RETVAL(handled);
+
+ debug:
+	l = i->head;
+	do {
+		struct uart_8250_port *up = list_entry(l, struct uart_8250_port, list);
+		int j;
+
+		printk("serial8250: port %p(%d)\n", up, up->port.line);
+		for (j = 0; j < 64; j++)
+			printk("%d: jif=%08lx type=%02x num=%02x iir=%02x lsr=%02x => iir=%02x lsr=%02x\n", j,
+				up->log[(up->log_idx + j) & 63].jiffies,
+				up->log[(up->log_idx + j) & 63].type,
+				up->log[(up->log_idx + j) & 63].num,
+				up->log[(up->log_idx + j) & 63].iir_b,
+				up->log[(up->log_idx + j) & 63].lsr_b,
+				up->log[(up->log_idx + j) & 63].iir_e,
+				up->log[(up->log_idx + j) & 63].lsr_e);
+		l = l->next;
+	} while (l != i->head);
+	goto out;
 }
 
 /*


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
