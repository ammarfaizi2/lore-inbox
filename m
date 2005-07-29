Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVG2Gb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVG2Gb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 02:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbVG2Gb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 02:31:26 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52686 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261642AbVG2GbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 02:31:24 -0400
Message-ID: <42E9CD36.4010402@pobox.com>
Date: Fri, 29 Jul 2005 02:31:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patch] 2.6.x libata fix
Content-Type: multipart/mixed;
 boundary="------------040109040504080202050103"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040109040504080202050103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the fix described in the attached diffstat/changelog/patch.


--------------040109040504080202050103
Content-Type: text/plain;
 name="libata-dev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev.txt"

 drivers/scsi/ata_piix.c |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)


commit 7b6dbd6872ca1d0c03dc0e0a7108d79c8dafa793
Author: Greg Felix <gregfelixlkml@gmail.com>
Date:   Thu Jul 28 15:54:15 2005 -0400

    libata: Check PCI sub-class code before disabling AHCI
    
    This patch adds functionality to check the PCI sub-class code of an
    AHCI capable device before disabling AHCI.  It fixes a bug where an
    ICH7 sata controller is being setup by the BIOS as sub-class 1 (ide)
    and the AHCI control registers weren't being initialized, thus causing
    an IO error in piix_disable_ahci().
    
    Signed-off-by: Gregory Felix <greg.felix@gmail.com>


diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -38,6 +38,7 @@ enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
 	ICH5_PMR		= 0x90, /* port mapping register */
 	ICH5_PCS		= 0x92,	/* port control and status */
+	PIIX_SCC		= 0x0A, /* sub-class code register */
 
 	PIIX_FLAG_AHCI		= (1 << 28), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 29), /* make sure PCI INTx enabled */
@@ -62,6 +63,8 @@ enum {
 	ich6_sata_rm		= 4,
 	ich7_sata		= 5,
 	esb2_sata		= 6,
+
+	PIIX_AHCI_DEVICE	= 6,
 };
 
 static int piix_init_one (struct pci_dev *pdev,
@@ -574,11 +577,11 @@ static int piix_disable_ahci(struct pci_
 	addr = pci_resource_start(pdev, AHCI_PCI_BAR);
 	if (!addr || !pci_resource_len(pdev, AHCI_PCI_BAR))
 		return 0;
-	
+
 	mmio = ioremap(addr, 64);
 	if (!mmio)
 		return -ENOMEM;
-	
+
 	tmp = readl(mmio + AHCI_GLOBAL_CTL);
 	if (tmp & AHCI_ENABLE) {
 		tmp &= ~AHCI_ENABLE;
@@ -588,7 +591,7 @@ static int piix_disable_ahci(struct pci_
 		if (tmp & AHCI_ENABLE)
 			rc = -EIO;
 	}
-	
+
 	iounmap(mmio);
 	return rc;
 }
@@ -626,9 +629,13 @@ static int piix_init_one (struct pci_dev
 	port_info[1] = NULL;
 
 	if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
-		int rc = piix_disable_ahci(pdev);
-		if (rc)
-			return rc;
+               u8 tmp;
+               pci_read_config_byte(pdev, PIIX_SCC, &tmp);
+               if (tmp == PIIX_AHCI_DEVICE) {
+                       int rc = piix_disable_ahci(pdev);
+                       if (rc)
+                           return rc;
+               }
 	}
 
 	if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {

--------------040109040504080202050103--
