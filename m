Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTFKR6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbTFKR6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:58:53 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:60623
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262568AbTFKR6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:58:52 -0400
Date: Wed, 11 Jun 2003 20:12:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
Message-ID: <20030611181217.GX26270@dualathlon.random>
References: <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au> <1055194762.23130.370.camel@tiny.suse.com> <20030611003356.GN26270@dualathlon.random> <1055292839.24111.180.camel@tiny.suse.com> <20030611010628.GO26270@dualathlon.random> <1055296630.23697.195.camel@tiny.suse.com> <20030611021030.GQ26270@dualathlon.random> <1055353360.23697.235.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055353360.23697.235.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 01:42:41PM -0400, Chris Mason wrote:
> +		if (q->rq[rw].count >= q->batch_requests) {
> +			smp_mb();
> +			if (waitqueue_active(&q->wait_for_requests[rw]))
> +				wake_up(&q->wait_for_requests[rw]);

in my tree I also changed this to:

				wake_up_nr(&q->wait_for_requests[rw], q->rq[rw].count);

otherwise only one waiter will eat the requests, while multiple waiters
can eat requests in parallel instead because we freed not just 1 request
but many of them.

I wonder if my above change is really the right way to implement the
removal of the _exclusive line that went in rc6. However with your patch
the wake_up_nr (or ~equivalent removal of _exclusive wakeup of rc6)
should mostly improve cpu parallelism in smp and while waiting for I/O,
the amount of stuff in the I/O queue and the overall fariness shouldn't
change very significantly with this new completely fair FIFO request
allocator.

Andrea
