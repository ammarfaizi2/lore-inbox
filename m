Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUCQKb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUCQKbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:31:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12727 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261340AbUCQKbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:31:06 -0500
Message-ID: <405828DB.7060005@pobox.com>
Date: Wed, 17 Mar 2004 05:30:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH,RFT] VIA SATA driver update
Content-Type: multipart/mixed;
 boundary="------------030309020907080506030107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030309020907080506030107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


A lot of cleanups, though the main functional changes are that the 
driver now uses the generic SATA phy probe/reset code.

Tested on a VIA-based MSI motherboard, running a 64-bit Athlon64 kernel.

I'm interested in hearing reports if libata's VIA SATA still fails for 
you...

IMPORTANT NOTE:  If your kernel's default configuration does not work 
for you, you may need one or more of the following kernel command line 
options:
	noapic
	iommu=off
	acpi=off

(I didn't need any of these options, but some users might)

Patch for 2.6.5-rc1-bk:
attached

Patch for 2.4.25 (included in libata-for-24 bundle):
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.25-libata8.patch.bz2

BK repositories:
http://gkernel.bkbits.net/libata-2.4
http://gkernel.bkbits.net/libata-2.5


--------------030309020907080506030107
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	Wed Mar 17 05:13:24 2004
+++ b/drivers/scsi/sata_via.c	Wed Mar 17 05:13:24 2004
@@ -22,7 +22,6 @@
 
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -32,19 +31,31 @@
 #include "scsi.h"
 #include "hosts.h"
 #include <linux/libata.h>
+#include <asm/io.h>
 
 #define DRV_NAME	"sata_via"
-#define DRV_VERSION	"0.11"
+#define DRV_VERSION	"0.20"
 
 enum {
 	via_sata		= 0,
+
+	SATA_CHAN_ENAB		= 0x40,
+	SATA_INT_GATE		= 0x41,
+	SATA_NATIVE_MODE	= 0x42,
+
+	PORT0			= (1 << 1), /* yes, port0 is bit 1 */
+	PORT1			= (1 << 0), /* yes, port1 is bit 0 */
+
+	ENAB_ALL		= PORT0 | PORT1,
+
+	INT_GATE_ALL		= PORT0 | PORT1,
+
+	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 };
 
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
-static void svia_sata_phy_reset(struct ata_port *ap);
-static void svia_port_disable(struct ata_port *ap);
-
-static unsigned int in_module_init = 1;
+static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
+static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, via_sata },
@@ -78,14 +89,14 @@
 };
 
 static struct ata_port_operations svia_sata_ops = {
-	.port_disable		= svia_port_disable,
+	.port_disable		= ata_port_disable,
 
 	.tf_load		= ata_tf_load_pio,
 	.tf_read		= ata_tf_read_pio,
 	.check_status		= ata_check_status_pio,
 	.exec_command		= ata_exec_command_pio,
 
-	.phy_reset		= svia_sata_phy_reset,
+	.phy_reset		= sata_phy_reset,
 	.phy_config		= pata_phy_config,	/* not a typo */
 
 	.bmdma_start            = ata_bmdma_start_pio,
@@ -94,70 +105,45 @@
 
 	.irq_handler		= ata_interrupt,
 
+	.scr_read		= svia_scr_read,
+	.scr_write		= svia_scr_write,
+
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
 };
 
-static struct ata_port_info svia_port_info[] = {
-	/* via_sata */
-	{
-		.sht		= &svia_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY
-				  | ATA_FLAG_SRST,
-		.pio_mask	= 0x03,	/* pio3-4 */
-		.udma_mask	= 0x7f,	/* udma0-6 ; FIXME */
-		.port_ops	= &svia_sata_ops,
-	},
-};
-
-static struct pci_bits svia_enable_bits[] = {
-	{ 0x40U, 1U, 0x02UL, 0x02UL },	/* port 0 */
-	{ 0x40U, 1U, 0x01UL, 0x01UL },	/* port 1 */
-};
-
-
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("SCSI low-level driver for VIA SATA controllers");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, svia_pci_tbl);
 
-/**
- *	svia_sata_phy_reset -
- *	@ap:
- *
- *	LOCKING:
- *
- */
-
-static void svia_sata_phy_reset(struct ata_port *ap)
+static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
-	if (!pci_test_config_bits(ap->host_set->pdev,
-				  &svia_enable_bits[ap->port_no])) {
-		ata_port_disable(ap);
-		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
-		return;
-	}
+	if (sc_reg > SCR_CONTROL)
+		return 0xffffffffU;
+	return inl(ap->ioaddr.scr_addr + (4 * sc_reg));
+}
 
