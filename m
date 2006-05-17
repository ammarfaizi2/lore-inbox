Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWEQWR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWEQWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWEQWMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:09 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54912 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751235AbWEQWME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:04 -0400
Message-Id: <20060517221353.982476000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:04 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 04/22] [PATCH] fs/locks.c: Fix sys_flock() race
Content-Disposition: inline; filename=fs-locks.c-Fix-sys_flock-race.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

sys_flock() currently has a race which can result in a double free in the
multi-thread case.

Thread 1			Thread 2

sys_flock(file, LOCK_EX)
				sys_flock(file, LOCK_UN)

If Thread 2 removes the lock from inode->i_lock before Thread 1 tests for
list_empty(&lock->fl_link) at the end of sys_flock, then both threads will
end up calling locks_free_lock for the same lock.

Fix is to make flock_lock_file() do the same as posix_lock_file(), namely
to make a copy of the request, so that the caller can always free the lock.

This also has the side-effect of fixing up a reference problem in the
lockd handling of flock.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 fs/locks.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--- linux-2.6.16.16.orig/fs/locks.c
+++ linux-2.6.16.16/fs/locks.c
@@ -714,8 +714,9 @@ EXPORT_SYMBOL(posix_locks_deadlock);
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
@@ -730,17 +731,19 @@ static int flock_lock_file(struct file *
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
@@ -748,26 +751,27 @@ static int flock_lock_file(struct file *
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
 
@@ -1532,9 +1536,7 @@ asmlinkage long sys_flock(unsigned int f
 		error = flock_lock_file_wait(filp, lock);
 
  out_free:
-	if (list_empty(&lock->fl_link)) {
-		locks_free_lock(lock);
-	}
+	locks_free_lock(lock);
 
  out_putf:
 	fput(filp);

--
