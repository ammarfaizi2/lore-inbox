Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbUCTLOB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 06:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263362AbUCTLOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 06:14:00 -0500
Received: from holomorphy.com ([207.189.100.168]:63623 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263359AbUCTLNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 06:13:55 -0500
Date: Sat, 20 Mar 2004 03:13:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040320111340.GA2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com, hch@infradead.org
References: <1079651064.8149.158.camel@arrakis> <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis> <20040318175654.435b1639.pj@sgi.com> <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com> <20040320031843.GY2045@holomorphy.com> <20040320000235.5e72040a.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320000235.5e72040a.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 12:02:35AM -0800, Paul Jackson wrote:
> Other ways to reduce cpumask copies:
>  1) Additional macros, for example a boolean cpus_intersect(x,y), which
>     is true iff x overlaps y, and saves the tmp cpumask in the code:
>         cpus_and(tmp, target_cpu_mask, allowed_mask);
>         if (!cpus_empty(tmp)) {
>     or a cpus_subset(x,y) "is x a subset of y" macro to replace this:
>         cpus_and(tmp, cpumask, cpu_callout_map);
>         BUG_ON(!cpus_equal(cpumask, tmp));
>    with this:
> 	BUG_ON(!cpus_subset(cpumask, cpu_callout_map));

That probably wouldn't be tough to get merged.


On Sat, Mar 20, 2004 at 12:02:35AM -0800, Paul Jackson wrote:
>  2) Using existing macros more carefully, for example using cpu_set() to
>     set the bit in the following, and saving the copy by assignment:
> 	pending_irq_balance_cpumask[irq] = cpumask_of_cpu(new_cpu);
>     or using the existing cpu_isset() macro, replacing the code (seen
>     in part above ;):
>         cpus_and(allowed_mask, cpu_online_map, irq_affinity[selected_irq]);
>         target_cpu_mask = cpumask_of_cpu(min_loaded);
>         cpus_and(tmp, target_cpu_mask, allowed_mask);
>         if (!cpus_empty(tmp)) {
>     with the code:
> 	if (cpu_isset(min_loaded, cpu_online_map) && cpu_isset(min_loaded, irq_affinity[selected_irq]) {
> The current nested and ifdef'd complexity of the cpumask macro
> headers works against such efficient coding - it's non-trivial to see
> just what macros are available. The youngins reading this may not
> appreciate the value of reducing brain load; but the oldins might.

It was painful enough just to preserve semantics across such a far-
ranging set of changes. Ideally, yes, I would have done this in the
first place.


On Sat, Mar 20, 2004 at 12:02:35AM -0800, Paul Jackson wrote:
> 2) Pass a cpumask pointer to a function that generates a cpumask
> instead of taking one as a return value, letting the called function
> fill in the memory so referenced.  We should not be trying to hide
> such details, unless we can do so seamlessly and consistent with
> traditional 'C' semantics.

This is a generally sane thing to do.


On Sat, Mar 20, 2004 at 12:02:35AM -0800, Paul Jackson wrote:
>  3) Passing a const cpumask pointer to a function that examines a cpumask
>     instead of passing the cpumask by value (on small systems, its one word
>     either way - on big systems, it saves copying a multiword mask on the
>     stack).

IIRC the overhead of indirection on smaller systems was regarded as
unacceptable for these cases, which is what motivated the wrapper type.
If you can get the naked versions merged, more power to you.


On Sat, Mar 20, 2004 at 12:02:35AM -0800, Paul Jackson wrote:
>  4) Throwing away dead code:
> 	static int physical_balance = 0;
>         cpumask_t tmp;
> 	cpus_shift_right(tmp, cpu_online_map, 2);
> 	if (smp_num_siblings > 1 && !cpus_empty(tmp)
> 		physical_balance = 1;
> The above code fragments are from arch/i386 in 2.6.3-rc1-mm1.

[warning! long-winded response follows]

This isn't quite dead; physical_balance isn't a local. it's a state
variable static to io_apic.c and it determines the behavior later after
boot. Frankly, this code fragment is inexplicably bizarre and I've
never seen the code in action, as I have something very closely
approximating zero access (or less) to the systems that use it. In
general, this means you're stuck being very literal about its semantics
until the situation is clarified. This used to be something like

if (smp_num_siblings > 1 && (cpu_online_map >> 2))
	physical_balance = 1;

which defied my attempts to reverse-engineer its true meaning in terms
of cpumasks. In terms of HT, it "wants to do":

if (logical_cpus_per_physical_cpu() > 1 && nr_physical_cpus() > 1)
	set_state_variable_to_balance_by_physical_cpus();

I'm not wild about this kind of thing and would rather not codify
breakage on mixed cpu revision systems any more so than its already
done. The semantics also differ slightly if/when cpu_online_map is
arranged in varying ways, which obscured the issue and what ultimately
stifled the otherwise strong urge to improve it.

A potential "cleanup" that occurred to me is:

if (cpus_weight(cpu_online_map) > smp_num_siblings)
	physical_balance = 1;

which isn't really "good enough" either, but the best that can be done
with the now-extant machine descriptions. I would rather leave the
thing as-is until something equivalent to the following can be done
and the rest of arch/i386 swept to properly deal with HT in general:

if (nr_logical_cpus() > nr_physical_cpus() && nr_physical_cpus() > 1)
	physical_balance = 1;

but this is not how the machine descriptions are arranged now, and I
personally have neither the access to machines nor time allotted to
implement the changes required to fix this code properly. Other,
similar things hold for other bizarre cases where there's fear of
general fragility and bizarre bit twiddling forms of checks that would
vary in semantics from the "obviously cleaner" variants that can't be
cleaned up willy-nilly without the backing to get at the systems to
verify the changes. The only real exceptions to this are when things
are broken as-is, and what you have is an immediate and relatively
localized fix.

It's really unclear that the ia32 APIC/SMP disaster can ever feasibly
be cleaned up, as the code already landed there, and churning it just
raises the spectre of version skew, a rather long, dreary fight to get
the whole of the corrections merged, and the still more terrifying
possibility of incomplete merges leaving various out-of-synch codebases
(e.g. distros) in broken states. Let it serve as an example as to why
things should be done right the first time.

In conclusion, I converted a lot of the i386 arch code very literally
for a good reason. I wish us all the best of noseplugs as we're all
stuck holding our noses while the dead woodchuck under the porch stinks
up the kernel in perpetuity.


-- wli
