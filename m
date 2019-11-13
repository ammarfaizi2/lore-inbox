Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE5CC432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298F7206DA
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573674960;
	bh=R5rl0dW62dymmcGMZKKYVdq30kiRhFA2lc1lrd3l03Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=j5QvoZWiay/hF0kn2dvzUyWpE92+p5HkhFcKdXHvLUbphSfxkbSB2ZO5uD6ENgOSH
	 d3qea2U8N4jLexFFGI6Gu6IqUB8O3b5WK5eRz8G677lqvAkMvpaLjeKpzR2hsrohmL
	 NQfQvjama3EURpNeza1kX5P2GqYfrWDdOPSHf878=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfKMTz7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfKMTz7 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Wed, 13 Nov 2019 14:55:59 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F3B206DA;
        Wed, 13 Nov 2019 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573674958;
        bh=R5rl0dW62dymmcGMZKKYVdq30kiRhFA2lc1lrd3l03Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UVID2DvmqMy52AgW1Mr/67PT2/y+PA3chiTLNIPR4IthTMUAZHp1ouYjWLYgZeQ+j
         sBMhTBVbycnsYIZz3O9U7xk4Rq5p12LyT45ioPAAl9bhYuRvVRgrm1iKxiaOC/TYk7
         Ct6QnAQgPVzOfgwqCcLryz5dmW6TZRor9ab1gq4A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1F15D352295B; Wed, 13 Nov 2019 11:55:57 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:55:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org
Subject: Re: [PATCH 2/2] io-wq: ensure task is valid before sending it a
 signal
Message-ID: <20191113195557.GG2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191113194355.12107-1-axboe@kernel.dk>
 <20191113194355.12107-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113194355.12107-3-axboe@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Nov 13, 2019 at 12:43:55PM -0700, Jens Axboe wrote:
