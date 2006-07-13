Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWGMVbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWGMVbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWGMVbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:31:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28621 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030408AbWGMVbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:31:24 -0400
Date: Thu, 13 Jul 2006 14:30:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mingo@elte.hu, sekharan@us.ibm.com, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, arjan@infradead.org
Subject: Re: [patch] lockdep: annotate mm/slab.c
Message-Id: <20060713143058.383b00a5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607131147530.5623@g5.osdl.org>
References: <1152763195.11343.16.camel@linuxchandra>
	<20060713071221.GA31349@elte.hu>
	<20060713002803.cd206d91.akpm@osdl.org>
	<20060713072635.GA907@elte.hu>
	<20060713004445.cf7d1d96.akpm@osdl.org>
	<20060713124603.GB18936@elte.hu>
	<Pine.LNX.4.64.0607131147530.5623@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 11:50:01 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Thu, 13 Jul 2006, Ingo Molnar wrote:
> >  
> > +#ifdef CONFIG_LOCKDEP
> > +
> > +/*
> > + * Slab sometimes uses the kmalloc slabs to store the slab headers
> > + * for other slabs "off slab".
> > + * The locking for this is tricky in that it nests within the locks
> > + * of all other slabs in a few places; to deal with this special
> > + * locking we put on-slab caches into a separate lock-class.
> > + */
> > +static struct lock_class_key on_slab_key;
> > +
> > +static inline void init_lock_keys(struct cache_sizes *s)
> > +{
> > +	int q;
> > +
> > +	for (q = 0; q < MAX_NUMNODES; q++) {
> > +		if (!s->cs_cachep->nodelists[q] || OFF_SLAB(s->cs_cachep))
> > +			continue;
> > +		lockdep_set_class(&s->cs_cachep->nodelists[q]->list_lock,
> > +				  &on_slab_key);
> > +	}
> > +}
> > +
> > +#else
> > +static inline void init_lock_keys(struct cache_sizes *s)
> > +{
> > +}
> > +#endif
> 
> Why isn't the "on_slab_key" local to just the init_lock_keys() function, 
> and the #ifdef around it all?
> 
> Ie just
> 
> 	static inline void init_lock_keys(struct cache_sizes *s)
> 	{
> 	#ifdef CONFIG_LOCKDEP
> 		static struct lock_class_key on_slab_key;
> 		int q;
> 
> 		for (q = 0; q < MAX_NUMNODES; q++) {
> 			...
> 	#endif CONFIG_LOCKDEP
> 	}
> 
> instead?
> 

It could be wholly hidded inside a macro

#define lockdep_go_away(p) {
		static struct lock_class_key foo;
		lockdep_set_class(p, &foo);
	}

But istr suggesting that a couple of weeks ago and was given a
good-sounding reason which I forget.

At least when the code laid out as Ingo proposed, we have room for a
decent comment, which is rather desirable for this sort of thing.
