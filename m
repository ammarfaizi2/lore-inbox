Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbULQQ7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbULQQ7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbULQQ7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:59:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261909AbULQQ7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:59:05 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org, greg@kroah.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Make pci_set_power_state() check register version
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Fri, 17 Dec 2004 16:58:52 +0000
Message-ID: <24151.1103302732@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes pci_set_power_state() check the PM register version
and ignore non-version 2 registers. Trampling on earlier version PM registers
such as are sported by the Promise 20269 IDE card can cause the system to
hang.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat pci-pm-2610rc3mm1.diff 
 pci.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff -uNrp linux-2.6.10-rc3-mm1-asmoffsets/drivers/pci/pci.c linux-2.6.10-rc3-mm1-debug/drivers/pci/pci.c
--- linux-2.6.10-rc3-mm1-asmoffsets/drivers/pci/pci.c	2004-12-13 14:29:51.000000000 +0000
+++ linux-2.6.10-rc3-mm1-debug/drivers/pci/pci.c	2004-12-17 16:50:09.637295082 +0000
@@ -245,7 +245,7 @@ int
 pci_set_power_state(struct pci_dev *dev, int state)
 {
 	int pm;
-	u16 pmcsr;
+	u16 pmcsr, pmc;
 
 	/* bound the state we're entering */
 	if (state > 3) state = 3;
@@ -265,10 +265,16 @@ pci_set_power_state(struct pci_dev *dev,
 	/* abort if the device doesn't support PM capabilities */
 	if (!pm) return -EIO; 
 
+	pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
+	if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
+		printk(KERN_WARNING
+		       "PCI: %s has unsupported PM cap regs version (%u)\n",
+		       dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
+		return -EIO;
+	}
+
 	/* check if this device supports the desired state */
 	if (state == 1 || state == 2) {
-		u16 pmc;
-		pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
 		if (state == 1 && !(pmc & PCI_PM_CAP_D1)) return -EIO;
 		else if (state == 2 && !(pmc & PCI_PM_CAP_D2)) return -EIO;
 	}
