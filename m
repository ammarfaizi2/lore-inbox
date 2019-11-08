Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414C5C43331
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F982084C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfKHAnc convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:43:32 -0500
Received: from smtpbgeu1.qq.com ([52.59.177.22]:38451 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfKHAnc (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Thu, 7 Nov 2019 19:43:32 -0500
X-QQ-mid: bizesmtp27t1573173796tc666suw
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 08 Nov 2019 08:43:15 +0800 (CST)
X-QQ-SSF: 00400000002000S0ZU90B00A0000000
X-QQ-FEAT: nRXnH7lDr4fS8RhsDbEwg+XYZ0+e9sbjIrGQylqBLyO6PD8XEAVAa30YYn/CY
        L3lpFfKOd5F74EWIsdXEFvvMGCPcjOu4rYBvoBPBpU8xrnIynKK5uaz/Qi2ZJscePw5QTe4
        UMMreJp5BLzZD5AHIjH0D8j+Ctz8f1nCy/D0INQ7zbnxNRSm6QsvffWaPMNk8+K4FrTcdYf
        5/bLNEJmhlejPHTH5+Fb+FNQ2YiZO1NL/9lvNB6+UpiE/AEg4fhQnn/k2mLy8cdf1OvFGh7
        qIfw/KZ6XuOxGcr2f3FTmzXBLc8e0Lxd8cd5uvYDW4/1BcGy2/59sKncIRaC8jVcwYf3KBw
        CQZs4UFmrGNRfkQq4qVtWCOmX425Q==
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] io_uring: reduce/pack size of io_ring_ctx
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <2b059341-09f7-3810-435c-ef749cafedef@kernel.dk>
Date:   Fri, 8 Nov 2019 08:43:16 +0800
Cc:     io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8492EF8D-FB1F-46E3-AF89-E634D262173D@kylinos.cn>
References: <1031c163-abd1-f42c-370d-8801f5fd2440@kernel.dk>
 <EB274748-0796-4D09-A568-D7A16A0C22D7@kylinos.cn>
 <253b27a9-55a2-c88e-3ccb-625c104934bb@kernel.dk>
 <2b059341-09f7-3810-435c-ef749cafedef@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



> 2019年11月8日 08:35，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 11/7/19 5:06 PM, Jens Axboe wrote:
>> On 11/7/19 5:00 PM, Jackie Liu wrote:
>>> This patch looks good, but I prefer sqo_thread_started instead of sqo_done,
>>> because we are marking the thread started, not the end of the thread.
>>> 
>>> Anyway, Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>
>> 
>> Yeah, let's retain the old name. I'll make that change and add your
>> reviewed-by, thanks.
> 
> Actually, would you mind if we just make it ->completions[2] instead?
> That saves a kmalloc per ctx setup, I think that's worthwhile enough
> to bundle them together:
> 
> 
> commit 3b830211e99976650d5da0613dfca105c5007f8b
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Nov 7 17:27:39 2019 -0700
> 
>    io_uring: reduce/pack size of io_ring_ctx
> 
>    With the recent flurry of additions and changes to io_uring, the
>    layout of io_ring_ctx has become a bit stale. We're right now at
>    704 bytes in size on my x86-64 build, or 11 cachelines. This
>    patch does two things:
> 
>    - We have to completion structs embedded, that we only use for
>      quiesce of the ctx (or shutdown) and for sqthread init cases.
>      That 2x32 bytes right there, let's dynamically allocate them.
> 
>    - Reorder the struct a bit with an eye on cachelines, use cases,
>      and holes.
> 
>    With this patch, we're down to 512 bytes, or 8 cachelines.
> 
>    Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>
>    Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 4c488bf6e889..2b784262eaff 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -213,24 +213,13 @@ struct io_ring_ctx {
> 		wait_queue_head_t	inflight_wait;
> 	} ____cacheline_aligned_in_smp;
> 
> +	struct io_rings	*rings;
> +
> 	/* IO offload */
> 	struct io_wq		*io_wq;
> 	struct task_struct	*sqo_thread;	/* if using sq thread polling */
> 	struct mm_struct	*sqo_mm;
> 	wait_queue_head_t	sqo_wait;
> -	struct completion	sqo_thread_started;
> -
> -	struct {
> -		unsigned		cached_cq_tail;
> -		unsigned		cq_entries;
> -		unsigned		cq_mask;
> -		atomic_t		cq_timeouts;
> -		struct wait_queue_head	cq_wait;
> -		struct fasync_struct	*cq_fasync;
> -		struct eventfd_ctx	*cq_ev_fd;
> -	} ____cacheline_aligned_in_smp;
> -
> -	struct io_rings	*rings;
> 
> 	/*
> 	 * If used, fixed file set. Writers must ensure that ->refs is dead,
> @@ -246,7 +235,22 @@ struct io_ring_ctx {
> 
> 	struct user_struct	*user;
> 
> -	struct completion	ctx_done;
> +	/* 0 is for ctx quiesce/reinit/free, 1 is for sqo_thread started */
> +	struct completion	*completions;
> +

I think it's okay, it's clear through comments here.

--
BR, Jackie Liu



