Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263426AbVCEAgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263426AbVCEAgh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbVCEATI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:19:08 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:15666 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263427AbVCEAE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:04:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=Prv6ZqjDi3WMnZvHYbaNdZLrp1ixWwetSHaCUi3pc/EYT89py/YCTqmg/UHQxdhNV01bItNH0a+eCWKTFbfAuG75rLwqF22jHm66F9vN+jkPlgW1Q/P08qKwBi5yW0cPPEzBHH+emGa61JXAXK+qvBx1WfrHNyLVI/6bov7gvW0=
Message-ID: <e16ac85e050304160467045421@mail.gmail.com>
Date: Fri, 4 Mar 2005 17:04:55 -0700
From: Greg Felix <gregfelixlkml@gmail.com>
Reply-To: Greg Felix <gregfelixlkml@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] ata_piix.c: check PCI sub-class code before AHCI disabling
Cc: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds functionality to check the PCI sub-class code of an
AHCI capable device before disabling AHCI.  It fixes a bug where an
ICH7 sata controller is being setup by the BIOS as sub-class 1 (ide)
and the AHCI control registers weren't being initialized, thus causing
an IO error in piix_disable_ahci().

Thanks,
Greg Felix


Signed-off-by: Gregory Felix <greg.felix@gmail.com>

--- drivers/scsi/ata_piix.c.orig        2005-03-04 15:25:48.966846795 -0700
+++ drivers/scsi/ata_piix.c     2005-03-04 15:27:55.942404850 -0700
@@ -38,6 +38,7 @@ enum {
        PIIX_IOCFG              = 0x54, /* IDE I/O configuration register */
        ICH5_PMR                = 0x90, /* port mapping register */
        ICH5_PCS                = 0x92, /* port control and status */
+       PIIX_SCC                = 0x0A, /* sub-class code register */

        PIIX_FLAG_AHCI          = (1 << 28), /* AHCI possible */
        PIIX_FLAG_CHECKINTR     = (1 << 29), /* make sure PCI INTx enabled */
@@ -61,6 +62,8 @@ enum {
        ich6_sata               = 3,
        ich6_sata_rm            = 4,
        ich7_sata               = 5,
+
+       PIIX_AHCI_DEVICE        = 6,
 };

 static int piix_init_one (struct pci_dev *pdev,
@@ -609,9 +612,13 @@ static int piix_init_one (struct pci_dev
        port_info[1] = NULL;

        if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
-               int rc = piix_disable_ahci(pdev);
-               if (rc)
-                       return rc;
+               u8 tmp;
+               pci_read_config_byte(pdev, PIIX_SCC, &tmp);
+               if (tmp == PIIX_AHCI_DEVICE) {
+                       int rc = piix_disable_ahci(pdev);
+                       if (rc)
+                           return rc;
+               }
        }

        if (port_info[0]->host_flags & PIIX_FLAG_COMBINED) {
