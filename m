Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWCaPWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWCaPWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 10:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067AbWCaPWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 10:22:50 -0500
Received: from havoc.gtf.org ([69.61.125.42]:5249 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751386AbWCaPWs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 10:22:48 -0500
Date: Fri, 31 Mar 2006 10:22:44 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20060331152244.GA22806@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/ahci.c        |    4 ++++
 drivers/scsi/ata_piix.c    |    4 ++--
 drivers/scsi/libata-core.c |   28 +++++++++++++---------------
 drivers/scsi/libata-scsi.c |    8 ++------
 drivers/scsi/libata.h      |    2 +-
 5 files changed, 22 insertions(+), 24 deletions(-)

Jeff Garzik:
      [libata] ahci: add ATI SB600 PCI IDs

Tejun Heo:
      ata_piix: fix ich6/m_map_db
      libata: fix ata_qc_issue failure path
      libata: make ata_qc_issue complete failed qcs
      libata: fix ata_xfer_tbl termination

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index ffba656..1bd82c4 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -293,6 +293,10 @@ static const struct pci_device_id ahci_p
 	  board_ahci }, /* JMicron JMB360 */
 	{ 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* JMicron JMB363 */
+	{ PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ATI SB600 non-raid */
+	{ PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ATI SB600 raid */
 	{ }	/* terminate list */
 };
 
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 2d5be84..24e71b5 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -301,7 +301,7 @@ static struct piix_map_db ich6_map_db = 
 	.mask = 0x3,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
-		{  P0,  P1,  P2,  P3 }, /* 00b */
+		{  P0,  P2,  P1,  P3 }, /* 00b */
 		{ IDE, IDE,  P1,  P3 }, /* 01b */
 		{  P0,  P2, IDE, IDE }, /* 10b */
 		{  RV,  RV,  RV,  RV },
@@ -312,7 +312,7 @@ static struct piix_map_db ich6m_map_db =
 	.mask = 0x3,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
-		{  P0,  P1,  P2,  P3 }, /* 00b */
+		{  P0,  P2,  RV,  RV }, /* 00b */
 		{  RV,  RV,  RV,  RV },
 		{  P0,  P2, IDE, IDE }, /* 10b */
 		{  RV,  RV,  RV,  RV },
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 21b0ed5..e63c1ff 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -278,7 +278,7 @@ static void ata_unpack_xfermask(unsigned
 }
 
 static const struct ata_xfer_ent {
-	unsigned int shift, bits;
+	int shift, bits;
 	u8 base;
 } ata_xfer_tbl[] = {
 	{ ATA_SHIFT_PIO, ATA_BITS_PIO, XFER_PIO_0 },
@@ -989,9 +989,7 @@ ata_exec_internal(struct ata_port *ap, s
 	qc->private_data = &wait;
 	qc->complete_fn = ata_qc_complete_internal;
 
-	qc->err_mask = ata_qc_issue(qc);
-	if (qc->err_mask)
-		ata_qc_complete(qc);
+	ata_qc_issue(qc);
 
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
@@ -3997,15 +3995,14 @@ static inline int ata_should_dma_map(str
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
- *
- *	RETURNS:
- *	Zero on success, AC_ERR_* mask on failure
  */
-
-unsigned int ata_qc_issue(struct ata_queued_cmd *qc)
+void ata_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
+	qc->ap->active_tag = qc->tag;
+	qc->flags |= ATA_QCFLAG_ACTIVE;
+
 	if (ata_should_dma_map(qc)) {
 		if (qc->flags & ATA_QCFLAG_SG) {
 			if (ata_sg_setup(qc))
@@ -4020,17 +4017,18 @@ unsigned int ata_qc_issue(struct ata_que
 
 	ap->ops->qc_prep(qc);
 
-	qc->ap->active_tag = qc->tag;
-	qc->flags |= ATA_QCFLAG_ACTIVE;
-
-	return ap->ops->qc_issue(qc);
+	qc->err_mask |= ap->ops->qc_issue(qc);
+	if (unlikely(qc->err_mask))
+		goto err;
+	return;
 
 sg_err:
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
-	return AC_ERR_SYSTEM;
+	qc->err_mask |= AC_ERR_SYSTEM;
+err:
+	ata_qc_complete(qc);
 }
 
-
 /**
  *	ata_qc_issue_prot - issue taskfile to device in proto-dependent manner
  *	@qc: command to issue to device
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 628191b..53f5b0d 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1431,9 +1431,7 @@ static void ata_scsi_translate(struct at
 		goto early_finish;
 
 	/* select device, send command to hardware */
-	qc->err_mask = ata_qc_issue(qc);
-	if (qc->err_mask)
-		ata_qc_complete(qc);
+	ata_qc_issue(qc);
 
 	VPRINTK("EXIT\n");
 	return;
@@ -2199,9 +2197,7 @@ static void atapi_request_sense(struct a
 
 	qc->complete_fn = atapi_sense_complete;
 
-	qc->err_mask = ata_qc_issue(qc);
-	if (qc->err_mask)
-		ata_qc_complete(qc);
+	ata_qc_issue(qc);
 
 	DPRINTK("EXIT\n");
 }
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 65f52be..1c755b1 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -47,7 +47,7 @@ extern struct ata_queued_cmd *ata_qc_new
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_port_flush_task(struct ata_port *ap);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-extern unsigned int ata_qc_issue(struct ata_queued_cmd *qc);
+extern void ata_qc_issue(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
