Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUJOHJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUJOHJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 03:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUJOHJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 03:09:37 -0400
Received: from havoc.gtf.org ([69.28.190.101]:55965 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266252AbUJOHGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 03:06:41 -0400
Date: Fri, 15 Oct 2004 03:06:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] libata queued updated yet again
Message-ID: <20041015070639.GA5807@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Added a couple patches from Bart, and included the patch inline.

The patch is also available at
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-rc4-libata2.patch.bz2
(as soon as the robot gets around to updating, at least)

BK users:

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/Kconfig       |    8 +
 drivers/scsi/Makefile      |    1 
 drivers/scsi/ata_piix.c    |   26 ++--
 drivers/scsi/libata-core.c |    8 +
 drivers/scsi/libata-scsi.c |    2 
 drivers/scsi/sata_nv.c     |   38 +++---
 drivers/scsi/sata_uli.c    |  282 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    2 
 8 files changed, 334 insertions(+), 33 deletions(-)

through these ChangeSets:

Bartlomiej Zolnierkiewicz:
  o [libata piix] Fix PATA UDMA masks
  o [libata] do not memset() SCSI request buf in a get-reference style function
  o libata: PCI IDE legacy mode fix

François Romieu:
  o sata_nv: housekeeping for goto labels
  o sata_nv: wrong failure path and leak
  o sata_nv: enable hotplug event on successfull init only

Jeff Garzik:
  o [libata sata_uli] add dev_select hook
  o [libata] add sata_uli driver for ULi (formerly ALi) SATA

diff -Nru a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
--- a/drivers/scsi/Kconfig	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/Kconfig	2004-10-15 03:02:43 -04:00
@@ -465,6 +465,14 @@
 
 	  If unsure, say N.
 
+config SCSI_SATA_ULI
+	tristate "ULi Electronics SATA support"
+	depends on SCSI_SATA && PCI && EXPERIMENTAL
+	help
+	  This option enables support for ULi Electronics SATA.
+
+	  If unsure, say N.
+
 config SCSI_SATA_VIA
 	tristate "VIA SATA support"
 	depends on SCSI_SATA && PCI && EXPERIMENTAL
diff -Nru a/drivers/scsi/Makefile b/drivers/scsi/Makefile
--- a/drivers/scsi/Makefile	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/Makefile	2004-10-15 03:02:43 -04:00
@@ -130,6 +130,7 @@
 obj-$(CONFIG_SCSI_SATA_SIS)	+= libata.o sata_sis.o
 obj-$(CONFIG_SCSI_SATA_SX4)	+= libata.o sata_sx4.o
 obj-$(CONFIG_SCSI_SATA_NV)	+= libata.o sata_nv.o
+obj-$(CONFIG_SCSI_SATA_ULI)	+= libata.o sata_uli.o
 
 obj-$(CONFIG_ARM)		+= arm/
 
diff -Nru a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/ata_piix.c	2004-10-15 03:02:43 -04:00
@@ -184,7 +184,7 @@
 #else
 		.mwdma_mask	= 0x00, /* mwdma broken */
 #endif
-		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
+		.udma_mask	= 0x3f, /* udma0-5 */
 		.port_ops	= &piix_pata_ops,
 	},
 
@@ -209,7 +209,7 @@
 #else
 		.mwdma_mask	= 0x00, /* mwdma broken */
 #endif
-		.udma_mask	= ATA_UDMA_MASK_40C, /* FIXME: cbl det */
+		.udma_mask	= ATA_UDMA_MASK_40C,
 		.port_ops	= &piix_pata_ops,
 	},
 
@@ -252,7 +252,7 @@
  *	piix_pata_cbl_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
  *
- *	Read 80c cable indicator from SATA PCI device's PCI config
+ *	Read 80c cable indicator from ATA PCI device's PCI config
  *	register.  This register is normally set by firmware (BIOS).
  *
  *	LOCKING:
@@ -268,7 +268,7 @@
 		goto cbl40;
 
 	/* check BIOS cable detect results */
-	mask = ap->port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
+	mask = ap->hard_port_no == 0 ? PIIX_80C_PRI : PIIX_80C_SEC;
 	pci_read_config_byte(pdev, PIIX_IOCFG, &tmp);
 	if ((tmp & mask) == 0)
 		goto cbl40;
