Return-Path: <linux-kernel-owner+w=401wt.eu-S1751091AbXACTdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbXACTdJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbXACTdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:33:09 -0500
Received: from p02c11o145.mxlogic.net ([208.65.145.68]:45096 "EHLO
	p02c11o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbXACTdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:33:07 -0500
Date: Wed, 3 Jan 2007 21:33:24 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Steve Wise <swise@opengridcomputing.com>
Cc: netdev@vger.kernel.org, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH  v4 01/13] Linux RDMA Core Changes
Message-ID: <20070103193324.GD29003@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1167851839.4187.36.camel@stevo-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167851839.4187.36.camel@stevo-desktop>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 03 Jan 2007 19:34:32.0564 (UTC) FILETIME=[316F6340:01C72F6E]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14912.003
X-TM-AS-Result: No--0.603600-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Without extra param (1000 iterations in cycles): 
> 	ave 101.283 min 91 max 247
> With extra param (1000 iterations in cycles):
> 	ave 103.311 min 91 max 221

A 2% hit then. Not huge, but 0 either.

> Convert cycles to ns (3466.727 MHz CPU):
> 
> Without: 101.283 / 3466.727 = .02922us == 29.22ns
> With:    103.311 / 3466.727 = .02980us == 29.80ns
> 
> So I measure a .58ns average increase for passing in the additional
> parameter.

That depends on CPU speed though. Percentage is likely to be more universal.

> Here is a snipit of the test:
> 
>         spin_lock_irq(&lock);
>         do_gettimeofday(&start_tv);
>         for (i=0; i<1000; i++) {
>                 cycles_start[i] = get_cycles();
>                 ib_req_notify_cq(cb->cq, IB_CQ_NEXT_COMP);
>                 cycles_stop[i] = get_cycles();
>         }
>         do_gettimeofday(&stop_tv);
>         spin_unlock_irq(&lock);
> 
>         if (stop_tv.tv_usec < start_tv.tv_usec) {
>                 stop_tv.tv_usec += 1000000;
>                 stop_tv.tv_sec  -= 1;
>         }
> 
>         for (i=0; i < 1000; i++) {
>                 cycles_t v = cycles_stop[i] - cycles_start[i];
>                 sum += v;
>                 if (v > max)
>                         max = v;
>                 if (min == 0 || v < min)
>                         min = v;
>         }
> 
>         printk(KERN_ERR PFX "FOO delta sec %lu usec %lu sum %llu min %llu max %llu\n",
>                 stop_tv.tv_sec - start_tv.tv_sec,
>                 stop_tv.tv_usec - start_tv.tv_usec,
>                 (unsigned long long)sum, (unsigned long long)min,
>                 (unsigned long long)max);

Good job, the test looks good, thanks.

So what does this tell you?
To me it looks like there's a measurable speed difference,
and so we should find a way (e.g. what I proposed) to enable chelsio userspace
without adding overhead to other low level drivers or indeed chelsio kernel level code.

What do you think? Roland?

-- 
MST
