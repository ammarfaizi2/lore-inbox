Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269188AbTCDFwm>; Tue, 4 Mar 2003 00:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269221AbTCDFwm>; Tue, 4 Mar 2003 00:52:42 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:1421 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S269188AbTCDFwi>;
	Tue, 4 Mar 2003 00:52:38 -0500
Date: Tue, 4 Mar 2003 17:02:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 3/9 SPARC64 part
Message-Id: <20030304170258.6d91fc05.sfr@canb.auug.org.au>
In-Reply-To: <20030304165812.7141f7c0.sfr@canb.auug.org.au>
References: <20030304165812.7141f7c0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here is the SPARC64 part of the patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.63-32bit.1/arch/sparc64/kernel/sys_sparc32.c 2.5.63-32bit.2/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.63-32bit.1/arch/sparc64/kernel/sys_sparc32.c	2003-02-25 12:59:31.000000000 +1100
+++ 2.5.63-32bit.2/arch/sparc64/kernel/sys_sparc32.c	2003-02-25 14:35:59.000000000 +1100
@@ -806,41 +806,6 @@
 	return err;
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
-			mm_segment_t old_fs;
-			long ret;
-			
-			if (get_compat_flock(&f, (struct compat_flock *)arg))
-				return -EFAULT;
-			old_fs = get_fs(); set_fs (KERNEL_DS);
-			ret = sys_fcntl(fd, cmd, (unsigned long)&f);
-			set_fs (old_fs);
-			if (ret) return ret;
-			if (put_compat_flock(&f, (struct compat_flock *)arg))
-				return -EFAULT;
-			return 0;
-		}
-	default:
-		return sys_fcntl(fd, cmd, (unsigned long)arg);
-	}
-}
-
-asmlinkage long sys32_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	if (cmd >= F_GETLK64 && cmd <= F_SETLKW64)
-		return sys_fcntl(fd, cmd + F_GETLK - F_GETLK64, arg);
-	return sys32_fcntl(fd, cmd, arg);
-}
-
 extern asmlinkage long sys_truncate(const char * path, unsigned long length);
 extern asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 
diff -ruN 2.5.63-32bit.1/arch/sparc64/kernel/systbls.S 2.5.63-32bit.2/arch/sparc64/kernel/systbls.S
--- 2.5.63-32bit.1/arch/sparc64/kernel/systbls.S	2003-02-25 12:59:31.000000000 +1100
+++ 2.5.63-32bit.2/arch/sparc64/kernel/systbls.S	2003-02-25 14:35:59.000000000 +1100
@@ -37,7 +37,7 @@
 	.word sys_madvise, sys_vhangup, sys32_truncate64, sys_mincore, sys32_getgroups16
 /*80*/	.word sys32_setgroups16, sys_getpgrp, sys_setgroups, compat_sys_setitimer, sys32_ftruncate64
 	.word sys_swapon, compat_sys_getitimer, sys_setuid, sys_sethostname, sys_setgid
-/*90*/	.word sys_dup2, sys_setfsuid, sys32_fcntl, sys32_select, sys_setfsgid
+/*90*/	.word sys_dup2, sys_setfsuid, compat_sys_fcntl, sys32_select, sys_setfsgid
 	.word sys_fsync, sys_setpriority32, sys_nis_syscall, sys_nis_syscall, sys_nis_syscall
 /*100*/ .word sys_getpriority, sys32_rt_sigreturn, sys32_rt_sigaction, sys32_rt_sigprocmask, sys32_rt_sigpending
 	.word sys32_rt_sigtimedwait, sys32_rt_sigqueueinfo, sys32_rt_sigsuspend, sys_setresuid, sys_getresuid
@@ -50,7 +50,7 @@
 /*140*/	.word sys32_sendfile64, sys_nis_syscall, compat_sys_futex, sys_gettid, sys32_getrlimit
 	.word sys32_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
-	.word sys32_fcntl64, sys_ni_syscall, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
+	.word compat_sys_fcntl64, sys_ni_syscall, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
 /*160*/	.word sys32_sched_setaffinity, sys32_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
 	.word sys_quotactl, sys_set_tid_address, sys32_mount, sys_ustat, sys_setxattr
 /*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys32_getdents
@@ -172,7 +172,7 @@
 	.word compat_sys_setitimer, sunos_nosys, sys_swapon
 	.word compat_sys_getitimer, sys_gethostname, sys_sethostname
 	.word sunos_getdtablesize, sys_dup2, sunos_nop
-	.word sys32_fcntl, sunos_select, sunos_nop
+	.word compat_sys_fcntl, sunos_select, sunos_nop
 	.word sys_fsync, sys_setpriority32, sunos_socket
 	.word sys_connect, sunos_accept
 /*100*/	.word sys_getpriority, sunos_send, sunos_recv
diff -ruN 2.5.63-32bit.1/include/asm-sparc64/compat.h 2.5.63-32bit.2/include/asm-sparc64/compat.h
--- 2.5.63-32bit.1/include/asm-sparc64/compat.h	2003-02-11 09:40:00.000000000 +1100
+++ 2.5.63-32bit.2/include/asm-sparc64/compat.h	2003-02-25 14:35:59.000000000 +1100
@@ -64,6 +64,19 @@
 	short		__unused;
 };
 
+#define F_GETLK64	12
+#define F_SETLK64	13
+#define F_SETLKW64	14
+
+struct compat_flock64 {
+	short		l_type;
+	short		l_whence;
+	compat_loff_t	l_start;
+	compat_loff_t	l_len;
+	compat_pid_t	l_pid;
+	short		__unused;
+};
+
 struct compat_statfs {
 	int		f_type;
 	int		f_bsize;
@@ -84,4 +97,7 @@
 
 typedef u32		compat_sigset_word;
 
+#define COMPAT_OFF_T_MAX	0x7fffffff
+#define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
+
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN 2.5.63-32bit.1/include/asm-sparc64/fcntl.h 2.5.63-32bit.2/include/asm-sparc64/fcntl.h
--- 2.5.63-32bit.1/include/asm-sparc64/fcntl.h	2003-01-09 16:24:05.000000000 +1100
+++ 2.5.63-32bit.2/include/asm-sparc64/fcntl.h	2003-02-25 14:35:59.000000000 +1100
@@ -36,12 +36,6 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
-#ifdef __KERNEL__
-#define F_GETLK64	12
-#define F_SETLK64	13
-#define F_SETLKW64	14
-#endif
-
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
 
@@ -78,9 +72,6 @@
 	short __unused;
 };
 
-#ifdef __KERNEL__
-#define flock64	flock
-#endif
-
 #define F_LINUX_SPECIFIC_BASE	1024
+
 #endif /* !(_SPARC64_FCNTL_H) */
