Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266958AbSK2Eqr>; Thu, 28 Nov 2002 23:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbSK2Eqr>; Thu, 28 Nov 2002 23:46:47 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:60900 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266958AbSK2Eqj>;
	Thu, 28 Nov 2002 23:46:39 -0500
Date: Fri, 29 Nov 2002 15:52:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org,
       willy@debian.org
Subject: [PATCH] 32 bit consolidation 2/Many
Message-Id: <20021129155257.69a4bc13.sfr@canb.auug.org.au>
In-Reply-To: <20021129154507.7ef85bac.sfr@canb.auug.org.au>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0211270913480.7657-100000@home.transmeta.com>
	<20021127.213148.94755458.davem@redhat.com>
	<20021129154507.7ef85bac.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch build on the previous patch and consolidates sys32_utime.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.50-32bit.1/arch/ia64/ia32/sys_ia32.c 2.5.50-32bit.2/arch/ia64/ia32/sys_ia32.c
--- 2.5.50-32bit.1/arch/ia64/ia32/sys_ia32.c	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/arch/ia64/ia32/sys_ia32.c	2002-11-29 15:13:13.000000000 +1100
@@ -20,7 +20,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -803,37 +802,6 @@
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 
-struct utimbuf_32 {
-	int	atime;
-	int	mtime;
-};
-
-extern asmlinkage long sys_utimes(char * filename, struct timeval * utimes);
-extern asmlinkage long sys_gettimeofday (struct timeval *tv, struct timezone *tz);
-
-asmlinkage long
-sys32_utime (char *filename, struct utimbuf_32 *times32)
-{
-	mm_segment_t old_fs = get_fs();
-	struct timeval tv[2], *tvp;
-	long ret;
-
-	if (times32) {
-		if (get_user(tv[0].tv_sec, &times32->atime))
-			return -EFAULT;
-		tv[0].tv_usec = 0;
-		if (get_user(tv[1].tv_sec, &times32->mtime))
-			return -EFAULT;
-		tv[1].tv_usec = 0;
-		set_fs(KERNEL_DS);
-		tvp = tv;
-	} else
-		tvp = NULL;
-	ret = sys_utimes(filename, tvp);
-	set_fs(old_fs);
-	return ret;
-}
-
 extern struct timezone sys_tz;
 extern int do_sys_settimeofday (struct timeval *tv, struct timezone *tz);
 
diff -ruN 2.5.50-32bit.1/arch/mips64/kernel/linux32.c 2.5.50-32bit.2/arch/mips64/kernel/linux32.c
--- 2.5.50-32bit.1/arch/mips64/kernel/linux32.c	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/arch/mips64/kernel/linux32.c	2002-11-29 15:13:13.000000000 +1100
@@ -22,7 +22,6 @@
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/sysctl.h>
-#include <linux/utime.h>
 #include <linux/utsname.h>
 #include <linux/personality.h>
 #include <linux/timex.h>
@@ -117,36 +116,6 @@
 	return sys_ftruncate(fd, ((long) high << 32) | low);
 }
 
-extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	compat32_time_t actime, modtime;
-};
-
-asmlinkage int sys32_utime(char * filename, struct utimbuf32 *times)
-{
-	struct utimbuf t;
-	mm_segment_t old_fs;
-	int ret;
-	char *filenam;
-	
-	if (!times)
-		return sys_utime(filename, NULL);
-	if (get_user (t.actime, &times->actime) ||
-	    __get_user (t.modtime, &times->modtime))
-		return -EFAULT;
-	filenam = getname (filename);
-	ret = PTR_ERR(filenam);
-	if (!IS_ERR(filenam)) {
-		old_fs = get_fs();
-		set_fs (KERNEL_DS); 
-		ret = sys_utime(filenam, &t);
-		set_fs (old_fs);
-		putname (filenam);
-	}
-	return ret;
-}
-
 #if 0
 /*
  * count32() counts the number of arguments/envelopes
diff -ruN 2.5.50-32bit.1/arch/parisc/kernel/sys_parisc32.c 2.5.50-32bit.2/arch/parisc/kernel/sys_parisc32.c
--- 2.5.50-32bit.1/arch/parisc/kernel/sys_parisc32.c	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/arch/parisc/kernel/sys_parisc32.c	2002-11-29 15:13:13.000000000 +1100
@@ -16,7 +16,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -387,42 +386,6 @@
  * code available in case it's useful to others. -PB
  */
 
