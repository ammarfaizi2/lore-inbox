Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWAQQUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWAQQUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWAQQUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:20:06 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:27848 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932106AbWAQQUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:20:04 -0500
Date: Wed, 18 Jan 2006 01:19:35 +0900 (JST)
Message-Id: <20060118.011935.92586316.anemo@mba.ocn.ne.jp>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, sshtylyov@ru.mvista.com
Subject: [PATCH] serial: initialize spinlock for port failed to setup
 console
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems serial_core intend to initialize port->lock just once for
each ports.  This is done in uart_set_options() for console, and in
uart_add_one_port() for other ports.  But there is a case the
port->lock is not initialized by serial_core.  If the setup function
for the console was failed, it will not call uart_set_options() but
the port is marked as console (uart_console(port) returns 1).  It can
happen if console was PCI port which can not detected at the time of
register_console.

This patch is to initialize port->lock for such console port.  With
this change, most of spin_lock_init() (some of them are labeled
"Temporary fix.") in low-level serial drivers can be omitted.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 9437704..211701d 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2235,7 +2235,7 @@ int uart_add_one_port(struct uart_driver
 	 * If this port is a console, then the spinlock is already
 	 * initialised.
 	 */
-	if (!uart_console(port))
+	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED)))
 		spin_lock_init(&port->lock);
 
 	uart_configure_port(drv, state, port);
