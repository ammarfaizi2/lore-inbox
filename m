Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbTFZMvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 08:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265579AbTFZMvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 08:51:21 -0400
Received: from static-ctb-210-9-247-235.webone.com.au ([210.9.247.235]:64781
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S265585AbTFZMvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 08:51:18 -0400
Message-ID: <3EFAEF71.1080109@cyberone.com.au>
Date: Thu, 26 Jun 2003 23:04:49 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
References: <1055296630.23697.195.camel@tiny.suse.com>	 <20030611021030.GQ26270@dualathlon.random>	 <1055353360.23697.235.camel@tiny.suse.com>	 <20030611181217.GX26270@dualathlon.random>	 <1055356032.24111.240.camel@tiny.suse.com>	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>	 <20030612012951.GG1500@dualathlon.random>	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>	 <20030612024608.GE1415@dualathlon.random>	 <1056567822.10097.133.camel@tiny.suse.com>	 <3EFA8920.8050509@cyberone.com.au> <1056628116.20899.28.camel@tiny.suse.com>
In-Reply-To: <1056628116.20899.28.camel@tiny.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>On Thu, 2003-06-26 at 01:48, Nick Piggin wrote:
>
>
>>I am hoping to go a slightly different way in 2.5 pending
>>inclusion of process io contexts. If you had time to look
>>over my changes there (in current mm tree) it would be
>>appreciated, but they don't help your problem for 2.4.
>>
>>I found that my queue full fairness for 2.4 didn't address
>>the batching issue well. It does, guarantee lowest possible
>>maximum latency for singular requests, but due to lowered
>>throughput this can cause worse "high level" latency.
>>
>>I couldn't find a really good, comprehensive method of
>>allowing processes to batch without resorting to very
>>complex wakeup methods unless process io contexts are used.
>>The other possibility would be to keep a list of "batching"
>>processes which should achieve the same as io contexts.
>>
>>An easier approach would be to just allow the last woken
>>process to submit a batch of requests. This wouldn't have
>>as good guaranteed fairness, but not to say that it would
>>have starvation issues. I'll help you implement it if you
>>are interested.
>>
>
>One of the things I tried in this area was basically queue ownership. 
>When each process woke up, he was given strict ownership of the queue
>and could submit up to N number of requests.  One process waited for
>ownership in a yield loop for a max limit of a certain number of
>jiffies, all the others waited on the request queue.
>

Not sure exactly what you mean by one process waiting for ownership
in a yield loop, but why don't you simply allow the queue "owner" to
submit up to a maximum of N requests within a time limit. Once either
limit expires (or, rarely, another might become owner -) the process
would just be put to sleep by the normal queue_full mechanism.

>
>It generally increased the latency in __get_request wait by a multiple
>of N.  I didn't keep it because the current patch is already full of
>subtle interactions, I didn't want to make things more confusing than
>they already were ;-)
>

Yeah, something like that. I think that in a queue full situation,
the processes are wanting to submit more than 1 request though. So
the better thoughput you can achieve by batching translates to
better effective throughput. Read my recent debate with Andrea
about this though - I couldn't convince him!

I have seen much better maximum latencies, 2-3 times the
throughput, and an order of magnitude less context switching on
many threaded tiobench write loads when using batching.

In short, measuring get_request latency won't give you the full
story.

>
>The real problem with this approach is that we're guessing about the
>number of requests a given process wants to submit, and we're assuming
>those requests are going to be highly mergable.  If the higher levels
>pass these hints down to the elevator, we should be able to do a better
>job of giving both low latency and high throughput.
>

No, the numbers (batch # requests, batch time) are not highly scientific.
Simply when a process wakes up, we'll let them submit a small burst of
requests before they go back to sleep. Now in 2.5 (mm) we can cheat and
make this more effective, fair, and without possible missed wakes because
io contexts means that multiple processes can be batching at the same
time, and dynamically allocated requests means it doesn't matter if we
go a bit over the queue limit.

I think a decent solution for 2.4 would be to simply have the one queue
owner, but he allowed the queue to fall below the batch limit, wake
someone else and make them the owner. It can be a bit less fair, and
it doesn't work across queues, but they're less important cases.

>
>Between bios and the pdflush daemons, I think 2.5 is in pretty good
>shape to do what we need.  I'm not 100% sure we need batching when the
>requests being submitted are not highly mergable, but I haven't put lots
>of thought into that part yet.
>

No, there are a couple of problems here.
First, good locality != sequential. I saw tiobench 256 random write
throughput _doubled_ because each process is writing within its own
file.

Second, mergeable doesn't mean anything if your request size only
grows to say 128KB (IDE). I saw tiobench 256 sequential writes on IDE
go from ~ 25% peak throughput to ~70% (4.85->14.11 from 20MB/s disk)

Third, context switch rate. In the latest IBM regression tests,
tiobench 64 on ext2, 8xSMP (so don't look at throughput!), average
cs/s was about 2500 with mainline (FIFO request allocation), and
140 in mm (batching allocation). So nearly 20x better. This might
not be due to batching alone, but I didn't see any other obvious
change in mm.

>
>Anyway for 2.4 I'm not sure there's much more we can do.  I'd like to
>add tunables to the current patch, so userland can control the max io in
>flight and a simple toggle between throughput mode and latency mode on a
>per device basis.  It's not perfect but should tide us over until 2.6.
>
>

The changes do seem to be a critical fix due to the starvation issue,
but I'm worried that they take a big step back in performance under
high disk load. I found my FIFO mechanism to be unacceptably slow for
2.5.



