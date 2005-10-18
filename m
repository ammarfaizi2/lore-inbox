Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVJRMor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVJRMor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 08:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVJRMor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 08:44:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55424 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750702AbVJRMoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 08:44:46 -0400
To: Andy Isaacson <adi@hexapodia.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org, Andi Kleen <ak@suse.de>
Subject: Re: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
References: <20051018070513.GC28997@hexapodia.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 18 Oct 2005 06:44:29 -0600
In-Reply-To: <20051018070513.GC28997@hexapodia.org> (Andy Isaacson's message
 of "Tue, 18 Oct 2005 00:05:13 -0700")
Message-ID: <m1k6gbf102.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> writes:

> On Sat, Oct 15, 2005 at 06:49:56AM -0600, Eric W. Biederman wrote:
>> Andy Isaacson <adi@hexapodia.org> writes:
>> > I believe (but have not verified) that GCC simply inhibits
>> > dead-store-elimination when the address of the variable has been taken,
>> > so this theoretical possibility is not a real danger under gcc.  And in
>> > any case, it doesn't apply to your check_nmi_watchdog, because you've
>> > got function calls after the assignment.
>> 
>> It comes very close to applying to check_nmi_watchdog as both
> [snip]
>
> You prodded me to looking in a bit more depth at the code around this,
> and I'm actually a bit concerned that volatile may not be enough of a
> guarantee that other CPUs will see the correct value.  I grant that this
> is a mostly theoretical concern, but let's take a look at the code:
>
> +static __init void nmi_cpu_busy(void *data)
> +{
> +	volatile int *endflag = data;
> +	local_irq_enable();
> +	while (*endflag == 0)
> +		barrier();
> +}
>  static int __init check_nmi_watchdog(void)
>  {
> +	volatile int endflag = 0;
> ...
> +	if (nmi_watchdog == NMI_LOCAL_APIC)
> +		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
> ...
> +	endflag = 1;
> 	printk("OK.\n");
>         if (nmi_watchdog == NMI_LOCAL_APIC)
> 		nmi_hz = 1;
> +       kfree(prev_nmi_count);
> 	return 0;
> }
>
> So CPU#0 does a smp_call_function, does some work, then sets endflag,
> does a printk, sets a static variable, calls kfree, then leaves the
> stack frame.
>
> Meanwhile, CPU#1 - CPU#N are polling waiting for endflag to make a
> transition from 0->1.
>
> Nothing that CPU#0 does after setting endflag is a guarantee that its
> store to endflag will be seen by other CPUs.  In particular, if the
> caller immediately zeros that stack location (not an unlikely
> happenstance), then it's possible that the two stores to endflag might
> be coalesced by a write buffer in CPU#0's bus interface.

Yes but if they are at all separated in time things are better. And
the constant reads of endflag are going to ping-pong the cache
line between all of the cpus which will tend to get the store pushed
out as soon as possible.  No other magic is necessary on x86.

> In particular, a NUMA x86 system is rather likely to be unfair to remote
> nodes in this case (where the other local CPUs are polling too).

In the NUMA systems I am familiar with the system will slow to a crawl
instead of performing and being unfair.

>> If there is a better idiom to synchronize the cpus which does
>> not mark the variable volatile I could see switching to that. 
>> 
>> There is a theoretical race there as some cpu might not see endflag
>> get set and the next function on the stack could set it that same
>> stack slot to 0.  I can see value in fixing that, if there is a simple
>> and clear solution.  Currently I am having a failure of imagination.
>
> Exactly (he says; after writing the same thing above I re-read the rest
> of your post).
>
> I would imagine that some kind of write memory barrier is appropriate,
> but I'm not up to date on what's in fashion in the kernel code these
> days.

Probably a counter, to ensure the code exits.  The code prints
a message if it fails, and possibly the boot breaks.  So I don't expect
bugs in this code to persist for a long time without someone screaming.

Andrew has forwarded me the first bug report already.  
http://bugzilla.kernel.org/show_bug.cgi?id=5462

It looks like we have a bug of the watchdog timers instead of one of
the expected failure modes.  After I get some more information I will
be able to see what the practical consequences are.

Eric

