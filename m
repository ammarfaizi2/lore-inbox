Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbTJAIlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTJAIlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:41:11 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:40072 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262029AbTJAIlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:41:07 -0400
Date: Wed, 1 Oct 2003 14:16:39 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.0-test6-mm1] aio ref count in io_submit_one
Message-ID: <20031001084639.GA4188@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1064596018.1950.10.camel@ibm-c.pdx.osdl.net> <1064620762.2115.29.camel@ibm-c.pdx.osdl.net> <20030929040935.GA3637@in.ibm.com> <20030929131057.GA4630@in.ibm.com> <1064876358.23108.41.camel@ibm-c.pdx.osdl.net> <20030930040020.GA3435@in.ibm.com> <1064964169.1922.16.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064964169.1922.16.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 04:22:49PM -0700, Daniel McNeil wrote:
> Andrew and Suparna,
> 
> Here is a patch to hold an extra reference count on the AIO request iocb
> while it is being submitted and then drop it ref before returning.
> This prevents the race I was seeing with AIO O_DIRECT tests on ext3
> where the aio_complete() was freeing the iocb while it was still
> be referenced by the AIO submit code path.  I've run this on my
> 2-proc box with CONFIG_DEBUG_PAGEALLOC on and I no longer hit
> the oops.  The other option is to change the AIO code to never
> reference the iocb after it has been submitted, but that seems more
> error prone.  This patch is a very small change. I am surprised we have
> not seen this race before. 
> 
> Thoughts?
> 
> Daniel
> 
> 

> --- linux-2.6.0-test6-mm1/fs/aio.c	2003-09-30 14:47:51.000000000 -0700
> +++ linux-2.6.0-test6-mm1.aio/fs/aio.c	2003-09-30 16:03:08.702783397 -0700
> @@ -1490,7 +1490,14 @@ int io_submit_one(struct kioctx *ctx, st
>  		goto out_put_req;
>  
>  	spin_lock_irq(&ctx->ctx_lock);
> +	/*
> +	 * Hold an extra reference while submitting the i/o.
> +	 * This prevents races between the aio code path referencing the
> +	 * req (after submitting it) and aio_complete() freeing the req.
> +	 */
> +	req->ki_users++;		/* grab extra reference */
>  	ret = aio_run_iocb(req);
> +	(void)__aio_put_req(ctx, req);	/* drop the extra reference */	

I haven't looked very closely, but am just wondering why you ignore 
the return value of __aio_put_req here - are you sure there is no 
potential memory leakage (could be missing a put_ioctx) as a result ? 


>  	spin_unlock_irq(&ctx->ctx_lock);
>  
>  	if (-EIOCBRETRY == ret)

Although this isn't a problem with retry-based AIO (where we always
call aio_complete() from the calling routine, so should never see
the iocb going away underneath us), if we do add the ref count 
increment, we should probably try to do it for both the initial
submission and subsequent retries --- just in case we have code
(in future) that uses a combination of retries and aio completion
from interrupt context.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

