Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263275AbTFTQPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTFTQPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:15:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8094 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263275AbTFTQP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:15:28 -0400
Date: Fri, 20 Jun 2003 17:29:29 +0100
From: Matthew Wilcox <willy@debian.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI direct access resources
Message-ID: <20030620162929.GT24357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My mummy always taught me to request resources before I used them.
We weren't reserving the 0xc000-0xcfff range before, either.  I
bet not many people use type 2 accesses these days.

Index: arch/i386/pci/direct.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/i386/pci/direct.c,v
retrieving revision 1.6
diff -u -p -r1.6 direct.c
--- arch/i386/pci/direct.c	25 Feb 2003 12:39:09 -0000	1.6
+++ arch/i386/pci/direct.c	20 Jun 2003 14:30:26 -0000
@@ -200,6 +200,7 @@
 
 static int __init pci_direct_init(void)
 {
+	struct resource *region, *region2;
 	unsigned int tmp;
 	unsigned long flags;
 
@@ -237,43 +206,53 @@ static int __init pci_direct_init(void)
 	/*
 	 * Check if configuration type 1 works.
 	 */
-	if (pci_probe & PCI_PROBE_CONF1) {
-		outb (0x01, 0xCFB);
-		tmp = inl (0xCF8);
-		outl (0x80000000, 0xCF8);
-		if (inl (0xCF8) == 0x80000000 &&
-		    pci_sanity_check(&pci_direct_conf1)) {
-			outl (tmp, 0xCF8);
-			local_irq_restore(flags);
-			printk(KERN_INFO "PCI: Using configuration type 1\n");
-			if (!request_region(0xCF8, 8, "PCI conf1"))
-				pci_root_ops = NULL;
-			else
-				pci_root_ops = &pci_direct_conf1;
-			return 0;
-		}
-		outl (tmp, 0xCF8);
+	if (!pci_probe & PCI_PROBE_CONF1)
+		goto type2;
+	region = request_region(0xCF8, 8, "PCI conf1");
+	if (!region)
+		goto type2;
+
+	outb(0x01, 0xCFB);
+	tmp = inl(0xCF8);
+	outl(0x80000000, 0xCF8);
+	if (inl(0xCF8) == 0x80000000 &&
+	    pci_sanity_check(&pci_direct_conf1)) {
+		outl(tmp, 0xCF8);
+		local_irq_restore(flags);
+		printk(KERN_INFO "PCI: Using configuration type 1\n");
+		raw_pci_ops = &pci_direct_conf1;
+		return 0;
 	}
+	outl(tmp, 0xCF8);
+	release_resource(region);
 
+ type2:
 	/*
 	 * Check if configuration type 2 works.
 	 */
-	if (pci_probe & PCI_PROBE_CONF2) {
-		outb (0x00, 0xCFB);
-		outb (0x00, 0xCF8);
-		outb (0x00, 0xCFA);
-		if (inb (0xCF8) == 0x00 && inb (0xCFA) == 0x00 &&
-		    pci_sanity_check(&pci_direct_conf2)) {
-			local_irq_restore(flags);
-			printk(KERN_INFO "PCI: Using configuration type 2\n");
-			if (!request_region(0xCF8, 4, "PCI conf2"))
-				pci_root_ops = NULL;
-			else
-				pci_root_ops = &pci_direct_conf2;
-			return 0;
-		}
-	}
+	if (!pci_probe & PCI_PROBE_CONF2)
+		goto out;
+	region = request_region(0xCF8, 4, "PCI conf2");
+	if (!region)
+		goto out;
+	region2 = request_region(0xC000, 0xfff, "PCI conf2");
+	if (!region2)
+		goto fail2;
+	outb(0x00, 0xCFB);
+	outb(0x00, 0xCF8);
+	outb(0x00, 0xCFA);
+	if (inb(0xCF8) == 0x00 && inb(0xCFA) == 0x00 &&
+	    pci_sanity_check(&pci_direct_conf2)) {
+		local_irq_restore(flags);
+		printk(KERN_INFO "PCI: Using configuration type 2\n");
+		raw_pci_ops = &pci_direct_conf2;
+		return 0;
+	}
+	release_resource(region2);
+ fail2:
+	release_resource(region);
 
+ out:
 	local_irq_restore(flags);
 	return 0;
 }

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
