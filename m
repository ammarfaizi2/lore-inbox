Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267838AbTAMFDV>; Mon, 13 Jan 2003 00:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267850AbTAMFDV>; Mon, 13 Jan 2003 00:03:21 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:9181 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267838AbTAMFDS>;
	Mon, 13 Jan 2003 00:03:18 -0500
Date: Mon, 13 Jan 2003 16:12:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_[f]statfs - ppc64 part
Message-Id: <20030113161201.60fed24a.sfr@canb.auug.org.au>
In-Reply-To: <20030113160923.603d4f72.sfr@canb.auug.org.au>
References: <20030113160923.603d4f72.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

Here is the ppc64 part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.56-32bit.3/arch/ppc64/kernel/misc.S 2.5.56-32bit.4/arch/ppc64/kernel/misc.S
--- 2.5.56-32bit.3/arch/ppc64/kernel/misc.S	2003-01-09 16:23:54.000000000 +1100
+++ 2.5.56-32bit.4/arch/ppc64/kernel/misc.S	2003-01-13 11:07:06.000000000 +1100
@@ -567,8 +567,8 @@
 	.llong .sys32_getpriority
 	.llong .sys32_setpriority
 	.llong .sys_ni_syscall		/* old profil syscall */
-	.llong .sys32_statfs
-	.llong .sys32_fstatfs		/* 100 */
+	.llong .compat_sys_statfs
+	.llong .compat_sys_fstatfs		/* 100 */
 	.llong .sys_ioperm
 	.llong .sys32_socketcall
 	.llong .sys32_syslog
diff -ruN 2.5.56-32bit.3/arch/ppc64/kernel/sys_ppc32.c 2.5.56-32bit.4/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.56-32bit.3/arch/ppc64/kernel/sys_ppc32.c	2003-01-13 11:03:52.000000000 +1100
+++ 2.5.56-32bit.4/arch/ppc64/kernel/sys_ppc32.c	2003-01-13 11:07:06.000000000 +1100
@@ -807,65 +807,6 @@
 	return err;
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
-asmlinkage long sys32_statfs(const char * path, struct statfs32 *buf)
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
-	
-	return ret;
-}
-
-extern asmlinkage long sys_fstatfs(unsigned int fd, struct statfs * buf);
-
-asmlinkage long sys32_fstatfs(unsigned int fd, struct statfs32 *buf)
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
-	
-	return ret;
-}
-
-
-
 extern asmlinkage long sys_sysfs(int option, unsigned long arg1, unsigned long arg2);
 
 /* Note: it is necessary to treat option as an unsigned int,
diff -ruN 2.5.56-32bit.3/include/asm-ppc64/compat.h 2.5.56-32bit.4/include/asm-ppc64/compat.h
--- 2.5.56-32bit.3/include/asm-ppc64/compat.h	2003-01-09 16:24:05.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-ppc64/compat.h	2003-01-13 11:07:06.000000000 +1100
@@ -64,4 +64,17 @@
 	short		__unused;
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
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN 2.5.56-32bit.3/include/asm-ppc64/ppc32.h 2.5.56-32bit.4/include/asm-ppc64/ppc32.h
--- 2.5.56-32bit.3/include/asm-ppc64/ppc32.h	2003-01-09 16:24:05.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-ppc64/ppc32.h	2003-01-13 11:07:06.000000000 +1100
@@ -40,19 +40,6 @@
 
 /* These are here to support 32-bit syscalls on a 64-bit kernel. */
 
-struct statfs32 {
-	int f_type;
-	int f_bsize;
-	int f_blocks;
-	int f_bfree;
-	int f_bavail;
-	int f_files;
-	int f_ffree;
-	compat_fsid_t f_fsid;
-	int f_namelen;  /* SunOS ignores this field. */
-	int f_spare[6];
-};
-
 typedef union sigval32 {
 	int sival_int;
 	unsigned int sival_ptr;
