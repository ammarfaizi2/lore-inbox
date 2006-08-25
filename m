Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWHYOoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWHYOoO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWHYOoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:44:14 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:60654 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932458AbWHYOoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:44:13 -0400
Date: Fri, 25 Aug 2006 07:27:59 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Message-ID: <20060825142759.GH5330@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com> <p733bbn7m6o.fsf@verdi.suse.de> <20060825124905.GD5330@frankl.hpl.hp.com> <200608251513.58729.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608251513.58729.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, Aug 25, 2006 at 03:13:58PM +0200, Andi Kleen wrote:
> 
> > I don't understand this. Could you describe some more?
> 
> Look at the existing x86-64 interrupt handlers. enter/exit idle
> allows notifiers to hook into the idle thread entering/exiting.
> This needs to be added to all interrupt handlers that can interrupt
> the idle thread.
> 
Ok, now I understand.

> BTW you might be able to simplify some of your code by exploiting
> those. i386 currently doesn't have them, but i wouldn't see a problem
> with adding them there too.
>  
I think I will drop the EXCL_IDLE feature given that most PMU stop
counting when you go low-power. The feature does not quite do what
we want because it totally exclude the idle from monitoring, yet
the idle may be doing useful kernel work, such as fielding interrupts.


> > Yes, that is my end goal. The current does not do this just yet.
> > There needs to be an (MSR) reservation API that both NMI watchdog
> > and perfmon could use.
> 
> 
> The post 2.6.18 -mm* / my tree code has that already for i386/x86-64
> 
I will look into those. you are talking about the interface put in place
by Don Zickus.

> > Don't you need more than one counter for this?
> 
> I don't think so. Why?

For NMI, you want the counter to overflow at a certain frequency:

        wrmsrl(MSR_K7_PERFCTR0, -((u64)cpu_khz * 1000 / nmi_hz));

But for RDTSC, I would think you'd simply want the counter to count
monotonically. Given that perfctr0 is not 64-bit but 40, it will also
overflow (or wraparound) but presumably at a lower frequency than the
watchdog timer. I think I am not so clear on the intended usage user
level usage of perfctr0 as a substitute for RDTSC.


> > > There is a new sysctl in the upcomming .19 tree that will allow
> > > to disable it at runtime. If that's done it's fine if you take
> > > over the PMU completely, but don't do it by default please.
> > > > +
> > 
> > When NMI watchdog shuts down, it would need to free the counter
> > it was using. Then we could pick it up.
> 
> 
> The new code does reservation, although I don't think there is currently
> a way to get you notified when it happens. I suppose that could be added.
> But then I'm not sure it's a problem because you can just check whenever
> you set the perfmon state up.
>  
Perfmon2 would need to check and atomically secure registers 
its users could use. The trick is when is a good time to do this?
It cannot just be done at initialiazation of perfmon2. It needs to be
done each time a context is created, or each time a context is actually
attached because there is where you really need to access the HW resource.

It is important that we get this allocator in place fairly soon. People
have already asked me when they will be able to share the PMU with a finer
granularity betweeen system-wide and per-thread session. Today, we do
mutual exclusion between those two but that's too strong. Some PMU
architecturesmake splitting the PMU resource into different
independent "consumers" fairly easy to do, including when sampling
(assuming you have a central PMU interrupt dispatcher).

My point really is that you need to share the PMU between different
subsystems (perfmon, NMI, RDTSC-emulation) but also inside perfmon2
between the various users. That has to be done at the register level.
The interrupt handler then has to dispatch based on what overflowed.
Given the need for NMI, I assume we have to keep PMU interrupt on the
NMI vector. When the interrupt is actually caused by perfmon2, we would
have to post a lower priority interrupt on the vector used by perfmon2.


> > Are those following the K8 PMU model?
> 
> Athlon yes (the registers are the actual counters are different) 
> 

> Cyrix et.al. I don't know, but if they have a PMU it is likely
> different.
> 
> It's probably fine to not support Cyrix.et.al. as long as you don't crash
> during initialization on them,
> but supporting Athlon would be nice because it is still widely used.
> But I guess it would be fine to not do that initially and wait for user 
> patches.
>  
Yes, I would certainly prefer that because I do not have such machine
so it is hard to test.

> > > > +#ifdef CONFIG_SMP
> > > > +	num_ht = cpus_weight(cpu_sibling_map[0]);
> > > > +#else
> > > > +	num_ht = 1;
> > > > +#endif
> > > > +
> > > > +	PFM_INFO("cores/package=%d threads/core=%d",
> > > > +		 cpu_data->x86_max_cores,
> > > > +		 num_ht);
> > > 
> > > Not trusting /proc/cpuinfo?
> > 
> > I need to know the info from inside the kernel to dynamically adjust the
> > number of PMU registers available.
> 
> 
> My point was that the printk is redundant, but ok.

Ok, now I get it.

Thanks.
-- 
-Stephane
