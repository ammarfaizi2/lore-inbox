Return-Path: <linux-kernel-owner+w=401wt.eu-S1751020AbXAQWzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbXAQWzz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbXAQWzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:55:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56033 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023AbXAQWzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:55:54 -0500
Subject: [PATCH: 2.6.20-rc4-mm1] JFS: Avoid deadlock introduced by explicit
	I/O plugging
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 16:55:49 -0600
Message-Id: <1169074549.10560.10.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens,
Can you please take a look at this patch, and if you think it's sane,
add it to your explicit i/o plugging patchset?  Would it make sense in
any of these paths to use io_schedule() instead of schedule()?

I hadn't looked at your patchset until I discovered that jfs was easy to
hang in the -mm kernel.  I think jfs may be able to add explicit
plugging and unplugging in a couple of places, but I'd like to fix the
hang right away and take my time with any later patches.

Thanks,
Shaggy

JFS: Avoid deadlock introduced by explicit I/O plugging

jfs is pretty easy to deadlock with Jens' explicit i/o plugging patchset.
Just try building a kernel.

The problem occurs when a synchronous transaction initiates some I/O, then
waits in lmGroupCommit for the transaction to be committed to the journal.
This requires action by the commit thread, which ends up waiting on a page
to complete writeback.  The commit thread did not initiate the I/O, so it
cannot unplug the io queue, and deadlock occurs.

The fix is for the first thread to call blk_replug_current_nested() before
going to sleep.  This patch also adds the call to a couple other places that
look like they need it.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

diff -Nurp linux-2.6.20-rc4-mm1/fs/jfs/jfs_lock.h linux/fs/jfs/jfs_lock.h
--- linux-2.6.20-rc4-mm1/fs/jfs/jfs_lock.h	2006-11-29 15:57:37.000000000 -0600
+++ linux/fs/jfs/jfs_lock.h	2007-01-17 15:30:19.000000000 -0600
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/sched.h>
+#include <linux/blkdev.h>
 
 /*
  *	jfs_lock.h
@@ -42,6 +43,7 @@ do {							\
 		if (cond)				\
 			break;				\
 		unlock_cmd;				\
+		blk_replug_current_nested();		\
 		schedule();				\
 		lock_cmd;				\
 	}						\
diff -Nurp linux-2.6.20-rc4-mm1/fs/jfs/jfs_metapage.c linux/fs/jfs/jfs_metapage.c
--- linux-2.6.20-rc4-mm1/fs/jfs/jfs_metapage.c	2007-01-12 09:50:45.000000000 -0600
+++ linux/fs/jfs/jfs_metapage.c	2007-01-17 15:28:46.000000000 -0600
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/buffer_head.h>
 #include <linux/mempool.h>
+#include <linux/blkdev.h>
 #include "jfs_incore.h"
 #include "jfs_superblock.h"
 #include "jfs_filsys.h"
@@ -56,6 +57,7 @@ static inline void __lock_metapage(struc
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (metapage_locked(mp)) {
 			unlock_page(mp->page);
+			blk_replug_current_nested();
 			schedule();
 			lock_page(mp->page);
 		}
diff -Nurp linux-2.6.20-rc4-mm1/fs/jfs/jfs_txnmgr.c linux/fs/jfs/jfs_txnmgr.c
--- linux-2.6.20-rc4-mm1/fs/jfs/jfs_txnmgr.c	2007-01-12 09:50:45.000000000 -0600
+++ linux/fs/jfs/jfs_txnmgr.c	2007-01-17 15:29:04.000000000 -0600
@@ -50,6 +50,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kthread.h>
+#include <linux/blkdev.h>
 #include "jfs_incore.h"
 #include "jfs_inode.h"
 #include "jfs_filsys.h"
@@ -135,6 +136,7 @@ static inline void TXN_SLEEP_DROP_LOCK(w
 	add_wait_queue(event, &wait);
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	TXN_UNLOCK();
+	blk_replug_current_nested();
 	schedule();
 	current->state = TASK_RUNNING;
 	remove_wait_queue(event, &wait);

-- 
David Kleikamp
IBM Linux Technology Center

