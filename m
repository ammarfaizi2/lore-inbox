Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTLUOPS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 09:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbTLUOPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 09:15:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:46471 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263002AbTLUOPN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 09:15:13 -0500
Date: Sun, 21 Dec 2003 14:14:56 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Message-ID: <20031221141456.GI3438@mail.shareable.org>
References: <3FE492EF.2090202@colorfullife.com> <20031221113640.GF3438@mail.shareable.org> <3FE594D0.8000807@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE594D0.8000807@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> >What about killing fasync_helper altogether and using the method that
> >epoll uses to register "listeners" which send a signal when the poll
> >state of a device changes?
> >
> I think it would be a step in the wrong direction: poll should go away 
> from a simple wake-up to an interface that transfers the band info 
> (POLL_IN, POLL_OUT, etc). Right now at least two passes over the f_poll 
> functions are necessary, because the info which event actually triggered 
> is lost. kill_fasync transfers the band info, thus I don't want to 
> remove it.

I agree with the principle of the poll wakeup passing the event
information to the wakeup function - that would make select, poll,
epoll _and_ this new version of fsync faster.  That may be easier to
implement now than it was in 2.4, because we have wakeup functions,
although it is still a big change and it would be hard to get right in
some drivers.  Perhaps very hard.

We have found the performance impact of the extra ->poll calls
negligable with epoll.  They're simply not slow calls.  It's
only when you're doing select() or poll() of many descriptors
repeatedly that you notice, and that's already poor usage in other
ways.

So I am not convinced that such an invasive change is worthwhile,
particularly as drivers would become more complicated.  (Those drivers
which already call kill_fasync have the right logic, assuming there
are no bugs, but many don't and a big ->poll interface change implies they
all have to have it).

> It's a good idea, but requires lots of changes - perhaps it will be 
> necessary to change the pollwait and f_poll prototypes.

However, the two changes: fasync -> eventpoll-like waiter, and poll ->
fewer function calls are really quite orthogonal.

The fasync change is best done separately, with no changes to pollwait
and f_poll and virtually no changes to the drivers except to remove
calls to kill_fasync.

I don't think you need to change pollwait or ->poll, because the band
information for the signal is available, as you say, by calling ->poll
after the wakeup.

Put it this way: Davide thought epoll needed special hooks in all the
devices, until I convinced him they weren't needed.  He tried it and
not only did all the hooks go away, epoll became simpler and smaller,
it worked with every pollable fd instead of just the ones useful for
web servers, and surprisingly ran a bit faster too.

-- Jamie

