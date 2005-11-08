Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVKHNnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVKHNnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVKHNnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:43:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:42966 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932378AbVKHNni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:43:38 -0500
Subject: PATCH: Add enablebits support to the triflex driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 14:14:28 +0000
Message-Id: <1131459268.25192.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-mm1/drivers/scsi/pata_triflex.c linux-2.6.14-mm1/drivers/scsi/pata_triflex.c
--- linux.vanilla-2.6.14-mm1/drivers/scsi/pata_triflex.c	2005-11-07 13:06:24.000000000 +0000
+++ linux-2.6.14-mm1/drivers/scsi/pata_triflex.c	2005-11-07 14:45:02.000000000 +0000
@@ -44,10 +44,21 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_triflex"
-#define DRV_VERSION "0.2"
+#define DRV_VERSION "0.2.1"
 
 static void triflex_phy_reset(struct ata_port *ap)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	static struct pci_bits triflex_enable_bits[] = {
+		{ 0x80, 0x01, 0x01 },
+		{ 0x80, 0x02, 0x02 }
+	};
+
+	if (!pci_test_config_bits(pdev, &triflex_enable_bits[ap->hard_port_no])) {
+		ata_port_disable(ap);
+		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		return;
+	}
 	ap->cbl = ATA_CBL_PATA40;
 	ata_port_probe(ap);
 	ata_bus_reset(ap);

