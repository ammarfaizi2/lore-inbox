Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264041AbRFROTq>; Mon, 18 Jun 2001 10:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264050AbRFROTh>; Mon, 18 Jun 2001 10:19:37 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:3086 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264041AbRFROTS>; Mon, 18 Jun 2001 10:19:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Mike Galbraith <mikeg@wen-online.de>
Subject: Re: spindown [was Re: 2.4.6-pre2, pre3 VM Behavior]
Date: Mon, 18 Jun 2001 16:22:05 +0200
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
        John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, <thunder7@xs4all.nl>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de>
MIME-Version: 1.0
Message-Id: <01061816220503.11745@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 June 2001 12:05, Mike Galbraith wrote:
> It _juuust_ so happens that I was tinkering... what do you think of
> something like the below?  (and boy do I ever wonder what a certain
> box doing slrn stuff thinks of it.. hint hint;)

It's too subtle for me ;-)  (Not shy about sying that because this part of 
the kernel is probably subtle for everyone.)

The question I'm tackling right now is how the system behaves when the load 
goes away, or doesn't get heavy.  Your patch doesn't measure the load 
directly - it may attempt to predict it as a function of memory pressure, but 
that's a little more loosely coupled than what I had in mind.

I'm now in the midst of hatching a patch. [1] The first thing I had to do is 
go explore the block driver code, yum yum.  I found that it already computes 
the statistic I'm interested in, namely queued_sectors, which is used to pace 
the IO on block devices.  It's a little crude - we really want this to be 
per-queue and have one queue per "spindle" - but even in its current form 
it's workable.

The idea is that when queued_sectors drops below some threshold we have 
'unused disk bandwidth' so it would be nice to do something useful with it:

  1) Do an early 'sync_old_buffers'
  2) Do some preemptive pageout

The benefit of (1) is that it lets disks go idle a few seconds earlier, and 
(2) should improve the system's latency in response to load surges.  There 
are drawbacks too, which have been pointed out to me privately, but they tend 
to be pretty minor, for example: on a flash disk you'd do a few extra writes 
and wear it out ever-so-slightly sooner.  All the same, such special devices 
can be dealt easily once we progress a little further in improving the 
kernel's 'per spindle' intelligence.

Now how to implement this.  I considered putting a (newly minted) 
wakeup_kflush in blk_finished_io, conditional on a loaded-to-unloaded 
transition, and that's fine except it doesn't do the whole job: we also need 
to have the early flush for any write to a disk file while the disks are 
lightly loaded, i.e., there is no convenient loaded-to-unloaded transition to 
trigger it.  The missing trigger could be inserted into __mark_dirty, but 
that would penalize the loaded state (a little, but that's still too much).  
Furthermore, it's probably desirable to maintain a small delay between the 
dirty and the flush.  So what I'll try first is just running kflush's timer 
faster, and make its reschedule period vary with disk load, i.e., when there 
are fewer queued_sectors, kflush looks at the dirty buffer list more often.

The rest of what has to happen in kflush is pretty straightforward.  It just 
uses queued_sectors to determine how far to walk the dirty buffer list, which 
is maintained in time-since-dirtied order.  If queued_sectors is below some 
threshold the entire list is flushed.  Note that we want to change the sense 
of b_flushtime to b_timedirtied.  It's more efficient to do it this way 
anyway.

I haven't done anything about preemptive pageout yet, but similar ideas apply.

[1] This is an experiment, do not worry, it will not show up in your tree any 
time soon.  IOW, constructive criticism appreciated, flames copied to 
/dev/null.

--
Daniel
