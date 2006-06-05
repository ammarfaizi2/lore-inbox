Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750731AbWFEIYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWFEIYR (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWFEIYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:24:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750731AbWFEIYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:24:16 -0400
Date: Mon, 5 Jun 2006 01:24:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
        torvalds@osdl.org
Subject: Re: [RFC][PATCH] request_irq(...,SA_BOOTMEM);
Message-Id: <20060605012405.ac17f918.akpm@osdl.org>
In-Reply-To: <1149493691.8543.57.camel@localhost.localdomain>
References: <1149486009.8543.42.camel@localhost.localdomain>
	<1149491309.8543.54.camel@localhost.localdomain>
	<20060605003127.fc1ea37a.akpm@osdl.org>
	<1149493691.8543.57.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 17:48:10 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > I don't immediately see anything in there which would prevent us from
> > running these:
> > 
> > 	vfs_caches_init_early();
> > 	cpuset_init_early();
> > 	mem_init();
> > 	kmem_cache_init();
> > 	setup_per_cpu_pageset();
> > 
> > just after sort_main_extable().
> > 
> > But things will explode ;)
> > 
> > I suggest you run up a patch, test it on whatever machines you have, send
> > it over and I'll do the same.  But please make sure it has a config option
> > to restore the old sequence for now.  a) So people can work out that it was
> > this patch which broke things and b) so it doesn't adversely affect testing
> > of other things too much.
> 
> Good ideas. I'll give these things a spin. One thing that may explode is
> that all that code is running with local_irq_disable() (since local irqs
> aren't enabled before init_IRQ()) and that means possible use of some
> types of semaphores may trigger warn-on's (or worse as I think some
> implementations of down_read() might even force-enable irqs).

Yes, there are a few sleeping locks taken in
kmem_cache_init()->kmem_cache_init(), for example.

They would normally generate might_sleep() warnings, but __might_sleep()
suppresses that early in boot, for this very reason.

It's all a bit sleazy, "knowing" that these locks won't be contended, so
it's safe to do apparently-unsafe things.  We haven't even started the
other CPUs yet.

For something like kmem_cache_init() we could, I suppose, pass in a
dont-take-any-locks flag.  But for a fastpath thing (if there are any such
cases) that wouldn't be an option.

All very unpleasant.

And yes, the mutex code will (with debug enabled) unconditionally enable
interrupts.  ppc64 tends to oops when this happens, in the timer handler
(so it'll be intermittent...)

But looking at
work-around-ppc64-bootup-bug-by-making-mutex-debugging-save-restore-irqs.patch
I realise I don't understand it.  We only go into the irq-enabling code in
the case of contention, and there cannot be contention in this case?

