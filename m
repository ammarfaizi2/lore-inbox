Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264689AbTFLC6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264691AbTFLC6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:58:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45184
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264689AbTFLC6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:58:11 -0400
Date: Thu, 12 Jun 2003 05:12:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
Message-ID: <20030612031238.GA1571@dualathlon.random>
References: <1055356032.24111.240.camel@tiny.suse.com> <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au> <20030612012951.GG1500@dualathlon.random> <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au> <20030612024608.GE1415@dualathlon.random> <3EE7EA4A.5030105@cyberone.com.au> <20030612025812.GF1415@dualathlon.random> <3EE7EDBB.70608@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE7EDBB.70608@cyberone.com.au>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 01:04:27PM +1000, Nick Piggin wrote:
> 
> 
> Andrea Arcangeli wrote:
> 
> >On Thu, Jun 12, 2003 at 12:49:46PM +1000, Nick Piggin wrote:
> >
> >>
> >>Andrea Arcangeli wrote:
> >>
> >>>it does nothing w/ _exclusive and w/o the wake_up_nr, that's why I added
> >>>the wake_up_nr.
> >>>
> >>>
> >>>
> >>That is pretty pointless as well. You might as well just start
> >>waking up at the queue full limit, and wake one at a time.
> >>
> >>The purpose for batch_requests was I think for devices with a
> >>very small request size, to reduce context switches.
> >>
> >
> >batch_requests at least in my tree matters only when each request is
> >512btyes and you've some thousand of them to compose a 4M queue or so.
> >To maximize cpu cache usage etc.. I try to wakeup a task every 512bytes
> >written, but every 32*512bytes written or so. Of course w/o the
> >wake_up_nr that I added, that wasn't really working w/ the _exlusive
> >wakeup.
> >
> >if you check my tree you'll see that for sequential I/O with 512k in
> >each request (not 512bytes!) batch_requests is already a noop.
> >
> 
> 
> You are waking up multiple tasks which will each submit
> 1 request. You want to be waking up 1 task which will
> submit multiple requests - that is how you will save
> context switches, cpu cache, etc, and that task's requests
> will have a much better chance of being merged, or at
> least serviced as a nice batch than unrelated tasks.

for fairness reasons if there are multiple tasks, I want to wake them
all and let the others be able to eat requests before the first
allocates all the batch_sectors. So the current code is fine and
batch_sectors still works fine with multiple tasks queued in the
waitqueue, it still makes sense to wake more than one of them at the
same time to improve cpu utilization (regardless they're different
tasks, for istance we take less frequently the waitqueue spinlocks
etc..).

What we disabled is only the batch_sectors in function of the single
task, so if for example there's just 1 single task, we could let it go,
but it's quite a special case, if for example there would be two tasks,
we wouldn't want to let them go ahead (unless we can distributed exactly
count/2 requests to each task w/o reentering into __get_request_wait
that's unlikely). So the current code looks ok to me with the
wake_up_nr to take advantage of the batch_sectors against different
tasks, still w/o penalizing fariness.

Andrea
