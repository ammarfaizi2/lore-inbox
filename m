Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTB1EY7>; Thu, 27 Feb 2003 23:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTB1EY7>; Thu, 27 Feb 2003 23:24:59 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:49857 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261701AbTB1EYz>;
	Thu, 27 Feb 2003 23:24:55 -0500
Date: Fri, 28 Feb 2003 15:33:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus <torvalds@transmeta.com>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
Message-Id: <20030228153349.600b73f7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is my first pass at compat_sys_fcntl and compat_sys_fcntl64.

I am hoping it is OK with everyone.

This is just the generic part of the patch, arch's to follow.

As a side effect, this allows the removal of struct flock64 from all
the 64 bit architectures.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.63-32bit.1/fs/compat.c 2.5.63-32bit.2/fs/compat.c
--- 2.5.63-32bit.1/fs/compat.c	2003-01-14 09:57:57.000000000 +1100
+++ 2.5.63-32bit.2/fs/compat.c	2003-02-25 14:35:59.000000000 +1100
@@ -75,36 +75,6 @@
 	return error;
 }
 
-int get_compat_flock(struct flock *kfl, struct compat_flock *ufl)
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
-int put_compat_flock(struct flock *kfl, struct compat_flock *ufl)
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
 static int put_compat_statfs(struct compat_statfs *ubuf, struct statfs *kbuf)
 {
 	if (verify_area(VERIFY_WRITE, ubuf, sizeof(*ubuf)) ||
@@ -159,3 +129,120 @@
 out:
 	return error;
 }
+
+static int get_compat_flock(struct flock *kfl, struct compat_flock *ufl)
+{
+	if (!access_ok(VERIFY_READ, ufl, sizeof(*ufl)) ||
+	    __get_user(kfl->l_type, &ufl->l_type) ||
+	    __get_user(kfl->l_whence, &ufl->l_whence) ||
+	    __get_user(kfl->l_start, &ufl->l_start) ||
+	    __get_user(kfl->l_len, &ufl->l_len) ||
+	    __get_user(kfl->l_pid, &ufl->l_pid))
+		return -EFAULT;
+	return 0;
+}
+
+static int put_compat_flock(struct flock *kfl, struct compat_flock *ufl)
+{
+	if (!access_ok(VERIFY_WRITE, ufl, sizeof(*ufl)) ||
+	    __put_user(kfl->l_type, &ufl->l_type) ||
+	    __put_user(kfl->l_whence, &ufl->l_whence) ||
+	    __put_user(kfl->l_start, &ufl->l_start) ||
+	    __put_user(kfl->l_len, &ufl->l_len) ||
+	    __put_user(kfl->l_pid, &ufl->l_pid))
+		return -EFAULT;
+	return 0;
+}
+
+static int get_compat_flock64(struct flock *kfl, struct compat_flock64 *ufl)
+{
+	if (!access_ok(VERIFY_READ, ufl, sizeof(*ufl)) ||
+	    __get_user(kfl->l_type, &ufl->l_type) ||
+	    __get_user(kfl->l_whence, &ufl->l_whence) ||
+	    __get_user(kfl->l_start, &ufl->l_start) ||
+	    __get_user(kfl->l_len, &ufl->l_len) ||
+	    __get_user(kfl->l_pid, &ufl->l_pid))
+		return -EFAULT;
+	return 0;
+}
+
+static int put_compat_flock64(struct flock *kfl, struct compat_flock64 *ufl)
+{
+	if (!access_ok(VERIFY_WRITE, ufl, sizeof(*ufl)) ||
+	    __put_user(kfl->l_type, &ufl->l_type) ||
+	    __put_user(kfl->l_whence, &ufl->l_whence) ||
+	    __put_user(kfl->l_start, &ufl->l_start) ||
+	    __put_user(kfl->l_len, &ufl->l_len) ||
+	    __put_user(kfl->l_pid, &ufl->l_pid))
+		return -EFAULT;
+	return 0;
+}
+
+extern asmlinkage long sys_fcntl(unsigned int, unsigned int, unsigned long);
+
+asmlinkage long compat_sys_fcntl64(unsigned int fd, unsigned int cmd,
+		unsigned long arg)
+{
+	mm_segment_t old_fs;
+	struct flock f;
+	long ret;
+
+	switch (cmd) {
+	case F_GETLK:
+	case F_SETLK:
+	case F_SETLKW:
+		ret = get_compat_flock(&f, (struct compat_flock *)arg);
+		if (ret != 0)
+			break;
+		old_fs = get_fs();
+		set_fs(KERNEL_DS);
+		ret = sys_fcntl(fd, cmd, (unsigned long)&f);
+		set_fs(old_fs);
+		if ((cmd == F_GETLK) && (ret == 0)) {
+			if ((f.l_start >= COMPAT_OFF_T_MAX) ||
+			    ((f.l_start + f.l_len) >= COMPAT_OFF_T_MAX))
+				ret = -EOVERFLOW;
+			if (ret == 0)
+				ret = put_compat_flock(&f,
+						(struct compat_flock *)arg);
+		}
+		break;
+
+	case F_GETLK64:
+	case F_SETLK64:
+	case F_SETLKW64:
+		ret = get_compat_flock64(&f, (struct compat_flock64 *)arg);
+		if (ret != 0)
+			break;
+		old_fs = get_fs();
+		set_fs(KERNEL_DS);
+		ret = sys_fcntl(fd, F_GETLK, (unsigned long)&f);
+		ret = sys_fcntl(fd, (cmd == F_GETLK64) ? F_GETLK :
+				((cmd == F_SETLK64) ? F_SETLK : F_SETLKW),
+				(unsigned long)&f);
+		set_fs(old_fs);
+		if ((cmd == F_GETLK64) && (ret == 0)) {
+			if ((f.l_start >= COMPAT_LOFF_T_MAX) ||
+			    ((f.l_start + f.l_len) >= COMPAT_LOFF_T_MAX))
+				ret = -EOVERFLOW;
+			if (ret == 0)
+				ret = put_compat_flock64(&f,
+						(struct compat_flock64 *)arg);
+		}
+		break;
+
+	default:
+		ret = sys_fcntl(fd, cmd, arg);
+		break;
+	}
+	return ret;
+}
+
+asmlinkage long compat_sys_fcntl(unsigned int fd, unsigned int cmd,
+		unsigned long arg)
+{
+	if ((cmd == F_GETLK64) || (cmd == F_SETLK64) || (cmd == F_SETLKW64))
+		return -EINVAL;
+	return compat_sys_fcntl64(fd, cmd, arg);
+}
+
diff -ruN 2.5.63-32bit.1/include/linux/compat.h 2.5.63-32bit.2/include/linux/compat.h
--- 2.5.63-32bit.1/include/linux/compat.h	2003-01-17 14:01:07.000000000 +1100
+++ 2.5.63-32bit.2/include/linux/compat.h	2003-02-25 14:36:00.000000000 +1100
@@ -10,7 +10,6 @@
 
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
-#include <linux/fcntl.h>	/* for struct flock */
 #include <asm/compat.h>
 
 #define compat_jiffies_to_clock_t(x)	\
@@ -40,8 +39,6 @@
 } compat_sigset_t;
 
 extern int cp_compat_stat(struct kstat *, struct compat_stat *);
-extern int get_compat_flock(struct flock *, struct compat_flock *);
-extern int put_compat_flock(struct flock *, struct compat_flock *);
 extern int get_compat_timespec(struct timespec *, struct compat_timespec *);
 extern int put_compat_timespec(struct timespec *, struct compat_timespec *);
 
diff -ruN 2.5.63-32bit.1/include/linux/fs.h 2.5.63-32bit.2/include/linux/fs.h
--- 2.5.63-32bit.1/include/linux/fs.h	2003-02-25 12:59:59.000000000 +1100
+++ 2.5.63-32bit.2/include/linux/fs.h	2003-02-25 14:36:00.000000000 +1100
@@ -525,8 +525,10 @@
 extern int fcntl_getlk(struct file *, struct flock *);
 extern int fcntl_setlk(struct file *, unsigned int, struct flock *);
 
+#if BITS_PER_LONG == 32
 extern int fcntl_getlk64(struct file *, struct flock64 *);
 extern int fcntl_setlk64(struct file *, unsigned int, struct flock64 *);
+#endif
 
 /* fs/locks.c */
 extern void locks_init_lock(struct file_lock *);
