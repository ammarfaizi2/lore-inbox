Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWHJXfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWHJXfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWHJXfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:35:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932235AbWHJXfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:35:50 -0400
Message-Id: <200608102336.k7ANavV6009581@pasta.boston.redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix wrong error code on interrupted close syscalls
Date: Thu, 10 Aug 2006 19:36:57 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew.  Please consider the patch below for the next open 2.6 release.

The problem is that close() syscalls can call a file system's flush
handler, which in turn might sleep interruptibly and ultimately pass
back an -ERESTARTSYS return value.  This happens for files backed by
an interruptible NFS mount under nfs_file_flush() when a large file
has just been written and nfs_wait_bit_interruptible() detects that
there is a signal pending.

I have a test case where the "strace" command is used to attach to a
process sleeping in such a close().  Since the SIGSTOP is forced onto
the victim process (removing it from the thread's "blocked" mask in
force_sig_info()), the RPC wait is interrupted and the close() is
terminated early.

But the file table entry has already been cleared before the flush
handler was called.  Thus, when the syscall is restarted, the file
descriptor appears closed and an EBADF error is returned (which is
wrong).  What's worse, there is the hypothetical case where another
thread of a multi-threaded application might have reused the file
descriptor, in which case that file would be mistakenly closed.

The bottom line is that close() syscalls are not restartable, and
thus -ERESTARTSYS return values should be mapped to -EINTR.  This
is consistent with the close(2) manual page.  The fix is below.

Cheers.  -ernie



Signed-off-by: Ernie Petrides <petrides@redhat.com>

--- linux-2.6.17/fs/open.c.orig
+++ linux-2.6.17/fs/open.c
@@ -1172,6 +1172,7 @@ asmlinkage long sys_close(unsigned int f
 	struct file * filp;
 	struct files_struct *files = current->files;
 	struct fdtable *fdt;
+	int retval;
 
 	spin_lock(&files->file_lock);
 	fdt = files_fdtable(files);
@@ -1184,7 +1185,10 @@ asmlinkage long sys_close(unsigned int f
 	FD_CLR(fd, fdt->close_on_exec);
 	__put_unused_fd(files, fd);
 	spin_unlock(&files->file_lock);
-	return filp_close(filp, files);
+	retval = filp_close(filp, files);
+
+	/* can't restart close syscall because file table entry was cleared */
+	return (retval == -ERESTARTSYS) ? -EINTR : retval;
 
 out_unlock:
 	spin_unlock(&files->file_lock);
