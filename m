Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269163AbTCDFsw>; Tue, 4 Mar 2003 00:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269165AbTCDFsw>; Tue, 4 Mar 2003 00:48:52 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:49804 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S269163AbTCDFss>;
	Tue, 4 Mar 2003 00:48:48 -0500
Date: Tue, 4 Mar 2003 16:58:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] compat_sys_fcntl{,64} 1/9 Generic part
Message-Id: <20030304165812.7141f7c0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch creates compat_sys_fcntl{,64}.  The diffstat for the whole
patch set is below, but this is just the generic part, the architecture
specific parts will follow.

This patch also removes struct flock64 from all the 64 bit architectures
(except parisc).

I think I have answered all the questions from the last time I posted
this, so please apply.

 arch/ia64/ia32/ia32_entry.S       |    4 -
 arch/ia64/ia32/sys_ia32.c         |   92 -----------------------
 arch/mips64/kernel/linux32.c      |   44 -----------
 arch/mips64/kernel/scall_o32.S    |    4 -
 arch/parisc/kernel/sys_parisc32.c |   51 -------------
 arch/parisc/kernel/syscall.S      |    5 -
 arch/ppc64/kernel/misc.S          |    4 -
 arch/ppc64/kernel/sys_ppc32.c     |   33 --------
 arch/s390x/kernel/entry.S         |    4 -
 arch/s390x/kernel/linux32.c       |   51 -------------
 arch/s390x/kernel/linux32.h       |    4 -
 arch/s390x/kernel/wrapper32.S     |   12 +--
 arch/sparc64/kernel/sys_sparc32.c |   35 ---------
 arch/sparc64/kernel/systbls.S     |    6 -
 arch/x86_64/ia32/ia32entry.S      |    4 -
 arch/x86_64/ia32/sys_ia32.c       |   96 ------------------------
 fs/compat.c                       |  147 ++++++++++++++++++++++++++++++--------
 include/asm-alpha/fcntl.h         |    3
 include/asm-ia64/compat.h         |   19 ++++
 include/asm-ia64/fcntl.h          |    5 -
 include/asm-ia64/ia32.h           |    4 -
 include/asm-mips64/compat.h       |   18 ++++
 include/asm-mips64/fcntl.h        |   10 --
 include/asm-parisc/compat.h       |   11 ++
 include/asm-ppc64/compat.h        |   16 +++-
 include/asm-ppc64/fcntl.h         |   13 ---
 include/asm-s390x/compat.h        |   16 +++-
 include/asm-s390x/fcntl.h         |    2
 include/asm-sparc64/compat.h      |   16 ++++
 include/asm-sparc64/fcntl.h       |   11 --
 include/asm-x86_64/compat.h       |   18 ++++
 include/asm-x86_64/fcntl.h        |    4 -
 include/asm-x86_64/ia32.h         |   12 ---
 include/linux/compat.h            |    3
 include/linux/fs.h                |    2
 35 files changed, 254 insertions(+), 525 deletions(-)


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
