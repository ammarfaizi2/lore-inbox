Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbTFYUCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTFYUCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:02:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:19351 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S265029AbTFYUCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:02:44 -0400
Date: Wed, 25 Jun 2003 21:18:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] ACPI_HT_ONLY acpismp=force
Message-ID: <Pine.LNX.4.44.0306252112180.1636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the point of bootparam "acpismp=force"?  A way to change
your mind if you just said "acpi=off"?  A hurdle to jump to get
CONFIG_ACPI_HT_ONLY to do what you ask?  2.4.18 used to need it to
enable HT, but not recent releases.  It can't configure in what's
not there, and now serves only to confuse: kill it.

And you can't enable HyperThreading if you don't call acpi_boot_init
in the CONFIG_ACPI_HT_ONLY case.  But allow "acpi=off" to disable
that; and let acpi_disabled be 1 if CONFIG_ACPI is not defined.

Sorry, bootparam "noht" remains broken: it's currently a way of
erasing the "ht" flag from cpuinfo, and setting smp_num_siblings to
1 even when it should say 2.  Please, someone who knows their way
around the ACPI table handling fix it (it should be selecting one
from each pair in either acpi_boot_init), or else we just remove it.

--- 2.5.73/arch/i386/kernel/setup.c	Mon Jun 23 14:59:00 2003
+++ linux/arch/i386/kernel/setup.c	Wed Jun 25 20:00:02 2003
@@ -61,10 +61,10 @@
 unsigned long mmu_cr4_features;
 EXPORT_SYMBOL_GPL(mmu_cr4_features);
 
-#ifdef CONFIG_ACPI_HT_ONLY
-int acpi_disabled = 1;
-#else
+#ifdef CONFIG_ACPI
 int acpi_disabled = 0;
+#else
+int acpi_disabled = 1;
 #endif
 EXPORT_SYMBOL(acpi_disabled);
 
@@ -519,10 +519,6 @@
 		if (c == ' ' && !memcmp(from, "acpi=off", 8))
 			acpi_disabled = 1;
 
-		/* "acpismp=force" turns on ACPI again */
-		else if (!memcmp(from, "acpismp=force", 14))
-			acpi_disabled = 0;
-
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.
@@ -977,13 +973,16 @@
 	generic_apic_probe(*cmdline_p);
 #endif	
 
-#ifdef CONFIG_ACPI_BOOT
+#if defined(CONFIG_ACPI_BOOT) || defined(CONFIG_ACPI_HT_ONLY)
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
 	 */
 	if (!acpi_disabled)
 		acpi_boot_init();
 #endif
+#ifdef CONFIG_ACPI_HT_ONLY
+	acpi_disabled = 1;
+#endif
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (smp_found_config)
 		get_smp_config();
--- 2.5.73/drivers/acpi/Kconfig	Mon Jun 23 14:59:01 2003
+++ linux/drivers/acpi/Kconfig	Wed Jun 25 20:00:02 2003
@@ -49,9 +49,6 @@
 	  Full ACPI support (CONFIG_ACPI) is preferred.  Use this option 
 	  only if you wish to limit ACPI's role to processor enumeration.
 
-	  In this configuration, ACPI defaults to off. It must be enabled
-	  on the command-line with the "acpismp=force" option.
-
 config ACPI_BOOT
 	bool
 	depends on IA64 && (!IA64_HP_SIM || IA64_SGI_SN) || X86 && ACPI && !ACPI_HT_ONLY

