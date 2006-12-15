Return-Path: <linux-kernel-owner+w=401wt.eu-S1030212AbWLOWYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWLOWYq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 17:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWLOWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 17:24:46 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:58608 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030209AbWLOWYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 17:24:43 -0500
Message-ID: <45832095.9000503@garzik.org>
Date: Fri, 15 Dec 2006 17:24:21 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>,
       Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Tejun Heo <htejun@gmail.com>,
       Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
References: <20061204203410.6152efec.akpm@osdl.org> <20061215130552.95860b72.akpm@osdl.org> <20061215133927.a8346372.akpm@osdl.org> <200612152322.26375.rjw@sisk.pl>
In-Reply-To: <200612152322.26375.rjw@sisk.pl>
Content-Type: multipart/mixed;
 boundary="------------010209020902070405050708"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010209020902070405050708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:
> On Friday, 15 December 2006 22:39, Andrew Morton wrote:
>> On Fri, 15 Dec 2006 13:05:52 -0800
>> Andrew Morton <akpm@osdl.org> wrote:
>>
>>> Jeff, I shall send all the sata patches which I have at you one single time
>>> and I shall then drop the lot.  So please don't flub them.
>>>
>>> I'll then do a rc1-mm2 without them.
>> hm, this is looking like a lot of work for not much gain.  Rafael, are
>> you able to do a quick chop and tell us whether these:
>>
>> pci-move-pci_vdevice-from-libata-to-core.patch
>> pata_cs5530-suspend-resume-support-tweak.patch
>> ata-fix-platform_device_register_simple-error-check.patch
>> initializer-entry-defined-twice-in-pata_rz1000.patch
>> pata_via-suspend-resume-support-fix.patch
>> sata_nv-add-suspend-resume-support.patch
>> libata-simulate-report-luns-for-atapi-devices.patch
>> user-of-the-jiffies-rounding-patch-ata-subsystem.patch
>> libata-fix-oops-with-sparsemem.patch
>> sata_nv-fix-kfree-ordering-in-remove.patch
>> libata-dont-initialize-sg-in-ata_exec_internal-if-dma_none-take-2.patch
>> pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks-ide-fix.patch
>>
>> are innocent?
> 
> Yes, they are.

We all really appreciate your patience :)  This is good feedback.

To narrow down some more, does applying 2.6.20-rc1 + the attached patch 
work?  (ignoring -mm tree altogether)

The attached patch should /basically/ be the contents of Andrew's 
git-netdev-all patch.

	Jeff




--------------010209020902070405050708
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 984ab28..fb1de86 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -292,7 +292,7 @@ config PATA_ISAPNP
 	  If unsure, say N.
 
 config PATA_IT821X
-	tristate "IT821x PATA support (Experimental)"
+	tristate "IT8211/2 PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
 	help
 	  This option enables support for the ITE 8211 and 8212
@@ -301,6 +301,15 @@ config PATA_IT821X
 
 	  If unsure, say N.
 
+config PATA_IT8213
+	tristate "IT8213 PATA support (Experimental)"
+	depends on PCI && EXPERIMENTAL
+	help
+	  This option enables support for the ITE 821 PATA
+          controllers via the new ATA layer.
+
+	  If unsure, say N.
+
 config PATA_JMICRON
 	tristate "JMicron PATA support"
 	depends on PCI
@@ -337,6 +346,15 @@ config PATA_MARVELL
 
 	  If unsure, say N.
 
+config PATA_MPC52xx
+	tristate "Freescale MPC52xx SoC internal IDE"
+	depends on PPC_MPC52xx
+	help
+	  This option enables support for integrated IDE controller
+	  of the Freescale MPC52xx SoC.
+
+	  If unsure, say N.
+
 config PATA_MPIIX
 	tristate "Intel PATA MPIIX support"
 	depends on PCI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index bc3d81a..a0df15d 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -33,11 +33,13 @@ obj-$(CONFIG_PATA_HPT3X2N)	+= pata_hpt3x2n.o
 obj-$(CONFIG_PATA_HPT3X3)	+= pata_hpt3x3.o
 obj-$(CONFIG_PATA_ISAPNP)	+= pata_isapnp.o
 obj-$(CONFIG_PATA_IT821X)	+= pata_it821x.o
+obj-$(CONFIG_PATA_IT8213)	+= pata_it8213.o
 obj-$(CONFIG_PATA_JMICRON)	+= pata_jmicron.o
 obj-$(CONFIG_PATA_NETCELL)	+= pata_netcell.o
 obj-$(CONFIG_PATA_NS87410)	+= pata_ns87410.o
 obj-$(CONFIG_PATA_OPTI)		+= pata_opti.o
 obj-$(CONFIG_PATA_OPTIDMA)	+= pata_optidma.o
+obj-$(CONFIG_PATA_MPC52xx)	+= pata_mpc52xx.o
 obj-$(CONFIG_PATA_MARVELL)	+= pata_marvell.o
 obj-$(CONFIG_PATA_MPIIX)	+= pata_mpiix.o
 obj-$(CONFIG_PATA_OLDPIIX)	+= pata_oldpiix.o
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f36da48..dbae6d9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -645,8 +645,6 @@ static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev)
 	u32 cap_save, impl_save, tmp;
 
 	cap_save = readl(mmio + HOST_CAP);
