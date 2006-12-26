Return-Path: <linux-kernel-owner+w=401wt.eu-S932691AbWLZPUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWLZPUw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 10:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWLZPUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 10:20:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:57951 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690AbWLZPSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 10:18:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=VeCiVPDptEjOPOVTw0NEJEcW7i78m1tzCrqHfcIRspJlRPbmQIQHRYte97XyiP1YYDsJe9kkm0k6FDbwDeUOxLynQwNP0iHig3PaoUOjwWT+tcWm+89vEtNmL03qVxWvLofO/L4ij1C5ohy+W/l7Abc4j73dd/7dx0TNoYsubdg=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 9/12] libata: update SATA LLDs to use devres
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Wed, 27 Dec 2006 00:18:35 +0900
Message-Id: <11671463153709-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: gregkh@suse.de, jeff@garzik.org, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update libata SATA LLDs to use devres.  Core layer is already
converted to support managed LLDs.  This patch simplifies
initialization and fixes many resource related bugs in init failure
and detach path.  For example, all converted drivers now handle
ata_device_add() failure gracefully without excessive resource
rollback code.

As most resources are released automatically on driver detach, many
drivers don't need or can do with much simpler ->{port|host}_stop().
In general, stop callbacks are need iff port or host needs to be given
commands to shut it down.  Note that freezing is enough in many cases
and ports are automatically frozen before being detached.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c         |  125 ++++++++------------------------------
 drivers/ata/ata_piix.c     |   19 +-----
 drivers/ata/pdc_adma.c     |   79 +++++++------------------
 drivers/ata/sata_mv.c      |  142 +++++++++-----------------------------------
 drivers/ata/sata_nv.c      |   82 ++++++-------------------
 drivers/ata/sata_promise.c |  104 +++++++-------------------------
 drivers/ata/sata_qstor.c   |   90 +++++++---------------------
 drivers/ata/sata_sil.c     |   47 +++++----------
 drivers/ata/sata_sil24.c   |  112 +++++++++--------------------------
 drivers/ata/sata_sis.c     |   33 +++-------
 drivers/ata/sata_svw.c     |   48 +++++----------
 drivers/ata/sata_sx4.c     |  131 ++++++++++-------------------------------
 drivers/ata/sata_uli.c     |   43 ++++---------
 drivers/ata/sata_via.c     |   40 ++++---------
 drivers/ata/sata_vsc.c     |   51 +++++-----------
 15 files changed, 286 insertions(+), 860 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 76bf3e6..a9d856d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -45,7 +45,6 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
-#include <asm/io.h>
 
 #define DRV_NAME	"ahci"
 #define DRV_VERSION	"2.0"
@@ -165,9 +164,6 @@ enum {
 	PORT_CMD_ICC_PARTIAL	= (0x2 << 28), /* Put i/f in partial state */
 	PORT_CMD_ICC_SLUMBER	= (0x6 << 28), /* Put i/f in slumber state */
 
-	/* hpriv->flags bits */
-	AHCI_FLAG_MSI		= (1 << 0),
-
 	/* ap->flags bits */
 	AHCI_FLAG_NO_NCQ		= (1 << 24),
 	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
@@ -190,7 +186,6 @@ struct ahci_sg {
 };
 
 struct ahci_host_priv {
-	unsigned long		flags;
 	u32			cap;	/* cache of HOST_CAP register */
 	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
 };
@@ -224,7 +219,6 @@ static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg);
 static int ahci_port_resume(struct ata_port *ap);
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int ahci_pci_device_resume(struct pci_dev *pdev);
-static void ahci_remove_one (struct pci_dev *pdev);
 
 static struct scsi_host_template ahci_sht = {
 	.module			= THIS_MODULE,
@@ -436,9 +430,9 @@ static struct pci_driver ahci_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= ahci_pci_tbl,
 	.probe			= ahci_init_one,
+	.remove			= ata_pci_remove_one,
 	.suspend		= ahci_pci_device_suspend,
 	.resume			= ahci_pci_device_resume,
-	.remove			= ahci_remove_one,
 };
 
 
@@ -1401,23 +1395,18 @@ static int ahci_port_start(struct ata_port *ap)
 	dma_addr_t mem_dma;
 	int rc;
 
-	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		return -ENOMEM;
-	memset(pp, 0, sizeof(*pp));
 
 	rc = ata_pad_alloc(ap, dev);
-	if (rc) {
-		kfree(pp);
+	if (rc)
 		return rc;
-	}
 
