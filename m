Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268753AbTBZVfV>; Wed, 26 Feb 2003 16:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268941AbTBZVfV>; Wed, 26 Feb 2003 16:35:21 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:58061
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S268753AbTBZVfR>; Wed, 26 Feb 2003 16:35:17 -0500
Date: Wed, 26 Feb 2003 16:44:16 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <Pine.LNX.4.44.0302261323560.3156-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302261637560.8828-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Linus Torvalds wrote:

> What about detect_init_APIC()?
> 
> That one currently does an unconditional
> 
> 	boot_cpu_physical_apicid = 0;

Mikael's patch (included in the previous message) changes this to

	boot_cpu_physical_apicid = -1U;

which is the same thing indeed.

> What happens if you just remove that line (which means that the code 
> further on will do
> 
>          */
>         if (boot_cpu_physical_apicid == -1U)
>                 boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
>                 
> which might be correct.

It's not enough. There are two other problems, further down in 
APIC_init_uniprocessor():

1) apic_write_around(APIC_ID, boot_cpu_physical_apicid) places the APIC 
value in the lower 8 bits of APIC_ID, when it should be in the upper 8. As 
as result, it effectively forces the APIC id to always be 0 for the boot 
CPU, which is fatal on SMP AMD boxes.

2) phys_cpu_present_map = 1 means we always set bit 0, but later on 
in setup_local_APIC() we do
        if (!clustered_apic_mode && 
            !test_bit(GET_APIC_ID(apic_read(APIC_ID)), &phys_cpu_present_map))
                BUG();
and the bug is triggered if the APIC_ID is not zero.

Here's Mikael's patch again -- it's quite obviously correct, it fixes the 
problem on my SMP AMD boxes and doesn't break anything else I've thrown at 
it. Applies cleanly to both 2.4 and 2.5.latest.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-----------------------------------------------

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
 

