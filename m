Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVBBJI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVBBJI2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 04:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVBBJI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 04:08:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4043 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262188AbVBBJHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 04:07:02 -0500
Message-ID: <42009825.7080704@pobox.com>
Date: Wed, 02 Feb 2005 04:06:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Reply-To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Chew <achew@nvidia.com>
Subject: [RFT 2.6.11-rc2-bk10]  libata (SATA) driver update
Content-Type: multipart/mixed;
 boundary="------------090908020905020001000307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090908020905020001000307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Mainly for testing by Promise and nVIDIA users, but also includes a fix 
for a few lesser-used SCSI commands (that affect all SATA users).

See attached...



--------------090908020905020001000307
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/libata-core.c  |   91 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/scsi/libata-scsi.c  |    8 +--
 drivers/scsi/sata_nv.c      |   45 ++++++++++++++++-----
 drivers/scsi/sata_promise.c |   12 ++++-
 4 files changed, 135 insertions(+), 21 deletions(-)

through these ChangeSets:

Albert Lee:
  o [libata] SCSI-to-ATA translation fixes

Andrew Chew:
  o sata_nv: enable generic class support for future NVIDIA SATA

Jeff Garzik:
  o [libata sata_promise] support Promise SATAII TX2/TX4 cards
  o [libata] Remove CDROM drive from PATA DMA blacklist
  o [libata] add DMA blacklist


--------------090908020905020001000307
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2005-02-02 04:02:11 -05:00
+++ b/drivers/scsi/libata-core.c	2005-02-02 04:02:11 -05:00
@@ -1700,6 +1700,69 @@
 	DPRINTK("EXIT\n");
 }
 
+static void ata_pr_blacklisted(struct ata_port *ap, struct ata_device *dev)
+{
+	printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, disabling DMA\n",
+		ap->id, dev->devno);
+}
+
+static const char * ata_dma_blacklist [] = {
+	"WDC AC11000H",
+	"WDC AC22100H",
+	"WDC AC32500H",
+	"WDC AC33100H",
+	"WDC AC31600H",
+	"WDC AC32100H",
+	"WDC AC23200L",
+	"Compaq CRD-8241B",
+	"CRD-8400B",
+	"CRD-8480B",
+	"CRD-8482B",
+ 	"CRD-84",
+	"SanDisk SDP3B",
+	"SanDisk SDP3B-64",
+	"SANYO CD-ROM CRD",
+	"HITACHI CDR-8",
+	"HITACHI CDR-8335",
+	"HITACHI CDR-8435",
+	"Toshiba CD-ROM XM-6202B",
+	"CD-532E-A",
+	"E-IDE CD-ROM CR-840",
+	"CD-ROM Drive/F5A",
+	"WPI CDD-820",
+	"SAMSUNG CD-ROM SC-148C",
+	"SAMSUNG CD-ROM SC",
+	"SanDisk SDP3B-64",
+	"SAMSUNG CD-ROM SN-124",
+	"ATAPI CD-ROM DRIVE 40X MAXIMUM",
+	"_NEC DV5800A",
+};
+
+static int ata_dma_blacklisted(struct ata_port *ap, struct ata_device *dev)
+{
+	unsigned char model_num[40];
+	char *s;
+	unsigned int len;
+	int i;
+
+	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
+			  sizeof(model_num));
+	s = &model_num[0];
+	len = strnlen(s, sizeof(model_num));
+
+	/* ATAPI specifies that empty space is blank-filled; remove blanks */
+	while ((len > 0) && (s[len - 1] == ' ')) {
+		len--;
+		s[len] = 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ata_dma_blacklist); i++)
+		if (!strncmp(ata_dma_blacklist[i], s, len))
+			return 1;
+
+	return 0;
+}
+
 static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift)
 {
 	struct ata_device *master, *slave;
@@ -1712,17 +1775,37 @@
 
 	if (shift == ATA_SHIFT_UDMA) {
 		mask = ap->udma_mask;
-		if (ata_dev_present(master))
+		if (ata_dev_present(master)) {
 			mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
-		if (ata_dev_present(slave))
+			if (ata_dma_blacklisted(ap, master)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, master);
+			}
+		}
+		if (ata_dev_present(slave)) {
 			mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
+			if (ata_dma_blacklisted(ap, slave)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, slave);
+			}
+		}
 	}
 	else if (shift == ATA_SHIFT_MWDMA) {
 		mask = ap->mwdma_mask;
-		if (ata_dev_present(master))
+		if (ata_dev_present(master)) {
 			mask &= (master->id[ATA_ID_MWDMA_MODES] & 0x07);
-		if (ata_dev_present(slave))
+			if (ata_dma_blacklisted(ap, master)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, master);
+			}
+		}
+		if (ata_dev_present(slave)) {
 			mask &= (slave->id[ATA_ID_MWDMA_MODES] & 0x07);
+			if (ata_dma_blacklisted(ap, slave)) {
+				mask = 0;
+				ata_pr_blacklisted(ap, slave);
+			}
+		}
 	}
 	else if (shift == ATA_SHIFT_PIO) {
 		mask = ap->pio_mask;
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2005-02-02 04:02:11 -05:00
+++ b/drivers/scsi/libata-scsi.c	2005-02-02 04:02:11 -05:00
@@ -498,9 +498,9 @@
 
 	tf->nsect = n_sect & 0xff;
 
-	tf->hob_lbah = (sect >> 16) & 0xff;
-	tf->hob_lbam = (sect >> 8) & 0xff;
-	tf->hob_lbal = sect & 0xff;
+	tf->lbah = (sect >> 16) & 0xff;
+	tf->lbam = (sect >> 8) & 0xff;
+	tf->lbal = sect & 0xff;
 
 	return 0;
 }
