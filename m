Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVKQPho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVKQPho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVKQPhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:37:07 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:30071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751135AbVKQPg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:36:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=OIkKS6KQ2PfezIeg2740eMU8Y2UhMSe5mLlG8d+pjAJ4VfVubkgOCV3m8BWLirvDkf+dyMnyqIF5cHy77FWaM/wur1qMTlAAXtzFQABfG0xk7hwsL7gdXrEpx5/25oe8daBN5UAfPwKJGntrX6l0INy0NS1OCgkLkTH3M9pb5/4=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051117153509.B89B4777@htj.dyndns.org>
In-Reply-To: <20051117153509.B89B4777@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 07/10] blk: add FUA support to libata
Message-ID: <20051117153509.086EE269@htj.dyndns.org>
Date: Fri, 18 Nov 2005 00:36:46 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07_blk_libata-add-fua-support.patch

	Add FUA support to libata.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |   31 +++++++++++++++++++++++++------
 drivers/scsi/libata-scsi.c |   32 ++++++++++++++++++++++++++------
 drivers/scsi/libata.h      |    4 +++-
 include/linux/ata.h        |    6 +++++-
 include/linux/libata.h     |    3 ++-
 5 files changed, 61 insertions(+), 15 deletions(-)

Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-11-18 00:35:06.000000000 +0900
@@ -563,16 +563,28 @@ static const u8 ata_rw_cmds[] = {
 	ATA_CMD_WRITE_MULTI,
 	ATA_CMD_READ_MULTI_EXT,
 	ATA_CMD_WRITE_MULTI_EXT,
+	0,
+	0,
+	0,
+	ATA_CMD_WRITE_MULTI_FUA_EXT,
 	/* pio */
 	ATA_CMD_PIO_READ,
 	ATA_CMD_PIO_WRITE,
 	ATA_CMD_PIO_READ_EXT,
 	ATA_CMD_PIO_WRITE_EXT,
+	0,
+	0,
+	0,
+	0,
 	/* dma */
 	ATA_CMD_READ,
 	ATA_CMD_WRITE,
 	ATA_CMD_READ_EXT,
-	ATA_CMD_WRITE_EXT
+	ATA_CMD_WRITE_EXT,
+	0,
+	0,
+	0,
+	ATA_CMD_WRITE_FUA_EXT
 };
 
 /**
@@ -585,25 +597,32 @@ static const u8 ata_rw_cmds[] = {
  *	LOCKING:
  *	caller.
  */