@@ -294,7 +294,7 @@
 static void piix_pata_phy_reset(struct ata_port *ap)
 {
 	if (!pci_test_config_bits(ap->host_set->pdev,
-				  &piix_enable_bits[ap->port_no])) {
+				  &piix_enable_bits[ap->hard_port_no])) {
 		ata_port_disable(ap);
 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
 		return;
@@ -327,8 +327,8 @@
 	int orig_mask, mask, i;
 	u8 pcs;
 
-	mask = (PIIX_PORT_PRESENT << ap->port_no) |
-	       (PIIX_PORT_ENABLED << ap->port_no);
+	mask = (PIIX_PORT_PRESENT << ap->hard_port_no) |
+	       (PIIX_PORT_ENABLED << ap->hard_port_no);
 
 	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
 	orig_mask = (int) pcs & 0xff;
@@ -345,7 +345,7 @@
 		mask = (PIIX_PORT_PRESENT << i) | (PIIX_PORT_ENABLED << i);
 
 		if ((orig_mask & mask) == mask)
-			if (combined || (i == ap->port_no))
+			if (combined || (i == ap->hard_port_no))
 				return 1;
 	}
 
@@ -394,7 +394,7 @@
 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
 	struct pci_dev *dev	= ap->host_set->pdev;
 	unsigned int is_slave	= (adev->devno != 0);
-	unsigned int master_port= ap->port_no ? 0x42 : 0x40;
+	unsigned int master_port= ap->hard_port_no ? 0x42 : 0x40;
 	unsigned int slave_port	= 0x44;
 	u16 master_data;
 	u8 slave_data;
@@ -412,10 +412,10 @@
 		/* enable PPE, IE and TIME */
 		master_data |= 0x0070;
 		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data &= (ap->port_no ? 0x0f : 0xf0);
+		slave_data &= (ap->hard_port_no ? 0x0f : 0xf0);
 		slave_data |=
 			(timings[pio][0] << 2) |
-			(timings[pio][1] << (ap->port_no ? 4 : 0));
+			(timings[pio][1] << (ap->hard_port_no ? 4 : 0));
 	} else {
 		master_data &= 0xccf8;
 		/* enable PPE, IE and TIME */
@@ -445,9 +445,9 @@
 {
 	unsigned int udma	= adev->dma_mode; /* FIXME: MWDMA too */
 	struct pci_dev *dev	= ap->host_set->pdev;
-	u8 maslave		= ap->port_no ? 0x42 : 0x40;
+	u8 maslave		= ap->hard_port_no ? 0x42 : 0x40;
 	u8 speed		= udma;
-	unsigned int drive_dn	= (ap->port_no ? 2 : 0) + adev->devno;
+	unsigned int drive_dn	= (ap->hard_port_no ? 2 : 0) + adev->devno;
 	int a_speed		= 3 << (drive_dn * 4);
 	int u_flag		= 1 << drive_dn;
 	int v_flag		= 0x01 << drive_dn;
diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/libata-core.c	2004-10-15 03:02:43 -04:00
@@ -3032,6 +3032,8 @@
 	ap->ctl = ATA_DEVCTL_OBS;
 	ap->host_set = host_set;
 	ap->port_no = port_no;
+	ap->hard_port_no =
+		ent->legacy_mode ? ent->hard_port_no : port_no;
 	ap->pio_mask = ent->pio_mask;
 	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
@@ -3338,8 +3340,14 @@
 	probe_ent[0].n_ports = 1;
 	probe_ent[0].irq = 14;
 
+	probe_ent[0].hard_port_no = 0;
+	probe_ent[0].legacy_mode = 1;
+
 	probe_ent[1].n_ports = 1;
 	probe_ent[1].irq = 15;
+
+	probe_ent[1].hard_port_no = 1;
+	probe_ent[1].legacy_mode = 1;
 
 	probe_ent[0].port[0].cmd_addr = 0x1f0;
 	probe_ent[0].port[0].altstatus_addr =
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-15 03:02:43 -04:00
@@ -731,7 +731,6 @@
 		buflen = cmd->request_bufflen;
 	}
 
-	memset(buf, 0, buflen);
 	*buf_out = buf;
 	return buflen;
 }
@@ -780,6 +779,7 @@
 	struct scsi_cmnd *cmd = args->cmd;
 
 	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
+	memset(rbuf, 0, buflen);
 	rc = actor(args, rbuf, buflen);
 	ata_scsi_rbuf_put(cmd);
 
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-10-15 03:02:43 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-10-15 03:02:43 -04:00
@@ -311,7 +311,7 @@
 	static int printed_version = 0;
 	struct nv_host *host;
 	struct ata_port_info *ppi;
-	struct ata_probe_ent *probe_ent = NULL;
+	struct ata_probe_ent *probe_ent;
 	int rc;
 
 	if (!printed_version++)
@@ -319,11 +319,11 @@
 
 	rc = pci_enable_device(pdev);
 	if (rc)
