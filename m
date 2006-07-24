Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWGXRPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWGXRPO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWGXRPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:15:13 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:3200 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932222AbWGXRPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:15:11 -0400
Subject: Re: [Patch] statistics infrastructure - update 10
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060713074306.22e13848.akpm@osdl.org>
References: <1152707259.3028.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20060712091024.c5bd19c7.akpm@osdl.org>
	 <1152722709.3028.28.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	 <20060713010004.63215f02.akpm@osdl.org> <44B62A9B.7000707@de.ibm.com>
	 <20060713074306.22e13848.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 19:15:04 +0200
Message-Id: <1153761304.2986.130.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 07:43 -0700, Andrew Morton wrote:
> On Thu, 13 Jul 2006 13:12:27 +0200
> Martin Peschke <mp3@de.ibm.com> wrote:
> 
> > > I'd suggest that you:
> > > 
> > > - Create a new __alloc_percpu_mask(size_t size, cpumask_t cpus)
> > > 
> > > - Make that function use your newly added
> > > 
> > > 	percpu_data_populate(struct percpu_data *p, int cpu, size_t size, gfp_t gfp);
> > > 
> > > 	(maybe put `size' into 'struct percpu_data'?)
> > > 
> > > - implement __alloc_percpu() as __alloc_percpu_mask(size, cpu_possible_map)
> > 
> > Getting at the root of the problem. I will have a shot at it.
> > (It will take til next week, though - pretty warm outside...)
> > 
> > A question:
> > For symmetry's sake, should I add __free_percpu_mask(), which would
> > put NULL where __alloc_percpu_mask() has put a valid address earlier?
> > Otherwise, per_cpu_ptr() would return !NULL for an object released
> > during cpu hotunplug handling.
> > Or, is this not an issue because some cpu mask indicates that the cpu
> > is offline anyway, and that the contents of the pointer is not valid.
> 
> Sure, we need a way of freeing a cpu's storage and of zapping that CPU's
> slot.  Whether that's mask-based or just operates on a single CPU is
> debatable.  Probably the latter, given the do-it-at-hotplug-time usage
> model.

My initial patch provides both (cpu-based and mask-based). I will remove
one method if feedback seconds this assumption.

> It could be argued that the whole idea is wrong - that we're putting
> restrictions upon the implementation of alloc_percpu().  After all, an
> implementation at present could do
> 
> alloc_percpu(size):
> 	size = roundup(size, L1_CACHE_SIZE);
> 	ret = kmalloc(size*NR_CPUS + sizeof(int));
> 	*(int *)ret = size;
> 
> per_cpu_ptr(ptr, cpu):
> 	(void *)((int *)ptr + (*((int *)ptr) * cpu))
> 
> or whatever.  The API additions which are being proposed here make that
> impossible.  Or at least, more complex and slower.

I don't think so.

> Is it reasonable to assume that all implementations will, for all time,
> include at least one layer of indirection?  After all, the above would be a
> feasible implementation for non-NUMA SMP.  It's just as many derefs though.

An enhanced API doesn't need to expose how per-cpu data is actually
organised, i.e. struct percpu_data. That is, archs are still free to
implement per-cpu data in different ways.

The patch allows to make the dynamic allocation, or removal,
respectively, of per-cpu data a two-stage process:

a1) initial (partial) allocation
a2) further population as needed (i.e. when CPU is coming online)

b1) (partial) depopulation as needed (i.e. when CPU is going offline)
b2) final removal

If some arch-optimisation hindered changing objects at run time, well,
a2) and b1 would be just NOPs, leaving all the work to a1) and b2). The
performance of per_cpu_ptr() won't be affected, anyway.

Does this address your qualms?

> hmm.  1k of memory isn't much.  How much memory will all this _really_ save?

1k for a single (sample) object doesn't sound that much.
But how big will (statistic) ojects really be? I can't tell.
And how many objects will be there? I don't know.

'grep -r CPU_UP_PREPARE' indicates that there are people who are worried
about memory consumption of (unused) per-cpu data.

