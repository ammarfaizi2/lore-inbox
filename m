Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUJNQdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUJNQdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 12:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266684AbUJNQdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 12:33:39 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:39366 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266756AbUJNQcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 12:32:05 -0400
Message-ID: <416EA996.4040402@rtr.ca>
Date: Thu, 14 Oct 2004 12:30:14 -0400
From: Mark Lord <lsml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
References: <4161A06D.8010601@rtr.ca> <4165B233.9080405@rtr.ca> <416D8A4E.5030106@pobox.com> <416DA951.2090104@rtr.ca> <416DAF1A.2040204@pobox.com> <416DB912.7040805@rtr.ca> <416DBC96.2090602@pobox.com>
In-Reply-To: <416DBC96.2090602@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------000902090608070209060608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000902090608070209060608
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 >Seems sane, send a patch.

Here you go.  This patch modifies libata-scsi for easier sharing
of the various ata_id_* functions and the ata_scsi_simulate()
function with non-libata drivers.

Signed-off-by: Mark Lord <mlord@pobox.com>
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

--------------000902090608070209060608
Content-Type: text/plain;
 name="libata_id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata_id.patch"

diff -u --recursive --new-file --exclude='.*' linux-2.6.9-rc4/drivers/scsi/libata-core.c linux/drivers/scsi/libata-core.c
--- linux-2.6.9-rc4/drivers/scsi/libata-core.c	2004-10-13 14:47:26.000000000 -0400
+++ linux/drivers/scsi/libata-core.c	2004-10-14 12:04:48.000000000 -0400
@@ -829,17 +829,17 @@
  *	caller.
  */
 
