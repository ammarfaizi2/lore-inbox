Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267416AbTACGNJ>; Fri, 3 Jan 2003 01:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbTACGNJ>; Fri, 3 Jan 2003 01:13:09 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:5549 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267416AbTACGNG>;
	Fri, 3 Jan 2003 01:13:06 -0500
Date: Fri, 3 Jan 2003 17:21:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davem@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] move struct flock32 3/8 sparc64
Message-Id: <20030103172118.59b24934.sfr@canb.auug.org.au>
In-Reply-To: <20030103164106.21e65093.sfr@canb.auug.org.au>
References: <20030103164106.21e65093.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here is the sparc64 specific part.  This patch is against Linus' recent
2.5.54 BK plus the previous patch I sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301031304-32bit.1/arch/sparc64/kernel/sys_sparc32.c 2.5.54-200301031304-32bit.2/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.54-200301031304-32bit.1/arch/sparc64/kernel/sys_sparc32.c	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/arch/sparc64/kernel/sys_sparc32.c	2003-01-03 16:24:56.000000000 +1100
@@ -804,30 +804,6 @@
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
@@ -841,13 +817,13 @@
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
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-sparc64/compat.h 2.5.54-200301031304-32bit.2/include/asm-sparc64/compat.h
--- 2.5.54-200301031304-32bit.1/include/asm-sparc64/compat.h	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-sparc64/compat.h	2003-01-03 16:24:56.000000000 +1100
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
 #endif /* _ASM_SPARC64_COMPAT_H */
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-sparc64/fcntl.h 2.5.54-200301031304-32bit.2/include/asm-sparc64/fcntl.h
--- 2.5.54-200301031304-32bit.1/include/asm-sparc64/fcntl.h	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-sparc64/fcntl.h	2003-01-03 16:24:56.000000000 +1100
@@ -79,19 +79,6 @@
 };
 
 #ifdef __KERNEL__
-#include <linux/compat.h>
-
-struct flock32 {
-	short l_type;
-	short l_whence;
-	compat_off_t l_start;
-	compat_off_t l_len;
-	compat_pid_t l_pid;
-	short __unused;
-};
-#endif
-
-#ifdef __KERNEL__
 #define flock64	flock
 #endif
 
