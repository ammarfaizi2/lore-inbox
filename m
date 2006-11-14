Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965916AbWKNPE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965916AbWKNPE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 10:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965918AbWKNPE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 10:04:57 -0500
Received: from havoc.gtf.org ([69.61.125.42]:37781 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965914AbWKNPE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 10:04:56 -0500
Date: Tue, 14 Nov 2006 10:04:54 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] libata fixes
Message-ID: <20061114150454.GA11900@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/libata-scsi.c |    2 +-
 drivers/ata/pata_artop.c  |    2 +-
 drivers/ata/pata_hpt37x.c |   19 ++++++++++++++++---
 3 files changed, 18 insertions(+), 5 deletions(-)

Alan Cox:
      hpt37x: Check the enablebits

Alexey Dobriyan:
      pata_artop: fix "& (1 >>" typo

Darrick J. Wong:
      libata: fix double-completion on error

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7af2a4b..5c1fc46 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1612,9 +1612,9 @@ early_finish:
 
 err_did:
 	ata_qc_free(qc);
-err_mem:
 	cmd->result = (DID_ERROR << 16);
 	done(cmd);
+err_mem:
 	DPRINTK("EXIT - internal\n");
 	return 0;
 
diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 690828e..96a0980 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -92,7 +92,7 @@ static int artop6260_pre_reset(struct at
 		return -ENOENT;
 
 	pci_read_config_byte(pdev, 0x49, &tmp);
-	if (tmp & (1 >> ap->port_no))
+	if (tmp & (1 << ap->port_no))
 		ap->cbl = ATA_CBL_PATA40;
 	else
 		ap->cbl = ATA_CBL_PATA80;
diff --git a/drivers/ata/pata_hpt37x.c b/drivers/ata/pata_hpt37x.c
index 7350443..fce3fcd 100644
--- a/drivers/ata/pata_hpt37x.c
+++ b/drivers/ata/pata_hpt37x.c
@@ -25,7 +25,7 @@ #include <scsi/scsi_host.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.5"
+#define DRV_VERSION	"0.5.1"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -453,7 +453,13 @@ static int hpt37x_pre_reset(struct ata_p
 {
 	u8 scr2, ata66;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-
+	static const struct pci_bits hpt37x_enable_bits[] = {
+		{ 0x50, 1, 0x04, 0x04 },
+		{ 0x54, 1, 0x04, 0x04 }
+	};
+	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
+		return -ENOENT;
+		
 	pci_read_config_byte(pdev, 0x5B, &scr2);
 	pci_write_config_byte(pdev, 0x5B, scr2 & ~0x01);
 	/* Cable register now active */
@@ -488,10 +494,17 @@ static void hpt37x_error_handler(struct 
 
 static int hpt374_pre_reset(struct ata_port *ap)
 {
+	static const struct pci_bits hpt37x_enable_bits[] = {
+		{ 0x50, 1, 0x04, 0x04 },
+		{ 0x54, 1, 0x04, 0x04 }
+	};
 	u16 mcr3, mcr6;
 	u8 ata66;
-
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
+	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
+		return -ENOENT;
+		
 	/* Do the extra channel work */
 	pci_read_config_word(pdev, 0x52, &mcr3);
 	pci_read_config_word(pdev, 0x56, &mcr6);
