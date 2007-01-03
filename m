Return-Path: <linux-kernel-owner+w=401wt.eu-S932078AbXACUU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbXACUU1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbXACUU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:20:26 -0500
Received: from rrcs-24-153-217-226.sw.biz.rr.com ([24.153.217.226]:37338 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932078AbXACUUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:20:18 -0500
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
From: Steve Wise <swise@opengridcomputing.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20070103193324.GD29003@mellanox.co.il>
References: <1167851839.4187.36.camel@stevo-desktop>
	 <20070103193324.GD29003@mellanox.co.il>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 14:20:18 -0600
Message-Id: <1167855618.4187.65.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 21:33 +0200, Michael S. Tsirkin wrote:
> > Without extra param (1000 iterations in cycles): 
> > 	ave 101.283 min 91 max 247
> > With extra param (1000 iterations in cycles):
> > 	ave 103.311 min 91 max 221
> 
> A 2% hit then. Not huge, but 0 either.
> 
> > Convert cycles to ns (3466.727 MHz CPU):
> > 
> > Without: 101.283 / 3466.727 = .02922us == 29.22ns
> > With:    103.311 / 3466.727 = .02980us == 29.80ns
> > 
> > So I measure a .58ns average increase for passing in the additional
> > parameter.
> 
> That depends on CPU speed though. Percentage is likely to be more universal.
> 
> > Here is a snipit of the test:
> > 
> >         spin_lock_irq(&lock);
> >         do_gettimeofday(&start_tv);
> >         for (i=0; i<1000; i++) {
> >                 cycles_start[i] = get_cycles();
> >                 ib_req_notify_cq(cb->cq, IB_CQ_NEXT_COMP);
> >                 cycles_stop[i] = get_cycles();
> >         }
> >         do_gettimeofday(&stop_tv);
> >         spin_unlock_irq(&lock);
> > 
> >         if (stop_tv.tv_usec < start_tv.tv_usec) {
> >                 stop_tv.tv_usec += 1000000;
> >                 stop_tv.tv_sec  -= 1;
> >         }
> > 
> >         for (i=0; i < 1000; i++) {
> >                 cycles_t v = cycles_stop[i] - cycles_start[i];
> >                 sum += v;
> >                 if (v > max)
> >                         max = v;
> >                 if (min == 0 || v < min)
> >                         min = v;
> >         }
> > 
> >         printk(KERN_ERR PFX "FOO delta sec %lu usec %lu sum %llu min %llu max %llu\n",
> >                 stop_tv.tv_sec - start_tv.tv_sec,
> >                 stop_tv.tv_usec - start_tv.tv_usec,
> >                 (unsigned long long)sum, (unsigned long long)min,
> >                 (unsigned long long)max);
> 
> Good job, the test looks good, thanks.
> 
> So what does this tell you?
> To me it looks like there's a measurable speed difference,
> and so we should find a way (e.g. what I proposed) to enable chelsio userspace
> without adding overhead to other low level drivers or indeed chelsio kernel level code.
> 
> What do you think? Roland?
> 

I think having a 2nd function to set the udata seems onerous.


