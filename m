Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130386AbQJ1QrD>; Sat, 28 Oct 2000 12:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130098AbQJ1Qqy>; Sat, 28 Oct 2000 12:46:54 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:24271 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130083AbQJ1Qql>; Sat, 28 Oct 2000 12:46:41 -0400
Message-ID: <39FB02D5.9AF89277@uow.edu.au>
Date: Sun, 29 Oct 2000 03:46:13 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kumon@flab.fujitsu.co.jp, Andi Kleen <ak@suse.de>,
        Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: 
 Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>,
			<39F92187.A7621A09@timpanogas.org>
			<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
			<20001027094613.A18382@gruyere.muc.suse.de>
			<39F957BC.4289FF10@uow.edu.au> <200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp> <39FAF4C6.3BB04774@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> I think it's more expedient at this time to convert
> acquire_fl_sem/release_fl_sem into lock_kernel/unlock_kernel
> (so we _can_ sleep) and to fix the above alleged deadlock
> via the creation of __posix_unblock_lock()

I agree with me.  Could you please test the scalability
of this?



--- linux-2.4.0-test10-pre5/fs/locks.c	Tue Oct 24 21:34:13 2000
+++ linux-akpm/fs/locks.c	Sun Oct 29 03:34:15 2000
@@ -1706,11 +1706,25 @@
 posix_unblock_lock(struct file_lock *waiter)
 {
 	acquire_fl_sem();
+	__posix_unblock_lock(waiter);
+	release_fl_sem();
+}
+
+/**
+ *	__posix_unblock_lock - stop waiting for a file lock
+ *	@waiter: the lock which was waiting
+ *
+ *	lockd needs to block waiting for locks.
+ *	Like posix_unblock_lock(), except it doesn't
+ *	acquire the file lock semaphore.
+ */
+void
+__posix_unblock_lock(struct file_lock *waiter)
+{
 	if (!list_empty(&waiter->fl_block)) {
 		locks_delete_block(waiter);
 		wake_up(&waiter->fl_wait);
 	}
-	release_fl_sem();
 }
 
 static void lock_get_status(char* out, struct file_lock *fl, int id, char *pfx)
--- linux-2.4.0-test10-pre5/include/linux/fs.h	Tue Oct 24 21:34:13 2000
+++ linux-akpm/include/linux/fs.h	Sun Oct 29 03:32:00 2000
@@ -564,6 +564,7 @@
 extern struct file_lock *posix_test_lock(struct file *, struct file_lock *);
 extern int posix_lock_file(struct file *, struct file_lock *, unsigned int);
 extern void posix_block_lock(struct file_lock *, struct file_lock *);
+extern void __posix_unblock_lock(struct file_lock *);
 extern void posix_unblock_lock(struct file_lock *);
 extern int __get_lease(struct inode *inode, unsigned int flags);
 extern time_t lease_get_mtime(struct inode *);
--- linux-2.4.0-test10-pre5/kernel/ksyms.c	Sun Oct 15 01:27:46 2000
+++ linux-akpm/kernel/ksyms.c	Sun Oct 29 03:32:38 2000
@@ -221,6 +221,7 @@
 EXPORT_SYMBOL(posix_lock_file);
 EXPORT_SYMBOL(posix_test_lock);
 EXPORT_SYMBOL(posix_block_lock);
+EXPORT_SYMBOL(__posix_unblock_lock);
 EXPORT_SYMBOL(posix_unblock_lock);
 EXPORT_SYMBOL(locks_mandatory_area);
 EXPORT_SYMBOL(dput);
--- linux-2.4.0-test10-pre5/fs/lockd/svclock.c	Tue Oct 24 21:34:13 2000
+++ linux-akpm/fs/lockd/svclock.c	Sun Oct 29 03:32:22 2000
@@ -456,7 +456,7 @@
 	struct nlm_block	**bp, *block;
 
 	dprintk("lockd: VFS unblock notification for block %p\n", fl);
-	posix_unblock_lock(fl);
+	__posix_unblock_lock(fl);
 	for (bp = &nlm_blocked; (block = *bp); bp = &block->b_next) {
 		if (nlm_compare_locks(&block->b_call.a_args.lock.fl, fl)) {
 			svc_wake_up(block->b_daemon);
--- linux-2.4.0-test10-pre5/fs/fcntl.c	Sun Oct 15 01:27:45 2000
+++ linux-akpm/fs/fcntl.c	Sun Oct 29 03:35:47 2000
@@ -254,11 +254,15 @@
 			unlock_kernel();
 			break;
 		case F_GETLK:
+			lock_kernel();
 			err = fcntl_getlk(fd, (struct flock *) arg);
+			unlock_kernel();
 			break;
 		case F_SETLK:
 		case F_SETLKW:
+			lock_kernel();
 			err = fcntl_setlk(fd, cmd, (struct flock *) arg);
+			unlock_kernel();
 			break;
 		case F_GETOWN:
 			/*
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
