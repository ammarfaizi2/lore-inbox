Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVDHTNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVDHTNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 15:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262935AbVDHTNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 15:13:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53993 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262929AbVDHTN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 15:13:27 -0400
Message-ID: <4256D7CA.7030908@pobox.com>
Date: Fri, 08 Apr 2005 15:13:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric A. Cottrell" <eac@shore.net>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: LIBATA AHCI engine timeout hang with ATAPI devices
References: <4256D1A9.6080401@shore.net>
In-Reply-To: <4256D1A9.6080401@shore.net>
Content-Type: multipart/mixed;
 boundary="------------030507070202010503020401"
X-Warning: 24.25.22.197 is listed at orbz.gst-group.uk.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030507070202010503020401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Eric A. Cottrell wrote:
> Hello,
> 
> I made the mistake of getting the Plextor SATA DVD Recorder with my new 
> system not realizing that SATA support is just coming online.  I want to 
> turn this into an opportunity to make the Plextor work.  Thanks to the 
> IDE information pages I got a good start.
> 
> I have success using the ata_piix and ahci drivers with SATA Hard 
> Drives.  I noticed that the Plextor works with the ata_piix driver  but 
> not with the AHCI driver.  The AHCI driver hangs after the INQUIRY is 
> printed.

You need something like the attached patch.

In general, ATAPI is still very much experimental at this point.  One 
known bug that affects libata is that ATAPI DMA is not aligned to a 
4-byte boundary.

	Jeff



--------------030507070202010503020401
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/17 04:43:52-05:00 jgarzik@pobox.com 
#   [libata ahci] finish ATAPI support
# 
# drivers/scsi/ahci.c
#   2005/02/17 04:42:57-05:00 jgarzik@pobox.com +9 -13
#   [libata ahci] finish ATAPI support
# 
diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-04-08 15:10:54 -04:00
+++ b/drivers/scsi/ahci.c	2005-04-08 15:10:54 -04:00
@@ -38,7 +38,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ahci"
-#define DRV_VERSION	"1.00"
+#define DRV_VERSION	"1.10"
 
 
 enum {
@@ -49,6 +49,7 @@
 	AHCI_CMD_SLOT_SZ	= 32 * 32,
 	AHCI_RX_FIS_SZ		= 256,
 	AHCI_CMD_TBL_HDR	= 0x80,
+	AHCI_CMD_TBL_CDB	= 0x40,
 	AHCI_CMD_TBL_SZ		= AHCI_CMD_TBL_HDR + (AHCI_MAX_SG * 16),
 	AHCI_PORT_PRIV_DMA_SZ	= AHCI_CMD_SLOT_SZ + AHCI_CMD_TBL_SZ +
 				  AHCI_RX_FIS_SZ,
@@ -477,7 +478,8 @@
 
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
 {
-	struct ahci_port_priv *pp = qc->ap->private_data;
+	struct ata_port *ap = qc->ap;
+	struct ahci_port_priv *pp = ap->private_data;
 	u32 opts;
 	const u32 cmd_fis_len = 5; /* five dwords */
 
@@ -489,18 +491,8 @@
 	opts = (qc->n_elem << 16) | cmd_fis_len;
 	if (qc->tf.flags & ATA_TFLAG_WRITE)
 		opts |= AHCI_CMD_WRITE;
-
-	switch (qc->tf.protocol) {
-	case ATA_PROT_ATAPI:
-	case ATA_PROT_ATAPI_NODATA:
-	case ATA_PROT_ATAPI_DMA:
+	if (is_atapi_taskfile(&qc->tf))
 		opts |= AHCI_CMD_ATAPI;
-		break;
-
-	default:
-		/* do nothing */
-		break;
-	}
 
 	pp->cmd_slot[0].opts = cpu_to_le32(opts);
 	pp->cmd_slot[0].status = 0;
@@ -512,6 +504,10 @@
 	 * a SATA Register - Host to Device command FIS.
 	 */
 	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
+	if (opts & AHCI_CMD_ATAPI) {
+		memset(pp->cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
+		memcpy(pp->cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, ap->cdb_len);
+	}
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;

--------------030507070202010503020401--
