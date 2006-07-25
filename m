Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWGYUG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWGYUG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWGYUG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:06:29 -0400
Received: from gw.goop.org ([64.81.55.164]:20191 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964849AbWGYUG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:06:28 -0400
Message-ID: <44C67975.8040704@goop.org>
Date: Tue, 25 Jul 2006 13:05:09 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 25/33] Implement timekeeping for Xen
References: <20060718091807.467468000@sous-sol.org>	 <20060718091954.777155000@sous-sol.org> <1153795784.23416.58.camel@cog.beaverton.ibm.com>
In-Reply-To: <1153795784.23416.58.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I was hoping to catch up with you at OLS to talk about this, but, well, 
you know...

john stultz wrote:
> Interesting. The Andi has been bugging me for a similarly designed
> per-cpu TSC clocksource, but just for generic use. I'm a little
> skeptical that it will be 100% without error, since anything dealing w/
> the TSCs have been nothing but trouble in my mind, but this looks like a
> good proving ground for the concept.
>   

I haven't had much direct experience with it, but Ian Pratt says it has 
been pretty successful in practice.  The big problem has been CPUs 
(typically AMD) which drop into a thermal throttling state without 
telling anyone (no interrupt, etc).  Xen doesn't really support CPU 
speed switching yet, so that hasn't been a problem.

> It was mentioned to me that the clocksource approach helped cleanup some
> of the xen time changes (is that really true? :), but there were still
> some outstanding issues (time inconsistencies, perhaps?). I'm just
> curious if there are any details about the issues there, or if I
> misunderstood?
>   

No, the time rework did make it much easier to plug Xen in.  The 
original Xen time patch was basically a complete copy of 
arch/i386/kernel/time.c with additional hacks.  That patch did do more 
than this once, since I was primarily aiming for basically functional & 
clean rather than fully functional, on the assumption that the patch 
would generate this discussion so we could sort out the rest of the issues.

This Xen time patch deals with:

    * setting the system clock at boot
    * ticks
    * lost & stolen ticks
    * tickless idle

In addition to this, we would also like to be able to absolutely slave 
the guest time to the hypervisor time, so that even if the hypervisor 
time changes there still a very small (or ideally 0) skew between the 
guest time.

>> This does not implement setting the hypervisor clock; nor does it
>> implement non-independent time, so hypervisor wallclock changes will
>> not affect the guest.
>>     
>
> Hmmm. I'm not sure if I understood that last line or not. I guess I need
> to think a bit about CLOCK_REALTIME vs CLOCK_MONOTONIC wrt
> hypervisiors. 
>
> I guess the question is "who owns time?" the guest OS (does it have its
> own CLOCK_REALTIME, independent of other guests?) or does the
> hypervisor? What does NTPd running on a guest actually adjust?
>   

In Xen there are two types of guest domain: dom0 and domU.  Dom0 (of 
which there can be only one) can perform privileged hypervisor 
operations, has direct access to hardware, etc; only dom0 can change 
hypervisor time.  DomU domains are typically not privileged, only have 
virtual devices, etc.  With respect to time, domains can either operate 
with "dependent time" or "independent time".

With independent time, a guest maintains its own notion of time.  It may 
be initially set from the hypervisor, or it might use something else, 
like ntp.  It may also choose to use the hypervisor as a clock source, 
or it can use any other clock.  This is the easy case, since its the 
same as a stand-alone kernel.

With dependent time, the guest time is slaved to the hypervisor time.  
At any point in time, all dependent-time guests should have a very small 
(ideally 0) skew between each other and the hypervisor itself, 
regardless of how the hypervisor time changes.  It would never make 
sense to use ntp or a non-hypervisor clocksource in a dependent-time 
guest.  settimeofday and adjtimex would be null operations (I'm not sure 
if it makes sense to have a dependent-time dom0).

There are two problems in implementing this at present.  The first is 
that the clock abstractions have nicely moved all the maintenance of the 
system time of day into the core, with no need for the arch-specific 
code to know about it.  This is nice, but it isn't clear to me how we'd 
implement a dependent-time guest.

The second problem is that at present the only way to set the hypervisor 
time is with a simple stepwise settimeofday interface, rather than a 
time-warping adjtimex interface.  This means that there's at least time 
potential for a other guests with slaved clocks could see non-monotonic 
time.  We probably need to have a full time implementation of a clock 
within Xen itself, so that the dom0 adjtimex calls just call down into 
it rather than really maintaining a local clock.

The added complication is that we don't want to make a real hypercall 
into the hypervisor every time to fetch the time.  To avoid this there 
is a shared memory region mapped from the hypervisor into the guests 
with contains periodically updated time information.  This is updated by 
the hypervisor timer interrupt (100Hz?), and so is fairly low 
precision.  To get more precise time, the guests extrapolate from this 
using the tsc.  The obvious trouble with this extrapolation is that if 
the hypervisor time slows down, the guest could see non-monotonic time 
because their extrapolation over-shoots the real hypervisor tick-to-tick 
time step.


