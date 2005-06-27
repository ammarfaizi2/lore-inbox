Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVF0S0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVF0S0b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVF0S0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:26:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53893 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261556AbVF0SZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:25:01 -0400
Message-ID: <42C043B0.1040103@redhat.com>
Date: Mon, 27 Jun 2005 14:21:36 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] stale POSIX lock handling
Content-Type: multipart/mixed;
 boundary="------------040306070609000900010305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040306070609000900010305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

I believe that there is a problem with the handling of POSIX locks,
which the attached patch should address.

The problem appears to be a race between fcntl(2) and close(2).
A multithreaded application could close a file descriptor at the same time
as it is trying to acquire a lock using the same file descriptor.  I would
suggest that that multithreaded application is not providing the proper
synchronization for itself, but the OS should still behave correctly.

SUS3 (Single UNIX Specification Version 3, read: POSIX) indicates that
when a file descriptor is closed, that all POSIX locks on the file,
owned by the process which closed the file descriptor, should be released.

The trick here is when those locks are released.  The current code
releases all locks which exist when close is processing, but any locks in
progress are handled when the last reference to the open file is released.

There are three cases to consider.

One is the simple case, a multithreaded (mt) process has a file open
and races to close it and acquire a lock on it.  In this case, the close
will release one reference to the open file and when the fcntl is done,
it will release the other reference.  For this situation, no locks should
exist on the file when both the close and fcntl operations are done.
The current system will handle this case because the last reference to
the open file is being released.

The second case is when the mt process has dup(2)'d the file descriptor.
The close will release one reference to the file and the fcntl, when done,
will release another, but there will still be at least one more reference
to the open file.  One could argue that the existence of a lock on the
file after the close has completed is okay, because it was acquired
after the close operation and there is still a way for the application
to release the lock on the file, using an existing file descriptor.

The third case is when the mt process has forked, after opening the
file and either before or after becoming an mt process.  In this case,
each process would hold a reference to the open file.  For each process,
this degenerates to first case above.  However, the lock continues to
exist until both processes have released their references to the open
file.  This lock could block other lock requests.

The changes to release the lock when the last reference to the open file
aren't quite right because they would allow the lock to exist as long as
there was a reference to the open file.  This is too long.

The new proposed solution is to add support in the fcntl code path
to detect a race with close and then to release the lock which was
just acquired when such as race is detected.  This causes locks to be
released in a timely fashion and for the system to conform to the POSIX
semantic specification.

This was tested by instrumenting a kernel to detect the handling locks
and then running a program which generates case #3 above.  A dangling lock
could be reliably generated.  When the changes to detect the close/fcntl
race were added, a dangling lock could no longer be generated.

My apologies for the length of this note.  Describing the situations in
words is difficult and takes a bunch of them to do so.  :-)

    Thanx...

       ps


--------------040306070609000900010305
Content-Type: text/plain;
 name="devel"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="devel"

--- ./fs/locks.c.org	2005-06-27 08:54:55.000000000 -0400
+++ ./fs/locks.c	2005-06-27 13:24:38.447157408 -0400
@@ -1589,7 +1589,8 @@ out:
 /* Apply the lock described by l to an open file descriptor.
  * This implements both the F_SETLK and F_SETLKW commands of fcntl().
  */
