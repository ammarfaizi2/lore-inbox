Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbTBLFX5>; Wed, 12 Feb 2003 00:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266851AbTBLFX5>; Wed, 12 Feb 2003 00:23:57 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:5562 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S266839AbTBLFXt>; Wed, 12 Feb 2003 00:23:49 -0500
Message-ID: <3E49DC38.52D278C4@verizon.net>
Date: Tue, 11 Feb 2003 21:31:36 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andmike@us.ibm.com, james.bottomley@steeleye.com,
       linux-kernel@vger.kernel.org, fischer@norbit.de, Tommy.Thorn@irisa.fr
Subject: [PATCH] fix scsi/aha15*.c for 2.5.60
Content-Type: multipart/mixed;
 boundary="------------1B3CFF9D5F30012B7D5DB8C0"
X-Authentication-Info: Submitted using SMTP AUTH at pop015.verizon.net from [4.64.238.61] at Tue, 11 Feb 2003 23:33:30 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1B3CFF9D5F30012B7D5DB8C0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Here are patches to aha152x.c and aha1542.c so that they will build
in 2.5.60.

Please review and apply or comment...

Thanks,
~Randy
--------------1B3CFF9D5F30012B7D5DB8C0
Content-Type: text/plain; charset=us-ascii;
 name="scsi-aha15xyz-2560.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scsi-aha15xyz-2560.patch"

patch_name:	scsi-aha15xyz-2560.patch
patch_version:	2003-02-11.21:20:32
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	repair scsi/aha152x.c and aha1542.c for 2.5.60
product:	Linux
product_versions: linux-2560
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 aha152x.c |   78 ++++++++++++++++++++++++++++++++------------------------
 aha1542.c |   86 +++++++++++++++++++++++++++++++-------------------------------
 2 files changed, 88 insertions(+), 76 deletions(-)


diff -Naur ./drivers/scsi/aha152x.c%SYN ./drivers/scsi/aha152x.c
--- ./drivers/scsi/aha152x.c%SYN	Mon Feb 10 10:37:57 2003
+++ ./drivers/scsi/aha152x.c	Tue Feb 11 20:56:26 2003
@@ -306,9 +306,9 @@
 #define ERR_LEAD	KERN_ERR	LEAD
 #define DEBUG_LEAD	KERN_DEBUG	LEAD
 #define CMDINFO(cmd) \
-			(cmd) ? ((cmd)->host->host_no) : -1, \
-                        (cmd) ? ((cmd)->target & 0x0f) : -1, \
-			(cmd) ? ((cmd)->lun & 0x07) : -1
+			(cmd) ? ((cmd)->device->host->host_no) : -1, \
+                        (cmd) ? ((cmd)->device->id & 0x0f) : -1, \
+			(cmd) ? ((cmd)->device->lun & 0x07) : -1
 
 #define DELAY_DEFAULT 1000
 
@@ -583,8 +583,8 @@
 
 #define DATA_LEN		(HOSTDATA(shpnt)->data_len)
 
-#define SYNCRATE		(HOSTDATA(shpnt)->syncrate[CURRENT_SC->target])
-#define SYNCNEG			(HOSTDATA(shpnt)->syncneg[CURRENT_SC->target])
+#define SYNCRATE		(HOSTDATA(shpnt)->syncrate[CURRENT_SC->device->id])
+#define SYNCNEG			(HOSTDATA(shpnt)->syncneg[CURRENT_SC->device->id])
 
 #define DELAY			(HOSTDATA(shpnt)->delay)
 #define EXT_TRANS		(HOSTDATA(shpnt)->ext_trans)
@@ -771,7 +771,7 @@
 	Scsi_Cmnd *ptr, *prev;
 
 	for (ptr = *SC, prev = NULL;
-	     ptr && ((ptr->target != target) || (ptr->lun != lun));
+	     ptr && ((ptr->device->id != target) || (ptr->device->lun != lun));
 	     prev = ptr, ptr = SCNEXT(ptr))
 	     ;
 
