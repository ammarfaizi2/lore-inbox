Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266369AbUFQEie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266369AbUFQEie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 00:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266372AbUFQEie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 00:38:34 -0400
Received: from havoc.gtf.org ([216.162.42.101]:13801 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266369AbUFQEgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 00:36:06 -0400
Date: Thu, 17 Jun 2004 00:33:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       achew@nvidia.com, linux-kernel@vger.kernel.org
Subject: [PATCH] current libata queue
Message-ID: <20040617043321.GA20746@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is my latest queue, including the nvidia changes and config
changes.

Instead of two config options -- one in IDE and one in libata --
I decided just to do one in IDE:
	"Support for SATA (deprecated; use libata)?"

Let me know if anyone feels I should still do a config option in libata.

Also, if this patch is too large for review, I would be glad to split
them up and post them separately.




BK users may do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/ide/Kconfig         |   20 ++
 drivers/ide/pci/amd74xx.c   |   20 --
 drivers/ide/pci/generic.c   |    2 
 drivers/ide/pci/piix.c      |    4 
 drivers/ide/pci/siimage.c   |    3 
 drivers/scsi/Kconfig        |    8 
 drivers/scsi/Makefile       |    1 
 drivers/scsi/ata_piix.c     |    4 
 drivers/scsi/libata-core.c  |  359 ++++++++++++--------------------------------
 drivers/scsi/sata_nv.c      |  353 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c |    8 
 drivers/scsi/sata_sil.c     |    2 
 drivers/scsi/sata_sis.c     |    2 
 drivers/scsi/sata_svw.c     |    2 
 drivers/scsi/sata_sx4.c     |    9 -
 drivers/scsi/sata_via.c     |    2 
 drivers/scsi/sata_vsc.c     |    2 
 include/linux/libata.h      |   59 +++++--
 18 files changed, 560 insertions(+), 300 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/06/17 1.1789)
   [libata/IDE nvidia] shuffle pci ids
   
   * Mark conflicting PCI ids with CONFIG_BLK_DEV_IDE_SATA
   * Move not-yet-released PCI ids to libata sata_nv driver

<jgarzik@pobox.com> (04/06/16 1.1788)
   [libata] put nvidia in Kconfig, in alphabetical order

<achew@nvidia.com> (04/06/16 1.1787)
   [libata] Add NVIDIA SATA driver

<jgarzik@pobox.com> (04/06/16 1.1786)
   [IDE] Introduce SATA enable/disable config option
   
   This config option is introduced to help reduce user confusion,
   and eliminate conflicts between the IDE driver (which is often
   built into user kernels) and the new libata SATA driver.

<jgarzik@pobox.com> (04/06/15 1.1754.9.5)
   [libata] ->qc_prep hook
   
   Rename ->fill_sg hook to ->qc_prep, and call it unconditionally
   (as opposed to ->fill_sg, which was called only when the
   flag ATA_QCFLAG_SG was set).

<jgarzik@pobox.com> (04/06/14 1.1754.9.4)
   [libata] PCI IDE command-end/irq-acknowledge cleanup
   
   Restruct default irq handler (used for many PCI IDE-like SATA
   controllers) to obtain device status and acknowledge interrupts
   a bit differently.
   
   In an attempt to better attack the "ich5 screaming interrupt" problem,
   acknowledge and clear the device's INTRQ by reading the Status register
   _before_ ack'ing the controller's irq status.  This is a deviation
   from how the Linux IDE driver acknowledges interrupts, but it may
   be the best method, since the ICH5 appears to continue to assert
   the interrupt bit in the BMDMA until the device INTRQ line is cleared.
   
   Of course, SATA has no INTRQ line per se, so ICH5 essentially has
   new interrupt behavior not seen before in the PCI IDE world, while
   pretending that it's compatible with PCI IDE.  Sigh.
   
   This change affects all SATA controllers (for which there are libata
   drivers) except for sata_promise and sata_sx4.

<jgarzik@pobox.com> (04/06/14 1.1754.9.3)
   [libata] PCI IDE DMA code shuffling
   
   PCI IDE DMA standard (or "bmdma") helper routines ata_bmdma_stop,
   ata_bmdma_ack_irq, and ata_bmdma_status are added to linux/libata.h,
   and used in libata-core.
   
   There is a minor behavior change, such that, the Alt Status register
   is read before acknowledging the bmdma interrupt.  This should be ok,
   and furthermore there will be more significant behavior changes
   in this area coming soon.

<jgarzik@pobox.com> (04/06/14 1.1754.9.2)
   [libata] don't probe from workqueue
   
   Since we want the probe phase to call other workqueues, this is
   required to eliminate future deadlocks.
   
   Other methods would include starting a single-shot thread just for
   probing, but overall, using a separate thread for probing is pointless
   since we are already in process context when we probe.
   
   So, we simply call ata_bus_probe directly.

<p.lavarre@ieee.org> (04/06/02 1.1726.75.4)
   [PATCH] ata_check_bmdma
   
   Move hand-coded BMDMA status check into separate function.

diff -Nru a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2004-06-17 00:28:35 -04:00
+++ b/drivers/ide/Kconfig	2004-06-17 00:28:35 -04:00
@@ -95,6 +95,26 @@
 
 comment "Please see Documentation/ide.txt for help/info on IDE drives"
 
+config BLK_DEV_IDE_SATA
+	bool "Support for SATA (deprecated; conflicts with libata SATA driver)"
+	default n
+	---help---
+	  There are two drivers for Serial ATA controllers.
+
+	  The main driver, "libata", exists inside the SCSI subsystem
+	  and supports most modern SATA controllers.
+
+	  The IDE driver (which you are currently configuring) supports
+	  a few first-generation SATA controllers.
+
+	  In order to eliminate conflicts between the two subsystems,
+	  this config option enables the IDE driver's SATA support.
+	  Normally this is disabled, as it is preferred that libata
+	  supports SATA controllers, and this (IDE) driver supports
+	  PATA controllers.
+
+	  If unsure, say N.
+
 config BLK_DEV_HD_IDE
 	bool "Use old disk-only driver on primary interface"
 	depends on ((X86 && X86_PC9800!=y) || SH_MPC1211)
