Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422748AbWJUTz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbWJUTz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 15:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423387AbWJUTz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 15:55:59 -0400
Received: from havoc.gtf.org ([69.61.125.42]:1740 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422748AbWJUTz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 15:55:58 -0400
Date: Sat, 21 Oct 2006 15:55:53 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: [git patches] libata fixes
Message-ID: <20061021195553.GA315@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got some more fixes brewing, pending feedback.

Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/Kconfig      |    1 +
 drivers/ata/ahci.c       |    2 +-
 drivers/ata/ata_piix.c   |    4 ++--
 drivers/ata/libata-sff.c |    9 +++++++++
 include/linux/libata.h   |    2 +-
 5 files changed, 14 insertions(+), 4 deletions(-)

Adrian Bunk:
      ATA must depend on BLOCK

Alan Cox:
      ahci: readability tweak
      libata-sff: Allow for wacky systems

Kristen Carlson Accardi:
      libata: use correct map_db values for ICH8

Tejun Heo:
      libata: typo fix

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 3f4aa0c..03f6338 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -6,6 +6,7 @@ menu "Serial ATA (prod) and Parallel ATA
 
 config ATA
 	tristate "ATA device support"
+	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
 	depends on !SUN4 || BROKEN
 	select SCSI
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2592912..cef2e70 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1041,7 +1041,7 @@ static void ahci_host_intr(struct ata_po
 	/* hmmm... a spurious interupt */
 
 	/* some devices send D2H reg with I bit set during NCQ command phase */
-	if (ap->sactive && status & PORT_IRQ_D2H_REG_FIS)
+	if (ap->sactive && (status & PORT_IRQ_D2H_REG_FIS))
 		return;
 
 	/* ignore interim PIO setup fis interrupts */
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 5719704..5250187 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -432,9 +432,9 @@ static const struct piix_map_db ich8_map
 	.present_shift = 8,
 	.map = {
 		/* PM   PS   SM   SS       MAP */
-		{  P0,  NA,  P1,  NA }, /* 00b (hardwired) */
+		{  P0,  P2,  P1,  P3 }, /* 00b (hardwired when in AHCI) */
 		{  RV,  RV,  RV,  RV },
-		{  RV,  RV,  RV,  RV }, /* 10b (never) */
+		{  IDE,  IDE,  NA,  NA }, /* 10b (IDE mode) */
 		{  RV,  RV,  RV,  RV },
 	},
 };
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 06daaa3..7645f2b 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -981,6 +981,15 @@ int ata_pci_init_one (struct pci_dev *pd
 		mask = (1 << 2) | (1 << 0);
 		if ((tmp8 & mask) != mask)
 			legacy_mode = (1 << 3);
+#if defined(CONFIG_NO_ATA_LEGACY)
+		/* Some platforms with PCI limits cannot address compat
+		   port space. In that case we punt if their firmware has
+		   left a device in compatibility mode */
+		if (legacy_mode) {
+			printk(KERN_ERR "ata: Compatibility mode ATA is not supported on this platform, skipping.\n");
+			return -EOPNOTSUPP;
+		}
+#endif
 	}
 
 	rc = pci_request_regions(pdev, DRV_NAME);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d0a7ad5..b03d5a3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -143,7 +143,7 @@ enum {
 	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device limited to PIO mode */
-	ATA_DFLAG_NCQ_OFF	= (1 << 9), /* devied limited to non-NCQ mode */
+	ATA_DFLAG_NCQ_OFF	= (1 << 9), /* device limited to non-NCQ mode */
 	ATA_DFLAG_SUSPENDED	= (1 << 10), /* device suspended */
 	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
