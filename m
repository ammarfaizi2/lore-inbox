Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVKETvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVKETvV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 14:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVKETvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 14:51:21 -0500
Received: from havoc.gtf.org ([69.61.125.42]:15531 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932309AbVKETvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 14:51:20 -0500
Date: Sat, 5 Nov 2005 14:51:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x libata fix
Message-ID: <20051105195119.GA1039@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following fix:

 drivers/scsi/libata-core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

Tejun Heo:
      [libata] restore sg on DMA mapping failure

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e1346cd..1c1a7ca 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2622,8 +2622,11 @@ static int ata_sg_setup_one(struct ata_q
 
 	dma_address = dma_map_single(ap->host_set->dev, qc->buf_virt,
 				     sg->length, dir);
-	if (dma_mapping_error(dma_address))
+	if (dma_mapping_error(dma_address)) {
+		/* restore sg */
+		sg->length += qc->pad_len;
 		return -1;
+	}
 
 	sg_dma_address(sg) = dma_address;
 	sg_dma_len(sg) = sg->length;
@@ -2694,8 +2697,11 @@ static int ata_sg_setup(struct ata_queue
 
 	dir = qc->dma_dir;
 	n_elem = dma_map_sg(ap->host_set->dev, sg, qc->n_elem, dir);
-	if (n_elem < 1)
+	if (n_elem < 1) {
+		/* restore last sg */
+		lsg->length += qc->pad_len;
 		return -1;
+	}
 
 	DPRINTK("%d sg elements mapped\n", n_elem);
 
