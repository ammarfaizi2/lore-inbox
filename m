Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTLXChQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 21:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTLXChP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 21:37:15 -0500
Received: from dp.samba.org ([66.70.73.150]:4587 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263488AbTLXCgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 21:36:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ioe-lkml@rameria.de,
       Stephen Hemminger <shemminger@osdl.org>,
       Sylvain Jeaugey <sylvain.jeaugey@bull.net>, Ray Bryant <raybry@sgi.com>,
       Christoph Hellwig <hch@infradead.org>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] another minor bit of cpumask cleanup 
In-reply-to: Your message of "Tue, 23 Dec 2003 02:10:39 -0800."
             <20031223021039.5b99a04b.pj@sgi.com> 
Date: Wed, 24 Dec 2003 12:26:02 +1100
Message-Id: <20031224023632.5D5462C260@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031223021039.5b99a04b.pj@sgi.com> you write:
> I like your patch.  Since your more substantial patch negates my
> trivial patch to remove the old for_each_online_cpu(), I'll forget
> about my patch.

OK, thanks for reviewing!

> Speaking of trivial patches, didn't you (Rusty) used to be the Trivial
> Patch Monkey, and what has become of that esteemed role in 2.6 land?

Yes, but while things were frozen I only checked that mailbox once a
week or less, since things slowed to a crawl.  Also, there are only so
many genuinely trivial patches which aren't stupid 8)

> I do have a more substantial patch that is yet widely published to
> provide an alternative underlying implementation of the cpumask macros
> with something that can be used for both cpu and node masks, that takes
> one file to express instead of 5 or 6, and that has one base type
> (struct of array of unsigned longs) rather than a choice of three or so
> implementations.

Hmm, sounds interesting.

> For at least one architecture, sparc64 (IIRC), wli informs me that davem
> is quite certain this alternative can't be used (resulting machine code
> way too painful).  But I am hopeful that we can make it cleaner source
> code and just as good machine code, at least for the architectures that
> can use recent gcc optimizing.

I think we'll only be able to tell with the patch in front of us.
Maybe Dave will be convinced: he's dogmatic, but rarely unreasonable.

> > possible cpu ...  online cpus
> 
> I'm not quite sure of the meaning to you of these terms.
> Is it that possible cpus are the union of online and offline cpus?

Yes.  cpu_online(x) <= cpu_possible(x).  For adding counters and the
like, cpu_possible() is the test you want (most common usage).  If
you're using cpu_online(x), you need to either hold the cpucontrol
lock, or register a callback for it changing, or both.

> > noone uses them that way (except for arch/i386/mach-voyager, which
> > D: uses for_each_cpu(cpu_online_mask)
> 
> What about the one remaining usage of for_each_cpu(), also in
> voyager, but not using cpu_online_mask:
> 
> arch/i386/mach-voyager/voyager_smp.c:
> 
> 	=============================================================
> 	#ifdef VOYAGER_DEBUG
>                 ...
>                 if((isr & (1<<irq) && !(status & IRQ_REPLAY)) == 0) {
>                         ...
>                         int mask;
> 
>                         printk("VOYAGER SMP: CPU%d lost interrupt %d\n",
>                                cpu, irq);
>                         for_each_cpu(real_cpu, mask) {
> 	=============================================================
> 
> You noted that 'mask' needed initializing in a comment in your patch,
> but I don't see that you change the calling signature of for_each_cpu(),
> not that it is clear to what it should be changed ;(.

I figured the code is broken as is: I've left it broken (with the
benefit that it no longer even compiles).  Someday someone will enable
VOYAGER_DEBUG and they'll fix it.

> > so the iterators are moved
> > D: from linux/cpumask.h to linux/smp.h, where that is asm/smp.h is included.
> 
> This comment says the iterators are moved to smp.h, but the patch seems
> to still show them in cpumask.h.  I suspect that I prefer them in smp.h
> better.

Good catch: that comment is wrong.  Moving broke too much stuff IIRC.
Someone can do a separate patch if they want.

> > D: Followup patches will convert users.
> 
> Looks to me like this here patch is converting some users, such as
> in fork.c and sched.c.  Is this the conversion you speak of, or is
> there more to come in a followup?

I did the users which are actually wrong, but didn't do the ones which
are simply inefficient (ie. for (i = 0; i < NR_CPUS; i++)).  The
freeze came down, and I decided to go for minimal impact.

In 2.7, my aim is to switch the rest of them, move more things to
per-cpu rather than [NR_CPUS] arrays, add the more efficient dynamic
per-cpu allocation, and spread the per-cpu religion by fire and the
sword.

But I've said too much already...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
