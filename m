Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbUC2JFk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 04:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUC2JFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 04:05:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:56978 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262770AbUC2JFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 04:05:30 -0500
Subject: [PATCH] fix oops at pmac_zilog rmmod'ing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080551112.1384.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 19:05:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew / Linus, please apply

Ben.

-----Forwarded Message-----
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix oops at pmac_zilog rmmod'ing
Date: Mon, 29 Mar 2004 10:51:37 +0200

Hi,

rmmod'ing pmac_zilog currently oopses because uart_unregister_driver(),
which nullifies drv->tty_driver, is called before uart_remove_one_port(),
which uses said drv->tty_driver.

The comment at top of uart_unregister_driver() specifically says we have
to have removed all our ports
via uart_remove_one_port() before.

HTH,

--- drivers/serial/pmac_zilog.c.orig	2004-03-29 10:41:22.000000000 +0200
+++ drivers/serial/pmac_zilog.c	2004-03-29 10:42:07.000000000 +0200
@@ -1875,9 +1875,6 @@
 	/* Get rid of macio-driver (detach from macio) */
 	macio_unregister_driver(&pmz_driver);
 
-	/* Unregister UART driver */
-	uart_unregister_driver(&pmz_uart_reg);
-
 	for (i = 0; i < pmz_ports_count; i++) {
 		struct uart_pmac_port *uport = &pmz_ports[i];
 		if (uport->node != NULL) {
@@ -1885,6 +1882,8 @@
 			pmz_dispose_port(uport);
 		}
 	}
+	/* Unregister UART driver */
+	uart_unregister_driver(&pmz_uart_reg);
 }
 
 #ifdef CONFIG_SERIAL_PMACZILOG_CONSOLE


