Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVKAKN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVKAKN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 05:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVKAKN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 05:13:27 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:30163 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750708AbVKAKN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 05:13:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=MmNlqfmVX9L3ejxcdOMYsfxvQPihgrCC7WZHz+E4SfuBp2USvr5kyt1NgvwBj2FQwgwRSIuZXkAmM09nY71OKehoFizPDb3YbtWJZlE828mhS0zW4BjyVW+2dTP8UvL/PJ3d6yBL0LDAb7wxPu1x/kLcFl2n/CFL7jYaAtTCLrc=
Message-ID: <43673FBC.3070403@gmail.com>
Date: Tue, 01 Nov 2005 19:13:16 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: torvalds@osdl.org, acme@mandriva.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: fix dangling pointer access in __elv_add_request
References: <20051101082349.GA17756@htj.dyndns.org> <20051101090857.GC26049@suse.de>
In-Reply-To: <20051101090857.GC26049@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, Nov 01 2005, Tejun Heo wrote:
> 
>>cfq's add_req_fn callback may invoke q->request_fn directly and
>>depending on low-level driver used and timing, a queued request may be
>>finished & deallocated before add_req_fn callback returns.  So,
>>__elv_add_request must not access rq after it's passed to add_req_fn
>>callback.
> 
> 
> It's a generel problem, you may get the queue run at any time regardless
> of what the io scheduler is doing. CFQ does run the queue manully
> sometimes, but SCSI may do the very same thing for you as well. Given
> that SCSI also shortly reenables interrupts in the ->request_fn()
> handling, it's quite possible for the request to be completed.
 >
 > So, as we don't hold a reference to the request, I'd say your patch
 > looks correct and should be applied right away.
 >
 >
 >>Jens, does generalizing queue kicking functions and disallowing
 >>ioscheds from directly calling q->request_fn sound like a good idea?
 >
 >
 > Yes certainly.
 >

The thing is that we are holding queue_lock before calling add_req_fn 
callback and also after it finishes giving it an appearance of 
atomicity.  I think q->request_fn semantics is peculiar and a bit prone 
to bug, so it might be better to make ioscheds always use generic queue 
kicking function which always uses work queue to run q->request_fn so 
that we don't have queue_lock releasing and regrabbing inbetween.  Do 
you think there can be any noticieable performance issues?

Hmmmm... One more thing about q->request_fn's locking behavior is that, 
as I noted while posting the ordered patchset, for SCSI, the behavior 
can reorder issued requests making it impossible to use ordered tags for 
flushing.  I'm thinking of submitting a patch to make scsi request_fn 
atomic w.r.t. queue_lock, but there might be some performance issues I'm 
not aware of.  Functions which release and regrab locks underneath the 
caller are just... hard.  :-p

Thanks.

-- 
tejun
