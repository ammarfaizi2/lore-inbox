Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWGZG2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWGZG2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWGZG2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:28:43 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38306 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030402AbWGZG2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:28:42 -0400
Date: Wed, 26 Jul 2006 10:28:17 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
Message-ID: <20060726062817.GA20636@2ka.mipt.ru>
References: <44C66FC9.3050402@redhat.com> <20060725.150122.49854414.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060725.150122.49854414.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 26 Jul 2006 10:28:21 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 03:01:22PM -0700, David Miller (davem@davemloft.net) wrote:
> From: Ulrich Drepper <drepper@redhat.com>
> Date: Tue, 25 Jul 2006 12:23:53 -0700
> 
> > I was very much surprised by the reactions I got after my OLS talk.
> > Lots of people declared interest and even agreed with the approach and
> > asked me to do further ahead with all this.  For those who missed it,
> > the paper and the slides are available on my home page:
> > 
> > http://people.redhat.com/drepper/
> > 
> > As for the next steps I see a number of possible ways.  The discussions
> > can be held on the usual mailing lists (i.e., lkml and netdev) but due
> > to the raw nature of the current proposal I would imagine that would be
> > mainly perceived as noise.
> 
> Since I gave a big thumbs up for Evgivny's kevent work yesterday
> on linux-kernel, you might want to start by comparing your work
> to his.  Because his has the advantage that 1) we have code now
> and 2) he has written many test applications and performed many
> benchmarks against his code which has flushed out most of the
> major implementation issues.
> 
> I think most of the people who have encouraged your work are unaware
> of Evgivny's kevent stuff, which is extremely unfortunate, the two
> works are more similar than they are different.
> 
> I do not think discussing all of this on netdev would be perceived
> as noise. :)

Hello David, Ulrich.

Here is brief description of what is kevent and how it works.

Kevent subsystem incorporates several AIO/kqueue design notes and ideas.
Kevent can be used both for edge and level notifications. It supports
socket notifications (accept, send, recv), network AIO (aio_send(),
aio_recv() and aio_sendfile()), inode notifications (create/remove),
generic poll()/select() notifications and timer notifications.

There are several object in the kevent system:
storage - each source of events (socket, inode, timer, aio, anything) has
	structure kevent_storage incorporated into it, which is basically a list
	of registered interests for this source of events.
user - it is abstraction which holds all requested kevents. It is
	similar to FreeBSD's kqueue.
kevent - set of interests for given source of events or storage.

When kevent is queued into storage, it will live there until removed by
kevent_dequeue(). When some activity is noticed in given storage, it
scans it's kevent_storage->list for kevents which match activity event.
If kevents are found and they are not already in the
kevent_user->ready_list, they will be added there at the end.

ioctl(WAIT) (or appropriate syscall) will wait until either requested
number of kevents are ready or timeout elapsed or at least one kevent is
ready, it's behaviour depends on parameters.

It is possible to have one-shot kevents, which are automatically removed
when are ready.

Any event can be added/removed/modified by ioctl or special controlling
syscall.

Network AIO is based on kevent and works as usual kevent storage on top
of inode.
When new socket is created it is associated with that inode and when
some activity is detected appropriate notifications are generated and
kevent_naio_callback() is called.
When new kevent is being registered, network AIO ->enqueue() callback
simply marks itself like usual socket event watcher. It also locks
physical userspace pages in memory and stores appropriate pointers in
private kevent structure. I have not created additional DMA memory
allocation methods, like Ulrich described in his article, so I handle it
inside NAIO which has some overhead (I posted get_user_pages()
sclability graph some time ago).
Network AIO callback gets pointers to userspace pages and tries to copy
data from receiving skb queue into them using protocol specific
callback. This callback is very similar to ->recvmsg(), so they could
share a lot in future (as far as I recall it worked only with hardware
capable to do checksumming, I'm a bit lazy).

Both network and aio implementation work on top of hooks inside
appropriate state machines, but not as repeated call design (curect AIO) 
or special thread (SGI AIO). AIO work was stopped, since I was unable to 
achieve the same speed as synchronous read 
(maximum speeds were 2Gb/sec vs. 2.1 GB/sec for aio and sync IO accordingly
when reading data from the cache).
Network aio_sendfile() works lazily - it asynchronously populates pages
into the VFS cache (which can be used for various tricks with adaptive
readahead) and then uses usual ->sendfile() callback.

I have not created an interface for userspace events (like Solaris), 
since right now I do not see it's usefullness, but if there is
requirements for that it is quite easy with kevents.

I'm preparing set of kevent patches resend (with cleanups mentioned in
previous e-mails), which will be ready in a couple of moments.

1. kevent homepage.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent

2. network aio homepage.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=naio

3. LWN.net published a very good article about kevent.
http://lwn.net/Articles/172844/

Thank you.

-- 
	Evgeniy Polyakov
