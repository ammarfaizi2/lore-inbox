Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbTAMFM2>; Mon, 13 Jan 2003 00:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267887AbTAMFM2>; Mon, 13 Jan 2003 00:12:28 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:24285 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267883AbTAMFMZ>;
	Mon, 13 Jan 2003 00:12:25 -0500
Date: Mon, 13 Jan 2003 16:21:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ak@muc.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] compat_sys_[f]statfs - x86_64 part
Message-Id: <20030113162107.510c81f5.sfr@canb.auug.org.au>
In-Reply-To: <20030113160923.603d4f72.sfr@canb.auug.org.au>
References: <20030113160923.603d4f72.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Here is tha x86_64 part.  This is relative to 2.5.56 and the previous
patches that I have sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.56-32bit.3/arch/x86_64/ia32/ia32entry.S 2.5.56-32bit.4/arch/x86_64/ia32/ia32entry.S
--- 2.5.56-32bit.3/arch/x86_64/ia32/ia32entry.S	2003-01-09 16:23:55.000000000 +1100
+++ 2.5.56-32bit.4/arch/x86_64/ia32/ia32entry.S	2003-01-13 11:07:06.000000000 +1100
@@ -299,8 +299,8 @@
 	.quad sys_getpriority
 	.quad sys_setpriority
 	.quad ni_syscall			/* old profil syscall holder */
-	.quad sys32_statfs
-	.quad sys32_fstatfs		/* 100 */
+	.quad compat_sys_statfs
+	.quad compat_sys_fstatfs		/* 100 */
 	.quad sys_ioperm
 	.quad sys32_socketcall
 	.quad sys_syslog
diff -ruN 2.5.56-32bit.3/arch/x86_64/ia32/sys_ia32.c 2.5.56-32bit.4/arch/x86_64/ia32/sys_ia32.c
--- 2.5.56-32bit.3/arch/x86_64/ia32/sys_ia32.c	2003-01-13 11:03:59.000000000 +1100
+++ 2.5.56-32bit.4/arch/x86_64/ia32/sys_ia32.c	2003-01-13 11:07:06.000000000 +1100
@@ -404,58 +404,6 @@
 	return 0;
 }
 
-static int
-put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
-{
-	if (verify_area(VERIFY_WRITE, ubuf, sizeof(struct statfs32)) ||
-	    __put_user (kbuf->f_type, &ubuf->f_type) ||
-	    __put_user (kbuf->f_bsize, &ubuf->f_bsize) ||
-	    __put_user (kbuf->f_blocks, &ubuf->f_blocks) ||
-	    __put_user (kbuf->f_bfree, &ubuf->f_bfree) ||
-	    __put_user (kbuf->f_bavail, &ubuf->f_bavail) ||
-	    __put_user (kbuf->f_files, &ubuf->f_files) ||
-	    __put_user (kbuf->f_ffree, &ubuf->f_ffree) ||
-	    __put_user (kbuf->f_namelen, &ubuf->f_namelen) ||
-	    __put_user (kbuf->f_fsid.val[0], &ubuf->f_fsid.val[0]) ||
-	    __put_user (kbuf->f_fsid.val[1], &ubuf->f_fsid.val[1]))
-		return -EFAULT;
-	return 0;
-}
-
-extern asmlinkage long sys_statfs(const char * path, struct statfs * buf);
-
-asmlinkage long
-sys32_statfs(const char * path, struct statfs32 *buf)
-{
-	int ret;
-	struct statfs s;
-	mm_segment_t old_fs = get_fs();
-	
-	set_fs (KERNEL_DS);
-	ret = sys_statfs((const char *)path, &s);
-	set_fs (old_fs);
-	if (put_statfs(buf, &s))
-		return -EFAULT;
-	return ret;
-}
-
-extern asmlinkage long sys_fstatfs(unsigned int fd, struct statfs * buf);
-
-asmlinkage long
-sys32_fstatfs(unsigned int fd, struct statfs32 *buf)
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
 static inline long
 get_tv32(struct timeval *o, struct compat_timeval *i)
 {
diff -ruN 2.5.56-32bit.3/include/asm-x86_64/compat.h 2.5.56-32bit.4/include/asm-x86_64/compat.h
--- 2.5.56-32bit.3/include/asm-x86_64/compat.h	2003-01-09 16:24:05.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-x86_64/compat.h	2003-01-13 11:07:06.000000000 +1100
@@ -68,4 +68,17 @@
 	compat_pid_t	l_pid;
 };
 
+struct compat_statfs {
+	int		f_type;
+	int		f_bsize;
+	int		f_blocks;
+	int		f_bfree;
+	int		f_bavail;
+	int		f_files;
+	int		f_ffree;
+	compat_fsid_t	f_fsid;
+	int		f_namelen;	/* SunOS ignores this field. */
+	int		f_spare[6];
+};
+
 #endif /* _ASM_X86_64_COMPAT_H */
diff -ruN 2.5.56-32bit.3/include/asm-x86_64/ia32.h 2.5.56-32bit.4/include/asm-x86_64/ia32.h
--- 2.5.56-32bit.3/include/asm-x86_64/ia32.h	2003-01-09 16:24:05.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-x86_64/ia32.h	2003-01-13 11:07:06.000000000 +1100
@@ -101,19 +101,6 @@
 } __attribute__((packed));
 
 
-struct statfs32 {
-       int f_type;
-       int f_bsize;
-       int f_blocks;
-       int f_bfree;
-       int f_bavail;
-       int f_files;
-       int f_ffree;
-       compat_fsid_t f_fsid;
-       int f_namelen;  /* SunOS ignores this field. */
-       int f_spare[6];
-};
-
 typedef union sigval32 {
 	int sival_int;
 	unsigned int sival_ptr;
