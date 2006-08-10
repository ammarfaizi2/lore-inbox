Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWHJTqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWHJTqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWHJTh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:26 -0400
Received: from mail.suse.de ([195.135.220.2]:15249 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932661AbWHJThJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:09 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [110/145] x86_64: Don't access the APIC in safe_smp_processor_id when it is not mapped yet
Message-Id: <20060810193708.AF03C13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:08 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Lockdep can call the dwarf2 unwinder early, and the dwarf2 code
uses safe_smp_processor_id which tries to access the local APIC page.
But that doesn't work before the APIC code has set up its fixmap.

Check for this case and always return boot cpu then.

Cc: jbeulich@novell.com
Cc: mingo@elte.hu

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/apic.c |    2 ++
 arch/x86_64/kernel/smp.c  |    2 +-
 include/asm-x86_64/apic.h |    1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

Index: linux/arch/x86_64/kernel/apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/apic.c
+++ linux/arch/x86_64/kernel/apic.c
@@ -38,6 +38,7 @@
 #include <asm/timex.h>
 #include <asm/apic.h>
 
+int apic_mapped;
 int apic_verbosity;
 int apic_runs_main_timer;
 int apic_calibrate_pmtmr __initdata;
@@ -600,6 +601,7 @@ void __init init_apic_mappings(void)
 		apic_phys = mp_lapic_addr;
 
 	set_fixmap_nocache(FIX_APIC_BASE, apic_phys);
+	apic_mapped = 1;
 	apic_printk(APIC_VERBOSE,"mapped APIC to %16lx (%16lx)\n", APIC_BASE, apic_phys);
 
 	/*
Index: linux/arch/x86_64/kernel/smp.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smp.c
+++ linux/arch/x86_64/kernel/smp.c
@@ -526,7 +526,7 @@ int safe_smp_processor_id(void)
 {
 	unsigned apicid, i;
 
-	if (disable_apic)
+	if (disable_apic || !apic_mapped)
 		return 0;
 
 	apicid = hard_smp_processor_id();
Index: linux/include/asm-x86_64/apic.h
===================================================================
--- linux.orig/include/asm-x86_64/apic.h
+++ linux/include/asm-x86_64/apic.h
@@ -18,6 +18,7 @@
 extern int apic_verbosity;
 extern int apic_runs_main_timer;
 extern int ioapic_force;
+extern int apic_mapped;
 
 /*
  * Define the default level of output to be very little
