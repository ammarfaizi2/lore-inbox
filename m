Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTDENss (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTDENss (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:48:48 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:26081 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262239AbTDENso (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 08:48:44 -0500
Date: Sat, 5 Apr 2003 16:00:08 +0200 (MEST)
Message-Id: <200304051400.h35E08Vg015459@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: marcelo@conectiva.com.br
Subject: [PATCH][2.4.21-pre7] fix APIC bus errors on SMP K7 boxes in UP mode
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SMP K7 boxes that run in UP mode, because they have only one CPU
installed or are running a UP kernel, are prone to instability
due to APIC bus problems.

These problems occur because the kernel's local APIC code always
resets the boot CPU's APIC_ID to zero, due to a combination of a
programming error and a logical mistake. Since some dual K7 boards
boot on the non-zero APIC_ID CPU, this bogus reset creates an APIC_ID
conflict which causes APIC bus errors and message delivery failures.

The patch below fixes this. The same fix went into 2.5.64. Please apply.

/Mikael

--- linux-2.4.21-pre7/arch/i386/kernel/apic.c.~1~	2003-04-05 12:35:30.000000000 +0200
+++ linux-2.4.21-pre7/arch/i386/kernel/apic.c	2003-04-05 13:10:51.000000000 +0200
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
 
