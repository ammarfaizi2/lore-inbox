Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTGGGsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 02:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbTGGGsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 02:48:36 -0400
Received: from dp.samba.org ([66.70.73.150]:25004 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264766AbTGGGsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 02:48:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16137.6948.764603.59450@cargo.ozlabs.ibm.com>
Date: Mon, 7 Jul 2003 17:03:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] timer clean up for i2c-keywest.c
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes i2c-keywest.c to use mod_timer instead of a
two-line sequence to compute .expires and call add_timer in 3 places.
Without this patch I get a BUG from time to time in add_timer.

Paul.

diff -urN linux-2.5/drivers/i2c/i2c-keywest.c pmac-2.5/drivers/i2c/i2c-keywest.c
--- linux-2.5/drivers/i2c/i2c-keywest.c	2003-05-07 14:25:43.000000000 +1000
+++ pmac-2.5/drivers/i2c/i2c-keywest.c	2003-06-15 13:26:59.000000000 +1000
@@ -220,10 +220,8 @@
 	spin_lock(&iface->lock);
 	del_timer(&iface->timeout_timer);
 	handle_interrupt(iface, read_reg(reg_isr));
-	if (iface->state != state_idle) {
-		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-		add_timer(&iface->timeout_timer);
-	}
+	if (iface->state != state_idle)
+		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
 	spin_unlock(&iface->lock);
 	return IRQ_HANDLED;
 }
@@ -331,8 +329,7 @@
 		write_reg(reg_subaddr, command);
 
 	/* Arm timeout */
-	iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-	add_timer(&iface->timeout_timer);
+	mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
 
 	/* Start sending address & enable interrupt*/
 	write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
@@ -421,8 +418,7 @@
 			((iface->read_write == I2C_SMBUS_READ) ? 0x01 : 0x00));
 
 		/* Arm timeout */
-		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
-		add_timer(&iface->timeout_timer);
+		mod_timer(&iface->timeout_timer, jiffies + POLL_TIMEOUT);
 
 		/* Start sending address & enable interrupt*/
 		write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
