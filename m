Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263609AbUFBQwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUFBQwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 12:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUFBQwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 12:52:23 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:21953 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S263609AbUFBQwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 12:52:08 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [patch] 2.6.7-rc2-mm1: let SERIAL_8250_ACPI depend on ACPI_PCI
Date: Wed, 2 Jun 2004 10:51:59 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040602003938.GJ25681@fs.tum.de>
In-Reply-To: <20040602003938.GJ25681@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200406021051.59314.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 June 2004 6:39 pm, Adrian Bunk wrote:
> The  PCI IRQ update in the ACPI tree causes the following compile error with CONFIG_PCI=n:
> ...
> drivers/built-in.o(.text+0xfc1c7): In function `acpi_serial_ext_irq':
> : undefined reference to `acpi_register_gsi'
> drivers/built-in.o(.text+0xfc1f6): In function `acpi_serial_irq':
> : undefined reference to `acpi_register_gsi'

As Matthew noted, there's no reason a machine ACPI needs to have
PCI, so I propose the following patch instead.  This just makes
acpi_register_gsi()and acpi_gsi_to_irq() available independent
of CONFIG_PCI.

diff -u -Nur linux-2.6.6/arch/i386/kernel/acpi/boot.c linux-2.6.6-pci-irq/arch/i386/kernel/acpi/boot.c
--- linux-2.6.6/arch/i386/kernel/acpi/boot.c	2004-06-02 10:43:15.000000000 -0600
+++ linux-2.6.6-pci-irq/arch/i386/kernel/acpi/boot.c	2004-06-02 10:41:07.000000000 -0600
@@ -438,23 +438,25 @@
 	return 0;
 }
 
-#ifdef CONFIG_ACPI_PCI
 unsigned int acpi_register_gsi(u32 gsi, int edge_level, int active_high_low)
 {
-	static u16 irq_mask;
 	unsigned int irq;
-	extern void eisa_set_level_irq(unsigned int irq);
 
+#ifdef CONFIG_PCI
 	/*
 	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
 	 */
 	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC) {
+		static u16 irq_mask;
+		extern void eisa_set_level_irq(unsigned int irq);
+
 		if ((gsi < 16) && !((1 << gsi) & irq_mask)) {
 			Dprintk(KERN_DEBUG PREFIX "Setting GSI %u as level-triggered\n", gsi);
 			irq_mask |= (1 << gsi);
 			eisa_set_level_irq(gsi);
 		}
 	}
+#endif
 
 #ifdef CONFIG_X86_IO_APIC
 	if (acpi_irq_model == ACPI_IRQ_MODEL_IOAPIC) {
@@ -464,7 +466,6 @@
 	acpi_gsi_to_irq(gsi, &irq);
 	return irq;
 }
-#endif	/* CONFIG_ACPI_PCI */
 
 static unsigned long __init
 acpi_scan_rsdp (
diff -u -Nur linux-2.6.6/include/linux/acpi.h linux-2.6.6-pci-irq/include/linux/acpi.h
--- linux-2.6.6/include/linux/acpi.h	2004-06-02 10:43:15.000000000 -0600
+++ linux-2.6.6-pci-irq/include/linux/acpi.h	2004-06-02 10:33:57.000000000 -0600
@@ -413,6 +413,8 @@
 
 #endif 	/*!CONFIG_ACPI_BOOT*/
 
+unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
+int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
 #ifdef CONFIG_ACPI_PCI
 
@@ -437,8 +439,6 @@
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
-unsigned int acpi_register_gsi (u32 gsi, int edge_level, int active_high_low);
-int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 
 struct acpi_pci_driver {
 	struct acpi_pci_driver *next;
