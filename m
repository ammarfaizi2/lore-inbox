Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWGMOnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWGMOnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWGMOnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 10:43:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751556AbWGMOnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 10:43:13 -0400
Date: Thu, 13 Jul 2006 07:43:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 10
Message-Id: <20060713074306.22e13848.akpm@osdl.org>
In-Reply-To: <44B62A9B.7000707@de.ibm.com>
References: <1152707259.3028.7.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<20060712091024.c5bd19c7.akpm@osdl.org>
	<1152722709.3028.28.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<20060713010004.63215f02.akpm@osdl.org>
	<44B62A9B.7000707@de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 13:12:27 +0200
Martin Peschke <mp3@de.ibm.com> wrote:

> > I'd suggest that you:
> > 
> > - Create a new __alloc_percpu_mask(size_t size, cpumask_t cpus)
> > 
> > - Make that function use your newly added
> > 
> > 	percpu_data_populate(struct percpu_data *p, int cpu, size_t size, gfp_t gfp);
> > 
> > 	(maybe put `size' into 'struct percpu_data'?)
> > 
> > - implement __alloc_percpu() as __alloc_percpu_mask(size, cpu_possible_map)
> 
> Getting at the root of the problem. I will have a shot at it.
> (It will take til next week, though - pretty warm outside...)
> 
> A question:
> For symmetry's sake, should I add __free_percpu_mask(), which would
> put NULL where __alloc_percpu_mask() has put a valid address earlier?
> Otherwise, per_cpu_ptr() would return !NULL for an object released
> during cpu hotunplug handling.
> Or, is this not an issue because some cpu mask indicates that the cpu
> is offline anyway, and that the contents of the pointer is not valid.

Sure, we need a way of freeing a cpu's storage and of zapping that CPU's
slot.  Whether that's mask-based or just operates on a single CPU is
debatable.  Probably the latter, given the do-it-at-hotplug-time usage
model.


It could be argued that the whole idea is wrong - that we're putting
restrictions upon the implementation of alloc_percpu().  After all, an
implementation at present could do

alloc_percpu(size):
	size = roundup(size, L1_CACHE_SIZE);
	ret = kmalloc(size*NR_CPUS + sizeof(int));
	*(int *)ret = size;

per_cpu_ptr(ptr, cpu):
	(void *)((int *)ptr + (*((int *)ptr) * cpu))

or whatever.  The API additions which are being proposed here make that
impossible.  Or at least, more complex and slower.

Is it reasonable to assume that all implementations will, for all time,
include at least one layer of indirection?  After all, the above would be a
feasible implementation for non-NUMA SMP.  It's just as many derefs though.

hmm.  1k of memory isn't much.  How much memory will all this _really_ save?
