Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262622AbVDAFBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbVDAFBa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 00:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVDAFBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 00:01:30 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:11136 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262620AbVDAFBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 00:01:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VIEOFpVTrdc1x3MrpZfXYq15/UlPUx+bhY14SU+lnt1QnAHtSqdEbnIFyMOXVEOCOOnkqyAJsdArhc/R6yYnW9LRm5INZ3GAJriW7cgygMlKYj4scHPVt2bDxTbXJHYvsdiK1yU0kGzcj916XnqFERc4l0+OZiHCgJiDd6LhkKs=
Date: Fri, 1 Apr 2005 14:01:09 +0900
From: Tejun Heo <htejun@gmail.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 01/13] scsi: don't use blk_insert_request() for requeueing
Message-ID: <20050401050109.GB11318@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.BA0001D5@htj.dyndns.org> <1112291600.5619.19.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112291600.5619.19.camel@mulgrave>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

On Thu, Mar 31, 2005 at 11:53:20AM -0600, James Bottomley wrote:
> On Thu, 2005-03-31 at 18:07 +0900, Tejun Heo wrote:
> > 01_scsi_no_REQ_SPECIAL_on_requeue.patch
> > 
> > 	blk_insert_request() has 'reinsert' argument, which, when set,
> > 	turns on REQ_SPECIAL and REQ_SOFTBARRIER and requeues the
> > 	request.  SCSI midlayer was the only user of this feature and
> > 	all requeued requests become special requests defeating
> > 	quiesce state.  This patch makes scsi midlayer use
> > 	blk_requeue_request() for requeueing and removes 'reinsert'
> > 	feature from blk_insert_request().
> 
> Well, REQ_SPECIAL is the signal to the mid-layer that we've allocated
> the resources necessary to process the command, so in practice it will
> be turned on for every requeue request (because we set it when the
> command is prepared),

 Sorry, but where?  AFAICT, only blk_insert_request() and
scsi_init_io() on sgtable allocation failure set REQ_SPECIAL during
scsi midlayer processing.  This patch replaces blk_insert_request()
with blk_requeue_request() and the next patch removes REQ_SPECIAL
setting in scsi_init_io().

 REQ_SPECIAL is currently overloaded to mean two different things.

 * The request is a special request.
 * The request has been requeued using scsi_queue_insert().
   i.e. It has been prepped.

 However, #2 can be tested by rq->special != NULL condition, and, in
fact, the prep_fn already has the code.  This is why this and the next
patch don't break the requeue path.  IMHO, this proves the subtlety of
the REQ_SPECIAL semantics.  Which path is taken on which case gets
kind of confusing by meaning two different things with REQ_SPECIAL.

> so this patch would have no effect on your stated
> quiesce problem.  However, if you think about how requests work with
> head insertion and one command following another, there's really not a
> huge problem here either.

 I agree that it's not a huge problem, but it's subtle and has the
potential of causing probably non-destructive but confusing behavior
on rare cases.

> The other reason I don't like this is that we've been trying hard to
> sweep excess block knowledge out of the mid-layer.  I don't think
> REQ_SOFTBARRIER is anything we really have to know about.

 We currently requeue using two different block functions.

 * blk_insert_request(): this function does two things
	1. enqueue special requests
	2. turn on REQ_SPECIAL|REQ_SOFTBARRIER and call
	   blk_requeue_request().  This is used only by scsi midlayer.
 * blk_requeue_request()

 REQ_SOFTBARRIER tells the request queue that other requests shouldn't
pass this one.  We need this to be set for prepped requests;
otherwise, it may, theoretically, deadlock (unprepped request waiting
for the prepped request back in the queue).  So, the current code

 * depends on blk_insert_request() sets REQ_SOFTBARRIER when
   requeueing.  It works but nothing in the interface or semantics
   is clear about it.  Why expect a request reinserted using
   blk_insert_request() gets REQ_SOFTBARRIER turned on while a request
   reinserted with blk_requeue_request() doesn't?  or why are there
   two different paths doing mostly the same thing with slightly
   different semantics?
 * requeueing using blk_requeue_request() in scsi_request_fn() doesn't
   turn on either REQ_SPECIAL or REQ_SOFTBARRIER.  Missing REQ_SPECIAL
   is okay, as we have the extra path in prep_fn (if it ever gets requeued
   due to medium failure, so gets re-prepped), but missing
   REQ_SOFTBARRIER can *theoretically* cause problem.

 So, it's more likely becoming less dependent on unobvious behavior of
block layer.  As we need the request to stay on top, we tell the block
layer to do so, instead of depending on blk_insert_request()
unobviously doing it for us.

 Thanks.

-- 
tejun

