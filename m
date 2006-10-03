Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030650AbWJCW7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030650AbWJCW7o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030651AbWJCW7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:59:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7660 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030650AbWJCW7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:59:43 -0400
Subject: [PATCH] ide-generic: jmicron fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 00:25:20 +0100
Message-Id: <1159917920.17553.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people find their Jmicron pata port reports its disabled even
though it has devices on it and was boot probed. Fix this

(Candidate for 2.6.18.*, less so for 2.6.19 as we've got a proper
jmicron driver on the merge for that to replace ide-generic support)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm3/drivers/ide/pci/generic.c linux-2.6.18-mm3/drivers/ide/pci/generic.c
--- linux.vanilla-2.6.18-mm3/drivers/ide/pci/generic.c	2006-10-03 19:23:03.166273120 +0100
+++ linux-2.6.18-mm3/drivers/ide/pci/generic.c	2006-10-03 16:57:36.000000000 +0100
@@ -236,11 +236,13 @@
 
 	if (dev->vendor == PCI_VENDOR_ID_JMICRON && PCI_FUNC(dev->devfn) != 1)
 		goto out;
-
-	pci_read_config_word(dev, PCI_COMMAND, &command);
-	if (!(command & PCI_COMMAND_IO)) {
-		printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
-		goto out;
+	
+	if (dev->vendor != PCI_VENDOR_ID_JMICRON) {
+		pci_read_config_word(dev, PCI_COMMAND, &command);
+		if (!(command & PCI_COMMAND_IO)) {
+			printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
+			goto out;
+		}
 	}
 	ret = ide_setup_pci_device(dev, d);
 out:

