Return-Path: <linux-kernel-owner+w=401wt.eu-S1751016AbXAIEjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbXAIEjY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 23:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbXAIEjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 23:39:24 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:51837 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbXAIEjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 23:39:23 -0500
Date: Tue, 9 Jan 2007 10:09:10 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070109043910.GB589@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org> <20070107215103.GA7960@tv-sign.ru> <20070108152211.GA31263@in.ibm.com> <20070108155638.GA156@tv-sign.ru> <20070108163140.GC31263@in.ibm.com> <20070108170635.GA448@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108170635.GA448@tv-sign.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 08:06:35PM +0300, Oleg Nesterov wrote:
> Ah, missed you point, thanks. Yet another old problem which was not introduced
> by recent changes. And yet another indication we should avoid kthread_stop()
> on CPU_DEAD event :) I believe this is easy to fix, but need to think more.

I think the problem is not just with CPU_DEAD. Anyone who calls
cleanup_workqueue_thread (say destroy_workqueue?) will see this race. 

Do you see any problems if cleanup_workqueue_thread is changed as:

cleanup_workqueue_thread()
{
	kthread_stop(p);
	spin_lock(cwq->lock);
	cwq->thread = NULL;
	spin_unlock(cwq->lock);
}


> 	run_workqueue:
> 
> 		while (!list_empty(&cwq->worklist)) {
> 			...
> 			// We hold lock_cpu_hotplug(), cpu event can't make
> 			// progress.
> 			...
> 		}

Ok ..yes a cpu_event_waits_for_lock() helper will help here.

> > I agree it minimizes the interactions. Maybe worth attempting. However I
> > suspect it may not be as simple as it appears :)
> 
> Yes, that is why this patch only does the first step: flush_workqueue() checks
> the dead CPUs as well, this change is minimal.
> 
> Do you see any problems this patch adds?

I dont see as of now. I suspect we will know better when we implement
the patch to eliminate CPU_DEAD handling in workqueue.c

-- 
Regards,
vatsa
