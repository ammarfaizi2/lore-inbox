Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751668AbWJEK4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbWJEK4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWJEK4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:56:11 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:49296 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751669AbWJEK4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:56:09 -0400
Date: Thu, 5 Oct 2006 14:55:37 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take19 1/4] kevent: Core files.
Message-ID: <20061005105536.GA4838@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <200610051156.25036.dada1@cosmosbay.com> <20061005102106.GE1015@2ka.mipt.ru> <200610051245.03880.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200610051245.03880.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 05 Oct 2006 14:55:38 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 12:45:03PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> On Thursday 05 October 2006 12:21, Evgeniy Polyakov wrote:
> > On Thu, Oct 05, 2006 at 11:56:24AM +0200, Eric Dumazet (dada1@cosmosbay.com) 
> > > I may be wrong, but what is currently missing for me is :
> > >
> > > - No hardcoded limit on the max number of events. (A process that can
> > > open XXX.XXX files should be allowed to open a kevent queue with at least
> > > XXX.XXX events). Right now thats not clear what happens IF the current
> > > limit is reached.
> >
> > This forces to overflows in fixed sized memory mapped buffer.
> > If we remove memory mapped buffer or will allow to have overflows (and
> > thus skipped entries) keven can easily scale to that limits (tested with
> > xx.xxx events though).
> 
> What is missing or not obvious is : If events are skipped because of 
> overflows, What happens ? Connections stuck forever ? Hope that everything 
> will restore itself ? Is kernel able to SIGNAL this problem to user land ?
 
Exisitng  code does not overflow by design, but can consume a lot of
memory. I talked about the case, when there will be some limit on
number of entries put into mapped buffer.

> > > - In order to avoid touching the whole ring buffer, it might be good to
> > > be able to reset the indexes to the beginning when ring buffer is empty.
> > > (So if the user land is responsive enough to consume events, only first
> > > pages of the mapping would be used : that saves L1/L2 cpu caches)
> >
> > And what happens when there are 3 empty at the beginning and \we need to
> > put there 4 ready events?
> 
> Re-read what I said :  when ring buffer is empty.
> 
> When ring buffer is empty, kernel can reset index right before adding XX new 
> events. You read 3 events consumed, I said : When all ring buffer is empty, 
> because all previous events were consumed by user land, then we can reset 
> indexes to 0.

It is the same.
What if reing buffer was grown upto 3 entry, and is now empty, and we
need to put there 4 entries? Grow it again?
It can be done, easily, but it looks like a workaround not as solution.
And it is highly unlikely that in situation, when there are a lot of
event, ring can be empty.

> >
> > > A plus would be
> > >
> > > - A working/usable mmap ring buffer implementation, but I think its not
> > > mandatory. System calls are not that expensive, especially if you can
> > > batch XX events per syscall (like epoll). Nice thing with a ring buffer
> > > is that we touch less cache lines than say epoll that have lot of linked
> > > structures.
> > >
> > > About mmap, I think you might want a hybrid thing :
> > >
> > > One writable page where userland can write its index, (and hold one or
> > > more futex shared by kernel) (with appropriate thread locking in case
> > > multiple threads want to dequeue events). In fast path, no syscalls are
> > > needed to maintain this user index.
> > >
> > > XXX readonly pages (for user, but r/w for kernel), where kernel write its
> > > own index, and events of course.
> >
> > The problem is in that xxx pages - how many can we eat per kevent
> > descriptor? It is pinned memory and thus it is possible to have a DoS.
> > If xxx above is not enough to store all events, we will have
> > yet-another-broken behaviour like rt-signal queue overflow.
> >
> 
> Re-read : I have a process that has the right to open XXX.XXX handles, 
> allocating XXX.XXX tcp sockets, dentries, files structures, inodes, epoll 
> events, its obviously already a DOS risk, but controled by 'ulimit -n'
> 
> Allocating XXX.XXX * (32 or 64) bytes is a win if I can zap epoll structures 
> (currently more than 256 bytes per event)
> 
> epoll structures are pinned too... what's wrong with that ?
> 
> # egrep "filp|poll|TCP|dentries|sock_inode" /proc/slabinfo |cut -c1-50
> tw_sock_TCP         1302   2200    192   20    1 :
> request_sock_TCP    2046   4260    128   30    1 :
> TCP               151509 196910   1472    5    2 :
> eventpoll_pwq     146718 199439     72   53    1 :
> eventpoll_epi     146718 199360    192   20    1 :
> sock_inode_cache  149182 197940    640    6    1 :
> filp              149537 202515    256   15    1 :
> 
> If you want to protect from DOS, just use ulimit -n 100

epoll() does not have mmap.
Problem is not about how many events can be put into the kernel, but how
many of them can be put into mapped buffer.
There is no problem if mmap is turned off.

> Eric

-- 
	Evgeniy Polyakov
