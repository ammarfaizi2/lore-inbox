Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVI0S5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVI0S5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 14:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVI0S5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 14:57:54 -0400
Received: from dvhart.com ([64.146.134.43]:11661 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965045AbVI0S5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 14:57:53 -0400
Date: Tue, 27 Sep 2005 11:57:50 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: "Seth, Rohit" <rohit.seth@intel.com>, Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <922980000.1127847470@flay>
In-Reply-To: <20050926123357.A4892@unix-os.sc.intel.com>
References: <20050921222839.76c53ba1.akpm@osdl.org> <20050924175848.GD3586@inferi.kami.home> <20050924112339.342b82e1.akpm@osdl.org> <20050926123357.A4892@unix-os.sc.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems like from the log messages that quite a few pages are hanging in the cpu's cold pcp list even with the low memory conditions.  Below is the patch to reduce the higher bound in cold pcp list (...this got increased with my previous change).  
> 
> I think we should also drain the CPU's hot and cold pcps for the GFP_KERNEL page requests (in the event the higher order request is not able to get serviced otherwise).  This will still only drains the current CPUs pcps in an MP environment (leaving the other CPUs with their lists intact).  I will send this patch later today.
> 
> 	[PATCH]: Reduce the high mark in cpu's cold pcp list.
> 
> 	Signed-off-by: Rohit Seth <rohit.seth@intel.com>
> 
> 
> --- linux-2.6.13.old/mm/page_alloc.c	2005-09-26 10:57:07.000000000 -0700
> +++ linux-2.6.13.work/mm/page_alloc.c	2005-09-26 10:47:57.000000000 -0700
> @@ -1749,7 +1749,7 @@
>  	pcp = &p->pcp[1];		/* cold*/
>  	pcp->count = 0;
>  	pcp->low = 0;
> -	pcp->high = 2 * batch;
> +	pcp->high = batch / 2;
>  	pcp->batch = max(1UL, batch/2);
>  	INIT_LIST_HEAD(&pcp->list);
>  }
> -

I don't understand. How can you set the high watermark at half the batch
size? Makes no sense to me.

And can you give a stricter definiton of what you mean by "low memory
conditions"? I agree we ought to empty the lists before going OOM or
anything, but not at the slightest feather of pressure ... answer lies
somewhere inbetween ... but where?

M.



