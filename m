Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbUKPGlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbUKPGlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 01:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbUKPGlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 01:41:07 -0500
Received: from havoc.gtf.org ([69.28.190.101]:33704 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261925AbUKPGju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 01:39:50 -0500
Date: Tue, 16 Nov 2004 01:39:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] VIA vt6421 SATA support
Message-ID: <20041116063949.GA30646@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Support for VIA VT6421 SATA was easy, so I added it simply as a bit of
stress relief from debugging elsewhere :)

I just checked this into my libata-dev-2.6 queue...



 drivers/scsi/sata_via.c |  202 +++++++++++++++++++++++++++++++++++-------------
 1 files changed, 148 insertions(+), 54 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/11/16 1.2170)
   [libata sata_via] add support for VT6421 SATA

<jgarzik@pobox.com> (04/11/16 1.2169)
   [libata sata_via] minor cleanups
   
   Preparation for addition of VT6421 support.  Mostly moving bits
   of code into discrete functions.

diff -Nru a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c	2004-11-16 01:36:14 -05:00
+++ b/drivers/scsi/sata_via.c	2004-11-16 01:36:14 -05:00
@@ -24,6 +24,11 @@
    If you do not delete the provisions above, a recipient may use your
    version of this file under either the OSL or the GPL.
 
+   ----------------------------------------------------------------------
+
+   To-do list:
+   * VT6421 PATA support
+
  */
 
 #include <linux/kernel.h>
@@ -38,11 +43,14 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"sata_via"
-#define DRV_VERSION	"1.0"
+#define DRV_VERSION	"1.1"
 
-enum {
-	via_sata		= 0,
+enum board_ids_enum {
+	vt6420,
+	vt6421,
+};
 
+enum {
 	SATA_CHAN_ENAB		= 0x40, /* SATA channel enable */
 	SATA_INT_GATE		= 0x41, /* SATA interrupt gating */
 	SATA_NATIVE_MODE	= 0x42, /* Native mode enable */
@@ -50,10 +58,8 @@
 
 	PORT0			= (1 << 1),
 	PORT1			= (1 << 0),
-
-	ENAB_ALL		= PORT0 | PORT1,
-
-	INT_GATE_ALL		= PORT0 | PORT1,
+	ALL_PORTS		= PORT0 | PORT1,
+	N_PORTS			= 2,
 
 	NATIVE_MODE_ALL		= (1 << 7) | (1 << 6) | (1 << 5) | (1 << 4),
 
@@ -66,7 +72,8 @@
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static struct pci_device_id svia_pci_tbl[] = {
-	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, via_sata },
+	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
+	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
 
 	{ }	/* terminate list */
 };
@@ -158,18 +165,131 @@
 	8, 4, 8, 4, 16, 256
 };
 
+static const unsigned int vt6421_bar_sizes[] = {
+	16, 16, 16, 16, 32, 128
+};
+
 static unsigned long svia_scr_addr(unsigned long addr, unsigned int port)
 {
 	return addr + (port * 128);
 }
 
+static unsigned long vt6421_scr_addr(unsigned long addr, unsigned int port)
+{
+	return addr + (port * 64);
+}
+
+static void vt6421_init_addrs(struct ata_probe_ent *probe_ent,
+			      struct pci_dev *pdev,
+			      unsigned int port)
+{
+	unsigned long reg_addr = pci_resource_start(pdev, port);
+	unsigned long bmdma_addr = pci_resource_start(pdev, 4) + (port * 8);
+	unsigned long scr_addr;
+
+	probe_ent->port[port].cmd_addr = reg_addr;
+	probe_ent->port[port].altstatus_addr =
+	probe_ent->port[port].ctl_addr = (reg_addr + 8) | ATA_PCI_CTL_OFS;
+	probe_ent->port[port].bmdma_addr = bmdma_addr;
+
+	scr_addr = vt6421_scr_addr(pci_resource_start(pdev, 5), port);
+	probe_ent->port[port].scr_addr = scr_addr;
+
+	ata_std_ports(&probe_ent->port[port]);
+}
+
+static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
+{
+	struct ata_probe_ent *probe_ent;
+	struct ata_port_info *ppi = &svia_port_info;
+
+	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
+	if (!probe_ent)
+		return NULL;
+
+	probe_ent->port[0].scr_addr =
+		svia_scr_addr(pci_resource_start(pdev, 5), 0);
+	probe_ent->port[1].scr_addr =
+		svia_scr_addr(pci_resource_start(pdev, 5), 1);
+
+	return probe_ent;
+}
+
+static struct ata_probe_ent *vt6421_init_probe_ent(struct pci_dev *pdev)
+{
+	struct ata_probe_ent *probe_ent;
+	unsigned int i;
+
+	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+	if (!probe_ent)
+		return NULL;
+
+	memset(probe_ent, 0, sizeof(*probe_ent));
+	probe_ent->dev = pci_dev_to_dev(pdev);
+	INIT_LIST_HEAD(&probe_ent->node);
+
+	probe_ent->sht		= &svia_sht;
+	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |
+				  ATA_FLAG_NO_LEGACY;
+	probe_ent->port_ops	= &svia_sata_ops;
+	probe_ent->n_ports	= N_PORTS;
+	probe_ent->irq		= pdev->irq;
+	probe_ent->irq_flags	= SA_SHIRQ;
+	probe_ent->pio_mask	= 0x1f;
+	probe_ent->mwdma_mask	= 0x07;
+	probe_ent->udma_mask	= 0x7f;
+
+	for (i = 0; i < N_PORTS; i++)
+		vt6421_init_addrs(probe_ent, pdev, i);
+
+	return probe_ent;
+}
+
+static void svia_configure(struct pci_dev *pdev)
+{
+	u8 tmp8;
+
+	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &tmp8);
+	printk(KERN_INFO DRV_NAME "(%s): routed to hard irq line %d\n",
+	       pci_name(pdev),
+	       (int) (tmp8 & 0xf0) == 0xf0 ? 0 : tmp8 & 0x0f);
+
+	/* make sure SATA channels are enabled */
+	pci_read_config_byte(pdev, SATA_CHAN_ENAB, &tmp8);
+	if ((tmp8 & ALL_PORTS) != ALL_PORTS) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channels (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= ALL_PORTS;
+		pci_write_config_byte(pdev, SATA_CHAN_ENAB, tmp8);
+	}
+
+	/* make sure interrupts for each channel sent to us */
+	pci_read_config_byte(pdev, SATA_INT_GATE, &tmp8);
+	if ((tmp8 & ALL_PORTS) != ALL_PORTS) {
+		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel interrupts (0x%x)\n",
+		       pci_name(pdev), (int) tmp8);
+		tmp8 |= ALL_PORTS;
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
+}
+
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	unsigned int i;
 	int rc;
