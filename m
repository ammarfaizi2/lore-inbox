Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTACGRW>; Fri, 3 Jan 2003 01:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTACGRV>; Fri, 3 Jan 2003 01:17:21 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:24749 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267425AbTACGRU>;
	Fri, 3 Jan 2003 01:17:20 -0500
Date: Fri, 3 Jan 2003 17:25:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ak@muc.de
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] move struct flock32 4/8 x86_64
Message-Id: <20030103172533.048fee08.sfr@canb.auug.org.au>
In-Reply-To: <20030103164106.21e65093.sfr@canb.auug.org.au>
References: <20030103164106.21e65093.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Here is the x86_64 specific patch.  This is against Linus' recent 2.5.54
BK tree plus the previous patch I sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301031304-32bit.1/arch/x86_64/ia32/sys_ia32.c 2.5.54-200301031304-32bit.2/arch/x86_64/ia32/sys_ia32.c
--- 2.5.54-200301031304-32bit.1/arch/x86_64/ia32/sys_ia32.c	2003-01-02 15:13:46.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/arch/x86_64/ia32/sys_ia32.c	2003-01-03 16:24:56.000000000 +1100
@@ -1066,30 +1066,6 @@
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
 asmlinkage long sys32_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg);
 
@@ -1105,13 +1081,13 @@
 			mm_segment_t old_fs;
 			long ret;
 			
-			if (get_flock(&f, (struct flock32 *)arg))
+			if (get_compat_flock(&f, (struct compat_flock *)arg))
 				return -EFAULT;
 			old_fs = get_fs(); set_fs (KERNEL_DS);
 			ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 			set_fs (old_fs);
 			if (ret) return ret;
-			if (put_flock(&f, (struct flock32 *)arg))
+			if (put_compat_flock(&f, (struct compat_flock *)arg))
 				return -EFAULT;
 			return 0;
 		}
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-x86_64/compat.h 2.5.54-200301031304-32bit.2/include/asm-x86_64/compat.h
--- 2.5.54-200301031304-32bit.1/include/asm-x86_64/compat.h	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-x86_64/compat.h	2003-01-03 16:24:56.000000000 +1100
@@ -60,4 +60,12 @@
 	u32		__unused5;
 };
 
+struct compat_flock {
+	short		l_type;
+	short		l_whence;
+	compat_off_t	l_start;
+	compat_off_t	l_len;
+	compat_pid_t	l_pid;
+};
+
 #endif /* _ASM_X86_64_COMPAT_H */
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-x86_64/ia32.h 2.5.54-200301031304-32bit.2/include/asm-x86_64/ia32.h
--- 2.5.54-200301031304-32bit.1/include/asm-x86_64/ia32.h	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-x86_64/ia32.h	2003-01-03 16:24:56.000000000 +1100
@@ -11,16 +11,6 @@
  * 32 bit structures for IA32 support.
  */
 
-/* fcntl.h */
-struct flock32 {
-       short l_type;
-       short l_whence;
-       compat_off_t l_start;
-       compat_off_t l_len;
-       compat_pid_t l_pid;
-};
-
-
 struct ia32_flock64 {
 	short  l_type;
 	short  l_whence;
