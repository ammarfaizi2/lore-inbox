Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263578AbUJ2VRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUJ2VRW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbUJ2VOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:14:54 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:47922 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263519AbUJ2VIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:08:34 -0400
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP
	kernel
From: Paul Fulghum <paulkf@microgate.com>
To: Tim_T_Murphy@Dell.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC4@ausx2kmps304.aus.amer.dell.com>
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC4@ausx2kmps304.aus.amer.dell.com>
Content-Type: text/plain
Message-Id: <1099084117.3356.7.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 29 Oct 2004 16:08:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 14:55, Tim_T_Murphy@Dell.com wrote:
> Oct 29 13:34:48 racjag-1 chat[3886]: expect (CLIENTSERVER)
> Oct 29 13:34:48 racjag-1 kernel: drivers/serial/serial_core.c:102: spin_lock(drivers/serial/serial_core.c:023f2548) already locked by drivers/serial/8250.c/1015
> Oct 29 13:34:48 racjag-1 kernel: drivers/serial/8250.c:1017: spin_unlock(drivers/serial/serial_core.c:023f2548) not locked
> Oct 29 13:34:48 racjag-1 chat[3886]: CLIENTSERVER

One way this can happen is a receive interrupt:

serial8250_interrupt();
    spin_lock(port->lock);
    serial8250_handle_port();
       receive_chars();
          flip.work.func(); /* if FLIP buffer full */
             ldisc->receive_buf(); /* N_TTY */
                 tty->driver->flush_chars();
                     uart_start();
                        spin_lock(port->lock); *BANG*

Try the attached patch and report what happens.

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.6.8/drivers/serial/8250.c	2004-08-14 00:36:13.000000000 -0500
+++ b/drivers/serial/8250.c	2004-10-29 15:58:28.076014336 -0500
@@ -830,9 +830,13 @@ receive_chars(struct uart_8250_port *up,
 
 	do {
 		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
-			tty->flip.work.func((void *)tty);
-			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
-				return; // if TTY_DONT_FLIP is set
+			/* no room in flip buffer, discard rx FIFO contents to clear IRQ */
+			do {
+				serial_inp(up, UART_RX);
+				up->port.icount.overrun++;
+				*status = serial_inp(up, UART_LSR);
+			} while ((*status & UART_LSR_DR) && (max_count-- > 0));
+			return;	/* if TTY_DONT_FLIP is set */
 		}
 		ch = serial_inp(up, UART_RX);
 		*tty->flip.char_buf_ptr = ch;


