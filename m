Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbUKOBYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUKOBYK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUKOBVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:21:00 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40199 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261411AbUKOBTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:19:51 -0500
Date: Mon, 15 Nov 2004 01:19:40 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
In-Reply-To: <41967669.3070707@aknet.ru>
Message-ID: <Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl>
References: <41967669.3070707@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004, Stas Sergeev wrote:

> 1. Local APIC stopped working. I know
> I have to add "lapic" to the command-line,
> but now this doesn't help (in -mm4 either
> I think). dmesg says:

 Here's a fix.  The problem is detect_init_APIC() is called early, before
the command line have been processed.  Therefore "lapic" (and "nolapic")  
have not been seen, yet.

 This has been verified to work correctly with your configuration.  
Andrew, please apply.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

patch-2.6.10-rc1-mm5-i386-lapic-0
diff -up --recursive --new-file linux-2.6.10-rc1-mm5.macro/arch/i386/kernel/apic.c linux-2.6.10-rc1-mm5/arch/i386/kernel/apic.c
--- linux-2.6.10-rc1-mm5.macro/arch/i386/kernel/apic.c	2004-11-14 16:01:48.000000000 +0000
+++ linux-2.6.10-rc1-mm5/arch/i386/kernel/apic.c	2004-11-15 00:41:02.000000000 +0000
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
@@ -692,26 +697,6 @@ static void apic_pm_activate(void) { }
  * Original code written by Keir Fraser.
  */
 
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
-
 static int __init apic_set_verbosity(char *str)
 {
 	if (strcmp("debug", str) == 0)
diff -up --recursive --new-file linux-2.6.10-rc1-mm5.macro/arch/i386/kernel/setup.c linux-2.6.10-rc1-mm5/arch/i386/kernel/setup.c
--- linux-2.6.10-rc1-mm5.macro/arch/i386/kernel/setup.c	2004-11-14 16:01:49.000000000 +0000
+++ linux-2.6.10-rc1-mm5/arch/i386/kernel/setup.c	2004-11-15 00:10:26.000000000 +0000
@@ -40,6 +40,7 @@
 #include <linux/init.h>
 #include <linux/edd.h>
 #include <video/edid.h>
+#include <asm/apic.h>
 #include <asm/e820.h>
 #include <asm/mpspec.h>
 #include <asm/setup.h>
@@ -814,6 +815,16 @@ static void __init parse_cmdline_early (
 #endif /* CONFIG_X86_LOCAL_APIC */
 #endif /* CONFIG_ACPI_BOOT */
 
+#ifdef CONFIG_X86_LOCAL_APIC
+		/* enable local APIC */
+		else if (!memcmp(from, "lapic", 5))
+			lapic_enable();
+
+		/* disable local APIC */
+		else if (!memcmp(from, "nolapic", 6))
+			lapic_disable();
+#endif /* CONFIG_X86_LOCAL_APIC */
+
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.
diff -up --recursive --new-file linux-2.6.10-rc1-mm5.macro/include/asm-i386/apic.h linux-2.6.10-rc1-mm5/include/asm-i386/apic.h
--- linux-2.6.10-rc1-mm5.macro/include/asm-i386/apic.h	2004-11-14 16:02:45.000000000 +0000
+++ linux-2.6.10-rc1-mm5/include/asm-i386/apic.h	2004-11-15 00:09:31.000000000 +0000
@@ -5,6 +5,7 @@
 #include <linux/pm.h>
 #include <asm/fixmap.h>
 #include <asm/apicdef.h>
+#include <asm/processor.h>
 #include <asm/system.h>
 
 #define Dprintk(x...)
@@ -16,8 +17,20 @@
 #define APIC_VERBOSE 1
 #define APIC_DEBUG   2
 
+extern int enable_local_apic;
 extern int apic_verbosity;
 
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
+
 /*
  * Define the default level of output to be very little
  * This can be turned up by using apic=verbose for more
