Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317912AbSGKVWa>; Thu, 11 Jul 2002 17:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317915AbSGKVW3>; Thu, 11 Jul 2002 17:22:29 -0400
Received: from infa.abo.fi ([130.232.208.126]:32011 "EHLO infa.abo.fi")
	by vger.kernel.org with ESMTP id <S317912AbSGKVW0>;
	Thu, 11 Jul 2002 17:22:26 -0400
Date: Fri, 12 Jul 2002 00:24:42 +0300
From: Marcus Alanen <marcus@infa.abo.fi>
Message-Id: <200207112124.AAA32295@infa.abo.fi>
To: andrea@suse.de, Matthew Wilcox <willy@debian.org>
Cc: Andrea Arcangeli <andrea@e-mind.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: O_DIRECT handling introduced a race in F_SETFL
In-Reply-To: <20020710112936.GW8878@dualathlon.random>
References: <20020702193019.C27706@parcelfarce.linux.theplanet.co.uk> <20020705141934.GI7734@dualathlon.random> <20020705141934.GI7734@dualathlon.random> <20020710112936.GW8878@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>this one from -aa fixes fasync too. Please review, thanks.
>
>--- odirect/fs/fcntl.c.~1~	Fri Jul  5 12:20:47 2002
>+++ odirect/fs/fcntl.c	Sat Jul  6 18:53:56 2002
>@@ -213,32 +213,29 @@ static int setfl(int fd, struct file * f
> 	if (!(arg & O_APPEND) && IS_APPEND(inode))
> 		return -EPERM;
> 
>+	/*
>+	 * alloc_kiovec() and ->fasync can sleep, so abuse the i_sem
>+	 * to serialize against parallel setfl on the same filp,
>+	 * to avoid races with ->f_flags and ->f_iobuf.
>+	 */
>+	down(&inode->i_sem);
    ^^^^ 
> 	/* Did FASYNC state change? */
> 	if ((arg ^ filp->f_flags) & FASYNC) {
> 		if (filp->f_op && filp->f_op->fasync) {
>+			lock_kernel();
> 			error = filp->f_op->fasync(fd, filp, (arg & FASYNC) !=
>  0);
>+			unlock_kernel();
...

You introduce locking that hasn't been there previously.


To keep things in sync, ioctl.c needs to take i_sem also. In kernel 2.5,
pipe.c needs to move acquisition of i_sem to the surrounding functions.

Patch below. (Trivial documentation update added)

Could somebody please verify this?


Marcus


===== Documentation/filesystems/Locking 1.32 vs edited =====
--- 1.32/Documentation/filesystems/Locking	Wed Jul  3 03:22:36 2002
+++ edited/Documentation/filesystems/Locking	Thu Jul 11 23:03:52 2002
@@ -343,6 +343,8 @@
 
 ->fsync() has i_sem on inode.
 
+->fasync() has i_sem on inode.
+
 --------------------------- dquot_operations -------------------------------
 prototypes:
 	void (*initialize) (struct inode *, short);
===== fs/ioctl.c 1.4 vs edited =====
--- 1.4/fs/ioctl.c	Sat May 18 20:50:00 2002
+++ edited/fs/ioctl.c	Thu Jul 11 23:49:25 2002
@@ -82,10 +82,13 @@
 				filp->f_flags &= ~flag;
 			break;
 
-		case FIOASYNC:
+		case FIOASYNC: {
+			struct inode * inode;
 			if ((error = get_user(on, (int *)arg)) != 0)
 				break;
 			flag = on ? FASYNC : 0;
+			inode = filp->f_dentry->d_inode;
+			down(&inode->i_sem);
 
 			/* Did FASYNC state change ? */
 			if ((flag ^ filp->f_flags) & FASYNC) {
@@ -94,13 +97,16 @@
 				else error = -ENOTTY;
 			}
 			if (error != 0)
-				break;
+				goto fioasync_out;
 
 			if (on)
 				filp->f_flags |= FASYNC;
 			else
 				filp->f_flags &= ~FASYNC;
+		fioasync_out:
+			up(&inode->i_sem);
 			break;
+		}
 
 		case FIOQSIZE:
 			if (S_ISDIR(filp->f_dentry->d_inode->i_mode) ||
===== fs/pipe.c 1.14 vs edited =====
--- 1.14/fs/pipe.c	Wed Jun 12 03:23:20 2002
+++ edited/fs/pipe.c	Thu Jul 11 23:23:58 2002
@@ -329,9 +329,7 @@
 	struct inode *inode = filp->f_dentry->d_inode;
 	int retval;
 
-	down(PIPE_SEM(*inode));
 	retval = fasync_helper(fd, filp, on, PIPE_FASYNC_READERS(*inode));
-	up(PIPE_SEM(*inode));
 
 	if (retval < 0)
 		return retval;
@@ -346,9 +344,7 @@
 	struct inode *inode = filp->f_dentry->d_inode;
 	int retval;
 
-	down(PIPE_SEM(*inode));
 	retval = fasync_helper(fd, filp, on, PIPE_FASYNC_WRITERS(*inode));
-	up(PIPE_SEM(*inode));
 
 	if (retval < 0)
 		return retval;
@@ -363,15 +359,11 @@
 	struct inode *inode = filp->f_dentry->d_inode;
 	int retval;
 
-	down(PIPE_SEM(*inode));
-
 	retval = fasync_helper(fd, filp, on, PIPE_FASYNC_READERS(*inode));
 
 	if (retval >= 0)
 		retval = fasync_helper(fd, filp, on, PIPE_FASYNC_WRITERS(*inode));
 
-	up(PIPE_SEM(*inode));
-
 	if (retval < 0)
 		return retval;
 
@@ -382,14 +374,18 @@
 static int
 pipe_read_release(struct inode *inode, struct file *filp)
 {
+	down(PIPE_SEM(*inode));
 	pipe_read_fasync(-1, filp, 0);
+	up(PIPE_SEM(*inode));
 	return pipe_release(inode, 1, 0);
 }
 
 static int
 pipe_write_release(struct inode *inode, struct file *filp)
 {
+	down(PIPE_SEM(*inode));
 	pipe_write_fasync(-1, filp, 0);
+	up(PIPE_SEM(*inode));
 	return pipe_release(inode, 0, 1);
 }
 
@@ -398,7 +394,9 @@
 {
 	int decr, decw;
 
+	down(PIPE_SEM(*inode));
 	pipe_rdwr_fasync(-1, filp, 0);
+	up(PIPE_SEM(*inode));
 	decr = (filp->f_mode & FMODE_READ) != 0;
 	decw = (filp->f_mode & FMODE_WRITE) != 0;
 	return pipe_release(inode, decr, decw);


-- 
Marcus Alanen
maalanen@abo.fi
