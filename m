Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269286AbUHaWog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269286AbUHaWog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269125AbUHaWoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:44:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269238AbUHaWmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:42:23 -0400
Date: Tue, 31 Aug 2004 17:42:14 -0500
From: Ken Preslan <kpreslan@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sfrench@samba.org
Subject: Re: [PATCH] Allow cluster-wide flock
Message-ID: <20040831224214.GA28219@potassium.msp.redhat.com>
References: <1093907129.8729.148.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093907129.8729.148.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2004 at 07:05:29PM -0400, Trond Myklebust wrote:
> ...
> Firstly, it would be nice to throw out the existing wait loop in
> sys_flock(), and replace it with a call to this new
> flock_lock_file_wait(). I suppose that can be done in a separate cleanup
> patch, though...
> ... 
> One solution that I've already suggested to Ken & co is to use a
> separate f_op->flock() call. That would be my preference, since the
> filesystems have to treat flock and posix locks differently anyway.
> ...

Thanks for the suggestions.  Below is a patch that implements both of
them.


diff -urN -p linux-2.6.9-rc1-mm2/fs/locks.c linux/fs/locks.c
--- linux-2.6.9-rc1-mm2/fs/locks.c	2004-08-31 16:44:58.385205028 -0500
+++ linux/fs/locks.c	2004-08-31 16:45:03.260092514 -0500
@@ -1392,24 +1392,12 @@ asmlinkage long sys_flock(unsigned int f
 	if (error)
 		goto out_free;
 
-	if (filp->f_op && filp->f_op->lock) {
-		error = filp->f_op->lock(filp,
-					(can_sleep) ? F_SETLKW : F_SETLK,
-					lock);
-		goto out_free;
-	}
-
-	for (;;) {
-		error = flock_lock_file(filp, lock);
-		if ((error != -EAGAIN) || !can_sleep)
-			break;
-		error = wait_event_interruptible(lock->fl_wait, !lock->fl_next);
-		if (!error)
-			continue;
-
-		locks_delete_block(lock);
-		break;
-	}
+	if (filp->f_op && filp->f_op->flock)
+		error = filp->f_op->flock(filp,
+					  (can_sleep) ? F_SETLKW : F_SETLK,
+					  lock);
+	else
+		error = flock_lock_file_wait(filp, lock);
 
  out_free:
 	if (list_empty(&lock->fl_link)) {
@@ -1766,10 +1754,10 @@ void locks_remove_flock(struct file *fil
 	if (!inode->i_flock)
 		return;
 
-	if (filp->f_op && filp->f_op->lock) {
+	if (filp->f_op && filp->f_op->flock) {
 		struct file_lock fl = { .fl_flags = FL_FLOCK,
 					.fl_type = F_UNLCK };
-		filp->f_op->lock(filp, F_SETLKW, &fl);
+		filp->f_op->flock(filp, F_SETLKW, &fl);
 	}
 
 	lock_kernel();
diff -urN -p linux-2.6.9-rc1-mm2/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.6.9-rc1-mm2/include/linux/fs.h	2004-08-31 16:44:58.386204800 -0500
+++ linux/include/linux/fs.h	2004-08-31 16:45:03.261092285 -0500
@@ -983,6 +983,7 @@ struct file_operations {
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 	int (*check_flags)(int);
 	int (*dir_notify)(struct file *filp, unsigned long arg);
+	int (*flock) (struct file *, int, struct file_lock *);
 };
 
 struct inode_operations {

-- 
Ken Preslan <kpreslan@redhat.com>