Also, we had quite a few discussions at OLS about introducing a general 
hypervisor interface layer, and how to handle time is obviously a part 
of that.  I would imagine that most of this is a common problem to any 
hypervisor-based system rather than something specific to Xen (though 
obviously the details might vary).

>> +/* Permitted clock jitter, in nsecs, beyond which a warning will be printed. */
>> +static unsigned long permitted_clock_jitter = 10000000UL; /* 10ms */
>> +static int __init __permitted_clock_jitter(char *str)
>> +{
>> +	permitted_clock_jitter = simple_strtoul(str, NULL, 0);
>> +	return 1;
>> +}
>> +__setup("permitted_clock_jitter=", __permitted_clock_jitter);
>>     
>
> permitted_clock_jitter is a little vague and might get confused w/ the
> NTP notion of jitter. Is there a better name, or could we get a xen_
> prefix there?
>   

Sure.  I copied this over without really looking into it deeply, so I 
need to work out what this really means.   Would "permitted_backstep" 
might be a better name?  Adding "xen_" is a no-brainer though, though it 
might be something which will be common to all systems with virtualized 
time.

>> +/* These are perodically updated in shared_info, and then copied here. */
>> +struct shadow_time_info {
>> +	u64 tsc_timestamp;     /* TSC at last update of time vals.  */
>> +	u64 system_timestamp;  /* Time, in nanosecs, since boot.    */
>> +	u32 tsc_to_nsec_mul;
>> +	u32 tsc_to_usec_mul;
>>     
>
> Hmmm. Keeping separate cycle->usec and cycle->nsec multipliers is an
> interesting optimization. I'd even consider it for the generic
> clocksource code, but I suspect recalculating the independent adjustment
> factors for both kills the performance benefit.  Have you actually
> compaired against the cost of the /1000 going from nsec to usec?
>   

This is also something I copied over.  It wasn't obvious to me that it 
would be a big win either.  In fact, this patch doesn't use tsc_to_usec 
at all, so its completely redundant.

>> +	int tsc_shift;
>> +	u32 version;
>>     
>
> Errr.. Why is a version value necessary?
>   
This structure is derived from the time structure Xen maintains in 
shared memory.  If the shared memory version matches the local shadow 
version, we don't need to sync the two (I'm not sure if this is actually 
used in this patch).

>> +
>> +static DEFINE_PER_CPU(struct shadow_time_info, shadow_time);
>> +
>> +/* Keep track of last time we did processing/updating of jiffies and xtime. */
>> +static u64 processed_system_time;   /* System time (ns) at last processing. */
>> +static DEFINE_PER_CPU(u64, processed_system_time);
>>     
>
> Errr. That would confuse me right off. Global and per-cpu values having
> the same name?
>   

Yes, I was wondering about that myself.

>> +/* How much CPU time was spent blocked and how much was 'stolen'? */
>> +static DEFINE_PER_CPU(u64, processed_stolen_time);
>> +static DEFINE_PER_CPU(u64, processed_blocked_time);
>>     
>
> These seem like more generic accounting structures. Surely other
> virtualized arches have something similar? Something that should be
> looked into.
>   

Yes.

>> +	if (shift < 0)
>> +		delta >>= -shift;
>> +	else
>> +		delta <<= shift;
>>     
>
> I think there is a shift_right() macro that can avoid this.
>   

OK.

> Also I'm not sure I follow why you shift before multiply instead of
> multiply before shift? Does that not hurt your precision?
>   

It would seem so.  I'm not sure what the original thought was here.

>> +#ifdef __i386__
>> +	__asm__ (
>> +		"mul  %5       ; "
>> +		"mov  %4,%%eax ; "
>> +		"mov  %%edx,%4 ; "
>> +		"mul  %5       ; "
>> +		"xor  %5,%5    ; "
>> +		"add  %4,%%eax ; "
>> +		"adc  %5,%%edx ; "
>> +		: "=A" (product), "=r" (tmp1), "=r" (tmp2)
>> +		: "a" ((u32)delta), "1" ((u32)(delta >> 32)), "2" (mul_frac) );
>> +#elif __x86_64__
>> +	__asm__ (
>> +		"mul %%rdx ; shrd $32,%%rdx,%%rax"
>> +		: "=a" (product) : "0" (delta), "d" ((u64)mul_frac) );
>> +#else
>> +#error implement me!
>> +#endif
>> +
>> +	return product;
>> +}
>>     
>
> I think we need some generic mul_llxl_ll() wrappers here.
>   

OK.

>> +
>> +static u64 get_nsec_offset(struct shadow_time_info *shadow)
>>     
> get_nsec_offset is a little generic for a name. I know xen_ prefixes
> everywhere are irritating, but maybe something a little more specific
> would be a good idea.
>   

It's static, so it isn't affecting the global namespace.  Do you just 
mean in terms of making it easy to find with tags or backtraces?

>> +static cycle_t xen_clocksource_read(void)
>> +{
>> +	struct shadow_time_info *shadow = &per_cpu(shadow_time, smp_processor_id());
>> +
>> +	get_time_values_from_xen();
>> +
>> +	return shadow->system_timestamp + get_nsec_offset(shadow);
>> +}
>>     
>
> Does get_time_values_from_xen() really need to be called on every
> clocksource_read call?
>   

