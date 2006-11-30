Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935651AbWK3KsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935651AbWK3KsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935650AbWK3KsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:48:21 -0500
Received: from havoc.gtf.org ([69.61.125.42]:26773 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S935634AbWK3KsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:48:20 -0500
Date: Thu, 30 Nov 2006 05:48:18 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes
Message-ID: <20061130104818.GA29216@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW:  Immediately after a release (such as today's 2.6.19), I keep my
'upstream-fixes' branch alive, so that I can fast-forward bug fixes
upstream without my huge For-Next-Release pending queue ('upstream')
getting pushed.

That's what this is.  And I'll be sending a similar netdev bug fix push.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/ahci.c              |   27 ++++++++++++++++++++++-----
 drivers/ata/ata_generic.c       |    1 +
 drivers/ata/pata_ali.c          |    1 +
 drivers/ata/pata_amd.c          |    1 +
 drivers/ata/pata_artop.c        |    1 +
 drivers/ata/pata_atiixp.c       |    1 +
 drivers/ata/pata_cmd64x.c       |    1 +
 drivers/ata/pata_cs5520.c       |    1 +
 drivers/ata/pata_cs5530.c       |    1 +
 drivers/ata/pata_cs5535.c       |    1 +
 drivers/ata/pata_cypress.c      |    1 +
 drivers/ata/pata_efar.c         |    1 +
 drivers/ata/pata_hpt366.c       |    1 +
 drivers/ata/pata_hpt37x.c       |    1 +
 drivers/ata/pata_hpt3x2n.c      |    1 +
 drivers/ata/pata_hpt3x3.c       |    1 +
 drivers/ata/pata_isapnp.c       |    1 +
 drivers/ata/pata_it821x.c       |    1 +
 drivers/ata/pata_jmicron.c      |    1 +
 drivers/ata/pata_legacy.c       |    1 +
 drivers/ata/pata_mpiix.c        |    1 +
 drivers/ata/pata_netcell.c      |    1 +
 drivers/ata/pata_ns87410.c      |    1 +
 drivers/ata/pata_oldpiix.c      |    1 +
 drivers/ata/pata_opti.c         |    1 +
 drivers/ata/pata_optidma.c      |    1 +
 drivers/ata/pata_pcmcia.c       |    1 +
 drivers/ata/pata_pdc2027x.c     |    1 +
 drivers/ata/pata_pdc202xx_old.c |    1 +
 drivers/ata/pata_qdi.c          |    1 +
 drivers/ata/pata_radisys.c      |    1 +
 drivers/ata/pata_rz1000.c       |    1 +
 drivers/ata/pata_sc1200.c       |    1 +
 drivers/ata/pata_serverworks.c  |    1 +
 drivers/ata/pata_sil680.c       |    1 +
 drivers/ata/pata_sis.c          |    1 +
 drivers/ata/pata_sl82c105.c     |    1 +
 drivers/ata/pata_triflex.c      |    1 +
 drivers/ata/pata_via.c          |    1 +
 39 files changed, 60 insertions(+), 5 deletions(-)

Tejun Heo:
      ahci: ignore PORT_IRQ_IF_ERR on JMB controllers
      libata: add missing sht->slave_destroy

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f510e11..bddb14e 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -78,6 +78,7 @@ enum {
 
 	board_ahci		= 0,
 	board_ahci_vt8251	= 1,
+	board_ahci_ign_iferr	= 2,
 
 	/* global controller registers */
 	HOST_CAP		= 0x00, /* host capabilities */
@@ -168,6 +169,7 @@ enum {
 	/* ap->flags bits */
 	AHCI_FLAG_RESET_NEEDS_CLO	= (1 << 24),
 	AHCI_FLAG_NO_NCQ		= (1 << 25),
+	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 26), /* ignore IRQ_IF_ERR */
 };
 
 struct ahci_cmd_hdr {
@@ -295,6 +297,17 @@ static const struct ata_port_info ahci_p
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
 		.port_ops	= &ahci_ops,
 	},
+	/* board_ahci_ign_iferr */
+	{
+		.sht		= &ahci_sht,
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
+				  ATA_FLAG_SKIP_D2H_BSY |
+				  AHCI_FLAG_IGN_IRQ_IF_ERR,
+		.pio_mask	= 0x1f, /* pio0-4 */
+		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
+		.port_ops	= &ahci_ops,
+	},
 };
 
 static const struct pci_device_id ahci_pci_tbl[] = {
@@ -327,11 +340,11 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
 
 	/* JMicron */
-	{ PCI_VDEVICE(JMICRON, 0x2360), board_ahci }, /* JMicron JMB360 */
-	{ PCI_VDEVICE(JMICRON, 0x2361), board_ahci }, /* JMicron JMB361 */
-	{ PCI_VDEVICE(JMICRON, 0x2363), board_ahci }, /* JMicron JMB363 */
-	{ PCI_VDEVICE(JMICRON, 0x2365), board_ahci }, /* JMicron JMB365 */
-	{ PCI_VDEVICE(JMICRON, 0x2366), board_ahci }, /* JMicron JMB366 */
+	{ PCI_VDEVICE(JMICRON, 0x2360), board_ahci_ign_iferr }, /* JMB360 */
+	{ PCI_VDEVICE(JMICRON, 0x2361), board_ahci_ign_iferr }, /* JMB361 */
+	{ PCI_VDEVICE(JMICRON, 0x2363), board_ahci_ign_iferr }, /* JMB363 */
+	{ PCI_VDEVICE(JMICRON, 0x2365), board_ahci_ign_iferr }, /* JMB365 */
+	{ PCI_VDEVICE(JMICRON, 0x2366), board_ahci_ign_iferr }, /* JMB366 */
 
 	/* ATI */
 	{ PCI_VDEVICE(ATI, 0x4380), board_ahci }, /* ATI SB600 non-raid */
@@ -980,6 +993,10 @@ static void ahci_error_intr(struct ata_p
 	/* analyze @irq_stat */
 	ata_ehi_push_desc(ehi, "irq_stat 0x%08x", irq_stat);
 
+	/* some controllers set IRQ_IF_ERR on device errors, ignore it */
+	if (ap->flags & AHCI_FLAG_IGN_IRQ_IF_ERR)
+		irq_stat &= ~PORT_IRQ_IF_ERR;
+
 	if (irq_stat & PORT_IRQ_TF_ERR)
 		err_mask |= AC_ERR_DEV;
 
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 377425e..4a80ff9 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -116,6 +116,7 @@ static struct scsi_host_template generic
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 1d695df..64eed99 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -346,6 +346,7 @@ static struct scsi_host_template ali_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 5c47a9e..8be46a6 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -333,6 +333,7 @@ static struct scsi_host_template amd_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 96a0980..2cd3076 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -314,6 +314,7 @@ static struct scsi_host_template artop_s
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 1ce28d2..4e1d3b5 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -216,6 +216,7 @@ static struct scsi_host_template atiixp_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index b9bbd1d..29a60df 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -275,6 +275,7 @@ static struct scsi_host_template cmd64x_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 2cd3c0f..33d2b88 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -166,6 +166,7 @@ static struct scsi_host_template cs5520_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index a07cc81..981f492 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -180,6 +180,7 @@ static struct scsi_host_template cs5530_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index f8def3f..8dafa4a 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -184,6 +184,7 @@ static struct scsi_host_template cs5535_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index 247b436..5a0b811 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -135,6 +135,7 @@ static struct scsi_host_template cy82c69
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index ef18c60..755f792 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -233,6 +233,7 @@ static struct scsi_host_template efar_sh
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 6d3e4c0..c0e150a 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -329,6 +329,7 @@ static struct scsi_host_template hpt36x_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index fce3fcd..1eeb16f 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -775,6 +775,7 @@ static struct scsi_host_template hpt37x_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 58cfb2b..47d7664 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -341,6 +341,7 @@ static struct scsi_host_template hpt3x2n
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 3334d72..d216cc5 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -118,6 +118,7 @@ static struct scsi_host_template hpt3x3_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 640b8b0..40ca2b8 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -34,6 +34,7 @@ static struct scsi_host_template isapnp_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index 18ff3e5..7f68f14 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -675,6 +675,7 @@ static struct scsi_host_template it821x_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 52a2bdf..0210b10 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -136,6 +136,7 @@ static struct scsi_host_template jmicron
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
 };
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 10231ef..b39078b 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -135,6 +135,7 @@ static struct scsi_host_template legacy_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 9dfe3e9..e00d406 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -166,6 +166,7 @@ static struct scsi_host_template mpiix_s
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index f5672de..1963a4d 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -62,6 +62,7 @@ static struct scsi_host_template netcell
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	/* Use standard CHS mapping rules */
 	.bios_param		= ata_std_bios_param,
 };
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 2a3dbee..7ec800f 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -156,6 +156,7 @@ static struct scsi_host_template ns87410
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index fc947df..8837256 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -231,6 +231,7 @@ static struct scsi_host_template oldpiix
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index a7320ba..c6319cf 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -202,6 +202,7 @@ static struct scsi_host_template opti_sh
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index c6906b4..2f4770c 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -359,6 +359,7 @@ static struct scsi_host_template optidma
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index e93ea27..999922d 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -69,6 +69,7 @@ static struct scsi_host_template pcmcia_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index d894d99..beb6d10 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -141,6 +141,7 @@ static struct scsi_host_template pdc2027
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 5ba9eb2..6baf51b 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -269,6 +269,7 @@ static struct scsi_host_template pdc_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 2c3cc0c..314938d 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -164,6 +164,7 @@ static struct scsi_host_template qdi_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 1af83d7..048c2bb 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -227,6 +227,7 @@ static struct scsi_host_template radisys
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 4533b63..e4e5ea4 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -90,6 +90,7 @@ static struct scsi_host_template rz1000_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 067d9d2..0c75dae 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -193,6 +193,7 @@ static struct scsi_host_template sc1200_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index 5bbf76e..be7f60e 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -325,6 +325,7 @@ static struct scsi_host_template serverw
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 4a2b72b..11942fd 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -225,6 +225,7 @@ static struct scsi_host_template sil680_
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index b9ffafb..91e85f9 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -545,6 +545,7 @@ static struct scsi_host_template sis_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 08a6dc8..dc1cfc6 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -237,6 +237,7 @@ static struct scsi_host_template sl82c10
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 9640f80..bfda1f7 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -192,6 +192,7 @@ static struct scsi_host_template triflex
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 1e7be9e..c5f1616 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -295,6 +295,7 @@ static struct scsi_host_template via_sht
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
 };
 
