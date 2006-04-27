Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWD0Bnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWD0Bnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 21:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWD0Bnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 21:43:42 -0400
Received: from rtr.ca ([64.26.128.89]:44952 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964857AbWD0Bnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 21:43:41 -0400
Message-ID: <445021B8.3070705@rtr.ca>
Date: Wed, 26 Apr 2006 21:43:20 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in handling
 medium errors
References: <200604261627.29419.lkml@rtr.ca>	<1146092161.12914.3.camel@mulgrave.il.steeleye.com>	<20060426161444.423a8296.akpm@osdl.org>	<44500033.3010605@rtr.ca> <20060426163536.6f7bff77.akpm@osdl.org>
In-Reply-To: <20060426163536.6f7bff77.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mark Lord <lkml@rtr.ca> wrote:
>>> That's if we think -stable needs this fixed.
>> Let's say a bunch of read bio's get coalesced into a single
>> 200+ sector request.  This then fails on one single bad sector
>> out of the 200+.  Without the patch, there is a very good chance
>> that sd.c will simply fail the entire request, all 200+ sectors.
>>
>> With the patch, it will fail the first block, and then retry
>> the remaining blocks.  And repeat this until something works,
>> or until everything has failed one by one.
> 
> Yowch.  I have the feeling that this'll take our EIO-handling time from
> far-too-long to far-too-long*200.

That's how it always used to work (eg. SUSE9 2.6.5+ kernels; Jens?).

>> What I need to have happen when a request is failed due to bad-media,
>> is have it split the request into a sequence of single-block requests
>> that are passed to the LLD one at a time.  The ones with real bad
>> sectors will then be independently failed, and the rest will get done.
>>
>> Much better.  Much more complex.
>>
>> I'm thinking about something like that, just not sure whether to put it
>> (initially) in libata, sd.c, or the block layer.
> 
> block, I suspect.  My DVD trauma was IDE-induced.  Jens is mulling the
> problem - I'd suggest you coordinate with him.

I've been pinging Jens about it for a couple of weeks now; no response.

> It would be a good thing to fix.
> 
> It's moderately hard to test, though.  Easy enough for DVDs and CDs, but
> it's harder to take a marker pen to a hard drive.

I have a bunch of "pre-marked" SATA drives here just for the purpose..

Cheers

