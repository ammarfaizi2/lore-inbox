Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTKESIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 13:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTKESIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 13:08:17 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:18341 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262986AbTKESIN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 13:08:13 -0500
Date: Wed, 5 Nov 2003 19:08:10 +0100
To: linux-kernel@vger.kernel.org
Cc: linux-archs@vger.kernel.org
Subject: [PATCH] compat syscalls for sys_io_...
Message-ID: <20031105180810.GA2691@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Thomas Spatzier <tspat@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've implemented compat wrapper functions for the sys_io... set of
system calls for 32 bit emulation on s390. I think, these
wrapper functions will also be needed by architectures other than s390
(I found implementations for ppc64 and x86_64; compat_io_setup is
heavily based on the ppc64 implementation);
therefore I think they should be put into fs/compat.c.
Please verify/comment on the patch below. AFAICS they should do across
archs.

Regards,
Thomas.


diff -urN linux-2.6.0-test9/fs/compat.c linux-2.6.0-test9-compat-aio/fs/compat.c
--- linux-2.6.0-test9/fs/compat.c	2003-09-29 13:30:29.000000000 +0200
+++ linux-2.6.0-test9-compat-aio/fs/compat.c	2003-11-05 18:57:43.000000000 +0100
@@ -554,3 +554,88 @@
 	return compat_sys_fcntl64(fd, cmd, arg);
 }
 
+/* posix aio functions: sys_io_... */
+extern asmlinkage long
+sys_io_setup(unsigned, aio_context_t *ctx);
+
+asmlinkage long
+sys32_io_setup(unsigned nr_events, compat_aio_context_t *ctx)
+{
+	aio_context_t kctx;
+	mm_segment_t old_fs;
+	long ret;
+
+	// ctx points to 4 byte area (u32) in userspace !
+	ret = get_user(kctx, ctx);
+	if (ret)
+		goto out;
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_io_setup(nr_events, &kctx);
+	set_fs(old_fs);
+	if (!ret)
+		ret = put_user(kctx, ctx);
+out:
+	return ret;
+}
+
+extern asmlinkage long
+sys_io_getevents(aio_context_t,long,long,struct io_event *,struct timespec *);
+
+asmlinkage long
+sys32_io_getevents(compat_aio_context_t ctx_id, long min_nr, long nr,
+		struct io_event *events,
+		struct compat_timespec *timeout)
+{
+	struct timespec ktimeout;
+	struct timespec *usr_timeout;
+	long ret;
+
+	ret = -EFAULT;
+	if ( get_compat_timespec(&ktimeout, timeout) )
+		goto out;
+	usr_timeout = compat_alloc_user_space(sizeof(*usr_timeout));
+	if ( copy_to_user(usr_timeout, &ktimeout, sizeof(ktimeout)) )
+		goto out;
+	ret = sys_io_getevents(ctx_id, min_nr, nr, events, usr_timeout);
+out:
+	return ret;
+}
+
+extern asmlinkage long
+sys_io_submit(aio_context_t, long, struct iocb __user **);
+
+static inline long
+get_64bit_user_ptr_array(long nr, u32 *ptr32, u64 *ptr64)
+{
+	u32 uptr;
+	long ret;
+
+	ret = -EFAULT;
+	int i;
+	for (i = 0; i < nr; ++i) {
+		if ( get_user(uptr, ptr32 + i) )
+			goto out;
+		if ( put_user((u64)compat_ptr(uptr), ptr64 + i) )
+			goto out;
+	}
+	ret = 0;
+out:
+	return ret;
+}
+
+asmlinkage long
+sys32_io_submit(compat_aio_context_t ctx_id, long nr, u32 *iocb)
+{
+	struct iocb **iocb64; //array of 64bit pointers in user space
+	long ret;
+
+	//alloc 64 bit pointer array in user space
+	iocb64 = compat_alloc_user_space(nr*sizeof(*iocb64));
+	ret = get_64bit_user_ptr_array(nr, (u32 *)iocb, (u64 *)iocb64);
+	if (ret)
+		goto out;
+	ret = sys_io_submit(ctx_id, nr, iocb64);
+out:
+	return ret;
+}
diff -urN linux-2.6.0-test9/include/linux/compat.h linux-2.6.0-test9-compat-aio/include/linux/compat.h
--- linux-2.6.0-test9/include/linux/compat.h	2003-10-09 19:19:51.000000000 +0200
+++ linux-2.6.0-test9-compat-aio/include/linux/compat.h	2003-11-04 15:46:54.000000000 +0100
@@ -97,5 +97,7 @@
 	char		d_name[256];
 };
 
+typedef unsigned int compat_aio_context_t;
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
