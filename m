Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbVLWJdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbVLWJdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 04:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVLWJdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 04:33:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54544 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030472AbVLWJdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 04:33:50 -0500
Date: Fri, 23 Dec 2005 09:33:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Serial: bug in 8250.c when handling PCI or other level triggers
Message-ID: <20051223093343.GA22506@flint.arm.linux.org.uk>
Mail-Followup-To: Meelis Roos <mroos@linux.ee>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <1134573803.25663.35.camel@localhost.localdomain> <20051214160700.7348A14BEA@rhn.tartu-labor> <20051214172445.GF7124@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512212221310.651@math.ut.ee> <20051221221516.GK1736@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512221231430.6200@math.ut.ee> <20051222130744.GA31339@flint.arm.linux.org.uk> <Pine.SOC.4.61.0512231117560.25532@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0512231117560.25532@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 11:20:59AM +0200, Meelis Roos wrote:
> >I notice you're using gcc 4.0.3.  Have you tried other compiler
> >versions?
> 
> Tried 3.3 (Debian 3.3.6). Discover still gets the errors, opening port 
> with minicom didn't this time (maybe I did start minicom an power on the 
> switch in different order). But when closing minicom, I got the messages 
> again (after the AGP messages).

So not much change.

Ok, please apply this patch on top of the previous and re-send the
kernel messages.  This will let us see what's going on with 'l' and
'end'.

Thanks.

--- a/drivers/serial/8250.c	2005-12-23 09:26:45.273235110 +0000
+++ b/drivers/serial/8250.c	2005-12-23 09:32:37.347434791 +0000
@@ -146,6 +146,9 @@
 		unsigned char	iir_b;
 		unsigned char	lsr_e;
 		unsigned char	iir_e;
+		void		*l;
+		void		*eb;
+		void		*ee;
 	} log[64];
 	unsigned char		log_idx;
 };
@@ -1348,8 +1351,11 @@
 		up->log[up->log_idx].type = 0;
 		up->log[up->log_idx].num = pass_counter;
 		up->log[up->log_idx].iir_b = iir;
+		up->log[up->log_idx].l = l;
+		up->log[up->log_idx].eb = end;
 
 		if (!(iir & UART_IIR_NO_INT)) {
+			up->log[up->log_idx].type = 1;
 			spin_lock(&up->port.lock);
 			serial8250_handle_port(up, regs);
 			spin_unlock(&up->port.lock);
@@ -1361,6 +1367,7 @@
 			end = l;
 
 		up->log[up->log_idx].iir_e = serial_in(up, UART_IIR);
+		up->log[up->log_idx].ee = end;
 		up->log_idx = (up->log_idx + 1) & 63;
 
 		l = l->next;
@@ -1402,16 +1409,19 @@
 		struct uart_8250_port *up = list_entry(l, struct uart_8250_port, list);
 		int i;
 
-		printk("serial8250: port %p(%d)\n", up, up->port.line);
+		printk("serial8250: port %p(%d) head=%p end=%p\n", up, up->port.line, i->head, end);
 		for (i = 0; i < 64; i++)
-			printk("%d: jif=%08lx type=%02x num=%02x iir=%02x lsr=%02x => iir=%02x lsr=%02x\n", i,
+			printk("%d: jif=%08lx type=%02x num=%02x iir=%02x lsr=%02x => iir=%02x lsr=%02x l=%p eb=%p ee=%p\n", i,
 				up->log[(up->log_idx + i) & 63].jiffies,
 				up->log[(up->log_idx + i) & 63].type,
 				up->log[(up->log_idx + i) & 63].num,
 				up->log[(up->log_idx + i) & 63].iir_b,
 				up->log[(up->log_idx + i) & 63].lsr_b,
 				up->log[(up->log_idx + i) & 63].iir_e,
-				up->log[(up->log_idx + i) & 63].lsr_e);
+				up->log[(up->log_idx + i) & 63].lsr_e,
+				up->log[(up->log_idx + i) & 63].l,
+				up->log[(up->log_idx + i) & 63].eb,
+				up->log[(up->log_idx + i) & 63].ee);
 		l = l->next;
 	} while (l != i->head);
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
