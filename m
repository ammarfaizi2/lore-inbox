Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbVKAIYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbVKAIYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVKAIYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:24:01 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:41278 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964978AbVKAIX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:23:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=O5XUa89BwQTQKIlPzCzJpWoDmy8lR5Rr7lUOxY0KQUmfAb4yRp31JP2JiV12W43ywc0F3uU+ygpH46vzU6xs8H9mN0HqHX5lfMFYguKH/A9a8EwZApGp40dLntmfmo87Xd6rL240ZVtMLYOw0SPgBkufTq8qInU3KKrjRWagjNA=
Date: Tue, 1 Nov 2005 17:23:49 +0900
From: Tejun Heo <htejun@gmail.com>
To: torvalds@osdl.org, axboe@suse.de, acme@mandriva.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] blk: fix dangling pointer access in __elv_add_request
Message-ID: <20051101082349.GA17756@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cfq's add_req_fn callback may invoke q->request_fn directly and
depending on low-level driver used and timing, a queued request may be
finished & deallocated before add_req_fn callback returns.  So,
__elv_add_request must not access rq after it's passed to add_req_fn
callback.

This patch moves rq_mergeable test above add_req_fn().  This may
result in q->last_merge pointing to REQ_NOMERGE request if add_req_fn
callback sets it but as RQ_NOMERGE is checked again when blk layer
actually tries to merge requests, this does not cause any problem.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Arnaldo, I think this patch should fix the oops you're seeing.  Please
let me know how it works.  And thanks again for detailed reporting.

Jens, does generalizing queue kicking functions and disallowing
ioscheds from directly calling q->request_fn sound like a good idea?

Linus, with or without Arnaldo's confirmation, this patch fixes an
existing bug.  Please apply.  Thanks.

diff --git a/drivers/block/elevator.c b/drivers/block/elevator.c
--- a/drivers/block/elevator.c
+++ b/drivers/block/elevator.c
@@ -369,9 +369,14 @@ void __elv_add_request(request_queue_t *
 	case ELEVATOR_INSERT_SORT:
 		BUG_ON(!blk_fs_request(rq));
 		rq->flags |= REQ_SORTED;
-		q->elevator->ops->elevator_add_req_fn(q, rq);
 		if (q->last_merge == NULL && rq_mergeable(rq))
 			q->last_merge = rq;
+		/*
+		 * Some ioscheds (cfq) run q->request_fn directly, so
+		 * rq cannot be accessed after calling
+		 * elevator_add_req_fn.
+		 */
+		q->elevator->ops->elevator_add_req_fn(q, rq);
 		break;
 
 	default:
