Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbVAFIQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVAFIQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 03:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVAFIQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 03:16:51 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:42874 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262769AbVAFIQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 03:16:49 -0500
Message-ID: <41DCF3EC.3090506@yahoo.com.au>
Date: Thu, 06 Jan 2005 19:16:44 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, riel@redhat.com,
       marcelo.tosatti@cyclades.com, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: memory barrier in ll_rw_blk.c (was Re: [PATCH][5/?] count writeback
 pages in nr_scanned)
References: <20050105203217.GB17265@logos.cnet> <41DC7D86.8050609@yahoo.com.au> <Pine.LNX.4.61.0501052025450.11550@chimarrao.boston.redhat.com> <20050105173624.5c3189b9.akpm@osdl.org> <Pine.LNX.4.61.0501052240250.11550@chimarrao.boston.redhat.com> <41DCB577.9000205@yahoo.com.au> <20050105202611.65eb82cf.akpm@osdl.org> <41DCC014.80007@yahoo.com.au> <20050105204706.0781d672.akpm@osdl.org> <41DCC4C6.8000205@yahoo.com.au> <20050106080649.GE17821@suse.de>
In-Reply-To: <20050106080649.GE17821@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Jan 06 2005, Nick Piggin wrote:

>>
>>This memory barrier is not needed because the waitqueue will only get
>>waiters on it in the following situations:
>>
>>rq->count has exceeded the threshold - however all manipulations of ->count
>>are performed under the runqueue lock, and so we will correctly pick up any
>>waiter.
>>
>>Memory allocation for the request fails. In this case, there is no additional
>>help provided by the memory barrier. We are guaranteed to eventually wake
>>up waiters because the request allocation mempool guarantees that if the mem
>>allocation for a request fails, there must be some requests in flight. They
>>will wake up waiters when they are retired.
> 
> 
> Not sure I agree completely. Yes it will work, but only because it tests
> <= q->nr_requests and I don't think that 'eventually' is good enough :-)
> 
> The actual waitqueue manipulation doesn't happen under the queue lock,
> so the memory barrier is needed to pickup the change on SMP. So I'd like
> to keep the barrier.
> 

No that's right... but between the prepare_to_wait and the io_schedule,
get_request takes the lock and checks nr_requests. I think we are safe?

> I'd prefer to add smp_mb() to waitqueue_active() actually!
> 

That may be a good idea (I haven't really taken much notice of how other
code uses it).

I'm not worried about any possible performance advantages of removing it,
rather just having a memory barrier without comments can be perplexing.
