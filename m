Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUJBAxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUJBAxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUJBAxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:53:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:30605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266912AbUJBAwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:52:31 -0400
Date: Fri, 1 Oct 2004 17:52:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Chris Wright <chrisw@osdl.org>, Ivan Kalatchev <ivan.kalatchev@esg.ca>,
       linux-kernel@vger.kernel.org
Subject: [TEST PATCH] Re: kernel 2.6.8 bug in fs/locks.c
Message-ID: <20041001175230.F1973@build.pdx.osdl.net>
References: <000001c4a7d3$21c62bb0$2e646434@ivans> <20041001122332.E1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041001122332.E1973@build.pdx.osdl.net>; from chrisw@osdl.org on Fri, Oct 01, 2004 at 12:23:33PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> * Ivan Kalatchev (ivan.kalatchev@esg.ca) wrote:
> > I'm using pthreads for each user-application connections. To protect
> > configuration file from corruption I used file locking mechanism - fcntl
> > with F_WRLCK/F_RDLCK.
> 
> I must be confused.  pthreads and fcntl locking...that does't give
> proper exclusion?  The BUG, however, is no good.  Despite the fact
> that it appears to come at the result of an application bug, we should
> be able to handle this w/out a BUG.  AFAICT, one thread has closed the
> file descriptor, whilst another is mucking with the locks.  So the locker
> winds up holding the last ref to the filp.  This blows the logic of when
> locks_remove_posix gets called.  Thanks for the bug report.

This is a rather ugly fix, but it demonstrates the hole.  It's possible
for a posix lock to get applied after the final close of the file.  This
means locks_remove_posix misses the yet to be created posix lock, and
on final fput when leaving fcntl, locks_remove_flock will BUG().
I was able to reproduce Ivan's bugreport.  I doubt it's the right/best
fix, but it's functional (no more BUG()).  Against -bk-curr.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/fcntl.c 1.40 vs edited =====
--- 1.40/fs/fcntl.c	2004-09-02 02:48:03 -07:00
+++ edited/fs/fcntl.c	2004-10-01 17:34:15 -07:00
@@ -364,7 +364,7 @@
 
 asmlinkage long sys_fcntl(int fd, unsigned int cmd, unsigned long arg)
 {	
-	struct file *filp;
+	struct file *filp, *filp2;
 	long err = -EBADF;
 
 	filp = fget(fd);
@@ -379,6 +379,11 @@
 
 	err = do_fcntl(fd, cmd, arg, filp);
 
+	filp2 = fget(fd);
+	if (filp2 != filp)
+		locks_remove_posix(filp, current->files);
+	if (filp2)
+		fput(filp2);
  	fput(filp);
 out:
 	return err;
@@ -387,7 +392,7 @@
 #if BITS_PER_LONG == 32
 asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
 {	
-	struct file * filp;
+	struct file *filp, *filp2;
 	long err;
 
 	err = -EBADF;
@@ -414,6 +419,12 @@
 			err = do_fcntl(fd, cmd, arg, filp);
 			break;
 	}
+
+	filp2 = fget(fd);
+	if (filp2 != filp)
+		locks_remove_posix(filp, current->files);
+	if (filp2)
+		fput(filp2);
 	fput(filp);
 out:
 	return err;
