Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTCKAoD>; Mon, 10 Mar 2003 19:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262781AbTCKAoD>; Mon, 10 Mar 2003 19:44:03 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:55507 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262780AbTCKAn6>;
	Mon, 10 Mar 2003 19:43:58 -0500
Date: Tue, 11 Mar 2003 11:54:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 5/9 ia64 part
Message-Id: <20030311115432.18e50632.sfr@canb.auug.org.au>
In-Reply-To: <20030311114113.44abed66.sfr@canb.auug.org.au>
References: <20030311114113.44abed66.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Here is the ia64 part of the patch.  Pleas apply after Linus has applied
the generic part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.64-2003030918-32bit.1/arch/ia64/ia32/ia32_entry.S 2.5.64-2003030918-32bit.2/arch/ia64/ia32/ia32_entry.S
--- 2.5.64-2003030918-32bit.1/arch/ia64/ia32/ia32_entry.S	2003-03-09 20:08:57.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/ia64/ia32/ia32_entry.S	2003-03-09 20:34:44.000000000 +1100
@@ -253,7 +253,7 @@
 	data8 sys_umount	  /* recycled never used phys( */
 	data8 sys32_ni_syscall	  /* old lock syscall holder */
 	data8 sys32_ioctl
-	data8 sys32_fcntl	  /* 55 */
+	data8 compat_sys_fcntl	  /* 55 */
 	data8 sys32_ni_syscall	  /* old mpx syscall holder */
 	data8 sys_setpgid
 	data8 sys32_ni_syscall	  /* old ulimit syscall holder */
@@ -419,7 +419,7 @@
 	data8 sys_mincore
 	data8 sys_madvise
 	data8 sys_getdents64	  /* 220 */
-	data8 sys32_fcntl64
+	data8 compat_sys_fcntl64
 	data8 sys_ni_syscall		/* reserved for TUX */
 	data8 sys_ni_syscall		/* reserved for Security */
 	data8 sys_gettid
diff -ruN 2.5.64-2003030918-32bit.1/arch/ia64/ia32/sys_ia32.c 2.5.64-2003030918-32bit.2/arch/ia64/ia32/sys_ia32.c
--- 2.5.64-2003030918-32bit.1/arch/ia64/ia32/sys_ia32.c	2003-03-09 20:08:57.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/ia64/ia32/sys_ia32.c	2003-03-09 20:34:44.000000000 +1100
@@ -2966,38 +2966,6 @@
 	return ret;
 }
 
-extern asmlinkage long sys_fcntl (unsigned int fd, unsigned int cmd, unsigned long arg);
-
-asmlinkage long
-sys32_fcntl (unsigned int fd, unsigned int cmd, unsigned int arg)
-{
-	mm_segment_t old_fs;
-	struct flock f;
-	long ret;
-
-	switch (cmd) {
-	      case F_GETLK:
-	      case F_SETLK:
-	      case F_SETLKW:
-		if (get_compat_flock(&f, (struct compat_flock *) A(arg)))
-			return -EFAULT;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		ret = sys_fcntl(fd, cmd, (unsigned long) &f);
-		set_fs(old_fs);
-		if (cmd == F_GETLK && put_compat_flock(&f, (struct compat_flock *) A(arg)))
-			return -EFAULT;
-		return ret;
-
-	      default:
-		/*
-		 *  `sys_fcntl' lies about arg, for the F_SETOWN
-		 *  sub-function arg can have a negative value.
-		 */
-		return sys_fcntl(fd, cmd, arg);
-	}
-}
-
 asmlinkage long sys_ni_syscall(void);
 
 asmlinkage long
@@ -3292,66 +3260,6 @@
 	return ret;
 }
 
