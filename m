Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbTACGUa>; Fri, 3 Jan 2003 01:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbTACGUa>; Fri, 3 Jan 2003 01:20:30 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:38573 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267424AbTACGU2>;
	Fri, 3 Jan 2003 01:20:28 -0500
Date: Fri, 3 Jan 2003 17:28:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] move struct flock32 5/8 ia64
Message-Id: <20030103172842.6cfd5fac.sfr@canb.auug.org.au>
In-Reply-To: <20030103164106.21e65093.sfr@canb.auug.org.au>
References: <20030103164106.21e65093.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Here is the ia64 specific patch.  This is against Linus' recent 2.5.54 BK
tree plus the previous patch I sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301031304-32bit.1/arch/ia64/ia32/sys_ia32.c 2.5.54-200301031304-32bit.2/arch/ia64/ia32/sys_ia32.c
--- 2.5.54-200301031304-32bit.1/arch/ia64/ia32/sys_ia32.c	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/arch/ia64/ia32/sys_ia32.c	2003-01-03 16:24:56.000000000 +1100
@@ -3017,38 +3017,6 @@
 	return ret;
 }
 
-static inline int
-get_flock32(struct flock *kfl, struct flock32 *ufl)
-{
-	int err;
-
-	if (!access_ok(VERIFY_READ, ufl, sizeof(*ufl)))
-		return -EFAULT;
-
-	err = __get_user(kfl->l_type, &ufl->l_type);
-	err |= __get_user(kfl->l_whence, &ufl->l_whence);
-	err |= __get_user(kfl->l_start, &ufl->l_start);
-	err |= __get_user(kfl->l_len, &ufl->l_len);
-	err |= __get_user(kfl->l_pid, &ufl->l_pid);
-	return err;
-}
-
-static inline int
-put_flock32(struct flock *kfl, struct flock32 *ufl)
-{
-	int err;
-
-	if (!access_ok(VERIFY_WRITE, ufl, sizeof(*ufl)))
-		return -EFAULT;
-
-	err = __put_user(kfl->l_type, &ufl->l_type);
-	err |= __put_user(kfl->l_whence, &ufl->l_whence);
-	err |= __put_user(kfl->l_start, &ufl->l_start);
-	err |= __put_user(kfl->l_len, &ufl->l_len);
-	err |= __put_user(kfl->l_pid, &ufl->l_pid);
-	return err;
-}
-
 extern asmlinkage long sys_fcntl (unsigned int fd, unsigned int cmd, unsigned long arg);
 
 asmlinkage long
@@ -3062,13 +3030,13 @@
 	      case F_GETLK:
 	      case F_SETLK:
 	      case F_SETLKW:
-		if (get_flock32(&f, (struct flock32 *) A(arg)))
+		if (get_compat_flock(&f, (struct compat_flock *) A(arg)))
 			return -EFAULT;
 		old_fs = get_fs();
 		set_fs(KERNEL_DS);
 		ret = sys_fcntl(fd, cmd, (unsigned long) &f);
 		set_fs(old_fs);
-		if (cmd == F_GETLK && put_flock32(&f, (struct flock32 *) A(arg)))
+		if (cmd == F_GETLK && put_compat_flock(&f, (struct compat_flock *) A(arg)))
 			return -EFAULT;
 		return ret;
 
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-ia64/compat.h 2.5.54-200301031304-32bit.2/include/asm-ia64/compat.h
--- 2.5.54-200301031304-32bit.1/include/asm-ia64/compat.h	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-ia64/compat.h	2003-01-03 16:24:56.000000000 +1100
@@ -60,4 +60,12 @@
 	u32		__unused5;
 };
 
+struct compat_flock {
+       short		l_type;
+       short		l_whence;
+       compat_off_t	l_start;
+       compat_off_t	l_len;
+       compat_pid_t	l_pid;
+};
+
 #endif /* _ASM_IA64_COMPAT_H */
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-ia64/ia32.h 2.5.54-200301031304-32bit.2/include/asm-ia64/ia32.h
--- 2.5.54-200301031304-32bit.1/include/asm-ia64/ia32.h	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-ia64/ia32.h	2003-01-03 16:24:56.000000000 +1100
@@ -18,15 +18,6 @@
 #define IA32_PAGE_ALIGN(addr)	(((addr) + IA32_PAGE_SIZE - 1) & IA32_PAGE_MASK)
 #define IA32_CLOCKS_PER_SEC	100	/* Cast in stone for IA32 Linux */
 
-/* fcntl.h */
-struct flock32 {
-       short l_type;
-       short l_whence;
-       compat_off_t l_start;
-       compat_off_t l_len;
-       compat_pid_t l_pid;
-};
-
 #define F_GETLK64	12
 #define F_SETLK64	13
 #define F_SETLKW64	14
