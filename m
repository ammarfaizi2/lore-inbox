Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267901AbTAMFRJ>; Mon, 13 Jan 2003 00:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267898AbTAMFRI>; Mon, 13 Jan 2003 00:17:08 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:35549 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267897AbTAMFQ6>;
	Mon, 13 Jan 2003 00:16:58 -0500
Date: Mon, 13 Jan 2003 16:25:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: [PATCH][COMPAT] compat_sys_[f]statfs - s390x part
Message-Id: <20030113162535.29072e36.sfr@canb.auug.org.au>
In-Reply-To: <20030113160923.603d4f72.sfr@canb.auug.org.au>
References: <20030113160923.603d4f72.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Hopefully, with Martin's continued blessing, here is the s390x part.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.56-32bit.3/arch/s390x/kernel/entry.S 2.5.56-32bit.4/arch/s390x/kernel/entry.S
--- 2.5.56-32bit.3/arch/s390x/kernel/entry.S	2003-01-02 15:13:45.000000000 +1100
+++ 2.5.56-32bit.4/arch/s390x/kernel/entry.S	2003-01-13 11:07:06.000000000 +1100
@@ -490,8 +490,8 @@
         .long  SYSCALL(sys_getpriority,sys32_getpriority_wrapper)
         .long  SYSCALL(sys_setpriority,sys32_setpriority_wrapper)
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* old profil syscall */
-        .long  SYSCALL(sys_statfs,sys32_statfs_wrapper)
-        .long  SYSCALL(sys_fstatfs,sys32_fstatfs_wrapper)   /* 100 */
+        .long  SYSCALL(sys_statfs,compat_sys_statfs_wrapper)
+        .long  SYSCALL(sys_fstatfs,compat_sys_fstatfs_wrapper)   /* 100 */
         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
         .long  SYSCALL(sys_socketcall,sys32_socketcall_wrapper)
         .long  SYSCALL(sys_syslog,sys32_syslog_wrapper)
diff -ruN 2.5.56-32bit.3/arch/s390x/kernel/linux32.c 2.5.56-32bit.4/arch/s390x/kernel/linux32.c
--- 2.5.56-32bit.3/arch/s390x/kernel/linux32.c	2003-01-09 16:23:54.000000000 +1100
+++ 2.5.56-32bit.4/arch/s390x/kernel/linux32.c	2003-01-13 11:07:06.000000000 +1100
@@ -884,61 +884,6 @@
 	return sys32_fcntl(fd, cmd, arg);
 }
 
-static inline int put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
-{
-	int err;
-	
-	err = put_user (kbuf->f_type, &ubuf->f_type);
-	err |= __put_user (kbuf->f_bsize, &ubuf->f_bsize);
-	err |= __put_user (kbuf->f_blocks, &ubuf->f_blocks);
-	err |= __put_user (kbuf->f_bfree, &ubuf->f_bfree);
-	err |= __put_user (kbuf->f_bavail, &ubuf->f_bavail);
-	err |= __put_user (kbuf->f_files, &ubuf->f_files);
-	err |= __put_user (kbuf->f_ffree, &ubuf->f_ffree);
-	err |= __put_user (kbuf->f_namelen, &ubuf->f_namelen);
-	err |= __put_user (kbuf->f_fsid.val[0], &ubuf->f_fsid.val[0]);
-	err |= __put_user (kbuf->f_fsid.val[1], &ubuf->f_fsid.val[1]);
-	return err;
-}
-
-extern asmlinkage int sys_statfs(const char * path, struct statfs * buf);
-
-asmlinkage int sys32_statfs(const char * path, struct statfs32 *buf)
-{
-	int ret;
-	struct statfs s;
-	mm_segment_t old_fs = get_fs();
-	char *pth;
-	
-	pth = getname (path);
-	ret = PTR_ERR(pth);
-	if (!IS_ERR(pth)) {
-		set_fs (KERNEL_DS);
-		ret = sys_statfs((const char *)pth, &s);
-		set_fs (old_fs);
-		putname (pth);
-		if (put_statfs(buf, &s))
-			return -EFAULT;
-	}
-	return ret;
-}
-
-extern asmlinkage int sys_fstatfs(unsigned int fd, struct statfs * buf);
-
-asmlinkage int sys32_fstatfs(unsigned int fd, struct statfs32 *buf)
-{
-	int ret;
-	struct statfs s;
-	mm_segment_t old_fs = get_fs();
-	
-	set_fs (KERNEL_DS);
-	ret = sys_fstatfs(fd, &s);
-	set_fs (old_fs);
-	if (put_statfs(buf, &s))
-		return -EFAULT;
-	return ret;
-}
-
 extern asmlinkage long sys_truncate(const char * path, unsigned long length);
 extern asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 