-/*
- * Unfortunately, the x86 compiler aligns variables of type "long long" to a 4 byte boundary
- * only, which means that the x86 version of "struct flock64" doesn't match the ia64 version
- * of struct flock.
- */
-
-static inline long
-ia32_put_flock (struct flock *l, unsigned long addr)
-{
-	return (put_user(l->l_type, (short *) addr)
-		| put_user(l->l_whence, (short *) (addr + 2))
-		| put_user(l->l_start, (long *) (addr + 4))
-		| put_user(l->l_len, (long *) (addr + 12))
-		| put_user(l->l_pid, (int *) (addr + 20)));
-}
-
-static inline long
-ia32_get_flock (struct flock *l, unsigned long addr)
-{
-	unsigned int start_lo, start_hi, len_lo, len_hi;
-	int err = (get_user(l->l_type, (short *) addr)
-		   | get_user(l->l_whence, (short *) (addr + 2))
-		   | get_user(start_lo, (int *) (addr + 4))
-		   | get_user(start_hi, (int *) (addr + 8))
-		   | get_user(len_lo, (int *) (addr + 12))
-		   | get_user(len_hi, (int *) (addr + 16))
-		   | get_user(l->l_pid, (int *) (addr + 20)));
-	l->l_start = ((unsigned long) start_hi << 32) | start_lo;
-	l->l_len = ((unsigned long) len_hi << 32) | len_lo;
-	return err;
-}
-
-asmlinkage long
-sys32_fcntl64 (unsigned int fd, unsigned int cmd, unsigned int arg)
-{
-	mm_segment_t old_fs;
-	struct flock f;
-	long ret;
-
-	switch (cmd) {
-	      case F_GETLK64:
-	      case F_SETLK64:
-	      case F_SETLKW64:
-		if (ia32_get_flock(&f, arg))
-			return -EFAULT;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		ret = sys_fcntl(fd, cmd, (unsigned long) &f);
-		set_fs(old_fs);
-		if (cmd == F_GETLK && ia32_put_flock(&f, arg))
-			return -EFAULT;
-		break;
-
-	      default:
-		ret = sys32_fcntl(fd, cmd, arg);
-		break;
-	}
-	return ret;
-}
-
 asmlinkage long
 sys32_truncate64 (unsigned int path, unsigned int len_lo, unsigned int len_hi)
 {
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-ia64/compat.h 2.5.64-2003030918-32bit.2/include/asm-ia64/compat.h
--- 2.5.64-2003030918-32bit.1/include/asm-ia64/compat.h	2003-02-11 09:39:57.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/include/asm-ia64/compat.h	2003-03-09 20:34:45.000000000 +1100
@@ -68,6 +68,22 @@
 	compat_pid_t	l_pid;
 };
 
+#define F_GETLK64	12
+#define F_SETLK64	13
+#define F_SETLKW64	14
+
+/*
+ * IA32 uses 4 byte alignment for 64 bit quantities,
+ * so we need to pack this structure.
+ */
+struct compat_flock64 {
+	short		l_type;
+	short		l_whence;
+	compat_loff_t	l_start;
+	compat_loff_t	l_len;
+	compat_pid_t	l_pid;
+} __attribute__((packed));
+
 struct compat_statfs {
 	int		f_type;
 	int		f_bsize;
@@ -88,4 +104,7 @@
 
 typedef u32		compat_sigset_word;
 
+#define COMPAT_OFF_T_MAX	0x7fffffff
+#define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
+
 #endif /* _ASM_IA64_COMPAT_H */
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-ia64/fcntl.h 2.5.64-2003030918-32bit.2/include/asm-ia64/fcntl.h
--- 2.5.64-2003030918-32bit.1/include/asm-ia64/fcntl.h	2000-10-10 11:54:58.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/include/asm-ia64/fcntl.h	2003-03-09 20:34:45.000000000 +1100
@@ -78,9 +78,6 @@
 	pid_t l_pid;
 };
 
-#ifdef __KERNEL__
-# define flock64	flock
-#endif
-
 #define F_LINUX_SPECIFIC_BASE	1024
+
 #endif /* _ASM_IA64_FCNTL_H */
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-ia64/ia32.h 2.5.64-2003030918-32bit.2/include/asm-ia64/ia32.h
--- 2.5.64-2003030918-32bit.1/include/asm-ia64/ia32.h	2003-02-11 09:39:57.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/include/asm-ia64/ia32.h	2003-03-09 20:34:45.000000000 +1100
@@ -18,10 +18,6 @@
 #define IA32_PAGE_ALIGN(addr)	(((addr) + IA32_PAGE_SIZE - 1) & IA32_PAGE_MASK)
 #define IA32_CLOCKS_PER_SEC	100	/* Cast in stone for IA32 Linux */
 
-#define F_GETLK64	12
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 /* sigcontext.h */
 /*
  * As documented in the iBCS2 standard..
