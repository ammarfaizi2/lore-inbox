Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F13C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 01:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA372075A
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 01:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKUB5n convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:57:43 -0500
Received: from smtpbg704.qq.com ([203.205.195.105]:33456 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725819AbfKUB5n (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 20:57:43 -0500
X-QQ-mid: bizesmtp26t1574301455twyk9bl4
Received: from [172.16.31.194] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Thu, 21 Nov 2019 09:57:33 +0800 (CST)
X-QQ-SSF: 00400000002000T0ZWF0B00A0000000
X-QQ-FEAT: CEypeEbALrupjAgA09z0T9mGmpEkBP3BuH1BU6D1MNNw9L4GqXG6icScWFLz+
        QMvRV6Vvj0CkuCXlkAs/22ksbO+FfhyytF1dDYR6syCguq4EjtqV416hjxmvP1bDxzaQdWI
        A+eSrvAiiPOGmNZw9KBPHbuv7dDcXJ9STwY5T5Ca3M9vaSeJBAT5E61WWEh/lL/k/HiHWlz
        HGxT6GPWGkvWwQcn0IYVHjq+Iz8OQvcWXcSvcwayGyaq5UcWD0ZJUKYmOEoRToc+zyPtceu
        PMxfLdcqtKu3Q0WHqqyIDkVBXP0gXBK4HQ0rtRm1mYuaalwv3zHCg0VizDcW49U5DtztyQB
        5J98/omqCUztnwlmUlqHAHUQye89ye/kB66W+H6
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] io_uring: fix race with shadow drain deferrals
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
Date:   Thu, 21 Nov 2019 09:57:33 +0800
Cc:     io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FCFA70EC-AC49-4B36-8A07-D2E2D2F1D4FA@kylinos.cn>
References: <27c153ee-cfc8-3251-a874-df85a033429a@kernel.dk>
 <cabb202a-a405-9f36-0363-1548f1b4dfd4@kernel.dk>
 <1C6D35BF-C89B-4AB9-83CD-0A6B676E4752@kylinos.cn>
 <890E4F5B-DDA2-40EF-B7AD-3C63EFA20D93@kylinos.cn>
 <b70c7e29-408c-af72-5dc1-85456c904c7a@kernel.dk>
 <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



> 2019年11月21日 09:49，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 11/20/19 6:40 PM, Jens Axboe wrote:
>> On 11/20/19 6:35 PM, Jackie Liu wrote:
>>> 
>>> 
>>>> 2019年11月21日 09:32，Jackie Liu <liuyun01@kylinos.cn> 写道：
>>>> 
>>>> 2019年11月21日 07:58，Jens Axboe <axboe@kernel.dk> 写道：
>>>> 
>>>>> 
>>>>> On 11/20/19 4:07 PM, Jens Axboe wrote:
>>>>>> When we go and queue requests with drain, we check if we need to defer
>>>>>> based on sequence. This is done safely under the lock, but then we drop
>>>>>> the lock before actually inserting the shadow. If the original request
>>>>>> is found on the deferred list by another completion in the mean time,
>>>>>> it could have been started AND completed by the time we insert the
>>>>>> shadow, which will stall the queue.
>>>>>> 
>>>>>> After re-grabbing the completion lock, check if the original request is
>>>>>> still in the deferred list. If it isn't, then we know that someone else
>>>>>> already found and issued it. If that happened, then our job is done, we
>>>>>> can simply free the shadow.
>>>>>> 
>>>>>> Cc: Jackie Liu <liuyun01@kylinos.cn>
>>>>>> Fixes: 4fe2c963154c ("io_uring: add support for link with drain")
>>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>> 
>>>>> BTW, the other solution here is to not release the completion_lock if
>>>>> we're going to return -EIOCBQUEUED, and let the caller do what it needs
>>>>> before releasing it. That'd look something like this, with some sparse
>>>>> annotations to keep things happy.
>>>>> 
>>>>> I think the original I posted here is easier to follow, and the
>>>>> deferral list is going to be tiny in general so it won't really add
>>>>> any extra overhead.
>>>>> 
>>>>> Let me know what you think and prefer.
>>>>> 
>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>> index 6175e2e195c0..0d1f33bcedc0 100644
>>>>> --- a/fs/io_uring.c
>>>>> +++ b/fs/io_uring.c
>>>>> @@ -2552,6 +2552,11 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>>>> 	return 0;
>>>>> }
>>>>> 
>>>>> +/*
>>>>> + * Returns with ctx->completion_lock held if -EIOCBQUEUED is returned, so
>>>>> + * the caller can make decisions based on the deferral without worrying about
>>>>> + * the request being found and issued in the mean time.
>>>>> + */
>>>>> static int io_req_defer(struct io_kiocb *req)
>>>>> {
>>>>> 	const struct io_uring_sqe *sqe = req->submit.sqe;
>>>>> @@ -2579,7 +2584,7 @@ static int io_req_defer(struct io_kiocb *req)
>>>>> 
>>>>> 	trace_io_uring_defer(ctx, req, false);
>>>>> 	list_add_tail(&req->list, &ctx->defer_list);
>>>>> -	spin_unlock_irq(&ctx->completion_lock);
>>>>> +	__release(&ctx->completion_lock);
>>>>> 	return -EIOCBQUEUED;
>>>>> }
>>>>> 
>>>>> @@ -2954,6 +2959,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
>>>>> 
>>>>> static void io_queue_sqe(struct io_kiocb *req)
>>>>> {
>>>>> +	struct io_ring_ctx *ctx = req->ctx;
>>>>> 	int ret;
>>>>> 
>>>>> 	ret = io_req_defer(req);
>>>>> @@ -2963,6 +2969,9 @@ static void io_queue_sqe(struct io_kiocb *req)
>>>>> 			if (req->flags & REQ_F_LINK)
>>>>> 				req->flags |= REQ_F_FAIL_LINK;
>>>>> 			io_double_put_req(req);
>>>>> +		} else {
>>>>> +			__acquire(&ctx->completion_lock);
>>>>> +			spin_unlock_irq(&ctx->completion_lock);
>>>>> 		}
>>>>> 	} else
>>>>> 		__io_queue_sqe(req);
>>>>> @@ -3001,16 +3010,17 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
>>>>> 				__io_free_req(shadow);
>>>>> 			return;
>>>>> 		}
>>>>> +		__acquire(&ctx->completion_lock);
>>>>> 	} else {
>>>>> 		/*
>>>>> 		 * If ret == 0 means that all IOs in front of link io are
>>>>> 		 * running done. let's queue link head.
>>>>> 		 */
>>>>> 		need_submit = true;
>>>>> +		spin_lock_irq(&ctx->completion_lock);
>>>>> 	}
>>>>> 
>>>>> 	/* Insert shadow req to defer_list, blocking next IOs */
>>>>> -	spin_lock_irq(&ctx->completion_lock);
>>>>> 	trace_io_uring_defer(ctx, shadow, true);
>>>>> 	list_add_tail(&shadow->list, &ctx->defer_list);
>>>>> 	spin_unlock_irq(&ctx->completion_lock);
>>>> 
>>>> This is indeed a potential lock issue, thanks, I am prefer this solution, clearer than first one.
>>>> But It may be a bit difficult for other people who read the code, use 'io_req_defer_may_lock'?
>>>> 
>>>> who about this?
>>>> 
>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>> index 5ad652f..6fdaeb1 100644
>>>> --- a/fs/io_uring.c
>>>> +++ b/fs/io_uring.c
>>>> @@ -2469,7 +2469,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>>>         return 0;
>>>> }
>>>> 
>>>> -static int io_req_defer(struct io_kiocb *req)
>>>> +static int __io_req_defer(struct io_kiocb *req)
>>>> {
>>>>         const struct io_uring_sqe *sqe = req->submit.sqe;
>>>>         struct io_uring_sqe *sqe_copy;
>>>> @@ -2495,8 +2495,21 @@ static int io_req_defer(struct io_kiocb *req)
>>>> 
>>>>         trace_io_uring_defer(ctx, req, false);
>>>>         list_add_tail(&req->list, &ctx->defer_list);
>>>> +
>>>> +       return -EIOCBQUEUED;
>>>> +}
>>>> +
>>>> +static int io_req_defer(struct io_kiocb *req)
>>>> +{
>>>> +       int ret = __io_req_defer(req);
>>> 
>>> There have an problem, need fix.
>>> 
>>> static int io_req_defer(struct io_kiocb *req)
>>> {
>>> 	int ret = __io_req_defer(req);
>>> 	if (ret == -EIOCBQUEUED)
>>> 		spin_unlock_irq(&ctx->completion_lock);
>>> 	return ret;
>>> }
>> 
>> Mid-air collision, indeed.
>> 
>> But as I wrote in the previous email, I don't think this one improves on
>> the situation... And fwiw, I did test both of mine, both are verified to
>> fix the issue.
> 
> Maybe we can compromise on something like this? Doesn't introduce any
> may_lock() naming, just uses the __io_req_defer() to take that blame.
> And uses the right sparse annotations to keep things happy with C=2 as
> well. Uses your trick to make io_req_defer() do the lock drop for the
> other caller.
> 
> Ran it through 400x rounds of testing, confirmed as well.
> 
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 6175e2e195c0..299a218e9552 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2552,7 +2552,12 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
> 	return 0;
> }
> 
> -static int io_req_defer(struct io_kiocb *req)
> +/*
> + * Returns with ctx->completion_lock held if -EIOCBQUEUED is returned, so
> + * the caller can make decisions based on the deferral without worrying about
> + * the request being found and issued in the mean time.
> + */
> +static int __io_req_defer(struct io_kiocb *req)
> {
> 	const struct io_uring_sqe *sqe = req->submit.sqe;
> 	struct io_uring_sqe *sqe_copy;
> @@ -2579,10 +2584,23 @@ static int io_req_defer(struct io_kiocb *req)
> 
> 	trace_io_uring_defer(ctx, req, false);
> 	list_add_tail(&req->list, &ctx->defer_list);
> -	spin_unlock_irq(&ctx->completion_lock);
> +	__release(&ctx->completion_lock);
> 	return -EIOCBQUEUED;
> }
> 
> +static int io_req_defer(struct io_kiocb *req)
> +{
> +	struct io_ring_ctx *ctx = req->ctx;
> +	int ret;
> +
> +	ret = __io_req_defer(req);
> +	if (ret == -EIOCBQUEUED) {
> +		__acquire(&ctx->completion_lock);
> +		spin_unlock_irq(&ctx->completion_lock);
> +	}
> +	return ret;
> +}
> +
> static int __io_submit_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
> 			   bool force_nonblock)
> {
> @@ -2957,15 +2975,14 @@ static void io_queue_sqe(struct io_kiocb *req)
> 	int ret;
> 
> 	ret = io_req_defer(req);
> -	if (ret) {
> -		if (ret != -EIOCBQUEUED) {
> -			io_cqring_add_event(req, ret);
> -			if (req->flags & REQ_F_LINK)
> -				req->flags |= REQ_F_FAIL_LINK;
> -			io_double_put_req(req);
> -		}
> -	} else
> +	if (!ret) {
> 		__io_queue_sqe(req);
> +	} else if (ret != -EIOCBQUEUED) {
> +		io_cqring_add_event(req, ret);
> +		if (req->flags & REQ_F_LINK)
> +			req->flags |= REQ_F_FAIL_LINK;
> +		io_double_put_req(req);
> +	}
> }

Hmm.. Why we need rewrite there? clear code? Seems to be unrelated to this issue.

> 
> static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
> @@ -2989,7 +3006,7 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
> 	 * list.
> 	 */
> 	req->flags |= REQ_F_IO_DRAIN;
> -	ret = io_req_defer(req);
> +	ret = __io_req_defer(req);
> 	if (ret) {
> 		if (ret != -EIOCBQUEUED) {
> err:
> @@ -3001,16 +3018,17 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
> 				__io_free_req(shadow);
> 			return;
> 		}
> +		__acquire(&ctx->completion_lock);
> 	} else {
> 		/*
> 		 * If ret == 0 means that all IOs in front of link io are
> 		 * running done. let's queue link head.
> 		 */
> 		need_submit = true;
> +		spin_lock_irq(&ctx->completion_lock);
> 	}
> 
> 	/* Insert shadow req to defer_list, blocking next IOs */
> -	spin_lock_irq(&ctx->completion_lock);
> 	trace_io_uring_defer(ctx, shadow, true);
> 	list_add_tail(&shadow->list, &ctx->defer_list);
> 	spin_unlock_irq(&ctx->completion_lock);

--
BR, Jackie Liu



