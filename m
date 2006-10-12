Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWJLBoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWJLBoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWJLBoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:44:10 -0400
Received: from havoc.gtf.org ([69.61.125.42]:64991 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932490AbWJLBoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:44:09 -0400
Date: Wed, 11 Oct 2006 21:44:08 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] SCSI/aha1740: handle SCSI API errors
Message-ID: <20061012014408.GA12771@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/scsi/aha1740.c          |   10 ++++++-

diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index c3c38a7..d7af9c6 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -586,7 +586,7 @@ static struct scsi_host_template aha1740
 
 static int aha1740_probe (struct device *dev)
 {
-	int slotbase;
+	int slotbase, rc;
 	unsigned int irq_level, irq_type, translation;
 	struct Scsi_Host *shpnt;
 	struct aha1740_hostdata *host;
@@ -641,10 +641,16 @@ static int aha1740_probe (struct device 
 	}
 
 	eisa_set_drvdata (edev, shpnt);
-	scsi_add_host (shpnt, dev); /* XXX handle failure */
+
+	rc = scsi_add_host (shpnt, dev);
+	if (rc)
+		goto err_irq;
+
 	scsi_scan_host (shpnt);
 	return 0;
 
+ err_irq:
+ 	free_irq(irq_level, shpnt);
  err_unmap:
 	dma_unmap_single (&edev->dev, host->ecb_dma_addr,
 			  sizeof (host->ecb), DMA_BIDIRECTIONAL);
