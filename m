Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVBTTCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVBTTCb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 14:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVBTTCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 14:02:31 -0500
Received: from fsmlabs.com ([168.103.115.128]:43483 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261778AbVBTTAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 14:00:51 -0500
Date: Sun, 20 Feb 2005 12:01:31 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Len Brown <len.brown@intel.com>, bugzilla@emiller.f2s.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH][2.4] Fix timer override on nforce
Message-ID: <Pine.LNX.4.61.0502201157330.26742@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per our discussion, i've ported the 2.6 nforce skip timer override (and 
early PCI access) code to 2.4. This fixes an issue whereupon nforce 
systems have incorrect override values for irq0. Architectures affected 
are i386 and x86_64

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/18 07:53:21-07:00 zwane@montezuma.fsmlabs.com 
#   ACPI skip_timer_override backport from 2.6 including early PCI bridge detection.
# 
# include/asm-x86_64/acpi.h
#   2005/02/18 07:53:18-07:00 zwane@montezuma.fsmlabs.com +1 -0
#   ACPI skip_timer_override backport from 2.6 including early PCI bridge detection.
# 
# include/asm-i386/pci-direct.h
#   2005/02/18 07:53:18-07:00 zwane@montezuma.fsmlabs.com +1 -0
#   ACPI skip_timer_override backport from 2.6 including early PCI bridge detection.
# 
# include/asm-i386/acpi.h
#   2005/02/18 07:53:18-07:00 zwane@montezuma.fsmlabs.com +2 -0
#   ACPI skip_timer_override backport from 2.6 including early PCI bridge detection.
# 
# arch/x86_64/kernel/io_apic.c
#   2005/02/18 07:53:18-07:00 zwane@montezuma.fsmlabs.com +7 -3
#   ACPI skip_timer_override backport from 2.6 including early PCI bridge detection.
# 
# arch/x86_64/kernel/acpi.c
#   2005/02/18 07:53:18-07:00 zwane@montezuma.fsmlabs.com +7 -0
#   ACPI skip_timer_override backport from 2.6 including early PCI bridge detection.
# 
# arch/i386/kernel/earlyquirk.c
#   2005/02/18 07:53:18-07:00 zwane@montezuma.fsmlabs.com +53 -0
#   ACPI skip_timer_override backport from 2.6 including early PCI bridge detection.
# 
# arch/i386/kernel/acpi.c
#   2005/02/18 07:53:18-07:00 zwane@montezuma.fsmlabs.com +9 -0
#   ACPI skip_timer_override backport from 2.6 including early PCI bridge detection.
# 
# arch/i386/kernel/Makefile
#   2005/02/18 07:53:18-07:00 zwane@montezuma.fsmlabs.com +1 -1
#   ACPI skip_timer_override backport from 2.6 including early PCI bridge detection.
# 
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	2005-02-18 07:53:58 -07:00
+++ b/arch/i386/kernel/Makefile	2005-02-18 07:53:58 -07:00
@@ -40,7 +40,7 @@
 obj-$(CONFIG_ACPI_SLEEP)	+= acpi_wakeup.o
 obj-$(CONFIG_SMP)		+= smp.o smpboot.o trampoline.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= mpparse.o apic.o nmi.o
-obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
+obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o earlyquirk.o
 obj-$(CONFIG_X86_VISWS_APIC)	+= visws_apic.o
 obj-$(CONFIG_EDD)             	+= edd.o
 
diff -Nru a/arch/i386/kernel/acpi.c b/arch/i386/kernel/acpi.c
--- a/arch/i386/kernel/acpi.c	2005-02-18 07:53:58 -07:00
+++ b/arch/i386/kernel/acpi.c	2005-02-18 07:53:58 -07:00
@@ -55,6 +55,7 @@
 
 acpi_interrupt_flags acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;
+int acpi_skip_timer_override __initdata;
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
    -------------------------------------------------------------------------- */
@@ -320,6 +321,12 @@
 		return 0;
 	}
 
+	if (acpi_skip_timer_override &&
+		intsrc->bus_irq == 0 && intsrc->global_irq == 2) {
+		printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
+		return 0;
+	}
+
 	mp_override_legacy_irq (
 		intsrc->bus_irq,
 		intsrc->flags.polarity,
@@ -433,6 +440,8 @@
 		return result;
 	}
 
