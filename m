Return-Path: <linux-kernel-owner+w=401wt.eu-S1422875AbWLUI6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422875AbWLUI6A (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWLUI57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:57:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:4720 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422875AbWLUI57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:57:59 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,197,1165219200"; 
   d="scan'208"; a="180183657:sNHT20064534"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-aio@kvack.org>, "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'xb'" <xavier.bru@bull.net>, "'Zach Brown'" <zach.brown@oracle.com>,
       <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: RE: [patch] aio: fix buggy put_ioctx call in aio_complete
Date: Thu, 21 Dec 2006 00:57:57 -0800
Message-ID: <000101c724de$1c81d980$1b80030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Acck2I5eZLJgFMsTQkqRy0pUNu1l0gAAgEmg
In-Reply-To: <20061221001756.84c8fa7f.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Thursday, December 21, 2006 12:18 AM
> Alas, your above description doesn't really tell us what the bug is, so I'm
> at a bit of a loss here.
> 
> <finds http://marc.theaimsgroup.com/?l=linux-aio&m=116616463009218&w=2>
> 
> So that's a refcounting bug.  But it's really a locking bug, because
> refcounting needs locking too.

I should've quoted the original bug report (kicking myself for those
fat fingers!): http://marc.theaimsgroup.com/?l=linux-kernel&m=116599593200888&w=2

The bug manifested from an expectation that __put_ioctx can be called
in the softirq context, but it really shouldn't. Normally, aio_complete
will not decrement last ref count on ioctx, but under stressed system,
it might.


> > Problem is in wait_for_all_aios(), it is checking wait status without
> > properly holding an ioctx lock. Perhaps, this patch is walking on thin
> > ice.  It abuses rcu over a buggy code. OTOH, I really don't want to hold
> > ctx_lock over the entire wakeup call at the end of aio_complete:
> > 
> >         if (waitqueue_active(&ctx->wait))
> >                 wake_up(&ctx->wait);
> > 
> > I'm worried about longer lock hold time in aio_complete and potentially 
> > increase lock contention for concurrent I/O completion.
> 
> There is a potential problem where we deliver a storm of wakeups at the
> waitqueue, and until the waked-up process actually ges going and removes
> itself from the waitqueue, those wake_up()s do lots of work waking up an
> already-runnable task.
> 
> If we were using DEFINE_WAIT/prepare_to_wait/finish_wait in there then the
> *first* wake_up() would do some work, but all the following ones are
> practically free.
> 
> So if you're going to get in there and run the numbers on this, try both
> approaches.

Yes, I agree and I would like to bring your patch on "DEFINE_WAIT..." back
too.  I will run that experiment.


> > A quick look
> > at lockmeter data I had on a 4 socket system (with dual core + HT), it
> > already showing signs of substantial lock contention in aio_complete.
> > I'm afraid putting the above call inside ioctx_lock will make things
> > worse.
> 
> It beats oopsing.

Yeah, correctness absolutely over rule optimization.  I just hope I can
find a way to satisfy both.


> > And synchronize_rcu fits the bill perfectly: aio_complete sets wakeup
> > status, drop ioctx_lock, do the wakeup call all protected inside rcu
> > lock.  Then wait_for_all_aios will just wait for all that sequence to
> > complete before it proceed with __put_ioctx().  All nice and easy.
> 
> Possibly it would be less abusive to use preempt_disable()/enable (with
> suitable comments) and synchronize_kernel().  To at least remove the rcu
> signals from in there.

I think I'm going to abandon this whole synchronize thing and going to
put the wake up call inside ioctx_lock spin lock along with the other
patch you mentioned above in the waiter path.  On top of that, I have
another patch attempts to perform wake-up only when the waiter can truly
proceed in aio_read_evt so dribbling I/O completion doesn't inefficiently
waking up waiter too frequently and only to have waiter put back to sleep
again. I will dig that up and experiment.

