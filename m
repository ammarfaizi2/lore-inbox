Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTLWKK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 05:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLWKK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 05:10:59 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:46502 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265080AbTLWKKz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 05:10:55 -0500
Date: Tue, 23 Dec 2003 02:10:39 -0800
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ioe-lkml@rameria.de,
       Stephen Hemminger <shemminger@osdl.org>,
       Sylvain Jeaugey <sylvain.jeaugey@bull.net>, Ray Bryant <raybry@sgi.com>,
       Christoph Hellwig <hch@infradead.org>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] another minor bit of cpumask cleanup
Message-Id: <20031223021039.5b99a04b.pj@sgi.com>
In-Reply-To: <20031223124504.29dc5ed1.rusty@rustcorp.com.au>
References: <20031221180044.0f27eca1.pj@sgi.com>
	<20031221224745.268db46d.akpm@osdl.org>
	<20031221231918.34fcca86.pj@sgi.com>
	<20031223124504.29dc5ed1.rusty@rustcorp.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty writes:
> I have a patch which changes these iterators [for_each_cpu] anyway,

Cool.


> I'd rather have 12 crossing patches than silence

yup


> For the hotplug CPU stuff,

Makes sense to me that the hotplug CPU work would be in the drivers seat
on these cpu looping macros.  I like your patch.  Since your more
substantial patch negates my trivial patch to remove the old
for_each_online_cpu(), I'll forget about my patch.

Andrew:

    You lucked out in dropping my patch to remove for_each_online_cpu(). 
    Good.


Speaking of trivial patches, didn't you (Rusty) used to be the Trivial
Patch Monkey, and what has become of that esteemed role in 2.6 land?

I do have a more substantial patch that is yet widely published to
provide an alternative underlying implementation of the cpumask macros
with something that can be used for both cpu and node masks, that takes
one file to express instead of 5 or 6, and that has one base type
(struct of array of unsigned longs) rather than a choice of three or so
implementations.

For at least one architecture, sparc64 (IIRC), wli informs me that davem
is quite certain this alternative can't be used (resulting machine code
way too painful).  But I am hopeful that we can make it cleaner source
code and just as good machine code, at least for the architectures that
can use recent gcc optimizing.

The basic goal of this patch-to-be will be to provide a solid 'mask'
type that can be used within the kernel for various bit masks of known
(compiled in) lengths of one to quite a few words.  This work stems from
a suggestion by Christoph Hellwig that I implement numamask_t using an
ADT shared with cpumask_t.  I originally told Christoph I would have
that ADT patch up and published in a week.  That was two months ago ;)

Unfortunately, I've just started on vacation for the next month or so,
so won't likely get much further publishing this right now.  If someone
has possibly conflicting work, or would like to join in, or otherwise
raise issues, please speak up.

I have the patch in a healthy state and being used on work that I am
doing to support the 'cpuset' feature being developed by Simon and
Sylvain of Bull (France).

There are some performance tests that Ray Bryant has graciously
volunteered to attempt, which will be critical to my final
recommendation of this alternative for at least the ia64 arch, which
tests will not happen until Feb, when I can set Ray up to make the
comparisons of this new implementation with the current one.  We need to
know whether for the > 256 bit case, seemingly replacing a call by
reference (pointer to mask) with a call by value will actually matter to
performance of the code we care about.

> possible cpu ...  online cpus

I'm not quite sure of the meaning to you of these terms.
Is it that possible cpus are the union of online and offline cpus?


> noone uses them that way (except for arch/i386/mach-voyager, which
> D: uses for_each_cpu(cpu_online_mask)

What about the one remaining usage of for_each_cpu(), also in
voyager, but not using cpu_online_mask:

arch/i386/mach-voyager/voyager_smp.c:

	=============================================================
	#ifdef VOYAGER_DEBUG
                ...
                if((isr & (1<<irq) && !(status & IRQ_REPLAY)) == 0) {
                        ...
                        int mask;

                        printk("VOYAGER SMP: CPU%d lost interrupt %d\n",
                               cpu, irq);
                        for_each_cpu(real_cpu, mask) {
	=============================================================

You noted that 'mask' needed initializing in a comment in your patch,
but I don't see that you change the calling signature of for_each_cpu(),
not that it is clear to what it should be changed ;(.


> so the iterators are moved
> D: from linux/cpumask.h to linux/smp.h, where that is asm/smp.h is included.

This comment says the iterators are moved to smp.h, but the patch seems
to still show them in cpumask.h.  I suspect that I prefer them in smp.h
better.


> D: Followup patches will convert users.

Looks to me like this here patch is converting some users, such as
in fork.c and sched.c.  Is this the conversion you speak of, or is
there more to come in a followup?

Good work, Rusty.  Thanks.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