-int fcntl_setlk(struct file *filp, unsigned int cmd, struct flock __user *l)
+int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
+		struct flock __user *l)
 {
 	struct file_lock *file_lock = locks_alloc_lock();
 	struct flock flock;
@@ -1618,6 +1619,7 @@ int fcntl_setlk(struct file *filp, unsig
 		goto out;
 	}
 
+again:
 	error = flock_to_posix_lock(filp, file_lock, &flock);
 	if (error)
 		goto out;
@@ -1646,25 +1648,34 @@ int fcntl_setlk(struct file *filp, unsig
 	if (error)
 		goto out;
 
-	if (filp->f_op && filp->f_op->lock != NULL) {
+	if (filp->f_op && filp->f_op->lock != NULL)
 		error = filp->f_op->lock(filp, cmd, file_lock);
-		goto out;
-	}
-
-	for (;;) {
-		error = __posix_lock_file(inode, file_lock);
-		if ((error != -EAGAIN) || (cmd == F_SETLK))
+	else {
+		for (;;) {
+			error = __posix_lock_file(inode, file_lock);
+			if ((error != -EAGAIN) || (cmd == F_SETLK))
+				break;
+			error = wait_event_interruptible(file_lock->fl_wait,
+					!file_lock->fl_next);
+			if (!error)
+				continue;
+	
+			locks_delete_block(file_lock);
 			break;
-		error = wait_event_interruptible(file_lock->fl_wait,
-				!file_lock->fl_next);
-		if (!error)
-			continue;
+		}
+	}
 
-		locks_delete_block(file_lock);
-		break;
+	/*
+	 * Attempt to detect a close/fcntl race and recover by
+	 * releasing the lock that was just acquired.
+	 */
+	if (!error &&
+	    cmd != F_UNLCK && fcheck(fd) != filp && flock.l_type != F_UNLCK) {
+		flock.l_type = F_UNLCK;
+		goto again;
 	}
 
- out:
+out:
 	locks_free_lock(file_lock);
 	return error;
 }
@@ -1722,7 +1733,8 @@ out:
 /* Apply the lock described by l to an open file descriptor.
  * This implements both the F_SETLK and F_SETLKW commands of fcntl().
  */
-int fcntl_setlk64(struct file *filp, unsigned int cmd, struct flock64 __user *l)
+int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
+		struct flock64 __user *l)
 {
 	struct file_lock *file_lock = locks_alloc_lock();
 	struct flock64 flock;
@@ -1751,6 +1763,7 @@ int fcntl_setlk64(struct file *filp, uns
 		goto out;
 	}
 
+again:
 	error = flock64_to_posix_lock(filp, file_lock, &flock);
 	if (error)
 		goto out;
@@ -1779,22 +1792,31 @@ int fcntl_setlk64(struct file *filp, uns
 	if (error)
 		goto out;
 
-	if (filp->f_op && filp->f_op->lock != NULL) {
+	if (filp->f_op && filp->f_op->lock != NULL)
 		error = filp->f_op->lock(filp, cmd, file_lock);
-		goto out;
-	}
-
-	for (;;) {
-		error = __posix_lock_file(inode, file_lock);
-		if ((error != -EAGAIN) || (cmd == F_SETLK64))
+	else {
+		for (;;) {
+			error = __posix_lock_file(inode, file_lock);
+			if ((error != -EAGAIN) || (cmd == F_SETLK64))
+				break;
+			error = wait_event_interruptible(file_lock->fl_wait,
+					!file_lock->fl_next);
+			if (!error)
+				continue;
+	
+			locks_delete_block(file_lock);
 			break;
-		error = wait_event_interruptible(file_lock->fl_wait,
-				!file_lock->fl_next);
-		if (!error)
-			continue;
+		}
+	}
 
-		locks_delete_block(file_lock);
-		break;
+	/*
+	 * Attempt to detect a close/fcntl race and recover by
+	 * releasing the lock that was just acquired.
+	 */
+	if (!error &&
+	    cmd != F_UNLCK && fcheck(fd) != filp && flock.l_type != F_UNLCK) {
+		flock.l_type = F_UNLCK;
+		goto again;
 	}
 
 out:
@@ -1886,12 +1908,7 @@ void locks_remove_flock(struct file *fil
 
 	while ((fl = *before) != NULL) {
 		if (fl->fl_file == filp) {
-			/*
-			 * We might have a POSIX lock that was created at the same time
-			 * the filp was closed for the last time. Just remove that too,
-			 * regardless of ownership, since nobody can own it.
-			 */
-			if (IS_FLOCK(fl) || IS_POSIX(fl)) {
+			if (IS_FLOCK(fl)) {
 				locks_delete_lock(before);
 				continue;
 			}
--- ./fs/fcntl.c.org	2005-06-27 08:54:57.000000000 -0400
+++ ./fs/fcntl.c	2005-06-27 13:24:38.471153760 -0400
@@ -290,7 +290,7 @@ static long do_fcntl(int fd, unsigned in
 		break;
 	case F_SETLK:
 	case F_SETLKW:
-		err = fcntl_setlk(filp, cmd, (struct flock __user *) arg);
+		err = fcntl_setlk(fd, filp, cmd, (struct flock __user *) arg);
 		break;
 	case F_GETOWN:
 		/*
@@ -378,7 +378,8 @@ asmlinkage long sys_fcntl64(unsigned int
 			break;
 		case F_SETLK64:
 		case F_SETLKW64:
-			err = fcntl_setlk64(filp, cmd, (struct flock64 __user *) arg);
+			err = fcntl_setlk64(fd, filp, cmd,
+					(struct flock64 __user *) arg);
 			break;
 		default:
 			err = do_fcntl(fd, cmd, arg, filp);
--- ./include/linux/fs.h.org	2005-06-27 08:54:57.000000000 -0400
+++ ./include/linux/fs.h	2005-06-27 13:24:38.444157864 -0400
@@ -691,11 +691,13 @@ extern struct list_head file_lock_list;
 #include <linux/fcntl.h>
 
 extern int fcntl_getlk(struct file *, struct flock __user *);
-extern int fcntl_setlk(struct file *, unsigned int, struct flock __user *);
+extern int fcntl_setlk(unsigned int, struct file *, unsigned int,
+			struct flock __user *);
 
 #if BITS_PER_LONG == 32
 extern int fcntl_getlk64(struct file *, struct flock64 __user *);
-extern int fcntl_setlk64(struct file *, unsigned int, struct flock64 __user *);
+extern int fcntl_setlk64(unsigned int, struct file *, unsigned int,
+			struct flock64 __user *);
 #endif
 
 extern void send_sigio(struct fown_struct *fown, int fd, int band);

--------------040306070609000900010305--
