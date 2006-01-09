Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWAIRLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWAIRLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWAIRLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:11:06 -0500
Received: from havoc.gtf.org ([69.61.125.42]:9107 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030183AbWAIRLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:11:04 -0500
Date: Mon, 9 Jan 2006 12:11:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] 2.6.x libata fix
Message-ID: <20060109171104.GA25793@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/sata_nv.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

Andrew Chew:
      sata_nv, spurious interrupts at system startup with MAXTOR 6H500F0 drive

diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index c0cf52c..bbbb55e 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -29,6 +29,12 @@
  *  NV-specific details such as register offsets, SATA phy location,
  *  hotplug info, etc.
  *
+ *  0.10
+ *     - Fixed spurious interrupts issue seen with the Maxtor 6H500F0 500GB
+ *       drive.  Also made the check_hotplug() callbacks return whether there
+ *       was a hotplug interrupt or not.  This was not the source of the
+ *       spurious interrupts, but is the right thing to do anyway.
+ *
  *  0.09
  *     - Fixed bug introduced by 0.08's MCP51 and MCP55 support.
  *
@@ -124,10 +130,10 @@ static void nv_scr_write (struct ata_por
 static void nv_host_stop (struct ata_host_set *host_set);
 static void nv_enable_hotplug(struct ata_probe_ent *probe_ent);
 static void nv_disable_hotplug(struct ata_host_set *host_set);
-static void nv_check_hotplug(struct ata_host_set *host_set);
+static int nv_check_hotplug(struct ata_host_set *host_set);
 static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent);
 static void nv_disable_hotplug_ck804(struct ata_host_set *host_set);
-static void nv_check_hotplug_ck804(struct ata_host_set *host_set);
+static int nv_check_hotplug_ck804(struct ata_host_set *host_set);
 
 enum nv_host_type
 {
@@ -176,7 +182,7 @@ struct nv_host_desc
 	enum nv_host_type	host_type;
 	void			(*enable_hotplug)(struct ata_probe_ent *probe_ent);
 	void			(*disable_hotplug)(struct ata_host_set *host_set);
-	void			(*check_hotplug)(struct ata_host_set *host_set);
+	int			(*check_hotplug)(struct ata_host_set *host_set);
 
 };
 static struct nv_host_desc nv_device_tbl[] = {
@@ -309,12 +315,16 @@ static irqreturn_t nv_interrupt (int irq
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
 				handled += ata_host_intr(ap, qc);
+			else
+				// No request pending?  Clear interrupt status
+				// anyway, in case there's one pending.
+				ap->ops->check_status(ap);
 		}
 
 	}
 
 	if (host->host_desc->check_hotplug)
-		host->host_desc->check_hotplug(host_set);
+		handled += host->host_desc->check_hotplug(host_set);
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
@@ -497,7 +507,7 @@ static void nv_disable_hotplug(struct at
 	outb(intr_mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 }
 
-static void nv_check_hotplug(struct ata_host_set *host_set)
+static int nv_check_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
@@ -522,7 +532,11 @@ static void nv_check_hotplug(struct ata_
 		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
 			printk(KERN_WARNING "nv_sata: "
 				"Secondary device removed\n");
+
+		return 1;
 	}
+
+	return 0;
 }
 
 static void nv_enable_hotplug_ck804(struct ata_probe_ent *probe_ent)
@@ -560,7 +574,7 @@ static void nv_disable_hotplug_ck804(str
 	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
 }
 
-static void nv_check_hotplug_ck804(struct ata_host_set *host_set)
+static int nv_check_hotplug_ck804(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
@@ -585,7 +599,11 @@ static void nv_check_hotplug_ck804(struc
 		if (intr_status & NV_INT_STATUS_SDEV_REMOVED)
 			printk(KERN_WARNING "nv_sata: "
 				"Secondary device removed\n");
+
+		return 1;
 	}
+
+	return 0;
 }
 
 static int __init nv_init(void)
