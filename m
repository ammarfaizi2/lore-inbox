Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUCJF1n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUCJF1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:27:43 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:46533 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262089AbUCJF1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:27:35 -0500
Message-ID: <404EA645.8010900@cyberone.com.au>
Date: Wed, 10 Mar 2004 16:23:17 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: blk_congestion_wait racy?
References: <OFAAC6B1AC.5886C5F2-ONC1256E52.0061A30B-C1256E52.0062656E@de.ibm.com>
In-Reply-To: <OFAAC6B1AC.5886C5F2-ONC1256E52.0061A30B-C1256E52.0062656E@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Schwidefsky wrote:

>
>
>
>Hi Nick,
>
>
>>Another problem is that if there are no requests anywhere in the system,
>>sleepers in blk_congestion_wait will not get kicked. blk_congestion_wait
>>could probably have blk_run_queues moved after prepare_to_wait, which
>>might help.
>>
>I tried putting blk_run_queues after prepare_to_wait, it worked but it
>didn't help. The test still needs close to a minute.
>
>

OK. This was *with* the memory barrier changes too, was it? Not that
they should make that much difference. The test is still racy, but
the window just gets smaller.

But I'm guessing that you have no requests in flight by the time
blk_congestion_wait gets called, so nothing ever gets kicked.

I prefer something more like this model: if 'current' submits a request
to a congested queue then it gets put on the congestion waitqueue.
You can then run blk_congestion_wait afterwards and it won't block if
the queue you've written to has come out of congestion at any time.

This also means that you can (should, in fact) stop uncongested queues
from waking up the waiters every time they complete a request. Hmm, I
like it.