-void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+void ata_dev_id_string(u16 *id, unsigned char *s,
 		       unsigned int ofs, unsigned int len)
 {
 	unsigned int c;
 
 	while (len > 0) {
-		c = dev->id[ofs] >> 8;
+		c = id[ofs] >> 8;
 		*s = c;
 		s++;
 
-		c = dev->id[ofs] & 0xff;
+		c = id[ofs] & 0xff;
 		*s = c;
 		s++;
 
@@ -1082,7 +1082,7 @@
 	 */
 
 	/* we require LBA and DMA support (bits 8 & 9 of word 49) */
-	if (!ata_id_has_dma(dev) || !ata_id_has_lba(dev)) {
+	if (!ata_id_has_dma(dev->id) || !ata_id_has_lba(dev->id)) {
 		printk(KERN_DEBUG "ata%u: no dma/lba\n", ap->id);
 		goto err_out_nosup;
 	}
@@ -1100,7 +1100,7 @@
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
-		if (!ata_id_is_ata(dev))	/* sanity check */
+		if (!ata_id_is_ata(dev->id))	/* sanity check */
 			goto err_out_nosup;
 
 		tmp = dev->id[ATA_ID_MAJOR_VER];
@@ -1114,11 +1114,11 @@
 			goto err_out_nosup;
 		}
 
-		if (ata_id_has_lba48(dev)) {
+		if (ata_id_has_lba48(dev->id)) {
 			dev->flags |= ATA_DFLAG_LBA48;
-			dev->n_sectors = ata_id_u64(dev, 100);
+			dev->n_sectors = ata_id_u64(dev->id, 100);
 		} else {
-			dev->n_sectors = ata_id_u32(dev, 60);
+			dev->n_sectors = ata_id_u32(dev->id, 60);
 		}
 
 		ap->host->max_cmd_len = 16;
@@ -1133,7 +1133,7 @@
 
 	/* ATAPI-specific feature tests */
 	else {
-		if (ata_id_is_ata(dev))		/* sanity check */
+		if (ata_id_is_ata(dev->id))		/* sanity check */
 			goto err_out_nosup;
 
 		rc = atapi_cdb_len(dev->id);
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-rc4/drivers/scsi/libata.h linux/drivers/scsi/libata.h
--- linux-2.6.9-rc4/drivers/scsi/libata.h	2004-10-13 14:47:26.000000000 -0400
+++ linux/drivers/scsi/libata.h	2004-10-14 11:48:35.000000000 -0400
@@ -29,9 +29,8 @@
 #define DRV_VERSION	"1.02"	/* must be exactly four chars */
 
 struct ata_scsi_args {
-	struct ata_port		*ap;
-	struct ata_device	*dev;
-	struct scsi_cmnd		*cmd;
+	u16			*id;
+	struct scsi_cmnd	*cmd;
 	void			(*done)(struct scsi_cmnd *);
 };
 
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-rc4/drivers/scsi/libata-scsi.c linux/drivers/scsi/libata-scsi.c
--- linux-2.6.9-rc4/drivers/scsi/libata-scsi.c	2004-10-13 14:47:26.000000000 -0400
+++ linux/drivers/scsi/libata-scsi.c	2004-10-14 12:06:49.000000000 -0400
@@ -34,7 +34,7 @@
 #include "libata.h"
 
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, u8 *scsicmd);
-static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
+static void ata_scsi_simulate(u16 *id,
 			      struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
 static struct ata_device *
@@ -411,7 +411,7 @@
 	tf->protocol = ATA_PROT_NODATA;
 
 	if ((tf->flags & ATA_TFLAG_LBA48) &&
-	    (ata_id_has_flush_ext(qc->dev)))
+	    (ata_id_has_flush_ext(qc->dev->id)))
 		tf->command = ATA_CMD_FLUSH_EXT;
 	else
 		tf->command = ATA_CMD_FLUSH;
@@ -758,7 +758,7 @@
 
 /**
  *	ata_scsi_rbuf_fill - wrapper for SCSI command simulators
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@actor: Callback hook for desired SCSI command simulator
  *
  *	Takes care of the hard work of simulating a SCSI command...
@@ -793,7 +793,7 @@
 
 /**
  *	ata_scsiop_inq_std - Simulate INQUIRY command
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -807,8 +807,6 @@
 unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen)
 {
-	struct ata_device *dev = args->dev;
-
 	u8 hdr[] = {
 		TYPE_DISK,
 		0,
@@ -818,7 +816,7 @@
 	};
 
 	/* set scsi removeable (RMB) bit per ata bit */
-	if (ata_id_removeable(dev))
+	if (ata_id_removeable(args->id))
 		hdr[1] |= (1 << 7);
 
 	VPRINTK("ENTER\n");
@@ -827,8 +825,8 @@
 
 	if (buflen > 35) {
 		memcpy(&rbuf[8], "ATA     ", 8);
-		ata_dev_id_string(dev, &rbuf[16], ATA_ID_PROD_OFS, 16);
-		ata_dev_id_string(dev, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
+		ata_dev_id_string(args->id, &rbuf[16], ATA_ID_PROD_OFS, 16);
+		ata_dev_id_string(args->id, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
 		if (rbuf[32] == 0 || rbuf[32] == ' ')
 			memcpy(&rbuf[32], "n/a ", 4);
 	}
@@ -852,7 +850,7 @@
 
 /**
  *	ata_scsiop_inq_00 - Simulate INQUIRY EVPD page 0, list of pages
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -880,7 +878,7 @@
 
 /**
  *	ata_scsiop_inq_80 - Simulate INQUIRY EVPD page 80, device serial number
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -902,7 +900,7 @@
 	memcpy(rbuf, hdr, sizeof(hdr));
 
 	if (buflen > (ATA_SERNO_LEN + 4))
-		ata_dev_id_string(args->dev, (unsigned char *) &rbuf[4],
+		ata_dev_id_string(args->id, (unsigned char *) &rbuf[4],
 				  ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
 
 	return 0;
@@ -912,7 +910,7 @@
 
 /**
  *	ata_scsiop_inq_83 - Simulate INQUIRY EVPD page 83, device identity
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -941,7 +939,7 @@
 
 /**
  *	ata_scsiop_noop -
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -989,7 +987,7 @@
 
 /**
  *	ata_msense_caching - Simulate MODE SENSE caching info page
- *	@dev: Device associated with this MODE SENSE command
+ *	@id: device IDENTIFY data
  *	@ptr_io: (input/output) Location to store more output data
  *	@last: End of output data buffer
  *
@@ -1001,7 +999,7 @@
  *	None.
  */
 
-static unsigned int ata_msense_caching(struct ata_device *dev, u8 **ptr_io,
+static unsigned int ata_msense_caching(u16 *id, u8 **ptr_io,
 				       const u8 *last)
 {
 	u8 page[] = {
@@ -1011,9 +1009,9 @@
 		0, 0, 0, 0, 0, 0, 0, 0		/* 8 zeroes */
 	};
 
-	if (ata_id_wcache_enabled(dev))
+	if (ata_id_wcache_enabled(id))
 		page[2] |= (1 << 2);	/* write cache enable */
-	if (!ata_id_rahead_enabled(dev))
+	if (!ata_id_rahead_enabled(id))
 		page[12] |= (1 << 5);	/* disable read ahead */
 
 	ata_msense_push(ptr_io, last, page, sizeof(page));
@@ -1067,7 +1065,7 @@
 
 /**
  *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1081,7 +1079,6 @@
 				  unsigned int buflen)
 {
 	u8 *scsicmd = args->cmd->cmnd, *p, *last;
-	struct ata_device *dev = args->dev;
 	unsigned int page_control, six_byte, output_len;
 
 	VPRINTK("ENTER\n");
@@ -1109,7 +1106,7 @@
 		break;
 
 	case 0x08:		/* caching */
-		output_len += ata_msense_caching(dev, &p, last);
+		output_len += ata_msense_caching(args->id, &p, last);
 		break;
 
 	case 0x0a: {		/* control mode */
@@ -1119,7 +1116,7 @@
 
 	case 0x3f:		/* all pages */
 		output_len += ata_msense_rw_recovery(&p, last);
-		output_len += ata_msense_caching(dev, &p, last);
+		output_len += ata_msense_caching(args->id, &p, last);
 		output_len += ata_msense_ctl_mode(&p, last);
 		break;
 
@@ -1141,7 +1138,7 @@
 
 /**
  *	ata_scsiop_read_cap - Simulate READ CAPACITY[ 16] commands
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1154,11 +1151,15 @@
 unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf,
 			        unsigned int buflen)
 {
-	u64 n_sectors = args->dev->n_sectors;
+	u64 n_sectors;
 	u32 tmp;
 
 	VPRINTK("ENTER\n");
 
+	if (ata_id_has_lba48(args->id))
+		n_sectors = ata_id_u64(args->id, 100);
+	else
+		n_sectors = ata_id_u32(args->id, 60);
 	n_sectors--;		/* ATA TotalUserSectors - 1 */
 
 	tmp = n_sectors;	/* note: truncates, if lba48 */
@@ -1196,7 +1197,7 @@
 
 /**
  *	ata_scsiop_report_luns - Simulate REPORT LUNS command
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1472,7 +1473,7 @@
 		if (xlat_func)
 			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
 		else
-			ata_scsi_simulate(ap, dev, cmd, done);
+			ata_scsi_simulate(dev->id, cmd, done);
 	} else
 		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
@@ -1482,8 +1483,7 @@
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@ap: Port to which ATA device is attached.
- *	@dev: Target device for CDB.
+ *	@id: current IDENTIFY data for target device.
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
  *
@@ -1494,15 +1494,14 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
+static void ata_scsi_simulate(u16 *id,
 			      struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *))
 {
 	struct ata_scsi_args args;
 	u8 *scsicmd = cmd->cmnd;
 
-	args.ap = ap;
-	args.dev = dev;
+	args.id = id;
 	args.cmd = cmd;
 	args.done = done;
 
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-rc4/drivers/scsi/sata_sil.c linux/drivers/scsi/sata_sil.c
--- linux-2.6.9-rc4/drivers/scsi/sata_sil.c	2004-10-13 14:47:26.000000000 -0400
+++ linux/drivers/scsi/sata_sil.c	2004-10-14 12:05:23.000000000 -0400
@@ -287,7 +287,7 @@
 	const char *s;
 	unsigned int len;
 
-	ata_dev_id_string(dev, model_num, ATA_ID_PROD_OFS,
+	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
 			  sizeof(model_num));
 	s = &model_num[0];
 	len = strnlen(s, sizeof(model_num));
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-rc4/include/linux/ata.h linux/include/linux/ata.h
--- linux-2.6.9-rc4/include/linux/ata.h	2004-10-13 14:47:31.000000000 -0400
+++ linux/include/linux/ata.h	2004-10-14 11:51:26.000000000 -0400
@@ -217,24 +217,24 @@
 	u8			command;	/* IO operation */
 };
 
-#define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
-#define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
-#define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
-#define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))
-#define ata_id_has_flush_ext(dev) ((dev)->id[83] & (1 << 13))
-#define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
-#define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
-#define ata_id_has_pm(dev)	((dev)->id[82] & (1 << 3))
-#define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 9))
-#define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 8))
-#define ata_id_removeable(dev)	((dev)->id[0] & (1 << 7))
-#define ata_id_u32(dev,n)	\
-	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))
-#define ata_id_u64(dev,n)	\
-	( ((u64) dev->id[(n) + 3] << 48) |	\
-	  ((u64) dev->id[(n) + 2] << 32) |	\
-	  ((u64) dev->id[(n) + 1] << 16) |	\
-	  ((u64) dev->id[(n) + 0]) )
+#define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
+#define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
+#define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
+#define ata_id_has_flush(id) ((id)[83] & (1 << 12))
+#define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
+#define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
+#define ata_id_has_wcache(id)	((id)[82] & (1 << 5))
+#define ata_id_has_pm(id)	((id)[82] & (1 << 3))
+#define ata_id_has_lba(id)	((id)[49] & (1 << 9))
+#define ata_id_has_dma(id)	((id)[49] & (1 << 8))
+#define ata_id_removeable(id)	((id)[0] & (1 << 7))
+#define ata_id_u32(id,n)	\
+	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
+#define ata_id_u64(id,n)	\
+	( ((u64) (id)[(n) + 3] << 48) |	\
+	  ((u64) (id)[(n) + 2] << 32) |	\
+	  ((u64) (id)[(n) + 1] << 16) |	\
+	  ((u64) (id)[(n) + 0]) )
 
 static inline int atapi_cdb_len(u16 *dev_id)
 {
diff -u --recursive --new-file --exclude='.*' linux-2.6.9-rc4/include/linux/libata.h linux/include/linux/libata.h
--- linux-2.6.9-rc4/include/linux/libata.h	2004-10-13 14:47:31.000000000 -0400
+++ linux/include/linux/libata.h	2004-10-14 12:05:52.000000000 -0400
@@ -403,7 +403,7 @@
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
 extern unsigned int ata_dev_classify(struct ata_taskfile *tf);
-extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+extern void ata_dev_id_string(u16 *id, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
@@ -613,9 +613,9 @@
 
 static inline int ata_try_flush_cache(struct ata_device *dev)
 {
-	return ata_id_wcache_enabled(dev) ||
-	       ata_id_has_flush(dev) ||
-	       ata_id_has_flush_ext(dev);
+	return ata_id_wcache_enabled(dev->id) ||
+	       ata_id_has_flush(dev->id) ||
+	       ata_id_has_flush_ext(dev->id);
 }
 
 #endif /* __LINUX_LIBATA_H__ */

--------------000902090608070209060608--
