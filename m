Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTFJAOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 20:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTFJAOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 20:14:22 -0400
Received: from 216-42-72-151.ppp.netsville.net ([216.42.72.151]:63144 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S262320AbTFJAOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 20:14:21 -0400
Subject: Re: [PATCH] io stalls (was: -rc7   Re: Linux 2.4.21-rc6)
From: Chris Mason <mason@suse.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <20030609221950.GF26270@dualathlon.random>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
	 <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de>
	 <200306041246.21636.m.c.p@wolk-project.de>
	 <20030604104825.GR3412@x30.school.suse.de>
	 <3EDDDEBB.4080209@cyberone.com.au>
	 <1055194762.23130.370.camel@tiny.suse.com>
	 <20030609221950.GF26270@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1055204844.23132.399.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 09 Jun 2003 20:27:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 18:19, Andrea Arcangeli wrote:

> > Anyway, less talk, more code.  Treat this with care, it has only been
> > lightly tested.  Thanks to Andrea and Nick whose patches this is largely
> > based on:
> 
> I spent last Saturday working on this too. This is the status of my
> current patches, would be interesting to compare them. they're not very
> well tested yet though.
> 

I'll try to get some numbers in the morning.

> They would obsoletes the old fix-pausing and the old elevator-lowlatency
> (I was going to release a new tree today, but I delayed it so I fixed
> uml today too first [tested with skas and w/o skas]).
> 
> those backout the rc7 interactivity changes (the only one that wasn't in
> my tree was the add_wait_queue_exclusive, that IMHO would better stay
> for scalability reasons).
> 

I didn't test without _exlusive for the final iteration of my patch, but
in all the early ones using _exclusive improve latencies.  I think
people are reporting otherwise because they have hit the sweet spot for
number of procs going after the requests.  With _exclusive they have a
higher chance of getting starved by a new process coming in, without the
_exclusive, each waiter has a fighting chance of getting to the free
request on their own.  Hopefully we can do better with the _exclusive,
it does seem to scale much better.

Aside from the io in flight calculations, the major difference between
our patches is in __get_request_wait.  Once a process waits once, that
call to __get_request_wait ignores q->full in my code.

I found the q->full checks did help, but as you increased the number of
concurrent readers/writers things broke down to the old high latencies. 
By delaying the point where q->full was cleared, I could make the
latency benefit last for a higher number of procs.  Finally I gave up
and left it set until all the waiters were gone, which seems to have the
most consistent results.

The interesting part was it didn't seem to change the hit in
throughput.  The cost was about the same between the original patch and
my final one, but I need to test more.

-chris


