Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVKSVmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVKSVmb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVKSVmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:42:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:36737 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750867AbVKSVmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:42:31 -0500
Subject: PATCH: Clean up and fix the VIA PATA libata driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Nov 2005 22:14:47 +0000
Message-Id: <1132438487.19692.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the enable bits bug for the VIA and also uses the change I
sent and you merged which allows a pci probe to pass private_data
through to the final host_set. This allows the driver to dramatically
shrink in size and replaces the set of methods for each chip type with a
single set of methods and config structure.

Adds a couple of printks to help debug some reports of hangs.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.14-mm2/drivers/scsi/pata_via.c linux-2.6.14-mm2/drivers/scsi/pata_via.c
--- linux.vanilla-2.6.14-mm2/drivers/scsi/pata_via.c	2005-11-19 17:28:03.000000000 +0000
+++ linux-2.6.14-mm2/drivers/scsi/pata_via.c	2005-11-19 17:34:41.000000000 +0000
@@ -60,7 +60,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_via"
-#define DRV_VERSION "0.1.1"
+#define DRV_VERSION "0.1.2"
 
 /*
  *	The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
@@ -139,7 +139,7 @@
 }
 
 /**
- *	via_early_phy_reset	-	reset for eary chip
+ *	via_phy_reset		-	reset for eary chip
  *	@ap: ATA port
  *
  *	Handle the reset callback for the later chips with cable detect
@@ -151,8 +151,8 @@
 
 	/* Note: When we add VIA 6410 remember it doesn't have enable bits */
 	static struct pci_bits via_enable_bits[] = {
-		{ 0x40, 0x02, 0x02 },
-		{ 0x40, 0x01, 0x01 }
+		{ 0x40, 1, 0x02, 0x02 },
+		{ 0x40, 1, 0x01, 0x01 }
 	};
 
 	if (!pci_test_config_bits(pdev, &via_enable_bits[ap->hard_port_no])) {
@@ -192,6 +192,8 @@
 	int ut;
 	int offset = 3 - (2*ap->hard_port_no) - adev->devno;
 
+	printk("via_do_set_mode: Mode=%d ast broken=%c udma=%d mul=%d\n",
+		mode, "YN"[set_ast], udma_type, tdiv);
 	/* Calculate the timing values we require */
 	ata_timing_compute(adev, adev->pio_mode, &t, T, UT);
 
@@ -247,54 +249,26 @@
 		pci_write_config_byte(pdev, 0x50 + offset, ut);
 }
 
