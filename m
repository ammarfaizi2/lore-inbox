Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSFQGv7>; Mon, 17 Jun 2002 02:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSFQGtv>; Mon, 17 Jun 2002 02:49:51 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:6787 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316782AbSFQGs0>;
	Mon, 17 Jun 2002 02:48:26 -0400
Date: Mon, 17 Jun 2002 16:47:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ralf@gnu.org, engebret@us.ibm.com,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@redhat.com,
       ak@suse.de, davidm@hpl.hp.com, anton@samba.org, paulus@samba.org
Subject: [PATCH] Consolidate sys32_utime
Message-Id: <20020617164720.143c4035.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch implements a generic sys32_utime for those architectures
that need it.  The relevant architecture maintainers have seen this
and the only comments caused the creation of the previous patch
(creating compat32.h).

This patch depends on the patch that creates compat32.h.

Please apply.  More to come.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.22-sfr.3/arch/ia64/ia32/sys_ia32.c 2.5.22-sfr.4/arch/ia64/ia32/sys_ia32.c
--- 2.5.22-sfr.3/arch/ia64/ia32/sys_ia32.c	Mon Jun 17 16:09:22 2002
+++ 2.5.22-sfr.4/arch/ia64/ia32/sys_ia32.c	Fri Jun 14 16:56:47 2002
@@ -20,7 +20,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -802,36 +801,7 @@
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 
-struct utimbuf_32 {
-	int	atime;
-	int	mtime;
-};
-
-extern asmlinkage long sys_utimes(char * filename, struct timeval * utimes);
 extern asmlinkage long sys_gettimeofday (struct timeval *tv, struct timezone *tz);
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
 
 extern struct timezone sys_tz;
 extern int do_sys_settimeofday (struct timeval *tv, struct timezone *tz);
diff -ruN 2.5.22-sfr.3/arch/mips64/kernel/linux32.c 2.5.22-sfr.4/arch/mips64/kernel/linux32.c
--- 2.5.22-sfr.3/arch/mips64/kernel/linux32.c	Mon Jun 17 16:10:14 2002
+++ 2.5.22-sfr.4/arch/mips64/kernel/linux32.c	Fri Jun 14 16:57:30 2002
@@ -22,7 +22,6 @@
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/sysctl.h>
-#include <linux/utime.h>
 #include <linux/utsname.h>
 #include <linux/personality.h>
 #include <linux/timex.h>
@@ -115,36 +114,6 @@
 	if ((int)high < 0)
 		return -EINVAL;
 	return sys_ftruncate(fd, ((long) high << 32) | low);
-}
-
-extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
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
 }
 
 #if 0
diff -ruN 2.5.22-sfr.3/arch/ppc64/kernel/sys_ppc32.c 2.5.22-sfr.4/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.22-sfr.3/arch/ppc64/kernel/sys_ppc32.c	Mon Jun 17 16:11:03 2002
+++ 2.5.22-sfr.4/arch/ppc64/kernel/sys_ppc32.c	Fri Jun 14 17:05:46 2002
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -120,41 +119,6 @@
 		}
 	}
 	return result;
-}
-
-
-
-extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
-};
-
-asmlinkage long sys32_utime(char * filename, struct utimbuf32 *times)
-{
-	struct utimbuf t;
-	mm_segment_t old_fs;
-	int ret;
-	char *filenam;
-	
-	PPCDBG(PPCDBG_SYS32NI, "sys32_utime - running - filename=%s, times=%p - pid=%ld, comm=%s \n", filename, times, current->pid, current->comm);
-
-	if (!times)
-		return sys_utime(filename, NULL);
-	if (get_user(t.actime, &times->actime) || __get_user(t.modtime, &times->modtime))
-		return -EFAULT;
-	filenam = getname32(filename);
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
 }
 
 
diff -ruN 2.5.22-sfr.3/arch/s390x/kernel/linux32.c 2.5.22-sfr.4/arch/s390x/kernel/linux32.c
--- 2.5.22-sfr.3/arch/s390x/kernel/linux32.c	Mon Jun 17 16:11:33 2002
+++ 2.5.22-sfr.4/arch/s390x/kernel/linux32.c	Fri Jun 14 16:59:11 2002
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -1010,36 +1009,6 @@
 		return -EINVAL;
 	else
 		return sys_ftruncate(fd, (high << 32) | low);
