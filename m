Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267398AbTACFq5>; Fri, 3 Jan 2003 00:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbTACFq4>; Fri, 3 Jan 2003 00:46:56 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:36522 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267398AbTACFqz>;
	Fri, 3 Jan 2003 00:46:55 -0500
Date: Fri, 3 Jan 2003 16:55:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: anton@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] move struct flock32 2/8 ppc64
Message-Id: <20030103165515.2daf9c8a.sfr@canb.auug.org.au>
In-Reply-To: <20030103164106.21e65093.sfr@canb.auug.org.au>
References: <20030103164106.21e65093.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

This is the ppc64 specific part. Patch is against recent Linus 2.5.54 BK tree.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301031304-32bit.1/arch/ppc64/kernel/sys_ppc32.c 2.5.54-200301031304-32bit.2/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.54-200301031304-32bit.1/arch/ppc64/kernel/sys_ppc32.c	2003-01-03 14:08:44.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/arch/ppc64/kernel/sys_ppc32.c	2003-01-03 16:24:56.000000000 +1100
@@ -247,30 +247,6 @@
 	return ret;
 }
 
-static inline int get_flock(struct flock *kfl, struct flock32 *ufl)
-{
-	int err;
-	
-	err = get_user(kfl->l_type, &ufl->l_type);
-	err |= __get_user(kfl->l_whence, &ufl->l_whence);
-	err |= __get_user(kfl->l_start, &ufl->l_start);
-	err |= __get_user(kfl->l_len, &ufl->l_len);
-	err |= __get_user(kfl->l_pid, &ufl->l_pid);
-	return err;
-}
-
-static inline int put_flock(struct flock *kfl, struct flock32 *ufl)
-{
-	int err;
-	
-	err = __put_user(kfl->l_type, &ufl->l_type);
-	err |= __put_user(kfl->l_whence, &ufl->l_whence);
-	err |= __put_user(kfl->l_start, &ufl->l_start);
-	err |= __put_user(kfl->l_len, &ufl->l_len);
-	err |= __put_user(kfl->l_pid, &ufl->l_pid);
-	return err;
-}
-
 extern asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
 asmlinkage long sys32_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -283,12 +259,12 @@
 		mm_segment_t old_fs;
 		long ret;
 
-		if(get_flock(&f, (struct flock32 *)arg))
+		if(get_compat_flock(&f, (struct compat_flock *)arg))
 			return -EFAULT;
 		old_fs = get_fs(); set_fs (KERNEL_DS);
 		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 		set_fs (old_fs);
-		if(put_flock(&f, (struct flock32 *)arg))
+		if(put_compat_flock(&f, (struct compat_flock *)arg))
 			return -EFAULT;
 		return ret;
 	}
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-ppc64/compat.h 2.5.54-200301031304-32bit.2/include/asm-ppc64/compat.h
--- 2.5.54-200301031304-32bit.1/include/asm-ppc64/compat.h	2003-01-03 14:08:45.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-ppc64/compat.h	2003-01-03 16:24:56.000000000 +1100
@@ -55,4 +55,13 @@
 	u32		__unused4[2];
 };
 
+struct compat_flock {
+	short		l_type;
+	short		l_whence;
+	compat_off_t	l_start;
+	compat_off_t	l_len;
+	compat_pid_t	l_pid;
+	short		__unused;
+};
+
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-ppc64/ppc32.h 2.5.54-200301031304-32bit.2/include/asm-ppc64/ppc32.h
--- 2.5.54-200301031304-32bit.1/include/asm-ppc64/ppc32.h	2003-01-03 14:08:45.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-ppc64/ppc32.h	2003-01-03 16:24:56.000000000 +1100
@@ -141,15 +141,6 @@
 	compat_size_t ss_size;
 } stack_32_t;
 
-struct flock32 {
-	short l_type;
-	short l_whence;
-	compat_off_t l_start;
-	compat_off_t l_len;
-	compat_pid_t l_pid;
-	short __unused;
-};
-
 struct sigcontext32 {
 	unsigned int	_unused[4];
 	int		signal;
