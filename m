Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267443AbTACGbs>; Fri, 3 Jan 2003 01:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTACGbs>; Fri, 3 Jan 2003 01:31:48 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:27822 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267443AbTACGbp>;
	Fri, 3 Jan 2003 01:31:45 -0500
Date: Fri, 3 Jan 2003 17:39:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] move struct flock32 7/8 mips64
Message-Id: <20030103173958.4e6b85e1.sfr@canb.auug.org.au>
In-Reply-To: <20030103164106.21e65093.sfr@canb.auug.org.au>
References: <20030103164106.21e65093.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

Here is the mips64 part of the patch. This patch is against Linus' recent
2.5.54 BK tree plus the previous patch I sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301031304-32bit.1/arch/mips64/kernel/linux32.c 2.5.54-200301031304-32bit.2/arch/mips64/kernel/linux32.c
--- 2.5.54-200301031304-32bit.1/arch/mips64/kernel/linux32.c	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/arch/mips64/kernel/linux32.c	2003-01-03 16:24:56.000000000 +1100
@@ -1135,39 +1135,6 @@
 	return sys_setsockopt(fd, level, optname, optval, optlen);
 }
 
-struct flock32 {
-	short l_type;
-	short l_whence;
-	compat_off_t l_start;
-	compat_off_t l_len;
-	compat_pid_t l_pid;
-	short __unused;
-};
-
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
 extern asmlinkage long
 sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
@@ -1183,12 +1150,12 @@
 			mm_segment_t old_fs;
 			long ret;
 			
-			if (get_flock(&f, (struct flock32 *)arg))
+			if (get_compat_flock(&f, (struct compat_flock *)arg))
 				return -EFAULT;
 			old_fs = get_fs(); set_fs (KERNEL_DS);
 			ret = sys_fcntl(fd, cmd, (unsigned long)&f);
 			set_fs (old_fs);
-			if (put_flock(&f, (struct flock32 *)arg))
+			if (put_compat_flock(&f, (struct compat_flock *)arg))
 				return -EFAULT;
 			return ret;
 		}
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-mips64/compat.h 2.5.54-200301031304-32bit.2/include/asm-mips64/compat.h
--- 2.5.54-200301031304-32bit.1/include/asm-mips64/compat.h	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-mips64/compat.h	2003-01-03 16:24:56.000000000 +1100
@@ -57,4 +57,13 @@
 	s32		st_pad4[14];
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
 #endif /* _ASM_MIPS64_COMPAT_H */
