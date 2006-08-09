Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030532AbWHIGZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030532AbWHIGZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbWHIGZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:25:18 -0400
Received: from havoc.gtf.org ([69.61.125.42]:21657 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030521AbWHIGZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:25:16 -0400
Date: Wed, 9 Aug 2006 02:25:14 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes
Message-ID: <20060809062514.GA27491@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-greg' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-greg

to receive the following updates:

 drivers/scsi/ata_piix.c    |    5 +++--
 drivers/scsi/libata-core.c |   34 ++++++++--------------------------
 drivers/scsi/libata-scsi.c |   13 +++++++++++++
 drivers/scsi/sata_sil24.c  |    1 -
 4 files changed, 24 insertions(+), 29 deletions(-)

Jeff Garzik:
      [libata] manually inline ata_host_remove()

Keith Owens:
      Fix compile problem when sata debugging is on

Tejun Heo:
      libata: fix ata_port_detach() for old EH ports
      ata_piix: fix host_set private_data intialization
      sata_sil24: don't set probe_ent->mmio_base
      libata: fix ata_device_add() error path
      libata: clear sdev->locked on door lock failure

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 19745a3..5e8afc8 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -567,8 +567,8 @@ static int piix_sata_prereset(struct ata
 			present = 1;
 	}
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
-		ap->id, pcs, present_mask);
+	DPRINTK("ata%u: LEAVE, pcs=0x%x present=0x%x\n",
+		ap->id, pcs, present);
 
 	if (!present) {
 		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
@@ -828,6 +828,7 @@ static void __devinit piix_init_sata_map
 		case IDE:
 			WARN_ON((i & 1) || map[i + 1] != IDE);
 			pinfo[i / 2] = piix_port_info[ich5_pata];
+			pinfo[i / 2].private_data = hpriv;
 			i++;
 			printk(" IDE IDE");
 			break;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 386e5f2..16fc2dd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5185,28 +5185,6 @@ void ata_host_stop (struct ata_host_set 
 		iounmap(host_set->mmio_base);
 }
 
-
-/**
- *	ata_host_remove - Unregister SCSI host structure with upper layers
- *	@ap: Port to unregister
- *	@do_unregister: 1 if we fully unregister, 0 to just stop the port
- *
- *	LOCKING:
- *	Inherited from caller.
- */
-
-static void ata_host_remove(struct ata_port *ap, unsigned int do_unregister)
-{
-	struct Scsi_Host *sh = ap->host;
-
-	DPRINTK("ENTER\n");
-
-	if (do_unregister)
-		scsi_remove_host(sh);
-
-	ap->ops->port_stop(ap);
-}
-
 /**
  *	ata_dev_init - Initialize an ata_device structure
  *	@dev: Device structure to initialize
@@ -5532,8 +5510,11 @@ int ata_device_add(const struct ata_prob
 
 err_out:
 	for (i = 0; i < count; i++) {
-		ata_host_remove(host_set->ports[i], 1);
-		scsi_host_put(host_set->ports[i]->host);
+		struct ata_port *ap = host_set->ports[i];
+		if (ap) {
+			ap->ops->port_stop(ap);
+			scsi_host_put(ap->host);
+		}
 	}
 err_free_ret:
 	kfree(host_set);
@@ -5558,7 +5539,7 @@ void ata_port_detach(struct ata_port *ap
 	int i;
 
 	if (!ap->ops->error_handler)
-		return;
+		goto skip_eh;
 
 	/* tell EH we're leaving & flush EH */
 	spin_lock_irqsave(ap->lock, flags);
@@ -5594,6 +5575,7 @@ void ata_port_detach(struct ata_port *ap
 	cancel_delayed_work(&ap->hotplug_task);
 	flush_workqueue(ata_aux_wq);
 
+ skip_eh:
 	/* remove the associated SCSI host */
 	scsi_remove_host(ap->host);
 }
@@ -5662,7 +5644,7 @@ int ata_scsi_release(struct Scsi_Host *h
 	DPRINTK("ENTER\n");
 
 	ap->ops->port_disable(ap);
-	ata_host_remove(ap, 0);
+	ap->ops->port_stop(ap);
 
 	DPRINTK("EXIT\n");
 	return 1;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 7ced41e..e92c31d 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2353,6 +2353,19 @@ static void atapi_qc_complete(struct ata
 			ata_gen_ata_desc_sense(qc);
 		}
 
+		/* SCSI EH automatically locks door if sdev->locked is
+		 * set.  Sometimes door lock request continues to
+		 * fail, for example, when no media is present.  This
+		 * creates a loop - SCSI EH issues door lock which
+		 * fails and gets invoked again to acquire sense data
+		 * for the failed command.
+		 *
+		 * If door lock fails, always clear sdev->locked to
+		 * avoid this infinite loop.
+		 */
+		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL)
+			qc->dev->sdev->locked = 0;
+
 		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;
 		qc->scsidone(cmd);
 		ata_qc_free(qc);
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 2e0f4a4..3f368c7 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -1106,7 +1106,6 @@ static int sil24_init_one(struct pci_dev
 
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->mmio_base = port_base;
 	probe_ent->private_data = hpriv;
 
 	hpriv->host_base = host_base;
