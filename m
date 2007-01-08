Return-Path: <linux-kernel-owner+w=401wt.eu-S1161324AbXAHQBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161324AbXAHQBt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161327AbXAHQBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:01:49 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49267 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161324AbXAHQBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:01:48 -0500
Date: Mon, 8 Jan 2007 16:11:07 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com, akpm@osdl.org,
       uwe.koziolek@gmx.net
Subject: [PATCH] sata_sis: Support for PATA supports
Message-ID: <20070108161107.121f196b@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is quick rework of the patch Uwe proposed but using Kconfig not
ifdefs and user selection to sort out PATA support. Instead of ifdefs and
requiring the user to select both drivers the SATA driver selects the
PATA one.

For neatness I've also moved the extern into the function that uses it.

Two questions really
1.	Do you want the extern in a header file
2.	Is this now neat enough to keep you happy Jeff or shall I do
the library split anyway ?

Please let me know so I can fire off new versions and try and get
this one submitted for good today.

Signed-off-by: Alan Cox


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/ata/Kconfig linux-2.6.20-rc3-mm1/drivers/ata/Kconfig
--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/Kconfig	2007-01-05 13:09:36.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/Kconfig	2007-01-08 15:27:55.000000000 +0000
@@ -112,11 +112,14 @@
 	  If unsure, say N.
 
 config SATA_SIS
-	tristate "SiS 964/180 SATA support"
+	tristate "SiS 964/965/966/180 SATA support"
 	depends on PCI
+	select PATA_SIS
 	help
-	  This option enables support for SiS Serial ATA 964/180.
-
+	  This option enables support for SiS Serial ATA on 
+	  SiS 964/965/966/180 and Parallel ATA on SiS 180.
+	  The PATA support for SiS 180 requires additionally to
+	  enable the PATA_SIS driver in the config.
 	  If unsure, say N.
 
 config SATA_ULI
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/ata/pata_sis.c linux-2.6.20-rc3-mm1/drivers/ata/pata_sis.c
--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/pata_sis.c	2007-01-05 13:09:36.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/pata_sis.c	2007-01-05 14:10:40.000000000 +0000
@@ -768,6 +768,8 @@
 	.port_ops	= &sis_133_early_ops,
 };
 
+/* Privately shared with the SiS180 SATA driver, not for use elsewhere */
+EXPORT_SYMBOL_GPL(sis_info133);
 
 static void sis_fixup(struct pci_dev *pdev, struct sis_chipset *sis)
 {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc3-mm1/drivers/ata/sata_sis.c linux-2.6.20-rc3-mm1/drivers/ata/sata_sis.c
--- linux.vanilla-2.6.20-rc3-mm1/drivers/ata/sata_sis.c	2007-01-05 13:09:36.000000000 +0000
+++ linux-2.6.20-rc3-mm1/drivers/ata/sata_sis.c	2007-01-08 15:30:56.000000000 +0000
@@ -138,22 +138,25 @@
 	.port_ops	= &sis_ops,
 };
 
-
 MODULE_AUTHOR("Uwe Koziolek");
 MODULE_DESCRIPTION("low-level driver for Silicon Integratad Systems SATA controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg, struct pci_dev *pdev)
+static unsigned int get_scr_cfg_addr(struct ata_port *ap, unsigned int sc_reg)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
+	u8 pmr;
 
-	if (port_no)  {
+	if (ap->port_no)  {
 		switch (pdev->device) {
 			case 0x0180:
 			case 0x0181:
-				addr += SIS180_SATA1_OFS;
+				pci_read_config_byte(pdev, SIS_PMR, &pmr);
+				if ((pmr & SIS_PMR_COMBINED) == 0)
+					addr += SIS180_SATA1_OFS;
 				break;
 
 			case 0x0182:
@@ -170,7 +173,7 @@
 static u32 sis_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg, pdev);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap, sc_reg);
 	u32 val, val2 = 0;
 	u8 pmr;
 
@@ -188,13 +191,13 @@
 	return (val|val2) &  0xfffffffb; /* avoid problems with powerdowned ports */
 }
 
-static void sis_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
+static void sis_scr_cfg_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr, pdev);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap, sc_reg);
 	u8 pmr;
 
-	if (scr == SCR_ERROR) /* doesn't exist in PCI cfg space */
+	if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
 		return;
 
 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
@@ -251,6 +254,9 @@
 
 static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	/* Provided by the PATA driver */
+	extern struct ata_port_info sis_info133;
+
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
@@ -300,6 +306,17 @@
 	switch (ent->device) {
 	case 0x0180:
 	case 0x0181:
+
+		/* The PATA-handling is provided by pata_sis */
+		switch (pmr & 0x30) {
+		case 0x10:
+			ppi[1] = &sis_info133;
+			break;
+			
+		case 0x30:
+			ppi[0] = &sis_info133;
+			break;
+		}
 		if ((pmr & SIS_PMR_COMBINED) == 0) {
 			dev_printk(KERN_INFO, &pdev->dev,
 				   "Detected SiS 180/181/964 chipset in SATA mode\n");
@@ -379,4 +396,3 @@
 
 module_init(sis_init);
 module_exit(sis_exit);
-
