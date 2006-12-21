Return-Path: <linux-kernel-owner+w=401wt.eu-S1422825AbWLUH6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWLUH6q (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422827AbWLUH6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:58:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:1514 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422825AbWLUH6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:58:46 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,197,1165219200"; 
   d="scan'208"; a="180167625:sNHT23952964"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>
Cc: "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'xb'" <xavier.bru@bull.net>, "'Zach Brown'" <zach.brown@oracle.com>,
       <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: RE: [patch] aio: fix buggy put_ioctx call in aio_complete
Date: Wed, 20 Dec 2006 23:58:43 -0800
Message-ID: <000001c724d5$d708ca60$1b80030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccktWK5gF2X4P41TnKzZk06EMKXDwAG9Fmw
In-Reply-To: <20061220200535.211a3dda.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, December 20, 2006 8:06 PM
> On Tue, 19 Dec 2006 13:49:18 -0800
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> > Regarding to a bug report on:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=116599593200888&w=2
> > 
> > flush_workqueue() is not allowed to be called in the softirq context.
> > However, aio_complete() called from I/O interrupt can potentially call
> > put_ioctx with last ref count on ioctx and trigger a bug warning.  It
> > is simply incorrect to perform ioctx freeing from aio_complete.
> > 
> > This patch removes all duplicate ref counting for each kiocb as
> > reqs_active already used as a request ref count for each active ioctx.
> > This also ensures that buggy call to flush_workqueue() in softirq
> > context is eliminated. wait_for_all_aios currently will wait on last
> > active kiocb.  However, it is racy.  This patch also tighten it up
> > by utilizing rcu synchronization mechanism to ensure no further
> > reference to ioctx before put_ioctx function is run.
> 
> hrm, maybe.  Does this count as "abuse of the RCU interfaces".  Or "reuse"?

Yeah, it's abuse.

Problem is in wait_for_all_aios(), it is checking wait status without
properly holding an ioctx lock. Perhaps, this patch is walking on thin
ice.  It abuses rcu over a buggy code. OTOH, I really don't want to hold
ctx_lock over the entire wakeup call at the end of aio_complete:

        if (waitqueue_active(&ctx->wait))
                wake_up(&ctx->wait);

I'm worried about longer lock hold time in aio_complete and potentially 
increase lock contention for concurrent I/O completion.  A quick look
at lockmeter data I had on a 4 socket system (with dual core + HT), it
already showing signs of substantial lock contention in aio_complete.
I'm afraid putting the above call inside ioctx_lock will make things
worse.

And synchronize_rcu fits the bill perfectly: aio_complete sets wakeup
status, drop ioctx_lock, do the wakeup call all protected inside rcu
lock.  Then wait_for_all_aios will just wait for all that sequence to
complete before it proceed with __put_ioctx().  All nice and easy.
