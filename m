Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269897AbUJTEKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269897AbUJTEKw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 00:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270210AbUJSXjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:39:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:8074 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270118AbUJSWqc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:32 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257353938@kroah.com>
Date: Tue, 19 Oct 2004 15:42:15 -0700
Message-Id: <10982257352551@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.26, 2004/10/06 12:25:27-07:00, greg@kroah.com

[PATCH] PCI: get rid of pci_find_device() from arch/i386/*

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c |    3 ++-
 arch/i386/kernel/cpu/cyrix.c              |   12 ++++++++++--
 arch/i386/pci/acpi.c                      |    2 +-
 arch/i386/pci/i386.c                      |    4 ++--
 arch/i386/pci/irq.c                       |   20 +++++++++++++-------
 5 files changed, 28 insertions(+), 13 deletions(-)


diff -Nru a/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c b/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
--- a/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2004-10-19 15:25:25 -07:00
+++ b/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2004-10-19 15:25:25 -07:00
@@ -199,7 +199,7 @@
 	}
 
 	/* detect which companion chip is used */
-	while ((gx_pci = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, gx_pci)) != NULL) {
+	while ((gx_pci = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, gx_pci)) != NULL) {
 		if ((pci_match_device (gx_chipset_tbl, gx_pci)) != NULL) {
 			return gx_pci;
 		}
@@ -499,6 +499,7 @@
 static void __exit cpufreq_gx_exit(void)
 {
 	cpufreq_unregister_driver(&gx_suspmod_driver);
+	pci_dev_put(gx_params->cs55x0);
 	kfree(gx_params);
 }
 
diff -Nru a/arch/i386/kernel/cpu/cyrix.c b/arch/i386/kernel/cpu/cyrix.c
--- a/arch/i386/kernel/cpu/cyrix.c	2004-10-19 15:25:25 -07:00
+++ b/arch/i386/kernel/cpu/cyrix.c	2004-10-19 15:25:25 -07:00
@@ -192,6 +192,7 @@
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
 	char *buf = c->x86_model_id;
 	const char *p = NULL;
+	struct pci_dev *dev;
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
@@ -274,9 +275,16 @@
 		/*
 		 *  The 5510/5520 companion chips have a funky PIT.
 		 */  
-		if (pci_find_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510, NULL) ||
-		    pci_find_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL))
+		dev = pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510, NULL);
+		if (dev) {
+			pci_dev_put(dev);
 			pit_latch_buggy = 1;
+		}
+		dev =  pci_find_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL);
+		if (dev) {
+			pci_dev_put(dev);
+			pit_latch_buggy = 1;
+		}
 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
diff -Nru a/arch/i386/pci/acpi.c b/arch/i386/pci/acpi.c
--- a/arch/i386/pci/acpi.c	2004-10-19 15:25:25 -07:00
+++ b/arch/i386/pci/acpi.c	2004-10-19 15:25:25 -07:00
@@ -35,7 +35,7 @@
 	 * also do it here in case there are still broken drivers that
 	 * don't use pci_enable_device().
 	 */
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL)
 		acpi_pci_irq_enable(dev);
 
 #ifdef CONFIG_X86_IO_APIC
diff -Nru a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c	2004-10-19 15:25:25 -07:00
+++ b/arch/i386/pci/i386.c	2004-10-19 15:25:25 -07:00
@@ -124,7 +124,7 @@
 	u16 command;
 	struct resource *r, *pr;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		for(idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -168,7 +168,7 @@
 	int idx;
 	struct resource *r;
 
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		int class = dev->class >> 8;
 
 		/* Don't touch classless devices and host bridges */
diff -Nru a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
--- a/arch/i386/pci/irq.c	2004-10-19 15:25:25 -07:00
+++ b/arch/i386/pci/irq.c	2004-10-19 15:25:25 -07:00
@@ -455,12 +455,18 @@
 
 static __init int intel_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
+	struct pci_dev *dev1, *dev2;
+
 	/* 440GX has a proprietary PIRQ router -- don't use it */
-	if (	pci_find_device(PCI_VENDOR_ID_INTEL,
-				PCI_DEVICE_ID_INTEL_82443GX_0, NULL) ||
-		pci_find_device(PCI_VENDOR_ID_INTEL,
-				PCI_DEVICE_ID_INTEL_82443GX_2, NULL))
+	dev1 = pci_get_device(PCI_VENDOR_ID_INTEL,
+				PCI_DEVICE_ID_INTEL_82443GX_0, NULL);
+	dev2 = pci_get_device(PCI_VENDOR_ID_INTEL,
+				PCI_DEVICE_ID_INTEL_82443GX_2, NULL);
+	if ((dev1 != NULL) || (dev2 != NULL)) {
+		pci_dev_put(dev1);
+		pci_dev_put(dev2);
 		return 0;
+	}
 
 	switch(device)
 	{
@@ -804,7 +810,7 @@
 	printk(KERN_INFO "PCI: %s IRQ %d for device %s\n", msg, irq, pci_name(dev));
 
 	/* Update IRQ for all devices with the same pirq value */
-	while ((dev2 = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev2)) != NULL) {
+	while ((dev2 = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev2)) != NULL) {
 		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin);
 		if (!pin)
 			continue;
@@ -838,7 +844,7 @@
 	u8 pin;
 
 	DBG("PCI: IRQ fixup\n");
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		/*
 		 * If the BIOS has set an out of range IRQ number, just ignore it.
 		 * Also keep track of which IRQ's are already in use.
@@ -854,7 +860,7 @@
 	}
 
 	dev = NULL;
-	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
 		pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 #ifdef CONFIG_X86_IO_APIC
 		/*

