Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbTFLEDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 00:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbTFLEDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 00:03:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42119
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264734AbTFLEDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 00:03:00 -0400
Date: Thu, 12 Jun 2003 06:17:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
Message-ID: <20030612041723.GD1571@dualathlon.random>
References: <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au> <20030612024608.GE1415@dualathlon.random> <3EE7EA4A.5030105@cyberone.com.au> <20030612025812.GF1415@dualathlon.random> <3EE7EDBB.70608@cyberone.com.au> <20030612031238.GA1571@dualathlon.random> <3EE7F18C.3010502@cyberone.com.au> <20030612033342.GC1571@dualathlon.random> <3EE7F7F4.1040800@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE7F7F4.1040800@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 01:48:04PM +1000, Nick Piggin wrote:
> 
> 
> Andrea Arcangeli wrote:
> 
> >On Thu, Jun 12, 2003 at 01:20:44PM +1000, Nick Piggin wrote:
> >
> >>Its no less fair this way, tasks will still be woken in fifo
> >>order. They will just be given the chance to submit a batch
> >>of requests.
> >>
> >
> >If you change the behaviour with queued_task_nr > batch_requests it is
> >less fair period. Whatever else thing I don't care about right now
> >because it is a minor cpu improvement anyways.
> >
> >I'm not talking about performance, I'm talking about latency and
> >fariness only. This is the whole point of the ->full logic.
> >
> 
> I say each task getting 8 requests at a time is as fair
> as each getting 1 request at a time. Yes, you may get a
> worse latency, but _fairness_ is the same.

It is the worse latency that is the problem of course.  Fariness in this
case isn't affected (assuming you would write the batch_sectors fair),
but latency would definitely be affected.

> Well I'm not so sure that your method will do a great deal
> of good. On SMP you would increase contention on the spinlock.
> IMO it would be better to serialise them on the waitqueue
> instead of a spinlock seeing as they are already sleeping.

I think the worse part is the cacheline bouncing, but that might happen
anyways under load. at least certainly it makes sense for UP or if
you're lucky and the tasks run serially (possible if all cpus are
running).

> I think we'll just have to agree to disagree here. This
> sort of thing came up in our CFQ discussion as well. Its
> not that I think your way is without merits, but I think
> in an overload situtation its a better aim to attempt to
> keep throughput up rather than attempt to provide the
> lowest possible latency.

Those changes (like the CFQ I/O scheduler in 2.5) are being developed
mostly due the latency complains we get as feedback on l-k. That's why
I care about latency first here. But we've to care about throughput too
of course. This isn't CFQ, it just tries to provide new requests to
different tasks with the minimal possible latency which in turn also
guarantees fariness. That sounds a good default to me, especially when I
see the removal of the _exclusive wakeup in mainline taken as a major
fariness/latency improvement.

Andrea
