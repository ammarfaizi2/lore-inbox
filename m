Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUHEUIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUHEUIk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267933AbUHEUIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:08:39 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:52936 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S267940AbUHEUGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:06:33 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove unconditional PCI ACPI IRQ routing
Date: Thu, 5 Aug 2004 14:06:24 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408051406.24785.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that PCI interrupts are routed in pci_enable_device(), remove
the unconditional routing previously done in pci_acpi_init().

This has the potential to break drivers that don't use
pci_enable_device() correctly, so I also added a "pci=routeirq"
kernel option that restores the previous behavior.  I intend to
remove that option, along with all the code below, in a month
or so.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== Documentation/kernel-parameters.txt 1.43 vs edited =====
--- 1.43/Documentation/kernel-parameters.txt	2004-07-11 03:23:28 -06:00
+++ edited/Documentation/kernel-parameters.txt	2004-08-05 12:46:55 -06:00
@@ -851,6 +851,10 @@
 					enabled.
 		noacpi			[IA-32] Do not use ACPI for IRQ routing
 					or for PCI scanning.
+		routeirq		Do IRQ routing for all PCI devices.
+					This is normally done in pci_enable_device(),
+					so this option is a temporary workaround
+					for broken drivers that don't call it.
 
 	pcmv=		[HW,PCMCIA] BadgePAD 4
 
===== arch/i386/pci/acpi.c 1.14 vs edited =====
--- 1.14/arch/i386/pci/acpi.c	2004-05-24 23:32:34 -06:00
+++ edited/arch/i386/pci/acpi.c	2004-08-05 13:46:56 -06:00
@@ -15,6 +15,7 @@
 	return pcibios_scan_root(busnum);
 }
 
+extern int pci_routeirq;
 static int __init pci_acpi_init(void)
 {
 	struct pci_dev *dev = NULL;
@@ -30,13 +31,27 @@
 	pcibios_scanned++;
 	pcibios_enable_irq = acpi_pci_irq_enable;
 
-	/*
-	 * PCI IRQ routing is set up by pci_enable_device(), but we
-	 * also do it here in case there are still broken drivers that
-	 * don't use pci_enable_device().
-	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
-		acpi_pci_irq_enable(dev);
+	if (pci_routeirq) {
+		/*
+		 * PCI IRQ routing is set up by pci_enable_device(), but we
+		 * also do it here in case there are still broken drivers that
+		 * don't use pci_enable_device().
+		 */
+		printk(KERN_INFO "** Routing PCI interrupts for all devices because \"pci=routeirq\"\n");
+		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
+		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
+		printk(KERN_INFO "** so I can fix the driver.\n");
+		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+			acpi_pci_irq_enable(dev);
+	} else {
+		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");
+		printk(KERN_INFO "** causes a device to stop working, it is probably because the\n");
+		printk(KERN_INFO "** driver failed to call pci_enable_device().  As a temporary\n");
+		printk(KERN_INFO "** workaround, the \"pci=routeirq\" argument restores the old\n");
+		printk(KERN_INFO "** behavior.  If this argument makes the device work again,\n");
+		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
+		printk(KERN_INFO "** so I can fix the driver.\n");
+	}
 
 #ifdef CONFIG_X86_IO_APIC
 	if (acpi_ioapic)
===== arch/i386/pci/common.c 1.43 vs edited =====
--- 1.43/arch/i386/pci/common.c	2004-02-29 23:20:00 -07:00
+++ edited/arch/i386/pci/common.c	2004-08-05 12:46:55 -06:00
@@ -23,6 +23,7 @@
 unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
 				PCI_PROBE_MMCONF;
 
+int pci_routeirq;
 int pcibios_last_bus = -1;
 struct pci_bus *pci_root_bus = NULL;
 struct pci_raw_ops *raw_pci_ops;
@@ -226,6 +227,9 @@
 		return NULL;
 	} else if (!strcmp(str, "assign-busses")) {
 		pci_probe |= PCI_ASSIGN_ALL_BUSSES;
+		return NULL;
+	} else if (!strcmp(str, "routeirq")) {
+		pci_routeirq = 1;
 		return NULL;
 	}
 	return str;
===== arch/ia64/pci/pci.c 1.50 vs edited =====
--- 1.50/arch/ia64/pci/pci.c	2004-06-16 23:42:37 -06:00
+++ edited/arch/ia64/pci/pci.c	2004-08-05 13:48:39 -06:00
@@ -46,6 +46,8 @@
 #define DBG(x...)
 #endif
 
+static int pci_routeirq;
+
 struct pci_fixup pcibios_fixups[1];
 
 /*
@@ -138,13 +140,27 @@
 
 	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
 
-	/*
-	 * PCI IRQ routing is set up by pci_enable_device(), but we
-	 * also do it here in case there are still broken drivers that
-	 * don't use pci_enable_device().
-	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
-		acpi_pci_irq_enable(dev);
+	if (pci_routeirq) {
+		/*
+		 * PCI IRQ routing is set up by pci_enable_device(), but we
+		 * also do it here in case there are still broken drivers that
+		 * don't use pci_enable_device().
+		 */
+		printk(KERN_INFO "** Routing PCI interrupts for all devices because \"pci=routeirq\"\n");
+		printk(KERN_INFO "** was specified.  If this was required to make a driver work,\n");
+		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
+		printk(KERN_INFO "** so I can fix the driver.\n");
+		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+			acpi_pci_irq_enable(dev);
+	} else {
+		printk(KERN_INFO "** PCI interrupts are no longer routed automatically.  If this\n");
+		printk(KERN_INFO "** causes a device to stop working, it is probably because the\n");
+		printk(KERN_INFO "** driver failed to call pci_enable_device().  As a temporary\n");
+		printk(KERN_INFO "** workaround, the \"pci=routeirq\" argument restores the old\n");
+		printk(KERN_INFO "** behavior.  If this argument makes the device work again,\n");
+		printk(KERN_INFO "** please email the output of \"lspci\" to bjorn.helgaas@hp.com\n");
+		printk(KERN_INFO "** so I can fix the driver.\n");
+	}
 
 	return 0;
 }
@@ -440,6 +456,8 @@
 char * __init
 pcibios_setup (char *str)
 {
+	if (!strcmp(str, "routeirq"))
+		pci_routeirq = 1;
 	return NULL;
 }
 