@@ -1476,7 +1476,7 @@
  */
 int aha152x_internal_queue(Scsi_Cmnd *SCpnt, struct semaphore *sem, int phase, Scsi_Cmnd *done_SC, void (*done)(Scsi_Cmnd *))
 {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 	unsigned long flags;
 
 #if defined(AHA152X_DEBUG)
@@ -1589,7 +1589,7 @@
  */
 int aha152x_abort(Scsi_Cmnd *SCpnt)
 {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 	Scsi_Cmnd *ptr;
 	unsigned long flags;
 
@@ -1641,7 +1641,7 @@
 {
 	Scsi_Cmnd	 *SCp   = (Scsi_Cmnd *)p;
 	struct semaphore *sem   = SCSEM(SCp);
-	struct Scsi_Host *shpnt = SCp->host;
+	struct Scsi_Host *shpnt = SCp->device->host;
 
 	/* remove command from issue queue */
 	if(remove_SC(&ISSUE_SC, SCp)) {
@@ -1663,10 +1663,11 @@
  */
 int aha152x_device_reset(Scsi_Cmnd * SCpnt)
 {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 	DECLARE_MUTEX_LOCKED(sem);
 	struct timer_list timer;
-	Scsi_Cmnd cmnd;
+	Scsi_Cmnd *cmd;
+	int ret;
 
 #if defined(AHA152X_DEBUG)
 	if(HOSTDATA(shpnt)->debug & debug_eh) {
@@ -1680,31 +1681,42 @@
 		return FAILED;
 	}
 
-	cmnd.cmd_len         = 0;
-	cmnd.host            = SCpnt->host;
-	cmnd.target          = SCpnt->target;
-	cmnd.lun             = SCpnt->lun;
-	cmnd.use_sg          = 0;
-	cmnd.request_buffer  = 0;
-	cmnd.request_bufflen = 0;
+	spin_unlock_irq(shpnt->host_lock);
+	cmd = scsi_get_command(SCpnt->device, GFP_ATOMIC);
+	if (!cmd) {
+		spin_lock_irq(shpnt->host_lock);
+		return FAILED;
+	}
+
+	cmd->cmd_len         = 0;
+	cmd->device->host    = SCpnt->device->host;
+	cmd->device->id      = SCpnt->device->id;
+	cmd->device->lun     = SCpnt->device->lun;
+	cmd->use_sg          = 0;
+	cmd->request_buffer  = 0;
+	cmd->request_bufflen = 0;
 
 	init_timer(&timer);
-	timer.data     = (unsigned long) &cmnd;
+	timer.data     = (unsigned long) cmd;
 	timer.expires  = jiffies + 100*HZ;   /* 10s */
 	timer.function = (void (*)(unsigned long)) timer_expired;
 
-	aha152x_internal_queue(&cmnd, &sem, resetting, 0, internal_done);
+	aha152x_internal_queue(cmd, &sem, resetting, 0, internal_done);
 
 	add_timer(&timer);
 	down(&sem);
 
 	del_timer(&timer);
 
-	if(cmnd.SCp.phase & resetted) {
-		return SUCCESS;
+	if(cmd->SCp.phase & resetted) {
+		ret = SUCCESS;
 	} else {
-		return FAILED;
+		ret = FAILED;
 	}
+
+	scsi_put_command(cmd);
+	spin_lock_irq(shpnt->host_lock);
+	return ret;
 }
 
 void free_hard_reset_SCs(struct Scsi_Host *shpnt, Scsi_Cmnd **SCs)
@@ -1738,7 +1750,7 @@
  */
 int aha152x_bus_reset(Scsi_Cmnd *SCpnt)
 {
-	struct Scsi_Host *shpnt = SCpnt->host;
+	struct Scsi_Host *shpnt = SCpnt->device->host;
 	unsigned long flags;
 
 #if defined(AHA152X_DEBUG)
@@ -1822,7 +1834,7 @@
 	aha152x_bus_reset(SCpnt);
 
 	DPRINTK(debug_eh, DEBUG_LEAD "resetting ports\n", CMDINFO(SCpnt));
-	reset_ports(SCpnt->host);
+	reset_ports(SCpnt->device->host);
 
 	return SUCCESS;
 }
@@ -2052,9 +2064,9 @@
 					cmnd->cmnd[4]         = sizeof(ptr->sense_buffer);
 					cmnd->cmnd[5]         = 0;
 					cmnd->cmd_len	      = 6;
-					cmnd->host            = ptr->host;
-					cmnd->target          = ptr->target;
-					cmnd->lun             = ptr->lun;
+					cmnd->device->host    = ptr->device->host;
+					cmnd->device->id      = ptr->device->id;
+					cmnd->device->lun     = ptr->device->lun;
 					cmnd->use_sg          = 0; 
 					cmnd->request_buffer  = ptr->sense_buffer;
 					cmnd->request_bufflen = sizeof(ptr->sense_buffer);
@@ -2113,7 +2125,7 @@
 		/* clear selection timeout */
 		SETPORT(SSTAT1, SELTO);
 
-		SETPORT(SCSIID, (shpnt->this_id << OID_) | CURRENT_SC->target);
+		SETPORT(SCSIID, (shpnt->this_id << OID_) | CURRENT_SC->device->id);
 		SETPORT(SXFRCTL1, (PARITY ? ENSPCHK : 0 ) | ENSTIMER);
 		SETPORT(SCSISEQ, ENSELO | ENAUTOATNO | (DISCONNECTED_SC ? ENRESELI : 0));
 	} else {
@@ -2152,7 +2164,7 @@
 
 	SETPORT(SSTAT0, CLRSELDO);
 	
-	ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->lun));
+	ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->device->lun));
 
 	if (CURRENT_SC->SCp.phase & aborting) {
 		ADDMSGO(ABORT);
@@ -2472,7 +2484,7 @@
 {
 	if(MSGOLEN==0) {
 		if((CURRENT_SC->SCp.phase & syncneg) && SYNCNEG==2 && SYNCRATE==0) {
-			ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->lun));
+			ADDMSGO(IDENTIFY(RECONNECT, CURRENT_SC->device->lun));
 		} else {
 			printk(INFO_LEAD "unexpected MESSAGE OUT phase; rejecting\n", CMDINFO(CURRENT_SC));
 			ADDMSGO(MESSAGE_REJECT);
@@ -3376,7 +3388,7 @@
 static void show_command(Scsi_Cmnd *ptr)
 {
 	printk(KERN_DEBUG "0x%08x: target=%d; lun=%d; cmnd=(",
-	       (unsigned int) ptr, ptr->target, ptr->lun);
+	       (unsigned int) ptr, ptr->device->id, ptr->device->lun);
 
 	print_command(ptr->cmnd);
 
@@ -3441,7 +3453,7 @@
 	int i;
 
 	SPRINTF("0x%08x: target=%d; lun=%d; cmnd=( ",
-		(unsigned int) ptr, ptr->target, ptr->lun);
+		(unsigned int) ptr, ptr->device->id, ptr->device->lun);
 
 	for (i = 0; i < COMMAND_SIZE(ptr->cmnd[0]); i++)
 		SPRINTF("0x%02x ", ptr->cmnd[i]);
diff -Naur ./drivers/scsi/aha1542.c%SYN ./drivers/scsi/aha1542.c
--- ./drivers/scsi/aha1542.c%SYN	Mon Feb 10 10:38:39 2003
+++ ./drivers/scsi/aha1542.c	Tue Feb 11 21:19:43 2003
@@ -597,8 +597,8 @@
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
@@ -608,8 +608,8 @@
 
 	DEB(int i);
 
-	mb = HOSTDATA(SCpnt->host)->mb;
-	ccb = HOSTDATA(SCpnt->host)->ccb;
+	mb = HOSTDATA(SCpnt->device->host)->mb;
+	ccb = HOSTDATA(SCpnt->device->host)->ccb;
 
 	DEB(if (target > 1) {
 	    SCpnt->result = DID_TIME_OUT << 16;
@@ -653,25 +653,25 @@
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
@@ -762,7 +762,7 @@
 		    aha1542_stat());
 		SCpnt->scsi_done = done;
 		mb[mbo].status = 1;
-		aha1542_out(SCpnt->host->io_port, &ahacmd, 1);	/* start scsi command */
+		aha1542_out(SCpnt->device->host->io_port, &ahacmd, 1);	/* start scsi command */
 		DEB(aha1542_stat());
 	} else
 		printk("aha1542_queuecommand: done can't be NULL\n");
@@ -1356,7 +1356,7 @@
 	 */
 
 	printk(KERN_ERR "aha1542.c: Unable to abort command for target %d\n",
-	       SCpnt->target);
+	       SCpnt->device->id);
 	return FAILED;
 }
 
