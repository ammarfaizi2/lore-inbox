Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUKJQ3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUKJQ3U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 11:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUKJQ3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 11:29:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:6080 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261993AbUKJQ2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 11:28:41 -0500
Date: Wed, 10 Nov 2004 17:28:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.10-rc1-mm4
Message-ID: <20041110162809.GQ5602@suse.de>
References: <20041109074909.3f287966.akpm@osdl.org> <20041109161112.GA3921@suse.de> <20041109115338.59d195ec.akpm@osdl.org> <20041109211409.GB3921@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109211409.GB3921@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09 2004, Jens Axboe wrote:
> On Tue, Nov 09 2004, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > On Tue, Nov 09 2004, Andrew Morton wrote:
> > > > +blk_sync_queue-updates.patch
> > > > 
> > > >  update an update to the md updates
> > > 
> > > I still don't think this is a good general export, it has very
> > > specialized use. For example, from the description it looks like this
> > > can be generally used on any block device and when it returns, we have
> > > synced the queue. This simply isn't true, there are absolutely no
> > > guarentees of that nature unless the block driver itself implements the
> > > __make_request() functionality and has taken proper precautions to
> > > prevent this already.
> > 
> > True.   So what do we do?  Grit our teeth and move it into MD?
> 
> That, or just comment it appropriately instead. Or, perhaps better, make

Here's a patch to just correct the comment. The md usage is safe because
it switches ->make_request_fn before syncing the queue and on second
thought it is a bit silly to add freeze/unfreeze functionality that no
one will use right now anyways. Alternatively, we could add this
functionality to the core so the interface would be

	/* callers wait for unfreeze */
	blk_freeze_queue(q, FREEZE_WAIT);

or

	/* callers are io errored immediately */
	blk_freeze_queue(q, FREEZE_END_IO);

which would work for both. I'll keep it in mind if such a use becomes
attractive, for now I think we should just correct the comment.

--- linux-2.6.10-rc1-mm4/drivers/block/ll_rw_blk.c~	2004-11-10 17:23:36.166564568 +0100
+++ linux-2.6.10-rc1-mm4/drivers/block/ll_rw_blk.c	2004-11-10 17:24:41.139041569 +0100
@@ -1361,7 +1361,7 @@
 EXPORT_SYMBOL(blk_stop_queue);
 
 /**
- * blk_sync_queue - cancel any pending callbacks a queue
+ * blk_sync_queue - cancel any pending callbacks on a queue
  * @q: the queue
  *
  * Description:
@@ -1369,7 +1369,9 @@
  *     on a queue, such as calling the unplug function after a timeout.
  *     A block device may call blk_sync_queue to ensure that any
  *     such activity is cancelled, thus allowing it to release resources
- *     the the callbacks might use.
+ *     the the callbacks might use. The caller must already have made sure
+ *     that its ->make_request_fn will not re-add plugging prior to calling
+ *     this function.
  *
  */
 void blk_sync_queue(struct request_queue *q)

-- 
Jens Axboe

