Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWJQNwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWJQNwh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWJQNwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:52:37 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:33492 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1750972AbWJQNwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:52:36 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Tue, 17 Oct 2006 15:52:34 +0200
User-Agent: KMail/1.9.5
Cc: Johann Borck <johann.borck@densedata.com>,
       Ulrich Drepper <drepper@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
References: <11587449471424@2ka.mipt.ru> <200610171519.37051.dada1@cosmosbay.com> <20061017134206.GC20225@2ka.mipt.ru>
In-Reply-To: <20061017134206.GC20225@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171552.35470.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 15:42, Evgeniy Polyakov wrote:
> On Tue, Oct 17, 2006 at 03:19:36PM +0200, Eric Dumazet (dada1@cosmosbay.com) 
wrote:
> > On Tuesday 17 October 2006 12:39, Evgeniy Polyakov wrote:
> > > I can add such notification, but its existense _is_ the broken design.
> > > After such condition happend, all new events will dissapear (although
> > > they are still accessible through usual queue) from mapped buffer.
> > >
> > > While writing this I have come to the idea on how to imrove the case of
> > > the size of mapped buffer - we can make it with limited size, and when
> > > it is full, some bit will be set in the shared area and obviously no
> > > new events can be added there, but when user commits some events from
> > > that buffer (i.e. says to kernel that appropriate kevents can be freed
> > > or requeued according to theirs flags), new ready events from ready
> > > queue can be copied into mapped buffer.
> > >
> > > It still does not solve (and I do insist that it is broken behaviour)
> > > the case when kernel is going to generate infinite number of events for
> > > one requested by userspace (as in case of generating new
> > > 'data_has_arrived' event when new byte has been received).
> >
> > Behavior is not broken. It's quite usefull and works 99.9999% of time.
> >
> > I was trying to suggest you but you missed my point.
> >
> > You dont want to use a bit, but a full sequence counter, 32bits.
> >
> > A program may handle XXX.XXX handles, but use a 4096 entries ring
> > buffer 'only'.
> >
> > The user program keeps a local copy of a special word
> > named 'ring_buffer_full_counter'
> >
> > Each time the kernel cannot queue an event in the ring buffer, it
> > increase the "ring_buffer_was_full_counter" (exported to user app in the
> > mmap view)
> >
> > When the user application notice the kernel
> > changed "ring_buffer_was_full_counter" it does a full scan of all file
> > handles (preferably using poll() to get all relevant info in one syscall)
> > :
>
> I.e. to scan the rest of the xxx.xxx events?
>
> > do {
> >    if (read_event_from_mmap()) {handle_event(fd); continue;}
> >    /* ring buffer is empty, check if we missed some events */
> >    if (unlikely(mmap->ring_buffer_full_counter !=
> > my_ring_buffer_full_counter)) {
> > 	my_ring_buffer_full_counter = mmap->ring_buffer_full_counter;
> > 	/* slow PATH */
> > 	/* can use a big poll() for example, or just a loop without poll() */
> > 	for_all_file_desc_do() {
> > 		check if some event/data is waiting on THIS fd
> > 		}
> > 	/*
> > 	}
> >     else  syscall_wait_for_one_available_kevent(queue)
> > }
> >
> > This is how a program can recover. If ring buffer has a reasonable size,
> > this kind of event should not happen very frequently. If it does (because
> > events continue to fill ring_buffer during recovery and might hit FULL
> > again), maybe a smart program is able to resize the ring_buffer, and
> > start using it after yet another recovery pass.
> > If not, we dont care, because a big poll() give us many ready
> > file-descriptors in one syscall, and maybe this is much better than
> > kevent/epoll when XX.XXX events are ready.
>
> What about the case, which I described in other e-mail, when in case of
> the full ring buffer, no new events are written there, and when
> userspace commits (i.e. marks as ready to be freed or requeued by kernel)
> some events, new ones will be copied from ready queue into the buffer?

Then, user might receive 'false events', exactly like poll()/select()/epoll() 
can do sometime. IE a 'ready' indication while there is no current event 
available on a particular fd / event_source.

This should be safe, since those programs already ignore read() 
returns -EAGAIN and other similar things.

Programmer prefers to receive two 'event available' indications than ZERO (and 
be stuck for infinite time). Of course, hot path (normal cases) should return 
one 'event' only.

In order words, being ultra fast 99.99 % of the time, but being able to block 
forever once in a while is not an option.
 
Eric

