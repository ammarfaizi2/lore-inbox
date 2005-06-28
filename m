Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVF1ObF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVF1ObF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVF1O3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:29:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12042 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261958AbVF1OY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:24:57 -0400
Date: Tue, 28 Jun 2005 15:24:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT:PATCH] 2/3: Check status of CTS when using flow control
Message-ID: <20050628152452.A9994@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050626221501.GA5769@dyn-67.arm.linux.org.uk> <20050626221750.GA5789@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050626221750.GA5789@dyn-67.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Jun 26, 2005 at 11:17:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 11:17:50PM +0100, Russell King wrote:
> Fix bugme #4712: read the CTS status and set hw_stopped if CTS
> is not active.
> 
> Thanks to Stefan Wolff for spotting this problem.

Stefan Wolff pointed out that this wasn't quite correct.  Here's an
updated patch.

Index: drivers/serial/serial_core.c
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/drivers/serial/serial_core.c  (mode:100644)
+++ uncommitted/drivers/serial/serial_core.c  (mode:100644)
@@ -182,6 +182,13 @@
 				uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
 		}
 
+		if (info->flags & UIF_CTS_FLOW) {
+			spin_lock_irq(&port->lock);
+			if (!(port->ops->get_mctrl(port) & TIOCM_CTS))
+				info->tty->hw_stopped = 1;
+			spin_unlock_irq(&port->lock);
+		}
+
 		info->flags |= UIF_INITIALIZED;
 
 		clear_bit(TTY_IO_ERROR, &info->tty->flags);
@@ -1134,6 +1141,16 @@
 		spin_unlock_irqrestore(&state->port->lock, flags);
 	}
 
+	/* Handle turning on CRTSCTS */
+	if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
+		spin_lock_irqsave(&state->port->lock, flags);
+		if (!(state->port->ops->get_mctrl(state->port) & TIOCM_CTS)) {
+			tty->hw_stopped = 1;
+			state->port->ops->stop_tx(state->port, 0);
+		}
+		spin_unlock_irqrestore(&state->port->lock, flags);
+	}
+
 #if 0
 	/*
 	 * No need to wake up processes in open wait, since they


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