-	mem = dma_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma, GFP_KERNEL);
-	if (!mem) {
-		ata_pad_free(ap, dev);
-		kfree(pp);
+	mem = dmam_alloc_coherent(dev, AHCI_PORT_PRIV_DMA_SZ, &mem_dma,
+				  GFP_KERNEL);
+	if (!mem)
 		return -ENOMEM;
-	}
 	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
 
 	/*
@@ -1459,9 +1448,7 @@ static int ahci_port_start(struct ata_port *ap)
 
 static void ahci_port_stop(struct ata_port *ap)
 {
-	struct device *dev = ap->host->dev;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
-	struct ahci_port_priv *pp = ap->private_data;
 	void __iomem *mmio = ap->host->mmio_base;
 	void __iomem *port_mmio = ahci_port_base(mmio, ap->port_no);
 	const char *emsg = NULL;
@@ -1471,12 +1458,6 @@ static void ahci_port_stop(struct ata_port *ap)
 	rc = ahci_deinit_port(port_mmio, hpriv->cap, &emsg);
 	if (rc)
 		ata_port_printk(ap, KERN_WARNING, "%s (%d)\n", emsg, rc);
-
-	ap->private_data = NULL;
-	dma_free_coherent(dev, AHCI_PORT_PRIV_DMA_SZ,
-			  pp->cmd_slot, pp->cmd_slot_dma);
-	ata_pad_free(ap, dev);
-	kfree(pp);
 }
 
 static void ahci_setup_port(struct ata_ioports *port, unsigned long base,
@@ -1644,15 +1625,15 @@ static void ahci_print_info(struct ata_probe_ent *probe_ent)
 		);
 }
 
-static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent = NULL;
+	unsigned int board_idx = (unsigned int) ent->driver_data;
+	struct device *dev = &pdev->dev;
+	struct ata_probe_ent *probe_ent;
 	struct ahci_host_priv *hpriv;
 	unsigned long base;
 	void __iomem *mmio_base;
-	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int have_msi, pci_dev_busy = 0;
 	int rc;
 
 	VPRINTK("ENTER\n");
@@ -1673,46 +1654,34 @@ static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 			return -ENODEV;
 	}
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
-	if (pci_enable_msi(pdev) == 0)
-		have_msi = 1;
-	else {
+	if (pci_enable_msi(pdev))
 		pci_intx(pdev, 1);
-		have_msi = 0;
-	}
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
-		goto err_out_msi;
-	}
+	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		return -ENOMEM;
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = pci_iomap(pdev, AHCI_PCI_BAR, 0);
-	if (mmio_base == NULL) {
-		rc = -ENOMEM;
-		goto err_out_free_ent;
-	}
+	mmio_base = pcim_iomap(pdev, AHCI_PCI_BAR, 0);
+	if (mmio_base == NULL)
+		return -ENOMEM;
 	base = (unsigned long) mmio_base;
 
-	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv) {
-		rc = -ENOMEM;
-		goto err_out_iounmap;
-	}
-	memset(hpriv, 0, sizeof(*hpriv));
+	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
 
 	probe_ent->sht		= ahci_port_info[board_idx].sht;
 	probe_ent->port_flags	= ahci_port_info[board_idx].flags;
@@ -1725,13 +1694,10 @@ static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	probe_ent->mmio_base = mmio_base;
 	probe_ent->private_data = hpriv;
 
-	if (have_msi)
-		hpriv->flags |= AHCI_FLAG_MSI;
-
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
-		goto err_out_hpriv;
+		return rc;
 
 	if (!(probe_ent->port_flags & AHCI_FLAG_NO_NCQ) &&
 	    (hpriv->cap & HOST_CAP_NCQ))
@@ -1739,48 +1705,11 @@ static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ahci_print_info(probe_ent);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (!ata_device_add(probe_ent))
+		return -ENODEV;
 
+	devm_kfree(dev, probe_ent);
 	return 0;
-
-err_out_hpriv:
-	kfree(hpriv);
-err_out_iounmap:
-	pci_iounmap(pdev, mmio_base);
-err_out_free_ent:
-	kfree(probe_ent);
-err_out_msi:
-	if (have_msi)
-		pci_disable_msi(pdev);
-	else
-		pci_intx(pdev, 0);
-	pci_release_regions(pdev);
-err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-	return rc;
-}
-
-static void ahci_remove_one(struct pci_dev *pdev)
-{
-	struct device *dev = pci_dev_to_dev(pdev);
-	struct ata_host *host = dev_get_drvdata(dev);
-	struct ahci_host_priv *hpriv = host->private_data;
-
-	ata_host_remove(host);
-
-	pci_iounmap(pdev, host->mmio_base);
-
-	if (hpriv->flags & AHCI_FLAG_MSI)
-		pci_disable_msi(pdev);
-	else
-		pci_intx(pdev, 0);
-	pci_release_regions(pdev);
-	pci_disable_device(pdev);
-	dev_set_drvdata(dev, NULL);
-	kfree(hpriv);
 }
 
 static int __init ahci_init(void)
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 47701b2..46d66dc 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -153,7 +153,6 @@ struct piix_host_priv {
 
 static int piix_init_one (struct pci_dev *pdev,
 				    const struct pci_device_id *ent);
-static void piix_host_stop(struct ata_host *host);
 static void piix_pata_error_handler(struct ata_port *ap);
 static void ich_pata_error_handler(struct ata_port *ap);
 static void piix_sata_error_handler(struct ata_port *ap);
@@ -308,8 +307,6 @@ static const struct ata_port_operations piix_pata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations ich_pata_ops = {
@@ -341,8 +338,6 @@ static const struct ata_port_operations ich_pata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
@@ -371,8 +366,6 @@ static const struct ata_port_operations piix_sata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= piix_host_stop,
 };
 
 static const struct piix_map_db ich5_map_db = {
@@ -1059,6 +1052,7 @@ static void __devinit piix_init_sata_map(struct pci_dev *pdev,
 static int piix_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
+	struct device *dev = &pdev->dev;
 	struct ata_port_info port_info[2];
 	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
 	struct piix_host_priv *hpriv;
@@ -1072,7 +1066,7 @@ static int piix_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!in_module_init)
 		return -ENODEV;
 
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
+	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv)
 		return -ENOMEM;
 
@@ -1122,15 +1116,6 @@ static int piix_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	return ata_pci_init_one(pdev, ppinfo, 2);
 }
 
-static void piix_host_stop(struct ata_host *host)
-{
-	struct piix_host_priv *hpriv = host->private_data;
-
-	ata_host_stop(host);
-
-	kfree(hpriv);
-}
-
 static int __init piix_init(void)
 {
 	int rc;
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 90786d7..a6bf7cb 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -42,7 +42,6 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
-#include <asm/io.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"pdc_adma"
@@ -550,48 +549,28 @@ static int adma_port_start(struct ata_port *ap)
 	if (rc)
 		return rc;
 	adma_enter_reg_mode(ap);
-	rc = -ENOMEM;
-	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
-		goto err_out;
-	pp->pkt = dma_alloc_coherent(dev, ADMA_PKT_BYTES, &pp->pkt_dma,
-								GFP_KERNEL);
+		return -ENOMEM;
+	pp->pkt = dmam_alloc_coherent(dev, ADMA_PKT_BYTES, &pp->pkt_dma,
+				      GFP_KERNEL);
 	if (!pp->pkt)
-		goto err_out_kfree;
+		return -ENOMEM;
 	/* paranoia? */
 	if ((pp->pkt_dma & 7) != 0) {
 		printk("bad alignment for pp->pkt_dma: %08x\n",
 						(u32)pp->pkt_dma);
-		dma_free_coherent(dev, ADMA_PKT_BYTES,
-						pp->pkt, pp->pkt_dma);
-		goto err_out_kfree;
+		return -ENOMEM;
 	}
 	memset(pp->pkt, 0, ADMA_PKT_BYTES);
 	ap->private_data = pp;
 	adma_reinit_engine(ap);
 	return 0;
-
-err_out_kfree:
-	kfree(pp);
-err_out:
-	ata_port_stop(ap);
-	return rc;
 }
 
 static void adma_port_stop(struct ata_port *ap)
 {
-	struct device *dev = ap->host->dev;
-	struct adma_port_priv *pp = ap->private_data;
-
 	adma_reset_engine(ADMA_REGS(ap->host->mmio_base, ap->port_no));
-	if (pp != NULL) {
-		ap->private_data = NULL;
-		if (pp->pkt != NULL)
-			dma_free_coherent(dev, ADMA_PKT_BYTES,
-					pp->pkt, pp->pkt_dma);
-		kfree(pp);
-	}
-	ata_port_stop(ap);
 }
 
 static void adma_host_stop(struct ata_host *host)
@@ -600,8 +579,6 @@ static void adma_host_stop(struct ata_host *host)
 
 	for (port_no = 0; port_no < ADMA_PORTS; ++port_no)
 		adma_reset_engine(ADMA_REGS(host->mmio_base, port_no));
-
-	ata_pci_host_stop(host);
 }
 
 static void adma_host_init(unsigned int chip_id,
@@ -649,34 +626,28 @@ static int adma_ata_init_one(struct pci_dev *pdev,
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
-		goto err_out;
+		return rc;
 
-	if ((pci_resource_flags(pdev, 4) & IORESOURCE_MEM) == 0) {
-		rc = -ENODEV;
-		goto err_out_regions;
-	}
+	if ((pci_resource_flags(pdev, 4) & IORESOURCE_MEM) == 0)
+		return -ENODEV;
 
-	mmio_base = pci_iomap(pdev, 4, 0);
-	if (mmio_base == NULL) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	mmio_base = pcim_iomap(pdev, 4, 0);
+	if (mmio_base == NULL)
+		return -ENOMEM;
 
 	rc = adma_set_dma_masks(pdev, mmio_base);
 	if (rc)
-		goto err_out_iounmap;
+		return rc;
 
-	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
-		goto err_out_iounmap;
-	}
+	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		return -ENOMEM;
 
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
@@ -703,19 +674,11 @@ static int adma_ata_init_one(struct pci_dev *pdev,
 	/* initialize adapter */
 	adma_host_init(board_idx, probe_ent);
 
-	rc = ata_device_add(probe_ent);
-	kfree(probe_ent);
-	if (rc != ADMA_PORTS)
-		goto err_out_iounmap;
-	return 0;
+	if (!ata_device_add(probe_ent))
+		return -ENODEV;
 
-err_out_iounmap:
-	pci_iounmap(pdev, mmio_base);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	pci_disable_device(pdev);
-	return rc;
+	devm_kfree(&pdev->dev, probe_ent);
+	return 0;
 }
 
 static int __init adma_ata_init(void)
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 1b8e0eb..e1754cb 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -34,7 +34,6 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
-#include <asm/io.h>
 
 #define DRV_NAME	"sata_mv"
 #define DRV_VERSION	"0.7"
@@ -342,7 +341,6 @@ static u32 mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in);
 static void mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val);
 static void mv_phy_reset(struct ata_port *ap);
 static void __mv_phy_reset(struct ata_port *ap, int can_sleep);
