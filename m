Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752017AbWFLO2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbWFLO2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWFLO2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:28:43 -0400
Received: from havoc.gtf.org ([69.61.125.42]:7594 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1752013AbWFLO2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:28:42 -0400
Date: Mon, 12 Jun 2006 10:26:44 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] libata fix
Message-ID: <20060612142644.GA10368@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/sata_mv.c |    3 +++
 1 file changed, 3 insertions(+)

Mark Lord:
      sata_mv: grab host lock inside eng_timeout

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 9b8bca1..f16f92a 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -2035,6 +2035,7 @@ static void mv_phy_reset(struct ata_port
 static void mv_eng_timeout(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
+	unsigned long flags;
 
 	printk(KERN_ERR "ata%u: Entering mv_eng_timeout\n",ap->id);
 	DPRINTK("All regs @ start of eng_timeout\n");
@@ -2046,8 +2047,10 @@ static void mv_eng_timeout(struct ata_po
 	       ap->host_set->mmio_base, ap, qc, qc->scsicmd,
 	       &qc->scsicmd->cmnd);
 
+	spin_lock_irqsave(&ap->host_set->lock, flags);
 	mv_err_intr(ap, 0);
 	mv_stop_and_reset(ap);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	WARN_ON(!(qc->flags & ATA_QCFLAG_ACTIVE));
 	if (qc->flags & ATA_QCFLAG_ACTIVE) {
