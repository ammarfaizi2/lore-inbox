Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbUK3TKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbUK3TKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbUK3TKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:10:10 -0500
Received: from mail.mev.co.uk ([62.49.15.74]:36565 "EHLO mail.mev.co.uk")
	by vger.kernel.org with ESMTP id S262244AbUK3TGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:06:30 -0500
Message-ID: <41ACC49A.20807@mev.co.uk>
Date: Tue, 30 Nov 2004 19:06:02 +0000
From: Ian Abbott <abbotti@mev.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] serial closing_wait and close_delay
Content-Type: multipart/mixed;
 boundary="------------000903070801040902000607"
X-OriginalArrivalTime: 30 Nov 2004 19:06:00.0364 (UTC) FILETIME=[A14966C0:01C4D70F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000903070801040902000607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear Marcelo,

This patch should fix various problems with the closing_wait and 
close_delay serial parameters, but I can only test the standard serial 
driver.

There are various scaling problems when HZ != 100:

* In several drivers, the values set by TIOCSSERIAL are scaled by 
HZ/100, but the values got by TIOCGSERIAL are not scaled back.

* Invariably, the scaled closing_wait value is compared with an unscaled 
constant ASYNC_CLOSING_WAIT_NONE or the same value by another name 
(depending on the specific driver).

My patch stores the values set by TIOCSSERIAL without scaling and scales 
the values by HZ/100 at the point of use.  (This is not as bad as it 
sounds, as each value is scaled once per 'close'.)  There seems to be a 
general consensus amongst the serial drivers that the closing_wait and 
close_delay values from the user are in units of .01 seconds.

There is another problem, not related to HZ scaling:

* In several drivers, the closing_wait and close_delay values are 
written to a struct serial_state by TIOCSSERIAL, but the values used in 
the close routine are read from a struct async_struct, with no code to 
transfer of values between the two structures.  My patch ignores the 
members in struct async_struct and uses the values from struct serial_state.

-- Ian.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

--------------000903070801040902000607
Content-Type: text/x-patch;
 name="serial-closing-wait.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-closing-wait.patch"

diff -urN linux-2.4.29-pre1/arch/cris/drivers/serial.c linux-2.4.29-pre1-ia/arch/cris/drivers/serial.c
--- linux-2.4.29-pre1/arch/cris/drivers/serial.c	2004-02-18 13:36:30.000000000 +0000
+++ linux-2.4.29-pre1-ia/arch/cris/drivers/serial.c	2004-11-29 13:01:26.707580416 +0000
@@ -4552,7 +4552,7 @@
 	 */
 	tty->closing = 1;
 	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the serial receiver and the DMA receive interrupt.
@@ -4586,7 +4586,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -5155,8 +5155,8 @@
 		info->baud_base = DEF_BAUD_BASE;
 		info->custom_divisor = 0;		
 		info->flags = 0;
-		info->close_delay = 5*HZ/10;
-		info->closing_wait = 30*HZ;
+		info->close_delay = 50;		/* .5 seconds */
+		info->closing_wait = 3000;	/* 30 seconds */
 		info->x_char = 0;
 		info->event = 0;
 		info->count = 0;
diff -urN linux-2.4.29-pre1/arch/ppc/8xx_io/uart.c linux-2.4.29-pre1-ia/arch/ppc/8xx_io/uart.c
--- linux-2.4.29-pre1/arch/ppc/8xx_io/uart.c	2003-11-28 18:26:19.000000000 +0000
+++ linux-2.4.29-pre1-ia/arch/ppc/8xx_io/uart.c	2004-11-29 13:01:26.712579656 +0000
@@ -1760,8 +1760,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1797,9 +1797,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2743,8 +2743,8 @@
 		state->line = i;
 		state->type = PORT_UNKNOWN;
 		state->custom_divisor = 0;
-		state->close_delay = 5*HZ/10;
-		state->closing_wait = 30*HZ;
+		state->close_delay = 50;	/* .5 seconds */
+		state->closing_wait = 3000;	/* 30 seconds */
 		state->callout_termios = callout_driver.init_termios;
 		state->normal_termios = serial_driver.init_termios;
 		state->icount.cts = state->icount.dsr =
diff -urN linux-2.4.29-pre1/arch/ppc/cpm2_io/uart.c linux-2.4.29-pre1-ia/arch/ppc/cpm2_io/uart.c
--- linux-2.4.29-pre1/arch/ppc/cpm2_io/uart.c	2004-04-14 14:05:27.000000000 +0100
+++ linux-2.4.29-pre1-ia/arch/ppc/cpm2_io/uart.c	2004-11-29 13:01:26.716579048 +0000
@@ -1754,8 +1754,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1790,9 +1790,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2714,8 +2714,8 @@
 		state->line = i;
 		state->type = PORT_UNKNOWN;
 		state->custom_divisor = 0;
-		state->close_delay = 5*HZ/10;
-		state->closing_wait = 30*HZ;
+		state->close_delay = 50;	/* .5 seconds */
+		state->closing_wait = 3000;	/* 30 seconds */
 		state->callout_termios = callout_driver.init_termios;
 		state->normal_termios = serial_driver.init_termios;
 		state->icount.cts = state->icount.dsr =
diff -urN linux-2.4.29-pre1/drivers/char/amiserial.c linux-2.4.29-pre1-ia/drivers/char/amiserial.c
--- linux-2.4.29-pre1/drivers/char/amiserial.c	2002-11-28 23:53:12.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/amiserial.c	2004-11-29 13:01:26.719578592 +0000
@@ -1215,8 +1215,8 @@
 	info->flags = ((state->flags & ~ASYNC_INTERNAL_FLAGS) |
 		       (info->flags & ASYNC_INTERNAL_FLAGS));
 	state->custom_divisor = new_serial.custom_divisor;
-	state->close_delay = new_serial.close_delay * HZ/100;
-	state->closing_wait = new_serial.closing_wait * HZ/100;
+	state->close_delay = new_serial.close_delay;
+	state->closing_wait = new_serial.closing_wait;
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 
 check_and_exit:
@@ -1581,8 +1581,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1614,9 +1614,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2185,8 +2185,8 @@
 	state->port = (int)&custom.serdatr; /* Just to give it a value */
 	state->line = 0;
 	state->custom_divisor = 0;
-	state->close_delay = 5*HZ/10;
-	state->closing_wait = 30*HZ;
+	state->close_delay = 50;	/* .5 seconds */
+	state->closing_wait = 3000;	/* 30 seconds */
 	state->callout_termios = callout_driver.init_termios;
 	state->normal_termios = serial_driver.init_termios;
 	state->icount.cts = state->icount.dsr = 
diff -urN linux-2.4.29-pre1/drivers/char/au1x00-serial.c linux-2.4.29-pre1-ia/drivers/char/au1x00-serial.c
--- linux-2.4.29-pre1/drivers/char/au1x00-serial.c	2003-08-25 12:44:41.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/au1x00-serial.c	2004-11-29 13:01:26.767571296 +0000
@@ -1494,8 +1494,8 @@
 	info->flags = ((state->flags & ~ASYNC_INTERNAL_FLAGS) |
 		       (info->flags & ASYNC_INTERNAL_FLAGS));
 	state->custom_divisor = new_serial.custom_divisor;
-	state->close_delay = new_serial.close_delay * HZ/100;
-	state->closing_wait = new_serial.closing_wait * HZ/100;
+	state->close_delay = new_serial.close_delay;
+	state->closing_wait = new_serial.closing_wait;
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 	info->xmit_fifo_size = state->xmit_fifo_size =
 		new_serial.xmit_fifo_size;
@@ -1948,8 +1948,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1976,9 +1976,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2655,8 +2655,8 @@
 		state->line = i;
 		state->type = PORT_UNKNOWN;
 		state->custom_divisor = 0;
-		state->close_delay = 5*HZ/10;
-		state->closing_wait = 30*HZ;
+		state->close_delay = 50;	/* .5 seconds */
+		state->closing_wait = 3000;	/* 30 seconds */
 		state->callout_termios = callout_driver.init_termios;
 		state->normal_termios = serial_driver.init_termios;
 		state->icount.cts = state->icount.dsr =
diff -urN linux-2.4.29-pre1/drivers/char/cyclades.c linux-2.4.29-pre1-ia/drivers/char/cyclades.c
--- linux-2.4.29-pre1/drivers/char/cyclades.c	2003-06-13 15:51:32.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/cyclades.c	2004-11-29 13:01:26.775570080 +0000
@@ -2866,7 +2866,7 @@
     tty->closing = 1;
     CY_UNLOCK(info, flags);
     if (info->closing_wait != CY_CLOSING_WAIT_NONE) {
-	tty_wait_until_sent(tty, info->closing_wait);
+	tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
     }
     CY_LOCK(info, flags);
 
@@ -2929,7 +2929,7 @@
 	CY_UNLOCK(info, flags);
         if (info->close_delay) {
             current->state = TASK_INTERRUPTIBLE;
-            schedule_timeout(info->close_delay);
+            schedule_timeout(info->close_delay * HZ / 100);
         }
         wake_up_interruptible(&info->open_wait);
 	CY_LOCK(info, flags);
@@ -3659,8 +3659,8 @@
     info->custom_divisor = new_serial.custom_divisor;
     info->flags = ((info->flags & ~ASYNC_FLAGS) |
                     (new_serial.flags & ASYNC_FLAGS));
-    info->close_delay = new_serial.close_delay * HZ/100;
-    info->closing_wait = new_serial.closing_wait * HZ/100;
+    info->close_delay = new_serial.close_delay;
+    info->closing_wait = new_serial.closing_wait;
 
 check_and_exit:
     if (info->flags & ASYNC_INITIALIZED){
@@ -4314,11 +4314,11 @@
 	    break;
 #endif /* CONFIG_CYZ_INTR */
 	case CYSETWAIT:
-    	    info->closing_wait = (unsigned short)arg * HZ/100;
+    	    info->closing_wait = (unsigned short)arg;
 	    ret_val = 0;
 	    break;
 	case CYGETWAIT:
-	    ret_val = info->closing_wait / (HZ/100);
+	    ret_val = info->closing_wait;
 	    break;
         case TIOCMGET:
             ret_val = get_modem_info(info, (unsigned int *) arg);
@@ -5637,7 +5637,7 @@
                     info->rbpr = 0;
                     info->rco = 0;
 		    info->custom_divisor = 0;
-                    info->close_delay = 5*HZ/10;
+                    info->close_delay = 50;	/* .5 seconds */
 		    info->closing_wait = CLOSING_WAIT_DELAY;
 		    info->icount.cts = info->icount.dsr = 
 			info->icount.rng = info->icount.dcd = 0;
@@ -5696,7 +5696,7 @@
                     info->cor4 = 0;
                     info->cor5 = 0;
 		    info->custom_divisor = 0;
-                    info->close_delay = 5*HZ/10;
+                    info->close_delay = 50;	/* .5 seconds */
 		    info->closing_wait = CLOSING_WAIT_DELAY;
 		    info->icount.cts = info->icount.dsr = 
 			info->icount.rng = info->icount.dcd = 0;
diff -urN linux-2.4.29-pre1/drivers/char/dz.c linux-2.4.29-pre1-ia/drivers/char/dz.c
--- linux-2.4.29-pre1/drivers/char/dz.c	2004-02-18 13:36:31.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/dz.c	2004-11-29 13:01:26.778569624 +0000
@@ -1095,7 +1095,7 @@
 	tty->closing = 1;
 
 	if (info->closing_wait != DZ_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 
 	/*
 	 * At this point we stop accepting input.  To do this, we
@@ -1123,7 +1123,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/esp.c linux-2.4.29-pre1-ia/drivers/char/esp.c
--- linux-2.4.29-pre1/drivers/char/esp.c	2002-08-03 01:39:43.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/esp.c	2004-11-29 13:01:26.822562936 +0000
@@ -1570,8 +1570,8 @@
 		info->flags = ((info->flags & ~ASYNC_FLAGS) |
 			       (new_serial.flags & ASYNC_FLAGS));
 		info->custom_divisor = new_serial.custom_divisor;
-		info->close_delay = new_serial.close_delay * HZ/100;
-		info->closing_wait = new_serial.closing_wait * HZ/100;
+		info->close_delay = new_serial.close_delay;
+		info->closing_wait = new_serial.closing_wait;
 
 		if (change_irq) {
 			/*
@@ -2087,7 +2087,7 @@
 	 */
 	tty->closing = 1;
 	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -2124,7 +2124,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2636,8 +2636,8 @@
 		if (info->custom_divisor)
 			info->flags |= ASYNC_SPD_CUST;
 		info->magic = ESP_MAGIC;
-		info->close_delay = 5*HZ/10;
-		info->closing_wait = 30*HZ;
+		info->close_delay = 50;		/* .5 seconds */
+		info->closing_wait = 3000;	/* 30 seconds */
 		info->tqueue.routine = do_softint;
 		info->tqueue.data = info;
 		info->tqueue_hangup.routine = do_serial_hangup;
diff -urN linux-2.4.29-pre1/drivers/char/generic_serial.c linux-2.4.29-pre1-ia/drivers/char/generic_serial.c
--- linux-2.4.29-pre1/drivers/char/generic_serial.c	2002-11-28 23:53:12.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/generic_serial.c	2004-11-29 13:01:26.825562480 +0000
@@ -784,7 +784,7 @@
 	 */
 	tty->closing = 1;
 	/* if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-	   tty_wait_until_sent(tty, port->closing_wait); */
+	   tty_wait_until_sent(tty, port->closing_wait * HZ / 100); */
 
 	/*
 	 * At this point we stop accepting input.  To do this, we
@@ -797,7 +797,7 @@
 
 	/* close has no way of returning "EINTR", so discard return value */
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		gs_wait_tx_flushed (port, port->closing_wait); 
+		gs_wait_tx_flushed (port, port->closing_wait * HZ / 100); 
 
 	port->flags &= ~GS_ACTIVE;
 
@@ -815,7 +815,7 @@
 	if (port->blocked_open) {
 		if (port->close_delay) {
 			set_current_state (TASK_INTERRUPTIBLE);
-			schedule_timeout(port->close_delay);
+			schedule_timeout(port->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&port->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/ip2main.c linux-2.4.29-pre1-ia/drivers/char/ip2main.c
--- linux-2.4.29-pre1/drivers/char/ip2main.c	2004-11-17 11:54:21.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/ip2main.c	2004-11-29 13:01:26.830561720 +0000
@@ -1831,7 +1831,7 @@
 		 * This uses an timeout, after which the close
 		 * completes.
 		 */
-		ip2_wait_until_sent(tty, pCh->ClosingWaitTime );
+		ip2_wait_until_sent(tty, pCh->ClosingWaitTime * HZ / 100);
 	}
 	/*
 	 * At this point we stop accepting input. Here we flush the channel
@@ -1862,7 +1862,7 @@
 	if (pCh->wopen) {
 		if (pCh->ClosingDelay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(pCh->ClosingDelay);
+			schedule_timeout(pCh->ClosingDelay * HZ / 100);
 		}
 		wake_up_interruptible(&pCh->open_wait);
 	}
@@ -2673,8 +2673,8 @@
 		pCh->flags = (pCh->flags & ~ASYNC_FLAGS) |
 			       (ns.flags & ASYNC_FLAGS);
 		pCh->BaudDivisor = ns.custom_divisor;
-		pCh->ClosingDelay = ns.close_delay * HZ/100;
-		pCh->ClosingWaitTime = ns.closing_wait * HZ/100;
+		pCh->ClosingDelay = ns.close_delay;
+		pCh->ClosingWaitTime = ns.closing_wait;
 	}
 
 	if ( ( (old_flags & ASYNC_SPD_MASK) != (pCh->flags & ASYNC_SPD_MASK) )
diff -urN linux-2.4.29-pre1/drivers/char/isicom.c linux-2.4.29-pre1-ia/drivers/char/isicom.c
--- linux-2.4.29-pre1/drivers/char/isicom.c	2003-06-13 15:51:33.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/isicom.c	2004-11-29 13:01:26.833561264 +0000
@@ -1189,7 +1189,7 @@
 	
 	tty->closing = 1;
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, port->closing_wait);
+		tty_wait_until_sent(tty, port->closing_wait * HZ / 100);
 	/* indicate to the card that no more data can be received 
 	   on this port */
 	if (port->flags & ASYNC_INITIALIZED) {   
@@ -1209,7 +1209,7 @@
 #ifdef ISICOM_DEBUG			
 			printk(KERN_DEBUG "ISICOM: scheduling until time out.\n");
 #endif			
-			schedule_timeout(port->close_delay);
+			schedule_timeout(port->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&port->open_wait);
 	}	
@@ -1905,8 +1905,8 @@
 			port->channel = channel;		
 			port->normal_termios = isicom_normal.init_termios;
 			port->callout_termios = isicom_callout.init_termios;
-		 	port->close_delay = 50 * HZ/100;
-		 	port->closing_wait = 3000 * HZ/100;
+		 	port->close_delay = 50;		/* .5 seconds */
+		 	port->closing_wait = 3000;	/* 30 seconds */
 			port->hangup_tq.routine = do_isicom_hangup;
 		 	port->hangup_tq.data = port;
 		 	port->bh_tqueue.routine = isicom_bottomhalf;
diff -urN linux-2.4.29-pre1/drivers/char/istallion.c linux-2.4.29-pre1-ia/drivers/char/istallion.c
--- linux-2.4.29-pre1/drivers/char/istallion.c	2004-11-29 13:00:15.466410720 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/istallion.c	2004-11-29 13:01:26.885553360 +0000
@@ -623,7 +623,7 @@
  */
 #define	STL_MAXBAUD	460800
 #define	STL_BAUDBASE	115200
-#define	STL_CLOSEDELAY	(5 * HZ / 10)
+#define	STL_CLOSEDELAY	50	/* .5 seconds */
 
 /*****************************************************************************/
 
@@ -1198,7 +1198,7 @@
 		stli_flushchars(tty);
 	tty->closing = 1;
 	if (portp->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, portp->closing_wait);
+		tty_wait_until_sent(tty, portp->closing_wait * HZ / 100);
 
 	portp->flags &= ~ASYNC_INITIALIZED;
 	brdp = stli_brds[portp->brdnr];
@@ -1224,7 +1224,7 @@
 
 	if (portp->openwaitcnt) {
 		if (portp->close_delay)
-			stli_delay(portp->close_delay);
+			stli_delay(portp->close_delay * HZ / 1000);
 		wake_up_interruptible(&portp->open_wait);
 	}
 
@@ -3368,7 +3368,7 @@
 		portp->panelnr = panelnr;
 		portp->baud_base = STL_BAUDBASE;
 		portp->close_delay = STL_CLOSEDELAY;
-		portp->closing_wait = 30 * HZ;
+		portp->closing_wait = 3000;	/* 30 seconds */
 		portp->tqhangup.routine = stli_dohangup;
 		portp->tqhangup.data = portp;
 		init_waitqueue_head(&portp->open_wait);
diff -urN linux-2.4.29-pre1/drivers/char/moxa.c linux-2.4.29-pre1-ia/drivers/char/moxa.c
--- linux-2.4.29-pre1/drivers/char/moxa.c	2001-10-25 21:53:47.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/moxa.c	2004-11-29 13:01:26.889552752 +0000
@@ -390,8 +390,8 @@
 		ch->tqueue.routine = do_moxa_softint;
 		ch->tqueue.data = ch;
 		ch->tty = 0;
-		ch->close_delay = 5 * HZ / 10;
-		ch->closing_wait = 30 * HZ;
+		ch->close_delay = 50;		/* .5 seconds */
+		ch->closing_wait = 3000;	/* 30 seconds */
 		ch->count = 0;
 		ch->blocked_open = 0;
 		ch->callout_termios = moxaCallout.init_termios;
@@ -668,7 +668,8 @@
 		ch->callout_termios = *tty->termios;
 	if (ch->asyncflags & ASYNC_INITIALIZED) {
 		setup_empty_event(tty);
-		tty_wait_until_sent(tty, 30 * HZ);	/* 30 seconds timeout */
+		if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+			tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 		moxaEmptyTimer_on[ch->port] = 0;
 		del_timer(&moxaEmptyTimer[ch->port]);
 	}
@@ -685,7 +686,7 @@
 	if (ch->blocked_open) {
 		if (ch->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(ch->close_delay);
+			schedule_timeout(ch->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&ch->open_wait);
 	}
@@ -2805,8 +2806,8 @@
 		     (info->asyncflags & ~ASYNC_USR_MASK)))
 			return (-EPERM);
 	} else {
-		info->close_delay = new_serial.close_delay * HZ / 100;
-		info->closing_wait = new_serial.closing_wait * HZ / 100;
+		info->close_delay = new_serial.close_delay;
+		info->closing_wait = new_serial.closing_wait;
 	}
 
 	new_serial.flags = (new_serial.flags & ~ASYNC_FLAGS);
diff -urN linux-2.4.29-pre1/drivers/char/mxser.c linux-2.4.29-pre1-ia/drivers/char/mxser.c
--- linux-2.4.29-pre1/drivers/char/mxser.c	2004-11-17 11:54:21.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/mxser.c	2004-11-29 13:01:26.893552144 +0000
@@ -450,8 +450,8 @@
 		else
 			info->xmit_fifo_size = 16;
 		info->custom_divisor = hwconf->baud_base[i] * 16;
-		info->close_delay = 5 * HZ / 10;
-		info->closing_wait = 30 * HZ;
+		info->close_delay = 50;		/* .5 seconds */
+		info->closing_wait = 3000;	/* 30 seconds */
 		info->tqueue.routine = mxser_do_softint;
 		info->tqueue.data = info;
 		info->callout_termios = mxvar_cdriver.init_termios;
@@ -861,7 +861,7 @@
 	 */
 	tty->closing = 1;
 	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -898,7 +898,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2215,8 +2215,8 @@
 		 */
 		info->flags = ((info->flags & ~ASYNC_FLAGS) |
 			       (new_serial.flags & ASYNC_FLAGS));
-		info->close_delay = new_serial.close_delay * HZ / 100;
-		info->closing_wait = new_serial.closing_wait * HZ / 100;
+		info->close_delay = new_serial.close_delay;
+		info->closing_wait = new_serial.closing_wait;
 	}
 
 	if (info->flags & ASYNC_INITIALIZED) {
diff -urN linux-2.4.29-pre1/drivers/char/riscom8.c linux-2.4.29-pre1-ia/drivers/char/riscom8.c
--- linux-2.4.29-pre1/drivers/char/riscom8.c	2001-09-13 23:21:32.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/riscom8.c	2004-11-29 13:01:26.896551688 +0000
@@ -1171,7 +1171,7 @@
 	 */
 	tty->closing = 1;
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, port->closing_wait);
+		tty_wait_until_sent(tty, port->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1208,7 +1208,7 @@
 	if (port->blocked_open) {
 		if (port->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->close_delay);
+			schedule_timeout(port->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&port->open_wait);
 	}
@@ -1518,8 +1518,8 @@
 	tmp.irq  = bp->irq;
 	tmp.flags = port->flags;
 	tmp.baud_base = (RC_OSCFREQ + CD180_TPC/2) / CD180_TPC;
-	tmp.close_delay = port->close_delay * HZ/100;
-	tmp.closing_wait = port->closing_wait * HZ/100;
+	tmp.close_delay = port->close_delay;
+	tmp.closing_wait = port->closing_wait;
 	tmp.xmit_fifo_size = CD180_NFIFO;
 	return copy_to_user(retinfo, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
@@ -1815,8 +1815,8 @@
 		rc_port[i].tqueue.data = &rc_port[i];
 		rc_port[i].tqueue_hangup.routine = do_rc_hangup;
 		rc_port[i].tqueue_hangup.data = &rc_port[i];
-		rc_port[i].close_delay = 50 * HZ/100;
-		rc_port[i].closing_wait = 3000 * HZ/100;
+		rc_port[i].close_delay = 50;	/* .5 seconds */
+		rc_port[i].closing_wait = 3000;	/* 30 seconds */
 		init_waitqueue_head(&rc_port[i].open_wait);
 		init_waitqueue_head(&rc_port[i].close_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/rocket.c linux-2.4.29-pre1-ia/drivers/char/rocket.c
--- linux-2.4.29-pre1/drivers/char/rocket.c	2003-11-28 18:26:20.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/rocket.c	2004-11-29 13:01:26.900551080 +0000
@@ -1103,7 +1103,7 @@
 	 * Wait for the transmit buffer to clear
 	 */
 	if (info->closing_wait != ROCKET_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	/*
 	 * Before we drop DTR, make sure the UART transmitter
 	 * has completely drained; this is especially
@@ -1135,7 +1135,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	} else {
diff -urN linux-2.4.29-pre1/drivers/char/ser_a2232.c linux-2.4.29-pre1-ia/drivers/char/ser_a2232.c
--- linux-2.4.29-pre1/drivers/char/ser_a2232.c	2003-11-28 18:26:20.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/ser_a2232.c	2004-11-29 13:01:26.943544544 +0000
@@ -698,8 +698,8 @@
 		port->gs.callout_termios = tty_std_termios;
 		port->gs.normal_termios = tty_std_termios;
 		port->gs.magic = A2232_MAGIC;
-		port->gs.close_delay = HZ/2;
-		port->gs.closing_wait = 30 * HZ;
+		port->gs.close_delay = 50;	/* .5 seconds */
+		port->gs.closing_wait = 3000;	/* 30 seconds */
 		port->gs.rd = &a2232_real_driver;
 #ifdef NEW_WRITE_LOCKING
 		init_MUTEX(&(port->gs.port_write_sem));
diff -urN linux-2.4.29-pre1/drivers/char/serial.c linux-2.4.29-pre1-ia/drivers/char/serial.c
--- linux-2.4.29-pre1/drivers/char/serial.c	2004-11-17 11:54:21.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/serial.c	2004-11-29 13:01:26.954542872 +0000
@@ -2177,8 +2177,8 @@
 	info->flags = ((state->flags & ~ASYNC_INTERNAL_FLAGS) |
 		       (info->flags & ASYNC_INTERNAL_FLAGS));
 	state->custom_divisor = new_serial.custom_divisor;
-	state->close_delay = new_serial.close_delay * HZ/100;
-	state->closing_wait = new_serial.closing_wait * HZ/100;
+	state->close_delay = new_serial.close_delay;
+	state->closing_wait = new_serial.closing_wait;
 #if (LINUX_VERSION_CODE > 0x20100)
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 #endif
@@ -2845,8 +2845,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -2873,9 +2873,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -5522,8 +5522,8 @@
 		state->line = i;
 		state->type = PORT_UNKNOWN;
 		state->custom_divisor = 0;
-		state->close_delay = 5*HZ/10;
-		state->closing_wait = 30*HZ;
+		state->close_delay = 50;	/* .5 seconds */
+		state->closing_wait = 3000;	/* 30 seconds */
 		state->callout_termios = callout_driver.init_termios;
 		state->normal_termios = serial_driver.init_termios;
 		state->icount.cts = state->icount.dsr = 
diff -urN linux-2.4.29-pre1/drivers/char/serial_amba.c linux-2.4.29-pre1-ia/drivers/char/serial_amba.c
--- linux-2.4.29-pre1/drivers/char/serial_amba.c	2002-08-03 01:39:43.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/serial_amba.c	2004-11-29 13:01:26.946544088 +0000
@@ -1102,8 +1102,8 @@
 	info->flags = ((state->flags & ~ASYNC_INTERNAL_FLAGS) |
 		       (info->flags & ASYNC_INTERNAL_FLAGS));
 	state->custom_divisor = new_serial.custom_divisor;
-	state->close_delay = new_serial.close_delay * HZ / 100;
-	state->closing_wait = new_serial.closing_wait * HZ / 100;
+	state->close_delay = new_serial.close_delay;
+	state->closing_wait = new_serial.closing_wait;
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 	port->fifosize = new_serial.xmit_fifo_size;
 
@@ -1442,7 +1442,7 @@
 	 */
 	tty->closing = 1;
 	if (info->state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->state->closing_wait);
+		tty_wait_until_sent(tty, info->state->closing_wait * HZ / 100);
 	/*
 	 * At this point, we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts.
@@ -1467,7 +1467,7 @@
 	if (info->blocked_open) {
 		if (info->state->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->state->close_delay);
+			schedule_timeout(info->state->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -1829,8 +1829,8 @@
 	for (i = 0; i < SERIAL_AMBA_NR; i++) {
 		struct amba_state *state = amba_state + i;
 		state->line		= i;
-		state->close_delay	= 5 * HZ / 10;
-		state->closing_wait	= 30 * HZ;
+		state->close_delay	= 50;	/* .5 seconds */
+		state->closing_wait	= 3000;	/* 30 seconds */
 		state->callout_termios	= ambacallout_driver.init_termios;
 		state->normal_termios	= ambanormal_driver.init_termios;
 	}
diff -urN linux-2.4.29-pre1/drivers/char/serial_tx3912.c linux-2.4.29-pre1-ia/drivers/char/serial_tx3912.c
--- linux-2.4.29-pre1/drivers/char/serial_tx3912.c	2003-08-25 12:44:41.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/serial_tx3912.c	2004-11-29 13:01:26.956542568 +0000
@@ -624,8 +624,8 @@
 	rs_port->gs.callout_termios = tty_std_termios;
 	rs_port->gs.normal_termios	= tty_std_termios;
 	rs_port->gs.magic = SERIAL_MAGIC;
-	rs_port->gs.close_delay = HZ/2;
-	rs_port->gs.closing_wait = 30 * HZ;
+	rs_port->gs.close_delay = 50;		/* .5 seconds */
+	rs_port->gs.closing_wait = 3000;	/* 30 seconds */
 	rs_port->gs.rd = &rs_real_driver;
 #ifdef NEW_WRITE_LOCKING
 	rs_port->gs.port_write_sem = MUTEX;
diff -urN linux-2.4.29-pre1/drivers/char/serial_txx9.c linux-2.4.29-pre1-ia/drivers/char/serial_txx9.c
--- linux-2.4.29-pre1/drivers/char/serial_txx9.c	2003-08-25 12:44:41.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/serial_txx9.c	2004-11-29 13:01:27.047528736 +0000
@@ -1153,8 +1153,8 @@
 		port->gs.callout_termios = tty_std_termios;
 		port->gs.normal_termios	= tty_std_termios;
 		port->gs.magic = TXX9_SERIAL_MAGIC;
-		port->gs.close_delay = HZ/2;
-		port->gs.closing_wait = 30 * HZ;
+		port->gs.close_delay = 50;	/* .5 seconds */
+		port->gs.closing_wait = 3000;	/* 30 seconds */
 		port->gs.rd = &rs_real_driver;
 #ifdef NEW_WRITE_LOCKING
 		port->gs.port_write_sem = MUTEX;
diff -urN linux-2.4.29-pre1/drivers/char/serial_txx927.c linux-2.4.29-pre1-ia/drivers/char/serial_txx927.c
--- linux-2.4.29-pre1/drivers/char/serial_txx927.c	2002-08-03 01:39:43.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/serial_txx927.c	2004-11-29 13:01:26.959542112 +0000
@@ -1442,8 +1442,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1473,7 +1473,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2059,8 +2059,8 @@
 		state->line = i;
 		state->type = PORT_UNKNOWN;
 		state->custom_divisor = 0;
-		state->close_delay = 5*HZ/10;
-		state->closing_wait = 30*HZ;
+		state->close_delay = 50;	/* .5 seconds */
+		state->closing_wait = 3000;	/* 30 seconds */
 		state->callout_termios = callout_driver.init_termios;
 		state->normal_termios = serial_driver.init_termios;
 		state->icount.cts = state->icount.dsr = 
diff -urN linux-2.4.29-pre1/drivers/char/sgiserial.c linux-2.4.29-pre1-ia/drivers/char/sgiserial.c
--- linux-2.4.29-pre1/drivers/char/sgiserial.c	2004-02-18 13:36:31.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/sgiserial.c	2004-11-29 13:01:27.050528280 +0000
@@ -1476,7 +1476,7 @@
 	 */
 	tty->closing = 1;
 	if (info->closing_wait != ZILOG_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1509,7 +1509,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/sh-sci.c linux-2.4.29-pre1-ia/drivers/char/sh-sci.c
--- linux-2.4.29-pre1/drivers/char/sh-sci.c	2003-11-28 18:26:20.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/sh-sci.c	2004-11-29 13:01:27.053527824 +0000
@@ -1429,8 +1429,8 @@
 		port->gs.callout_termios = sci_callout_driver.init_termios;
 		port->gs.normal_termios	= sci_driver.init_termios;
 		port->gs.magic = SCI_MAGIC;
-		port->gs.close_delay = HZ/2;
-		port->gs.closing_wait = 30 * HZ;
+		port->gs.close_delay = 50;	/* .5 seconds */
+		port->gs.closing_wait = 3000;	/* 30 seconds */
 		port->gs.rd = &sci_real_driver;
 		init_waitqueue_head(&port->gs.open_wait);
 		init_waitqueue_head(&port->gs.close_wait);
diff -urN linux-2.4.29-pre1/drivers/char/specialix.c linux-2.4.29-pre1-ia/drivers/char/specialix.c
--- linux-2.4.29-pre1/drivers/char/specialix.c	2002-08-03 01:39:43.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/specialix.c	2004-11-29 13:01:27.056527368 +0000
@@ -1547,7 +1547,7 @@
 	 */
 	tty->closing = 1;
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, port->closing_wait);
+		tty_wait_until_sent(tty, port->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1587,7 +1587,7 @@
 	if (port->blocked_open) {
 		if (port->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->close_delay);
+			schedule_timeout(port->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&port->open_wait);
 	}
@@ -1960,8 +1960,8 @@
 	tmp.irq  = bp->irq;
 	tmp.flags = port->flags;
 	tmp.baud_base = (SX_OSCFREQ + CD186x_TPC/2) / CD186x_TPC;
-	tmp.close_delay = port->close_delay * HZ/100;
-	tmp.closing_wait = port->closing_wait * HZ/100;
+	tmp.close_delay = port->close_delay;
+	tmp.closing_wait = port->closing_wait;
 	tmp.custom_divisor =  port->custom_divisor;
 	tmp.xmit_fifo_size = CD186x_NFIFO;
 	if (copy_to_user(retinfo, &tmp, sizeof(tmp)))
@@ -2291,8 +2291,8 @@
 		sx_port[i].tqueue.data = &sx_port[i];
 		sx_port[i].tqueue_hangup.routine = do_sx_hangup;
 		sx_port[i].tqueue_hangup.data = &sx_port[i];
-		sx_port[i].close_delay = 50 * HZ/100;
-		sx_port[i].closing_wait = 3000 * HZ/100;
+		sx_port[i].close_delay = 50;	/* .5 seconds */
+		sx_port[i].closing_wait = 3000;	/* 30 seconds */
 		init_waitqueue_head(&sx_port[i].open_wait);
 		init_waitqueue_head(&sx_port[i].close_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/char/stallion.c linux-2.4.29-pre1-ia/drivers/char/stallion.c
--- linux-2.4.29-pre1/drivers/char/stallion.c	2004-11-29 13:00:15.485407832 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/stallion.c	2004-11-29 13:01:27.063526304 +0000
@@ -403,7 +403,7 @@
 #define	STL_SC26198MAXBAUD	460800
 
 #define	STL_BAUDBASE		115200
-#define	STL_CLOSEDELAY		(5 * HZ / 10)
+#define	STL_CLOSEDELAY		50	/* .5 seconds */
 
 /*****************************************************************************/
 
@@ -1221,7 +1221,7 @@
  */
 	tty->closing = 1;
 	if (portp->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, portp->closing_wait);
+		tty_wait_until_sent(tty, portp->closing_wait * HZ / 100);
 	stl_waituntilsent(tty, (HZ / 2));
 
 	portp->flags &= ~ASYNC_INITIALIZED;
@@ -1246,7 +1246,7 @@
 
 	if (portp->openwaitcnt) {
 		if (portp->close_delay)
-			stl_delay(portp->close_delay);
+			stl_delay(portp->close_delay * HZ / 100);
 		wake_up_interruptible(&portp->open_wait);
 	}
 
@@ -2287,7 +2287,7 @@
 		portp->clk = brdp->clk;
 		portp->baud_base = STL_BAUDBASE;
 		portp->close_delay = STL_CLOSEDELAY;
-		portp->closing_wait = 30 * HZ;
+		portp->closing_wait = 3000;	/* 30 seconds */
 		portp->normaltermios = stl_deftermios;
 		portp->callouttermios = stl_deftermios;
 		portp->tqueue.routine = stl_offintr;
diff -urN linux-2.4.29-pre1/drivers/char/sx.c linux-2.4.29-pre1-ia/drivers/char/sx.c
--- linux-2.4.29-pre1/drivers/char/sx.c	2003-06-13 15:51:33.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/sx.c	2004-11-29 13:01:27.107519616 +0000
@@ -2370,8 +2370,8 @@
 			port->gs.callout_termios = tty_std_termios;
 			port->gs.normal_termios	= tty_std_termios;
 			port->gs.magic = SX_MAGIC;
-			port->gs.close_delay = HZ/2;
-			port->gs.closing_wait = 30 * HZ;
+			port->gs.close_delay = 50;	/* .5 seconds */
+			port->gs.closing_wait = 3000;	/* 30 seconds */
 			port->board = board;
 			port->gs.rd = &sx_real_driver;
 #ifdef NEW_WRITE_LOCKING
diff -urN linux-2.4.29-pre1/drivers/char/synclink.c linux-2.4.29-pre1-ia/drivers/char/synclink.c
--- linux-2.4.29-pre1/drivers/char/synclink.c	2003-11-28 18:26:20.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/synclink.c	2004-11-29 13:01:27.117518096 +0000
@@ -3334,7 +3334,7 @@
 		if (debug_level >= DEBUG_LEVEL_INFO)
 			printk("%s(%d):mgsl_close(%s) calling tty_wait_until_sent\n",
 				 __FILE__,__LINE__, info->device_name );
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	}
 		
  	if (info->flags & ASYNC_INITIALIZED)
@@ -3354,7 +3354,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -4581,8 +4581,8 @@
 		info->task.routine = mgsl_bh_handler;
 		info->task.data    = info;
 		info->max_frame_size = 4096;
-		info->close_delay = 5*HZ/10;
-		info->closing_wait = 30*HZ;
+		info->close_delay = 50;		/* .5 seconds */
+		info->closing_wait = 3000;	/* 30 seconds */
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->close_wait);
 		init_waitqueue_head(&info->status_event_wait_q);
diff -urN linux-2.4.29-pre1/drivers/char/synclinkmp.c linux-2.4.29-pre1-ia/drivers/char/synclinkmp.c
--- linux-2.4.29-pre1/drivers/char/synclinkmp.c	2004-11-17 11:54:21.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/synclinkmp.c	2004-11-29 13:01:27.162511256 +0000
@@ -897,7 +897,7 @@
 		if (debug_level >= DEBUG_LEVEL_INFO)
 			printk("%s(%d):%s close() calling tty_wait_until_sent\n",
 				 __FILE__,__LINE__, info->device_name );
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	}
 
  	if (info->flags & ASYNC_INITIALIZED)
@@ -917,7 +917,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -3758,8 +3758,8 @@
 		info->task.routine = bh_handler;
 		info->task.data    = info;
 		info->max_frame_size = 4096;
-		info->close_delay = 5*HZ/10;
-		info->closing_wait = 30*HZ;
+		info->close_delay = 50;		/* .5 seconds */
+		info->closing_wait = 3000;	/* 30 seconds */
 		init_waitqueue_head(&info->open_wait);
 		init_waitqueue_head(&info->close_wait);
 		init_waitqueue_head(&info->status_event_wait_q);
diff -urN linux-2.4.29-pre1/drivers/char/vac-serial.c linux-2.4.29-pre1-ia/drivers/char/vac-serial.c
--- linux-2.4.29-pre1/drivers/char/vac-serial.c	2004-02-18 13:36:31.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/char/vac-serial.c	2004-11-29 13:01:27.166510648 +0000
@@ -1340,8 +1340,8 @@
 		       (info->flags & ASYNC_INTERNAL_FLAGS));
 	state->custom_divisor = new_serial.custom_divisor;
 	state->type = new_serial.type;
-	state->close_delay = new_serial.close_delay * HZ/100;
-	state->closing_wait = new_serial.closing_wait * HZ/100;
+	state->close_delay = new_serial.close_delay;
+	state->closing_wait = new_serial.closing_wait;
 	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
 	info->xmit_fifo_size = state->xmit_fifo_size =
 		new_serial.xmit_fifo_size;
@@ -1699,8 +1699,8 @@
 	 * the line discipline to only process XON/XOFF characters.
 	 */
 	tty->closing = 1;
-	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+	if (state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
+		tty_wait_until_sent(tty, state->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1727,9 +1727,9 @@
 	info->event = 0;
 	info->tty = 0;
 	if (info->blocked_open) {
-		if (info->close_delay) {
+		if (state->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(state->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2417,8 +2417,8 @@
 		state->line = i;
 		state->type = PORT_UNKNOWN;
 		state->custom_divisor = 0;
-		state->close_delay = 5*HZ/10;
-		state->closing_wait = 30*HZ;
+		state->close_delay = 50;	/* .5 seconds */
+		state->closing_wait = 3000;	/* 30 seconds */
 		state->callout_termios = callout_driver.init_termios;
 		state->normal_termios = serial_driver.init_termios;
 		state->icount.cts = state->icount.dsr =
diff -urN linux-2.4.29-pre1/drivers/char/vme_scc.c linux-2.4.29-pre1-ia/drivers/char/vme_scc.c
--- linux-2.4.29-pre1/drivers/char/vme_scc.c	2002-08-03 01:39:43.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/char/vme_scc.c	2004-11-29 13:01:27.168510344 +0000
@@ -205,8 +205,8 @@
 		port->gs.callout_termios = tty_std_termios;
 		port->gs.normal_termios = tty_std_termios;
 		port->gs.magic = SCC_MAGIC;
-		port->gs.close_delay = HZ/2;
-		port->gs.closing_wait = 30 * HZ;
+		port->gs.close_delay = 50;	/* .5 seconds */
+		port->gs.closing_wait = 3000;	/* 30 seconds */
 		port->gs.rd = &scc_real_driver;
 #ifdef NEW_WRITE_LOCKING
 		port->gs.port_write_sem = MUTEX;
diff -urN linux-2.4.29-pre1/drivers/macintosh/macserial.c linux-2.4.29-pre1-ia/drivers/macintosh/macserial.c
--- linux-2.4.29-pre1/drivers/macintosh/macserial.c	2002-08-03 01:39:44.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/macintosh/macserial.c	2004-11-29 13:01:27.172509736 +0000
@@ -1996,7 +1996,7 @@
 	tty->closing = 1;
 	if (info->closing_wait != ZILOG_CLOSING_WAIT_NONE) {
 		restore_flags(flags);
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 		save_flags(flags); cli();
 	}
 
@@ -2038,7 +2038,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/sbus/char/aurora.c linux-2.4.29-pre1-ia/drivers/sbus/char/aurora.c
--- linux-2.4.29-pre1/drivers/sbus/char/aurora.c	2002-11-28 23:53:14.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/sbus/char/aurora.c	2004-11-29 13:01:27.216503048 +0000
@@ -1538,7 +1538,7 @@
 #ifdef AURORA_DEBUG
 		printk("aurora_close: waiting to flush...\n");
 #endif
-		tty_wait_until_sent(tty, port->closing_wait);
+		tty_wait_until_sent(tty, port->closing_wait * HZ / 100);
 	}
 
 	/* At this point we stop accepting input.  To do this, we
@@ -1581,7 +1581,7 @@
 	if (port->blocked_open) {
 		if (port->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->close_delay);
+			schedule_timeout(port->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&port->open_wait);
 	}
@@ -1988,8 +1988,8 @@
 	tmp.irq  = bp->irq;
 	tmp.flags = port->flags;
 	tmp.baud_base = (bp->oscfreq + CD180_TPC/2) / CD180_TPC;
-	tmp.close_delay = port->close_delay * HZ/100;
-	tmp.closing_wait = port->closing_wait * HZ/100;
+	tmp.close_delay = port->close_delay;
+	tmp.closing_wait = port->closing_wait;
 	tmp.xmit_fifo_size = CD180_NFIFO;
 	copy_to_user(retinfo, &tmp, sizeof(tmp));
 #ifdef AURORA_DEBUG
@@ -2359,8 +2359,8 @@
 		aurora_port[i].tqueue.data = &aurora_port[i];
 		aurora_port[i].tqueue_hangup.routine = do_aurora_hangup;
 		aurora_port[i].tqueue_hangup.data = &aurora_port[i];
-		aurora_port[i].close_delay = 50 * HZ/100;
-		aurora_port[i].closing_wait = 3000 * HZ/100;
+		aurora_port[i].close_delay = 50;	/* .5 seconds */
+		aurora_port[i].closing_wait = 3000;	/* 30 seconds */
 		init_waitqueue_head(&aurora_port[i].open_wait);
 		init_waitqueue_head(&aurora_port[i].close_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/sbus/char/sab82532.c linux-2.4.29-pre1-ia/drivers/sbus/char/sab82532.c
--- linux-2.4.29-pre1/drivers/sbus/char/sab82532.c	2002-08-03 01:39:44.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/sbus/char/sab82532.c	2004-11-29 13:01:27.220502440 +0000
@@ -1647,7 +1647,7 @@
 	 */
 	tty->closing = 1;
 	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 
 	/*
 	 * At this point we stop accepting input.  To do this, we
@@ -1675,7 +1675,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2310,8 +2310,8 @@
 		writeb(readb(&info->regs->rw.mode) | SAB82532_MODE_RTS, &info->regs->rw.mode);
 
 		info->custom_divisor = 16;
-		info->close_delay = 5*HZ/10;
-		info->closing_wait = 30*HZ;
+		info->close_delay = 50;		/* .5 seconds */
+		info->closing_wait = 3000;	/* 30 seconds */
 		info->tec_timeout = SAB82532_MAX_TEC_TIMEOUT;
 		info->cec_timeout = SAB82532_MAX_CEC_TIMEOUT;
 		info->x_char = 0;
diff -urN linux-2.4.29-pre1/drivers/sbus/char/su.c linux-2.4.29-pre1-ia/drivers/sbus/char/su.c
--- linux-2.4.29-pre1/drivers/sbus/char/su.c	2002-08-03 01:39:44.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/sbus/char/su.c	2004-11-29 13:01:27.224501832 +0000
@@ -1794,7 +1794,7 @@
 	 */
 	tty->closing = 1;
 	if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1823,7 +1823,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -2553,8 +2553,8 @@
 		info->baud_base = BAUD_BASE;
 		/* info->flags = 0; */
 		info->custom_divisor = 0;
-		info->close_delay = 5*HZ/10;
-		info->closing_wait = 30*HZ;
+		info->close_delay = 50;		/* .5 seconds */
+		info->closing_wait = 3000;	/* 30 seconds */
 		info->callout_termios = callout_driver.init_termios;
 		info->normal_termios = serial_driver.init_termios;
 		info->icount.cts = info->icount.dsr = 
diff -urN linux-2.4.29-pre1/drivers/sbus/char/zs.c linux-2.4.29-pre1-ia/drivers/sbus/char/zs.c
--- linux-2.4.29-pre1/drivers/sbus/char/zs.c	2002-08-03 01:39:44.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/sbus/char/zs.c	2004-11-29 13:01:27.228501224 +0000
@@ -1583,7 +1583,7 @@
 	 */
 	tty->closing = 1;
 	if (info->closing_wait != ZILOG_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receive line status interrupts, and tell the
@@ -1616,7 +1616,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/tc/zs.c linux-2.4.29-pre1-ia/drivers/tc/zs.c
--- linux-2.4.29-pre1/drivers/tc/zs.c	2004-02-18 13:36:31.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/tc/zs.c	2004-11-29 13:01:27.271494688 +0000
@@ -1408,7 +1408,7 @@
 	 */
 	tty->closing = 1;
 	if (info->closing_wait != ZILOG_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, info->closing_wait);
+		tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 	/*
 	 * At this point we stop accepting input.  To do this, we
 	 * disable the receiver and receive interrupts.
@@ -1437,7 +1437,7 @@
 	if (info->blocked_open) {
 		if (info->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			schedule_timeout(info->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
diff -urN linux-2.4.29-pre1/drivers/usb/serial/io_edgeport.c linux-2.4.29-pre1-ia/drivers/usb/serial/io_edgeport.c
--- linux-2.4.29-pre1/drivers/usb/serial/io_edgeport.c	2004-08-08 00:26:05.000000000 +0100
+++ linux-2.4.29-pre1-ia/drivers/usb/serial/io_edgeport.c	2004-11-29 13:01:27.276493928 +0000
@@ -1830,8 +1830,8 @@
 	tmp.flags		= ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ;
 	tmp.xmit_fifo_size	= edge_port->maxTxCredits;
 	tmp.baud_base		= 9600;
-	tmp.close_delay		= 5*HZ;
-	tmp.closing_wait	= 30*HZ;
+	tmp.close_delay		= 50;	/* .5 seconds */
+	tmp.closing_wait	= 3000;	/* 30 seconds */
 //	tmp.custom_divisor	= state->custom_divisor;
 //	tmp.hub6		= state->hub6;
 //	tmp.io_type		= state->io_type;
diff -urN linux-2.4.29-pre1/drivers/usb/serial/io_ti.c linux-2.4.29-pre1-ia/drivers/usb/serial/io_ti.c
--- linux-2.4.29-pre1/drivers/usb/serial/io_ti.c	2003-11-28 18:26:20.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/usb/serial/io_ti.c	2004-11-29 13:01:27.280493320 +0000
@@ -2461,8 +2461,8 @@
 	tmp.flags		= ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ;
 	tmp.xmit_fifo_size	= edge_port->port->bulk_out_size;
 	tmp.baud_base		= 9600;
-	tmp.close_delay		= 5*HZ;
-	tmp.closing_wait	= 30*HZ;
+	tmp.close_delay		= 50;	/* .5 seconds */
+	tmp.closing_wait	= 3000;	/* 30 seconds */
 //	tmp.custom_divisor	= state->custom_divisor;
 //	tmp.hub6		= state->hub6;
 //	tmp.io_type		= state->io_type;
diff -urN linux-2.4.29-pre1/drivers/usb/serial/usbserial.c linux-2.4.29-pre1-ia/drivers/usb/serial/usbserial.c
--- linux-2.4.29-pre1/drivers/usb/serial/usbserial.c	2004-11-17 11:54:21.000000000 +0000
+++ linux-2.4.29-pre1-ia/drivers/usb/serial/usbserial.c	2004-11-29 13:01:27.282493016 +0000
@@ -675,7 +675,7 @@
 		tty->closing = 1;
 		up (&port->sem);
 		if (info->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-			tty_wait_until_sent(tty, info->closing_wait);
+			tty_wait_until_sent(tty, info->closing_wait * HZ / 100);
 		down (&port->sem);
 		if (!tty->driver_data) /* woopsie, disconnect, now what */ ;
 #endif
diff -urN linux-2.4.29-pre1/net/irda/ircomm/ircomm_tty.c linux-2.4.29-pre1-ia/net/irda/ircomm/ircomm_tty.c
--- linux-2.4.29-pre1/net/irda/ircomm/ircomm_tty.c	2003-08-25 12:44:44.000000000 +0100
+++ linux-2.4.29-pre1-ia/net/irda/ircomm/ircomm_tty.c	2004-11-29 13:01:27.329485872 +0000
@@ -419,8 +419,8 @@
 		self->tqueue.data = self;
 		self->max_header_size = IRCOMM_TTY_HDR_UNINITIALISED;
 		self->max_data_size = IRCOMM_TTY_DATA_UNINITIALISED;
-		self->close_delay = 5*HZ/10;
-		self->closing_wait = 30*HZ;
+		self->close_delay = 50;		/* .5 seconds */
+		self->closing_wait = 3000;	/* 30 seconds */
 
 		/* Init some important stuff */
 		init_timer(&self->watchdog_timer);
@@ -560,7 +560,7 @@
 	 */
 	tty->closing = 1;
 	if (self->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, self->closing_wait);
+		tty_wait_until_sent(tty, self->closing_wait * HZ / 100);
 
 	ircomm_tty_shutdown(self);
 
@@ -575,7 +575,7 @@
 	if (self->blocked_open) {
 		if (self->close_delay) {
 			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(self->close_delay);
+			schedule_timeout(self->close_delay * HZ / 100);
 		}
 		wake_up_interruptible(&self->open_wait);
 	}

--------------000903070801040902000607--
