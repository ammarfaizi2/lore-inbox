Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVBBOie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVBBOie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 09:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVBBOiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 09:38:01 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:59109 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262440AbVBBOgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 09:36:40 -0500
Date: Wed, 2 Feb 2005 15:36:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: sripathik@in.ibm.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: getdents patch for 32 -> 64 converter
Message-ID: <20050202143626.GA4952@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sripathi,

> This patch solves a problem with working of getdents while using 32 bit 
> binaries on 64 bit Linux/390. glibc expects d_type to be passed if we 
> have a kernel version after 2.6.4, so we have to also handle it in the 
> 32bit syscall converter. Similar patch was given for PPC by Marcus 
> Meissner 
> (http://ozlabs.org/pipermail/linuxppc64-dev/2004-March/001359.html) and 
> was integrated into 2.6.5.

thanks for bringing this to my attention. This is indeed broken,
but I prefer a different solution: remove the s390 specific compat
functions and use the generic ones. 

Andrew, would you please add this to your patch collection?

blue skies,
  Martin.

---

[patch] s390: compat_sys_old_readdir and compat_sys_getdents.

From: Sripathi Kodi <sripathik@in.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 should use the generic compat functions for compat_sys_old_readdir
and compat_sys_getdents. The s390 specific ones are buggy and superflous.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/compat_linux.c   |  130 --------------------------------------
 arch/s390/kernel/compat_wrapper.S |    4 -
 2 files changed, 2 insertions(+), 132 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-patched/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	2005-02-02 13:47:25.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/compat_linux.c	2005-02-02 13:50:32.000000000 +0100
@@ -355,136 +355,6 @@
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-/* readdir & getdents */
-
-#define NAME_OFFSET(de) ((int) ((de)->d_name - (char *) (de)))
-#define ROUND_UP(x) (((x)+sizeof(u32)-1) & ~(sizeof(u32)-1))
-
-struct old_linux_dirent32 {
-	u32		d_ino;
-	u32		d_offset;
-	unsigned short	d_namlen;
-	char		d_name[1];
-};
-
-struct readdir_callback32 {
-	struct old_linux_dirent32 * dirent;
-	int count;
-};
-
-static int fillonedir(void * __buf, const char * name, int namlen,
-		      loff_t offset, ino_t ino, unsigned int d_type)
-{
-	struct readdir_callback32 * buf = (struct readdir_callback32 *) __buf;
-	struct old_linux_dirent32 * dirent;
-
-	if (buf->count)
-		return -EINVAL;
-	buf->count++;
-	dirent = buf->dirent;
-	put_user(ino, &dirent->d_ino);
-	put_user(offset, &dirent->d_offset);
-	put_user(namlen, &dirent->d_namlen);
-	copy_to_user(dirent->d_name, name, namlen);
-	put_user(0, dirent->d_name + namlen);
-	return 0;
-}
-
-asmlinkage long old32_readdir(unsigned int fd, struct old_linux_dirent32 *dirent, unsigned int count)
-{
-	int error = -EBADF;
-	struct file * file;
-	struct readdir_callback32 buf;
-
-	file = fget(fd);
-	if (!file)
-		goto out;
-
-	buf.count = 0;
-	buf.dirent = dirent;
-
-	error = vfs_readdir(file, fillonedir, &buf);
-	if (error < 0)
-		goto out_putf;
-	error = buf.count;
-
-out_putf:
-	fput(file);
-out:
-	return error;
-}
-
-struct linux_dirent32 {
-	u32		d_ino;
-	u32		d_off;
-	unsigned short	d_reclen;
-	char		d_name[1];
-};
-
-struct getdents_callback32 {
-	struct linux_dirent32 * current_dir;
-	struct linux_dirent32 * previous;
-	int count;
-	int error;
-};
-
-static int filldir(void * __buf, const char * name, int namlen, loff_t offset, ino_t ino,
-		   unsigned int d_type)
-{
-	struct linux_dirent32 * dirent;
-	struct getdents_callback32 * buf = (struct getdents_callback32 *) __buf;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
-
-	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
-		return -EINVAL;
-	dirent = buf->previous;
-	if (dirent)
-		put_user(offset, &dirent->d_off);
-	dirent = buf->current_dir;
-	buf->previous = dirent;
-	put_user(ino, &dirent->d_ino);
-	put_user(reclen, &dirent->d_reclen);
-	copy_to_user(dirent->d_name, name, namlen);
-	put_user(0, dirent->d_name + namlen);
-	buf->current_dir = ((void *)dirent) + reclen;
-	buf->count -= reclen;
-	return 0;
-}
-
-asmlinkage long sys32_getdents(unsigned int fd, struct linux_dirent32 *dirent, unsigned int count)
-{
-	struct file * file;
-	struct linux_dirent32 * lastdirent;
-	struct getdents_callback32 buf;
-	int error = -EBADF;
-
-	file = fget(fd);
-	if (!file)
-		goto out;
-
-	buf.current_dir = dirent;
-	buf.previous = NULL;
-	buf.count = count;
-	buf.error = 0;
-
-	error = vfs_readdir(file, filldir, &buf);
-	if (error < 0)
-		goto out_putf;
-	lastdirent = buf.previous;
-	error = buf.error;
-	if(lastdirent) {
-		put_user(file->f_pos, &lastdirent->d_off);
-		error = count - buf.count;
-	}
-out_putf:
-	fput(file);
-out:
-	return error;
-}
-
-/* end of readdir & getdents */
-
 int cp_compat_stat(struct kstat *stat, struct compat_stat *statbuf)
 {
 	int err;
diff -urN linux-2.6/arch/s390/kernel/compat_wrapper.S linux-2.6-patched/arch/s390/kernel/compat_wrapper.S
--- linux-2.6/arch/s390/kernel/compat_wrapper.S	2005-02-02 13:47:25.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/compat_wrapper.S	2005-02-02 13:50:32.000000000 +0100
@@ -391,7 +391,7 @@
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# void *
 	llgfr	%r4,%r4			# unsigned int
-	jg	old32_readdir		# branch to system call
+	jg	compat_sys_old_readdir	# branch to system call
 
 	.globl  old32_mmap_wrapper 
 old32_mmap_wrapper:
@@ -639,7 +639,7 @@
 	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# void *
 	llgfr	%r4,%r4			# unsigned int
-	jg	sys32_getdents		# branch to system call
+	jg	compat_sys_getdents	# branch to system call
 
 	.globl  compat_sys_select_wrapper
