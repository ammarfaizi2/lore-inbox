Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUATTUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUATTUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:20:39 -0500
Received: from havoc.gtf.org ([63.247.75.124]:9377 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265649AbUATTUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:20:03 -0500
Date: Tue, 20 Jan 2004 14:20:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.6.x libata updates
Message-ID: <20040120192001.GA28749@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(just driver updates)

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.5

This will update the following files:

 drivers/scsi/sata_sil.c |  125 ++++++++++++++++++++++++++++++++++++++++------
 drivers/scsi/sata_svw.c |  129 ++++++++++++++++++++++++++----------------------
 2 files changed, 178 insertions(+), 76 deletions(-)

through these ChangeSets:

<benh@kernel.crashing.org> (04/01/14 1.1474.88.10)
   [libata sata_svw] cleanup, better probing
   
   * use fewer magic numbers
   * probe all 4 ports, using standard SATA SCRs
   * limit udma mask to 0x3f
   * clean up PPC-specific procfs stuff

<arubin@atl.lmco.com> (04/01/14 1.1474.88.9)
   [libata sata_sil] add pci id for Silicon Image 3512

<normalperson@yhbt.net> (04/01/14 1.1474.88.8)
   [libata sata_sil] cleaner, better version of errata workarounds
   
   No longer unfairly punishes non-errata Seagate and Maxtor drives.

<marchand@kde.org> (04/01/06 1.1474.80.3)
   [libata sata_sil] add support for adaptec 1210sa, 4-port sii 3114

<jgarzik@redhat.com> (04/01/06 1.1474.80.2)
   [libata sata_svr] fix DRV_NAME to reflect actual driver filename

<jgarzik@redhat.com> (03/12/30 1.1474.65.1)
   [libata sata_sil] unmask interrupts during initialization
   
   Prudent in general, and needed for Adaptec BIOSes.

diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	Tue Jan 20 14:18:05 2004
+++ b/drivers/scsi/sata_sil.c	Tue Jan 20 14:18:05 2004
@@ -34,11 +34,16 @@
 #include "hosts.h"
 #include <linux/libata.h>
 
-#define DRV_NAME	"ata_sil"
-#define DRV_VERSION	"0.51"
+#define DRV_NAME	"sata_sil"
+#define DRV_VERSION	"0.52"
 
 enum {
 	sil_3112		= 0,
+	sil_3114		= 1,
+
+	SIL_SYSCFG		= 0x48,
+	SIL_MASK_IDE0_INT	= (1 << 22),
+	SIL_MASK_IDE1_INT	= (1 << 23),
 
 	SIL_IDE0_TF		= 0x80,
 	SIL_IDE0_CTL		= 0x8A,
@@ -49,6 +54,19 @@
 	SIL_IDE1_CTL		= 0xCA,
 	SIL_IDE1_BMDMA		= 0x08,
 	SIL_IDE1_SCR		= 0x180,
+
+	SIL_IDE2_TF		= 0x280,
+	SIL_IDE2_CTL		= 0x28A,
+	SIL_IDE2_BMDMA		= 0x200,
+	SIL_IDE2_SCR		= 0x300,
+
+	SIL_IDE3_TF		= 0x2C0,
+	SIL_IDE3_CTL		= 0x2CA,
+	SIL_IDE3_BMDMA		= 0x208,
+	SIL_IDE3_SCR		= 0x380,
+
+	SIL_QUIRK_MOD15WRITE	= (1 << 0),
+	SIL_QUIRK_UDMA5MAX	= (1 << 1),
 };
 
 static void sil_set_piomode (struct ata_port *ap, struct ata_device *adev,
@@ -62,9 +80,33 @@
 
 static struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ }	/* terminate list */
 };
 
+
+/* TODO firmware versions should be added - eric */
+struct sil_drivelist {
+	const char * product;
+	unsigned int quirk;
+} sil_blacklist [] = {
+	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
+	{ }
+};
+
 static struct pci_driver sil_pci_driver = {
 	.name			= DRV_NAME,
 	.id_table		= sil_pci_tbl,
@@ -120,6 +162,14 @@
 		.pio_mask	= 0x03,			/* pio3-4 */
 		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
 		.port_ops	= &sil_ops,
+	}, /* sil_3114 */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.pio_mask	= 0x03,			/* pio3-4 */
+		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
+		.port_ops	= &sil_ops,
 	},
 };
 
@@ -182,34 +232,52 @@
  *	information on these errata, I will create a more exhaustive
  *	list, and apply the fixups to only the specific
  *	devices/hosts/firmwares that need it.
