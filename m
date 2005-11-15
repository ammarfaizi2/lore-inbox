Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVKOS0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVKOS0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVKOS0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:26:04 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:6354 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S964990AbVKOS0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:26:02 -0500
Message-ID: <437A2814.1060308@cs.wisc.edu>
Date: Tue, 15 Nov 2005 12:25:24 -0600
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] libata error handling fixes (ATAPI)
References: <20051114195717.GA24373@havoc.gtf.org> <20051115074148.GA17459@htj.dyndns.org> <4379AA5B.1060900@pobox.com> <4379B28E.9070708@gmail.com> <4379C062.3010302@pobox.com> <20051115120016.GD7787@suse.de>
In-Reply-To: <20051115120016.GD7787@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Nov 15 2005, Jeff Garzik wrote:
> 
>>>For departure of libata from SCSI, I was thinking more of another more 
>>>generic block device framework in which libata can live in.  And I 
>>>thought that it was reasonable to assume that the framework would supply 
>>>a EH mechanism which supports queue stalling/draining and separate 
>>>thread.  So, my EH patches tried to make the same environment for libata 
>>
>>A big reason why libata uses the SCSI layer is infrastructure like this. 
>> It would certainly be nice to see timeouts and EH at the block layer. 
>> The block layer itself already supports queue stalling/draining.
> 
> 
> I have a pretty simple plan for this:
> 
> - Add a timer to struct request. It already has a timeout field for
>   SG_IO originated requests, we could easily utilize this in general.
>   I'm not sure how the querying of timeout would happen so far, it would
>   probably require a q->set_rq_timeout() hook to ask the low level
>   driver to set/return rq->timeout for a given request.
> 
> - Add a timeout hook to struct request_queue that would get invoked from
>   the timeout handler. Something along the lines of:
> 
>         - Timeout on a request happens. Freeze the queue and use
>           kblockd to take the actual timeout into process context, where
>           we call the queue ->rq_timeout() hook. Unfreeze/reschedule
>           queue operations based on what the ->rq_timeout() hook tells
>           us.
> 
> That is generic enough to be able to arm the timeout automatically from
> ->elevator_activate_req_fn() and dearm it when it completes or gets
> deactivated. It should also be possible to implement the SCSI error
> handling on top of that.
> 

To disable the timeout would you then have scsi_done call a block layer 
function to disarm it then follow the current flow where or do you think 
it would be nice to move the scsi softirq code up to block layer. So 
scsi_done would call a block layer function that would disarm the timer, 
add the request to a block layer softirq list (a list like scsi-ml's 
scsi_done_q), and then in the block layer softirq function it could call 
a request_queue callout which for scsi-ml's device queue would call 
scsi_decide_disposition and return if it wanted the request requeued or 
how many sectors completed or to kick off the eh. I had stated on this 
for my block layer multipath driver, but can seperate the patches if 
this would be useful.

Would ide benefit from running from a softirq and would it be able to 
use such a thing?

