Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263778AbTCUT1N>; Fri, 21 Mar 2003 14:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263811AbTCUTZ4>; Fri, 21 Mar 2003 14:25:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51076
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263778AbTCUTZR>; Fri, 21 Mar 2003 14:25:17 -0500
Date: Fri, 21 Mar 2003 20:40:33 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212040.h2LKeXeU026425@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: add __ide_set_handler to fix abort race
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/ide-iops.c linux-2.5.65-ac2/drivers/ide/ide-iops.c
--- linux-2.5.65/drivers/ide/ide-iops.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/ide-iops.c	2003-03-07 18:43:58.000000000 +0000
@@ -986,13 +999,11 @@
  *
  * See also ide_execute_command
  */
-void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler,
+void __ide_set_handler (ide_drive_t *drive, ide_handler_t *handler,
 		      unsigned int timeout, ide_expiry_t *expiry)
 {
-	unsigned long flags;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
-	spin_lock_irqsave(&ide_lock, flags);
 	if (hwgroup->handler != NULL) {
 		printk(KERN_CRIT "%s: ide_set_handler: handler not null; "
 			"old=%p, new=%p\n",
@@ -1002,11 +1013,21 @@
 	hwgroup->expiry		= expiry;
 	hwgroup->timer.expires	= jiffies + timeout;
 	add_timer(&hwgroup->timer);
+}
+
+EXPORT_SYMBOL(__ide_set_handler);
+
+void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler,
+		      unsigned int timeout, ide_expiry_t *expiry)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&ide_lock, flags);
+	__ide_set_handler(drive, handler, timeout, expiry);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
 EXPORT_SYMBOL(ide_set_handler);
-
+ 
 /**
  *	ide_execute_command	-	execute an IDE command
  *	@drive: IDE drive to issue the command against
