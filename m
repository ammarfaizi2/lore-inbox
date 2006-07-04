Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWGDHEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWGDHEm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWGDHEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:04:42 -0400
Received: from mxl145v66.mxlogic.net ([208.65.145.66]:62167 "EHLO
	p02c11o143.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751047AbWGDHEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:04:41 -0400
Date: Tue, 4 Jul 2006 10:03:28 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Zach Brown <zach.brown@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] mthca: initialize send and receive queue locks separately
Message-ID: <20060704070328.GG21049@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060703225019.7379.96075.sendpatchset@tetsuo.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703225019.7379.96075.sendpatchset@tetsuo.zabbo.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 04 Jul 2006 07:08:11.0187 (UTC) FILETIME=[9C0F4830:01C69F38]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [63.251.237.3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Zach Brown <zach.brown@oracle.com>:
> Subject: [PATCH] mthca: initialize send and receive queue locks separately
> 
> mthca: initialize send and receive queue locks separately
> 
> lockdep identifies a lock by the call site of its initialization.  By
> initializing the send and receive queue locks in mthca_wq_init() we confuse
> lockdep.  It warns that that the ordered acquiry of both locks in
> mthca_modify_qp() is recursive acquiry of one lock:
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> modprobe/1192 is trying to acquire lock:
>  (&wq->lock){....}, at: [<f892b4db>] mthca_modify_qp+0x60/0xa7b [ib_mthca]
> but task is already holding lock:
>  (&wq->lock){....}, at: [<f892b4ce>] mthca_modify_qp+0x53/0xa7b [ib_mthca]

Is this mthca code unique?
Would not it be better to teach lockdep about this scenario somehow?

> Initializing the locks separately in mthca_alloc_qp_common() stops the warning
> and will let lockdep enforce proper ordering on paths that acquire both locks.
> 
> Signed-off-by: Zach Brown <zach.brown@oracle.com>

This moves code out of a common function and so results in code duplication
and has memory cost.

> ---
> 
>  drivers/infiniband/hw/mthca/mthca_qp.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> Index: 2.6.17-mm6/drivers/infiniband/hw/mthca/mthca_qp.c
> ===================================================================
> --- 2.6.17-mm6.orig/drivers/infiniband/hw/mthca/mthca_qp.c	2006-07-03 08:41:16.000000000 -0400
> +++ 2.6.17-mm6/drivers/infiniband/hw/mthca/mthca_qp.c	2006-07-03 10:05:52.000000000 -0400
> @@ -224,7 +224,7 @@
>  
>  static void mthca_wq_init(struct mthca_wq *wq)
>  {
> -	spin_lock_init(&wq->lock);
> +	/* mthca_alloc_qp_common() initializes the locks */
>  	wq->next_ind  = 0;
>  	wq->last_comp = wq->max - 1;
>  	wq->head      = 0;

And then we'll have to remember to update this comment when lock
is moved to another place?

> @@ -1114,6 +1114,9 @@
>  	qp->sq_policy    = send_policy;
>  	mthca_wq_init(&qp->sq);
>  	mthca_wq_init(&qp->rq);
> +	/* these are initialized separately so lockdep can tell them apart */
> +	spin_lock_init(&qp->sq.lock);
> +	spin_lock_init(&qp->rq.lock);
>  
>  	ret = mthca_map_memfree(dev, qp);
>  	if (ret)
> 

Looks wrong, to me. Is it a good idea to fix correct code?
Assuming its important, can we maybe add some annotations to make lockdep shut
up, instead?

-- 
MST
