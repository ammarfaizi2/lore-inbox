Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTEZWi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbTEZWZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:25:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64718
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262312AbTEZWKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:10:54 -0400
Date: Tue, 27 May 2003 00:24:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030526222406.GU3767@dualathlon.random>
References: <60830000.1053575867@[10.10.2.4]> <Pine.LNX.3.96.1030522130544.19863B-100000@gatekeeper.tmr.com> <20030522.154410.104047403.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522.154410.104047403.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 03:44:10PM -0700, David S. Miller wrote:
>    From: Bill Davidsen <davidsen@tmr.com>
>    Date: Thu, 22 May 2003 13:24:26 -0400 (EDT)
> 
>    > You have to install new modutils to even use modules with the 2.5.x
>    > kernel, given that why are we even talking about the "inconvenience"
>    > of installing the usermode IRQ balancer as being a blocker for
>    > ripping out the in-kernel stuff?
>    
>    But you don't have to use modules at all, while running without
>    interrupts isn't an option.
>    
> Interrupts WORK without the IRQ balancing.
> 
> Come one people, get real already.

this is not the point, the whole point of irq balancing is performance,
not functionality.

Tell me how to do what I'm doing in my 2.4 tree in userspace (this was my
partially rewritten implementation based on Ingo's original code that I found
very suboptimal while reading it):

#ifdef CONFIG_SMP

#define IRQ_BALANCE_INTERVAL (HZ/50)

typedef struct {
	unsigned int cpu;
	unsigned long timestamp;
} ____cacheline_aligned irq_balance_t;

static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned;
extern unsigned long irq_affinity [NR_IRQS];

#define IRQ_ALLOWED(cpu,allowed_mask) \
		((1UL << cpu) & (allowed_mask))

static unsigned long move(unsigned int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
{
	unsigned int cpu = curr_cpu;
	unsigned int phys_id;

	phys_id = cpu_logical_map(cpu);
	if (IRQ_ALLOWED(phys_id, allowed_mask) && idle_cpu(phys_id))
		return cpu;

	goto inside;

	do {
		if (unlikely(cpu == curr_cpu))
			return cpu;
inside:
		if (direction == 1) {
			cpu++;
			if (cpu >= smp_num_cpus)
				cpu = 0;
		} else {
			cpu--;
			if (cpu == -1)
				cpu = smp_num_cpus-1;
		}

		phys_id = cpu_logical_map(cpu);
	} while (!IRQ_ALLOWED(phys_id, allowed_mask) || !idle_cpu(phys_id));

	return cpu;
}

#endif /* CONFIG_SMP */

static inline void balance_irq(int irq)
{
#if CONFIG_SMP
	irq_balance_t *entry = irq_balance + irq;
	unsigned long now = jiffies;

	if (unlikely(time_after(now, entry->timestamp + IRQ_BALANCE_INTERVAL))) {
		unsigned long allowed_mask;
		unsigned int new_cpu;
		int random_number;

		entry->timestamp = now;

		rdtscl(random_number);
		random_number &= 1;

		allowed_mask = cpu_online_map & irq_affinity[irq];
		new_cpu = move(entry->cpu, allowed_mask, now, random_number);
		if (entry->cpu != new_cpu) {
			entry->cpu = new_cpu;
			set_ioapic_affinity(irq, clustered_apic_mode == 0 ?
			1UL << new_cpu : cpu_present_to_apicid(entry->cpu) );
		}
	}
#endif
}

this is much better than whatever you can do in userspace. You'll never be able
to react quickly to avoid wasting idle timeslices of cpus in userspace.

Unfortunately I didn't see number comparisons of this with the userspace
balancer, but the above in the numbers is an order of magnitude better
than all other 2.4 patches I seen floating around. the other patches are
even reprogramming the IO-apic when no irq routing change is done, and
they reprogram at an overkill frequency, so no surprise the above is
much faster and no surprise the irq balancer as well would be much
faster than the other patches.

Would be interesting to compare the above with the userspace balancer in
a system with some cpu sometime idle, like some network bound file
serving or similar.

To you it seems obvious no kernel-only optimization like the above (not
remotely doable in userspace) can ever exist, this isn't true as far as I can
tell, and to me those heuristics make lots of sense, especially on a 64way smp
not under 100% cpu utilization.

and if you put the userspace balancer on top of the above the above will
be only a branch cost (not even an extern call) (unlike the other
patches that were reprogramming the ioapic regardless).

And overall I believe it doesn't make much sense to leave irq balancing in
userspace, the advantages seems too few and the disavantages seems way too
many.

The portability argument is a plain symptom of the lack of an API to write the
algorithm in a portable way: the proof is the /proc/irq interface that for
istance is still duplicated across all ports. Grep for register_irq_proc,
you'll find it in sparc64 in i386 etc..  fix that and the portability argument
will go away.  Infact I wish that the sparc64 port will finally go in sync with
the rest of the kernel with regards to irqs. x86, alpha x86-64 ia64  are
all just using the exact same logic for irq handling, sparc is the only
relevant arch that refuses to go in sync. If you miss functionalty from
the current irq API in all major ports just extend it and put sparc in
sync so finally irq.c can be moved to kernel and not under arch/. If
sparc64 is so much smarter than the rest of the archs in handling
interrupts then just make it the standard for all ports. Then be sure
there will be no risk of portability issues while writing an irq
balancing algorithm in kernel. I would like to see that cleanup
happening, that wouldn't only help stuff like irq balancing but it
should also help writing portable realtime hooks that needs to deal with
those bits in irq.c. Deferring the need of this further with the excuse
that irq balancing in userspace is better doesn't sound good to me. Sure
I also don't like to see the irq balancing code cut and pasted a dozen
of times in the kernel, but keeping it in userspace just hides the
problem, that the only common API is provided to userspace and not to
the kernel itself.

Maybe you leave sparc64 with its own implementation to avoid one
indirect call per irq? But do you really think those ugly if else are
faster than a indirect call? what when you'll have to support one more
chipset?

	if (tlb_type == cheetah || tlb_type == cheetah_plus) {
		/* We set it to our Safari AID. */
		__asm__ __volatile__("ldxa [%%g0] %1, %0"
				     : "=r" (tid)
				     : "i" (ASI_SAFARI_CONFIG));
		tid = ((tid & (0x3ffUL<<17)) << 9);
		tid &= IMAP_AID_SAFARI;
	} else if (this_is_starfire == 0) {
		/* We set it to our UPA MID. */
		__asm__ __volatile__("ldxa [%%g0] %1, %0"
				     : "=r" (tid)
				     : "i" (ASI_UPA_CONFIG));
		tid = ((tid & UPA_CONFIG_MID) << 9);
		tid &= IMAP_TID_UPA;
	} else {
		tid = (starfire_translate(imap, smp_processor_id()) << 26);
		tid &= IMAP_TID_UPA;
	}

Andrea
