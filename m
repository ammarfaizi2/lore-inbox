Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbTB0Oi0>; Thu, 27 Feb 2003 09:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbTB0Oi0>; Thu, 27 Feb 2003 09:38:26 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:27548 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S265154AbTB0OiZ>;
	Thu, 27 Feb 2003 09:38:25 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15966.9540.641385.149104@gargle.gargle.HOWL>
Date: Thu, 27 Feb 2003 15:48:36 +0100
To: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] local APIC init fixes for 2.4.21-pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo & Alan,

This patch for 2.4.21-pre fixes two local APIC initialisation bugs.
It has been reported to fix serious stability problems with UP kernels
on SMP Athlons. It needs to go in 2.4.21-pre & -ac as soon as possible.

Bug 1: APIC_init_uniprocessor() has a broken write to APIC_ID, forcing
APIC_ID to always be zero for the boot CPU. This causes serious
problems when running UP kernels on SMP Athlons. The fix is to remove
the write altogether, since it's redundant and potentially dangerous.

Bug 2: APIC_init_uniprocessor() incorrectly sets phys_cpu_present_map
to 1 instead of 1 << boot_cpu_physical_apicid. Any machine whose boot
CPU doesn't have ID zero will trigger a BUG() in setup_local_APIC().
The fix is to correct the initialisation of phys_cpu_present_map.

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
 
