Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267401AbTACFdm>; Fri, 3 Jan 2003 00:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267399AbTACFdm>; Fri, 3 Jan 2003 00:33:42 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:39849 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S267398AbTACFdj>;
	Fri, 3 Jan 2003 00:33:39 -0500
Date: Fri, 3 Jan 2003 16:41:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] move struct flock32 1/8 generic
Message-Id: <20030103164106.21e65093.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch moves struct flock32 to struct compat_flock and consolidates
the functions used to copy it to/from user mode.

The overall diffstat looks like this:
 arch/ia64/ia32/sys_ia32.c         |   36 ++----------------------------------
 arch/mips64/kernel/linux32.c      |   37 ++-----------------------------------
 arch/parisc/kernel/sys_parisc32.c |   37 ++-----------------------------------
 arch/ppc64/kernel/sys_ppc32.c     |   28 ++--------------------------
 arch/s390x/kernel/linux32.c       |   30 +++---------------------------
 arch/s390x/kernel/linux32.h       |    9 ---------
 arch/sparc64/kernel/sys_sparc32.c |   28 ++--------------------------
 arch/x86_64/ia32/sys_ia32.c       |   28 ++--------------------------
 fs/compat.c                       |   31 +++++++++++++++++++++++++++++++
 include/asm-ia64/compat.h         |    8 ++++++++
 include/asm-ia64/ia32.h           |    9 ---------
 include/asm-mips64/compat.h       |    9 +++++++++
 include/asm-parisc/compat.h       |    8 ++++++++
 include/asm-ppc64/compat.h        |    9 +++++++++
 include/asm-ppc64/ppc32.h         |    9 ---------
 include/asm-s390x/compat.h        |    9 +++++++++
 include/asm-sparc64/compat.h      |    9 +++++++++
 include/asm-sparc64/fcntl.h       |   13 -------------
 include/asm-x86_64/compat.h       |    8 ++++++++
 include/asm-x86_64/ia32.h         |   10 ----------
 include/linux/compat.h            |    3 +++
 21 files changed, 109 insertions(+), 259 deletions(-)

This is just the generic part.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.54-200301031304-32bit.1/fs/compat.c 2.5.54-200301031304-32bit.2/fs/compat.c
--- 2.5.54-200301031304-32bit.1/fs/compat.c	2002-12-16 14:49:52.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/fs/compat.c	2003-01-03 16:24:56.000000000 +1100
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/fs.h>
+#include <linux/fcntl.h>
 
 #include <asm/uaccess.h>
 
@@ -70,3 +71,33 @@
 		error = cp_compat_stat(&stat, statbuf);
 	return error;
 }
+
+int get_compat_flock(struct flock *kfl, struct compat_flock *ufl)
+{
+	int err;
+
+	if (!access_ok(VERIFY_READ, ufl, sizeof(*ufl)))
+		return -EFAULT;
+
+	err = __get_user(kfl->l_type, &ufl->l_type);
+	err |= __get_user(kfl->l_whence, &ufl->l_whence);
+	err |= __get_user(kfl->l_start, &ufl->l_start);
+	err |= __get_user(kfl->l_len, &ufl->l_len);
+	err |= __get_user(kfl->l_pid, &ufl->l_pid);
+	return err;
+}
+
+int put_compat_flock(struct flock *kfl, struct compat_flock *ufl)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, ufl, sizeof(*ufl)))
+		return -EFAULT;
+
+	err = __put_user(kfl->l_type, &ufl->l_type);
+	err |= __put_user(kfl->l_whence, &ufl->l_whence);
+	err |= __put_user(kfl->l_start, &ufl->l_start);
+	err |= __put_user(kfl->l_len, &ufl->l_len);
+	err |= __put_user(kfl->l_pid, &ufl->l_pid);
+	return err;
+}
diff -ruN 2.5.54-200301031304-32bit.1/include/linux/compat.h 2.5.54-200301031304-32bit.2/include/linux/compat.h
--- 2.5.54-200301031304-32bit.1/include/linux/compat.h	2003-01-03 14:08:45.000000000 +1100
+++ 2.5.54-200301031304-32bit.2/include/linux/compat.h	2003-01-03 16:25:50.000000000 +1100
@@ -10,6 +10,7 @@
 
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
+#include <linux/fcntl.h>	/* for struct flock */
 #include <asm/compat.h>
 
 #define compat_jiffies_to_clock_t(x)	\
@@ -33,6 +34,8 @@
 };
 
 extern int cp_compat_stat(struct kstat *, struct compat_stat *);
+extern int get_compat_flock(struct flock *, struct compat_flock *);
+extern int put_compat_flock(struct flock *, struct compat_flock *);
 
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
