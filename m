Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWHYNOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWHYNOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWHYNOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:14:18 -0400
Received: from mail.suse.de ([195.135.220.2]:5536 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750926AbWHYNOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:14:18 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Date: Fri, 25 Aug 2006 15:13:58 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com> <p733bbn7m6o.fsf@verdi.suse.de> <20060825124905.GD5330@frankl.hpl.hp.com>
In-Reply-To: <20060825124905.GD5330@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608251513.58729.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 14:49, Stephane Eranian wrote:

> Yes, wrmsrl() is fine as long as I write MSR for counters (i.e., more than 32 bits)
> using wrmsrl() is fine. But there is code where I need to write an address into
> an MSR (namely MSR_IA32_DS_AREA). On i386 the address is 32 bit, on x86_64, it
> is 64-bit, the macros is mostly here to hide this.
> 
> 	wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);
> 
> That generates a warning from the compiler for i386.

Fix the header to not cause the warning then? (in a separate patch) 

> Are we already running with cr4.pce set today?

Not yet. But soon.
 
> The cr4.pce allows all PMC (counter) to be read at user level, not just perfctr0.
> When enabled all counters are readable at user level from any process. A process
> can see the value accumulated by another process (assuming monitoring in per-thread
> mode).

Yes, we'll have to live with that.

> Some people may see this as a security risk.

Maybe some paranoiacs, but we normally don't design software for these people's
obsessions.

> On the other hand all you see  
> is counts.

Exactly. And you always have RDTSC anyways.


> So as long as the i386/x86_64 PMU only collect counts, this could be 
> fine. The day they can capture addresses, this becomes more problematic, I think.

We can worry about it when it happens. Whenever anyone adds that capability
to the hardware they will hopefully add new separate ring 3 control bits.

> I don't understand this. Could you describe some more?

Look at the existing x86-64 interrupt handlers. enter/exit idle
allows notifiers to hook into the idle thread entering/exiting.
This needs to be added to all interrupt handlers that can interrupt
the idle thread.

BTW you might be able to simplify some of your code by exploiting
those. i386 currently doesn't have them, but i wouldn't see a problem
with adding them there too.
 
> Yes, that is my end goal. The current does not do this just yet.
> There needs to be an (MSR) reservation API that both NMI watchdog
> and perfmon could use.


The post 2.6.18 -mm* / my tree code has that already for i386/x86-64

> 
> Are you planning on using perfctr0 for both NMI watchdog and a
> replacement for RDTSC? 

Yes.

> Don't you need more than one counter for this?

I don't think so. Why?

> 
> 
> > There is a new sysctl in the upcomming .19 tree that will allow
> > to disable it at runtime. If that's done it's fine if you take
> > over the PMU completely, but don't do it by default please.
> > > +
> 
> When NMI watchdog shuts down, it would need to free the counter
> it was using. Then we could pick it up.


The new code does reservation, although i don't think there is currently
a way to get you notified when it happens. I suppose that could be added.
But then I'm not sure it's a problem because you can just check whenever
you set the perfmon state up.
 
> Are those following the K8 PMU model?

Athlon yes (the registers are the actual counters are different) 

Cyrix et.al. I don't know, but if they have a PMU it is likely
different.

It's probably fine to not support Cyrix.et.al. as long as you don't crash
during initialization on them,
but supporting Athlon would be nice because it is still widely used.
But I guess it would be fine to not do that initially and wait for user 
patches.
 
> Agreed. You would need more than one bit for this.

Feel free to add as many as you need. Just in separate patches please.
 
> > Is there a particular reason you can't just limit it to the number
> > of compiled in counters and ignore the others? 
> > 
> Yes, that's another possibility as long as counters are totally independent
> of each other.

Doing so would be more future-proof.
 
> I need to check this. I remember having had some problems with this on i386.

If there are problems fix them in the source please, don't try 
to work around them.
 

> > > +
> > > +#ifdef CONFIG_SMP
> > > +	num_ht = cpus_weight(cpu_sibling_map[0]);
> > > +#else
> > > +	num_ht = 1;
> > > +#endif
> > > +
> > > +	PFM_INFO("cores/package=%d threads/core=%d",
> > > +		 cpu_data->x86_max_cores,
> > > +		 num_ht);
> > 
> > Not trusting /proc/cpuinfo?
> 
> I need to know the info from inside the kernel to dynamically adjust the
> number of PMU registers available.


My point was that the printk is redundant, but ok.

-Andi
