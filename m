Return-Path: <SRS0=qbCF=ZK=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94292C432C0
	for <io-uring@archiver.kernel.org>; Mon, 18 Nov 2019 06:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8572075E
	for <io-uring@archiver.kernel.org>; Mon, 18 Nov 2019 06:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1+FApPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfKRG5N (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:57:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37694 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfKRG5M (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 18 Nov 2019 01:57:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI6sLBY188241;
        Mon, 18 Nov 2019 06:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=LXsWMY8mgMd7/nL8114RICzRvsSGuoH9vWgcBN06dQI=;
 b=b1+FApPyqRSCcCEcFbUbtDWAYzB3bKG+8+WAUFYR2dIkaXM8F5T2/LeVwzeeOAP+rufm
 IMECGJcAX4ad4wyyMbQIR76z4rZv7bHHMtfmphAJIDDtgeuix8WVIMQvQpXYB/VrGvVy
 NnyGLsXU+WoKkXWCx+8SZGw5ahrgDQCZn7woPz7buoacqhNyyvuExY97rl1xpYns0i90
 pCyVKfrexz6wD7+xmsphcyHoEJtKNGAA7F+A55pbbxIS3ognMu/lYykixhGlxxP2e099
 RM2SEJzrU7hDRr8BPdQCHnevcpFdRfMKXTqakmsfhfe0xgwL9zV3+PSUFzX4/fvvhbjx aQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rq61e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 06:57:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI6sAuF013035;
        Mon, 18 Nov 2019 06:57:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2watjwx7sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 06:57:09 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAI6v5a1024633;
        Mon, 18 Nov 2019 06:57:06 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Nov 2019 22:57:05 -0800
Subject: Re: [PATCH v2] io_uring: provide fallback request for OOM situations
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <55798841-7303-525c-fe38-c3fb4fc47a65@kernel.dk>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <d86e30fb-6c33-a9cf-40bf-28a0350eef52@oracle.com>
Date:   Mon, 18 Nov 2019 14:57:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <55798841-7303-525c-fe38-c3fb4fc47a65@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180060
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/19 5:25 AM, Jens Axboe wrote:
> One thing that really sucks for userspace APIs is if the kernel passes
> back -ENOMEM/-EAGAIN for resource shortages. The application really has
> no idea of what to do in those cases. Should it try and reap
> completions? Probably a good idea. Will it solve the issue? Who knows.
> 
> This patch adds a simple fallback mechanism if we fail to allocate
> memory for a request. If we fail allocating memory from the slab for a
> request, we punt to a pre-allocated request. There's just one of these
> per io_ring_ctx, but the important part is if we ever return -EBUSY to
> the application, the applications knows that it can wait for events and
> make forward progress when events have completed. This is the important
> part.
> 

I'm lost how -EBUSY will be returned if allocating from the pre-allocated request.
Could you please explain a bit more? 

Thanks, -Bob

> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Changes since v1:
> - Get rid of the GFP_ATOMIC fallback, just provide the fallback. That
>   should be plenty, and we probably don't want to dip into the atomic
>   pool if GFP_KERNEL failed.
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 1e4c1b7eac6e..81457913e9c9 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -238,6 +238,9 @@ struct io_ring_ctx {
>  	/* 0 is for ctx quiesce/reinit/free, 1 is for sqo_thread started */
>  	struct completion	*completions;
>  
> +	/* if all else fails... */
> +	struct io_kiocb		*fallback_req;
> +
>  #if defined(CONFIG_UNIX)
>  	struct socket		*ring_sock;
>  #endif
> @@ -407,6 +410,10 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>  	if (!ctx)
>  		return NULL;
>  
> +	ctx->fallback_req = kmem_cache_alloc(req_cachep, GFP_KERNEL);
> +	if (!ctx->fallback_req)
> +		goto err;
> +
>  	ctx->completions = kmalloc(2 * sizeof(struct completion), GFP_KERNEL);
>  	if (!ctx->completions)
>  		goto err;
> @@ -432,6 +439,8 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>  	INIT_LIST_HEAD(&ctx->inflight_list);
>  	return ctx;
>  err:
> +	if (ctx->fallback_req)
> +		kmem_cache_free(req_cachep, ctx->fallback_req);
>  	kfree(ctx->completions);
>  	kfree(ctx);
>  	return NULL;
> @@ -711,6 +720,23 @@ static void io_cqring_add_event(struct io_kiocb *req, long res)
>  	io_cqring_ev_posted(ctx);
>  }
>  
> +static inline bool io_is_fallback_req(struct io_kiocb *req)
> +{
> +	return req == (struct io_kiocb *)
> +			((unsigned long) req->ctx->fallback_req & ~1UL);
> +}
> +
> +static struct io_kiocb *io_get_fallback_req(struct io_ring_ctx *ctx)
> +{
> +	struct io_kiocb *req;
> +
> +	req = ctx->fallback_req;
> +	if (!test_and_set_bit_lock(0, (unsigned long *) ctx->fallback_req))
> +		return req;
> +
> +	return NULL;
> +}
> +
>  static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>  				   struct io_submit_state *state)
>  {
> @@ -723,7 +749,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>  	if (!state) {
>  		req = kmem_cache_alloc(req_cachep, gfp);
>  		if (unlikely(!req))
> -			goto out;
> +			goto fallback;
>  	} else if (!state->free_reqs) {
>  		size_t sz;
>  		int ret;
> @@ -738,7 +764,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>  		if (unlikely(ret <= 0)) {
>  			state->reqs[0] = kmem_cache_alloc(req_cachep, gfp);
>  			if (!state->reqs[0])
> -				goto out;
> +				goto fallback;
>  			ret = 1;
>  		}
>  		state->free_reqs = ret - 1;
> @@ -750,6 +776,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>  		state->cur_req++;
>  	}
>  
> +got_it:
>  	req->file = NULL;
>  	req->ctx = ctx;
>  	req->flags = 0;
> @@ -758,7 +785,10 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>  	req->result = 0;
>  	INIT_IO_WORK(&req->work, io_wq_submit_work);
>  	return req;
> -out:
> +fallback:
> +	req = io_get_fallback_req(ctx);
> +	if (req)
> +		goto got_it;
>  	percpu_ref_put(&ctx->refs);
>  	return NULL;
>  }
> @@ -788,7 +818,10 @@ static void __io_free_req(struct io_kiocb *req)
>  		spin_unlock_irqrestore(&ctx->inflight_lock, flags);
>  	}
>  	percpu_ref_put(&ctx->refs);
> -	kmem_cache_free(req_cachep, req);
> +	if (likely(!io_is_fallback_req(req)))
> +		kmem_cache_free(req_cachep, req);
> +	else
> +		clear_bit_unlock(0, (unsigned long *) ctx->fallback_req);
>  }
>  
>  static bool io_link_cancel_timeout(struct io_kiocb *req)
> @@ -1000,8 +1033,8 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
>  			 * completions for those, only batch free for fixed
>  			 * file and non-linked commands.
>  			 */
> -			if ((req->flags & (REQ_F_FIXED_FILE|REQ_F_LINK)) ==
> -			    REQ_F_FIXED_FILE) {
> +			if (((req->flags & (REQ_F_FIXED_FILE|REQ_F_LINK)) ==
> +			    REQ_F_FIXED_FILE) && !io_is_fallback_req(req)) {
>  				reqs[to_free++] = req;
>  				if (to_free == ARRAY_SIZE(reqs))
>  					io_free_req_many(ctx, reqs, &to_free);
> @@ -4119,6 +4152,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
>  				ring_pages(ctx->sq_entries, ctx->cq_entries));
>  	free_uid(ctx->user);
>  	kfree(ctx->completions);
> +	kmem_cache_free(req_cachep, ctx->fallback_req);
>  	kfree(ctx);
>  }
>  
> 

