Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVKHNqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVKHNqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbVKHNqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:46:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:37804 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964895AbVKHNqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:46:15 -0500
Subject: PATCH: Add enablebits to via driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 14:15:37 +0000
Message-Id: <1131459337.25192.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-mm1/drivers/scsi/pata_via.c linux-2.6.14-mm1/drivers/scsi/pata_via.c
--- linux.vanilla-2.6.14-mm1/drivers/scsi/pata_via.c	2005-11-07 13:06:24.000000000 +0000
+++ linux-2.6.14-mm1/drivers/scsi/pata_via.c	2005-11-07 14:46:43.000000000 +0000
@@ -61,7 +61,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_via"
-#define DRV_VERSION "0.1"
+#define DRV_VERSION "0.1.1"
 
 /*
  *	The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
@@ -148,6 +148,19 @@
  
 static void via_phy_reset(struct ata_port *ap)
 {
+	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
+	
+	/* Note: When we add VIA 6410 remember it doesn't have enable bits */
+	static struct pci_bits via_enable_bits[] = {
+		{ 0x40, 0x02, 0x02 },
+		{ 0x40, 0x01, 0x01 }
+	};
+
+	if (!pci_test_config_bits(pdev, &via_enable_bits[ap->hard_port_no])) {
+		ata_port_disable(ap);
+		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		return;
+	}
 	ap->cbl = via_cable_detect(ap);
 	ata_bus_reset(ap);
 	ata_port_probe(ap);

