Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUJMX7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUJMX7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269769AbUJMX7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:59:39 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:61957 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267678AbUJMX7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:59:15 -0400
Date: Thu, 14 Oct 2004 00:59:13 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "mobil@wodkahexe.de" <mobil@wodkahexe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
In-Reply-To: <20041012195448.2eaabcea.mobil@wodkahexe.de>
Message-ID: <Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, mobil@wodkahexe.de wrote:

> after upgrading to 2.6.9-rc4 I'm getting the following message in dmesg:
> 
> No local APIC present or hardware disabled
> 
> 2.6.9-rc3 and older kernels did not show this message. They showed:
>  Local APIC disabled by BIOS -- reenabling.
>  Found and enabled local APIC!

 As you've already been told, the local APIC is not being enabled by
default anymore.  I think this change may be unfortunate for users, so
I've proposed the change to be applied for systems using ACPI and then
verbosely, so that the reason for the APIC being kept disabled is clear.  
Unfortunately I have no system available for testing that uses ACPI, so
I'm asking whether you could participate in testing of the following
patch.  With the patch applied, you should either get a warning or the
local APIC running (e.g. if you disable ACPI by specifying "noacpi").  
Does the patch work for you?  For anyone else?

  Maciej

patch-2.6.9-rc4-lapic-5
diff -up --recursive --new-file linux-2.6.9-rc4.macro/arch/i386/kernel/acpi/boot.c linux-2.6.9-rc4/arch/i386/kernel/acpi/boot.c
--- linux-2.6.9-rc4.macro/arch/i386/kernel/acpi/boot.c	2004-10-12 23:57:01.000000000 +0000
+++ linux-2.6.9-rc4/arch/i386/kernel/acpi/boot.c	2004-10-13 23:27:03.000000000 +0000
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 
+#include <asm/cpufeature.h>
 #include <asm/pgtable.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -842,6 +843,18 @@ acpi_boot_init (void)
 	}
 
 	/*
+	 * Don't override BIOS and enable the local APIC
+	 * unless "lapic" specified.
+	 */
+	if (!acpi_disabled && !cpu_has_apic && enable_local_apic == 0) {
+		printk(KERN_NOTICE PREFIX "Local APIC won't be reenabled, "
+		       "because of frequent BIOS bugs\n");
+		printk(KERN_NOTICE PREFIX
+		       "You can enable it with \"lapic\"\n");
+		disable_lapic();
+	}
+
+	/*
 	 * set sci_int and PM timer address
 	 */
 	acpi_table_parse(ACPI_FADT, acpi_parse_fadt);
diff -up --recursive --new-file linux-2.6.9-rc4.macro/arch/i386/kernel/apic.c linux-2.6.9-rc4/arch/i386/kernel/apic.c
--- linux-2.6.9-rc4.macro/arch/i386/kernel/apic.c	2004-10-12 23:57:01.000000000 +0000
+++ linux-2.6.9-rc4/arch/i386/kernel/apic.c	2004-10-13 00:14:58.000000000 +0000
@@ -667,7 +667,7 @@ static int __init detect_init_APIC (void
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
-	/* Disabled by DMI scan or kernel option? */
+	/* Disabled by DMI scan, ACPI or kernel option? */
 	if (enable_local_apic < 0)
 		return -1;
 
@@ -692,12 +692,6 @@ static int __init detect_init_APIC (void
 
 	if (!cpu_has_apic) {
 		/*
-		 * Over-ride BIOS and try to enable LAPIC
-		 * only if "lapic" specified
-		 */
-		if (enable_local_apic != 1)
-			goto no_apic;
-		/*
 		 * Some BIOSes disable the local APIC in the
 		 * APIC_BASE MSR. This can only be done in
 		 * software for Intel P6 and AMD K7 (Model > 1).
diff -up --recursive --new-file linux-2.6.9-rc4.macro/include/asm-i386/apic.h linux-2.6.9-rc4/include/asm-i386/apic.h
--- linux-2.6.9-rc4.macro/include/asm-i386/apic.h	2004-10-12 23:58:10.000000000 +0000
+++ linux-2.6.9-rc4/include/asm-i386/apic.h	2004-10-13 19:55:55.000000000 +0000
@@ -107,6 +107,12 @@ extern int APIC_init_uniprocessor (void)
 extern void disable_APIC_timer(void);
 extern void enable_APIC_timer(void);
 
+extern int enable_local_apic;
+static inline void disable_lapic(void)
+{
+	enable_local_apic = -1;
+}
+
 extern int check_nmi_watchdog (void);
 extern void enable_NMI_through_LVT0 (void * dummy);
 
@@ -116,6 +122,11 @@ extern unsigned int nmi_watchdog;
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
-#endif /* CONFIG_X86_LOCAL_APIC */
+#else /* !CONFIG_X86_LOCAL_APIC */
+
+#define enable_local_apic -1
+static inline void disable_lapic(void) { /* nothing */ }
+
+#endif /* !CONFIG_X86_LOCAL_APIC */
 
 #endif /* __ASM_APIC_H */
