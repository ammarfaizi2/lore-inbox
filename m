Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283782AbRLWPOv>; Sun, 23 Dec 2001 10:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282978AbRLWPOo>; Sun, 23 Dec 2001 10:14:44 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:52182 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S282491AbRLWPOX>;
	Sun, 23 Dec 2001 10:14:23 -0500
Date: Sun, 23 Dec 2001 16:14:16 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200112231514.QAA25107@harpo.it.uu.se>
To: marcelo@conectiva.com.br, torvalds@transmeta.com
Subject: [PATCH] 2.4.17/2.5.1 apic.c LVTERR fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus & Marcelo,

Here is a patch which fixes a long-standing bug in the x86 local APIC
code. The patch applies to both 2.4.17 and 2.5.1. Please apply.

The Intel P6 local APIC internally signals an Illegal Vector error
whenever a zero vector is written to an LVT entry, even if the entry
is simultaneously masked. The bug is that apic.c triggers these errors
when the contents of LVTERR is defined by the BIOS and not the kernel,
which can cause unexpected interrupts on unknown vectors. This typically
happens at boot-time initialisation, PM suspend, and PM resume.

The patch eliminates the problem by changing the initialisation order
in apic.c's clear_local_APIC() and apic_pm_resume() to ensure that LVTERR
is masked when we write (potentially) null vectors to LVT entries.

(Non-broken UP BIOSen often boot the kernel with LVTERR null and masked,
and leave LVTERR alone at PM suspend/resume, so _usually_ the errors just
show up as annoying kernel messages. It is, however, an extremely bad
idea to rely on the BIOS to mask errors caused the kernel itself.)

/Mikael

--- linux-2.4.17-apicfixes/arch/i386/kernel/apic.c.~1~	Fri Nov 23 22:40:14 2001
+++ linux-2.4.17-apicfixes/arch/i386/kernel/apic.c	Sun Dec 23 15:09:06 2001
@@ -56,6 +56,14 @@
 	maxlvt = get_maxlvt();
 
 	/*
+	 * Masking an LVT entry on a P6 can trigger a local APIC error
+	 * if the vector is zero. Mask LVTERR first to prevent this.
+	 */
+	if (maxlvt >= 3) {
+		v = ERROR_APIC_VECTOR; /* any non-zero vector will do */
+		apic_write_around(APIC_LVTERR, v | APIC_LVT_MASKED);
+	}
+	/*
 	 * Careful: we have to set masks only first to deassert
 	 * any level-triggered sources.
 	 */
@@ -65,10 +73,6 @@
 	apic_write_around(APIC_LVT0, v | APIC_LVT_MASKED);
 	v = apic_read(APIC_LVT1);
 	apic_write_around(APIC_LVT1, v | APIC_LVT_MASKED);
-	if (maxlvt >= 3) {
-		v = apic_read(APIC_LVTERR);
-		apic_write_around(APIC_LVTERR, v | APIC_LVT_MASKED);
-	}
 	if (maxlvt >= 4) {
 		v = apic_read(APIC_LVTPC);
 		apic_write_around(APIC_LVTPC, v | APIC_LVT_MASKED);
@@ -84,6 +88,8 @@
 		apic_write_around(APIC_LVTERR, APIC_LVT_MASKED);
 	if (maxlvt >= 4)
 		apic_write_around(APIC_LVTPC, APIC_LVT_MASKED);
+	apic_write(APIC_ESR, 0);
+	v = apic_read(APIC_ESR);
 }
 
 void __init connect_bsp_APIC(void)
@@ -480,6 +486,7 @@
 	l &= ~MSR_IA32_APICBASE_BASE;
 	l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 	wrmsr(MSR_IA32_APICBASE, l, h);
+	apic_write(APIC_LVTERR, ERROR_APIC_VECTOR | APIC_LVT_MASKED);
 	apic_write(APIC_ID, apic_pm_state.apic_id);
 	apic_write(APIC_DFR, apic_pm_state.apic_dfr);
 	apic_write(APIC_LDR, apic_pm_state.apic_ldr);
@@ -487,15 +494,15 @@
 	apic_write(APIC_SPIV, apic_pm_state.apic_spiv);
 	apic_write(APIC_LVT0, apic_pm_state.apic_lvt0);
 	apic_write(APIC_LVT1, apic_pm_state.apic_lvt1);
+	apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
+	apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
+	apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
+	apic_write(APIC_TMICT, apic_pm_state.apic_tmict);
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
 	apic_write(APIC_LVTERR, apic_pm_state.apic_lvterr);
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
-	apic_write(APIC_LVTPC, apic_pm_state.apic_lvtpc);
-	apic_write(APIC_LVTT, apic_pm_state.apic_lvtt);
-	apic_write(APIC_TDCR, apic_pm_state.apic_tdcr);
-	apic_write(APIC_TMICT, apic_pm_state.apic_tmict);
 	__restore_flags(flags);
 	if (apic_pm_state.perfctr_pmdev)
 		pm_send(apic_pm_state.perfctr_pmdev, PM_RESUME, data);
