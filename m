Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbUKAXqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbUKAXqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S290148AbUKAXmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:42:01 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:54021 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S289992AbUKAX2p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 18:28:45 -0500
Date: Mon, 1 Nov 2004 23:28:35 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UP local APIC bootstrap cleanup
Message-ID: <Pine.LNX.4.58L.0411012309470.18634@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 Here is a patch to do some cleanup to code affected by the recent change
to the bootstrap code responsible for enabling the local APIC.  It adds a
message about how to get the APIC enabled if previously disabled by the
BIOS to aid people expecting the former behavior.  It removes some
P4-specific code that's become dead as a result of the change.  Finally it
improves a couple of inaccurate comments.

 This has been agreed to be reasonable.  Please apply

  Maciej

Signed-off-by: "Maciej W. Rozycki" <macro@linux-mips.org>

patch-2.6.9-lapic-7
diff -up --recursive --new-file linux-2.6.9.macro/arch/i386/kernel/apic.c linux-2.6.9/arch/i386/kernel/apic.c
--- linux-2.6.9.macro/arch/i386/kernel/apic.c	2004-10-12 23:57:01.000000000 +0000
+++ linux-2.6.9/arch/i386/kernel/apic.c	2004-10-24 00:30:29.000000000 +0000
@@ -667,7 +667,7 @@ static int __init detect_init_APIC (void
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
-	/* Disabled by DMI scan or kernel option? */
+	/* Disabled by kernel option? */
 	if (enable_local_apic < 0)
 		return -1;
 
@@ -681,8 +681,7 @@ static int __init detect_init_APIC (void
 			break;
 		goto no_apic;
 	case X86_VENDOR_INTEL:
-		if (boot_cpu_data.x86 == 6 ||
-		    (boot_cpu_data.x86 == 15 && (cpu_has_apic || enable_local_apic > 0)) ||
+		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
@@ -692,15 +691,20 @@ static int __init detect_init_APIC (void
 
 	if (!cpu_has_apic) {
 		/*
-		 * Over-ride BIOS and try to enable LAPIC
-		 * only if "lapic" specified
+		 * Over-ride BIOS and try to enable the local
+		 * APIC only if "lapic" specified.
 		 */
-		if (enable_local_apic != 1)
-			goto no_apic;
+		if (enable_local_apic <= 0) {
+			apic_printk(APIC_VERBOSE,
+				    "Local APIC disabled by BIOS -- "
+				    "you can enable it with \"lapic\"\n");
+			return -1;
+		}
 		/*
 		 * Some BIOSes disable the local APIC in the
 		 * APIC_BASE MSR. This can only be done in
-		 * software for Intel P6 and AMD K7 (Model > 1).
+		 * software for Intel P6 or later and AMD K7
+		 * (Model > 1) or later.
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
