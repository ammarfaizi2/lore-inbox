Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318204AbSG2VTV>; Mon, 29 Jul 2002 17:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318206AbSG2VTV>; Mon, 29 Jul 2002 17:19:21 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14603 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318203AbSG2VTT>; Mon, 29 Jul 2002 17:19:19 -0400
Date: Mon, 29 Jul 2002 14:22:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Larson <plars@austin.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs_read/vfs_write small bug fix (2.5.29)
In-Reply-To: <1027976813.7699.214.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0207291418280.1470-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Jul 2002, Paul Larson wrote:
> 
> This passes all the LTP pread and pwrite tests.

Christoph claims that the kernel pread/pwrite has never been a
32-bitinterface at all, but has always been really a pread64/pwrite64.

Which would make my patch do the wrong thing on big-endian machines, and 
would also break any apps that actually used it with loff_t.

If so, the bug is actually in user space, and the real fix on a kernel 
level is to _document_ the fact that "sys_pread()" isn't actually the same 
as the regular pread() system call. Done by renaming it to "pread64()" 
internally, like this..

Does this work for you? If not, that implies that glibc may be missing a

	if (pos < 0) {
		errno = EINVAL;
		return -1;
	}

in its implementation of the pread/pwrite shim layer.

(Or maybe glibc doesn't know that the kernel pread/pwrite system calls 
were always 64-bit clean, and it just happened to work).

		Linus

-----
===== arch/i386/kernel/entry.S 1.38 vs edited =====
--- 1.38/arch/i386/kernel/entry.S	Fri Jul 26 00:57:48 2002
+++ edited/arch/i386/kernel/entry.S	Mon Jul 29 14:09:51 2002
@@ -689,8 +689,8 @@
 	.long sys_rt_sigtimedwait
 	.long sys_rt_sigqueueinfo
 	.long sys_rt_sigsuspend
-	.long sys_pread		/* 180 */
-	.long sys_pwrite
+	.long sys_pread64	/* 180 */
+	.long sys_pwrite64
 	.long sys_chown16
 	.long sys_getcwd
 	.long sys_capget
===== fs/read_write.c 1.12 vs edited =====
--- 1.12/fs/read_write.c	Sat Jul 27 08:21:19 2002
+++ edited/fs/read_write.c	Mon Jul 29 14:08:55 2002
@@ -185,8 +185,6 @@
 		return -EBADF;
 	if (!file->f_op || !file->f_op->read)
 		return -EINVAL;
-	if (pos < 0)
-		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
 	if (!ret) {
@@ -210,8 +208,6 @@
 		return -EBADF;
 	if (!file->f_op || !file->f_op->write)
 		return -EINVAL;
-	if (pos < 0)
-		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
 	if (!ret) {
@@ -254,12 +250,15 @@
 	return ret;
 }
 
-asmlinkage ssize_t sys_pread(unsigned int fd, char *buf,
+asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf,
 			     size_t count, loff_t pos)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
 
+	if (pos < 0)
+		return -EINVAL;
+
 	file = fget(fd);
 	if (file) {
 		ret = vfs_read(file, buf, count, &pos);
@@ -269,11 +268,14 @@
 	return ret;
 }
 
-asmlinkage ssize_t sys_pwrite(unsigned int fd, const char *buf,
+asmlinkage ssize_t sys_pwrite64(unsigned int fd, const char *buf,
 			      size_t count, loff_t pos)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
+
+	if (pos < 0)
+		return -EINVAL;
 
 	file = fget(fd);
 	if (file) {