-		return rc;
+		goto err_out;
 
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
-		goto err_out;
+		goto err_out_disable;
 
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
@@ -332,18 +332,16 @@
 	if (rc)
 		goto err_out_regions;
 
+	rc = -ENOMEM;
+
 	ppi = &nv_port_info;
 	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
-	if (!probe_ent) {
-		rc = -ENOMEM;
+	if (!probe_ent)
 		goto err_out_regions;
-	}
 
 	host = kmalloc(sizeof(struct nv_host), GFP_KERNEL);
-	if (!host) {
-		rc = -ENOMEM;
+	if (!host)
 		goto err_out_free_ent;
-	}
 
 	host->host_desc = &nv_device_tbl[ent->driver_data];
 
@@ -354,8 +352,10 @@
 
 		probe_ent->mmio_base = ioremap(pci_resource_start(pdev, 5),
 				pci_resource_len(pdev, 5));
-		if (probe_ent->mmio_base == NULL)
-			goto err_out_iounmap;
+		if (probe_ent->mmio_base == NULL) {
+			rc = -EIO;
+			goto err_out_free_host;
+		}
 
 		base = (unsigned long)probe_ent->mmio_base;
 
@@ -373,14 +373,14 @@
 
 	pci_set_master(pdev);
 
-	// Enable hotplug event interrupts.
-	if (host->host_desc->enable_hotplug)
-		host->host_desc->enable_hotplug(probe_ent);
-
 	rc = ata_device_add(probe_ent);
 	if (rc != NV_PORTS)
 		goto err_out_iounmap;
 
+	// Enable hotplug event interrupts.
+	if (host->host_desc->enable_hotplug)
+		host->host_desc->enable_hotplug(probe_ent);
+
 	kfree(probe_ent);
 
 	return 0;
@@ -388,15 +388,15 @@
 err_out_iounmap:
 	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
 		iounmap(probe_ent->mmio_base);
-
+err_out_free_host:
+	kfree(host);
 err_out_free_ent:
 	kfree(probe_ent);
-
 err_out_regions:
 	pci_release_regions(pdev);
-
-err_out:
+err_out_disable:
 	pci_disable_device(pdev);
+err_out:
 	return rc;
 }
 
