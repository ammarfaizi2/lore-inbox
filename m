Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWILPwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWILPwq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWILPwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:52:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19428 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751423AbWILPwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:52:17 -0400
Subject: [PATCH] pata_amd: Check enable bits on Nvidia
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 12 Sep 2006 17:14:03 +0100
Message-Id: <1158077643.6780.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of people reported long delays on probe with the newer kernels
and Nvidia PATA. This turned out to be because the Nvidia path forgot to
check the enable bits so probed empty ports.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ata/pata_amd.c linux-2.6.18-rc6-mm1/drivers/ata/pata_amd.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/ata/pata_amd.c	2006-09-11 17:00:08.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/ata/pata_amd.c	2006-09-11 17:17:19.000000000 +0100
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_amd"
-#define DRV_VERSION "0.2.2"
+#define DRV_VERSION "0.2.3"
 
 /**
  *	timing_setup		-	shared timing computation and load
@@ -253,11 +253,22 @@
 
 static int nv_pre_reset(struct ata_port *ap) {
 	static const u8 bitmask[2] = {0x03, 0xC0};
+	static const struct pci_bits nv_enable_bits[] = {
+		{ 0x50, 1, 0x02, 0x02 },
+		{ 0x50, 1, 0x01, 0x01 }
+	};
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u8 ata66;
 	u16 udma;
 
+	if (!pci_test_config_bits(pdev, &nv_enable_bits[ap->port_no])) {
+		ata_port_disable(ap);
+		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+		return 0;
+	}
+
+
 	pci_read_config_byte(pdev, 0x52, &ata66);
 	if (ata66 & bitmask[ap->port_no])
 		ap->cbl = ATA_CBL_PATA80;

