Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319275AbSHVBlM>; Wed, 21 Aug 2002 21:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319277AbSHVBlM>; Wed, 21 Aug 2002 21:41:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28682 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319275AbSHVBlL>;
	Wed, 21 Aug 2002 21:41:11 -0400
Date: Thu, 22 Aug 2002 02:45:18 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move BKL down a little in setfl
Message-ID: <20020822024518.T29958@parcelfarce.linux.theplanet.co.uk>
References: <20020821234241.R29958@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0208211549100.1280-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208211549100.1280-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 21, 2002 at 03:50:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 03:50:27PM -0700, Linus Torvalds wrote:
> This exits with the BKL held, as far as I can tell:

duh, you're right.  here's a fixed patch:

diff -urpNX dontdiff linux-2.5.31/fs/fcntl.c linux-2.5.31-willy/fs/fcntl.c
--- linux-2.5.31/fs/fcntl.c	2002-08-01 14:16:07.000000000 -0700
+++ linux-2.5.31-willy/fs/fcntl.c	2002-08-21 18:32:37.000000000 -0700
@@ -227,23 +227,16 @@ asmlinkage long sys_dup(unsigned int fil
 static int setfl(int fd, struct file * filp, unsigned long arg)
 {
 	struct inode * inode = filp->f_dentry->d_inode;
-	int error;
+	int error = 0;
 
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
@@ -251,13 +244,19 @@ static int setfl(int fd, struct file * f
 				return -EINVAL;
 	}
 
-	/* required for strict SunOS emulation */
-	if (O_NONBLOCK != O_NDELAY)
-	       if (arg & O_NDELAY)
-		   arg |= O_NONBLOCK;
+	lock_kernel();
+	if ((arg ^ filp->f_flags) & FASYNC) {
+		if (filp->f_op && filp->f_op->fasync) {
+			error = filp->f_op->fasync(fd, filp, (arg & FASYNC) != 0);
+			if (error < 0)
+				goto out;
+		}
+	}
 
 	filp->f_flags = (arg & SETFL_MASK) | (filp->f_flags & ~SETFL_MASK);
-	return 0;
+ out:
+	unlock_kernel();
+	return error;
 }
 
 static long do_fcntl(unsigned int fd, unsigned int cmd,
@@ -283,9 +282,7 @@ static long do_fcntl(unsigned int fd, un
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
