Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVARBZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVARBZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVARBY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:24:56 -0500
Received: from mail.dif.dk ([193.138.115.101]:48567 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261431AbVARBSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:18:51 -0500
Date: Tue, 18 Jan 2005 02:21:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 02/11] Get rid of verify_area() - rest of i386 + misc part
 2 from kernel/ etc.
Message-ID: <Pine.LNX.4.61.0501180145440.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert a bunch of verify_area()'s to access_ok().
Rest of i386 + misc part 2 from kernel/ etc.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc1-bk4-orig/fs/binfmt_aout.c	2005-01-16 21:27:13.000000000 +0100
+++ linux-2.6.11-rc1-bk4/fs/binfmt_aout.c	2005-01-16 21:40:30.000000000 +0100
@@ -148,14 +148,14 @@ static int aout_core_dump(long signr, st
 /* make sure we actually have a data and stack area to dump */
 	set_fs(USER_DS);
 #ifdef __sparc__
-	if (verify_area(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize))
+	if (!access_ok(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize))
 		dump.u_dsize = 0;
-	if (verify_area(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize))
+	if (!access_ok(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize))
 		dump.u_ssize = 0;
 #else
-	if (verify_area(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
+	if (!access_ok(VERIFY_READ, (void __user *)START_DATA(dump), dump.u_dsize << PAGE_SHIFT))
 		dump.u_dsize = 0;
-	if (verify_area(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
+	if (!access_ok(VERIFY_READ, (void __user *)START_STACK(dump), dump.u_ssize << PAGE_SHIFT))
 		dump.u_ssize = 0;
 #endif
 
--- linux-2.6.11-rc1-bk4-orig/fs/eventpoll.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.11-rc1-bk4/fs/eventpoll.c	2005-01-16 21:44:14.000000000 +0100
@@ -639,8 +639,10 @@ asmlinkage long sys_epoll_wait(int epfd,
 		return -EINVAL;
 
 	/* Verify that the area passed by the user is writeable */
-	if ((error = verify_area(VERIFY_WRITE, events, maxevents * sizeof(struct epoll_event))))
+	if (!access_ok(VERIFY_WRITE, events, maxevents * sizeof(struct epoll_event))) {
+		error = -EFAULT;
 		goto eexit_1;
+	}
 
 	/* Get the "struct file *" for the eventpoll file */
 	error = -EBADF;
--- linux-2.6.11-rc1-bk4-orig/fs/compat.c	2005-01-16 21:27:13.000000000 +0100
+++ linux-2.6.11-rc1-bk4/fs/compat.c	2005-01-16 21:48:22.000000000 +0100
@@ -129,7 +129,7 @@ static int put_compat_statfs(struct comp
 		 && (kbuf->f_ffree & 0xffffffff00000000ULL))
 			return -EOVERFLOW;
 	}
-	if (verify_area(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
+	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
 	    __put_user(kbuf->f_type, &ubuf->f_type) ||
 	    __put_user(kbuf->f_bsize, &ubuf->f_bsize) ||
 	    __put_user(kbuf->f_blocks, &ubuf->f_blocks) ||
@@ -203,7 +203,7 @@ static int put_compat_statfs64(struct co
 		 && (kbuf->f_ffree & 0xffffffff00000000ULL))
 			return -EOVERFLOW;
 	}
-	if (verify_area(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
+	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
 	    __put_user(kbuf->f_type, &ubuf->f_type) ||
 	    __put_user(kbuf->f_bsize, &ubuf->f_bsize) ||
 	    __put_user(kbuf->f_blocks, &ubuf->f_blocks) ||
@@ -1120,7 +1120,7 @@ static ssize_t compat_do_readv_writev(in
 			goto out;
 	}
 	ret = -EFAULT;
-	if (verify_area(VERIFY_READ, uvector, nr_segs*sizeof(*uvector)))
+	if (!access_ok(VERIFY_READ, uvector, nr_segs*sizeof(*uvector)))
 		goto out;
 
 	/*
@@ -1509,7 +1509,7 @@ int compat_get_fd_set(unsigned long nr, 
 	if (ufdset) {
 		unsigned long odd;
 
-		if (verify_area(VERIFY_WRITE, ufdset, nr*sizeof(compat_ulong_t)))
+		if (!access_ok(VERIFY_WRITE, ufdset, nr*sizeof(compat_ulong_t)))
 			return -EFAULT;
 
 		odd = nr & 1UL;
@@ -1598,10 +1598,12 @@ compat_sys_select(int n, compat_ulong_t 
 	if (tvp) {
 		time_t sec, usec;
 
-		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
-		    || (ret = __get_user(sec, &tvp->tv_sec))
-		    || (ret = __get_user(usec, &tvp->tv_usec)))
+		if (!access_ok(VERIFY_READ, tvp, sizeof(*tvp))
+		    || __get_user(sec, &tvp->tv_sec)
+		    || __get_user(usec, &tvp->tv_usec)) {	
+			ret = -EFAULT;
 			goto out_nofds;
+		}
 
 		ret = -EINVAL;
 		if (sec < 0 || usec < 0)
--- linux-2.6.11-rc1-bk4-orig/fs/select.c	2005-01-12 23:26:22.000000000 +0100
+++ linux-2.6.11-rc1-bk4/fs/select.c	2005-01-16 21:50:22.000000000 +0100
@@ -302,10 +302,12 @@ sys_select(int n, fd_set __user *inp, fd
 	if (tvp) {
 		time_t sec, usec;
 
-		if ((ret = verify_area(VERIFY_READ, tvp, sizeof(*tvp)))
-		    || (ret = __get_user(sec, &tvp->tv_sec))
-		    || (ret = __get_user(usec, &tvp->tv_usec)))
+		if (!access_ok(VERIFY_READ, tvp, sizeof(*tvp))
+		    || __get_user(sec, &tvp->tv_sec)
+		    || __get_user(usec, &tvp->tv_usec)) {
+			ret = -EFAULT;
 			goto out_nofds;
+		}
 
 		ret = -EINVAL;
 		if (sec < 0 || usec < 0)
--- linux-2.6.11-rc1-bk4-orig/ipc/compat_mq.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.11-rc1-bk4/ipc/compat_mq.c	2005-01-16 21:55:28.000000000 +0100
@@ -25,7 +25,7 @@ struct compat_mq_attr {
 static inline int get_compat_mq_attr(struct mq_attr *attr,
 			const struct compat_mq_attr __user *uattr)
 {
-	if (verify_area(VERIFY_READ, uattr, sizeof *uattr))
+	if (!access_ok(VERIFY_READ, uattr, sizeof *uattr))
 		return -EFAULT;
 
 	return __get_user(attr->mq_flags, &uattr->mq_flags)
@@ -105,7 +105,7 @@ asmlinkage ssize_t compat_sys_mq_timedre
 static int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event)
 {
-	if (verify_area(VERIFY_READ, u_event, sizeof(*u_event)))
+	if (!access_ok(VERIFY_READ, u_event, sizeof(*u_event)))
 		return -EFAULT;
 
 	return __get_user(event->sigev_value.sival_int,
--- linux-2.6.11-rc1-bk4-orig/net/econet/af_econet.c	2005-01-16 21:27:14.000000000 +0100
+++ linux-2.6.11-rc1-bk4/net/econet/af_econet.c	2005-01-16 22:04:28.000000000 +0100
@@ -437,8 +437,8 @@ static int econet_sendmsg(struct kiocb *
 		void __user *base = msg->msg_iov[i].iov_base;
 		size_t len = msg->msg_iov[i].iov_len;
 		/* Check it now since we switch to KERNEL_DS later. */
-		if ((err = verify_area(VERIFY_READ, base, len)) < 0)
-			return err;
+		if (!access_ok(VERIFY_READ, base, len))
+			return -EFAULT;
 		iov[i+1].iov_base = base;
 		iov[i+1].iov_len = len;
 		size += len;
--- linux-2.6.11-rc1-bk4-orig/arch/i386/math-emu/fpu_system.h	2004-12-24 22:34:30.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/i386/math-emu/fpu_system.h	2005-01-17 00:53:52.000000000 +0100
@@ -66,18 +66,18 @@
 #define instruction_address	(*(struct address *)&I387.soft.fip)
 #define operand_address		(*(struct address *)&I387.soft.foo)
 
-#define FPU_verify_area(x,y,z)	if ( verify_area(x,y,z) ) \
+#define FPU_verify_area(x,y,z)	if ( !access_ok(x,y,z) ) \
 				math_abort(FPU_info,SIGSEGV)
 
 #undef FPU_IGNORE_CODE_SEGV
 #ifdef FPU_IGNORE_CODE_SEGV
-/* verify_area() is very expensive, and causes the emulator to run
+/* access_ok() is very expensive, and causes the emulator to run
    about 20% slower if applied to the code. Anyway, errors due to bad
    code addresses should be much rarer than errors due to bad data
    addresses. */
 #define	FPU_code_verify_area(z)
 #else
-/* A simpler test than verify_area() can probably be done for
+/* A simpler test than access_ok() can probably be done for
    FPU_code_verify_area() because the only possible error is to step
    past the upper boundary of a legal code area. */
 #define	FPU_code_verify_area(z) FPU_verify_area(VERIFY_READ,(void __user *)FPU_EIP,z)



