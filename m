Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWIONxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWIONxN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWIONxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:53:12 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46793 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751460AbWIONxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:53:10 -0400
Subject: [PATCH] serverworks: Switch to pci refcounted interfaces
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:16:53 +0100
Message-Id: <1158329813.29932.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we don't support hotplug we end up leaking an isa_dev reference which
if unload was ever added we would drop at the end of unloading. This is
fine because we do genuinely need the isa_dev pointer until unload.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/serverworks.c linux-2.6.18-rc6-mm1/drivers/ide/pci/serverworks.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/ide/pci/serverworks.c	2006-09-11 11:02:12.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/ide/pci/serverworks.c	2006-09-14 17:22:11.000000000 +0100
@@ -359,7 +359,7 @@
 
 	/* OSB4 : South Bridge and IDE */
 	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
-		isa_dev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS,
+		isa_dev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
 			  PCI_DEVICE_ID_SERVERWORKS_OSB4, NULL);
 		if (isa_dev) {
 			pci_read_config_dword(isa_dev, 0x64, &reg);
@@ -380,7 +380,7 @@
 		if (!(PCI_FUNC(dev->devfn) & 1)) {
 			struct pci_dev * findev = NULL;
 			u32 reg4c = 0;
-			findev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS,
+			findev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
 				PCI_DEVICE_ID_SERVERWORKS_CSB5, NULL);
 			if (findev) {
 				pci_read_config_dword(findev, 0x4C, &reg4c);
@@ -388,6 +388,7 @@
 				reg4c |=  0x00000040;
 				reg4c |=  0x00000020;
 				pci_write_config_dword(findev, 0x4C, reg4c);
+				pci_dev_put(findev);
 			}
 			outb_p(0x06, 0x0c00);
 			dev->irq = inb_p(0x0c01);
@@ -395,12 +396,13 @@
 			struct pci_dev * findev = NULL;
 			u8 reg41 = 0;
 
-			findev = pci_find_device(PCI_VENDOR_ID_SERVERWORKS,
+			findev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
 					PCI_DEVICE_ID_SERVERWORKS_CSB6, NULL);
 			if (findev) {
 				pci_read_config_byte(findev, 0x41, &reg41);
 				reg41 &= ~0x40;
 				pci_write_config_byte(findev, 0x41, reg41);
+				pci_dev_put(findev);
 			}
 			/*
 			 * This is a device pin issue on CSB6.

