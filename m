Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWJQNmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWJQNmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWJQNmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:42:44 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:54223 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750943AbWJQNmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:42:43 -0400
Date: Tue, 17 Oct 2006 17:42:07 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Johann Borck <johann.borck@densedata.com>,
       Ulrich Drepper <drepper@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 1/4] kevent: Core files.
Message-ID: <20061017134206.GC20225@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <453465B6.1000401@densedata.com> <20061017103940.GA19246@2ka.mipt.ru> <200610171519.37051.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200610171519.37051.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 17 Oct 2006 17:42:08 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 03:19:36PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> On Tuesday 17 October 2006 12:39, Evgeniy Polyakov wrote:
> 
> > I can add such notification, but its existense _is_ the broken design.
> > After such condition happend, all new events will dissapear (although
> > they are still accessible through usual queue) from mapped buffer.
> >
> > While writing this I have come to the idea on how to imrove the case of
> > the size of mapped buffer - we can make it with limited size, and when
> > it is full, some bit will be set in the shared area and obviously no new
> > events can be added there, but when user commits some events from that
> > buffer (i.e. says to kernel that appropriate kevents can be freed or
> > requeued according to theirs flags), new ready events from ready queue
> > can be copied into mapped buffer.
> >
> > It still does not solve (and I do insist that it is broken behaviour)
> > the case when kernel is going to generate infinite number of events for
> > one requested by userspace (as in case of generating new 'data_has_arrived'
> > event when new byte has been received).
> 
> Behavior is not broken. It's quite usefull and works 99.9999% of time.
>
> I was trying to suggest you but you missed my point.
> 
> You dont want to use a bit, but a full sequence counter, 32bits.
> 
> A program may handle XXX.XXX handles, but use a 4096 entries ring 
> buffer 'only'.
> 
> The user program keeps a local copy of a special word 
> named 'ring_buffer_full_counter'
> 
> Each time the kernel cannot queue an event in the ring buffer, it increase 
> the "ring_buffer_was_full_counter" (exported to user app in the mmap view)
> 
> When the user application notice the kernel 
> changed "ring_buffer_was_full_counter" it does a full scan of all file 
> handles (preferably using poll() to get all relevant info in one syscall) :

I.e. to scan the rest of the xxx.xxx events?

> do {
>    if (read_event_from_mmap()) {handle_event(fd); continue;}
>    /* ring buffer is empty, check if we missed some events */
>    if (unlikely(mmap->ring_buffer_full_counter !=  
> my_ring_buffer_full_counter)) {
> 	my_ring_buffer_full_counter = mmap->ring_buffer_full_counter;
> 	/* slow PATH */
> 	/* can use a big poll() for example, or just a loop without poll() */
> 	for_all_file_desc_do() {
> 		check if some event/data is waiting on THIS fd
> 		}
> 	/* 
> 	}
>     else  syscall_wait_for_one_available_kevent(queue)
> }
> 
> This is how a program can recover. If ring buffer has a reasonable size, this 
> kind of event should not happen very frequently. If it does (because events 
> continue to fill ring_buffer during recovery and might hit FULL again), maybe 
> a smart program is able to resize the ring_buffer, and start using it after 
> yet another recovery pass.
> If not, we dont care, because a big poll() give us many ready file-descriptors 
> in one syscall, and maybe this is much better than kevent/epoll when XX.XXX 
> events are ready.

What about the case, which I described in other e-mail, when in case of
the full ring buffer, no new events are written there, and when
userspace commits (i.e. marks as ready to be freed or requeued by kernel) 
some events, new ones will be copied from ready queue into the buffer?

> Eric

-- 
	Evgeniy Polyakov