-	ata_port_probe(ap);
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)
+static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
+{
+	if (sc_reg > SCR_CONTROL)
 		return;
-
-	ata_bus_reset(ap);
+	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
-/**
- *	svia_port_disable -
- *	@ap:
- *
- *	LOCKING:
- *
- */
+static const unsigned int svia_bar_sizes[] = {
+	8, 4, 8, 4, 16, 256
+};
 
-static void svia_port_disable(struct ata_port *ap)
+static unsigned long svia_scr_addr(unsigned long addr, unsigned int port)
 {
-	ata_port_disable(ap);
+	if (port >= 4)
+		return 0;	/* invalid port */
 
-	/* FIXME */
+	addr &= ~((1 << 7) | (1 << 6));
+	addr |= ((unsigned long)port << 6);
+
+	return addr;
 }
 
 /**
@@ -174,19 +160,124 @@
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
-	struct ata_port_info *port_info[1];
-	unsigned int n_ports = 1;
+	unsigned int i;
+	int rc;
+	struct ata_probe_ent *probe_ent;
+	u8 tmp8;
 
 	if (!printed_version++)
 		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
 
-	/* no hotplugging support (FIXME) */
-	if (!in_module_init)
-		return -ENODEV;
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	rc = pci_request_regions(pdev, DRV_NAME);
+	if (rc)
+		goto err_out;
+
+
+	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
+		if ((pci_resource_start(pdev, i) == 0) ||
+		    (pci_resource_len(pdev, i) < svia_bar_sizes[i])) {
+			printk(KERN_ERR DRV_NAME "(%s): invalid PCI BAR %u (sz 0x%lx, val 0x%lx)\n",
+			       pci_name(pdev), i,
+			       pci_resource_start(pdev, i),
+			       pci_resource_len(pdev, i));
+			rc = -ENODEV;
+			goto err_out_regions;
+		}
+
+	rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+	if (rc)
+		goto err_out_regions;
+	rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+	if (rc)
+		goto err_out_regions;
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (!probe_ent) {
+		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
+		       pci_name(pdev));
+		rc = -ENOMEM;
+		goto err_out_regions;
+	}
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	INIT_LIST_HEAD(&probe_ent->node);
+	probe_ent->pdev = pdev;
+	probe_ent->sht = &svia_sht;
+	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
+				ATA_FLAG_NO_LEGACY;
+	probe_ent->port_ops = &svia_sata_ops;
+	probe_ent->n_ports = 2;
+	probe_ent->irq = pdev->irq;
+	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->pio_mask = 0x1f;
+	probe_ent->udma_mask = 0x7f;
+
+	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
+	ata_std_ports(&probe_ent->port[0]);
+	probe_ent->port[0].altstatus_addr =
+	probe_ent->port[0].ctl_addr =
+		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
+	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+	probe_ent->port[0].scr_addr =
+		svia_scr_addr(pci_resource_start(pdev, 5), 0);
+
+	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
+	ata_std_ports(&probe_ent->port[1]);
+	probe_ent->port[1].altstatus_addr =
+	probe_ent->port[1].ctl_addr =
+		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
+	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+	probe_ent->port[1].scr_addr =
+		svia_scr_addr(pci_resource_start(pdev, 5), 1);
+
+	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &tmp8);
+	printk(KERN_INFO DRV_NAME "(%s): routed to hard irq line %d\n",
+	       pci_name(pdev),
+	       (int) (tmp8 & 0xf0) == 0xf0 ? 0 : tmp8 & 0x0f);
+
+	/* make sure SATA channels are enabled */
+	pci_read_config_byte(pdev, SATA_CHAN_ENAB, &tmp8);
+	if ((tmp8 & ENAB_ALL) != ENAB_ALL) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channels (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= ENAB_ALL;
+		pci_write_config_byte(pdev, SATA_CHAN_ENAB, tmp8);
+	}
+
+	/* make sure interrupts for each channel sent to us */
+	pci_read_config_byte(pdev, SATA_INT_GATE, &tmp8);
+	if ((tmp8 & INT_GATE_ALL) != INT_GATE_ALL) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel interrupts (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= INT_GATE_ALL;
+		pci_write_config_byte(pdev, SATA_INT_GATE, tmp8);
+	}
+
+	/* make sure native mode is enabled */
+	pci_read_config_byte(pdev, SATA_NATIVE_MODE, &tmp8);
+	if ((tmp8 & NATIVE_MODE_ALL) != NATIVE_MODE_ALL) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel native mode (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= NATIVE_MODE_ALL;
+		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
+	}
 
-	port_info[0] = &svia_port_info[ent->driver_data];
+	pci_set_master(pdev);
+
+	/* FIXME: check ata_device_add return value */
+	ata_device_add(probe_ent);
+	kfree(probe_ent);
+
+	return 0;
 
-	return ata_pci_init_one(pdev, port_info, n_ports);
+err_out_regions:
+	pci_release_regions(pdev);
+err_out:
+	pci_disable_device(pdev);
+	return rc;
 }
 
 /**
@@ -200,17 +291,7 @@
 
 static int __init svia_init(void)
 {
-	int rc;
-
-	DPRINTK("pci_module_init\n");
-	rc = pci_module_init(&svia_pci_driver);
-	if (rc)
-		return rc;
-
-	in_module_init = 0;
-
-	DPRINTK("done\n");
-	return 0;
+	return pci_module_init(&svia_pci_driver);
 }
 
 /**

--------------030309020907080506030107--