-/* from utime.h */
-struct utimbuf32 {
-	compat32_time_t actime;
-	compat32_time_t modtime;
-};
-
-asmlinkage long sys32_utime(char *filename, struct utimbuf32 *times)
-{
-    struct utimbuf32 times32;
-    struct utimbuf times64;
-    extern long sys_utime(char *filename, struct utimbuf *times);
-    char *fname;
-    long ret;
-
-    if (!times)
-    	return sys_utime(filename, NULL);
-
-    /* get the 32-bit struct from user space */
-    if (copy_from_user(&times32, times, sizeof times32))
-    	return -EFAULT;
-
-    /* convert it into the 64-bit one */
-    times64.actime = times32.actime;
-    times64.modtime = times32.modtime;
-
-    /* grab the file name */
-    fname = getname(filename);
-
-    KERNEL_SYSCALL(ret, sys_utime, fname, &times64);
-
-    /* free the file name */
-    putname(fname);
-
-    return ret;
-}
-
 struct tms32 {
 	__kernel_clock_t32 tms_utime;
 	__kernel_clock_t32 tms_stime;
diff -ruN 2.5.50-32bit.1/arch/ppc64/kernel/sys_ppc32.c 2.5.50-32bit.2/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.50-32bit.1/arch/ppc64/kernel/sys_ppc32.c	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/arch/ppc64/kernel/sys_ppc32.c	2002-11-29 15:13:13.000000000 +1100
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -70,39 +69,6 @@
 #include <asm/ppc32.h>
 #include <asm/mmu_context.h>
 
-extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	compat32_time_t actime, modtime;
-};
-
-asmlinkage long sys32_utime(char * filename, struct utimbuf32 *times)
-{
-	struct utimbuf t;
-	mm_segment_t old_fs;
-	int ret;
-	char *filenam;
-	
-	if (!times)
-		return sys_utime(filename, NULL);
-	if (get_user(t.actime, &times->actime) || __get_user(t.modtime, &times->modtime))
-		return -EFAULT;
-	filenam = getname(filename);
-
-	ret = PTR_ERR(filenam);
-	if (!IS_ERR(filenam)) {
-		old_fs = get_fs();
-		set_fs (KERNEL_DS); 
-		ret = sys_utime(filenam, &t);
-		set_fs (old_fs);
-		putname (filenam);
-	}
-
-	return ret;
-}
-
-
-
 struct iovec32 { u32 iov_base; __kernel_size_t32 iov_len; };
 
 typedef ssize_t (*IO_fn_t)(struct file *, char *, size_t, loff_t *);
diff -ruN 2.5.50-32bit.1/arch/s390x/kernel/linux32.c 2.5.50-32bit.2/arch/s390x/kernel/linux32.c
--- 2.5.50-32bit.1/arch/s390x/kernel/linux32.c	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/arch/s390x/kernel/linux32.c	2002-11-29 15:13:13.000000000 +1100
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -1011,36 +1010,6 @@
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	compat32_time_t actime, modtime;
-};
-
-asmlinkage int sys32_utime(char * filename, struct utimbuf32 *times)
-{
-	struct utimbuf t;
-	mm_segment_t old_fs;
-	int ret;
-	char *filenam;
-	
-	if (!times)
-		return sys_utime(filename, NULL);
-	if (get_user (t.actime, &times->actime) ||
-	    __get_user (t.modtime, &times->modtime))
-		return -EFAULT;
-	filenam = getname (filename);
-	ret = PTR_ERR(filenam);
-	if (!IS_ERR(filenam)) {
-		old_fs = get_fs();
-		set_fs (KERNEL_DS); 
-		ret = sys_utime(filenam, &t);
-		set_fs (old_fs);
-		putname (filenam);
-	}
-	return ret;
-}
-
 struct iovec32 { u32 iov_base; __kernel_size_t32 iov_len; };
 
 typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