diff -Nru a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/ide/pci/amd74xx.c	2004-06-17 00:28:35 -04:00
@@ -71,11 +71,7 @@
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,	0x50, AMD_UDMA_133 },
 	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	0x50, AMD_UDMA_133 },
-	{ PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,	0x50, AMD_UDMA_133 },
 	{ 0 }
 };
 
@@ -487,11 +483,7 @@
 	/* 11 */ DECLARE_NV_DEV("NFORCE3-250-SATA"),
 	/* 12 */ DECLARE_NV_DEV("NFORCE3-250-SATA2"),
 	/* 13 */ DECLARE_NV_DEV("NFORCE-CK804"),
-	/* 14 */ DECLARE_NV_DEV("NFORCE-CK804-SATA"),
-	/* 15 */ DECLARE_NV_DEV("NFORCE-CK804-SATA2"),
-	/* 16 */ DECLARE_NV_DEV("NFORCE-MCP04"),
-	/* 17 */ DECLARE_NV_DEV("NFORCE-MCP04-SATA"),
-	/* 18 */ DECLARE_NV_DEV("NFORCE-MCP04-SATA2")
+	/* 14 */ DECLARE_NV_DEV("NFORCE-MCP04"),
 };
 
 static int __devinit amd74xx_probe(struct pci_dev *dev, const struct pci_device_id *id)
@@ -512,17 +504,17 @@
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  5 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  6 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  7 },
+#ifdef CONFIG_BLK_DEV_IDE_SATA
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  8 },
+#endif
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0,  9 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10 },
+#ifdef CONFIG_BLK_DEV_IDE_SATA
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12 },
+#endif
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17 },
-	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_IDE,	PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
diff -Nru a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
--- a/drivers/ide/pci/generic.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/ide/pci/generic.c	2004-06-17 00:28:35 -04:00
@@ -127,7 +127,9 @@
 	{ PCI_VENDOR_ID_HINT,   PCI_DEVICE_ID_HINT_VXPROII_IDE,    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 6},
 	{ PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 7},
 	{ PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, PCI_ANY_ID, 0, 0, 8},
+#ifdef CONFIG_BLK_DEV_IDE_SATA
 	{ PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237_SATA,	   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 9},
+#endif
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
 	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
diff -Nru a/drivers/ide/pci/piix.c b/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/ide/pci/piix.c	2004-06-17 00:28:35 -04:00
@@ -793,9 +793,9 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_11,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 15},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801E_11, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 16},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_10,PCI_ANY_ID, PCI_ANY_ID, 0, 0, 17},
-#ifndef CONFIG_SCSI_SATA
+#ifdef CONFIG_BLK_DEV_IDE_SATA
  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 18},
-#endif /* !CONFIG_SCSI_SATA */
+#endif
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 19},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_19, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 20},
 	{ 0, },
diff -Nru a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
--- a/drivers/ide/pci/siimage.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/ide/pci/siimage.c	2004-06-17 00:28:35 -04:00
@@ -21,6 +21,7 @@
  *	if neccessary
  */
 
+#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -1127,8 +1128,10 @@
 
 static struct pci_device_id siimage_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+#ifdef CONFIG_BLK_DEV_IDE_SATA
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+#endif
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, siimage_pci_tbl);
diff -Nru a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/Kconfig	2004-06-17 00:28:35 -04:00
@@ -422,6 +422,14 @@
 
 	  If unsure, say N.
 
+config SCSI_SATA_NV
+	tristate "NVIDIA SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for NVIDIA Serial ATA.
+
+	  If unsure, say N.
+
 config SCSI_SATA_PROMISE
 	tristate "Promise SATA TX2/TX4 support"
 	depends on SCSI_SATA && PCI
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/Makefile	2004-06-17 00:28:35 -04:00
@@ -127,6 +127,7 @@
 obj-$(CONFIG_SCSI_SATA_VITESSE)	+= libata.o sata_vsc.o
 obj-$(CONFIG_SCSI_SATA_SIS)	+= libata.o sata_sis.o
 obj-$(CONFIG_SCSI_SATA_SX4)	+= libata.o sata_sx4.o
+obj-$(CONFIG_SCSI_SATA_NV)	+= libata.o sata_nv.o
 
 obj-$(CONFIG_ARM)		+= arm/
 
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-06-17 00:28:35 -04:00
@@ -138,7 +138,7 @@
 
 	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
@@ -161,7 +161,7 @@
 
 	.bmdma_setup		= ata_bmdma_setup_pio,
 	.bmdma_start		= ata_bmdma_start_pio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/libata-core.c	2004-06-17 00:28:35 -04:00
@@ -50,7 +50,6 @@
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
 static void __ata_dev_select (struct ata_port *ap, unsigned int device);
-static void ata_dma_complete(struct ata_queued_cmd *qc, u8 host_stat);
 static void ata_host_set_pio(struct ata_port *ap);
 static void ata_host_set_udma(struct ata_port *ap);
 static void ata_dev_set_pio(struct ata_port *ap, unsigned int device);
@@ -65,37 +64,6 @@
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
 
