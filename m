Return-Path: <linux-kernel-owner+w=401wt.eu-S964860AbWL1EXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWL1EXv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 23:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWL1EXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 23:23:51 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:42244 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964860AbWL1EXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 23:23:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type;
        b=eUPdX6p1L57jFVpln5mHB2t8xrx+WPSn9G7vE4MW1PGBMmBc9nq863iM5rFg/vc50EESOzrMIiDueWNrNNF+Xj1WNsqL1wV9IxSXF8qeSHj8yLrWNOd9kOAkNxf8X1do4k/OR4ZpV2rrjSUvPfPLvzOUzdlVuTR6iA6j6CB0wL8=
Message-ID: <459346C4.1030802@gmail.com>
Date: Thu, 28 Dec 2006 13:23:32 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
References: <45841710.9040900@t-online.de> <4587F87C.2050100@gmail.com> <45883299.2050209@t-online.de> <45887CD8.5090100@gmail.com> <458AE5FB.7080607@t-online.de> <4591FE96.1080606@gmail.com>
In-Reply-To: <4591FE96.1080606@gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/mixed;
 boundary="------------050308000804050009070407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050308000804050009070407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Harald Dunkel wrote:
>> Hi Tejun,
>>
>> Tejun Heo wrote:
>>> * dmesg is truncated, please post the content of file /var/log/boot.msg.
>>>
>>> * Please post the result of 'lspci -nnvvv'
>>>
>>> * Please try the attached patch and see if it makes any difference and
>>> post the result of 'dmesg' after trying to play a problematic dvd.
>>>
>> It still doesn't work, but the dmesg output looks less
>> weird. See attachments.
>>
>>
>> Hope this helps. Please mail.
> 
> Okay, Hmmm... Weird.  I tried to reproduce it here w/ LG dvd ram and
> sil3114 (almost identical, just two more ports) with no success.  I just
> ordered SH-S183A and it should arrive later today (zero-day shipping
> just at USD 3.5!).
> 
> I'll write again when I know more.
> 

Failed to reproduce here.  Please do the following two things.

1. Post the result of "mplayer -v dvd:// > out 2>&1"

2. Apply the attached patch to v2.6.19 and report dmesg after playing dvd.

Happy new year.

-- 
tejun

--------------050308000804050009070407
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 02b2b27..cd92a70 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1139,6 +1139,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 		tmp = atapi_eh_request_sense(qc->dev,
 					     qc->scsicmd->sense_buffer);
 		if (!tmp) {
+			const u8 *c = qc->cdb;
 			/* ATA_QCFLAG_SENSE_VALID is used to tell
 			 * atapi_qc_complete() that sense data is
 			 * already valid.
@@ -1146,6 +1147,17 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 			 * TODO: interpret sense data and set
 			 * appropriate err_mask.
 			 */
+			ata_dev_printk(qc->dev, KERN_ERR,
+				       "CDB: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x "
+				       "%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x p=%d\n",
+				       c[0], c[1], c[2], c[3], c[4], c[5], c[6], c[7],
+				       c[8], c[9], c[10], c[11], c[12], c[13], c[14], c[15],
+				       qc->tf.protocol);
+			ata_dev_printk(qc->dev, KERN_ERR,
+				       "SENSE: k %02x a %02x:%02x\n",
+				       qc->scsicmd->sense_buffer[2],
+				       qc->scsicmd->sense_buffer[12],
+				       qc->scsicmd->sense_buffer[13]);
 			qc->flags |= ATA_QCFLAG_SENSE_VALID;
 		} else
 			qc->err_mask |= tmp;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 47ea111..bb8b860 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -51,7 +51,7 @@
 
 #define SECTOR_SIZE	512
 
-typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
+typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc);
 
 static struct ata_device * __ata_scsi_find_dev(struct ata_port *ap,
 					const struct scsi_device *scsidev);