diff -ruN 2.5.50-32bit.1/arch/s390x/kernel/wrapper32.S 2.5.50-32bit.2/arch/s390x/kernel/wrapper32.S
--- 2.5.50-32bit.1/arch/s390x/kernel/wrapper32.S	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/arch/s390x/kernel/wrapper32.S	2002-11-29 15:13:13.000000000 +1100
@@ -133,7 +133,7 @@
 	.globl  sys32_utime_wrapper 
 sys32_utime_wrapper:
 	llgtr	%r2,%r2			# char *
-	llgtr	%r3,%r3			# struct utimbuf_emu31 *
+	llgtr	%r3,%r3			# struct utimbuf32 *
 	jg	sys32_utime		# branch to system call
 
 	.globl  sys32_access_wrapper 
diff -ruN 2.5.50-32bit.1/arch/sparc64/kernel/sys_sparc32.c 2.5.50-32bit.2/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.50-32bit.1/arch/sparc64/kernel/sys_sparc32.c	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/arch/sparc64/kernel/sys_sparc32.c	2002-11-29 15:13:13.000000000 +1100
@@ -15,7 +15,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -965,36 +964,6 @@
 		return sys_ftruncate(fd, (high << 32) | low);
 }
 
-extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	compat32_time_t actime, modtime;
-};
-
-asmlinkage int sys32_utime(char * filename, struct utimbuf32 *times)
-{
-	struct utimbuf t;
-	mm_segment_t old_fs;
-	int ret;
-	char *filenam;
-	
-	if (!times)
-		return sys_utime(filename, NULL);
-	if (get_user (t.actime, &times->actime) ||
-	    __get_user (t.modtime, &times->modtime))
-		return -EFAULT;
-	filenam = getname (filename);
-	ret = PTR_ERR(filenam);
-	if (!IS_ERR(filenam)) {
-		old_fs = get_fs();
-		set_fs (KERNEL_DS); 
-		ret = sys_utime(filenam, &t);
-		set_fs (old_fs);
-		putname (filenam);
-	}
-	return ret;
-}
-
 struct iovec32 { u32 iov_base; __kernel_size_t32 iov_len; };
 
 typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
diff -ruN 2.5.50-32bit.1/arch/x86_64/ia32/sys_ia32.c 2.5.50-32bit.2/arch/x86_64/ia32/sys_ia32.c
--- 2.5.50-32bit.1/arch/x86_64/ia32/sys_ia32.c	2002-11-29 13:16:25.000000000 +1100
+++ 2.5.50-32bit.2/arch/x86_64/ia32/sys_ia32.c	2002-11-29 15:13:13.000000000 +1100
@@ -26,7 +26,6 @@
 #include <linux/fs.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -617,40 +616,6 @@
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 
-struct utimbuf_32 {
-	int	atime;
-	int	mtime;
-};
-
-extern asmlinkage long sys_utimes(char * filename, struct timeval * utimes);
-extern asmlinkage long sys_gettimeofday (struct timeval *tv, struct timezone *tz);
-
-asmlinkage long
-ia32_utime(char * filename, struct utimbuf_32 *times32)
-{
-	mm_segment_t old_fs = get_fs();
-	struct timeval tv[2];
-	long ret;
-
-	if (times32) {
-		get_user(tv[0].tv_sec, &times32->atime);
-		tv[0].tv_usec = 0;
-		get_user(tv[1].tv_sec, &times32->mtime);
-		tv[1].tv_usec = 0;
-		set_fs (KERNEL_DS);
-	} else {
-		set_fs (KERNEL_DS);
-		ret = sys_gettimeofday(&tv[0], 0);
-		if (ret < 0)
-			goto out;
-		tv[1] = tv[0];
-	}
-	ret = sys_utimes(filename, tv);
-  out:
-	set_fs (old_fs);
-	return ret;
-}
-
 extern struct timezone sys_tz;
 extern int do_sys_settimeofday(struct timeval *tv, struct timezone *tz);
 
