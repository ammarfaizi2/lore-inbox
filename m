Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319232AbSHUWif>; Wed, 21 Aug 2002 18:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319233AbSHUWif>; Wed, 21 Aug 2002 18:38:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61703 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319232AbSHUWie>;
	Wed, 21 Aug 2002 18:38:34 -0400
Date: Wed, 21 Aug 2002 23:42:41 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move BKL down a little in setfl
Message-ID: <20020821234241.R29958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nothing spectacular here, just push the BKL down a little.

diff -urpNX dontdiff linux-2.5.31/fs/fcntl.c linux-2.5.31-willy/fs/fcntl.c
--- linux-2.5.31/fs/fcntl.c	2002-08-01 14:16:07.000000000 -0700
+++ linux-2.5.31-willy/fs/fcntl.c	2002-08-18 14:06:35.000000000 -0700
@@ -227,23 +227,15 @@ asmlinkage long sys_dup(unsigned int fil
 static int setfl(int fd, struct file * filp, unsigned long arg)
 {
 	struct inode * inode = filp->f_dentry->d_inode;
-	int error;
 
-	/*
-	 * In the case of an append-only file, O_APPEND
-	 * cannot be cleared
-	 */
+	/* O_APPEND cannot be cleared if the file is marked as append-only */
 	if (!(arg & O_APPEND) && IS_APPEND(inode))
 		return -EPERM;
 
-	/* Did FASYNC state change? */
-	if ((arg ^ filp->f_flags) & FASYNC) {
-		if (filp->f_op && filp->f_op->fasync) {
-			error = filp->f_op->fasync(fd, filp, (arg & FASYNC) != 0);
-			if (error < 0)
-				return error;
-		}
-	}
+	/* required for strict SunOS emulation */
+	if (O_NONBLOCK != O_NDELAY)
+	       if (arg & O_NDELAY)
+		   arg |= O_NONBLOCK;
 
 	if (arg & O_DIRECT) {
 		if (!inode->i_mapping || !inode->i_mapping->a_ops ||
@@ -251,12 +243,18 @@ static int setfl(int fd, struct file * f
 				return -EINVAL;
 	}
 
-	/* required for strict SunOS emulation */
-	if (O_NONBLOCK != O_NDELAY)
-	       if (arg & O_NDELAY)
-		   arg |= O_NONBLOCK;
+	lock_kernel();
+	if ((arg ^ filp->f_flags) & FASYNC) {
+		if (filp->f_op && filp->f_op->fasync) {
+			int error;
+			error = filp->f_op->fasync(fd, filp, (arg & FASYNC) != 0);
+			if (error < 0)
+				return error;
+		}
+	}
 
 	filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);
+	unlock_kernel();
 	return 0;
 }
 
@@ -283,9 +281,7 @@ static long do_fcntl(unsigned int fd, un
 			err = filp->f_flags;
 			break;
 		case F_SETFL:
-			lock_kernel();
 			err = setfl(fd, filp, arg);
-			unlock_kernel();
 			break;
 		case F_GETLK:
 			err = fcntl_getlk(filp, (struct flock *) arg);

-- 
Revolutions do not require corporate support.
