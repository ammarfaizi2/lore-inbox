Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268291AbTCAAWQ>; Fri, 28 Feb 2003 19:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268314AbTCAAWQ>; Fri, 28 Feb 2003 19:22:16 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:39358 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268291AbTCAAWP>;
	Fri, 28 Feb 2003 19:22:15 -0500
Date: Sat, 1 Mar 2003 01:32:33 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303010032.h210WXgJ002912@harpo.it.uu.se>
To: jp.pozzi@izzop.org
Subject: Re: Bug in APIC on 2.4.20 kernel
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Mar 2003 00:18:46 +0100, "JP Pozzi izzop.org" wrote:
>I found a problem with the APIC management in the 2.4.20 kernel.
>
>My system is (was) a bi-processor one :
>
>MSI K7D Master (BIOS V 1.1) with 2 ATHLON MP 1800+
>
>The facts :
>
>1) The 2.4.20 kernel was OK on my system with the 2 processors and a
>home made SMP kernel.
>
>2) One processor was broken/defective.
>
>3) No boot was possible with only on processor on the card with a loop
>while booting saying endlessly : "APIC 04(04)"
>
>I try to recompile the 2.4.20 kernel with no SMP support the problem was
>the same, I try gcc2.95 and gcc3 without any success.

Known problem. It has been discussed extensively on LKML recently.
Apply the patch below.

/Mikael

diff -ruN linux-2.4.21-pre5/arch/i386/kernel/apic.c linux-2.4.21-pre5.apic-fixes/arch/i386/kernel/apic.c
--- linux-2.4.21-pre5/arch/i386/kernel/apic.c	2003-02-27 12:58:55.000000000 +0100
+++ linux-2.4.21-pre5.apic-fixes/arch/i386/kernel/apic.c	2003-02-27 13:05:28.000000000 +0100
@@ -649,7 +649,6 @@
 	}
 	set_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-	boot_cpu_physical_apicid = 0;
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;
 
@@ -1169,8 +1168,7 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
-	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
+	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
 
 	apic_pm_init2();
 