@@ -951,7 +951,6 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate
  *
  *	Sets up an ATA taskfile to issue STANDBY (to stop) or READ VERIFY
  *	(to start). Perhaps these commands should be preceded by
@@ -964,22 +963,25 @@ int ata_scsi_change_queue_depth(struct scsi_device *sdev, int queue_depth)
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc,
-					     const u8 *scsicmd)
+static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
+	const u8 *cdb = scmd->cmnd;
+
+	if (scmd->cmd_len < 5)
+		goto invalid_fld;
 
 	tf->flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
 	tf->protocol = ATA_PROT_NODATA;
-	if (scsicmd[1] & 0x1) {
+	if (cdb[1] & 0x1) {
 		;	/* ignore IMMED bit, violates sat-r05 */
 	}
-	if (scsicmd[4] & 0x2)
+	if (cdb[4] & 0x2)
 		goto invalid_fld;       /* LOEJ bit set not supported */
-	if (((scsicmd[4] >> 4) & 0xf) != 0)
+	if (((cdb[4] >> 4) & 0xf) != 0)
 		goto invalid_fld;       /* power conditions not supported */
-	if (scsicmd[4] & 0x1) {
+	if (cdb[4] & 0x1) {
 		tf->nsect = 1;	/* 1 sector, lba=0 */
 
 		if (qc->dev->flags & ATA_DFLAG_LBA) {
@@ -1012,7 +1014,7 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc,
 	return 0;
 
 invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
 }
@@ -1021,7 +1023,6 @@ invalid_fld:
 /**
  *	ata_scsi_flush_xlat - Translate SCSI SYNCHRONIZE CACHE command
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate (ignored)
  *
  *	Sets up an ATA taskfile to issue FLUSH CACHE or
  *	FLUSH CACHE EXT.
@@ -1032,8 +1033,7 @@ invalid_fld:
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
 
@@ -1051,7 +1051,7 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *scs
 
 /**
  *	scsi_6_lba_len - Get LBA and transfer length
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Calculate LBA and transfer length for 6-byte commands.
  *
@@ -1059,18 +1059,17 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc, const u8 *scs
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-
-static void scsi_6_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
+static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
 	u64 lba = 0;
 	u32 len = 0;
 
 	VPRINTK("six-byte command\n");
 
-	lba |= ((u64)scsicmd[2]) << 8;
-	lba |= ((u64)scsicmd[3]);
+	lba |= ((u64)cdb[2]) << 8;
+	lba |= ((u64)cdb[3]);
 
-	len |= ((u32)scsicmd[4]);
+	len |= ((u32)cdb[4]);
 
 	*plba = lba;
 	*plen = len;
@@ -1078,7 +1077,7 @@ static void scsi_6_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
 
 /**
  *	scsi_10_lba_len - Get LBA and transfer length
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Calculate LBA and transfer length for 10-byte commands.
  *
@@ -1086,21 +1085,20 @@ static void scsi_6_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-
-static void scsi_10_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
+static void scsi_10_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
 	u64 lba = 0;
 	u32 len = 0;
 
 	VPRINTK("ten-byte command\n");
 
-	lba |= ((u64)scsicmd[2]) << 24;
-	lba |= ((u64)scsicmd[3]) << 16;
-	lba |= ((u64)scsicmd[4]) << 8;
-	lba |= ((u64)scsicmd[5]);
+	lba |= ((u64)cdb[2]) << 24;
+	lba |= ((u64)cdb[3]) << 16;
+	lba |= ((u64)cdb[4]) << 8;
+	lba |= ((u64)cdb[5]);
 
-	len |= ((u32)scsicmd[7]) << 8;
-	len |= ((u32)scsicmd[8]);
+	len |= ((u32)cdb[7]) << 8;
+	len |= ((u32)cdb[8]);
 
 	*plba = lba;
 	*plen = len;
@@ -1108,7 +1106,7 @@ static void scsi_10_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
 
 /**
  *	scsi_16_lba_len - Get LBA and transfer length
- *	@scsicmd: SCSI command to translate
+ *	@cdb: SCSI command to translate
  *
  *	Calculate LBA and transfer length for 16-byte commands.
  *
@@ -1116,27 +1114,26 @@ static void scsi_10_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
  *	@plba: the LBA
  *	@plen: the transfer length
  */
-
-static void scsi_16_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
+static void scsi_16_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
 	u64 lba = 0;
 	u32 len = 0;
 
 	VPRINTK("sixteen-byte command\n");
 
-	lba |= ((u64)scsicmd[2]) << 56;
-	lba |= ((u64)scsicmd[3]) << 48;
-	lba |= ((u64)scsicmd[4]) << 40;
-	lba |= ((u64)scsicmd[5]) << 32;
-	lba |= ((u64)scsicmd[6]) << 24;
-	lba |= ((u64)scsicmd[7]) << 16;
-	lba |= ((u64)scsicmd[8]) << 8;
-	lba |= ((u64)scsicmd[9]);
+	lba |= ((u64)cdb[2]) << 56;
+	lba |= ((u64)cdb[3]) << 48;
+	lba |= ((u64)cdb[4]) << 40;
+	lba |= ((u64)cdb[5]) << 32;
+	lba |= ((u64)cdb[6]) << 24;
+	lba |= ((u64)cdb[7]) << 16;
+	lba |= ((u64)cdb[8]) << 8;
+	lba |= ((u64)cdb[9]);
 
-	len |= ((u32)scsicmd[10]) << 24;
-	len |= ((u32)scsicmd[11]) << 16;
-	len |= ((u32)scsicmd[12]) << 8;
-	len |= ((u32)scsicmd[13]);
+	len |= ((u32)cdb[10]) << 24;
+	len |= ((u32)cdb[11]) << 16;
+	len |= ((u32)cdb[12]) << 8;
+	len |= ((u32)cdb[13]);
 
 	*plba = lba;
 	*plen = len;
@@ -1145,7 +1142,6 @@ static void scsi_16_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
 /**
  *	ata_scsi_verify_xlat - Translate SCSI VERIFY command into an ATA one
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate
  *
  *	Converts SCSI VERIFY command to an ATA READ VERIFY command.
  *
@@ -1155,23 +1151,28 @@ static void scsi_16_lba_len(const u8 *scsicmd, u64 *plba, u32 *plen)
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
 	u64 dev_sectors = qc->dev->n_sectors;
+	const u8 *cdb = scmd->cmnd;
 	u64 block;
 	u32 n_block;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
 
-	if (scsicmd[0] == VERIFY)
-		scsi_10_lba_len(scsicmd, &block, &n_block);
-	else if (scsicmd[0] == VERIFY_16)
-		scsi_16_lba_len(scsicmd, &block, &n_block);
-	else
+	if (cdb[0] == VERIFY) {
+		if (scmd->cmd_len < 10)
+			goto invalid_fld;
+		scsi_10_lba_len(cdb, &block, &n_block);
+	} else if (cdb[0] == VERIFY_16) {
+		if (scmd->cmd_len < 16)
+			goto invalid_fld;
+		scsi_16_lba_len(cdb, &block, &n_block);
+	} else
 		goto invalid_fld;
 
 	if (!n_block)
@@ -1246,24 +1247,23 @@ static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, const u8 *sc
 	return 0;
 
 invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
 
 out_of_range:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x21, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x21, 0x0);
 	/* "Logical Block Address out of range" */
 	return 1;
 
 nothing_to_do:
-	qc->scsicmd->result = SAM_STAT_GOOD;
+	scmd->result = SAM_STAT_GOOD;
 	return 1;
 }
 
 /**
  *	ata_scsi_rw_xlat - Translate SCSI r/w command into an ATA one
  *	@qc: Storage for translated ATA taskfile
- *	@scsicmd: SCSI command to translate
  *
  *	Converts any of six SCSI read/write commands into the
  *	ATA counterpart, including starting sector (LBA),
@@ -1279,9 +1279,10 @@ nothing_to_do:
  *	RETURNS:
  *	Zero on success, non-zero on error.
  */
-
-static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc)
 {
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	const u8 *cdb = scmd->cmnd;
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
 	u64 block;
@@ -1290,21 +1291,24 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicm
 	qc->flags |= ATA_QCFLAG_IO;
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 
-	if (scsicmd[0] == WRITE_10 || scsicmd[0] == WRITE_6 ||
-	    scsicmd[0] == WRITE_16)
+	if (cdb[0] == WRITE_10 || cdb[0] == WRITE_6 || cdb[0] == WRITE_16)
 		tf->flags |= ATA_TFLAG_WRITE;
 
 	/* Calculate the SCSI LBA, transfer length and FUA. */
-	switch (scsicmd[0]) {
+	switch (cdb[0]) {
 	case READ_10:
 	case WRITE_10:
-		scsi_10_lba_len(scsicmd, &block, &n_block);
-		if (unlikely(scsicmd[1] & (1 << 3)))
+		if (unlikely(scmd->cmd_len < 10))
+			goto invalid_fld;
+		scsi_10_lba_len(cdb, &block, &n_block);
+		if (unlikely(cdb[1] & (1 << 3)))
 			tf->flags |= ATA_TFLAG_FUA;
 		break;
 	case READ_6:
 	case WRITE_6:
-		scsi_6_lba_len(scsicmd, &block, &n_block);
+		if (unlikely(scmd->cmd_len < 6))
+			goto invalid_fld;
+		scsi_6_lba_len(cdb, &block, &n_block);
 
 		/* for 6-byte r/w commands, transfer length 0
 		 * means 256 blocks of data, not 0 block.
@@ -1314,8 +1318,10 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicm
 		break;
 	case READ_16:
 	case WRITE_16:
-		scsi_16_lba_len(scsicmd, &block, &n_block);
-		if (unlikely(scsicmd[1] & (1 << 3)))
+		if (unlikely(scmd->cmd_len < 16))
+			goto invalid_fld;
+		scsi_16_lba_len(cdb, &block, &n_block);
+		if (unlikely(cdb[1] & (1 << 3)))
 			tf->flags |= ATA_TFLAG_FUA;
 		break;
 	default:
@@ -1435,17 +1441,17 @@ static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, const u8 *scsicm
 	return 0;
 
 invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x0);
 	/* "Invalid field in cbd" */
 	return 1;
 
 out_of_range:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x21, 0x0);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x21, 0x0);
 	/* "Logical Block Address out of range" */
 	return 1;
 
 nothing_to_do:
-	qc->scsicmd->result = SAM_STAT_GOOD;
+	scmd->result = SAM_STAT_GOOD;
 	return 1;
 }
 
@@ -1565,7 +1571,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      ata_xlat_func_t xlat_func)
 {
 	struct ata_queued_cmd *qc;
-	u8 *scsicmd = cmd->cmnd;
 	int is_io = xlat_func == ata_scsi_rw_xlat;
 
 	VPRINTK("ENTER\n");
@@ -1597,7 +1602,7 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
 
 	qc->complete_fn = ata_scsi_qc_complete;
 
-	if (xlat_func(qc, scsicmd))
+	if (xlat_func(qc))
 		goto early_finish;
 
 	/* select device, send command to hardware */
@@ -2462,7 +2467,6 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 /**
  *	atapi_xlat - Initialize PACKET taskfile
  *	@qc: command structure to be initialized
- *	@scsicmd: SCSI CDB associated with this PACKET command
  *
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
@@ -2470,25 +2474,25 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	Zero on success, non-zero on failure.
  */
-
-static unsigned int atapi_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 {
-	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
 	int using_pio = (dev->flags & ATA_DFLAG_PIO);
-	int nodata = (cmd->sc_data_direction == DMA_NONE);
+	int nodata = (scmd->sc_data_direction == DMA_NONE);
 
 	if (!using_pio)
 		/* Check whether ATAPI DMA is safe */
 		if (ata_check_atapi_dma(qc))
 			using_pio = 1;
 
-	memcpy(&qc->cdb, scsicmd, dev->cdb_len);
+	memset(qc->cdb, 0, dev->cdb_len);
+	memcpy(qc->cdb, scmd->cmnd, scmd->cmd_len);
 
 	qc->complete_fn = atapi_qc_complete;
 
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
+	if (scmd->sc_data_direction == DMA_TO_DEVICE) {
 		qc->tf.flags |= ATA_TFLAG_WRITE;
 		DPRINTK("direction: write\n");
 	}
@@ -2510,12 +2514,12 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc, const u8 *scsicmd)
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
-		if (atapi_dmadir && (cmd->sc_data_direction != DMA_TO_DEVICE))
+		if (atapi_dmadir && (scmd->sc_data_direction != DMA_TO_DEVICE))
 			/* some SATA bridges need us to indicate data xfer direction */
 			qc->tf.feature |= ATAPI_DMADIR;
 	}
 
