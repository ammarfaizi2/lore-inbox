Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWGLNr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWGLNr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWGLNr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:47:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33041 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751369AbWGLNr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:47:56 -0400
Date: Wed, 12 Jul 2006 14:47:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Minimal fix for sysrq on serial console hang
Message-ID: <20060712134749.GA11047@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <1152712461.22943.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152712461.22943.58.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 02:54:21PM +0100, Alan Cox wrote:
> When I originally did this change I used oops_in_progress as a locking
> guide. However it turns out there is one other place that turns all the
> locking on its head and that is sysrq.

Well, akpm's had a fix in his tree for some time, which he's been
pestering me with, so I committed that a few days ago:

# Author:    Andrew Morton (Fri Jun 30 10:29:59 BST 2006)
# Committer: Russell King (Sun Jul  9 21:11:10 BST 2006)
#	
#	[SERIAL] 8250: sysrq deadlock fix
#	
#	Fix http://bugzilla.kernel.org/show_bug.cgi?id=6716
#	
#	Doing a sysrq over a serial line into an SMP machine presently deadlocks.
#	
#	Signed-off-by: Andrew Morton
#	Signed-off-by: Russell King
#
#	 drivers/serial/8250.c |   13 +++++++++----
#	 1 files changed, 9 insertions(+), 4 deletions(-)
#
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 0995430..0ae9ced 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2240,10 +2252,14 @@ serial8250_console_write(struct console 
 
 	touch_nmi_watchdog();
 
-	if (oops_in_progress) {
-		locked = spin_trylock_irqsave(&up->port.lock, flags);
+	local_irq_save(flags);
+	if (up->port.sysrq) {
+		/* serial8250_handle_port() already took the lock */
+		locked = 0;
+	} else if (oops_in_progress) {
+		locked = spin_trylock(&up->port.lock);
 	} else
-		spin_lock_irqsave(&up->port.lock, flags);
+		spin_lock(&up->port.lock);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -2265,7 +2281,8 @@ serial8250_console_write(struct console 
 	serial_out(up, UART_IER, ier);
 
 	if (locked)
-		spin_unlock_irqrestore(&up->port.lock, flags);
+		spin_unlock(&up->port.lock);
+	local_irq_restore(flags);
 }
 
 static int serial8250_console_setup(struct console *co, char *options)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
