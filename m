Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRBHUz1>; Thu, 8 Feb 2001 15:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbRBHUy5>; Thu, 8 Feb 2001 15:54:57 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:36878 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129041AbRBHUym>; Thu, 8 Feb 2001 15:54:42 -0500
Date: Thu, 8 Feb 2001 21:10:55 GMT
Message-Id: <200102082110.VAA87458@tepid.osl.fast.no>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.uit.no
From: Dag Brattli <dag@brattli.net>
Reply-To: dag@brattli.net
Subject: [patch] patch-2.4.1-irda1 (irtty)
X-Mailer: Pygmy (v0.4.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is a patch that fixes a kernel crash people have 
experiended when using IrDA dongles with Linux-2.4.

The problem was that the netdev was deallocated a bit
to early at close time.

Please apply to your latest 2.4 code.

-- Dag

--- linux/drivers/net/irda/irtty.c.orig	Sun Jan 21 23:35:44 2001
+++ linux/drivers/net/irda/irtty.c	Sun Jan 21 23:36:30 2001
@@ -279,6 +279,11 @@ static void irtty_close(struct tty_struc
 	tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
 	tty->disc_data = 0;
 	
+	/* We are not using any dongle anymore! */
+	if (self->dongle)
+		irda_device_dongle_cleanup(self->dongle);
+	self->dongle = NULL;
+
 	/* Remove netdevice */
 	if (self->netdev) {
 		rtnl_lock();
@@ -286,11 +291,6 @@ static void irtty_close(struct tty_struc
 		rtnl_unlock();
 	}
 	
-	/* We are not using any dongle anymore! */
-	if (self->dongle)
-		irda_device_dongle_cleanup(self->dongle);
-	self->dongle = NULL;
-
 	/* Remove speed changing task if any */
 	if (self->task)
 		irda_task_delete(self->task);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
