Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136578AbREDX7r>; Fri, 4 May 2001 19:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136579AbREDX7i>; Fri, 4 May 2001 19:59:38 -0400
Received: from colorfullife.com ([216.156.138.34]:55054 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136578AbREDX7W>;
	Fri, 4 May 2001 19:59:22 -0400
Message-ID: <3AF3423B.33A3C3AE@colorfullife.com>
Date: Sat, 05 May 2001 01:58:51 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3 one-liner bugfixes
In-Reply-To: <Pine.LNX.4.31.0105041518080.1059-100000@penguin.transmeta.com> <3AF33A76.32C22DA1@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------75CFEED68E173192975C0043"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------75CFEED68E173192975C0043
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Manfred Spraul wrote:
> 
> +       else
> +               fl->fl_type & ~F_INPROGRESS;
               ^^^^^^
> +       unlock_kernel();
> +       return ret;
>  }

The last patch was incorrect. Corrected version attached.

--
	Manfred
--------------75CFEED68E173192975C0043
Content-Type: text/plain; charset=us-ascii;
 name="patch-fcntl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fcntl"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 4
//  SUBLEVEL = 4
//  EXTRAVERSION =
--- 2.4/fs/fcntl.c	Thu Nov 16 07:50:25 2000
+++ build-2.4/fs/fcntl.c	Sat May  5 00:32:17 2001
@@ -338,7 +338,6 @@
 	if (!filp)
 		goto out;
 
-	lock_kernel();
 	switch (cmd) {
 		case F_GETLK64:
 			err = fcntl_getlk64(fd, (struct flock64 *) arg);
@@ -353,7 +352,6 @@
 			err = do_fcntl(fd, cmd, arg, filp);
 			break;
 	}
-	unlock_kernel();
 	fput(filp);
 out:
 	return err;
--- 2.4/fs/locks.c	Sun Apr 22 13:21:33 2001
+++ build-2.4/fs/locks.c	Sat May  5 01:54:59 2001
@@ -1157,11 +1157,16 @@
 int fcntl_getlease(struct file *filp)
 {
 	struct file_lock *fl;
-	
+	int ret;
+
+	lock_kernel();
 	fl = filp->f_dentry->d_inode->i_flock;
 	if ((fl == NULL) || ((fl->fl_flags & FL_LEASE) == 0))
-		return F_UNLCK;
-	return fl->fl_type & ~F_INPROGRESS;
+		ret = F_UNLCK;
+	else
+		ret = fl->fl_type & ~F_INPROGRESS;
+	unlock_kernel();
+	return ret;
 }
 
 /* We already had a lease on this file; just change its type */
@@ -1357,7 +1362,9 @@
 		goto out_putf;
 
 	if (filp->f_op && filp->f_op->lock) {
+		lock_kernel();
 		error = filp->f_op->lock(filp, F_GETLK, &file_lock);
+		unlock_kernel();
 		if (error < 0)
 			goto out_putf;
 		else if (error == LOCK_USE_CLNT)
@@ -1481,7 +1488,9 @@
 	}
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
+		lock_kernel();
 		error = filp->f_op->lock(filp, cmd, file_lock);
+		unlock_kernel();
 		if (error < 0)
 			goto out_putf;
 	}
@@ -1522,7 +1531,9 @@
 		goto out_putf;
 
 	if (filp->f_op && filp->f_op->lock) {
+		lock_kernel();
 		error = filp->f_op->lock(filp, F_GETLK, &file_lock);
+		unlock_kernel();
 		if (error < 0)
 			goto out_putf;
 		else if (error == LOCK_USE_CLNT)
@@ -1619,7 +1630,9 @@
 	}
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
+		lock_kernel();
 		error = filp->f_op->lock(filp, cmd, file_lock);
+		unlock_kernel();
 		if (error < 0)
 			goto out_putf;
 	}

--------------75CFEED68E173192975C0043--


