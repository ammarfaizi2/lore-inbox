Return-Path: <linux-kernel-owner+w=401wt.eu-S965453AbWLPR1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965453AbWLPR1P (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWLPR1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:27:14 -0500
Received: from havoc.gtf.org ([69.61.125.42]:36325 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964871AbWLPR1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:27:13 -0500
Date: Sat, 16 Dec 2006 12:27:11 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes
Message-ID: <20061216172711.GA27337@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More fixes coming too - the thing Alan's talking about, and an ata_piix
leak-on-err fix.  By Monday-ish (its a working weekend).

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/Kconfig        |    6 +++---
 drivers/ata/ahci.c         |    2 --
 drivers/ata/ata_piix.c     |   22 +++++++++++++++++-----
 drivers/ata/libata-core.c  |   14 ++++++++++----
 drivers/ata/libata-scsi.c  |    4 ++--
 drivers/ata/pata_legacy.c  |    4 +++-
 drivers/ata/pata_qdi.c     |    4 ++--
 drivers/ata/pata_rz1000.c  |    2 --
 drivers/ata/pata_via.c     |    9 +++++++--
 drivers/ata/pata_winbond.c |    4 ++--
 drivers/ata/sata_svw.c     |   41 ++++++++++++++++++++++++++++++++++-------
 11 files changed, 80 insertions(+), 32 deletions(-)

Akinobu Mita (1):
      ata: fix platform_device_register_simple() error check

Alan (2):
      Fix help text for CONFIG_ATA_PIIX
      pata_via: Cable detect error

Ira Snyder (1):
      initializer entry defined twice in pata_rz1000

Jason Gaston (1):
      ata_piix: IDE mode SATA patch for Intel ICH9

Jeff Garzik (2):
      [libata] use kmap_atomic(KM_IRQ0) in SCSI simulator
      [libata] sata_svw: Disable ATAPI DMA on current boards (errata workaround)

Tejun Heo (3):
      ata_piix: use piix_host_stop() in ich_pata_ops
      libata: don't initialize sg in ata_exec_internal() if DMA_NONE (take #2)
      ahci: do not mangle saved HOST_CAP while resetting controller

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 984ab28..b34e0a9 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -40,9 +40,9 @@ config ATA_PIIX
 	tristate "Intel PIIX/ICH SATA support"
 	depends on PCI
 	help
-	  This option enables support for ICH5/6/7/8 Serial ATA.
-	  If PATA support was enabled previously, this enables
-	  support for select Intel PIIX/ICH PATA host controllers.
+	  This option enables support for ICH5/6/7/8 Serial ATA
+	  and support for PATA on the Intel PIIX3/PIIX4/ICH series
+	  PATA host controllers.
 
 	  If unsure, say N.
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f36da48..dbae6d9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -645,8 +645,6 @@ static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev)
 	u32 cap_save, impl_save, tmp;
 
 	cap_save = readl(mmio + HOST_CAP);
-	cap_save &= ( (1<<28) | (1<<17) );
-	cap_save |= (1 << 27);
 	impl_save = readl(mmio + HOST_PORTS_IMPL);
 
 	/* global controller reset */
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index c7de0bb..47701b2 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -226,14 +226,26 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
-	/* Enterprise Southbridge 2 (where's the datasheet?) */
+	/* Enterprise Southbridge 2 (631xESB/632xESB) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
+	/* SATA Controller 1 IDE (ICH8) */
 	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
-	/* SATA Controller 2 IDE (ICH8, ditto) */
+	/* SATA Controller 2 IDE (ICH8) */
 	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
-	/* Mobile SATA Controller IDE (ICH8M, ditto) */
+	/* Mobile SATA Controller IDE (ICH8M) */
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9) */
+	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9) */
+	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9) */
+	{ 0x8086, 0x2926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9M) */
+	{ 0x8086, 0x2928, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9M) */
+	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9M) */
+	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 
 	{ }	/* terminate list */
 };
@@ -330,7 +342,7 @@ static const struct ata_port_operations ich_pata_ops = {
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 011c0a8..0d51d13 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1332,7 +1332,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 }
 
 /**
- *	ata_exec_internal_sg - execute libata internal command
+ *	ata_exec_internal - execute libata internal command
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
@@ -1353,11 +1353,17 @@ unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
 {
-	struct scatterlist sg;
+	struct scatterlist *psg = NULL, sg;
+	unsigned int n_elem = 0;
 
-	sg_init_one(&sg, buf, buflen);
+	if (dma_dir != DMA_NONE) {
+		WARN_ON(!buf);
+		sg_init_one(&sg, buf, buflen);
+		psg = &sg;
+		n_elem++;
+	}
 
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, 1);
+	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem);
 }
 
 /**
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 664e137..a4790be 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1539,7 +1539,7 @@ static unsigned int ata_scsi_rbuf_get(struct scsi_cmnd *cmd, u8 **buf_out)
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		buf = kmap_atomic(sg->page, KM_USER0) + sg->offset;
+		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
 		buflen = sg->length;
 	} else {
 		buf = cmd->request_buffer;
@@ -1567,7 +1567,7 @@ static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, u8 *buf)
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		kunmap_atomic(buf - sg->offset, KM_USER0);
+		kunmap_atomic(buf - sg->offset, KM_IRQ0);
 	}
 }
 
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index c7d1738..e7bf9d8 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -698,8 +698,10 @@ static __init int legacy_init_one(int port, unsigned long io, unsigned long ctrl
 		goto fail_io;
 
 	pdev = platform_device_register_simple(DRV_NAME, nr_legacy_host, NULL, 0);
-	if (pdev == NULL)
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
 		goto fail_dev;
+	}
 
 	if (ht6560a & mask) {
 		ops = &ht6560a_port_ops;
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 36f621a..afc0d99 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -247,8 +247,8 @@ static __init int qdi_init_one(unsigned long port, int type, unsigned long io, i
 	 */
 
 	pdev = platform_device_register_simple(DRV_NAME, nr_qdi_host, NULL, 0);
