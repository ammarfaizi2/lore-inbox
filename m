Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVDASKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVDASKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVDASKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:10:12 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:6324 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262834AbVDASJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:09:58 -0500
Subject: Re: [PATCH scsi-misc-2.6 01/13] scsi: don't use
	blk_insert_request() for requeueing
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050401050109.GB11318@htj.dyndns.org>
References: <20050331090647.FEDC3964@htj.dyndns.org>
	 <20050331090647.BA0001D5@htj.dyndns.org>
	 <1112291600.5619.19.camel@mulgrave> <20050401050109.GB11318@htj.dyndns.org>
Content-Type: text/plain
Date: Fri, 01 Apr 2005 12:09:48 -0600
Message-Id: <1112378988.5776.18.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 14:01 +0900, Tejun Heo wrote:
> > Well, REQ_SPECIAL is the signal to the mid-layer that we've allocated
> > the resources necessary to process the command, so in practice it will
> > be turned on for every requeue request (because we set it when the
> > command is prepared),
> 
>  Sorry, but where?  AFAICT, only blk_insert_request() and
> scsi_init_io() on sgtable allocation failure set REQ_SPECIAL during
> scsi midlayer processing.  This patch replaces blk_insert_request()
> with blk_requeue_request() and the next patch removes REQ_SPECIAL
> setting in scsi_init_io().
> 
>  REQ_SPECIAL is currently overloaded to mean two different things.
> 
>  * The request is a special request.
>  * The request has been requeued using scsi_queue_insert().
>    i.e. It has been prepped.

But its true meaning is defined by the block layer (since it's a block
flag).  It's supposed to mean that the ->special field of the request is
in use to carry data meaningful to the underlying driver.  SCSI sets it
on that basis.

So, if I understand correctly, based on the fact that the current block
code in fact never bothers with REQ_SPECIAL, but only checks req-
>special, you're proposing that we need never actually set REQ_SPECIAL
when making use of the ->special field?  Thus you want to use
REQ_SPECIAL to distinguish between internally generated commands and
external commands?  That sounds fine as long as the block API gets
updated to reflect this (comments in linux/blkdev.h shoudl be fine).

> > The other reason I don't like this is that we've been trying hard to
> > sweep excess block knowledge out of the mid-layer.  I don't think
> > REQ_SOFTBARRIER is anything we really have to know about.
> 
>  We currently requeue using two different block functions.
> 
>  * blk_insert_request(): this function does two things
> 	1. enqueue special requests
> 	2. turn on REQ_SPECIAL|REQ_SOFTBARRIER and call
> 	   blk_requeue_request().  This is used only by scsi midlayer.
>  * blk_requeue_request()
> 
>  REQ_SOFTBARRIER tells the request queue that other requests shouldn't
> pass this one.  We need this to be set for prepped requests;
> otherwise, it may, theoretically, deadlock (unprepped request waiting
> for the prepped request back in the queue).  So, the current code
> 
>  * depends on blk_insert_request() sets REQ_SOFTBARRIER when
>    requeueing.  It works but nothing in the interface or semantics
>    is clear about it.  Why expect a request reinserted using
>    blk_insert_request() gets REQ_SOFTBARRIER turned on while a request
>    reinserted with blk_requeue_request() doesn't?  or why are there
>    two different paths doing mostly the same thing with slightly
>    different semantics?
>  * requeueing using blk_requeue_request() in scsi_request_fn() doesn't
>    turn on either REQ_SPECIAL or REQ_SOFTBARRIER.  Missing REQ_SPECIAL
>    is okay, as we have the extra path in prep_fn (if it ever gets requeued
>    due to medium failure, so gets re-prepped), but missing
>    REQ_SOFTBARRIER can *theoretically* cause problem.
> 
>  So, it's more likely becoming less dependent on unobvious behavior of
> block layer.  As we need the request to stay on top, we tell the block
> layer to do so, instead of depending on blk_insert_request()
> unobviously doing it for us.

But that's the point.  This is non obvious behaviour in the block layer,
so SCSI doesn't want to know about it (and the block maintainer won't
want to trawl through the SCSI and other block drivers altering it if it
changes).  If the bug is that the block layer isn't setting it on all
our requeues where it should, then either we're using the wrong API or
the block layer API is buggy.

James


