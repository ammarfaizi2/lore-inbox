Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTF0Coj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 22:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTF0Cnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 22:43:49 -0400
Received: from granite.he.net ([216.218.226.66]:40719 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263459AbTF0CnA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 22:43:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10566751054129@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.73
In-Reply-To: <10566751051325@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jun 2003 17:51:45 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1503, 2003/06/26 17:27:29-07:00, willy@debian.org

[PATCH] PCI: i386/pci/direct.c fixes

 - Request resources before using them
 - Don't allocate GFP_KERNEL memory with interrupts disabled
 - Split pci_direct_init() into three functions to prevent it from
   getting too long.


 arch/i386/pci/direct.c |  106 +++++++++++++++++++++++++++++++------------------
 1 files changed, 68 insertions(+), 38 deletions(-)


diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Thu Jun 26 17:38:57 2003
+++ b/arch/i386/pci/direct.c	Thu Jun 26 17:38:57 2003
@@ -201,54 +201,84 @@
 	return 0;
 }
 
-static int __init pci_direct_init(void)
+static int __init pci_check_type1(void)
 {
-	unsigned int tmp;
 	unsigned long flags;
+	unsigned int tmp;
+	int works = 0;
 
 	local_irq_save(flags);
 
-	/*
-	 * Check if configuration type 1 works.
-	 */
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
-				raw_pci_ops = NULL;
-			else
-				raw_pci_ops = &pci_direct_conf1;
-			return 0;
-		}
-		outl (tmp, 0xCF8);
+	outb(0x01, 0xCFB);
+	tmp = inl(0xCF8);
+	outl(0x80000000, 0xCF8);
+	if (inl(0xCF8) == 0x80000000 && pci_sanity_check(&pci_direct_conf1)) {
+		works = 1;
 	}
+	outl(tmp, 0xCF8);
+	local_irq_restore(flags);
+
+	return works;
+}
 
-	/*
-	 * Check if configuration type 2 works.
-	 */
-	if (pci_probe & PCI_PROBE_CONF2) {
-		outb (0x00, 0xCFB);
-		outb (0x00, 0xCF8);
-		outb (0x00, 0xCFA);
-		if (inb (0xCF8) == 0x00 && inb (0xCFA) == 0x00 &&
-		    pci_sanity_check(&pci_direct_conf2)) {
-			local_irq_restore(flags);
-			printk(KERN_INFO "PCI: Using configuration type 2\n");
-			if (!request_region(0xCF8, 4, "PCI conf2"))
-				raw_pci_ops = NULL;
-			else
-				raw_pci_ops = &pci_direct_conf2;
-			return 0;
-		}
+static int __init pci_check_type2(void)
+{
+	unsigned long flags;
+	int works = 0;
+
+	local_irq_save(flags);
+
+	outb(0x00, 0xCFB);
+	outb(0x00, 0xCF8);
+	outb(0x00, 0xCFA);
+	if (inb(0xCF8) == 0x00 && inb(0xCFA) == 0x00 &&
+	    pci_sanity_check(&pci_direct_conf2)) {
+		works = 1;
 	}
 
 	local_irq_restore(flags);
+
+	return works;
+}
+
+static int __init pci_direct_init(void)
+{
+	struct resource *region, *region2;
+
+	if ((pci_probe & PCI_PROBE_CONF1) == 0)
+		goto type2;
+	region = request_region(0xCF8, 8, "PCI conf1");
+	if (!region)
+		goto type2;
+
+	if (pci_check_type1()) {
+		printk(KERN_INFO "PCI: Using configuration type 1\n");
+		raw_pci_ops = &pci_direct_conf1;
+		return 0;
+	}
+	release_resource(region);
+
+ type2:
+	if ((!pci_probe & PCI_PROBE_CONF2) == 0)
+		goto out;
+	region = request_region(0xCF8, 4, "PCI conf2");
+	if (!region)
+		goto out;
+	region2 = request_region(0xC000, 0x1000, "PCI conf2");
+	if (!region2)
+		goto fail2;
+
+	if (pci_check_type2()) {
+		printk(KERN_INFO "PCI: Using configuration type 2\n");
+		raw_pci_ops = &pci_direct_conf2;
+		return 0;
+	}
+
+	release_resource(region2);
+ fail2:
+	release_resource(region);
+
+ out:
 	return 0;
 }
 

