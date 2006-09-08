Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWIHG0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWIHG0k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 02:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWIHG0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 02:26:40 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:58106 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751121AbWIHG0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 02:26:38 -0400
Date: Thu, 7 Sep 2006 23:26:28 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/18] 2.6.17.9 perfmon2 patch for review: event sets and multiplexing support
Message-ID: <20060908062628.GB17249@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230805.k7N85x2H000432@frankl.hpl.hp.com> <20060823155148.a2945c4e.akpm@osdl.org> <20060906145031.GE13962@frankl.hpl.hp.com> <20060906192135.83fc4231.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906192135.83fc4231.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Sep 06, 2006 at 07:21:35PM -0700, Andrew Morton wrote:
> On Wed, 6 Sep 2006 07:50:31 -0700
> Stephane Eranian <eranian@hpl.hp.com> wrote:
> 
> > > > +
> > > > +	cachep = ctx->flags.mapset ? pfm_set_cachep : pfm_lg_set_cachep;
> > > > +
> > > > +	new_set = kmem_cache_alloc(cachep, SLAB_ATOMIC);
> > > 
> > > SLAB_ATOMIC is unreliable.  Is it possible to use SLAB_KERNEL here?  If
> > > coms ecallers can sleep and others cannot then passing in the gfp_flags
> > > would permit improvement here.
> > > 
> > 
> > I made some changes and now I know I execute this part of the function
> > with interrupts disabled, holding only the perfmon context lock. I assume
> > SLAB_KERNEL means, we can sleep. I think I can make this change safely.
> > 
> > 
> > > 
> > > > +		if (ctx->flags.mapset) {
> > > > +			view_size = PAGE_ALIGN(sizeof(struct pfm_set_view));
> > > > +			view      = vmalloc(view_size);
> > > 
> > > vmalloc() sleeps, so this _could_ have used SLAB_ATOMIC.
> > > 
> > 
> > I am not sure I follow you here. Are you talking about eh kmem_cache_alloc()
> > above?
> > 
> 
> My logic was as follows:
> 
> a) vmalloc() can sleep
> 
> b) Stephane at some time tested this conde with
>    CONFIG_DEBUG_SPINLOCK_SLEEP and didn't get sleep-while-atomic warnings out of
>    that vmalloc().
> 
> c) Hence this code is never called under spinlock, or with local
>    interrupts disabled.
> 
> d) Hence it is safe to convert the earlier SLAB_ATOMIC into SLAB_KERNEL.
> 
> 
> If b) is false then it's the vmalloc() call which is incorrect, not the
> SLAB_ATOMIC.

Looking at the code again, I now think that vmalloc is wrong. I have made
some changes to lift the restrictions on interrupts being masked, but I still
need to hold a spinlock. So I think, I need to replace vmalloc with kmalloc
and SLAB_ATOMIC. Furthermore, I think I need to surround this with a pair
of preempt_disable/preempt_enable (given the interrupts are unmasked).

Thanks.

-- 

-Stephane
