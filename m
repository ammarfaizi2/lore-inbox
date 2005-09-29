Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVI2S6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVI2S6x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVI2S6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:58:53 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:20235 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S964780AbVI2S6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:58:51 -0400
Date: Thu, 29 Sep 2005 14:52:47 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>,
       Nuno Silva <nuno.silva@vgertech.com>
Subject: Re: Linux SATA S.M.A.R.T. and SLEEP? -- was [PATCH libata-dev-2.6:passthru] passthru fixes
Message-ID: <20050929185245.GA28483@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433C31C8.1030901@vgertech.com>
User-Agent: Mutt/1.4.1i
X-Original-Status: RO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Silva <nuno.silva@vgertech.com> wrote:
> Justin Piszcz wrote:
> >Under 2.6.13.2,
> >
> >Is there any utility that I can use to put a SATA HDD to sleep?
> >Secondly, I notice I cannot access any of the HDD's S.M.A.R.T. functions
> >on SATA drives?
> 
> Search for Jeff's patch 2.6.12-git4-passthru1.patch
> I think this will be included RSN. This solves your two issues.

You probably want this patch as well, at least the first hunk.
It fixes a potential memory leak that could cause lock-ups when using
hdparm or smartctl/smartd.

John
---
Fix a few problems seen with the passthru branch:

- leaked scsi_request on buffer allocate failure
- passthru sense routines were refering to tf->command
  which is not read in tf_read, instead use drv_stat for
  status register.
- passthru sense passed back to user on ata_task_ioctl

Patch is against the current libata-dev passthru branch.

