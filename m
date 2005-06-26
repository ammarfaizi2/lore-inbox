Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVFZW04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVFZW04 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVFZW04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:26:56 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:5619 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261617AbVFZW0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:26:48 -0400
Date: Sun, 26 Jun 2005 18:26:43 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [CFT:PATCH] 2/3: Check status of CTS when using flow control
In-reply-to: <20050626221750.GA5789@dyn-67.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <200506261826.43244.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050626221501.GA5769@dyn-67.arm.linux.org.uk>
 <20050626221750.GA5789@dyn-67.arm.linux.org.uk>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 18:17, Russell King wrote:
>Fix bugme #4712: read the CTS status and set hw_stopped if CTS
>is not active.
>
>Thanks to Stefan Wolff for spotting this problem.
>
This one needs to make mainline & maybe, after 3 years, I can use a 
pl2303 to talk to an old slow coco.  Twould be very nice if that 
fixed the lack of flow controls the connection apparently fails from.

>Index: drivers/serial/serial_core.c
>===================================================================
>--- a/drivers/serial/serial_core.c  (mode:100644)
>+++ b/drivers/serial/serial_core.c  (mode:100644)
>@@ -180,6 +180,13 @@
>     */
>    if (info->tty->termios->c_cflag & CBAUD)
>     uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
>+
>+   if (info->flags & UIF_CTS_FLOW) {
>+    spin_lock_irq(&port->lock);
>+    if (!(port->ops->get_mctrl(port) & TIOCM_CTS))
>+					info->tty->hw_stopped = 1;
>+				spin_unlock_irq(&port->lock);
>+			}
> 		}
>
> 		info->flags |= UIF_INITIALIZED;
>@@ -1134,6 +1141,16 @@
> 		spin_unlock_irqrestore(&state->port->lock, flags);
> 	}
>
>+	/* Handle turning on CRTSCTS */
>+	if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
>+		spin_lock_irqsave(&state->port->lock, flags);
>+		if (!(state->port->ops->get_mctrl(state->port) & TIOCM_CTS)) {
>+			tty->hw_stopped = 1;
>+			state->port->ops->stop_tx(state->port, 0);
>+		}
>+		spin_unlock_irqrestore(&state->port->lock, flags);
>+	}
>+
> #if 0
> 	/*
> 	 * No need to wake up processes in open wait, since they
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
