Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTF0JcQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 05:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264099AbTF0JcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 05:32:16 -0400
Received: from dialup-25.157.221.203.acc50-nort-cbr.comindico.com.au ([203.221.157.25]:16132
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264097AbTF0JcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 05:32:14 -0400
Message-ID: <3EFC122F.3090406@cyberone.com.au>
Date: Fri, 27 Jun 2003 19:45:19 +1000
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
References: <1055296630.23697.195.camel@tiny.suse.com>	 <20030611021030.GQ26270@dualathlon.random>	 <1055353360.23697.235.camel@tiny.suse.com>	 <20030611181217.GX26270@dualathlon.random>	 <1055356032.24111.240.camel@tiny.suse.com>	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>	 <20030612012951.GG1500@dualathlon.random>	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>	 <20030612024608.GE1415@dualathlon.random>	 <1056567822.10097.133.camel@tiny.suse.com>	 <3EFA8920.8050509@cyberone.com.au>	 <1056628116.20899.28.camel@tiny.suse.com>	 <3EFAEF71.1080109@cyberone.com.au>	 <1056642911.20899.88.camel@tiny.suse.com>	 <3EFB9C0C.9000600@cyberone.com.au> <1056677984.20904.181.camel@tiny.suse.com>
In-Reply-To: <1056677984.20904.181.camel@tiny.suse.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>On Thu, 2003-06-26 at 21:21, Nick Piggin wrote:
>
>
>>>Very true.  But get_request latency is the minimum amount of time a
>>>single read is going to wait (in 2.4.x anyway), and that is what we need
>>>to focus on when we're trying to fix interactive performance.
>>>
>>>
>>The read situation is different to write. To fill the read queue,
>>you need queue_nr_requests / 2-3 (for readahead) reading processes
>>to fill the queue, more if the reads are random.
>>If this kernel is being used interactively, its not our fault we
>>might not give quite as good interactive performance. I'm sure
>>the fileserver admin would rather take the tripled bandwidth ;)
>>
>>That said, I think a lot of interactive programs will want to do
>>more than 1 request at a time anyway.
>>
>>
>
>My intuition agrees with yours, but if this is true then andrea's old
>elevator-lowlatency patch alone is enough, and we don't need q->full at
>all.  Users continued to complain of bad latencies even with his code
>applied.
>

Didn't that still have the starvation issues in get_request that
my patch addressed though? This batching is needed due to the
strict FIFO behaviour that my "q->full" thing did.

>
>>From a practical point of view his old code is the same as the batch
>wakeup code for get_request latencies and provides good throughput. 
>There are a few cases where batch wakeup has shorter overall latencies,
>but I don't think people were in those heavy workloads while they were
>complaining of stalls in -aa.
>
>
>>>>Second, mergeable doesn't mean anything if your request size only
>>>>grows to say 128KB (IDE). I saw tiobench 256 sequential writes on IDE
>>>>go from ~ 25% peak throughput to ~70% (4.85->14.11 from 20MB/s disk)
>>>>
>>>>
>>>Well, play around with raw io, my box writes at roughly disk speed with
>>>128k synchronous requests (contiguous writes).
>>>
>>>
>>Yeah, I'm not talking about request overhead - I think a 128K sized
>>request is just fine. But when there are 256 threads writing, with
>>FIFO method, 128 threads will each have 1 request in the queue. If
>>they are sequential writers, each request will probably be 128K.
>>That isn't enough to get good disk bandwidth. The elevator _has_ to
>>make a suboptimal decision.
>>
>>With batching, say 8 processes have 16 sequential requests on the
>>queue each. The elevator can make good choices.
>>
>
>I agree here too, it just doesn't match the user reports we've been
>getting in 2.4 ;-)  If 2.5 can dynamically allocate requests now and
>then you can get much better results with io contexts/dynamic wakeups,
>but I can't see how to make it work in 2.4 without larger backports.
>
>So, the way I see things, we've got a few choices.
>
>1) do nothing.  2.6 isn't that far off.
>
>2) add elevator-lowlatency without q->full.  It solves 90% of the
>problem
>
>3) add q->full as well and make it the default.  Great latencies, not so
>good throughput.  Add userland tunables so people can switch.
>
>4) back port some larger chunk of 2.5 and find a better overall
>solution.
>
>I vote for #3, don't care much if q->full is on or off by default, as
>long as we make an easy way for people to set it.
>

5) include the "q->full" starvation fix; add the concept of a
   queue owner, the batching process.

I'm a bit busy at the moment and so I won't test this, unfortunately.
I would prefer that if something like #5 doesn't get in, then nothing
be done for .22 unless its backed up by a few decent benchmarks. But
its not my call anyway.

Cheers,
Nick


