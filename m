Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVCQWXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVCQWXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVCQWXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:23:14 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:25212 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261263AbVCQWUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:20:31 -0500
From: Brett Russ <russb@emc.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050317221753.53957EDF@lns1032.lss.emc.com>
In-Reply-To: <20050317221753.53957EDF@lns1032.lss.emc.com>
Subject: Re: [PATCH libata-dev-2.6 05/05] libata: rework how CCs generated
Message-ID: <20050317221753.0D09D0D9@lns1032.lss.emc.com>
Date: Thu, 17 Mar 2005 17:20:26 -0500 (EST)
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05_libata_split_ata_to_sense_error.patch

	This patch fixes several bugs as well as reorganizes the way
	check conditions are generated.  Bugs fixed: 1) in
	ata_scsi_qc_complete(), ATA_12/16 commands wouldn't call
	ata_pass_thru_cc() on error status; 2) ata_pass_thru_cc()
	wouldn't put the SK, ASC, and ASCQ from ata_to_sense_error()
	in the correct place in the sense block because
	ata_to_sense_error() was writing a fixed sense block.

	Per the recommendations in the comments, ata_to_sense_error()
	is now split into 3 parts.  The existing fcn is only used for
	outputting a sense key/ASC/ASCQ triplicate.  A new function
	ata_dump_status() was created to print the error info, similar
	to the ide variety.  A third function ata_gen_fixed_sense()
	was created to generate a fixed length sense block.  I added
	the use of the info field for 28b LBAs only.
	ata_pass_thru_cc() renamed to ata_gen_ata_desc_sense() to
	match naming convention, presumably to include another
	descriptor format function in the future (see question 2
	below).

	Questions:

	1) I made the ata_gen_..._sense() routines read the status
           register themselves rather than use the drv_stat values
           that used to be passed in?  These values seemed
           unreliable/useless since they were often hard coded (see
           calls to ata_qc_complete() for origins of most drv_stat
           variables).  Sound ok?

	2) the SAT spec has little about error handling and sense
           information, sepcifically what descriptor format is valid
           for use by SAT commands.  I want to use descriptor type 00
           (information) in my next patch until a spec says
           differently.  Sound ok?

Signed-off-by: Brett Russ <russb@emc.com>

 libata-scsi.c |  342 +++++++++++++++++++++++++++++++++-------------------------
 libata.h      |    1 
 2 files changed, 197 insertions(+), 146 deletions(-)

