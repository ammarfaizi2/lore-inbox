Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUBZVtO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUBZVtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:49:14 -0500
Received: from sunsite.ms.mff.cuni.cz ([195.113.19.66]:7296 "EHLO
	sunsite.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261160AbUBZVsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:48:52 -0500
Date: Thu, 26 Feb 2004 20:38:19 +0100
From: Jakub Jelinek <jakub@redhat.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: [PATCH] Add getdents32t syscall
Message-ID: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

glibc struct dirent has d_type field (similarly to struct dirent64).
Because no 32-bit getdents syscall provides this field to userland,
glibc needs to use getdents64 syscall even for 32-bit getdents
(and readdir etc.) and convert dirent entries from struct dirent64
to struct dirent.  The code is quite complicated and as the former
is bigger and the size of 64-bit dirents cannot be predicted accurately,
it can happen that glibc reads too many entries and has to seek back
on the dir etc.

The following patch introduces a new syscall (on 32-bit architectures),
which fills in 32-bit struct dirent with d_type member.
With this syscall glibc can simply call this syscall in 32-bit getdents
and be done with it, no seeking, issues with NFS zero extended d_ino values,
buffer translation etc.  sys_getdents32t (the t in there is for type,
to differentiate it from compatibility sys_getdents32 which don't provide
d_type) function should be usable both on 32-bit arches and in 32-bit
compatibility layers on 64-bit arches (on most arches directly, if
the arguments are zero extended in assembly).

--- linux-2.6.3/fs/readdir.c.jj	2004-02-18 04:57:52.000000000 +0100
+++ linux-2.6.3/fs/readdir.c	2004-02-26 09:49:20.073123212 +0100
@@ -207,6 +207,88 @@ out:
 	return error;
 }
 
+struct getdents_callback32t {
+	struct linux_dirent32t __user * current_dir;
+	struct linux_dirent32t __user * previous;
+	int count;
+	int error;
+};
+
+int filldir32t(void * __buf, const char * name, int namlen, loff_t offset,
+	       ino_t ino, unsigned int d_type)
+{
+	struct linux_dirent32t __user * dirent;
+	struct getdents_callback32t * buf = (struct getdents_callback32t *) __buf;
+	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+
+	buf->error = -EINVAL;	/* only used if we fail.. */
+	if (reclen > buf->count)
+		return -EINVAL;
+	dirent = buf->previous;
+	if (dirent) {
+		if (__put_user(offset, &dirent->d_off))
+			goto efault;
+	}
+	dirent = buf->current_dir;
+	if (__put_user(ino, &dirent->d_ino))
+		goto efault;
+	if (__put_user(reclen, &dirent->d_reclen))
+		goto efault;
+	if (__put_user(d_type, &dirent->d_type))
+		goto efault;
+	if (copy_to_user(dirent->d_name, name, namlen))
+		goto efault;
+	if (__put_user(0, dirent->d_name + namlen))
+		goto efault;
+	buf->previous = dirent;
+	dirent = (void *)dirent + reclen;
+	buf->current_dir = dirent;
+	buf->count -= reclen;
+	return 0;
+efault:
+	buf->error = -EFAULT;
+	return -EFAULT;
+}
+
+asmlinkage long sys_getdents32t(unsigned int fd, struct linux_dirent32t __user * dirent, unsigned int count)
+{
+	struct file * file;
+	struct linux_dirent32t __user * lastdirent;
+	struct getdents_callback32t buf;
+	int error;
+
+	error = -EFAULT;
+	if (!access_ok(VERIFY_WRITE, dirent, count))
+		goto out;
+
+	error = -EBADF;
+	file = fget(fd);
+	if (!file)
+		goto out;
+
+	buf.current_dir = dirent;
+	buf.previous = NULL;
+	buf.count = count;
+	buf.error = 0;
+
+	error = vfs_readdir(file, filldir32t, &buf);
+	if (error < 0)
+		goto out_putf;
+	error = buf.error;
+	lastdirent = buf.previous;
+	if (lastdirent) {
+		if (put_user(file->f_pos, &lastdirent->d_off))
+			error = -EFAULT;
+		else
+			error = count - buf.count;
+	}
+
+out_putf:
+	fput(file);
+out:
+	return error;
+}
+
 #define ROUND_UP64(x) (((x)+sizeof(u64)-1) & ~(sizeof(u64)-1))
 
 struct getdents_callback64 {
--- linux-2.6.3/include/asm-x86_64/ia32_unistd.h.jj	2004-02-18 04:58:34.000000000 +0100
+++ linux-2.6.3/include/asm-x86_64/ia32_unistd.h	2004-02-26 15:29:06.138150177 +0100
@@ -278,6 +278,8 @@
 #define __NR_ia32_tgkill		270
 #define __NR_ia32_utimes		271
 #define __NR_ia32_fadvise64_64		272
+#define __NR_ia32_vserver		273
+#define __NR_ia32_getdents32t		274
 
 #define IA32_NR_syscalls 275	/* must be > than biggest syscall! */	
 
--- linux-2.6.3/include/asm-i386/unistd.h.jj	2004-02-24 16:19:19.000000000 +0100
+++ linux-2.6.3/include/asm-i386/unistd.h	2004-02-26 09:50:50.400877877 +0100
@@ -279,8 +279,9 @@
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
 #define __NR_vserver		273
+#define __NR_getdents32t	274
 
-#define NR_syscalls 274
+#define NR_syscalls 275
 
 #ifndef __KERNEL_SYSCALLS_NO_ERRNO__
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
--- linux-2.6.3/include/linux/dirent.h.jj	2004-02-18 04:59:07.000000000 +0100
+++ linux-2.6.3/include/linux/dirent.h	2004-02-26 09:47:16.694315247 +0100
@@ -18,6 +18,14 @@ struct dirent64 {
 
 #ifdef __KERNEL__
 
+struct linux_dirent32t {
+	u32		d_ino;
+	s32		d_off;
+	unsigned short	d_reclen;
+	unsigned char	d_type;
+	char		d_name[0];
+};
+
 struct linux_dirent64 {
 	u64		d_ino;
 	s64		d_off;
--- linux-2.6.3/arch/i386/kernel/entry.S.jj	2004-02-24 16:19:19.000000000 +0100
+++ linux-2.6.3/arch/i386/kernel/entry.S	2004-02-26 15:26:20.086930379 +0100
@@ -1031,5 +1031,6 @@ ENTRY(sys_call_table)
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_getdents32t
 
 syscall_table_size=(.-sys_call_table)
--- linux-2.6.3/arch/x86_64/ia32/ia32entry.S.jj	2004-02-26 00:08:16.000000000 +0100
+++ linux-2.6.3/arch/x86_64/ia32/ia32entry.S	2004-02-26 15:28:14.555401079 +0100
@@ -486,6 +486,8 @@ ia32_sys_call_table:
 	.quad sys_tgkill
 	.quad compat_sys_utimes
 	.quad sys32_fadvise64_64
+	.quad quiet_ni_syscall
+	.quad sys_getdents32t
 	/* don't forget to change IA32_NR_syscalls */
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8


	Jakub
