Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267962AbTBRR4d>; Tue, 18 Feb 2003 12:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267959AbTBRR4B>; Tue, 18 Feb 2003 12:56:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20745 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267935AbTBRRyP>; Tue, 18 Feb 2003 12:54:15 -0500
Subject: PATCH: add ide_execute_command but do not use it yet
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:04:36 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lC6e-00067g-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/ide-iops.c linux-2.5.61-ac2/drivers/ide/ide-iops.c
--- linux-2.5.61/drivers/ide/ide-iops.c	2003-02-10 18:38:18.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/ide-iops.c	2003-02-18 18:06:17.000000000 +0000
@@ -926,6 +983,8 @@
  * at the appropriate code to handle the next interrupt, and a
  * timer is started to prevent us from waiting forever in case
  * something goes wrong (see the ide_timer_expiry() handler later on).
+ *
+ * See also ide_execute_command
  */
 void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler,
 		      unsigned int timeout, ide_expiry_t *expiry)
@@ -935,7 +994,7 @@
 
 	spin_lock_irqsave(&ide_lock, flags);
 	if (hwgroup->handler != NULL) {
-		printk("%s: ide_set_handler: handler not null; "
+		printk(KERN_CRIT "%s: ide_set_handler: handler not null; "
 			"old=%p, new=%p\n",
 			drive->name, hwgroup->handler, handler);
 	}
@@ -948,6 +1007,47 @@
 
 EXPORT_SYMBOL(ide_set_handler);
 
+/**
+ *	ide_execute_command	-	execute an IDE command
+ *	@drive: IDE drive to issue the command against
+ *	@command: command byte to write
+ *	@handler: handler for next phase
+ *	@timeout: timeout for command
+ *	@expiry:  handler to run on timeout
+ *
+ *	Helper function to issue an IDE command. This handles the
+ *	atomicity requirements, command timing and ensures that the 
+ *	handler and IRQ setup do not race. All IDE command kick off
+ *	should go via this function or do equivalent locking.
+ */
+ 
+void ide_execute_command(ide_drive_t *drive, task_ioreg_t cmd, ide_handler_t *handler, unsigned timeout, ide_expiry_t *expiry)
+{
+	unsigned long flags;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+	ide_hwif_t *hwif = HWIF(drive);
+	
+	spin_lock_irqsave(&ide_lock, flags);
+	
+	if(hwgroup->handler)
+		BUG();
+	hwgroup->handler	= handler;
+	hwgroup->expiry		= expiry;
+	hwgroup->timer.expires	= jiffies + timeout;
+	add_timer(&hwgroup->timer);
+	hwif->OUTBSYNC(cmd, IDE_COMMAND_REG);
+	/* Drive takes 400nS to respond, we must avoid the IRQ being
+	   serviced before that. 
+	   
+	   FIXME: we could skip this delay with care on non shared
+	   devices 
+	*/
+	ndelay(400);
+	spin_unlock_irqrestore(&ide_lock, flags);
+}
+
+EXPORT_SYMBOL(ide_execute_command);
+
 
 /* needed below */
 ide_startstop_t do_reset1 (ide_drive_t *, int);
