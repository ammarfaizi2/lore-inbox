Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTJPQ7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTJPQ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:59:15 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:14062 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262709AbTJPQ7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:59:01 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] serial console registration bugfix (2.6)
Date: Thu, 16 Oct 2003 10:58:56 -0600
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310161058.56455.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uart_set_options() can dereference a null pointer.  This happens
if you specify a console that hasn't previously been setup by
early_serial_setup().

For example, on ia64, the HCDP typically tells us about line 0,
so we calls early_serial_setup() for it.  If the user specifies
"console=ttyS3", we machine-check when trying to follow the
uninitialized port->ops pointer.

It's not entirely clear to me whether we should return 0 or -ENODEV
or something.  The advantage of returning zero is that if the user
specifies "console=ttyS0" and we just lack the HCDP, the console
doesn't work as early as usual, but it does start working after the
serial driver detects the port (though the baud/parity/etc from the
command line are lost).  Returning -ENODEV seems to prevent it from
ever working.

Bjorn

===== drivers/serial/serial_core.c 1.72 vs edited =====
--- 1.72/drivers/serial/serial_core.c	Mon Sep 29 18:35:33 2003
+++ edited/drivers/serial/serial_core.c	Thu Oct 16 09:56:55 2003
@@ -1859,6 +1859,9 @@
 	if (flow == 'r')
 		termios.c_cflag |= CRTSCTS;
 
+	if (!port->ops)
+		return 0;
+
 	port->ops->set_termios(port, &termios, NULL);
 	co->cflag = termios.c_cflag;
 

