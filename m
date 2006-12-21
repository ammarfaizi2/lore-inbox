Return-Path: <linux-kernel-owner+w=401wt.eu-S1422983AbWLURBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422983AbWLURBw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422982AbWLURBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:01:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:3419 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422983AbWLURBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:01:52 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,200,1165219200"; 
   d="scan'208"; a="180429129:sNHT1553387192"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <jmoyer@redhat.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'xb'" <xavier.bru@bull.net>, "'Zach Brown'" <zach.brown@oracle.com>,
       <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: RE: [patch] aio: fix buggy put_ioctx call in aio_complete
Date: Thu, 21 Dec 2006 09:01:28 -0800
Message-ID: <000601c72521$ab1d4880$fe80030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcclIGWakJTvPnQLRqCw2lIlTicRQAAADmLA
In-Reply-To: <m3vek5xk6t.fsf@redhat.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmoyer@redhat.com wrote on Thursday, December 21, 2006 8:56 AM
> kenneth.w.chen> I think I'm going to abandon this whole synchronize thing
> kenneth.w.chen> and going to put the wake up call inside ioctx_lock spin
> kenneth.w.chen> lock along with the other patch you mentioned above in the
> kenneth.w.chen> waiter path.  On top of that, I have another patch attempts
> kenneth.w.chen> to perform wake-up only when the waiter can truly proceed
> kenneth.w.chen> in aio_read_evt so dribbling I/O completion doesn't
> kenneth.w.chen> inefficiently waking up waiter too frequently and only to
> kenneth.w.chen> have waiter put back to sleep again. I will dig that up and
> kenneth.w.chen> experiment.
> 
> In the mean time, can't we simply take the context lock in
> wait_for_all_aios?  Unless I missed something, I think that will address
> the reference count problem.

Take ioctx_lock is one part, the other part is to move

	spin_unlock_irqrestore(&ctx->ctx_lock, flags);

in aio_complete all the way down to the end of the function, after wakeup
and put_ioctx.  But then the ref counting on ioctx in aio_complete path is
Meaningless, which is the thing I'm trying to remove.

