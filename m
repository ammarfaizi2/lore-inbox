Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTBOTUn>; Sat, 15 Feb 2003 14:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbTBOTTv>; Sat, 15 Feb 2003 14:19:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62224 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265139AbTBOTTX>; Sat, 15 Feb 2003 14:19:23 -0500
Subject: PATCH: Fix aha1542
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Date: Sat, 15 Feb 2003 19:29:32 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k80D-0007Ju-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap included this with the 152x stuff which then got lost in
discussion about core changes and queueing reset. 154x doesnt need the
extra discussion. Also adds a fix to use mca-legacy as needed for 1640
right now

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/scsi/aha1542.c linux-2.5.61-ac1/drivers/scsi/aha1542.c
--- linux-2.5.61/drivers/scsi/aha1542.c	2003-02-10 18:38:39.000000000 +0000
+++ linux-2.5.61-ac1/drivers/scsi/aha1542.c	2003-02-14 20:13:00.000000000 +0000
@@ -40,6 +40,7 @@
 #include <linux/isapnp.h>
 #include <linux/blk.h>
 #include <linux/mca.h>
+#include <linux/mca-legacy.h>
 
 #include <asm/dma.h>
 #include <asm/system.h>
@@ -597,8 +598,8 @@
 	unchar ahacmd = CMD_START_SCSI;
 	unchar direction;
 	unchar *cmd = (unchar *) SCpnt->cmnd;
-	unchar target = SCpnt->target;
-	unchar lun = SCpnt->lun;
+	unchar target = SCpnt->device->id;
+	unchar lun = SCpnt->device->lun;
 	unsigned long flags;
 	void *buff = SCpnt->request_buffer;
 	int bufflen = SCpnt->request_bufflen;
@@ -608,8 +609,8 @@
 
 	DEB(int i);
 
-	mb = HOSTDATA(SCpnt->host)->mb;
-	ccb = HOSTDATA(SCpnt->host)->ccb;
+	mb = HOSTDATA(SCpnt->device->host)->mb;
+	ccb = HOSTDATA(SCpnt->device->host)->ccb;
 
 	DEB(if (target > 1) {
 	    SCpnt->result = DID_TIME_OUT << 16;
@@ -653,25 +654,25 @@
 	   is how the host adapter will scan for them */
 
 	spin_lock_irqsave(&aha1542_lock, flags);
-	mbo = HOSTDATA(SCpnt->host)->aha1542_last_mbo_used + 1;
+	mbo = HOSTDATA(SCpnt->device->host)->aha1542_last_mbo_used + 1;
 	if (mbo >= AHA1542_MAILBOXES)
 		mbo = 0;
 
 	do {
-		if (mb[mbo].status == 0 && HOSTDATA(SCpnt->host)->SCint[mbo] == NULL)
+		if (mb[mbo].status == 0 && HOSTDATA(SCpnt->device->host)->SCint[mbo] == NULL)
 			break;
 		mbo++;
 		if (mbo >= AHA1542_MAILBOXES)
 			mbo = 0;
-	} while (mbo != HOSTDATA(SCpnt->host)->aha1542_last_mbo_used);
+	} while (mbo != HOSTDATA(SCpnt->device->host)->aha1542_last_mbo_used);
 
-	if (mb[mbo].status || HOSTDATA(SCpnt->host)->SCint[mbo])
+	if (mb[mbo].status || HOSTDATA(SCpnt->device->host)->SCint[mbo])
 		panic("Unable to find empty mailbox for aha1542.\n");
 
-	HOSTDATA(SCpnt->host)->SCint[mbo] = SCpnt;	/* This will effectively prevent someone else from
+	HOSTDATA(SCpnt->device->host)->SCint[mbo] = SCpnt;	/* This will effectively prevent someone else from
 							   screwing with this cdb. */
 
-	HOSTDATA(SCpnt->host)->aha1542_last_mbo_used = mbo;
+	HOSTDATA(SCpnt->device->host)->aha1542_last_mbo_used = mbo;
 	spin_unlock_irqrestore(&aha1542_lock, flags);
 
 #ifdef DEBUG
@@ -762,7 +763,7 @@
 		    aha1542_stat());
 		SCpnt->scsi_done = done;
 		mb[mbo].status = 1;
-		aha1542_out(SCpnt->host->io_port, &ahacmd, 1);	/* start scsi command */
+		aha1542_out(SCpnt->device->host->io_port, &ahacmd, 1);	/* start scsi command */
 		DEB(aha1542_stat());
 	} else
 		printk("aha1542_queuecommand: done can't be NULL\n");
