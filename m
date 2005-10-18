Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVJRHFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVJRHFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVJRHFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:05:15 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:64666 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S932421AbVJRHFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:05:14 -0400
Date: Tue, 18 Oct 2005 00:05:13 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org, Andi Kleen <ak@suse.de>
Subject: Re: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
Message-ID: <20051018070513.GC28997@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13bn3ndvv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 06:49:56AM -0600, Eric W. Biederman wrote:
> Andy Isaacson <adi@hexapodia.org> writes:
> > I believe (but have not verified) that GCC simply inhibits
> > dead-store-elimination when the address of the variable has been taken,
> > so this theoretical possibility is not a real danger under gcc.  And in
> > any case, it doesn't apply to your check_nmi_watchdog, because you've
> > got function calls after the assignment.
> 
> It comes very close to applying to check_nmi_watchdog as both
[snip]

You prodded me to looking in a bit more depth at the code around this,
and I'm actually a bit concerned that volatile may not be enough of a
guarantee that other CPUs will see the correct value.  I grant that this
is a mostly theoretical concern, but let's take a look at the code:

+static __init void nmi_cpu_busy(void *data)
+{
+	volatile int *endflag = data;
+	local_irq_enable();
+	while (*endflag == 0)
+		barrier();
+}
 static int __init check_nmi_watchdog(void)
 {
+	volatile int endflag = 0;
...
+	if (nmi_watchdog == NMI_LOCAL_APIC)
+		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
...
+	endflag = 1;
	printk("OK.\n");
        if (nmi_watchdog == NMI_LOCAL_APIC)
		nmi_hz = 1;
+       kfree(prev_nmi_count);
	return 0;
}

So CPU#0 does a smp_call_function, does some work, then sets endflag,
does a printk, sets a static variable, calls kfree, then leaves the
stack frame.

Meanwhile, CPU#1 - CPU#N are polling waiting for endflag to make a
transition from 0->1.

Nothing that CPU#0 does after setting endflag is a guarantee that its
store to endflag will be seen by other CPUs.  In particular, if the
caller immediately zeros that stack location (not an unlikely
happenstance), then it's possible that the two stores to endflag might
be coalesced by a write buffer in CPU#0's bus interface.

Making endflag volatile does not affect the write buffer; it simply
forces the compiler to generate the "store to memory" instruction at the
appropriate place in the code flow.  To affect the write buffer, the
virtual address would have to be flagged appropriately (on x86, using an
MTRR; on MIPS, using a flag on the TLB entry; similar options on other
platforms) or an appropriate store instruction such as "non-temporal
store" would have to be used.  Or, a memory barrier.

In particular, a NUMA x86 system is rather likely to be unfair to remote
nodes in this case (where the other local CPUs are polling too).

> If there is a better idiom to synchronize the cpus which does
> not mark the variable volatile I could see switching to that. 
> 
> There is a theoretical race there as some cpu might not see endflag
> get set and the next function on the stack could set it that same
> stack slot to 0.  I can see value in fixing that, if there is a simple
> and clear solution.  Currently I am having a failure of imagination.

Exactly (he says; after writing the same thing above I re-read the rest
of your post).

I would imagine that some kind of write memory barrier is appropriate,
but I'm not up to date on what's in fashion in the kernel code these
days.

-andy
