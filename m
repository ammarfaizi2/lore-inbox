Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbTFLQDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264872AbTFLQDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:03:49 -0400
Received: from static-ctb-203-29-86-193.webone.com.au ([203.29.86.193]:10756
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264832AbTFLQDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:03:48 -0400
Message-ID: <3EE8A74E.9040400@cyberone.com.au>
Date: Fri, 13 Jun 2003 02:16:14 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
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
References: <1055356032.24111.240.camel@tiny.suse.com>	 <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au>	 <20030612012951.GG1500@dualathlon.random>	 <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au>	 <20030612024608.GE1415@dualathlon.random>	 <3EE7EA4A.5030105@cyberone.com.au>	 <20030612025812.GF1415@dualathlon.random> <3EE7EDBB.70608@cyberone.com.au>	 <20030612031238.GA1571@dualathlon.random>	 <3EE7F18C.3010502@cyberone.com.au> <1055434002.23697.431.camel@tiny.suse.com>
In-Reply-To: <1055434002.23697.431.camel@tiny.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

>On Wed, 2003-06-11 at 23:20, Nick Piggin wrote:
>
>
>>I think the cpu utilization gain of waking a number of tasks
>>at once would be outweighed by advantage of waking 1 task
>>and not putting it to sleep again for a number of requests.
>>You obviously are not claiming concurrency improvements, as
>>your method would also increase contention on the io lock
>>(or the queue lock in 2.5).
>>
>
>I've been trying variations on this for a few days, none have been
>thrilling but the end result is better dbench and iozone throughput
>overall.  For the 20 writer iozone test, rc7 got an average throughput
>of 3MB/s, and yesterdays latency patch got 500k/s or so.  Ouch.
>
>This gets us up to 1.2MB/s.  I'm keeping yesterday's
>get_request_wait_wake, which wakes up a waiter instead of unplugging.
>
>The basic idea here is that after a process is woken up and grabs a
>request, he becomes the batch owner.  Batch owners get to ignore the
>q->full flag for either 1/5 second or 32 requests, whichever comes
>first.  The timer part is an attempt at preventing memory pressure
>writers (who go 1 req at a time) from holding onto batch ownership for
>too long.  Latency stats after dbench 50:
>

Yeah, I get ~50% more throughput and up to 20% better CPU
efficiency on tiobench 256 for sequential and random
writers by doing something similar.


