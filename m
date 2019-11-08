Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE40EC43331
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA2820674
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BsYr4xJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfKHAfU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:35:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38199 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfKHAfT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 19:35:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so3567679pfp.5
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 16:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mbrMZz4bbTdmfnVgj3z/3Inr3TH+sGUVXtg9X7cyhR4=;
        b=BsYr4xJ9EMg2BcPd34MdRf/bvyv/2Cej39BEfknRMhw68LFS7PJeBNIlaVSLyKBbFk
         wSkDVABlc3eOgww+zYHbob/mXb0gUTu5v1uv+8jexVVckoAWNWgMn15TDQ/JmGQt4i+f
         17P/U7MJS4iUdLctSL9EGd9O9PwWhqGjaOw+eGKkIjeJJmz/5PoRsqWZKOy9rsg2OWJn
         52c6tTjRUE5PMBwUkuRsfrKDtvQKqryrVEI4ytj5OVk/3kaSnFiB+6BvNQyUJXeWHOQE
         tKNiA/tXY+JhfOcdPt9Yn9D2PPrePdCQ0bhbl98OgoTOpA9DL9dKPTBW+muq65i86R1+
         7cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mbrMZz4bbTdmfnVgj3z/3Inr3TH+sGUVXtg9X7cyhR4=;
        b=jQsy5THm2CHgoXAb//YQHUBImn70tgbhzWa3NAdCs90w/h8a4SLq3z/4903kgwATAl
         rugJ8GJ4TcA96p0QpA7PmOkCyb4Edf3yK7KedbFRQnuNzXGLF0lYhPYs3fSjr7Kt/TKS
         okfLSZ6IAxoKl/zHy9GRHCSOVEh7CtWTqlUMnt0BtE9Kzccyw1Eh+VRtPljeidR9Ot0n
         dfAAVjPskM9YR5fqxeMELuUohA7JoSciMdv5bE24Z+lyG0RryEmAM1fmmGHKYH7/1u1l
         Wy9SbuMUXXaDOwuWN1y/RAGChEI2sDD/C0Y6CIqLVppbybqosOOZxVSLfTUA/TcRIfpd
         Pi+A==
X-Gm-Message-State: APjAAAUfnhYy5m5/3uUzEC0gJGBWQsygUT0kTckRuIOMq4T+oPzC/uOp
        abcyQKp+xfsKuKHKSQQUOzhiIGVHe0w=
X-Google-Smtp-Source: APXvYqxnRD+Ze6FG87Gbt6VrTDO1kHO6V4VIYhEM7EOdv2ooCVRXnT8Mai01geL37ILLi9W6GIUAIQ==
X-Received: by 2002:a63:6744:: with SMTP id b65mr8216669pgc.13.1573173316934;
        Thu, 07 Nov 2019 16:35:16 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 9sm3249227pfn.113.2019.11.07.16.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 16:35:15 -0800 (PST)
Subject: Re: [PATCH] io_uring: reduce/pack size of io_ring_ctx
From:   Jens Axboe <axboe@kernel.dk>
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1031c163-abd1-f42c-370d-8801f5fd2440@kernel.dk>
 <EB274748-0796-4D09-A568-D7A16A0C22D7@kylinos.cn>
 <253b27a9-55a2-c88e-3ccb-625c104934bb@kernel.dk>
Message-ID: <2b059341-09f7-3810-435c-ef749cafedef@kernel.dk>
Date:   Thu, 7 Nov 2019 17:35:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <253b27a9-55a2-c88e-3ccb-625c104934bb@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/7/19 5:06 PM, Jens Axboe wrote:
> On 11/7/19 5:00 PM, Jackie Liu wrote:
>> This patch looks good, but I prefer sqo_thread_started instead of sqo_done,
>> because we are marking the thread started, not the end of the thread.
>>
>> Anyway, Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>
> 
> Yeah, let's retain the old name. I'll make that change and add your
> reviewed-by, thanks.

Actually, would you mind if we just make it ->completions[2] instead?
That saves a kmalloc per ctx setup, I think that's worthwhile enough
to bundle them together:


commit 3b830211e99976650d5da0613dfca105c5007f8b
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Nov 7 17:27:39 2019 -0700

    io_uring: reduce/pack size of io_ring_ctx
    
    With the recent flurry of additions and changes to io_uring, the
    layout of io_ring_ctx has become a bit stale. We're right now at
    704 bytes in size on my x86-64 build, or 11 cachelines. This
    patch does two things:
    
    - We have to completion structs embedded, that we only use for
      quiesce of the ctx (or shutdown) and for sqthread init cases.
      That 2x32 bytes right there, let's dynamically allocate them.
    
    - Reorder the struct a bit with an eye on cachelines, use cases,
      and holes.
    
    With this patch, we're down to 512 bytes, or 8 cachelines.
    
    Reviewed-by: Jackie Liu <liuyun01@kylinos.cn>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4c488bf6e889..2b784262eaff 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -213,24 +213,13 @@ struct io_ring_ctx {
 		wait_queue_head_t	inflight_wait;
 	} ____cacheline_aligned_in_smp;
 
+	struct io_rings	*rings;
+
 	/* IO offload */
 	struct io_wq		*io_wq;
 	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
 	wait_queue_head_t	sqo_wait;
