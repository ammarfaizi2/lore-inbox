Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWCKGKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWCKGKk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 01:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWCKGKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 01:10:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:29340 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750865AbWCKGKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 01:10:39 -0500
X-Authenticated: #14349625
Subject: Re: [PATCH] mm: Implement swap prefetching tweaks
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
In-Reply-To: <200603111658.10520.kernel@kolivas.org>
References: <200603102054.20077.kernel@kolivas.org>
	 <1142055239.7819.47.camel@homer> <200603111650.23727.kernel@kolivas.org>
	 <200603111658.10520.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 07:11:35 +0100
Message-Id: <1142057495.7819.62.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 16:58 +1100, Con Kolivas wrote:
> On Saturday 11 March 2006 16:50, Con Kolivas wrote:
> > On Saturday 11 March 2006 16:33, Mike Galbraith wrote:
> > > On Sat, 2006-03-11 at 14:50 +1100, Con Kolivas wrote:
> > > > On Saturday 11 March 2006 09:35, Andrew Morton wrote:
> > > > > Con Kolivas <kernel@kolivas.org> wrote:
> > > > > > +	/*
> > > > > > +	 * get_page_state is super expensive so we only perform it every
> > > > > > +	 * SWAP_CLUSTER_MAX prefetched_pages.
> > > > >
> > > > > nr_running() is similarly expensive btw.
> > > >
> > > > Yes which is why I do it just as infrequently as get_page_state.
> > > >
> > > > > > 	 * We also test if we're the only
> > > > > > +	 * task running anywhere. We want to have as little impact on all
> > > > > > +	 * resources (cpu, disk, bus etc). As this iterates over every
> > > > > > cpu +	 * we measure this infrequently.
> > > > > > +	 */
> > > > > > +	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
> > > > > > +		unsigned long cpuload = nr_running();
> > > > > > +
> > > > > > +		if (cpuload > 1)
> > > > > > +			goto out;
> > > > >
> > > > > Sorry, this is just wrong.  If swap prefetch is useful then it's also
> > > > > useful if some task happens to be sitting over in the corner
> > > > > calculating pi.
> > > > >
> > > > > What's the actual problem here?  Someone's 3d game went blippy?  Why?
> > > > > How much?  Are we missing a cond_resched()?
> > > >
> > > > No, it's pretty easy to reproduce, kprefetchd sits there in
> > > > uninterruptible sleep with one cpu on SMP pegged at 100% iowait due to
> > > > it. This tends to have noticeable effects everywhere on HT or SMP. On
> > > > UP the yielding helped it but even then it still causes blips. How
> > > > much? Well to be honest it's noticeable a shipload. Running a game, any
> > > > game, that uses 100% (and most fancy games do) causes stuttering on
> > > > audio, pauses and so on. This is evident on linux native games, games
> > > > under emulators or qemu and so on. That iowait really hurts, and
> > > > tweaking just priority doesn't help it in any way.
> > >
> > > That doesn't really make sense to me.  If a task can trigger audio
> > > dropout and stalls by sleeping, we have a serious problem.  In your
> > > SMP/HT case, I'd start crawling over the load balancing code.  I can't
> > > see how trivial CPU with non-saturated IO can cause dropout in the UP
> > > case either.  Am I missing something?
> >
> > Clearly you, me and everyone else is missing something. I see it with each
> > task bound to one cpu with cpu affinity so it's not a balancing issue. Try
> > it yourself if you can instead of not believing me. Get a big dd reader
> > (virtually no cpu and all io wait sleep) on one cpu and try and play a game
> > on the other cpu. It dies rectally.
> 
> I happen to have a tool to instrument this as you're probably aware 
> (interbench). Here is an old log I found of this.:

Yeah, I have a copy.  Interpreting the results isn't necessarily easy
though, just as any other benchmark.

> 
> --- Benchmarking simulated cpu of Gaming in the presence of simulated ---
> Load	Latency +/- SD (ms)  Max Latency   % Desired CPU
> None	      0 +/- 0              0		 100
> Write	   36.5 +/- 103          966		73.3
> Read	   17.2 +/- 22.9         244		85.3
> 
> Note the max latency being massive and desired cpu dropping. This is on a HT 
> machine.

I wonder what that would look like with two real CPUs.

	-Mike

