Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbUKLXbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbUKLXbs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbUKLX3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:29:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:505 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262694AbUKLXWq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:46 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017153578@kroah.com>
Date: Fri, 12 Nov 2004 15:21:55 -0800
Message-Id: <11003017152249@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.35.4, 2004/10/28 15:56:14-05:00, akpm@osdl.org

[PATCH] PCI: remove unconditional PCI ACPI IRQ routing

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Now that PCI interrupts are routed in pci_enable_device(), remove the
unconditional routing previously done in pci_acpi_init().

This has the potential to break drivers that don't use pci_enable_device()
correctly, so I also added a "pci=routeirq" kernel option that restores the
previous behavior.  I intend to remove that option, along with all the code
below, in a month or so.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/kernel-parameters.txt |    4 ++++
 arch/i386/pci/acpi.c                |   30 ++++++++++++++++++++++--------
 arch/i386/pci/common.c              |    4 ++++
 arch/ia64/pci/pci.c                 |   33 ++++++++++++++++++++++++++-------
 4 files changed, 56 insertions(+), 15 deletions(-)


diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-11-12 15:14:28 -08:00
+++ b/Documentation/kernel-parameters.txt	2004-11-12 15:14:28 -08:00
@@ -912,6 +912,10 @@
 					enabled.
 		noacpi			[IA-32] Do not use ACPI for IRQ routing
 					or for PCI scanning.
+		routeirq		Do IRQ routing for all PCI devices.
+					This is normally done in pci_enable_device(),
+					so this option is a temporary workaround
+					for broken drivers that don't call it.
 
 		firmware		[ARM] Do not re-enumerate the bus but
 					instead just use the configuration
diff -Nru a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
--- a/arch/i386/pci/acpi.c	2004-11-12 15:14:28 -08:00
+++ b/arch/i386/pci/acpi.c	2004-11-12 15:14:28 -08:00
@@ -15,6 +15,7 @@
 	return pcibios_scan_root(busnum);
 }
 
+extern int pci_routeirq;
 static int __init pci_acpi_init(void)
 {
 	struct pci_dev *dev = NULL;
@@ -30,14 +31,27 @@
 	pcibios_scanned++;
 	pcibios_enable_irq = acpi_pci_irq_enable;
 
-	/*
-	 * PCI IRQ routing is set up by pci_enable_device(), but we
-	 * also do it here in case there are still broken drivers that
-	 * don't use pci_enable_device().
-	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
-		acpi_pci_irq_enable(dev);
-
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
 		print_IO_APIC();
diff -Nru a/arch/i386/pci/common.c b/arch/i386/pci/common.c
--- a/arch/i386/pci/common.c	2004-11-12 15:14:28 -08:00
+++ b/arch/i386/pci/common.c	2004-11-12 15:14:28 -08:00
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
diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	2004-11-12 15:14:28 -08:00
+++ b/arch/ia64/pci/pci.c	2004-11-12 15:14:28 -08:00
@@ -46,6 +46,8 @@
 #define DBG(x...)
 #endif
 
+static int pci_routeirq;
+
 /*
  * Low-level SAL-based PCI configuration access functions. Note that SAL
  * calls are already serialized (via sal_lock), so we don't need another
@@ -141,13 +143,28 @@
 
 	acpi_get_devices(NULL, acpi_map_iosapic, NULL, NULL);
 #endif
-	/*
-	 * PCI IRQ routing is set up by pci_enable_device(), but we
-	 * also do it here in case there are still broken drivers that
-	 * don't use pci_enable_device().
-	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
-		acpi_pci_irq_enable(dev);
+
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
@@ -443,6 +460,8 @@
 char * __init
 pcibios_setup (char *str)
 {
+	if (!strcmp(str, "routeirq"))
+		pci_routeirq = 1;
 	return NULL;
 }
 

