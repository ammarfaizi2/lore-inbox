Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317881AbSFNDuw>; Thu, 13 Jun 2002 23:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317880AbSFNDuv>; Thu, 13 Jun 2002 23:50:51 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:63715 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317878AbSFNDus>;
	Thu, 13 Jun 2002 23:50:48 -0400
Date: Fri, 14 Jun 2002 13:50:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Consolidate sys32_utime
Message-Id: <20020614135014.236fb9ac.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following patch removes the architecture specific versions of
the utime() system call for 32 bit emulation and adds a generic
version in fs/open.c.  Comments, please.

This is the first in (hopefully) a long list of these sort of
patches.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.21/arch/mips64/config.in 2.5.21-sfr.3/arch/mips64/config.in
--- 2.5.21/arch/mips64/config.in	Tue Apr 23 10:42:12 2002
+++ 2.5.21-sfr.3/arch/mips64/config.in	Thu Jun 13 02:30:49 2002
@@ -115,6 +115,7 @@
 tristate 'Kernel support for 64-bit ELF binaries' CONFIG_BINFMT_ELF
 bool 'Kernel support for Linux/MIPS 32-bit binary compatibility' CONFIG_MIPS32_COMPAT
 if [ "$CONFIG_MIPS32_COMPAT" = "y" ]; then
+   define_bool CONFIG_32BIT_SUPPORT y
    define_bool CONFIG_BINFMT_ELF32 y
 fi
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
diff -ruN 2.5.21/arch/mips64/kernel/linux32.c 2.5.21-sfr.3/arch/mips64/kernel/linux32.c
--- 2.5.21/arch/mips64/kernel/linux32.c	Wed Feb 20 16:36:37 2002
+++ 2.5.21-sfr.3/arch/mips64/kernel/linux32.c	Thu Jun 13 02:32:11 2002
@@ -22,7 +22,6 @@
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/sysctl.h>
-#include <linux/utime.h>
 #include <linux/utsname.h>
 #include <linux/personality.h>
 #include <linux/timex.h>
@@ -114,36 +113,6 @@
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
diff -ruN 2.5.21/arch/ppc64/config.in 2.5.21-sfr.3/arch/ppc64/config.in
--- 2.5.21/arch/ppc64/config.in	Mon Jun  3 12:16:58 2002
+++ 2.5.21-sfr.3/arch/ppc64/config.in	Wed Jun 12 17:39:34 2002
@@ -7,6 +7,7 @@
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 define_bool CONFIG_GENERIC_ISA_DMA y
 define_bool CONFIG_HAVE_DEC_LOCK y
+define_bool CONFIG_32BIT_SUPPORT y
 
 source init/Config.in
 
diff -ruN 2.5.21/arch/ppc64/kernel/sys_ppc32.c 2.5.21-sfr.3/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.21/arch/ppc64/kernel/sys_ppc32.c	Mon Jun  3 12:16:59 2002
+++ 2.5.21-sfr.3/arch/ppc64/kernel/sys_ppc32.c	Wed Jun 12 17:25:38 2002
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -119,41 +118,6 @@
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
 
 
diff -ruN 2.5.21/arch/s390x/config.in 2.5.21-sfr.3/arch/s390x/config.in
--- 2.5.21/arch/s390x/config.in	Mon Jun 10 23:13:43 2002
+++ 2.5.21-sfr.3/arch/s390x/config.in	Thu Jun 13 02:34:10 2002
@@ -21,6 +21,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Kernel support for 31 bit emulation' CONFIG_S390_SUPPORT
 if [ "$CONFIG_S390_SUPPORT" = "y" ]; then
+  define_boot CONFIG_32BIT_SUPPORT y
   tristate 'Kernel support for 31 bit ELF binaries' CONFIG_BINFMT_ELF32 
 fi
 endmenu
diff -ruN 2.5.21/arch/s390x/kernel/linux32.c 2.5.21-sfr.3/arch/s390x/kernel/linux32.c
--- 2.5.21/arch/s390x/kernel/linux32.c	Mon Jun 10 23:13:43 2002
+++ 2.5.21-sfr.3/arch/s390x/kernel/linux32.c	Thu Jun 13 02:34:55 2002
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -1009,36 +1008,6 @@
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
diff -ruN 2.5.21/arch/sparc64/config.in 2.5.21-sfr.3/arch/sparc64/config.in
--- 2.5.21/arch/sparc64/config.in	Mon May  6 13:52:43 2002
+++ 2.5.21-sfr.3/arch/sparc64/config.in	Thu Jun 13 02:27:21 2002
@@ -54,6 +54,7 @@
 fi
 bool 'Kernel support for Linux/Sparc 32bit binary compatibility' CONFIG_SPARC32_COMPAT
 if [ "$CONFIG_SPARC32_COMPAT" != "n" ]; then
+   define_bool CONFIG_32BIT_SUPPORT y
    tristate '  Kernel support for 32-bit ELF binaries' CONFIG_BINFMT_ELF32
    bool '  Kernel support for 32-bit (ie. SunOS) a.out binaries' CONFIG_BINFMT_AOUT32
 fi
