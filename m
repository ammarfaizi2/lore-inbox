Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262777AbTCKAlv>; Mon, 10 Mar 2003 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262778AbTCKAlv>; Mon, 10 Mar 2003 19:41:51 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:46035 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262777AbTCKAlr>;
	Mon, 10 Mar 2003 19:41:47 -0500
Date: Tue, 11 Mar 2003 11:52:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, ak@muc.de
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 4/9 x86_64 part
Message-Id: <20030311115219.0fbadb01.sfr@canb.auug.org.au>
In-Reply-To: <20030311114113.44abed66.sfr@canb.auug.org.au>
References: <20030311114113.44abed66.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the x86_64 part of the patch with Andi's blessing.  Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.64-2003030918-32bit.1/arch/x86_64/ia32/ia32entry.S 2.5.64-2003030918-32bit.2/arch/x86_64/ia32/ia32entry.S
--- 2.5.64-2003030918-32bit.1/arch/x86_64/ia32/ia32entry.S	2003-02-18 11:46:36.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/x86_64/ia32/ia32entry.S	2003-03-09 20:34:45.000000000 +1100
@@ -255,7 +255,7 @@
 	.quad sys_umount			/* new_umount */
 	.quad ni_syscall			/* old lock syscall holder */
 	.quad sys32_ioctl
-	.quad sys32_fcntl64		/* 55 */
+	.quad compat_sys_fcntl64		/* 55 */
 	.quad ni_syscall			/* old mpx syscall holder */
 	.quad sys_setpgid
 	.quad ni_syscall			/* old ulimit syscall holder */
@@ -421,7 +421,7 @@
 	.quad sys_mincore
 	.quad sys_madvise
 	.quad sys_getdents64	/* 220 getdents64 */ 
-	.quad sys32_fcntl64	
+	.quad compat_sys_fcntl64	
 	.quad sys_ni_syscall	/* tux */
 	.quad sys_ni_syscall    /* security */
 	.quad sys_gettid	
diff -ruN 2.5.64-2003030918-32bit.1/arch/x86_64/ia32/sys_ia32.c 2.5.64-2003030918-32bit.2/arch/x86_64/ia32/sys_ia32.c
--- 2.5.64-2003030918-32bit.1/arch/x86_64/ia32/sys_ia32.c	2003-02-25 12:59:32.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/arch/x86_64/ia32/sys_ia32.c	2003-03-09 20:34:45.000000000 +1100
@@ -1016,102 +1016,6 @@
 	return ret;
 }
 
