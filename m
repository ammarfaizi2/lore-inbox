Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbRCHW4k>; Thu, 8 Mar 2001 17:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130126AbRCHW4b>; Thu, 8 Mar 2001 17:56:31 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:20612 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S130090AbRCHW4O>;
	Thu, 8 Mar 2001 17:56:14 -0500
Date: Thu, 8 Mar 2001 23:55:33 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200103082255.XAA14402@harpo.it.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] UP-APIC fix for Mobile P6
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan et al,

This patch (against 2.4.2-ac14) fixes a buglet in the UP-APIC support.
As a side-effect of hpa's CPU detection rewrite in 2.4.0-test, the
X86_FEATURE constants where changed from bit masks to bit numbers.
Unfortunately one spot in apic.c:detect_init_APIC() wasn't updated,
with the effect that we would fail to detect P6 processors lacking
local APICs (all Mobile P6 CPUs it seems).

This didn't cause failures in the NMI watchdog since the new detection
code in setup.c would clear the APIC feature bit before any damage
was done. However, some users were confused by the fact that their
kernels would claim to have detected and initialised the local APIC,
but still the NMI watchdog wouldn't run.

/Mikael

--- linux-2.4.2-ac14/arch/i386/kernel/apic.c.~1~	Thu Mar  8 22:18:04 2001
+++ linux-2.4.2-ac14/arch/i386/kernel/apic.c	Thu Mar  8 22:31:49 2001
@@ -548,7 +548,7 @@
 
 static int __init detect_init_APIC (void)
 {
-	u32 h, l, dummy, features;
+	u32 h, l, features;
 	int needs_pm = 0;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
@@ -588,8 +588,8 @@
 	 * The APIC feature bit should now be enabled
 	 * in `cpuid'
 	 */
-	cpuid(1, &dummy, &dummy, &dummy, &features);
-	if (!(features & X86_FEATURE_APIC)) {
+	features = cpuid_edx(1);
+	if (!(features & (1 << X86_FEATURE_APIC))) {
 		printk("Could not enable APIC!\n");
 		return -1;
 	}
