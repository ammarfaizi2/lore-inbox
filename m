Return-Path: <linux-kernel-owner+w=401wt.eu-S1751906AbXARDXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbXARDXn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 22:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbXARDXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 22:23:43 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:60911 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbXARDXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 22:23:41 -0500
Subject: Re: [PATCH: 2.6.20-rc4-mm1] JFS: Avoid deadlock introduced by
	explicit  I/O plugging
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20070117234653.GI3508@kernel.dk>
References: <1169074549.10560.10.camel@kleikamp.austin.ibm.com>
	 <20070117231847.GH3508@kernel.dk>
	 <1169077157.10560.16.camel@kleikamp.austin.ibm.com>
	 <20070117234653.GI3508@kernel.dk>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 21:23:36 -0600
Message-Id: <1169090616.10560.21.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 10:46 +1100, Jens Axboe wrote:
> On Wed, Jan 17 2007, Dave Kleikamp wrote:
> > On Thu, 2007-01-18 at 10:18 +1100, Jens Axboe wrote:
> >
> > > Can you try io_schedule() and verify that things just work?
> >
> > I actually did do that in the first place, but wondered if it was the
> > right thing to introduce the accounting changes that came with that.
> > I'll change it back to io_schedule() and test it again, just to make
> > sure.
> 
> It appears to be the correct change to me - you really are waiting for
> IO resources (otherwise it would not hang with the plug change), so
> doing an inc/dec of iowait around the schedule should be done.

Okay, here it is.

> > If that's the right fix, I can push it directly since it won't have any
> > dependencies on your patches.
> 
> Perfect!

It should make the next -mm.

JFS: call io_schedule() instead of schedule() to avoid deadlock

The introduction of Jens Axboe's explicit i/o plugging patches introduced a
deadlock in jfs.  This was caused by the process initiating I/O not
unplugging the queue before waiting on the commit thread.  The commit
thread itself was waiting for that I/O to complete.  Calling io_schedule()
rather than schedule() unplugs the I/O queue avoiding the deadlock, and it
appears to be the right function to call in any case.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

---
commit 4aa0d230c2cfc1ac4bcf7c5466f9943cf14233a9
tree b873dce6146f4880c6c48ab53c0079566f52a60b
parent 82d5b9a7c63054a9a2cd838ffd177697f86e7e34
author Dave Kleikamp <shaggy@linux.vnet.ibm.com> Wed, 17 Jan 2007 21:18:35 -0600
committer Dave Kleikamp <shaggy@linux.vnet.ibm.com> Wed, 17 Jan 2007 21:18:35 -0600

 fs/jfs/jfs_lock.h     |    2 +-
 fs/jfs/jfs_metapage.c |    2 +-
 fs/jfs/jfs_txnmgr.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_lock.h b/fs/jfs/jfs_lock.h
index 7d78e83..df48ece 100644
--- a/fs/jfs/jfs_lock.h
+++ b/fs/jfs/jfs_lock.h
@@ -42,7 +42,7 @@ do {							\
 		if (cond)				\
 			break;				\
 		unlock_cmd;				\
-		schedule();				\
+		io_schedule();				\
 		lock_cmd;				\
 	}						\
 	current->state = TASK_RUNNING;			\
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index ceaf03b..58deae0 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -56,7 +56,7 @@ static inline void __lock_metapage(struct metapage *mp)
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (metapage_locked(mp)) {
 			unlock_page(mp->page);
-			schedule();
+			io_schedule();
 			lock_page(mp->page);
 		}
 	} while (trylock_metapage(mp));
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index d558e51..6988a10 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -135,7 +135,7 @@ static inline void TXN_SLEEP_DROP_LOCK(wait_queue_head_t * event)
 	add_wait_queue(event, &wait);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	TXN_UNLOCK();
-	schedule();
+	io_schedule();
 	current->state = TASK_RUNNING;
 	remove_wait_queue(event, &wait);
 }

-- 
David Kleikamp
IBM Linux Technology Center

