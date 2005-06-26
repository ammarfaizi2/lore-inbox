Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVFZWSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVFZWSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVFZWSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:18:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18194 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261380AbVFZWRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:17:53 -0400
Date: Sun, 26 Jun 2005 23:17:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT:PATCH] 2/3: Check status of CTS when using flow control
Message-ID: <20050626221750.GA5789@dyn-67.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050626221501.GA5769@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626221501.GA5769@dyn-67.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bugme #4712: read the CTS status and set hw_stopped if CTS
is not active.

Thanks to Stefan Wolff for spotting this problem.

Index: drivers/serial/serial_core.c
===================================================================
--- a/drivers/serial/serial_core.c  (mode:100644)
+++ b/drivers/serial/serial_core.c  (mode:100644)
@@ -180,6 +180,13 @@
 			 */
 			if (info->tty->termios->c_cflag & CBAUD)
 				uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
+
+			if (info->flags & UIF_CTS_FLOW) {
+				spin_lock_irq(&port->lock);
+				if (!(port->ops->get_mctrl(port) & TIOCM_CTS))
+					info->tty->hw_stopped = 1;
+				spin_unlock_irq(&port->lock);
+			}
 		}
 
 		info->flags |= UIF_INITIALIZED;
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