+ *
+ *	20040111 - Seagate drives affected by the Mod15Write bug are blacklisted
+ *	The Maxtor quirk is in the blacklist, but I'm keeping the original
+ *	pessimistic fix for the following reasons:
+ *	- There seems to be less info on it, only one device gleaned off the
+ *	Windows	driver, maybe only one is affected.  More info would be greatly
+ *	appreciated.
+ *	- But then again UDMA5 is hardly anything to complain about
  */
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
+	unsigned int n, quirks = 0;
+	u32 class_rev = 0;
 	const char *s = &dev->product[0];
 	unsigned int len = strnlen(s, sizeof(dev->product));
 
+	pci_read_config_dword(ap->host_set->pdev, PCI_CLASS_REVISION, &class_rev);
+	class_rev &= 0xff;
+
 	/* ATAPI specifies that empty space is blank-filled; remove blanks */
 	while ((len > 0) && (s[len - 1] == ' '))
 		len--;
 
-	/* limit to udma5 */
-	if (!memcmp(s, "Maxtor ", 7)) {
-		printk(KERN_INFO "ata%u(%u): applying pessimistic Maxtor errata fix\n",
+	for (n = 0; sil_blacklist[n].product; n++) 
+		if (!memcmp(sil_blacklist[n].product, s,
+			    strlen(sil_blacklist[n].product))) {
+			quirks = sil_blacklist[n].quirk;
+			break;
+		}
+	
+	/* limit requests to 15 sectors */
+	if ((class_rev <= 0x01) && (quirks & SIL_QUIRK_MOD15WRITE)) {
+		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
 		       ap->id, dev->devno);
-		ap->udma_mask &= ATA_UDMA5;
+		ap->host->max_sectors = 15;
+		ap->host->hostt->max_sectors = 15;
 		return;
 	}
 
-	/* limit requests to 15 sectors */
-	if ((len > 4) && (!memcmp(s, "ST", 2))) {
-		if ((!memcmp(s + len - 2, "AS", 2)) ||
-		    (!memcmp(s + len - 3, "ASL", 3))) {
-			printk(KERN_INFO "ata%u(%u): applying pessimistic Seagate errata fix\n",
-			       ap->id, dev->devno);
-			ap->host->max_sectors = 15;
-			ap->host->hostt->max_sectors = 15;
-			return;
-		}
+	/* limit to udma5 */
+	/* is this for (class_rev <= 0x01) only, too? */
+	if (quirks & SIL_QUIRK_UDMA5MAX) {
+		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",
+		       ap->id, dev->devno, s);
+		ap->udma_mask &= ATA_UDMA5;
+		return;
 	}
 }
 
@@ -236,6 +304,7 @@
 	unsigned long base;
 	void *mmio_base;
 	int rc;
+	u32 tmp;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -267,7 +336,7 @@
 	probe_ent->pdev = pdev;
 	probe_ent->port_ops = sil_port_info[ent->driver_data].port_ops;
 	probe_ent->sht = sil_port_info[ent->driver_data].sht;
-	probe_ent->n_ports = 2;
+	probe_ent->n_ports = (ent->driver_data == sil_3114) ? 4 : 2;
 	probe_ent->pio_mask = sil_port_info[ent->driver_data].pio_mask;
 	probe_ent->udma_mask = sil_port_info[ent->driver_data].udma_mask;
        	probe_ent->irq = pdev->irq;
@@ -295,6 +364,28 @@
 	probe_ent->port[1].bmdma_addr = base + SIL_IDE1_BMDMA;
 	probe_ent->port[1].scr_addr = base + SIL_IDE1_SCR;
 	ata_std_ports(&probe_ent->port[1]);
+
+	/* make sure IDE0/1 interrupts are not masked */
+	tmp = readl(mmio_base + SIL_SYSCFG);
+	if (tmp & (SIL_MASK_IDE0_INT | SIL_MASK_IDE1_INT)) {
+		tmp &= ~(SIL_MASK_IDE0_INT | SIL_MASK_IDE1_INT);
+		writel(tmp, mmio_base + SIL_SYSCFG);
+		readl(mmio_base + SIL_SYSCFG);	/* flush */
+	}
+
+	if (ent->driver_data == sil_3114) {
+		probe_ent->port[2].cmd_addr = base + SIL_IDE2_TF;
+		probe_ent->port[2].ctl_addr = base + SIL_IDE2_CTL;
+		probe_ent->port[2].bmdma_addr = base + SIL_IDE2_BMDMA;
+		probe_ent->port[2].scr_addr = base + SIL_IDE2_SCR;
+		ata_std_ports(&probe_ent->port[2]);
+
+		probe_ent->port[3].cmd_addr = base + SIL_IDE3_TF;
+		probe_ent->port[3].ctl_addr = base + SIL_IDE3_CTL;
+		probe_ent->port[3].bmdma_addr = base + SIL_IDE3_BMDMA;
+		probe_ent->port[3].scr_addr = base + SIL_IDE3_SCR;
+		ata_std_ports(&probe_ent->port[3]);
+	}
 
 	pci_set_master(pdev);
 