@@ -1368,36 +1368,36 @@
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
@@ -1415,9 +1415,9 @@
 	 * Now tell the 1542 to flush all pending commands for this 
 	 * target 
 	 */
-	aha1542_out(SCpnt->host->io_port, &ahacmd, 1);
+	aha1542_out(SCpnt->device->host->io_port, &ahacmd, 1);
 
-	printk(KERN_WARNING "aha1542.c: Trying device reset for target %d\n", SCpnt->target);
+	printk(KERN_WARNING "aha1542.c: Trying device reset for target %d\n", SCpnt->device->id);
 
 	return SUCCESS;
 
@@ -1467,7 +1467,7 @@
 	 * we do this?  Try this first, and we can add that later
 	 * if it turns out to be useful.
 	 */
-	outb(SCRST, CONTROL(SCpnt->host->io_port));
+	outb(SCRST, CONTROL(SCpnt->device->host->io_port));
 
 	/*
 	 * Wait for the thing to settle down a bit.  Unfortunately
@@ -1476,11 +1476,11 @@
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
@@ -1489,12 +1489,12 @@
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
@@ -1510,8 +1510,8 @@
 				kfree(SCtmp->host_scribble);
 				SCtmp->host_scribble = NULL;
 			}
-			HOSTDATA(SCpnt->host)->SCint[i] = NULL;
-			HOSTDATA(SCpnt->host)->mb[i].status = 0;
+			HOSTDATA(SCpnt->device->host)->SCint[i] = NULL;
+			HOSTDATA(SCpnt->device->host)->mb[i].status = 0;
 		}
 	}
 
@@ -1531,7 +1531,7 @@
 	 * we do this?  Try this first, and we can add that later
 	 * if it turns out to be useful.
 	 */
-	outb(HRST | SCRST, CONTROL(SCpnt->host->io_port));
+	outb(HRST | SCRST, CONTROL(SCpnt->device->host->io_port));
 
 	/*
 	 * Wait for the thing to settle down a bit.  Unfortunately
@@ -1540,18 +1540,18 @@
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
@@ -1559,12 +1559,12 @@
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
@@ -1579,8 +1579,8 @@
 				kfree(SCtmp->host_scribble);
 				SCtmp->host_scribble = NULL;
 			}
-			HOSTDATA(SCpnt->host)->SCint[i] = NULL;
-			HOSTDATA(SCpnt->host)->mb[i].status = 0;
+			HOSTDATA(SCpnt->device->host)->SCint[i] = NULL;
+			HOSTDATA(SCpnt->device->host)->mb[i].status = 0;
 		}
 	}
 

--------------1B3CFF9D5F30012B7D5DB8C0--

