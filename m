Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264612AbTFLDer (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 23:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbTFLDer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 23:34:47 -0400
Received: from dyn-ctb-210-9-241-68.webone.com.au ([210.9.241.68]:48900 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264612AbTFLDep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 23:34:45 -0400
Message-ID: <3EE7F7F4.1040800@cyberone.com.au>
Date: Thu, 12 Jun 2003 13:48:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Chris Mason <mason@suse.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: [PATCH] io stalls
References: <3EE7D1AA.30701@cyberone.com.au> <20030612012951.GG1500@dualathlon.random> <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au> <20030612024608.GE1415@dualathlon.random> <3EE7EA4A.5030105@cyberone.com.au> <20030612025812.GF1415@dualathlon.random> <3EE7EDBB.70608@cyberone.com.au> <20030612031238.GA1571@dualathlon.random> <3EE7F18C.3010502@cyberone.com.au> <20030612033342.GC1571@dualathlon.random>
In-Reply-To: <20030612033342.GC1571@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>On Thu, Jun 12, 2003 at 01:20:44PM +1000, Nick Piggin wrote:
>
>>Its no less fair this way, tasks will still be woken in fifo
>>order. They will just be given the chance to submit a batch
>>of requests.
>>
>
>If you change the behaviour with queued_task_nr > batch_requests it is
>less fair period. Whatever else thing I don't care about right now
>because it is a minor cpu improvement anyways.
>
>I'm not talking about performance, I'm talking about latency and
>fariness only. This is the whole point of the ->full logic.
>

I say each task getting 8 requests at a time is as fair
as each getting 1 request at a time. Yes, you may get a
worse latency, but _fairness_ is the same.

>
>>I think the cpu utilization gain of waking a number of tasks
>>at once would be outweighed by advantage of waking 1 task
>>and not putting it to sleep again for a number of requests.
>>You obviously are not claiming concurrency improvements, as
>>your method would also increase contention on the io lock
>>(or the queue lock in 2.5).
>>
>
>I'm claiming that with queued_task_nr > batch_requests the
>batch_requests logic still has a chance to save some cpu, this is the
>only reason I didn't nuke it completely as you suggested some email ago.
>

Well I'm not so sure that your method will do a great deal
of good. On SMP you would increase contention on the spinlock.
IMO it would be better to serialise them on the waitqueue
instead of a spinlock seeing as they are already sleeping.

>
>>Then you have the cache gains of running each task for a
>>longer period of time. You also get possible IO scheduling
>>improvements.
>>
>>Consider 8 requests, batch_requests at 4, 10 tasks writing
>>to different areas of disk.
>>
>>Your method still only allows each task to have 1 request in
>>the elevator at once. Mine allows each to have a run of 4
>>requests in the elevator.
>>
>
>I definitely want 1 request in the elevator at once or we can as well
>drop your ->full and return to be unfair. The whole point of ->full is
>to get the total fariness, across the tasks in the queue queue, and for
>tasks outside the queue calling get_request too. Since not all tasks
>will fit in the I/O queue, providing a very fair FIFO in the
>wait_for_request is fundamental to provide any sort of latency
>guarantee IMHO (the fact an _exclusive wakeup removal that mixes stuff
>and probably has the side effect of being more fair, made that much
>difference to mainline users kind of confirms that).
>
>
I think we'll just have to agree to disagree here. This
sort of thing came up in our CFQ discussion as well. Its
not that I think your way is without merits, but I think
in an overload situtation its a better aim to attempt to
keep throughput up rather than attempt to provide the
lowest possible latency.


