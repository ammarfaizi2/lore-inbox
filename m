Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269297AbTCDGHV>; Tue, 4 Mar 2003 01:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269298AbTCDGHV>; Tue, 4 Mar 2003 01:07:21 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:43149 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S269297AbTCDGHS>;
	Tue, 4 Mar 2003 01:07:18 -0500
Date: Tue, 4 Mar 2003 17:17:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 8/9 PARISC part
Message-Id: <20030304171739.2fa21181.sfr@canb.auug.org.au>
In-Reply-To: <20030304165812.7141f7c0.sfr@canb.auug.org.au>
References: <20030304165812.7141f7c0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the PARISC part of the patch as Willy asked me to send these
directly to you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.63-32bit.1/arch/parisc/kernel/sys_parisc32.c 2.5.63-32bit.2/arch/parisc/kernel/sys_parisc32.c
--- 2.5.63-32bit.1/arch/parisc/kernel/sys_parisc32.c	2003-02-18 11:46:33.000000000 +1100
+++ 2.5.63-32bit.2/arch/parisc/kernel/sys_parisc32.c	2003-02-25 14:35:59.000000000 +1100
@@ -316,35 +316,6 @@
     return -ENOSYS;
 }
 
-extern asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
-
-asmlinkage long sys32_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case F_GETLK:
-	case F_SETLK:
-	case F_SETLKW:
-		{
-			struct flock f;
-			long ret;
-			
-			if (get_compat_flock(&f, (struct compat_flock *)arg))
-				return -EFAULT;
-			KERNEL_SYSCALL(ret, sys_fcntl, fd, cmd, (unsigned long)&f);
-			if (ret) return ret;
-			if (f.l_start >= 0x7fffffffUL ||
-			    f.l_len >= 0x7fffffffUL ||
-			    f.l_start + f.l_len >= 0x7fffffffUL)
-				return -EOVERFLOW;
-			if (put_compat_flock(&f, (struct compat_flock *)arg))
-				return -EFAULT;
-			return 0;
-		}
-	default:
-		return sys_fcntl(fd, cmd, (unsigned long)arg);
-	}
-}
-
 #ifdef CONFIG_SYSCTL
 
 struct __sysctl_args32 {
@@ -2043,28 +2014,6 @@
 	return err;
 }
 
-/* LFS */
-
-extern asmlinkage long sys_fcntl(unsigned int, unsigned int, unsigned long);
-
-asmlinkage long sys32_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-		case F_GETLK64:
-			cmd = F_GETLK;
-			break;
-		case F_SETLK64:
-			cmd = F_SETLK;
-			break;
-		case F_SETLKW64:
-			cmd = F_SETLKW;
-			break;
-		default:
-			break;
-	}
-	return sys32_fcntl(fd, cmd, arg);
-}
-
 /* EXPORT/UNEXPORT */
 struct nfsctl_export32 {
 	char		ex_client[NFSCLNT_IDMAX+1];
diff -ruN 2.5.63-32bit.1/arch/parisc/kernel/syscall.S 2.5.63-32bit.2/arch/parisc/kernel/syscall.S
--- 2.5.63-32bit.1/arch/parisc/kernel/syscall.S	2003-02-18 11:46:33.000000000 +1100
+++ 2.5.63-32bit.2/arch/parisc/kernel/syscall.S	2003-02-28 15:14:47.000000000 +1100
@@ -409,8 +409,7 @@
 	ENTRY_SAME(getpeername)
 	/* This one's a huge ugly mess */
 	ENTRY_DIFF(ioctl)
-	/* struct flock? */
-	ENTRY_DIFF(fcntl)		/* 55 */
+	ENTRY_COMP(fcntl)		/* 55 */
 	ENTRY_SAME(socketpair)
 	ENTRY_SAME(setpgid)
 	ENTRY_SAME(send)
@@ -589,7 +588,7 @@
 	ENTRY_OURS(truncate64)
 	ENTRY_OURS(ftruncate64)		/* 200 */
 	ENTRY_SAME(getdents64)
-	ENTRY_DIFF(fcntl64)
+	ENTRY_COMP(fcntl64)
 	ENTRY_SAME(ni_syscall)
 	ENTRY_SAME(ni_syscall)
 	ENTRY_SAME(ni_syscall)		/* 205 */
diff -ruN 2.5.63-32bit.1/include/asm-parisc/compat.h 2.5.63-32bit.2/include/asm-parisc/compat.h
--- 2.5.63-32bit.1/include/asm-parisc/compat.h	2003-02-11 09:39:59.000000000 +1100
+++ 2.5.63-32bit.2/include/asm-parisc/compat.h	2003-02-25 14:35:59.000000000 +1100
@@ -72,6 +72,14 @@
 	compat_pid_t		l_pid;
 };
 
+struct compat_flock64 {
+	short			l_type;
+	short			l_whence;
+	compat_loff_t		l_start;
+	compat_loff_t		l_len;
+	compat_pid_t		l_pid;
+};
+
 struct compat_statfs {
 	s32		f_type;
 	s32		f_bsize;
@@ -92,4 +100,7 @@
 
 typedef u32		compat_sigset_word;
 
+#define COMPAT_OFF_T_MAX	0x7fffffff
+#define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
+
 #endif /* _ASM_PARISC_COMPAT_H */
