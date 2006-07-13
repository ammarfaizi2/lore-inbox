Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWGMHcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWGMHcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 03:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWGMHcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 03:32:11 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47499 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751370AbWGMHcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 03:32:10 -0400
Date: Thu, 13 Jul 2006 09:26:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: sekharan@us.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, arjan@infradead.org
Subject: Re: Random panics seen in 2.6.18-rc1
Message-ID: <20060713072635.GA907@elte.hu>
References: <1152763195.11343.16.camel@linuxchandra> <20060713071221.GA31349@elte.hu> <20060713002803.cd206d91.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713002803.cd206d91.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Thu, 13 Jul 2006 09:12:21 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > Chandra Seetharaman reported SLAB crashes caused by the slab.c
> > lock annotation patch. There is only one chunk of that patch
> > that has a material effect on the slab logic - this patch
> > undoes that chunk.
> > 
> 
> yup.
> 
> > ---
> >  mm/slab.c |    9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > Index: linux/mm/slab.c
> > ===================================================================
> > --- linux.orig/mm/slab.c
> > +++ linux/mm/slab.c
> > @@ -3100,16 +3100,7 @@ static void free_block(struct kmem_cache
> >  		if (slabp->inuse == 0) {
> >  			if (l3->free_objects > l3->free_limit) {
> >  				l3->free_objects -= cachep->num;
> > -				/*
> > -				 * It is safe to drop the lock. The slab is
> > -				 * no longer linked to the cache. cachep
> > -				 * cannot disappear - we are using it and
> > -				 * all destruction of caches must be
> > -				 * serialized properly by the user.
> > -				 */
> > -				spin_unlock(&l3->list_lock);
> >  				slab_destroy(cachep, slabp);
> > -				spin_lock(&l3->list_lock);
> 
> But what was that change _for_?  Presumably, to plug some lockdep 
> problem. Which now will come back.

correct - but i first wanted to get the fix out, before trying to fix 
the lockdep thing.

> And the additional arg to __cache_free() was rather a step backwards - 
> this is fastpath.  With a bit more effort that could have been avoided 
> (please).

yeah, i'll fix this. Any suggestions of how to avoid the parameter 
passing? (without ugly #ifdeffery)

	Ingo
