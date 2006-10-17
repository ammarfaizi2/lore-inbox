Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWJQNgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWJQNgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWJQNgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:36:25 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:22180 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750843AbWJQNgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:36:24 -0400
Date: Tue, 17 Oct 2006 17:35:16 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Chase Venters <chase.venters@clientec.com>
Cc: Johann Borck <johann.borck@densedata.com>,
       Ulrich Drepper <drepper@redhat.com>, Eric Dumazet <dada1@cosmosbay.com>,
       Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take19 1/4] kevent: Core files.
Message-ID: <20061017133516.GB20225@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <200610170100.10500.chase.venters@clientec.com> <20061017104242.GB19246@2ka.mipt.ru> <200610170812.28027.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200610170812.28027.chase.venters@clientec.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 17 Oct 2006 17:35:17 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 08:12:04AM -0500, Chase Venters (chase.venters@clientec.com) wrote:
> > > > Regarding mukevent I'm thinking of a event-type specific struct, that
> > > > is filled by the originating code, and placed into a per-event-type
> > > > ring buffer (which  requires modification of kevent_wait).
> > >
> > > I'd personally worry about an implementation that used a per-event-type
> > > ring buffer, because you're still left having to hack around starvation
> > > issues in user-space. It is of course possible under the current model
> > > for anyone who wants per-event-type ring buffers to have them - just make
> > > separate kevent sets.
> > >
> > > I haven't thought this through all the way yet, but why not have variable
> > > length event structures and have the kernel fill in a "next" pointer in
> > > each one? This could even be used to keep backwards binary compatibility
> > > while
> >
> > Why do we want variable size structures in mmap ring buffer?
> 
> Flexibility primarily. So when we all decide to add a new event type six 
> months from now, or add more information to an existing one, we don't run the 
> risk that the existing mukevent isn't big enough.

Do we need such flexibility, when we have unique id attached to each
event? User can store any information in own buffers, which are indexed
by that id.

> > > adding additional fields to the structures over time, though no space
> > > would be wasted on modern programs. You still end up with a question of
> > > what to do in case of overflow, but I'm thinking the thing to do in that
> > > case might be to start pushing overflow events onto a linked list which
> > > can be written back into the ring buffer when space becomes available.
> > > The appropriate behavior would be to throw new events on the linked list
> > > if the linked list had any events, so that things are delivered in order,
> > > but write to the mapped buffer directly otherwise.
> >
> > I think in a similar way.
> > Kevent actually do not require such list, since it has already queue of
> > the ready events.
> 
> The current event types coalesce if there are multiple events, correct? It 
> sounds like there may be other event types where coalescing multiple events 
> is not the correct approach.

There is no events coalescing, I think that it is even incorrect to say, that
something is being coalesced in kevents.

There is 'new' (which is well forgotten old) approach - user _asks_ kernel 
about some information, and kernel says when it is ready. Kernel does not 
say: part of the info is ready, part of the info is ready and so on, it 
just marks user's request as ready - that means that it is possible that
there were zillions of events, each one could mark the _same_ userspace
request as ready, and exactly what user requested is transferred back. 
Thus it is very fast and is correct way to deal with problem of pipes of 
different diameters.

Kernel does not generate events - only user creates requests, which are
marked as ready.

I made that decision to remove _any_ kind of possible overflows from
kernel side - if user was scheduled away, or has unsufficient space or
bad mood, to not introduce any kind of ugly priorities (higher one 
could fill the whole pipe while lower could not even send a single event). 
Instead kernel does just what it was requested to do, and it can provide 
some hints on how that process happend (for example how many sockets are 
ready for accept(), or how many bytes are in the receiving queue).

And that approach does solve the problem of the cases when it looks like
it is logical to _generate_ event - for example in inotify case, where
new event is _generated_ each time requested case happens. For example
the case when new files are created in the directory - it is possible
that there will be queue overflow (btw, watch for each file in the kernel 
tree takes about 2gb of kernel mem), if many files were created, so
userspace must rescan the whole directory to check missed files, so why
is it needed at all to generate info about first two or ten files,
instead userspace asks kernel to notify it when directory has changed or
some new files were created, and kernelspace will answer when directory
has been changed or new files were created (with some hint with number
of them).

Likely request for generation of events in kernel is a workaround for 
some other problems, which in long term will hit us with new troubles -
queue length and overflows.

> Thanks,
> Chase

-- 
	Evgeniy Polyakov
