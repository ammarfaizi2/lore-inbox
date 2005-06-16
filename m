Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVFPE4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVFPE4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 00:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVFPE4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 00:56:51 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:45323 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261736AbVFPE4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:56:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=QqdWTBunXgHYHYTM5sv2XkFYkG3IdjlzbPHu1M8TODO7ctpy209lOhdvhsYH5i/+Rdd4M5ojOSj0njDiqA8/NqybQwFmXKl5DPlcL5Ff78RlKaCoIjBG4II8MlMVNSjurBTkwdZjjglG3W9cT47TuQeZlaVMXON4nsqIobpwOT0=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH Linux 2.6.12-rc6-mm1 00/06] blk: generic dispatch queue (for review)
Message-ID: <20050616045540.E3E4D48B@htj.dyndns.org>
Date: Thu, 16 Jun 2005 13:56:38 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 This patchset implements generic dispatch queue I've talked about in
the last ordered reimplementation patchset.  The patches are against
2.6.12-rc6-mm1 + ordered patchset + 3 last blk fix patches.  As I
haven't posted ordered patchset against 2.6.12-rc6-mm1 (still waiting
for your comments), to apply this patchset, you'll have to apply the
ordered patchset against 2.6.12-rc5-mm2 to 2.6.12-rc6-mm1, and then
apply these patches.  libata changes will fail but it wouldn't matter
for review purpose.  (if you want ordered patchset against
2.6.12-rc6-mm1, I can send it to you, just tell me.)

 This patchset updates only noop and cfq io schedulers.  as and
deadline wouldn't compile w/ this patchset applied.  I'll update as
and deadline once some consensus regarding the general direction of
this patchset is gained.

 This patchset is composed of two large parts.

 * Implementation of generic dispatch queue & updating individual
   elevators.
 * Move last_merge handling into generic elevator.

 Currently, each specific iosched maintains its own dispatch queue to
handle ordering, requeueing, cluster dispatching, etc...  This causes
the following problems.

 * duplicated codes
 * difficult to enforce semantics over dispatch queue (request
   ordering, requeueing, ...)
 * specific ioscheds have to deal with non-fs or ordered requests
   directly.

 With generic dispatch queue, specific ioscheds are guaranteed to be
handed only non-barrier fs requests, such that ioscheds only have to
implement ordering logic of normal fs requests.  Also, callback
invocation is stricter now.  Each fs request follows one of the
following paths.

 * add_req_fn -> dispatch_fn -> activate_fn (-> deactivate_fn ->
   activate_fn)* -> completed_req_fn
 * add_req_fn -> merged_req_fn
 * add_req_fn -> dispatch_fn (This path is special case for barrier
   request.  This can be easily removed by activating at the start of
   ordered sequence, and completing at the end.  Would removing this
   path be better?)

 Previously, elv_remove_request() and elv_completed_request() weren't
invoked for requests which are allocated outside blk layer (!rq->rl);
however, other elevator/iosched functions are called for such requests
making things a bit confusing.  As this patchset prevents non-fs
requests from going into specific ioscheds and removing the
inconsistency is necessary for implementation.  rq->rl tests in those
places are removed.

 With generic dispatch queue implemented, last_merge handling can be
moved into generic elevator proper.  The latter part of this patchset
does that.  One problem this change introduces is that, noop iosched
loses its ability to merge requests (as no merging is allowed for
requests on a generic dispatch queue).  To add it back cleanly, we
need to make noop use a separate list instead of q->queue_head to keep
requests before dispatching.  I don't know how meaningful this would
be.  The change should be simple & easy.  If merging capability of
noop iosched is important, plz let me know.

 As this patchset makes enforcing semantics over dispatch queue
easier, we can implement proper requeueing of failed tagged ordered
requests (the ordered request and in-flight normal requests should be
requeued in proper positions) on this.  After this patchset is
applied, I'll work on that.

 Oh, hacks introduced in the ordered patchset (blk_account_rq
modification and bar_rq_hack_*) are removed by this patchset.

[ Start of patch descriptions ]

01_blk_dispatch_queue.patch
	: implement generic dispatch queue

	Implements generic dispatch queue which can replace all
	dispatch queues implemented by each iosched.  This reduces
	code duplication, eases enforcing semantics over dispatch
	queue, and simplifies specific ioscheds.

02_blk_dispatch_queue_noop.patch
	: update noop iosched to use generic dispatch queue

	Update noop iosched to use generic dispatch queue

03_blk_dispatch_queue_cfq.patch
	: update cfq iosched to use generic dispatch queue

	Update cfq iosched to use generic dispatch queue

04_blk_last_merge_consolidation.patch
	: move last_merge handling into generic elevator code

	Currently, both generic elevator code and specific ioscheds
	participate in the management and usage of last_merge.  This
	and the following patches move last_merge handling into
	generic elevator code.

05_blk_last_merge_consolidation_noop.patch
	: remove last_merge handling from noop iosched

	Remove last_merge handling from noop iosched.  This change
	removes merging capability of noop iosched.

06_blk_last_merge_consolidation_cfq.patch
	: remove last_merge handling from cfq iosched

	Remove last_merge handling from cfq iosched

[ End of patch descriptions ]

 Thanks.

--
tejun