-static void mv_host_stop(struct ata_host *host);
 static int mv_port_start(struct ata_port *ap);
 static void mv_port_stop(struct ata_port *ap);
 static void mv_qc_prep(struct ata_queued_cmd *qc);
@@ -418,7 +416,6 @@ static const struct ata_port_operations mv5_ops = {
 
 	.port_start		= mv_port_start,
 	.port_stop		= mv_port_stop,
-	.host_stop		= mv_host_stop,
 };
 
 static const struct ata_port_operations mv6_ops = {
@@ -446,7 +443,6 @@ static const struct ata_port_operations mv6_ops = {
 
 	.port_start		= mv_port_start,
 	.port_stop		= mv_port_stop,
-	.host_stop		= mv_host_stop,
 };
 
 static const struct ata_port_operations mv_iie_ops = {
@@ -474,7 +470,6 @@ static const struct ata_port_operations mv_iie_ops = {
 
 	.port_start		= mv_port_start,
 	.port_stop		= mv_port_stop,
-	.host_stop		= mv_host_stop,
 };
 
 static const struct ata_port_info mv_port_info[] = {
@@ -808,35 +803,6 @@ static void mv_scr_write(struct ata_port *ap, unsigned int sc_reg_in, u32 val)
 	}
 }
 
-/**
- *      mv_host_stop - Host specific cleanup/stop routine.
- *      @host: host data structure
- *
- *      Disable ints, cleanup host memory, call general purpose
- *      host_stop.
- *
- *      LOCKING:
- *      Inherited from caller.
- */
-static void mv_host_stop(struct ata_host *host)
-{
-	struct mv_host_priv *hpriv = host->private_data;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-
-	if (hpriv->hp_flags & MV_HP_FLAG_MSI) {
-		pci_disable_msi(pdev);
-	} else {
-		pci_intx(pdev, 0);
-	}
-	kfree(hpriv);
-	ata_host_stop(host);
-}
-
-static inline void mv_priv_free(struct mv_port_priv *pp, struct device *dev)
-{
-	dma_free_coherent(dev, MV_PORT_PRIV_DMA_SZ, pp->crpb, pp->crpb_dma);
-}
-
 static void mv_edma_cfg(struct mv_host_priv *hpriv, void __iomem *port_mmio)
 {
 	u32 cfg = readl(port_mmio + EDMA_CFG_OFS);
@@ -882,22 +848,21 @@ static int mv_port_start(struct ata_port *ap)
 	void __iomem *port_mmio = mv_ap_base(ap);
 	void *mem;
 	dma_addr_t mem_dma;
-	int rc = -ENOMEM;
+	int rc;
 
-	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
-		goto err_out;
-	memset(pp, 0, sizeof(*pp));
+		return -ENOMEM;
 
-	mem = dma_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
-				 GFP_KERNEL);
+	mem = dmam_alloc_coherent(dev, MV_PORT_PRIV_DMA_SZ, &mem_dma,
+				  GFP_KERNEL);
 	if (!mem)
-		goto err_out_pp;
+		return -ENOMEM;
 	memset(mem, 0, MV_PORT_PRIV_DMA_SZ);
 
 	rc = ata_pad_alloc(ap, dev);
 	if (rc)
-		goto err_out_priv;
+		return rc;
 
 	/* First item in chunk of DMA memory:
 	 * 32-slot command request table (CRQB), 32 bytes each in size
@@ -950,13 +915,6 @@ static int mv_port_start(struct ata_port *ap)
 	 */
 	ap->private_data = pp;
 	return 0;
-
-err_out_priv:
-	mv_priv_free(pp, dev);
-err_out_pp:
-	kfree(pp);
-err_out:
-	return rc;
 }
 
 /**
@@ -970,18 +928,11 @@ err_out:
  */
 static void mv_port_stop(struct ata_port *ap)
 {
-	struct device *dev = ap->host->dev;
-	struct mv_port_priv *pp = ap->private_data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ap->host->lock, flags);
 	mv_stop_dma(ap);
 	spin_unlock_irqrestore(&ap->host->lock, flags);
-
-	ap->private_data = NULL;
-	ata_pad_free(ap, dev);
-	mv_priv_free(pp, dev);
-	kfree(pp);
 }
 
 /**
@@ -2341,49 +2292,41 @@ static void mv_print_info(struct ata_probe_ent *probe_ent)
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
-	struct ata_probe_ent *probe_ent = NULL;
+	struct device *dev = &pdev->dev;
+	struct ata_probe_ent *probe_ent;
 	struct mv_host_priv *hpriv;
 	unsigned int board_idx = (unsigned int)ent->driver_data;
 	void __iomem *mmio_base;
-	int pci_dev_busy = 0, rc;
+	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
-	if (rc) {
+	rc = pcim_enable_device(pdev);
+	if (rc)
 		return rc;
-	}
 	pci_set_master(pdev);
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		return -ENOMEM;
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = pci_iomap(pdev, MV_PRIMARY_BAR, 0);
-	if (mmio_base == NULL) {
-		rc = -ENOMEM;
-		goto err_out_free_ent;
-	}
+	mmio_base = pcim_iomap(pdev, MV_PRIMARY_BAR, 0);
+	if (mmio_base == NULL)
+		return -ENOMEM;
 
-	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv) {
-		rc = -ENOMEM;
-		goto err_out_iounmap;
-	}
-	memset(hpriv, 0, sizeof(*hpriv));
+	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
 
 	probe_ent->sht = mv_port_info[board_idx].sht;
 	probe_ent->port_flags = mv_port_info[board_idx].flags;
@@ -2398,48 +2341,21 @@ static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* initialize adapter */
 	rc = mv_init_host(pdev, probe_ent, board_idx);
-	if (rc) {
-		goto err_out_hpriv;
-	}
+	if (rc)
+		return rc;
 
 	/* Enable interrupts */
-	if (msi && pci_enable_msi(pdev) == 0) {
-		hpriv->hp_flags |= MV_HP_FLAG_MSI;
-	} else {
+	if (msi && !pci_enable_msi(pdev))
 		pci_intx(pdev, 1);
-	}
 
 	mv_dump_pci_cfg(pdev, 0x68);
 	mv_print_info(probe_ent);
 
-	if (ata_device_add(probe_ent) == 0) {
-		rc = -ENODEV;		/* No devices discovered */
-		goto err_out_dev_add;
-	}
+	if (ata_device_add(probe_ent) == 0)
+		return -ENODEV;
 