-}
-
-extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
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
 }
 
 struct iovec32 { u32 iov_base; __kernel_size_t32 iov_len; };
diff -ruN 2.5.22-sfr.3/arch/sparc64/kernel/sys_sparc32.c 2.5.22-sfr.4/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.22-sfr.3/arch/sparc64/kernel/sys_sparc32.c	Mon Jun 17 16:13:02 2002
+++ 2.5.22-sfr.4/arch/sparc64/kernel/sys_sparc32.c	Mon Jun 17 16:38:51 2002
@@ -15,7 +15,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -962,36 +961,6 @@
 		return -EINVAL;
 	else
 		return sys_ftruncate(fd, (high << 32) | low);
-}
-
-extern asmlinkage int sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
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
 }
 
 struct iovec32 { u32 iov_base; __kernel_size_t32 iov_len; };
diff -ruN 2.5.22-sfr.3/arch/x86_64/ia32/sys_ia32.c 2.5.22-sfr.4/arch/x86_64/ia32/sys_ia32.c
--- 2.5.22-sfr.3/arch/x86_64/ia32/sys_ia32.c	Mon Jun 17 16:16:22 2002
+++ 2.5.22-sfr.4/arch/x86_64/ia32/sys_ia32.c	Mon Jun 17 16:39:55 2002
@@ -26,7 +26,6 @@
 #include <linux/fs.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -613,40 +612,8 @@
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 
-struct utimbuf_32 {
-	int	atime;
-	int	mtime;
-};
-
-extern asmlinkage long sys_utimes(char * filename, struct timeval * utimes);
 extern asmlinkage long sys_gettimeofday (struct timeval *tv, struct timezone *tz);
 
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
 
@@ -1746,38 +1713,6 @@
 } 
 
 /* 32-bit timeval and related flotsam.  */
-
-extern asmlinkage long sys_utime(char * filename, struct utimbuf * times);
-
-struct utimbuf32 {
-	__kernel_time_t32 actime, modtime;
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
 
 /*
  * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
diff -ruN 2.5.22-sfr.3/fs/open.c 2.5.22-sfr.4/fs/open.c
--- 2.5.22-sfr.3/fs/open.c	Mon Jun 17 14:09:56 2002
+++ 2.5.22-sfr.4/fs/open.c	Mon Jun 17 16:40:42 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/utime.h>
@@ -316,6 +317,52 @@
 out:
 	return error;
 }
+
+#ifdef CONFIG_32BIT_COMPAT
+
+#include <asm/compat32.h>
+
+/*
+ * 32 bit compatibility version of sys_utime.  We implement this
+ * int terms of sys_utimes since ia64 does not have a sys_utime.
+ */
+struct utimbuf32 {
+	__kernel_time_t32 actime, modtime;
+};
+
+asmlinkage long sys32_utime(char * filename, struct utimbuf32 *times)
+{
+	mm_segment_t old_fs;
+	struct timeval tv[2];
+	struct utimbuf32 ktimes;
+	int ret;
+	char *filenam;
+
+	if (!times)
+		/*
+		 * utime() and utimes() have the same effect if
+		 * their second argument is NULL.
+		 */
+		return sys_utimes(filename, NULL);
+	if (copy_from_user(&ktimes, times, sizeof(*times)))
+		return -EFAULT;
+	tv[0].tv_sec = ktimes.actime;
+	tv[0].tv_usec = 0;
+	tv[1].tv_sec = ktimes.modtime;
+	tv[1].tv_usec = 0;
+	filenam = getname(filename);
+	ret = PTR_ERR(filenam);
+	if (!IS_ERR(filenam)) {
+		old_fs = get_fs();
+		set_fs(KERNEL_DS); 
+		ret = sys_utime(filenam, tv);
+		set_fs(old_fs);
+		putname(filenam);
+	}
+	return ret;
+}
+
+#endif /* CONFIG_32BIT_COMPAT  */
 
 /*
  * access() needs to use the real uid/gid, not the effective uid/gid.
