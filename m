Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTFLA7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbTFLA7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:59:35 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:9908 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S264647AbTFLA7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:59:33 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <3EE7D1AA.30701@cyberone.com.au>
References: <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <20030611003356.GN26270@dualathlon.random>
	 <1055292839.24111.180.camel@tiny.suse.com>
	 <20030611010628.GO26270@dualathlon.random>
	 <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
	 <1055353360.23697.235.camel@tiny.suse.com>
	 <20030611181217.GX26270@dualathlon.random>
	 <1055356032.24111.240.camel@tiny.suse.com>
	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1055380331.23697.299.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jun 2003 21:12:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 21:04, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >On Wed, Jun 11, 2003 at 02:27:13PM -0400, Chris Mason wrote:
> >
> >>On Wed, 2003-06-11 at 14:12, Andrea Arcangeli wrote:
> >>
> >>>On Wed, Jun 11, 2003 at 01:42:41PM -0400, Chris Mason wrote:
> >>>
> >>>>+		if (q->rq[rw].count >= q->batch_requests) {
> >>>>+			smp_mb();
> >>>>+			if (waitqueue_active(&q->wait_for_requests[rw]))
> >>>>+				wake_up(&q->wait_for_requests[rw]);
> >>>>
> >>>in my tree I also changed this to:
> >>>
> >>>				wake_up_nr(&q->wait_for_requests[rw], q->rq[rw].count);
> >>>
> >>>otherwise only one waiter will eat the requests, while multiple waiters
> >>>can eat requests in parallel instead because we freed not just 1 request
> >>>but many of them.
> >>>
> >>I tried a few variations of this yesterday and they all led to horrible
> >>latencies, but I couldn't really explain why.  I had a bunch of other
> >>
> >
> >the I/O latency in theory shouldn't change, we're not reordering the
> >queue at all, they'll go to sleep immediatly again if __get_request
> >returns null.
> >
> 
> And go to the end of the queue?
> 

This got dragged into private mail for a few messages, but we figured
out the problem turns into scheduling fairness with wake_up_nr()

32 procs might get woken, but when the first of those procs gets a
request, he'll wake another, and so on.  But there's no promise that
getting woken fairly means you'll get scheduled fairly, so you might not
get scheduled in for quite a while, perhaps even after new requests have
gone onto the wait queue and gotten woken up.

The real problem is get_request_wait_wakeup, andrea is working on a few
changes to that.  

-chris

