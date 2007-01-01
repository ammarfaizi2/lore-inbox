Return-Path: <linux-kernel-owner+w=401wt.eu-S1751301AbXAATA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbXAATA4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbXAATA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:00:56 -0500
Received: from aun.it.uu.se ([130.238.12.36]:37019 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866AbXAATAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:00:55 -0500
Date: Mon, 1 Jan 2007 20:00:08 +0100 (MET)
Message-Id: <200701011900.l01J08qF005615@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jgarzik@pobox.com
Subject: Re: [PATCH] preliminary sata_promise ATAPI support
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2006 18:37:18 +0100 (MET), Mikael Pettersson wrote:
>This patch against 2.6.20-rc2 adds partial ATAPI support to
>the sata_promise driver. This patch is preliminary and for
>review only.
...
>As to why CD-writing fails with DMA enabled, I suspect that I
>either need to blacklist specific packet commands from using
>DMA, or ...

That was it: ->check_atapi_dma() needs to inspect the packet
command and only enable DMA for bulk data transfers. With this
change sata_promise successfully both reads and writes CDs.

The rules for which commands should use DMA are taken from
Promise's drivers. I missed this filter originally because it
is located in their high-level Linux glue driver while I was
mostly studying their low-level hardware driver. The filter matches
the corresponding code in pata_pdc2027x.c, with the exception
of an additional no-DMA restriction for WRITE_10 with large LBA.

The patch below goes on top of the first preliminary patch.

/Mikael

--- linux-2.6.20-rc3/drivers/ata/sata_promise.c.~1~	2007-01-01 17:13:05.000000000 +0100
+++ linux-2.6.20-rc3/drivers/ata/sata_promise.c	2007-01-01 19:14:00.000000000 +0100
@@ -39,6 +39,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/device.h>
+#include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
@@ -430,16 +431,10 @@ static void pdc_qc_prep(struct ata_queue
 		qc->tf.protocol = ATA_PROT_DMA;
 		pdc_pkt_header(&qc->tf, qc->ap->prd_dma, qc->dev->devno, pp->pkt);
 		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
-		if (qc->dev->cdb_len & ~0x1E) { /* 2/4/6/8/10/12/14/16 are Ok */
-			printk(KERN_ERR "%s: bad cdb_len %u\n", __FUNCTION__, qc->dev->cdb_len);
-			BUG();
-		}
+		/* we can represent cdb lengths 2/4/6/8/10/12/14/16 */
+		BUG_ON(qc->dev->cdb_len & ~0x1E);
 		pp->pkt[12] = (((qc->dev->cdb_len >> 1) & 7) << 5) | 0x00 | 0x08;
 		memcpy(pp->pkt+13, qc->cdb, qc->dev->cdb_len);
-#if 0
-		/* pdc-ultra/cam/cam_ata.c will pad SG length to a multiple
-		   of 4 here, but libata has already done that for us */
-#endif
 		break;
 
 	default:
@@ -788,7 +783,29 @@ static void pdc_exec_command_mmio(struct
 
 static int pdc_check_atapi_dma(struct ata_queued_cmd *qc)
 {
-	return 0;	/* ATAPI DMA is supported */
+	u8 *scsicmd = qc->scsicmd->cmnd;
+	int pio = 1; /* atapi dma off by default */
+
+	/* Whitelist commands that may use DMA. */
+	switch (scsicmd[0]) {
+	case WRITE_12:
+	case WRITE_10:
+	case WRITE_6:
+	case READ_12:
+	case READ_10:
+	case READ_6:
+	case 0xad: /* READ_DVD_STRUCTURE */
+	case 0xbe: /* READ_CD */
+		pio = 0;
+	}
+	/* -45150 (FFFF4FA2) to -1 (FFFFFFFF) shall use PIO mode */
+	if (scsicmd[0] == WRITE_10) {
+		unsigned int lba;
+		lba = (scsicmd[2] << 24) | (scsicmd[3] << 16) | (scsicmd[4] << 8) | scsicmd[5];
+		if (lba >= 0xFFFF4FA2)
+			pio = 1;
+	}
+	return pio;
 }
 
 static void pdc_ata_setup_port(struct ata_ioports *port, unsigned long base)
