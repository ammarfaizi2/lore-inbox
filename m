Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269289AbTCDGFB>; Tue, 4 Mar 2003 01:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269290AbTCDGFB>; Tue, 4 Mar 2003 01:05:01 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:32141 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S269289AbTCDGEz>;
	Tue, 4 Mar 2003 01:04:55 -0500
Date: Tue, 4 Mar 2003 17:15:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 7/9 MIPS64 part
Message-Id: <20030304171512.61956434.sfr@canb.auug.org.au>
In-Reply-To: <20030304165812.7141f7c0.sfr@canb.auug.org.au>
References: <20030304165812.7141f7c0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

Here is the MIPS64 part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.63-32bit.1/arch/mips64/kernel/linux32.c 2.5.63-32bit.2/arch/mips64/kernel/linux32.c
--- 2.5.63-32bit.1/arch/mips64/kernel/linux32.c	2003-02-25 14:35:17.000000000 +1100
+++ 2.5.63-32bit.2/arch/mips64/kernel/linux32.c	2003-02-25 14:35:59.000000000 +1100
@@ -1068,50 +1068,6 @@
 	return sys_setsockopt(fd, level, optname, optval, optlen);
 }
 
-extern asmlinkage long
-sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
-
-asmlinkage long
-sys32_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case F_GETLK:
-	case F_SETLK:
-	case F_SETLKW:
-		{
-			struct flock f;
-			mm_segment_t old_fs;
-			long ret;
-			
-			if (get_compat_flock(&f, (struct compat_flock *)arg))
-				return -EFAULT;
-			old_fs = get_fs(); set_fs (KERNEL_DS);
-			ret = sys_fcntl(fd, cmd, (unsigned long)&f);
-			set_fs (old_fs);
-			if (put_compat_flock(&f, (struct compat_flock *)arg))
-				return -EFAULT;
-			return ret;
-		}
-	default:
-		return sys_fcntl(fd, cmd, (unsigned long)arg);
-	}
-}
-
-asmlinkage long
-sys32_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case F_GETLK64:
-		return sys_fcntl(fd, F_GETLK, arg);
-	case F_SETLK64:
-		return sys_fcntl(fd, F_SETLK, arg);
-	case F_SETLKW64:
-		return sys_fcntl(fd, F_SETLKW, arg);
-	}
-
-	return sys32_fcntl(fd, cmd, arg);
-}
-
 struct msgbuf32 { s32 mtype; char mtext[1]; };
 
 struct ipc_perm32
diff -ruN 2.5.63-32bit.1/arch/mips64/kernel/scall_o32.S 2.5.63-32bit.2/arch/mips64/kernel/scall_o32.S
--- 2.5.63-32bit.1/arch/mips64/kernel/scall_o32.S	2003-02-25 14:35:17.000000000 +1100
+++ 2.5.63-32bit.2/arch/mips64/kernel/scall_o32.S	2003-02-25 14:35:59.000000000 +1100
@@ -288,7 +288,7 @@
 	sys	sys_umount	2
 	sys	sys_ni_syscall	0
 	sys	sys32_ioctl	3
-	sys	sys32_fcntl	3			/* 4055 */
+	sys	compat_sys_fcntl	3		/* 4055 */
 	sys	sys_ni_syscall	2
 	sys	sys_setpgid	2
 	sys	sys_ni_syscall, 0
@@ -453,7 +453,7 @@
 	sys	sys_mincore	3
 	sys	sys_madvise	3
 	sys	sys_getdents64	3
-	sys	sys32_fcntl64	3			/* 4220 */
+	sys	compat_sys_fcntl64	3		/* 4220 */
 	sys	sys32_gettid	0
 	sys	sys32_tkill	2
 	.endm
diff -ruN 2.5.63-32bit.1/include/asm-mips64/compat.h 2.5.63-32bit.2/include/asm-mips64/compat.h
--- 2.5.63-32bit.1/include/asm-mips64/compat.h	2003-02-25 14:35:17.000000000 +1100
+++ 2.5.63-32bit.2/include/asm-mips64/compat.h	2003-02-25 14:35:59.000000000 +1100
@@ -62,8 +62,21 @@
 	short		l_whence;
 	compat_off_t	l_start;
 	compat_off_t	l_len;
+	s32		l_sysid;	/* ABI junk, unused on Linux */
+	compat_pid_t	l_pid;
+	s32		pad[4];		/* ABI junk, unused on Linux */
+};
+
+#define F_GETLK64	33	/*  using 'struct flock64' */
+#define F_SETLK64	34
+#define F_SETLKW64	35
+
+struct compat_flock64 {
+	short		l_type;
+	short		l_whence;
+	compat_loff_t	l_start;
+	compat_loff_t	l_len;
 	compat_pid_t	l_pid;
-	short		__unused;
 };
 
 struct compat_statfs {
@@ -87,4 +100,7 @@
 
 typedef u32		compat_sigset_word;
 
+#define COMPAT_OFF_T_MAX	0x7fffffff
+#define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
+
 #endif /* _ASM_MIPS64_COMPAT_H */
diff -ruN 2.5.63-32bit.1/include/asm-mips64/fcntl.h 2.5.63-32bit.2/include/asm-mips64/fcntl.h
--- 2.5.63-32bit.1/include/asm-mips64/fcntl.h	2001-09-10 03:43:02.000000000 +1000
+++ 2.5.63-32bit.2/include/asm-mips64/fcntl.h	2003-02-25 14:35:59.000000000 +1100
@@ -43,12 +43,6 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
-#ifdef __KERNEL__
-#define F_GETLK64	33	/*  using 'struct flock64' */
-#define F_SETLK64	34
-#define F_SETLKW64	35
-#endif
-
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
 
@@ -86,10 +80,6 @@
 	long  pad[4];			/* ZZZZZZZZZZZZZZZZZZZZZZZZZZ */
 } flock_t;
 
-#ifdef __KERNEL__
-#define flock64		flock
-#endif
-
 #define F_LINUX_SPECIFIC_BASE	1024
 
 #endif /* _ASM_FCNTL_H */