@@ -600,7 +600,7 @@
 				return 1;
 
 			/* stores LBA27:24 in lower 4 bits of device reg */
-			tf->device |= scsicmd[2];
+			tf->device |= scsicmd[6];
 
 			qc->nsect = scsicmd[13];
 		}
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2005-02-02 04:02:11 -05:00
+++ b/drivers/scsi/sata_nv.c	2005-02-02 04:02:11 -05:00
@@ -20,6 +20,10 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *  0.06
+ *     - Added generic SATA support by using a pci_device_id that filters on
+ *       the IDE storage class code.
+ *
  *  0.03
  *     - Fixed a bug where the hotplug handlers for non-CK804/MCP04 were using
  *       mmio_base, which is only set for the CK804/MCP04 case.
@@ -44,7 +48,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME			"sata_nv"
-#define DRV_VERSION			"0.5"
+#define DRV_VERSION			"0.6"
 
 #define NV_PORTS			2
 #define NV_PIO_MASK			0x1f
@@ -108,6 +112,7 @@
 
 enum nv_host_type
 {
+	GENERIC,
 	NFORCE2,
 	NFORCE3,
 	CK804
@@ -128,6 +133,9 @@
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+		PCI_ANY_ID, PCI_ANY_ID,
+		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
 	{ 0, } /* terminate list */
 };
 
@@ -136,7 +144,6 @@
 struct nv_host_desc
 {
 	enum nv_host_type	host_type;
-	unsigned long		host_flags;
 	void			(*enable_hotplug)(struct ata_probe_ent *probe_ent);
 	void			(*disable_hotplug)(struct ata_host_set *host_set);
 	void			(*check_hotplug)(struct ata_host_set *host_set);
@@ -144,21 +151,24 @@
 };
 static struct nv_host_desc nv_device_tbl[] = {
 	{
+		.host_type	= GENERIC,
+		.enable_hotplug	= NULL,
+		.disable_hotplug= NULL,
+		.check_hotplug	= NULL,
+	},
+	{
 		.host_type	= NFORCE2,
-		.host_flags	= 0x00000000,
 		.enable_hotplug	= nv_enable_hotplug,
 		.disable_hotplug= nv_disable_hotplug,
 		.check_hotplug	= nv_check_hotplug,
 	},
 	{
 		.host_type	= NFORCE3,
-		.host_flags	= 0x00000000,
 		.enable_hotplug	= nv_enable_hotplug,
 		.disable_hotplug= nv_disable_hotplug,
 		.check_hotplug	= nv_check_hotplug,
 	},
 	{	.host_type	= CK804,
-		.host_flags	= NV_HOST_FLAGS_SCR_MMIO,
 		.enable_hotplug	= nv_enable_hotplug_ck804,
 		.disable_hotplug= nv_disable_hotplug_ck804,
 		.check_hotplug	= nv_check_hotplug_ck804,
@@ -168,6 +178,7 @@
 struct nv_host
 {
 	struct nv_host_desc	*host_desc;
+	unsigned long		host_flags;
 };
 
 static struct pci_driver nv_pci_driver = {
@@ -284,8 +295,8 @@
 	if (sc_reg > SCR_CONTROL)
 		return 0xffffffffU;
 
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		return readl(ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		return readl((void*)ap->ioaddr.scr_addr + (sc_reg * 4));
 	else
 		return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -298,8 +309,8 @@
 	if (sc_reg > SCR_CONTROL)
 		return;
 
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
-		writel(val, ap->ioaddr.scr_addr + (sc_reg * 4));
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		writel(val, (void*)ap->ioaddr.scr_addr + (sc_reg * 4));
 	else
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -322,6 +333,14 @@
 	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
 	int rc;
+	u32 bar;
+
+        // Make sure this is a SATA controller by counting the number of bars
+        // (NVIDIA SATA controllers will always have six bars).  Otherwise,
+        // it's an IDE controller and we ignore it.
+	for (bar=0; bar<6; bar++)
+		if (pci_resource_start(pdev, bar) == 0)
+			return -ENODEV;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
@@ -352,11 +371,15 @@
 	if (!host)
 		goto err_out_free_ent;
 
+	memset(host, 0, sizeof(struct nv_host));
 	host->host_desc = &nv_device_tbl[ent->driver_data];
 
 	probe_ent->private_data = host;
 
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
+	if (pci_resource_flags(pdev, 5) & IORESOURCE_MEM)
+		host->host_flags |= NV_HOST_FLAGS_SCR_MMIO;
+
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO) {
 		unsigned long base;
 
 		probe_ent->mmio_base = ioremap(pci_resource_start(pdev, 5),
@@ -395,7 +418,7 @@
 	return 0;
 
 err_out_iounmap:
-	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+	if (host->host_flags & NV_HOST_FLAGS_SCR_MMIO)
 		iounmap(probe_ent->mmio_base);
 err_out_free_host:
 	kfree(host);
diff -Nru a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c	2005-02-02 04:02:11 -05:00
+++ b/drivers/scsi/sata_promise.c	2005-02-02 04:02:11 -05:00
@@ -156,10 +156,16 @@
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
+
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
+
 	{ }	/* terminate list */
 };
 
@@ -406,9 +412,11 @@
 		return IRQ_NONE;
 	}
 
-        spin_lock(&host_set->lock);
+	spin_lock(&host_set->lock);
+
+	writel(mask, mmio_base + PDC_INT_SEQMASK);
 
-        for (i = 0; i < host_set->n_ports; i++) {
+	for (i = 0; i < host_set->n_ports; i++) {
 		VPRINTK("port %u\n", i);
 		ap = host_set->ports[i];
 		tmp = mask & (1 << (i + 1));

--------------090908020905020001000307--
