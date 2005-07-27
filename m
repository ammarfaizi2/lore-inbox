Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVG0HpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVG0HpE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 03:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVG0HpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 03:45:04 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:58186 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262003AbVG0HpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 03:45:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=r1ZwmMktsHotZ8PL0i2CnEMHMryWZxGjuDpuVWuZYybo07952dhFDnTCE2NpUrcMjNftIw0mGkmaJSDt+IqIdSMgJACiqKC3V08NHhG39Y3aHyjHu2IZ1xzuM4vrS1csi24Yj9j3kpkCuBIak3pKBT3dxw6wLW1hwim93Y7tsNI=
Date: Wed, 27 Jul 2005 16:44:52 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master 07/10] blk: add FUA support to libata
Message-ID: <20050727074452.GA13665@htj.dyndns.org>
References: <20050726154457.38D60C67@htj.dyndns.org> <20050726154457.4305D013@htj.dyndns.org> <42E65D06.3050405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E65D06.3050405@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 11:55:50AM -0400, Jeff Garzik wrote:
> Tejun Heo wrote:
> >07_blk_libata-add-fua-support.patch
> >
> >	Add FUA support to libata.
> 
> NAK -- doesn't appear to take into account that read/write(6) don't 
> support FUA.
> 
> Correct me if I'm wrong.
> 
> Otherwise, looks OK.
> 

 Hello, Jeff.

 I'm sorry.  It's my bad.  Here's the corrected one.  Thanks for
pointing out.

 As this patch is the last one which modifies libata, this changes
does not affect other patches in this patchset.  Just ignoring the
original one and applying this one should suffice.

Signed-off-by: Tejun Heo <htejun@gmail.com>

