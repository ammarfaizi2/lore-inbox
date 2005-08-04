Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVHDMmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVHDMmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVHDMkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:40:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:62410 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262509AbVHDMjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:39:07 -0400
Date: Thu, 4 Aug 2005 14:39:00 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       amitkale@linsyssoft.com
Subject: Re: [patch 07/15] Basic x86_64 support
Message-ID: <20050804123900.GR8266@wotan.suse.de>
References: <resend.6.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org> <resend.7.2972005.trini@kernel.crashing.org> <20050803130531.GR10895@wotan.suse.de> <20050803133756.GA3337@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803133756.GA3337@smtp.west.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That doesn't make much sense here. tasklet will only run when interrupts
> > are enabled, and that is much later. You could move it to there.
> 
> Where?  Keep in mind it's really only x86_64 that isn't able to break
> sooner.

The local_irq_enable() call in init/main.c:start_kernel()

If you want to run gdb earlier you need to do it without a tasklet.

> > > --- linux-2.6.13-rc3/include/asm-x86_64/hw_irq.h~x86_64-lite	2005-07-29 13:19:10.000000000 -0700
> > > +++ linux-2.6.13-rc3-trini/include/asm-x86_64/hw_irq.h	2005-07-29 13:19:10.000000000 -0700
> > > @@ -55,6 +55,7 @@ struct hw_interrupt_type;
> > >  #define TASK_MIGRATION_VECTOR	0xfb
> > >  #define CALL_FUNCTION_VECTOR	0xfa
> > >  #define KDB_VECTOR	0xf9
> > > +#define KGDB_VECTOR	0xf8
> > 
> > I already allocated these vectors for something else.
> 
> Is there another we can use?  Just following what looked to be the
> logical order.

How about you use KDB_VECTOR and rename it to DEBUG_VECTOR
and then just check if kgdb is currently active? 

KDB can do the same.

I changed the assignment in my tree like this:

#define SPURIOUS_APIC_VECTOR    0xff
#define ERROR_APIC_VECTOR       0xfe
#define RESCHEDULE_VECTOR       0xfd
#define CALL_FUNCTION_VECTOR    0xfc
#define KDB_VECTOR              0xfb    /* reserved for KDB */
#define THERMAL_APIC_VECTOR     0xfa
/* 0xf9 free */
#define INVALIDATE_TLB_VECTOR_END       0xf8
#define INVALIDATE_TLB_VECTOR_START     0xf0    /* f0-f8 used for TLB flush */


but that can be merged later. THere will be probably more changes
with the per CPU IDT planned.

> > >  	cfg = __prepare_ICR(shortcut, vector, dest);
> > > +        if (vector == KGDB_VECTOR) {
> > > +                 /*
> > > +                  * KGDB IPI is to be delivered as a NMI
> > > +                  */
> > > +                 cfg = (cfg&~APIC_VECTOR_MASK)|APIC_DM_NMI;
> > > +         }
> > 
> > No way adding another ugly special case like this. I wanted
> > to rip out the KDB version for a long time.
> 
> I'd be happy to rework it in a cleaner manner, just point me at an
> example please.

The code is equivalent to passing shortcut|APIC_DM_NMI and vector == 0

> > > -	asm volatile(SAVE_CONTEXT						    \
> > > +       asm volatile(".globl __switch_to_begin\n\t"				    \
> > > +		     "__switch_to_begin:\n\t"					  \
> > > +		     SAVE_CONTEXT						  \
> > 
> > Why is this needed?
> 
> So that backtraces show they're in switch_to rather than somewhere else
> (since it's a #define we wouldn't know otherwise).

Ok.

-Andi
