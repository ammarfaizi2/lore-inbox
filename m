Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVASAHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVASAHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVASAHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:07:18 -0500
Received: from ozlabs.org ([203.10.76.45]:27293 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261488AbVASAGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:06:45 -0500
Subject: Re: [patch 2/2] mm: Reimplementation of alloc_percpu
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Dipankar Sarma <dipankar@in.ibm.com>
In-Reply-To: <20050118151534.GA2126@impedimenta.in.ibm.com>
References: <20050117183014.GB2322@impedimenta.in.ibm.com>
	 <20050117183617.GC2322@impedimenta.in.ibm.com>
	 <1106011832.30801.5.camel@localhost.localdomain>
	 <20050118151534.GA2126@impedimenta.in.ibm.com>
Content-Type: text/plain
Date: Wed, 19 Jan 2005 10:30:05 +1100
Message-Id: <1106091005.21033.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 20:45 +0530, Ravikiran G Thirumalai wrote:
> On Tue, Jan 18, 2005 at 12:30:32PM +1100, Rusty Russell wrote:
> > On Tue, 2005-01-18 at 00:06 +0530, Ravikiran G Thirumalai wrote:
> > > ...
> > > The allocator can be easily modified to use __per_cpu_offset[] table at a later
> > > stage by: 
> > > 1. Allocating ALIGN(__per_cpu_end - __per_cpu_start, PAGE_SIZE) for the
> > >    static percpu areas and populating __per_cpu_offset[] offset table
> > > 2. Making PCPU_BLKSIZE same as the static per cpu area size above
> > > 3. Serving dynamic percpu requests from modules etc from blocks by
> > >    returning ret -= __per_cpu_offset[0] from a percpu block.  This way
> > >    modules need not have a limit on static percpu areas.
> > 
> > Unfortunately ia64 breaks (3).  They have pinned TLB entries covering
> > 64k, which they put the static per-cpu data into.  This is used for
> > local_inc, etc, and David Mosberger loved that trick (this is why my
> > version allocated from that first reserved block for modules' static
> > per-cpu vars).
> 
> Hmmm... then if we change (1) to allocate PERCPU_ENOUGH_ROOM, then the math
> will work out?  We will still have a limit on static per-cpu areas in
> modules, but alloc_percpu can use the same __per_cpu_offset table[].
> Will this work?

I think so.

> But, what I am concerned is about arches like x86_64 which currently
> do not maintain the relation:
> __per_cpu_offset[n] = __per_cpu_offset[0] + static_percpu_size * n  ---> (A)
> correct me if I am wrong, but both our methods for alloc_percpu to use
> per_cpu_offset depend on the static per-cpu areas being virtually
> contiguous (with relation (A) above being maintained).
> If arches cannot sew up node local pages to form a virtually contiguous
> block, maybe because setup_per_cpu_areas happens early during boot, 
> then we will have a problem.

They don't actually have to be contiguous, although that makes it
easier.  They can reserve virtual address space to extend their per-cpu
areas.  I think this is a worthwhile tradeoff if they want to do this.

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

