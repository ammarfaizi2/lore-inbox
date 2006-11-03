Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753446AbWKCTAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbWKCTAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753455AbWKCTAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:00:22 -0500
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:47017 "EHLO
	outbound3-dub-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1753446AbWKCTAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:00:21 -0500
X-BigFish: V
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Workaround for SB600 SATA ODD issue
Message-Id: <20061103190004.9ED8DCBD48@localhost.localdomain>
Date: Fri,  3 Nov 2006 14:00:04 -0500 (EST)
From: luugi.marsan@amd.com (Luugi Marsan)
X-OriginalArrivalTime: 03 Nov 2006 18:59:57.0843 (UTC) FILETIME=[419B5630:01C6FF7A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: conke.hu@amd.com

There was an ASIC bug in the SB600 SATA controller of low revision (<=13) and CD burning may hang (only SATA ODD has this issue, and SATA HDD works well). The patch provides a workaround for this issue.

Signed-off-by:  Luugi Marsan <luugi.marsan@amd.com>

--- linux-2.6.19-rc4-git5/drivers/ata/ahci.c.orig       2006-11-04 03:56:22.000000000 +0800
+++ linux-2.6.19-rc4-git5/drivers/ata/ahci.c    2006-11-04 04:20:36.000000000 +0800
@@ -189,6 +189,7 @@ struct ahci_host_priv {
        unsigned long           flags;
        u32                     cap;    /* cache of HOST_CAP register */
        u32                     port_map; /* cache of HOST_PORTS_IMPL reg */
+       u8                      rev;    /* PCI Revision ID */
 };
 
 struct ahci_port_priv {
@@ -220,6 +221,7 @@ static int ahci_port_resume(struct ata_p
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int ahci_pci_device_resume(struct pci_dev *pdev);
 static void ahci_remove_one (struct pci_dev *pdev);
+static int ahci_check_atapi_dma(struct ata_queued_cmd *qc);
 
 static struct scsi_host_template ahci_sht = {
        .module                 = THIS_MODULE,
@@ -251,6 +253,8 @@ static const struct ata_port_operations
 
        .tf_read                = ahci_tf_read,
 
+       .check_atapi_dma        = ahci_check_atapi_dma,
+
        .qc_prep                = ahci_qc_prep,
        .qc_issue               = ahci_qc_issue,
 
@@ -906,6 +910,28 @@ static unsigned int ahci_fill_sg(struct
        return n_sg;
 }
 
+static int ahci_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+       struct pci_dev *pdev = to_pci_dev(qc->ap->host->dev);
+      
+       /* walkaround for SB600 SATA ODD isuue */
+       if (0x1002 == pdev->vendor && 0x4380 == pdev->device)
+       {
+               struct ahci_host_priv *priv = qc->ap->host->private_data;
+               u32 rq_len, low_8k;
+
+               if ( 13 < priv->rev )
+                       return 0;
+
+               rq_len = qc->scsicmd->request_bufflen;
+               low_8k = rq_len & 0x1fff;
+
+               if ( (rq_len & 0xffffe000) && low_8k && (512 > low_8k) )
+                       return 1;
+       }
+       return 0;
+}
+
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
 {
        struct ata_port *ap = qc->ap;
@@ -1366,6 +1392,7 @@ static int ahci_host_init(struct ata_pro
 
        hpriv->cap = readl(mmio + HOST_CAP);
        hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
+       pci_read_config_byte(pdev, PCI_REVISION_ID, &hpriv->rev);
        probe_ent->n_ports = (hpriv->cap & 0x1f) + 1;
 
        VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n", 

