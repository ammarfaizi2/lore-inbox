Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750706AbWFEHtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWFEHtj (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWFEHtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:49:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:42453 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750706AbWFEHti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:49:38 -0400
Subject: Re: [RFC][PATCH] request_irq(...,SA_BOOTMEM);
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
        torvalds@osdl.org
In-Reply-To: <20060605003127.fc1ea37a.akpm@osdl.org>
References: <1149486009.8543.42.camel@localhost.localdomain>
	 <1149491309.8543.54.camel@localhost.localdomain>
	 <20060605003127.fc1ea37a.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 17:48:10 +1000
Message-Id: <1149493691.8543.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't immediately see anything in there which would prevent us from
> running these:
> 
> 	vfs_caches_init_early();
> 	cpuset_init_early();
> 	mem_init();
> 	kmem_cache_init();
> 	setup_per_cpu_pageset();
> 
> just after sort_main_extable().
> 
> But things will explode ;)
> 
> I suggest you run up a patch, test it on whatever machines you have, send
> it over and I'll do the same.  But please make sure it has a config option
> to restore the old sequence for now.  a) So people can work out that it was
> this patch which broke things and b) so it doesn't adversely affect testing
> of other things too much.

Good ideas. I'll give these things a spin. One thing that may explode is
that all that code is running with local_irq_disable() (since local irqs
aren't enabled before init_IRQ()) and that means possible use of some
types of semaphores may trigger warn-on's (or worse as I think some
implementations of down_read() might even force-enable irqs).

But there is no fundamental reasons to do so ... that's the trick :) If
that happens, those semaphores are still ok as they should never get
into contention that early.

Anyway, I'll give it a spin on ppc and maybe x86 if I can find a victim
to test on here, and will send something.

Cheers,
Ben.


