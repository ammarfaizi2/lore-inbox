Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWEBN6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWEBN6q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWEBN6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:58:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43223 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964832AbWEBN6p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:58:45 -0400
Subject: PATCH (RFC): Rework the 8250 console fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 02 May 2006 15:09:43 +0100
Message-Id: <1146578983.3519.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell got various bits of mail showing the 8250 console fix broke some
setups with the assumptions it made. Based on this suggestion that we
actually need to just do the locking I've prepared an alternative
patch. 

The patch does one thing a little oddly. If an oops is in progress it
only attempts to take the port lock and continues regardless. In that
situation the oops will hit the console but things may be a bit odd
thereafter. Getting the oops out seems to be the important thing to do
in that situation.

There are two questions that I think make this an RFC not a final patch

1.	Should this be pushed up into serial/serial_core.c for all chips.

2.	Is the use of local_irq_save/spin_trylock spin_unlock_irqrestore
going to break any platforms that do weird stuff or do we need a
spin_trylock_irqsave ?


Alan

(no signed off by as it isn't yet appropriate to merge.. and if I don't
sign it off nobody can jump the gun 8))

--- drivers/serial/8250.c~	2006-05-02 14:28:05.430397240 +0100
+++ drivers/serial/8250.c	2006-05-02 14:28:05.430397240 +0100
@@ -2201,7 +2201,18 @@
 {
 	struct uart_8250_port *up = &serial8250_ports[co->index];
 	unsigned int ier;
+	unsigned long flags;
+	int locked = 1;
 
+	if (unlikely(oops_in_progress)) {
+		/* We want our private lock to be ignored during an oops. This
+		   might cause a serial console stall afterwards but the oops data
+		   is the critical information to get out */
+		local_irq_save(flags);
+		locked = spin_trylock(&up->port.lock);
+	} else
+		spin_lock_irqsave(&up->port.lock, flags);
+		
 	touch_nmi_watchdog();
 
 	/*
@@ -2221,8 +2232,12 @@
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, ier | UART_IER_THRI);
+	serial_out(up, UART_IER, ier);
+	
+	if (locked)
+		spin_unlock_irqrestore(&up->port.lock, flags);
+	else
+		local_irq_restore(flags);
 }
 
 static int serial8250_console_setup(struct console *co, char *options)