diff -ruN 2.5.56-32bit.3/arch/s390x/kernel/linux32.h 2.5.56-32bit.4/arch/s390x/kernel/linux32.h
--- 2.5.56-32bit.3/arch/s390x/kernel/linux32.h	2003-01-09 16:23:54.000000000 +1100
+++ 2.5.56-32bit.4/arch/s390x/kernel/linux32.h	2003-01-13 11:07:06.000000000 +1100
@@ -25,19 +25,6 @@
 #define F_SETLK64       13
 #define F_SETLKW64      14    
 
-struct statfs32 {
-	__s32			f_type;
-	__s32			f_bsize;
-	__s32			f_blocks;
-	__s32			f_bfree;
-	__s32			f_bavail;
-	__s32			f_files;
-	__s32			f_ffree;
-	__kernel_fsid_t		f_fsid;
-	__s32			f_namelen;  
-	__s32			f_spare[6];
-};
-
 typedef __u32 old_sigset_t32;       /* at least 32 bits */ 
 
 struct old_sigaction32 {
diff -ruN 2.5.56-32bit.3/arch/s390x/kernel/wrapper32.S 2.5.56-32bit.4/arch/s390x/kernel/wrapper32.S
--- 2.5.56-32bit.3/arch/s390x/kernel/wrapper32.S	2003-01-02 15:13:45.000000000 +1100
+++ 2.5.56-32bit.4/arch/s390x/kernel/wrapper32.S	2003-01-13 11:07:06.000000000 +1100
@@ -440,17 +440,17 @@
 	lgfr	%r4,%r4			# int
 	jg	sys_setpriority		# branch to system call
 
-	.globl  sys32_statfs_wrapper 
-sys32_statfs_wrapper:
+	.globl  compat_sys_statfs_wrapper 
+compat_sys_statfs_wrapper:
 	llgtr	%r2,%r2			# char *
-	llgtr	%r3,%r3			# struct statfs_emu31 *
-	jg	sys32_statfs		# branch to system call
+	llgtr	%r3,%r3			# struct compat_statfs *
+	jg	compat_sys_statfs	# branch to system call
 
-	.globl  sys32_fstatfs_wrapper 
-sys32_fstatfs_wrapper:
+	.globl  compat_sys_fstatfs_wrapper 
+compat_sys_fstatfs_wrapper:
 	llgfr	%r2,%r2			# unsigned int
-	llgtr	%r3,%r3			# struct statfs_emu31 *
-	jg	sys32_fstatfs		# branch to system call
+	llgtr	%r3,%r3			# struct compat_statfs *
+	jg	compat_sys_fstatfs	# branch to system call
 
 	.globl  sys32_socketcall_wrapper 
 sys32_socketcall_wrapper:
diff -ruN 2.5.56-32bit.3/include/asm-s390x/compat.h 2.5.56-32bit.4/include/asm-s390x/compat.h
--- 2.5.56-32bit.3/include/asm-s390x/compat.h	2003-01-09 16:24:05.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-s390x/compat.h	2003-01-13 11:07:06.000000000 +1100
@@ -67,4 +67,17 @@
 	short		__unused;
 };
 
+struct compat_statfs {
+	s32		f_type;
+	s32		f_bsize;
+	s32		f_blocks;
+	s32		f_bfree;
+	s32		f_bavail;
+	s32		f_files;
+	s32		f_ffree;
+	compat_fsid_t	f_fsid;
+	s32		f_namelen;  
+	s32		f_spare[6];
+};
+
 #endif /* _ASM_S390X_COMPAT_H */
