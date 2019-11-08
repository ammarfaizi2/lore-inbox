Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CB2C43331
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B691214DB
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfKHAAM convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:00:12 -0500
Received: from smtpbguseast2.qq.com ([54.204.34.130]:44494 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfKHAAL (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 19:00:11 -0500
X-QQ-mid: bizesmtp21t1573171204tz9lxjka
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 08 Nov 2019 08:00:03 +0800 (CST)
X-QQ-SSF: 00400000002000S0ZU90B00A0000000
X-QQ-FEAT: kt6gOBlTESkybYe3xp/Yi73heXThwhPrvVZvF7OkELBiyybg0bqzg3g8W8SZd
        JGzamtPxZl6eq7dkxwOv2Tf/f5o+uRlL3rsy17v2NrZswONY3jFBQrsa1EZTQrxGRPx1jJB
        CoWLIZXC1O8h0pjijs1yraISzFSpUCmygdfsklLNVrb0U+23XsWptecRl71Nb2Vze4JETE+
        jfz9N5e5wyuTC1Kl0AgSY/eh8P+dIJmjC6ffZqCTc0EtnK4T7T25ezvzrbW/fyzde+qvd5I
        8xHjJb/aQK3eAI7nkUsd8oVnkq5l2OQf7InGvG2frvFB963UF3J/4Mr0AxcP9OOK6c2RsuV
        HO7/9+5xBkXQjphLz4=
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] io_uring: reduce/pack size of io_ring_ctx
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <1031c163-abd1-f42c-370d-8801f5fd2440@kernel.dk>
Date:   Fri, 8 Nov 2019 08:00:05 +0800
Cc:     io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EB274748-0796-4D09-A568-D7A16A0C22D7@kylinos.cn>
References: <1031c163-abd1-f42c-370d-8801f5fd2440@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



> 2019年11月8日 04:23，Jens Axboe <axboe@kernel.dk> 写道：
> 
> With the recent flurry of additions and changes to io_uring, the
> layout of io_ring_ctx has become a bit stale. We're right now at
> 704 bytes in size on my x86-64 build, or 11 cachelines. This
> patch does two things:
> 
> - We have to completion structs embedded, that we only use for
>  quiesce of the ctx (or shutdown) and for sqthread init cases.
>  That 2x32 bytes right there, let's dynamically allocate them.
> 
> - Reorder the struct a bit with an eye on cachelines, use cases,
>  and holes.
> 
> With this patch, we're down to 512 bytes, or 8 cachelines.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> --
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index f8344f95817e..2dbc108fa27b 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -212,25 +212,14 @@ struct io_ring_ctx {
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
> -		atomic_t		cached_cq_overflow;
> -		unsigned		cq_entries;
> -		unsigned		cq_mask;
> -		struct wait_queue_head	cq_wait;
> -		struct fasync_struct	*cq_fasync;
> -		struct eventfd_ctx	*cq_ev_fd;
> -		atomic_t		cq_timeouts;
> -	} ____cacheline_aligned_in_smp;
> -
> -	struct io_rings	*rings;
> +	struct completion	*sqo_done;
> 
> 	/*
> 	 * If used, fixed file set. Writers must ensure that ->refs is dead,
> @@ -246,7 +235,22 @@ struct io_ring_ctx {
> 
> 	struct user_struct	*user;
> 
> -	struct completion	ctx_done;
> +	struct completion	*ctx_done;
> +
> +#if defined(CONFIG_UNIX)
> +	struct socket		*ring_sock;
> +#endif
> +
> +	struct {
> +		unsigned		cached_cq_tail;
> +		atomic_t		cached_cq_overflow;
> +		unsigned		cq_entries;
> +		unsigned		cq_mask;
> +		struct wait_queue_head	cq_wait;
> +		struct fasync_struct	*cq_fasync;
> +		struct eventfd_ctx	*cq_ev_fd;
> +		atomic_t		cq_timeouts;
> +	} ____cacheline_aligned_in_smp;
> 
> 	struct {
> 		struct mutex		uring_lock;
> @@ -268,10 +272,6 @@ struct io_ring_ctx {
> 		spinlock_t		inflight_lock;
> 		struct list_head	inflight_list;
> 	} ____cacheline_aligned_in_smp;
> -
> -#if defined(CONFIG_UNIX)
> -	struct socket		*ring_sock;
> -#endif
> };
> 
> struct sqe_submit {
> @@ -396,7 +396,7 @@ static void io_ring_ctx_ref_free(struct percpu_ref *ref)
> {
> 	struct io_ring_ctx *ctx = container_of(ref, struct io_ring_ctx, refs);
> 
> -	complete(&ctx->ctx_done);
> +	complete(ctx->ctx_done);
> }
> 
> static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
> @@ -407,17 +407,20 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
> 	if (!ctx)
> 		return NULL;
> 
> +	ctx->ctx_done = kmalloc(sizeof(struct completion), GFP_KERNEL);
> +	ctx->sqo_done = kmalloc(sizeof(struct completion), GFP_KERNEL);
> +	if (!ctx->ctx_done || !ctx->sqo_done)
> +		goto err;
> +
> 	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free,
> -			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
> -		kfree(ctx);
> -		return NULL;
> -	}
> +			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
> +		goto err;
> 
> 	ctx->flags = p->flags;
> 	init_waitqueue_head(&ctx->cq_wait);
> 	INIT_LIST_HEAD(&ctx->cq_overflow_list);
> -	init_completion(&ctx->ctx_done);
> -	init_completion(&ctx->sqo_thread_started);
> +	init_completion(ctx->ctx_done);
> +	init_completion(ctx->sqo_done);
> 	mutex_init(&ctx->uring_lock);
> 	init_waitqueue_head(&ctx->wait);
> 	spin_lock_init(&ctx->completion_lock);
> @@ -429,6 +432,11 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
> 	spin_lock_init(&ctx->inflight_lock);
> 	INIT_LIST_HEAD(&ctx->inflight_list);
> 	return ctx;
> +err:
> +	kfree(ctx->ctx_done);
> +	kfree(ctx->sqo_done);
> +	kfree(ctx);
> +	return NULL;
> }
> 
> static inline bool __io_sequence_defer(struct io_ring_ctx *ctx,
> @@ -3037,7 +3045,7 @@ static int io_sq_thread(void *data)
> 	unsigned inflight;
> 	unsigned long timeout;
> 
> -	complete(&ctx->sqo_thread_started);
> +	complete(ctx->sqo_done);
> 
> 	old_fs = get_fs();
> 	set_fs(USER_DS);
> @@ -3276,7 +3284,7 @@ static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
> static void io_sq_thread_stop(struct io_ring_ctx *ctx)
> {
> 	if (ctx->sqo_thread) {
> -		wait_for_completion(&ctx->sqo_thread_started);
> +		wait_for_completion(ctx->sqo_done);
> 		/*
> 		 * The park is a bit of a work-around, without it we get
> 		 * warning spews on shutdown with SQPOLL set and affinity
> @@ -4098,6 +4106,8 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
> 		io_unaccount_mem(ctx->user,
> 				ring_pages(ctx->sq_entries, ctx->cq_entries));
> 	free_uid(ctx->user);
> +	kfree(ctx->ctx_done);
> +	kfree(ctx->sqo_done);
> 	kfree(ctx);
> }
> 
> @@ -4141,7 +4151,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
> 		io_wq_cancel_all(ctx->io_wq);
> 
> 	io_iopoll_reap_events(ctx);
> -	wait_for_completion(&ctx->ctx_done);
> +	wait_for_completion(ctx->ctx_done);
> 	io_ring_ctx_free(ctx);
> }
> 
> @@ -4545,7 +4555,7 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
> 	 * no new references will come in after we've killed the percpu ref.
> 	 */
> 	mutex_unlock(&ctx->uring_lock);
> -	wait_for_completion(&ctx->ctx_done);
> +	wait_for_completion(ctx->ctx_done);
> 	mutex_lock(&ctx->uring_lock);
> 
> 	switch (opcode) {
> @@ -4588,7 +4598,7 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
> 	}
> 
> 	/* bring the ctx back to life */
> -	reinit_completion(&ctx->ctx_done);
> +	reinit_completion(ctx->ctx_done);
> 	percpu_ref_reinit(&ctx->refs);
> 	return ret;
> }

This patch looks good, but I prefer sqo_thread_started instead of sqo_done,
because we are marking the thread started, not the end of the thread.

Anyway, Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>

--
BR, Jackie Liu



