Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbTJPO6M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTJPO6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:58:12 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:41141 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263007AbTJPO6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:58:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16270.45563.560434.98578@alkaid.it.uu.se>
Date: Thu, 16 Oct 2003 16:58:03 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.23-pre7] APICBASE fix backport from 2.6
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the BIOS boots us with the local APIC enabled but at a
non-standard address, and we're not parsing any MP/ACPI
tables, then we will (a) map the wrong address, and (b)
write the wrong address to APICBASE at resume from suspend.

Apparently some HP machines are affected by this bug.

This is a backport of the fix Linus put in 2.6.0-test7-bk8.

/Mikael

diff -ruN linux-2.4.23-pre7/arch/i386/kernel/apic.c linux-2.4.23-pre7.apicbase-fix/arch/i386/kernel/apic.c
--- linux-2.4.23-pre7/arch/i386/kernel/apic.c	2003-10-16 15:57:41.000000000 +0200
+++ linux-2.4.23-pre7.apicbase-fix/arch/i386/kernel/apic.c	2003-10-16 16:01:13.282374825 +0200
@@ -502,10 +502,18 @@
 
 	__save_flags(flags);
 	__cli();
+
+	/*
+	 * Make sure the APICBASE points to the right address
+	 *
+	 * FIXME! This will be wrong if we ever support suspend on
+	 * SMP! We'll need to do this as part of the CPU restore!
+	 */
 	rdmsr(MSR_IA32_APICBASE, l, h);
 	l &= ~MSR_IA32_APICBASE_BASE;
-	l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
+	l |= MSR_IA32_APICBASE_ENABLE | mp_lapic_addr;
 	wrmsr(MSR_IA32_APICBASE, l, h);
+
 	apic_write(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
 	apic_write(APIC_ID, apic_pm_state.apic_id);
 	apic_write(APIC_DFR, apic_pm_state.apic_dfr);
@@ -674,6 +682,12 @@
 	}
 	set_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
+
+	/* The BIOS may have set up the APIC at some other address */
+	rdmsr(MSR_IA32_APICBASE, l, h);
+	if (l & MSR_IA32_APICBASE_ENABLE)
+		mp_lapic_addr = l & MSR_IA32_APICBASE_BASE;
+
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;
 
