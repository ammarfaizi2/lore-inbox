Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262783AbTEGCSx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbTEGCSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:18:53 -0400
Received: from dp.samba.org ([66.70.73.150]:21480 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262783AbTEGCSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:18:52 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       paulus@samba.org
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "Tue, 06 May 2003 01:47:45 MST."
             <20030506014745.02508f0d.akpm@digeo.com> 
Date: Wed, 07 May 2003 11:57:13 +1000
Message-Id: <20030507023126.12F702C019@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030506014745.02508f0d.akpm@digeo.com> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > It's a tradeoff, but I think it's worth it for a kmalloc_percpu which
> > is fast, space-efficient and numa-aware, since the code is needed
> > anyway.
> 
> I don't beleive that kmalloc_percpu() itself needs to be fast, as you say.
> 
> The code is _not_ NUMA-aware.  Is it?

No, it's arch-overridable.  You know me, I don't mess with
arch-specific stuff. 8)

> On 64GB 32-way that's 128MB of lowmem.  Unpopular.  I'd settle for a __setup
> thingy here, and a printk when the memory runs out.

Currently __setup is run far too late.  Fortunately Bartlomiej has
been working on moving __setup earlier, for other reasons (two-stage
parameter parsing).  In this case, it'd need to be before arch setup,
hmm...

> btw, what's wrong with leaving kmalloc_percpu() as-is, and only using this
> allocator for DEFINE_PERCPU()?

I figured that since the allocator is going to be there anyway, it
made sense to express kmalloc_percpu() in those terms.  If you think
the price is too high, I can respect that.

The more people use the __per_cpu_offset instead of
smp_processor_id(), the cheaper it gets, even to the stage where some
archs might want to express smp_processor_id() in terms of
__per_cpu_offset, rather than vice-versa.  Given that it's also more
space efficient (each var doesn't take one cacheline) too, I'd
recommend __alloc_percpu() of eg. single ints for long-lived objects
where I wouldn't recommend the current kmalloc_percpu().

Paul Mackerras points out that we could get the numa-aware allocation
plus "one big alloc" properties by playing with page mappings: reserve
1MB of virtual address, and map more pages as required.  I didn't
think that we'd need that yet, though.

So, numerous options, and you're smarter than me, so you can decide 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
