Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSLME2A>; Thu, 12 Dec 2002 23:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbSLME2A>; Thu, 12 Dec 2002 23:28:00 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:46750 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261317AbSLME15>;
	Thu, 12 Dec 2002 23:27:57 -0500
Date: Fri, 13 Dec 2002 15:34:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: [PATCH][COMPAT] consolidate sys32_new[lf]stat - architecture independent
Message-Id: <20021213153439.1f3e466e.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Another in the COMPAT series.  This build on the previous patches.

This patch renames more types and moves them into asm/compat.h and
also consolidates sys32_new{stat,fstat,lstat}.

Across all the architectures, the diffstat looks like this:
 arch/ia64/ia32/ia32_entry.S       |    6 -
 arch/ia64/ia32/sys_ia32.c         |  131 +++++++++++++-------------------------
 arch/mips64/kernel/linux32.c      |   59 +++--------------
 arch/mips64/kernel/scall_o32.S    |    6 -
 arch/parisc/kernel/ioctl32.c      |   10 +-
 arch/parisc/kernel/sys_parisc32.c |   85 +++---------------------
 arch/ppc64/kernel/ioctl32.c       |    8 +-
 arch/ppc64/kernel/misc.S          |    6 -
 arch/ppc64/kernel/sys_ppc32.c     |   96 +++++++++------------------
 arch/s390x/kernel/entry.S         |    6 -
 arch/s390x/kernel/ioctl32.c       |    5 -
 arch/s390x/kernel/linux32.c       |  107 ++++++++++---------------------
 arch/s390x/kernel/linux32.h       |   37 ----------
 arch/s390x/kernel/wrapper32.S     |   22 +++---
 arch/sparc64/kernel/ioctl32.c     |   10 +-
 arch/sparc64/kernel/sys_sparc32.c |  110 +++++++++++--------------------
 arch/sparc64/kernel/sys_sunos32.c |   16 ++--
 arch/sparc64/kernel/systbls.S     |   12 +--
 arch/x86_64/ia32/ia32_ioctl.c     |   10 +-
 arch/x86_64/ia32/ia32entry.S      |    6 -
 arch/x86_64/ia32/ipc32.c          |   16 ++--
 arch/x86_64/ia32/sys_ia32.c       |   84 ++++--------------------
 fs/Makefile                       |    2 
 fs/compat.c                       |   72 ++++++++++++++++++++
 include/asm-ia64/compat.h         |   32 ++++++++-
 include/asm-ia64/ia32.h           |   36 ----------
 include/asm-mips64/compat.h       |   31 ++++++++
 include/asm-mips64/posix_types.h  |    8 --
 include/asm-mips64/stat.h         |   24 ------
 include/asm-parisc/compat.h       |   39 +++++++++++
 include/asm-parisc/posix_types.h  |    8 --
 include/asm-ppc64/compat.h        |   28 ++++++++
 include/asm-ppc64/ppc32.h         |   46 ++-----------
 include/asm-s390x/compat.h        |   31 ++++++++
 include/asm-sparc64/compat.h      |   28 ++++++++
 include/asm-sparc64/fcntl.h       |    8 +-
 include/asm-sparc64/posix_types.h |    8 --
 include/asm-sparc64/siginfo.h     |    6 -
 include/asm-sparc64/stat.h        |   21 ------
 include/asm-x86_64/compat.h       |   31 ++++++++
 include/asm-x86_64/ia32.h         |   42 +-----------
 include/linux/compat.h            |    3 
 kernel/compat.c                   |   19 -----
 43 files changed, 589 insertions(+), 782 deletions(-)

This is just the architecture independent part of the patch.  I have
built this on PPC64 only.

Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.51-32bit.1/fs/Makefile 2.5.51-32bit.2/fs/Makefile
--- 2.5.51-32bit.1/fs/Makefile	2002-11-28 10:34:54.000000000 +1100
+++ 2.5.51-32bit.2/fs/Makefile	2002-12-12 17:18:35.000000000 +1100
@@ -15,6 +15,8 @@
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
 		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o
 
+obj-$(CONFIG_COMPAT) += compat.o
+
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)
 obj-y += nfsctl.o
