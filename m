Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263597AbRFSEhW>; Tue, 19 Jun 2001 00:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263607AbRFSEhN>; Tue, 19 Jun 2001 00:37:13 -0400
Received: from www.wen-online.de ([212.223.88.39]:4876 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263597AbRFSEhF>;
	Tue, 19 Jun 2001 00:37:05 -0400
Date: Tue, 19 Jun 2001 06:35:38 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
        John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, <thunder7@xs4all.nl>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
In-Reply-To: <01061816220503.11745@starship>
Message-ID: <Pine.LNX.4.33.0106190617430.483-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Daniel Phillips wrote:

> On Sunday 17 June 2001 12:05, Mike Galbraith wrote:
> > It _juuust_ so happens that I was tinkering... what do you think of
> > something like the below?  (and boy do I ever wonder what a certain
> > box doing slrn stuff thinks of it.. hint hint;)
>
> It's too subtle for me ;-)  (Not shy about sying that because this part of
> the kernel is probably subtle for everyone.)

No subtltry (hammer), it just draws a line that doesn't move around
in unpredictable ways.  For example, nr_free_buffer_pages() adds in
free pages to the line it draws.  You may have a large volume of dirty
data, decide it would be prudent to flush, then someone frees a nice
chunk of memory...  (send morse code messages via malloc/free?:)

Anyway it's crude, but it seems to have gotten results from the slrn
load.  I received logs for ac15 and ac15+patch.  ac15 took 265 seconds
to do the job whereas with the patch it took 227 seconds.  I haven't
poured over the logs yet, but there seems to be throughput to be had.

If anyone is interested in the logs, they're much smaller than expected
-rw-r--r--   1 mikeg    users       11993 Jun 19 05:58 ac15_mike.log
-rw-r--r--   1 mikeg    users       13015 Jun 19 05:58 ac15_org.log

> The question I'm tackling right now is how the system behaves when the load
> goes away, or doesn't get heavy.  Your patch doesn't measure the load
> directly - it may attempt to predict it as a function of memory pressure, but
> that's a little more loosely coupled than what I had in mind.

It doesn't attempt to predict, it reacts to the existing situation.

> I'm now in the midst of hatching a patch. [1] The first thing I had to do is
> go explore the block driver code, yum yum.  I found that it already computes
> the statistic I'm interested in, namely queued_sectors, which is used to pace
> the IO on block devices.  It's a little crude - we really want this to be
> per-queue and have one queue per "spindle" - but even in its current form
> it's workable.
>
> The idea is that when queued_sectors drops below some threshold we have
> 'unused disk bandwidth' so it would be nice to do something useful with it:

(that's much more subtle/clever:)

>   1) Do an early 'sync_old_buffers'
>   2) Do some preemptive pageout
>
> The benefit of (1) is that it lets disks go idle a few seconds earlier, and
> (2) should improve the system's latency in response to load surges.  There
> are drawbacks too, which have been pointed out to me privately, but they tend
> to be pretty minor, for example: on a flash disk you'd do a few extra writes
> and wear it out ever-so-slightly sooner.  All the same, such special devices
> can be dealt easily once we progress a little further in improving the
> kernel's 'per spindle' intelligence.
>
> Now how to implement this.  I considered putting a (newly minted)
> wakeup_kflush in blk_finished_io, conditional on a loaded-to-unloaded
> transition, and that's fine except it doesn't do the whole job: we also need
> to have the early flush for any write to a disk file while the disks are
> lightly loaded, i.e., there is no convenient loaded-to-unloaded transition to
> trigger it.  The missing trigger could be inserted into __mark_dirty, but
> that would penalize the loaded state (a little, but that's still too much).
> Furthermore, it's probably desirable to maintain a small delay between the
> dirty and the flush.  So what I'll try first is just running kflush's timer
> faster, and make its reschedule period vary with disk load, i.e., when there
> are fewer queued_sectors, kflush looks at the dirty buffer list more often.
>
> The rest of what has to happen in kflush is pretty straightforward.  It just
> uses queued_sectors to determine how far to walk the dirty buffer list, which
> is maintained in time-since-dirtied order.  If queued_sectors is below some
> threshold the entire list is flushed.  Note that we want to change the sense
> of b_flushtime to b_timedirtied.  It's more efficient to do it this way
> anyway.
>
> I haven't done anything about preemptive pageout yet, but similar ideas apply.

Preemptive pageout could be simply walk the dirty list looking for swap
pages and writing them out.  With the fair aging change that's already
in, there will be some.  If the fair aging change to background aging
works out, there will be more (don't want too many more though;).  The
only problem I can see with that simle method is that once written, the
page lands on the inactive_clean list.  That list is short and does get
consumed.. might turn fake pageout into a real one unintentionally.

> [1] This is an experiment, do not worry, it will not show up in your tree any
> time soon.  IOW, constructive criticism appreciated, flames copied to
> /dev/null.

Look forward to seeing it.

	-Mike