@@ -1356,7 +1357,7 @@
 	 */
 
 	printk(KERN_ERR "aha1542.c: Unable to abort command for target %d\n",
-	       SCpnt->target);
+	       SCpnt->device->id);
 	return FAILED;
 }
 
@@ -1368,36 +1369,36 @@
 {
 	unsigned long flags;
 	struct mailbox *mb;
-	unchar target = SCpnt->target;
-	unchar lun = SCpnt->lun;
+	unchar target = SCpnt->device->id;
+	unchar lun = SCpnt->device->lun;
 	int mbo;
 	struct ccb *ccb;
 	unchar ahacmd = CMD_START_SCSI;
 
-	ccb = HOSTDATA(SCpnt->host)->ccb;
-	mb = HOSTDATA(SCpnt->host)->mb;
+	ccb = HOSTDATA(SCpnt->device->host)->ccb;
+	mb = HOSTDATA(SCpnt->device->host)->mb;
 
 	spin_lock_irqsave(&aha1542_lock, flags);
-	mbo = HOSTDATA(SCpnt->host)->aha1542_last_mbo_used + 1;
+	mbo = HOSTDATA(SCpnt->device->host)->aha1542_last_mbo_used + 1;
 	if (mbo >= AHA1542_MAILBOXES)
 		mbo = 0;
 
 	do {
-		if (mb[mbo].status == 0 && HOSTDATA(SCpnt->host)->SCint[mbo] == NULL)
+		if (mb[mbo].status == 0 && HOSTDATA(SCpnt->device->host)->SCint[mbo] == NULL)
 			break;
 		mbo++;
 		if (mbo >= AHA1542_MAILBOXES)
 			mbo = 0;
-	} while (mbo != HOSTDATA(SCpnt->host)->aha1542_last_mbo_used);
+	} while (mbo != HOSTDATA(SCpnt->device->host)->aha1542_last_mbo_used);
 
-	if (mb[mbo].status || HOSTDATA(SCpnt->host)->SCint[mbo])
+	if (mb[mbo].status || HOSTDATA(SCpnt->device->host)->SCint[mbo])
 		panic("Unable to find empty mailbox for aha1542.\n");
 
-	HOSTDATA(SCpnt->host)->SCint[mbo] = SCpnt;	/* This will effectively
+	HOSTDATA(SCpnt->device->host)->SCint[mbo] = SCpnt;	/* This will effectively
 							   prevent someone else from
 							   screwing with this cdb. */
 
-	HOSTDATA(SCpnt->host)->aha1542_last_mbo_used = mbo;
+	HOSTDATA(SCpnt->device->host)->aha1542_last_mbo_used = mbo;
 	spin_unlock_irqrestore(&aha1542_lock, flags);
 
 	any2scsi(mb[mbo].ccbptr, SCSI_BUF_PA(&ccb[mbo]));	/* This gets trashed for some reason */
@@ -1415,9 +1416,9 @@
 	 * Now tell the 1542 to flush all pending commands for this 
 	 * target 
 	 */
-	aha1542_out(SCpnt->host->io_port, &ahacmd, 1);
+	aha1542_out(SCpnt->device->host->io_port, &ahacmd, 1);
 
-	printk(KERN_WARNING "aha1542.c: Trying device reset for target %d\n", SCpnt->target);
+	printk(KERN_WARNING "aha1542.c: Trying device reset for target %d\n", SCpnt->device->id);
 
 	return SUCCESS;
 
@@ -1467,7 +1468,7 @@
 	 * we do this?  Try this first, and we can add that later
 	 * if it turns out to be useful.
 	 */
-	outb(SCRST, CONTROL(SCpnt->host->io_port));
+	outb(SCRST, CONTROL(SCpnt->device->host->io_port));
 
 	/*
 	 * Wait for the thing to settle down a bit.  Unfortunately
@@ -1476,11 +1477,11 @@
 	 * check for timeout, and if we are doing something like this
 	 * we are pretty desperate anyways.
 	 */
-	spin_unlock_irq(SCpnt->host->host_lock);
+	spin_unlock_irq(SCpnt->device->host->host_lock);
 	scsi_sleep(4 * HZ);
-	spin_lock_irq(SCpnt->host->host_lock);
+	spin_lock_irq(SCpnt->device->host->host_lock);
 
