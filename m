Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVAMJps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVAMJps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 04:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVAMJpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 04:45:47 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:42925 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261509AbVAMJpY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 04:45:24 -0500
Date: Thu, 13 Jan 2005 11:45:32 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <roland@topspin.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] [PATCH][5/18] InfiniBand/mthca: add needed rmb() in event queue poll
Message-ID: <20050113094532.GA31298@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20051121347.kR765yQEXhqhoLHL@topspin.com> <20051121347.vxtR3merv690zIQY@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121347.vxtR3merv690zIQY@topspin.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Roland Dreier (roland@topspin.com) "[openib-general] [PATCH][5/18] InfiniBand/mthca: add needed rmb() in event queue poll":
> Add an rmb() between checking the ownership bit of an event queue
> entry and reading the contents of the EQE.  Without this barrier, the
> CPU could read stale contents of the EQE before HW writes the EQE but
> have the read of the ownership bit reordered until after HW finishes
> writing, which leads to the driver processing an incorrect event. This
> was actually observed to happen when multiple completion queues are in
> heavy use on an IBM JS20 PowerPC 970 system.
> 
> Also explain the existing rmb() in completion queue poll (there for
> the same reason) and slightly improve debugging output.
> 
> Signed-off-by: Roland Dreier <roland@topspin.com>
> 
> --- linux/drivers/infiniband/hw/mthca/mthca_cq.c	(revision 1437)
> +++ linux/drivers/infiniband/hw/mthca/mthca_cq.c	(revision 1439)
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2004 Topspin Communications.  All rights reserved.
> + * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
>   *
>   * This software is available to you under a choice of one of two
>   * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -391,6 +391,10 @@
>  	if (!next_cqe_sw(cq))
>  		return -EAGAIN;
>  
> +	/*
> +	 * Make sure we read CQ entry contents after we've checked the
> +	 * ownership bit.
> +	 */
>  	rmb();
>  
>  	cqe = get_cqe(cq, cq->cons_index);
> @@ -768,7 +772,8 @@
>  		u32 *ctx = MAILBOX_ALIGN(mailbox);
>  		int j;
>  
> -		printk(KERN_ERR "context for CQN %x\n", cq->cqn);
> +		printk(KERN_ERR "context for CQN %x (cons index %x, next sw %d)\n",
> +		       cq->cqn, cq->cons_index, next_cqe_sw(cq));
>  		for (j = 0; j < 16; ++j)
>  			printk(KERN_ERR "[%2x] %08x\n", j * 4, be32_to_cpu(ctx[j]));
>  	}
> --- linux/drivers/infiniband/hw/mthca/mthca_eq.c	(revision 1437)
> +++ linux/drivers/infiniband/hw/mthca/mthca_eq.c	(revision 1439)
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2004 Topspin Communications.  All rights reserved.
> + * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
>   *
>   * This software is available to you under a choice of one of two
>   * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -240,6 +240,12 @@
>  		int set_ci = 0;
>  		eqe = get_eqe(eq, eq->cons_index);
>  
> +		/*
> +		 * Make sure we read EQ entry contents after we've
> +		 * checked the ownership bit.
> +		 */
> +		rmb();
> +
>  		switch (eqe->type) {
>  		case MTHCA_EVENT_TYPE_COMP:
>  			disarm_cqn = be32_to_cpu(eqe->event.comp.cqn) & 0xffffff;

Since we are using the eqe here, it seems that read_barrier_depends
shall be sufficient (as well as in the cq case)?

However, I see that read_barrier_depends is a nop on ppc, and the
comment indicates that problems were seen on ppc 970.
What gives? do I misunderstand what a dependency is?

MST
