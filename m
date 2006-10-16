Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWJPHZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWJPHZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 03:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWJPHZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 03:25:31 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:51370 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1030319AbWJPHZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 03:25:30 -0400
Subject: [PATCH] drivers/serial/dz.c: Remove
	save_flags()/cli()/restore_flags()
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 12:58:52 +0530
Message-Id: <1160983732.19143.420.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced save_flags()/cli()/restore_flags() pair with spin_lock
alternatives.

For this case, I believe spin lock plays no role but I also do not have
a better way.

Tested compile only.

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
--- linux-2.6.19-rc1-orig/drivers/serial/dz.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.19-rc1/drivers/serial/dz.c	2006-10-16 12:48:31.000000000 +0530
@@ -778,13 +778,13 @@ int __init dz_init(void)
 {
 	unsigned long flags;
 	int ret, i;
+	spinlock_t dz_lock = SPIN_LOCK_UNLOCKED;
 
 	printk("%s%s\n", dz_name, dz_version);
 
 	dz_init_ports();
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dz_lock,flags);
 
 #ifndef CONFIG_SERIAL_DZ_CONSOLE
 	/* reset the chip */
@@ -794,7 +794,7 @@ int __init dz_init(void)
 	/* order matters here... the trick is that flags
 	   is updated... in request_irq - to immediatedly obliterate
 	   it is unwise. */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dz_lock,flags);
 
 	if (request_irq(dz_ports[0].port.irq, dz_interrupt,
 			IRQF_DISABLED, "DZ", &dz_ports[0]))