-	cap_save &= ( (1<<28) | (1<<17) );
-	cap_save |= (1 << 27);
 	impl_save = readl(mmio + HOST_PORTS_IMPL);
 
 	/* global controller reset */
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index c7de0bb..7959e4c 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -226,14 +226,26 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	{ 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
 	/* 2801GBM/GHM (ICH7M, identical to ICH6M) */
 	{ 0x8086, 0x27c4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6m_sata_ahci },
-	/* Enterprise Southbridge 2 (where's the datasheet?) */
+	/* Enterprise Southbridge 2 (631xESB/632xESB) */
 	{ 0x8086, 0x2680, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },
-	/* SATA Controller 1 IDE (ICH8, no datasheet yet) */
+	/* SATA Controller 1 IDE (ICH8) */
 	{ 0x8086, 0x2820, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
-	/* SATA Controller 2 IDE (ICH8, ditto) */
+	/* SATA Controller 2 IDE (ICH8) */
 	{ 0x8086, 0x2825, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
-	/* Mobile SATA Controller IDE (ICH8M, ditto) */
+	/* Mobile SATA Controller IDE (ICH8M) */
 	{ 0x8086, 0x2828, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9) */
+	{ 0x8086, 0x2920, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9) */
+	{ 0x8086, 0x2921, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9) */
+	{ 0x8086, 0x2926, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9M) */
+	{ 0x8086, 0x2928, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9M) */
+	{ 0x8086, 0x292d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
+	/* SATA Controller IDE (ICH9M) */
+	{ 0x8086, 0x292e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_ahci },
 
 	{ }	/* terminate list */
 };
@@ -330,7 +342,7 @@ static const struct ata_port_operations ich_pata_ops = {
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_host_stop,
+	.host_stop		= piix_host_stop,
 };
 
 static const struct ata_port_operations piix_sata_ops = {
@@ -620,7 +632,7 @@ static int piix_pata_prereset(struct ata_port *ap)
 
 	if (!pci_test_config_bits(pdev, &piix_enable_bits[ap->port_no]))
 		return -ENOENT;
-		
+
 	ap->cbl = ATA_CBL_PATA40;
 	return ata_std_prereset(ap);
 }
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 011c0a8..fd20e7a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1332,7 +1332,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 }
 
 /**
- *	ata_exec_internal_sg - execute libata internal command
+ *	ata_exec_internal - execute libata internal command
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
  *	@cdb: CDB for packet command
@@ -1353,11 +1353,17 @@ unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
 {
-	struct scatterlist sg;
+	struct scatterlist *psg = NULL, sg;
+	unsigned int n_elem = 0;
 
-	sg_init_one(&sg, buf, buflen);
+	if (dma_dir != DMA_NONE) {
+		WARN_ON(!buf);
+		sg_init_one(&sg, buf, buflen);
+		psg = &sg;
+		n_elem++;
+	}
 
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, 1);
+	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem);
 }
 
 /**
@@ -5773,7 +5779,7 @@ int ata_device_add(const struct ata_probe_ent *ent)
 	int rc;
 
 	DPRINTK("ENTER\n");
-	
+
 	if (ent->irq == 0) {
 		dev_printk(KERN_ERR, dev, "is not available: No interrupt assigned.\n");
 		return 0;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 664e137..a4790be 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1539,7 +1539,7 @@ static unsigned int ata_scsi_rbuf_get(struct scsi_cmnd *cmd, u8 **buf_out)
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		buf = kmap_atomic(sg->page, KM_USER0) + sg->offset;
+		buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
 		buflen = sg->length;
 	} else {
 		buf = cmd->request_buffer;
@@ -1567,7 +1567,7 @@ static inline void ata_scsi_rbuf_put(struct scsi_cmnd *cmd, u8 *buf)
 		struct scatterlist *sg;
 
 		sg = (struct scatterlist *) cmd->request_buffer;
-		kunmap_atomic(buf - sg->offset, KM_USER0);
+		kunmap_atomic(buf - sg->offset, KM_IRQ0);
 	}
 }
 
diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index c5d61d1..2035417 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -504,7 +504,7 @@ static struct ata_port_operations ali_c5_port_ops = {
  *	Perform the setup on the device that must be done both at boot
  *	and at resume time.
  */
- 
+
 static void ali_init_chipset(struct pci_dev *pdev)
 {
 	u8 rev, tmp;
@@ -655,7 +655,7 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
         	port_info[0] = port_info[1] = &info_c5;
 
 	ali_init_chipset(pdev);
-	
+
 	isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
 	if (isa_bridge && rev >= 0x20 && rev < 0xC2) {
 		/* Are we paired with a UDMA capable chip */
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 9f165a8..476b879 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -305,7 +305,7 @@ static void __devexit cs5520_remove_one(struct pci_dev *pdev)
  *	Do any reconfiguration work needed by a resume from RAM. We need
  *	to restore DMA mode support on BIOSen which disabled it
  */
- 
+
 static int cs5520_reinit_one(struct pci_dev *pdev)
 {
 	u8 pcicfg;
diff --git a/drivers/ata/pata_cs5530.c b/drivers/ata/pata_cs5530.c
index 1c62801..9b9d911 100644
--- a/drivers/ata/pata_cs5530.c
+++ b/drivers/ata/pata_cs5530.c
@@ -247,7 +247,7 @@ static int cs5530_is_palmax(void)
  *	Perform the chip initialisation work that is shared between both
  *	setup and resume paths
  */
- 
+
 static int cs5530_init_chip(void)
 {
 	struct pci_dev *master_0 = NULL, *cs5530_0 = NULL, *dev = NULL;
@@ -357,11 +357,11 @@ static int cs5530_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		.port_ops = &cs5530_port_ops
 	};
 	static struct ata_port_info *port_info[2] = { &info, &info };
-	
+
 	/* Chip initialisation */
 	if (cs5530_init_chip())
 		return -ENODEV;
-		
+
 	if (cs5530_is_palmax())
 		port_info[1] = &info_palmax_secondary;
 
@@ -375,7 +375,7 @@ static int cs5530_reinit_one(struct pci_dev *pdev)
 	BUG_ON(cs5530_init_chip());
 	return ata_pci_device_resume(pdev);
 }
-	
+
 static const struct pci_device_id cs5530[] = {
 	{ PCI_VDEVICE(CYRIX, PCI_DEVICE_ID_CYRIX_5530_IDE), },
 
diff --git a/drivers/ata/pata_hpt366.c b/drivers/ata/pata_hpt366.c
index 2663599..8cf167e 100644
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -232,7 +232,7 @@ static int hpt36x_pre_reset(struct ata_port *ap)
 
 	if (!pci_test_config_bits(pdev, &hpt36x_enable_bits[ap->port_no]))
 		return -ENOENT;
-		
+
 	pci_read_config_byte(pdev, 0x5A, &ata66);
 	if (ata66 & (1 << ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 47082df..e51651b 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -459,7 +459,7 @@ static int hpt37x_pre_reset(struct ata_port *ap)
 	};
 	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
 		return -ENOENT;
-		
+
 	pci_read_config_byte(pdev, 0x5B, &scr2);
 	pci_write_config_byte(pdev, 0x5B, scr2 & ~0x01);
 	/* Cable register now active */
@@ -504,7 +504,7 @@ static int hpt374_pre_reset(struct ata_port *ap)
 
 	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
 		return -ENOENT;
-		
+
 	/* Do the extra channel work */
 	pci_read_config_word(pdev, 0x52, &mcr3);
 	pci_read_config_word(pdev, 0x56, &mcr6);
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index 5f1d385..5caf167 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -164,7 +164,7 @@ static struct ata_port_operations hpt3x3_port_ops = {
  *
  *	Perform the setup required at boot and on resume.
  */
- 
+
 static void hpt3x3_init_chipset(struct pci_dev *dev)
 {
 	u16 cmd;
diff --git a/drivers/ata/pata_it8213.c b/drivers/ata/pata_it8213.c
new file mode 100644
index 0000000..7e9a416
--- /dev/null
+++ b/drivers/ata/pata_it8213.c
@@ -0,0 +1,354 @@
+/*
+ *    pata_it8213.c - iTE Tech. Inc.  IT8213 PATA driver
+ *
+ *    The IT8213 is a very Intel ICH like device for timing purposes, having
+ *    a similar register layout and the same split clock arrangement. Cable
+ *    detection is different, and it does not have slave channels or all the
+ *    clutter of later ICH/SATA setups.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+#include <linux/ata.h>
+
+#define DRV_NAME	"pata_it8213"
+#define DRV_VERSION	"0.0.2"
+
+/**
+ *	it8213_pre_reset	-	check for 40/80 pin
+ *	@ap: Port
+ *
+ *	Perform cable detection for the 8213 ATA interface. This is
+ *	different to the PIIX arrangement
+ */
+
+static int it8213_pre_reset(struct ata_port *ap)
+{
+	static const struct pci_bits it8213_enable_bits[] = {
+		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
+	};
+
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	u8 tmp;
+
+	if (!pci_test_config_bits(pdev, &it8213_enable_bits[ap->port_no]))
+		return -ENOENT;
+
+	pci_read_config_byte(pdev, 0x42, &tmp);
+	if (tmp & 2)	/* The initial docs are incorrect */
+		ap->cbl = ATA_CBL_PATA40;
+	else
+		ap->cbl = ATA_CBL_PATA80;
+	return ata_std_prereset(ap);
+}
+
+/**
+ *	it8213_probe_reset - Probe specified port on PATA host controller
+ *	@ap: Port to probe
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void it8213_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, it8213_pre_reset, ata_std_softreset, NULL, ata_std_postreset);
+}
+
+/**
+ *	it8213_set_piomode - Initialize host controller PATA PIO timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *
+ *	Set PIO mode for device, in host controller PCI config space.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void it8213_set_piomode (struct ata_port *ap, struct ata_device *adev)
+{
+	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
+	unsigned int idetm_port= ap->port_no ? 0x42 : 0x40;
+	u16 idetm_data;
+	int control = 0;
+
+	/*
+	 *	See Intel Document 298600-004 for the timing programing rules
+	 *	for PIIX/ICH. The 8213 is a clone so very similar
+	 */
+
+	static const	 /* ISP  RTC */
+	u8 timings[][2]	= { { 0, 0 },
+			    { 0, 0 },
+			    { 1, 0 },
+			    { 2, 1 },
+			    { 2, 3 }, };
+
+	if (pio > 2)
+		control |= 1;	/* TIME1 enable */
+	if (ata_pio_need_iordy(adev))	/* PIO 3/4 require IORDY */
+		control |= 2;	/* IORDY enable */
+	/* Bit 2 is set for ATAPI on the IT8213 - reverse of ICH/PIIX */
+	if (adev->class != ATA_DEV_ATA)
+		control |= 4;
+
+	pci_read_config_word(dev, idetm_port, &idetm_data);
+
+	/* Enable PPE, IE and TIME as appropriate */
+
+	if (adev->devno == 0) {
+		idetm_data &= 0xCCF0;
+		idetm_data |= control;
+		idetm_data |= (timings[pio][0] << 12) |
+			(timings[pio][1] << 8);
+	} else {
+		u8 slave_data;
+
+		idetm_data &= 0xCC0F;
+		idetm_data |= (control << 4);
+
+		/* Slave timing in seperate register */
+		pci_read_config_byte(dev, 0x44, &slave_data);
+		slave_data &= 0xF0;
+		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << 4;
+		pci_write_config_byte(dev, 0x44, slave_data);
+	}
+
+	idetm_data |= 0x4000;	/* Ensure SITRE is enabled */
+	pci_write_config_word(dev, idetm_port, idetm_data);
+}
+
+/**
+ *	it8213_set_dmamode - Initialize host controller PATA DMA timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: Device to program
+ *
+ *	Set UDMA/MWDMA mode for device, in host controller PCI config space.
+ *	This device is basically an ICH alike.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void it8213_set_dmamode (struct ata_port *ap, struct ata_device *adev)
+{
+	struct pci_dev *dev	= to_pci_dev(ap->host->dev);
+	u16 master_data;
+	u8 speed		= adev->dma_mode;
+	int devid		= adev->devno;
+	u8 udma_enable;
+
+	static const	 /* ISP  RTC */
+	u8 timings[][2]	= { { 0, 0 },
+			    { 0, 0 },
+			    { 1, 0 },
+			    { 2, 1 },
+			    { 2, 3 }, };
+
+	pci_read_config_word(dev, 0x40, &master_data);
+	pci_read_config_byte(dev, 0x48, &udma_enable);
+
+	if (speed >= XFER_UDMA_0) {
+		unsigned int udma = adev->dma_mode - XFER_UDMA_0;
+		u16 udma_timing;
+		u16 ideconf;
+		int u_clock, u_speed;
+
+		/* Clocks follow the PIIX style */
+		u_speed = min(2 - (udma & 1), udma);
+		if (udma == 5)
+			u_clock = 0x1000;	/* 100Mhz */
+		else if (udma > 2)
+			u_clock = 1;		/* 66Mhz */
+		else
+			u_clock = 0;		/* 33Mhz */
+
+		udma_enable |= (1 << devid);
+
+		/* Load the UDMA mode number */
+		pci_read_config_word(dev, 0x4A, &udma_timing);
+		udma_timing &= ~(3 << (4 * devid));
+		udma_timing |= (udma & 3) << (4 * devid);
+		pci_write_config_word(dev, 0x4A, udma_timing);
+
+		/* Load the clock selection */
+		pci_read_config_word(dev, 0x54, &ideconf);
+		ideconf &= ~(0x1001 << devid);
+		ideconf |= u_clock << devid;
+		pci_write_config_word(dev, 0x54, ideconf);
+	} else {
+		/*
+		 * MWDMA is driven by the PIO timings. We must also enable
+		 * IORDY unconditionally along with TIME1. PPE has already
+		 * been set when the PIO timing was set.
+		 */
+		unsigned int mwdma	= adev->dma_mode - XFER_MW_DMA_0;
+		unsigned int control;
+		u8 slave_data;
+		static const unsigned int needed_pio[3] = {
+			XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
+		};
+		int pio = needed_pio[mwdma] - XFER_PIO_0;
+
+		control = 3;	/* IORDY|TIME1 */
+
+		/* If the drive MWDMA is faster than it can do PIO then
+		   we must force PIO into PIO0 */
+
+		if (adev->pio_mode < needed_pio[mwdma])
+			/* Enable DMA timing only */
+			control |= 8;	/* PIO cycles in PIO0 */
+
+		if (devid) {	/* Slave */
+			master_data &= 0xFF4F;  /* Mask out IORDY|TIME1|DMAONLY */
+			master_data |= control << 4;
+			pci_read_config_byte(dev, 0x44, &slave_data);
+			slave_data &= (0x0F + 0xE1 * ap->port_no);
+			/* Load the matching timing */
+			slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) << (ap->port_no ? 4 : 0);
+			pci_write_config_byte(dev, 0x44, slave_data);
+		} else { 	/* Master */
+			master_data &= 0xCCF4;	/* Mask out IORDY|TIME1|DMAONLY
+						   and master timing bits */
+			master_data |= control;
+			master_data |=
+				(timings[pio][0] << 12) |
+				(timings[pio][1] << 8);
+		}
+		udma_enable &= ~(1 << devid);
+		pci_write_config_word(dev, 0x40, master_data);
+	}
+	pci_write_config_byte(dev, 0x48, udma_enable);
+}
+
+static struct scsi_host_template it8213_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
+};
+
+static const struct ata_port_operations it8213_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= it8213_set_piomode,
+	.set_dmamode		= it8213_set_dmamode,
+	.mode_filter		= ata_pci_default_filter,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= it8213_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	.bmdma_setup		= ata_bmdma_setup,
+	.bmdma_start		= ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_pio_data_xfer,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
+
+/**
+ *	it8213_init_one - Register 8213 ATA PCI device with kernel services
+ *	@pdev: PCI device to register
+ *	@ent: Entry in it8213_pci_tbl matching with @pdev
+ *
+ *	Called from kernel PCI layer.
+ *
+ *	LOCKING:
+ *	Inherited from PCI layer (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, or -ERRNO value.
+ */
+
+static int it8213_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version;
+	static struct ata_port_info info = {
+		.sht		= &it8213_sht,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x07, /* mwdma0-2 */
+		.udma_mask 	= 0x1f, /* UDMA 100 */
+		.port_ops	= &it8213_ops,
+	};
+	static struct ata_port_info *port_info[2] = { &info, &info };
+
+	if (!printed_version++)
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "version " DRV_VERSION "\n");
+
+	/* Current IT8213 stuff is single port */
+	return ata_pci_init_one(pdev, port_info, 1);
+}
+
+static const struct pci_device_id it8213_pci_tbl[] = {
+	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8213), },
+
+	{ }	/* terminate list */
+};
+
+static struct pci_driver it8213_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= it8213_pci_tbl,
+	.probe			= it8213_init_one,
+	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
+};
+
+static int __init it8213_init(void)
+{
+	return pci_register_driver(&it8213_pci_driver);
+}
+
+static void __exit it8213_exit(void)
+{
+	pci_unregister_driver(&it8213_pci_driver);
+}
+
+module_init(it8213_init);
+module_exit(it8213_exit);
+
+MODULE_AUTHOR("Alan Cox");
+MODULE_DESCRIPTION("SCSI low-level driver for the ITE 8213");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, it8213_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 2d661cb..efb1b6d 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -229,7 +229,7 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 static int jmicron_reinit_one(struct pci_dev *pdev)
 {
 	u32 reg;
-	
+
 	switch(pdev->device) {
 		case PCI_DEVICE_ID_JMICRON_JMB368:
 			break;
diff --git a/drivers/ata/pata_marvell.c b/drivers/ata/pata_marvell.c
index 1c810ea..af93533 100644
--- a/drivers/ata/pata_marvell.c
+++ b/drivers/ata/pata_marvell.c
@@ -45,10 +45,10 @@ static int marvell_pre_reset(struct ata_port *ap)
 	for(i = 0; i <= 0x0F; i++)
 		printk("%02X:%02X ", i, readb(barp + i));
 	printk("\n");
-	
+
 	devices = readl(barp + 0x0C);
 	pci_iounmap(pdev, barp);
-	
+
 	if ((pdev->device == 0x6145) && (ap->port_no == 0) &&
 	    (!(devices & 0x10)))	/* PATA enable ? */
 		return -ENOENT;
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
new file mode 100644
index 0000000..8b7019a
--- /dev/null
+++ b/drivers/ata/pata_mpc52xx.c
@@ -0,0 +1,563 @@
+/*
+ * drivers/ata/pata_mpc52xx.c
+ *
+ * libata driver for the Freescale MPC52xx on-chip IDE interface
+ *
+ * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 Mipsys - Benjamin Herrenschmidt
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/libata.h>
+
+#include <asm/io.h>
+#include <asm/types.h>
+#include <asm/prom.h>
+#include <asm/of_platform.h>
+#include <asm/mpc52xx.h>
+
+
+#define DRV_NAME	"mpc52xx_ata"
+#define DRV_VERSION	"0.1.0"
+
+
+/* Private structures used by the driver */
+struct mpc52xx_ata_timings {
+	u32	pio1;
+	u32	pio2;
+};
+
+struct mpc52xx_ata_priv {
+	unsigned int			ipb_period;
+	struct mpc52xx_ata __iomem *	ata_regs;
+	int				ata_irq;
+	struct mpc52xx_ata_timings	timings[2];
+	int				csel;
+};
+
+
+/* ATAPI-4 PIO specs (in ns) */
+static const int ataspec_t0[5]    = {600, 383, 240, 180, 120};
+static const int ataspec_t1[5]    = { 70,  50,  30,  30,  25};
+static const int ataspec_t2_8[5]  = {290, 290, 290,  80,  70};
+static const int ataspec_t2_16[5] = {165, 125, 100,  80,  70};
+static const int ataspec_t2i[5]   = {  0,   0,   0,  70,  25};
+static const int ataspec_t4[5]    = { 30,  20,  15,  10,  10};
+static const int ataspec_ta[5]    = { 35,  35,  35,  35,  35};
+
+#define CALC_CLKCYC(c,v) ((((v)+(c)-1)/(c)))
+
+
+/* Bit definitions inside the registers */
+#define MPC52xx_ATA_HOSTCONF_SMR	0x80000000UL /* State machine reset */
+#define MPC52xx_ATA_HOSTCONF_FR		0x40000000UL /* FIFO Reset */
+#define MPC52xx_ATA_HOSTCONF_IE		0x02000000UL /* Enable interrupt in PIO */
+#define MPC52xx_ATA_HOSTCONF_IORDY	0x01000000UL /* Drive supports IORDY protocol */
+
+#define MPC52xx_ATA_HOSTSTAT_TIP	0x80000000UL /* Transaction in progress */
+#define MPC52xx_ATA_HOSTSTAT_UREP	0x40000000UL /* UDMA Read Extended Pause */
+#define MPC52xx_ATA_HOSTSTAT_RERR	0x02000000UL /* Read Error */
+#define MPC52xx_ATA_HOSTSTAT_WERR	0x01000000UL /* Write Error */
+
+#define MPC52xx_ATA_FIFOSTAT_EMPTY	0x01 /* FIFO Empty */
+
+#define MPC52xx_ATA_DMAMODE_WRITE	0x01 /* Write DMA */
+#define MPC52xx_ATA_DMAMODE_READ	0x02 /* Read DMA */
+#define MPC52xx_ATA_DMAMODE_UDMA	0x04 /* UDMA enabled */
+#define MPC52xx_ATA_DMAMODE_IE		0x08 /* Enable drive interrupt to CPU in DMA mode */
+#define MPC52xx_ATA_DMAMODE_FE		0x10 /* FIFO Flush enable in Rx mode */
+#define MPC52xx_ATA_DMAMODE_FR		0x20 /* FIFO Reset */
+#define MPC52xx_ATA_DMAMODE_HUT		0x40 /* Host UDMA burst terminate */
+
+
+/* Structure of the hardware registers */
+struct mpc52xx_ata {
+
+	/* Host interface registers */
+	u32 config;		/* ATA + 0x00 Host configuration */
+	u32 host_status;	/* ATA + 0x04 Host controller status */
+	u32 pio1;		/* ATA + 0x08 PIO Timing 1 */
+	u32 pio2;		/* ATA + 0x0c PIO Timing 2 */
+	u32 mdma1;		/* ATA + 0x10 MDMA Timing 1 */
+	u32 mdma2;		/* ATA + 0x14 MDMA Timing 2 */
+	u32 udma1;		/* ATA + 0x18 UDMA Timing 1 */
+	u32 udma2;		/* ATA + 0x1c UDMA Timing 2 */
+	u32 udma3;		/* ATA + 0x20 UDMA Timing 3 */
+	u32 udma4;		/* ATA + 0x24 UDMA Timing 4 */
+	u32 udma5;		/* ATA + 0x28 UDMA Timing 5 */
+	u32 share_cnt;		/* ATA + 0x2c ATA share counter */
+	u32 reserved0[3];
+
+	/* FIFO registers */
+	u32 fifo_data;		/* ATA + 0x3c */
+	u8  fifo_status_frame;	/* ATA + 0x40 */
+	u8  fifo_status;	/* ATA + 0x41 */
+	u16 reserved7[1];
+	u8  fifo_control;	/* ATA + 0x44 */
+	u8  reserved8[5];
+	u16 fifo_alarm;		/* ATA + 0x4a */
+	u16 reserved9;
+	u16 fifo_rdp;		/* ATA + 0x4e */
+	u16 reserved10;
+	u16 fifo_wrp;		/* ATA + 0x52 */
+	u16 reserved11;
+	u16 fifo_lfrdp;		/* ATA + 0x56 */
+	u16 reserved12;
+	u16 fifo_lfwrp;		/* ATA + 0x5a */
+
+	/* Drive TaskFile registers */
+	u8  tf_control;		/* ATA + 0x5c TASKFILE Control/Alt Status */
+	u8  reserved13[3];
+	u16 tf_data;		/* ATA + 0x60 TASKFILE Data */
+	u16 reserved14;
+	u8  tf_features;	/* ATA + 0x64 TASKFILE Features/Error */
+	u8  reserved15[3];
+	u8  tf_sec_count;	/* ATA + 0x68 TASKFILE Sector Count */
+	u8  reserved16[3];
+	u8  tf_sec_num;		/* ATA + 0x6c TASKFILE Sector Number */
+	u8  reserved17[3];
+	u8  tf_cyl_low;		/* ATA + 0x70 TASKFILE Cylinder Low */
+	u8  reserved18[3];
+	u8  tf_cyl_high;	/* ATA + 0x74 TASKFILE Cylinder High */
+	u8  reserved19[3];
+	u8  tf_dev_head;	/* ATA + 0x78 TASKFILE Device/Head */
+	u8  reserved20[3];
+	u8  tf_command;		/* ATA + 0x7c TASKFILE Command/Status */
+	u8  dma_mode;		/* ATA + 0x7d ATA Host DMA Mode configuration */
+	u8  reserved21[2];
+};
+
+
+/* ======================================================================== */
+/* Aux fns                                                                  */
+/* ======================================================================== */
+
+
+/* MPC52xx low level hw control */
+
+static int
+mpc52xx_ata_compute_pio_timings(struct mpc52xx_ata_priv *priv, int dev, int pio)
+{
+	struct mpc52xx_ata_timings *timing = &priv->timings[dev];
+	unsigned int ipb_period = priv->ipb_period;
+	unsigned int t0, t1, t2_8, t2_16, t2i, t4, ta;
+
+	if ((pio<0) || (pio>4))
+		return -EINVAL;
+
+	t0	= CALC_CLKCYC(ipb_period, 1000 * ataspec_t0[pio]);
+	t1	= CALC_CLKCYC(ipb_period, 1000 * ataspec_t1[pio]);
+	t2_8	= CALC_CLKCYC(ipb_period, 1000 * ataspec_t2_8[pio]);
+	t2_16	= CALC_CLKCYC(ipb_period, 1000 * ataspec_t2_16[pio]);
+	t2i	= CALC_CLKCYC(ipb_period, 1000 * ataspec_t2i[pio]);
+	t4	= CALC_CLKCYC(ipb_period, 1000 * ataspec_t4[pio]);
+	ta	= CALC_CLKCYC(ipb_period, 1000 * ataspec_ta[pio]);
+
+	timing->pio1 = (t0 << 24) | (t2_8 << 16) | (t2_16 << 8) | (t2i);
+	timing->pio2 = (t4 << 24) | (t1 << 16) | (ta << 8);
+
+	return 0;
+}
+
+static void
+mpc52xx_ata_apply_timings(struct mpc52xx_ata_priv *priv, int device)
+{
+	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
+	struct mpc52xx_ata_timings *timing = &priv->timings[device];
+
+	out_be32(&regs->pio1,  timing->pio1);
+	out_be32(&regs->pio2,  timing->pio2);
+	out_be32(&regs->mdma1, 0);
+	out_be32(&regs->mdma2, 0);
+	out_be32(&regs->udma1, 0);
+	out_be32(&regs->udma2, 0);
+	out_be32(&regs->udma3, 0);
+	out_be32(&regs->udma4, 0);
+	out_be32(&regs->udma5, 0);
+
+	priv->csel = device;
+}
+
+static int
+mpc52xx_ata_hw_init(struct mpc52xx_ata_priv *priv)
+{
+	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
+	int tslot;
+
+	/* Clear share_cnt (all sample code do this ...) */
+	out_be32(&regs->share_cnt, 0);
+
+	/* Configure and reset host */
+	out_be32(&regs->config,
+			MPC52xx_ATA_HOSTCONF_IE |
+			MPC52xx_ATA_HOSTCONF_IORDY |
+			MPC52xx_ATA_HOSTCONF_SMR |
+			MPC52xx_ATA_HOSTCONF_FR);
+
+	udelay(10);
+
+	out_be32(&regs->config,
+			MPC52xx_ATA_HOSTCONF_IE |
+			MPC52xx_ATA_HOSTCONF_IORDY);
+
+	/* Set the time slot to 1us */
+	tslot = CALC_CLKCYC(priv->ipb_period, 1000000);
+	out_be32(&regs->share_cnt, tslot << 16 );
+
+	/* Init timings to PIO0 */
+	memset(priv->timings, 0x00, 2*sizeof(struct mpc52xx_ata_timings));
+
+	mpc52xx_ata_compute_pio_timings(priv, 0, 0);
+	mpc52xx_ata_compute_pio_timings(priv, 1, 0);
+
+	mpc52xx_ata_apply_timings(priv, 0);
+
+	return 0;
+}
+
+
+/* ======================================================================== */
+/* libata driver                                                            */
+/* ======================================================================== */
+
+static void
+mpc52xx_ata_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct mpc52xx_ata_priv *priv = ap->host->private_data;
+	int pio, rv;
+
+	pio = adev->pio_mode - XFER_PIO_0;
+
+	rv = mpc52xx_ata_compute_pio_timings(priv, adev->devno, pio);
+
+	if (rv) {
+		printk(KERN_ERR DRV_NAME
+			": Trying to select invalid PIO mode %d\n", pio);
+		return;
+	}
+
+	mpc52xx_ata_apply_timings(priv, adev->devno);
+}
+static void
+mpc52xx_ata_dev_select(struct ata_port *ap, unsigned int device)
+{
+	struct mpc52xx_ata_priv *priv = ap->host->private_data;
+
+	if (device != priv->csel)
+		mpc52xx_ata_apply_timings(priv, device);
+
+	ata_std_dev_select(ap,device);
+}
+
+static void
+mpc52xx_ata_error_handler(struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL,
+			ata_std_postreset);
+}
+
+
+
+static struct scsi_host_template mpc52xx_ata_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
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
+static struct ata_port_operations mpc52xx_ata_port_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= mpc52xx_ata_set_piomode,
+	.dev_select		= mpc52xx_ata_dev_select,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= mpc52xx_ata_error_handler,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_mmio_data_xfer,
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
+static struct ata_probe_ent mpc52xx_ata_probe_ent = {
+	.port_ops	= &mpc52xx_ata_port_ops,
+	.sht		= &mpc52xx_ata_sht,
+	.n_ports	= 1,
+	.pio_mask	= 0x1f,		/* Up to PIO4 */
+	.mwdma_mask	= 0x00,		/* No MWDMA   */
+	.udma_mask	= 0x00,		/* No UDMA    */
+	.port_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_MMIO,
+	.irq_flags	= 0,
+};
+
+static int __devinit
+mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv)
+{
+	struct ata_probe_ent *ae = &mpc52xx_ata_probe_ent;
+	struct ata_ioports *aio = &ae->port[0];
+	int rv;
+
+	INIT_LIST_HEAD(&ae->node);
+	ae->dev = dev;
+	ae->irq = priv->ata_irq;
+
+	aio->cmd_addr		= 0;	/* Don't have a classic reg block */
+	aio->altstatus_addr	= (unsigned long)&priv->ata_regs->tf_control;
+	aio->ctl_addr		= (unsigned long)&priv->ata_regs->tf_control;
+	aio->data_addr		= (unsigned long)&priv->ata_regs->tf_data;
+	aio->error_addr		= (unsigned long)&priv->ata_regs->tf_features;
+	aio->feature_addr	= (unsigned long)&priv->ata_regs->tf_features;
+	aio->nsect_addr		= (unsigned long)&priv->ata_regs->tf_sec_count;
+	aio->lbal_addr		= (unsigned long)&priv->ata_regs->tf_sec_num;
+	aio->lbam_addr		= (unsigned long)&priv->ata_regs->tf_cyl_low;
+	aio->lbah_addr		= (unsigned long)&priv->ata_regs->tf_cyl_high;
+	aio->device_addr	= (unsigned long)&priv->ata_regs->tf_dev_head;
+	aio->status_addr	= (unsigned long)&priv->ata_regs->tf_command;
+	aio->command_addr	= (unsigned long)&priv->ata_regs->tf_command;
+
+	ae->private_data = priv;
+
+	rv = ata_device_add(ae);
+
+	return rv ? 0 : -EINVAL;
+}
+
+static struct mpc52xx_ata_priv *
+mpc52xx_ata_remove_one(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct mpc52xx_ata_priv *priv = host->private_data;
+
+	ata_host_remove(host);
+
+	return priv;
+}
+
+
+/* ======================================================================== */
+/* OF Platform driver                                                       */
+/* ======================================================================== */
+
+static int __devinit
+mpc52xx_ata_probe(struct of_device *op, const struct of_device_id *match)
+{
+	unsigned int ipb_freq;
+	struct resource res_mem;
+	int ata_irq = NO_IRQ;
+	struct mpc52xx_ata __iomem *ata_regs = NULL;
+	struct mpc52xx_ata_priv *priv = NULL;
+	int rv;
+
+	/* Get ipb frequency */
+	ipb_freq = mpc52xx_find_ipb_freq(op->node);
+	if (!ipb_freq) {
+		printk(KERN_ERR DRV_NAME ": "
+			"Unable to find IPB Bus frequency\n" );
+		return -ENODEV;
+	}
+
+	/* Get IRQ and register */
+	rv = of_address_to_resource(op->node, 0, &res_mem);
+	if (rv) {
+		printk(KERN_ERR DRV_NAME ": "
+			"Error while parsing device node resource\n" );
+		return rv;
+	}
+
+	ata_irq = irq_of_parse_and_map(op->node, 0);
+	if (ata_irq == NO_IRQ) {
+		printk(KERN_ERR DRV_NAME ": "
+			"Error while mapping the irq\n");
+		return -EINVAL;
+	}
+
+	/* Request mem region */
+	if (!request_mem_region(res_mem.start,
+				sizeof(struct mpc52xx_ata), DRV_NAME)) {
+		printk(KERN_ERR DRV_NAME ": "
+			"Error while requesting mem region\n");
+		irq_dispose_mapping(ata_irq);
+		return -EBUSY;
+	}
+
+	/* Remap registers */
+	ata_regs = ioremap(res_mem.start, sizeof(struct mpc52xx_ata));
+	if (!ata_regs) {
+		printk(KERN_ERR DRV_NAME ": "
+			"Error while mapping register set\n");
+		rv = -ENOMEM;
+		goto err;
+	}
+
+	/* Prepare our private structure */
+	priv = kmalloc(sizeof(struct mpc52xx_ata_priv), GFP_ATOMIC);
+	if (!priv) {
+		printk(KERN_ERR DRV_NAME ": "
+			"Error while allocating private structure\n");
+		rv = -ENOMEM;
+		goto err;
+	}
+
+	priv->ipb_period = 1000000000 / (ipb_freq / 1000);
+	priv->ata_regs = ata_regs;
+	priv->ata_irq = ata_irq;
+	priv->csel = -1;
+
+	/* Init the hw */
+	rv = mpc52xx_ata_hw_init(priv);
+	if (rv) {
+		printk(KERN_ERR DRV_NAME ": Error during HW init\n");
+		goto err;
+	}
+
+	/* Register ourselves to libata */
+	rv = mpc52xx_ata_init_one(&op->dev, priv);
+	if (rv) {
+		printk(KERN_ERR DRV_NAME ": "
+			"Error while registering to ATA layer\n");
+		return rv;
+	}
+
+	/* Done */
+	return 0;
+
+	/* Error path */
+err:
+	kfree(priv);
+
+	if (ata_regs)
+		iounmap(ata_regs);
+
+	release_mem_region(res_mem.start, sizeof(struct mpc52xx_ata));
+
+	irq_dispose_mapping(ata_irq);
+
+	return rv;
+}
+
+static int
+mpc52xx_ata_remove(struct of_device *op)
+{
+	struct mpc52xx_ata_priv *priv;
+	struct resource res_mem;
+	int rv;
+
+	/* Unregister */
+	priv = mpc52xx_ata_remove_one(&op->dev);
+
+	/* Free everything */
+	iounmap(priv->ata_regs);
+
+	rv = of_address_to_resource(op->node, 0, &res_mem);
+	if (rv) {
+		printk(KERN_ERR DRV_NAME ": "
+			"Error while parsing device node resource\n");
+		printk(KERN_ERR DRV_NAME ": "
+			"Zone may not be properly released\n");
+	} else
+		release_mem_region(res_mem.start, sizeof(struct mpc52xx_ata));
+
+	irq_dispose_mapping(priv->ata_irq);
+
+	kfree(priv);
+
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+
+static int
+mpc52xx_ata_suspend(struct of_device *op, pm_message_t state)
+{
+	return 0;	/* FIXME : What to do here ? */
+}
+
+static int
+mpc52xx_ata_resume(struct of_device *op)
+{
+	return 0;	/* FIXME : What to do here ? */
+}
+
+#endif
+
+
+static struct of_device_id mpc52xx_ata_of_match[] = {
+	{
+		.compatible = "mpc5200-ata",
+	},
+	{
+		.compatible = "mpc52xx-ata",
+	},
+	{},
+};
+
+
+static struct of_platform_driver mpc52xx_ata_of_platform_driver = {
+	.owner		= THIS_MODULE,
+	.name		= DRV_NAME,
+	.match_table	= mpc52xx_ata_of_match,
+	.probe		= mpc52xx_ata_probe,
+	.remove		= mpc52xx_ata_remove,
+#ifdef CONFIG_PM
+	.suspend	= mpc52xx_ata_suspend,
+	.resume		= mpc52xx_ata_resume,
+#endif
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+
+/* ======================================================================== */
+/* Module                                                                   */
+/* ======================================================================== */
+
+static int __init
+mpc52xx_ata_init(void)
+{
+	printk(KERN_INFO "ata: MPC52xx IDE/ATA libata driver\n");
+	return of_register_platform_driver(&mpc52xx_ata_of_platform_driver);
+}
+
+static void __exit
+mpc52xx_ata_exit(void)
+{
+	of_unregister_platform_driver(&mpc52xx_ata_of_platform_driver);
+}
+
+module_init(mpc52xx_ata_init);
+module_exit(mpc52xx_ata_exit);
+
+MODULE_AUTHOR("Sylvain Munaut <tnt@246tNt.com>");
+MODULE_DESCRIPTION("Freescale MPC52xx IDE/ATA libata driver");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, mpc52xx_ata_of_match);
+MODULE_VERSION(DRV_VERSION);
+
diff --git a/drivers/ata/pata_serverworks.c b/drivers/ata/pata_serverworks.c
index f02b6a3..8019197 100644
--- a/drivers/ata/pata_serverworks.c
+++ b/drivers/ata/pata_serverworks.c
@@ -559,7 +559,7 @@ static int serverworks_reinit_one(struct pci_dev *pdev)
 {
 	/* Force master latency timer to 64 PCI clocks */
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
-	
+
 	switch (pdev->device)
 	{
 		case PCI_DEVICE_ID_SERVERWORKS_OSB4IDE:
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 32cf0bf..ae07f63 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -270,7 +270,7 @@ static struct ata_port_operations sil680_port_ops = {
  *	is powered up on boot and when we resume in case we resumed from RAM.
  *	Returns the final clock settings.
  */
- 
+
 static u8 sil680_init_chip(struct pci_dev *pdev)
 {
 	u32 class_rev	= 0;
diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 916cedb..c434c4e 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -847,7 +847,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct sis_chipset *chipset = NULL;
 
 	static struct sis_chipset sis_chipsets[] = {
-	
+
 		{ 0x0968, &sis_info133 },
 		{ 0x0966, &sis_info133 },
 		{ 0x0965, &sis_info133 },
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index cc09d47..9905fa8 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -384,11 +384,11 @@ static struct ata_port_operations via_port_ops_noirq = {
 static void via_config_fifo(struct pci_dev *pdev, unsigned int flags)
 {
 	u8 enable;
-	
+
 	/* 0x40 low bits indicate enabled channels */
 	pci_read_config_byte(pdev, 0x40 , &enable);
 	enable &= 3;
-	
+
 	if (flags & VIA_SET_FIFO) {
 		u8 fifo_setting[4] = {0x00, 0x60, 0x00, 0x20};
 		u8 fifo;
@@ -509,7 +509,7 @@ static int via_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Initialise the FIFO for the enabled channels. */
 	via_config_fifo(pdev, config->flags);
-	
+
 	/* Clock set up */
 	switch(config->flags & VIA_UDMA) {
 		case VIA_UDMA_NONE:
@@ -568,7 +568,7 @@ static int via_reinit_one(struct pci_dev *pdev)
 	u32 timing;
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	const struct via_isa_bridge *config = host->private_data;
-	
+
 	via_config_fifo(pdev, config->flags);
 
 	if ((config->flags & VIA_UDMA) == VIA_UDMA_66) {
@@ -583,7 +583,7 @@ static int via_reinit_one(struct pci_dev *pdev)
 		timing &= ~0x80008;
 		pci_write_config_dword(pdev, 0x50, timing);
 	}
-	return ata_pci_device_resume(pdev);	
+	return ata_pci_device_resume(pdev);
 }
 
 static const struct pci_device_id via[] = {
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 3ea345c..cd5560f 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -5,7 +5,7 @@
  *    Support for the Winbond 83759A when operating in advanced mode.
  *    Multichip mode is not currently supported.
  */
- 
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -69,7 +69,7 @@ static void winbond_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	int timing = 0x88 + (ap->port_no * 4) + (adev->devno * 2);
 
 	reg = winbond_readcfg(winbond->config, 0x81);
-	
+
 	/* Get the timing data in cycles */
 	if (reg & 0x40)		/* Fast VLB bus, assume 50MHz */
 		ata_timing_compute(adev, adev->pio_mode, &t, 20000, 1000);
@@ -80,9 +80,9 @@ static void winbond_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	recovery = (FIT(t.recover, 1, 15) + 1) & 0x0F;
 	timing = (active << 4) | recovery;
 	winbond_writecfg(winbond->config, timing, reg);
-	
+
 	/* Load the setup timing */
-	
+
 	reg = 0x35;
 	if (adev->class != ATA_DEV_ATA)
 		reg |= 0x08;	/* FIFO off */
@@ -194,13 +194,13 @@ static __init int winbond_init_one(unsigned long port)
 	winbond_writecfg(port, 0x85, reg);
 
 	reg = winbond_readcfg(port, 0x81);
-	
+
 	if (!(reg & 0x03))		/* Disabled */
 		return 0;
 
 	for (i = 0; i < 2 ; i ++) {
 
-		if (reg & (1 << i)) {		
+		if (reg & (1 << i)) {
 			/*
 			 *	Fill in a probe structure first of all
 			 */
@@ -217,7 +217,7 @@ static __init int winbond_init_one(unsigned long port)
 			ae.pio_mask = 0x1F;
 
 			ae.sht = &winbond_sht;
-	
+
 			ae.n_ports = 1;
 			ae.irq = 14 + i;
 			ae.irq_flags = 0;
@@ -257,7 +257,7 @@ static __init int winbond_init(void)
 
 	int ct = 0;
 	int i;
-	
+
 	if (probe_winbond == 0)
 		return -ENODEV;
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 0d316eb..49f8ff2 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -536,7 +536,7 @@ static void nv_adma_mode(struct ata_port *ap)
 
 	if (!(pp->flags & NV_ADMA_PORT_REGISTER_MODE))
 		return;
-		
+
 	WARN_ON(pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE);
 
 	tmp = readw(mmio + NV_ADMA_CTL);
@@ -576,7 +576,7 @@ static int nv_adma_slave_config(struct scsi_device *sdev)
 		/* Subtract 1 since an extra entry may be needed for padding, see
 		   libata-scsi.c */
 		sg_tablesize = LIBATA_MAX_PRD - 1;
-		
+
 		/* Since the legacy DMA engine is in use, we need to disable ADMA
 		   on the port. */
 		adma_enable = 0;
@@ -588,7 +588,7 @@ static int nv_adma_slave_config(struct scsi_device *sdev)
 		sg_tablesize = NV_ADMA_SGTBL_TOTAL_LEN;
 		adma_enable = 1;
 	}
-	
+
 	pci_read_config_dword(pdev, NV_MCP_SATA_CFG_20, &current_reg);
 
 	if(ap->port_no == 1)
@@ -597,7 +597,7 @@ static int nv_adma_slave_config(struct scsi_device *sdev)
 	else
 		config_mask = NV_MCP_SATA_CFG_20_PORT0_EN |
 			      NV_MCP_SATA_CFG_20_PORT0_PWB_EN;
-	
+
 	if(adma_enable) {
 		new_reg = current_reg | config_mask;
 		pp->flags &= ~NV_ADMA_ATAPI_SETUP_COMPLETE;
@@ -606,10 +606,10 @@ static int nv_adma_slave_config(struct scsi_device *sdev)
 		new_reg = current_reg & ~config_mask;
 		pp->flags |= NV_ADMA_ATAPI_SETUP_COMPLETE;
 	}
-	
+
 	if(current_reg != new_reg)
 		pci_write_config_dword(pdev, NV_MCP_SATA_CFG_20, new_reg);
-	
+
 	blk_queue_bounce_limit(sdev->request_queue, bounce_limit);
 	blk_queue_segment_boundary(sdev->request_queue, segment_boundary);
 	blk_queue_max_hw_segments(sdev->request_queue, sg_tablesize);
@@ -822,13 +822,13 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
 			handled++; /* irq handled if we got here */
 		}
 	}
-	
+
 	if(notifier_clears[0] || notifier_clears[1]) {
 		/* Note: Both notifier clear registers must be written
 		   if either is set, even if one is zero, according to NVIDIA. */
-		writel(notifier_clears[0], 
+		writel(notifier_clears[0],
 			nv_adma_notifier_clear_block(host->ports[0]));
-		writel(notifier_clears[1], 
+		writel(notifier_clears[1],
 			nv_adma_notifier_clear_block(host->ports[1]));
 	}
 
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 9c25a1e..c90fb13 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -42,7 +42,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_sis"
-#define DRV_VERSION	"0.6"
+#define DRV_VERSION	"0.7"
 
 enum {
 	sis_180			= 0,
@@ -67,9 +67,12 @@ static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id sis_pci_tbl[] = {
-	{ PCI_VDEVICE(SI, 0x180), sis_180 },
-	{ PCI_VDEVICE(SI, 0x181), sis_180 },
-	{ PCI_VDEVICE(SI, 0x182), sis_180 },
+	{ PCI_VDEVICE(SI, 0x0180), sis_180 },		/* SiS 964/180 */
+	{ PCI_VDEVICE(SI, 0x0181), sis_180 },		/* SiS 964/180 */
+	{ PCI_VDEVICE(SI, 0x0182), sis_180 },		/* SiS 965/965L */
+	{ PCI_VDEVICE(SI, 0x0183), sis_180 },		/* SiS 965/965L */
+	{ PCI_VDEVICE(SI, 0x1182), sis_180 },		/* SiS 966/966L */
+	{ PCI_VDEVICE(SI, 0x1183), sis_180 },		/* SiS 966/966L */
 
 	{ }	/* terminate list */
 };
@@ -142,24 +145,32 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg, int device)
+static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg, struct pci_dev *pdev)
 {
 	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
 
 	if (port_no)  {
-		if (device == 0x182)
-			addr += SIS182_SATA1_OFS;
-		else
-			addr += SIS180_SATA1_OFS;
+		switch (pdev->device) {
+			case 0x0180:
+			case 0x0181:
+				addr += SIS180_SATA1_OFS;
+				break;
+
+			case 0x0182:
+			case 0x0183:
+			case 0x1182:
+			case 0x1183:
+				addr += SIS182_SATA1_OFS;
+				break;
+		}
 	}
-
 	return addr;
 }
 
 static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev->device);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev);
 	u32 val, val2 = 0;
 	u8 pmr;
 
@@ -170,7 +181,8 @@ static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 
 	pci_read_config_dword(pdev, cfg_addr, &val);
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
 
 	return (val|val2) &  0xfffffffb; /* avoid problems with powerdowned ports */
@@ -179,7 +191,7 @@ static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev->device);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev);
 	u8 pmr;
 
 	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
@@ -189,7 +201,8 @@ static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 
 	pci_write_config_dword(pdev, cfg_addr, val);
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 		pci_write_config_dword(pdev, cfg_addr+0x10, val);
 }
 
@@ -209,7 +222,8 @@ static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
 
 	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+	if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+	    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
 
 	return (val | val2) &  0xfffffffb;
@@ -229,7 +243,8 @@ static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 		sis_scr_cfg_write(ap, sc_reg, val);
 	else {
 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
-		if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+		if ((pdev->device == 0x0182) || (pdev->device == 0x0183) || (pdev->device == 0x1182) ||
+		    (pdev->device == 0x1183) || (pmr & SIS_PMR_COMBINED))
 			outl(val, ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
 	}
 }
@@ -243,7 +258,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ata_port_info pi = sis_port_info, *ppi[2] = { &pi, &pi };
 	int pci_dev_busy = 0;
 	u8 pmr;
-	u8 port2_start;
+	u8 port2_start = 0x20;
 
 	if (!printed_version++)
 		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
@@ -282,28 +297,42 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-	if (ent->device != 0x182) {
+	switch (ent->device) {
+	case 0x0180:
+	case 0x0181:
 		if ((pmr & SIS_PMR_COMBINED) == 0) {
 			dev_printk(KERN_INFO, &pdev->dev,
 				   "Detected SiS 180/181/964 chipset in SATA mode\n");
 			port2_start = 64;
-		}
-		else {
+		} else {
 			dev_printk(KERN_INFO, &pdev->dev,
 				   "Detected SiS 180/181 chipset in combined mode\n");
 			port2_start=0;
 			pi.flags |= ATA_FLAG_SLAVE_POSS;
 		}
-	}
-	else {
+		break;
+
+	case 0x0182:
+	case 0x0183:
 		pci_read_config_dword ( pdev, 0x6C, &val);
 		if (val & (1L << 31)) {
 			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182/965 chipset\n");
 			pi.flags |= ATA_FLAG_SLAVE_POSS;
-		}
-		else
+		} else {
 			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 182/965L chipset\n");
-		port2_start = 0x20;
+		}
+		break;
+
+	case 0x1182:
+	case 0x1183:
+		pci_read_config_dword(pdev, 0x64, &val);
+		if (val & 0x10000000) {
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966L SATA controller\n");
+		} else {
+			dev_printk(KERN_INFO, &pdev->dev, "Detected SiS 1182/1183/966 SATA controller\n");
+			pi.flags |= ATA_FLAG_SLAVE_POSS;
+		}
+		break;
 	}
 
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index db32d15..d89c959 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -56,6 +56,8 @@
 #define DRV_VERSION	"2.0"
 
 enum {
+	K2_FLAG_NO_ATAPI_DMA		= (1 << 29),
+
 	/* Taskfile registers offsets */
 	K2_SATA_TF_CMD_OFFSET		= 0x00,
 	K2_SATA_TF_DATA_OFFSET		= 0x00,
@@ -83,11 +85,33 @@ enum {
 
 	/* Port stride */
 	K2_SATA_PORT_OFFSET		= 0x100,
+
+	board_svw4			= 0,
+	board_svw8			= 1,
+};
+
+static const struct k2_board_info {
+	unsigned int		n_ports;
+	unsigned long		port_flags;
+} k2_board_info[] = {
+	/* board_svw4 */
+	{ 4, K2_FLAG_NO_ATAPI_DMA },
+
+	/* board_svw8 */
+	{ 8, K2_FLAG_NO_ATAPI_DMA },
 };
 
 static u8 k2_stat_check_status(struct ata_port *ap);
 
 
+static int k2_sata_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	if (qc->ap->flags & K2_FLAG_NO_ATAPI_DMA)
+		return -1;	/* ATAPI DMA not supported */
+
+	return 0;
+}
+
 static u32 k2_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)
@@ -313,6 +337,7 @@ static const struct ata_port_operations k2_sata_ops = {
 	.check_status		= k2_stat_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
+	.check_atapi_dma	= k2_sata_check_atapi_dma,
 	.bmdma_setup		= k2_bmdma_setup_mmio,
 	.bmdma_start		= k2_bmdma_start_mmio,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -359,6 +384,8 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
 	void __iomem *mmio_base;
+	const struct k2_board_info *board_info =
+			&k2_board_info[ent->driver_data];
 	int pci_dev_busy = 0;
 	int rc;
 	int i;
@@ -424,7 +451,7 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 
 	probe_ent->sht = &k2_sata_sht;
 	probe_ent->port_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				ATA_FLAG_MMIO;
+				ATA_FLAG_MMIO | board_info->port_flags;
 	probe_ent->port_ops = &k2_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
@@ -441,7 +468,7 @@ static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *e
 	/* different controllers have different number of ports - currently 4 or 8 */
 	/* All ports are on the same function. Multi-function device is no
 	 * longer available. This should not be seen in any system. */
-	for (i = 0; i < ent->driver_data; i++)
+	for (i = 0; i < board_info->n_ports; i++)
 		k2_sata_setup_port(&probe_ent->port[i], base + i * K2_SATA_PORT_OFFSET);
 
 	pci_set_master(pdev);
@@ -469,11 +496,11 @@ err_out:
  * controller
  * */
 static const struct pci_device_id k2_sata_pci_tbl[] = {
-	{ PCI_VDEVICE(SERVERWORKS, 0x0240), 4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0241), 4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0242), 8 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024a), 4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024b), 4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0240), board_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0241), board_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0242), board_svw8 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024a), board_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024b), board_svw4 },
 
 	{ }
 };
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 1c7f19a..8c2335c 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -319,7 +319,7 @@ static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
 {
 	struct ata_probe_ent *probe_ent;
 	struct ata_port_info *ppi[2];
-	
+
 	ppi[0] = ppi[1] = &vt6420_port_info;
 	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ab27548..9356322 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -307,7 +307,7 @@ enum {
 	 * most devices.
 	 */
 	ATA_SPINUP_WAIT		= 8000,
-	
+
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependant */
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 95c1e74..ff9e6d3 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1621,6 +1621,7 @@
 #define PCI_VENDOR_ID_ITE		0x1283
 #define PCI_DEVICE_ID_ITE_8211		0x8211
 #define PCI_DEVICE_ID_ITE_8212		0x8212
+#define PCI_DEVICE_ID_ITE_8213		0x8213
 #define PCI_DEVICE_ID_ITE_8872		0x8872
 #define PCI_DEVICE_ID_ITE_IT8330G_0	0xe886
 

--------------010209020902070405050708--
