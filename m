Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268512AbTBWQ2b>; Sun, 23 Feb 2003 11:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbTBWQ2b>; Sun, 23 Feb 2003 11:28:31 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:25512 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268512AbTBWQ2a>;
	Sun, 23 Feb 2003 11:28:30 -0500
Date: Sun, 23 Feb 2003 17:38:37 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200302231638.h1NGcbTx009510@harpo.it.uu.se>
To: ionut@badula.org
Subject: [CFT][PATCH] fix UP local APIC on SMP Athlon
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003 03:05:37 -0500 (EST), Ion Badulescu wrote:
>On Sat, 22 Feb 2003, Mikael Pettersson wrote:
>> This is interesting. Very interesting, even. A plain UP_APIC kernel
>> (with IO_APIC not enabled or not detected) shouldn't need to touch
>> APIC_ID at all. I strongly suspect this is a remnant of apic.c's old
>> SMP-only history, and that it should be removed for UP_APIC-only.
>> 
>> I need to get some downtime (zzz...) but I'll look into this ASAP.
>
>More testing on more platforms actually lead me to a slightly different 
>patch, which makes a lot more sense as far as phys_cpu_present_map is 
>concerned:
>
>--- linux-2.4.21-pre4/arch/i386/kernel/apic.c.old	Fri Jan 31 10:32:12 2003
>+++ linux-2.4.21-pre4/arch/i386/kernel/apic.c	Sat Feb 22 02:47:02 2003
>@@ -1169,8 +1169,8 @@
> 
> 	connect_bsp_APIC();
> 
>-	phys_cpu_present_map = 1;
>-	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
>+	phys_cpu_present_map = (1 << boot_cpu_physical_apicid);
>+	printk("Setting %d in the phys_cpu_present_map\n", boot_cpu_physical_apicid);
> 
> 	apic_pm_init2();
...
>As a matter of fact, I got very interesting numbers from that printk() I
>added:
>
>- all the Intel and single proc AMD printed "0".
>- all the dual AMD machines printed "1".

UP machines would print 0 since detect_init_APIC() incorrectly (IMO)
sets boot_cpu_physical_apicid to 0. On the dual AMD machines,
mpparse.c would find an MP table and initialise boot_cpu_physical_apicid
from it; presumably they booted on the non-zero CPU.

>So the reason it was crashing on the dual Athlons is two-fold:
>
>- It would try to write 1 into APIC_ID, when instead it should have
>written (1 << 24). So it was effectively setting the APIC ID to 0.

The APIC_ID:s must be globally unique, or horrible things happen.
The broken write to APIC_ID would indeed change the APIC_ID to zero,
which could conflict with another CPU.

I'm proposing the patch below. It fixes two problems:
1. Correct initialisation of phys_cpu_present_map. The existing
   code is incorrect whenever the boot CPU's APIC_ID isn't zero.
2. Eliminate unnecessary (and currently broken) write to APIC_ID.
   Instead we ensure that boot_cpu_physical_apicid matches the CPU:
   detect_init_APIC() sets it to -1 instead of 0, which forces
   init_apic_mappings() to read it from the boot CPU's local APIC.

Tested on two UP_APIC Intel machines. I would appreciate testing on
AMD, UP_IOAPIC machines, and UP-kernel-on-SMP-hardware.

/Mikael

--- linux-2.4.21-pre4/arch/i386/kernel/apic.c.~1~	2003-02-23 15:55:31.000000000 +0100
+++ linux-2.4.21-pre4/arch/i386/kernel/apic.c	2003-02-23 16:03:50.000000000 +0100
@@ -649,7 +649,7 @@
 	}
 	set_bit(X86_FEATURE_APIC, &boot_cpu_data.x86_capability);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-	boot_cpu_physical_apicid = 0;
+	boot_cpu_physical_apicid = -1U;
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;
 
@@ -1169,8 +1169,8 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
-	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
+	BUG_ON(boot_cpu_physical_apicid != GET_APIC_ID(apic_read(APIC_ID)));
+	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
 
 	apic_pm_init2();
 
