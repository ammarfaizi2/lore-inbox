Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262766AbTCKAqi>; Mon, 10 Mar 2003 19:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262771AbTCKAqh>; Mon, 10 Mar 2003 19:46:37 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:3796 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262766AbTCKAq3>;
	Mon, 10 Mar 2003 19:46:29 -0500
Date: Tue, 11 Mar 2003 11:57:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 6/9 s390x part
Message-Id: <20030311115702.7c36172c.sfr@canb.auug.org.au>
In-Reply-To: <20030311114113.44abed66.sfr@canb.auug.org.au>
References: <20030311114113.44abed66.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the s390x part of the patch with Martin's blessing. Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.64-2003030918-32bit.1/arch/s390x/kernel/entry.S 2.5.64-2003030918-32bit.2/arch/s390x/kernel/entry.S
--- 2.5.64-2003030918-32bit.1/arch/s390x/kernel/entry.S	2003-02-25 12:59:29.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/s390x/kernel/entry.S	2003-03-09 20:34:44.000000000 +1100
@@ -452,7 +452,7 @@
         .long  SYSCALL(sys_umount,sys32_umount_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old lock syscall */
         .long  SYSCALL(sys_ioctl,sys32_ioctl_wrapper)
-        .long  SYSCALL(sys_fcntl,sys32_fcntl_wrapper)   /* 55 */
+        .long  SYSCALL(sys_fcntl,compat_sys_fcntl_wrapper)   /* 55 */
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* intel mpx syscall */
         .long  SYSCALL(sys_setpgid,sys32_setpgid_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old ulimit syscall */
@@ -618,7 +618,7 @@
         .long  SYSCALL(sys_mincore,sys32_mincore_wrapper)
         .long  SYSCALL(sys_madvise,sys32_madvise_wrapper)
 	.long  SYSCALL(sys_getdents64,sys32_getdents64_wrapper)/* 220 */
-	.long  SYSCALL(sys_ni_syscall,sys32_fcntl64_wrapper)
+	.long  SYSCALL(sys_ni_syscall,compat_sys_fcntl64_wrapper)
 	.long  SYSCALL(sys_readahead,sys32_readahead)
 	.long  SYSCALL(sys_ni_syscall,sys32_sendfile64)
 	.long  SYSCALL(sys_setxattr,sys32_setxattr_wrapper)
diff -ruN 2.5.64-2003030918-32bit.1/arch/s390x/kernel/linux32.c 2.5.64-2003030918-32bit.2/arch/s390x/kernel/linux32.c
--- 2.5.64-2003030918-32bit.1/arch/s390x/kernel/linux32.c	2003-02-25 12:59:30.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/s390x/kernel/linux32.c	2003-03-09 20:34:44.000000000 +1100
@@ -834,57 +834,6 @@
 	return err;
 }
 
-extern asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
-
-asmlinkage long sys32_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	switch (cmd) {
-	case F_GETLK:
-		{
-			struct flock f;
-			mm_segment_t old_fs;
-			long ret;
-			
-			if(get_compat_flock(&f, (struct compat_flock *)A(arg)))
-				return -EFAULT;
-			old_fs = get_fs(); set_fs (KERNEL_DS);
-			ret = sys_fcntl(fd, cmd, (unsigned long)&f);
-			set_fs (old_fs);
-			if (ret) return ret;
-			if (f.l_start >= 0x7fffffffUL ||
-			    f.l_start + f.l_len >= 0x7fffffffUL)
-				return -EOVERFLOW;
-			if(put_compat_flock(&f, (struct compat_flock *)A(arg)))
-				return -EFAULT;
-			return 0;
-		}
-	case F_SETLK:
-	case F_SETLKW:
-		{
-			struct flock f;
-			mm_segment_t old_fs;
-			long ret;
-			
-			if(get_compat_flock(&f, (struct compat_flock *)A(arg)))
-				return -EFAULT;
-			old_fs = get_fs(); set_fs (KERNEL_DS);
-			ret = sys_fcntl(fd, cmd, (unsigned long)&f);
-			set_fs (old_fs);
-			if (ret) return ret;
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
 
diff -ruN 2.5.64-2003030918-32bit.1/arch/s390x/kernel/linux32.h 2.5.64-2003030918-32bit.2/arch/s390x/kernel/linux32.h
--- 2.5.64-2003030918-32bit.1/arch/s390x/kernel/linux32.h	2003-01-17 14:01:01.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/s390x/kernel/linux32.h	2003-03-09 20:34:45.000000000 +1100
@@ -21,10 +21,6 @@
         __s32   msgtyp;
 };
 
-#define F_GETLK64       12
-#define F_SETLK64       13
-#define F_SETLKW64      14    
-
 struct old_sigaction32 {
        __u32			sa_handler;	/* Really a pointer, but need to deal with 32 bits */
        compat_old_sigset_t	sa_mask;	/* A 32 bit mask */
diff -ruN 2.5.64-2003030918-32bit.1/arch/s390x/kernel/wrapper32.S 2.5.64-2003030918-32bit.2/arch/s390x/kernel/wrapper32.S
--- 2.5.64-2003030918-32bit.1/arch/s390x/kernel/wrapper32.S	2003-02-25 12:59:30.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/s390x/kernel/wrapper32.S	2003-03-09 20:34:45.000000000 +1100
@@ -227,12 +227,12 @@
 	llgfr	%r4,%r4			# unsigned int
 	jg	sys32_ioctl		# branch to system call
 
-	.globl  sys32_fcntl_wrapper 
-sys32_fcntl_wrapper:
+	.globl  compat_sys_fcntl_wrapper 
+compat_sys_fcntl_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgfr	%r3,%r3			# unsigned int 
 	llgfr	%r4,%r4			# unsigned long
-	jg	sys32_fcntl		# branch to system call
+	jg	compat_sys_fcntl	# branch to system call
 
 	.globl  sys32_setpgid_wrapper 
 sys32_setpgid_wrapper:
@@ -1050,12 +1050,12 @@
 	llgfr	%r4,%r4			# unsigned int
 	jg	sys_getdents64		# branch to system call
 
-	.globl  sys32_fcntl64_wrapper 
-sys32_fcntl64_wrapper:
+	.globl  compat_sys_fcntl64_wrapper 
+compat_sys_fcntl64_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	llgfr	%r3,%r3			# unsigned int 
 	llgfr	%r4,%r4			# unsigned long
-	jg	sys32_fcntl64		# branch to system call
+	jg	compat_sys_fcntl64	# branch to system call
 
 	.globl	sys32_stat64_wrapper
 sys32_stat64_wrapper:
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-s390x/compat.h 2.5.64-2003030918-32bit.2/include/asm-s390x/compat.h
--- 2.5.64-2003030918-32bit.1/include/asm-s390x/compat.h	2003-02-25 12:59:57.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/include/asm-s390x/compat.h	2003-03-09 20:34:45.000000000 +1100
@@ -64,7 +64,18 @@
 	compat_off_t	l_start;
 	compat_off_t	l_len;
 	compat_pid_t	l_pid;
-	short		__unused;
+};
+
+#define F_GETLK64       12
+#define F_SETLK64       13
+#define F_SETLKW64      14    
+
+struct compat_flock64 {
+	short		l_type;
+	short		l_whence;
+	compat_loff_t	l_start;
+	compat_loff_t	l_len;
+	compat_pid_t	l_pid;
 };
 
 struct compat_statfs {
@@ -87,4 +98,7 @@
 
 typedef u32		compat_sigset_word;
 
+#define COMPAT_OFF_T_MAX	0x7fffffff
+#define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
+
 #endif /* _ASM_S390X_COMPAT_H */
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-s390x/fcntl.h 2.5.64-2003030918-32bit.2/include/asm-s390x/fcntl.h
--- 2.5.64-2003030918-32bit.1/include/asm-s390x/fcntl.h	2001-11-10 09:11:15.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/include/asm-s390x/fcntl.h	2003-03-09 20:34:45.000000000 +1100
@@ -80,6 +80,4 @@
 
 #define F_LINUX_SPECIFIC_BASE  1024
 
-#define flock64   flock
-
 #endif
