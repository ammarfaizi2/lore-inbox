Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbSLDG4c>; Wed, 4 Dec 2002 01:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbSLDG4c>; Wed, 4 Dec 2002 01:56:32 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:59780 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266938AbSLDG42>;
	Wed, 4 Dec 2002 01:56:28 -0500
Date: Wed, 4 Dec 2002 18:02:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: [PATCH] compatibility syscall layer (lets try again)
Message-Id: <20021204180224.406d143c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Below is the generic part of the start of the compatibility syscall layer.
I think I have made it generic enough that each architecture can define
what compatibility means.

To use this,an architecture must create asm/compat.h and provide typedefs
for (currently) compat_time_t, compat_suseconds_t, struct compat_timespec.

Hopefully, this is what you had in mind - ohterwise back to the drawing
board.

I will follow this posting with the architecture specific patches that I
have done but not tested.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-BK.2/fs/open.c 2.5.50-BK.2-32bit.1/fs/open.c
--- 2.5.50-BK.2/fs/open.c	2002-12-04 12:07:36.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/fs/open.c	2002-12-04 12:01:36.000000000 +1100
@@ -280,7 +280,7 @@
  * must be owner or have write permission.
  * Else, update from *times, must be owner or super user.
  */
-asmlinkage long sys_utimes(char * filename, struct timeval * utimes)
+long do_utimes(char * filename, struct timeval * times)
 {
 	int error;
 	struct nameidata nd;
@@ -299,11 +299,7 @@
 
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
-	if (utimes) {
-		struct timeval times[2];
-		error = -EFAULT;
-		if (copy_from_user(&times, utimes, sizeof(times)))
-			goto dput_and_out;
+	if (times) {
 		newattrs.ia_atime.tv_sec = times[0].tv_sec;
 		newattrs.ia_atime.tv_nsec = times[0].tv_usec * 1000;
 		newattrs.ia_mtime.tv_sec = times[1].tv_sec;
@@ -323,6 +319,16 @@
 	return error;
 }
 
+asmlinkage long sys_utimes(char * filename, struct timeval * utimes)
+{
+	struct timeval times[2];
+
+	if (utimes && copy_from_user(&times, utimes, sizeof(times)))
+		return -EFAULT;
+	return do_utimes(filename, utimes ? times : NULL);
+}
+
+
 /*
  * access() needs to use the real uid/gid, not the effective uid/gid.
  * We do this by temporarily clearing all FS-related capabilities and
diff -ruN 2.5.50-BK.2/include/linux/compat.h 2.5.50-BK.2-32bit.1/include/linux/compat.h
--- 2.5.50-BK.2/include/linux/compat.h	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/include/linux/compat.h	2002-12-04 15:42:36.000000000 +1100
@@ -0,0 +1,29 @@
+#ifndef _LINUX_COMPAT_H
+#define _LINUX_COMPAT_H
+/*
+ * These are the type definitions for the arhitecure sepcific
+ * compatibility layer.
+ */
+#include <linux/config.h>
+
+#ifdef CONFIG_COMPAT
+
+#include <asm/compat.h>
+
+struct compat_timeval {
+	compat_time_t		tv_sec;
+	compat_suseconds_t	tv_usec;
+};
+
+struct compat_utimbuf {
+	compat_time_t		actime;
+	compat_time_t		modtime;
+};
+
+struct compat_itimerval {
+	struct compat_timeval	it_interval;
+	struct compat_timeval	it_value;
+};
+
+#endif /* CONFIG_COMPAT */
+#endif /* _LINUX_COMPAT_H */
diff -ruN 2.5.50-BK.2/include/linux/time.h 2.5.50-BK.2-32bit.1/include/linux/time.h
--- 2.5.50-BK.2/include/linux/time.h	2002-11-18 15:47:56.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/include/linux/time.h	2002-12-03 15:47:26.000000000 +1100
@@ -138,6 +138,8 @@
 #ifdef __KERNEL__
 extern void do_gettimeofday(struct timeval *tv);
 extern void do_settimeofday(struct timeval *tv);
+extern long do_nanosleep(struct timespec *t);
+extern long do_utimes(char * filename, struct timeval * times);
 #endif
 
 #define FD_SETSIZE		__FD_SETSIZE
diff -ruN 2.5.50-BK.2/kernel/Makefile 2.5.50-BK.2-32bit.1/kernel/Makefile
--- 2.5.50-BK.2/kernel/Makefile	2002-11-28 10:34:59.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/kernel/Makefile	2002-12-03 15:42:28.000000000 +1100
@@ -21,6 +21,7 @@
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_COMPAT) += compat.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -ruN 2.5.50-BK.2/kernel/compat.c 2.5.50-BK.2-32bit.1/kernel/compat.c
--- 2.5.50-BK.2/kernel/compat.c	1970-01-01 10:00:00.000000000 +1000
+++ 2.5.50-BK.2-32bit.1/kernel/compat.c	2002-12-04 17:40:08.000000000 +1100
@@ -0,0 +1,114 @@
+/*
+ *  linux/kernel/compat.c
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
+
+#include <asm/uaccess.h>
+
+asmlinkage long compat_sys_nanosleep(struct compat_timespec *rqtp,
+		struct compat_timespec *rmtp)
+{
+	struct timespec t;
+	struct compat_timespec ct;
+	s32 ret;
+
+	if (copy_from_user(&ct, rqtp, sizeof(ct)))
+		return -EFAULT;
+	t.tv_sec = ct.tv_sec;
+	t.tv_nsec = ct.tv_nsec;
+	ret = do_nanosleep(&t);
+	if (rmtp && (ret == -EINTR)) {
+		ct.tv_sec = t.tv_sec;
+		ct.tv_nsec = t.tv_nsec;
+		if (copy_to_user(rmtp, &ct, sizeof(ct)))
+			return -EFAULT;
+	}
+	return ret;
+}
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
+static inline long get_compat_itimerval(struct itimerval *o,
+		struct compat_itimerval *i)
+{
+	return (!access_ok(VERIFY_READ, i, sizeof(*i)) ||
+		(__get_user(o->it_interval.tv_sec, &i->it_interval.tv_sec) |
+		 __get_user(o->it_interval.tv_usec, &i->it_interval.tv_usec) |
+		 __get_user(o->it_value.tv_sec, &i->it_value.tv_sec) |
+		 __get_user(o->it_value.tv_usec, &i->it_value.tv_usec)));
+}
+
+static inline long put_compat_itimerval(struct compat_itimerval *o,
+		struct itimerval *i)
+{
+	return (!access_ok(VERIFY_WRITE, o, sizeof(*o)) ||
+		(__put_user(i->it_interval.tv_sec, &o->it_interval.tv_sec) |
+		 __put_user(i->it_interval.tv_usec, &o->it_interval.tv_usec) |
+		 __put_user(i->it_value.tv_sec, &o->it_value.tv_sec) |
+		 __put_user(i->it_value.tv_usec, &o->it_value.tv_usec)));
+}
+
+extern int do_getitimer(int which, struct itimerval *value);
+
+asmlinkage long compat_sys_getitimer(int which, struct compat_itimerval *it)
+{
+	struct itimerval kit;
+	int error;
+
+	error = do_getitimer(which, &kit);
+	if (!error && put_compat_itimerval(it, &kit))
+		error = -EFAULT;
+	return error;
+}
+
+extern int do_setitimer(int which, struct itimerval *, struct itimerval *);
+
+asmlinkage long compat_sys_setitimer(int which, struct compat_itimerval *in,
+		struct compat_itimerval *out)
+{
+	struct itimerval kin, kout;
+	int error;
+
+	if (in) {
+		if (get_compat_itimerval(&kin, in))
+			return -EFAULT;
+	} else
+		memset(&kin, 0, sizeof(kin));
+
+	error = do_setitimer(which, &kin, out ? &kout : NULL);
+	if (error || !out)
+		return error;
+	if (put_compat_itimerval(out, &kout))
+		return -EFAULT;
+	return 0;
+}
diff -ruN 2.5.50-BK.2/kernel/timer.c 2.5.50-BK.2-32bit.1/kernel/timer.c
--- 2.5.50-BK.2/kernel/timer.c	2002-12-04 12:07:39.000000000 +1100
+++ 2.5.50-BK.2-32bit.1/kernel/timer.c	2002-12-04 12:03:23.000000000 +1100
@@ -1020,33 +1020,41 @@
 	return current->pid;
 }
 
-asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+long do_nanosleep(struct timespec *t)
 {
-	struct timespec t;
 	unsigned long expire;
 
-	if(copy_from_user(&t, rqtp, sizeof(struct timespec)))
-		return -EFAULT;
-
-	if (t.tv_nsec >= 1000000000L || t.tv_nsec < 0 || t.tv_sec < 0)
+	if ((t->tv_nsec >= 1000000000L) || (t->tv_nsec < 0) || (t->tv_sec < 0))
 		return -EINVAL;
 
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
+	expire = timespec_to_jiffies(t) + (t->tv_sec || t->tv_nsec);
 
 	current->state = TASK_INTERRUPTIBLE;
 	expire = schedule_timeout(expire);
 
 	if (expire) {
-		if (rmtp) {
-			jiffies_to_timespec(expire, &t);
-			if (copy_to_user(rmtp, &t, sizeof(struct timespec)))
-				return -EFAULT;
-		}
+		jiffies_to_timespec(expire, t);
 		return -EINTR;
 	}
 	return 0;
 }
 
+asmlinkage long sys_nanosleep(struct timespec *rqtp, struct timespec *rmtp)
+{
+	struct timespec t;
+	long ret;
+
+	if (copy_from_user(&t, rqtp, sizeof(t)))
+		return -EFAULT;
+
+	ret = do_nanosleep(&t);
+	if (rmtp && (ret == -EINTR)) {
+		if (copy_to_user(rmtp, &t, sizeof(t)))
+			return -EFAULT;
+	}
+	return ret;
+}
+
 /*
  * sys_sysinfo - fill in sysinfo struct
  */ 