-	qc->nbytes = cmd->request_bufflen;
+	qc->nbytes = scmd->request_bufflen;
 
 	return 0;
 }
@@ -2635,28 +2639,27 @@ ata_scsi_map_proto(u8 byte1)
 /**
  *	ata_scsi_pass_thru - convert ATA pass-thru CDB to taskfile
  *	@qc: command structure to be initialized
- *	@scsicmd: SCSI command to convert
  *
  *	Handles either 12 or 16-byte versions of the CDB.
  *
  *	RETURNS:
  *	Zero on success, non-zero on failure.
  */
-static unsigned int
-ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
+static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &(qc->tf);
-	struct scsi_cmnd *cmd = qc->scsicmd;
+	struct scsi_cmnd *scmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
+	const u8 *cdb = scmd->cmnd;
 
-	if ((tf->protocol = ata_scsi_map_proto(scsicmd[1])) == ATA_PROT_UNKNOWN)
+	if ((tf->protocol = ata_scsi_map_proto(cdb[1])) == ATA_PROT_UNKNOWN)
 		goto invalid_fld;
 
 	/* We may not issue DMA commands if no DMA mode is set */
 	if (tf->protocol == ATA_PROT_DMA && dev->dma_mode == 0)
 		goto invalid_fld;
 
-	if (scsicmd[1] & 0xe0)
+	if (cdb[1] & 0xe0)
 		/* PIO multi not supported yet */
 		goto invalid_fld;
 