Signed-off-by: Jeff Raubitschek <jhr@google.com>

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -116,8 +116,10 @@ int ata_cmd_ioctl(struct scsi_device *sc
 	if (args[3]) {
 		argsize = SECTOR_SIZE * args[3];
 		argbuf = kmalloc(argsize, GFP_KERNEL);
-		if (argbuf == NULL)
-			return -ENOMEM;
+		if (argbuf == NULL) {
+			rc = -ENOMEM;
+			goto error;
+		}
 
 		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
 		scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,
@@ -182,6 +184,7 @@ int ata_task_ioctl(struct scsi_device *s
 	u8 scsi_cmd[MAX_COMMAND_SIZE];
 	u8 args[7];
 	struct scsi_request *sreq;
+	unsigned char *sb;
 
 	if (NULL == (void *)arg)
 		return -EINVAL;
@@ -192,7 +195,7 @@ int ata_task_ioctl(struct scsi_device *s
 	memset(scsi_cmd, 0, sizeof(scsi_cmd));
 	scsi_cmd[0]  = ATA_16;
 	scsi_cmd[1]  = (3 << 1); /* Non-data */
-	/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
+	scsi_cmd[2]  = 0x20; /* Always ask for sense data */
 	scsi_cmd[4]  = args[1];
 	scsi_cmd[6]  = args[2];
 	scsi_cmd[8]  = args[3];
@@ -211,15 +214,29 @@ int ata_task_ioctl(struct scsi_device *s
 	   from scsi_ioctl_send_command() for default case... */
 	scsi_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
 
-	if (sreq->sr_result) {
+	sb = sreq->sr_sense_buffer;
+
+	/* Retrieve data from check condition */
+	if((sb[1] == NO_SENSE) && (sb[2] == 0) && (sb[3] == 0x1D)) {
+		unsigned char *desc= sb + 8;
+
+		args[0]=desc[13];
+		args[1]=desc[3];
+		args[2]=desc[5];
+		args[3]=desc[7];
+		args[4]=desc[9];
+		args[5]=desc[11];
+	} else if (sreq->sr_result) {
 		rc = -EIO;
 		goto error;
 	}
 
-	/* Need code to retrieve data from check condition? */
-
 error:
 	scsi_release_request(sreq);
+
+	if (rc == 0 && copy_to_user(arg, args, sizeof(args)))
+		return -EFAULT;
+
 	return rc;
 }
 
@@ -323,6 +340,7 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
  *	ata_dump_status - user friendly display of error info
  *	@id: id of the port in question
  *	@tf: ptr to filled out taskfile
+ *	@stat: ATA command/status register
  *
  *	Decode and dump the ATA error/status registers for the user so
  *	that they have some idea what really happened at the non
@@ -331,9 +349,9 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
  *	LOCKING:
  *	inherited from caller
  */
-void ata_dump_status(unsigned id, struct ata_taskfile *tf)
+void ata_dump_status(unsigned id, struct ata_taskfile *tf, u8 stat)
 {
-	u8 stat = tf->command, err = tf->feature;
+	u8 err = tf->feature;
 
 	printk(KERN_WARNING "ata%u: status=0x%02x { ", id, stat);
 	if (stat & ATA_BUSY) {
@@ -479,6 +497,7 @@ void ata_to_sense_error(unsigned id, u8 
 /*
  *	ata_gen_ata_desc_sense - Generate check condition sense block.
  *	@qc: Command that completed.
+ *	@stat: ATA status register
  *
  *	This function is specific to the ATA descriptor format sense
  *	block specified for the ATA pass through commands.  Regardless
@@ -489,7 +508,7 @@ void ata_to_sense_error(unsigned id, u8 
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
-void ata_gen_ata_desc_sense(struct ata_queued_cmd *qc)
+void ata_gen_ata_desc_sense(struct ata_queued_cmd *qc, u8 stat)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
@@ -510,10 +529,15 @@ void ata_gen_ata_desc_sense(struct ata_q
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+	if (unlikely(stat & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[1], &sb[2], &sb[3]);
 		sb[1] &= 0x0f;
+	} else {
+		/* ATA PASS THROUGH INFORMATION AVAILABLE */
+		sb[1] = NO_SENSE;
+		sb[2] = 0;
+		sb[3] = 0x1D;
 	}
 
 	/*
@@ -540,7 +564,7 @@ void ata_gen_ata_desc_sense(struct ata_q
 	desc[9] = tf->lbam;
 	desc[11] = tf->lbah;
 	desc[12] = tf->device;
-	desc[13] = tf->command; /* == status reg */
+	desc[13] = stat;
 
 	/*
 	 * Fill in Extend bit, and the high order bytes
@@ -558,6 +582,7 @@ void ata_gen_ata_desc_sense(struct ata_q
 /**
  *	ata_gen_fixed_sense - generate a SCSI fixed sense block
  *	@qc: Command that we are erroring out
+ *	@stat: ATA status register
  *
  *	Leverage ata_to_sense_error() to give us the codes.  Fit our
  *	LBA in here if there's room.
@@ -565,7 +590,7 @@ void ata_gen_ata_desc_sense(struct ata_q
  *	LOCKING:
  *	inherited from caller
  */
-void ata_gen_fixed_sense(struct ata_queued_cmd *qc)
+void ata_gen_fixed_sense(struct ata_queued_cmd *qc, u8 stat)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
@@ -585,7 +610,7 @@ void ata_gen_fixed_sense(struct ata_queu
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+	if (unlikely(stat & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[2], &sb[12], &sb[13]);
 		sb[2] &= 0x0f;
@@ -998,7 +1023,7 @@ static int ata_scsi_qc_complete(struct a
 	 */
 	if (((cmd->cmnd[0] == ATA_16) || (cmd->cmnd[0] == ATA_12)) &&
  	    ((cmd->cmnd[2] & 0x20) || need_sense)) {
- 		ata_gen_ata_desc_sense(qc);
+ 		ata_gen_ata_desc_sense(qc, drv_stat);
 	} else {
 		if (!need_sense) {
 			cmd->result = SAM_STAT_GOOD;
@@ -1009,13 +1034,13 @@ static int ata_scsi_qc_complete(struct a
 			 * good for smaller LBA (and maybe CHS?)
 			 * devices.
 			 */
-			ata_gen_fixed_sense(qc);
+			ata_gen_fixed_sense(qc, drv_stat);
 		}
 	}
 
 	if (need_sense) {
 		/* The ata_gen_..._sense routines fill in tf */
-		ata_dump_status(qc->ap->id, &qc->tf);
+		ata_dump_status(qc->ap->id, &qc->tf, drv_stat);
 	}
 
 	qc->scsidone(cmd);
-- 
John W. Linville
linville@tuxdriver.com

