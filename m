Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbULAKsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbULAKsr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 05:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbULAKsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 05:48:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55568 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261360AbULAKsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 05:48:40 -0500
Date: Wed, 1 Dec 2004 10:48:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] serial closing_wait and close_delay
Message-ID: <20041201104834.A7842@flint.arm.linux.org.uk>
Mail-Followup-To: Ian Abbott <abbotti@mev.co.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <41ACC49A.20807@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41ACC49A.20807@mev.co.uk>; from abbotti@mev.co.uk on Tue, Nov 30, 2004 at 07:06:02PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 07:06:02PM +0000, Ian Abbott wrote:
> * In several drivers, the values set by TIOCSSERIAL are scaled by 
> HZ/100, but the values got by TIOCGSERIAL are not scaled back.

See the attached patch for 2.6.  I'd rather keep state->clos* delays
in a sanely sized unit rather than whatever the setserial interface
wants.

> My patch stores the values set by TIOCSSERIAL without scaling and scales 
> the values by HZ/100 at the point of use.  (This is not as bad as it 
> sounds, as each value is scaled once per 'close'.)  There seems to be a 
> general consensus amongst the serial drivers that the closing_wait and 
> close_delay values from the user are in units of .01 seconds.

setserial documentation indicates that these are supposed to be in units
of 0.01 seconds, so I suspect this is what everyone has come to expect.

===== drivers/serial/serial_core.c 1.94 vs edited =====
--- 1.94/drivers/serial/serial_core.c	2004-11-01 12:29:41 +00:00
+++ edited/drivers/serial/serial_core.c	2004-12-01 10:41:10 +00:00
@@ -584,8 +584,10 @@
 	tmp.flags	    = port->flags;
 	tmp.xmit_fifo_size  = port->fifosize;
 	tmp.baud_base	    = port->uartclk / 16;
-	tmp.close_delay	    = state->close_delay;
-	tmp.closing_wait    = state->closing_wait;
+	tmp.close_delay	    = state->close_delay / 10;
+	tmp.closing_wait    = state->closing_wait == USF_CLOSING_WAIT_NONE ?
+				ASYNC_CLOSING_WAIT_NONE :
+			        state->closing_wait / 10;
 	tmp.custom_divisor  = port->custom_divisor;
 	tmp.hub6	    = port->hub6;
 	tmp.io_type         = port->iotype;
@@ -603,8 +605,8 @@
 	struct serial_struct new_serial;
 	struct uart_port *port = state->port;
 	unsigned long new_port;
-	unsigned int change_irq, change_port, old_flags;
-	unsigned int old_custom_divisor;
+	unsigned int change_irq, change_port, old_flags, closing_wait;
+	unsigned int old_custom_divisor, close_delay;
 	int retval = 0;
 
 	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
@@ -615,6 +617,9 @@
 		new_port += (unsigned long) new_serial.port_high << HIGH_BITS_OFFSET;
 
 	new_serial.irq = irq_canonicalize(new_serial.irq);
+	close_delay = new_serial.close_delay * 10;
+	closing_wait = new_serial.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
+			USF_CLOSING_WAIT_NONE : new_serial.closing_wait * 10;
 
 	/*
 	 * This semaphore protects state->count.  It is also
@@ -646,8 +651,8 @@
 		retval = -EPERM;
 		if (change_irq || change_port ||
 		    (new_serial.baud_base != port->uartclk / 16) ||
-		    (new_serial.close_delay != state->close_delay) ||
-		    (new_serial.closing_wait != state->closing_wait) ||
+		    (close_delay != state->close_delay) ||
+		    (closing_wait != state->closing_wait) ||
 		    (new_serial.xmit_fifo_size != port->fifosize) ||
 		    (((new_serial.flags ^ old_flags) & ~UPF_USR_MASK) != 0))
 			goto exit;
@@ -751,8 +756,8 @@
 	port->flags            = (port->flags & ~UPF_CHANGE_MASK) |
 				 (new_serial.flags & UPF_CHANGE_MASK);
 	port->custom_divisor   = new_serial.custom_divisor;
-	state->close_delay     = new_serial.close_delay * HZ / 100;
-	state->closing_wait    = new_serial.closing_wait * HZ / 100;
+	state->close_delay     = close_delay;
+	state->closing_wait    = closing_wait;
 	port->fifosize         = new_serial.xmit_fifo_size;
 	if (state->info->tty)
 		state->info->tty->low_latency =
@@ -1191,7 +1196,7 @@
 	tty->closing = 1;
 
 	if (state->closing_wait != USF_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, state->closing_wait);
+		tty_wait_until_sent(tty, msecs_to_jiffies(state->closing_wait));
 
 	/*
 	 * At this point, we stop accepting input.  To do this, we
@@ -1219,9 +1224,8 @@
 	state->info->tty = NULL;
 
 	if (state->info->blocked_open) {
-		if (state->close_delay) {
-			msleep_interruptible(jiffies_to_msecs(state->close_delay));
-		}
+		if (state->close_delay)
+			msleep_interruptible(state->close_delay);
 	} else if (!uart_console(port)) {
 		uart_change_pm(state, 3);
 	}
@@ -2082,8 +2086,8 @@
 	for (i = 0; i < drv->nr; i++) {
 		struct uart_state *state = drv->state + i;
 
-		state->close_delay     = 5 * HZ / 10;
-		state->closing_wait    = 30 * HZ;
+		state->close_delay     = 500;	/* .5 seconds */
+		state->closing_wait    = 30000;	/* 30 seconds */
 
 		init_MUTEX(&state->sem);
 	}
===== include/linux/serial_core.h 1.49 vs edited =====
--- 1.49/include/linux/serial_core.h	2004-11-29 13:41:34 +00:00
+++ edited/include/linux/serial_core.h	2004-12-01 10:13:06 +00:00
@@ -244,11 +244,11 @@
  * within.
  */
 struct uart_state {
-	unsigned int		close_delay;
-	unsigned int		closing_wait;
+	unsigned int		close_delay;		/* msec */
+	unsigned int		closing_wait;		/* msec */
 
 #define USF_CLOSING_WAIT_INF	(0)
-#define USF_CLOSING_WAIT_NONE	(65535)
+#define USF_CLOSING_WAIT_NONE	(~0U)
 
 	int			count;
 	int			pm_state;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
