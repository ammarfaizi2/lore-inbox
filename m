Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267902AbTAMFTH>; Mon, 13 Jan 2003 00:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267904AbTAMFTD>; Mon, 13 Jan 2003 00:19:03 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:43741 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267902AbTAMFSt>;
	Mon, 13 Jan 2003 00:18:49 -0500
Date: Mon, 13 Jan 2003 16:27:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][COMPAT] compat_sys_[f]statfs - mips64 part
Message-Id: <20030113162729.551ef978.sfr@canb.auug.org.au>
In-Reply-To: <20030113160923.603d4f72.sfr@canb.auug.org.au>
References: <20030113160923.603d4f72.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

This is the mips64 part.  This is relative to 2.5.56 and the previous
patches I have sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.56-32bit.3/arch/mips64/kernel/linux32.c 2.5.56-32bit.4/arch/mips64/kernel/linux32.c
--- 2.5.56-32bit.3/arch/mips64/kernel/linux32.c	2003-01-13 11:03:51.000000000 +1100
+++ 2.5.56-32bit.4/arch/mips64/kernel/linux32.c	2003-01-13 11:07:06.000000000 +1100
@@ -524,72 +524,6 @@
 	return ret;
 }
 
-struct statfs32 {
-	int	f_type;
-	int	f_bsize;
-	int	f_frsize;
-	int	f_blocks;
-	int	f_bfree;
-	int	f_files;
-	int	f_ffree;
-	int	f_bavail;
-	compat_fsid_t	f_fsid;
-	int	f_namelen;
-	int	f_spare[6];
-};
-
-static inline int
-put_statfs (struct statfs32 *ubuf, struct statfs *kbuf)
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
-asmlinkage int
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
-extern asmlinkage int sys_fstatfs(unsigned int fd, struct statfs * buf);
-
-asmlinkage int
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
 extern asmlinkage int
 sys_getrusage(int who, struct rusage *ru);
 
diff -ruN 2.5.56-32bit.3/arch/mips64/kernel/scall_o32.S 2.5.56-32bit.4/arch/mips64/kernel/scall_o32.S
--- 2.5.56-32bit.3/arch/mips64/kernel/scall_o32.S	2003-01-13 11:02:35.000000000 +1100
+++ 2.5.56-32bit.4/arch/mips64/kernel/scall_o32.S	2003-01-13 11:07:06.000000000 +1100
@@ -332,8 +332,8 @@
 	sys	sys_getpriority	2
 	sys	sys_setpriority	3
 	sys	sys_ni_syscall	0
-	sys	sys32_statfs	2
-	sys	sys32_fstatfs	2			/* 4100 */
+	sys	compat_sys_statfs	2
+	sys	compat_sys_fstatfs	2			/* 4100 */
 	sys	sys_ni_syscall	0	/* sys_ioperm */
 	sys	sys_socketcall	2
 	sys	sys_syslog	3
diff -ruN 2.5.56-32bit.3/include/asm-mips64/compat.h 2.5.56-32bit.4/include/asm-mips64/compat.h
--- 2.5.56-32bit.3/include/asm-mips64/compat.h	2003-01-13 11:03:18.000000000 +1100
+++ 2.5.56-32bit.4/include/asm-mips64/compat.h	2003-01-13 11:07:06.000000000 +1100
@@ -66,4 +66,18 @@
 	short		__unused;
 };
 
+struct compat_statfs {
+	int		f_type;
+	int		f_bsize;
+	int		f_frsize;
+	int		f_blocks;
+	int		f_bfree;
+	int		f_files;
+	int		f_ffree;
+	int		f_bavail;
+	compat_fsid_t	f_fsid;
+	int		f_namelen;
+	int		f_spare[6];
+};
+
 #endif /* _ASM_MIPS64_COMPAT_H */
