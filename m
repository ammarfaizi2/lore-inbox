Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263648AbTDXMgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 08:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTDXMgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 08:36:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17537 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263646AbTDXMgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 08:36:08 -0400
Date: Thu, 24 Apr 2003 13:48:16 +0100
From: Matthew Wilcox <willy@debian.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: bcrl@redhat.com, akpm@digeo.com, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: Filesystem AIO read-write patches
Message-ID: <20030424124816.GX3140@parcelfarce.linux.theplanet.co.uk>
References: <20030424102221.A2166@in.ibm.com> <20030424104103.C2288@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424104103.C2288@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:41:03AM +0530, Suparna Bhattacharya wrote:
> -void blk_congestion_wait(int rw, long timeout)
> +int blk_congestion_wait_wq(int rw, long timeout, wait_queue_t *wait)
>  {
> -	DEFINE_WAIT(wait);
>  	wait_queue_head_t *wqh = &congestion_wqh[rw];
> +	DEFINE_WAIT(local_wait);
> +
> +	if (!wait)
> +		wait = &local_wait;
>  
>  	blk_run_queues();
> -	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
> +	prepare_to_wait(wqh, wait, TASK_UNINTERRUPTIBLE);
> +	if (!is_sync_wait(wait)) 
> +		return -EIOCBRETRY;
> +
>  	io_schedule_timeout(timeout);
> -	finish_wait(wqh, &wait);
> +	finish_wait(wqh, wait);
> +	return 0;
> +}
> +
> +void blk_congestion_wait(int rw, long timeout)
> +{
> +	blk_congestion_wait_wq(rw, timeout, NULL);
>  }

I don't like this one.  DEFINE_WAIT allocates stuff on the stack.  
And aio seems to allocate a lot more on the stack than normal io does.
How about the following instead:

int blk_congestion_wait_wq(int rw, long timeout, wait_queue_t *wait)
{
 	wait_queue_head_t *wqh = &congestion_wqh[rw];

 	blk_run_queues();
	prepare_to_wait(wqh, wait, TASK_UNINTERRUPTIBLE);
	if (!is_sync_wait(wait)) 
		return -EIOCBRETRY;

	io_schedule_timeout(timeout);
	finish_wait(wqh, wait);
	return 0;
}

void blk_congestion_wait(int rw, long timeout)
{
	DEFINE_WAIT(wait);
	blk_congestion_wait_wq(rw, timeout, &wait);
}

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
