Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWKGL7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWKGL7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbWKGL7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:59:34 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:41682 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754205AbWKGL7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:59:33 -0500
Date: Tue, 7 Nov 2006 14:51:11 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [take21 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061107115111.GA13028@2ka.mipt.ru>
References: <11619654014077@2ka.mipt.ru> <45506D51.30604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45506D51.30604@garzik.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 07 Nov 2006 14:51:11 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 06:26:09AM -0500, Jeff Garzik (jeff@garzik.org) wrote:
> Evgeniy Polyakov wrote:
> >Generic event handling mechanism.
> >
> >Consider for inclusion.
> >
> >Changes from 'take20' patchset:
> > * new ring buffer implementation
> > * removed artificial limit on possible number of kevents
> >With this release and fixed userspace web server it was possible to 
> >achive 3960+ req/s with client connection rate of 4000 con/s
> >over 100 Mbit lan, data IO over network was about 10582.7 KB/s, which
> >is too close to wire speed if we get into account headers and the like.
> 
> OK, now that ring buffer is here, I definitely like the direction this 
> code is taking.  I just committed the patches to a local repo for a good 
> in-depth review.

It is third ring buffer, the fourth one will be in the next release,
which should satisfy everyone.

> Could you write up a simple text file, documenting (a) your proposed 
> syscalls and (b) your ring buffer design?

Initial draft about supported syscalls can be found at documentation page at
http://linux-net.osdl.org/index.php/Kevent

Ring buffer background bits pasted below (quotations from blog, do not
pay too much attention if sometimes something is not in sync).

New ring buffer is implemented fully in userspace in process' memory,
which means that there are no memory pinned, its size can have almost
any length, several threads and processes can access it simultaneously.
There is new system call

int kevent_ring_init(int ctl_fd, struct ring_buffer *ring, unsigned int
num);

which initializes kevent's ring buffer (int ctl_fd is a kevent file
descriptor, struct ring_buffer *ring is a userspace allocated ring
buffer, and unsigned int num is maximum number of events (struct
ukevent) which can be placed into that buffer).
Ring buffer is described with following structure:

struct kevent_ring
{
	unsigned int		ring_kidx, ring_uidx;
	struct ukevent		event[0];
};

where unsigned int ring_kidx, ring_uidx are last kernel's position (i.e.
position which points to the first place after the last kevent put by
kernel into the ring buffer) and last userspace commit (i.e. position
where first unread kevent lives) positions appropriately.
I will release appropriate userspace test application when tests are
completed.

When kevent is removed (not dequeued when it is ready, but just
removed), even if it was ready, it is not copied into ring buffer, since
if it is removed, no one cares about it (otherwise user would wait until
it becomes ready and got it through usual way using kevent_get_events()
or kevent_wait()) and thus no need to copy it to the ring buffer.
Dequeueing of the kevent (calling kevent_get_events()) means that user
has processed previously dequeued kevent and is ready to process new
one, which means that position in the ring buffer previously ocupied but
that event can be reused by currently dequeued event. In the world where
only one type of syscalls to get events is used (either usual way and
kevent_get_events() or ring buffer and kevent_wait()) it should not be a
problem, since kevent_wait() only allows to mark number of events as
processed by userspace starting from the beginning (i.e. from the last
processed event), but if several threads will use different models, that
can rise some questions, for example one thread can start to read events
from ring buffer, and in that time other thread will call
kevent_get_events(), which can rewrite that events. Actually other
thread can call kevent_wait() to commit that events (i.e. mark them as
processed by userspace so kernel could free them or requeue), so
appropriate locking is required in userspace in any way.

So I want to repeat, that it is possible with userspace ring buffer,
that events in the ring buffer can be replaced without knowledge for the
thread currently reading them (when other thread calls
kevent_get_events() or kevent_wait()), so appropriate locking between
threads or processes, which can simultaneously access the same ring
buffer, is required.

Having userspace ring buffer allows to make all kevent syscalls as so
called 'cancellation points' by glibc, i.e. when thread has been
cancelled in kevent syscall, thread can be safely removed and no events
will be lost, since each syscall will copy event into special ring
buffer, accessible from other threads or even processes (if shared
memory is used).


> 
> Overall I have a Linux "design wish", that I hope kevent can fulfill:
> 
> To develop completely async applications (generally network servers, in 
> Linux-land) and increase the chance of zero-copy I/O, network and file 
> I/O submission and completion should be as async as possible.
> 
> As such, syscalls themselves have come a serializing bottleneck that 
> isn't strictly necessary.  A fully-async application should be able to 
> submit file read, file write, and network write requests 
> asynchronously... in batches.  Network reads, and file I/O completions 
> should be received asynchronously, potentially in batches.
> 
> Even with epoll and AIO syscalls, Linux isn't quite up to the task.
> 
> So to me, the design of the userspace interface that solves this problem 
> is a fundamental issue.
> 
> My best guess at a solution would be two classes of mmap'd ring buffers, 
> request and response.  Let the app allocate one or more.  Then have two 
> hooks, (a) kick the kernel to read the request ring, and (b) kick the 
> app when one or more events have arrived on a ring.

Mmap ring buffer implementation was stopped by Andrew Morton and Ulrich
Drepper, process' memory is used instead. copy_to_user() is slower (and
some times noticebly), but there are major advantages of such approach.

> But that's just thinking out loud.  I welcome any solution that gives 
> userspace a fully-async submission/completion interface for both network 
> and file I/O.

Well, kevent network and FS AIO are suspended for now (although first
patches included them all).

> Setting the standard for a good interface here means Linux will kick ass 
> for decades more to come ;-)  This is IMO a Big Deal(tm).
> 
> 	Jeff
> 

-- 
	Evgeniy Polyakov
