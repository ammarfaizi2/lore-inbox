Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWCKHYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWCKHYS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 02:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbWCKHYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 02:24:18 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:58521 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751728AbWCKHYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 02:24:17 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
Date: Sat, 11 Mar 2006 18:24:05 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
References: <200603102054.20077.kernel@kolivas.org> <200603111650.23727.kernel@kolivas.org> <1142056851.7819.54.camel@homer>
In-Reply-To: <1142056851.7819.54.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603111824.06274.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 17:00, Mike Galbraith wrote:
> On Sat, 2006-03-11 at 16:50 +1100, Con Kolivas wrote:
> > On Saturday 11 March 2006 16:33, Mike Galbraith wrote:
> > > On Sat, 2006-03-11 at 14:50 +1100, Con Kolivas wrote:
> > > > On Saturday 11 March 2006 09:35, Andrew Morton wrote:
> > > > > Con Kolivas <kernel@kolivas.org> wrote:
> > > > > > +	/*
> > > > > > +	 * get_page_state is super expensive so we only perform it
> > > > > > every +	 * SWAP_CLUSTER_MAX prefetched_pages.
> > > > >
> > > > > nr_running() is similarly expensive btw.
> > > >
> > > > Yes which is why I do it just as infrequently as get_page_state.
> > > >
> > > > > > 	 * We also test if we're the only
> > > > > > +	 * task running anywhere. We want to have as little impact on
> > > > > > all +	 * resources (cpu, disk, bus etc). As this iterates over
> > > > > > every cpu +	 * we measure this infrequently.
> > > > > > +	 */
> > > > > > +	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
> > > > > > +		unsigned long cpuload = nr_running();
> > > > > > +
> > > > > > +		if (cpuload > 1)
> > > > > > +			goto out;
> > > > >
> > > > > Sorry, this is just wrong.  If swap prefetch is useful then it's
> > > > > also useful if some task happens to be sitting over in the corner
> > > > > calculating pi.
> > > > >
> > > > > What's the actual problem here?  Someone's 3d game went blippy? 
> > > > > Why? How much?  Are we missing a cond_resched()?
> > > >
> > > > No, it's pretty easy to reproduce, kprefetchd sits there in
> > > > uninterruptible sleep with one cpu on SMP pegged at 100% iowait due
> > > > to it. This tends to have noticeable effects everywhere on HT or SMP.
> > > > On UP the yielding helped it but even then it still causes blips. How
> > > > much? Well to be honest it's noticeable a shipload. Running a game,
> > > > any game, that uses 100% (and most fancy games do) causes stuttering
> > > > on audio, pauses and so on. This is evident on linux native games,
> > > > games under emulators or qemu and so on. That iowait really hurts,
> > > > and tweaking just priority doesn't help it in any way.
> > >
> > > That doesn't really make sense to me.  If a task can trigger audio
> > > dropout and stalls by sleeping, we have a serious problem.  In your
> > > SMP/HT case, I'd start crawling over the load balancing code.  I can't
> > > see how trivial CPU with non-saturated IO can cause dropout in the UP
> > > case either.  Am I missing something?
> >
> > Clearly you, me and everyone else is missing something. I see it with
> > each task bound to one cpu with cpu affinity so it's not a balancing
> > issue. Try it yourself if you can instead of not believing me. Get a big
> > dd reader (virtually no cpu and all io wait sleep) on one cpu and try and
> > play a game on the other cpu. It dies rectally.
>
> I said it didn't make sense to me, not that I didn't believe you.  If I
> had a real SMP box, I would look into it, but all I have is HT.

No doubt it would be better on an SMP box. The norm is, however, for all these 
multi-core, multi-threading cpus to be more common than real SMP and they all 
share varying amounts of their resources.

> If you're creating a lot of traffic, I can see it causing problems.  I
> was under the impression that you were doing minimal IO and absolutely
> trivial CPU.  That's what didn't make sense to me to be clear.

A lot of cpu would be easier to handle; it's using absolutely miniscule 
amounts of cpu. The IO is massive though (and seeky in nature), and reading 
from a swap partition seems particularly expensive in this regard.

Cheers,
Con
