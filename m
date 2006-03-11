Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWCKFVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWCKFVe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 00:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWCKFVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 00:21:34 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:23255 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750708AbWCKFVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 00:21:33 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: [ck] Re: [PATCH] mm: Implement swap prefetching tweaks
Date: Sat, 11 Mar 2006 16:21:13 +1100
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, Peter Williams <pwil3058@bigpond.net.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200603102054.20077.kernel@kolivas.org> <200603111518.46474.kernel@kolivas.org> <200603110605.03046.astralstorm@gorzow.mm.pl>
In-Reply-To: <200603110605.03046.astralstorm@gorzow.mm.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603111621.13577.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 16:04, Radoslaw Szkodzinski wrote:
> On Saturday 11 March 2006 05:18, Con Kolivas wrote yet:
> > On Saturday 11 March 2006 10:11, Peter Williams wrote:
> > > Andrew Morton wrote:
> > > > Con Kolivas <kernel@kolivas.org> wrote:
> > > >>	 * We also test if we're the only
> > > >>+	 * task running anywhere. We want to have as little impact on all
> > > >>+	 * resources (cpu, disk, bus etc). As this iterates over every cpu
> > > >>+	 * we measure this infrequently.
> > > >>+	 */
> > > >>+	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX)) {
> > > >>+		unsigned long cpuload = nr_running();
> > > >>+
> > > >>+		if (cpuload > 1)
> > > >>+			goto out;
> > > >
> > > > Sorry, this is just wrong.  If swap prefetch is useful then it's also
> > > > useful if some task happens to be sitting over in the corner
> > > > calculating pi.
> > >
> > > On SMP systems, something based on the run queues' raw_weighted_load
> > > fields (comes with smpnice patch) might be more useful than
> > > nr_running() as it contains information about the priority of the
> > > running tasks. Perhaps (raw_weighted_load() > SCHED_LOAD_SCALE) or some
> > > variation, where raw_weighted_load() is the sum of that field for all
> > > CPUs) would suffice.  It would mean "there's more than the equivalent
> > > of one nice==0 task running" and shouldn't be any more expensive than
> > > nr_running(). Dividing SCHED_LOAD_SCALE by some number would be an
> > > obvious variation to try as would taking into account this process's
> > > contribution to the weighted load.
> > >
> > > Also if this was useful there's no real reason that raw_weighted_load
> > > couldn't be made available on non SMP systems as well as SMP ones.
> >
> > That does seem reasonable, but I'm looking at total system load, not per
> > runqueue. So a global_weighted_load() function would be required to
> > return that. Because despite what anyone seems to want to believe,
> > reading from disk hurts. Why it hurts so much I'm not really sure, but
> > it's not a SCSI vs IDE with or without DMA issue. It's not about tweaking
> > parameters. It doesn't seem to be only about cpu cycles. This is not a
> > mistuned system that it happens on. It just plain hurts if we do lots of
> > disk i/o, perhaps it's saturating the bus or something. Whatever it is,
> > as much as I'd _like_ swap prefetch to just keep working quietly at ultra
> > ultra low priority, the disk reads that swap prefetch does are not
> > innocuous so I really do want them to only be done when nothing else
> > wants cpu.
>
> Wouldn't the change break prefetching if I have 98% CPU time free and not
> 100%? Something like an audio player in the background?

That would only intermittently stop prefetching whenever both happened to use 
cpu at exactly the same time (which is the desired effect). So playing audio 
will slow prefetch a little but it will still prefetch.

> It seems that any Seti@home type of calculation would kill it.
> In reality, we don't want disk reads when something interactive is running,
> so maybe you'd look at the nice level of the task?
> (higher than x = don't count it?)

That's what Peter is promoting here. I could use the "weighted load" value to 
determine just that, and keep running prefetch if highly niced tasks are 
running. I am considering adding that in the future. For the moment I 
definitely think opting out of prefetching whenever anything is running is 
the right thing to do.

Cheers,
Con