-extern asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
-asmlinkage long sys32_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg);
-
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
-	case F_GETLK64: 
-	case F_SETLK64: 
-	case F_SETLKW64: 
-		return sys32_fcntl64(fd,cmd,arg); 
-
-	default:
-		return sys_fcntl(fd, cmd, (unsigned long)arg);
-	}
-}
-
-static inline int get_flock64(struct ia32_flock64 *fl32, struct flock *fl64)
-{
-	if (access_ok(fl32, sizeof(struct ia32_flock64), VERIFY_WRITE)) {
-		int ret = __get_user(fl64->l_type, &fl32->l_type); 
-		ret |= __get_user(fl64->l_whence, &fl32->l_whence);
-		ret |= __get_user(fl64->l_start, &fl32->l_start); 
-		ret |= __get_user(fl64->l_len, &fl32->l_len); 
-		ret |= __get_user(fl64->l_pid, &fl32->l_pid); 
-		return ret; 
-		}
-	return -EFAULT; 
-}
-
-static inline int put_flock64(struct ia32_flock64 *fl32, struct flock *fl64)
-{
-	if (access_ok(fl32, sizeof(struct ia32_flock64), VERIFY_WRITE)) {
-		int ret = __put_user(fl64->l_type, &fl32->l_type); 
-		ret |= __put_user(fl64->l_whence, &fl32->l_whence);
-		ret |= __put_user(fl64->l_start, &fl32->l_start); 
-		ret |= __put_user(fl64->l_len, &fl32->l_len); 
-		ret |= __put_user(fl64->l_pid, &fl32->l_pid); 
-		return ret; 
-	}
-	return -EFAULT; 
-}
-
-asmlinkage long sys32_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct flock fl64;  
-	mm_segment_t oldfs = get_fs(); 
-	int ret = 0; 
-	int oldcmd = cmd;
-	unsigned long oldarg = arg;
-
-	switch (cmd) {
-	case F_GETLK64: 
-		cmd = F_GETLK; 
-		goto cnv;
-	case F_SETLK64: 
-		cmd = F_SETLK; 
-		goto cnv; 
-	case F_SETLKW64:
-		cmd = F_SETLKW; 
-	cnv:
-		ret = get_flock64((struct ia32_flock64 *)arg, &fl64); 
-		arg = (unsigned long)&fl64; 
-		set_fs(KERNEL_DS); 
-		break; 
-	case F_GETLK:
-	case F_SETLK:
-	case F_SETLKW:
-		return sys32_fcntl(fd,cmd,arg); 
-	}
-	if (!ret)
-		ret = sys_fcntl(fd, cmd, arg);
-	set_fs(oldfs); 
-	if (oldcmd == F_GETLK64 && !ret)
-		ret = put_flock64((struct ia32_flock64 *)oldarg, &fl64); 
-	return ret; 
-}
-
 int sys32_ni_syscall(int call)
 { 
 	printk(KERN_INFO "IA32 syscall %d from %s not implemented\n", call,
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-x86_64/compat.h 2.5.64-2003030918-32bit.2/include/asm-x86_64/compat.h
--- 2.5.64-2003030918-32bit.1/include/asm-x86_64/compat.h	2003-02-11 09:40:00.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/include/asm-x86_64/compat.h	2003-03-11 11:30:59.000000000 +1100
@@ -68,6 +68,22 @@
 	compat_pid_t	l_pid;
 };
 
+#define F_GETLK64	12	/*  using 'struct flock64' */
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
 
 typedef u32               compat_sigset_word;
 
+#define COMPAT_OFF_T_MAX	0x7fffffff
+#define COMPAT_LOFF_T_MAX	0x7fffffffffffffff
+
 #endif /* _ASM_X86_64_COMPAT_H */
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-x86_64/fcntl.h 2.5.64-2003030918-32bit.2/include/asm-x86_64/fcntl.h
--- 2.5.64-2003030918-32bit.1/include/asm-x86_64/fcntl.h	2002-02-20 14:13:21.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/include/asm-x86_64/fcntl.h	2003-03-09 20:34:45.000000000 +1100
@@ -72,8 +72,4 @@
 
 #define F_LINUX_SPECIFIC_BASE	1024
 
-#ifdef __KERNEL__
-#define flock64	flock
-#endif
-
 #endif /* !_X86_64_FCNTL_H */
diff -ruN 2.5.64-2003030918-32bit.1/include/asm-x86_64/ia32.h 2.5.64-2003030918-32bit.2/include/asm-x86_64/ia32.h
--- 2.5.64-2003030918-32bit.1/include/asm-x86_64/ia32.h	2003-02-15 23:20:00.000000000 +1100
+++ 2.5.64-2003030918-32bit.2/include/asm-x86_64/ia32.h	2003-03-09 20:34:45.000000000 +1100
@@ -11,18 +11,6 @@
  * 32 bit structures for IA32 support.
  */
 
-struct ia32_flock64 {
-	short  l_type;
-	short  l_whence;
-	loff_t l_start;  /* unnatural alignment */
-	loff_t l_len;
-	pid_t  l_pid;
-} __attribute__((packed));
-
-#define F_GETLK64	12	/*  using 'struct flock64' */
-#define F_SETLK64	13
-#define F_SETLKW64	14
-
 #include <asm/sigcontext32.h>
 
 /* signal.h */
