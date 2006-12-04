Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936965AbWLDPPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936965AbWLDPPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936992AbWLDPPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:15:35 -0500
Received: from [81.2.110.250] ([81.2.110.250]:49999 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org with ESMTP
	id S936965AbWLDPPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:15:34 -0500
Date: Mon, 4 Dec 2006 15:21:05 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH]: via 6421 PATA support done in a rather cleaner fashion
Message-ID: <20061204152105.6132a59c@localhost.localdomain>
In-Reply-To: <45742FFA.6020604@wpkg.org>
References: <45742FFA.6020604@wpkg.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wants testing... so test and report

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/sata_via.c	2006-11-24 13:58:05.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/sata_via.c	2006-12-04 14:57:34.719099648 +0000
@@ -59,11 +59,14 @@
 	SATA_INT_GATE		= 0x41, /* SATA interrupt gating */
 	SATA_NATIVE_MODE	= 0x42, /* Native mode enable */
 	SATA_PATA_SHARING	= 0x49, /* PATA/SATA sharing func ctrl */
-
+	PATA_UDMA_TIMING	= 0xB3, /* PATA timing for DMA/ cable detect */
+	PATA_PIO_TIMING		= 0xAB, /* PATA timing register */
+	
 	PORT0			= (1 << 1),
 	PORT1			= (1 << 0),
 	ALL_PORTS		= PORT0 | PORT1,
-	N_PORTS			= 2,
+	PATA_PORT		= 2,	/* PATA is port 2 */
+	N_PORTS			= 3,
 
 	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 
@@ -75,6 +78,10 @@
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void vt6420_error_handler(struct ata_port *ap);
+static void vt6421_error_handler(struct ata_port *ap);
+static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev);
+static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev);
+static unsigned long vt6421_mode_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long modes);
 
 static const struct pci_device_id svia_pci_tbl[] = {
 	{ PCI_VDEVICE(VIA, 0x0591), vt6420 },
@@ -140,8 +147,12 @@
 	.host_stop		= ata_host_stop,
 };
 
-static const struct ata_port_operations vt6421_sata_ops = {
+static const struct ata_port_operations vt6421_ata_ops = {
 	.port_disable		= ata_port_disable,
+	
+	.set_piomode		= vt6421_set_pio_mode,
+	.set_dmamode		= vt6421_set_dma_mode,
+	.mode_filter		= vt6421_mode_filter,
 
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
@@ -160,7 +171,7 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= vt6421_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
@@ -278,6 +289,55 @@
 				  NULL, ata_std_postreset);
 }
 
+static int vt6421_prereset(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 tmp;
+	
+	if (ap->port_no != PATA_PORT) {
+		ap->cbl = ATA_CBL_SATA;
+		return 0;
+	}
+	pci_read_config_byte(pdev, PATA_UDMA_TIMING, &tmp);
+	
+	if (tmp & 0x10)
+		ap->cbl = ATA_CBL_PATA40;
+	else
+		ap->cbl = ATA_CBL_PATA80;
+	return 0;
+}
+
+static void vt6421_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, vt6421_prereset, ata_std_softreset,
+				  NULL, ata_std_postreset);
+}
+
+static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	static const u8 pio_bits[] = { 0xA8, 0x65, 0x65, 0x31, 0x20 };
+	if (ap->port_no == PATA_PORT)
+		pci_write_config_byte(pdev, PATA_PIO_TIMING, pio_bits[adev->pio_mode - XFER_PIO_0]);
+}
+
+static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	static const u8 udma_bits[] = { 0xEE, 0xE8, 0xE6, 0xE4, 0xE2, 0xE1, 0xE0, 0xE0 };
+	if (ap->port_no == PATA_PORT)
+		pci_write_config_byte(pdev, PATA_UDMA_TIMING, udma_bits[adev->pio_mode - XFER_UDMA_0]);
+}
+
+static unsigned long vt6421_mode_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long modes)
+{
+	if(ap->port_no == PATA_PORT) {
+		modes &= ~ATA_MASK_MWDMA;	/* No MWDMA support */
+		modes &= ~ (0x40 << ATA_SHIFT_UDMA);  /* UDMA 133 limited */
+	}
+	return modes;
+}
+
 static const unsigned int svia_bar_sizes[] = {
 	8, 4, 8, 4, 16, 256
 };
@@ -348,7 +408,7 @@
 
 	probe_ent->sht		= &svia_sht;
 	probe_ent->port_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY;
-	probe_ent->port_ops	= &vt6421_sata_ops;
+	probe_ent->port_ops	= &vt6421_ata_ops;
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
 	probe_ent->irq_flags	= IRQF_SHARED;
@@ -500,4 +560,3 @@
 
 module_init(svia_init);
 module_exit(svia_exit);
-
