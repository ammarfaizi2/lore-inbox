Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267866AbTAMFQQ>; Mon, 13 Jan 2003 00:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267895AbTAMFQP>; Mon, 13 Jan 2003 00:16:15 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:31709 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267866AbTAMFOe>;
	Mon, 13 Jan 2003 00:14:34 -0500
Date: Mon, 13 Jan 2003 16:23:17 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_[f]statfs - ia64 part
Message-Id: <20030113162317.4470b403.sfr@canb.auug.org.au>
In-Reply-To: <20030113160923.603d4f72.sfr@canb.auug.org.au>
References: <20030113160923.603d4f72.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Here is the ia64 part.  It is relative to 2.5.56 plus the previous patches
I have sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.56-32bit.3/arch/ia64/ia32/ia32_entry.S 2.5.56-32bit.4/arch/ia64/ia32/ia32_entry.S
--- 2.5.56-32bit.3/arch/ia64/ia32/ia32_entry.S	2002-12-27 15:15:38.000000000 +1100
+++ 2.5.56-32bit.4/arch/ia64/ia32/ia32_entry.S	2003-01-13 11:07:06.000000000 +1100
@@ -290,8 +290,8 @@
 	data8 sys_getpriority
 	data8 sys_setpriority
 	data8 sys32_ni_syscall	  /* old profil syscall holder */
-	data8 sys32_statfs
-	data8 sys32_fstatfs	  /* 100 */
+	data8 compat_sys_statfs
+	data8 compat_sys_fstatfs	  /* 100 */
 	data8 sys32_ioperm
 	data8 sys32_socketcall
 	data8 sys_syslog
diff -ruN 2.5.56-32bit.3/arch/ia64/ia32/sys_ia32.c 2.5.56-32bit.4/arch/ia64/ia32/sys_ia32.c
--- 2.5.56-32bit.3/arch/ia64/ia32/sys_ia32.c	2003-01-13 11:03:51.000000000 +1100
+++ 2.5.56-32bit.4/arch/ia64/ia32/sys_ia32.c	2003-01-13 11:07:06.000000000 +1100
@@ -609,61 +609,6 @@
 	return retval;
 }
 
-static inline int
-put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
-{
-	int err;
-
-	if (!access_ok(VERIFY_WRITE, ubuf, sizeof(*ubuf)))
-		return -EFAULT;
-
-	err = __put_user(kbuf->f_type, &ubuf->f_type);
-	err |= __put_user(kbuf->f_bsize, &ubuf->f_bsize);
-	err |= __put_user(kbuf->f_blocks, &ubuf->f_blocks);
-	err |= __put_user(kbuf->f_bfree, &ubuf->f_bfree);
-	err |= __put_user(kbuf->f_bavail, &ubuf->f_bavail);
-	err |= __put_user(kbuf->f_files, &ubuf->f_files);
-	err |= __put_user(kbuf->f_ffree, &ubuf->f_ffree);
-	err |= __put_user(kbuf->f_namelen, &ubuf->f_namelen);
-	err |= __put_user(kbuf->f_fsid.val[0], &ubuf->f_fsid.val[0]);
-	err |= __put_user(kbuf->f_fsid.val[1], &ubuf->f_fsid.val[1]);
-	return err;
-}
-
-extern asmlinkage long sys_statfs(const char * path, struct statfs * buf);
-
-asmlinkage long
-sys32_statfs (const char *path, struct statfs32 *buf)
-{
-	int ret;
-	struct statfs s;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	ret = sys_statfs(path, &s);
-	set_fs(old_fs);
-	if (put_statfs(buf, &s))
-		return -EFAULT;
-	return ret;
-}
-
-extern asmlinkage long sys_fstatfs(unsigned int fd, struct statfs * buf);
-
-asmlinkage long
-sys32_fstatfs (unsigned int fd, struct statfs32 *buf)
-{
-	int ret;
-	struct statfs s;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	ret = sys_fstatfs(fd, &s);
-	set_fs(old_fs);
-	if (put_statfs(buf, &s))
-		return -EFAULT;
-	return ret;
-}
-
 static inline long
 get_tv32 (struct timeval *o, struct compat_timeval *i)
 {
diff -ruN 2.5.56-32bit.3/include/asm-ia64/compat.h 2.5.56-32bit.4/include/asm-ia64/compat.h
--- 2.5.56-32bit.3/include/asm-ia64/compat.h	2003-01-13 11:02:36.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-ia64/compat.h	2003-01-13 11:07:06.000000000 +1100
@@ -61,11 +61,24 @@
 };
 
 struct compat_flock {
-       short		l_type;
-       short		l_whence;
-       compat_off_t	l_start;
-       compat_off_t	l_len;
-       compat_pid_t	l_pid;
+	short		l_type;
+	short		l_whence;
+	compat_off_t	l_start;
+	compat_off_t	l_len;
+	compat_pid_t	l_pid;
+};
+
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
 };
 
 #endif /* _ASM_IA64_COMPAT_H */
diff -ruN 2.5.56-32bit.3/include/asm-ia64/ia32.h 2.5.56-32bit.4/include/asm-ia64/ia32.h
--- 2.5.56-32bit.3/include/asm-ia64/ia32.h	2003-01-13 11:02:36.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-ia64/ia32.h	2003-01-13 11:07:06.000000000 +1100
@@ -203,19 +203,6 @@
 	unsigned int	st_ino_hi;
 };
 
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
