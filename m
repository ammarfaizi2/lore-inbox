Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVL2XXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVL2XXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVL2XXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:23:48 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:42557 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751152AbVL2XXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:23:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=j+KyY05dvJMGSdNQh2WIfq7GPpQ8m+raycsrNH5k/rlIDl5ivRry2kKFvivAdDfImzzfiYe4InOOrZH6WVoHtNQ//m/ZSprUw54LUV9wGfULkcB5IegV4Rc6DMWKyIwHsKiLTpoXxaB/eIhn7IGEDXnRExPLNp19DW0M8dUIsSE=
Message-ID: <355e5e5e0512291523h508fe0c8j459a9377d52d5529@mail.gmail.com>
Date: Thu, 29 Dec 2005 18:23:46 -0500
From: Lukasz Kosewski <lkosewsk@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH 2.6.15-rc7-git3 1/3] sata_promise: add correct read/write of hotplug registers for SATAII devices
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7586_23340332.1135898626160"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_7586_23340332.1135898626160
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

VGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIGNvcnJlY3RseSBtYXNraW5nIG91dCBhbmQga25v
d2luZyBhYm91dApob3RwbHVnIGV2ZW50cyBvbiBQcm9taXNlIFNBVEFJSTE1MCBUeDQvVHgyIFBs
dXMgY29udHJvbGxlcnMuCgpTaWduZWQtb2ZmLWJ5OiAgTHVrZSBLb3Nld3NraSA8bGtvc2V3c2tA
Z21haWwuY29tPgoKTHVrZSBLb3Nld3NraQo=
------=_Part_7586_23340332.1135898626160
Content-Type: text/x-patch; 
	name=01-promise_sataII150_support-2.6.15-rc7-git3.diff; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01-promise_sataII150_support-2.6.15-rc7-git3.diff"

29.12.05    Luke Kosewski   <lkosewsk@gmail.com>

	* A patch to the sata_promise driver in libata for it to correctly mask
	  out and understand hotplug interrupts on SATAII150 controllers.

	Signed-off-by:  Luke Kosewski <lkosewsk@gmail.com>

