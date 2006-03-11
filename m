Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWCKDur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWCKDur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 22:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWCKDur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 22:50:47 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:9694 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932396AbWCKDur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 22:50:47 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
Date: Sat, 11 Mar 2006 14:50:38 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200603102054.20077.kernel@kolivas.org> <20060310143545.74a9a92a.akpm@osdl.org>
In-Reply-To: <20060310143545.74a9a92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603111450.39305.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 09:35, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > +	/*
> > +	 * get_page_state is super expensive so we only perform it every
> > +	 * SWAP_CLUSTER_MAX prefetched_pages.
>
> nr_running() is similarly expensive btw.

Yes which is why I do it just as infrequently as get_page_state.
>
> > 	 * We also test if we're the only
> > +	 * task running anywhere. We want to have as little impact on all
> > +	 * resources (cpu, disk, bus etc). As this iterates over every cpu
> > +	 * we measure this infrequently.
> > +	 */
> > +	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
> > +		unsigned long cpuload = nr_running();
> > +
> > +		if (cpuload > 1)
> > +			goto out;
>
> Sorry, this is just wrong.  If swap prefetch is useful then it's also
> useful if some task happens to be sitting over in the corner calculating
> pi.
>
> What's the actual problem here?  Someone's 3d game went blippy?  Why?  How
> much?  Are we missing a cond_resched()?

No, it's pretty easy to reproduce, kprefetchd sits there in uninterruptible 
sleep with one cpu on SMP pegged at 100% iowait due to it. This tends to have 
noticeable effects everywhere on HT or SMP. On UP the yielding helped it but 
even then it still causes blips. How much? Well to be honest it's noticeable 
a shipload. Running a game, any game, that uses 100% (and most fancy games 
do) causes stuttering on audio, pauses and so on. This is evident on linux 
native games, games under emulators or qemu and so on. That iowait really 
hurts, and tweaking just priority doesn't help it in any way.

With this change it's much more polite and takes a bit longer to complete 
prefetching but is still effective while no longer being noticeable.

> > +		cpuload += nr_uninterruptible();
> > +		if (cpuload > 1)
> > +			goto out;
>
> Not sure about this either.

Same as above. It's the tasks in uninterruptible sleep that cause the most 
harm. I do it sequentially simply because nr_running() is more likely to be 
>1 than the sum total, and I'd prefer not to do nr_uninterruptible() unless 
it's necessary. Both of these are actually done lockless though.

> > +		if (ns->last_free) {
> > +			if (ns->current_free + SWAP_CLUSTER_MAX <
> > +				ns->last_free) {
> > +					ns->last_free = ns->current_free;
> >  					node_clear(node,
> >  						sp_stat.prefetch_nodes);
> >  					continue;
> >  			}
> >  		} else
>
> That has an extra tabstop.

Hrm. 3 years on and I still make basi style mistakes.

Cheers,
Con
