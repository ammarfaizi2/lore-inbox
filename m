Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbTACG1m>; Fri, 3 Jan 2003 01:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267429AbTACG1l>; Fri, 3 Jan 2003 01:27:41 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:10670 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267423AbTACG1i>;
	Fri, 3 Jan 2003 01:27:38 -0500
Date: Fri, 3 Jan 2003 17:35:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: [PATCH][COMPAT] move struct flock32 6/8 s390x
Message-Id: <20030103173544.1f63c8ba.sfr@canb.auug.org.au>
In-Reply-To: <20030103164106.21e65093.sfr@canb.auug.org.au>
References: <20030103164106.21e65093.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the s390x part of the patch.  Martin has said that I should feed
these straight to you and he will fix up any problems later.  Please apply
if you apply the gerneic part.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301031304-32bit.1/arch/s390x/kernel/linux32.c 2.5.54-200301031304-32bit.2/arch/s390x/kernel/linux32.c
--- 2.5.54-200301031304-32bit.1/arch/s390x/kernel/linux32.c	2003-01-02 15:13:45.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/arch/s390x/kernel/linux32.c	2003-01-03 16:24:56.000000000 +1100
@@ -833,30 +833,6 @@
 	return err;
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
@@ -868,7 +844,7 @@
 			mm_segment_t old_fs;
 			long ret;
 			
-			if(get_flock(&f, (struct flock32 *)A(arg)))
+			if(get_compat_flock(&f, (struct compat_flock *)A(arg)))
 				return -EFAULT;
 			old_fs = get_fs(); set_fs (KERNEL_DS);
 			ret = sys_fcntl(fd, cmd, (unsigned long)&f);
@@ -877,7 +853,7 @@
 			if (f.l_start >= 0x7fffffffUL ||
 			    f.l_start + f.l_len >= 0x7fffffffUL)
 				return -EOVERFLOW;
-			if(put_flock(&f, (struct flock32 *)A(arg)))
+			if(put_compat_flock(&f, (struct compat_flock *)A(arg)))
 				return -EFAULT;
 			return 0;
 		}
@@ -888,7 +864,7 @@
 			mm_segment_t old_fs;
 			long ret;
 			
-			if(get_flock(&f, (struct flock32 *)A(arg)))
+			if(get_compat_flock(&f, (struct compat_flock *)A(arg)))
 				return -EFAULT;
 			old_fs = get_fs(); set_fs (KERNEL_DS);
 			ret = sys_fcntl(fd, cmd, (unsigned long)&f);
diff -ruN 2.5.54-200301031304-32bit.1/arch/s390x/kernel/linux32.h 2.5.54-200301031304-32bit.2/arch/s390x/kernel/linux32.h
--- 2.5.54-200301031304-32bit.1/arch/s390x/kernel/linux32.h	2003-01-02 15:13:45.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/arch/s390x/kernel/linux32.h	2003-01-03 16:24:56.000000000 +1100
@@ -25,15 +25,6 @@
 #define F_SETLK64       13
 #define F_SETLKW64      14    
 
-struct flock32 {
-        short l_type;
-        short l_whence;
-        compat_off_t l_start;
-        compat_off_t l_len;
-        compat_pid_t l_pid;
-        short __unused;
-}; 
-
 struct statfs32 {
 	__s32			f_type;
 	__s32			f_bsize;
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-s390x/compat.h 2.5.54-200301031304-32bit.2/include/asm-s390x/compat.h
--- 2.5.54-200301031304-32bit.1/include/asm-s390x/compat.h	2003-01-02 15:13:49.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-s390x/compat.h	2003-01-03 16:24:56.000000000 +1100
@@ -58,4 +58,13 @@
 	u32		__unused5;
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
 #endif /* _ASM_S390X_COMPAT_H */