-static const char * thr_state_name[] = {
-	"THR_UNKNOWN",
-	"THR_PORT_RESET",
-	"THR_AWAIT_DEATH",
-	"THR_PROBE_FAILED",
-	"THR_IDLE",
-	"THR_PROBE_SUCCESS",
-	"THR_PROBE_START",
-};
-
-/**
- *	ata_thr_state_name - convert thread state enum to string
- *	@thr_state: thread state to be converted to string
- *
- *	Converts the specified thread state id to a constant C string.
- *
- *	LOCKING:
- *	None.
- *
- *	RETURNS:
- *	The THR_xxx-prefixed string naming the specified thread
- *	state id, or the string "<invalid THR_xxx state>".
- */
-
-static const char *ata_thr_state_name(unsigned int thr_state)
-{
-	if (thr_state < ARRAY_SIZE(thr_state_name))
-		return thr_state_name[thr_state];
-	return "<invalid THR_xxx state>";
-}
-
 /**
  *	ata_tf_load_pio - send taskfile registers to host controller
  *	@ap: Port to which output is sent
@@ -1150,13 +1118,16 @@
 }
 
 /**
- *	ata_port_reset -
- *	@ap:
+ *	ata_bus_probe - Reset and probe ATA bus
+ *	@ap: Bus to probe
  *
  *	LOCKING:
+ *
+ *	RETURNS:
+ *	Zero on success, non-zero on error.
  */
 
-static void ata_port_reset(struct ata_port *ap)
+static int ata_bus_probe(struct ata_port *ap)
 {
 	unsigned int i, found = 0;
 
@@ -1180,14 +1151,12 @@
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		goto err_out_disable;
 
-	ap->thr_state = THR_PROBE_SUCCESS;
-
-	return;
+	return 0;
 
 err_out_disable:
 	ap->ops->port_disable(ap);
 err_out:
-	ap->thr_state = THR_PROBE_FAILED;
+	return -1;
 }
 
 /**
@@ -1806,13 +1775,13 @@
 }
 
 /**
- *	ata_fill_sg -
- *	@qc:
+ *	ata_fill_sg - Fill PCI IDE PRD table
+ *	@qc: Metadata associated with taskfile to be transferred
  *
  *	LOCKING:
  *
  */
-void ata_fill_sg(struct ata_queued_cmd *qc)
+static void ata_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
@@ -1854,6 +1823,21 @@
 }
 
 /**
+ *	ata_qc_prep - Prepare taskfile for submission
+ *	@qc: Metadata associated with taskfile to be prepared
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+void ata_qc_prep(struct ata_queued_cmd *qc)
+{
+	if (!(qc->flags & ATA_QCFLAG_SG))
+		return;
+
+	ata_fill_sg(qc);
+}
+
+/**
  *	ata_sg_setup_one -
  *	@qc:
  *
@@ -1870,7 +1854,6 @@
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	int dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
 	struct scatterlist *sg = qc->sg;
-	unsigned int have_sg = (qc->flags & ATA_QCFLAG_SG);
 	dma_addr_t dma_address;
 
 	assert(sg == &qc->sgent);
@@ -1880,9 +1863,6 @@
 	sg->offset = (unsigned long) cmd->request_buffer & ~PAGE_MASK;
 	sg_dma_len(sg) = cmd->request_bufflen;
 
-	if (!have_sg)
-		return 0;
-
 	dma_address = pci_map_single(ap->host_set->pdev, cmd->request_buffer,
 				     cmd->request_bufflen, dir);
 	if (pci_dma_mapping_error(dma_address))
@@ -1912,22 +1892,19 @@
 	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct scatterlist *sg;
-	int n_elem;
-	unsigned int have_sg = (qc->flags & ATA_QCFLAG_SG);
+	int n_elem, dir;
 
 	VPRINTK("ENTER, ata%u, use_sg %d\n", ap->id, cmd->use_sg);
 	assert(cmd->use_sg > 0);
 
 	sg = (struct scatterlist *)cmd->request_buffer;
-	if (have_sg) {
-		int dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
-		n_elem = pci_map_sg(ap->host_set->pdev, sg, cmd->use_sg, dir);
-		if (n_elem < 1)
-			return -1;
-		DPRINTK("%d sg elements mapped\n", n_elem);
-	} else {
-		n_elem = cmd->use_sg;
-	}
+	dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+	n_elem = pci_map_sg(ap->host_set->pdev, sg, cmd->use_sg, dir);
+	if (n_elem < 1)
+		return -1;
+
+	DPRINTK("%d sg elements mapped\n", n_elem);
+
 	qc->n_elem = n_elem;
 
 	return 0;
@@ -2166,7 +2143,7 @@
 
 void ata_eng_timeout(struct ata_port *ap)
 {
-	u8 host_stat, drv_stat;
+	u8 host_stat = 0, drv_stat;
 	struct ata_queued_cmd *qc;
 
 	DPRINTK("ENTER\n");
@@ -2187,34 +2164,28 @@
 	qc->scsidone = scsi_finish_command;
 
 	switch (qc->tf.protocol) {
+
 	case ATA_PROT_DMA:
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			host_stat = readb(mmio + ATA_DMA_STATUS);
-		} else
-			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	case ATA_PROT_ATAPI_DMA:
+		host_stat = ata_bmdma_status(ap);
 
-		printk(KERN_ERR "ata%u: DMA timeout, stat 0x%x\n",
-		       ap->id, host_stat);
+		/* before we do anything else, clear DMA-Start bit */
+		ata_bmdma_stop(ap);
 
-		ata_dma_complete(qc, host_stat);
-		break;
+		/* fall through */
 
 	case ATA_PROT_NODATA:
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-
-		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat);
-
-		ata_qc_complete(qc, drv_stat);
-		break;
-
 	default:
-		drv_stat = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
+		ata_altstatus(ap);
+		drv_stat = ata_chk_status(ap);
 
-		printk(KERN_ERR "ata%u: unknown timeout, cmd 0x%x stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat);
+		/* ack bmdma irq events */
+		ata_bmdma_ack_irq(ap);
 
+		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
+		       ap->id, qc->tf.command, drv_stat, host_stat);
+
+		/* complete taskfile transaction */
 		ata_qc_complete(qc, drv_stat);
 		break;
 	}
@@ -2362,10 +2333,10 @@
 			if (ata_sg_setup_one(qc))
 				goto err_out;
 		}
