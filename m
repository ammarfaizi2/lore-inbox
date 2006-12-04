Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936902AbWLDO0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936902AbWLDO0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936901AbWLDO0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:26:32 -0500
Received: from mail.syneticon.net ([213.239.212.131]:38605 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP id S936899AbWLDO0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:26:30 -0500
Message-ID: <45742FFA.6020604@wpkg.org>
Date: Mon, 04 Dec 2006 15:26:02 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] sata_via: add VT6421 PATA support
Content-Type: multipart/mixed;
 boundary="------------040102020904030307010605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040102020904030307010605
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

his patch adds VT6421 PATA support to sata_via.

If we don't want to enable PATA support, nothing is changed in sata_via 
driver:

<M> VIA SATA support
      [ ]   VT6421 PATA support (HIGHLY EXPERIMENTAL)


The patch is based on the patch from VIA, it applies to 2.6.19.


-- 
Tomasz Chmielewski
http://wpkg.org


--------------040102020904030307010605
Content-Type: text/x-patch;
 name="sata_via-vt6421_pata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_via-vt6421_pata.patch"

diff -uprN a/drivers/ata/Kconfig b/drivers/ata/Kconfig
--- a/drivers/ata/Kconfig	2006-11-29 22:57:37.000000000 +0100
+++ b/drivers/ata/Kconfig	2006-12-04 14:37:09.000000000 +0100
@@ -135,6 +135,14 @@ config SATA_VIA
 
 	  If unsure, say N.
 
+config PATA_VT6421
+        bool "VIA VT6421 PATA support (HIGHLY EXPERIMENTAL)"
+        depends on SATA_VIA
+        help
+          This option enables support for PATA on VIA VT6421 chips.
+
+          If unsure, say N.
+
 config SATA_VITESSE
 	tristate "VITESSE VSC-7174 / INTEL 31244 SATA support"
 	depends on PCI
diff -uprN a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
--- a/drivers/ata/sata_via.c	2006-11-29 22:57:37.000000000 +0100
+++ b/drivers/ata/sata_via.c	2006-12-04 14:41:36.000000000 +0100
@@ -3,7 +3,7 @@
  *
  *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
  * 		   Please ALWAYS copy linux-ide@vger.kernel.org
- 		   on emails.
+ *		   on emails.
  *
  *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
  *  Copyright 2003-2004 Jeff Garzik
@@ -29,10 +29,6 @@
  *
  *  Hardware documentation available under NDA.
  *
- *
- *  To-do list:
- *  - VT6421 PATA support
- *
  */
 
 #include <linux/kernel.h>
@@ -63,7 +59,12 @@ enum {
 	PORT0			= (1 << 1),
 	PORT1			= (1 << 0),
 	ALL_PORTS		= PORT0 | PORT1,
+
+#ifndef CONFIG_PATA_VT6421
 	N_PORTS			= 2,
+#else
+	N_PORTS                 = 3,
+#endif
 
 	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 
@@ -109,6 +110,12 @@ static struct scsi_host_template svia_sh
 	.bios_param		= ata_std_bios_param,
 };
 