Index: blk-fixes/drivers/scsi/libata-core.c
===================================================================
--- blk-fixes.orig/drivers/scsi/libata-core.c	2005-07-27 15:53:29.000000000 +0900
+++ blk-fixes/drivers/scsi/libata-core.c	2005-07-27 15:53:31.000000000 +0900
@@ -602,19 +602,21 @@ void ata_tf_from_fis(u8 *fis, struct ata
 }
 
 /**
- *	ata_prot_to_cmd - determine which read/write opcodes to use
+ *	ata_prot_to_cmd - determine which read/write/fua-write opcodes to use
  *	@protocol: ATA_PROT_xxx taskfile protocol
  *	@lba48: true is lba48 is present
  *
- *	Given necessary input, determine which read/write commands
- *	to use to transfer data.
+ *	Given necessary input, determine which read/write/fua-write
+ *	commands to use to transfer data.  Note that we only support
+ *	fua-writes on DMA LBA48 protocol.  In other cases, we simply
+ *	return 0 which is NOP.
  *
  *	LOCKING:
  *	None.
  */
 static int ata_prot_to_cmd(int protocol, int lba48)
 {
-	int rcmd = 0, wcmd = 0;
+	int rcmd = 0, wcmd = 0, wfua = 0;
 
 	switch (protocol) {
 	case ATA_PROT_PIO:
@@ -631,6 +633,7 @@ static int ata_prot_to_cmd(int protocol,
 		if (lba48) {
 			rcmd = ATA_CMD_READ_EXT;
 			wcmd = ATA_CMD_WRITE_EXT;
+			wfua = ATA_CMD_WRITE_FUA_EXT;
 		} else {
 			rcmd = ATA_CMD_READ;
 			wcmd = ATA_CMD_WRITE;
@@ -641,7 +644,7 @@ static int ata_prot_to_cmd(int protocol,
 		return -1;
 	}
 
-	return rcmd | (wcmd << 8);
+	return rcmd | (wcmd << 8) | (wfua << 16);
 }
 
 /**
@@ -674,6 +677,7 @@ static void ata_dev_set_protocol(struct 
 
 	dev->read_cmd = cmd & 0xff;
 	dev->write_cmd = (cmd >> 8) & 0xff;
+	dev->write_fua_cmd = (cmd >> 16) & 0xff;
 }
 
 static const char * xfer_mode_str[] = {
Index: blk-fixes/include/linux/ata.h
===================================================================
--- blk-fixes.orig/include/linux/ata.h	2005-07-27 15:53:29.000000000 +0900
+++ blk-fixes/include/linux/ata.h	2005-07-27 15:53:31.000000000 +0900
@@ -117,6 +117,7 @@ enum {
 	ATA_CMD_READ_EXT	= 0x25,
 	ATA_CMD_WRITE		= 0xCA,
 	ATA_CMD_WRITE_EXT	= 0x35,
+	ATA_CMD_WRITE_FUA_EXT	= 0x3D,
 	ATA_CMD_PIO_READ	= 0x20,
 	ATA_CMD_PIO_READ_EXT	= 0x24,
 	ATA_CMD_PIO_WRITE	= 0x30,
@@ -227,7 +228,8 @@ struct ata_taskfile {
 #define ata_id_is_sata(id)	((id)[93] == 0)
 #define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
 #define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
-#define ata_id_has_flush(id) ((id)[83] & (1 << 12))
+#define ata_id_has_fua(id)	((id)[84] & (1 << 6))
+#define ata_id_has_flush(id)	((id)[83] & (1 << 12))
 #define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
 #define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
 #define ata_id_has_wcache(id)	((id)[82] & (1 << 5))
Index: blk-fixes/include/linux/libata.h
===================================================================
--- blk-fixes.orig/include/linux/libata.h	2005-07-27 15:53:29.000000000 +0900
+++ blk-fixes/include/linux/libata.h	2005-07-27 15:53:31.000000000 +0900
@@ -278,6 +278,7 @@ struct ata_device {
 	u8			xfer_protocol;	/* taskfile xfer protocol */
 	u8			read_cmd;	/* opcode to use on read */
 	u8			write_cmd;	/* opcode to use on write */
+	u8			write_fua_cmd;	/* opcode to use on FUA write */
 };
 
 struct ata_port {
Index: blk-fixes/drivers/scsi/libata-scsi.c
===================================================================
--- blk-fixes.orig/drivers/scsi/libata-scsi.c	2005-07-27 15:53:29.000000000 +0900
+++ blk-fixes/drivers/scsi/libata-scsi.c	2005-07-27 16:18:45.000000000 +0900
@@ -542,12 +542,40 @@ static unsigned int ata_scsi_rw_xlat(str
 	tf->protocol = qc->dev->xfer_protocol;
 	tf->device |= ATA_LBA;
 
-	if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
-	    scsicmd[0] == READ_16) {
+	switch (scsicmd[0]) {
+	case READ_10:
+	case READ_16:
+		if (unlikely(scsicmd[1] & (1 << 3))) {
+			printk(KERN_WARNING
+			       "ata%u(%u): WARNING: FUA READ unsupported\n",
+			       qc->ap->id, qc->dev->devno);
+			return 1;
+		}
+		/* fall through */
+	case READ_6:
 		tf->command = qc->dev->read_cmd;
-	} else {
+		break;
+
+	case WRITE_10:
+	case WRITE_16:
+		if (unlikely(scsicmd[1] & (1 << 3))) {
+			if (qc->dev->write_fua_cmd == 0 || !lba48) {
+				printk(KERN_WARNING
+				       "ata%u(%u): WARNING: FUA WRITE "
+				       "unsupported with the current "
+				       "protocol/addressing\n",
+				       qc->ap->id, qc->dev->devno);
+				return 1;
+			}
+			tf->command = qc->dev->write_fua_cmd;
+			tf->flags |= ATA_TFLAG_WRITE;
+			break;
+		}
+		/* fall through */
+	case WRITE_6:
 		tf->command = qc->dev->write_cmd;
 		tf->flags |= ATA_TFLAG_WRITE;
+		break;
 	}
 
 	if (scsicmd[0] == READ_10 || scsicmd[0] == WRITE_10) {
@@ -1141,10 +1169,12 @@ unsigned int ata_scsiop_mode_sense(struc
 	if (six_byte) {
 		output_len--;
 		rbuf[0] = output_len;
+		rbuf[2] |= ata_id_has_fua(args->id) ? 1 << 4 : 0;
 	} else {
 		output_len -= 2;
 		rbuf[0] = output_len >> 8;
 		rbuf[1] = output_len;
+		rbuf[3] |= ata_id_has_fua(args->id) ? 1 << 4 : 0;
 	}
 
 	return 0;
