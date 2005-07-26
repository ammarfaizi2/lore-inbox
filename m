Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVGZN7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVGZN7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVGZN5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:57:49 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:51264 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261799AbVGZN4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:56:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=J7WRpdPCmiiAyWulKNzx55Ie/3VBzemrEnQ4RAe2tJ0UA7p+jpAAZJXflJ+r+ovyVeA5LFjig15TeefEXO3JMc+0ZY2OET6iVelgE9yXLeLrvDvndlompK3dsVFm6JvMJpC1RLxmGQzJysHshuxoMyuZVl5v3iIFbWtzdcZfR7A=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726135502.D83FC6EE@htj.dyndns.org>
In-Reply-To: <20050726135502.D83FC6EE@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 05/05] blk: update biodoc
Message-ID: <20050726135502.3A3F3C6C@htj.dyndns.org>
Date: Tue, 26 Jul 2005 22:56:42 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

05_blk_update-biodoc.patch

	Updates biodoc to reflect changes in elevator API.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 biodoc.txt |  113 ++++++++++++++++++++++++++++---------------------------------
 1 files changed, 52 insertions(+), 61 deletions(-)

Index: blk-fixes/Documentation/block/biodoc.txt
===================================================================
--- blk-fixes.orig/Documentation/block/biodoc.txt	2005-07-26 22:54:59.000000000 +0900
+++ blk-fixes/Documentation/block/biodoc.txt	2005-07-26 22:55:01.000000000 +0900
@@ -906,9 +906,20 @@ Aside:
 
 
 4. The I/O scheduler
-I/O schedulers are now per queue. They should be runtime switchable and modular
-but aren't yet. Jens has most bits to do this, but the sysfs implementation is
-missing.
+I/O scheduler, a.k.a. elevator, is implemented in two layers.  Generic dispatch
+queue and specific I/O schedulers.  Unless stated otherwise, elevator is used
+to refer to both parts and I/O scheduler to specific I/O schedulers.
+
+Block layer implements generic dispatch queue in ll_rw_blk.c and elevator.c.
+The generic dispatch queue is responsible for properly ordering barrier
+requests, requeueing, handling non-fs requests and all other subtleties.
+
+Specific I/O schedulers are responsible for ordering normal filesystem
+requests.  They can also choose to delay certain requests to improve
+throughput or whatever purpose.  As the plural form indicates, there are
+multiple I/O schedulers.  They can be built as modules but at least one should
+be built inside the kernel.  Each queue can choose different one and can also
+change to another one dynamically.
 
 A block layer call to the i/o scheduler follows the convention elv_xxx(). This
 calls elevator_xxx_fn in the elevator switch (drivers/block/elevator.c). Oh,
@@ -921,44 +932,36 @@ keeping work.
 The functions an elevator may implement are: (* are mandatory)
 elevator_merge_fn		called to query requests for merge with a bio
 
-elevator_merge_req_fn		" " "  with another request
+elevator_merge_req_fn		called when two requests get merged. the one
+				which gets merged into the other one will be
+				never seen by I/O scheduler again. IOW, after
+				being merged, the request is gone.
 
 elevator_merged_fn		called when a request in the scheduler has been
 				involved in a merge. It is used in the deadline
 				scheduler for example, to reposition the request
 				if its sorting order has changed.
 
-*elevator_next_req_fn		returns the next scheduled request, or NULL
-				if there are none (or none are ready).
+elevator_dispatch_fn		fills the dispatch queue with ready requests.
+				I/O schedulers are free to postpone requests by
+				not filling the dispatch queue unless @force
+				is non-zero.  Once dispatched, I/O schedulers
+				are not allowed to manipulate the requests -
+				they belong to generic dispatch queue.
 
-*elevator_add_req_fn		called to add a new request into the scheduler
+elevator_add_req_fn		called to add a new request into the scheduler
 
 elevator_queue_empty_fn		returns true if the merge queue is empty.
 				Drivers shouldn't use this, but rather check
 				if elv_next_request is NULL (without losing the
 				request if one exists!)
 
-elevator_remove_req_fn		This is called when a driver claims ownership of
-				the target request - it now belongs to the
-				driver. It must not be modified or merged.
-				Drivers must not lose the request! A subsequent
-				call of elevator_next_req_fn must  return the
-				_next_ request.
-
-elevator_requeue_req_fn		called to add a request to the scheduler. This
-				is used when the request has alrnadebeen
-				returned by elv_next_request, but hasn't
-				completed. If this is not implemented then
-				elevator_add_req_fn is called instead.
-
 elevator_former_req_fn
 elevator_latter_req_fn		These return the request before or after the
 				one specified in disk sort order. Used by the
 				block layer to find merge possibilities.
 
