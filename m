Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVC2Jfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVC2Jfd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVC2Jfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:35:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33951 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262264AbVC2J21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:28:27 -0500
Date: Tue, 29 Mar 2005 11:28:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] use cheaper elv_queue_empty when unplug a device
Message-ID: <20050329092819.GK16636@suse.de>
References: <200503290253.j2T2rqg25691@unix-os.sc.intel.com> <20050329080646.GE16636@suse.de> <42491DBE.6020303@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42491DBE.6020303@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29 2005, Nick Piggin wrote:
> Jens Axboe wrote:
> >On Mon, Mar 28 2005, Chen, Kenneth W wrote:
> >
> >>This patch was posted last year and if I remember correctly, Jens said
> >>he is OK with the patch.  In function __generic_unplug_deivce(), kernel
> >>can use a cheaper function elv_queue_empty() instead of more expensive
> >>elv_next_request to find whether the queue is empty or not. blk_run_queue
> >>can also made conditional on whether queue's emptiness before calling
> >>request_fn().
> >>
> >>
> >>Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
> >
> >
> >Looks good, thanks.
> >
> >Signed-off-by: Jens Axboe <axboe@suse.de>
> >
> 
> Speaking of which, I've had a few ideas lying around for possible
> performance improvement in the block code.
> 
> I haven't used a big disk array (or tried any simulation), but I'll
> attach the patch if you're looking into that area.
> 
> It puts in a few unlikely()s, but the main changes are:
> - don't generic_unplug_device unconditionally in get_request_wait,
> - removes the relock/retry merge mechanism in __make_request if we
>   aren't able to get the GFP_ATOMIC allocation. Just fall through
>   and assume the chances of getting a merge will be small (is this
>   a valid assumption? Should measure it I guess).
> - removes the GFP_ATOMIC allocation. That's always a good thing.

Looks good, I've been toying with something very similar for a long time
myself.

The unplug change is a no-brainer. The retry stuff i __make_request()
will make no real difference on 'typical' hardware, when it was
introduced in 2.4.x it was very useful on slower devices like dvd-rams.
The batch wakeups should take care of this.

The atomic-vs-blocking allocation should be tested. I'd really like it
to be a "don't dive into the vm very much, just wait on the mempool"
type allocation, so we are not at the mercy of long vm reclaim times
hurting the latencies here.

-- 
Jens Axboe

