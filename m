Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268067AbVBFFsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268067AbVBFFsX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbVBFFsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:48:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37043 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S267098AbVBFFo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:44:59 -0500
Message-ID: <4205AECC.9050305@pobox.com>
Date: Sun, 06 Feb 2005 00:44:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Reply-To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [RFT #2] libata (SATA) driver fixes
Content-Type: multipart/mixed;
 boundary="------------080402000802040405050702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080402000802040405050702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See attached changelog and patch, for review and testing.

This includes some fixes for some ugly probe-related bugs, rarely hit 
thankfully.  It also includes new "future nvidia SATA" support and 
Promise SATAII TX2/4 support.

Note that this patch changes the interrupt-acknowledgement code in 
sata_promise.c for all Promise controllers, not just the new SATAII 
ones.  This should be safe and indeed desirable, but warrants special 
mention (and testing).

This is going to Linus/Andrew for 2.6.11 real soon now.

	Jeff



--------------080402000802040405050702
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/libata-core.c  |  187 ++++++++++++++++++++++++++++++++------------
 drivers/scsi/libata-scsi.c  |   35 ++++----
 drivers/scsi/sata_nv.c      |   45 ++++++++--
 drivers/scsi/sata_promise.c |   14 ++-
 drivers/scsi/sata_sil.c     |    1 
 include/linux/ata.h         |    2 
 include/linux/libata.h      |    2 
 7 files changed, 207 insertions(+), 79 deletions(-)

through these ChangeSets:

<jpaana:s2.org>:
  o [libata sata_promise] add PCI ID for new SATAII TX2 card

<mkrikis:yahoo.com>:
  o libata: fix ata_piix on ICH6R in RAID mode

<syntax:pa.net>:
  o [libata sata_sil] add another Seagate drive to blacklist

Albert Lee:
  o [libata] SCSI-to-ATA translation fixes

Andrew Chew:
  o sata_nv: enable generic class support for future NVIDIA SATA

Brett Russ:
  o [libata scsi] verify cmd bug fixes/support

Jeff Garzik:
  o [libata sata_promise] support Promise SATAII TX2/TX4 cards
  o [libata] Remove CDROM drive from PATA DMA blacklist
  o [libata] add DMA blacklist

Pete Zaitcev:
  o [libata] fix probe object allocation bugs


--------------080402000802040405050702
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2005-02-06 00:34:30 -05:00
+++ b/drivers/scsi/libata-core.c	2005-02-06 00:34:30 -05:00
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
@@ -3452,32 +3535,28 @@
 }
 
 static struct ata_probe_ent *
-ata_probe_ent_alloc(int n, struct device *dev, struct ata_port_info **port)
+ata_probe_ent_alloc(struct device *dev, struct ata_port_info *port)
 {
 	struct ata_probe_ent *probe_ent;
-	int i;
 
-	probe_ent = kmalloc(sizeof(*probe_ent) * n, GFP_KERNEL);
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       kobject_name(&(dev->kobj)));
 		return NULL;
 	}
 
-	memset(probe_ent, 0, sizeof(*probe_ent) * n);
+	memset(probe_ent, 0, sizeof(*probe_ent));
 
-	for (i = 0; i < n; i++) {
-		INIT_LIST_HEAD(&probe_ent[i].node);
-		probe_ent[i].dev = dev;
-
-		probe_ent[i].sht = port[i]->sht;
-		probe_ent[i].host_flags = port[i]->host_flags;
-		probe_ent[i].pio_mask = port[i]->pio_mask;
-		probe_ent[i].mwdma_mask = port[i]->mwdma_mask;
-		probe_ent[i].udma_mask = port[i]->udma_mask;
-		probe_ent[i].port_ops = port[i]->port_ops;
+	INIT_LIST_HEAD(&probe_ent->node);
+	probe_ent->dev = dev;
 
-	}
+	probe_ent->sht = port->sht;
+	probe_ent->host_flags = port->host_flags;
+	probe_ent->pio_mask = port->pio_mask;
+	probe_ent->mwdma_mask = port->mwdma_mask;
+	probe_ent->udma_mask = port->udma_mask;
+	probe_ent->port_ops = port->port_ops;
 
 	return probe_ent;
 }
@@ -3487,7 +3566,7 @@
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port)
 {
 	struct ata_probe_ent *probe_ent =
-		ata_probe_ent_alloc(1, pci_dev_to_dev(pdev), port);
+		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
 
@@ -3513,39 +3592,47 @@
 	return probe_ent;
 }
 
