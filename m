Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933455AbWKNQJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933455AbWKNQJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933456AbWKNQJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:09:20 -0500
Received: from cantor.suse.de ([195.135.220.2]:14479 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933455AbWKNQJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:09:06 -0500
From: Andi Kleen <ak@suse.de>
References: <20061114508.445749000@suse.de>
In-Reply-To: <20061114508.445749000@suse.de>
To: len.brown@intel.com, patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.19] [7/9] x86: Add acpi_user_timer_override option for Asus boards
Message-Id: <20061114160857.DD78313DE0@wotan.suse.de>
Date: Tue, 14 Nov 2006 17:08:57 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Timer overrides are normally disabled on Nvidia board because
they are commonly wrong, except on new ones with HPET support.
Unfortunately there are quite some Asus boards around that
don't have HPET, but need a timer override.

We don't know yet how to handle this transparently,
but at least add a command line option to force the timer override
and let them boot.

Cc: len.brown@intel.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 Documentation/kernel-parameters.txt |    4 ++++
 arch/i386/kernel/acpi/boot.c        |    8 ++++++++
 arch/i386/kernel/acpi/earlyquirk.c  |    8 +++++++-
 arch/x86_64/kernel/early-quirks.c   |    8 ++++++++
 include/asm-i386/acpi.h             |    1 +
 include/asm-x86_64/acpi.h           |    1 +
 6 files changed, 29 insertions(+), 1 deletion(-)

Index: linux/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/boot.c
+++ linux/arch/i386/kernel/acpi/boot.c
@@ -82,6 +82,7 @@ EXPORT_SYMBOL(acpi_strict);
 acpi_interrupt_flags acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;
 int acpi_skip_timer_override __initdata;
+int acpi_use_timer_override __initdata;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
@@ -1300,6 +1301,13 @@ static int __init parse_acpi_skip_timer_
 	return 0;
 }
 early_param("acpi_skip_timer_override", parse_acpi_skip_timer_override);
+
+static int __init parse_acpi_use_timer_override(char *arg)
+{
+	acpi_use_timer_override = 1;
+	return 0;
+}
+early_param("acpi_use_timer_override", parse_acpi_use_timer_override);
 #endif /* CONFIG_X86_IO_APIC */
 
 static int __init setup_acpi_sci(char *s)
Index: linux/arch/i386/kernel/acpi/earlyquirk.c
===================================================================
--- linux.orig/arch/i386/kernel/acpi/earlyquirk.c
+++ linux/arch/i386/kernel/acpi/earlyquirk.c
@@ -27,11 +27,17 @@ static int __init check_bridge(int vendo
 #ifdef CONFIG_ACPI
 	/* According to Nvidia all timer overrides are bogus unless HPET
 	   is enabled. */
-	if (vendor == PCI_VENDOR_ID_NVIDIA) {
+	if (!acpi_use_timer_override && vendor == PCI_VENDOR_ID_NVIDIA) {
 		nvidia_hpet_detected = 0;
 		acpi_table_parse(ACPI_HPET, nvidia_hpet_check);
 		if (nvidia_hpet_detected == 0) {
 			acpi_skip_timer_override = 1;
+			  printk(KERN_INFO "Nvidia board "
+                       "detected. Ignoring ACPI "
+                       "timer override.\n");
+                printk(KERN_INFO "If you got timer trouble "
+			 	 "try acpi_use_timer_override\n");
+
 		}
 	}
 #endif
Index: linux/arch/x86_64/kernel/early-quirks.c
===================================================================
--- linux.orig/arch/x86_64/kernel/early-quirks.c
+++ linux/arch/x86_64/kernel/early-quirks.c
@@ -45,7 +45,13 @@ static void nvidia_bugs(void)
 	/*
 	 * All timer overrides on Nvidia are
 	 * wrong unless HPET is enabled.
+	 * Unfortunately that's not true on many Asus boards.
+	 * We don't know yet how to detect this automatically, but
+	 * at least allow a command line override.
 	 */
+	if (acpi_use_timer_override)
+		return;
+
 	nvidia_hpet_detected = 0;
 	acpi_table_parse(ACPI_HPET, nvidia_hpet_check);
 	if (nvidia_hpet_detected == 0) {
@@ -53,6 +59,8 @@ static void nvidia_bugs(void)
 		printk(KERN_INFO "Nvidia board "
 		       "detected. Ignoring ACPI "
 		       "timer override.\n");
+		printk(KERN_INFO "If you got timer trouble "
+			"try acpi_use_timer_override\n");
 	}
 #endif
 	/* RED-PEN skip them on mptables too? */
Index: linux/include/asm-i386/acpi.h
===================================================================
--- linux.orig/include/asm-i386/acpi.h
+++ linux/include/asm-i386/acpi.h
@@ -132,6 +132,7 @@ extern int acpi_gsi_to_irq(u32 gsi, unsi
 
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_skip_timer_override;
+extern int acpi_use_timer_override;
 #endif
 
 static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
Index: linux/include/asm-x86_64/acpi.h
===================================================================
--- linux.orig/include/asm-x86_64/acpi.h
+++ linux/include/asm-x86_64/acpi.h
@@ -163,6 +163,7 @@ extern u8 x86_acpiid_to_apicid[];
 #define ARCH_HAS_POWER_INIT 1
 
 extern int acpi_skip_timer_override;
+extern int acpi_use_timer_override;
 
 #endif /*__KERNEL__*/
 
Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt
+++ linux/Documentation/kernel-parameters.txt
@@ -164,6 +164,10 @@ and is between 256 and 4096 characters. 
 	acpi_skip_timer_override [HW,ACPI]
 			Recognize and ignore IRQ0/pin2 Interrupt Override.
 			For broken nForce2 BIOS resulting in XT-PIC timer.
+	acpi_use_timer_override [HW,ACPI}
+			Use timer override. For some broken Nvidia NF5 boards
+			that require a timer override, but don't have
+			HPET
 
 	acpi_dbg_layer=	[HW,ACPI]
 			Format: <int>
