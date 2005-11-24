Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbVKXFoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbVKXFoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbVKXFoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:44:34 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:43151 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1161008AbVKXFod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:44:33 -0500
Date: Thu, 24 Nov 2005 05:44:31 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Disable APIC pin 1 on dodgy ATI chipsets
Message-ID: <20051124054430.GC28070@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ATI's AMD64 chipsets appear to have the interesting "feature" that every 
timer tick causes an interrupt from both the APIC and the legacy PIC. 
The following patch checks if the northbridge matches the affected 
chipsets, and if so disables APIC pin 1. As an added bonus, it skips the 
acpi timer override since I haven't found one of these machines where 
it's needed and it's actively harmful on at least some of them. We've 
been shipping this patch in Ubuntu with no reported issues.

This is kernel bugzilla number 3927.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.og>

--- io_apic.c.orig	2005-09-20 21:43:42.000000000 +0100
+++ a/arch/x86_64/kernel/io_apic.c	2005-09-20 22:33:42.000000000 +0100
@@ -45,6 +45,7 @@
 int sis_apic_bug; /* not actually supported, dummy for compile */
 
 static int no_timer_check;
+static int disable_timer_pin_1;
 
 static DEFINE_SPINLOCK(ioapic_lock);
 
@@ -258,18 +259,24 @@ void __init check_ioapic(void) 
 			for (func = 0; func < 8; func++) { 
 				u32 class;
 				u32 vendor;
+				u16 product;
 				u8 type;
 				class = read_pci_config(num,slot,func,
 							PCI_CLASS_REVISION);
+
 				if (class == 0xffffffff)
 					break; 
 
-		       		if ((class >> 16) != PCI_CLASS_BRIDGE_PCI)
+		       		if ((class >> 16) != PCI_CLASS_BRIDGE_PCI && 
+				    (class >> 16) != PCI_CLASS_BRIDGE_HOST)
 					continue; 
 
 				vendor = read_pci_config(num, slot, func, 
 							 PCI_VENDOR_ID);
 				vendor &= 0xffff;
+				
+				product = read_pci_config_16(num, slot, func,
+							  PCI_DEVICE_ID);
 				switch (vendor) { 
 				case PCI_VENDOR_ID_VIA:
 #ifdef CONFIG_GART_IOMMU
@@ -292,8 +299,18 @@ void __init check_ioapic(void) 
 #endif
 					/* RED-PEN skip them on mptables too? */
 					return;
-				} 
 
+				case PCI_VENDOR_ID_ATI:
+					if (product==0x5950 || product==0x5951) {
+						printk(KERN_INFO "ATI board detected - disabling APIC pin 1\n");
+#ifdef CONFIG_ACPI
+						/* This seems to be wrong, too */
+						acpi_skip_timer_override = 1;
+#endif
+						disable_timer_pin_1 = 1;
+					}
+					return;
+				}
 				/* No multi-function device? */
 				type = read_pci_config_byte(num,slot,func,
 							    PCI_HEADER_TYPE);

-- 
Matthew Garrett | mjg59@srcf.ucam.org
