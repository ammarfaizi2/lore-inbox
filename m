Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWEBPHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWEBPHA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 11:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWEBPHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 11:07:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16146 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964866AbWEBPG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 11:06:59 -0400
Date: Tue, 2 May 2006 16:06:53 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH (RFC): Rework the 8250 console fix
Message-ID: <20060502150653.GA1736@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <1146578983.3519.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146578983.3519.49.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 03:09:43PM +0100, Alan Cox wrote:
> Russell got various bits of mail showing the 8250 console fix broke some
> setups with the assumptions it made. Based on this suggestion that we
> actually need to just do the locking I've prepared an alternative
> patch. 

I had merged your suggestion this morning, though I've just redone it
to fix a bug.

> There are two questions that I think make this an RFC not a final patch
> 
> 1.	Should this be pushed up into serial/serial_core.c for all chips.

No - uart_console_write doesn't know enough about the hardware to be
able to take the spinlock itself.

> 2.	Is the use of local_irq_save/spin_trylock spin_unlock_irqrestore
> going to break any platforms that do weird stuff or do we need a
> spin_trylock_irqsave ?

We do have a spin_trylock_irqsave(), so we don't need to worry about this.

b41d859ea4471c8784c500b97cdf82c7529c19ee
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2235,10 +2235,17 @@ static void
 serial8250_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_8250_port *up = &serial8250_ports[co->index];
+	unsigned long flags;
 	unsigned int ier;
+	int locked = 1;
 
 	touch_nmi_watchdog();
 
+	if (oops_in_progress) {
+		locked = spin_trylock_irqsave(&up->port.lock, flags);
+	} else
+		spin_lock_irqsave(&up->port.lock, flags);
+
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
@@ -2257,6 +2265,9 @@ serial8250_console_write(struct console 
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
 	serial_out(up, UART_IER, ier);
+
+	if (locked)
+		spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static int serial8250_console_setup(struct console *co, char *options)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