--- linux-2.6.15-rc7/drivers/scsi/sata_promise.c.old	2005-12-28 17:11:42.000000000 -0500
+++ linux-2.6.15-rc7/drivers/scsi/sata_promise.c	2005-12-28 17:44:22.000000000 -0500
@@ -58,6 +58,7 @@ enum {
 	PDC_GLOBAL_CTL		= 0x48, /* Global control/status (per port) */
 	PDC_CTLSTAT		= 0x60,	/* IDE control and status (per port) */
 	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
+	PDC2_SATA_PLUG_CSR	= 0x60, /* SATAII Plug control/status reg */
 	PDC_SLEW_CTL		= 0x470, /* slew rate control reg */
 
 	PDC_ERR_MASK		= (1<<19) | (1<<20) | (1<<21) | (1<<22) |
@@ -66,8 +67,10 @@ enum {
 	board_2037x		= 0,	/* FastTrak S150 TX2plus */
 	board_20319		= 1,	/* FastTrak S150 TX4 */
 	board_20619		= 2,	/* FastTrak TX4000 */
+	board_2057x		= 3,	/* SATAII150 Tx2plus */
+	board_40518		= 4,	/* SATAII150 Tx4 */
 
-	PDC_HAS_PATA		= (1 << 1), /* PDC20375 has PATA */
+	PDC_HAS_PATA		= (1 << 1), /* PDC20375/20575 has PATA */
 
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 
@@ -81,6 +84,10 @@ struct pdc_port_priv {
 	dma_addr_t		pkt_dma;
 };
 
+struct pdc_host_priv {
+	int			hotplug_offset;
+};
+
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static int pdc_ata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -95,6 +102,7 @@ static void pdc_tf_load_mmio(struct ata_
 static void pdc_exec_command_mmio(struct ata_port *ap, const struct ata_taskfile *tf);
 static void pdc_irq_clear(struct ata_port *ap);
 static int pdc_qc_issue_prot(struct ata_queued_cmd *qc);
+static void pdc_host_stop(struct ata_host_set *host_set);
 
 
 static struct scsi_host_template pdc_ata_sht = {
@@ -137,7 +145,7 @@ static const struct ata_port_operations 
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
-	.host_stop		= ata_pci_host_stop,
+	.host_stop		= pdc_host_stop,
 };
 
 static const struct ata_port_operations pdc_pata_ops = {
@@ -158,7 +166,7 @@ static const struct ata_port_operations 
 
 	.port_start		= pdc_port_start,
 	.port_stop		= pdc_port_stop,
-	.host_stop		= ata_pci_host_stop,
+	.host_stop		= pdc_host_stop,
 };
 
 static struct ata_port_info pdc_port_info[] = {
@@ -191,6 +199,26 @@ static struct ata_port_info pdc_port_inf
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &pdc_pata_ops,
 	},
+
+	/* board_2057x */
+	{
+		.sht		= &pdc_ata_sht,
+		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc_sata_ops,
+	},
+
+	/* board_40518 */
+	{
+		.sht		= &pdc_ata_sht,
+		.host_flags	= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &pdc_sata_ops,
+	},
 };
 
 static const struct pci_device_id pdc_ata_pci_tbl[] = {
@@ -207,9 +235,9 @@ static const struct pci_device_id pdc_at
 	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3574, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
+	  board_2057x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_2037x },
+	  board_2057x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d73, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 
@@ -222,7 +250,7 @@ static const struct pci_device_id pdc_at
 	{ PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-	  board_20319 },
+	  board_40518 },
 
 	{ PCI_VENDOR_ID_PROMISE, 0x6629, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20619 },
@@ -286,6 +314,16 @@ static void pdc_port_stop(struct ata_por
 }
 
 
+static void pdc_host_stop(struct ata_host_set *host_set)
+{
+	struct pdc_host_priv *hp = host_set->private_data;
+
+	ata_pci_host_stop(host_set);
+
+	kfree(hp);
+}
+
+
 static void pdc_reset_port(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr + PDC_CTLSTAT;
@@ -481,14 +519,15 @@ static irqreturn_t pdc_interrupt (int ir
 		VPRINTK("QUICK EXIT 2\n");
 		return IRQ_NONE;
 	}
+
+	spin_lock(&host_set->lock);
+
 	mask &= 0xffff;		/* only 16 tags possible */
 	if (!mask) {
 		VPRINTK("QUICK EXIT 3\n");
-		return IRQ_NONE;
+		goto done_irq;
 	}
 
-	spin_lock(&host_set->lock);
-
 	writel(mask, mmio_base + PDC_INT_SEQMASK);
 
 	for (i = 0; i < host_set->n_ports; i++) {
@@ -505,10 +544,10 @@ static irqreturn_t pdc_interrupt (int ir
 		}
 	}
 
-        spin_unlock(&host_set->lock);
-
 	VPRINTK("EXIT\n");
 
+done_irq:
+	spin_unlock(&host_set->lock);
 	return IRQ_RETVAL(handled);
 }
 
@@ -586,6 +625,8 @@ static void pdc_ata_setup_port(struct at
 static void pdc_host_init(unsigned int chip_id, struct ata_probe_ent *pe)
 {
 	void __iomem *mmio = pe->mmio_base;
+	struct pdc_host_priv *hp = pe->private_data;
+	int hotplug_offset = hp->hotplug_offset;
 	u32 tmp;
 
 	/*
@@ -600,12 +641,12 @@ static void pdc_host_init(unsigned int c
 	writel(tmp, mmio + PDC_FLASH_CTL);
 
 	/* clear plug/unplug flags for all ports */
-	tmp = readl(mmio + PDC_SATA_PLUG_CSR);
-	writel(tmp | 0xff, mmio + PDC_SATA_PLUG_CSR);
+	tmp = readl(mmio + hotplug_offset);
+	writel(tmp | 0xff, mmio + hotplug_offset);
 
 	/* mask plug/unplug ints */
-	tmp = readl(mmio + PDC_SATA_PLUG_CSR);
-	writel(tmp | 0xff0000, mmio + PDC_SATA_PLUG_CSR);
+	tmp = readl(mmio + hotplug_offset);
+	writel(tmp | 0xff0000, mmio + hotplug_offset);
 
 	/* reduce TBG clock to 133 Mhz. */
 	tmp = readl(mmio + PDC_TBG_MODE);
@@ -627,6 +668,7 @@ static int pdc_ata_init_one (struct pci_
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
+	struct pdc_host_priv *hp;
 	unsigned long base;
 	void __iomem *mmio_base;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
@@ -674,6 +716,17 @@ static int pdc_ata_init_one (struct pci_
 	}
 	base = (unsigned long) mmio_base;
 
+	hp = kmalloc(sizeof(*hp), GFP_KERNEL);
+	if (hp == NULL) {
+		rc = -ENOMEM;
+		goto err_out_free_ent;
+	}
+	memset(hp, 0, sizeof(*hp));
+
+	/* Set default hotplug offset */
+	hp->hotplug_offset = PDC_SATA_PLUG_CSR;
+	probe_ent->private_data = hp;
+
 	probe_ent->sht		= pdc_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc_port_info[board_idx].host_flags;
 	probe_ent->pio_mask	= pdc_port_info[board_idx].pio_mask;
@@ -693,6 +746,10 @@ static int pdc_ata_init_one (struct pci_
 
 	/* notice 4-port boards */
 	switch (board_idx) {
+	case board_40518:
+		/* Override hotplug offset for SATAII150 */
+		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
+		/* Fall through */
 	case board_20319:
        		probe_ent->n_ports = 4;
 
@@ -702,6 +759,10 @@ static int pdc_ata_init_one (struct pci_
 		probe_ent->port[2].scr_addr = base + 0x600;
 		probe_ent->port[3].scr_addr = base + 0x700;
 		break;
+	case board_2057x:
+		/* Override hotplug offset for SATAII150 */
+		hp->hotplug_offset = PDC2_SATA_PLUG_CSR;
+		/* Fall through */
 	case board_2037x:
        		probe_ent->n_ports = 2;
 		break;
@@ -724,8 +785,10 @@ static int pdc_ata_init_one (struct pci_
 	/* initialize adapter */
 	pdc_host_init(board_idx, probe_ent);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
+	/* FIXME: Need any other frees than hp? */
+	if (!ata_device_add(probe_ent))
+		kfree(hp);
+
 	kfree(probe_ent);
 
 	return 0;



------=_Part_7586_23340332.1135898626160--