-	WAIT(STATUS(SCpnt->host->io_port),
+	WAIT(STATUS(SCpnt->device->host->io_port),
 	     STATMASK, INIT | IDLE, STST | DIAGF | INVDCMD | DF | CDF);
 
 	/*
@@ -1489,12 +1490,12 @@
 	 * out.  We do not try and restart any commands or anything - 
 	 * the strategy handler takes care of that crap.
 	 */
-	printk(KERN_WARNING "Sent BUS RESET to scsi host %d\n", SCpnt->host->host_no);
+	printk(KERN_WARNING "Sent BUS RESET to scsi host %d\n", SCpnt->device->host->host_no);
 
 	for (i = 0; i < AHA1542_MAILBOXES; i++) {
-		if (HOSTDATA(SCpnt->host)->SCint[i] != NULL) {
+		if (HOSTDATA(SCpnt->device->host)->SCint[i] != NULL) {
 			Scsi_Cmnd *SCtmp;
-			SCtmp = HOSTDATA(SCpnt->host)->SCint[i];
+			SCtmp = HOSTDATA(SCpnt->device->host)->SCint[i];
 
 
 			if (SCtmp->device->soft_reset) {
@@ -1510,8 +1511,8 @@
 				kfree(SCtmp->host_scribble);
 				SCtmp->host_scribble = NULL;
 			}
-			HOSTDATA(SCpnt->host)->SCint[i] = NULL;
-			HOSTDATA(SCpnt->host)->mb[i].status = 0;
+			HOSTDATA(SCpnt->device->host)->SCint[i] = NULL;
+			HOSTDATA(SCpnt->device->host)->mb[i].status = 0;
 		}
 	}
 
@@ -1531,7 +1532,7 @@
 	 * we do this?  Try this first, and we can add that later
 	 * if it turns out to be useful.
 	 */
-	outb(HRST | SCRST, CONTROL(SCpnt->host->io_port));
+	outb(HRST | SCRST, CONTROL(SCpnt->device->host->io_port));
 
 	/*
 	 * Wait for the thing to settle down a bit.  Unfortunately
@@ -1540,18 +1541,18 @@
 	 * check for timeout, and if we are doing something like this
 	 * we are pretty desperate anyways.
 	 */
-	spin_unlock_irq(SCpnt->host->host_lock);
+	spin_unlock_irq(SCpnt->device->host->host_lock);
 	scsi_sleep(4 * HZ);
-	spin_lock_irq(SCpnt->host->host_lock);
+	spin_lock_irq(SCpnt->device->host->host_lock);
 
-	WAIT(STATUS(SCpnt->host->io_port),
+	WAIT(STATUS(SCpnt->device->host->io_port),
 	     STATMASK, INIT | IDLE, STST | DIAGF | INVDCMD | DF | CDF);
 
 	/*
 	 * We need to do this too before the 1542 can interact with
 	 * us again.
 	 */
-	setup_mailboxes(SCpnt->host->io_port, SCpnt->host);
+	setup_mailboxes(SCpnt->device->host->io_port, SCpnt->device->host);
 
 	/*
 	 * Now try to pick up the pieces.  For all pending commands,
@@ -1559,12 +1560,12 @@
 	 * out.  We do not try and restart any commands or anything - 
 	 * the strategy handler takes care of that crap.
 	 */
-	printk(KERN_WARNING "Sent BUS RESET to scsi host %d\n", SCpnt->host->host_no);
+	printk(KERN_WARNING "Sent BUS RESET to scsi host %d\n", SCpnt->device->host->host_no);
 
 	for (i = 0; i < AHA1542_MAILBOXES; i++) {
-		if (HOSTDATA(SCpnt->host)->SCint[i] != NULL) {
+		if (HOSTDATA(SCpnt->device->host)->SCint[i] != NULL) {
 			Scsi_Cmnd *SCtmp;
-			SCtmp = HOSTDATA(SCpnt->host)->SCint[i];
+			SCtmp = HOSTDATA(SCpnt->device->host)->SCint[i];
 
 			if (SCtmp->device->soft_reset) {
 				/*
@@ -1579,8 +1580,8 @@
 				kfree(SCtmp->host_scribble);
 				SCtmp->host_scribble = NULL;
 			}
-			HOSTDATA(SCpnt->host)->SCint[i] = NULL;
-			HOSTDATA(SCpnt->host)->mb[i].status = 0;
+			HOSTDATA(SCpnt->device->host)->SCint[i] = NULL;
+			HOSTDATA(SCpnt->device->host)->mb[i].status = 0;
 		}
 	}
 
