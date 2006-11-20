Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934032AbWKTJVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934032AbWKTJVs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 04:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934030AbWKTJVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 04:21:48 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57236 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S934022AbWKTJVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 04:21:46 -0500
Date: Mon, 20 Nov 2006 12:19:51 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061120091951.GA13050@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <20061120004301.d1815a95.akpm@osdl.org> <20061120085158.GA2816@2ka.mipt.ru> <20061120011516.56311f7a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061120011516.56311f7a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 20 Nov 2006 12:19:52 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 01:15:16AM -0800, Andrew Morton (akpm@osdl.org) wrote:
> On Mon, 20 Nov 2006 11:51:59 +0300
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > On Mon, Nov 20, 2006 at 12:43:01AM -0800, Andrew Morton (akpm@osdl.org) wrote:
> > > > > >If thread calls kevent_wait() it means it has processed previous entries, 
> > > > > >one can call kevent_wait() with $num parameter as zero, which
> > > > > >means that thread does not want any new events, so nothing will be
> > > > > >copied.
> > > > > 
> > > > > This doesn't solve the problem.  You could only request new events when 
> > > > > all previously reported events are processed.  Plus: how do you report 
> > > > > events if the you don't allow get_event pass them on?
> > > > 
> > > > Userspace should itself maintain order and possibility to get event in
> > > > this implementation, kernel just returns events which were requested.
> > > 
> > > That would mean that in a multithreaded application (or multi-processes
> > > sharing the same MAP_SHARED ringbuffer), all threads/processes will be
> > > slowed down to wait for the slowest one.
> > 
> > Not at all - all other threads can call kevent_get_events() with theirs
> > own place in the ring buffer, so while one of them is processing an
> > entry, others can fill next entries.
> 
> eh?  That's not a ringbuffer, and it sounds awfully complex.
> 
> I don't know if this (new?) proposal resolves the
> events-gets-lost-due-to-thread-cancellation problem?  Would need to see
> considerably more detail.

It does - event is copied into shared buffer, but place (or index in the
ring buffer) is selected by userspace (wrapper, glibc, anything).
It is simple and (from my point of view) elegant, but it will not be used - 
I surrender and implement kenelspace ring buffer management right now, I 
just said that it is possible to implement any kind of ring buffer in 
userspace with old kevent_get_events() syscall only.

-- 
	Evgeniy Polyakov
