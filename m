Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268928AbTBZUiA>; Wed, 26 Feb 2003 15:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268929AbTBZUiA>; Wed, 26 Feb 2003 15:38:00 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:19464 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S268928AbTBZUh7>;
	Wed, 26 Feb 2003 15:37:59 -0500
Date: Wed, 26 Feb 2003 15:47:38 -0500
Message-Id: <200302262047.h1QKlcPt015577@buggy.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <20030226072327.7936B2C04B@lists.samba.org>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003 18:14:42 +1100, Rusty Russell <rusty@rustcorp.com.au> wrote:
> In message <9530000.1046238665@[10.10.2.4]> you write:
>> > SMP box, compiled for UP with CONFIG_LOCAL_APIC=y freezes on boot with
>> > last lines:
>> > 
>> >     POSIX conformance testing by UNIFIX
>> >     masked ExtINT on CPU#0
>> >     ESR value before enabling vector: 00000008
>> >     [ Freeze here ]

I suspect the ESR is a red herring. The problem is that the kernel 
assumes that the boot CPU is always CPU#0, and it also misprograms the 
boot CPU's APIC.

What kind of SMP box is it (Intel/AMD)?

>> I put an esr_disable flag in there a while back ... does that workaround it?
> 
> Yes.  Hmm.  Wonder if that helps my SMP wierness, too.

Does this patch (from Mikael) help? It fixed my problem on a dual AMD
box running a UP + local APIC kernel.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
--------------------------

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
 
