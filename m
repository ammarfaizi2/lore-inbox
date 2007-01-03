Return-Path: <linux-kernel-owner+w=401wt.eu-S1750824AbXACOnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbXACOnz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbXACOny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:43:54 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:36486 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbXACOnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:43:52 -0500
Date: Wed, 3 Jan 2007 16:41:53 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Steve Wise <swise@opengridcomputing.com>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
Message-ID: <20070103144153.GN6019@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1167834348.4187.3.camel@stevo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167834348.4187.3.camel@stevo-desktop>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > @@ -1373,7 +1374,7 @@ int ib_peek_cq(struct ib_cq *cq, int wc_
> > >  static inline int ib_req_notify_cq(struct ib_cq *cq,
> > >  				   enum ib_cq_notify cq_notify)
> > >  {
> > > -	return cq->device->req_notify_cq(cq, cq_notify);
> > > +	return cq->device->req_notify_cq(cq, cq_notify, NULL);
> > >  }
> > >  
> > >  /**
> > 
> > Can't say I like this adding overhead in data path operations (and note this
> > can't be optimized out). And kernel consumers work without passing it in, so it
> > hurts kernel code even for Chelsio. Granted, the cost is small here, but these
> > things do tend to add up.
> > 
> > It seems all Chelsio needs is to pass in a consumer index - so, how about a new
> > entry point? Something like void set_cq_udata(struct ib_cq *cq, struct ib_udata *udata)?
> > 
> 
> Adding a new entry point would hurt chelsio's user mode performance if
> if then requires 2 kernel transitions to rearm the cq.  

No, it won't need 2 transitions - just an extra function call,
so it won't hurt performance - it would improve performance.

ib_uverbs_req_notify_cq would call

	ib_uverbs_req_notify_cq()
	{
			ib_set_cq_udata(cq, udata)
			ib_req_notify_cq(cq, cmd.solicited_only ?
				IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
	}

This way kernel consumers don't incur any overhead,
and in userspace users extra function call is dwarfed
by system call overhead.

> Passing in user data is sort of SOP for these sorts of verbs.  

I don't see other examples. Where we did pass extra user data
is in non-data pass verbs such as create QP.

This is most inner tight loop in many ULPs, so we should be very careful
about adding code there - these things do add up.
See recent IRQ API update in kernel.

> How much does passing one more param cost for kernel users?  

Donnu. I just reviewed the code.
It really should be up to patch submitter to check the performance
effect of his patch, if there might be any.

-- 
MST
