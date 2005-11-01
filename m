Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVKAMOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVKAMOr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVKAMOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:14:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36428 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750773AbVKAMOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:14:46 -0500
Date: Tue, 1 Nov 2005 13:15:37 +0100
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: torvalds@osdl.org, acme@mandriva.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk: fix dangling pointer access in __elv_add_request
Message-ID: <20051101121537.GH26049@suse.de>
References: <20051101082349.GA17756@htj.dyndns.org> <20051101090857.GC26049@suse.de> <43673FBC.3070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43673FBC.3070403@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01 2005, Tejun Heo wrote:
> Jens Axboe wrote:
> >On Tue, Nov 01 2005, Tejun Heo wrote:
> >
> >>cfq's add_req_fn callback may invoke q->request_fn directly and
> >>depending on low-level driver used and timing, a queued request may be
> >>finished & deallocated before add_req_fn callback returns.  So,
> >>__elv_add_request must not access rq after it's passed to add_req_fn
> >>callback.
> >
> >
> >It's a generel problem, you may get the queue run at any time regardless
> >of what the io scheduler is doing. CFQ does run the queue manully
> >sometimes, but SCSI may do the very same thing for you as well. Given
> >that SCSI also shortly reenables interrupts in the ->request_fn()
> >handling, it's quite possible for the request to be completed.
> >
> > So, as we don't hold a reference to the request, I'd say your patch
> > looks correct and should be applied right away.
> >
> >
> >>Jens, does generalizing queue kicking functions and disallowing
> >>ioscheds from directly calling q->request_fn sound like a good idea?
> >
> >
> > Yes certainly.
> >
> 
> The thing is that we are holding queue_lock before calling add_req_fn 
> callback and also after it finishes giving it an appearance of 
> atomicity.  I think q->request_fn semantics is peculiar and a bit prone 
> to bug, so it might be better to make ioscheds always use generic queue 
> kicking function which always uses work queue to run q->request_fn so 
> that we don't have queue_lock releasing and regrabbing inbetween.  Do 
> you think there can be any noticieable performance issues?

Hmm well, I'd rather not push the work off to a workqueue unless I have
to. That's basically why I coded it myself so far, since I (usually :-)
know when it's safe to do it in the various ways. 'as' basically always
pushes off the work to kblockd, but I'd rather not lose this
optimization.

> Hmmmm... One more thing about q->request_fn's locking behavior is that, 
> as I noted while posting the ordered patchset, for SCSI, the behavior 
> can reorder issued requests making it impossible to use ordered tags for 
> flushing.  I'm thinking of submitting a patch to make scsi request_fn 
> atomic w.r.t. queue_lock, but there might be some performance issues I'm 
> not aware of.  Functions which release and regrab locks underneath the 
> caller are just... hard.  :-p

Yeah it's problematic and not exactly the best design. It also tends to
screw up cfq/as on requeues, if a requests get requeued and isn't the
first returned again.

WRT performance penalty, really hard to guess without looking at the
patch :-)

-- 
Jens Axboe

