Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA58C43141
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 23:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3650206EC
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 23:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573688575;
	bh=5/Bz8qnfU1qVexRU1dimWeASPWGovi0BLjKGq37wwdc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qDScbGrWF/6eJmOCIPvVlZj5Z7OdFoGVzEfb7AmQZciJs+isyj9wlXryhRfIysJbX
	 e4oxNddHjh6lv5HRDGzPm8eDibkUSBePqJTpKUGw1PXYH6GydL0BSevp9iN+VBAuWt
	 UdMrVFd/ZhUoZpumgTrC+uJHzUI3SyFpzszvtu08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKMXmy (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 18:42:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfKMXmx (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Wed, 13 Nov 2019 18:42:53 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D057D206EC;
        Wed, 13 Nov 2019 23:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573688572;
        bh=5/Bz8qnfU1qVexRU1dimWeASPWGovi0BLjKGq37wwdc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AqjJpo2pjNkI8qxxTig09O/IK0uOPEInzIVJHlAOLuW5U3l7eOctdSIZKIVmmP8mB
         0Q4Jr2SRnhXqym1hyM9wfS+BPKNgu5wbHviiNImSNFJn0MBNZt/NCeWQLxso3MnxGu
         O+RzPX6Cs5Nyk57YgacL4Eyt25CcXgG2NWLlJO1Y=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DBEDA352295B; Wed, 13 Nov 2019 15:42:51 -0800 (PST)
Date:   Wed, 13 Nov 2019 15:42:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org
Subject: Re: [PATCH 3/3] io-wq: ensure free/busy list browsing see all items
Message-ID: <20191113234251.GH2865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191113213206.2415-1-axboe@kernel.dk>
 <20191113213206.2415-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113213206.2415-4-axboe@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Nov 13, 2019 at 02:32:06PM -0700, Jens Axboe wrote:
> We have two lists for workers in io-wq, a busy and a free list. For
> certain operations we want to browse all workers, and we currently do
> that by browsing the two separate lists. But since these lists are RCU
> protected, we can potentially miss workers if they move between the two
> lists while we're browsing them.
> 
> Add a third list, all_list, that simply holds all workers. A worker is
> added to that list when it starts, and removed when it exits. This makes
> the worker iteration cleaner, too.
> 
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

H/T to Olof for asking the question, by the way!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  fs/io-wq.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index 4031b75541be..fcb6c74209da 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -46,6 +46,7 @@ struct io_worker {
>  	refcount_t ref;
>  	unsigned flags;
>  	struct hlist_nulls_node nulls_node;
> +	struct list_head all_list;
>  	struct task_struct *task;
>  	wait_queue_head_t wait;
>  	struct io_wqe *wqe;
> @@ -96,6 +97,7 @@ struct io_wqe {
>  
>  	struct io_wq_nulls_list free_list;
>  	struct io_wq_nulls_list busy_list;
> +	struct list_head all_list;
>  
>  	struct io_wq *wq;
>  };
> @@ -212,6 +214,7 @@ static void io_worker_exit(struct io_worker *worker)
>  
>  	spin_lock_irq(&wqe->lock);
>  	hlist_nulls_del_rcu(&worker->nulls_node);
> +	list_del_rcu(&worker->all_list);
>  	if (__io_worker_unuse(wqe, worker)) {
>  		__release(&wqe->lock);
>  		spin_lock_irq(&wqe->lock);
> @@ -590,6 +593,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
>  
>  	spin_lock_irq(&wqe->lock);
>  	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list.head);
> +	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
>  	worker->flags |= IO_WORKER_F_FREE;
>  	if (index == IO_WQ_ACCT_BOUND)
>  		worker->flags |= IO_WORKER_F_BOUND;
> @@ -733,16 +737,13 @@ static bool io_wqe_worker_send_sig(struct io_worker *worker, void *data)
>   * worker that isn't exiting
>   */
>  static bool io_wq_for_each_worker(struct io_wqe *wqe,
> -				  struct io_wq_nulls_list *list,
>  				  bool (*func)(struct io_worker *, void *),
>  				  void *data)
>  {
> -	struct hlist_nulls_node *n;
>  	struct io_worker *worker;
>  	bool ret = false;
>  
> -restart:
> -	hlist_nulls_for_each_entry_rcu(worker, n, &list->head, nulls_node) {
> +	list_for_each_entry_rcu(worker, &wqe->all_list, all_list) {
>  		if (io_worker_get(worker)) {
>  			ret = func(worker, data);
>  			io_worker_release(worker);
> @@ -750,8 +751,7 @@ static bool io_wq_for_each_worker(struct io_wqe *wqe,
>  				break;
>  		}
>  	}
> -	if (!ret && get_nulls_value(n) != list->nulls)
> -		goto restart;
> +
>  	return ret;
>  }
>  
> @@ -769,10 +769,7 @@ void io_wq_cancel_all(struct io_wq *wq)
>  	for (i = 0; i < wq->nr_wqes; i++) {
>  		struct io_wqe *wqe = wq->wqes[i];
>  
> -		io_wq_for_each_worker(wqe, &wqe->busy_list,
> -					io_wqe_worker_send_sig, NULL);
> -		io_wq_for_each_worker(wqe, &wqe->free_list,
> -					io_wqe_worker_send_sig, NULL);
> +		io_wq_for_each_worker(wqe, io_wqe_worker_send_sig, NULL);
>  	}
>  	rcu_read_unlock();
>  }
> @@ -834,14 +831,7 @@ static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
>  	}
>  
>  	rcu_read_lock();
> -	found = io_wq_for_each_worker(wqe, &wqe->free_list, io_work_cancel,
> -					&data);
> -	if (found)
> -		goto done;
> -
> -	found = io_wq_for_each_worker(wqe, &wqe->busy_list, io_work_cancel,
> -					&data);
> -done:
> +	found = io_wq_for_each_worker(wqe, io_work_cancel, &data);
>  	rcu_read_unlock();
>  	return found ? IO_WQ_CANCEL_RUNNING : IO_WQ_CANCEL_NOTFOUND;
>  }
> @@ -919,14 +909,7 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
>  	 * completion will run normally in this case.
>  	 */
>  	rcu_read_lock();
> -	found = io_wq_for_each_worker(wqe, &wqe->free_list, io_wq_worker_cancel,
> -					cwork);
> -	if (found)
> -		goto done;
> -
> -	found = io_wq_for_each_worker(wqe, &wqe->busy_list, io_wq_worker_cancel,
> -					cwork);
> -done:
> +	found = io_wq_for_each_worker(wqe, io_wq_worker_cancel, cwork);
>  	rcu_read_unlock();
>  	return found ? IO_WQ_CANCEL_RUNNING : IO_WQ_CANCEL_NOTFOUND;
>  }
> @@ -1030,6 +1013,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
>  		wqe->free_list.nulls = 0;
>  		INIT_HLIST_NULLS_HEAD(&wqe->busy_list.head, 1);
>  		wqe->busy_list.nulls = 1;
> +		INIT_LIST_HEAD(&wqe->all_list);
>  
>  		i++;
>  	}
> @@ -1077,10 +1061,7 @@ void io_wq_destroy(struct io_wq *wq)
>  
>  		if (!wqe)
>  			continue;
> -		io_wq_for_each_worker(wqe, &wqe->free_list, io_wq_worker_wake,
> -						NULL);
> -		io_wq_for_each_worker(wqe, &wqe->busy_list, io_wq_worker_wake,
> -						NULL);
> +		io_wq_for_each_worker(wqe, io_wq_worker_wake, NULL);
>  	}
>  	rcu_read_unlock();
>  
> -- 
> 2.24.0
> 
