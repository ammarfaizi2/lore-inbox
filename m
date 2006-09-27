Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030757AbWI0UVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030757AbWI0UVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030756AbWI0UVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:21:13 -0400
Received: from havoc.gtf.org ([69.61.125.42]:32971 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030754AbWI0UVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:21:10 -0400
Date: Wed, 27 Sep 2006 16:19:45 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes and cleanups
Message-ID: <20060927201945.GA2591@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One major fix, a couple minor fixes, and a couple cleanups.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/Kconfig            |    3 ++-
 drivers/ata/ata_generic.c      |    2 +-
 drivers/ata/ata_piix.c         |    8 +++-----
 drivers/ata/libata-core.c      |    5 +++++
 drivers/ata/libata-eh.c        |    6 +++++-
 drivers/ata/libata-sff.c       |    6 +++---
 drivers/ata/pata_ali.c         |    8 ++++----
 drivers/ata/pata_amd.c         |   37 ++++++++++++++-----------------------
 drivers/ata/pata_artop.c       |   22 ++++++++--------------
 drivers/ata/pata_atiixp.c      |   12 +++++-------
 drivers/ata/pata_cmd64x.c      |    6 +++---
 drivers/ata/pata_cs5520.c      |    2 --
 drivers/ata/pata_cs5530.c      |    2 +-
 drivers/ata/pata_cs5535.c      |    2 +-
 drivers/ata/pata_cypress.c     |    2 +-
 drivers/ata/pata_efar.c        |   12 ++++--------
 drivers/ata/pata_hpt366.c      |    2 +-
 drivers/ata/pata_hpt37x.c      |    8 ++++----
 drivers/ata/pata_hpt3x2n.c     |    2 +-
 drivers/ata/pata_hpt3x3.c      |    2 +-
 drivers/ata/pata_isapnp.c      |    2 +-
 drivers/ata/pata_it821x.c      |    4 ++--
 drivers/ata/pata_jmicron.c     |    5 ++---
 drivers/ata/pata_legacy.c      |   14 +++++++-------
 drivers/ata/pata_mpiix.c       |   11 ++++-------
 drivers/ata/pata_netcell.c     |    3 +--
 drivers/ata/pata_ns87410.c     |    9 +++------
 drivers/ata/pata_oldpiix.c     |    9 +++------
 drivers/ata/pata_opti.c        |   12 +++++-------
 drivers/ata/pata_optidma.c     |   14 ++++++--------
 drivers/ata/pata_pcmcia.c      |    2 +-
 drivers/ata/pata_pdc2027x.c    |    8 +++-----
 drivers/ata/pata_qdi.c         |    4 ++--
 drivers/ata/pata_radisys.c     |    2 --
 drivers/ata/pata_rz1000.c      |    2 +-
 drivers/ata/pata_sc1200.c      |    2 +-
 drivers/ata/pata_serverworks.c |   12 ++++++++----
 drivers/ata/pata_sil680.c      |    2 +-
 drivers/ata/pata_sis.c         |   20 ++++----------------
 drivers/ata/pata_sl82c105.c    |   11 ++++-------
 drivers/ata/pata_triflex.c     |   15 ++++++---------
 drivers/ata/pata_via.c         |   13 +++++--------
 drivers/ata/sata_mv.c          |    1 +
 43 files changed, 138 insertions(+), 188 deletions(-)

Alan Cox:
      libata: refuse to register IRQless ports
      libata: tighten rules for legacy dependancies
      libata-eh: Remove layering violation and duplication when handling absent ports
      libata-sff: use our IRQ defines
      pata_serverworks: correct PCI ID in cable detection table

Jeff Garzik:
      [libata] pata_serverworks: fill in ->irq_clear hook
      [libata] One more s/15/ATA_SECONDARY_IRQ/ substitution
      [libata] sata_mv: fix oops by filling in missing hook
      [libata] Don't use old-EH ->eng_timeout() hook when not needed

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 99837d9..3f4aa0c 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -311,7 +311,7 @@ config PATA_JMICRON
 
 config PATA_LEGACY
 	tristate "Legacy ISA PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	depends on ISA && EXPERIMENTAL
 	help
 	  This option enables support for ISA/VLB bus legacy PATA
 	  ports and allows them to be accessed via the new ATA layer.
@@ -400,6 +400,7 @@ config PATA_PDC_OLD
 
 config PATA_QDI
 	tristate "QDI VLB PATA support"
+	depends on ISA
 	help
 	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
 
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 1d1c30a..377425e 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -143,7 +143,7 @@ static struct ata_port_operations generi
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
 
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ffa111e..5719704 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -643,11 +643,9 @@ static int piix_pata_prereset(struct ata
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
-	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no])) {
-		ata_port_printk(ap, KERN_INFO, "port disabled. ignoring.\n");
-		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
+		return -ENOENT;
+		
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 753b015..b4abd68 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5453,6 +5453,11 @@ int ata_device_add(const struct ata_prob
 	int rc;
 
 	DPRINTK("ENTER\n");
+	
+	if (ent->irq == 0) {
+		dev_printk(KERN_ERR, dev, "is not available: No interrupt assigned.\n");
+		return 0;
+	}
 	/* alloc a container for our list of ATA ports (buses) */
 	host = kzalloc(sizeof(struct ata_host) +
 		       (ent->n_ports * sizeof(void *)), GFP_KERNEL);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3fa80f0..02b2b27 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1515,7 +1515,11 @@ static int ata_eh_reset(struct ata_port 
 	if (prereset) {
 		rc = prereset(ap);
 		if (rc) {
-			ata_port_printk(ap, KERN_ERR,
+			if (rc == -ENOENT) {
+				ata_port_printk(ap, KERN_DEBUG, "port disabled. ignoring.\n");
+				ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
+			} else
+				ata_port_printk(ap, KERN_ERR,
 					"prereset failed (errno=%d)\n", rc);
 			return rc;
 		}
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 688bb55..08b3a40 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -881,7 +881,7 @@ static struct ata_probe_ent *ata_pci_ini
 	probe_ent->private_data = port[0]->private_data;
 
 	if (port_mask & ATA_PORT_PRIMARY) {
-		probe_ent->irq = 14;
+		probe_ent->irq = ATA_PRIMARY_IRQ;
 		probe_ent->port[0].cmd_addr = ATA_PRIMARY_CMD;
 		probe_ent->port[0].altstatus_addr =
 		probe_ent->port[0].ctl_addr = ATA_PRIMARY_CTL;
@@ -896,9 +896,9 @@ static struct ata_probe_ent *ata_pci_ini
 
 	if (port_mask & ATA_PORT_SECONDARY) {
 		if (probe_ent->irq)
-			probe_ent->irq2 = 15;
+			probe_ent->irq2 = ATA_SECONDARY_IRQ;
 		else
-			probe_ent->irq = 15;
+			probe_ent->irq = ATA_SECONDARY_IRQ;
 		probe_ent->port[1].cmd_addr = ATA_SECONDARY_CMD;
 		probe_ent->port[1].altstatus_addr =
 		probe_ent->port[1].ctl_addr = ATA_SECONDARY_CTL;
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 8448ee6..87af3b5 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -369,7 +369,7 @@ static struct ata_port_operations ali_ea
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -410,7 +410,7 @@ static struct ata_port_operations ali_20
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -448,7 +448,7 @@ static struct ata_port_operations ali_c2
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -485,7 +485,7 @@ static struct ata_port_operations ali_c5
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 3293cf9..599ee26 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -25,7 +25,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_amd"
-#define DRV_VERSION "0.2.3"
+#define DRV_VERSION "0.2.4"
 
 /**
  *	timing_setup		-	shared timing computation and load
@@ -137,11 +137,8 @@ static int amd_pre_reset(struct ata_port
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 ata66;
 
-	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no]))
+		return -ENOENT;
 
 	pci_read_config_byte(pdev, 0x42, &ata66);
 	if (ata66 & bitmask[ap->port_no])
@@ -167,11 +164,9 @@ static int amd_early_pre_reset(struct at
 		{ 0x40, 1, 0x01, 0x01 }
 	};
 
-	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &amd_enable_bits[ap->port_no]))
+		return -ENOENT;
+
 	/* No host side cable detection */
 	ap->cbl = ATA_CBL_PATA80;
 	return ata_std_prereset(ap);
@@ -262,12 +257,8 @@ static int nv_pre_reset(struct ata_port 
 	u8 ata66;
 	u16 udma;
 
-	if (!pci_test_config_bits(pdev, &nv_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
-
+	if (!pci_test_config_bits(pdev, &nv_enable_bits[ap->port_no]))
+		return -ENOENT;
 
 	pci_read_config_byte(pdev, 0x52, &ata66);
 	if (ata66 & bitmask[ap->port_no])
@@ -368,7 +359,7 @@ static struct ata_port_operations amd33_
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -402,7 +393,7 @@ static struct ata_port_operations amd66_
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -436,7 +427,7 @@ static struct ata_port_operations amd100
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -470,7 +461,7 @@ static struct ata_port_operations amd133
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -504,7 +495,7 @@ static struct ata_port_operations nv100_
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -538,7 +529,7 @@ static struct ata_port_operations nv133_
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index d6ef3bf..c4ccb75 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -28,7 +28,7 @@ #include <linux/libata.h>
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_artop"
-#define DRV_VERSION	"0.4.1"
+#define DRV_VERSION	"0.4.2"
 
 /*
  *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
@@ -47,11 +47,9 @@ static int artop6210_pre_reset(struct at
 		{ 0x4AU, 1U, 0x04UL, 0x04UL },	/* port 1 */
 	};
 
-	if (!pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
+		return -ENOENT;
+
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
@@ -90,11 +88,9 @@ static int artop6260_pre_reset(struct at
 	u8 tmp;
 
 	/* Odd numbered device ids are the units with enable bits (the -R cards) */
-	if (pdev->device % 1 && !pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (pdev->device % 1 && !pci_test_config_bits(pdev, &artop_enable_bits[ap->port_no]))
+		return -ENOENT;
+
 	pci_read_config_byte(pdev, 0x49, &tmp);
 	if (tmp & (1 >> ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
@@ -344,7 +340,7 @@ static const struct ata_port_operations 
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+
 	.data_xfer		= ata_pio_data_xfer,
 
 	.irq_handler		= ata_interrupt,
@@ -379,8 +375,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
-
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 3f78a1e..6c2269b 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -22,7 +22,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_atiixp"
-#define DRV_VERSION "0.4.2"
+#define DRV_VERSION "0.4.3"
 
 enum {
 	ATIIXP_IDE_PIO_TIMING	= 0x40,
@@ -41,11 +41,9 @@ static int atiixp_pre_reset(struct ata_p
 		{ 0x48, 1, 0x08, 0x00 }
 	};
 
-	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &atiixp_enable_bits[ap->port_no]))
+		return -ENOENT;
+
 	ap->cbl = ATA_CBL_PATA80;
 	return ata_std_prereset(ap);
 }
@@ -244,7 +242,7 @@ static struct ata_port_operations atiixp
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
index abf1bb7..e92b0ef 100644
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -301,7 +301,7 @@ static struct ata_port_operations cmd64x
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -335,7 +335,7 @@ static struct ata_port_operations cmd646
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -369,7 +369,7 @@ static struct ata_port_operations cmd648
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 792ce48..a6c6ceb 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -193,8 +193,6 @@ static struct ata_port_operations cs5520
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
-
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index f3d8a3b..7bba4d9 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -207,7 +207,7 @@ static struct ata_port_operations cs5530
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= cs5530_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_cs5535.c b/drivers/ata/pata_cs5535.c
index 69d6b42..d64fcdc 100644
--- a/drivers/ata/pata_cs5535.c
+++ b/drivers/ata/pata_cs5535.c
@@ -211,7 +211,7 @@ static struct ata_port_operations cs5535
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_cypress.c b/drivers/ata/pata_cypress.c
index fd55474..dfa5ac5 100644
--- a/drivers/ata/pata_cypress.c
+++ b/drivers/ata/pata_cypress.c
@@ -162,7 +162,7 @@ static struct ata_port_operations cy82c6
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_efar.c b/drivers/ata/pata_efar.c
index c30bc18..95cd1ca 100644
--- a/drivers/ata/pata_efar.c
+++ b/drivers/ata/pata_efar.c
@@ -22,7 +22,7 @@ #include <linux/libata.h>
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_efar"
-#define DRV_VERSION	"0.4.1"
+#define DRV_VERSION	"0.4.2"
 
 /**
  *	efar_pre_reset	-	check for 40/80 pin
@@ -42,11 +42,9 @@ static int efar_pre_reset(struct ata_por
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 tmp;
 
-	if (!pci_test_config_bits(pdev, &efar_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &efar_enable_bits[ap->port_no]))
+		return -ENOENT;
+
 	pci_read_config_byte(pdev, 0x47, &tmp);
 	if (tmp & (2 >> ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
@@ -263,8 +261,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
-
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 94bb1df..cf656ec 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -360,7 +360,7 @@ static struct ata_port_operations hpt366
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 532a792..10318c0 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -793,7 +793,7 @@ static struct ata_port_operations hpt370
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -832,7 +832,7 @@ static struct ata_port_operations hpt370
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -872,7 +872,7 @@ static struct ata_port_operations hpt372
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -912,7 +912,7 @@ static struct ata_port_operations hpt374
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_hpt3x2n.c b/drivers/ata/pata_hpt3x2n.c
index 06c8db0..5c5d4f6 100644
--- a/drivers/ata/pata_hpt3x2n.c
+++ b/drivers/ata/pata_hpt3x2n.c
@@ -372,7 +372,7 @@ static struct ata_port_operations hpt3x2
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= hpt3x2n_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 1527701..1f084ab 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -145,7 +145,7 @@ static struct ata_port_operations hpt3x3
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 73948c8..640b8b0 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -52,7 +52,7 @@ static struct ata_port_operations isapnp
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_it821x.c b/drivers/ata/pata_it821x.c
index af39097..82a46ff 100644
--- a/drivers/ata/pata_it821x.c
+++ b/drivers/ata/pata_it821x.c
@@ -703,7 +703,7 @@ static struct ata_port_operations it821x
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= it821x_smart_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -739,7 +739,7 @@ static struct ata_port_operations it821x
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= it821x_passthru_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_clear	= ata_bmdma_irq_clear,
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 6832a64..be3a866 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -51,7 +51,7 @@ static int jmicron_pre_reset(struct ata_
 	/* Check if our port is enabled */
 	pci_read_config_dword(pdev, 0x40, &control);
 	if ((control & port_mask) == 0)
-		return 0;
+		return -ENOENT;
 
 	/* There are two basic mappings. One has the two SATA ports merged
 	   as master/slave and the secondary as PATA, the other has only the
@@ -164,8 +164,7 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	/* Timeout handling. Special recovery hooks here */
-	.eng_timeout		= ata_eng_timeout,
+	/* IRQ-related hooks */
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index ad37c22..10231ef 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -161,7 +161,7 @@ static struct ata_port_operations simple
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer_noirq,
 
 	.irq_handler	= ata_interrupt,
@@ -186,7 +186,7 @@ static struct ata_port_operations legacy
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer_noirq,
 
 	.irq_handler	= ata_interrupt,
@@ -296,7 +296,7 @@ static struct ata_port_operations pdc202
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= pdc_data_xfer_vlb,
 
 	.irq_handler	= ata_interrupt,
@@ -348,7 +348,7 @@ static struct ata_port_operations ht6560
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,	/* Check vlb/noirq */
 
 	.irq_handler	= ata_interrupt,
@@ -411,7 +411,7 @@ static struct ata_port_operations ht6560
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,	/* FIXME: Check 32bit and noirq */
 
 	.irq_handler	= ata_interrupt,
@@ -529,7 +529,7 @@ static struct ata_port_operations opti82
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -659,7 +659,7 @@ static struct ata_port_operations opti82
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= opti82c46x_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_mpiix.c b/drivers/ata/pata_mpiix.c
index 1958c4e..3c65393 100644
--- a/drivers/ata/pata_mpiix.c
+++ b/drivers/ata/pata_mpiix.c
@@ -18,7 +18,7 @@
  * The driver conciously keeps this logic internally to avoid pushing quirky
  * PATA history into the clean libata layer.
  *
- * Thinkpad specific note: If you boot an MPIIX using thinkpad with a PCMCIA
+ * Thinkpad specific note: If you boot an MPIIX using a thinkpad with a PCMCIA
  * hard disk present this driver will not detect it. This is not a bug. In this
  * configuration the secondary port of the MPIIX is disabled and the addresses
  * are decoded by the PCMCIA bridge and therefore are for a generic IDE driver
@@ -35,7 +35,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_mpiix"
-#define DRV_VERSION "0.7.1"
+#define DRV_VERSION "0.7.2"
 
 enum {
 	IDETIM = 0x6C,		/* IDE control register */
@@ -54,11 +54,8 @@ static int mpiix_pre_reset(struct ata_po
 		{ 0x6F, 1, 0x80, 0x80 }
 	};
 
-	if (!pci_test_config_bits(pdev, &mpiix_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &mpiix_enable_bits[ap->port_no]))
+		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
diff --git a/drivers/ata/pata_netcell.c b/drivers/ata/pata_netcell.c
index 16cb254..76eb9c9 100644
--- a/drivers/ata/pata_netcell.c
+++ b/drivers/ata/pata_netcell.c
@@ -90,8 +90,7 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	/* Timeout handling. Special recovery hooks here */
-	.eng_timeout		= ata_eng_timeout,
+	/* IRQ-related hooks */
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
diff --git a/drivers/ata/pata_ns87410.c b/drivers/ata/pata_ns87410.c
index 93d6646..2005a95 100644
--- a/drivers/ata/pata_ns87410.c
+++ b/drivers/ata/pata_ns87410.c
@@ -45,11 +45,8 @@ static int ns87410_pre_reset(struct ata_
 		{ 0x47, 1, 0x08, 0x08 }
 	};
 
-	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no]))
+		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
@@ -179,7 +176,7 @@ static struct ata_port_operations ns8741
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ns87410_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_oldpiix.c b/drivers/ata/pata_oldpiix.c
index 04c618a..31a285c 100644
--- a/drivers/ata/pata_oldpiix.c
+++ b/drivers/ata/pata_oldpiix.c
@@ -25,7 +25,7 @@ #include <linux/libata.h>
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_oldpiix"
-#define DRV_VERSION	"0.5.1"
+#define DRV_VERSION	"0.5.2"
 
 /**
  *	oldpiix_pre_reset		-	probe begin
@@ -42,11 +42,8 @@ static int oldpiix_pre_reset(struct ata_
 		{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
 	};
 
-	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->port_no]))
+		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
diff --git a/drivers/ata/pata_opti.c b/drivers/ata/pata_opti.c
index c3d0132..57fe21f 100644
--- a/drivers/ata/pata_opti.c
+++ b/drivers/ata/pata_opti.c
@@ -34,7 +34,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_opti"
-#define DRV_VERSION "0.2.4"
+#define DRV_VERSION "0.2.5"
 
 enum {
 	READ_REG	= 0,	/* index of Read cycle timing register */
@@ -59,11 +59,9 @@ static int opti_pre_reset(struct ata_por
 		{ 0x40, 1, 0x08, 0x00 }
 	};
 
-	if (!pci_test_config_bits(pdev, &opti_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &opti_enable_bits[ap->port_no]))
+		return -ENOENT;
+
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
@@ -229,7 +227,7 @@ static struct ata_port_operations opti_p
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_optidma.c b/drivers/ata/pata_optidma.c
index 177a455..7296a20 100644
--- a/drivers/ata/pata_optidma.c
+++ b/drivers/ata/pata_optidma.c
@@ -33,7 +33,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_optidma"
-#define DRV_VERSION "0.2.1"
+#define DRV_VERSION "0.2.2"
 
 enum {
 	READ_REG	= 0,	/* index of Read cycle timing register */
@@ -59,11 +59,9 @@ static int optidma_pre_reset(struct ata_
 		0x40, 1, 0x08, 0x00
 	};
 
-	if (ap->port_no && !pci_test_config_bits(pdev, &optidma_enable_bits)) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (ap->port_no && !pci_test_config_bits(pdev, &optidma_enable_bits))
+		return -ENOENT;
+
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
@@ -388,7 +386,7 @@ static struct ata_port_operations optidm
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -423,7 +421,7 @@ static struct ata_port_operations optipl
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 62b25cd..cb501e1 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -87,7 +87,7 @@ static struct ata_port_operations pcmcia
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer_noirq,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 31ab9c8..bd4ed67 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -36,7 +36,7 @@ #include <linux/libata.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.74-ac3"
+#define DRV_VERSION	"0.74-ac5"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -311,10 +311,8 @@ static inline int pdc2027x_port_enabled(
 static int pdc2027x_prereset(struct ata_port *ap)
 {
 	/* Check whether port enabled */
-	if (!pdc2027x_port_enabled(ap)) {
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pdc2027x_port_enabled(ap))
+		return -ENOENT;
 	pdc2027x_cbl_detect(ap);
 	return ata_std_prereset(ap);
 }
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 35cfdf0..7977f47 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -184,7 +184,7 @@ static struct ata_port_operations qdi650
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= qdi_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= qdi_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -212,7 +212,7 @@ static struct ata_port_operations qdi658
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= qdi_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= qdi_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_radisys.c b/drivers/ata/pata_radisys.c
index 277f841..c20bcf4 100644
--- a/drivers/ata/pata_radisys.c
+++ b/drivers/ata/pata_radisys.c
@@ -255,8 +255,6 @@ static const struct ata_port_operations 
 	.qc_issue		= radisys_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
-
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 3c6d84f..eccc6fd 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -112,7 +112,7 @@ static struct ata_port_operations rz1000
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.freeze		= ata_bmdma_freeze,
diff --git a/drivers/ata/pata_sc1200.c b/drivers/ata/pata_sc1200.c
index 4166c1a..107e6cd 100644
--- a/drivers/ata/pata_sc1200.c
+++ b/drivers/ata/pata_sc1200.c
@@ -217,7 +217,7 @@ static struct ata_port_operations sc1200
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= sc1200_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index af45611..a5c8d7e 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -41,7 +41,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_serverworks"
-#define DRV_VERSION "0.3.6"
+#define DRV_VERSION "0.3.7"
 
 #define SVWKS_CSB5_REVISION_NEW	0x92 /* min PCI_REVISION_ID for UDMA5 (A2.0) */
 #define SVWKS_CSB6_REVISION	0xa0 /* min PCI_REVISION_ID for UDMA4 (A1.0) */
@@ -128,7 +128,7 @@ static struct sv_cable_table cable_detec
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_VENDOR_ID_DELL, dell_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB6IDE, PCI_VENDOR_ID_DELL, dell_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_VENDOR_ID_SUN,  sun_cable },
-	{ PCI_DEVICE_ID_SERVERWORKS_OSB4, PCI_ANY_ID, osb4_cable },
+	{ PCI_DEVICE_ID_SERVERWORKS_OSB4IDE, PCI_ANY_ID, osb4_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_ANY_ID, csb_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB6IDE, PCI_ANY_ID, csb_cable },
 	{ PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2, PCI_ANY_ID, csb_cable },
@@ -352,10 +352,12 @@ static struct ata_port_operations server
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
+	.irq_clear	= ata_bmdma_irq_clear,
+
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
 	.host_stop	= ata_host_stop
@@ -385,10 +387,12 @@ static struct ata_port_operations server
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
+	.irq_clear	= ata_bmdma_irq_clear,
+
 	.port_start	= ata_port_start,
 	.port_stop	= ata_port_stop,
 	.host_stop	= ata_host_stop
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 8f7db96..c8b2e26 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -251,7 +251,7 @@ static struct ata_port_operations sil680
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 2e55516..17791e2 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -34,7 +34,7 @@ #include <linux/libata.h>
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_sis"
-#define DRV_VERSION	"0.4.3"
+#define DRV_VERSION	"0.4.4"
 
 struct sis_chipset {
 	u16 device;			/* PCI host ID */
@@ -74,11 +74,9 @@ static int sis_133_pre_reset(struct ata_
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u16 tmp;
 
-	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
+		return -ENOENT;
+
 	/* The top bit of this register is the cable detect bit */
 	pci_read_config_word(pdev, 0x50 + 2 * ap->port_no, &tmp);
 	if (tmp & 0x8000)
@@ -575,8 +573,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
-
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
@@ -610,8 +606,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
-
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
@@ -646,8 +640,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
-
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
@@ -681,8 +673,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
-
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
@@ -716,8 +706,6 @@ static const struct ata_port_operations 
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
 
-	.eng_timeout		= ata_eng_timeout,
-
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index f849978..5b762ac 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -19,7 +19,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_sl82c105"
-#define DRV_VERSION "0.2.2"
+#define DRV_VERSION "0.2.3"
 
 enum {
 	/*
@@ -49,11 +49,8 @@ static int sl82c105_pre_reset(struct ata
 	};
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
-	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		dev_printk(KERN_INFO, &pdev->dev, "port disabled. ignoring.\n");
-		return 0;
-	}
+	if (ap->port_no && !pci_test_config_bits(pdev, &sl82c105_enable_bits[ap->port_no]))
+		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
@@ -264,7 +261,7 @@ static struct ata_port_operations sl82c1
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_triflex.c b/drivers/ata/pata_triflex.c
index 36f7887..a954ed9 100644
--- a/drivers/ata/pata_triflex.c
+++ b/drivers/ata/pata_triflex.c
@@ -46,13 +46,13 @@ #define DRV_NAME "pata_triflex"
 #define DRV_VERSION "0.2.5"
 
 /**
- *	triflex_probe_init		-	probe begin
+ *	triflex_prereset		-	probe begin
  *	@ap: ATA port
  *
  *	Set up cable type and use generic probe init
  */
 
-static int triflex_probe_init(struct ata_port *ap)
+static int triflex_prereset(struct ata_port *ap)
 {
 	static const struct pci_bits triflex_enable_bits[] = {
 		{ 0x80, 1, 0x01, 0x01 },
@@ -61,11 +61,8 @@ static int triflex_probe_init(struct ata
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
-	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return 0;
-	}
+	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->port_no]))
+		return -ENOENT;
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
@@ -74,7 +71,7 @@ static int triflex_probe_init(struct ata
 
 static void triflex_error_handler(struct ata_port *ap)
 {
-	ata_bmdma_drive_eh(ap, triflex_probe_init, ata_std_softreset, NULL, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, triflex_prereset, ata_std_softreset, NULL, ata_std_postreset);
 }
 
 /**
@@ -221,7 +218,7 @@ static struct ata_port_operations trifle
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index 1b2ff13..7b5dd23 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -60,7 +60,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_via"
-#define DRV_VERSION "0.1.13"
+#define DRV_VERSION "0.1.14"
 
 /*
  *	The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
@@ -155,11 +155,8 @@ static int via_pre_reset(struct ata_port
 
 		struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 
-		if (!pci_test_config_bits(pdev, &via_enable_bits[ap->port_no])) {
-			ata_port_disable(ap);
-			printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-			return 0;
-		}
+		if (!pci_test_config_bits(pdev, &via_enable_bits[ap->port_no]))
+			return -ENOENT;
 	}
 
 	if ((config->flags & VIA_UDMA) >= VIA_UDMA_66)
@@ -325,7 +322,7 @@ static struct ata_port_operations via_po
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer,
 
 	.irq_handler	= ata_interrupt,
@@ -360,7 +357,7 @@ static struct ata_port_operations via_po
 
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
+
 	.data_xfer	= ata_pio_data_xfer_noirq,
 
 	.irq_handler	= ata_interrupt,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index fdce6e0..c01496d 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -463,6 +463,7 @@ static const struct ata_port_operations 
 
 	.qc_prep		= mv_qc_prep_iie,
 	.qc_issue		= mv_qc_issue,
+	.data_xfer		= ata_mmio_data_xfer,
 
 	.eng_timeout		= mv_eng_timeout,
 