diff -ruN 2.5.21/arch/sparc64/kernel/sys_sparc32.c 2.5.21-sfr.3/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.21/arch/sparc64/kernel/sys_sparc32.c	Mon Jun 10 23:13:44 2002
+++ 2.5.21-sfr.3/arch/sparc64/kernel/sys_sparc32.c	Wed Jun 12 17:35:22 2002
@@ -15,7 +15,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -961,36 +960,6 @@
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
diff -ruN 2.5.21/arch/x86_64/config.in 2.5.21-sfr.3/arch/x86_64/config.in
--- 2.5.21/arch/x86_64/config.in	Mon May  6 13:52:43 2002
+++ 2.5.21-sfr.3/arch/x86_64/config.in	Thu Jun 13 12:03:49 2002
@@ -87,6 +87,9 @@
 bool 'Power Management support' CONFIG_PM
 
 bool 'IA32 Emulation' CONFIG_IA32_EMULATION
+if [ "$CONFIG_IA32_EMULATION" = "y" ]; then
+   define_bool CONFIG_32BIT_SUPPORT y
+fi
 
 endmenu
 
diff -ruN 2.5.21/arch/x86_64/ia32/sys_ia32.c 2.5.21-sfr.3/arch/x86_64/ia32/sys_ia32.c
--- 2.5.21/arch/x86_64/ia32/sys_ia32.c	Sat May 18 22:59:44 2002
+++ 2.5.21-sfr.3/arch/x86_64/ia32/sys_ia32.c	Thu Jun 13 02:40:44 2002
@@ -26,7 +26,6 @@
 #include <linux/fs.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -1745,38 +1744,6 @@
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
diff -ruN 2.5.21/fs/open.c 2.5.21-sfr.3/fs/open.c
--- 2.5.21/fs/open.c	Mon Jun 10 23:13:50 2002
+++ 2.5.21-sfr.3/fs/open.c	Fri Jun 14 13:01:35 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/utime.h>
@@ -315,6 +316,51 @@
 out:
 	return error;
 }
+
+#ifdef CONFIG_32BIT_SUPPORT
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
+#endif /* !(defined(__alpha__) || defined(__ia64__)) */
+#endif /* CONFIG_32BIT_SUPPORT  */
 
 /*
  * access() needs to use the real uid/gid, not the effective uid/gid.
diff -ruN 2.5.21/include/asm-ppc64/posix_types.h 2.5.21-sfr.3/include/asm-ppc64/posix_types.h
--- 2.5.21/include/asm-ppc64/posix_types.h	Fri May  3 12:08:10 2002
+++ 2.5.21-sfr.3/include/asm-ppc64/posix_types.h	Thu Jun 13 12:38:44 2002
@@ -51,6 +51,9 @@
 	int	val[2];
 } __kernel_fsid_t;
 
+/* Now 32bit compatibility types */
+typedef	int		__kernel_time_t32;
+
 #ifndef __GNUC__
 
 #define	__FD_SET(d, set)	((set)->fds_bits[__FDELT(d)] |= __FDMASK(d))
diff -ruN 2.5.21/include/asm-ppc64/ppc32.h 2.5.21-sfr.3/include/asm-ppc64/ppc32.h
--- 2.5.21/include/asm-ppc64/ppc32.h	Wed Feb 20 16:36:51 2002
+++ 2.5.21-sfr.3/include/asm-ppc64/ppc32.h	Thu Jun 13 12:39:11 2002
@@ -46,7 +46,6 @@
 typedef unsigned int           __kernel_size_t32;
 typedef int                    __kernel_ssize_t32;
 typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
 typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
diff -ruN 2.5.21/include/asm-x86_64/ia32.h 2.5.21-sfr.3/include/asm-x86_64/ia32.h
--- 2.5.21/include/asm-x86_64/ia32.h	Tue Apr 23 10:42:33 2002
+++ 2.5.21-sfr.3/include/asm-x86_64/ia32.h	Thu Jun 13 12:41:02 2002
@@ -13,7 +13,6 @@
 typedef unsigned int	       __kernel_size_t32;
 typedef int		       __kernel_ssize_t32;
 typedef int		       __kernel_ptrdiff_t32;
-typedef int		       __kernel_time_t32;
 typedef int		       __kernel_clock_t32;
 typedef int		       __kernel_pid_t32;
 typedef unsigned short	       __kernel_ipc_pid_t32;
diff -ruN 2.5.21/include/asm-x86_64/posix_types.h 2.5.21-sfr.3/include/asm-x86_64/posix_types.h
--- 2.5.21/include/asm-x86_64/posix_types.h	Wed Feb 20 16:36:51 2002
+++ 2.5.21-sfr.3/include/asm-x86_64/posix_types.h	Thu Jun 13 12:40:44 2002
@@ -40,6 +40,9 @@
 typedef __kernel_uid_t __kernel_uid32_t;
 typedef __kernel_gid_t __kernel_gid32_t;
 
+/* Now 32bit compatibility types */
+typedef	int		__kernel_time_t32;
+
 #ifdef __KERNEL__
 
 #undef __FD_SET



