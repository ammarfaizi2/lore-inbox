Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVGZN40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVGZN40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVGZN4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:56:25 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:47497 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261775AbVGZN4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:56:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=YWG4jrhuchIN8rXAAKMALBqhX7EqW2JK0PYrVko2wIKicMTb2kyV6dgWeOolYNk0N3izt+kk16A+Jy/pXBWMjanXPPMH8CfUsWetwoNjHigm9SCDTtitsfiZ5av7fpu6UJk70C50Wkc/ELdoYGAY62SOGIyvs+f6ltoFFPRcoGc=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH linux-2.6-block:master 00/05] blk: generic dispatch queue
Message-ID: <20050726135502.D83FC6EE@htj.dyndns.org>
Date: Tue, 26 Jul 2005 22:56:17 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Jens.

 This patchset implements generic dispatch queue.  The patches are
against the master head of linux-2.6-block tree.

 Changes from the first posting of this patchset are...

 * elevator_activate_req_fn is now called when the driver first sees
   the request (the first elv_next_request() of a request) not when
   the request is removed.  This makes iosched's accounting identical
   to before.  There should be no noticeable behavior change.
 * All ioscheds are updated
 * Doc update
 * Misc comment/code changes

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
 iii. [none]

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

