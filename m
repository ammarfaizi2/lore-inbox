Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTJULVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTJULVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:21:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:44786 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263055AbTJULVn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:21:43 -0400
Date: Tue, 21 Oct 2003 16:57:13 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Avoid flushing AIO workqueue on cancel/exit
Message-ID: <20031021112713.GA4264@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031021102514.GA4217@in.ibm.com> <20031021035900.18040eee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031021035900.18040eee.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 03:59:00AM -0700, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> > When streaming AIO requests are in progress on multiple
> >  io context's, flushing the AIO workqueue on i/o cancellation
> >  or process exit could potentially end up waiting for a 
> >  long time as fresh requests from other active ioctx's keep 
> >  getting queued up.
> 
> But flush_workqueue() will ignore any newly-added work requests:
> 
>  * This function will sample each workqueue's current insert_sequence number and
>  * will sleep until the head sequence is greater than or equal to that.  This
>  * means that we sleep until all works which were queued on entry have been
>  * handled, but we are not livelocked by new incoming ones.

True. I must have had an old version of workqueue.c in mind ... which
had a warning of that sort; I didn't realise that had been fixed.

Now that we have included the patch to splice the AIO runlist, 
newer requests getting queued up on the ioctx shouldn't livelock us. 

So yes this isn't strictly necessary. We still have one ioctx cancellation
waiting for ongoing retries on other ioctx's system wide to get done,
instead of just the io context being cancelled, but that's probably
not so bad. We can wait till that shows up as a real problem.

> 
> Now, flush_workqueue() is potentially inefficient on SMP because it flushes
> each CPU's workqueue sequentially.  But we can fix that in
> flush_workqueue() by converting it to a two-pass approach:
> 
> a) gather each CPU's insert_sequence number into a local array[NR_CPUS]
> 
> b) wait until each CPU's remove_sequence number exceeds the previously-gathered
>    insert_sequence number.
> 

Regards
Suparna

> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

