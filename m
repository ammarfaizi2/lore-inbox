Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTEXTkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 15:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbTEXTkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 15:40:24 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:2708
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263993AbTEXTiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 15:38:17 -0400
Date: Sat, 24 May 2003 15:51:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: [RFR] a new SCSI driver
Message-ID: <20030524195123.GA8394@gtf.org>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all.

My little project is now ready to face the masses.  Put simply, this
driver allows one to present ATA (and soon ATAPI) devices through
the Linux SCSI layer.

Since we already have an ATA (a.k.a. IDE) driver, I suppose the main
question on a lot of people's minds is "why?"  So I present some quick
notes, in bullet form, that can form the basis of discussion.

Review is requested by all interested:  driver authors, SCSI mavens,
ATA mavens, whatever.

I request that people try to avoid this posting devolving into an
ata-versus-scsi flamewar.  Maybe I can defuse that before the fact, by
saying:  "when in doubt, use drivers/ide."

So let's begin...  comments and questions welcome!


Why SCSI?
---------

* Many of the advantages are derived the existence of the scsi
  mid-layer.  It does a lot of work on our behalf, allowing me
  to focus on the ATA command protocols (PIO-in, PIO-out, DMA,
  etc.) almost exclusively.

* The SCSI mid-layer has shrunk and benefitted a lot from Axboe's
  block layer work.  It's much more lightweight in 2.5.x.

* Serial ATA is looming quickly on the horizon.  Both device and host
  controller SATA implementations really lend themselves to behaviors
  that have existed in SCSI for a while.  SATA even defines use of SCSI
  Enclosure Services.

* The Linux SCSI layer handles hotplugging, and is more modular.
  It already has refcounted devices and sysfs and such.  Creating a
  new block device driver from scratch means handling all those
  little details.

* SCSI has been doing basic error recovery and queue control for a
  while now.  Upcoming SATA2 will benefit greatly from this, as well
  ATA TCQ if I ever get around to implementing the latter.

* ATAPI is SCSI-like.

* Note that PATA in my driver is only an afterthought.  The main
  area of focus, now and in the future, is SATA.  It has strict
  PATA device and host controller restrictions: must do UDMA, LBA,
  be at least ATA-3, etc.  See "when in doubt..." statement above :)


Build notes
-----------

* Patch below requires you move drivers/scsi/{scsi,hosts,scsi_obsolete}.h
  to include/linux/scsi_{defs,hosts,obsolete}.h in order to build.
  These changes are present in the FTP site patches and BK repos, but
  are not included below to save space.  They are obvious changes that
  can even be recreated by hand.

* You should disable CONFIG_IDE.  Both drivers should request_region
  properly, but if you're not careful the IDE driver will grab the
  hardware before my driver does.


Testing status
--------------

* SATA stressed with iozone, bonnie, dbench, and some proprietary stress
  tools, on multiple boxes.

* PATA stressed similarly, on one box.


Near-future directions
----------------------

* ATAPI (see below)

* libata.c DMA and taskfile handling is still host-controller specific.
  It's the most widely used host controller standard, sure.  But that
  mainly applies to PATA devices.

  Future host controllers, with a tiny additional bit of
  abstracting-out, will simply ignore these functions (provided as
  defaults for most host controllers) and use their own.

* Better error handling (see below), and more command queueing work


ATA notes
---------

* Supports max UDMA/33 for PATA right now.  Temporary limitation because
  I'm too slack to worry about cable detection.

* No packet command -- yet.  And thus, no ATAPI cdroms/burners/etc.
  Coming soon!

* Does polling PIO in a kthread.  Watch katad chew up CPU.

ATA hardware notes
------------------

* Intentionally concentrated on modern hardware:  mainly SATA,
  with a little bit of PATA thrown in when convenient.

* Only supports Intel PATA and SATA right now

* Code is structured such that DMA engine and command queueing engine
  can be replaced by different hardware.  Next hardware driver will
  demonstrate this.


SCSI protocol notes
-------------------

* claims compliance with latest scsi3 standards (sam3, spc3, sbc2).
  bug reports in spec compliance are welcome.


Resources
---------

* BitKeeper for 2.4.x and 2.5.x:

	bk://kernel.bkbits.net/jgarzik/atascsi-2.4
	bk://kernel.bkbits.net/jgarzik/atascsi-2.5

* Patchkits for 2.4.x and 2.5.x:

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.21-rc3-atascsi1.patch.bz2
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.69-bk17-atascsi1.patch.bz2


Open issues (currently being addressed)
---------------------------------------

* ATAPI.  FWIW, yes, I do know that ATAPI is "SCSI-like" and not 100%
  conformant SCSI.

* Error handling.  VERY primitive right now.  Handling of errors is
  often "we'll stop talking to the device forever".  Hey, it's better than
  data corruption.  :)


Kudos (in alpha order for fairness :))
--------------------------------------

* Jens Axboe, for tons of block layer knowledge and general reality
  checks.

* James Bottomley, for patiently answering a lot of my SCSI questions.

* Alan Cox, for key inspirational ideas.

* Andre Hedrick, for tons of ATA knowledge.  I've soaked up a ton of
  time talking ATA with him, for which I'll be forever grateful.

* Lots of people on IRC and linux-scsi for helpful answers and
  suggestions.

* myself, for progressing quite a bit on one of my Big Projects To Do
  Before I Die.





drivers/scsi/Kconfig    |   27 
drivers/scsi/Makefile   |    1 
drivers/scsi/ata_piix.c |  312 ++++++
drivers/scsi/libata.c   | 2239 ++++++++++++++++++++++++++++++++++++++++++++++++
include/linux/ata.h     |  483 ++++++++++
5 files changed, 3062 insertions(+)




diff -Nru a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	Sat May 24 14:36:45 2003
+++ b/drivers/scsi/Kconfig	Sat May 24 14:36:45 2003
@@ -400,6 +400,33 @@
 	  say M here and read <file:Documentation/modules.txt>.  The module
 	  will be called megaraid.
 
+config SCSI_ATA
+	bool "ATA support (EXPERIMENTAL)"
+	depends on SCSI && EXPERIMENTAL
+	help
+	  This driver family supports ATA host controllers and devices
+	  (a.k.a. IDE drives).
+
+	  If unsure, say N.
+
+config SCSI_ATA_PATA
+	bool "Parallel ATA support (EXPERIMENTAL)"
+	depends on SCSI_ATA && EXPERIMENTAL
+	help
+	  This option enables support for parallel ATA host controllers.
+
+	  If unsure, say N.
+
+config SCSI_ATA_PIIX
+	tristate "Intel PIIX/ICH PATA/SATA support"
+	depends on SCSI_ATA && PCI
+	help
+	  This option enables support for ICH5 Serial ATA.
+	  If PATA support was enabled previously, this enables
+	  support for select Intel PIIX/ICH PATA host controllers.
+
+	  If unsure, say N.
+
 config SCSI_BUSLOGIC
 	tristate "BusLogic SCSI support"
 	depends on SCSI
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	Sat May 24 14:36:45 2003
+++ b/drivers/scsi/Makefile	Sat May 24 14:36:45 2003
@@ -113,6 +113,7 @@
 obj-$(CONFIG_SCSI_CPQFCTS)	+= cpqfc.o
 obj-$(CONFIG_SCSI_LASI700)	+= lasi700.o 53c700.o
 obj-$(CONFIG_SCSI_NSP32)	+= nsp32.o
