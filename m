Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVJSMfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVJSMfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVJSMfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:35:12 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:484 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750766AbVJSMfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:35:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=FUb37Y4ru392+jwUHBdtTDqzknnQO0+DioPPwA7lH1GN3wCmMYcEM0c6SNffJHx3rou+E2wPqnqEGIvMoQapmMVkd9bQF3H95nEGgSZt9zcFut/mKj1p+qjNkl4AvMVm2RwZHZtRem+r4ZBThvNMCUhnvS7Si6jW2OWHZWikpQU=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH linux-2.6-block:master 00/05] blk: generic dispatch queue
Message-ID: <20051019123429.450E4424@htj.dyndns.org>
Date: Wed, 19 Oct 2005 21:35:03 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 This patchset implements generic dispatch queue.

 This patchset is composed of three parts.

 * Implementation of generic dispatch queue & updating individual
   elevators.
 * Move last_merge handling into generic elevator.
 * biodoc update

 Currently, each specific iosched maintains its own dispatch queue to
handle ordering, requeueing, cluster dispatching, etc...  This causes
the following problems.

 * duplicated codes
 * difficult to enforce semantics over dispatch queue (request
   ordering, requeueing, ...)
 * specific ioscheds have to deal with non-fs or ordered requests.

 With generic dispatch queue, specific ioscheds are guaranteed to be
handed only non-barrier fs requests, such that ioscheds only have to
implement ordering logic of normal fs requests.  Also, callback
invocation is stricter now.  Each fs request follows one of the
following paths.

 set_req_fn ->

 i.   add_req_fn -> (merged_fn ->)* -> dispatch_fn -> activate_req_fn ->
      (deactivate_req_fn -> activate_req_fn ->)* -> completed_req_fn
 ii.  add_req_fn -> (merged_fn ->)* -> merge_req_fn
 iii. [nothing]

 -> put_req_fn

 Previously, elv_remove_request() and elv_completed_request() weren't
invoked for requests which are allocated outside blk layer (!rq->rl);
however, other elevator/iosched functions are called for such requests
making things a bit confusing.  As this patchset prevents non-fs
requests from going into specific ioscheds and removing the
inconsistency is necessary for implementation.  rq->rl tests in those
places are removed.

 With generic dispatch queue implemented, last_merge handling can be
moved into generic elevator proper.  The second part of this patchset
does that.  One problem this change introduces is that, noop iosched
loses its ability to merge requests (as no merging is allowed for
requests on a generic dispatch queue).  To add it back cleanly, we
need to make noop use a separate list instead of q->queue_head to keep
requests before dispatching.  I don't know how meaningful this would
be.  The change should be simple & easy.  If merging capability of
noop iosched is important, plz let me know.

[ Start of patch descriptions ]

01_blk_implement-generic-dispatch-queue.patch
	: implement generic dispatch queue

	Implements generic dispatch queue which can replace all
        dispatch queues implemented by each iosched.  This reduces
        code duplication, eases enforcing semantics over dispatch
        queue, and simplifies specific ioscheds.

02_blk_generic-dispatch-queue-update-for-ioscheds.patch
	: update ioscheds to use generic dispatch queue

	This patch updates all four ioscheds to use generic dispatch
	queue.  There's one behavior change in as-iosched.

	* In as-iosched, when force dispatching
	  (ELEVATOR_INSERT_BACK), batch_data_dir is reset to REQ_SYNC
	  and changed_batch and new_batch are cleared to zero.  This
	  prevernts AS from doing incorrect update_write_batch after
	  the forced dispatched requests are finished.

	* In cfq-iosched, cfqd->rq_in_driver currently counts the
	  number of activated (removed) requests to determine
	  whether queue-kicking is needed and cfq_max_depth has been
	  reached.  With generic dispatch queue, I think counting
	  the number of dispatched requests would be more appropriate.

	* cfq_max_depth can be lowered to 1 again.

03_blk_generic-last_merge-handling.patch
	: move last_merge handling into generic elevator code

	Currently, both generic elevator code and specific ioscheds
        participate in the management and usage of last_merge.  This
        and the following patches move last_merge handling into
        generic elevator code.

04_blk_generic-last_merge-handling-update-for-ioscheds.patch
	: remove last_merge handling from ioscheds

	Remove last_merge handling from all ioscheds.  This patch
	removes merging capability of noop iosched.

05_blk_update-biodoc.patch
	: update biodoc

	Updates biodoc to reflect changes in elevator API.

[ End of patch descriptions ]

 Thanks.

--
tejun

