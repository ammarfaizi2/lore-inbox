Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbSLVDwv>; Sat, 21 Dec 2002 22:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbSLVDwv>; Sat, 21 Dec 2002 22:52:51 -0500
Received: from fmr01.intel.com ([192.55.52.18]:60145 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264706AbSLVDwt> convert rfc822-to-8bit;
	Sat, 21 Dec 2002 22:52:49 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Date: Sat, 21 Dec 2002 20:00:54 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E1AF@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-MS-Has-Attach: 
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Thread-Index: AcKogGC7JpwahRRzEdeNCQBQi+Bs2AA6ggKA
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "William Lee Irwin III" <wli@holomorphy.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Martin Bligh" <mbligh@us.ibm.com>, "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, "Hubert Mantel" <mantel@suse.de>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
X-OriginalArrivalTime: 22 Dec 2002 04:00:53.0992 (UTC) FILETIME=[B949E680:01C2A96E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: William Lee Irwin III [mailto:wli@holomorphy.com]
> On Fri, Dec 20, 2002 at 04:57:28PM -0600, Protasevich, Natalie wrote:
> > There are only a few problems with porting the Linux kernel 
> to the ES7000:
> > 	we use 8-bit APIC IDs - this makes us use APIC_LDR instead of
> > APIC_ID throughout the code;
> > 	we have special RTE destination values on IO-APIC - the 
> "if" in the
> > programming IO-APIC line code;
> > 	we introduce severe IRQ override case - we remap ISA 
> interrupts to a
> > different interrupt range (all the "i < 16" clauses).
> > Also, I usually have to add things like XTPR mechanism for 
> Fosters/Gallatins
> > and disable conventional IRQ balancing, since our IO-APIC 
> doesn't work this
> > way... (All of the above is in the SuSE code base).
> 
> Venkatesh, do you think you can handle these generically? Aside from
> machine-specific configurations this all looks like perfectly generic.
> 
> If it's publicly discussable, what's the difference wrt. the IO-APIC?
> IIRC NUMA-Q had a similar issue, where flat logical destinations were
> being programmed into the IO-APIC by the IRQ balancing code, but the
> NUMA-Q IO-APIC was programmed to accept physical destinations in the
> RTE's via the DESTMOD bit, using physical broadcast by default, and
> achieving node-locality as physical destinations may not refer to
> off-node cpus. There probably isn't an issue of node 
> locality, but even
> if the IO-APIC's are programmed for logical DESTMOD it won't work with
> the flat logical gunk the original IRQ balance patch programmed up.
> 
> From 2.5.52 include/asm-i386/smp.h:
> 
> #ifdef CONFIG_CLUSTERED_APIC
>  #define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
> #else
>  #define INT_DELIVERY_MODE 1     /* logical delivery 
> broadcast to all procs */
> #endif
> 
> 
> From 2.5.52 arch/i386/mach-generic/mach_apic.h:
> 
> #ifdef CONFIG_SMP
>  #define TARGET_CPUS (clustered_apic_mode ? 0xf : cpu_online_map)
> #else
>  #define TARGET_CPUS 0x01
> #endif
> 
> And while setting up the RTE's in io_apic.c:
> 
>                 entry.delivery_mode = dest_LowestPrio;
>                 entry.dest_mode = INT_DELIVERY_MODE;
>                 entry.mask = 0;                         /* 
> enable IRQ */
>                 entry.dest.logical.logical_dest = TARGET_CPUS;
> 
> ... which is rather blatant abuse of entry.dest.logical.logical_dest
> for the NUMA-Q case, but never mind that.
> 
> 
> On Fri, Dec 20, 2002 at 04:57:28PM -0600, Protasevich, Natalie wrote:
> > I worked with the SuSE tree which has clustered code (at 
> the first glance)
> > close to the patch being discussed here.
> > The 2.5 tree gives us a benefit of the subarch that will accomodate
> > (hopefully) our special cases. 
> > But I may need to add more hooks.
> 
> It'd be great to have the APIC interface general enough to handle all
> these machines.

Yes, our feeling it is possible to handle all non-NUMAQ systems pretty generically in terms of APIC setup and interrupt routing. We can use either logical clustered or physical destination modes.
But for NUMAQ systems, interrupt routing has to know about the local nodes and have necessary logic to do the routing withing local node.

Thanks,
-Venkatesh 

 