-	struct completion	sqo_thread_started;
-
-	struct {
-		unsigned		cached_cq_tail;
-		unsigned		cq_entries;
-		unsigned		cq_mask;
-		atomic_t		cq_timeouts;
-		struct wait_queue_head	cq_wait;
-		struct fasync_struct	*cq_fasync;
-		struct eventfd_ctx	*cq_ev_fd;
-	} ____cacheline_aligned_in_smp;
-
-	struct io_rings	*rings;
 
 	/*
 	 * If used, fixed file set. Writers must ensure that ->refs is dead,
@@ -246,7 +235,22 @@ struct io_ring_ctx {
 
 	struct user_struct	*user;
 
-	struct completion	ctx_done;
+	/* 0 is for ctx quiesce/reinit/free, 1 is for sqo_thread started */
+	struct completion	*completions;
+
+#if defined(CONFIG_UNIX)
+	struct socket		*ring_sock;
+#endif
+
+	struct {
+		unsigned		cached_cq_tail;
+		unsigned		cq_entries;
+		unsigned		cq_mask;
+		atomic_t		cq_timeouts;
+		struct wait_queue_head	cq_wait;
+		struct fasync_struct	*cq_fasync;
+		struct eventfd_ctx	*cq_ev_fd;
+	} ____cacheline_aligned_in_smp;
 
 	struct {
 		struct mutex		uring_lock;
@@ -268,10 +272,6 @@ struct io_ring_ctx {
 		spinlock_t		inflight_lock;
 		struct list_head	inflight_list;
 	} ____cacheline_aligned_in_smp;
-
-#if defined(CONFIG_UNIX)
-	struct socket		*ring_sock;
-#endif
 };
 
 struct sqe_submit {
@@ -396,7 +396,7 @@ static void io_ring_ctx_ref_free(struct percpu_ref *ref)
 {
 	struct io_ring_ctx *ctx = container_of(ref, struct io_ring_ctx, refs);
 
-	complete(&ctx->ctx_done);
+	complete(&ctx->completions[0]);
 }
 
 static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
@@ -407,17 +407,19 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (!ctx)
 		return NULL;
 
+	ctx->completions = kmalloc(2 * sizeof(struct completion), GFP_KERNEL);
+	if (!ctx->completions)
+		goto err;
+
 	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free,
-			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
-		kfree(ctx);
-		return NULL;
-	}
+			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
+		goto err;
 
 	ctx->flags = p->flags;
 	init_waitqueue_head(&ctx->cq_wait);
 	INIT_LIST_HEAD(&ctx->cq_overflow_list);
-	init_completion(&ctx->ctx_done);
-	init_completion(&ctx->sqo_thread_started);
+	init_completion(&ctx->completions[0]);
+	init_completion(&ctx->completions[1]);
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->wait);
 	spin_lock_init(&ctx->completion_lock);
@@ -429,6 +431,10 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	spin_lock_init(&ctx->inflight_lock);
 	INIT_LIST_HEAD(&ctx->inflight_list);
 	return ctx;
+err:
+	kfree(ctx->completions);
+	kfree(ctx);
+	return NULL;
 }
 
 static inline bool __io_sequence_defer(struct io_ring_ctx *ctx,
@@ -3065,7 +3071,7 @@ static int io_sq_thread(void *data)
 	unsigned inflight;
 	unsigned long timeout;
 
-	complete(&ctx->sqo_thread_started);
+	complete(&ctx->completions[1]);
 
 	old_fs = get_fs();
 	set_fs(USER_DS);
@@ -3304,7 +3310,7 @@ static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 {
 	if (ctx->sqo_thread) {
-		wait_for_completion(&ctx->sqo_thread_started);
+		wait_for_completion(&ctx->completions[1]);
 		/*
 		 * The park is a bit of a work-around, without it we get
 		 * warning spews on shutdown with SQPOLL set and affinity
@@ -4126,6 +4132,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		io_unaccount_mem(ctx->user,
 				ring_pages(ctx->sq_entries, ctx->cq_entries));
 	free_uid(ctx->user);
+	kfree(ctx->completions);
 	kfree(ctx);
 }
 
@@ -4169,7 +4176,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 		io_wq_cancel_all(ctx->io_wq);
 
 	io_iopoll_reap_events(ctx);
-	wait_for_completion(&ctx->ctx_done);
+	wait_for_completion(&ctx->completions[0]);
 	io_ring_ctx_free(ctx);
 }
 
@@ -4573,7 +4580,7 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 	 * no new references will come in after we've killed the percpu ref.
 	 */
 	mutex_unlock(&ctx->uring_lock);
-	wait_for_completion(&ctx->ctx_done);
+	wait_for_completion(&ctx->completions[0]);
 	mutex_lock(&ctx->uring_lock);
 
 	switch (opcode) {
@@ -4616,7 +4623,7 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 	}
 
 	/* bring the ctx back to life */
-	reinit_completion(&ctx->ctx_done);
+	reinit_completion(&ctx->completions[0]);
 	percpu_ref_reinit(&ctx->refs);
 	return ret;
 }

-- 
Jens Axboe

