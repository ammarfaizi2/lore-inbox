Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVASIE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVASIE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVASIDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:03:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53951 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261637AbVASHdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:44 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/29] x86-local-apic-fix
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Maciej W. Rozycki" <macro@linux-mips.org>

Fix a kexec problem whcih causes local APIC detection failure.

The problem is detect_init_APIC() is called early, before the command line
have been processed.  Therefore "lapic" (and "nolapic") have not been seen,
yet.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 arch/i386/kernel/apic.c  |   25 +++++--------------------
 arch/i386/kernel/setup.c |   11 +++++++++++
 include/asm-i386/apic.h  |   13 +++++++++++++
 3 files changed, 29 insertions(+), 20 deletions(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/arch/i386/kernel/apic.c linux-2.6.11-rc1-mm1-nokexec-x86-local-apic-fix/arch/i386/kernel/apic.c
--- linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/arch/i386/kernel/apic.c	Fri Jan 14 04:32:22 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-local-apic-fix/arch/i386/kernel/apic.c	Tue Jan 18 22:43:54 2005
@@ -41,6 +41,11 @@
 #include "io_ports.h"
 
 /*
+ * Knob to control our willingness to enable the local APIC.
+ */
+int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
+
+/*
  * Debug level
  */
 int apic_verbosity;
@@ -666,26 +671,6 @@
  * Detect and enable local APICs on non-SMP boards.
  * Original code written by Keir Fraser.
  */
-
-/*
- * Knob to control our willingness to enable the local APIC.
- */
-int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
-
-static int __init lapic_disable(char *str)
-{
-	enable_local_apic = -1;
-	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
-	return 0;
-}
-__setup("nolapic", lapic_disable);
-
-static int __init lapic_enable(char *str)
-{
-	enable_local_apic = 1;
-	return 0;
-}
-__setup("lapic", lapic_enable);
 
 static int __init apic_set_verbosity(char *str)
 {
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/arch/i386/kernel/setup.c linux-2.6.11-rc1-mm1-nokexec-x86-local-apic-fix/arch/i386/kernel/setup.c
--- linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/arch/i386/kernel/setup.c	Fri Jan 14 04:28:30 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-local-apic-fix/arch/i386/kernel/setup.c	Tue Jan 18 22:43:55 2005
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/edd.h>
 #include <video/edid.h>
+#include <asm/apic.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
 #include <asm/setup.h>
@@ -813,6 +814,16 @@
 			disable_ioapic_setup();
 #endif /* CONFIG_X86_LOCAL_APIC */
 #endif /* CONFIG_ACPI_BOOT */
+
+#ifdef CONFIG_X86_LOCAL_APIC
+		/* enable local APIC */
+		else if (!memcmp(from, "lapic", 5))
+			lapic_enable();
+
+		/* disable local APIC */
+		else if (!memcmp(from, "nolapic", 6))
+			lapic_disable();
+#endif /* CONFIG_X86_LOCAL_APIC */
 
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/include/asm-i386/apic.h linux-2.6.11-rc1-mm1-nokexec-x86-local-apic-fix/include/asm-i386/apic.h
--- linux-2.6.11-rc1-mm1-nokexec-x86-rename-apic_mode_exint/include/asm-i386/apic.h	Fri Jan  7 12:54:13 2005
+++ linux-2.6.11-rc1-mm1-nokexec-x86-local-apic-fix/include/asm-i386/apic.h	Tue Jan 18 22:43:55 2005
@@ -5,6 +5,7 @@
 #include <linux/pm.h>
 #include <asm/fixmap.h>
 #include <asm/apicdef.h>
+#include <asm/processor.h>
 #include <asm/system.h>
 
 #define Dprintk(x...)
@@ -16,7 +17,19 @@
 #define APIC_VERBOSE 1
 #define APIC_DEBUG   2
 
+extern int enable_local_apic;
 extern int apic_verbosity;
+
+static inline void lapic_disable(void)
+{
+	enable_local_apic = -1;
+	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+}
+
+static inline void lapic_enable(void)
+{
+	enable_local_apic = 1;
+}
 
 /*
  * Define the default level of output to be very little
