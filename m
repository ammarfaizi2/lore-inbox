Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbVLTXxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbVLTXxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 18:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVLTXxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 18:53:07 -0500
Received: from ozlabs.org ([203.10.76.45]:45196 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932186AbVLTXxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 18:53:05 -0500
Date: Wed, 21 Dec 2005 10:52:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org,
       perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [Perfctr-devel] Re: quick overview of the perfmon2 interface
Message-ID: <20051220235245.GE19042@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, eranian@hpl.hp.com,
	linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
	linux-ia64@vger.kernel.org, perfctr-devel@lists.sourceforge.net
References: <20051219113140.GC2690@frankl.hpl.hp.com> <20051220025156.a86b418f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220025156.a86b418f.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 02:51:56AM -0800, Andrew Morton wrote:
> Stephane Eranian <eranian@hpl.hp.com> wrote:
> > 	or create full sampling measurements.
> > ...
> > 
> > 	Sampling is supported at the user level and also at the kernel level with
> > 	the ability to use a kernel-level sampling buffer. The format of the kernel
> > 	sampling buffer is implemented by a kernel pluggable module. As such it is
> > 	very easy to develop a custom format without any modification to the
> > 	interface nor its implementation.
> 
> Why would one want to change the format of the sampling buffer?
> 
> Would much simplification be realised if we were to remove this option?
> 
> > 	To compensate for limitations of many PMU, such as a small number of
> > 	counters, the interface also exports the notion of event sets and allows
> > 	applications to multiplex sets, thereby allowing more events to be
> > 	measured in a single run than there are actual counters.
> > 
> > 	The PMU register description is implemented by a kernel pluggable module
> > 	thereby allowing new hardware to be supported without the need to wait
> > 	for the next release of the kernel.
> 
> Is that option important, or likely to be useful?  Are you sure there isn't
> some overdesign here?

Heh, I've been wondering that for some time.  It's better than it
was..

[snip]
> > 	- pfm_load_context(int fd, pfarg_load_t *load)
> > 
> > 	   Attach a perfmon context to either a thread or a processor. In the
> > 	   case of a thread, the thread id is passed. In the case of a
> > 	   processor, the context is bound to the CPU on which the call is
> > 	   performed.
> 
> Why should userspace concern itself with a particular CPU?  That's really
> only valid if the process has bound itself to a single CPU?  If the CPU is
> fully virtuialised by perfmon (it is) then why do we care about individual
> CPU instances?

This option is for a context monitoring the whole system, rather than
a single thread, which you sometimes want to do (because one thread's
actions could have an impact on others, for example).  But a context
can't sensibly track more than one thing simultaneously executing, so
it needs to be bound to a particular CPU.  In practice such a context
would almost invariably be used as part of a 1-per-cpu set of contexts
the results ultimately aggregated.

[snip]
> > 	A system-wide context allows a tool to monitor all activities on one
> > 	processor, i.e, across all threads. Full System-wide monitoring in an
> > 	SMP system is achieved by creating and binding a perfmon context on
> > 	each processor. By construction, a perfmon context can only be bound
> > 	to one processor at a time.  This design choice is motivated by the
> > 	desire to enforce locality and to simplify the kernel implementation.
> 
> hm.  I'm surprised at such a CPU-centric approach.  I'd have expected to
> see a more task-centric model.

It is task-centric, usually.  The CPU binding is only when doing
full-system monitoring.  The above is a bit unclear, giving undue
emphasis to the per-CPU case: the point is that (from the kernel's
point of view) a context can only ever be active on one CPU at a time.
For a thread-virtualized context (the common case) that happens
automatically because the thread can't run on multiple CPUs at once,
for a full system monitoring context the binding must be explicit instead.

[snip]
> > 	This is not such a new idea, it is present in OProfile or perfctr.
> > 	However, the interface needs to remains generic and flexible. If
> > 	the sampling buffer is in kernel, its format and what gets recorded
> > 	becomes somehow locked by the implementation. Every tool has different
> > 	needs. For instance, a tool such as Oprofile may want to aggregate
> > 	samples in the kernel, others such as VTUNE want to record all samples
> > 	sequentially. Furthermore, some tools may want to combine in each sample
> > 	PMU information with other kernel level information, such as a kernel
> > 	call stack for instance. It is hard to design a generic buffer format
> > 	that can handle all possible request. Instead, the interface provides
> > 	an infrastructure  in which the buffer format is implemented by a kernel
> > 	module. Each module controls, what gets recorded, how it is recorded,
> > 	how the information is exported to user, when a 'buffer full'
> > 	notification must be sent. The perfmon core has an interface to
> > 	dynamically register new formats. Each format is uniquely identified by
> > 	a 128-bit UUID which is passed by the tool when the context is created.
> > 	Arguments for the buffer format are also passed during this call.
> 
> Well that addresses my earlier questions I guess.
> 
> Is this actually useful?  oprofile is there and works OK.  Again, is there
> overdesign here?
> 
> And why is it necessary to make the presentation of the samples to
> userspace pluggable?  I'd have thought that a single relayfs-based
> implementation would suit all sampling buffer formats.

I think there's some confusion here because the term "pluggable buffer
format" isn't a particularly good one.  It makes sense in the context
of perfmon's internal architecture, but doesn't really convey the
basic idea.

As I understand it from working with the perfmon code a bit, the point
is not so much the buffer itself, but the selection of what things to
sample when and how.  The default format gives a fairly configurable
set of ways to do this but for some applications you'd have a choice
of either not collecting all the data you need, or collecting so much
extra data that it would bog down trying to save and/or aggregate it
all.  So, the point of "custom buffer formats" is more a matter of
being able to add new (potentially application specific) sampling
schemes.

As you say, relayfs should be fine for the actual presentation of the
buffer to userspace, whatever it contains.

[snip]
> Overall: I worry about excessive configurability, excessive
> features.

Join the club :)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