diff -ruN 2.5.51-32bit.1/fs/compat.c 2.5.51-32bit.2/fs/compat.c
--- 2.5.51-32bit.1/fs/compat.c	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.51-32bit.2/fs/compat.c	2002-12-13 15:11:15.000000000 +1100
@@ -0,0 +1,72 @@
+/*
+ *  linux/fs/compat.c
+ *
+ *  Kernel compatibililty routines for e.g. 32 bit syscall support
+ *  on 64 bit kernels.
+ *
+ *  Copyright (C) 2002 Stephen Rothwell, IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <linux/compat.h>
+#include <linux/errno.h>
+#include <linux/time.h>
+#include <linux/fs.h>
+
+#include <asm/uaccess.h>
+
+/*
+ * Not all architectures have sys_utime, so implement this in terms
+ * of sys_utimes.
+ */
+asmlinkage long compat_sys_utime(char *filename, struct compat_utimbuf *t)
+{
+	struct timeval tv[2];
+
+	if (t) {
+		if (get_user(tv[0].tv_sec, &t->actime) ||
+		    get_user(tv[1].tv_sec, &t->modtime))
+			return -EFAULT;
+		tv[0].tv_usec = 0;
+		tv[1].tv_usec = 0;
+	}
+	return do_utimes(filename, t ? tv : NULL);
+}
+
+
+asmlinkage long compat_sys_newstat(char * filename,
+		struct compat_stat *statbuf)
+{
+	struct kstat stat;
+	int error = vfs_stat(filename, &stat);
+
+	if (!error)
+		error = cp_compat_stat(&stat, statbuf);
+	return error;
+}
+
+asmlinkage long compat_sys_newlstat(char * filename,
+		struct compat_stat *statbuf)
+{
+	struct kstat stat;
+	int error = vfs_lstat(filename, &stat);
+
+	if (!error)
+		error = cp_compat_stat(&stat, statbuf);
+	return error;
+}
+
+asmlinkage long compat_sys_newfstat(unsigned int fd,
+		struct compat_stat * statbuf)
+{
+	struct kstat stat;
+	int error = vfs_fstat(fd, &stat);
+
+	if (!error)
+		error = cp_compat_stat(&stat, statbuf);
+	return error;
+}
diff -ruN 2.5.51-32bit.1/include/linux/compat.h 2.5.51-32bit.2/include/linux/compat.h
--- 2.5.51-32bit.1/include/linux/compat.h	2002-12-10 17:32:48.000000000 +1100
+++ 2.5.51-32bit.2/include/linux/compat.h	2002-12-13 14:49:21.000000000 +1100
@@ -8,6 +8,7 @@
 
 #ifdef CONFIG_COMPAT
 
+#include <linux/stat.h>
 #include <asm/compat.h>
 
 #define compat_jiffies_to_clock_t(x)	((x) / (HZ / COMPAT_USER_HZ))
@@ -29,5 +30,7 @@
 	compat_clock_t		tms_cstime;
 };
 
+extern int cp_compat_stat(struct kstat *, struct compat_stat *);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff -ruN 2.5.51-32bit.1/kernel/compat.c 2.5.51-32bit.2/kernel/compat.c
--- 2.5.51-32bit.1/kernel/compat.c	2002-12-10 16:45:09.000000000 +1100
+++ 2.5.51-32bit.2/kernel/compat.c	2002-12-12 17:19:15.000000000 +1100
@@ -88,25 +88,6 @@
 	return ret;
 }
 
-/*
- * Not all architectures have sys_utime, so implement this in terms
- * of sys_utimes.
- */
-asmlinkage long compat_sys_utime(char *filename, struct compat_utimbuf *t)
-{
-	struct timeval tv[2];
-
-	if (t) {
-		if (get_user(tv[0].tv_sec, &t->actime) ||
-		    get_user(tv[1].tv_sec, &t->modtime))
-			return -EFAULT;
-		tv[0].tv_usec = 0;
-		tv[1].tv_usec = 0;
-	}
-	return do_utimes(filename, t ? tv : NULL);
-}
-
-
 static inline long get_compat_itimerval(struct itimerval *o,
 		struct compat_itimerval *i)
 {
