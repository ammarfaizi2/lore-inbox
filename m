Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbTGDCIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbTGDB6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:58:03 -0400
Received: from granite.he.net ([216.218.226.66]:26638 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265662AbTGDByy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:54 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845532869@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845531561@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:13 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1367, 2003/07/03 15:51:45-07:00, willy@debian.org

[PATCH] PCI: arch/i386/pci/irq.c should use pci_find_bus
Use pci_find_bus rather than relying on the return value of pci_scan_bus.


 arch/i386/pci/irq.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	Thu Jul  3 18:16:48 2003
+++ b/arch/i386/pci/irq.c	Thu Jul  3 18:16:48 2003
@@ -102,13 +102,12 @@
 #endif
 		busmap[e->bus] = 1;
 	}
-	for(i=1; i<256; i++)
-		/*
-		 *  It might be a secondary bus, but in this case its parent is already
-		 *  known (ascending bus order) and therefore pci_scan_bus returns immediately.
-		 */
-		if (busmap[i] && pci_scan_bus(i, &pci_root_ops, NULL))
+	for(i = 1; i < 256; i++) {
+		if (!busmap[i] || pci_find_bus(0, i))
+			continue;
+		if (pci_scan_bus(i, &pci_root_ops, NULL))
 			printk(KERN_INFO "PCI: Discovered primary peer bus %02x [IRQ]\n", i);
+	}
 	pcibios_last_bus = -1;
 }
 

