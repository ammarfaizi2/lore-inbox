Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTACGeB>; Fri, 3 Jan 2003 01:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbTACGeB>; Fri, 3 Jan 2003 01:34:01 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:46254 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267429AbTACGdz>;
	Fri, 3 Jan 2003 01:33:55 -0500
Date: Fri, 3 Jan 2003 17:42:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: matthew@wil.cx
Cc: torvalds@transmeta.com, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][COMPAT] move struct flock32 8/8 parisc
Message-Id: <20030103174212.18df3e6b.sfr@canb.auug.org.au>
In-Reply-To: <20030103164106.21e65093.sfr@canb.auug.org.au>
References: <20030103164106.21e65093.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Here is the parisc part of the patch. This is against Linus' recent 2.5.54
BK tree plus the previous patch I sent you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301031304-32bit.1/arch/parisc/kernel/sys_parisc32.c 2.5.54-200301031304-32bit.2/arch/parisc/kernel/sys_parisc32.c
--- 2.5.54-200301031304-32bit.1/arch/parisc/kernel/sys_parisc32.c	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/arch/parisc/kernel/sys_parisc32.c	2003-01-03 16:24:56.000000000 +1100
@@ -387,39 +387,6 @@
  * code available in case it's useful to others. -PB
  */
 
-struct flock32 {
-	short l_type;
-	short l_whence;
-	compat_off_t l_start;
-	compat_off_t l_len;
-	compat_pid_t l_pid;
-};
-
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
 extern asmlinkage long sys_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
 asmlinkage long sys32_fcntl(unsigned int fd, unsigned int cmd, unsigned long arg)
@@ -432,7 +399,7 @@
 			struct flock f;
 			long ret;
 			
-			if(get_flock(&f, (struct flock32 *)arg))
+			if(get_compat_flock(&f, (struct compat_flock *)arg))
 				return -EFAULT;
 			KERNEL_SYSCALL(ret, sys_fcntl, fd, cmd, (unsigned long)&f);
 			if (ret) return ret;
@@ -440,7 +407,7 @@
 			    f.l_len >= 0x7fffffffUL ||
 			    f.l_start + f.l_len >= 0x7fffffffUL)
 				return -EOVERFLOW;
-			if(put_flock(&f, (struct flock32 *)arg))
+			if(put_compat_flock(&f, (struct compat_flock *)arg))
 				return -EFAULT;
 			return 0;
 		}
diff -ruN 2.5.54-200301031304-32bit.1/include/asm-parisc/compat.h 2.5.54-200301031304-32bit.2/include/asm-parisc/compat.h
--- 2.5.54-200301031304-32bit.1/include/asm-parisc/compat.h	2003-01-03 16:24:15.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/asm-parisc/compat.h	2003-01-03 16:24:56.000000000 +1100
@@ -64,4 +64,12 @@
 	u32		st_spare4[3];
 };
 
+struct compat_flock {
+	short		l_type;
+	short		l_whence;
+	compat_off_t	l_start;
+	compat_off_t	l_len;
+	compat_pid_t	l_pid;
+};
+
 #endif /* _ASM_PARISC_COMPAT_H */