-	struct ata_port_info *ppi;
 	struct ata_probe_ent *probe_ent;
+	int board_id = (int) ent->driver_data;
+	const int *bar_sizes;
 	u8 tmp8;
 
 	if (!printed_version++)
@@ -183,17 +303,23 @@
 	if (rc)
 		goto err_out;
 
-	pci_read_config_byte(pdev, SATA_PATA_SHARING, &tmp8);
-	if (tmp8 & SATA_2DEV) {
-		printk(KERN_ERR DRV_NAME "(%s): SATA master/slave not supported (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
-		rc = -EIO;
-		goto err_out_regions;
+	if (board_id == vt6420) {
+		pci_read_config_byte(pdev, SATA_PATA_SHARING, &tmp8);
+		if (tmp8 & SATA_2DEV) {
+			printk(KERN_ERR DRV_NAME "(%s): SATA master/slave not supported (0x%x)\n",
+		       	pci_name(pdev), (int) tmp8);
+			rc = -EIO;
+			goto err_out_regions;
+		}
+
+		bar_sizes = &svia_bar_sizes[0];
+	} else {
+		bar_sizes = &vt6421_bar_sizes[0];
 	}
 
 	for (i = 0; i < ARRAY_SIZE(svia_bar_sizes); i++)
 		if ((pci_resource_start(pdev, i) == 0) ||
-		    (pci_resource_len(pdev, i) < svia_bar_sizes[i])) {
+		    (pci_resource_len(pdev, i) < bar_sizes[i])) {
 			printk(KERN_ERR DRV_NAME "(%s): invalid PCI BAR %u (sz 0x%lx, val 0x%lx)\n",
 			       pci_name(pdev), i,
 			       pci_resource_start(pdev, i),
@@ -209,8 +335,11 @@
 	if (rc)
 		goto err_out_regions;
 
-	ppi = &svia_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi);
+	if (board_id == vt6420)
+		probe_ent = vt6420_init_probe_ent(pdev);
+	else
+		probe_ent = vt6421_init_probe_ent(pdev);
+	
 	if (!probe_ent) {
 		printk(KERN_ERR DRV_NAME "(%s): out of memory\n",
 		       pci_name(pdev));
@@ -218,42 +347,7 @@
 		goto err_out_regions;
 	}
 
-	probe_ent->port[0].scr_addr =
-		svia_scr_addr(pci_resource_start(pdev, 5), 0);
-	probe_ent->port[1].scr_addr =
-		svia_scr_addr(pci_resource_start(pdev, 5), 1);
-
-	pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &tmp8);
-	printk(KERN_INFO DRV_NAME "(%s): routed to hard irq line %d\n",
-	       pci_name(pdev),
-	       (int) (tmp8 & 0xf0) == 0xf0 ? 0 : tmp8 & 0x0f);
-
-	/* make sure SATA channels are enabled */
-	pci_read_config_byte(pdev, SATA_CHAN_ENAB, &tmp8);
-	if ((tmp8 & ENAB_ALL) != ENAB_ALL) {
-		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channels (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
-		tmp8 |= ENAB_ALL;
-		pci_write_config_byte(pdev, SATA_CHAN_ENAB, tmp8);
-	}
-
-	/* make sure interrupts for each channel sent to us */
-	pci_read_config_byte(pdev, SATA_INT_GATE, &tmp8);
-	if ((tmp8 & INT_GATE_ALL) != INT_GATE_ALL) {
-		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel interrupts (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
-		tmp8 |= INT_GATE_ALL;
-		pci_write_config_byte(pdev, SATA_INT_GATE, tmp8);
-	}
-
-	/* make sure native mode is enabled */
-	pci_read_config_byte(pdev, SATA_NATIVE_MODE, &tmp8);
-	if ((tmp8 & NATIVE_MODE_ALL) != NATIVE_MODE_ALL) {
-		printk(KERN_DEBUG DRV_NAME "(%s): enabling SATA channel native mode (0x%x)\n",
-		       pci_name(pdev), (int) tmp8);
-		tmp8 |= NATIVE_MODE_ALL;
-		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
-	}
+	svia_configure(pdev);
 
 	pci_set_master(pdev);
 