-struct ata_probe_ent *
-ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port)
+static struct ata_probe_ent *
+ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port,
+    struct ata_probe_ent **ppe2)
 {
-	struct ata_probe_ent *probe_ent =
-		ata_probe_ent_alloc(2, pci_dev_to_dev(pdev), port);
+	struct ata_probe_ent *probe_ent, *probe_ent2;
+
+	probe_ent = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
 	if (!probe_ent)
 		return NULL;
+	probe_ent2 = ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[1]);
+	if (!probe_ent2) {
+		kfree(probe_ent);
+		return NULL;
+	}
+
+	probe_ent->n_ports = 1;
+	probe_ent->irq = 14;
 
-	probe_ent[0].n_ports = 1;
-	probe_ent[0].irq = 14;
+	probe_ent->hard_port_no = 0;
+	probe_ent->legacy_mode = 1;
 
-	probe_ent[0].hard_port_no = 0;
-	probe_ent[0].legacy_mode = 1;
+	probe_ent2->n_ports = 1;
+	probe_ent2->irq = 15;
 
-	probe_ent[1].n_ports = 1;
-	probe_ent[1].irq = 15;
+	probe_ent2->hard_port_no = 1;
+	probe_ent2->legacy_mode = 1;
 
-	probe_ent[1].hard_port_no = 1;
-	probe_ent[1].legacy_mode = 1;
-
-	probe_ent[0].port[0].cmd_addr = 0x1f0;
-	probe_ent[0].port[0].altstatus_addr =
-	probe_ent[0].port[0].ctl_addr = 0x3f6;
-	probe_ent[0].port[0].bmdma_addr = pci_resource_start(pdev, 4);
-
-	probe_ent[1].port[0].cmd_addr = 0x170;
-	probe_ent[1].port[0].altstatus_addr =
-	probe_ent[1].port[0].ctl_addr = 0x376;
-	probe_ent[1].port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
+	probe_ent->port[0].cmd_addr = 0x1f0;
+	probe_ent->port[0].altstatus_addr =
+	probe_ent->port[0].ctl_addr = 0x3f6;
+	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
 
-	ata_std_ports(&probe_ent[0].port[0]);
-	ata_std_ports(&probe_ent[1].port[0]);
+	probe_ent2->port[0].cmd_addr = 0x170;
+	probe_ent2->port[0].altstatus_addr =
+	probe_ent2->port[0].ctl_addr = 0x376;
+	probe_ent2->port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
+
+	ata_std_ports(&probe_ent->port[0]);
+	ata_std_ports(&probe_ent2->port[0]);
 
+	*ppe2 = probe_ent2;
 	return probe_ent;
 }
 
@@ -3579,7 +3666,8 @@
 	else
 		port[1] = port[0];
 