-	if (pdev == NULL)
-		return -ENOMEM;
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
 
 	memset(&ae, 0, sizeof(struct ata_probe_ent));
 	INIT_LIST_HEAD(&ae.node);
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 3677c64..adf4cc1 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -105,8 +105,6 @@ static struct ata_port_operations rz1000_port_ops = {
 	.exec_command	= ata_exec_command,
 	.dev_select 	= ata_std_dev_select,
 
-	.error_handler	= rz1000_error_handler,
-
 	.bmdma_setup 	= ata_bmdma_setup,
 	.bmdma_start 	= ata_bmdma_start,
 	.bmdma_stop	= ata_bmdma_stop,
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index cc09d47..ff93e8f 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -161,10 +161,15 @@ static int via_pre_reset(struct ata_port *ap)
 			return -ENOENT;
 	}
 
-	if ((config->flags & VIA_UDMA) >= VIA_UDMA_66)
+	if ((config->flags & VIA_UDMA) >= VIA_UDMA_100)
 		ap->cbl = via_cable_detect(ap);
-	else
+	/* The UDMA66 series has no cable detect so do drive side detect */
+	else if ((config->flags & VIA_UDMA) < VIA_UDMA_66)
 		ap->cbl = ATA_CBL_PATA40;
+	else
+		ap->cbl = ATA_CBL_PATA_UNK;
+		
+
 	return ata_std_prereset(ap);
 }
 
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 3ea345c..5d1f518 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -206,8 +206,8 @@ static __init int winbond_init_one(unsigned long port)
 			 */
 
 			pdev = platform_device_register_simple(DRV_NAME, nr_winbond_host, NULL, 0);
-			if (pdev == NULL)
-				return -ENOMEM;
+			if (IS_ERR(pdev))
+				return PTR_ERR(pdev);
 
 			memset(&ae, 0, sizeof(struct ata_probe_ent));
 			INIT_LIST_HEAD(&ae.node);
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index db32d15..d89c959 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -56,6 +56,8 @@
 #define DRV_VERSION	"2.0"
 
 enum {
+	K2_FLAG_NO_ATAPI_DMA		= (1 << 29),
+
 	/* Taskfile registers offsets */
 	K2_SATA_TF_CMD_OFFSET		= 0x00,
 	K2_SATA_TF_DATA_OFFSET		= 0x00,
@@ -83,11 +85,33 @@ enum {
 
 	/* Port stride */
 	K2_SATA_PORT_OFFSET		= 0x100,
+
+	board_svw4			= 0,
+	board_svw8			= 1,
+};
+
+static const struct k2_board_info {
+	unsigned int		n_ports;
+	unsigned long		port_flags;
+} k2_board_info[] = {
+	/* board_svw4 */
+	{ 4, K2_FLAG_NO_ATAPI_DMA },
+
+	/* board_svw8 */
+	{ 8, K2_FLAG_NO_ATAPI_DMA },
 };
 
 static u8 k2_stat_check_status(struct ata_port *ap);
 
 
+static int k2_sata_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	if (qc->ap->flags & K2_FLAG_NO_ATAPI_DMA)
+		return -1;	/* ATAPI DMA not supported */
+
+	return 0;
+}
+
 static u32 k2_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)
@@ -313,6 +337,7 @@ static const struct ata_port_operations k2_sata_ops = {
 	.check_status		= k2_stat_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
+	.check_atapi_dma	= k2_sata_check_atapi_dma,
 	.bmdma_setup		= k2_bmdma_setup_mmio,
 	.bmdma_start		= k2_bmdma_start_mmio,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -359,6 +384,8 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
 	void __iomem *mmio_base;
+	const struct k2_board_info *board_info =
+			&k2_board_info[ent->driver_data];
 	int pci_dev_busy = 0;
 	int rc;
 	int i;
@@ -424,7 +451,7 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 
 	probe_ent->sht = &k2_sata_sht;
 	probe_ent->port_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO;
+				ATA_FLAG_MMIO | board_info->port_flags;
 	probe_ent->port_ops = &k2_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
@@ -441,7 +468,7 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	/* different controllers have different number of ports - currently 4 or 8 */
 	/* All ports are on the same function. Multi-function device is no
 	 * longer available. This should not be seen in any system. */
-	for (i = 0; i < ent->driver_data; i++)
+	for (i = 0; i < board_info->n_ports; i++)
 		k2_sata_setup_port(&probe_ent->port[i], base + i * K2_SATA_PORT_OFFSET);
 
 	pci_set_master(pdev);
@@ -469,11 +496,11 @@ err_out:
  * controller
  * */
 static const struct pci_device_id k2_sata_pci_tbl[] = {
-	{ PCI_VDEVICE(SERVERWORKS, 0x0240), 4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0241), 4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0242), 8 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024a), 4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024b), 4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0240), board_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0241), board_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0242), board_svw8 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024a), board_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024b), board_svw4 },
 
 	{ }
 };
