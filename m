Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTFKSOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 14:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTFKSOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 14:14:11 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:8115 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S263407AbTFKSOG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 14:14:06 -0400
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030611181217.GX26270@dualathlon.random>
References: <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <20030611003356.GN26270@dualathlon.random>
	 <1055292839.24111.180.camel@tiny.suse.com>
	 <20030611010628.GO26270@dualathlon.random>
	 <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
	 <1055353360.23697.235.camel@tiny.suse.com>
	 <20030611181217.GX26270@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1055356032.24111.240.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jun 2003 14:27:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 14:12, Andrea Arcangeli wrote:
> On Wed, Jun 11, 2003 at 01:42:41PM -0400, Chris Mason wrote:
> > +		if (q->rq[rw].count >= q->batch_requests) {
> > +			smp_mb();
> > +			if (waitqueue_active(&q->wait_for_requests[rw]))
> > +				wake_up(&q->wait_for_requests[rw]);
> 
> in my tree I also changed this to:
> 
> 				wake_up_nr(&q->wait_for_requests[rw], q->rq[rw].count);
> 
> otherwise only one waiter will eat the requests, while multiple waiters
> can eat requests in parallel instead because we freed not just 1 request
> but many of them.

I tried a few variations of this yesterday and they all led to horrible
latencies, but I couldn't really explain why.  I had a bunch of other
stuff in at the time to try and improve throughput though, so I'll try
it again.

I think part of the problem is the cascading wakeups from
get_request_wait_wakeup().  So if we wakeup 32 procs they in turn wakeup
another 32, etc.

-chris


