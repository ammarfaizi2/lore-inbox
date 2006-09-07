Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWIGC2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWIGC2G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 22:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWIGC2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 22:28:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422659AbWIGC2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 22:28:02 -0400
Date: Wed, 6 Sep 2006 19:21:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/18] 2.6.17.9 perfmon2 patch for review: event sets and
 multiplexing support
Message-Id: <20060906192135.83fc4231.akpm@osdl.org>
In-Reply-To: <20060906145031.GE13962@frankl.hpl.hp.com>
References: <200608230805.k7N85x2H000432@frankl.hpl.hp.com>
	<20060823155148.a2945c4e.akpm@osdl.org>
	<20060906145031.GE13962@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006 07:50:31 -0700
Stephane Eranian <eranian@hpl.hp.com> wrote:

> > > +
> > > +	cachep = ctx->flags.mapset ? pfm_set_cachep : pfm_lg_set_cachep;
> > > +
> > > +	new_set = kmem_cache_alloc(cachep, SLAB_ATOMIC);
> > 
> > SLAB_ATOMIC is unreliable.  Is it possible to use SLAB_KERNEL here?  If
> > coms ecallers can sleep and others cannot then passing in the gfp_flags
> > would permit improvement here.
> > 
> 
> I made some changes and now I know I execute this part of the function
> with interrupts disabled, holding only the perfmon context lock. I assume
> SLAB_KERNEL means, we can sleep. I think I can make this change safely.
> 
> 
> > 
> > > +		if (ctx->flags.mapset) {
> > > +			view_size = PAGE_ALIGN(sizeof(struct pfm_set_view));
> > > +			view      = vmalloc(view_size);
> > 
> > vmalloc() sleeps, so this _could_ have used SLAB_ATOMIC.
> > 
> 
> I am not sure I follow you here. Are you talking about eh kmem_cache_alloc()
> above?
> 

My logic was as follows:

a) vmalloc() can sleep

b) Stephane at some time tested this conde with
   CONFIG_DEBUG_SPINLOCK_SLEEP and didn't get sleep-while-atomic warnings out of
   that vmalloc().

c) Hence this code is never called under spinlock, or with local
   interrupts disabled.

d) Hence it is safe to convert the earlier SLAB_ATOMIC into SLAB_KERNEL.


If b) is false then it's the vmalloc() call which is incorrect, not the
SLAB_ATOMIC.

