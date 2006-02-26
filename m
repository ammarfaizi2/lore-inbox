Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWBZKF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWBZKF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 05:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWBZKF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 05:05:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62218 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751308AbWBZKF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 05:05:27 -0500
Date: Sun, 26 Feb 2006 10:05:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Convert serial_core oopses to BUG_ON
Message-ID: <20060226100518.GA31256@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With reference to these two bugs:

	http://bugzilla.kernel.org/show_bug.cgi?id=5958
	http://bugzilla.kernel.org/show_bug.cgi?id=6131

it seems that folk are under the impression that serial_core is
responsible for these bugs.  It isn't.

Calling serial functions to flush buffers, or try to send more data
after the port has been closed or hung up is a bug in the code doing
the calling, not in the serial_core driver.

Make this explicitly obvious by adding BUG_ON()'s.

I don't particularly want to add these BUG_ON()'s since they have a
performance impact, but it seems that they're necessary to convey
sufficient understanding about where the bug lies.  The Bluetooth
problem has been around for _ages_ (longer than the entry in bugzilla)
and no one seems the least bit interested in fixing the fscking thing.

I can only hope that adding these BUG_ON()'s provides sufficient
clarity to cause people to look elsewhere.

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -71,6 +71,11 @@ static void uart_change_pm(struct uart_s
 void uart_write_wakeup(struct uart_port *port)
 {
 	struct uart_info *info = port->info;
+	/*
+	 * This means you called this function _after_ the port was
+	 * closed.  No cookie for you.
+	 */
+	BUG_ON(!info);
 	tasklet_schedule(&info->tlet);
 }
 
@@ -479,6 +484,12 @@ uart_write(struct tty_struct *tty, const
 	unsigned long flags;
 	int c, ret = 0;
 
+	/*
+	 * This means you called this function _after_ the port was
+	 * closed.  No cookie for you.
+	 */
+	BUG_ON(!state);
+
 	if (!circ->buf)
 		return 0;
 
@@ -521,6 +532,12 @@ static void uart_flush_buffer(struct tty
 	struct uart_port *port = state->port;
 	unsigned long flags;
 
+	/*
+	 * This means you called this function _after_ the port was
+	 * closed.  No cookie for you.
+	 */
+	BUG_ON(!state);
+
 	DPRINTK("uart_flush_buffer(%d) called\n", tty->index);
 
 	spin_lock_irqsave(&port->lock, flags);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
