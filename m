Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVGZRDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVGZRDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVGZPra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:47:30 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:11053 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261873AbVGZPqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:46:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=Obml+0sSUDhux0dXTe02DaZLUD8GbmsiBo7z4241z8sANVJl1PCAicsp9ilei9hGzjfPEOucooPJTiBy9pq+pPkOJlVi4Yf7kXU5N9QodlVhcNpQvTLlSd6Q48S34e2/SblfhjKpSjlyJMUQ2Nm5u+ecVI802jJYrrmxgFEkBxc=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726154457.38D60C67@htj.dyndns.org>
In-Reply-To: <20050726154457.38D60C67@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 07/10] blk: add FUA support to libata
Message-ID: <20050726154457.4305D013@htj.dyndns.org>
Date: Wed, 27 Jul 2005 00:46:26 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07_blk_libata-add-fua-support.patch

	Add FUA support to libata.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |   14 +++++++++-----
 drivers/scsi/libata-scsi.c |   26 ++++++++++++++++++++++++--
 include/linux/ata.h        |    4 +++-
 include/linux/libata.h     |    1 +
 4 files changed, 37 insertions(+), 8 deletions(-)

Index: blk-fixes/drivers/scsi/libata-core.c
===================================================================
--- blk-fixes.orig/drivers/scsi/libata-core.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/libata-core.c	2005-07-27 00:44:52.000000000 +0900
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
--- blk-fixes.orig/include/linux/ata.h	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/include/linux/ata.h	2005-07-27 00:44:52.000000000 +0900
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
--- blk-fixes.orig/include/linux/libata.h	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/include/linux/libata.h	2005-07-27 00:44:52.000000000 +0900
@@ -278,6 +278,7 @@ struct ata_device {
 	u8			xfer_protocol;	/* taskfile xfer protocol */
 	u8			read_cmd;	/* opcode to use on read */
 	u8			write_cmd;	/* opcode to use on write */
+	u8			write_fua_cmd;	/* opcode to use on FUA write */
 };
 
 struct ata_port {
Index: blk-fixes/drivers/scsi/libata-scsi.c
===================================================================
--- blk-fixes.orig/drivers/scsi/libata-scsi.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/libata-scsi.c	2005-07-27 00:44:52.000000000 +0900
@@ -537,6 +537,7 @@ static unsigned int ata_scsi_rw_xlat(str
 {
 	struct ata_taskfile *tf = &qc->tf;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+	int fua = scsicmd[1] & (1 << 3);
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = qc->dev->xfer_protocol;
@@ -544,9 +545,28 @@ static unsigned int ata_scsi_rw_xlat(str
 
 	if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
 	    scsicmd[0] == READ_16) {
-		tf->command = qc->dev->read_cmd;
+		if (!fua) {
+			tf->command = qc->dev->read_cmd;
+		} else {
+			printk(KERN_WARNING
+			       "ata%u(%u): WARNING: FUA READ unsupported\n",
+			       qc->ap->id, qc->dev->devno);
+			return 1;
+		}
 	} else {
-		tf->command = qc->dev->write_cmd;
+		if (!fua) {
+			tf->command = qc->dev->write_cmd;
+		} else {
+			if (qc->dev->write_fua_cmd == 0 || !lba48) {
+				printk(KERN_WARNING
+				       "ata%u(%u): WARNING: FUA WRITE "
+				       "unsupported with the current "
+				       "protocol/addressing\n",
+				       qc->ap->id, qc->dev->devno);
+				return 1;
+			}
+			tf->command = qc->dev->write_fua_cmd;
+		}
 		tf->flags |= ATA_TFLAG_WRITE;
 	}
 
@@ -1141,10 +1161,12 @@ unsigned int ata_scsiop_mode_sense(struc
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

