Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWCOBb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWCOBb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWCOBb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:31:27 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:46535 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750846AbWCOBb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:31:26 -0500
Date: Wed, 15 Mar 2006 02:31:25 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 2.6.16-rc6 calls check_acpi_pci() on x86 with ACPI disabled
Message-ID: <20060315013125.GA24402@MAIL.13thfloor.at>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew! Folks!

check_acpi_pci() is called form arch/i386/kernel/setup.c
even if CONFIG_ACPI is not defined, but the code in
include/asm/acpi.h doesn't provide it in this case, 
so either we need to move the declaration outside the 
CONFIG_ACPI check, or alternatively move the call in
setup.c inside the CONFIG_ACPI one

attached two patches which would do this

best,
Herbert

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>


--- ./include/asm/acpi.h.orig	2006-03-15 01:06:10 +0100
+++ ./include/asm/acpi.h	2006-03-15 01:38:25 +0100
@@ -103,6 +103,12 @@ __acpi_release_global_lock (unsigned int
         :"=r"(n_hi), "=r"(n_lo)     \
         :"0"(n_hi), "1"(n_lo))
 
+#ifdef CONFIG_X86_IO_APIC
+extern void check_acpi_pci(void);
+#else
+static inline void check_acpi_pci(void) { }
+#endif
+
 #ifdef CONFIG_ACPI 
 extern int acpi_lapic;
 extern int acpi_ioapic;
@@ -128,8 +134,6 @@ extern int acpi_gsi_to_irq(u32 gsi, unsi
 extern int skip_ioapic_setup;
 extern int acpi_skip_timer_override;
 
-extern void check_acpi_pci(void);
-
 static inline void disable_ioapic_setup(void)
 {
 	skip_ioapic_setup = 1;
@@ -142,8 +146,6 @@ static inline int ioapic_setup_disabled(
 
 #else
 static inline void disable_ioapic_setup(void) { }
-static inline void check_acpi_pci(void) { }
-
 #endif
 
 static inline void acpi_noirq_set(void) { acpi_noirq = 1; }



alternatively:


--- ./arch/i386/kernel/setup.c.orig	2006-03-15 01:05:09 +0100
+++ ./arch/i386/kernel/setup.c	2006-03-15 01:25:41 +0100
@@ -1599,11 +1599,10 @@ void __init setup_arch(char **cmdline_p)
 	if (efi_enabled)
 		efi_map_memmap();
 
+#ifdef CONFIG_ACPI
 #ifdef CONFIG_X86_IO_APIC
 	check_acpi_pci();	/* Checks more than just ACPI actually */
 #endif
-
-#ifdef CONFIG_ACPI
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
 	 */
