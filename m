Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267870AbTAMFKq>; Mon, 13 Jan 2003 00:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267874AbTAMFKq>; Mon, 13 Jan 2003 00:10:46 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:22237 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267870AbTAMFKm>;
	Mon, 13 Jan 2003 00:10:42 -0500
Date: Mon, 13 Jan 2003 16:19:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] compat_sys_[f]statfs - sparc64 part
Message-Id: <20030113161924.605a14fa.sfr@canb.auug.org.au>
In-Reply-To: <20030113160923.603d4f72.sfr@canb.auug.org.au>
References: <20030113160923.603d4f72.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

This is the sparc64 part.  This is relative to 2.5.56 and the previous
patches I have sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.56-32bit.3/arch/sparc64/kernel/sys_sparc32.c 2.5.56-32bit.4/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.56-32bit.3/arch/sparc64/kernel/sys_sparc32.c	2003-01-12 15:11:55.000000000 +1100
+++ 2.5.56-32bit.4/arch/sparc64/kernel/sys_sparc32.c	2003-01-13 11:07:06.000000000 +1100
@@ -840,61 +840,6 @@
 	return sys32_fcntl(fd, cmd, arg);
 }
 
-static int put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
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
 
diff -ruN 2.5.56-32bit.3/arch/sparc64/kernel/systbls.S 2.5.56-32bit.4/arch/sparc64/kernel/systbls.S
--- 2.5.56-32bit.3/arch/sparc64/kernel/systbls.S	2003-01-02 15:13:45.000000000 +1100
+++ 2.5.56-32bit.4/arch/sparc64/kernel/systbls.S	2003-01-13 11:07:06.000000000 +1100
@@ -50,7 +50,7 @@
 /*140*/	.word sys32_sendfile64, sys_nis_syscall, sys_futex, sys_gettid, sys32_getrlimit
 	.word sys32_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
-	.word sys32_fcntl64, sys_ni_syscall, sys32_statfs, sys32_fstatfs, sys_oldumount
+	.word sys32_fcntl64, sys_ni_syscall, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
 /*160*/	.word sys32_sched_setaffinity, sys32_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
 	.word sys_quotactl, sys_set_tid_address, sys32_mount, sys_ustat, sys_setxattr
 /*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys32_getdents
@@ -197,7 +197,7 @@
 	.word sunos_nosys, sunos_nosys
 /*150*/	.word sys_getsockname, sunos_nosys, sunos_nosys
 	.word sys_poll, sunos_nosys, sunos_nosys
-	.word sunos_getdirentries, sys32_statfs, sys32_fstatfs
+	.word sunos_getdirentries, compat_sys_statfs, compat_sys_fstatfs
 	.word sys_oldumount, sunos_nosys, sunos_nosys
 	.word sys_getdomainname, sys_setdomainname
 	.word sunos_nosys, sys_quotactl, sunos_nosys
diff -ruN 2.5.56-32bit.3/include/asm-sparc64/compat.h 2.5.56-32bit.4/include/asm-sparc64/compat.h
--- 2.5.56-32bit.3/include/asm-sparc64/compat.h	2003-01-09 16:24:05.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-sparc64/compat.h	2003-01-13 11:07:06.000000000 +1100
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
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN 2.5.56-32bit.3/include/asm-sparc64/statfs.h 2.5.56-32bit.4/include/asm-sparc64/statfs.h
--- 2.5.56-32bit.3/include/asm-sparc64/statfs.h	2003-01-09 16:24:05.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-sparc64/statfs.h	2003-01-13 11:07:06.000000000 +1100
@@ -5,25 +5,11 @@
 #ifndef __KERNEL_STRICT_NAMES
 
 #include <linux/types.h>
-#include <linux/compat.h>	/* for compat_fsid_t */
 
 typedef __kernel_fsid_t	fsid_t;
 
 #endif
 
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
 struct statfs {
 	long f_type;
 	long f_bsize;
