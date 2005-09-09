Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964922AbVIIDMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbVIIDMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 23:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVIIDMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 23:12:12 -0400
Received: from havoc.gtf.org ([69.61.125.42]:2541 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751251AbVIIDMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 23:12:10 -0400
Date: Thu, 8 Sep 2005 23:12:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] libata fixes
Message-ID: <20050909031207.GA25014@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain fixes for last-minute problems noticed in current build,
following GregKH's PCI merge.


 drivers/scsi/sata_mv.c  |   16 ----------------
 drivers/scsi/sata_sis.c |   20 +++++++++++---------
 2 files changed, 11 insertions(+), 25 deletions(-)



commit 8add788574694c5aed04fcb281a5c999e40cd8f6
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Thu Sep 8 23:07:29 2005 -0400

    [libata] minor fixes
    
    * sata_mv: remove pci_intx(), now that the same function is in PCI core
    * sata_sis: fix variable initialization bug, trim trailing whitespace



diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -699,22 +699,6 @@ static int mv_host_init(struct ata_probe
 	return rc;
 }
 
-/* move to PCI layer, integrate w/ MSI stuff */
-static void pci_intx(struct pci_dev *pdev, int enable)
-{
-	u16 pci_command, new;
-
-	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
-
-	if (enable)
-		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
-	else
-		new = pci_command | PCI_COMMAND_INTX_DISABLE;
-
-	if (new != pci_command)
-		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
-}
-
 static int mv_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -55,7 +55,7 @@ enum {
 	SIS180_SATA1_OFS	= 0x10, /* offset from sata0->sata1 phy regs */
 	SIS182_SATA1_OFS	= 0x20, /* offset from sata0->sata1 phy regs */
 	SIS_PMR			= 0x90, /* port mapping register */
-	SIS_PMR_COMBINED	= 0x30, 
+	SIS_PMR_COMBINED	= 0x30,
 
 	/* random bits */
 	SIS_FLAG_CFGSCR		= (1 << 30), /* host flag: SCRs via PCI cfg */
@@ -147,11 +147,13 @@ static unsigned int get_scr_cfg_addr(uns
 {
 	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
 
-	if (port_no) 
+	if (port_no)  {
 		if (device == 0x182)
 			addr += SIS182_SATA1_OFS;
 		else
 			addr += SIS180_SATA1_OFS;
+	}
+
 	return addr;
 }
 
@@ -166,10 +168,10 @@ static u32 sis_scr_cfg_read (struct ata_
 		return 0xffffffff;
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-	
+
 	pci_read_config_dword(pdev, cfg_addr, &val);
 
-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED)) 
+	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
 		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
 
 	return val|val2;
@@ -185,7 +187,7 @@ static void sis_scr_cfg_write (struct at
 		return;
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-	
+
 	pci_write_config_dword(pdev, cfg_addr, val);
 
 	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
@@ -195,7 +197,7 @@ static void sis_scr_cfg_write (struct at
 static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	u32 val,val2;
+	u32 val, val2 = 0;
 	u8 pmr;
 
 	if (sc_reg > SCR_CONTROL)
@@ -209,9 +211,9 @@ static u32 sis_scr_read (struct ata_port
 	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
 
 	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
-		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
+		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
 
-	return val|val2;
+	return val | val2;
 }
 
 static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
@@ -223,7 +225,7 @@ static void sis_scr_write (struct ata_po
 		return;
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
-	
+
 	if (ap->flags & SIS_FLAG_CFGSCR)
 		sis_scr_cfg_write(ap, sc_reg, val);
 	else {
