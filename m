Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262777AbRE3NYt>; Wed, 30 May 2001 09:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262778AbRE3NYj>; Wed, 30 May 2001 09:24:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38161 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262777AbRE3NYT>;
	Wed, 30 May 2001 09:24:19 -0400
Date: Wed, 30 May 2001 15:24:13 +0200
From: Jens Axboe <axboe@kernel.org>
To: Mark Hemment <markhe@veritas.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
Message-ID: <20010530152412.C17136@suse.de>
In-Reply-To: <20010529160704.N26871@suse.de> <Pine.LNX.4.21.0105301348370.7153-100000@alloc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105301348370.7153-100000@alloc>; from markhe@veritas.com on Wed, May 30, 2001 at 02:03:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30 2001, Mark Hemment wrote:
> Hi again, :)
> 
> On Tue, 29 May 2001, Jens Axboe wrote:
> > Another day, another version.
> > 
> > Bugs fixed in this version: none
> > Known bugs in this version: none
> > 
> > In other words, it's perfect of course.
> 
>   With the scsi-high patch, I'm not sure about the removal of the line
> from __scsi_end_request();
> 
> 	req->buffer = bh->b_data;

Why?

>   A requeued request is not always processed immediately, so new
> buffer-heads arriving at the block-layer can be merged against it.  A
> requeued request is placed at the head of a request list, so
> nothing can merge with it - but what about if multiple requests are
> requeued on the same queue?

You forget that SCSI is not head-active, so there can indeed be merges
against a request that was re-added to the queue list.

>   When processing the completion of a SCSI request in a bottom-half,
> __scsi_end_request() can find all the buffers associated with the request
> haven't been completed (ie. leftovers).
> 
>   One question is; can this ever happen?

Yes it can happen.

>   The request is re-queued to the block layer via 
> scsi_queue_next_request(), which uses the "special" pointer in the request
> structure to remember the Scsi_Cmnd associated with the request.  The SCSI
> request function is then called, but doesn't guarantee to immediately
> process the re-queued request even though it was added at the head (say,
> the queue has become plugged).  This can trigger two possible bugs.
> 
>   The first is that __scsi_end_request() doesn't decrement the
> hard_nr_sectors count in the request.  As the request is back on the
> queue, it is possible for newly arriving buffer-heads to merge with the
> heads already hanging off the request.  This merging uses the
> hard_nr_sectors when calculating both the merged hard_nr_sectors and
> nr_sectors counts.

Right, that looks like a bug. I would prefer SCSI using
end_that_request_first here actually.

>   As the request is at the head, only back-merging can occur, but if
> __scsi_end_request() triggers another uncompleted request to be re-queued,
> it is possible to get front merging as well.

There can be front merges too. If a head is active, then no merging can
occcur. But for SCSI, the front request must always be in a sane state.
Or bad things can happen, like you describe.

>   The merging of a re-queued request looks safe, except for the
> hard_nr_sectors.  This patch corrects the hard_nr_sectors accounting.

Right

>   The second bug is from request merging in attempt_merge().
> 
>   For a re-queued request, the request structure is the one embedded in
> the Scsi_Cmnd (which is a copy of the request taken in the 
> scsi_request_fn).
>   In attempt_merge(), q->merge_requests_fn() is called to see the requests
> are allowed to merge.  __scsi_merge_requests_fn() checks number of
> segments, etc, but doesn't check if one of the requests is a re-queued one
> (ie. no test against ->special).
>   This can lead to attempt_merge() releasing the embedded request
> structure (which, as an extract copy, has the ->q set, so to
> blkdev_release_request() it looks like a request which originated from
> the block layer).  This isn't too healthy.
> 
>   The fix here is to add a check in __scsi_merge_requests_fn() to check
> for ->special being non-NULL.

How about just adding 

	if (req->cmd != next->cmd
	    || req->rq_dev != next->rq_dev
	    || req->nr_sectors + next->nr_sectors > q->max_sectors
	    || next->sem || req->special)
                return;

ie check for special too, that would make sense to me. Either way would
work, but I'd rather make this explicit in the block layer that 'not
normal' requests are left alone. That includes stuff with the sem set,
or special.

-- 
Jens Axboe

