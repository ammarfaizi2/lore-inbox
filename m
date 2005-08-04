Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVHDOFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVHDOFW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVHDOFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:05:21 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7880 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262554AbVHDOEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:04:46 -0400
Date: Thu, 4 Aug 2005 07:04:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, amitkale@linsyssoft.com
Subject: Re: [patch 07/15] Basic x86_64 support
Message-ID: <20050804140445.GB3337@smtp.west.cox.net>
References: <resend.6.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org> <resend.7.2972005.trini@kernel.crashing.org> <20050803130531.GR10895@wotan.suse.de> <20050803133756.GA3337@smtp.west.cox.net> <20050804123900.GR8266@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804123900.GR8266@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 02:39:00PM +0200, Andi Kleen wrote:
> > > That doesn't make much sense here. tasklet will only run when interrupts
> > > are enabled, and that is much later. You could move it to there.
> > 
> > Where?  Keep in mind it's really only x86_64 that isn't able to break
> > sooner.
> 
> The local_irq_enable() call in init/main.c:start_kernel()

But as I say, only x86_64 needs this kind of delay.

> If you want to run gdb earlier you need to do it without a tasklet.

We really would like to try again once stacks are setup (IOW, once
if ((&__get_cpu_var(init_tss))[0].ist[0])) is true).

> > > > --- linux-2.6.13-rc3/include/asm-x86_64/hw_irq.h~x86_64-lite	2005-07-29 13:19:10.000000000 -0700
> > > > +++ linux-2.6.13-rc3-trini/include/asm-x86_64/hw_irq.h	2005-07-29 13:19:10.000000000 -0700
> > > > @@ -55,6 +55,7 @@ struct hw_interrupt_type;
> > > >  #define TASK_MIGRATION_VECTOR	0xfb
> > > >  #define CALL_FUNCTION_VECTOR	0xfa
> > > >  #define KDB_VECTOR	0xf9
> > > > +#define KGDB_VECTOR	0xf8
> > > 
> > > I already allocated these vectors for something else.
> > 
> > Is there another we can use?  Just following what looked to be the
> > logical order.
> 
> How about you use KDB_VECTOR and rename it to DEBUG_VECTOR
> and then just check if kgdb is currently active? 

I can do the kgdb and generic changes at least.

[snip]
> > > >  	cfg = __prepare_ICR(shortcut, vector, dest);
> > > > +        if (vector == KGDB_VECTOR) {
> > > > +                 /*
> > > > +                  * KGDB IPI is to be delivered as a NMI
> > > > +                  */
> > > > +                 cfg = (cfg&~APIC_VECTOR_MASK)|APIC_DM_NMI;
> > > > +         }
> > > 
> > > No way adding another ugly special case like this. I wanted
> > > to rip out the KDB version for a long time.
> > 
> > I'd be happy to rework it in a cleaner manner, just point me at an
> > example please.
> 
> The code is equivalent to passing shortcut|APIC_DM_NMI and vector == 0

OK.  I'll see if I can change things around then, thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