diff -Nru a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c	Tue Jan 20 14:18:05 2004
+++ b/drivers/scsi/sata_svw.c	Tue Jan 20 14:18:05 2004
@@ -38,13 +38,41 @@
 #include "hosts.h"
 #include <linux/libata.h>
 
-#ifdef CONFIG_ALL_PPC
+#ifdef CONFIG_PPC_OF
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
-#endif /* CONFIG_ALL_PPC */
+#endif /* CONFIG_PPC_OF */
 
-#define DRV_NAME	"ata_k2"
-#define DRV_VERSION	"1.03"
+#define DRV_NAME	"sata_svw"
+#define DRV_VERSION	"1.04"
+
+/* Taskfile registers offsets */
+#define K2_SATA_TF_CMD_OFFSET		0x00
+#define K2_SATA_TF_DATA_OFFSET		0x00
+#define K2_SATA_TF_ERROR_OFFSET		0x04
+#define K2_SATA_TF_NSECT_OFFSET		0x08
+#define K2_SATA_TF_LBAL_OFFSET		0x0c
+#define K2_SATA_TF_LBAM_OFFSET		0x10
+#define K2_SATA_TF_LBAH_OFFSET		0x14
+#define K2_SATA_TF_DEVICE_OFFSET	0x18
+#define K2_SATA_TF_CMDSTAT_OFFSET      	0x1c
+#define K2_SATA_TF_CTL_OFFSET		0x20
+
+/* DMA base */
+#define K2_SATA_DMA_CMD_OFFSET		0x30
+
+/* SCRs base */
+#define K2_SATA_SCR_STATUS_OFFSET	0x40
+#define K2_SATA_SCR_ERROR_OFFSET	0x44
+#define K2_SATA_SCR_CONTROL_OFFSET	0x48
+
+/* Others */
+#define K2_SATA_SICR1_OFFSET		0x80
+#define K2_SATA_SICR2_OFFSET		0x84
+#define K2_SATA_SIM_OFFSET		0x88
+
+/* Port stride */
+#define K2_SATA_PORT_OFFSET		0x100
 
 
 static u32 k2_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
@@ -139,7 +167,7 @@
 }
 
 
-#ifdef CONFIG_ALL_PPC
+#ifdef CONFIG_PPC_OF
 /*
  * k2_sata_proc_info
  * inout : decides on the direction of the dataflow and the meaning of the
@@ -151,29 +179,15 @@
  * length: If inout==FALSE max number of bytes to be written into the buffer
  *	   else number of bytes in the buffer
  */
-static int k2_sata_proc_info(char *page, char **start, off_t offset, int count,
-		   int hostno, int inout)
+static int k2_sata_proc_info(struct Scsi_Host *shost, char *page, char **start,
+			     off_t offset, int count, int inout)
 {
-	struct Scsi_Host *hpnt;
 	struct ata_port *ap;
 	struct device_node *np;
 	int len, index;
 
-	/* Find ourself. That's locking-broken, shitty etc... but thanks to
-	 * /proc/scsi interface and lack of state kept around in this driver,
-	 * its best I want to do for now...
-	 */
-	hpnt = scsi_hostlist;
-	while (hpnt) {
-		if (hostno == hpnt->host_no)
-			break;
-		hpnt = hpnt->next;
-	}
-	if (!hpnt)
-		return 0;
-
 	/* Find  the ata_port */
-	ap = (struct ata_port *) &hpnt->hostdata[0];
+	ap = (struct ata_port *) &shost->hostdata[0];
 	if (ap == NULL)
 		return 0;
 
@@ -198,7 +212,7 @@
 
 	return len;
 }
-#endif /* CONFIG_ALL_PPC */
+#endif /* CONFIG_PPC_OF */
 
 
 static Scsi_Host_Template k2_sata_sht = {
@@ -216,8 +230,8 @@
 	.proc_name		= DRV_NAME,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
-#ifdef CONFIG_ALL_PPC
-	.proc_info		= k2_sata_proc_info
+#ifdef CONFIG_PPC_OF
+	.proc_info		= k2_sata_proc_info,
 #endif
 	.bios_param		= ata_std_bios_param,
 };
@@ -243,21 +257,20 @@
 	.port_stop		= ata_port_stop,
 };
 
