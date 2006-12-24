Return-Path: <linux-kernel-owner+w=401wt.eu-S1754213AbWLXJOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbWLXJOS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 04:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbWLXJOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 04:14:18 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:35861 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbWLXJOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 04:14:16 -0500
X-Greylist: delayed 1367 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 04:14:13 EST
Date: Sun, 24 Dec 2006 10:49:25 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
Message-ID: <20061224084925.GD15106@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061214135233.21159.78613.stgit@dell3.ogc.int> <20061214135303.21159.61880.stgit@dell3.ogc.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214135303.21159.61880.stgit@dell3.ogc.int>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
> index 283d50b..15cbd49 100644
> --- a/drivers/infiniband/hw/mthca/mthca_cq.c
> +++ b/drivers/infiniband/hw/mthca/mthca_cq.c
> @@ -722,7 +722,8 @@ repoll:
>  	return err == 0 || err == -EAGAIN ? npolled : err;
>  }
>  
> -int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify)
> +int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify, 
> +		       struct ib_udata *udata)
>  {
>  	__be32 doorbell[2];
>  
> @@ -739,7 +740,8 @@ int mthca_tavor_arm_cq(struct ib_cq *cq,
>  	return 0;
>  }
>  
> -int mthca_arbel_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify)
> +int mthca_arbel_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify notify,
> +		       struct ib_udata *udata)
>  {
>  	struct mthca_cq *cq = to_mcq(ibcq);
>  	__be32 doorbell[2];
> diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
> index fe5cecf..6b9ccf6 100644
> --- a/drivers/infiniband/hw/mthca/mthca_dev.h
> +++ b/drivers/infiniband/hw/mthca/mthca_dev.h
> @@ -493,8 +493,8 @@ void mthca_unmap_eq_icm(struct mthca_dev
>  
>  int mthca_poll_cq(struct ib_cq *ibcq, int num_entries,
>  		  struct ib_wc *entry);
> -int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
> -int mthca_arbel_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify);
> +int mthca_tavor_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify, struct ib_udata *udata);
> +int mthca_arbel_arm_cq(struct ib_cq *cq, enum ib_cq_notify notify, struct ib_udata *udata);
>  int mthca_init_cq(struct mthca_dev *dev, int nent,
>  		  struct mthca_ucontext *ctx, u32 pdn,
>  		  struct mthca_cq *cq);
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 8eacc35..e3e1a2c 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -941,7 +941,8 @@ struct ib_device {
>  					      struct ib_wc *wc);
>  	int                        (*peek_cq)(struct ib_cq *cq, int wc_cnt);
>  	int                        (*req_notify_cq)(struct ib_cq *cq,
> -						    enum ib_cq_notify cq_notify);
> +						    enum ib_cq_notify cq_notify,
> +						    struct ib_udata *udata);
>  	int                        (*req_ncomp_notif)(struct ib_cq *cq,
>  						      int wc_cnt);
>  	struct ib_mr *             (*get_dma_mr)(struct ib_pd *pd,
> @@ -1373,7 +1374,7 @@ int ib_peek_cq(struct ib_cq *cq, int wc_
>  static inline int ib_req_notify_cq(struct ib_cq *cq,
>  				   enum ib_cq_notify cq_notify)
>  {
> -	return cq->device->req_notify_cq(cq, cq_notify);
> +	return cq->device->req_notify_cq(cq, cq_notify, NULL);
>  }
>  
>  /**

Can't say I like this adding overhead in data path operations (and note this
can't be optimized out). And kernel consumers work without passing it in, so it
hurts kernel code even for Chelsio. Granted, the cost is small here, but these
things do tend to add up.

It seems all Chelsio needs is to pass in a consumer index - so, how about a new
entry point? Something like void set_cq_udata(struct ib_cq *cq, struct ib_udata *udata)?

-- 
MST
