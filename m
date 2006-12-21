Return-Path: <linux-kernel-owner+w=401wt.eu-S1422974AbWLURiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422974AbWLURiH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422993AbWLURiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:38:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60591 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422974AbWLURiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:38:06 -0500
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'xb'" <xavier.bru@bull.net>, "'Zach Brown'" <zach.brown@oracle.com>,
       <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] aio: fix buggy put_ioctx call in aio_complete
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <000601c72521$ab1d4880$fe80030a@amr.corp.intel.com>
From: jmoyer@redhat.com
Date: Thu, 21 Dec 2006 12:34:52 -0500
In-Reply-To: <000601c72521$ab1d4880$fe80030a@amr.corp.intel.com> (Kenneth W. Chen's message of "Thu, 21 Dec 2006 09:01:28 -0800")
Message-ID: <m3odpxxidf.fsf@redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding RE: [patch] aio: fix buggy put_ioctx call in aio_complete; "Chen, Kenneth W" <kenneth.w.chen@intel.com> adds:

kenneth.w.chen> jmoyer@redhat.com wrote on Thursday, December 21, 2006 8:56
kenneth.w.chen> AM I think I'm going to abandon this whole synchronize
kenneth.w.chen> thing and going to put the wake up call inside ioctx_lock
kenneth.w.chen> spin lock along with the other patch you mentioned above in
kenneth.w.chen> the waiter path.  On top of that, I have another patch
kenneth.w.chen> attempts to perform wake-up only when the waiter can truly
kenneth.w.chen> proceed in aio_read_evt so dribbling I/O completion doesn't
kenneth.w.chen> inefficiently waking up waiter too frequently and only to
kenneth.w.chen> have waiter put back to sleep again. I will dig that up and
kenneth.w.chen> experiment.
>> In the mean time, can't we simply take the context lock in
>> wait_for_all_aios?  Unless I missed something, I think that will address
>> the reference count problem.

kenneth.w.chen> Take ioctx_lock is one part, the other part is to move

kenneth.w.chen> 	spin_unlock_irqrestore(&ctx->ctx_lock, flags);

kenneth.w.chen> in aio_complete all the way down to the end of the
kenneth.w.chen> function, after wakeup and put_ioctx.  But then the ref
kenneth.w.chen> counting on ioctx in aio_complete path is Meaningless,
kenneth.w.chen> which is the thing I'm trying to remove.

OK, right.  But are we simply papering over the real problem?  Earlier in
this thread, you stated:

> flush_workqueue() is not allowed to be called in the softirq context.
> However, aio_complete() called from I/O interrupt can potentially call
> put_ioctx with last ref count on ioctx and trigger a bug warning.  It
> is simply incorrect to perform ioctx freeing from aio_complete.

But how do we end up with the last reference to the ioctx in the aio
completion path?  That's a question I haven't seen answered.

-Jeff
