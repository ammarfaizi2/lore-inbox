Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTF0BSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 21:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTF0BSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 21:18:00 -0400
Received: from static-ctb-203-29-86-142.webone.com.au ([203.29.86.142]:37636
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263239AbTF0BR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 21:17:57 -0400
Message-ID: <3EFB9C0C.9000600@cyberone.com.au>
Date: Fri, 27 Jun 2003 11:21:16 +1000
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
References: <1055296630.23697.195.camel@tiny.suse.com>	 <20030611021030.GQ26270@dualathlon.random>	 <1055353360.23697.235.camel@tiny.suse.com>	 <20030611181217.GX26270@dualathlon.random>	 <1055356032.24111.240.camel@tiny.suse.com>	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>	 <20030612012951.GG1500@dualathlon.random>	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>	 <20030612024608.GE1415@dualathlon.random>	 <1056567822.10097.133.camel@tiny.suse.com>	 <3EFA8920.8050509@cyberone.com.au>	 <1056628116.20899.28.camel@tiny.suse.com>	 <3EFAEF71.1080109@cyberone.com.au> <1056642911.20899.88.camel@tiny.suse.com>
In-Reply-To: <1056642911.20899.88.camel@tiny.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>On Thu, 2003-06-26 at 09:04, Nick Piggin wrote:
>
>
>>>One of the things I tried in this area was basically queue ownership. 
>>>When each process woke up, he was given strict ownership of the queue
>>>and could submit up to N number of requests.  One process waited for
>>>ownership in a yield loop for a max limit of a certain number of
>>>jiffies, all the others waited on the request queue.
>>>
>>>
>>Not sure exactly what you mean by one process waiting for ownership
>>in a yield loop, but why don't you simply allow the queue "owner" to
>>submit up to a maximum of N requests within a time limit. Once either
>>limit expires (or, rarely, another might become owner -) the process
>>would just be put to sleep by the normal queue_full mechanism.
>>
>>
>
>You need some way to wakeup the queue after that time limit has expired,
>in case the owner never submits another request.  This can either be a
>timer or a process in a yield loop.  Given that very short expire time I
>set (10 jiffies), I went for the yield loop.
>
>
>>>It generally increased the latency in __get_request wait by a multiple
>>>of N.  I didn't keep it because the current patch is already full of
>>>subtle interactions, I didn't want to make things more confusing than
>>>they already were ;-)
>>>
>>>
>>Yeah, something like that. I think that in a queue full situation,
>>the processes are wanting to submit more than 1 request though. So
>>the better thoughput you can achieve by batching translates to
>>better effective throughput. Read my recent debate with Andrea
>>about this though - I couldn't convince him!
>>
>>
>
>Well, it depends ;-) I think we've got 3 basic kinds of procs during a
>q->full condition:
>
>1) wants to submit lots of somewhat contiguous io
>2) wants to submit a single io
>3) wants to submit lots of random io
>
>>From a throughput point of view, we only care about giving batch
>ownership to #1.  giving batch ownership to #3 will help reduce context
>switches, but if it helps throughput than the io wasn't really random
>(you've got a good point about locality below, drive write caches make a
>huge difference there).
>
>The problem I see in 2.4 is the elevator can't tell any of these cases
>apart, so any attempt at batch ownership is certain to be wrong at least
>part of the time.
>

I think though, for fairness, if we allow one to submit a batch
of requests, we have to give that opportunity to the others.
And yeah, it does reduce context switches, and it does improve
throughput for "random" localised IO.

>
>
>>I have seen much better maximum latencies, 2-3 times the
>>throughput, and an order of magnitude less context switching on
>>many threaded tiobench write loads when using batching.
>>
>>In short, measuring get_request latency won't give you the full
>>story.
>>
>>
>
>Very true.  But get_request latency is the minimum amount of time a
>single read is going to wait (in 2.4.x anyway), and that is what we need
>to focus on when we're trying to fix interactive performance.
>

The read situation is different to write. To fill the read queue,
you need queue_nr_requests / 2-3 (for readahead) reading processes
to fill the queue, more if the reads are random.
If this kernel is being used interactively, its not our fault we
might not give quite as good interactive performance. I'm sure
the fileserver admin would rather take the tripled bandwidth ;)

That said, I think a lot of interactive programs will want to do
more than 1 request at a time anyway.

>
>>>The real problem with this approach is that we're guessing about the
>>>number of requests a given process wants to submit, and we're assuming
>>>those requests are going to be highly mergable.  If the higher levels
>>>pass these hints down to the elevator, we should be able to do a better
>>>job of giving both low latency and high throughput.
>>>
>>>
>>No, the numbers (batch # requests, batch time) are not highly scientific.
>>Simply when a process wakes up, we'll let them submit a small burst of
>>requests before they go back to sleep. Now in 2.5 (mm) we can cheat and
>>make this more effective, fair, and without possible missed wakes because
>>io contexts means that multiple processes can be batching at the same
>>time, and dynamically allocated requests means it doesn't matter if we
>>go a bit over the queue limit.
>>
>>
>
>I agree 2.5 has a lot more room for the contexts to be effective, and I
>think they are a really good idea.
>
>
>>I think a decent solution for 2.4 would be to simply have the one queue
>>owner, but he allowed the queue to fall below the batch limit, wake
>>someone else and make them the owner. It can be a bit less fair, and
>>it doesn't work across queues, but they're less important cases.
>>
>>
>>>Between bios and the pdflush daemons, I think 2.5 is in pretty good
>>>shape to do what we need.  I'm not 100% sure we need batching when the
>>>requests being submitted are not highly mergable, but I haven't put lots
>>>of thought into that part yet.
>>>
>>>
>>No, there are a couple of problems here.
>>First, good locality != sequential. I saw tiobench 256 random write
>>throughput _doubled_ because each process is writing within its own
>>file.
>>
>>Second, mergeable doesn't mean anything if your request size only
>>grows to say 128KB (IDE). I saw tiobench 256 sequential writes on IDE
>>go from ~ 25% peak throughput to ~70% (4.85->14.11 from 20MB/s disk)
>>
>
>Well, play around with raw io, my box writes at roughly disk speed with
>128k synchronous requests (contiguous writes).
>

Yeah, I'm not talking about request overhead - I think a 128K sized
request is just fine. But when there are 256 threads writing, with
FIFO method, 128 threads will each have 1 request in the queue. If
they are sequential writers, each request will probably be 128K.
That isn't enough to get good disk bandwidth. The elevator _has_ to
make a suboptimal decision.

With batching, say 8 processes have 16 sequential requests on the
queue each. The elevator can make good choices.