@@ -1377,38 +1342,6 @@
 
 /* 32-bit timeval and related flotsam.  */
 
-extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	compat32_time_t actime, modtime;
-};
-
-asmlinkage long
-sys32_utime(char * filename, struct utimbuf32 *times)
-{
-	struct utimbuf t;
-	mm_segment_t old_fs;
-	int ret;
-	char *filenam;
-	
-	if (!times)
-		return sys_utime(filename, NULL);
-	if (verify_area(VERIFY_READ, times, sizeof(struct utimbuf32)) ||
-	    __get_user (t.actime, &times->actime) ||
-	    __get_user (t.modtime, &times->modtime))
-		return -EFAULT;
-	filenam = getname (filename);
-	ret = PTR_ERR(filenam);
-	if (!IS_ERR(filenam)) {
-		old_fs = get_fs();
-		set_fs (KERNEL_DS); 
-		ret = sys_utime(filenam, &t);
-		set_fs (old_fs);
-		putname(filenam);
-	}
-	return ret;
-}
-
 extern asmlinkage long sys_sysfs(int option, unsigned long arg1,
 				unsigned long arg2);
 
diff -ruN 2.5.50-32bit.1/fs/open.c 2.5.50-32bit.2/fs/open.c
--- 2.5.50-32bit.1/fs/open.c	2002-11-28 10:35:47.000000000 +1100
+++ 2.5.50-32bit.2/fs/open.c	2002-11-29 15:16:27.000000000 +1100
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/utime.h>
@@ -18,6 +19,7 @@
 #include <linux/backing-dev.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/compat32.h>
 
 #include <asm/uaccess.h>
 
@@ -279,7 +281,7 @@
  * must be owner or have write permission.
  * Else, update from *times, must be owner or super user.
  */
-asmlinkage long sys_utimes(char * filename, struct timeval * utimes)
+static long do_utimes(char * filename, struct timeval * times)
 {
 	int error;
 	struct nameidata nd;
@@ -298,11 +300,7 @@
 
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
@@ -322,6 +320,37 @@
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
+#ifdef CONFIG_COMPAT32
+/*
+ * Not all architectures have sys_utime, so implement this in terms
+ * of sys_utimes.
+ */
+extern long do_utimes(char * filename, struct timeval *utimes);
+
+asmlinkage long sys32_utime(char *filename, struct utimbuf32 *t)
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
+#endif
+
 /*
  * access() needs to use the real uid/gid, not the effective uid/gid.
  * We do this by temporarily clearing all FS-related capabilities and
diff -ruN 2.5.50-32bit.1/include/linux/compat32.h 2.5.50-32bit.2/include/linux/compat32.h
--- 2.5.50-32bit.1/include/linux/compat32.h	2002-11-29 13:29:44.000000000 +1100
+++ 2.5.50-32bit.2/include/linux/compat32.h	2002-11-29 15:14:38.000000000 +1100
@@ -16,5 +16,10 @@
 	s32		tv_nsec;
 };
 
+struct utimbuf32 {
+	compat32_time_t actime;
+	compat32_time_t	modtime;
+};
+
 #endif /* CONFIG_COMPAT32 */
 #endif /* _LINUX_COMPAT32_H */