-
-		ap->ops->fill_sg(qc);
 	}
 
+	ap->ops->qc_prep(qc);
+
 	qc->ap->active_tag = qc->tag;
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 
@@ -2446,7 +2417,7 @@
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 host_stat, dmactl;
+	u8 dmactl;
 	void *mmio = (void *) ap->ioaddr.bmdma_addr;
 
 	/* load PRD table addr. */
@@ -2460,10 +2431,6 @@
 		dmactl |= ATA_DMA_WR;
 	writeb(dmactl, mmio + ATA_DMA_CMD);
 
-	/* clear interrupt, error bits */
-	host_stat = readb(mmio + ATA_DMA_STATUS);
-	writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR, mmio + ATA_DMA_STATUS);
-
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
 }
@@ -2511,7 +2478,7 @@
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
-	u8 host_stat, dmactl;
+	u8 dmactl;
 
 	/* load PRD table addr. */
 	outl(ap->prd_dma, ap->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
@@ -2523,11 +2490,6 @@
 		dmactl |= ATA_DMA_WR;
 	outb(dmactl, ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
 
-	/* clear interrupt, error bits */
-	host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-	     ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-
 	/* issue r/w command */
 	ap->ops->exec_command(ap, &qc->tf);
 }
@@ -2552,50 +2514,6 @@
 }
 
 /**
- *	ata_dma_complete - Complete an active ATA BMDMA command
- *	@qc: Command to complete
- *	@host_stat: BMDMA status register contents
- *
- *	LOCKING:
- */
-
-static void ata_dma_complete(struct ata_queued_cmd *qc, u8 host_stat)
-{
-	struct ata_port *ap = qc->ap;
-	VPRINTK("ENTER\n");
-
-	if (ap->flags & ATA_FLAG_MMIO) {
-		void *mmio = (void *) ap->ioaddr.bmdma_addr;
-
-		/* clear start/stop bit */
-		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
-		       mmio + ATA_DMA_CMD);
-
-		/* ack intr, err bits */
-		writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		       mmio + ATA_DMA_STATUS);
-	} else {
-		/* clear start/stop bit */
-		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
-		     ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
-
-		/* ack intr, err bits */
-		outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
-		     ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
-	}
-
-
-	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
-	ata_altstatus(ap);		/* dummy read */
-
-	DPRINTK("host %u, host_stat==0x%X, drv_stat==0x%X\n",
-		ap->id, (u32) host_stat, (u32) ata_chk_status(ap));
-
-	/* get drive status; clear intr; complete txn */
-	ata_qc_complete(qc, ata_wait_idle(ap));
-}
-
-/**
  *	ata_host_intr - Handle host interrupt for given (port, task)
  *	@ap: Port on which interrupt arrived (possibly...)
  *	@qc: Taskfile currently active in engine
@@ -2615,59 +2533,60 @@
 				   struct ata_queued_cmd *qc)
 {
 	u8 status, host_stat;
-	unsigned int handled = 0;
 
 	switch (qc->tf.protocol) {
 
-	/* BMDMA completion */
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
-		if (ap->flags & ATA_FLAG_MMIO) {
-			void *mmio = (void *) ap->ioaddr.bmdma_addr;
-			host_stat = readb(mmio + ATA_DMA_STATUS);
-		} else
-			host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		/* check status of DMA engine */
+		host_stat = ata_bmdma_status(ap);
 		VPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
 
-		if (!(host_stat & ATA_DMA_INTR)) {
-			ap->stats.idle_irq++;
-			break;
-		}
+		/* if it's not our irq... */
+		if (!(host_stat & ATA_DMA_INTR))
+			goto idle_irq;
 
-		ata_dma_complete(qc, host_stat);
-		handled = 1;
-		break;
+		/* before we do anything else, clear DMA-Start bit */
+		ata_bmdma_stop(ap);
+
+		/* fall through */
 
-	/* command completion, but no data xfer */
-	/* FIXME: a shared interrupt _will_ cause a non-data command
-	 * to be completed prematurely, with an error.
-	 *
-	 * This doesn't matter right now, since we aren't sending
-	 * non-data commands down this pipe except in development
-	 * situations.
-	 */
-	case ATA_PROT_ATAPI:
 	case ATA_PROT_NODATA:
-		status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
-		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
+		/* check altstatus */
+		status = ata_altstatus(ap);
+		if (status & ATA_BUSY)
+			goto idle_irq;
+
+		/* check main status, clearing INTRQ */
+		status = ata_chk_status(ap);
+		if (unlikely(status & ATA_BUSY))
+			goto idle_irq;
+		DPRINTK("BUS_NODATA (dev_stat 0x%X)\n", status);
+
+		/* ack bmdma irq events */
+		ata_bmdma_ack_irq(ap);
+
+		/* complete taskfile transaction */
 		ata_qc_complete(qc, status);
-		handled = 1;
 		break;
 
 	default:
-		ap->stats.idle_irq++;
+		goto idle_irq;
+	}
+
+	return 1;	/* irq handled */
+
+idle_irq:
+	ap->stats.idle_irq++;
 
 #ifdef ATA_IRQ_TRAP
-		if ((ap->stats.idle_irq % 1000) == 0) {
-			handled = 1;
-			ata_irq_ack(ap, 0); /* debug trap */
-			printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
-		}
-#endif
-		break;
+	if ((ap->stats.idle_irq % 1000) == 0) {
+		handled = 1;
+		ata_irq_ack(ap, 0); /* debug trap */
+		printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
 	}
