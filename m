Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbRE3NEg>; Wed, 30 May 2001 09:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262774AbRE3NE0>; Wed, 30 May 2001 09:04:26 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:46547 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S261897AbRE3NEP>; Wed, 30 May 2001 09:04:15 -0400
Date: Wed, 30 May 2001 14:03:02 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Jens Axboe <axboe@kernel.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 4GB I/O, cut three
In-Reply-To: <20010529160704.N26871@suse.de>
Message-ID: <Pine.LNX.4.21.0105301348370.7153-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, :)

On Tue, 29 May 2001, Jens Axboe wrote:
> Another day, another version.
> 
> Bugs fixed in this version: none
> Known bugs in this version: none
> 
> In other words, it's perfect of course.

  With the scsi-high patch, I'm not sure about the removal of the line
from __scsi_end_request();

	req->buffer = bh->b_data;

  A requeued request is not always processed immediately, so new
buffer-heads arriving at the block-layer can be merged against it.  A
requeued request is placed at the head of a request list, so
nothing can merge with it - but what about if multiple requests are
requeued on the same queue?

  In Linus's tree, requests requeued via the SCSI layer can cause problems
(corruption).  I sent out a patch to cover this a few months back, which
got picked up by Alan (its in the -ac series - see the changes to
scsi_lib.c and scsi_merge.c) but no one posted any feedback.
  I've included some of the original message below.

Mark


------------------------------------------------------------------
>From markhe@veritas.com Sat Mar 31 16:07:14 2001 +0100
Date: Sat, 31 Mar 2001 16:07:13 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
Subject: [PATCH] Possible SCSI + block-layer bugs

Hi,

  I've never seen these trigger, but they look theoretically possible.

  When processing the completion of a SCSI request in a bottom-half,
__scsi_end_request() can find all the buffers associated with the request
haven't been completed (ie. leftovers).

  One question is; can this ever happen?
  If it can't then the code should be removed from __scsi_end_request(),
if it can happen then there appears to be a few problems;

  The request is re-queued to the block layer via 
scsi_queue_next_request(), which uses the "special" pointer in the request
structure to remember the Scsi_Cmnd associated with the request.  The SCSI
request function is then called, but doesn't guarantee to immediately
process the re-queued request even though it was added at the head (say,
the queue has become plugged).  This can trigger two possible bugs.

  The first is that __scsi_end_request() doesn't decrement the
hard_nr_sectors count in the request.  As the request is back on the
queue, it is possible for newly arriving buffer-heads to merge with the
heads already hanging off the request.  This merging uses the
hard_nr_sectors when calculating both the merged hard_nr_sectors and
nr_sectors counts.
  As the request is at the head, only back-merging can occur, but if
__scsi_end_request() triggers another uncompleted request to be re-queued,
it is possible to get front merging as well.

  The merging of a re-queued request looks safe, except for the
hard_nr_sectors.  This patch corrects the hard_nr_sectors accounting.


  The second bug is from request merging in attempt_merge().

  For a re-queued request, the request structure is the one embedded in
the Scsi_Cmnd (which is a copy of the request taken in the 
scsi_request_fn).
  In attempt_merge(), q->merge_requests_fn() is called to see the requests
are allowed to merge.  __scsi_merge_requests_fn() checks number of
segments, etc, but doesn't check if one of the requests is a re-queued one
(ie. no test against ->special).
  This can lead to attempt_merge() releasing the embedded request
structure (which, as an extract copy, has the ->q set, so to
blkdev_release_request() it looks like a request which originated from
the block layer).  This isn't too healthy.

  The fix here is to add a check in __scsi_merge_requests_fn() to check
for ->special being non-NULL.