+#ifdef CONFIG_PATA_VT6421
+static void via_pata_phy_reset(struct ata_port *ap);
+static void via_pata_set_piomode(struct ata_port *ap, struct ata_device *adev);
+static void via_pata_set_dmamode(struct ata_port *ap, struct ata_device *adev);
+#endif
+
 static const struct ata_port_operations vt6420_sata_ops = {
 	.port_disable		= ata_port_disable,
 
@@ -143,6 +150,11 @@ static const struct ata_port_operations 
 static const struct ata_port_operations vt6421_sata_ops = {
 	.port_disable		= ata_port_disable,
 
+#ifdef CONFIG_PATA_VT6421
+       .set_piomode            = via_pata_set_piomode,
+       .set_dmamode            = via_pata_set_dmamode,
+#endif
+
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
@@ -154,6 +166,10 @@ static const struct ata_port_operations 
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
 
+#ifdef CONFIG_PATA_VT6421
+	.phy_reset              = via_pata_phy_reset,
+#endif
+
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_pio_data_xfer,
@@ -166,8 +182,10 @@ static const struct ata_port_operations 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 
+#ifndef CONFIG_PATA_VT6421
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
+#endif
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
@@ -237,6 +255,7 @@ static int vt6420_prereset(struct ata_po
 	 * __sata_phy_reset().
 	 */
 	svia_scr_write(ap, SCR_CONTROL, 0x300);
+
 	svia_scr_read(ap, SCR_CONTROL); /* flush */
 
 	/* wait for phy to become ready, if necessary */
@@ -291,6 +310,7 @@ static unsigned long svia_scr_addr(unsig
 	return addr + (port * 128);
 }
 
+
 static unsigned long vt6421_scr_addr(unsigned long addr, unsigned int port)
 {
 	return addr + (port * 64);
@@ -347,7 +367,14 @@ static struct ata_probe_ent *vt6421_init
 	INIT_LIST_HEAD(&probe_ent->node);
 
 	probe_ent->sht		= &svia_sht;
+
+#ifndef CONFIG_PATA_VT6421
 	probe_ent->port_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY;
+#else
+        probe_ent->port_flags   = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
+                                  ATA_FLAG_NO_LEGACY;
+#endif
+
 	probe_ent->port_ops	= &vt6421_sata_ops;
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
@@ -362,6 +389,165 @@ static struct ata_probe_ent *vt6421_init
 	return probe_ent;
 }
 
+#ifdef CONFIG_PATA_VT6421
+/* add functions for pata */
+
+/**
+ *     via_pata_cbl_detect - Probe host controller cable detect info
+ *     @ap: Port for which cable detect info is desired
+ *
+ *     Read 80c cable indicator from ATA PCI device's PCI config
+ *     register.  This register is normally set by firmware (BIOS).
+ *
+ *     LOCKING:
+ *     None (inherited from caller).
+ */
+static void via_pata_cbl_detect(struct ata_port *ap)
+{
+       struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+       int cfg_addr;
+       u8 tmp;
+
+       if (ap->port_no == 2) { /* PATA channel in VT6421 */
+               ap->cbl = ATA_CBL_PATA80;
+               cfg_addr = 0xB3;
+               pci_read_config_byte(pdev, cfg_addr, &tmp);
+               if (tmp & 0x10) { /* 40pin cable */
+                       ap->cbl = ATA_CBL_PATA40;
+               } else { /* 80pin cable */
+                       ap->cbl = ATA_CBL_PATA80;
+               }
+       } else { /* channel 0 and 1 are SATA channels */
+               ap->cbl = ATA_CBL_SATA;
+       }
+
+       return;
+}
+
+/**
+ *     via_pata_phy_reset - Probe specified port on PATA host controller
+ *     @ap: Port to probe
+ *
+ *     Probe PATA phy.
+ *
+ *     LOCKING:
+ *     None (inherited from caller).
+ */
+
+static void via_pata_phy_reset(struct ata_port *ap)
+{
+       via_pata_cbl_detect(ap);
+
+       ata_port_probe(ap);
+
+       ata_bus_reset(ap);
+}
+
+
+/**
+ *     via_pata_set_piomode - Initialize host controller PATA PIO timings
+ *     @ap: Port whose timings we are configuring
+ *     @adev: um
+ *     @pio: PIO mode, 0 - 4
+ *
+ *     Set PIO mode for device, in host controller PCI config space.
+ *
+ *     LOCKING:
+ *     None (inherited from caller).
+ */
+
+static void via_pata_set_piomode (struct ata_port *ap, struct ata_device *adev)
+{
+       struct pci_dev *dev     = to_pci_dev(ap->host->dev);
+
+       u8 cfg_byte;
+       int cfg_addr;
+
+       if (ap->port_no != 2) { /* SATA channel in VT6421 */
+               /* no need to set */
+               return;
+       }
+
+
+       cfg_addr = 0xAB;
+       switch (adev->pio_mode & 0x07) {
+               case 0:
+                       cfg_byte = 0xa8;
+                       break;
+               case 1:
+                       cfg_byte = 0x65;
+                       break;
+               case 2:
+                       cfg_byte = 0x65;
+                       break;
+               case 3:
+                       cfg_byte = 0x31;
+                       break;
+               case 4:
+                       cfg_byte = 0x20;
+                       break;
+               default:
+                       cfg_byte = 0x20;
+       }
+
+       pci_write_config_byte (dev, cfg_addr, cfg_byte);
+}
+
+/**
+ *     via_pata_set_dmamode - Initialize host controller PATA PIO timings
+ *     @ap: Port whose timings we are configuring
+ *     @adev: um
+ *     @udma: udma mode, 0 - 6
+ *
+ *     Set UDMA mode for device, in host controller PCI config space.
+ *
+ *     LOCKING:
+ *     None (inherited from caller).
+ */
+
+static void via_pata_set_dmamode (struct ata_port *ap, struct ata_device *adev)
+{
+       struct pci_dev *dev     = to_pci_dev(ap->host->dev);
+
+       u8 cfg_byte;
+       int cfg_addr;
+
+       if (ap->port_no != 2) { /* SATA channel in VT6421 */
+               /* no need to set */
+               return;
+       }
+
+       cfg_addr = 0xB3;
+       switch (adev->dma_mode & 0x07) {
+               case 0:
+                       cfg_byte = 0xee;
+                       break;
+               case 1:
+                       cfg_byte = 0xe8;
+                       break;
+               case 2:
+                       cfg_byte = 0xe6;
+                       break;
+               case 3:
+                       cfg_byte = 0xe4;
+                       break;
+               case 4:
+                       cfg_byte = 0xe2;
+                       break;
+               case 5:
+                       cfg_byte = 0xe1;
+                       break;
+               case 6:
+                       cfg_byte = 0xe0;
+                       break;
+               default:
+                       cfg_byte = 0xe0;
+       }
+
+       pci_write_config_byte (dev, cfg_addr, cfg_byte);
+}
+#endif
+
 static void svia_configure(struct pci_dev *pdev)
 {
 	u8 tmp8;

--------------040102020904030307010605--
