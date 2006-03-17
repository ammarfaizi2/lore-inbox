Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752455AbWCQA2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbWCQA2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbWCQA2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:28:44 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:27012 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752455AbWCQA2o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:28:44 -0500
Subject: [PATCH] kill implicit check_acpi_pci() warning
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ak@suse.de, gregkh@suse.de,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Thu, 16 Mar 2006 16:28:35 -0800
Message-Id: <20060317002835.FDAEA381@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been seeing these in recent -mms:

arch/i386/kernel/setup.c: In function `setup_arch':
arch/i386/kernel/setup.c:1523: warning: implicit declaration of function `check_acpi_pci'

The issue is that the stub check_acpi_pci() is inside an
#ifdef ACPI in the header, while the actual use inside the
.c file is not.  I've elected to take both the extern and
the stub in the header, and take them out of the ACPI #ifdef.

The comment next to the call says the following:

	check_acpi_pci();       /* Checks more than just ACPI actually */

Seems weird to have "_acpi_" in it then, but what do I know?

BTW, I'm running a config with ACPI=n and X86_IO_APIC=y.

---

 work-dave/include/asm-i386/acpi.h |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/setup.c~kill-implicit-check_acpi_pci-warning arch/i386/kernel/setup.c
diff -puN include/asm-i386/acpi.h~kill-implicit-check_acpi_pci-warning include/asm-i386/acpi.h
--- work/include/asm-i386/acpi.h~kill-implicit-check_acpi_pci-warning	2006-03-16 16:25:59.000000000 -0800
+++ work-dave/include/asm-i386/acpi.h	2006-03-16 16:25:59.000000000 -0800
@@ -128,8 +128,6 @@ extern int acpi_gsi_to_irq(u32 gsi, unsi
 extern int skip_ioapic_setup;
 extern int acpi_skip_timer_override;
 
-extern void check_acpi_pci(void);
-
 static inline void disable_ioapic_setup(void)
 {
 	skip_ioapic_setup = 1;
@@ -142,7 +140,6 @@ static inline int ioapic_setup_disabled(
 
 #else
 static inline void disable_ioapic_setup(void) { }
-static inline void check_acpi_pci(void) { }
 
 #endif
 
@@ -163,6 +160,11 @@ static inline void acpi_disable_pci(void
 
 #endif	/* !CONFIG_ACPI */
 
+#ifdef CONFIG_X86_IO_APIC
+extern void check_acpi_pci(void);
+#else
+static inline void check_acpi_pci(void) { }
+#endif
 
 #ifdef CONFIG_ACPI_SLEEP
 
_
