Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbTFLCvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 22:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264720AbTFLCvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 22:51:12 -0400
Received: from dyn-ctb-210-9-241-68.webone.com.au ([210.9.241.68]:43268 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264717AbTFLCvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 22:51:05 -0400
Message-ID: <3EE7EDBB.70608@cyberone.com.au>
Date: Thu, 12 Jun 2003 13:04:27 +1000
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
References: <1055353360.23697.235.camel@tiny.suse.com> <20030611181217.GX26270@dualathlon.random> <1055356032.24111.240.camel@tiny.suse.com> <20030611183503.GY26270@dualathlon.random> <3EE7D1AA.30701@cyberone.com.au> <20030612012951.GG1500@dualathlon.random> <1055384547.24111.322.camel@tiny.suse.com> <3EE7E876.80808@cyberone.com.au> <20030612024608.GE1415@dualathlon.random> <3EE7EA4A.5030105@cyberone.com.au> <20030612025812.GF1415@dualathlon.random>
In-Reply-To: <20030612025812.GF1415@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>On Thu, Jun 12, 2003 at 12:49:46PM +1000, Nick Piggin wrote:
>
>>
>>Andrea Arcangeli wrote:
>>
>>>it does nothing w/ _exclusive and w/o the wake_up_nr, that's why I added
>>>the wake_up_nr.
>>>
>>>
>>>
>>That is pretty pointless as well. You might as well just start
>>waking up at the queue full limit, and wake one at a time.
>>
>>The purpose for batch_requests was I think for devices with a
>>very small request size, to reduce context switches.
>>
>
>batch_requests at least in my tree matters only when each request is
>512btyes and you've some thousand of them to compose a 4M queue or so.
>To maximize cpu cache usage etc.. I try to wakeup a task every 512bytes
>written, but every 32*512bytes written or so. Of course w/o the
>wake_up_nr that I added, that wasn't really working w/ the _exlusive
>wakeup.
>
>if you check my tree you'll see that for sequential I/O with 512k in
>each request (not 512bytes!) batch_requests is already a noop.
>


You are waking up multiple tasks which will each submit
1 request. You want to be waking up 1 task which will
submit multiple requests - that is how you will save
context switches, cpu cache, etc, and that task's requests
will have a much better chance of being merged, or at
least serviced as a nice batch than unrelated tasks.