> While we're always under RCU read protection when finding the worker
> to signal, that only protects the worker from being freed. The task
> could very well be exiting, if we get unlucky enough.
> 
> Same is true for ->cur_work, which is currently under protection by
> the wqe->lock that this worker belongs to. Add a specific worker lock
> that protects whether the task is exiting and also the current work
> item. Then we can guarantee that the task we're sending a signal is:
> 
> 1) Currently processing the exact work we think it is
> 2) It's not currently exiting
> 
> It's important to not use the wqe->lock for ->cur_work, as we can run
> into lock ordering issues with io_poll_wake() being called under the
> signal lock if we're polling a signal fd, and io_poll_wake() then
> needing to call io_wq_enqueue() which grabs wqe->lock. For cancel, the
> ordering is exactly the opposite.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  fs/io-wq.c | 66 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index 26d81540c1fc..f035460b9776 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -49,7 +49,10 @@ struct io_worker {
>  	struct task_struct *task;
>  	wait_queue_head_t wait;
>  	struct io_wqe *wqe;
> +
>  	struct io_wq_work *cur_work;
> +	spinlock_t lock;
> +	int exiting;
>  
>  	struct rcu_head rcu;
>  	struct mm_struct *mm;
> @@ -223,6 +226,10 @@ static void io_worker_exit(struct io_worker *worker)
>  	if (!nr_workers && refcount_dec_and_test(&wqe->wq->refs))
>  		complete(&wqe->wq->done);
>  
> +	spin_lock_irq(&worker->lock);
> +	worker->exiting = true;
> +	spin_unlock_irq(&worker->lock);
> +
>  	kfree_rcu(worker, rcu);
>  }
>  
> @@ -323,7 +330,6 @@ static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
>  		hlist_nulls_add_head_rcu(&worker->nulls_node,
>  						&wqe->busy_list.head);
>  	}
> -	worker->cur_work = work;
>  
>  	/*
>  	 * If worker is moving from bound to unbound (or vice versa), then
> @@ -402,17 +408,6 @@ static void io_worker_handle_work(struct io_worker *worker)
>  	do {
>  		unsigned hash = -1U;
>  
> -		/*
> -		 * Signals are either sent to cancel specific work, or to just
> -		 * cancel all work items. For the former, ->cur_work must
> -		 * match. ->cur_work is NULL at this point, since we haven't
> -		 * assigned any work, so it's safe to flush signals for that
> -		 * case. For the latter case of cancelling all work, the caller
> -		 * wil have set IO_WQ_BIT_CANCEL.
> -		 */
> -		if (signal_pending(current))
> -			flush_signals(current);
> -
>  		/*
>  		 * If we got some work, mark us as busy. If we didn't, but
>  		 * the list isn't empty, it means we stalled on hashed work.
> @@ -432,6 +427,14 @@ static void io_worker_handle_work(struct io_worker *worker)
>  		if (!work)
>  			break;
>  next:
> +		/* flush any pending signals before assigning new work */
> +		if (signal_pending(current))
> +			flush_signals(current);
> +
> +		spin_lock_irq(&worker->lock);
> +		worker->cur_work = work;
> +		spin_unlock_irq(&worker->lock);
> +
>  		if ((work->flags & IO_WQ_WORK_NEEDS_FILES) &&
>  		    current->files != work->files) {
>  			task_lock(current);
> @@ -457,8 +460,12 @@ static void io_worker_handle_work(struct io_worker *worker)
>  		old_work = work;
>  		work->func(&work);
>  
> -		spin_lock_irq(&wqe->lock);
> +		spin_lock_irq(&worker->lock);
>  		worker->cur_work = NULL;
> +		spin_unlock_irq(&worker->lock);
> +
> +		spin_lock_irq(&wqe->lock);
> +
>  		if (hash != -1U) {
>  			wqe->hash_map &= ~BIT_ULL(hash);
>  			wqe->flags &= ~IO_WQE_FLAG_STALLED;
> @@ -577,6 +584,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
>  	worker->nulls_node.pprev = NULL;
>  	init_waitqueue_head(&worker->wait);
>  	worker->wqe = wqe;
> +	spin_lock_init(&worker->lock);
>  
>  	worker->task = kthread_create_on_node(io_wqe_worker, worker, wqe->node,
>  				"io_wqe_worker-%d/%d", index, wqe->node);
> @@ -721,7 +729,10 @@ void io_wq_enqueue_hashed(struct io_wq *wq, struct io_wq_work *work, void *val)
>  
>  static bool io_wqe_worker_send_sig(struct io_worker *worker, void *data)
>  {
> -	send_sig(SIGINT, worker->task, 1);
> +	spin_lock_irq(&worker->lock);
> +	if (!worker->exiting)
> +		send_sig(SIGINT, worker->task, 1);
> +	spin_unlock_irq(&worker->lock);
>  	return false;
>  }
>  
> @@ -783,7 +794,6 @@ struct io_cb_cancel_data {
>  static bool io_work_cancel(struct io_worker *worker, void *cancel_data)
>  {
>  	struct io_cb_cancel_data *data = cancel_data;
> -	struct io_wqe *wqe = data->wqe;
>  	unsigned long flags;
>  	bool ret = false;
>  
> @@ -791,13 +801,14 @@ static bool io_work_cancel(struct io_worker *worker, void *cancel_data)
>  	 * Hold the lock to avoid ->cur_work going out of scope, caller
>  	 * may deference the passed in work.
>  	 */
> -	spin_lock_irqsave(&wqe->lock, flags);
> +	spin_lock_irqsave(&worker->lock, flags);
>  	if (worker->cur_work &&
>  	    data->cancel(worker->cur_work, data->caller_data)) {
> -		send_sig(SIGINT, worker->task, 1);
> +		if (!worker->exiting)
> +			send_sig(SIGINT, worker->task, 1);
>  		ret = true;
>  	}
> -	spin_unlock_irqrestore(&wqe->lock, flags);
> +	spin_unlock_irqrestore(&worker->lock, flags);
>  
>  	return ret;
>  }
> @@ -864,13 +875,21 @@ enum io_wq_cancel io_wq_cancel_cb(struct io_wq *wq, work_cancel_fn *cancel,
>  static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
>  {
>  	struct io_wq_work *work = data;
> +	unsigned long flags;
> +	bool ret = false;
> +
> +	if (worker->cur_work != work)
> +		return false;
>  
> +	spin_lock_irqsave(&worker->lock, flags);
>  	if (worker->cur_work == work) {
> -		send_sig(SIGINT, worker->task, 1);
> -		return true;
> +		if (!worker->exiting)
> +			send_sig(SIGINT, worker->task, 1);
> +		ret = true;
>  	}
> +	spin_unlock_irqrestore(&worker->lock, flags);
>  
> -	return false;
> +	return ret;
>  }
>  
>  static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
> @@ -1049,7 +1068,10 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
>  
>  static bool io_wq_worker_wake(struct io_worker *worker, void *data)
>  {
> -	wake_up_process(worker->task);
> +	spin_lock_irq(&worker->lock);
> +	if (!worker->exiting)
> +		wake_up_process(worker->task);
> +	spin_unlock_irq(&worker->lock);
>  	return false;
>  }
>  
> -- 
> 2.24.0
> 
