Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbSLTX0j>; Fri, 20 Dec 2002 18:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbSLTX0j>; Fri, 20 Dec 2002 18:26:39 -0500
Received: from holomorphy.com ([66.224.33.161]:7368 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266316AbSLTX0h>;
	Fri, 20 Dec 2002 18:26:37 -0500
Date: Fri, 20 Dec 2002 15:33:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Cleverdon'" <jamesclv@us.ibm.com>,
       "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Martin Bligh'" <mbligh@us.ibm.com>,
       "'John Stultz'" <johnstul@us.ibm.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'Mallick, Asit K'" <asit.k.mallick@intel.com>,
       "'Saxena, Sunil'" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "'Andi Kleen'" <ak@suse.de>, "'Hubert Mantel'" <mantel@suse.de>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with m ore than 8 CPUs
Message-ID: <20021220233339.GF9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
	'Christoph Hellwig' <hch@infradead.org>,
	'James Cleverdon' <jamesclv@us.ibm.com>,
	"'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
	'Linux Kernel' <linux-kernel@vger.kernel.org>,
	'Martin Bligh' <mbligh@us.ibm.com>,
	'John Stultz' <johnstul@us.ibm.com>,
	"'Nakajima, Jun'" <jun.nakajima@intel.com>,
	"'Mallick, Asit K'" <asit.k.mallick@intel.com>,
	"'Saxena, Sunil'" <sunil.saxena@intel.com>,
	"Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
	'Andi Kleen' <ak@suse.de>, 'Hubert Mantel' <mantel@suse.de>
References: <3FAD1088D4556046AEC48D80B47B478C1AEC73@usslc-exch-4.slc.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C1AEC73@usslc-exch-4.slc.unisys.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 04:57:28PM -0600, Protasevich, Natalie wrote:
> Briefly, our ES7000 boxes are non-NUMA, but use clustered APICs (logical
> with Cascades, and physical with Gallatins/Fosters). Our code is pretty much
> within the clustered APIC code (when both physical and logical are
> implemented). Even with NUMA that is forced in clustered APIC case, we are
> usually OK as a single-node case.

Okay, so nothing wild like a non-APIC interrupt controller is going on
here. (c.f. Voyager for an example).


On Fri, Dec 20, 2002 at 04:57:28PM -0600, Protasevich, Natalie wrote:
> There are only a few problems with porting the Linux kernel to the ES7000:
> 	we use 8-bit APIC IDs - this makes us use APIC_LDR instead of
> APIC_ID throughout the code;
> 	we have special RTE destination values on IO-APIC - the "if" in the
> programming IO-APIC line code;
> 	we introduce severe IRQ override case - we remap ISA interrupts to a
> different interrupt range (all the "i < 16" clauses).
> Also, I usually have to add things like XTPR mechanism for Fosters/Gallatins
> and disable conventional IRQ balancing, since our IO-APIC doesn't work this
> way... (All of the above is in the SuSE code base).

Venkatesh, do you think you can handle these generically? Aside from
machine-specific configurations this all looks like perfectly generic.

If it's publicly discussable, what's the difference wrt. the IO-APIC?
IIRC NUMA-Q had a similar issue, where flat logical destinations were
being programmed into the IO-APIC by the IRQ balancing code, but the
NUMA-Q IO-APIC was programmed to accept physical destinations in the
RTE's via the DESTMOD bit, using physical broadcast by default, and
achieving node-locality as physical destinations may not refer to
off-node cpus. There probably isn't an issue of node locality, but even
if the IO-APIC's are programmed for logical DESTMOD it won't work with
the flat logical gunk the original IRQ balance patch programmed up.

>From 2.5.52 include/asm-i386/smp.h:

#ifdef CONFIG_CLUSTERED_APIC
 #define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
#else
 #define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
#endif


>From 2.5.52 arch/i386/mach-generic/mach_apic.h:

#ifdef CONFIG_SMP
 #define TARGET_CPUS (clustered_apic_mode ? 0xf : cpu_online_map)
#else
 #define TARGET_CPUS 0x01
#endif

And while setting up the RTE's in io_apic.c:

                entry.delivery_mode = dest_LowestPrio;
                entry.dest_mode = INT_DELIVERY_MODE;
                entry.mask = 0;                         /* enable IRQ */
                entry.dest.logical.logical_dest = TARGET_CPUS;

... which is rather blatant abuse of entry.dest.logical.logical_dest
for the NUMA-Q case, but never mind that.


On Fri, Dec 20, 2002 at 04:57:28PM -0600, Protasevich, Natalie wrote:
> I worked with the SuSE tree which has clustered code (at the first glance)
> close to the patch being discussed here.
> The 2.5 tree gives us a benefit of the subarch that will accomodate
> (hopefully) our special cases. 
> But I may need to add more hooks.

It'd be great to have the APIC interface general enough to handle all
these machines.


Bill