-
 static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
 {
-	port->cmd_addr = base;
-	port->data_addr = base;
-	port->error_addr = base + 0x4;
-	port->nsect_addr = base + 0x8;
-	port->lbal_addr = base + 0xc;
-	port->lbam_addr = base + 0x10;
-	port->lbah_addr = base + 0x14;
-	port->device_addr = base + 0x18;
-	port->cmdstat_addr = base + 0x1c;
-	port->ctl_addr = base + 0x20;
-	port->bmdma_addr = base + 0x30;
-	port->scr_addr = base + 0x40;
+	port->cmd_addr		= base + K2_SATA_TF_CMD_OFFSET;
+	port->data_addr		= base + K2_SATA_TF_DATA_OFFSET;
+	port->error_addr	= base + K2_SATA_TF_ERROR_OFFSET;
+	port->nsect_addr	= base + K2_SATA_TF_NSECT_OFFSET;
+	port->lbal_addr		= base + K2_SATA_TF_LBAL_OFFSET;
+	port->lbam_addr		= base + K2_SATA_TF_LBAM_OFFSET;
+	port->lbah_addr		= base + K2_SATA_TF_LBAH_OFFSET;
+	port->device_addr	= base + K2_SATA_TF_DEVICE_OFFSET;
+	port->cmdstat_addr	= base + K2_SATA_TF_CMDSTAT_OFFSET;
+	port->ctl_addr		= base + K2_SATA_TF_CTL_OFFSET;
+	port->bmdma_addr	= base + K2_SATA_DMA_CMD_OFFSET;
+	port->scr_addr		= base + K2_SATA_SCR_STATUS_OFFSET;
 }
 
 
@@ -279,7 +292,14 @@
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
+	/*
+	 * Check if we have resources mapped at all (second function may
+	 * have been disabled by firmware)
+	 */
+	if (pci_resource_len(pdev, 5) == 0)
+		return -ENODEV;
 
+	/* Request PCI regions */
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
 		goto err_out;
@@ -306,44 +326,37 @@
 	}
 	base = (unsigned long) mmio_base;
 
-	/*
-	 * Check for the "disabled" second function to avoid registering
-	 * useless interfaces on K2
-	 */
-	if (readl(mmio_base + 0x40)  == 0xffffffffUL &&
-	    readl(mmio_base + 0x140) == 0xffffffffUL) {
-		rc = -ENODEV;
-		goto err_out_unmap;
-	}
-
 	/* Clear a magic bit in SCR1 according to Darwin, those help
 	 * some funky seagate drives (though so far, those were already
 	 * set by the firmware on the machines I had access to
 	 */
-	writel(readl(mmio_base + 0x80) & ~0x00040000, mmio_base + 0x80);
+	writel(readl(mmio_base + K2_SATA_SICR1_OFFSET) & ~0x00040000,
+	       mmio_base + K2_SATA_SICR1_OFFSET);
 
 	/* Clear SATA error & interrupts we don't use */
-	writel(0xffffffff, mmio_base + 0x44);
-	writel(0x0, mmio_base + 0x88);
+	writel(0xffffffff, mmio_base + K2_SATA_SCR_ERROR_OFFSET);
+	writel(0x0, mmio_base + K2_SATA_SIM_OFFSET);
 
 	probe_ent->sht = &k2_sata_sht;
 	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
 				ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO;
 	probe_ent->port_ops = &k2_sata_ops;
-	probe_ent->n_ports = 2;
+	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
 	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->mmio_base = mmio_base;
 
-	/*
-	 * We don't care much about the PIO/UDMA masks, but the core won't like us
+	/* We don't care much about the PIO/UDMA masks, but the core won't like us
 	 * if we don't fill these
 	 */
 	probe_ent->pio_mask = 0x1f;
-	probe_ent->udma_mask = 0x7f;
+	probe_ent->udma_mask = 0x3f;
 
-	k2_sata_setup_port(&probe_ent->port[0], base);
-	k2_sata_setup_port(&probe_ent->port[1], base + 0x100);
+	/* We have 4 ports per PCI function */
+	k2_sata_setup_port(&probe_ent->port[0], base + 0 * K2_SATA_PORT_OFFSET);
+	k2_sata_setup_port(&probe_ent->port[1], base + 1 * K2_SATA_PORT_OFFSET);
+	k2_sata_setup_port(&probe_ent->port[2], base + 2 * K2_SATA_PORT_OFFSET);
+	k2_sata_setup_port(&probe_ent->port[3], base + 3 * K2_SATA_PORT_OFFSET);
 
 	pci_set_master(pdev);
 
@@ -353,8 +366,6 @@
 
 	return 0;
 
-err_out_unmap:
-	iounmap((void *)base);
 err_out_free_ent:
 	kfree(probe_ent);
 err_out_regions:
