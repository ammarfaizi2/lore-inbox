Return-Path: <linux-kernel-owner+w=401wt.eu-S1750826AbXACO4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbXACO4N (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 09:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbXACO4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 09:56:13 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:38932 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750790AbXACO4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 09:56:12 -0500
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
From: Steve Wise <swise@opengridcomputing.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rdreier@cisco.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20070103144153.GN6019@mellanox.co.il>
References: <1167834348.4187.3.camel@stevo-desktop>
	 <20070103144153.GN6019@mellanox.co.il>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 08:56:12 -0600
Message-Id: <1167836172.4187.9.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > It seems all Chelsio needs is to pass in a consumer index - so, how about a new
> > > entry point? Something like void set_cq_udata(struct ib_cq *cq, struct ib_udata *udata)?
> > > 
> > 
> > Adding a new entry point would hurt chelsio's user mode performance if
> > if then requires 2 kernel transitions to rearm the cq.  
> 
> No, it won't need 2 transitions - just an extra function call,
> so it won't hurt performance - it would improve performance.
> 
> ib_uverbs_req_notify_cq would call
> 
> 	ib_uverbs_req_notify_cq()
> 	{
> 			ib_set_cq_udata(cq, udata)
> 			ib_req_notify_cq(cq, cmd.solicited_only ?
> 				IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
> 	}
> 

ib_set_cq_udata() would transition into the kernel to pass in the
consumer's index.  In addition, ib_req_notify_cq would also transition
into the kernel since its not a bypass function for chelsio.

> This way kernel consumers don't incur any overhead,
> and in userspace users extra function call is dwarfed
> by system call overhead.
> 
> > Passing in user data is sort of SOP for these sorts of verbs.  
> 
> I don't see other examples. Where we did pass extra user data
> is in non-data pass verbs such as create QP.
> 
> This is most inner tight loop in many ULPs, so we should be very careful
> about adding code there - these things do add up.
> See recent IRQ API update in kernel.

Roland, do you have any comments on this?  You previously indicated
these patches were good to go once chelsio's ethernet driver gets pulled
in. 

> > How much does passing one more param cost for kernel users?  
> 
> Donnu. I just reviewed the code.
> It really should be up to patch submitter to check the performance
> effect of his patch, if there might be any.

I've run this code with mthca and didn't notice any performance
degradation, but I wasn't specifically measuring cq_poll overhead in a
tight loop...






