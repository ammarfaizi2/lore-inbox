Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbTFYUGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbTFYUGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:06:53 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:52668 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S265036AbTFYUFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:05:19 -0400
Date: Wed, 25 Jun 2003 21:20:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] ACPI_HT_ONLY acpismp=force
In-Reply-To: <Pine.LNX.4.44.0306252112180.1636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306252118490.1636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the point of bootparam "acpismp=force"?  A way to change
your mind if you just said "acpi=off"?  A hurdle to jump to get
CONFIG_ACPI_HT_ONLY to do what you ask?  2.4.18 used to need it to
enable HT, but not recent releases.  It can't configure in what's
not there, and now serves only to confuse: kill it.

2.4.22-bk already has a cset to call acpi_boot_init
in the CONFIG_ACPI_HT_ONLY case.  But allow "acpi=off" to disable
that; and let acpi_disabled be 1 if CONFIG_ACPI is not defined.

Sorry, bootparam "noht" remains broken: it's currently a way of
erasing the "ht" flag from cpuinfo, and setting smp_num_siblings to
1 even when it should say 2.  Please, someone who knows their way
around the ACPI table handling fix it (it should be selecting one
from each pair in either acpi_boot_init), or else we just remove it.

--- 2.4.22-bk/Documentation/Configure.help	Wed Jun 25 14:00:53 2003
+++ linux/Documentation/Configure.help	Wed Jun 25 20:27:12 2003
@@ -18638,9 +18638,6 @@
   Full ACPI support (CONFIG_ACPI) is preferred.  Use this option
   only if you wish to limit ACPI's role to processor enumeration.
 
-  In this configuration, ACPI defaults to off. It must be enabled
-  on the command-line with the "acpismp=force" option.
-
 Enable ACPI 2.0 with errata 1.3
 CONFIG_ACPI20
   Enable support for the 2.0 version of the ACPI interpreter.  See the
--- 2.4.22-bk/Documentation/kernel-parameters.txt	Fri Jun 20 23:53:32 2003
+++ linux/Documentation/kernel-parameters.txt	Wed Jun 25 20:27:12 2003
@@ -70,8 +70,6 @@
 
 	acpi=		[HW,ACPI] Advanced Configuration and Power Interface 
 
-	acpismp=force	[IA-32] Early setup parse and use ACPI SMP table.
- 
 	ad1816=		[HW,SOUND]
 
 	ad1848=		[HW,SOUND]
--- 2.4.22-bk/arch/i386/kernel/setup.c	Wed Jun 25 14:00:53 2003
+++ linux/arch/i386/kernel/setup.c	Wed Jun 25 20:27:12 2003
@@ -174,10 +174,10 @@
 static int disable_x86_ht __initdata = 0;
 static u32 disabled_x86_caps[NCAPINTS] __initdata = { 0 };
 
-#ifdef CONFIG_ACPI_HT_ONLY
-int acpi_disabled __initdata = 1;
-#else
+#ifdef CONFIG_ACPI
 int acpi_disabled __initdata = 0;
+#else
+int acpi_disabled __initdata = 1;
 #endif
 
 extern int blk_nohighio;
@@ -811,10 +811,6 @@
 		else if (!memcmp(from, "acpi=off", 8))
 			acpi_disabled = 1;
 
-		/* "acpismp=force" turns on ACPI again */
-		else if (!memcmp(from, "acpismp=force", 13))
-			acpi_disabled = 0;
-
 		/*
 		 * highmem=size forces highmem to be exactly 'size' bytes.
 		 * This works even on boxes that have no highmem otherwise.
@@ -1163,13 +1159,16 @@
 	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
 	paging_init();
-#ifdef CONFIG_ACPI
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
 	/*
 	 * get boot-time SMP configuration:
--- 2.4.22-bk/include/linux/acpi.h	Mon Jun 23 14:51:54 2003
+++ linux/include/linux/acpi.h	Wed Jun 25 20:27:12 2003
@@ -37,7 +37,7 @@
 #include <asm/acpi.h>
 
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,

