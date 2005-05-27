Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVE0VXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVE0VXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 17:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVE0VU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 17:20:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:18401 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262601AbVE0VTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 17:19:55 -0400
Message-ID: <42978EF1.5000703@pobox.com>
Date: Fri, 27 May 2005 17:19:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix ide-scsi EH locking
Content-Type: multipart/mixed;
 boundary="------------090503010009000008000405"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090503010009000008000405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


SCSI's error handling hooks are called inside

	spin_lock_irqsave(host_lock, flags)
	...
	spin_unlock_irqrestore(host_lock, flags)

ide-scsi's SCSI EH functions, which operate inside the above lock, wrap 
several operations inside

	spin_lock_irq(ide_lock)
	...
	spin_unlock_irq(ide_lock)

Use of the unconditional spin_lock_irq(), as opposed to 
spin_lock_irqsave(), corrupts the irq context.

Attached patch (against latest git) updates ide-scsi to simply use the 
spin_lock() variant, since we know we are already inside of 
spin_lock_irqsave().

Patch untested, but at least the code isn't obviously wrong now...



--------------090503010009000008000405
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -46,6 +46,7 @@
 #include <linux/slab.h>
 #include <linux/ide.h>
 #include <linux/scatterlist.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -959,7 +960,8 @@ static int idescsi_eh_abort (struct scsi
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
 		printk (KERN_WARNING "ide-scsi: drive did%s become ready\n", busy?" not":"");
 
-	spin_lock_irq(&ide_lock);
+	/* remember, we are inside spin_lock_irq() already */
+	spin_lock(&ide_lock);
 
 	/* If there is no pc running we're done (our interrupt took care of it) */
 	if (!scsi->pc) {
@@ -985,7 +987,7 @@ static int idescsi_eh_abort (struct scsi
 	}
 
 ide_unlock:
-	spin_unlock_irq(&ide_lock);
+	spin_unlock(&ide_lock);
 no_drive:
 	if (test_bit(IDESCSI_LOG_CMD, &scsi->log))
 		printk (KERN_WARNING "ide-scsi: abort returns %s\n", ret == SUCCESS?"success":"failed");
@@ -1012,7 +1014,8 @@ static int idescsi_eh_reset (struct scsi
 		return FAILED;
 	}
 
-	spin_lock_irq(&ide_lock);
+	/* remember, we are inside spin_lock_irq() already */
+	spin_lock(&ide_lock);
 
 	if (!scsi->pc || (req = scsi->pc->rq) != HWGROUP(drive)->rq || !HWGROUP(drive)->handler) {
 		printk (KERN_WARNING "ide-scsi: No active request in idescsi_eh_reset\n");
@@ -1038,16 +1041,15 @@ static int idescsi_eh_reset (struct scsi
 	HWGROUP(drive)->rq = NULL;
 	HWGROUP(drive)->handler = NULL;
 	HWGROUP(drive)->busy = 1;		/* will set this to zero when ide reset finished */
-	spin_unlock_irq(&ide_lock);
+	spin_unlock(&ide_lock);
 
 	ide_do_reset(drive);
 
 	/* ide_do_reset starts a polling handler which restarts itself every 50ms until the reset finishes */
 
 	do {
-		set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock_irq(cmd->device->host->host_lock);
-		schedule_timeout(HZ/20);
+		msleep(50);
 		spin_lock_irq(cmd->device->host->host_lock);
 	} while ( HWGROUP(drive)->handler );
 

--------------090503010009000008000405--