-static void via_set_piomode_badast(struct ata_port *ap, struct ata_device *adev)
+static void via_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	via_do_set_mode(ap, adev, adev->pio_mode, 4, 0, 133);
-}
-
-static void via_set_dmamode_badast(struct ata_port *ap, struct ata_device *adev)
-{
-	via_do_set_mode(ap, adev, adev->dma_mode, 4, 0, 133);
-}
-
-static void via_set_piomode_100(struct ata_port *ap, struct ata_device *adev)
-{
-	via_do_set_mode(ap, adev, adev->pio_mode, 3, 1, 100);
-}
-
-static void via_set_dmamode_100(struct ata_port *ap, struct ata_device *adev)
-{
-	via_do_set_mode(ap, adev, adev->dma_mode, 3, 1, 100);
-}
-
-static void via_set_piomode_66(struct ata_port *ap, struct ata_device *adev)
-{
-	via_do_set_mode(ap, adev, adev->pio_mode, 2, 1, 66);
-}
-
-static void via_set_dmamode_66(struct ata_port *ap, struct ata_device *adev)
-{
-	via_do_set_mode(ap, adev, adev->dma_mode, 2, 1, 66);
-}
-
-static void via_set_piomode_33(struct ata_port *ap, struct ata_device *adev)
-{
-	via_do_set_mode(ap, adev, adev->pio_mode, 1, 1, 33);
-}
-
-static void via_set_dmamode_33(struct ata_port *ap, struct ata_device *adev)
-{
-	via_do_set_mode(ap, adev, adev->dma_mode, 1, 1, 33);
-}
-
-static void via_set_piomode_mwdma(struct ata_port *ap, struct ata_device *adev)
-{
-	via_do_set_mode(ap, adev, adev->pio_mode, 1, 1, 0);
-}
-
-static void via_set_dmamode_mwdma(struct ata_port *ap, struct ata_device *adev)
-{
-	via_do_set_mode(ap, adev, adev->dma_mode, 1, 1, 0);
+	const struct via_isa_bridge *config = ap->host_set->private_data;
+	int set_ast = (config->flags & VIA_BAD_AST) ? 0 : 1;
+	int mode = config->flags & VIA_UDMA;
+	static u8 tclock[5] = { 1, 1, 2, 3, 4 };
+	static u8 udma[5] = { 0, 33, 66, 100, 133 };
+	
+	via_do_set_mode(ap, adev, adev->pio_mode, tclock[mode], set_ast, udma[mode]);
+}
+
+static void via_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	const struct via_isa_bridge *config = ap->host_set->private_data;
+	int set_ast = (config->flags & VIA_BAD_AST) ? 0 : 1;
+	int mode = config->flags & VIA_UDMA;
+	static u8 tclock[5] = { 1, 1, 2, 3, 4 };
+	static u8 udma[5] = { 0, 33, 66, 100, 133 };
+	
+	via_do_set_mode(ap, adev, adev->dma_mode, tclock[mode], set_ast, udma[mode]);
 }
 
 static struct scsi_host_template via_sht = {
@@ -319,68 +293,8 @@
 
 static struct ata_port_operations via_port_ops = {
 	.port_disable	= ata_port_disable,
-	.set_piomode	= via_set_piomode_mwdma,
-	.set_dmamode	= via_set_dmamode_mwdma,
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.phy_reset	= via_phy_reset,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-
-	.port_start	= ata_port_start,
-	.port_stop	= ata_port_stop,
-	.host_stop	= ata_host_stop
-};
-
-static struct ata_port_operations via_port_ops_33 = {
-	.port_disable	= ata_port_disable,
-	.set_piomode	= via_set_piomode_33,
-	.set_dmamode	= via_set_dmamode_33,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.phy_reset	= via_phy_reset,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-
-	.port_start	= ata_port_start,
-	.port_stop	= ata_port_stop,
-	.host_stop	= ata_host_stop
-};
-
-static struct ata_port_operations via_port_ops_66 = {
-	.port_disable	= ata_port_disable,
-	.set_piomode	= via_set_piomode_66,
-	.set_dmamode	= via_set_dmamode_66,
-
+	.set_piomode	= via_set_piomode,
+	.set_dmamode	= via_set_dmamode,
 	.tf_load	= ata_tf_load,
 	.tf_read	= ata_tf_read,
 	.check_status 	= ata_check_status,
@@ -406,67 +320,6 @@
 	.host_stop	= ata_host_stop
 };
 
-static struct ata_port_operations via_port_ops_100 = {
-	.port_disable	= ata_port_disable,
-	.set_piomode	= via_set_piomode_100,
-	.set_dmamode	= via_set_dmamode_100,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.phy_reset	= via_phy_reset,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-
-	.port_start	= ata_port_start,
-	.port_stop	= ata_port_stop,
-	.host_stop	= ata_host_stop
-};
-
-static struct ata_port_operations via_badast_port_ops = {
-	.port_disable	= ata_port_disable,
-	.set_piomode	= via_set_piomode_badast,
-	.set_dmamode	= via_set_dmamode_badast,
-
-	.tf_load	= ata_tf_load,
-	.tf_read	= ata_tf_read,
-	.check_status 	= ata_check_status,
-	.exec_command	= ata_exec_command,
-	.dev_select 	= ata_std_dev_select,
-
-	.phy_reset	= via_phy_reset,
-
-	.bmdma_setup 	= ata_bmdma_setup,
-	.bmdma_start 	= ata_bmdma_start,
-	.bmdma_stop	= ata_bmdma_stop,
-	.bmdma_status 	= ata_bmdma_status,
-
-	.qc_prep 	= ata_qc_prep,
-	.qc_issue	= ata_qc_issue_prot,
-	.eng_timeout	= ata_eng_timeout,
-
-	.irq_handler	= ata_interrupt,
-	.irq_clear	= ata_bmdma_irq_clear,
-
-	.port_start	= ata_port_start,
-	.port_stop	= ata_port_stop,
-	.host_stop	= ata_host_stop
-};
-
-
 /**
  *	via_init_one		-	discovery callback
  *	@pdev: PCI device ID
@@ -493,7 +346,7 @@
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x7,
-		.port_ops = &via_port_ops_33
+		.port_ops = &via_port_ops
 	};
 	/* VIA UDMA 66 devices */
 	static struct ata_port_info via_udma66_info = {
@@ -502,7 +355,7 @@
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x1f,
-		.port_ops = &via_port_ops_66
+		.port_ops = &via_port_ops
 	};
 	/* VIA UDMA 100 devices */
 	static struct ata_port_info via_udma100_info = {
@@ -511,7 +364,7 @@
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,
-		.port_ops = &via_port_ops_100
+		.port_ops = &via_port_ops
 	};
 	/* UDMA133 with bad AST (All current 133) */
 	static struct ata_port_info via_udma133_info = {
@@ -520,9 +373,9 @@
 		.pio_mask = 0x1f,
 		.mwdma_mask = 0x07,
 		.udma_mask = 0x3f,	/* 0x7F but need to fix north bridge */
-		.port_ops = &via_badast_port_ops
+		.port_ops = &via_port_ops
 	};
-	static struct ata_port_info *port_info[2], *type;
+	struct ata_port_info *port_info[2], *type;
 	struct pci_dev *isa = NULL;
 	const struct via_isa_bridge *config;
 	static int printed_version;
@@ -613,6 +466,8 @@
 	}
 
 	/* We have established the device type, now fire it up */
+	type->private_data = (void *)config;
+	
 	port_info[0] = port_info[1] = type;
 	return ata_pci_init_one(pdev, port_info, 2);
 }
@@ -650,5 +505,3 @@
 
 module_init(via_init);
 module_exit(via_exit);
-
-

