Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbUKPHWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbUKPHWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 02:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUKPHWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 02:22:49 -0500
Received: from havoc.gtf.org ([69.28.190.101]:11690 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261930AbUKPHWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 02:22:36 -0500
Date: Tue, 16 Nov 2004 02:21:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ULi SATA fixes, new support
Message-ID: <20041116072131.GA32560@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another one just checked into libata-dev-2.6.


 drivers/scsi/sata_uli.c |   51 +++++++++++++++++++++---------------------------
 1 files changed, 23 insertions(+), 28 deletions(-)

through these ChangeSets:

<jgarzik@pobox.com> (04/11/16 1.2169)
   [libata sata_uli] add 5281 support, fix SATA phy setup for others
   
   Contributed by Peer Chen @ ULi and tested by a user.

diff -Nru a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c	2004-11-16 02:19:58 -05:00
+++ b/drivers/scsi/sata_uli.c	2004-11-16 02:19:58 -05:00
@@ -32,16 +32,18 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_uli"
-#define DRV_VERSION	"0.2"
+#define DRV_VERSION	"0.5"
 
 enum {
 	uli_5289		= 0,
 	uli_5287		= 1,
+	uli_5281		= 2,
 
 	/* PCI configuration registers */
-	ULI_SCR_BASE		= 0x90, /* sata0 phy SCR registers */
-	ULI_SATA1_OFS		= 0x10, /* offset from sata0->sata1 phy regs */
-
+	ULI5287_BASE		= 0x90, /* sata0 phy SCR registers */
+	ULI5287_OFFS		= 0x10, /* offset from sata0->sata1 phy regs */
+	ULI5281_BASE		= 0x60, /* sata0 phy SCR  registers */
+	ULI5281_OFFS		= 0x60, /* offset from sata0->sata1 phy regs */
 };
 
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -51,6 +53,7 @@
 static struct pci_device_id uli_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AL, 0x5289, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5289 },
 	{ PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5287 },
+	{ PCI_VENDOR_ID_AL, 0x5281, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5281 },
 	{ }	/* terminate list */
 };
 
@@ -125,33 +128,15 @@
 MODULE_DEVICE_TABLE(pci, uli_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg)
+static unsigned int get_scr_cfg_addr(struct ata_port *ap, unsigned int sc_reg)
 {
-	unsigned int addr = ULI_SCR_BASE + (4 * sc_reg);
-
-	switch (port_no) {
-	case 0:
-		break;
-	case 1:
-		addr += ULI_SATA1_OFS;
-		break;
-	case 2:
-		addr += ULI_SATA1_OFS*4;
-		break;
-	case 3:
-		addr += ULI_SATA1_OFS*5;
-		break;
-	default:
-		BUG();
-		break;
-	}
-	return addr;
+	return ap->ioaddr.scr_addr + (4 * sc_reg);
 }
 
 static u32 uli_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap, sc_reg);
 	u32 val;
 
 	pci_read_config_dword(pdev, cfg_addr, &val);
@@ -161,7 +146,7 @@
 static void uli_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap, scr);
 
 	pci_write_config_dword(pdev, cfg_addr, val);
 }
@@ -222,9 +207,11 @@
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
-
+	
 	switch (board_idx) {
 	case uli_5287:
+		probe_ent->port[0].scr_addr = ULI5287_BASE;
+		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
        		probe_ent->n_ports = 4;
 
        		probe_ent->port[2].cmd_addr = pci_resource_start(pdev, 0) + 8;
@@ -232,19 +219,27 @@
 		probe_ent->port[2].ctl_addr =
 			(pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[2].bmdma_addr = pci_resource_start(pdev, 4) + 16;
+		probe_ent->port[2].scr_addr = ULI5287_BASE + ULI5287_OFFS*4;
 
 		probe_ent->port[3].cmd_addr = pci_resource_start(pdev, 2) + 8;
 		probe_ent->port[3].altstatus_addr =
 		probe_ent->port[3].ctl_addr =
 			(pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[3].bmdma_addr = pci_resource_start(pdev, 4) + 24;
+		probe_ent->port[3].scr_addr = ULI5287_BASE + ULI5287_OFFS*5;
 
 		ata_std_ports(&probe_ent->port[2]);
 		ata_std_ports(&probe_ent->port[3]);
 		break;
 
 	case uli_5289:
-		/* do nothing; ata_pci_init_native_mode did it all */
+		probe_ent->port[0].scr_addr = ULI5287_BASE;
+		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
+		break;
+
+	case uli_5281:
+		probe_ent->port[0].scr_addr = ULI5281_BASE;
+		probe_ent->port[1].scr_addr = ULI5281_BASE + ULI5281_OFFS;
 		break;
 
 	default:
