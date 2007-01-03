Return-Path: <linux-kernel-owner+w=401wt.eu-S1751085AbXACTRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbXACTRV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbXACTRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:17:20 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:34768 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062AbXACTRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:17:20 -0500
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
From: Steve Wise <swise@opengridcomputing.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20070103151823.GR6019@mellanox.co.il>
References: <1167836172.4187.9.camel@stevo-desktop>
	 <20070103150013.GO6019@mellanox.co.il>
	 <1167836841.4187.18.camel@stevo-desktop>
	 <20070103151823.GR6019@mellanox.co.il>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 13:17:19 -0600
Message-Id: <1167851839.4187.36.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > ib_set_cq_udata() would transition into the kernel to pass in the
> > > > consumer's index.  In addition, ib_req_notify_cq would also transition
> > > > into the kernel since its not a bypass function for chelsio.
> > > 
> > > We misunderstand each other.
> > > 
> > > ib_uverbs_req_notify_cq is in drivers/infiniband/core/uverbs_cmd.c -
> > > all this code runs inside the IB_USER_VERBS_CMD_REQ_NOTIFY_CQ command,
> > > so there is a single user to kernel transition.
> > > 
> > 
> > Oh I see. 
> > 
> > This seems like a lot of extra code to avoid passing one extra arg to
> > the driver's req_notify_cq verb.  I'd appreciate other folk's input on
> > how important they think this is.  
> >
> > If you insist, then I'll run some tests specifically in kernel mode and
> > see how this affects mthca's req_notify performance.
> 
> This might be an interesting datapoint.
> 

Here's what I measured:

Without extra param (1000 iterations in cycles): 
	ave 101.283 min 91 max 247
With extra param (1000 iterations in cycles):
	ave 103.311 min 91 max 221

Convert cycles to ns (3466.727 MHz CPU):

Without: 101.283 / 3466.727 = .02922us == 29.22ns
With:    103.311 / 3466.727 = .02980us == 29.80ns

So I measure a .58ns average increase for passing in the additional
parameter.

Here is a snipit of the test:

        spin_lock_irq(&lock);
        do_gettimeofday(&start_tv);
        for (i=0; i<1000; i++) {
                cycles_start[i] = get_cycles();
                ib_req_notify_cq(cb->cq, IB_CQ_NEXT_COMP);
                cycles_stop[i] = get_cycles();
        }
        do_gettimeofday(&stop_tv);
        spin_unlock_irq(&lock);

        if (stop_tv.tv_usec < start_tv.tv_usec) {
                stop_tv.tv_usec += 1000000;
                stop_tv.tv_sec  -= 1;
        }

        for (i=0; i < 1000; i++) {
                cycles_t v = cycles_stop[i] - cycles_start[i];
                sum += v;
                if (v > max)
                        max = v;
                if (min == 0 || v < min)
                        min = v;
        }

        printk(KERN_ERR PFX "FOO delta sec %lu usec %lu sum %llu min %llu max %llu\n",
                stop_tv.tv_sec - start_tv.tv_sec,
                stop_tv.tv_usec - start_tv.tv_usec,
                (unsigned long long)sum, (unsigned long long)min,
                (unsigned long long)max);



