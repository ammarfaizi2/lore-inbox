Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267842AbTBVHzh>; Sat, 22 Feb 2003 02:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267843AbTBVHzh>; Sat, 22 Feb 2003 02:55:37 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:31750 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S267842AbTBVHzf>;
	Sat, 22 Feb 2003 02:55:35 -0500
Date: Sat, 22 Feb 2003 03:05:37 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
To: Mikael Pettersson <mikpe@user.it.uu.se>
cc: m.c.p@wolk-project.de, Jeff Garzik <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: UP local APIC is deadly on SMP Athlon
In-Reply-To: <200302220038.h1M0cn6r004153@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0302220144530.18311-100000@moisil.badula.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003, Mikael Pettersson wrote:

> This is interesting. Very interesting, even. A plain UP_APIC kernel
> (with IO_APIC not enabled or not detected) shouldn't need to touch
> APIC_ID at all. I strongly suspect this is a remnant of apic.c's old
> SMP-only history, and that it should be removed for UP_APIC-only.
> 
> I need to get some downtime (zzz...) but I'll look into this ASAP.

More testing on more platforms actually lead me to a slightly different 
patch, which makes a lot more sense as far as phys_cpu_present_map is 
concerned:

--- linux-2.4.21-pre4/arch/i386/kernel/apic.c.old	Fri Jan 31 10:32:12 2003
+++ linux-2.4.21-pre4/arch/i386/kernel/apic.c	Sat Feb 22 02:47:02 2003
@@ -1169,8 +1169,8 @@
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
-	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
+	phys_cpu_present_map = (1 << boot_cpu_physical_apicid);
+	printk("Setting %d in the phys_cpu_present_map\n", boot_cpu_physical_apicid);
 
 	apic_pm_init2();
 
 
This has passed my testing on the following platforms:

* P3 (I820 chipset, no IO-APIC, APIC originally disabled by BIOS)
* P3 (440BX chipset, no IO-APIC, APIC originally disabled by BIOS)
* single P3 (ServerWorks OSB4 chipset, one CPU in dual CPU MB)
* dual P3 (ServerWorks OSB4 chipset, both CPU's present)
* dual P4 Xeon (I7500 chipset, both CPU's present, HT enabled)
* K7 (VIA KT400 chipset, IO-APIC present)
* K7 (VIA KM133 chipset, IO-APIC present)
* dual K7 (AMD 760MP chipset, both CPU's present)
* dual K7 (AMD 760MPX chipset, both CPU's present)

As a matter of fact, I got very interesting numbers from that printk() I
added:

- all the Intel and single proc AMD printed "0".
- all the dual AMD machines printed "1".

So the reason it was crashing on the dual Athlons is two-fold:

- It would try to write 1 into APIC_ID, when instead it should have
written (1 << 24). So it was effectively setting the APIC ID to 0.
- It would unconditionally set bit 0 in the phys_cpu_present_map bitmap, 
but later on it would check bit number boot_cpu_physical_apicid and BUG() 
if it found it clear.

So I think the patch above is safe. We could maybe replace the 
old apic_write_around() with something like

	apic_write_around(APIC_ID, (boot_cpu_physical_apicid << 24))

but it's probably unnecessary, as you said.

Ok. Enough for today. Zzzz catching time for me too...

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

