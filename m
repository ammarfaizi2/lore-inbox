Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWEGIYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWEGIYx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 04:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWEGIYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 04:24:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60433 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932099AbWEGIYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 04:24:52 -0400
Date: Sun, 7 May 2006 09:24:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Gerd Hoffmann <kraxel@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial: fix UART_BUG_TXEN test
Message-ID: <20060507082444.GA15039@flint.arm.linux.org.uk>
Mail-Followup-To: Gerd Hoffmann <kraxel@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <44339A8F.7030305@suse.de> <20060412092631.GA25799@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060412092631.GA25799@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 10:26:31AM +0100, Russell King wrote:
> On Wed, Apr 05, 2006 at 12:23:11PM +0200, Gerd Hoffmann wrote:
> > There is a bug in the UART_BUG_TXEN test: It gives false positives in
> > case the UART_IER_THRI bit is set.  Fixed by explicitly clearing the
> > UART_IER register first.
> > 
> > It may trigger with an active serial console as serial console writes
> > set the UART_IER_THRI bit.
> 
> Actually, I think Alan's (f91a3715db2bb44fcf08cec642e68f919b70f7f4)
> idea of setting UART_IER_THRI after serial console writes is buggy.
> If the serial port being used as a console is sharing its interrupt
> line with other devices, then there's the very real possibility for
> causing spurious interrupts.
> 
> I think that's what needs to be fixed rather than working around this
> potentially buggy behaviour.
> 
> Maybe we have no option but to take the spinlock in the serial console
> code, and suck it if we oops with that spinlock held.

So here's the patch.  I've been waiting for feedback from Alan before
sending this upstream...  Nevertheless, could you (Gerd) test it please?

Thanks.

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2200,10 +2200,17 @@ static void
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
@@ -2221,8 +2228,10 @@ serial8250_console_write(struct console 
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, ier | UART_IER_THRI);
+	serial_out(up, UART_IER, ier);
+
+	if (locked)
+		spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
 static int serial8250_console_setup(struct console *co, char *options)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
