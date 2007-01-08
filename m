Return-Path: <linux-kernel-owner+w=401wt.eu-S1161350AbXAHQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161350AbXAHQaQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161351AbXAHQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:30:16 -0500
Received: from [81.2.110.250] ([81.2.110.250]:59486 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161350AbXAHQaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:30:14 -0500
Date: Mon, 8 Jan 2007 16:40:50 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_via: PATA support, resubmit
Message-ID: <20070108164050.60633505@localhost.localdomain>
In-Reply-To: <45A2688E.3080503@pobox.com>
References: <20070108122659.00c22754@localhost.localdomain>
	<45A24159.7060001@pobox.com>
	<20070108154249.6d8f5697@localhost.localdomain>
	<45A2688E.3080503@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just separate PATA and SATA operations.  That way everything works as 
> expected, and you don't unintentionally add lovely oopses all over the 
> place.

Ok - based on your pointers to [ab]using port_start you want something
like this for now, with the port_start evaporating when Tejun's probe
changes go in ?

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/ata/sata_via.c linux-2.6.20-rc3-mm1/drivers/ata/sata_via.c
--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/sata_via.c	2007-01-05 13:09:36.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/sata_via.c	2007-01-08 16:06:12.000000000 +0000
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
 
@@ -75,6 +78,11 @@
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 static void vt6420_error_handler(struct ata_port *ap);
+static void vt6421_sata_error_handler(struct ata_port *ap);
+static void vt6421_pata_error_handler(struct ata_port *ap);
+static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev);
+static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev);
+static int vt6421_port_start(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
 	{ PCI_VDEVICE(VIA, 0x0591), vt6420 },
@@ -140,9 +148,43 @@
 	.host_stop		= ata_host_stop,
 };
 
-static const struct ata_port_operations vt6421_sata_ops = {
+static const struct ata_port_operations vt6421_pata_ops = {
 	.port_disable		= ata_port_disable,
+	
+	.set_piomode		= vt6421_set_pio_mode,
+	.set_dmamode		= vt6421_set_dma_mode,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_pio_data_xfer,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= vt6421_pata_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.port_start		= vt6421_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
+static const struct ata_port_operations vt6421_sata_ops = {
+	.port_disable		= ata_port_disable,
+	
 	.tf_load		= ata_tf_load,
 	.tf_read		= ata_tf_read,
 	.check_status		= ata_check_status,
@@ -160,7 +202,7 @@
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= vt6421_sata_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
@@ -169,7 +211,7 @@
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
 
-	.port_start		= ata_port_start,
+	.port_start		= vt6421_port_start,
 	.port_stop		= ata_port_stop,
 	.host_stop		= ata_host_stop,
 };
@@ -278,6 +320,63 @@
 				  NULL, ata_std_postreset);
 }
 
+static int vt6421_pata_prereset(struct ata_port *ap)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 tmp;
+
+	pci_read_config_byte(pdev, PATA_UDMA_TIMING, &tmp);
+	if (tmp & 0x10)
+		ap->cbl = ATA_CBL_PATA40;
+	else
+		ap->cbl = ATA_CBL_PATA80;
+	return 0;
+}
+
+static void vt6421_pata_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, vt6421_pata_prereset, ata_std_softreset,
+				  NULL, ata_std_postreset);
+}
+
+static int vt6421_sata_prereset(struct ata_port *ap)
+{
+	ap->cbl = ATA_CBL_SATA;
+	return 0;
+}
+
+static void vt6421_sata_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, vt6421_sata_prereset, ata_std_softreset,
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
+static int vt6421_port_start(struct ata_port *ap)
+{
+	if (ap->port_no == PATA_PORT) {
+		ap->ops = &vt6421_pata_ops;
+		ap->mwdma_mask = 0;
+		ap->flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST;
+	}
+	return ata_port_start(ap);
+}
+
 static const unsigned int svia_bar_sizes[] = {
 	8, 4, 8, 4, 16, 256
 };
@@ -500,4 +599,3 @@
 
 module_init(svia_init);
 module_exit(svia_exit);
-