+obj-$(CONFIG_SCSI_ATA_PIIX)	+= ata_piix.o libata.o
 
 obj-$(CONFIG_ARM)		+= arm/
 
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/scsi/ata_piix.c	Sat May 24 14:36:45 2003
@@ -0,0 +1,312 @@
+/*
+	Copyright 2003 Red Hat Inc
+	Copyright 2003 Jeff Garzik
+
+
+	Copyright header from piix.c:
+
+    Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
+    Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
+    Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
+
+    May be copied or modified under the terms of the GNU General Public License
+
+
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ata.h>
+
+#define DRV_NAME	"ata_piix"
+#define DRV_VERSION	"0.9 "	/* must be exactly four chars */
+
+enum {
+	ICH5_PCS		= 0x92,	/* port control and status */
+
+	ich5_pata		= 0,
+	ich5_sata		= 1,
+	piix4_pata		= 2,
+};
+
+static int __devinit piix_init_one (struct pci_dev *pdev,
+				    const struct pci_device_id *ent);
+static void piix_port_probe(struct ata_host *ah);
+static void piix_port_disable(struct ata_host *ah);
+static void piix_set_piomode (struct ata_host *ah, struct ata_device *adev,
+			      unsigned int pio);
+static void piix_set_udmamode (struct ata_host *ah, struct ata_device *adev,
+			       unsigned int udma);
+
+static unsigned int in_module_init = 1;
+
+static struct pci_device_id piix_pci_tbl[] __devinitdata = {
+	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix4_pata },
+	{ 0x8086, 0x24db, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_pata },
+
+	{ 0x8086, 0x24d1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich5_sata },
+
+	{ }	/* terminate list */
+};
+
+struct pci_driver piix_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= piix_pci_tbl,
+	.probe			= piix_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static Scsi_Host_Template piix_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.detect			= ata_scsi_detect,
+	.release		= ata_scsi_release,
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
+};
+
+struct ata_board ata_board_tbl[] __devinitdata = {
+	/* ich5_pata */
+	{
+		.sht		= &piix_sht,
+		.pio_mask	= 0x03,	/* pio3-4 */
+		.udma_mask	= 0x07,	/* udma0-2 ; FIXME */
+	},
+
+	/* ich5_sata */
+	{
+		.sht		= &piix_sht,
+		.host_flags	= ATA_FLAG_SATA,
+		.pio_mask	= 0x03,	/* pio3-4 */
+		.udma_mask	= 0x3f,	/* udma0-5 ; FIXME */
+	},
+
+	/* piix4_pata */
+	{
+		.sht		= &piix_sht,
+		.pio_mask	= 0x03, /* pio3-4 */
+		.udma_mask	= 0x07,	/* udma0-2 ; FIXME */
+	},
+};
+
+struct ata_host_ops piix_pata_ops = {
+	.port_probe		= ata_port_probe,
+	.port_disable		= ata_port_disable,
+	.set_piomode		= piix_set_piomode,
+	.set_udmamode		= piix_set_udmamode,
+};
+
+struct ata_host_ops piix_sata_ops = {
+	.port_probe		= piix_port_probe,
+	.port_disable		= piix_port_disable,
+	.set_piomode		= piix_set_piomode,
+	.set_udmamode		= piix_set_udmamode,
+};
+
+MODULE_AUTHOR("Andre Hedrick, Alan Cox, Andrzej Krzysztofowicz, Jeff Garzik");
+MODULE_DESCRIPTION("SCSI low-level driver for Intel PIIX/ICH ATA controllers");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
+
+static void piix_port_probe(struct ata_host *ah)
+{
+	u16 pcs;
+	struct pci_dev *pdev = ah->host_set->pdev;
+
+	pci_read_config_word(pdev, ICH5_PCS, &pcs);
+
+	/* if port not enabled, exit */
+	if ((pcs & (1 << ah->port_no)) == 0) {
+		ata_port_disable(ah);
+		DPRINTK("port %d disabled, ignoring\n", ah->port_no);
+		return;
+	}
+
+	/* if port enabled but no device, disable port and exit */
+	if ((pcs & (1 << (ah->port_no + 4))) == 0) {
+		pcs &= ~(1 << ah->port_no);
+		pci_write_config_word(pdev, ICH5_PCS, pcs);
+
+		ata_port_disable(ah);
+		DPRINTK("port %d has no dev, disabling\n", ah->port_no);
+		return;
+	}
+
+	ata_port_probe(ah);
+}
+
+static void piix_port_disable(struct ata_host *ah)
+{
+	struct pci_dev *pdev = ah->host_set->pdev;
+	u16 pcs;
+
+	ata_port_disable(ah);
+
+	pci_read_config_word(pdev, ICH5_PCS, &pcs);
+
+	if (pcs & (1 << ah->port_no)) {
+		pcs &= ~(1 << ah->port_no);
+		pci_write_config_word(pdev, ICH5_PCS, pcs);
+	}
+}
+
+static void piix_set_piomode (struct ata_host *ah, struct ata_device *adev,
+			      unsigned int pio)
+{
+	struct pci_dev *dev	= ah->host_set->pdev;
+	unsigned int is_slave	= (adev->flags & ATA_DFLAG_MASTER) ? 0 : 1;
+	unsigned int master_port= ah->port_no ? 0x42 : 0x40;
+	unsigned int slave_port	= 0x44;
+	u16 master_data;
+	u8 slave_data;
+			 /* ISP  RTC */
+	u8 timings[][2]	= { { 0, 0 },
+			    { 0, 0 },
+			    { 1, 0 },
+			    { 2, 1 },
+			    { 2, 3 }, };
+
+	pci_read_config_word(dev, master_port, &master_data);
+	if (is_slave) {
+		master_data |= 0x4000;
+		/* enable PPE, IE and TIME */
+		master_data |= 0x0070;
+		pci_read_config_byte(dev, slave_port, &slave_data);
+		slave_data &= (ah->port_no ? 0x0f : 0xf0);
+		slave_data |=
+			(timings[pio][0] << 2) |
+			(timings[pio][1] << (ah->port_no ? 4 : 0));
+	} else {
+		master_data &= 0xccf8;
+		/* enable PPE, IE and TIME */
+		master_data |= 0x0007;
+		master_data |=
+			(timings[pio][0] << 12) |
+			(timings[pio][1] << 8);
+	}
+	pci_write_config_word(dev, master_port, master_data);
+	if (is_slave)
+		pci_write_config_byte(dev, slave_port, slave_data);
+}
+
+static void piix_set_udmamode (struct ata_host *ah, struct ata_device *adev,
+			      unsigned int udma)
+{
+	struct pci_dev *dev	= ah->host_set->pdev;
+	u8 maslave		= ah->port_no ? 0x42 : 0x40;
+	u8 speed		= udma;
+	unsigned int drive_dn	= (ah->port_no ? 2 : 0) + adev->devno;
+	int a_speed		= 3 << (drive_dn * 4);
+	int u_flag		= 1 << drive_dn;
+	int v_flag		= 0x01 << drive_dn;
+	int w_flag		= 0x10 << drive_dn;
+	int u_speed		= 0;
+	int			sitre;
+	u16			reg4042, reg44, reg48, reg4a, reg54;
+	u8			reg55;
+
+	pci_read_config_word(dev, maslave, &reg4042);
+	DPRINTK("reg4042 = 0x%04x\n", reg4042);
+	sitre = (reg4042 & 0x4000) ? 1 : 0;
+	pci_read_config_word(dev, 0x44, &reg44);
+	pci_read_config_word(dev, 0x48, &reg48);
+	pci_read_config_word(dev, 0x4a, &reg4a);
+	pci_read_config_word(dev, 0x54, &reg54);
+	pci_read_config_byte(dev, 0x55, &reg55);
+
+	switch(speed) {
+		case XFER_UDMA_4:
+		case XFER_UDMA_2:	u_speed = 2 << (drive_dn * 4); break;
+		case XFER_UDMA_6:
+		case XFER_UDMA_5:
+		case XFER_UDMA_3:
+		case XFER_UDMA_1:	u_speed = 1 << (drive_dn * 4); break;
+		case XFER_UDMA_0:	u_speed = 0 << (drive_dn * 4); break;
+		default:
+			BUG();
+			return;
+	}
+
+	if (!(reg48 & u_flag))
+		pci_write_config_word(dev, 0x48, reg48|u_flag);
+	if (speed == XFER_UDMA_5) {
+		pci_write_config_byte(dev, 0x55, (u8) reg55|w_flag);
+	} else {
+		pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
+	}
+	if (!(reg4a & u_speed)) {
+		pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
+		pci_write_config_word(dev, 0x4a, reg4a|u_speed);
+	}
+	if (speed > XFER_UDMA_2) {
+		if (!(reg54 & v_flag)) {
+			pci_write_config_word(dev, 0x54, reg54|v_flag);
+		}
+	} else {
+		pci_write_config_word(dev, 0x54, reg54 & ~v_flag);
+	}
+}
+
+static int __devinit piix_init_one (struct pci_dev *pdev,
+				    const struct pci_device_id *ent)
+{
+	struct ata_board *board_info = &ata_board_tbl[ent->driver_data];
+	unsigned is_sata = board_info->host_flags & ATA_FLAG_SATA;
+	static int printed_version;
+
+	if (!printed_version++)
+		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+
+	/* no hotplugging support (FIXME) */
+	if (!in_module_init)
+		return -ENODEV;
+
+	return ata_pci_init_one(pdev, board_info,
+				is_sata ? &piix_sata_ops : &piix_pata_ops);
+}
+
+static int __init piix_init(void)
+{
+	int rc;
+
+	DPRINTK("pci_module_init\n");
+	rc = pci_module_init(&piix_pci_driver);
+	if (rc)
+		return rc;
+
+	in_module_init = 0;
+
+	DPRINTK("scsi_register_host\n");
+	rc = scsi_register_host(&piix_sht);
+	if (rc) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+
+	DPRINTK("done\n");
+	return 0;
+
+err_out:
+	pci_unregister_driver(&piix_pci_driver);
+	return rc;
+}
+
+static void __exit piix_exit(void)
+{
+	scsi_unregister_host(&piix_sht);
+	pci_unregister_driver(&piix_pci_driver);
+}
+
+module_init(piix_init);
+module_exit(piix_exit);
+
diff -Nru a/drivers/scsi/libata.c b/drivers/scsi/libata.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/scsi/libata.c	Sat May 24 14:36:45 2003
@@ -0,0 +1,2239 @@
+/*
+   Copyright 2003 Red Hat, Inc.  All rights reserved.
+   Copyright 2003 Jeff Garzik
+
+   The contents of this file are subject to the Open
+   Software License version 1.1 that can be found at
+   http://www.opensource.org/licenses/osl-1.1.txt and is included herein
+   by reference.
+
+   Alternatively, the contents of this file may be used under the terms
+   of the GNU General Public License version 2 (the "GPL") as distributed
+   in the kernel source COPYING file, in which case the provisions of
+   the GPL are applicable instead of the above.  If you wish to allow
+   the use of your version of this file only under the terms of the
+   GPL and not to allow others to use your version of this file under
+   the OSL, indicate your decision by deleting the provisions above and
+   replace them with the notice and other provisions required by the GPL.
+   If you do not delete the provisions above, a recipient may use your
+   version of this file under either the OSL or the GPL.
+
+
+   TODO:
+	ATAPI.
+	ATAPI error handling.
+	Better ATA error handling.
+	request_region for legacy ATA ISA addresses.
+	scsi SYNCHRONIZE CACHE and associated mode page
+	other minor items, too many to list
+	replace THR_*_POLL states with calls to a poll function
+	use set-mult-mode/rw mult for faster PIO
+
+
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/ata.h>
+#include <scsi/scsi.h>
+#include <asm/io.h>
+#include <asm/semaphore.h>
+
+#include <linux/scsi_defs.h>
+#include <linux/scsi_hosts.h>
+
+#define DRV_NAME	"libata"
+#define DRV_VERSION	"0.51"	/* must be exactly four chars */
+
+struct ata_scsi_args {
+	struct ata_host		*ah;
+	struct ata_device	*dev;
+	Scsi_Cmnd		*cmd;
+	void			(*done)(Scsi_Cmnd *);
+};
+
+static void ata_to_sense_error(struct ata_queued_cmd *qc, Scsi_Cmnd *cmd);
+static void ata_scsi_badcmd(Scsi_Cmnd *cmd,
+			    void (*done)(Scsi_Cmnd *),
+			    u8 asc, u8 ascq);
+
+static unsigned int ata_unique_id = 1;
+static LIST_HEAD(ata_probe_list);
+static LIST_HEAD(ata_scsihost_list);
+static spinlock_t ata_module_lock = SPIN_LOCK_UNLOCKED;
+
+MODULE_AUTHOR("Jeff Garzik");
+MODULE_DESCRIPTION("Library module for running ATA devices underneath SCSI");
+MODULE_LICENSE("GPL");
+
+static const char * thr_state_name[] = {
+	"THR_UNKNOWN",
+	"THR_CHECKPORT",
+	"THR_EDD",
+	"THR_AWAIT_DEATH",
+	"THR_IDENTIFY",
+	"THR_CONFIG_PIO",
+	"THR_CONFIG_DMA",
+	"THR_PROBE_FAILED",
+	"THR_IDLE",
+	"THR_PROBE_SUCCESS",
+	"THR_PROBE_START",
+	"THR_CONFIG_FORCE_PIO",
+	"THR_PIO_POLL",
+	"THR_PIO_TMOUT",
+	"THR_PIO",
+	"THR_PIO_LAST",
+	"THR_PIO_LAST_POLL",
+	"THR_PIO_ERR",
+};
+
+static const char *ata_thr_state_name(unsigned int thr_state)
+{
+	if (thr_state < ARRAY_SIZE(thr_state_name))
+		return thr_state_name[thr_state];
+	return "<invalid THR_xxx state>";
+}
+
+static void msleep(unsigned long msecs)
+{
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(msecs_to_jiffies(msecs));
+}
+
+static void __ata_tf_to_host(struct ata_ioports *ioaddr,
+			     struct ata_taskfile *tf)
+{
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+
+	outb(tf->ctl, ioaddr->ctl_addr);
+
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		outb(tf->hob_feature, ioaddr->cmd_addr + ATA_REG_FEATURE);
+		outb(tf->hob_nsect, ioaddr->cmd_addr + ATA_REG_NSECT);
+		outb(tf->hob_lbal, ioaddr->cmd_addr + ATA_REG_LBAL);
+		outb(tf->hob_lbam, ioaddr->cmd_addr + ATA_REG_LBAM);
+		outb(tf->hob_lbah, ioaddr->cmd_addr + ATA_REG_LBAH);
+		DPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
+
+	if (is_addr) {
+		outb(tf->feature, ioaddr->cmd_addr + ATA_REG_FEATURE);
+		outb(tf->nsect, ioaddr->cmd_addr + ATA_REG_NSECT);
+		outb(tf->lbal, ioaddr->cmd_addr + ATA_REG_LBAL);
+		outb(tf->lbam, ioaddr->cmd_addr + ATA_REG_LBAM);
+		outb(tf->lbah, ioaddr->cmd_addr + ATA_REG_LBAH);
+		DPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		outb(tf->device, ioaddr->cmd_addr + ATA_REG_DEVICE);
+		DPRINTK("device 0x%X\n", tf->device);
+	}
+
+	ata_wait_idle(ioaddr);
+}
+
+static inline void ata_exec(struct ata_host *ah, struct ata_taskfile *tf,
+			   unsigned int bus_state)
+{
+	unsigned long flags;
+
+	DPRINTK("command 0x%X\n", tf->command);
+	spin_lock_irqsave(&ah->host_set->lock, flags);
+	ah->bus_state = bus_state;
+	outb(tf->command, ah->ioaddr.cmd_addr + ATA_REG_CMD);
+	ndelay(400);
+	spin_unlock_irqrestore(&ah->host_set->lock, flags);
+}
+
+static void ata_tf_to_host(struct ata_host *ah, struct ata_taskfile *tf,
+			   unsigned int bus_state)
+{
+	init_MUTEX_LOCKED(&ah->sem);
+
+	__ata_tf_to_host(&ah->ioaddr, tf);
+
+	ata_exec(ah, tf, bus_state);
+}
+
+static void ata_tf_from_host(struct ata_ioports *ioaddr,
+			     struct ata_taskfile *tf)
+{
+	if (tf->flags & ATA_TFLAG_DATAREG) {
+		u16 data = inw(ioaddr->cmd_addr + ATA_REG_DATA);
+		tf->data = data & 0xff;
+		tf->hob_data = data >> 8;
+	}
+
+	tf->nsect = inb(ioaddr->cmd_addr + ATA_REG_NSECT);
+	tf->lbal = inb(ioaddr->cmd_addr + ATA_REG_LBAL);
+	tf->lbam = inb(ioaddr->cmd_addr + ATA_REG_LBAM);
+	tf->lbah = inb(ioaddr->cmd_addr + ATA_REG_LBAH);
+	tf->device = inb(ioaddr->cmd_addr + ATA_REG_DEVICE);
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		outb(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
+		tf->hob_feature = inb(ioaddr->cmd_addr + ATA_REG_FEATURE);
+		tf->hob_nsect = inb(ioaddr->cmd_addr + ATA_REG_NSECT);
+		tf->hob_lbal = inb(ioaddr->cmd_addr + ATA_REG_LBAL);
+		tf->hob_lbam = inb(ioaddr->cmd_addr + ATA_REG_LBAM);
+		tf->hob_lbah = inb(ioaddr->cmd_addr + ATA_REG_LBAH);
+	}
+}
+
+static const char * udma_str[] = {
+	"UDMA/16",
+	"UDMA/25",
+	"UDMA/33",
+	"UDMA/44",
+	"UDMA/66",
+	"UDMA/100",
+	"UDMA/133",
+	"UDMA7",
+};
+
+static const char *ata_udma_string(unsigned int udma_mask)
+{
+	unsigned int i;
+
+	for (i = 7; i >= 0; i--) {
+		if (udma_mask & (1 << i))
+			return udma_str[i];
+	}
+
+	return "<n/a>";
+}
+
+static unsigned int ata_dev_classify(struct ata_taskfile *tf)
+{
+	/* Apple's open source Darwin code hints that some devices only
+	 * put a proper signature into the LBA mid/high registers,
+	 * So, we only check those.  It's sufficient for uniqueness.
+	 */
+
+	if (((tf->lbam == 0) && (tf->lbah == 0)) ||
+	    ((tf->lbam == 0x3c) && (tf->lbah == 0xc3))) {
+		DPRINTK("found ATA device by sig\n");
+		return ATA_DEV_ATA;
+	}
+
+	if (((tf->lbam == 0x14) && (tf->lbah == 0xeb)) ||
+	    ((tf->lbam == 0x69) && (tf->lbah == 0x96))) {
+		DPRINTK("found ATAPI device by sig\n");
+		return ATA_DEV_ATAPI;
+	}
+
+	DPRINTK("unknown device\n");
+	return ATA_DEV_UNKNOWN;
+}
+
+static unsigned int ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+				      unsigned int ofs, unsigned int len)
+{
+	unsigned int c, ret = 0;
+
+	while (len > 0) {
+		c = dev->id[ofs] >> 8;
+		*s = c;
+		s++;
+
+		ret = c = dev->id[ofs] & 0xff;
+		*s = c;
+		s++;
+
+		ofs++;
+		len -= 2;
+	}
+
+	return ret;
+}
+
+static void ata_dev_parse_strings(struct ata_device *dev)
+{
+	if (dev->class == ATA_DEV_ATA)
+		memcpy(dev->vendor, "ATA     ", 8);
+	else if (dev->class == ATA_DEV_ATAPI)
+		memcpy(dev->vendor, "ATAPI   ", 8);
+	else
+		memcpy(dev->vendor, "Unknown ", 8);
+
+	ata_dev_id_string(dev, dev->product, ATA_ID_PROD_OFS,
+			  sizeof(dev->product));
+}
+
+static u8 ata_dev_select(struct ata_host *ah, unsigned int device,
+			   unsigned int unconditional, unsigned int islba)
+{
+	struct ata_ioports *ioaddr = &ah->ioaddr;
+	u8 tmp, newtmp;
+
+	newtmp = tmp = inb(ioaddr->cmd_addr + ATA_REG_DEVICE);
+
+	if (device == 0) {
+		newtmp = tmp & ~ATA_DEV1;
+	} else {
+		newtmp = tmp | ATA_DEV1;
+	}
+	newtmp |= ATA_DEVICE_OBS;
+	if (islba)
+		newtmp |= ATA_LBA;
+
+	if (unconditional || (tmp != newtmp)) {
+		outb(newtmp, ioaddr->cmd_addr + ATA_REG_DEVICE);
+		ah->devsel = newtmp;
+		tmp = ata_wait_idle(&ah->ioaddr);
+		DPRINTK("selected dev using Device 0x%X, drv_stat 0x%X\n",
+			newtmp, tmp);
+	} else {
+		DPRINTK("Using cached Device reg, 0x%X\n", (u32) tmp);
+	}
+
+	assert(ah->bus_state == BUS_IDLE);
+
+	return tmp;
+}
+
+static inline void ata_dump_id(struct ata_device *dev)
+{
+	DPRINTK("49==0x%04x  "
+		"53==0x%04x  "
+		"63==0x%04x  "
+		"64==0x%04x  "
+		"75==0x%04x  \n",
+		dev->id[49],
+		dev->id[53],
+		dev->id[63],
+		dev->id[64],
+		dev->id[75]);
+	DPRINTK("80==0x%04x  "
+		"81==0x%04x  "
+		"82==0x%04x  "
+		"83==0x%04x  "
+		"84==0x%04x  \n",
+		dev->id[80],
+		dev->id[81],
+		dev->id[82],
+		dev->id[83],
+		dev->id[84]);
+	DPRINTK("88==0x%04x  "
+		"93==0x%04x\n",
+		dev->id[88],
+		dev->id[93]);
+}
+
+static void ata_dev_identify(struct ata_host *ah, unsigned int device)
+{
+	struct ata_device *dev = &ah->device[device];
+	unsigned int i;
+	u16 tmp;
+	u8 status;
+	struct ata_taskfile tf;
+
+	if (!ata_dev_present(dev)) {
+		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
+			ah->id, device);
+		return;
+	}
+
+	DPRINTK("ENTER, host %u, dev %u\n", ah->id, device);
+
+	if (dev->class == ATA_DEV_UNKNOWN)
+		BUG();
+	if (device > ATA_MAX_DEVICES)
+		BUG();
+	if (device > 1)
+		BUG();
+
+	ata_dev_select(ah, device, 0, 0); /* select device 0/1 */
+
+	ata_tf_init(ah, &tf);
+
+	if (dev->class == ATA_DEV_ATA)
+		tf.command = ATA_CMD_ID_ATA;
+	else
+		tf.command = ATA_CMD_ID_ATAPI;
+
+	DPRINTK("do identify\n");
+	ata_tf_to_host(ah, &tf, BUS_IDENTIFY);
+
+	/* wait for completion or timeout */
+	DPRINTK("completion wait\n");
+	down(&ah->sem);
+	DPRINTK("end wait\n");
+
+	assert(ah->bus_state == BUS_PIO);
+
+	/* make sure we have BSY=0, DRQ=1 */
+	status = ata_busy_wait(&ah->ioaddr, ATA_BUSY, 1000);
+	assert (((status & ATA_BUSY) == 0) && (status & ATA_DRQ));
+
+	/* read IDENTIFY [X] DEVICE page */
+	for (i = 0; i < ATA_ID_WORDS; i++)
+		dev->id[i] = inw(ah->ioaddr.cmd_addr + ATA_REG_DATA);
+
+	/* wait for host_idle */
+	status = ata_wait_idle(&ah->ioaddr);
+	if (status & (ATA_BUSY | ATA_DRQ)) {
+		DPRINTK("abormal status 2, 0x%X\n", status);
+		goto err_out;
+	}
+
+	ah->bus_state = BUS_IDLE;
+
+	if (dev->class == ATA_DEV_ATA) {
+		ata_dump_id(dev);
+
+		if (!ata_id_is_ata(dev))	/* sanity check */
+			goto err_out_nosup;
+
+		if (ata_id_has_lba48(dev)) {
+			dev->flags |= ATA_DFLAG_LBA48;
+			dev->n_sectors = ata_id_u64(dev, 100);
+		} else {
+			dev->n_sectors = ata_id_u32(dev, 60);
+		}
+
+		/* we require LBA and DMA support (bits 8 & 9 of word 49) */
+		if (!ata_id_has_dma(dev) || !ata_id_has_lba(dev))
+			goto err_out_nosup;
+
+		ata_dev_parse_strings(dev);
+
+		tmp = dev->id[ATA_ID_MAJOR_VER];
+		for (i = 14; i >= 1; i--)
+			if (tmp & (1 << i))
+				break;
+
+		/* we require at least ATA-3 */
+		if (i < 3)
+			goto err_out_nosup;
+
+		/* we require UDMA support */
+		tmp = dev->id[ATA_ID_UDMA_MODES];
+		if ((tmp & 0xff) == 0)
+			goto err_out_nosup;
+
+		/* print device info to dmesg */
+		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors\n",
+		       ah->id, device,
+		       ata_udma_string(tmp),
+		       dev->n_sectors);
+	} else {
+		/* we require UDMA support */
+		tmp = dev->id[ATA_ID_UDMA_MODES];
+		if ((tmp & 0xff) == 0)
+			goto err_out_nosup;
+
+		/* print device info to dmesg */
+		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
+		       ah->id, device,
+		       ata_udma_string(tmp));
+	}
+
+	DPRINTK("EXIT\n");
+	return;
+
+err_out_nosup:
+	printk(KERN_WARNING "ata%u: dev %u not supported, ignoring\n",
+	       ah->id, device);
+err_out:
+	dev->class = ATA_DEV_NONE;
+	DPRINTK("EXIT, err\n");
+}
+
+void ata_port_probe(struct ata_host *ah)
+{
+	ah->flags &= ~ATA_FLAG_PORT_DISABLED;
+}
+
+void ata_port_disable(struct ata_host *ah)
+{
+	ah->device[0].class = ATA_DEV_NONE;
+	ah->device[1].class = ATA_DEV_NONE;
+	ah->flags |= ATA_FLAG_PORT_DISABLED;
+}
+
+static unsigned int ata_bus_reset(struct ata_host *ah)
+{
+	unsigned int slave_possible = ah->flags & ATA_FLAG_SLAVE_POSS;
+	struct ata_taskfile tf;
+	u8 err, devsel, status;
+	unsigned int rc = 0;
+
+	DPRINTK("ENTER, host %u, port %u\n", ah->id, ah->port_no);
+
+	DPRINTK("irq toggle\n");
+	ata_irq_on(ah);		/* make sure interrupts are enabled */
+
+	/* set up execute-device-diag (bus reset) taskfile */
+	DPRINTK("execute-device-diag\n");
+	ata_tf_init(ah, &tf);
+	tf.command = ATA_CMD_EDD;
+
+	/* do bus reset */
+	ata_tf_to_host(ah, &tf, BUS_EDD);
+
+	/* wait for completion or timeout */
+	DPRINTK("EDD completion wait\n");
+	down(&ah->sem);
+	DPRINTK("EDD end wait, bus_idle: %s\n",
+		(ah->bus_state == BUS_IDLE) ? "YES" : "NO");
+
+	/* select device 0 */
+	devsel = ata_dev_select(ah, 0, 1, 0);
+
+	/* read back results of E.D.D. */
+	status = ata_chk_status(&ah->ioaddr);
+	err = inb(ah->ioaddr.cmd_addr + ATA_REG_ERR);
+
+	if ((devsel == 0xff) && (err == 0xff) && (status == 0xff)) {
+		ah->ops->port_disable(ah);
+		rc = 0;
+		goto out;
+	}
+
+	ah->device[1].class = ATA_DEV_NONE;
+
+	/* spec says 01h or 81h indicates device 0 passed diags */
+	DPRINTK("err register == 0x%X\n", err);
+	if ((err == 0x01) || (err == 0x81)) {
+		ata_tf_from_host(&ah->ioaddr, &tf);
+		ah->device[0].class = ata_dev_classify(&tf);
+
+		/* check for invalid signature */
+		if (ah->device[0].class == ATA_DEV_UNKNOWN) {
+			rc = 1;
+			goto out;
+		}
+
+		/* exit now if device 1 is absent/failed as well */
+		if ((!slave_possible) || (err == 0x81))
+			goto out;
+	} else {
+		/* no device 0 exists (or device 0 failed diags) */
+		ah->device[0].class = ATA_DEV_NONE;
+
+		/* exit now if device 1 is absent as well */
+		if ((!slave_possible) || (err == 0x80) ||
+		    ((err >= 0x82) && (err <= 0xff)))
+			goto out;
+	}
+
+	/* if we reach this point, we _might_ have a device 1 */
+	/* FIXME (PATA only case, so we put it off until later) */
+
+out:
+	DPRINTK("EXIT, returning %u\n", rc);
+	return rc;
+}
+
+static void ata_host_set_pio(struct ata_host *ah)
+{
+	struct ata_device *master, *slave;
+	unsigned int pio, i;
+	u16 mask;
+
+	master = &ah->device[0];
+	slave = &ah->device[1];
+
+	assert (ata_dev_present(master) || ata_dev_present(slave));
+
+	mask = ah->pio_mask;
+	if (ata_dev_present(master))
+		mask &= (master->id[ATA_ID_PIO_MODES] & 0x03);
+	if (ata_dev_present(slave))
+		mask &= (slave->id[ATA_ID_PIO_MODES] & 0x03);
+
+	/* require pio mode 3 or 4 support for host and all devices */
+	if (mask == 0) {
+		printk(KERN_WARNING "ata%u: no PIO3/4 support, ignoring\n",
+		       ah->id);
+		goto err_out;
+	}
+
+	pio = (mask & ATA_ID_PIO4) ? 4 : 3;
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (ata_dev_present(&ah->device[i])) {
+			ah->device[i].pio_mode = (pio == 3) ?
+				XFER_PIO_3 : XFER_PIO_4;
+			ah->ops->set_piomode(ah, &ah->device[i], pio);
+		}
+
+	return;
+
+err_out:
+	ah->ops->port_disable(ah);
+}
+
+static void ata_host_set_udma(struct ata_host *ah)
+{
+	struct ata_device *master, *slave;
+	u16 mask;
+	unsigned int i, j;
+	int udma_mode = -1;
+
+	master = &ah->device[0];
+	slave = &ah->device[1];
+
+	assert (ata_dev_present(master) || ata_dev_present(slave));
+	assert ((ah->flags & ATA_FLAG_PORT_DISABLED) == 0);
+
+	DPRINTK("udma masks: host 0x%X, master 0x%X, slave 0x%X\n",
+		ah->udma_mask,
+		(!ata_dev_present(master)) ? 0xff :
+			(master->id[ATA_ID_UDMA_MODES] & 0xff),
+		(!ata_dev_present(slave)) ? 0xff :
+			(slave->id[ATA_ID_UDMA_MODES] & 0xff));
+
+	mask = ah->udma_mask;
+	if (ata_dev_present(master))
+		mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
+	if (ata_dev_present(slave))
+		mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
+
+	i = XFER_UDMA_7;
+	while (i >= XFER_UDMA_0) {
+		j = i - XFER_UDMA_0;
+		DPRINTK("mask 0x%X i 0x%X j %u\n", mask, i, j);
+		if (mask & (1 << j)) {
+			udma_mode = i;
+			break;
+		}
+
+		i--;
+	}
+
+	/* require udma for host and all attached devices */
+	if (udma_mode < 0) {
+		printk(KERN_WARNING "ata%u: no UltraDMA support, ignoring\n",
+		       ah->id);
+		goto err_out;
+	}
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (ata_dev_present(&ah->device[i])) {
+			ah->device[i].udma_mode = udma_mode;
+			ah->ops->set_udmamode(ah, &ah->device[i], udma_mode);
+		}
+
+	return;
+
+err_out:
+	ah->ops->port_disable(ah);
+}
+
+static void ata_dev_set_xfermode(struct ata_host *ah, struct ata_device *dev)
+{
+	struct ata_taskfile tf;
+
+	/* set up set-features taskfile */
+	DPRINTK("set features - xfer mode\n");
+	ata_tf_init(ah, &tf);
+	tf.command = ATA_CMD_SET_FEATURES;
+	tf.feature = SETFEATURES_XFER;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	if (dev->flags & ATA_DFLAG_PIO)
+		tf.nsect = dev->pio_mode;
+	else
+		tf.nsect = dev->udma_mode;
+
+	/* do bus reset */
+	ata_tf_to_host(ah, &tf, BUS_NODATA);
+
+	/* wait for completion or timeout */
+	DPRINTK("SETFEATURES completion wait\n");
+	down(&ah->sem);
+	DPRINTK("SETFEATURES end wait\n");
+
+	assert(ah->bus_state == BUS_IDLE);
+
+	ata_wait_idle(&ah->ioaddr);
+
+	DPRINTK("EXIT\n");
+}
+
+static void ata_dev_set_udma(struct ata_host *ah, unsigned int device)
+{
+	struct ata_device *dev = &ah->device[device];
+
+	if (!ata_dev_present(dev) || (ah->flags & ATA_FLAG_PORT_DISABLED))
+		return;
+
+	ata_dev_set_xfermode(ah, dev);
+
+	assert((dev->udma_mode >= XFER_UDMA_0) &&
+	       (dev->udma_mode <= XFER_UDMA_7));
+	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
+	       ah->id, device,
+	       udma_str[dev->udma_mode - XFER_UDMA_0]);
+}
+
+static void ata_dev_set_pio(struct ata_host *ah, unsigned int device)
+{
+	struct ata_device *dev = &ah->device[device];
+
+	if (!ata_dev_present(dev) || (ah->flags & ATA_FLAG_PORT_DISABLED))
+		return;
+
+	/* force PIO mode */
+	dev->flags |= ATA_DFLAG_PIO;
+
+	ata_dev_set_xfermode(ah, dev);
+
+	assert((dev->pio_mode >= XFER_PIO_3) &&
+	       (dev->pio_mode <= XFER_PIO_4));
+	printk(KERN_INFO "ata%u: dev %u configured for PIO%c\n",
+	       ah->id, device,
+	       dev->pio_mode == 3 ? '3' : '4');
+}
+
+static void ata_sg_clean(struct ata_host *ah, struct ata_queued_cmd *qc)
+{
+	Scsi_Cmnd *cmd = qc->scsicmd;
+	struct scatterlist *sg;
+	unsigned int dma = (qc->flags & ATA_QCFLAG_DMA);
+
+#ifndef ATA_DEBUG
+	if (!dma)
+		return;
+#endif
+
+	sg = (struct scatterlist *)qc->scsicmd->request_buffer;
+
+#if defined(ATA_DEBUG) && defined(ATA_READ_POISON)
+	{
+	unsigned int i, j, match;
+	unsigned char *p;
+
+	for (i = 0; i < qc->n_elem; i++) {
+		match = 1;
+		p = sg[i].address;
+		for (j = 0; j < sg[i].length; j++)
+			if (p[j] != 0xfb) {
+				match = 0;
+				break;
+			}
+		if (match)
+			DPRINTK("PRD[%u] STILL POISONED\n", i);
+	}
+
+	}
+#endif
+
+	if (dma) {
+		int dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+
+		DPRINTK("unmapping %u sg elements\n", qc->n_elem);
+
+		pci_unmap_sg(ah->host_set->pdev, sg, qc->n_elem, dir);
+	}
+}
+
+static int ata_sg_setup(struct ata_host *ah, struct ata_queued_cmd *qc)
+{
+	Scsi_Cmnd *cmd = qc->scsicmd;
+	struct scatterlist *sg;
+	int n_elem;
+	unsigned int i;
+	unsigned int dma = (qc->flags & ATA_QCFLAG_DMA);
+#if defined(ATA_DEBUG) && defined(ATA_READ_POISON)
+	unsigned int rw = (qc->flags & ATA_QCFLAG_WRITE);
+#endif
+
+	VPRINTK("ENTER, ata%u, use_sg %d\n", ah->id, cmd->use_sg);
+	assert(cmd->use_sg > 0);
+
+	sg = (struct scatterlist *)cmd->request_buffer;
+	if (dma) {
+		int dir = scsi_to_pci_dma_dir(cmd->sc_data_direction);
+		n_elem = pci_map_sg(ah->host_set->pdev, sg, cmd->use_sg, dir);
+		if (n_elem < 1)
+			return -1;
+		DPRINTK("%d sg elements mapped\n", n_elem);
+	} else {
+		n_elem = cmd->use_sg;
+	}
+	qc->n_elem = n_elem;
+
+
+#ifndef ATA_DEBUG
+	if (!dma)
+		return 0;
+#endif
+
+	for (i = 0; i < n_elem; i++) {
+#if defined(ATA_DEBUG) && defined(ATA_READ_POISON)
+		if (!rw)
+			memset(sg[i].address, 0xfb, sg[i].length);
+#endif
+		ah->prd[i].addr = cpu_to_le32(sg[i].dma_address);
+		ah->prd[i].flags_len = cpu_to_le32(sg[i].length);
+		DPRINTK("PRD[%u] = (0x%X, 0x%X)\n",
+			i, ah->prd[i].addr, ah->prd[i].flags_len);
+	}
+	ah->prd[n_elem - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+
+#ifdef ATA_DEBUG
+	i = n_elem - 1;
+	DPRINTK("PRD[%u] = (0x%X, 0x%X)\n",
+		i, ah->prd[i].addr, ah->prd[i].flags_len);
+
+	for (i = n_elem; i < ATA_MAX_PRD; i++) {
+		ah->prd[i].addr = 0;
+		ah->prd[i].flags_len = cpu_to_le32(ATA_PRD_EOT);
+	}
+#endif
+
+	return 0;
+}
+
+static unsigned long ata_pio_poll(struct ata_host *ah)
+{
+	u8 status;
+	unsigned int poll_state = THR_UNKNOWN;
+	unsigned int reg_state = THR_UNKNOWN;
+	const unsigned int tmout_state = THR_PIO_TMOUT;
+
+	switch (ah->thr_state) {
+	case THR_PIO:
+	case THR_PIO_POLL:
+		poll_state = THR_PIO_POLL;
+		reg_state = THR_PIO;
+		break;
+	case THR_PIO_LAST:
+	case THR_PIO_LAST_POLL:
+		poll_state = THR_PIO_LAST_POLL;
+		reg_state = THR_PIO_LAST;
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	status = ata_chk_status(&ah->ioaddr);
+	if (status & ATA_BUSY) {
+		if (time_after(jiffies, ah->thr_timeout)) {
+			ah->thr_state = tmout_state;
+			return 0;
+		}
+		ah->thr_state = poll_state;
+		return ATA_SHORT_PAUSE;
+	}
+
+	ah->thr_state = reg_state;
+	return 0;
+}
+
+static void ata_pio_start (struct ata_host *ah, struct ata_queued_cmd *qc)
+{
+	/* FIXME: support TCQ */
+	qc->tf.ctl |= ATA_NIEN;	/* disable interrupts */
+	ata_tf_to_host(ah, &qc->tf, BUS_PIO);
+	assert(ah->thr_state == THR_IDLE);
+	ah->thr_state = THR_PIO;
+	up(&ah->thr_sem);
+}
+
+static void ata_pio_complete (struct ata_host *ah)
+{
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	u8 drv_stat;
+	
+	/*
+	 * This is purely hueristic.  This is a fast path.
+	 * Sometimes when we enter, BSY will be cleared in
+	 * a chk-status or two.  If not, the drive is probably seeking
+	 * or something.  Snooze for a couple msecs, then
+	 * chk-status again.  If still busy, fall back to
+	 * THR_PIO_POLL state.
+	 */
+	drv_stat = ata_busy_wait(&ah->ioaddr, ATA_BUSY | ATA_DRQ, 10);
+	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+		msleep(2);
+		drv_stat = ata_busy_wait(&ah->ioaddr, ATA_BUSY | ATA_DRQ, 10);
+		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+			ah->thr_state = THR_PIO_LAST_POLL;
+			ah->thr_timeout = jiffies + ATA_TMOUT_PIO;
+			return;
+		}
+	}
+
+	drv_stat = ata_wait_idle(&ah->ioaddr);
+	if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
+		ah->thr_state = THR_PIO_ERR;
+		return;
+	}
+
+	/* FIXME: support TCQ */
+	qc = &ah->qcmd[0];
+
+	ata_sg_clean(ah, qc);
+
+	qc->flags &= ~ATA_QCFLAG_ACTIVE;
+	ah->thr_state = THR_IDLE;
+
+	spin_lock_irqsave(&ah->host_set->lock, flags);
+	assert(ah->bus_state == BUS_PIO);
+	ah->bus_state = BUS_IDLE;
+	spin_unlock_irqrestore(&ah->host_set->lock, flags);
+
+	ata_irq_on(ah);
+
+	if (drv_stat & ATA_ERR) {
+		ata_to_sense_error(qc, qc->scsicmd);
+	} else {
+		qc->scsicmd->result = SAM_STAT_GOOD;
+		qc->done(qc->scsicmd);
+	}
+}
+
+static void ata_pio_sector(struct ata_host *ah)
+{
+	struct ata_queued_cmd *qc;
+	struct scatterlist *sg;
+	Scsi_Cmnd *cmd;
+	void *kaddr;
+	unsigned char *buf;
+	u8 status;
+
+	assert(ah->bus_state == BUS_PIO);
+
+	/*
+	 * This is purely hueristic.  This is a fast path.
+	 * Sometimes when we enter, BSY will be cleared in
+	 * a chk-status or two.  If not, the drive is probably seeking
+	 * or something.  Snooze for a couple msecs, then
+	 * chk-status again.  If still busy, fall back to
+	 * THR_PIO_POLL state.
+	 */
+	status = ata_busy_wait(&ah->ioaddr, ATA_BUSY, 5);
+	if (status & ATA_BUSY) {
+		msleep(2);
+		status = ata_busy_wait(&ah->ioaddr, ATA_BUSY, 10);
+		if (status & ATA_BUSY) {
+			ah->thr_state = THR_PIO_POLL;
+			ah->thr_timeout = jiffies + ATA_TMOUT_PIO;
+			return;
+		}
+	}
+
+	/* handle BSY=0, DRQ=0 as error */
+	if ((status & ATA_DRQ) == 0) {
+		ah->thr_state = THR_PIO_ERR;
+		return;
+	}
+
+	/* FIXME: support TCQ */
+	qc = &ah->qcmd[0];
+	cmd = qc->scsicmd;
+	sg = (struct scatterlist *)cmd->request_buffer;
+	if (qc->cursect == (qc->nsect - 1))
+		ah->thr_state = THR_PIO_LAST;
+
+	kaddr = kmap(sg[qc->cursg].page);
+	buf = kaddr + sg[qc->cursg].offset + (qc->cursg_ofs * ATA_SECT_SIZE);
+
+	qc->cursect++;
+	qc->cursg_ofs++;
+	
+	if ((qc->cursg_ofs * ATA_SECT_SIZE) == sg[qc->cursg].length) {
+		qc->cursg++;
+		qc->cursg_ofs = 0;
+	}
+
+	DPRINTK("data %s, drv_stat 0x%X\n",
+		qc->flags & ATA_QCFLAG_WRITE ? "write" : "read",
+		status);
+
+	/* do the actual data transfer */
+	if (qc->flags & ATA_QCFLAG_WRITE)
+		outsl(ah->ioaddr.cmd_addr + ATA_REG_DATA, buf, ATA_SECT_DWORDS);
+	else
+		insl(ah->ioaddr.cmd_addr + ATA_REG_DATA, buf, ATA_SECT_DWORDS);
+
+	kunmap(sg[qc->cursg].page);
+}
+
+static void ata_dma_start (struct ata_host *ah, struct ata_queued_cmd *qc)
+{
+	unsigned int rw = (qc->flags & ATA_QCFLAG_WRITE);
+	u8 host_stat, dmactl;
+
+	/* load taskfile registers */
+	__ata_tf_to_host(&ah->ioaddr, &qc->tf);
+
+	/* load PRD table addr. */
+	outl(ah->prd_dma, ah->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
+
+	/* specify data direction */
+	/* FIXME: redundant to later start-dma command? */
+	ah->dmactl = rw ? 0 : ATA_DMA_WR;
+	outb(ah->dmactl, ah->ioaddr.bmdma_addr + ATA_DMA_CMD);
+
+	/* clear interrupt, error bits */
+	host_stat = inb(ah->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
+	     ah->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+
+	/* issue r/w command */
+	ata_exec(ah, &qc->tf, BUS_DMA);
+
+	/* start host DMA transaction */
+	dmactl = inb(ah->ioaddr.bmdma_addr + ATA_DMA_CMD);
+	outb(dmactl | ATA_DMA_START,
+	     ah->ioaddr.bmdma_addr + ATA_DMA_CMD);
+}
+
+static void ata_dma_complete(struct ata_host *ah, u8 host_stat,
+			     unsigned int err)
+{
+	struct ata_queued_cmd *qc;
+	u8 drv_stat;
+
+	VPRINTK("ENTER\n");
+
+	/* clear start/stop bit */
+	outb(0, ah->ioaddr.bmdma_addr + ATA_DMA_CMD);
+
+	/* get controller status; clear intr, err bits */
+	outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
+	     ah->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	inb(ah->ioaddr.ctl_addr);	/* dummy read */
+
+	/* get drive status; clear intr */
+	drv_stat = ata_wait_idle(&ah->ioaddr);
+
+	DPRINTK("host %u, host_stat==0x%X, drv_stat==0x%X\n",
+		ah->id, (u32) host_stat, (u32) drv_stat);
+
+	/* FIXME: support TCQ */
+	qc = &ah->qcmd[0];
+	if (!(qc->flags & ATA_QCFLAG_ACTIVE))
+		printk(KERN_ERR "ata%u: BUG: SCSI cmd not active\n", ah->id);
+	else {
+		ata_sg_clean(ah, qc);
+
+		if (err || (drv_stat & ATA_ERR)) {
+			ata_to_sense_error(qc, qc->scsicmd);
+		} else {
+			qc->scsicmd->result = SAM_STAT_GOOD;
+			qc->done(qc->scsicmd);
+		}
+
+		qc->flags &= ~ATA_QCFLAG_ACTIVE;
+	}
+}
+
+static inline unsigned int ata_host_intr (struct ata_host *ah)
+{
+	u8 status, host_stat;
+	unsigned int handled = 0;
+
+	switch (ah->bus_state) {
+	case BUS_NOINTR:	/* do nothing; (hopefully!) shared irq */
+	case BUS_IDLE:
+	case BUS_PIO:
+		ah->stats.idle_irq++;
+
+#ifdef ATA_IRQ_TRAP
+		if ((ah->stats.idle_irq % 1000) == 0) {
+			handled = 1;
+			ata_irq_ack(ah, 0); /* debug trap */
+			printk(KERN_WARNING "ata%d: irq trap\n", ah->id);
+		}
+#endif
+		break;
+
+	case BUS_DMA:
+		host_stat = inb(ah->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		DPRINTK("BUS_DMA (host_stat 0x%X)\n", host_stat);
+
+		if (!(host_stat & ATA_DMA_INTR)) {
+			ah->stats.idle_irq++;
+			break;
+		}
+
+		ata_dma_complete(ah, host_stat, 0);
+		ah->bus_state = BUS_IDLE;
+		handled = 1;
+		break;
+
+	case BUS_EDD:
+		status = ata_irq_ack(ah, 0);
+		DPRINTK("BUS_EDD (drv_stat 0x%X)\n", status);
+		if (status & ATA_BUSY)
+			DPRINTK("abnormal status 0x%X host_stat 0x%X\n",
+				status, inb(ah->ioaddr.bmdma_addr +
+					ATA_DMA_STATUS));
+		ah->bus_state = BUS_IDLE;
+		up(&ah->sem);
+		handled = 1;
+		break;
+
+	case BUS_NODATA:	/* command completion, but no data xfer */
+		status = ata_irq_ack(ah, 1);
+		DPRINTK("BUS_NODATA (drv_stat 0x%X)\n", status);
+		ah->bus_state = BUS_IDLE;
+		up(&ah->sem);
+		handled = 1;
+		break;
+
+	case BUS_IDENTIFY:
+		status = ata_irq_ack(ah, 0);
+		DPRINTK("BUS_IDENTIFY (drv_stat 0x%X)\n", status);
+		ah->bus_state = BUS_PIO;
+		up(&ah->sem);
+		handled = 1;
+		break;
+
+	default:
+		printk(KERN_DEBUG "ata%u: unhandled bus state %u\n",
+		       ah->id, ah->bus_state);
+		ah->stats.unhandled_irq++;
+
+#ifdef ATA_IRQ_TRAP
+		if ((ah->stats.unhandled_irq % 1000) == 0) {
+			handled = 1;
+			ata_irq_ack(ah, 0); /* debug trap */
+			printk(KERN_WARNING "ata%d: irq trap\n", ah->id);
+		}
+#endif
+		break;
+	}
+
+	return handled;
+}
+
+static irqreturn_t ata_interrupt (int irq, void *dev_instance,
+				  struct pt_regs *regs)
+{
+	struct ata_host_set *host_set = dev_instance;
+	unsigned int i;
+	unsigned int handled = 0;
+
+	spin_lock(&host_set->lock);
+
+	for (i = 0; i < host_set->n_hosts; i++) {
+		struct ata_host *ah;
+
+		ah = host_set->hosts[i];
+		if (ah && (!(ah->flags & ATA_FLAG_PORT_DISABLED)))
+			handled += ata_host_intr(ah);
+	}
+
+	spin_unlock(&host_set->lock);
+
+	return IRQ_RETVAL(handled);
+}
+
+static void ata_timer(struct ata_host *ah)
+{
+	unsigned long flags;
+	unsigned int bus_state;
+	u8 host_stat;
+
+	DPRINTK("ENTER\n");
+
+	spin_lock_irqsave(&ah->host_set->lock, flags);
+	bus_state = ah->bus_state;
+	ah->bus_state = BUS_TIMER;
+	spin_unlock_irqrestore(&ah->host_set->lock, flags);
+
+	switch (bus_state) {
+	case BUS_PIO:
+	case BUS_EDD:
+	case BUS_NODATA:
+		ata_wait_idle(&ah->ioaddr);
+		up(&ah->sem);
+		break;
+
+	case BUS_DMA:
+		printk(KERN_WARNING "ata%u: DMA timeout\n", ah->id);
+		host_stat = inb(ah->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+		ata_dma_complete(ah, host_stat, 1);
+		break;
+
+	default:
+		DPRINTK("unhandled bus state %u\n", bus_state);
+		break;
+	}
+
+	spin_lock_irqsave(&ah->host_set->lock, flags);
+	ah->bus_state = BUS_IDLE;
+	spin_unlock_irqrestore(&ah->host_set->lock, flags);
+	DPRINTK("EXIT\n");
+}
+
+static void ata_thread_timer(unsigned long opaque)
+{
+	struct ata_host *ah = (struct ata_host *) opaque;
+
+	up(&ah->thr_sem);
+}
+
+static unsigned long ata_thread_iter(struct ata_host *ah)
+{
+	long timeout = 0;
+
+	DPRINTK("ata%u: thr_state %s\n",
+		ah->id, ata_thr_state_name(ah->thr_state));
+
+	switch (ah->thr_state) {
+	case THR_UNKNOWN:
+		ah->thr_state = THR_CHECKPORT;
+		break;
+
+	case THR_PROBE_START:
+		down(&ah->sem);
+		ah->thr_state = THR_CHECKPORT;
+		break;
+
+	case THR_CHECKPORT:
+		ah->ops->port_probe(ah);
+		if (ah->flags & ATA_FLAG_PORT_DISABLED)
+			ah->thr_state = THR_PROBE_FAILED;
+		else
+			ah->thr_state = THR_EDD;
+		break;
+
+	case THR_EDD:
+		if ((ata_bus_reset(ah)) || (ah->flags & ATA_FLAG_PORT_DISABLED))
+			ah->thr_state = THR_PROBE_FAILED;
+		else
+			ah->thr_state = THR_IDENTIFY;
+		break;
+
+	case THR_IDENTIFY:
+		ata_dev_identify(ah, 0);
+		ata_dev_identify(ah, 1);
+
+		if (!ata_dev_present(&ah->device[0]) &&
+		    !ata_dev_present(&ah->device[1])) {
+			ah->ops->port_disable(ah);
+			ah->thr_state = THR_PROBE_FAILED;
+		} else
+			ah->thr_state = THR_CONFIG_PIO;
+		break;
+
+	case THR_CONFIG_PIO:
+		ata_host_set_pio(ah);
+		if (ah->flags & ATA_FLAG_PORT_DISABLED)
+			ah->thr_state = THR_PROBE_FAILED;
+		else
+#ifdef ATA_FORCE_PIO
+			ah->thr_state = THR_CONFIG_FORCE_PIO;
+#else
+			ah->thr_state = THR_CONFIG_DMA;
+#endif
+		break;
+
+	case THR_CONFIG_FORCE_PIO:
+		ata_dev_set_pio(ah, 0);
+		ata_dev_set_pio(ah, 1);
+
+		if (ah->flags & ATA_FLAG_PORT_DISABLED)
+			ah->thr_state = THR_PROBE_FAILED;
+		else
+			ah->thr_state = THR_PROBE_SUCCESS;
+		break;
+
+	case THR_CONFIG_DMA:
+		ata_host_set_udma(ah);
+		ata_dev_set_udma(ah, 0);
+		ata_dev_set_udma(ah, 1);
+
+		if (ah->flags & ATA_FLAG_PORT_DISABLED)
+			ah->thr_state = THR_PROBE_FAILED;
+		else
+			ah->thr_state = THR_PROBE_SUCCESS;
+		break;
+
+	case THR_PROBE_SUCCESS:
+		up(&ah->probe_sem);
+		ah->thr_state = THR_IDLE;
+		break;
+
+	case THR_PROBE_FAILED:
+		up(&ah->probe_sem);
+		ah->thr_state = THR_AWAIT_DEATH;
+		break;
+
+	case THR_AWAIT_DEATH:
+		timeout = -1;
+		break;
+
+	case THR_IDLE:
+		timeout = 30 * HZ;
+		break;
+
+	case THR_PIO:
+		ata_pio_sector(ah);
+		break;
+
+	case THR_PIO_LAST:
+		ata_pio_complete(ah);
+		break;
+
+	case THR_PIO_POLL:
+	case THR_PIO_LAST_POLL:
+		timeout = ata_pio_poll(ah);
+		break;
+
+	case THR_PIO_TMOUT:
+		printk(KERN_ERR "ata%d: FIXME: THR_PIO_TMOUT\n", /* FIXME */
+		       ah->id);
+		timeout = 11 * HZ;
+		break;
+
+	case THR_PIO_ERR:
+		printk(KERN_ERR "ata%d: FIXME: THR_PIO_ERR\n", /* FIXME */
+		       ah->id);
+		timeout = 11 * HZ;
+		break;
+
+	default:
+		DPRINTK("unknown thread state %u!\n", ah->thr_state);
+		break;
+	}
+
+	DPRINTK("ata%u: new thr_state %s, returning %ld\n",
+		ah->id, ata_thr_state_name(ah->thr_state), timeout);
+	return timeout;
+}
+
+static int ata_thread (void *data)
+{
+        struct ata_host *ah = data;
+	long timeout;
+
+	daemonize ("katad-%u", ah->id);
+	allow_signal(SIGTERM);
+
+        while (1) {
+		cond_resched();
+
+		timeout = ata_thread_iter(ah);
+
+                if (signal_pending (current))
+                        flush_signals(current);
+
+                if ((timeout < 0) || (ah->time_to_die))
+                        break;
+
+ 		/* note sleeping for full timeout not guaranteed (that's ok) */
+		if (timeout) {
+			mod_timer(&ah->thr_timer, jiffies + timeout);
+			down_interruptible(&ah->thr_sem);
+
+                	if (signal_pending (current))
+                        	flush_signals(current);
+
+                	if (ah->time_to_die)
+                        	break;
+		}
+        }
+
+	printk(KERN_INFO "ata%u: thread exiting\n", ah->id);
+	ah->thr_pid = -1;
+        complete_and_exit (&ah->thr_exited, 0);
+}
+
+static void ata_to_sense_error(struct ata_queued_cmd *qc, Scsi_Cmnd *cmd)
+{
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+	cmd->sense_buffer[0] = 0x70;
+	cmd->sense_buffer[2] = MEDIUM_ERROR;
+	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
+
+	/* additional-sense-code[-qualifier] */
+	if ((qc->flags & ATA_QCFLAG_WRITE) == 0) {
+		cmd->sense_buffer[12] = 0x11; /* "unrecovered read error" */
+		cmd->sense_buffer[13] = 0x04;
+	} else {
+		cmd->sense_buffer[12] = 0x0C; /* "write error -             */
+		cmd->sense_buffer[13] = 0x02; /*  auto-reallocation failed" */
+	}
+
+	qc->done(cmd);
+}
+
+int ata_scsi_error(struct Scsi_Host *host)
+{
+	struct ata_host *ah;
+	struct ata_queued_cmd *qc;
+	Scsi_Cmnd *cmd;
+
+	DPRINTK("ENTER\n");
+	ah = (struct ata_host *) &host->hostdata[0];
+
+	ata_timer(ah);
+
+	/* FIXME: support TCQ */
+	qc = &ah->qcmd[0];
+	if (qc->flags & ATA_QCFLAG_ACTIVE) {
+		DPRINTK("cancelling command\n");
+
+		ata_sg_clean(ah, qc);
+
+		cmd = qc->scsicmd;
+
+		/* FIXME: slackness!!  we just assume medium error */
+		ata_to_sense_error(qc, cmd);
+
+		qc->flags &= ~ATA_QCFLAG_ACTIVE;
+	}
+
+	DPRINTK("EXIT\n");
+	return 0;
+}
+
+static unsigned int scsi_rw_to_ata(struct ata_queued_cmd *qc, u8 *scsicmd,
+				   unsigned int cmd_size)
+{
+	struct ata_taskfile *tf = &qc->tf;
+	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+	unsigned int pio = tf->flags & ATA_TFLAG_PIO;
+
+	qc->cursect = qc->cursg = qc->cursg_ofs = 0;
+	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf->hob_nsect = 0;
+	tf->hob_lbal = 0;
+	tf->hob_lbam = 0;
+	tf->hob_lbah = 0;
+
+	if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
+	    scsicmd[0] == READ_16) {
+		if (pio) {
+			if (lba48)
+				tf->command = ATA_CMD_PIO_READ_EXT;
+			else
+				tf->command = ATA_CMD_PIO_READ;
+		} else {
+			if (lba48)
+				tf->command = ATA_CMD_READ_EXT;
+			else
+				tf->command = ATA_CMD_READ;
+		}
+		qc->flags &= ~ATA_QCFLAG_WRITE;
+		DPRINTK("reading\n");
+	} else {
+		if (pio) {
+			if (lba48)
+				tf->command = ATA_CMD_PIO_WRITE_EXT;
+			else
+				tf->command = ATA_CMD_PIO_WRITE;
+		} else {
+			if (lba48)
+				tf->command = ATA_CMD_WRITE_EXT;
+			else
+				tf->command = ATA_CMD_WRITE;
+		}
+		qc->flags |= ATA_QCFLAG_WRITE;
+		DPRINTK("writing\n");
+	}
+
+	if (cmd_size == 10) {
+		if (lba48) {
+			tf->hob_nsect = scsicmd[7];
+			tf->hob_lbal = scsicmd[2];
+
+			qc->nsect = ((unsigned int)scsicmd[7] << 8) |
+					scsicmd[8];
+		} else {
+			/* if we don't support LBA48 addressing, the request
+			 * -may- be too large. */
+			if ((scsicmd[2] & 0xf0) || scsicmd[7])
+				return 1;
+
+			/* stores LBA27:24 in lower 4 bits of device reg */
+			tf->device |= scsicmd[2];
+
+			qc->nsect = scsicmd[8];
+		}
+		tf->device |= ATA_LBA;
+
+		tf->nsect = scsicmd[8];
+		tf->lbal = scsicmd[5];
+		tf->lbam = scsicmd[4];
+		tf->lbah = scsicmd[3];
+
+		DPRINTK("ten-byte command\n");
+		return 0;
+	}
+
+	if (cmd_size == 6) {
+		qc->nsect = tf->nsect = scsicmd[4];
+		tf->lbal = scsicmd[3];
+		tf->lbam = scsicmd[2];
+		tf->lbah = scsicmd[1] & 0x1f; /* mask out reserved bits */
+
+		DPRINTK("six-byte command\n");
+		return 0;
+	}
+
+	if (cmd_size == 16) {
+		/* rule out impossible LBAs and sector counts */
+		if (scsicmd[2] || scsicmd[3] || scsicmd[10] || scsicmd[11])
+			return 1;
+
+		if (lba48) {
+			tf->hob_nsect = scsicmd[12];
+			tf->hob_lbal = scsicmd[6];
+			tf->hob_lbam = scsicmd[5];
+			tf->hob_lbah = scsicmd[4];
+
+			qc->nsect = ((unsigned int)scsicmd[12] << 8) |
+					scsicmd[13];
+		} else {
+			/* once again, filter out impossible non-zero values */
+			if (scsicmd[4] || scsicmd[5] || scsicmd[12] ||
+			    (scsicmd[6] & 0xf0))
+				return 1;
+
+			/* stores LBA27:24 in lower 4 bits of device reg */
+			tf->device |= scsicmd[2];
+
+			qc->nsect = scsicmd[13];
+		}
+		tf->device |= ATA_LBA;
+
+		tf->nsect = scsicmd[13];
+		tf->lbal = scsicmd[9];
+		tf->lbam = scsicmd[8];
+		tf->lbah = scsicmd[7];
+
+		DPRINTK("sixteen-byte command\n");
+		return 0;
+	}
+
+	DPRINTK("no-byte command\n");
+	return 1;
+}
+
+static void ata_do_rw(struct ata_host *ah, struct ata_device *dev,
+		      Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *),
+		      unsigned int cmd_size)
+{
+	struct ata_queued_cmd *qc;
+	u8 *scsicmd = cmd->cmnd;
+	unsigned int pio;
+
+	VPRINTK("ENTER\n");
+	/* FIXME: support TCQ */
+	qc = &ah->qcmd[0];
+	qc->flags = ATA_QCFLAG_ACTIVE;
+	qc->scsicmd = cmd;
+	qc->done = done;
+
+	ata_dev_select(ah, dev->devno, 0, 1);
+
+	ata_tf_init(ah, &qc->tf);
+	pio = (dev->flags & ATA_DFLAG_PIO);
+	if (pio)
+		qc->tf.flags |= ATA_TFLAG_PIO;
+	else
+		qc->flags |= ATA_QCFLAG_DMA;
+	if (scsi_rw_to_ata(qc, scsicmd, cmd_size))
+		goto err_out;
+
+	/* set up SG table */
+	if (cmd->use_sg) {
+		if (ata_sg_setup(ah, qc))
+			goto err_out;
+	} else {
+		printk(KERN_ERR "ata%u: BUG: cmd->use_sg == 0\n", ah->id);
+		goto err_out;
+	}
+
+	if (pio)
+		ata_pio_start(ah, qc);
+	else
+		ata_dma_start(ah, qc);
+
+	VPRINTK("EXIT\n");
+	return;
+
+err_out:
+	ata_scsi_badcmd(cmd, done, 0x24, 0x00);
+	DPRINTK("EXIT - badcmd\n");
+}
+
+static unsigned int ata_scsi_get_reqbuf(Scsi_Cmnd *cmd, u8 **buf_out)
+{
+	u8 *buf;
+	unsigned int buflen;
+
+	if (cmd->use_sg) {
+		struct scatterlist *sg;
+
+		sg = (struct scatterlist *) cmd->request_buffer;
+		buf = kmap(sg->page) + sg->offset;
+		buflen = sg->length;
+	} else {
+		buf = cmd->request_buffer;
+		buflen = cmd->request_bufflen;
+	}
+
+	memset(buf, 0, buflen);
+	*buf_out = buf;
+	return buflen;
+}
+
+static inline void ata_scsi_put_reqbuf(Scsi_Cmnd *cmd)
+{
+	if (cmd->use_sg) {
+		struct scatterlist *sg;
+
+		sg = (struct scatterlist *) cmd->request_buffer;
+		kunmap(sg->page);
+	}
+}
+
+static void ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *reqbuf,
+			       unsigned int buflen)
+{
+	VPRINTK("ENTER\n");
+
+	reqbuf[0] = TYPE_DISK;
+	reqbuf[2] = 0x5;	/* claim SPC-3 version compatibility */
+	reqbuf[3] = 2;
+	reqbuf[4] = 96 - 4;
+
+	if (buflen > 36) {
+		memcpy(&reqbuf[8], args->dev->vendor, 8);
+		memcpy(&reqbuf[16], args->dev->product, 16);
+		memcpy(&reqbuf[32], DRV_VERSION, 4);
+	}
+
+	if (buflen > 63) {
+		reqbuf[59] = 0x60;	/* SAM-3 (no version claimed) */
+
+		reqbuf[60] = 0x03;
+		reqbuf[61] = 0x20;	/* SBC-2 (no version claimed) */
+
+		reqbuf[62] = 0x02;
+		reqbuf[63] = 0x60;	/* SPC-3 (no version claimed) */
+	}
+}
+
+static void ata_scsiop_inq_00(struct ata_scsi_args *args, u8 *reqbuf,
+			      unsigned int buflen)
+{
+	reqbuf[3] = 3;		/* number of supported EVPD pages */
+
+	if (buflen > 6) {
+		reqbuf[4] = 0x00;	/* page 0x00, this page */
+		reqbuf[5] = 0x80;	/* page 0x80, unit serial no page */
+		reqbuf[6] = 0x83;	/* page 0x83, device ident page */
+	}
+}
+
+static void ata_scsiop_inq_80(struct ata_scsi_args *args, u8 *reqbuf,
+			      unsigned int buflen)
+{
+	reqbuf[1] = 0x80;			/* this page code */
+	reqbuf[3] = ATA_SERNO_LEN;		/* page len */
+
+	if (buflen > (ATA_SERNO_LEN + 4))
+		ata_dev_id_string(args->dev, (unsigned char *) &reqbuf[4],
+				  ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
+}
+
+static const char *inq_83_str = "Linux ATA-SCSI simulator";
+
+static void ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *reqbuf,
+			      unsigned int buflen)
+{
+	reqbuf[1] = 0x83;			/* this page code */
+	reqbuf[3] = 4 + strlen(inq_83_str);	/* page len */
+
+	/* our one and only identification descriptor (vendor-specific) */
+	if (buflen > (strlen(inq_83_str) + 4 + 4)) {
+		reqbuf[4 + 0] = 2;	/* code set: ASCII */
+		reqbuf[4 + 3] = strlen(inq_83_str);
+		memcpy(reqbuf + 4 + 4, inq_83_str, strlen(inq_83_str));
+	}
+}
+
+static void ata_scsiop_noop(struct ata_scsi_args *args, u8 *reqbuf,
+			    unsigned int buflen)
+{
+	VPRINTK("ENTER\n");
+}
+
+static void ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *reqbuf,
+			        unsigned int buflen)
+{
+	u64 n_sectors = args->dev->n_sectors;
+	u32 tmp;
+
+	VPRINTK("ENTER\n");
+
+	tmp = n_sectors;	/* note: truncates, if lba48 */
+	if (args->cmd->cmnd[0] == READ_CAPACITY) {
+		reqbuf[0] = tmp >> (8 * 3);
+		reqbuf[1] = tmp >> (8 * 2);
+		reqbuf[2] = tmp >> (8 * 1);
+		reqbuf[3] = tmp;
+
+		tmp = ATA_SECT_SIZE;
+		reqbuf[6] = tmp >> 8;
+		reqbuf[7] = tmp;
+
+	} else {
+		reqbuf[2] = n_sectors >> (8 * 7);
+		reqbuf[3] = n_sectors >> (8 * 6);
+		reqbuf[4] = n_sectors >> (8 * 5);
+		reqbuf[5] = n_sectors >> (8 * 4);
+		reqbuf[6] = tmp >> (8 * 3);
+		reqbuf[7] = tmp >> (8 * 2);
+		reqbuf[8] = tmp >> (8 * 1);
+		reqbuf[9] = tmp;
+
+		tmp = ATA_SECT_SIZE;
+		reqbuf[12] = tmp >> 8;
+		reqbuf[13] = tmp;
+	}
+}
+
+static void ata_scsiop_report_luns(struct ata_scsi_args *args, u8 *reqbuf,
+				   unsigned int buflen)
+{
+	VPRINTK("ENTER\n");
+	reqbuf[3] = 8;	/* just one lun, LUN 0, size 8 bytes */
+}
+
+static void ata_scsi_reqfill(struct ata_scsi_args *args,
+			     void (*actor) (struct ata_scsi_args *args,
+			     		    u8 *reqbuf,
+					    unsigned int buflen))
+{
+	u8 *reqbuf;
+	unsigned int buflen;
+	Scsi_Cmnd *cmd = args->cmd;
+
+	buflen = ata_scsi_get_reqbuf(cmd, &reqbuf);
+	actor(args, reqbuf, buflen);
+	ata_scsi_put_reqbuf(cmd);
+
+	cmd->result = SAM_STAT_GOOD;
+	args->done(cmd);
+}
+
+static void ata_scsi_badcmd(Scsi_Cmnd *cmd,
+			    void (*done)(Scsi_Cmnd *),
+			    u8 asc, u8 ascq)
+{
+	DPRINTK("ENTER\n");
+	cmd->result = SAM_STAT_CHECK_CONDITION;
+
+	cmd->sense_buffer[0] = 0x70;
+	cmd->sense_buffer[2] = ILLEGAL_REQUEST;
+	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
+	cmd->sense_buffer[12] = asc;
+	cmd->sense_buffer[13] = ascq;
+
+	done(cmd);
+}
+
+int ata_scsi_queuecmd(Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *))
+{
+	u8 *scsicmd = cmd->cmnd;
+	struct ata_host *ah;
+	struct ata_device *dev;
+	struct ata_scsi_args args;
+
+	DPRINTK("CDB (%d,%d,%d) %02x %02x %02x %02x %02x %02x %02x %02x %02x\n",
+		cmd->channel, cmd->target, cmd->lun,
+		scsicmd[0], scsicmd[1], scsicmd[2], scsicmd[3],
+		scsicmd[4], scsicmd[5], scsicmd[6], scsicmd[7],
+		scsicmd[8]);
+
+	/* skip commands not addressed to targets we care about */
+	if ((cmd->device->channel != 0) || (cmd->device->lun != 0) ||
+	    (cmd->device->id >= ATA_MAX_DEVICES)) {
+		cmd->result = (DID_BAD_TARGET << 16); /* FIXME: correct?  */
+		done(cmd);
+		return 0;
+	}
+
+	ah = (struct ata_host *) &cmd->device->host->hostdata[0];
+	dev = &ah->device[cmd->device->id];
+
+	DPRINTK("ata%u: chan %u, target %u, lun %u\n",
+		ah->id, cmd->device->channel, cmd->device->id,
+		cmd->device->lun);
+
+	if (!ata_dev_present(dev)) {
+		DPRINTK("no ATA device\n");
+		cmd->result = (DID_BAD_TARGET << 16); /* FIXME: correct?  */
+		done(cmd);
+		return 0;
+	}
+
+	if (dev->class == ATA_DEV_ATAPI) {
+		DPRINTK("FIXME: support ATAPI\n");
+		cmd->result = (DID_BAD_TARGET << 16); /* FIXME: correct?  */
+		done(cmd);
+		return 0;
+	}
+
+	/* fast path */
+	switch(scsicmd[0]) {
+		case READ_6:
+		case WRITE_6:
+			ata_do_rw(ah, dev, cmd, done, 6);
+			return 0;
+
+		case READ_10:
+		case WRITE_10:
+			ata_do_rw(ah, dev, cmd, done, 10);
+			return 0;
+
+		case READ_16:
+		case WRITE_16:
+			ata_do_rw(ah, dev, cmd, done, 16);
+			return 0;
+
+		default:
+			/* do nothing */
+			break;
+	}
+
+	/*
+	 * slow path
+	 */
+
+	args.ah = ah;
+	args.dev = dev;
+	args.cmd = cmd;
+	args.done = done;
+
+	switch(scsicmd[0]) {
+		case TEST_UNIT_READY:		/* FIXME: correct? */
+		case FORMAT_UNIT:		/* FIXME: correct? */
+		case SEND_DIAGNOSTIC:		/* FIXME: correct? */
+			ata_scsi_reqfill(&args, ata_scsiop_noop);
+			break;
+
+		case INQUIRY:
+			if (scsicmd[1] & 2)	           /* is CmdDt set?  */
+				ata_scsi_badcmd(cmd, done, 0x24, 0x00);
+			else if ((scsicmd[1] & 1) == 0)    /* is EVPD clear? */
+				ata_scsi_reqfill(&args, ata_scsiop_inq_std);
+			else if (scsicmd[2] == 0x00)
+				ata_scsi_reqfill(&args, ata_scsiop_inq_00);
+			else if (scsicmd[2] == 0x80)
+				ata_scsi_reqfill(&args, ata_scsiop_inq_80);
+			else if (scsicmd[2] == 0x83)
+				ata_scsi_reqfill(&args, ata_scsiop_inq_83);
+			else
+				ata_scsi_badcmd(cmd, done, 0x24, 0x00);
+			break;
+
+		case READ_CAPACITY:
+			ata_scsi_reqfill(&args, ata_scsiop_read_cap);
+			break;
+
+		case SERVICE_ACTION_IN:
+			if ((scsicmd[1] & 0x1f) == SAI_READ_CAPACITY_16)
+				ata_scsi_reqfill(&args, ata_scsiop_read_cap);
+			else
+				ata_scsi_badcmd(cmd, done, 0x24, 0x00);
+			break;
+
+		case REPORT_LUNS:
+			ata_scsi_reqfill(&args, ata_scsiop_report_luns);
+			break;
+
+		/* mandantory commands we haven't implemented yet */
+		case REQUEST_SENSE:
+
+		/* all other commands */
+		default:
+			ata_scsi_badcmd(cmd, done, 0x20, 0x00);
+			break;
+	}
+
+	return 0;
+}
+
+static void ata_host_remove(struct ata_host *ah, unsigned int do_unregister)
+{
+	struct Scsi_Host *sh = ah->host;
+
+	DPRINTK("ENTER\n");
+	outl(0, ah->ioaddr.bmdma_addr + ATA_DMA_TABLE_OFS);
+	pci_free_consistent(ah->host_set->pdev, ATA_PRD_TBL_SZ, ah->prd, ah->prd_dma);
+
+	if (do_unregister)
+		scsi_unregister(sh);
+}
+
+static struct ata_host * __init ata_host_add(struct ata_probe_ent *ent,
+				struct ata_host_set *host_set,
+				unsigned int port_no)
+{
+	struct pci_dev *pdev = ent->pdev;
+	struct Scsi_Host *host;
+	struct ata_host *ah;
+	unsigned int i;
+
+	DPRINTK("ENTER\n");
+	host = scsi_register(ent->sht, sizeof(struct ata_host));
+	if (!host)
+		return NULL;
+
+	host->max_id = 16;
+	host->max_lun = 1;
+	host->max_channel = 1;
+	host->unique_id = ata_unique_id++;
+	host->max_cmd_len = 16;
+
+	ah = (struct ata_host *) &host->hostdata[0];
+	ah->flags = ATA_FLAG_PORT_DISABLED;
+	ah->id = host->unique_id;
+	ah->host = host;
+	ah->ctl = ATA_DEVCTL_OBS;
+	ah->host_set = host_set;
+	ah->port_no = port_no;
+	ah->pio_mask = ent->pio_mask;
+	ah->udma_mask = ent->udma_mask;
+	ah->flags |= ent->host_flags;
+	ah->ops = ent->host_ops;
+	ah->bus_state = BUS_UNKNOWN;
+	ah->thr_state = THR_PROBE_START;
+	ah->device[0].flags = ATA_DFLAG_MASTER;
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ah->device[i].devno = i;
+	init_completion(&ah->thr_exited);
+	init_MUTEX_LOCKED(&ah->probe_sem);
+	init_MUTEX_LOCKED(&ah->sem);
+	init_MUTEX_LOCKED(&ah->thr_sem);
+	init_timer(&ah->thr_timer);
+	ah->thr_timer.function = ata_thread_timer;
+	ah->thr_timer.data = (unsigned long) ah;
+#ifdef ATA_IRQ_TRAP
+	ah->stats.unhandled_irq = 1;
+	ah->stats.idle_irq = 1;
+#endif
+
+	memcpy(&ah->ioaddr, &ent->port[port_no], sizeof(struct ata_ioports));
+
+	ah->prd = pci_alloc_consistent(pdev, ATA_PRD_TBL_SZ, &ah->prd_dma);
+	if (!ah->prd)
+		goto err_out;
+	DPRINTK("prd alloc, virt %p, dma %x\n", ah->prd, ah->prd_dma);
+
+	ah->thr_pid = kernel_thread(ata_thread, ah, CLONE_FS | CLONE_FILES);
+	if (ah->thr_pid < 0) {
+		printk(KERN_ERR "ata%d: unable to start kernel thread\n",
+		       ah->id);
+		goto err_out_free;
+	}
+
+	return ah;
+
+err_out_free:
+	pci_free_consistent(ah->host_set->pdev, ATA_PRD_TBL_SZ, ah->prd, ah->prd_dma);
+err_out:
+	scsi_unregister(host);
+	return NULL;
+}
+
+static int __init ata_device_add(struct ata_probe_ent *ent)
+{
+	unsigned int count = 0, i;
+	struct pci_dev *pdev = ent->pdev;
+	struct ata_host_set *host_set;
+	struct ata_host *host;
+
+	DPRINTK("ENTER\n");
+	/* alloc a container for our list of ATA ports (buses) */
+	host_set = kmalloc(sizeof(struct ata_host_set) +
+			   (ent->n_ports * sizeof(void *)), GFP_KERNEL);
+	if (!host_set)
+		return 0;
+	memset(host_set, 0, sizeof(struct ata_host_set) + (ent->n_ports * sizeof(void *)));
+	INIT_LIST_HEAD(&host_set->driver_list);
+	spin_lock_init(&host_set->lock);
+
+	host_set->pdev = pdev;
+	host_set->n_hosts = ent->n_ports;
+	host_set->irq = ent->irq;
+
+	/* register each port bound to this device */
+	for (i = 0; i < ent->n_ports; i++) {
+		host = ata_host_add(ent, host_set, i);
+		if (!host)
+			goto err_out;
+
+		host_set->hosts[i] = host;
+
+		/* print per-port info to dmesg */
+		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
+				 "bmdma 0x%lX irq %lu\n",
+			host->id,
+			host->flags & ATA_FLAG_SATA ? 'S' : 'P',
+			ata_udma_string(ent->udma_mask),
+	       		host->ioaddr.cmd_addr,
+	       		host->ioaddr.ctl_addr,
+	       		host->ioaddr.bmdma_addr,
+	       		ent->irq);
+
+		count++;
+	}
+
+	if (!count) {
+		kfree(host_set);
+		return 0;
+	}
+
+	/* obtain irq, that is shared between channels */
+	if (request_irq(ent->irq, ata_interrupt, ent->irq_flags,
+			DRV_NAME, host_set))
+		goto err_out;
+
+	/* perform each probe synchronously */
+	DPRINTK("probe begin\n");
+	for (i = 0; i < count; i++) {
+		DPRINTK("ata%u: probe begin\n", host_set->hosts[i]->id);
+		up(&host_set->hosts[i]->sem);		/* start probe */
+		DPRINTK("ata%u: probe-wait begin\n", host_set->hosts[i]->id);
+		down(&host_set->hosts[i]->probe_sem);	/* wait for end */
+		DPRINTK("ata%u: probe-wait end\n", host_set->hosts[i]->id);
+	}
+
+	/* add to driver-global list */
+	spin_lock(&ata_module_lock);
+	list_add_tail(&host_set->driver_list, &ata_scsihost_list);
+	spin_unlock(&ata_module_lock);
+
+	pci_set_drvdata(pdev, host_set);
+
+	VPRINTK("EXIT, returning %u\n", ent->n_ports);
+	return ent->n_ports; /* success */
+
+err_out:
+	for (i = 0; i < count; i++)
+		ata_host_remove(host_set->hosts[i], 1);
+	kfree(host_set);
+	VPRINTK("EXIT, returning 0\n");
+	return 0;
+}
+
+int ata_scsi_detect(Scsi_Host_Template *sht)
+{
+	struct list_head *node;
+	struct ata_probe_ent *ent;
+	int count = 0;
+
+	VPRINTK("ENTER\n");
+
+	spin_lock(&ata_module_lock);
+	while (!list_empty(&ata_probe_list)) {
+		node = ata_probe_list.next;
+		ent = list_entry(node, struct ata_probe_ent, node);
+		list_del(node);
+
+		spin_unlock(&ata_module_lock);
+
+		count += ata_device_add(ent);
+		kfree(ent);
+
+		spin_lock(&ata_module_lock);
+	}
+	spin_unlock(&ata_module_lock);
+
+	VPRINTK("EXIT, returning %d\n", count);
+	return count;
+}
+
+int ata_scsi_release(struct Scsi_Host *host)
+{
+	struct ata_host *ah = (struct ata_host *) &host->hostdata[0];
+	int ret = 0;
+
+	DPRINTK("ENTER\n");
+
+	if (ah->thr_pid >= 0) {
+		ah->time_to_die = 1;
+		wmb();
+		ret = kill_proc(ah->thr_pid, SIGTERM, 1);
+		if (ret) {
+			printk(KERN_ERR "ata%d: unable to kill kernel thread\n",
+			       ah->id);
+			return 0;	/* FIXME: correct ret code? */
+		}
+		wait_for_completion(&ah->thr_exited);
+	}
+
+	ah->ops->port_disable(ah);
+	ata_host_remove(ah, 0);
+
+	DPRINTK("EXIT\n");
+	return 1;
+}
+
+int ata_pci_init_one (struct pci_dev *pdev, struct ata_board *board_info,
+		      struct ata_host_ops *host_ops)
+{
+	struct ata_probe_ent *probe_ent, *probe_ent2 = NULL;
+	u8 tmp8, mask;
+	unsigned int legacy_mode = 0;
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	/* require that firmware put us in native mode.
+	 * FIXME: temporary restriction.
+	 */
+	pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
+	mask = (1 << 2) | (1 << 0);
+	if ((tmp8 & mask) != mask)
+		legacy_mode = 1;
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
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (!probe_ent) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	probe_ent->pdev = pdev;
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	if (legacy_mode) {
+		probe_ent2 = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+		if (!probe_ent2) {
+			rc = -ENOMEM;
+			goto err_out_free_ent;
+		}
+
+		memset(probe_ent2, 0, sizeof(*probe_ent));
+		probe_ent2->pdev = pdev;
+		INIT_LIST_HEAD(&probe_ent2->node);
+	}
+
+	probe_ent->pio_mask = board_info->pio_mask;
+	probe_ent->udma_mask = board_info->udma_mask;
+	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+	probe_ent->host_flags = board_info->host_flags;
+	probe_ent->host_ops = host_ops;
+	probe_ent->sht = board_info->sht;
+
+	if (legacy_mode) {
+		probe_ent->port[0].cmd_addr = 0x1f0;
+		probe_ent->port[0].ctl_addr = 0x3f6;
+		probe_ent->n_ports = 1;
+		probe_ent->irq = 14;
+
+		probe_ent2->port[0].cmd_addr = 0x170;
+		probe_ent2->port[0].ctl_addr = 0x376;
+		probe_ent2->port[0].bmdma_addr = pci_resource_start(pdev, 4)+8;
+		probe_ent2->n_ports = 1;
+		probe_ent2->irq = 15;
+
+		probe_ent2->pio_mask = board_info->pio_mask;
+		probe_ent2->udma_mask = board_info->udma_mask;
+		probe_ent2->host_flags = board_info->host_flags;
+		probe_ent2->host_ops = host_ops;
+		probe_ent2->sht = board_info->sht;
+	} else {
+		probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
+		probe_ent->port[0].ctl_addr =
+			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
+
+		probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
+		probe_ent->port[1].ctl_addr =
+			pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
+		probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+
+		probe_ent->n_ports = 2;
+		probe_ent->irq = pdev->irq;
+		probe_ent->irq_flags = SA_SHIRQ;
+	}
+
+	pci_set_master(pdev);
+
+	spin_lock(&ata_module_lock);
+	list_add_tail(&probe_ent->node, &ata_probe_list);
+	if (legacy_mode)
+		list_add_tail(&probe_ent2->node, &ata_probe_list);
+	spin_unlock(&ata_module_lock);
+
+	return 0;
+
+err_out_free_ent:
+	kfree(probe_ent);
+err_out_regions:
+	pci_release_regions(pdev);
+err_out:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+void ata_pci_remove_one (struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = pci_get_drvdata(pdev);
+
+	/* FIXME: remove host_set from module-global list */
+
+	free_irq(host_set->irq, host_set);
+	kfree(host_set);
+
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static int __init ata_init(void)
+{
+	printk(KERN_DEBUG "libata version " DRV_VERSION " loaded.\n");
+	return 0;
+}
+
+module_init(ata_init);
+
+EXPORT_SYMBOL(ata_port_probe);
+EXPORT_SYMBOL(ata_port_disable);
+EXPORT_SYMBOL(ata_pci_init_one);
+EXPORT_SYMBOL(ata_pci_remove_one);
+EXPORT_SYMBOL(ata_scsi_detect);
+EXPORT_SYMBOL(ata_scsi_release);
+EXPORT_SYMBOL(ata_scsi_queuecmd);
+EXPORT_SYMBOL(ata_scsi_error);
+
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/ata.h	Sat May 24 14:36:45 2003
@@ -0,0 +1,483 @@
+/*
+   Copyright 2003 Red Hat, Inc.  All rights reserved.
+   Copyright 2003 Jeff Garzik
+
+   The contents of this file are subject to the Open 
+   Software License version 1.1 that can be found at
+   http://www.opensource.org/licenses/osl-1.1.txt and is included herein
+   by reference.
+
+   Alternatively, the contents of this file may be used under the terms
+   of the GNU General Public License version 2 (the "GPL") as distributed
+   in the kernel source COPYING file, in which case the provisions of
+   the GPL are applicable instead of the above.  If you wish to allow
+   the use of your version of this file only under the terms of the
+   GPL and not to allow others to use your version of this file under
+   the OSL, indicate your decision by deleting the provisions above and
+   replace them with the notice and other provisions required by the GPL.
+   If you do not delete the provisions above, a recipient may use your
+   version of this file under either the OSL or the GPL.
+
+ */
+
+#ifndef __LINUX_ATA_H__
+#define __LINUX_ATA_H__
+
+#include <linux/blkdev.h>
+#include <linux/scsi_defs.h>
+#include <linux/scsi_hosts.h>
+#include <linux/delay.h>
+
+/*
+ * compile-time options
+ */
+#undef ATA_FORCE_PIO		/* do not configure or use DMA */
+#undef ATA_READ_POISON		/* poison membufs before data is read in */
+#undef ATA_DEBUG		/* debugging output */
+#undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
+#undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
+#undef ATA_NDEBUG		/* define to disable quick runtime checks */
+
+
+/* note: prints function name for you */
+#ifdef ATA_DEBUG
+#define DPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#ifdef ATA_VERBOSE_DEBUG
+#define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define VPRINTK(fmt, args...)
+#endif	/* ATA_VERBOSE_DEBUG */
+#else
+#define DPRINTK(fmt, args...)
+#define VPRINTK(fmt, args...)
+#endif	/* ATA_DEBUG */
+
+#ifdef ATA_NDEBUG
+#define assert(expr)
+#else
+#define assert(expr) \
+        if(!(expr)) {                                   \
+        printk(KERN_ERR "Assertion failed! %s,%s,%s,line=%d\n", \
+        #expr,__FILE__,__FUNCTION__,__LINE__);          \
+        }
+#endif
+
+enum {
+	/* various global constants */
+	ATA_MAX_PORTS		= 2,
+	ATA_MAX_DEVICES		= 2,	/* per bus/port */
+	ATA_DEF_QUEUE		= 1,
+	ATA_MAX_QUEUE		= 1,
+	ATA_MAX_PRD		= 256,	/* we could make these 256/256 */
+	ATA_MAX_SECTORS		= 200,	/* FIXME */
+	ATA_MAX_BUS		= 2,
+	ATA_SECT_SIZE		= 512,
+	ATA_SECT_SIZE_MASK	= (ATA_SECT_SIZE - 1),
+	ATA_SECT_DWORDS		= ATA_SECT_SIZE / sizeof(u32),
+	ATA_ID_WORDS		= 256,
+	ATA_ID_PROD_OFS		= 27,
+	ATA_ID_SERNO_OFS	= 10,
+	ATA_ID_MAJOR_VER	= 80,
+	ATA_ID_PIO_MODES	= 64,
+	ATA_ID_UDMA_MODES	= 88,
+	ATA_ID_PIO4		= (1 << 1),
+	ATA_DEF_BUSY_WAIT	= 10000,
+	ATA_PCI_CTL_OFS		= 2,
+	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,
+	ATA_SERNO_LEN		= 20,
+
+	ATA_SHT_EMULATED	= 1,
+	ATA_SHT_CMD_PER_LUN	= 1,
+	ATA_SHT_THIS_ID		= -1,
+	ATA_SHT_USE_CLUSTERING	= 0,	/* FIXME: which is best, 0 or 1?  */
+
+	/* DMA-related */
+	ATA_PRD_SZ		= 8,
+	ATA_PRD_TBL_SZ		= (ATA_MAX_PRD * ATA_PRD_SZ),
+	ATA_PRD_EOT		= (1 << 31),	/* end-of-table flag */
+
+	ATA_DMA_MASK		= 0xffffffff,
+	ATA_DMA_TABLE_OFS	= 4,
+	ATA_DMA_STATUS		= 2,
+	ATA_DMA_CMD		= 0,
+	ATA_DMA_WR		= (1 << 3),
+	ATA_DMA_START		= (1 << 0),
+	ATA_DMA_INTR		= (1 << 2),
+	ATA_DMA_ERR		= (1 << 1),
+	ATA_DMA_ACTIVE		= (1 << 0),
+
+	/* bits in ATA command block registers */
+	ATA_HOB			= (1 << 7),	/* LBA48 selector */
+	ATA_NIEN		= (1 << 1),	/* disable-irq flag */
+	ATA_LBA			= (1 << 6),	/* LBA28 selector */
+	ATA_DEV1		= (1 << 4),	/* Select Device 1 (slave) */
+	ATA_BUSY		= (1 << 7),	/* BSY status bit */
+	ATA_DEVICE_OBS		= (1 << 7) | (1 << 5), /* obs bits in dev reg */
+	ATA_DEVCTL_OBS		= (1 << 3),
+	ATA_DRQ			= (1 << 3),
+	ATA_ERR			= (1 << 0),
+
+	/* ATA command block registers */
+	ATA_REG_DATA		= 0x00,
+	ATA_REG_ERR		= 0x01,
+	ATA_REG_NSECT		= 0x02,
+	ATA_REG_LBAL		= 0x03,
+	ATA_REG_LBAM		= 0x04,
+	ATA_REG_LBAH		= 0x05,
+	ATA_REG_DEVICE		= 0x06,
+	ATA_REG_STATUS		= 0x07,
+
+	ATA_REG_FEATURE		= ATA_REG_ERR, /* and their aliases */
+	ATA_REG_CMD		= ATA_REG_STATUS,
+	ATA_REG_BYTEL		= ATA_REG_LBAM,
+	ATA_REG_BYTEH		= ATA_REG_LBAH,
+	ATA_REG_DEVSEL		= ATA_REG_DEVICE,
+	ATA_REG_IRQ		= ATA_REG_NSECT,
+
+	/* struct ata_device stuff */
+	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
+	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
+	ATA_DFLAG_MASTER	= (1 << 2), /* is device 0? */
+
+	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
+	ATA_DEV_ATA		= 1,	/* ATA device */
+	ATA_DEV_ATAPI		= 2,	/* ATAPI device */
+	ATA_DEV_NONE		= 3,	/* no device */
+
+	/* struct ata_host flags */
+	ATA_FLAG_SLAVE_POSS	= (1 << 1), /* host supports slave dev */
+					    /* (doesn't imply presence) */
+	ATA_FLAG_PORT_DISABLED	= (1 << 2), /* port is disabled, ignore it */
+	ATA_FLAG_SATA		= (1 << 3),
+
+	/* struct ata_taskfile flags */
+	ATA_TFLAG_LBA48		= (1 << 0),
+	ATA_TFLAG_DATAREG	= (1 << 1),
+	ATA_TFLAG_ISADDR	= (1 << 2), /* enable r/w to nsect/lba regs */
+	ATA_TFLAG_DEVICE	= (1 << 4), /* enable r/w to device reg */
+	ATA_TFLAG_PIO		= (1 << 5),
+
+	ATA_QCFLAG_WRITE	= (1 << 0), /* read==0, write==1 */
+	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
+	ATA_QCFLAG_DMA		= (1 << 2), /* data delivered via DMA */
+
+	/* ATA device commands */
+	ATA_CMD_EDD		= 0x90,	/* execute device diagnostic */
+	ATA_CMD_ID_ATA		= 0xEC,
+	ATA_CMD_ID_ATAPI	= 0xA1,
+	ATA_CMD_READ		= 0xC8,
+	ATA_CMD_READ_EXT	= 0x25,
+	ATA_CMD_WRITE		= 0xCA,
+	ATA_CMD_WRITE_EXT	= 0x35,
+	ATA_CMD_PIO_READ	= 0x20,
+	ATA_CMD_PIO_READ_EXT	= 0x24,
+	ATA_CMD_PIO_WRITE	= 0x30,
+	ATA_CMD_PIO_WRITE_EXT	= 0x34,
+	ATA_CMD_SET_FEATURES	= 0xEF,
+
+	/* various lengths of time */
+	ATA_TMOUT_BOOT		= 30,		/* seconds */
+	ATA_TMOUT_EDD		= 5 * HZ,	/* just a guess */
+	ATA_TMOUT_PIO		= 30 * HZ,
+
+	/* ATA bus states */
+	BUS_UNKNOWN		= 0,
+	BUS_DMA			= 1,
+	BUS_IDLE		= 2,
+	BUS_NOINTR		= 3,
+	BUS_NODATA		= 4,
+	BUS_TIMER		= 5,
+	BUS_PIO			= 6,
+	BUS_EDD			= 7,
+	BUS_IDENTIFY		= 8,
+
+	/* thread states */
+	THR_UNKNOWN		= 0,
+	THR_CHECKPORT		= 1,
+	THR_EDD			= 2,
+	THR_AWAIT_DEATH		= 3,
+	THR_IDENTIFY		= 4,
+	THR_CONFIG_PIO		= 5,
+	THR_CONFIG_DMA		= 6,
+	THR_PROBE_FAILED	= 7,
+	THR_IDLE		= 8,
+	THR_PROBE_SUCCESS	= 9,
+	THR_PROBE_START		= 10,
+	THR_CONFIG_FORCE_PIO	= 11,
+	THR_PIO_POLL		= 12,
+	THR_PIO_TMOUT		= 13,
+	THR_PIO			= 14,
+	THR_PIO_LAST		= 15,
+	THR_PIO_LAST_POLL	= 16,
+	THR_PIO_ERR		= 17,
+
+	/* SATA port states */
+	PORT_UNKNOWN		= 0,
+	PORT_ENABLED		= 1,
+	PORT_DISABLED		= 2,
+
+	/* SETFEATURES stuff */
+	SETFEATURES_XFER	= 0x03,
+	XFER_UDMA_7		= 0x47,
+	XFER_UDMA_6		= 0x46,
+	XFER_UDMA_5		= 0x45,
+	XFER_UDMA_4		= 0x44,
+	XFER_UDMA_3		= 0x43,
+	XFER_UDMA_2		= 0x42,
+	XFER_UDMA_1		= 0x41,
+	XFER_UDMA_0		= 0x40,
+	XFER_PIO_4		= 0x0C,
+	XFER_PIO_3		= 0x0B,
+};
+
+struct ata_prd {
+	u32			addr;
+	u32			flags_len;
+} __attribute__((packed));
+
+struct ata_ioports {
+	unsigned long		cmd_addr;
+	unsigned long		ctl_addr;
+	unsigned long		bmdma_addr;
+};
+
+struct ata_probe_ent {
+	struct list_head	node;
+	struct pci_dev		*pdev;
+	struct ata_host_ops	*host_ops;
+	Scsi_Host_Template	*sht;
+	struct ata_ioports	port[ATA_MAX_PORTS];
+	unsigned int		n_ports;
+	unsigned int		pio_mask;
+	unsigned int		udma_mask;
+	unsigned int		legacy_mode;
+	unsigned long		irq;
+	unsigned int		irq_flags;
+	unsigned long		host_flags;
+};
+
+struct ata_host_set {
+	struct list_head	driver_list;
+	spinlock_t		lock;
+	struct pci_dev		*pdev;
+	unsigned long		irq;
+	unsigned int		n_hosts;
+	struct ata_host *	hosts[0];
+};
+
+struct ata_taskfile {
+	unsigned long		flags;		/* ATA_TFLAG_xxx */
+
+	u8			data;		/* command registers */
+	u8			feature;
+	u8			nsect;
+	u8			lbal;
+	u8			lbam;
+	u8			lbah;
+	u8			device;
+
+	u8			command;	/* IO operation */
+
+	u8			hob_feature;	/* additional data */
+	u8			hob_nsect;	/* to support LBA48 */
+	u8			hob_lbal;
+	u8			hob_lbam;
+	u8			hob_lbah;
+	u8			hob_data;
+
+	u8			ctl;		/* control reg/altstatus */
+};
+
+struct ata_queued_cmd {
+	unsigned long		flags;		/* ATA_QCFLAG_xxx */
+	unsigned int		n_elem;
+	unsigned int		nsect;
+	unsigned int		cursect;
+	unsigned int		cursg;
+	unsigned int		cursg_ofs;
+	Scsi_Cmnd		*scsicmd;
+	void			(*done)(Scsi_Cmnd *);
+	struct ata_taskfile	tf;
+	struct scatterlist	sgent;
+};
+
+struct ata_host_stats {
+	unsigned long		unhandled_irq;
+	unsigned long		idle_irq;
+	unsigned long		rw_reqbuf;
+};
+
+struct ata_device {
+	u64			n_sectors;	/* size of device, if ATA */
+	unsigned long		flags;		/* ATA_DFLAG_xxx */
+	unsigned int		class;		/* ATA_DEV_xxx */
+	unsigned int		devno;		/* 0 or 1 */
+	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+	unsigned int		pio_mode;
+	unsigned int		udma_mode;
+
+	unsigned char		vendor[8];	/* space-padded, not ASCIIZ */
+	unsigned char		product[16];
+};
+
+struct ata_host_ops;
+struct ata_host {
+	struct Scsi_Host	*host;	/* our co-allocated scsi host */
+	struct ata_host_ops	*ops;
+	unsigned long		flags;	/* ATA_FLAG_xxx */
+	unsigned int		id;	/* unique id req'd by scsi midlyr */
+	unsigned int		port_no; /* unique port #; from zero */
+
+	struct ata_prd		*prd;	 /* our SG list */
+	dma_addr_t		prd_dma; /* and its DMA mapping */
+
+	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
+
+	u8			ctl;	/* cache of ATA control register */
+	u8			dmactl; /* cache of DMA control register */
+	u8			devsel;	/* cache of Device Select reg */
+	unsigned int		bus_state;
+	unsigned int		port_state;
+	unsigned int		pio_mask;
+	unsigned int		udma_mask;
+
+	struct ata_device	device[ATA_MAX_DEVICES];
+	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
+	struct ata_host_stats	stats;
+	struct ata_host_set	*host_set;
+
+	struct semaphore	sem;
+	struct semaphore	probe_sem;
+
+	unsigned int		thr_state;
+	int			time_to_die;
+	pid_t			thr_pid;
+	struct completion	thr_exited;
+	struct semaphore	thr_sem;
+	struct timer_list	thr_timer;
+	unsigned long		thr_timeout;
+};
+
+struct ata_host_ops {
+	void (*port_probe) (struct ata_host *);
+	void (*port_disable) (struct ata_host *);
+
+	void (*set_piomode) (struct ata_host *, struct ata_device *,
+			     unsigned int);
+	void (*set_udmamode) (struct ata_host *, struct ata_device *,
+			     unsigned int);
+};
+
+struct ata_board {
+	Scsi_Host_Template	*sht;
+	unsigned long		host_flags;
+	unsigned long		pio_mask;
+	unsigned long		udma_mask;
+};
+
+#define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
+#define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
+#define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 8))
+#define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 9))
+#define ata_id_u32(dev,n)	\
+	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))
+#define ata_id_u64(dev,n)	\
+	( ((u64) dev->id[(n) + 3] << 48) |	\
+	  ((u64) dev->id[(n) + 2] << 32) |	\
+	  ((u64) dev->id[(n) + 1] << 16) |	\
+	  ((u64) dev->id[(n) + 0]) )  
+
+extern void ata_port_probe(struct ata_host *);
+extern void ata_port_disable(struct ata_host *);
+extern int ata_pci_init_one (struct pci_dev *, struct ata_board *,
+			     struct ata_host_ops *);
+extern void ata_pci_remove_one (struct pci_dev *pdev);
+extern int ata_scsi_detect(Scsi_Host_Template *sht);
+extern int ata_scsi_release(struct Scsi_Host *host);
+extern int ata_scsi_queuecmd(Scsi_Cmnd *cmd, void (*done)(Scsi_Cmnd *));
+extern int ata_scsi_error(struct Scsi_Host *host);
+
+static inline unsigned long msecs_to_jiffies(unsigned long msecs)
+{
+	return ((HZ * msecs + 999) / 1000);
+}
+
+static inline unsigned int ata_dev_present(struct ata_device *dev)
+{
+	return ((dev->class == ATA_DEV_ATA) ||
+		(dev->class == ATA_DEV_ATAPI));
+}
+
+static inline u8 ata_chk_status(struct ata_ioports *ioaddr)
+{
+	return inb(ioaddr->cmd_addr + ATA_REG_STATUS);
+}
+
+static inline u8 ata_busy_wait(struct ata_ioports *ioaddrs, unsigned int bits,
+			       unsigned int max)
+{
+	u8 status;
+
+	do {
+		udelay(10);
+		status = ata_chk_status(ioaddrs);
+		max--;
+	} while ((status & bits) && (max > 0));
+
+	return status;
+}
+
+static inline u8 ata_wait_idle(struct ata_ioports *ioaddrs)
+{
+	u8 status = ata_busy_wait(ioaddrs, ATA_BUSY | ATA_DRQ, 1000);
+
+	if (status & (ATA_BUSY | ATA_DRQ)) {
+		unsigned long l = ioaddrs->cmd_addr + ATA_REG_STATUS;
+		printk(KERN_WARNING
+		       "ATA: abnormal status 0x%X on port 0x%lX\n",
+		       status, l);
+	}
+
+	return status;
+}
+
+static inline void ata_tf_init(struct ata_host *ah, struct ata_taskfile *tf)
+{
+	memset(tf, 0, sizeof(*tf));
+
+	tf->ctl = ah->ctl;
+	tf->device = ah->devsel;
+}
+
+static inline void ata_irq_on(struct ata_host *ah)
+{
+	struct ata_ioports *ioaddr = &ah->ioaddr;
+
+	ah->ctl &= ~ATA_NIEN;
+	outb(ah->ctl, ioaddr->ctl_addr);
+
+	ata_wait_idle(ioaddr);
+}
+
+static inline u8 ata_irq_ack(struct ata_host *ah, unsigned int chk_drq)
+{
+	unsigned int bits = chk_drq ? ATA_BUSY | ATA_DRQ : ATA_BUSY;
+	u8 host_stat, status;
+
+	status = ata_busy_wait(&ah->ioaddr, bits, 1000);
+	if (status & bits)
+		DPRINTK("abnormal status 0x%X\n", status);
+
+	/* get controller status; clear intr, err bits */
+	host_stat = inb(ah->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	outb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
+	     ah->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+
+	VPRINTK("irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
+		host_stat, inb(ah->ioaddr.bmdma_addr + ATA_DMA_STATUS),
+		status);
+
+	return status;
+}
+
+#endif /* __LINUX_ATA_H__ */
