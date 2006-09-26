Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWIZQei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWIZQei (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWIZQei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:34:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2699 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750866AbWIZQeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:34:37 -0400
Subject: [PATCH] libata-eh: Remove layering violation and duplication when
	handling absent ports
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 17:53:38 +0100
Message-Id: <1159289618.11049.259.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the layering violation where drivers have to fiddle
directly with EH flags. Instead we now recognize -ENOENT means "no port"
and do the handling in the core code.

This also removes an instance of a call to disable the port, and an
identical printk from each driver doing this. Even better - future rule
changes will be in one place only.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/ata_piix.c linux-2.6.18-mm1/drivers/ata/ata_piix.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/ata_piix.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/ata_piix.c	2006-09-25 14:25:52.000000000 +0100
@@ -672,11 +672,9 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/libata-eh.c linux-2.6.18-mm1/drivers/ata/libata-eh.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/libata-eh.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/libata-eh.c	2006-09-25 14:26:05.000000000 +0100
@@ -1515,7 +1515,11 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_amd.c linux-2.6.18-mm1/drivers/ata/pata_amd.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_amd.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_amd.c	2006-09-25 14:28:46.000000000 +0100
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_amd"
-#define DRV_VERSION "0.2.3"
+#define DRV_VERSION "0.2.4"
 
 /**
  *	timing_setup		-	shared timing computation and load
@@ -137,11 +137,8 @@
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
@@ -167,11 +164,9 @@
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
@@ -262,12 +257,8 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_artop.c linux-2.6.18-mm1/drivers/ata/pata_artop.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_artop.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_artop.c	2006-09-25 14:28:39.000000000 +0100
@@ -28,7 +28,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_artop"
-#define DRV_VERSION	"0.4.1"
+#define DRV_VERSION	"0.4.2"
 
 /*
  *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
@@ -47,11 +47,9 @@
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
@@ -90,11 +88,9 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_atiixp.c linux-2.6.18-mm1/drivers/ata/pata_atiixp.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_atiixp.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_atiixp.c	2006-09-25 14:28:32.000000000 +0100
@@ -22,7 +22,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_atiixp"
-#define DRV_VERSION "0.4.2"
+#define DRV_VERSION "0.4.3"
 
 enum {
 	ATIIXP_IDE_PIO_TIMING	= 0x40,
@@ -41,11 +41,9 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_efar.c linux-2.6.18-mm1/drivers/ata/pata_efar.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_efar.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_efar.c	2006-09-25 14:30:32.000000000 +0100
@@ -22,7 +22,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_efar"
-#define DRV_VERSION	"0.4.1"
+#define DRV_VERSION	"0.4.2"
 
 /**
  *	efar_pre_reset	-	check for 40/80 pin
@@ -42,11 +42,9 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_jmicron.c linux-2.6.18-mm1/drivers/ata/pata_jmicron.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_jmicron.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_jmicron.c	2006-09-25 14:31:32.000000000 +0100
@@ -51,7 +51,7 @@
 	/* Check if our port is enabled */
 	pci_read_config_dword(pdev, 0x40, &control);
 	if ((control & port_mask) == 0)
-		return 0;
+		return -ENOENT;
 
 	/* There are two basic mappings. One has the two SATA ports merged
 	   as master/slave and the secondary as PATA, the other has only the
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_mpiix.c linux-2.6.18-mm1/drivers/ata/pata_mpiix.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_mpiix.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_mpiix.c	2006-09-25 14:33:06.000000000 +0100
@@ -18,7 +18,7 @@
  * The driver conciously keeps this logic internally to avoid pushing quirky
  * PATA history into the clean libata layer.
  *
- * Thinkpad specific note: If you boot an MPIIX using thinkpad with a PCMCIA
+ * Thinkpad specific note: If you boot an MPIIX using a thinkpad with a PCMCIA
  * hard disk present this driver will not detect it. This is not a bug. In this
  * configuration the secondary port of the MPIIX is disabled and the addresses
  * are decoded by the PCMCIA bridge and therefore are for a generic IDE driver
@@ -35,7 +35,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_mpiix"
-#define DRV_VERSION "0.7.1"
+#define DRV_VERSION "0.7.2"
 
 enum {
 	IDETIM = 0x6C,		/* IDE control register */
@@ -54,11 +54,8 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_ns87410.c linux-2.6.18-mm1/drivers/ata/pata_ns87410.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_ns87410.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_ns87410.c	2006-09-25 14:33:31.000000000 +0100
@@ -45,11 +45,8 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_oldpiix.c linux-2.6.18-mm1/drivers/ata/pata_oldpiix.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_oldpiix.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_oldpiix.c	2006-09-25 14:34:37.000000000 +0100
@@ -25,7 +25,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_oldpiix"
-#define DRV_VERSION	"0.5.1"
+#define DRV_VERSION	"0.5.2"
 
 /**
  *	oldpiix_pre_reset		-	probe begin
@@ -42,11 +42,8 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_opti.c linux-2.6.18-mm1/drivers/ata/pata_opti.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_opti.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_opti.c	2006-09-25 14:33:59.000000000 +0100
@@ -34,7 +34,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_opti"
-#define DRV_VERSION "0.2.4"
+#define DRV_VERSION "0.2.5"
 
 enum {
 	READ_REG	= 0,	/* index of Read cycle timing register */
@@ -59,11 +59,9 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_optidma.c linux-2.6.18-mm1/drivers/ata/pata_optidma.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_optidma.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_optidma.c	2006-09-25 14:34:21.000000000 +0100
@@ -33,7 +33,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_optidma"
-#define DRV_VERSION "0.2.1"
+#define DRV_VERSION "0.2.2"
 
 enum {
 	READ_REG	= 0,	/* index of Read cycle timing register */
@@ -59,11 +59,9 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_pdc2027x.c linux-2.6.18-mm1/drivers/ata/pata_pdc2027x.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_pdc2027x.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_pdc2027x.c	2006-09-25 14:35:23.000000000 +0100
@@ -36,7 +36,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.74-ac3"
+#define DRV_VERSION	"0.74-ac5"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -311,10 +311,8 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_sis.c linux-2.6.18-mm1/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_sis.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_sis.c	2006-09-25 15:50:01.000000000 +0100
@@ -34,7 +34,7 @@
 #include <linux/ata.h>
 
 #define DRV_NAME	"pata_sis"
-#define DRV_VERSION	"0.4.3"
+#define DRV_VERSION	"0.4.4"
 
 struct sis_chipset {
 	u16 device;			/* PCI host ID */
@@ -74,11 +74,9 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_sl82c105.c linux-2.6.18-mm1/drivers/ata/pata_sl82c105.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_sl82c105.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_sl82c105.c	2006-09-25 15:50:06.000000000 +0100
@@ -19,7 +19,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_sl82c105"
-#define DRV_VERSION "0.2.2"
+#define DRV_VERSION "0.2.3"
 
 enum {
 	/*
@@ -49,11 +49,8 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_triflex.c linux-2.6.18-mm1/drivers/ata/pata_triflex.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_triflex.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_triflex.c	2006-09-25 15:50:40.000000000 +0100
@@ -46,13 +46,13 @@
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
@@ -61,11 +61,8 @@
 
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
@@ -74,7 +71,7 @@
 
 static void triflex_error_handler(struct ata_port *ap)
 {
-	ata_bmdma_drive_eh(ap, triflex_probe_init, ata_std_softreset, NULL, ata_std_postreset);
+	ata_bmdma_drive_eh(ap, triflex_prereset, ata_std_softreset, NULL, ata_std_postreset);
 }
 
 /**
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/ata/pata_via.c linux-2.6.18-mm1/drivers/ata/pata_via.c
--- linux.vanilla-2.6.18-mm1/drivers/ata/pata_via.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/ata/pata_via.c	2006-09-25 15:51:04.000000000 +0100
@@ -60,7 +60,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_via"
-#define DRV_VERSION "0.1.13"
+#define DRV_VERSION "0.1.14"
 
 /*
  *	The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
@@ -155,11 +155,8 @@
 
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

