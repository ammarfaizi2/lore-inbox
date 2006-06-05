Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750705AbWFEHbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWFEHbf (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWFEHbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:31:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750705AbWFEHbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:31:35 -0400
Date: Mon, 5 Jun 2006 00:31:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
        torvalds@osdl.org
Subject: Re: [RFC][PATCH] request_irq(...,SA_BOOTMEM);
Message-Id: <20060605003127.fc1ea37a.akpm@osdl.org>
In-Reply-To: <1149491309.8543.54.camel@localhost.localdomain>
References: <1149486009.8543.42.camel@localhost.localdomain>
	<1149491309.8543.54.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 17:08:29 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2006-06-05 at 15:40 +1000, Benjamin Herrenschmidt wrote:
> > In various places, architectures need to request interrupts early during
> > boot. Before slab is initialized typically. We used to have all sorts of
> > arch hacks to do so, which ended up being turned into something like:
> 
>  ..../.... (skip workaround based on bootmem)
> 
> Hrm... I'm running into more problems with some of my powerpc irq
> cleanups related to slab not being initialized.
> 
> Why do we do it so late ? I don't see any reason. A bunch of stuff like
> init_IRQ(), time_init() etc...end up being called without a working slab
> (not even GFP_ATOMIC). Damn, even console_init().
> 
> What are the fundamental reasons, if any, why we initialize the slab so
> late ?

I suspect because it's been like that since for ever, and any time we touch
anything in there, bad things happen.

> ...
>
> I'm sure there is a subtle sneaky dependency, I would suspect something
> to do with the scheduler and/or the cpumask/numa infos, whatever, but I
> think we should really consider solving that.

I don't immediately see anything in there which would prevent us from
running these:

	vfs_caches_init_early();
	cpuset_init_early();
	mem_init();
	kmem_cache_init();
	setup_per_cpu_pageset();

just after sort_main_extable().

But things will explode ;)

I suggest you run up a patch, test it on whatever machines you have, send
it over and I'll do the same.  But please make sure it has a config option
to restore the old sequence for now.  a) So people can work out that it was
this patch which broke things and b) so it doesn't adversely affect testing
of other things too much.