Index: libata-dev-2.6/drivers/scsi/libata-scsi.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/libata-scsi.c	2005-03-17 17:16:58.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-03-17 17:16:59.000000000 -0500
@@ -331,24 +331,69 @@ struct ata_queued_cmd *ata_scsi_qc_new(s
 }
 
 /**
+ *	ata_dump_status - user friendly display of error info
+ *	@id: id of the port in question
+ *	@tf: ptr to filled out taskfile
+ *
+ *	Decode and dump the ATA error/status registers for the user so
+ *	that they have some idea what really happened at the non
+ *	make-believe layer.
+ *
+ *	LOCKING:
+ *	inherited from caller
+ */
+void ata_dump_status(unsigned id, struct ata_taskfile *tf)
+{
+	u8 stat = tf->command, err = tf->feature;
+
+	printk(KERN_WARNING "ata%u: status=0x%02x { ", id, stat);
+	if (stat & ATA_BUSY) {
+		printk("Busy }\n");	/* Data is not valid in this case */
+	} else {
+		if (stat & 0x40)	printk("DriveReady ");
+		if (stat & 0x20)	printk("DeviceFault ");
+		if (stat & 0x10)	printk("SeekComplete ");
+		if (stat & 0x08)	printk("DataRequest ");
+		if (stat & 0x04)	printk("CorrectedError ");
+		if (stat & 0x02)	printk("Index ");
+		if (stat & 0x01)	printk("Error ");
+		printk("}\n");
+
+		if (err) {
+			printk(KERN_WARNING "ata%u: error=0x%02x { ", id, err);
+			if (err & 0x04)		printk("DriveStatusError ");
+			if (err & 0x80) {
+				if (err & 0x04) printk("BadCRC ");
+				else printk("Sector ");
+			}
+			if (err & 0x40)		printk("UncorrectableError ");
+			if (err & 0x10)		printk("SectorIdNotFound ");
+			if (err & 0x02)		printk("TrackZeroNotFound ");
+			if (err & 0x01)		printk("AddrMarkNotFound ");
+			printk("}\n");
+		}
+	}
+}
+
+/**
  *	ata_to_sense_error - convert ATA error to SCSI error
- *	@qc: Command that we are erroring out
  *	@drv_stat: value contained in ATA status register
+ *	@drv_err: value contained in ATA error register
+ *	@sk: the sense key we'll fill out
+ *	@asc: the additional sense code we'll fill out
+ *	@ascq: the additional sense code qualifier we'll fill out
  *
- *	Converts an ATA error into a SCSI error. While we are at it
- *	we decode and dump the ATA error for the user so that they
- *	have some idea what really happened at the non make-believe
- *	layer.
+ *	Converts an ATA error into a SCSI error.  Fill out pointers to
+ *	SK, ASC, and ASCQ bytes for later use in fixed or descriptor
+ *	format sense blocks.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
-
-void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc, 
+			u8 *ascq)
 {
-	struct scsi_cmnd *cmd = qc->scsicmd;
-	u8 err = 0;
-	unsigned char *sb = cmd->sense_buffer;
+	int i;
 	/* Based on the 3ware driver translation table */
 	static unsigned char sense_table[][4] = {
 		/* BBD|ECC|ID|MAR */
@@ -389,147 +434,99 @@ void ata_to_sense_error(struct ata_queue
 		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	  Medium error, recovered
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
-	int i = 0;
-
-	cmd->result = SAM_STAT_CHECK_CONDITION;
 
 	/*
 	 *	Is this an error we can process/parse
 	 */
-
-	if(drv_stat & ATA_ERR)
-		/* Read the err bits */
-		err = ata_chk_err(qc->ap);
-
-	/* Display the ATA level error info */
-
-	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
-	if(drv_stat & 0x80)
-	{
-		printk("Busy ");
-		err = 0;	/* Data is not valid in this case */
-	}
-	else {
-		if(drv_stat & 0x40)	printk("DriveReady ");
-		if(drv_stat & 0x20)	printk("DeviceFault ");
-		if(drv_stat & 0x10)	printk("SeekComplete ");
-		if(drv_stat & 0x08)	printk("DataRequest ");
-		if(drv_stat & 0x04)	printk("CorrectedError ");
-		if(drv_stat & 0x02)	printk("Index ");
-		if(drv_stat & 0x01)	printk("Error ");
-	}
-	printk("}\n");
-
-	if(err)
-	{
-		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
-		if(err & 0x04)		printk("DriveStatusError ");
-		if(err & 0x80)
-		{
-			if(err & 0x04)
-				printk("BadCRC ");
-			else
-				printk("Sector ");
-		}
-		if(err & 0x40)		printk("UncorrectableError ");
-		if(err & 0x10)		printk("SectorIdNotFound ");
-		if(err & 0x02)		printk("TrackZeroNotFound ");
-		if(err & 0x01)		printk("AddrMarkNotFound ");
-		printk("}\n");
-
-		/* Should we dump sector info here too ?? */
+	if (drv_stat & ATA_BUSY) {
+		drv_err = 0;	/* Ignore the err bits, they're invalid */
 	}
 
+	printk(KERN_ERR "ata%u: translating stat 0x%02x err 0x%02x to sense\n",
+	       id,drv_stat,drv_err);
 
-	/* Look for err */
-	while(sense_table[i][0] != 0xFF)
-	{
-		/* Look for best matches first */
-		if((sense_table[i][0] & err) == sense_table[i][0])
-		{
-			sb[0] = 0x70;
-			sb[2] = sense_table[i][1];
-			sb[7] = 0x0a;
-			sb[12] = sense_table[i][2];
-			sb[13] = sense_table[i][3];
-			return;
+	if (drv_err) {
+		/* Look for drv_err */
+		for (i = 0; sense_table[i][0] != 0xFF; i++) {
+			/* Look for best matches first */
+			if ((sense_table[i][0] & drv_err) == sense_table[i][0]) {
+				*sk = sense_table[i][1];
+				*asc = sense_table[i][2];
+				*ascq = sense_table[i][3];
+				return;
+			}
 		}
-		i++;
+		/* No immediate match */
+		printk(KERN_DEBUG "ata%u: no sense translation for "
+		       "error 0x%02x\n", id, drv_err);
 	}
-	/* No immediate match */
-	if(err)
-		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
 
-	i = 0;
 	/* Fall back to interpreting status bits */
-	while(stat_table[i][0] != 0xFF)
-	{
-		if(stat_table[i][0] & drv_stat)
-		{
-			sb[0] = 0x70;
-			sb[2] = stat_table[i][1];
-			sb[7] = 0x0a;
-			sb[12] = stat_table[i][2];
-			sb[13] = stat_table[i][3];
+	for (i = 0; stat_table[i][0] != 0xFF; i++) {
+		if (stat_table[i][0] & drv_stat) {
+			*sk = stat_table[i][1];
+			*asc = stat_table[i][2];
+			*ascq = stat_table[i][3];
 			return;
 		}
-		i++;
-	}
-	/* No error ?? */
-	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", qc->ap->id, drv_stat);
-	/* additional-sense-code[-qualifier] */
-
-	sb[0] = 0x70;
-	sb[2] = MEDIUM_ERROR;
-	sb[7] = 0x0A;
-	if (cmd->sc_data_direction == SCSI_DATA_READ) {
-		sb[12] = 0x11; /* "unrecovered read error" */
-		sb[13] = 0x04;
-	} else {
-		sb[12] = 0x0C; /* "write error -             */
-		sb[13] = 0x02; /*  auto-reallocation failed" */
 	}
+	/* No error?  Undecoded? */
+	printk(KERN_ERR "ata%u: no sense translation for status: 0x%02x\n", 
+	       id, drv_stat);
+
+	/* For our last chance pick, use medium read error because
+	 * it's much more common than an ATA drive telling you a write
+	 * has failed.
+	 */
+	*sk = MEDIUM_ERROR;
+	*asc = 0x11; /* "unrecovered read error" */
+	*ascq = 0x04; /*  "auto-reallocation failed" */
 }
 
 /*
- *	ata_pass_thru_cc - Generate check condition sense block.
+ *	ata_gen_ata_desc_sense - Generate check condition sense block.
  *	@qc: Command that completed.
  *
- *	Regardless of whether the command errored or not, return
- *	a sense block. Copy all controller registers into
- *	the sense block. Clear sense key, ASC & ASCQ if
- *	there is no error.
+ *	This function is specific to the ATA descriptor format sense
+ *	block specified for the ATA pass through commands.  Regardless
+ *	of whether the command errored or not, return a sense
+ *	block. Copy all controller registers into the sense
+ *	block. Clear sense key, ASC & ASCQ if there is no error.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
-void ata_pass_thru_cc(struct ata_queued_cmd *qc, u8 drv_stat)
+void ata_gen_ata_desc_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned char *sb = cmd->sense_buffer;
-	unsigned char *desc = sb + 8 ;
+	unsigned char *desc = sb + 8;
+
+	memset(sb, 0, 32);
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
 
 	/*
+	 * Read the controller registers.
+	 */
+	assert(NULL != qc->ap->ops->tf_read);
+	qc->ap->ops->tf_read(qc->ap, tf);
+
+	/*
 	 * Use ata_to_sense_error() to map status register bits
-	 * onto sense key, asc & ascq. We will overwrite some
-	 * (many) of the fields later.
-	 *
-	 * TODO: reorganise better, by splitting ata_to_sense_error()
+	 * onto sense key, asc & ascq.
 	 */
-	if (unlikely(drv_stat & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
-		ata_to_sense_error(qc, drv_stat) ;
-	} else {
-		sb[3] = sb[2] = sb[1] = 0x00 ;
+	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
+				   &sb[1], &sb[2], &sb[3]);
+		sb[1] &= 0x0f;
 	}
 
 	/*
-	 * Sense data is current and format is
-	 * descriptor.
+	 * Sense data is current and format is descriptor.
 	 */
-	sb[0] = 0x72 ;
+	sb[0] = 0x72;
 
 	desc[0] = 0x09;
 
@@ -538,35 +535,78 @@ void ata_pass_thru_cc(struct ata_queued_
 	 * Since we only populate descriptor 0, the total
 	 * length is the same (fixed) length as descriptor 0.
 	 */
-	desc[1] = sb[7] = 14 ;
-
-	/*
-	 * Read the controller registers.
-	 */
-	qc->ap->ops->tf_read(qc->ap, tf);
+	desc[1] = sb[7] = 14;
 
 	/*
 	 * Copy registers into sense buffer.
 	 */
-	desc[2] = 0x00 ;
-	desc[3] = tf->feature ;	/* Note: becomes error register when read. */
-	desc[5] = tf->nsect ;
-	desc[7] = tf->lbal ;
-	desc[9] = tf->lbam ;
-	desc[11] = tf->lbah ;
-	desc[12] = tf->device ;
-	desc[13] = drv_stat ;
+	desc[2] = 0x00;
+	desc[3] = tf->feature;	/* == error reg */
+	desc[5] = tf->nsect;
+	desc[7] = tf->lbal;
+	desc[9] = tf->lbam;
+	desc[11] = tf->lbah;
+	desc[12] = tf->device;
+	desc[13] = tf->command; /* == status reg */
 
 	/*
 	 * Fill in Extend bit, and the high order bytes
 	 * if applicable.
 	 */
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		desc[2] |= 0x01 ;
-		desc[4] = tf->hob_nsect ;
-		desc[6] = tf->hob_lbal ;
-		desc[8] = tf->hob_lbam ;
-		desc[10] = tf->hob_lbah ;
+		desc[2] |= 0x01;
+		desc[4] = tf->hob_nsect;
+		desc[6] = tf->hob_lbal;
+		desc[8] = tf->hob_lbam;
+		desc[10] = tf->hob_lbah;
+	}
+}
+
+/**
+ *	ata_gen_fixed_sense - generate a SCSI fixed sense block
+ *	@qc: Command that we are erroring out
+ *
+ *	Leverage ata_to_sense_error() to give us the codes.  Fit our
+ *	LBA in here if there's room.
+ *
+ *	LOCKING:
+ *	inherited from caller
+ */
+void ata_gen_fixed_sense(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned char *sb = cmd->sense_buffer;
+
+	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
+
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+	/*
+	 * Read the controller registers.
+	 */
+	assert(NULL != qc->ap->ops->tf_read);
+	qc->ap->ops->tf_read(qc->ap, tf);
+
+	/*
+	 * Use ata_to_sense_error() to map status register bits
+	 * onto sense key, asc & ascq.
+	 */
+	if (unlikely(tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ))) {
+		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
+				   &sb[2], &sb[12], &sb[13]);
+		sb[2] &= 0x0f;
+	}
+
+	sb[0] = 0x70;
+	sb[7] = 0x0a;
+	if (tf->flags & ATA_TFLAG_LBA && !(tf->flags & ATA_TFLAG_LBA48)) {
+		/* A small (28b) LBA will fit in the 32b info field */
+		sb[0] |= 0x80;		/* set valid bit */
+		sb[3] = tf->device & 0x0f;
+		sb[4] = tf->lbah;
+		sb[5] = tf->lbam;
+		sb[6] = tf->lbal;
 	}
 }
 
@@ -946,23 +986,35 @@ static unsigned int ata_scsi_rw_xlat(str
 static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+ 	int need_sense = drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ);
 
-	/*
-	 * If this was a pass-thru command, and the user requested
-	 * a check condition return including register values.
-	 * Note that check condition is generated, and the ATA
-	 * register values are returned, whether the command completed
-	 * successfully or not. If there was no error, SK, ASC and
-	 * ASCQ will all be zero.
+	/* For ATA pass thru (SAT) commands, generate a sense block if
+	 * user mandated it or if there's an error.  Note that if we
+	 * generate because the user forced us to, a check condition
+	 * is generated and the ATA register values are returned
+	 * whether the command completed successfully or not. If there
+	 * was no error, SK, ASC and ASCQ will all be zero.
 	 */
 	if (((cmd->cmnd[0] == ATA_16) || (cmd->cmnd[0] == ATA_12)) &&
-						(cmd->cmnd[2] & 0x20)) {
-		ata_pass_thru_cc(qc, drv_stat) ;
+ 	    ((cmd->cmnd[2] & 0x20) || need_sense)) {
+ 		ata_gen_ata_desc_sense(qc);
 	} else {
-		if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
-			ata_to_sense_error(qc, drv_stat);
-		else
+		if (!need_sense) {
 			cmd->result = SAM_STAT_GOOD;
+		} else {
+			/* TODO: decide which descriptor format to use
+			 * for 48b LBA devices and call that here
+			 * instead of the fixed desc, which is only
+			 * good for smaller LBA (and maybe CHS?)
+			 * devices.
+			 */
+			ata_gen_fixed_sense(qc);
+		}
+	}
+
+	if (need_sense) {
+		/* The ata_gen_..._sense routines fill in tf */
+		ata_dump_status(qc->ap->id, &qc->tf);
 	}
 
 	qc->scsidone(cmd);
Index: libata-dev-2.6/drivers/scsi/libata.h
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/libata.h	2005-03-17 01:33:26.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/libata.h	2005-03-17 17:16:59.000000000 -0500
@@ -45,7 +45,6 @@ extern int ata_cmd_ioctl(struct scsi_dev
 
 
 /* libata-scsi.c */
-extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);

