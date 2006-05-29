Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWE2VhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWE2VhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWE2VZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:25:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7123 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751356AbWE2VZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:43 -0400
Date: Mon, 29 May 2006 23:26:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 36/61] lock validator: special locking: serial
Message-ID: <20060529212604.GJ3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (dual-initialized) locking code to the lock validator.
Has no effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
---
 drivers/serial/serial_core.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: linux/drivers/serial/serial_core.c
===================================================================
--- linux.orig/drivers/serial/serial_core.c
+++ linux/drivers/serial/serial_core.c
@@ -1849,6 +1849,12 @@ static const struct baud_rates baud_rate
 	{      0, B38400  }
 };
 
+/*
+ * lockdep: port->lock is initialized in two places, but we
+ *          want only one lock-type:
+ */
+static struct lockdep_type_key port_lock_key;
+
 /**
  *	uart_set_options - setup the serial console parameters
  *	@port: pointer to the serial ports uart_port structure
@@ -1869,7 +1875,7 @@ uart_set_options(struct uart_port *port,
 	 * Ensure that the serial console lock is initialised
 	 * early.
 	 */
-	spin_lock_init(&port->lock);
+	spin_lock_init_key(&port->lock, &port_lock_key);
 
 	memset(&termios, 0, sizeof(struct termios));
 
@@ -2255,7 +2261,7 @@ int uart_add_one_port(struct uart_driver
 	 * initialised.
 	 */
 	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED)))
-		spin_lock_init(&port->lock);
+		spin_lock_init_key(&port->lock, &port_lock_key);
 
 	uart_configure_port(drv, state, port);
 
