Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267933AbTAMFVw>; Mon, 13 Jan 2003 00:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267924AbTAMFVI>; Mon, 13 Jan 2003 00:21:08 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:45277 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267921AbTAMFUD>;
	Mon, 13 Jan 2003 00:20:03 -0500
Date: Mon, 13 Jan 2003 16:28:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: matthew@wil.cx
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_sys_[f]statfs - parisc part
Message-Id: <20030113162847.53de7ca3.sfr@canb.auug.org.au>
In-Reply-To: <20030113160923.603d4f72.sfr@canb.auug.org.au>
References: <20030113160923.603d4f72.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Here is the parisc part. This is relative to 2.5.56 and the previous
patches I have sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.56-32bit.3/arch/parisc/kernel/sys_parisc32.c 2.5.56-32bit.4/arch/parisc/kernel/sys_parisc32.c
--- 2.5.56-32bit.3/arch/parisc/kernel/sys_parisc32.c	2003-01-13 11:03:51.000000000 +1100
+++ 2.5.56-32bit.4/arch/parisc/kernel/sys_parisc32.c	2003-01-13 11:07:06.000000000 +1100
@@ -315,74 +315,6 @@
     return -ENOSYS;
 }
 
-/* 32-bit user apps use struct statfs which uses 'long's */
-struct statfs32 {
-	__s32 f_type;
-	__s32 f_bsize;
-	__s32 f_blocks;
-	__s32 f_bfree;
-	__s32 f_bavail;
-	__s32 f_files;
-	__s32 f_ffree;
-	__kernel_fsid_t f_fsid;
-	__s32 f_namelen;
-	__s32 f_spare[6];
-};
-
-/* convert statfs struct to statfs32 struct and copy result to user */
-static unsigned long statfs32_to_user(struct statfs32 *ust32, struct statfs *st)
-{
-    struct statfs32 st32;
-#undef CP
-#define CP(a) st32.a = st->a
-    CP(f_type);
-    CP(f_bsize);
-    CP(f_blocks);
-    CP(f_bfree);
-    CP(f_bavail);
-    CP(f_files);
-    CP(f_ffree);
-    CP(f_fsid);
-    CP(f_namelen);
-    return copy_to_user(ust32, &st32, sizeof st32);
-}
-
-/* The following statfs calls are copies of code from linux/fs/open.c and
- * should be checked against those from time to time */
-asmlinkage long sys32_statfs(const char * path, struct statfs32 * buf)
-{
-	struct nameidata nd;
-	int error;
-
-	error = user_path_walk(path, &nd);
-	if (!error) {
-		struct statfs tmp;
-		error = vfs_statfs(nd.dentry->d_inode->i_sb, &tmp);
-		if (!error && statfs32_to_user(buf, &tmp))
-			error = -EFAULT;
-		path_release(&nd);
-	}
-	return error;
-}
-
-asmlinkage long sys32_fstatfs(unsigned int fd, struct statfs32 * buf)
-{
-	struct file * file;
-	struct statfs tmp;
-	int error;
-
-	error = -EBADF;
-	file = fget(fd);
-	if (!file)
-		goto out;
-	error = vfs_statfs(file->f_dentry->d_inode->i_sb, &tmp);
-	if (!error && statfs32_to_user(buf, &tmp))
-		error = -EFAULT;
-	fput(file);
-out:
-	return error;
-}
-
 /* These may not work without my local types changes, but I wanted the
  * code available in case it's useful to others. -PB
  */
diff -ruN 2.5.56-32bit.3/include/asm-parisc/compat.h 2.5.56-32bit.4/include/asm-parisc/compat.h
--- 2.5.56-32bit.3/include/asm-parisc/compat.h	2003-01-13 11:03:18.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-parisc/compat.h	2003-01-13 11:07:06.000000000 +1100
@@ -72,4 +72,17 @@
 	compat_pid_t	l_pid;
 };
 
+struct compat_statfs {
+	s32		f_type;
+	s32		f_bsize;
+	s32		f_blocks;
+	s32		f_bfree;
+	s32		f_bavail;
+	s32		f_files;
+	s32		f_ffree;
+	__kernel_fsid_t	f_fsid;
+	s32		f_namelen;
+	s32		f_spare[6];
+};
+
 #endif /* _ASM_PARISC_COMPAT_H */