-	kfree(probe_ent);
+	devm_kfree(dev, probe_ent);
 	return 0;
-
-err_out_dev_add:
-	if (MV_HP_FLAG_MSI & hpriv->hp_flags) {
-		pci_disable_msi(pdev);
-	} else {
-		pci_intx(pdev, 0);
-	}
-err_out_hpriv:
-	kfree(hpriv);
-err_out_iounmap:
-	pci_iounmap(pdev, mmio_base);
-err_out_free_ent:
-	kfree(probe_ent);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	if (!pci_dev_busy) {
-		pci_disable_device(pdev);
-	}
-
-	return rc;
 }
 
 static int __init mv_init(void)
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index f6d498e..59d5207 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -346,8 +346,6 @@ static const struct ata_port_operations nv_generic_ops = {
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static const struct ata_port_operations nv_nf2_ops = {
@@ -373,8 +371,6 @@ static const struct ata_port_operations nv_nf2_ops = {
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static const struct ata_port_operations nv_ck804_ops = {
@@ -400,7 +396,6 @@ static const struct ata_port_operations nv_ck804_ops = {
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
 	.host_stop		= nv_ck804_host_stop,
 };
 
@@ -931,19 +926,14 @@ static int nv_adma_port_start(struct ata_port *ap)
 	if (rc)
 		return rc;
 
-	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
-
-	mem = dma_alloc_coherent(dev, NV_ADMA_PORT_PRIV_DMA_SZ,
-				 &mem_dma, GFP_KERNEL);
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
 
-	if (!mem) {
-		rc = -ENOMEM;
-		goto err_out_kfree;
-	}
+	mem = dmam_alloc_coherent(dev, NV_ADMA_PORT_PRIV_DMA_SZ,
+				  &mem_dma, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
 	memset(mem, 0, NV_ADMA_PORT_PRIV_DMA_SZ);
 
 	/*
@@ -989,31 +979,17 @@ static int nv_adma_port_start(struct ata_port *ap)
 	readl( mmio + NV_ADMA_CTL );	/* flush posted write */
 
 	return 0;
-
-err_out_kfree:
-	kfree(pp);
-err_out:
-	ata_port_stop(ap);
-	return rc;
 }
 
 static void nv_adma_port_stop(struct ata_port *ap)
 {
-	struct device *dev = ap->host->dev;
-	struct nv_adma_port_priv *pp = ap->private_data;
 	void __iomem *mmio = nv_adma_ctl_block(ap);
 
 	VPRINTK("ENTER\n");
 
 	writew(0, mmio + NV_ADMA_CTL);
-
-	ap->private_data = NULL;
-	dma_free_coherent(dev, NV_ADMA_PORT_PRIV_DMA_SZ, pp->cpb, pp->cpb_dma);
-	kfree(pp);
-	ata_port_stop(ap);
 }
 
-
 static void nv_adma_setup_port(struct ata_probe_ent *probe_ent, unsigned int port)
 {
 	void __iomem *mmio = probe_ent->mmio_base;
@@ -1388,7 +1364,6 @@ static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	static int printed_version = 0;
 	struct ata_port_info *ppi[2];
 	struct ata_probe_ent *probe_ent;
-	int pci_dev_busy = 0;
 	int rc;
 	u32 bar;
 	unsigned long base;
@@ -1405,14 +1380,14 @@ static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (	!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
-		goto err_out;
+		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out_disable;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
 	if(type >= CK804 && adma_enabled) {
@@ -1426,10 +1401,10 @@ static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if(!mask_set) {
 		rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 		if (rc)
-			goto err_out_regions;
+			return rc;
 		rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 		if (rc)
-			goto err_out_regions;
+			return rc;
 	}
 
 	rc = -ENOMEM;
@@ -1437,13 +1412,11 @@ static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	ppi[0] = ppi[1] = &nv_port_info[type];
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
-		goto err_out_regions;
+		return rc;
 
-	probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
-	if (!probe_ent->mmio_base) {
-		rc = -EIO;
-		goto err_out_free_ent;
-	}
+	probe_ent->mmio_base = pcim_iomap(pdev, 5, 0);
+	if (!probe_ent->mmio_base)
+		return -EIO;
 
 	base = (unsigned long)probe_ent->mmio_base;
 
@@ -1464,28 +1437,15 @@ static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (type == ADMA) {
 		rc = nv_adma_host_init(probe_ent);
 		if (rc)
-			goto err_out_iounmap;
+			return rc;
 	}
 
 	rc = ata_device_add(probe_ent);
 	if (rc != NV_PORTS)
-		goto err_out_iounmap;
-
-	kfree(probe_ent);
+		return -ENODEV;
 
+	devm_kfree(&pdev->dev, probe_ent);
 	return 0;
-
-err_out_iounmap:
-	pci_iounmap(pdev, probe_ent->mmio_base);
-err_out_free_ent:
-	kfree(probe_ent);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out_disable:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-err_out:
-	return rc;
 }
 
 static void nv_ck804_host_stop(struct ata_host *host)
@@ -1497,8 +1457,6 @@ static void nv_ck804_host_stop(struct ata_host *host)
 	pci_read_config_byte(pdev, NV_MCP_SATA_CFG_20, &regval);
 	regval &= ~NV_MCP_SATA_CFG_20_SATA_SPACE_EN;
 	pci_write_config_byte(pdev, NV_MCP_SATA_CFG_20, regval);
-
-	ata_pci_host_stop(host);
 }
 
 static void nv_adma_host_stop(struct ata_host *host)
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index f055874..7670e2f 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -42,7 +42,6 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
-#include <asm/io.h>
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
@@ -100,14 +99,12 @@ static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 static irqreturn_t pdc_interrupt (int irq, void *dev_instance);
 static void pdc_eng_timeout(struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
-static void pdc_port_stop(struct ata_port *ap);
 static void pdc_pata_phy_reset(struct ata_port *ap);
 static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_irq_clear(struct ata_port *ap);
 static unsigned int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
-static void pdc_host_stop(struct ata_host *host);
 static void pdc_freeze(struct ata_port *ap);
 static void pdc_thaw(struct ata_port *ap);
 static void pdc_error_handler(struct ata_port *ap);
@@ -153,8 +150,6 @@ static const struct ata_port_operations pdc_sata_ops = {
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
-	.port_stop		= pdc_port_stop,
-	.host_stop		= pdc_host_stop,
 };
 
 static const struct ata_port_operations pdc_pata_ops = {
@@ -175,8 +170,6 @@ static const struct ata_port_operations pdc_pata_ops = {
 	.irq_clear		= pdc_irq_clear,
 
 	.port_start		= pdc_port_start,
-	.port_stop		= pdc_port_stop,
-	.host_stop		= pdc_host_stop,
 };
 
 static const struct ata_port_info pdc_port_info[] = {
@@ -275,17 +268,13 @@ static int pdc_port_start(struct ata_port *ap)
 	if (rc)
 		return rc;
 
-	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
 
-	pp->pkt = dma_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
-	if (!pp->pkt) {
-		rc = -ENOMEM;
-		goto err_out_kfree;
-	}
+	pp->pkt = dmam_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
+	if (!pp->pkt)
+		return -ENOMEM;
 
 	ap->private_data = pp;
 
@@ -300,37 +289,8 @@ static int pdc_port_start(struct ata_port *ap)
 	}
 
 	return 0;
-
-err_out_kfree:
-	kfree(pp);
-err_out:
-	ata_port_stop(ap);
-	return rc;
 }
 
-
-static void pdc_port_stop(struct ata_port *ap)
-{
-	struct device *dev = ap->host->dev;
-	struct pdc_port_priv *pp = ap->private_data;
-
-	ap->private_data = NULL;
-	dma_free_coherent(dev, 128, pp->pkt, pp->pkt_dma);
-	kfree(pp);
-	ata_port_stop(ap);
-}
-
-
-static void pdc_host_stop(struct ata_host *host)
-{
-	struct pdc_host_priv *hp = host->private_data;
-
-	ata_pci_host_stop(host);
-
-	kfree(hp);
-}
-
-
 static void pdc_reset_port(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT;
@@ -733,55 +693,48 @@ static void pdc_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
 static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent = NULL;
+	struct ata_probe_ent *probe_ent;
 	struct pdc_host_priv *hp;
 	unsigned long base;
 	void __iomem *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 
-	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		return -ENOMEM;
 
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = pci_iomap(pdev, 3, 0);
-	if (mmio_base == NULL) {
-		rc = -ENOMEM;
-		goto err_out_free_ent;
-	}
+	mmio_base = pcim_iomap(pdev, 3, 0);
+	if (mmio_base == NULL)
+		return -ENOMEM;
 	base = (unsigned long) mmio_base;
 
-	hp = kzalloc(sizeof(*hp), GFP_KERNEL);
-	if (hp == NULL) {
-		rc = -ENOMEM;
-		goto err_out_free_ent;
-	}
+	hp = devm_kzalloc(&pdev->dev, sizeof(*hp), GFP_KERNEL);
+	if (hp == NULL)
+		return -ENOMEM;
 
 	probe_ent->private_data = hp;
 
@@ -841,22 +794,11 @@ static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	/* initialize adapter */
 	pdc_host_init(board_idx, probe_ent);
 
-	/* FIXME: Need any other frees than hp? */
 	if (!ata_device_add(probe_ent))
-		kfree(hp);
-
-	kfree(probe_ent);
+		return -ENODEV;
 
+	devm_kfree(&pdev->dev, probe_ent);
 	return 0;
-
-err_out_free_ent:
-	kfree(probe_ent);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-	return rc;
 }
 
 
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 710909d..2e4bf82 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -37,7 +37,6 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
-#include <asm/io.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_qstor"
@@ -117,7 +116,6 @@ static int qs_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *en
 static irqreturn_t qs_intr (int irq, void *dev_instance);
 static int qs_port_start(struct ata_port *ap);
 static void qs_host_stop(struct ata_host *host);
-static void qs_port_stop(struct ata_port *ap);
 static void qs_phy_reset(struct ata_port *ap);
 static void qs_qc_prep(struct ata_queued_cmd *qc);
 static unsigned int qs_qc_issue(struct ata_queued_cmd *qc);
@@ -164,7 +162,6 @@ static const struct ata_port_operations qs_ata_ops = {
 	.scr_read		= qs_scr_read,
 	.scr_write		= qs_scr_write,
 	.port_start		= qs_port_start,
-	.port_stop		= qs_port_stop,
 	.host_stop		= qs_host_stop,
 	.bmdma_stop		= qs_bmdma_stop,
 	.bmdma_status		= qs_bmdma_status,
@@ -501,17 +498,13 @@ static int qs_port_start(struct ata_port *ap)
 	if (rc)
 		return rc;
 	qs_enter_reg_mode(ap);
-	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
-	pp->pkt = dma_alloc_coherent(dev, QS_PKT_BYTES, &pp->pkt_dma,
-								GFP_KERNEL);
-	if (!pp->pkt) {
-		rc = -ENOMEM;
-		goto err_out_kfree;
-	}
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+	pp->pkt = dmam_alloc_coherent(dev, QS_PKT_BYTES, &pp->pkt_dma,
+				      GFP_KERNEL);
+	if (!pp->pkt)
+		return -ENOMEM;
 	memset(pp->pkt, 0, QS_PKT_BYTES);
 	ap->private_data = pp;
 
@@ -519,38 +512,14 @@ static int qs_port_start(struct ata_port *ap)
 	writel((u32) addr,        chan + QS_CCF_CPBA);
 	writel((u32)(addr >> 32), chan + QS_CCF_CPBA + 4);
 	return 0;
-
-err_out_kfree:
-	kfree(pp);
-err_out:
-	ata_port_stop(ap);
-	return rc;
-}
-
-static void qs_port_stop(struct ata_port *ap)
-{
-	struct device *dev = ap->host->dev;
-	struct qs_port_priv *pp = ap->private_data;
-
-	if (pp != NULL) {
-		ap->private_data = NULL;
-		if (pp->pkt != NULL)
-			dma_free_coherent(dev, QS_PKT_BYTES, pp->pkt,
-								pp->pkt_dma);
-		kfree(pp);
-	}
-	ata_port_stop(ap);
 }
 
 static void qs_host_stop(struct ata_host *host)
 {
 	void __iomem *mmio_base = host->mmio_base;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
 
 	writeb(0, mmio_base + QS_HCT_CTRL); /* disable host interrupts */
 	writeb(QS_CNFG3_GSRST, mmio_base + QS_HCF_CNFG3); /* global reset */
-
-	pci_iounmap(pdev, mmio_base);
 }
 
 static void qs_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
@@ -638,36 +607,29 @@ static int qs_ata_init_one(struct pci_dev *pdev,
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
-		goto err_out;
+		return rc;
 
-	if ((pci_resource_flags(pdev, 4) & IORESOURCE_MEM) == 0) {
-		rc = -ENODEV;
-		goto err_out_regions;
-	}
+	if ((pci_resource_flags(pdev, 4) & IORESOURCE_MEM) == 0)
+		return -ENODEV;
 
-	mmio_base = pci_iomap(pdev, 4, 0);
-	if (mmio_base == NULL) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	mmio_base = pcim_iomap(pdev, 4, 0);
+	if (mmio_base == NULL)
+		return -ENOMEM;
 
 	rc = qs_set_dma_masks(pdev, mmio_base);
 	if (rc)
-		goto err_out_iounmap;
+		return rc;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
-		goto err_out_iounmap;
-	}
+	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		return -ENOMEM;
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
@@ -694,19 +656,11 @@ static int qs_ata_init_one(struct pci_dev *pdev,
 	/* initialize adapter */
 	qs_host_init(board_idx, probe_ent);
 
-	rc = ata_device_add(probe_ent);
-	kfree(probe_ent);
-	if (rc != QS_PORTS)
-		goto err_out_iounmap;
-	return 0;
+	if (ata_device_add(probe_ent) != QS_PORTS)
+		return -EIO;
 
-err_out_iounmap:
-	pci_iounmap(pdev, mmio_base);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	pci_disable_device(pdev);
-	return rc;
+	devm_kfree(&pdev->dev, probe_ent);
+	return 0;
 }
 
 static int __init qs_ata_init(void)
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index ca7111a..1be1696 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -210,8 +210,6 @@ static const struct ata_port_operations sil_ops = {
 	.scr_read		= sil_scr_read,
 	.scr_write		= sil_scr_write,
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static const struct ata_port_info sil_port_info[] = {
@@ -621,38 +619,36 @@ static void sil_init_controller(struct pci_dev *pdev,
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent = NULL;
+	struct device *dev = &pdev->dev;
+	struct ata_probe_ent *probe_ent;
 	unsigned long base;
 	void __iomem *mmio_base;
 	int rc;
 	unsigned int i;
-	int pci_dev_busy = 0;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 
-	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		return -ENOMEM;
 
 	INIT_LIST_HEAD(&probe_ent->node);
 	probe_ent->dev = pci_dev_to_dev(pdev);
@@ -666,11 +662,9 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
        	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->port_flags = sil_port_info[ent->driver_data].flags;
 
-	mmio_base = pci_iomap(pdev, 5, 0);
-	if (mmio_base == NULL) {
-		rc = -ENOMEM;
-		goto err_out_free_ent;
-	}
+	mmio_base = pcim_iomap(pdev, 5, 0);
+	if (mmio_base == NULL)
+		return -ENOMEM;
 
 	probe_ent->mmio_base = mmio_base;
 
@@ -690,20 +684,11 @@ static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (!ata_device_add(probe_ent))
+		return -ENODEV;
 
+	devm_kfree(dev, probe_ent);
 	return 0;
-
-err_out_free_ent:
-	kfree(probe_ent);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-	return rc;
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index da982ed..c7a3c02 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -28,7 +28,6 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
-#include <asm/io.h>
 
 #define DRV_NAME	"sata_sil24"
 #define DRV_VERSION	"0.3"
@@ -341,8 +340,6 @@ static void sil24_thaw(struct ata_port *ap);
 static void sil24_error_handler(struct ata_port *ap);
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc);
 static int sil24_port_start(struct ata_port *ap);
-static void sil24_port_stop(struct ata_port *ap);
-static void sil24_host_stop(struct ata_host *host);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 #ifdef CONFIG_PM
 static int sil24_pci_device_resume(struct pci_dev *pdev);
@@ -362,7 +359,7 @@ static struct pci_driver sil24_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= sil24_pci_tbl,
 	.probe			= sil24_init_one,
-	.remove			= ata_pci_remove_one, /* safe? */
+	.remove			= ata_pci_remove_one,
 #ifdef CONFIG_PM
 	.suspend		= ata_pci_device_suspend,
 	.resume			= sil24_pci_device_resume,
@@ -416,8 +413,6 @@ static const struct ata_port_operations sil24_ops = {
 	.post_internal_cmd	= sil24_post_internal_cmd,
 
 	.port_start		= sil24_port_start,
-	.port_stop		= sil24_port_stop,
-	.host_stop		= sil24_host_stop,
 };
 
 /*
@@ -938,13 +933,6 @@ static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
 		sil24_init_port(ap);
 }
 
-static inline void sil24_cblk_free(struct sil24_port_priv *pp, struct device *dev)
-{
-	const size_t cb_size = sizeof(*pp->cmd_block) * SIL24_MAX_CMDS;
-
-	dma_free_coherent(dev, cb_size, pp->cmd_block, pp->cmd_block_dma);
-}
-
 static int sil24_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
@@ -952,22 +940,22 @@ static int sil24_port_start(struct ata_port *ap)
 	union sil24_cmd_block *cb;
 	size_t cb_size = sizeof(*cb) * SIL24_MAX_CMDS;
 	dma_addr_t cb_dma;
-	int rc = -ENOMEM;
+	int rc;
 
-	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
-		goto err_out;
+		return -ENOMEM;
 
 	pp->tf.command = ATA_DRDY;
 
-	cb = dma_alloc_coherent(dev, cb_size, &cb_dma, GFP_KERNEL);
+	cb = dmam_alloc_coherent(dev, cb_size, &cb_dma, GFP_KERNEL);
 	if (!cb)
-		goto err_out_pp;
+		return -ENOMEM;
 	memset(cb, 0, cb_size);
 
 	rc = ata_pad_alloc(ap, dev);
 	if (rc)
-		goto err_out_pad;
+		return rc;
 
 	pp->cmd_block = cb;
 	pp->cmd_block_dma = cb_dma;
@@ -975,33 +963,6 @@ static int sil24_port_start(struct ata_port *ap)
 	ap->private_data = pp;
 
 	return 0;
-
-err_out_pad:
-	sil24_cblk_free(pp, dev);
-err_out_pp:
-	kfree(pp);
-err_out:
-	return rc;
-}
-
-static void sil24_port_stop(struct ata_port *ap)
-{
-	struct device *dev = ap->host->dev;
-	struct sil24_port_priv *pp = ap->private_data;
-
-	sil24_cblk_free(pp, dev);
-	ata_pad_free(ap, dev);
-	kfree(pp);
-}
-
-static void sil24_host_stop(struct ata_host *host)
-{
-	struct sil24_host_priv *hpriv = host->private_data;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-
-	pci_iounmap(pdev, hpriv->host_base);
-	pci_iounmap(pdev, hpriv->port_base);
-	kfree(hpriv);
 }
 
 static void sil24_init_controller(struct pci_dev *pdev, int n_ports,
@@ -1066,43 +1027,38 @@ static void sil24_init_controller(struct pci_dev *pdev, int n_ports,
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
+	struct device *dev = &pdev->dev;
 	unsigned int board_id = (unsigned int)ent->driver_data;
 	struct ata_port_info *pinfo = &sil24_port_info[board_id];
-	struct ata_probe_ent *probe_ent = NULL;
-	struct sil24_host_priv *hpriv = NULL;
-	void __iomem *host_base = NULL;
-	void __iomem *port_base = NULL;
+	struct ata_probe_ent *probe_ent;
+	struct sil24_host_priv *hpriv;
+	void __iomem *host_base;
+	void __iomem *port_base;
 	int i, rc;
 	u32 tmp;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
-		goto out_disable;
+		return rc;
 
-	rc = -ENOMEM;
 	/* map mmio registers */
-	host_base = pci_iomap(pdev, 0, 0);
-	if (!host_base)
-		goto out_free;
-	port_base = pci_iomap(pdev, 2, 0);
-	if (!port_base)
-		goto out_free;
+	host_base = pcim_iomap(pdev, 0, 0);
+	port_base = pcim_iomap(pdev, 2, 0);
+	if (!host_base || !port_base)
+		return -ENOMEM;
 
 	/* allocate & init probe_ent and hpriv */
-	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (!probe_ent)
-		goto out_free;
-
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv)
-		goto out_free;
+	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
+	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!probe_ent || !hpriv)
+		return -ENOMEM;
 
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
@@ -1132,7 +1088,7 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			if (rc) {
 				dev_printk(KERN_ERR, &pdev->dev,
 					   "64-bit DMA enable failed\n");
-				goto out_free;
+				return rc;
 			}
 		}
 	} else {
@@ -1140,13 +1096,13 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (rc) {
 			dev_printk(KERN_ERR, &pdev->dev,
 				   "32-bit DMA enable failed\n");
-			goto out_free;
+			return rc;
 		}
 		rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			dev_printk(KERN_ERR, &pdev->dev,
 				   "32-bit consistent DMA enable failed\n");
-			goto out_free;
+			return rc;
 		}
 	}
 
@@ -1176,23 +1132,11 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
+	if (!ata_device_add(probe_ent))
+		return -ENODEV;
 
-	kfree(probe_ent);
+	devm_kfree(dev, probe_ent);
 	return 0;
-
- out_free:
-	if (host_base)
-		pci_iounmap(pdev, host_base);
-	if (port_base)
-		pci_iounmap(pdev, port_base);
-	kfree(probe_ent);
-	kfree(hpriv);
-	pci_release_regions(pdev);
- out_disable:
-	pci_disable_device(pdev);
-	return rc;
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 9c25a1e..d27f6cf 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -122,8 +122,6 @@ static const struct ata_port_operations sis_ops = {
 	.scr_read		= sis_scr_read,
 	.scr_write		= sis_scr_write,
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info sis_port_info = {
@@ -241,29 +239,28 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	int rc;
 	u32 genctl, val;
 	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
-	int pci_dev_busy = 0;
 	u8 pmr;
 	u8 port2_start;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 
 	/* check and see if the SCRs are in IO space or PCI cfg space */
 	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
@@ -307,10 +304,8 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	if (!probe_ent)
+		return -ENOMEM;
 
 	if (!(probe_ent->port_flags & SIS_FLAG_CFGSCR)) {
 		probe_ent->port[0].scr_addr =
@@ -322,20 +317,12 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_intx(pdev, 1);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (!ata_device_add(probe_ent))
+		return -EIO;
 
+	devm_kfree(&pdev->dev, probe_ent);
 	return 0;
 
-err_out_regions:
-	pci_release_regions(pdev);
-
-err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-	return rc;
-
 }
 
 static int __init sis_init(void)
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index 46d8a94..93037eb 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -359,8 +359,6 @@ static const struct ata_port_operations k2_sata_ops = {
 	.scr_read		= k2_sata_scr_read,
 	.scr_write		= k2_sata_scr_write,
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
@@ -386,12 +384,12 @@ static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
 static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent = NULL;
+	struct device *dev = &pdev->dev;
+	struct ata_probe_ent *probe_ent;
 	unsigned long base;
 	void __iomem *mmio_base;
 	const struct k2_board_info *board_info =
 			&k2_board_info[ent->driver_data];
-	int pci_dev_busy = 0;
 	int rc;
 	int i;
 
@@ -402,7 +400,7 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	 * If this driver happens to only be useful on Apple's K2, then
 	 * we should check that here as it has a normal Serverworks ID
 	 */
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 	/*
@@ -415,32 +413,27 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	/* Request PCI regions */
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	probe_ent = devm_kzalloc(dev, sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		return -ENOMEM;
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = pci_iomap(pdev, 5, 0);
-	if (mmio_base == NULL) {
-		rc = -ENOMEM;
-		goto err_out_free_ent;
-	}
+	mmio_base = pcim_iomap(pdev, 5, 0);
+	if (mmio_base == NULL)
+		return -ENOMEM;
 	base = (unsigned long) mmio_base;
 
 	/* Clear a magic bit in SCR1 according to Darwin, those help
@@ -478,20 +471,11 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 
 	pci_set_master(pdev);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (!ata_device_add(probe_ent))
+		return -ENODEV;
 
+	devm_kfree(dev, probe_ent);
 	return 0;
-
-err_out_free_ent:
-	kfree(probe_ent);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-	return rc;
 }
 
 /* 0x240 is device ID for Apple K2 device
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index ae7992d..d9838dc 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -42,7 +42,6 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
-#include <asm/io.h>
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_sx4"
@@ -156,11 +155,9 @@ static irqreturn_t pdc20621_interrupt (int irq, void *dev_instance);
 static void pdc_eng_timeout(struct ata_port *ap);
 static void pdc_20621_phy_reset (struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
-static void pdc_port_stop(struct ata_port *ap);
 static void pdc20621_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
-static void pdc20621_host_stop(struct ata_host *host);
 static unsigned int pdc20621_dimm_init(struct ata_probe_ent *pe);
 static int pdc20621_detect_dimm(struct ata_probe_ent *pe);
 static unsigned int pdc20621_i2c_read(struct ata_probe_ent *pe,
@@ -210,8 +207,6 @@ static const struct ata_port_operations pdc_20621_ops = {
 	.irq_handler		= pdc20621_interrupt,
 	.irq_clear		= pdc20621_irq_clear,
 	.port_start		= pdc_port_start,
-	.port_stop		= pdc_port_stop,
-	.host_stop		= pdc20621_host_stop,
 };
 
 static const struct ata_port_info pdc_port_info[] = {
@@ -243,18 +238,6 @@ static struct pci_driver pdc_sata_pci_driver = {
 };
 
 
-static void pdc20621_host_stop(struct ata_host *host)
-{
-	struct pci_dev *pdev = to_pci_dev(host->dev);
-	struct pdc_host_priv *hpriv = host->private_data;
-	void __iomem *dimm_mmio = hpriv->dimm_mmio;
-
-	pci_iounmap(pdev, dimm_mmio);
-	kfree(hpriv);
-
-	pci_iounmap(pdev, host->mmio_base);
-}
-
 static int pdc_port_start(struct ata_port *ap)
 {
 	struct device *dev = ap->host->dev;
@@ -265,43 +248,19 @@ static int pdc_port_start(struct ata_port *ap)
 	if (rc)
 		return rc;
 
-	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
-	if (!pp) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
-	memset(pp, 0, sizeof(*pp));
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
 
-	pp->pkt = dma_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
-	if (!pp->pkt) {
-		rc = -ENOMEM;
-		goto err_out_kfree;
-	}
+	pp->pkt = dmam_alloc_coherent(dev, 128, &pp->pkt_dma, GFP_KERNEL);
+	if (!pp->pkt)
+		return -ENOMEM;
 
 	ap->private_data = pp;
 
 	return 0;
-
-err_out_kfree:
-	kfree(pp);
-err_out:
-	ata_port_stop(ap);
-	return rc;
-}
-
-
-static void pdc_port_stop(struct ata_port *ap)
-{
-	struct device *dev = ap->host->dev;
-	struct pdc_port_priv *pp = ap->private_data;
-
-	ap->private_data = NULL;
-	dma_free_coherent(dev, 128, pp->pkt, pp->pkt_dma);
-	kfree(pp);
-	ata_port_stop(ap);
 }
 
-
 static void pdc_20621_phy_reset (struct ata_port *ap)
 {
 	VPRINTK("ENTER\n");
@@ -1365,65 +1324,53 @@ static void pdc_20621_init(struct ata_probe_ent *pe)
 static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_probe_ent *probe_ent = NULL;
+	struct ata_probe_ent *probe_ent;
 	unsigned long base;
 	void __iomem *mmio_base;
-	void __iomem *dimm_mmio = NULL;
-	struct pdc_host_priv *hpriv = NULL;
+	void __iomem *dimm_mmio;
+	struct pdc_host_priv *hpriv;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int pci_dev_busy = 0;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		return -ENOMEM;
 
-	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = pci_iomap(pdev, 3, 0);
-	if (mmio_base == NULL) {
-		rc = -ENOMEM;
-		goto err_out_free_ent;
-	}
+	mmio_base = pcim_iomap(pdev, 3, 0);
+	if (mmio_base == NULL)
+		return -ENOMEM;
 	base = (unsigned long) mmio_base;
 
-	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv) {
-		rc = -ENOMEM;
-		goto err_out_iounmap;
-	}
-	memset(hpriv, 0, sizeof(*hpriv));
+	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
 
-	dimm_mmio = pci_iomap(pdev, 4, 0);
-	if (!dimm_mmio) {
-		kfree(hpriv);
-		rc = -ENOMEM;
-		goto err_out_iounmap;
-	}
+	dimm_mmio = pcim_iomap(pdev, 4, 0);
+	if (!dimm_mmio)
+		return -ENOMEM;
 
 	hpriv->dimm_mmio = dimm_mmio;
 
@@ -1451,31 +1398,15 @@ static int pdc_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *
 
 	/* initialize adapter */
 	/* initialize local dimm */
-	if (pdc20621_dimm_init(probe_ent)) {
-		rc = -ENOMEM;
-		goto err_out_iounmap_dimm;
-	}
+	if (pdc20621_dimm_init(probe_ent))
+		return -ENOMEM;
 	pdc_20621_init(probe_ent);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (!ata_device_add(probe_ent))
+		return -ENODEV;
 
+	devm_kfree(&pdev->dev, probe_ent);
 	return 0;
-
-err_out_iounmap_dimm:		/* only get to this label if 20621 */
-	kfree(hpriv);
-	pci_iounmap(pdev, dimm_mmio);
-err_out_iounmap:
-	pci_iounmap(pdev, mmio_base);
-err_out_free_ent:
-	kfree(probe_ent);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-	return rc;
 }
 
 
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 5c603ca..a65c15d 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -122,8 +122,6 @@ static const struct ata_port_operations uli_ops = {
 	.scr_write		= uli_scr_write,
 
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info uli_port_info = {
@@ -188,41 +186,36 @@ static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ata_port_info *ppi[2];
 	int rc;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
-	int pci_dev_busy = 0;
 	struct uli_priv *hpriv;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 
 	ppi[0] = ppi[1] = &uli_port_info;
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
-	if (!probe_ent) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
+	if (!probe_ent)
+		return -ENOMEM;
 
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv) {
-		rc = -ENOMEM;
-		goto err_out_probe_ent;
-	}
+	hpriv = devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
 
 	probe_ent->private_data = hpriv;
 
@@ -268,21 +261,11 @@ static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_intx(pdev, 1);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (!ata_device_add(probe_ent))
+		return -ENODEV;
 
+	devm_kfree(&pdev->dev, probe_ent);
 	return 0;
-
-err_out_probe_ent:
-	kfree(probe_ent);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-	return rc;
-
 }
 
 static int __init uli_init(void)
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 1c7f19a..643dcae 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -44,7 +44,6 @@
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
 #include <linux/libata.h>
-#include <asm/io.h>
 
 #define DRV_NAME	"sata_via"
 #define DRV_VERSION	"2.0"
@@ -136,8 +135,6 @@ static const struct ata_port_operations vt6420_sata_ops = {
 	.irq_clear		= ata_bmdma_irq_clear,
 
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
 };
 
 static const struct ata_port_operations vt6421_sata_ops = {
@@ -170,8 +167,6 @@ static const struct ata_port_operations vt6421_sata_ops = {
 	.scr_write		= svia_scr_write,
 
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info vt6420_port_info = {
@@ -338,7 +333,7 @@ static struct ata_probe_ent *vt6421_init_probe_ent(struct pci_dev *pdev)
 	struct ata_probe_ent *probe_ent;
 	unsigned int i;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent)
 		return NULL;
 
@@ -409,20 +404,19 @@ static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ata_probe_ent *probe_ent;
 	int board_id = (int) ent->driver_data;
 	const int *bar_sizes;
-	int pci_dev_busy = 0;
 	u8 tmp8;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
 	if (board_id == vt6420) {
@@ -431,8 +425,7 @@ static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 			dev_printk(KERN_ERR, &pdev->dev,
 				   "SATA master/slave not supported (0x%x)\n",
 		       		   (int) tmp8);
-			rc = -EIO;
-			goto err_out_regions;
+			return -EIO;
 		}
 
 		bar_sizes = &svia_bar_sizes[0];
@@ -448,16 +441,15 @@ static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 				i,
 			        (unsigned long long)pci_resource_start(pdev, i),
 			        (unsigned long long)pci_resource_len(pdev, i));
-			rc = -ENODEV;
-			goto err_out_regions;
+			return -ENODEV;
 		}
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 
 	if (board_id == vt6420)
 		probe_ent = vt6420_init_probe_ent(pdev);
@@ -466,26 +458,18 @@ static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (!probe_ent) {
 		dev_printk(KERN_ERR, &pdev->dev, "out of memory\n");
-		rc = -ENOMEM;
-		goto err_out_regions;
+		return -ENOMEM;
 	}
 
 	svia_configure(pdev);
 
 	pci_set_master(pdev);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (!ata_device_add(probe_ent))
+		return -ENODEV;
 
+	devm_kfree(&pdev->dev, probe_ent);
 	return 0;
-
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-	return rc;
 }
 
 static int __init svia_init(void)
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 0fa1b89..107d9fd 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -311,8 +311,6 @@ static const struct ata_port_operations vsc_sata_ops = {
 	.scr_read		= vsc_sata_scr_read,
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
-	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
 };
 
 static void __devinit vsc_sata_setup_port(struct ata_ioports *port, unsigned long base)
@@ -342,29 +340,26 @@ static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_d
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
-	int pci_dev_busy = 0;
 	void __iomem *mmio_base;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	rc = pci_enable_device(pdev);
+	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
 	/*
 	 * Check if we have needed resource mapped.
 	 */
-	if (pci_resource_len(pdev, 0) == 0) {
-		rc = -ENODEV;
-		goto err_out;
-	}
+	if (pci_resource_len(pdev, 0) == 0)
+		return -ENODEV;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc) {
-		pci_dev_busy = 1;
-		goto err_out;
+		pcim_pin_device(pdev);
+		return rc;
 	}
 
 	/*
@@ -372,25 +367,20 @@ static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_d
 	 */
 	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
-		goto err_out_regions;
+		return rc;
 
-	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
-	if (probe_ent == NULL) {
-		rc = -ENOMEM;
-		goto err_out_regions;
-	}
-	memset(probe_ent, 0, sizeof(*probe_ent));
+	probe_ent = devm_kzalloc(&pdev->dev, sizeof(*probe_ent), GFP_KERNEL);
+	if (probe_ent == NULL)
+		return -ENOMEM;
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
-	mmio_base = pci_iomap(pdev, 0, 0);
-	if (mmio_base == NULL) {
-		rc = -ENOMEM;
-		goto err_out_free_ent;
-	}
+	mmio_base = pcim_iomap(pdev, 0, 0);
+	if (mmio_base == NULL)
+		return -ENOMEM;
 	base = (unsigned long) mmio_base;
 
 	/*
@@ -430,20 +420,11 @@ static int __devinit vsc_sata_init_one (struct pci_dev *pdev, const struct pci_d
 	 */
 	pci_write_config_dword(pdev, 0x98, 0);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (!ata_device_add(probe_ent))
+		return -ENODEV;
 
+	devm_kfree(&pdev->dev, probe_ent);
 	return 0;
-
-err_out_free_ent:
-	kfree(probe_ent);
-err_out_regions:
-	pci_release_regions(pdev);
-err_out:
-	if (!pci_dev_busy)
-		pci_disable_device(pdev);
-	return rc;
 }
 
 static const struct pci_device_id vsc_sata_pci_tbl[] = {
-- 
1.4.4.2


