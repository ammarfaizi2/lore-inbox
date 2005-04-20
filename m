Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVDTJFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVDTJFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 05:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVDTJFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 05:05:12 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:64116 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261392AbVDTJEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 05:04:54 -0400
Message-ID: <42661B2C.1020100@yahoo.com.au>
Date: Wed, 20 Apr 2005 19:04:44 +1000
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
References: <20050419231435.D85F89C0@htj.dyndns.org> <20050419231435.2DEBE102@htj.dyndns.org> <20050420063009.GB9371@suse.de> <20050420074026.GA11228@htj.dyndns.org> <1113983899.5074.111.camel@npiggin-nld.site> <426614B7.5010204@gmail.com> <20050420083853.GB6558@suse.de>
In-Reply-To: <20050420083853.GB6558@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Apr 20 2005, Tejun Heo wrote:

>> Well, yeah, all schedulers have dispatch queue (noop has only the
>>dispatch queue) and use them to defer/requeue, so no reordering will
>>happen, but I'm not sure they are required to be like this or just
>>happen to be implemented so.
> 
> 
> Precisely, I feel much better making sure SOFTBARRIER is set so that we
> _know_ that a scheduler following the outlined rules will do the right
> thing.
> 

Well yeah, at the moment I am just following implementations as
defining the standard.

> 
>> Hmm, well, it seems that setting REQ_SOFTBARRIER on requeue path isn't
>>necessary as we have INSERT_FRONT policy on requeue, and if
>>elv_next_req_fn() is required to return the same request when the
>>request isn't dequeued, you're right and we don't need this patch at
>>all.  We are guaranteed that all requeued requests are served in LIFO
>>manner.
> 
> 
> After a requeue, it is not required to return the same request again.
> 

Well I guess not.

Would there be any benefit to reordering after a requeue?

> 
>> BTW, the same un-dequeued request rule is sort of already broken as
>>INSERT_FRONT request passes a returned but un-dequeued request, but,
>>then again, we need this behavior as we have to favor fully-prepped
>>requests over partially-prepped one.
> 
> 
> INSERT_FRONT really should skip requests with REQ_STARTED on the
> dispatch list to be fully safe.
> 

I guess this could be one use of 'reordering' after a requeue.

I'm not sure this would need a REQ_SOFTBARRIER either though, really.

Your basic io scheduler framework - ie. a FIFO dispatch list which
can have requests requeued on the front models pretty well what the
block layer needs of the elevator.

Considering all requeues and all elv_next_request but not dequeued
requests would have this REQ_SOFTBARRIER bit set, any other model
that theoretically would allow reordering would degenerate to this
dispatch list behaviour, right?

In which case, the dispatch list is effectively basically the most
efficient way to do it? In which case should we just explicitly
document that in the API?


-- 
SUSE Labs, Novell Inc.

