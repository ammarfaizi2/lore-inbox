Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284575AbRLJBHf>; Sun, 9 Dec 2001 20:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286130AbRLJBH0>; Sun, 9 Dec 2001 20:07:26 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:19947 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S284575AbRLJBHT>;
	Sun, 9 Dec 2001 20:07:19 -0500
Date: Mon, 10 Dec 2001 02:07:15 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200112100107.CAA18309@harpo.it.uu.se>
To: zwane@linux.realnet.co.sz
Subject: [PATCH] APIC Error when doing apic_pm_suspend
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001 18:16:46 +0100, Mikael Pettersson wrote:
>Zwane Mwaikambo writes:
> > I get an APIC error 0x40 when resuming from an apm -s. If i'm correct
> > that would be an illegal register access wouldn't it? I tried putting
> > enter/exit printks in the apic_pm_resume/suspend functions and it showed
> > that both returned before the APIC error printk. Is there anyway of finding out
> > which register access it was? I "thought" it would be one of the
> > apic_writes in the pm functions but looks like i might be wrong.
> > 
> > The kernel is compiled with local APIC and gets detected and enabled on
> > boot (UP machine).
>
>No, 0x40 is an illegal vector error. It's a (semi-) known quirk in the P6 family
>of processors that you get this error when writing a null vector to any of the
>LVT entries, even if you are also setting the mask bit at the same time.
>Both the clear_local_APIC() call at PM suspend and the reinitialisation at PM
>resume can trigger this.
>
>The "error" is mostly harmless. Ignore it for now, I'll do a patch to silence it later.

Here's the patch I promised, for 2.4.17-pre6. It ensures that APIC LVTERR
is masked when we're storing possibly zero vectors in other LVT entries.

After thinking more about the issue (and fighting broken BIOSen on two
machines), I'm now convinced the old behaviour is buggy: triggering local
APIC errors when the contents of LVTERR is defined by the BIOS and not
the Linux kernel is inherently unsafe and must be avoided.

/Mikael

--- linux-2.4.17-pre6-apicfixes/arch/i386/kernel/apic.c.~1~	Sun Dec  9 22:58:56 2001
+++ linux-2.4.17-pre6-apicfixes/arch/i386/kernel/apic.c	Sun Dec  9 23:09:31 2001
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
