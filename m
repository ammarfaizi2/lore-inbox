Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265565AbTFZLfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 07:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265566AbTFZLfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 07:35:08 -0400
Received: from 216-42-72-146.ppp.netsville.net ([216.42.72.146]:36234 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S265565AbTFZLfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 07:35:01 -0400
Subject: Re: [PATCH] io stalls
From: Chris Mason <mason@suse.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
In-Reply-To: <3EFA8920.8050509@cyberone.com.au>
References: <1055296630.23697.195.camel@tiny.suse.com>
	 <20030611021030.GQ26270@dualathlon.random>
	 <1055353360.23697.235.camel@tiny.suse.com>
	 <20030611181217.GX26270@dualathlon.random>
	 <1055356032.24111.240.camel@tiny.suse.com>
	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>
	 <20030612012951.GG1500@dualathlon.random>
	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>
	 <20030612024608.GE1415@dualathlon.random>
	 <1056567822.10097.133.camel@tiny.suse.com>
	 <3EFA8920.8050509@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1056628116.20899.28.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Jun 2003 07:48:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-26 at 01:48, Nick Piggin wrote:

> I am hoping to go a slightly different way in 2.5 pending
> inclusion of process io contexts. If you had time to look
> over my changes there (in current mm tree) it would be
> appreciated, but they don't help your problem for 2.4.
> 
> I found that my queue full fairness for 2.4 didn't address
> the batching issue well. It does, guarantee lowest possible
> maximum latency for singular requests, but due to lowered
> throughput this can cause worse "high level" latency.
> 
> I couldn't find a really good, comprehensive method of
> allowing processes to batch without resorting to very
> complex wakeup methods unless process io contexts are used.
> The other possibility would be to keep a list of "batching"
> processes which should achieve the same as io contexts.
> 
> An easier approach would be to just allow the last woken
> process to submit a batch of requests. This wouldn't have
> as good guaranteed fairness, but not to say that it would
> have starvation issues. I'll help you implement it if you
> are interested.

One of the things I tried in this area was basically queue ownership. 
When each process woke up, he was given strict ownership of the queue
and could submit up to N number of requests.  One process waited for
ownership in a yield loop for a max limit of a certain number of
jiffies, all the others waited on the request queue.

It generally increased the latency in __get_request wait by a multiple
of N.  I didn't keep it because the current patch is already full of
subtle interactions, I didn't want to make things more confusing than
they already were ;-)

The real problem with this approach is that we're guessing about the
number of requests a given process wants to submit, and we're assuming
those requests are going to be highly mergable.  If the higher levels
pass these hints down to the elevator, we should be able to do a better
job of giving both low latency and high throughput.

Between bios and the pdflush daemons, I think 2.5 is in pretty good
shape to do what we need.  I'm not 100% sure we need batching when the
requests being submitted are not highly mergable, but I haven't put lots
of thought into that part yet.

Anyway for 2.4 I'm not sure there's much more we can do.  I'd like to
add tunables to the current patch, so userland can control the max io in
flight and a simple toggle between throughput mode and latency mode on a
per device basis.  It's not perfect but should tide us over until 2.6.

-chris