-void ata_rwcmd_protocol(struct ata_queued_cmd *qc)
+int ata_rwcmd_protocol(struct ata_queued_cmd *qc)
 {
 	struct ata_taskfile *tf = &qc->tf;
 	struct ata_device *dev = qc->dev;
+	u8 cmd;
 
-	int index, lba48, write;
+	int index, fua, lba48, write;
  
+	fua = (tf->flags & ATA_TFLAG_FUA) ? 4 : 0;
 	lba48 = (tf->flags & ATA_TFLAG_LBA48) ? 2 : 0;
 	write = (tf->flags & ATA_TFLAG_WRITE) ? 1 : 0;
 
 	if (dev->flags & ATA_DFLAG_PIO) {
 		tf->protocol = ATA_PROT_PIO;
-		index = dev->multi_count ? 0 : 4;
+		index = dev->multi_count ? 0 : 8;
 	} else {
 		tf->protocol = ATA_PROT_DMA;
-		index = 8;
+		index = 16;
 	}
 
-	tf->command = ata_rw_cmds[index + lba48 + write];
+	cmd = ata_rw_cmds[index + fua + lba48 + write];
+	if (cmd) {
+		tf->command = cmd;
+		return 0;
+	}
+	return -1;
 }
 
 static const char * xfer_mode_str[] = {
Index: work/include/linux/ata.h
===================================================================
--- work.orig/include/linux/ata.h	2005-11-18 00:14:29.000000000 +0900
+++ work/include/linux/ata.h	2005-11-18 00:35:06.000000000 +0900
@@ -129,6 +129,7 @@ enum {
 	ATA_CMD_READ_EXT	= 0x25,
 	ATA_CMD_WRITE		= 0xCA,
 	ATA_CMD_WRITE_EXT	= 0x35,
+	ATA_CMD_WRITE_FUA_EXT	= 0x3D,
 	ATA_CMD_PIO_READ	= 0x20,
 	ATA_CMD_PIO_READ_EXT	= 0x24,
 	ATA_CMD_PIO_WRITE	= 0x30,
@@ -137,6 +138,7 @@ enum {
 	ATA_CMD_READ_MULTI_EXT	= 0x29,
 	ATA_CMD_WRITE_MULTI	= 0xC5,
 	ATA_CMD_WRITE_MULTI_EXT	= 0x39,
+	ATA_CMD_WRITE_MULTI_FUA_EXT = 0xCE,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
@@ -192,6 +194,7 @@ enum {
 	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
 	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
 	ATA_TFLAG_LBA		= (1 << 4), /* enable LBA */
+	ATA_TFLAG_FUA		= (1 << 5), /* enable FUA */
 };
 
 enum ata_tf_protocols {
@@ -245,7 +248,8 @@ struct ata_taskfile {
 #define ata_id_is_sata(id)	((id)[93] == 0)
 #define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
 #define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
-#define ata_id_has_flush(id) ((id)[83] & (1 << 12))
+#define ata_id_has_fua(id)	((id)[84] & (1 << 6))
+#define ata_id_has_flush(id)	((id)[83] & (1 << 12))
 #define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
 #define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
 #define ata_id_has_wcache(id)	((id)[82] & (1 << 5))
Index: work/drivers/scsi/libata-scsi.c
===================================================================
--- work.orig/drivers/scsi/libata-scsi.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/scsi/libata-scsi.c	2005-11-18 00:35:06.000000000 +0900
@@ -1080,11 +1080,13 @@ static unsigned int ata_scsi_rw_xlat(str
 	    scsicmd[0] == WRITE_16)
 		tf->flags |= ATA_TFLAG_WRITE;
 
-	/* Calculate the SCSI LBA and transfer length. */
+	/* Calculate the SCSI LBA, transfer length and FUA. */
 	switch (scsicmd[0]) {
 	case READ_10:
 	case WRITE_10:
 		scsi_10_lba_len(scsicmd, &block, &n_block);
+		if (unlikely(scsicmd[1] & (1 << 3)))
+			tf->flags |= ATA_TFLAG_FUA;
 		break;
 	case READ_6:
 	case WRITE_6:
@@ -1099,6 +1101,8 @@ static unsigned int ata_scsi_rw_xlat(str
 	case READ_16:
 	case WRITE_16:
 		scsi_16_lba_len(scsicmd, &block, &n_block);
+		if (unlikely(scsicmd[1] & (1 << 3)))
+			tf->flags |= ATA_TFLAG_FUA;
 		break;
 	default:
 		DPRINTK("no-byte command\n");
@@ -1142,7 +1146,8 @@ static unsigned int ata_scsi_rw_xlat(str
 			tf->device |= (block >> 24) & 0xf;
 		}
 
-		ata_rwcmd_protocol(qc);
+		if (unlikely(ata_rwcmd_protocol(qc) < 0))
+			goto invalid_fld;
 
 		qc->nsect = n_block;
 		tf->nsect = n_block & 0xff;
@@ -1160,7 +1165,8 @@ static unsigned int ata_scsi_rw_xlat(str
 		if ((block >> 28) || (n_block > 256))
 			goto out_of_range;
 
-		ata_rwcmd_protocol(qc);
+		if (unlikely(ata_rwcmd_protocol(qc) < 0))
+			goto invalid_fld;
 
 		/* Convert LBA to CHS */
 		track = (u32)block / dev->sectors;
@@ -1696,6 +1702,7 @@ static unsigned int ata_msense_rw_recove
 unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf,
 				  unsigned int buflen)
 {
+	struct ata_device *dev = args->dev;
 	u8 *scsicmd = args->cmd->cmnd, *p, *last;
 	const u8 sat_blk_desc[] = {
 		0, 0, 0, 0,	/* number of blocks: sat unspecified */
@@ -1704,6 +1711,7 @@ unsigned int ata_scsiop_mode_sense(struc
 	};
 	u8 pg, spg;
 	unsigned int ebd, page_control, six_byte, output_len, alloc_len, minlen;
+	u8 dpofua;
 
 	VPRINTK("ENTER\n");
 
@@ -1772,9 +1780,17 @@ unsigned int ata_scsiop_mode_sense(struc
 
 	if (minlen < 1)
 		return 0;
+
+	dpofua = 0;
+	if (ata_id_has_fua(args->id) && dev->flags & ATA_DFLAG_LBA48 &&
+	    (!(dev->flags & ATA_DFLAG_PIO) || dev->multi_count))
+		dpofua = 1 << 4;
+
 	if (six_byte) {
 		output_len--;
 		rbuf[0] = output_len;
+		if (minlen > 2)
+			rbuf[2] |= dpofua;
 		if (ebd) {
 			if (minlen > 3)
 				rbuf[3] = sizeof(sat_blk_desc);
@@ -1787,6 +1803,8 @@ unsigned int ata_scsiop_mode_sense(struc
 		rbuf[0] = output_len >> 8;
 		if (minlen > 1)
 			rbuf[1] = output_len;
+		if (minlen > 3)
+			rbuf[3] |= dpofua;
 		if (ebd) {
 			if (minlen > 7)
 				rbuf[7] = sizeof(sat_blk_desc);
@@ -2424,7 +2442,7 @@ int ata_scsi_queuecmd(struct scsi_cmnd *
 		if (xlat_func)
 			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
 		else
-			ata_scsi_simulate(dev->id, cmd, done);
+			ata_scsi_simulate(ap, dev, cmd, done);
 	} else
 		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
@@ -2447,14 +2465,16 @@ out_unlock:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_scsi_simulate(u16 *id,
+void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
 		      struct scsi_cmnd *cmd,
 		      void (*done)(struct scsi_cmnd *))
 {
 	struct ata_scsi_args args;
 	const u8 *scsicmd = cmd->cmnd;
 
-	args.id = id;
+	args.ap = ap;
+	args.dev = dev;
+	args.id = dev->id;
 	args.cmd = cmd;
 	args.done = done;
 
Index: work/drivers/scsi/libata.h
===================================================================
--- work.orig/drivers/scsi/libata.h	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/scsi/libata.h	2005-11-18 00:35:06.000000000 +0900
@@ -32,6 +32,8 @@
 #define DRV_VERSION	"1.12"	/* must be exactly four chars */
 
 struct ata_scsi_args {
+	struct ata_port		*ap;
+	struct ata_device	*dev;
 	u16			*id;
 	struct scsi_cmnd	*cmd;
 	void			(*done)(struct scsi_cmnd *);
@@ -42,7 +44,7 @@ extern int atapi_enabled;
 extern int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
-extern void ata_rwcmd_protocol(struct ata_queued_cmd *qc);
+extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-11-18 00:14:29.000000000 +0900
+++ work/include/linux/libata.h	2005-11-18 00:35:06.000000000 +0900
@@ -476,7 +476,8 @@ extern u8   ata_bmdma_status(struct ata_
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_qc_complete(struct ata_queued_cmd *qc, unsigned int err_mask);
 extern void ata_eng_timeout(struct ata_port *ap);
-extern void ata_scsi_simulate(u16 *id, struct scsi_cmnd *cmd,
+extern void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
+			      struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct block_device *bdev,

