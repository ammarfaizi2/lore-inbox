Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWAECzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWAECzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 21:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbWAECzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 21:55:54 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:3340 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1750891AbWAECzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 21:55:54 -0500
Subject: [PATCH] sata_nv, spurious interrupts at system startup with MAXTOR
	6H500F0 drive
From: Andrew Chew <achew@nvidia.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1136430784.3294.16.camel@dhcp-172-16-174-102.nvidia.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Jan 2006 19:13:04 -0800
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2006 02:55:54.0226 (UTC) FILETIME=[8B5F5520:01C611A3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch works around a problem with spurious interrupts seen at boot time when
a MAXTOR 6H500F0 drive is present.  An ATA interrupt condition is mysteriously
present at start of day.  If we took too long in issuing the first command,
the kernel would basically get tired of the spurious interrupts and turn the interrupt
off.  Issuing the first command essentially causes the interrupt condition to
get acknowledged.

I haven't seen this happen with any other drives.

What I basically do is ack ATA status by reading it regardless of whether we're
expecting to have to handle an interrupt.  This clears the start-of-day anomalous
interrupt condition, and keeps the kernel from disabling that interrupt due to
too many spurious interrupts.

Also, I fixed a bug where hotplug interrupts weren't getting acknowledged as handled
in the ISR.  This was not the cause of the spurious interrupts, but it's the right
thing to do anyway.


Signed-Off-By: Andrew Chew






--- linux-2.6.15.orig/drivers/scsi/sata_nv.c	2006-01-02 19:21:10.000000000 -0800
+++ linux-2.6.15/drivers/scsi/sata_nv.c	2006-01-04 18:12:33.000000000 -0800
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
@@ -310,12 +316,16 @@ static irqreturn_t nv_interrupt (int irq
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
 
@@ -498,7 +508,7 @@ static void nv_disable_hotplug(struct at
 	outb(intr_mask, host_set->ports[0]->ioaddr.scr_addr + NV_INT_ENABLE);
 }
 
-static void nv_check_hotplug(struct ata_host_set *host_set)
+static int nv_check_hotplug(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
@@ -523,7 +533,11 @@ static void nv_check_hotplug(struct ata_
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
@@ -561,7 +575,7 @@ static void nv_disable_hotplug_ck804(str
 	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
 }
 
-static void nv_check_hotplug_ck804(struct ata_host_set *host_set)
+static int nv_check_hotplug_ck804(struct ata_host_set *host_set)
 {
 	u8 intr_status;
 
@@ -586,7 +600,11 @@ static void nv_check_hotplug_ck804(struc
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



