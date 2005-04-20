Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVDTJYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVDTJYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 05:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVDTJYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 05:24:54 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:29341 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261527AbVDTJYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 05:24:47 -0400
Message-ID: <42661FDB.7030409@yahoo.com.au>
Date: Wed, 20 Apr 2005 19:24:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Tejun Heo <htejun@gmail.com>, James.Bottomley@steeleye.com,
       Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 01/05] scsi: make blk layer set	REQ_SOFTBARRIER
 when a request is dispatched
References: <20050419231435.D85F89C0@htj.dyndns.org> <20050419231435.2DEBE102@htj.dyndns.org> <20050420063009.GB9371@suse.de> <20050420074026.GA11228@htj.dyndns.org> <1113983899.5074.111.camel@npiggin-nld.site> <426614B7.5010204@gmail.com> <20050420083853.GB6558@suse.de> <42661B2C.1020100@yahoo.com.au> <20050420091428.GH6558@suse.de>
In-Reply-To: <20050420091428.GH6558@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Apr 20 2005, Nick Piggin wrote:
> 

>>I guess this could be one use of 'reordering' after a requeue.
> 
> 
> Yeah, or perhaps the io scheduler might determine that a request has
> higher prio than a requeued one.  I'm not sure what semantics to place

I guess this is possible. It is often only a single request
that is on the dispatch list though, so I don't know if it
would make sense to reorder it by priority again.

> on soft-barrier, I've always taken it to mean 'maintain ordering if
> convenient' where the hard-barrier must be followed.
> 

I've thought it was SOFTBARRIER ensures the device driver (and
hardware?) sees the request in this order, and HARDBARRIER ensures
it reaches stable storage in this order.

Not exactly sure why you would want a softbarrier and not a
hardbarrier. Maybe for special commands.

> 
>>I'm not sure this would need a REQ_SOFTBARRIER either though, really.
>>
>>Your basic io scheduler framework - ie. a FIFO dispatch list which
>>can have requests requeued on the front models pretty well what the
>>block layer needs of the elevator.
>>
>>Considering all requeues and all elv_next_request but not dequeued
>>requests would have this REQ_SOFTBARRIER bit set, any other model
>>that theoretically would allow reordering would degenerate to this
>>dispatch list behaviour, right?
> 
> 
> Not sure I follow this - I don't want REQ_SOFTBARRIER set automatically
> on elv_next_request() return, it should only happen on requeues.
> REQ_STARTED implies that you should not pass this request, since the io
> scheduler is required to return this request again until dequeue is
> called. But the result is the same, correct.
> 

OK - but I'm wondering would it ever make sense to do it any
other way? I would have thought no, in which case we can document
that requests seen by 'elv_next_request', and those requeued back
into the device will not be reordered, and so Tejun does not need
to set REQ_SOFTBARRIER.

But I'm not so sure now... it isn't really that big a deal ;)
So whatever you're happy with is fine. Sorry for the nose.

-- 
SUSE Labs, Novell Inc.

