Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269147AbTB0BKx>; Wed, 26 Feb 2003 20:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269148AbTB0BKx>; Wed, 26 Feb 2003 20:10:53 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:54536 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S269147AbTB0BKv>;
	Wed, 26 Feb 2003 20:10:51 -0500
Date: Wed, 26 Feb 2003 20:20:57 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Mikael Pettersson <mikpe@user.it.uu.se>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <10510000.1046306748@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302262008280.6844-100000@moisil.badula.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Martin J. Bligh wrote:

> >  
> >  	connect_bsp_APIC();
> >  
> > -	phys_cpu_present_map = 1;
> > -	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
> > +	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
> >  
> >  	apic_pm_init2();
> 
> If I'm reading this correctly, this is called out of APIC_init_uniprocessor
> from smp_init ... isn't that after people have finished using
> phys_cpu_present_map (eg setup_ioapic_ids_from_mpc)? 

No, look further down in apic.c: APIC_init_uniprocessor() calls 
setup_IO_APIC() which then calls setup_ioapic_ids_from_mpc(). This happens 
after the code quoted above runs.

Additionally, in 2.4.x setup_local_APIC() also uses 
boot_cpu_physical_apicid, although only as a sanity check. That code 
is gone from (or never made it into) 2.5.

> maybe change this bit in trap_init:
> 
> @@ -665,7 +665,6 @@
>  	}
>  	set_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
>  	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
> -	boot_cpu_physical_apicid = 0;
>  	if (nmi_watchdog != NMI_NONE)
>  		nmi_watchdog = NMI_LOCAL_APIC;
>  
> to do:
> 
> boot_cpu_physical_apicid = hard_smp_processor_id();
> phys_cpu_present_map = 1 << boot_cpu_physical_apicid;

But is it necessarily true that hard_smp_processor_id() equals the APIC
id?

Anyway, after applying Linus' patch, the first thing that touches
boot_cpu_physical_apicid becomes init_apic_mappings() which does:

        if (boot_cpu_physical_apicid == -1U)
                boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));

and that's just about as good as it gets, certainly the CPU knows best 
what its APIC id is.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

