Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269177AbTBZVWu>; Wed, 26 Feb 2003 16:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269178AbTBZVWu>; Wed, 26 Feb 2003 16:22:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1805 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269177AbTBZVWs>; Wed, 26 Feb 2003 16:22:48 -0500
Date: Wed, 26 Feb 2003 13:30:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ion Badulescu <ionut@badula.org>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <mingo@redhat.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <Pine.LNX.4.44.0302261615330.8828-100000@guppy.limebrokerage.com>
Message-ID: <Pine.LNX.4.44.0302261323560.3156-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Feb 2003, Ion Badulescu wrote:
> > diff -urpN -X /home/fletch/.diff.exclude virgin/arch/i386/kernel/smpboot.c
> > nonzero_apicid/arch/i386/kernel/smpboot.c
> > --- virgin/arch/i386/kernel/smpboot.c	Sat Feb 15 16:11:40 2003
> > +++ nonzero_apicid/arch/i386/kernel/smpboot.c	Wed Feb 26 13:02:10 2003
> > @@ -951,6 +951,7 @@ static void __init smp_boot_cpus(unsigne
> >  	print_cpu_info(&cpu_data[0]);
> >  
> >  	boot_cpu_logical_apicid = logical_smp_processor_id();
> > +	boot_cpu_physical_apicid = hard_smp_processor_id();
> >  
> >  	current_thread_info()->cpu = 0;
> >  	smp_tune_scheduling();
> 
> But this patch is for smpboot.c, which is not even compiled in for a UP 
> kernel...
> 
> Both Rusty and I had problems with a UP+APIC kernel running on an SMP box.

What about detect_init_APIC()?

That one currently does an unconditional

	boot_cpu_physical_apicid = 0;

and as far as I can see, this is the path taken by the UP case (because it 
doesn't even _try_ to find the SMP config tables).

What happens if you just remove that line (which means that the code 
further on will do

         */
        if (boot_cpu_physical_apicid == -1U)
                boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
                
which might be correct.

		Linus

