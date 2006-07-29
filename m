Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWG2Fls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWG2Fls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 01:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWG2Fls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 01:41:48 -0400
Received: from havoc.gtf.org ([69.61.125.42]:22439 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422637AbWG2Flr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 01:41:47 -0400
Date: Sat, 29 Jul 2006 01:41:12 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes
Message-ID: <20060729054112.GA32497@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/scsi/libata-eh.c    |   69 ++++++++++++++++++++++++++++----------------
 drivers/scsi/sata_promise.c |    7 ++++
 include/linux/libata.h      |    4 +-
 3 files changed, 54 insertions(+), 26 deletions(-)

Jeff Garzik:
      [libata] sata_promise: comment out duplicate PCI ID

Tejun Heo:
      libata: fix autopsy ehc->i.action and ehc->i.dev handling
      libata: fix eh_skip_recovery condition
      libata: improve EH action and EHI flag handling

diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 4b6aa30..29f5934 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -764,12 +764,27 @@ static void ata_eh_about_to_do(struct at
 			       unsigned int action)
 {
 	unsigned long flags;
+	struct ata_eh_info *ehi = &ap->eh_info;
+	struct ata_eh_context *ehc = &ap->eh_context;
 
 	spin_lock_irqsave(ap->lock, flags);
 
-	ata_eh_clear_action(dev, &ap->eh_info, action);
+	/* Reset is represented by combination of actions and EHI
+	 * flags.  Suck in all related bits before clearing eh_info to
+	 * avoid losing requested action.
+	 */
+	if (action & ATA_EH_RESET_MASK) {
+		ehc->i.action |= ehi->action & ATA_EH_RESET_MASK;
+		ehc->i.flags |= ehi->flags & ATA_EHI_RESET_MODIFIER_MASK;
+
+		/* make sure all reset actions are cleared & clear EHI flags */
+		action |= ATA_EH_RESET_MASK;
+		ehi->flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
+	}
+
+	ata_eh_clear_action(dev, ehi, action);
 
-	if (!(ap->eh_context.i.flags & ATA_EHI_QUIET))
+	if (!(ehc->i.flags & ATA_EHI_QUIET))
 		ap->pflags |= ATA_PFLAG_RECOVERED;
 
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -790,6 +805,12 @@ static void ata_eh_about_to_do(struct at
 static void ata_eh_done(struct ata_port *ap, struct ata_device *dev,
 			unsigned int action)
 {
+	/* if reset is complete, clear all reset actions & reset modifier */
+	if (action & ATA_EH_RESET_MASK) {
+		action |= ATA_EH_RESET_MASK;
+		ap->eh_context.i.flags &= ~ATA_EHI_RESET_MODIFIER_MASK;
+	}
+
 	ata_eh_clear_action(dev, &ap->eh_context.i, action);
 }
 
@@ -1276,8 +1297,6 @@ static int ata_eh_speed_down(struct ata_
 static void ata_eh_autopsy(struct ata_port *ap)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
-	unsigned int action = ehc->i.action;
-	struct ata_device *failed_dev = NULL;
 	unsigned int all_err_mask = 0;
 	int tag, is_io = 0;
 	u32 serror;
@@ -1294,7 +1313,7 @@ static void ata_eh_autopsy(struct ata_po
 		ehc->i.serror |= serror;
 		ata_eh_analyze_serror(ap);
 	} else if (rc != -EOPNOTSUPP)
-		action |= ATA_EH_HARDRESET;
+		ehc->i.action |= ATA_EH_HARDRESET;
 
 	/* analyze NCQ failure */
 	ata_eh_analyze_ncq_error(ap);
@@ -1315,7 +1334,7 @@ static void ata_eh_autopsy(struct ata_po
 		qc->err_mask |= ehc->i.err_mask;
 
 		/* analyze TF */
-		action |= ata_eh_analyze_tf(qc, &qc->result_tf);
+		ehc->i.action |= ata_eh_analyze_tf(qc, &qc->result_tf);
 
 		/* DEV errors are probably spurious in case of ATA_BUS error */
 		if (qc->err_mask & AC_ERR_ATA_BUS)
@@ -1329,11 +1348,11 @@ static void ata_eh_autopsy(struct ata_po
 		/* SENSE_VALID trumps dev/unknown error and revalidation */
 		if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
 			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER);
-			action &= ~ATA_EH_REVALIDATE;
+			ehc->i.action &= ~ATA_EH_REVALIDATE;
 		}
 
 		/* accumulate error info */
-		failed_dev = qc->dev;
+		ehc->i.dev = qc->dev;
 		all_err_mask |= qc->err_mask;
 		if (qc->flags & ATA_QCFLAG_IO)
 			is_io = 1;
@@ -1342,25 +1361,22 @@ static void ata_eh_autopsy(struct ata_po
 	/* enforce default EH actions */
 	if (ap->pflags & ATA_PFLAG_FROZEN ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
-		action |= ATA_EH_SOFTRESET;
+		ehc->i.action |= ATA_EH_SOFTRESET;
 	else if (all_err_mask)
-		action |= ATA_EH_REVALIDATE;
+		ehc->i.action |= ATA_EH_REVALIDATE;
 
 	/* if we have offending qcs and the associated failed device */
-	if (failed_dev) {
+	if (ehc->i.dev) {
 		/* speed down */
-		action |= ata_eh_speed_down(failed_dev, is_io, all_err_mask);
+		ehc->i.action |= ata_eh_speed_down(ehc->i.dev, is_io,
+						   all_err_mask);
 
 		/* perform per-dev EH action only on the offending device */
-		ehc->i.dev_action[failed_dev->devno] |=
-			action & ATA_EH_PERDEV_MASK;
-		action &= ~ATA_EH_PERDEV_MASK;
+		ehc->i.dev_action[ehc->i.dev->devno] |=
+			ehc->i.action & ATA_EH_PERDEV_MASK;
+		ehc->i.action &= ~ATA_EH_PERDEV_MASK;
 	}
 
-	/* record autopsy result */
-	ehc->i.dev = failed_dev;
-	ehc->i.action |= action;
-
 	DPRINTK("EXIT\n");
 }
 
@@ -1483,6 +1499,9 @@ static int ata_eh_reset(struct ata_port 
 	ata_reset_fn_t reset;
 	int i, did_followup_srst, rc;
 
+	/* about to reset */
+	ata_eh_about_to_do(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
+
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
 	 */
@@ -1531,8 +1550,7 @@ static int ata_eh_reset(struct ata_port 
 		ata_port_printk(ap, KERN_INFO, "%s resetting port\n",
 				reset == softreset ? "soft" : "hard");
 
-	/* reset */
-	ata_eh_about_to_do(ap, NULL, ATA_EH_RESET_MASK);
+	/* mark that this EH session started with reset */
 	ehc->i.flags |= ATA_EHI_DID_RESET;
 
 	rc = ata_do_reset(ap, reset, classes);
@@ -1595,7 +1613,7 @@ static int ata_eh_reset(struct ata_port 
 			postreset(ap, classes);
 
 		/* reset successful, schedule revalidation */
-		ata_eh_done(ap, NULL, ATA_EH_RESET_MASK);
+		ata_eh_done(ap, NULL, ehc->i.action & ATA_EH_RESET_MASK);
 		ehc->i.action |= ATA_EH_REVALIDATE;
 	}
 
@@ -1848,15 +1866,16 @@ static int ata_eh_skip_recovery(struct a
 	for (i = 0; i < ata_port_max_devices(ap); i++) {
 		struct ata_device *dev = &ap->device[i];
 
-		if (ata_dev_absent(dev) || ata_dev_ready(dev))
+		if (!(dev->flags & ATA_DFLAG_SUSPENDED))
 			break;
 	}
 
 	if (i == ata_port_max_devices(ap))
 		return 1;
 
-	/* always thaw frozen port and recover failed devices */
-	if (ap->pflags & ATA_PFLAG_FROZEN || ata_port_nr_enabled(ap))
+	/* thaw frozen port, resume link and recover failed devices */
+	if ((ap->pflags & ATA_PFLAG_FROZEN) ||
+	    (ehc->i.flags & ATA_EHI_RESUME_LINK) || ata_port_nr_enabled(ap))
 		return 0;
 
 	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 64631bd..4776f4e 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -269,8 +269,15 @@ static const struct pci_device_id pdc_at
 	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20619 },
 
+/* TODO: remove all associated board_20771 code, as it completely
+ * duplicates board_2037x code, unless reason for separation can be
+ * divined.
+ */
+#if 0
 	{ PCI_VENDOR_ID_PROMISE, 0x3570, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20771 },
+#endif
+
 	{ }	/* terminate list */
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6cc497a..66c3100 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -265,12 +265,14 @@ enum {
 
 	/* ata_eh_info->flags */
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
-	ATA_EHI_RESUME_LINK	= (1 << 1),  /* need to resume link */
+	ATA_EHI_RESUME_LINK	= (1 << 1),  /* resume link (reset modifier) */
 	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 
 	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
 
+	ATA_EHI_RESET_MODIFIER_MASK = ATA_EHI_RESUME_LINK,
+
 	/* max repeat if error condition is still set after ->error_handler */
 	ATA_EH_MAX_REPEAT	= 5,
 
