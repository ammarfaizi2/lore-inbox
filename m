Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262767AbTCKAhD>; Mon, 10 Mar 2003 19:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262768AbTCKAhD>; Mon, 10 Mar 2003 19:37:03 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:20947 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262767AbTCKAhA>;
	Mon, 10 Mar 2003 19:37:00 -0500
Date: Tue, 11 Mar 2003 11:47:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 2/9 ppc64 part
Message-Id: <20030311114729.75a3885f.sfr@canb.auug.org.au>
In-Reply-To: <20030311114113.44abed66.sfr@canb.auug.org.au>
References: <20030311114113.44abed66.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

Here is the ppc64 part.  Please apply after Linus has applied the generic
part.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.64-2003030918-32bit.1/arch/ppc64/kernel/misc.S 2.5.64-2003030918-32bit.2/arch/ppc64/kernel/misc.S
--- 2.5.64-2003030918-32bit.1/arch/ppc64/kernel/misc.S	2003-02-25 12:59:28.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/ppc64/kernel/misc.S	2003-03-09 20:34:44.000000000 +1100
@@ -557,7 +557,7 @@
 	.llong .sys32_umount
 	.llong .sys_ni_syscall		/* old lock syscall */
 	.llong .sys32_ioctl
-	.llong .sys32_fcntl		/* 55 */
+	.llong .compat_sys_fcntl	/* 55 */
 	.llong .sys_ni_syscall		/* old mpx syscall */
 	.llong .sys32_setpgid
 	.llong .sys_ni_syscall		/* old ulimit syscall */
@@ -706,7 +706,7 @@
 	.llong .sys_ni_syscall		/* reserved for MacOnLinux */
 	.llong .sys_getdents64
 	.llong .sys_pivot_root
-	.llong .sys32_fcntl64
+	.llong .compat_sys_fcntl64
 	.llong .sys_madvise		/* 205 */
 	.llong .sys_mincore
 	.llong .sys_gettid
diff -ruN 2.5.64-2003030918-32bit.1/arch/ppc64/kernel/sys_ppc32.c 2.5.64-2003030918-32bit.2/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.64-2003030918-32bit.1/arch/ppc64/kernel/sys_ppc32.c	2003-02-25 12:59:29.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/ppc64/kernel/sys_ppc32.c	2003-03-09 20:34:44.000000000 +1100
@@ -248,32 +248,6 @@
 	return ret;
 }
 
-extern asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
-asmlinkage long sys32_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case F_GETLK:
-	case F_SETLK:
-	case F_SETLKW:
-	{
-		struct flock f;
-		mm_segment_t old_fs;
-		long ret;
-
-		if(get_compat_flock(&f, (struct compat_flock *)arg))
-			return -EFAULT;
-		old_fs = get_fs(); set_fs (KERNEL_DS);
-		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
-		set_fs (old_fs);
-		if(put_compat_flock(&f, (struct compat_flock *)arg))
-			return -EFAULT;
-		return ret;
-	}
-	default:
-		return sys_fcntl(fd, cmd, (unsigned long)arg);
-	}
-}
-
 struct ncp_mount_data32_v3 {
         int version;
         unsigned int ncp_fd;
@@ -3552,13 +3526,6 @@
 	return sys_umount(name, (int)flags);
 }
 
-asmlinkage long sys32_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	if (cmd >= F_GETLK64 && cmd <= F_SETLKW64)
-		return sys_fcntl(fd, cmd + F_GETLK - F_GETLK64, arg);
-	return sys32_fcntl(fd, cmd, arg);
-}
-
 struct __sysctl_args32 {
 	u32 name;
 	int nlen;
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-ppc64/compat.h 2.5.64-2003030918-32bit.2/include/asm-ppc64/compat.h
--- 2.5.64-2003030918-32bit.1/include/asm-ppc64/compat.h	2003-02-11 09:39:59.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/include/asm-ppc64/compat.h	2003-03-09 20:34:45.000000000 +1100
@@ -61,7 +61,18 @@
 	compat_off_t	l_start;
 	compat_off_t	l_len;
 	compat_pid_t	l_pid;
-	short		__unused;
+};
+
+#define F_GETLK64	12	/*  using 'struct flock64' */
+#define F_SETLK64	13
+#define F_SETLKW64	14
+
+struct compat_flock64 {
+	short		l_type;
+	short		l_whence;
+	compat_loff_t	l_start;
+	compat_loff_t	l_len;
+	compat_pid_t	l_pid;
 };
 
 struct compat_statfs {
@@ -84,4 +95,7 @@
 
 typedef u32		compat_sigset_word;
 
+#define COMPAT_OFF_T_MAX	0x7fffffff
+#define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
+
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-ppc64/fcntl.h 2.5.64-2003030918-32bit.2/include/asm-ppc64/fcntl.h
--- 2.5.64-2003030918-32bit.1/include/asm-ppc64/fcntl.h	2002-06-03 12:13:01.000000000 +1000
+++ 2.5.64-2003030918-32bit.2/include/asm-ppc64/fcntl.h	2003-03-09 20:34:45.000000000 +1100
@@ -42,10 +42,6 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
 
@@ -87,13 +83,6 @@
 	pid_t l_pid;
 };
 
-struct flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;
-	loff_t l_len;
-	pid_t  l_pid;
-};
-
 #define F_LINUX_SPECIFIC_BASE	1024
+
 #endif /* _PPC64_FCNTL_H */