-elevator_completed_req_fn	called when a request is completed. This might
-				come about due to being merged with another or
-				when the device completes the request.
+elevator_completed_req_fn	called when a request is completed.
 
 elevator_may_queue_fn		returns true if the scheduler wants to allow the
 				current context to queue a new request even if
@@ -967,13 +970,33 @@ elevator_may_queue_fn		returns true if t
 
 elevator_set_req_fn
 elevator_put_req_fn		Must be used to allocate and free any elevator
-				specific storate for a request.
+				specific storage for a request.
+
+elevator_activate_req_fn	Called when device driver first sees a request.
+				I/O schedulers can use this callback to
+				determine when actual execution of a request
+				starts.
+elevator_deactivate_req_fn	Called when device driver decides to delay
+				a request by requeueing it.
 
 elevator_init_fn
 elevator_exit_fn		Allocate and free any elevator specific storage
 				for a queue.
 
-4.2 I/O scheduler implementation
+4.2 Request flows seen by I/O schedulers
+All requests seens by I/O schedulers strictly follow one of the following three
+flows.
+
+ set_req_fn ->
+
+ i.   add_req_fn -> (merged_fn ->)* -> dispatch_fn -> activate_req_fn ->
+      (deactivate_req_fn -> activate_req_fn ->)* -> completed_req_fn
+ ii.  add_req_fn -> (merged_fn ->)* -> merge_req_fn
+ iii. [none]
+
+ -> put_req_fn
+
+4.3 I/O scheduler implementation
 The generic i/o scheduler algorithm attempts to sort/merge/batch requests for
 optimal disk scan and request servicing performance (based on generic
 principles and device capabilities), optimized for:
@@ -993,18 +1016,7 @@ request in sort order to prevent binary 
 This arrangement is not a generic block layer characteristic however, so
 elevators may implement queues as they please.
 
-ii. Last merge hint
-The last merge hint is part of the generic queue layer. I/O schedulers must do
-some management on it. For the most part, the most important thing is to make
-sure q->last_merge is cleared (set to NULL) when the request on it is no longer
-a candidate for merging (for example if it has been sent to the driver).
-
-The last merge performed is cached as a hint for the subsequent request. If
-sequential data is being submitted, the hint is used to perform merges without
-any scanning. This is not sufficient when there are multiple processes doing
-I/O though, so a "merge hash" is used by some schedulers.
-
-iii. Merge hash
+ii. Merge hash
 AS and deadline use a hash table indexed by the last sector of a request. This
 enables merging code to quickly look up "back merge" candidates, even when
 multiple I/O streams are being performed at once on one disk.
@@ -1013,29 +1025,8 @@ multiple I/O streams are being performed
 are far less common than "back merges" due to the nature of most I/O patterns.
 Front merges are handled by the binary trees in AS and deadline schedulers.
 
-iv. Handling barrier cases
-A request with flags REQ_HARDBARRIER or REQ_SOFTBARRIER must not be ordered
-around. That is, they must be processed after all older requests, and before
-any newer ones. This includes merges!
-
-In AS and deadline schedulers, barriers have the effect of flushing the reorder
-queue. The performance cost of this will vary from nothing to a lot depending
-on i/o patterns and device characteristics. Obviously they won't improve
-performance, so their use should be kept to a minimum.
-
-v. Handling insertion position directives
-A request may be inserted with a position directive. The directives are one of
-ELEVATOR_INSERT_BACK, ELEVATOR_INSERT_FRONT, ELEVATOR_INSERT_SORT.
-
-ELEVATOR_INSERT_SORT is a general directive for non-barrier requests.
-ELEVATOR_INSERT_BACK is used to insert a barrier to the back of the queue.
-ELEVATOR_INSERT_FRONT is used to insert a barrier to the front of the queue, and
-overrides the ordering requested by any previous barriers. In practice this is
-harmless and required, because it is used for SCSI requeueing. This does not
-require flushing the reorder queue, so does not impose a performance penalty.
-
-vi. Plugging the queue to batch requests in anticipation of opportunities for
-  merge/sort optimizations
+iii. Plugging the queue to batch requests in anticipation of opportunities for
+     merge/sort optimizations
 
 This is just the same as in 2.4 so far, though per-device unplugging
 support is anticipated for 2.5. Also with a priority-based i/o scheduler,
@@ -1069,7 +1060,7 @@ Aside:
   blk_kick_queue() to unplug a specific queue (right away ?)
   or optionally, all queues, is in the plan.
 
-4.3 I/O contexts
+4.4 I/O contexts
 I/O contexts provide a dynamically allocated per process data area. They may
 be used in I/O schedulers, and in the block layer (could be used for IO statis,
 priorities for example). See *io_context in drivers/block/ll_rw_blk.c, and

