Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277148AbRJ0VdN>; Sat, 27 Oct 2001 17:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277152AbRJ0VdD>; Sat, 27 Oct 2001 17:33:03 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:22656 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S277148AbRJ0Vcp>;
	Sat, 27 Oct 2001 17:32:45 -0400
Date: Sat, 27 Oct 2001 23:33:16 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110272133.XAA08875@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4 UP_APIC power management fix
Cc: alan@lxorguk.ukuu.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4 UP_APIC code sets up a handler for power management events,
but only if the local APIC was enabled by Linux. This needs to be
done unconditionally: even if Linux didn't enable the local APIC,
we will still reprogram it in ways the BIOS may not handle.

This is the case on my new P4 box, which boots with the local
APIC enabled. With a 2.2 kernel or 2.4 kernel w/o SMP or UP_APIC,
APM suspend works fine. With a 2.4 UP_APIC kernel and the P4
anti-hang patch to detect_init_APIC() I posted a few hours ago,
APM suspend hangs the machine. If detect_init_APIC() sets up the
PM handler unconditionally, suspend works.

Setting up the PM handler unconditionally shouldn't cause any
problems for UP P6/K7 boxes: most of them boot with the local
APIC disabled, so we would have set up the PM handler anyway.

The patch below implements this change. Please try it out.

/Mikael

--- linux-2.4.13-ac3/arch/i386/kernel/apic.c.~1~	Thu Oct 11 13:34:39 2001
+++ linux-2.4.13-ac3/arch/i386/kernel/apic.c	Sat Oct 27 22:17:01 2001
@@ -575,7 +575,6 @@
 static int __init detect_init_APIC (void)
 {
 	u32 h, l, features;
-	int needs_pm = 0;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
 	/* Workaround for us being called before identify_cpu(). */
@@ -607,7 +607,6 @@
 			l &= ~MSR_IA32_APICBASE_BASE;
 			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 			wrmsr(MSR_IA32_APICBASE, l, h);
-			needs_pm = 1;
 		}
 	}
 	/*
@@ -627,8 +626,7 @@
 
 	printk("Found and enabled local APIC!\n");
 
-	if (needs_pm)
-		apic_pm_init1();
+	apic_pm_init1();
 
 	return 0;
 
