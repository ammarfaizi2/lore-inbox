Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVLIOGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVLIOGD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 09:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVLIOGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 09:06:03 -0500
Received: from cantor2.suse.de ([195.135.220.15]:52169 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751332AbVLIOGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 09:06:01 -0500
Date: Fri, 9 Dec 2005 15:05:59 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Sachin Sant <sachinp@in.ibm.com>
Subject: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209140559.GA23868@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you can queue this up in -mm for a decade or two, just to make sure
it doesnt make some setup unhappy.


a POWER4 system in 'full-system-partition' mode has the console device
on ttyS0. But the user interface to the Linux system console may still
be on the hardware management console (HMC). If this is the case, there
is no way to send a break to trigger a sysrq.
Other setups do already use 'ctrl o' to trigger sysrq. This includes iSeries
virtual console on tty1, and pSeries LPAR console on hvc0 or hvsi0.

'ctrl o' is currently mapped to 'flush output', see 'stty -a'

Signed-off-by: Olaf Hering <olh@suse.de>

 drivers/serial/8250.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2.6.15-rc5-olh/drivers/serial/8250.c
===================================================================
--- linux-2.6.15-rc5-olh.orig/drivers/serial/8250.c
+++ linux-2.6.15-rc5-olh/drivers/serial/8250.c
@@ -1154,6 +1154,13 @@ receive_chars(struct uart_8250_port *up,
 			 */
 		}
 		ch = serial_inp(up, UART_RX);
+
+#if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_SERIAL_CORE_CONSOLE)
+		/* Handle the SysRq ^O Hack, but only on the system console */
+		if (ch == '\x0f' && uart_handle_break(&up->port))
+			goto ignore_char;
+#endif
+
 		flag = TTY_NORMAL;
 		up->port.icount.rx++;
 
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