diff -Nru a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/scsi/sata_uli.c	2004-10-15 03:02:43 -04:00
@@ -0,0 +1,282 @@
+/*
+ *  sata_uli.c - ULi Electronics SATA
+ *
+ *  The contents of this file are subject to the Open
+ *  Software License version 1.1 that can be found at
+ *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
+ *  by reference.
+ *
+ *  Alternatively, the contents of this file may be used under the terms
+ *  of the GNU General Public License version 2 (the "GPL") as distributed
+ *  in the kernel source COPYING file, in which case the provisions of
+ *  the GPL are applicable instead of the above.  If you wish to allow
+ *  the use of your version of this file only under the terms of the
+ *  GPL and not to allow others to use your version of this file under
+ *  the OSL, indicate your decision by deleting the provisions above and
+ *  replace them with the notice and other provisions required by the GPL.
+ *  If you do not delete the provisions above, a recipient may use your
+ *  version of this file under either the OSL or the GPL.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include "scsi.h"
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+
+#define DRV_NAME	"sata_uli"
+#define DRV_VERSION	"0.11"
+
+enum {
+	uli_5289		= 0,
+	uli_5287		= 1,
+
+	/* PCI configuration registers */
+	ULI_SCR_BASE		= 0x90, /* sata0 phy SCR registers */
+	ULI_SATA1_OFS		= 0x10, /* offset from sata0->sata1 phy regs */
+
+};
+
+static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+
+static struct pci_device_id uli_pci_tbl[] = {
+	{ PCI_VENDOR_ID_AL, 0x5289, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5289 },
+	{ PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5287 },
+	{ }	/* terminate list */
+};
+
+
+static struct pci_driver uli_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= uli_pci_tbl,
+	.probe			= uli_init_one,
+	.remove			= ata_pci_remove_one,
+};
+
+static Scsi_Host_Template uli_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.eh_strategy_handler	= ata_scsi_error,
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
+static struct ata_port_operations uli_ops = {
+	.port_disable		= ata_port_disable,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.phy_reset		= sata_phy_reset,
+
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
+	.eng_timeout		= ata_eng_timeout,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.scr_read		= uli_scr_read,
+	.scr_write		= uli_scr_write,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+};
+
+static struct ata_port_info uli_port_info = {
+	.sht            = &uli_sht,
+	.host_flags     = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
+			  ATA_FLAG_NO_LEGACY,
+	.pio_mask       = 0x03,		//support pio mode 4 (FIXME)
+	.udma_mask      = 0x7f,		//support udma mode 6
+	.port_ops       = &uli_ops,
+};
+
+
+MODULE_AUTHOR("Peer Chen");
+MODULE_DESCRIPTION("low-level driver for ULi Electronics SATA controller");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, uli_pci_tbl);
+
+static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg)
+{
+	unsigned int addr = ULI_SCR_BASE + (4 * sc_reg);
+
+	switch (port_no) {
+	case 0:
+		break;
+	case 1:
+		addr += ULI_SATA1_OFS;
+		break;
+	case 2:
+		addr += ULI_SATA1_OFS*4;
+		break;
+	case 3:
+		addr += ULI_SATA1_OFS*5;
+		break;
+	default:
+		BUG();
+		break;
+	}
+	return addr;
+}
+
+static u32 uli_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
+{
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg);
+	u32 val;
+
+	pci_read_config_dword(ap->host_set->pdev, cfg_addr, &val);
+	return val;
+}
+
+static void uli_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
+{
+	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr);
+
+	pci_write_config_dword(ap->host_set->pdev, cfg_addr, val);
+}
+
+static u32 uli_scr_read (struct ata_port *ap, unsigned int sc_reg)
+{
+	if (sc_reg > SCR_CONTROL)
+		return 0xffffffffU;
+
+	return uli_scr_cfg_read(ap, sc_reg);
+}
+
+static void uli_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+{
+	if (sc_reg > SCR_CONTROL)	//SCR_CONTROL=2, SCR_ERROR=1, SCR_STATUS=0
+		return;
+
+	uli_scr_cfg_write(ap, sc_reg, val);
+}
+
+/* move to PCI layer, integrate w/ MSI stuff */
+static void pci_enable_intx(struct pci_dev *pdev)
+{
+	u16 pci_command;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_INTX_DISABLE) {
+		pci_command &= ~PCI_COMMAND_INTX_DISABLE;
+		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+	}
+}
+
+static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct ata_probe_ent *probe_ent;
+	struct ata_port_info *ppi;
+	int rc;
+	unsigned int board_idx = (unsigned int) ent->driver_data;
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
+	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		goto err_out_regions;
+
+	ppi = &uli_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
+	if (!probe_ent) {
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+
+	switch (board_idx) {
+	case uli_5287:
+       		probe_ent->n_ports = 4;
+
+       		probe_ent->port[2].cmd_addr = pci_resource_start(pdev, 0) + 8;
+		probe_ent->port[2].altstatus_addr =
+		probe_ent->port[2].ctl_addr =
+			(pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS) + 4;
+		probe_ent->port[2].bmdma_addr = pci_resource_start(pdev, 4) + 16;
+
+		probe_ent->port[3].cmd_addr = pci_resource_start(pdev, 2) + 8;
+		probe_ent->port[3].altstatus_addr =
+		probe_ent->port[3].ctl_addr =
+			(pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS) + 4;
+		probe_ent->port[3].bmdma_addr = pci_resource_start(pdev, 4) + 24;
+
+		ata_std_ports(&probe_ent->port[2]);
+		ata_std_ports(&probe_ent->port[3]);
+		break;
+
+	case uli_5289:
+		/* do nothing; ata_pci_init_native_mode did it all */
+		break;
+
+	default:
+		BUG();
+		break;
+	}
+
+	pci_set_master(pdev);
+	pci_enable_intx(pdev);
+
+	/* FIXME: check ata_device_add return value */
+	ata_device_add(probe_ent);
+	kfree(probe_ent);
+
+	return 0;
+
+err_out_regions:
+	pci_release_regions(pdev);
+
+err_out:
+	pci_disable_device(pdev);
+	return rc;
+
+}
+
+static int __init uli_init(void)
+{
+	return pci_module_init(&uli_pci_driver);
+}
+
+static void __exit uli_exit(void)
+{
+	pci_unregister_driver(&uli_pci_driver);
+}
+
+
+module_init(uli_init);
+module_exit(uli_exit);
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-10-15 03:02:43 -04:00
+++ b/include/linux/libata.h	2004-10-15 03:02:43 -04:00
@@ -189,6 +189,7 @@
 	Scsi_Host_Template	*sht;
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
+	unsigned int		hard_port_no;
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
@@ -273,6 +274,7 @@
 	unsigned long		flags;	/* ATA_FLAG_xxx */
 	unsigned int		id;	/* unique id req'd by scsi midlyr */
 	unsigned int		port_no; /* unique port #; from zero */
+	unsigned int		hard_port_no;	/* hardware port #; from zero */
 
 	struct ata_prd		*prd;	 /* our SG list */
 	dma_addr_t		prd_dma; /* and its DMA mapping */
