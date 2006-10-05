Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751611AbWJEKVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbWJEKVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 06:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWJEKVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 06:21:52 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:19877 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751609AbWJEKVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 06:21:51 -0400
Date: Thu, 5 Oct 2006 14:21:06 +0400
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
Message-ID: <20061005102106.GE1015@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <a36005b50610041057g67dcaf73wd48d9fef88187ec6@mail.gmail.com> <20061005085750.GA1015@2ka.mipt.ru> <200610051156.25036.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200610051156.25036.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 05 Oct 2006 14:21:07 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 11:56:24AM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> On Thursday 05 October 2006 10:57, Evgeniy Polyakov wrote:
> 
> > Well, it is possible to create /sys/proc entry for that, and even now
> > userspace can grow mapping ring until it is forbiden by kernel, which
> > means limit is reached.
> 
> No need for yet another /sys/proc entry.
> 
> Right now, I (for example) may have a use for Generic event handling, but for 
> a program that needs XXX.XXX handles, and about XX.XXX events per second.
> 
> Right now, this program uses epoll, and reaches no limit at all, once you pass 
> the "ulimit -n", and other kernel wide tunes of course, not related to epoll.
> 
> With your current kevent, I cannot switch to it, because of hardcoded limits.
> 
> I may be wrong, but what is currently missing for me is :
> 
> - No hardcoded limit on the max number of events. (A process that can open 
> XXX.XXX files should be allowed to open a kevent queue with at least XXX.XXX 
> events). Right now thats not clear what happens IF the current limit is 
> reached.

This forces to overflows in fixed sized memory mapped buffer.
If we remove memory mapped buffer or will allow to have overflows (and
thus skipped entries) keven can easily scale to that limits (tested with
xx.xxx events though).

> - In order to avoid touching the whole ring buffer, it might be good to be 
> able to reset the indexes to the beginning when ring buffer is empty. (So if 
> the user land is responsive enough to consume events, only first pages of the 
> mapping would be used : that saves L1/L2 cpu caches)

And what happens when there are 3 empty at the beginning and \we need to
put there 4 ready events?

> A plus would be
> 
> - A working/usable mmap ring buffer implementation, but I think its not 
> mandatory. System calls are not that expensive, especially if you can batch 
> XX events per syscall (like epoll). Nice thing with a ring buffer is that we 
> touch less cache lines than say epoll that have lot of linked structures.
> 
> About mmap, I think you might want a hybrid thing :
> 
> One writable page where userland can write its index, (and hold one or more 
> futex shared by kernel) (with appropriate thread locking in case multiple 
> threads want to dequeue events). In fast path, no syscalls are needed to 
> maintain this user index.
> 
> XXX readonly pages (for user, but r/w for kernel), where kernel write its own 
> index, and events of course.

The problem is in that xxx pages - how many can we eat per kevent
descriptor? It is pinned memory and thus it is possible to have a DoS.
If xxx above is not enough to store all events, we will have
yet-another-broken behaviour like rt-signal queue overflow.

> Using separate cache lines avoid false sharing : kernel can update its own 
> index and events without having to pay the price of cache line ping pongs.
> It could use futex infrastructure to wakeup one thread 'only' instead of all 
> threads waiting an event.
>
> 
> Eric

-- 
	Evgeniy Polyakov