-	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0) {
+	if ((port[0]->host_flags & ATA_FLAG_NO_LEGACY) == 0
+	    && (pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
 		/* TODO: support transitioning to native mode? */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
 		mask = (1 << 2) | (1 << 0);
@@ -3641,9 +3729,7 @@
 		goto err_out_regions;
 
 	if (legacy_mode) {
-		probe_ent = ata_pci_init_legacy_mode(pdev, port);
-		if (probe_ent)
-			probe_ent2 = &probe_ent[1];
+		probe_ent = ata_pci_init_legacy_mode(pdev, port, &probe_ent2);
 	} else
 		probe_ent = ata_pci_init_native_mode(pdev, port);
 	if (!probe_ent) {
@@ -3657,8 +3743,12 @@
 	if (legacy_mode) {
 		if (legacy_mode & (1 << 0))
 			ata_device_add(probe_ent);
+		else
+			kfree(probe_ent);
 		if (legacy_mode & (1 << 1))
 			ata_device_add(probe_ent2);
+		else
+			kfree(probe_ent2);
 	} else {
 		ata_device_add(probe_ent);
 	}
@@ -3848,7 +3938,6 @@
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
-EXPORT_SYMBOL_GPL(ata_pci_init_legacy_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_native_mode);
 EXPORT_SYMBOL_GPL(ata_pci_init_one);
 EXPORT_SYMBOL_GPL(ata_pci_remove_one);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2005-02-06 00:34:30 -05:00
+++ b/drivers/scsi/libata-scsi.c	2005-02-06 00:34:30 -05:00
@@ -202,7 +202,7 @@
 		{0x40, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Uncorrectable ECC error      Unrecovered read error
 		/* BBD - block marked bad */
 		{0x80, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Block marked bad		  Medium error, unrecovered read error
-		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	static unsigned char stat_table[][4] = {
 		/* Must be first because BUSY means no other bits valid */
@@ -210,22 +210,22 @@
 		{0x20, 		HARDWARE_ERROR,  0x00, 0x00}, 	// Device fault
 		{0x08, 		ABORTED_COMMAND, 0x47, 0x00},	// Timed out in xfer, fake parity for now
 		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	  Medium error, recovered
-		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	int i = 0;
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
-	
+
 	/*
 	 *	Is this an error we can process/parse
 	 */
-	 
+
 	if(drv_stat & ATA_ERR)
 		/* Read the err bits */
 		err = ata_chk_err(qc->ap);
 
 	/* Display the ATA level error info */
-	
+
 	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
 	if(drv_stat & 0x80)
 	{
@@ -242,7 +242,7 @@
 		if(drv_stat & 0x01)	printk("Error ");
 	}
 	printk("}\n");
-	
+
 	if(err)
 	{
 		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
@@ -259,11 +259,11 @@
 		if(err & 0x02)		printk("TrackZeroNotFound ");
 		if(err & 0x01)		printk("AddrMarkNotFound ");
 		printk("}\n");
-		
+
 		/* Should we dump sector info here too ?? */
 	}
-		
-	
+
+
 	/* Look for err */
 	while(sense_table[i][0] != 0xFF)
 	{
@@ -301,7 +301,7 @@
 	/* No error ?? */
 	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", qc->ap->id, drv_stat);
 	/* additional-sense-code[-qualifier] */
-	
+
 	sb[0] = 0x70;
 	sb[2] = MEDIUM_ERROR;
 	sb[7] = 0x0A;
@@ -488,19 +488,24 @@
 	}
 
 	if (lba48) {
+		tf->command = ATA_CMD_VERIFY_EXT;
+
 		tf->hob_nsect = (n_sect >> 8) & 0xff;
 
 		tf->hob_lbah = (sect >> 40) & 0xff;
 		tf->hob_lbam = (sect >> 32) & 0xff;
 		tf->hob_lbal = (sect >> 24) & 0xff;
-	} else
+	} else {
+		tf->command = ATA_CMD_VERIFY;
+
 		tf->device |= (sect >> 24) & 0xf;
+	}
 
 	tf->nsect = n_sect & 0xff;
 
-	tf->hob_lbah = (sect >> 16) & 0xff;
-	tf->hob_lbam = (sect >> 8) & 0xff;
-	tf->hob_lbal = sect & 0xff;
+	tf->lbah = (sect >> 16) & 0xff;
+	tf->lbam = (sect >> 8) & 0xff;
+	tf->lbal = sect & 0xff;
 
 	return 0;
 }
@@ -600,7 +605,7 @@
 				return 1;
 
 			/* stores LBA27:24 in lower 4 bits of device reg */
-			tf->device |= scsicmd[2];
+			tf->device |= scsicmd[6];
 
 			qc->nsect = scsicmd[13];
 		}
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2005-02-06 00:34:30 -05:00
+++ b/drivers/scsi/sata_nv.c	2005-02-06 00:34:30 -05:00
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
--- a/drivers/scsi/sata_promise.c	2005-02-06 00:34:30 -05:00
+++ b/drivers/scsi/sata_promise.c	2005-02-06 00:34:30 -05:00
@@ -156,10 +156,18 @@
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3574, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
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
 
@@ -406,9 +414,11 @@
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
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-02-06 00:34:30 -05:00
+++ b/drivers/scsi/sata_sil.c	2005-02-06 00:34:30 -05:00
@@ -86,6 +86,7 @@
 	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
+	{ "ST380013AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2005-02-06 00:34:30 -05:00
+++ b/include/linux/ata.h	2005-02-06 00:34:30 -05:00
@@ -123,6 +123,8 @@
 	ATA_CMD_PIO_WRITE_EXT	= 0x34,
 	ATA_CMD_SET_FEATURES	= 0xEF,
 	ATA_CMD_PACKET		= 0xA0,
+	ATA_CMD_VERIFY		= 0x40,
+	ATA_CMD_VERIFY_EXT	= 0x42,
 
 	/* SETFEATURES stuff */
 	SETFEATURES_XFER	= 0x03,
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2005-02-06 00:34:30 -05:00
+++ b/include/linux/libata.h	2005-02-06 00:34:30 -05:00
@@ -436,8 +436,6 @@
 
 extern struct ata_probe_ent *
 ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port);
-extern struct ata_probe_ent *
-ata_pci_init_legacy_mode(struct pci_dev *pdev, struct ata_port_info **port);
 extern int pci_test_config_bits(struct pci_dev *pdev, struct pci_bits *bits);
 
 #endif /* CONFIG_PCI */

--------------080402000802040405050702--