@@ -2664,18 +2667,18 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	 * 12 and 16 byte CDBs use different offsets to
 	 * provide the various register values.
 	 */
-	if (scsicmd[0] == ATA_16) {
+	if (cdb[0] == ATA_16) {
 		/*
 		 * 16-byte CDB - may contain extended commands.
 		 *
 		 * If that is the case, copy the upper byte register values.
 		 */
-		if (scsicmd[1] & 0x01) {
-			tf->hob_feature = scsicmd[3];
-			tf->hob_nsect = scsicmd[5];
-			tf->hob_lbal = scsicmd[7];
-			tf->hob_lbam = scsicmd[9];
-			tf->hob_lbah = scsicmd[11];
+		if (cdb[1] & 0x01) {
+			tf->hob_feature = cdb[3];
+			tf->hob_nsect = cdb[5];
+			tf->hob_lbal = cdb[7];
+			tf->hob_lbam = cdb[9];
+			tf->hob_lbah = cdb[11];
 			tf->flags |= ATA_TFLAG_LBA48;
 		} else
 			tf->flags &= ~ATA_TFLAG_LBA48;
@@ -2683,26 +2686,26 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 		/*
 		 * Always copy low byte, device and command registers.
 		 */
-		tf->feature = scsicmd[4];
-		tf->nsect = scsicmd[6];
-		tf->lbal = scsicmd[8];
-		tf->lbam = scsicmd[10];
-		tf->lbah = scsicmd[12];
-		tf->device = scsicmd[13];
-		tf->command = scsicmd[14];
+		tf->feature = cdb[4];
+		tf->nsect = cdb[6];
+		tf->lbal = cdb[8];
+		tf->lbam = cdb[10];
+		tf->lbah = cdb[12];
+		tf->device = cdb[13];
+		tf->command = cdb[14];
 	} else {
 		/*
 		 * 12-byte CDB - incapable of extended commands.
 		 */
 		tf->flags &= ~ATA_TFLAG_LBA48;
 
-		tf->feature = scsicmd[3];
-		tf->nsect = scsicmd[4];
-		tf->lbal = scsicmd[5];
-		tf->lbam = scsicmd[6];
-		tf->lbah = scsicmd[7];
-		tf->device = scsicmd[8];
-		tf->command = scsicmd[9];
+		tf->feature = cdb[3];
+		tf->nsect = cdb[4];
+		tf->lbal = cdb[5];
+		tf->lbam = cdb[6];
+		tf->lbah = cdb[7];
+		tf->device = cdb[8];
+		tf->command = cdb[9];
 	}
 	/*
 	 * If slave is possible, enforce correct master/slave bit
@@ -2729,7 +2732,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	 */
 	tf->flags |= (ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE);
 
-	if (cmd->sc_data_direction == DMA_TO_DEVICE)
+	if (scmd->sc_data_direction == DMA_TO_DEVICE)
 		tf->flags |= ATA_TFLAG_WRITE;
 
 	/*
@@ -2738,7 +2741,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	 * TODO: find out if we need to do more here to
 	 *       cover scatter/gather case.
 	 */
-	qc->nsect = cmd->request_bufflen / ATA_SECT_SIZE;
+	qc->nsect = scmd->request_bufflen / ATA_SECT_SIZE;
 
 	/* request result TF */
 	qc->flags |= ATA_QCFLAG_RESULT_TF;
@@ -2746,7 +2749,7 @@ ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
 	return 0;
 
  invalid_fld:
-	ata_scsi_set_sense(qc->scsicmd, ILLEGAL_REQUEST, 0x24, 0x00);
+	ata_scsi_set_sense(scmd, ILLEGAL_REQUEST, 0x24, 0x00);
 	/* "Invalid field in cdb" */
 	return 1;
 }
@@ -2819,22 +2822,29 @@ static inline void ata_scsi_dump_cdb(struct ata_port *ap,
 #endif
 }
 
-static inline int __ata_scsi_queuecmd(struct scsi_cmnd *cmd,
+static inline int __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 				      void (*done)(struct scsi_cmnd *),
 				      struct ata_device *dev)
 {
 	int rc = 0;
 
+	if (unlikely(!scmd->cmd_len)) {
+		ata_dev_printk(dev, KERN_WARNING, "WARNING: zero len CDB\n");
+		scmd->result = DID_ERROR << 16;
+		done(scmd);
+		return 0;
+	}
+
 	if (dev->class == ATA_DEV_ATA) {
 		ata_xlat_func_t xlat_func = ata_get_xlat_func(dev,
-							      cmd->cmnd[0]);
+							      scmd->cmnd[0]);
 
 		if (xlat_func)
-			rc = ata_scsi_translate(dev, cmd, done, xlat_func);
+			rc = ata_scsi_translate(dev, scmd, done, xlat_func);
 		else
-			ata_scsi_simulate(dev, cmd, done);
+			ata_scsi_simulate(dev, scmd, done);
 	} else
-		rc = ata_scsi_translate(dev, cmd, done, atapi_xlat);
+		rc = ata_scsi_translate(dev, scmd, done, atapi_xlat);
 
 	return rc;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index abd2deb..7a4cf9e 100644

--------------050308000804050009070407--
