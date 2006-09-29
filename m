Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161218AbWI2A2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161218AbWI2A2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWI2A2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:28:01 -0400
Received: from havoc.gtf.org ([69.61.125.42]:32135 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161218AbWI2A14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:27:56 -0400
Date: Thu, 28 Sep 2006 20:27:55 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] libata: init probe_ent->private_data in a common loc
Message-ID: <20060929002755.GC7458@havoc.gtf.org>
References: <20060929002601.GA7397@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929002601.GA7397@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


commit d639ca94188fedbd8cfde1ab4ed9e9878ab2f01e
Author: Jeff Garzik <jeff@garzik.org>
Date:   Thu Sep 28 03:48:18 2006 -0400

    [libata] init probe_ent->private_data in a common location

    Don't write the same code twice, in two different functions, when they
    both call the same initialization function, with the same private_data
    pointer info.

    Also, note a bug found with a FIXME.

    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/ata/libata-core.c |    1 +
 drivers/ata/libata-sff.c  |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

d639ca94188fedbd8cfde1ab4ed9e9878ab2f01e
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 396493c..72644bd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5785,6 +5785,7 @@ ata_probe_ent_alloc(struct device *dev, 
 	probe_ent->mwdma_mask = port->mwdma_mask;
 	probe_ent->udma_mask = port->udma_mask;
 	probe_ent->port_ops = port->port_ops;
+	probe_ent->private_data = port->private_data;
 
 	return probe_ent;
 }
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index a620e23..06daaa3 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -828,7 +828,6 @@ ata_pci_init_native_mode(struct pci_dev 
 
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = IRQF_SHARED;
-	probe_ent->private_data = port[0]->private_data;
 
 	if (ports & ATA_PORT_PRIMARY) {
 		probe_ent->port[p].cmd_addr = pci_resource_start(pdev, 0);
@@ -878,7 +877,6 @@ static struct ata_probe_ent *ata_pci_ini
 		return NULL;
 
 	probe_ent->n_ports = 2;
-	probe_ent->private_data = port[0]->private_data;
 
 	if (port_mask & ATA_PORT_PRIMARY) {
 		probe_ent->irq = ATA_PRIMARY_IRQ;
@@ -908,6 +906,8 @@ static struct ata_probe_ent *ata_pci_ini
 				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
 		}
 		ata_std_ports(&probe_ent->port[1]);
+
+		/* FIXME: could be pointing to stack area; must copy */
 		probe_ent->pinfo2 = port[1];
 	} else
 		probe_ent->dummy_port_mask |= ATA_PORT_SECONDARY;