-
-	return handled;
+#endif
+	return 0;	/* irq not handled */
 }
 
 /**
@@ -2701,7 +2620,7 @@
 
 			qc = ata_qc_from_tag(ap, ap->active_tag);
 			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
-				handled += ata_host_intr(ap, qc);
+				handled |= ata_host_intr(ap, qc);
 		}
 	}
 
@@ -2711,62 +2630,6 @@
 }
 
 /**
- *	ata_thread_iter -
- *	@ap:
- *
- *	LOCKING:
- *
- *	RETURNS:
- *
- */
-
-static unsigned long ata_thread_iter(struct ata_port *ap)
-{
-	long timeout = 0;
-
-	DPRINTK("ata%u: thr_state %s\n",
-		ap->id, ata_thr_state_name(ap->thr_state));
-
-	switch (ap->thr_state) {
-	case THR_UNKNOWN:
-		ap->thr_state = THR_PORT_RESET;
-		break;
-
-	case THR_PROBE_START:
-		ap->thr_state = THR_PORT_RESET;
-		break;
-
-	case THR_PORT_RESET:
-		ata_port_reset(ap);
-		break;
-
-	case THR_PROBE_SUCCESS:
-		up(&ap->probe_sem);
-		ap->thr_state = THR_IDLE;
-		break;
-
-	case THR_PROBE_FAILED:
-		up(&ap->probe_sem);
-		ap->thr_state = THR_AWAIT_DEATH;
-		break;
-
-	case THR_AWAIT_DEATH:
-	case THR_IDLE:
-		timeout = -1;
-		break;
-
-	default:
-		printk(KERN_DEBUG "ata%u: unknown thr state %s\n",
-		       ap->id, ata_thr_state_name(ap->thr_state));
-		break;
-	}
-
-	DPRINTK("ata%u: new thr_state %s, returning %ld\n",
-		ap->id, ata_thr_state_name(ap->thr_state), timeout);
-	return timeout;
-}
-
-/**
  *	atapi_packet_task - Write CDB bytes to hardware
  *	@_data: Port to which ATAPI device is attached.
  *
@@ -2847,21 +2710,6 @@
 	pci_free_consistent(pdev, ATA_PRD_TBL_SZ, ap->prd, ap->prd_dma);
 }
 
-static void ata_probe_task(void *_data)
-{
-	struct ata_port *ap = _data;
-	long timeout;
-
-	timeout = ata_thread_iter(ap);
-	if (timeout < 0)
-		return;
-
-	if (timeout > 0)
-		queue_delayed_work(ata_wq, &ap->probe_task, timeout);
-	else
-		queue_work(ata_wq, &ap->probe_task);
-}
-
 /**
  *	ata_host_remove - Unregister SCSI host structure with upper layers
  *	@ap: Port to unregister
@@ -2918,7 +2766,6 @@
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
-	ap->thr_state = THR_PROBE_START;
 	ap->cbl = ATA_CBL_NONE;
 	ap->device[0].flags = ATA_DFLAG_MASTER;
 	ap->active_tag = ATA_TAG_POISON;
@@ -2926,13 +2773,10 @@
 
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
-	INIT_WORK(&ap->probe_task, ata_probe_task, ap);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		ap->device[i].devno = i;
 
-	init_MUTEX_LOCKED(&ap->probe_sem);
-
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
 	ap->stats.idle_irq = 1;
@@ -3041,6 +2885,10 @@
 		return 0;
 	}
 
+	/* TODO: ack irq here, to ensure it won't scream
+	 * when we enable it?
+	 */
+
 	/* obtain irq, that is shared between channels */
 	if (request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
 			DRV_NAME, host_set))
@@ -3055,12 +2903,17 @@
 		ap = host_set->ports[i];
 
 		DPRINTK("ata%u: probe begin\n", ap->id);
-		queue_work(ata_wq, &ap->probe_task);	/* start probe */
+		rc = ata_bus_probe(ap);
+		DPRINTK("ata%u: probe end\n", ap->id);
 
