Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWJQOIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWJQOIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWJQOIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:08:11 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:1669 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750993AbWJQOIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:08:10 -0400
Date: Tue, 17 Oct 2006 18:07:40 +0400
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
Message-ID: <20061017140740.GA20686@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <200610171519.37051.dada1@cosmosbay.com> <20061017134206.GC20225@2ka.mipt.ru> <200610171552.35470.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200610171552.35470.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 17 Oct 2006 18:07:41 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 03:52:34PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
> > What about the case, which I described in other e-mail, when in case of
> > the full ring buffer, no new events are written there, and when
> > userspace commits (i.e. marks as ready to be freed or requeued by kernel)
> > some events, new ones will be copied from ready queue into the buffer?
> 
> Then, user might receive 'false events', exactly like poll()/select()/epoll() 
> can do sometime. IE a 'ready' indication while there is no current event 
> available on a particular fd / event_source.

Only if user simultaneously uses oth interfaces and remove even from the
queue when it's copy was in mapped buffer, but in that case it's user's
problem (and if we do want, we can store pointer/index of the ring
buffer entry, so when event is removed from the ready queue (using 
kevent_get_events()), appropriate entry in the ring buffer will be
updated to show that it is no longer valid.

> This should be safe, since those programs already ignore read() 
> returns -EAGAIN and other similar things.
> 
> Programmer prefers to receive two 'event available' indications than ZERO (and 
> be stuck for infinite time). Of course, hot path (normal cases) should return 
> one 'event' only.
> 
> In order words, being ultra fast 99.99 % of the time, but being able to block 
> forever once in a while is not an option.

Have I missed something? It looks like the only problematic situation is
described above when user simultaneously uses both interfaces.

> Eric

-- 
	Evgeniy Polyakov