+	check_acpi_pci();
+	
 	result = acpi_blacklisted();
 	if (result) {
 		printk(KERN_NOTICE PREFIX "BIOS listed in blacklist, disabling ACPI support\n");
diff -Nru a/arch/i386/kernel/earlyquirk.c b/arch/i386/kernel/earlyquirk.c
--- a/arch/i386/kernel/earlyquirk.c	2005-02-18 07:53:58 -07:00
+++ b/arch/i386/kernel/earlyquirk.c	2005-02-18 07:53:58 -07:00
@@ -0,0 +1,53 @@
+/* 
+ * Do early PCI probing for bug detection when the main PCI subsystem is 
+ * not up yet.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <asm/pci-direct.h>
+#include <asm/acpi.h>
+
+#ifdef CONFIG_ACPI
+static int __init check_bridge(int vendor, int device) 
+{
+	/* According to Nvidia all timer overrides are bogus. Just ignore
+	   them all. */
+	if (vendor == PCI_VENDOR_ID_NVIDIA) { 
+		acpi_skip_timer_override = 1; 		
+	}
+	return 0;
+}
+   
+void __init check_acpi_pci(void) 
+{ 
+	int num,slot,func; 
+
+	/* Assume the machine supports type 1. If not it will 
+	   always read ffffffff and should not have any side effect. */
+
+	/* Poor man's PCI discovery */
+	for (num = 0; num < 32; num++) { 
+		for (slot = 0; slot < 32; slot++) { 
+			for (func = 0; func < 8; func++) { 
+				u32 class;
+				u32 vendor;
+				class = read_pci_config(num,slot,func,
+							PCI_CLASS_REVISION);
+				if (class == 0xffffffff)
+					break; 
+
+				if ((class >> 16) != PCI_CLASS_BRIDGE_PCI)
+					continue; 
+				
+				vendor = read_pci_config(num, slot, func, 
+							 PCI_VENDOR_ID);
+				
+				if (check_bridge(vendor&0xffff, vendor >> 16))
+					return; 
+			} 
+			
+		}
+	}
+}
+#endif /* CONFIG_ACPI */
diff -Nru a/arch/x86_64/kernel/acpi.c b/arch/x86_64/kernel/acpi.c
--- a/arch/x86_64/kernel/acpi.c	2005-02-18 07:53:58 -07:00
+++ b/arch/x86_64/kernel/acpi.c	2005-02-18 07:53:58 -07:00
@@ -53,6 +53,7 @@
 
 acpi_interrupt_flags acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;
+int acpi_skip_timer_override __initdata;
 /* --------------------------------------------------------------------------
                               Boot-time Configuration
    -------------------------------------------------------------------------- */
@@ -330,6 +331,12 @@
 	if (intsrc->bus_irq == acpi_fadt.sci_int) {
 		acpi_sci_ioapic_setup(intsrc->global_irq,
 			intsrc->flags.polarity, intsrc->flags.trigger);
+		return 0;
+	}
+
+	if (acpi_skip_timer_override &&
+		intsrc->bus_irq == 0 && intsrc->global_irq == 2) {
+		printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
 		return 0;
 	}
 
diff -Nru a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
--- a/arch/x86_64/kernel/io_apic.c	2005-02-18 07:53:58 -07:00
+++ b/arch/x86_64/kernel/io_apic.c	2005-02-18 07:53:58 -07:00
@@ -259,10 +259,14 @@
 				case PCI_VENDOR_ID_VIA:
 					return;
 				case PCI_VENDOR_ID_NVIDIA: 
+#ifdef CONFIG_ACPI
+				/* All timer overrides on Nvidia
+				   seem to be wrong. Skip them. */
+					acpi_skip_timer_override = 1;
 					printk(KERN_INFO 
-     "PCI bridge %02x:%02x from %x found. Setting \"noapic\". Overwrite with \"apic\"\n",
-					       num,slot,vendor); 
-					skip_ioapic_setup = 1;
+			"Nvidia board detected. Ignoring ACPI timer override.\n");
+#endif
+					/* RED-PEN skip them on mptables too? */
 					return;
 				} 
 
diff -Nru a/include/asm-i386/acpi.h b/include/asm-i386/acpi.h
--- a/include/asm-i386/acpi.h	2005-02-18 07:53:58 -07:00
+++ b/include/asm-i386/acpi.h	2005-02-18 07:53:58 -07:00
@@ -121,6 +121,8 @@
 extern int acpi_strict;
 extern int acpi_disabled;
 extern int acpi_ht;
+extern int acpi_skip_timer_override;
+void __init check_acpi_pci(void);
 static inline void disable_acpi(void) 
 { 
 	acpi_disabled = 1;
diff -Nru a/include/asm-i386/pci-direct.h b/include/asm-i386/pci-direct.h
--- a/include/asm-i386/pci-direct.h	2005-02-18 07:53:58 -07:00
+++ b/include/asm-i386/pci-direct.h	2005-02-18 07:53:58 -07:00
@@ -0,0 +1 @@
+#include "asm-x86_64/pci-direct.h"
diff -Nru a/include/asm-x86_64/acpi.h b/include/asm-x86_64/acpi.h
--- a/include/asm-x86_64/acpi.h	2005-02-18 07:53:58 -07:00
+++ b/include/asm-x86_64/acpi.h	2005-02-18 07:53:58 -07:00
@@ -118,6 +118,7 @@
 extern int acpi_strict;
 extern int acpi_disabled;
 extern int acpi_ht;
+extern int acpi_skip_timer_override;
 static inline void disable_acpi(void) 
 { 
 	acpi_disabled = 1;