-		DPRINTK("ata%u: probe-wait begin\n", ap->id);
-		down(&ap->probe_sem);	/* wait for end */
-
-		DPRINTK("ata%u: probe-wait end\n", ap->id);
+		if (rc) {
+			/* FIXME: do something useful here?
+			 * Current libata behavior will
+			 * tear down everything when
+			 * the module is removed
+			 * or the h/w is unplugged.
+			 */
+		}
 
 		rc = scsi_add_host(ap->host, &pdev->dev);
 		if (rc) {
@@ -3480,7 +3333,7 @@
 EXPORT_SYMBOL_GPL(ata_port_start);
 EXPORT_SYMBOL_GPL(ata_port_stop);
 EXPORT_SYMBOL_GPL(ata_interrupt);
-EXPORT_SYMBOL_GPL(ata_fill_sg);
+EXPORT_SYMBOL_GPL(ata_qc_prep);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_start_pio);
 EXPORT_SYMBOL_GPL(ata_bmdma_setup_mmio);
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/scsi/sata_nv.c	2004-06-17 00:28:35 -04:00
@@ -0,0 +1,353 @@
+/*
+ *  sata_nv.c - NVIDIA nForce SATA
+ *
+ *  Copyright 2004 NVIDIA Corp.  All rights reserved.
+ *  Copyright 2004 Andrew Chew
+ *
+ *  The contents of this file are subject to the Open
+ *  Software License version 1.1 that can be found at
+ *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
+ *  by reference.
+ *
+ *  Alternatively, the contents of this file may be used under the terms
+ *  of the GNU General Public License version 2 (the "GPL") as distributed
+ *  in the kernel source COPYING file, in which case the provisions of
+ *  the GPL are applicable instead of the above.  If you wish to allow
+ *  the use of your version of this file only under the terms of the
+ *  GPL and not to allow others to use your version of this file under
+ *  the OSL, indicate your decision by deleting the provisions above and
+ *  replace them with the notice and other provisions required by the GPL.
+ *  If you do not delete the provisions above, a recipient may use your
+ *  version of this file under either the OSL or the GPL.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include "scsi.h"
+#include "hosts.h"
+#include <linux/libata.h>
+
+#define DRV_NAME			"sata_nv"
+#define DRV_VERSION			"0.01"
+
+#define NV_PORTS			2
+#define NV_PIO_MASK			0x1f
+#define NV_UDMA_MASK			0x7f
+#define NV_PORT0_BMDMA_REG_OFFSET	0x00
+#define NV_PORT1_BMDMA_REG_OFFSET	0x08
+#define NV_PORT0_SCR_REG_OFFSET		0x00
+#define NV_PORT1_SCR_REG_OFFSET		0x40
+
+#define NV_INT_STATUS			0x10
+#define NV_INT_STATUS_PDEV_INT		0x01
+#define NV_INT_STATUS_PDEV_PM		0x02
+#define NV_INT_STATUS_PDEV_ADDED	0x04
+#define NV_INT_STATUS_PDEV_REMOVED	0x08
+#define NV_INT_STATUS_SDEV_INT		0x10
+#define NV_INT_STATUS_SDEV_PM		0x20
+#define NV_INT_STATUS_SDEV_ADDED	0x40
+#define NV_INT_STATUS_SDEV_REMOVED	0x80
+#define NV_INT_STATUS_PDEV_HOTPLUG	(NV_INT_STATUS_PDEV_ADDED | \
+					NV_INT_STATUS_PDEV_REMOVED)
+#define NV_INT_STATUS_SDEV_HOTPLUG	(NV_INT_STATUS_SDEV_ADDED | \
+					NV_INT_STATUS_SDEV_REMOVED)
+#define NV_INT_STATUS_HOTPLUG		(NV_INT_STATUS_PDEV_HOTPLUG | \
+					NV_INT_STATUS_SDEV_HOTPLUG)
+
+#define NV_INT_ENABLE			0x11
+#define NV_INT_ENABLE_PDEV_MASK		0x01
+#define NV_INT_ENABLE_PDEV_PM		0x02
+#define NV_INT_ENABLE_PDEV_ADDED	0x04
+#define NV_INT_ENABLE_PDEV_REMOVED	0x08
+#define NV_INT_ENABLE_SDEV_MASK		0x10
+#define NV_INT_ENABLE_SDEV_PM		0x20
+#define NV_INT_ENABLE_SDEV_ADDED	0x40
+#define NV_INT_ENABLE_SDEV_REMOVED	0x80
+#define NV_INT_ENABLE_PDEV_HOTPLUG	(NV_INT_ENABLE_PDEV_ADDED | \
+					NV_INT_ENABLE_PDEV_REMOVED)
+#define NV_INT_ENABLE_SDEV_HOTPLUG	(NV_INT_ENABLE_SDEV_ADDED | \
+					NV_INT_ENABLE_SDEV_REMOVED)
+#define NV_INT_ENABLE_HOTPLUG		(NV_INT_ENABLE_PDEV_HOTPLUG | \
+					NV_INT_ENABLE_SDEV_HOTPLUG)
+
+#define NV_INT_CONFIG			0x12
+#define NV_INT_CONFIG_METHD		0x01 // 0 = INT, 1 = SMI
+
+static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
+static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void nv_host_stop (struct ata_host_set *host_set);
+
+static struct pci_device_id nv_pci_tbl[] = {
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE2S_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE3S_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_CK804_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0, } /* terminate list */
+};
+
+static struct pci_driver nv_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= nv_pci_tbl,
+	.probe			= nv_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static Scsi_Host_Template nv_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= ATA_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations nv_ops = {
+	.port_disable		= ata_port_disable,
+	.tf_load		= ata_tf_load_pio,
+	.tf_read		= ata_tf_read_pio,
+	.exec_command		= ata_exec_command_pio,
+	.check_status		= ata_check_status_pio,
+	.phy_reset		= sata_phy_reset,
+	.bmdma_setup		= ata_bmdma_setup_pio,
+	.bmdma_start		= ata_bmdma_start_pio,
+	.qc_prep		= ata_qc_prep,
+	.eng_timeout		= ata_eng_timeout,
+	.irq_handler		= nv_interrupt,
+	.scr_read		= nv_scr_read,
+	.scr_write		= nv_scr_write,
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= nv_host_stop,
+};
+
+MODULE_AUTHOR("NVIDIA");
+MODULE_DESCRIPTION("low-level driver for NVIDIA nForce SATA controller");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, nv_pci_tbl);
+
+irqreturn_t nv_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	unsigned int i;
+	unsigned int handled = 0;
+	unsigned long flags;
+	u8 intr_status;
+	u8 intr_enable;
+
+	spin_lock_irqsave(&host_set->lock, flags);
+
+	for (i = 0; i < host_set->n_ports; i++) {
+		struct ata_port *ap;
+
+		ap = host_set->ports[i];
+		if (ap && (!(ap->flags & ATA_FLAG_PORT_DISABLED))) {
+			struct ata_queued_cmd *qc;
+
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (qc && (!(qc->tf.ctl & ATA_NIEN)))
+				handled += ata_host_intr(ap, qc);
+		}
+
+		intr_status = inb(ap->ioaddr.scr_addr + NV_INT_STATUS);
+		intr_enable = inb(ap->ioaddr.scr_addr + NV_INT_ENABLE);
+
+		// Clear interrupt status.
+		outb(0xff, ap->ioaddr.scr_addr + NV_INT_STATUS);
+
+		if (intr_status & NV_INT_STATUS_HOTPLUG) {
+			if (intr_status & NV_INT_STATUS_PDEV_ADDED) {
+				printk(KERN_WARNING "ata%u: "
+					"Primary device added\n", ap->id);
+			}
+
+			if (intr_status & NV_INT_STATUS_PDEV_REMOVED) {
+				printk(KERN_WARNING "ata%u: "
+					"Primary device removed\n", ap->id);
+			}
+
+			if (intr_status & NV_INT_STATUS_SDEV_ADDED) {
+				printk(KERN_WARNING "ata%u: "
+					"Secondary device added\n", ap->id);
+			}
+
+			if (intr_status & NV_INT_STATUS_SDEV_REMOVED) {
+				printk(KERN_WARNING "ata%u: "
+					"Secondary device removed\n", ap->id);
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
+static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg)
+{
+	if (sc_reg > SCR_CONTROL)
+		return 0xffffffffU;
+
+	return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
+}
+
+static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+{
+	if (sc_reg > SCR_CONTROL)
+		return;
+
+	outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+}
+
+static void nv_host_stop (struct ata_host_set *host_set)
+{
+	int i;
+
+	for (i=0; i<host_set->n_ports; i++) {
+		u8 intr_mask;
+
+		// Disable hotplug event interrupts.
+		intr_mask = inb(host_set->ports[i]->ioaddr.scr_addr +
+				NV_INT_ENABLE);
+		intr_mask &= ~(NV_INT_ENABLE_HOTPLUG);
+		outb(intr_mask, host_set->ports[i]->ioaddr.scr_addr +
+				NV_INT_ENABLE);
+	}
+}
+
+static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version = 0;
+	struct ata_probe_ent *probe_ent = NULL;
+	int i;
+	int rc;
+
+	if (!printed_version++)
+		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto err_out;
+
+	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		goto err_out_regions;
+	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		goto err_out_regions;
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (!probe_ent) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	probe_ent->pdev = pdev;
+	probe_ent->sht = &nv_sht;
+	probe_ent->host_flags = ATA_FLAG_SATA |
+				ATA_FLAG_SATA_RESET |
+				ATA_FLAG_SRST |
+				ATA_FLAG_NO_LEGACY;
+	probe_ent->port_ops = &nv_ops;
+	probe_ent->n_ports = NV_PORTS;
+	probe_ent->irq = pdev->irq;
+	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->pio_mask = NV_PIO_MASK;
+	probe_ent->udma_mask = NV_UDMA_MASK;
+
+	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
+	ata_std_ports(&probe_ent->port[0]);
+	probe_ent->port[0].altstatus_addr =
+	probe_ent->port[0].ctl_addr =
+		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
+	probe_ent->port[0].bmdma_addr =
+		pci_resource_start(pdev, 4) | NV_PORT0_BMDMA_REG_OFFSET;
+	probe_ent->port[0].scr_addr =
+		pci_resource_start(pdev, 5) | NV_PORT0_SCR_REG_OFFSET;
+
+	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
+	ata_std_ports(&probe_ent->port[1]);
+	probe_ent->port[1].altstatus_addr =
+	probe_ent->port[1].ctl_addr =
+		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
+	probe_ent->port[1].bmdma_addr =
+		pci_resource_start(pdev, 4) | NV_PORT1_BMDMA_REG_OFFSET;
+	probe_ent->port[1].scr_addr =
+		pci_resource_start(pdev, 5) | NV_PORT1_SCR_REG_OFFSET;
+
+	pci_set_master(pdev);
+
+	rc = ata_device_add(probe_ent);
+	if (rc != NV_PORTS)
+		goto err_out_regions;
+
+	// Enable hotplug event interrupts.
+	for (i=0; i<probe_ent->n_ports; i++) {
+		u8 intr_mask;
+
+		outb(NV_INT_STATUS_HOTPLUG, probe_ent->port[i].scr_addr +
+						NV_INT_STATUS);
+
+		intr_mask = inb(probe_ent->port[i].scr_addr + NV_INT_ENABLE);
+		intr_mask |= NV_INT_ENABLE_HOTPLUG;
+		outb(intr_mask, probe_ent->port[i].scr_addr + NV_INT_ENABLE);
+	}
+
+	kfree(probe_ent);
+
+	return 0;
+
+err_out_regions:
+	pci_release_regions(pdev);
+
+err_out:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+static int __init nv_init(void)
+{
+	return pci_module_init(&nv_pci_driver);
+}
+
+static void __exit nv_exit(void)
+{
+	pci_unregister_driver(&nv_pci_driver);
+}
+
+module_init(nv_init);
+module_exit(nv_exit);
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/sata_promise.c	2004-06-17 00:28:35 -04:00
@@ -81,7 +81,7 @@
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
 static void pdc_phy_reset(struct ata_port *ap);
-static void pdc_fill_sg(struct ata_queued_cmd *qc);
+static void pdc_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static inline void pdc_dma_complete (struct ata_port *ap,
@@ -114,7 +114,7 @@
 	.phy_reset		= pdc_phy_reset,
 	.bmdma_setup            = pdc_dma_setup,
 	.bmdma_start            = pdc_dma_start,
-	.fill_sg		= pdc_fill_sg,
+	.qc_prep		= pdc_qc_prep,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc_interrupt,
 	.scr_read		= pdc_sata_scr_read,
@@ -261,14 +261,14 @@
 	writel(val, (void *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
 
-static void pdc_fill_sg(struct ata_queued_cmd *qc)
+static void pdc_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct pdc_port_priv *pp = qc->ap->private_data;
 	unsigned int i;
 
 	VPRINTK("ENTER\n");
 
-	ata_fill_sg(qc);
+	ata_qc_prep(qc);
 
 	i = pdc_pkt_header(&qc->tf, qc->ap->prd_dma,  qc->dev->devno, pp->pkt);
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-06-17 00:28:35 -04:00
@@ -131,7 +131,7 @@
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.scr_read		= sil_scr_read,
diff -Nru a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/sata_sis.c	2004-06-17 00:28:35 -04:00
@@ -100,7 +100,7 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.scr_read		= sis_scr_read,
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/sata_svw.c	2004-06-17 00:28:35 -04:00
@@ -233,7 +233,7 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= ata_interrupt,
 	.scr_read		= k2_sata_scr_read,
diff -Nru a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/sata_sx4.c	2004-06-17 00:28:35 -04:00
@@ -153,7 +153,7 @@
 static void pdc_20621_phy_reset (struct ata_port *ap);
 static int pdc_port_start(struct ata_port *ap);
 static void pdc_port_stop(struct ata_port *ap);
-static void pdc20621_fill_sg(struct ata_queued_cmd *qc);
+static void pdc20621_qc_prep(struct ata_queued_cmd *qc);
 static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf);
 static void pdc20621_host_stop(struct ata_host_set *host_set);
@@ -200,7 +200,7 @@
 	.phy_reset		= pdc_20621_phy_reset,
 	.bmdma_setup            = pdc20621_dma_setup,
 	.bmdma_start            = pdc20621_dma_start,
-	.fill_sg		= pdc20621_fill_sg,
+	.qc_prep		= pdc20621_qc_prep,
 	.eng_timeout		= pdc_eng_timeout,
 	.irq_handler		= pdc20621_interrupt,
 	.port_start		= pdc_port_start,
@@ -434,7 +434,7 @@
 		buf32[dw + 3]);
 }
 
-static void pdc20621_fill_sg(struct ata_queued_cmd *qc)
+static void pdc20621_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct scatterlist *sg = qc->sg;
 	struct ata_port *ap = qc->ap;
@@ -445,6 +445,9 @@
 	unsigned int portno = ap->port_no;
 	unsigned int i, last, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
+
+	if (!(qc->flags & ATA_QCFLAG_SG))
+		return;
 
 	VPRINTK("ata%u: ENTER\n", ap->id);
 
diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/sata_via.c	2004-06-17 00:28:35 -04:00
@@ -108,7 +108,7 @@
 
 	.bmdma_setup            = ata_bmdma_setup_pio,
 	.bmdma_start            = ata_bmdma_start_pio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 
 	.irq_handler		= ata_interrupt,
diff -Nru a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2004-06-17 00:28:35 -04:00
+++ b/drivers/scsi/sata_vsc.c	2004-06-17 00:28:35 -04:00
@@ -215,7 +215,7 @@
 	.phy_reset		= sata_phy_reset,
 	.bmdma_setup            = ata_bmdma_setup_mmio,
 	.bmdma_start            = ata_bmdma_start_mmio,
-	.fill_sg		= ata_fill_sg,
+	.qc_prep		= ata_qc_prep,
 	.eng_timeout		= ata_eng_timeout,
 	.irq_handler		= vsc_sata_interrupt,
 	.scr_read		= vsc_sata_scr_read,
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-06-17 00:28:35 -04:00
+++ b/include/linux/libata.h	2004-06-17 00:28:35 -04:00
@@ -133,15 +133,6 @@
 	BUS_IDENTIFY		= 8,
 	BUS_PACKET		= 9,
 
-	/* thread states */
-	THR_UNKNOWN		= 0,
-	THR_PORT_RESET		= (THR_UNKNOWN + 1),
-	THR_AWAIT_DEATH		= (THR_PORT_RESET + 1),
-	THR_PROBE_FAILED	= (THR_AWAIT_DEATH + 1),
-	THR_IDLE		= (THR_PROBE_FAILED + 1),
-	THR_PROBE_SUCCESS	= (THR_IDLE + 1),
-	THR_PROBE_START		= (THR_PROBE_SUCCESS + 1),
-
 	/* SATA port states */
 	PORT_UNKNOWN		= 0,
 	PORT_ENABLED		= 1,
@@ -294,18 +285,12 @@
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
 
-	struct semaphore	probe_sem;
-
-	unsigned int		thr_state;
-
 	struct work_struct	packet_task;
 
 	struct work_struct	pio_task;
 	unsigned int		pio_task_state;
 	unsigned long		pio_task_timeout;
 
-	struct work_struct	probe_task;
-
 	void			*private_data;
 };
 
@@ -330,7 +315,7 @@
 
 	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
-	void (*fill_sg) (struct ata_queued_cmd *qc);
+	void (*qc_prep) (struct ata_queued_cmd *qc);
 	void (*eng_timeout) (struct ata_port *ap);
 
 	irqreturn_t (*irq_handler)(int, void *, struct pt_regs *);
@@ -390,7 +375,7 @@
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern irqreturn_t ata_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
-extern void ata_fill_sg(struct ata_queued_cmd *qc);
+extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
 extern void ata_bmdma_setup_mmio (struct ata_queued_cmd *qc);
@@ -554,6 +539,46 @@
 static inline unsigned int sata_dev_present(struct ata_port *ap)
 {
 	return ((scr_read(ap, SCR_STATUS) & 0xf) == 0x3) ? 1 : 0;
+}
+
+static inline void ata_bmdma_stop(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+
+		/* clear start/stop bit */
+		writeb(readb(mmio + ATA_DMA_CMD) & ~ATA_DMA_START,
+		      mmio + ATA_DMA_CMD);
+	} else {
+		/* clear start/stop bit */
+		outb(inb(ap->ioaddr.bmdma_addr + ATA_DMA_CMD) & ~ATA_DMA_START,
+		    ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	}
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_altstatus(ap);	      /* dummy read */
+}
+
+static inline void ata_bmdma_ack_irq(struct ata_port *ap)
+{
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = ((void *) ap->ioaddr.bmdma_addr) + ATA_DMA_STATUS;
+		writeb(readb(mmio), mmio);
+	} else {
+		unsigned long addr = ap->ioaddr.bmdma_addr + ATA_DMA_STATUS;
+		outb(inb(addr), addr);
+	}
+}
+
+static inline u8 ata_bmdma_status(struct ata_port *ap)
+{
+	u8 host_stat;
+	if (ap->flags & ATA_FLAG_MMIO) {
+		void *mmio = (void *) ap->ioaddr.bmdma_addr;
+		host_stat = readb(mmio + ATA_DMA_STATUS);
+	} else
+		host_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	return host_stat;
 }
 
 #endif /* __LINUX_LIBATA_H__ */