In principle it shouldn't cost much, if anything.  Hm, it doesn't look 
like it uses the version-comparison optimisation, but even without that 
it just copies some values with a low likelihood of needing to iterate.  
The version-comparison test would eliminate the tsc_to_usec divide as 
well (though that's redundant anyway).

We could call it less and rely on longer extrapolations of time, but I'm 
not sure it's worth it when traded against the possibility of 
non-monotonicity.

>> +static void init_cpu_khz(void)
>> +{
>> +	u64 __cpu_khz = 1000000ULL << 32;
>> +	struct vcpu_time_info *info;
>> +	info = &HYPERVISOR_shared_info->vcpu_info[0].time;
>> +	do_div(__cpu_khz, info->tsc_to_system_mul);
>> +	if (info->tsc_shift < 0)
>> +		cpu_khz = __cpu_khz << -info->tsc_shift;
>> +	else
>> +		cpu_khz = __cpu_khz >> info->tsc_shift;
>> +}
>>     
>
> Err.. That could use some comments. 
>   

Yep.

>> +static struct clocksource xen_clocksource = {
>> +	.name = "xen",
>> +	.rating = 400,
>> +	.read = xen_clocksource_read,
>> +	.mask = ~0,
>> +	.mult = 1,		/* time directly in nanoseconds */
>> +	.shift = 0,
>> +	.is_continuous = 1
>> +};
>>     
>
> Hmmm. The 1/0 mul/shift pair is interesting. Is it expected that NTP
> does not ever adjust this clocksource? If not the clocksource_adjust()
> function won't do well with this at all, so you might consider something
> like:
> #define XEN_SHIFT 22
> .mult = 1<<XEN_SHIFT
> .shift = XEN_SHIFT
>   

OK.  I added the 1/0 pair without really thinking about the implications 
for ntp.  It does make sense to use ntp, so I'll fix that.

>> +static void init_missing_ticks_accounting(int cpu)
>> +{
>> +	struct vcpu_register_runstate_memory_area area;
>> +	struct vcpu_runstate_info *runstate = &per_cpu(runstate, cpu);
>> +
>> +	memset(runstate, 0, sizeof(*runstate));
>> +
>> +	area.addr.v = runstate;
>> +	HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area, cpu, &area);
>> +
>> +	per_cpu(processed_blocked_time, cpu) =
>> +		runstate->time[RUNSTATE_blocked];
>> +	per_cpu(processed_stolen_time, cpu) =
>> +		runstate->time[RUNSTATE_runnable] +
>> +		runstate->time[RUNSTATE_offline];
>> +}
>>     
>
> Again, this accounting seems like it could be generically useful.
>   

OK.

>> +__init void time_init_hook(void)
>> +{
>> +	get_time_values_from_xen();
>> +
>> +	processed_system_time = per_cpu(shadow_time, 0).system_timestamp;
>> +	per_cpu(processed_system_time, 0) = processed_system_time;
>> +
>> +	init_cpu_khz();
>> +	printk(KERN_INFO "Xen reported: %u.%03u MHz processor.\n",
>> +	       cpu_khz / 1000, cpu_khz % 1000);
>> +
>> +	/* Cannot request_irq() until kmem is initialised. */
>> +	late_time_init = setup_cpu0_timer_irq;
>> +
>> +	init_missing_ticks_accounting(0);
>> +
>> +	clocksource_register(&xen_clocksource);
>> +
>> +	/* Set initial system time with full resolution */
>> +	xen_get_wallclock(&xtime);
>> +	set_normalized_timespec(&wall_to_monotonic,
>> +				-xtime.tv_sec, -xtime.tv_nsec);
>> +}
>>     
>
> Some mention of which functions require to hold what on xtime_lock would
> be useful as well (applies to this function as well as the previous ones
> already commented on).
>   

This is called from time_init(), which sets xtime without holding the 
lock.  I originally took the lock here, but removed it when I noticed 
that time_init() didn't bother.

> My only thoughts after looking at it: Using nanoseconds as a primary
> unit is often easier to work with, but less efficient.  So rather then
> keeping a tsc_timestamp + system_timestamp in two different units, why
> not keep a calculated TSC base that includes the "cycles since boot"
> which is adjusted in the same manner internally to Xen as the
> system_timestamp is. Then let the timekeeping code do the conversion for
> you.
>   

It's worth considering; we'll need to consider how that changes Xen's 
interface, but I think we'll need to look at that anyway.

> I haven't fully thought about what else it would affect in the above (I
> realize stolen_time, etc is in nsecs), but it might be something to
> consider.
>
> Am I making any sense or just babbling?

Definitely makes sense.  And I'd like to know your thoughts about how we 
can take more direct control of the system wallclock in a clean and 
sensible manner (or perhaps we shouldn't; maybe the right answer is that 
all the guests run an ntp server pointing at dom0, though that has its 
own downsides).

    J

