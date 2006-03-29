Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWC2QzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWC2QzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 11:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWC2QzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 11:55:12 -0500
Received: from mx2.netapp.com ([216.240.18.37]:49038 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1750839AbWC2QzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 11:55:10 -0500
X-IronPort-AV: i="4.03,144,1141632000"; 
   d="scan'208"; a="370773321:sNHT217844708"
Subject: fs/locks.c: Fix sys_flock() race
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Wed, 29 Mar 2006 11:55:08 -0500
Message-Id: <1143651308.8697.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 29 Mar 2006 16:55:09.0677 (UTC) FILETIME=[89D8A1D0:01C65351]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <Trond.Myklebust@netapp.com>

sys_flock() currently has a race which can result in a double free in the
multi-thread case.

Thread 1			Thread 2

sys_flock(file, LOCK_EX)
				sys_flock(file, LOCK_UN)

If Thread 2 removes the lock from inode->i_lock before Thread 1 tests for
list_empty(&lock->fl_link) at the end of sys_flock, then both threads
will end up calling locks_free_lock for the same lock.

Fix is to make flock_lock_file() do the same as posix_lock_file(), namely
to make a copy of the request, so that the caller can always free the lock.

This also has the side-effect of fixing up a reference problem in the
lockd handling of flock.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/locks.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 4d9e71d..6ba3756 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -735,8 +735,9 @@ EXPORT_SYMBOL(posix_locks_deadlock);
  * at the head of the list, but that's secret knowledge known only to
  * flock_lock_file and posix_lock_file.
  */
-static int flock_lock_file(struct file *filp, struct file_lock *new_fl)
+static int flock_lock_file(struct file *filp, struct file_lock *request)
 {
+	struct file_lock *new_fl = NULL;
 	struct file_lock **before;
 	struct inode * inode = filp->f_dentry->d_inode;
 	int error = 0;
@@ -751,17 +752,19 @@ static int flock_lock_file(struct file *
 			continue;
 		if (filp != fl->fl_file)
 			continue;
-		if (new_fl->fl_type == fl->fl_type)
+		if (request->fl_type == fl->fl_type)
 			goto out;
 		found = 1;
 		locks_delete_lock(before);
 		break;
 	}
-	unlock_kernel();
 
-	if (new_fl->fl_type == F_UNLCK)
-		return 0;
+	if (request->fl_type == F_UNLCK)
+		goto out;
 
+	new_fl = locks_alloc_lock();
+	if (new_fl == NULL)
+		goto out;
 	/*
 	 * If a higher-priority process was blocked on the old file lock,
 	 * give it the opportunity to lock the file.
@@ -769,26 +772,27 @@ static int flock_lock_file(struct file *
 	if (found)
 		cond_resched();
 
-	lock_kernel();
 	for_each_lock(inode, before) {
 		struct file_lock *fl = *before;
 		if (IS_POSIX(fl))
 			break;
 		if (IS_LEASE(fl))
 			continue;
-		if (!flock_locks_conflict(new_fl, fl))
+		if (!flock_locks_conflict(request, fl))
 			continue;
 		error = -EAGAIN;
-		if (new_fl->fl_flags & FL_SLEEP) {
-			locks_insert_block(fl, new_fl);
-		}
+		if (request->fl_flags & FL_SLEEP)
+			locks_insert_block(fl, request);
 		goto out;
 	}
+	locks_copy_lock(new_fl, request);
 	locks_insert_lock(&inode->i_flock, new_fl);
-	error = 0;
+	new_fl = NULL;
 
 out:
 	unlock_kernel();
+	if (new_fl)
+		locks_free_lock(new_fl);
 	return error;
 }
 
@@ -1569,9 +1573,7 @@ asmlinkage long sys_flock(unsigned int f
 		error = flock_lock_file_wait(filp, lock);
 
  out_free:
-	if (list_empty(&lock->fl_link)) {
-		locks_free_lock(lock);
-	}
+	locks_free_lock(lock);
 
  out_putf:
 	fput(filp);
