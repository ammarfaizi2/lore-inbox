Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbSJQQwg>; Thu, 17 Oct 2002 12:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSJQQwg>; Thu, 17 Oct 2002 12:52:36 -0400
Received: from smtpout.mac.com ([204.179.120.97]:28402 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261743AbSJQQwe>;
	Thu, 17 Oct 2002 12:52:34 -0400
Message-ID: <3DAEEC73.358660F@mac.com>
Date: Thu, 17 Oct 2002 18:59:31 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
X-Mailer: Mozilla 4.8 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, mingo@elte.hu
Subject: [PATCH] 2.5.43 futex, error in error path
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's an error when the f_setown() call fails.
Not the FD but the return code of f_setown() is free'ed. Oops.
I fixed that by renaming the outer variable "ret" to "fd" - of
course you could rename the inner one to rc or similar.

--- futex.c.orig	2002-10-17 17:29:39.000000000 +0200
+++ futex.c	2002-10-17 18:55:26.000000000 +0200
@@ -352,19 +352,19 @@
 	struct page *page = NULL;
 	struct futex_q *q;
 	struct file *filp;
-	int ret;
+	int fd;
 
-	ret = -EINVAL;
+	fd = -EINVAL;
 	if (signal < 0 || signal > _NSIG)
 		goto out;
 
-	ret = get_unused_fd();
-	if (ret < 0)
+	fd = get_unused_fd();
+	if (fd < 0)
 		goto out;
 	filp = get_empty_filp();
 	if (!filp) {
-		put_unused_fd(ret);
-		ret = -ENFILE;
+		put_unused_fd(fd);
+		fd = -ENFILE;
 		goto out;
 	}
 	filp->f_op = &futex_fops;
@@ -376,7 +376,7 @@
 		
 		ret = f_setown(filp, current->tgid, 1);
 		if (ret) {
-			put_unused_fd(ret);
+			put_unused_fd(fd);
 			put_filp(filp);
 			goto out;
 		}
@@ -385,9 +385,9 @@
 
 	q = kmalloc(sizeof(*q), GFP_KERNEL);
 	if (!q) {
-		put_unused_fd(ret);
+		put_unused_fd(fd);
 		put_filp(filp);
-		ret = -ENOMEM;
+		fd = -ENOMEM;
 		goto out;
 	}
 
@@ -397,7 +397,7 @@
 	if (!page) {
 		unlock_futex_mm();
 
-		put_unused_fd(ret);
+		put_unused_fd(fd);
 		put_filp(filp);
 		kfree(q);
 		return -EFAULT;
@@ -406,17 +406,17 @@
 	init_waitqueue_head(&q->waiters);
 	filp->private_data = q;
 
-	__queue_me(q, page, uaddr, offset, ret, filp);
+	__queue_me(q, page, uaddr, offset, fd, filp);
 
 	unlock_futex_mm();
 
 	/* Now we map fd to filp, so userspace can access it */
-	fd_install(ret, filp);
+	fd_install(fd, filp);
 	page = NULL;
 out:
 	if (page)
 		unpin_page(page);
-	return ret;
+	return fd;
 }
 
 asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
