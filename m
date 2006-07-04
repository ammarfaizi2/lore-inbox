Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWGDTls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWGDTls (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWGDTls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:41:48 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:21137 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932334AbWGDTls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:41:48 -0400
Date: Tue, 4 Jul 2006 16:41:38 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Fulghum <paulkf@microgate.com>,
       Greg KH <gregkh@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Pete Zaitcev <zaitcev@redhat.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] Serial-Core: adds atomic context debug code.
Message-ID: <20060704164138.0bfd6e27@doriath.conectiva>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.4.0-rc2 (GTK+ 2.9.4; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Andrew,

 While porting the USB-Serial layer to the Serial Core API [1], we found that
usb-serial devices must be able to sleep in the get_mctrl() and set_mctrl()
callbacks [2]. But, unfortunately, those callbacks are called with a spinlock
held.

 The solution is to switch from the spinlock to a mutex.

 But turns out that we have no sure whether uart_update_mctrl(),
uart_startup() and uart_configure_port() (which calls {get,set}_mctrl()) are
called from atomic context or not.

 This patch adds might_sleep() calls to them in order to help us to find the
answer.

 Please, note that this is just a debug patch to stay in -mm for a while,
ie, it's not a submission for mainline kernel.

[1] http://marc.theaimsgroup.com/?l=linux-usb-devel&m=114921742628790&w=2
[2] http://lkml.org/lkml/2006/6/13/242

Signed-off-by: Luiz Fernando N. Capitulino <lcapitulino@mandriva.com.br>

diff -purN linux-2.6.17.orig/drivers/serial/serial_core.c linux-2.6.17/drivers/serial/serial_core.c
--- linux-2.6.17.orig/drivers/serial/serial_core.c	2006-07-04 16:35:47.796329000 -0300
+++ linux-2.6.17/drivers/serial/serial_core.c	2006-07-04 16:35:47.820333205 -0300
@@ -128,6 +128,8 @@ uart_update_mctrl(struct uart_port *port
 	unsigned long flags;
 	unsigned int old;
 
+	might_sleep();
+
 	spin_lock_irqsave(&port->lock, flags);
 	old = port->mctrl;
 	port->mctrl = (old & ~clear) | set;
@@ -150,6 +152,8 @@ static int uart_startup(struct uart_stat
 	unsigned long page;
 	int retval = 0;
 
+	might_sleep();
+
 	if (info->flags & UIF_INITIALIZED)
 		return 0;
 
@@ -2055,6 +2059,8 @@ uart_configure_port(struct uart_driver *
 {
 	unsigned int flags;
 
+	might_sleep();
+
 	/*
 	 * If there isn't a port here, don't do anything further.
 	 */


-- 
Luiz Fernando N. Capitulino
