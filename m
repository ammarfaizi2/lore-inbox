Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWGDJpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWGDJpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 05:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWGDJpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 05:45:24 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:36758 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S932143AbWGDJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 05:45:22 -0400
Date: Tue, 4 Jul 2006 12:42:19 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zach Brown <zach.brown@oracle.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH] mthca: initialize send and receive queue locks separately
Message-ID: <20060704094219.GO21049@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060704085653.GA13426@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704085653.GA13426@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 04 Jul 2006 09:47:01.0906 (UTC) FILETIME=[CCCF9720:01C69F4E]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Ingo Molnar <mingo@elte.hu>:
> Subject: Re: [PATCH] mthca: initialize send and receive queue locks separately
> 
> 
> * Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> 
> > > Initializing the locks separately in mthca_alloc_qp_common() stops the warning
> > > and will let lockdep enforce proper ordering on paths that acquire both locks.
> > > 
> > > Signed-off-by: Zach Brown <zach.brown@oracle.com>
> > 
> > This moves code out of a common function and so results in code 
> > duplication and has memory cost.
> 
> the patch below does the same via the lockdep_set_class() method, which 
> has no cost on non-lockdep kernels.
> 
> 	Ingo
> 
> ---------------->
> Subject: lockdep: annotate drivers/infiniband/hw/mthca/mthca_qp.c
> From: Ingo Molnar <mingo@elte.hu>
> 
> annotate mthca queue locks: split them into send and receive locks.
> 
> (both can be held at once, but there is ordering between them which
> lockdep enforces)

I find this capability of lockdep very useful.

> Has no effect on non-lockdep kernels.

Hmm ... adding parameters to function still has text cost, I think. No?

> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  drivers/infiniband/hw/mthca/mthca_qp.c |   16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> Index: linux/drivers/infiniband/hw/mthca/mthca_qp.c
> ===================================================================
> --- linux.orig/drivers/infiniband/hw/mthca/mthca_qp.c
> +++ linux/drivers/infiniband/hw/mthca/mthca_qp.c
> @@ -222,9 +222,15 @@ static void *get_send_wqe(struct mthca_q
>  			 (PAGE_SIZE - 1));
>  }
>  
> -static void mthca_wq_init(struct mthca_wq *wq)
> +/*
> + * Send and receive queues for two different lock classes:
> + */
> +static struct lock_class_key mthca_wq_send_lock_class, mthca_wq_recv_lock_class;
> +

Does this still have a small cost in data size on non-lockdep kernels, as well?
If yes, maybe some typedef/macro magic can be used to put this struct in an
unused elf section for such kernels?

> +static void mthca_wq_init(struct mthca_wq *wq, struct lock_class_key *key)
>  {
>  	spin_lock_init(&wq->lock);
> +	lockdep_set_class(&wq->lock, key);
>  	wq->next_ind  = 0;
>  	wq->last_comp = wq->max - 1;
>  	wq->head      = 0;
> @@ -845,10 +851,10 @@ int mthca_modify_qp(struct ib_qp *ibqp, 
>  			mthca_cq_clean(dev, to_mcq(qp->ibqp.recv_cq), qp->qpn,
>  				       qp->ibqp.srq ? to_msrq(qp->ibqp.srq) : NULL);
>  
> -		mthca_wq_init(&qp->sq);
> +		mthca_wq_init(&qp->sq, &mthca_wq_send_lock_class);
>  		qp->sq.last = get_send_wqe(qp, qp->sq.max - 1);
>  
> -		mthca_wq_init(&qp->rq);
> +		mthca_wq_init(&qp->rq, &mthca_wq_recv_lock_class);
>  		qp->rq.last = get_recv_wqe(qp, qp->rq.max - 1);
>  
>  		if (mthca_is_memfree(dev)) {
> @@ -1112,8 +1118,8 @@ static int mthca_alloc_qp_common(struct 
>  	qp->atomic_rd_en = 0;
>  	qp->resp_depth   = 0;
>  	qp->sq_policy    = send_policy;
> -	mthca_wq_init(&qp->sq);
> -	mthca_wq_init(&qp->rq);
> +	mthca_wq_init(&qp->sq, &mthca_wq_send_lock_class);
> +	mthca_wq_init(&qp->rq, &mthca_wq_recv_lock_class);
>  
>  	ret = mthca_map_memfree(dev, qp);
>  	if (ret)
> 
> 

I'm pretty sure this still adds to code footprint due to extra function
parameters even on non-lockdep kernels. Will the following work?

@@ -1112,8 +1118,8 @@ static int mthca_alloc_qp_common(struct 
 	qp->atomic_rd_en = 0;
 	qp->resp_depth   = 0;
 	qp->sq_policy    = send_policy;
	mthca_wq_init(&qp->sq);
+	lockdep_set_class(&qp->sq.lock, &mthca_wq_send_lock_class);
	mthca_wq_init(&qp->rq);
+	lockdep_set_class(&qp->rq.lock, &mthca_wq_recv_lock_class);

-- 
MST
