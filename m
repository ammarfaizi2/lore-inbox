Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUDTH7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUDTH7M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 03:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUDTH7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 03:59:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18571 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261766AbUDTH7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 03:59:04 -0400
Message-ID: <4084D83D.8060405@redhat.com>
Date: Mon, 19 Apr 2004 21:58:53 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040418)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i2o_block Fix, possible CFQ elevator problem?
References: <4083BA03.1090606@redhat.com> <20040419121225.GT1966@suse.de> <408471E2.8060201@redhat.com> <40848159.7090605@togami.com> <20040420070805.GC25806@suse.de>
In-Reply-To: <20040420070805.GC25806@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>>>http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie.txt
>>
>>Next we tested cfq with the following section of code commented out. 
>>With this change the kernel no longer panics and seems to survive with 
>>four simultaneous bonnie++'s on all four block devices.
>>
>>--- cfq-iosched.c       2004-04-20 13:52:55.000000000 -1000
>>+++ /root/linux-2.6.5-1.326/drivers/block/cfq-iosched.c 2004-04-20 
>>14:09:43.000000000 -1000
>>@@ -401,10 +401,12 @@
>> dispatch:
>>                rq = list_entry_rq(cfqd->dispatch->next);
>>
>>+/*
>>                BUG_ON(q->last_merge == rq);
>>                crq = RQ_DATA(rq);
>>                if (crq)
>>                        BUG_ON(ON_MHASH(crq));
>>+*/
>>
>>                return rq;
>>        }
> 
> 
> This is not safe, the BUG_ON is there for a reason. If the request in on
> the merge hash when handed to the driver, you risk corrupting data. The
> fix would be figuring out why this is happening. Maybe it's looking at
> bad data, could you test with this patch applied and see if the oops
> still triggers?
> 
> ===== drivers/block/cfq-iosched.c 1.1 vs edited =====
> --- 1.1/drivers/block/cfq-iosched.c	Mon Apr 12 19:55:20 2004
> +++ edited/drivers/block/cfq-iosched.c	Tue Apr 20 09:07:20 2004
> @@ -403,7 +403,7 @@
>  
>  		BUG_ON(q->last_merge == rq);
>  		crq = RQ_DATA(rq);
> -		if (crq)
> +		if (blk_fs_request(rq) && crq)
>  			BUG_ON(ON_MHASH(crq));
>  
>  		return rq;
> 

We figured removing error handling was not safe, the previous post was 
only reporting test results to ask for more suggestions.  I have now 
tested your suggested patch above and it seems to crash in the same way 
as originally.

http://togami.com/~warren/archive/2004/i2o_cfq_quad_bonnie2.txt

This makes me curious, the other elevators lacked this type of error 
checking.  Did this mean they were possibly allowing data corruption to 
happen with buggy drivers like this?  Kind of scary!  We were lucky to 
test this now, because this was one of the first FC kernels that 
included cfq by default.

Do you have any advice regarding the atomic type removal problem that we 
experienced from our previous post?

Warren Togami
wtogami@redhat.com
