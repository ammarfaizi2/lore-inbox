Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSFNHyv>; Fri, 14 Jun 2002 03:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSFNHyu>; Fri, 14 Jun 2002 03:54:50 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:56314 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317570AbSFNHyj>;
	Fri, 14 Jun 2002 03:54:39 -0400
Date: Fri, 14 Jun 2002 17:53:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org, engebret@us.ibm.com, schwidefsky@de.ibm.com,
        linux390@de.ibm.com, davem@redhat.com, ak@suse.de, davidm@hpl.hp.com
Cc: anton@samba.org, paulus@samba.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Take 2: Consolidate sys32_utime
Message-Id: <20020614175319.3ea434ff.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all again,

Just because Dave Miller asked for it, I have added the beginnings of
include/asm/compat32.h (it will get bigger over time).

Question: should I create an empty compat32.h in each architecture
that doesn't need it, or should I leave the #includes in the
generic code as conditional.

Also the astute will have noticed that I left out the ia64 part of the
patch (sorry David, I don't know how that happened).

I have changed the CONFIG name from CONFIG_32BIT_SUPPORT to
CONFIG_32BIT_COMPAT.

The story so far:

The following patch removes the architecture specific versions of
the utime() system call for 32 bit emulation and adds a generic
version in fs/open.c.  Comments, please.

This is the first in (hopefully) a long list of these sort of
patches i.e. slowly consolidating all the 32 bit compatibility support.

In case anyone is wondering, I have not even built this as I don't have
easy access to any of these architectures ... Caveat Empor
(It would be nice if someone could try a build for each architecture
to iron out any obvious problems before I launch into even more
of these. HINT, HINT.)

Andi:  I have also removed ia32_utime as I couldn't find it used
anywhere.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.21/arch/ia64/config.in 2.5.21-sfr.3/arch/ia64/config.in
--- 2.5.21/arch/ia64/config.in	Thu May 30 09:44:27 2002
+++ 2.5.21-sfr.3/arch/ia64/config.in	Fri Jun 14 16:24:08 2002
@@ -91,6 +91,9 @@
 
 bool 'SMP support' CONFIG_SMP
 bool 'Support running of Linux/x86 binaries' CONFIG_IA32_SUPPORT
+if [ "$CONFIG_IA32_SUPPORT" = "y" ]; then
+   define_bool CONFIG_32BIT_COMPAT y
+fi
 bool 'Performance monitor support' CONFIG_PERFMON
 tristate '/proc/pal support' CONFIG_IA64_PALINFO
 tristate '/proc/efi/vars support' CONFIG_EFI_VARS
diff -ruN 2.5.21/arch/ia64/ia32/sys_ia32.c 2.5.21-sfr.3/arch/ia64/ia32/sys_ia32.c
--- 2.5.21/arch/ia64/ia32/sys_ia32.c	Mon Jun 10 23:13:43 2002
+++ 2.5.21-sfr.3/arch/ia64/ia32/sys_ia32.c	Fri Jun 14 16:56:47 2002
@@ -20,7 +20,6 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -50,6 +49,7 @@
 #include <linux/ipc.h>
 
 #include <asm/types.h>
+#include <asm/compat32.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
@@ -801,36 +801,7 @@
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
diff -ruN 2.5.21/arch/mips64/config.in 2.5.21-sfr.3/arch/mips64/config.in
--- 2.5.21/arch/mips64/config.in	Tue Apr 23 10:42:12 2002
+++ 2.5.21-sfr.3/arch/mips64/config.in	Fri Jun 14 16:27:16 2002
@@ -115,6 +115,7 @@
 tristate 'Kernel support for 64-bit ELF binaries' CONFIG_BINFMT_ELF
 bool 'Kernel support for Linux/MIPS 32-bit binary compatibility' CONFIG_MIPS32_COMPAT
 if [ "$CONFIG_MIPS32_COMPAT" = "y" ]; then
+   define_bool CONFIG_32BIT_COMPAT y
    define_bool CONFIG_BINFMT_ELF32 y
 fi
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
diff -ruN 2.5.21/arch/mips64/kernel/linux32.c 2.5.21-sfr.3/arch/mips64/kernel/linux32.c
--- 2.5.21/arch/mips64/kernel/linux32.c	Wed Feb 20 16:36:37 2002
+++ 2.5.21-sfr.3/arch/mips64/kernel/linux32.c	Fri Jun 14 16:57:30 2002
@@ -22,7 +22,6 @@
 #include <linux/sem.h>
 #include <linux/msg.h>
 #include <linux/sysctl.h>
-#include <linux/utime.h>
 #include <linux/utsname.h>
 #include <linux/personality.h>
 #include <linux/timex.h>
@@ -32,6 +31,7 @@
 #include <asm/uaccess.h>
 #include <asm/mman.h>
 #include <asm/ipc.h>
+#include <asm/compat32.h>
 
 
 #define A(__x) ((unsigned long)(__x))
@@ -114,36 +114,6 @@
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
+++ 2.5.21-sfr.3/arch/ppc64/config.in	Fri Jun 14 16:28:27 2002
@@ -7,6 +7,7 @@
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 define_bool CONFIG_GENERIC_ISA_DMA y
 define_bool CONFIG_HAVE_DEC_LOCK y
+define_bool CONFIG_32BIT_COMPAT y
 
 source init/Config.in
 
diff -ruN 2.5.21/arch/ppc64/kernel/ioctl32.c 2.5.21-sfr.3/arch/ppc64/kernel/ioctl32.c
--- 2.5.21/arch/ppc64/kernel/ioctl32.c	Mon Jun  3 12:16:58 2002
+++ 2.5.21-sfr.3/arch/ppc64/kernel/ioctl32.c	Fri Jun 14 17:05:08 2002
@@ -106,6 +106,7 @@
 #include <linux/random.h>
 #include <asm/ppc32.h>
 #include <asm/ppcdebug.h>
+#include <asm/compat32.h>
 
 /* Aiee. Someone does not find a difference between int and long */
 #define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
diff -ruN 2.5.21/arch/ppc64/kernel/sys_ppc32.c 2.5.21-sfr.3/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.21/arch/ppc64/kernel/sys_ppc32.c	Mon Jun  3 12:16:59 2002
+++ 2.5.21-sfr.3/arch/ppc64/kernel/sys_ppc32.c	Fri Jun 14 17:05:46 2002
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -57,6 +56,7 @@
 #include <asm/types.h>
 #include <asm/ipc.h>
 #include <asm/uaccess.h>
+#include <asm/compat32.h>
 
 #include <asm/semaphore.h>
 
@@ -119,41 +119,6 @@
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
+++ 2.5.21-sfr.3/arch/s390x/config.in	Fri Jun 14 17:36:07 2002
@@ -21,6 +21,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Kernel support for 31 bit emulation' CONFIG_S390_SUPPORT
 if [ "$CONFIG_S390_SUPPORT" = "y" ]; then
+  define_bool CONFIG_32BIT_COMPAT y
   tristate 'Kernel support for 31 bit ELF binaries' CONFIG_BINFMT_ELF32 
 fi
 endmenu
diff -ruN 2.5.21/arch/s390x/kernel/linux32.c 2.5.21-sfr.3/arch/s390x/kernel/linux32.c
--- 2.5.21/arch/s390x/kernel/linux32.c	Mon Jun 10 23:13:43 2002
+++ 2.5.21-sfr.3/arch/s390x/kernel/linux32.c	Fri Jun 14 16:59:11 2002
@@ -22,7 +22,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -62,6 +61,7 @@
 #include <asm/ipc.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
+#include <asm/compat32.h>
 
 #include <net/scm.h>
 #include <net/sock.h>
@@ -1009,36 +1009,6 @@
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
diff -ruN 2.5.21/arch/s390x/kernel/linux32.h 2.5.21-sfr.3/arch/s390x/kernel/linux32.h
--- 2.5.21/arch/s390x/kernel/linux32.h	Wed Oct 24 16:12:21 2001
+++ 2.5.21-sfr.3/arch/s390x/kernel/linux32.h	Fri Jun 14 16:58:22 2002
@@ -20,7 +20,6 @@
 typedef unsigned int           __kernel_size_t32;
 typedef int                    __kernel_ssize_t32;
 typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
 typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
diff -ruN 2.5.21/arch/sparc64/config.in 2.5.21-sfr.3/arch/sparc64/config.in
--- 2.5.21/arch/sparc64/config.in	Mon May  6 13:52:43 2002
+++ 2.5.21-sfr.3/arch/sparc64/config.in	Fri Jun 14 16:28:08 2002
@@ -54,6 +54,7 @@
 fi
 bool 'Kernel support for Linux/Sparc 32bit binary compatibility' CONFIG_SPARC32_COMPAT
 if [ "$CONFIG_SPARC32_COMPAT" != "n" ]; then
+   define_bool CONFIG_32BIT_COMPAT y
    tristate '  Kernel support for 32-bit ELF binaries' CONFIG_BINFMT_ELF32
    bool '  Kernel support for 32-bit (ie. SunOS) a.out binaries' CONFIG_BINFMT_AOUT32
 fi
diff -ruN 2.5.21/arch/sparc64/kernel/ioctl32.c 2.5.21-sfr.3/arch/sparc64/kernel/ioctl32.c
--- 2.5.21/arch/sparc64/kernel/ioctl32.c	Fri May 10 09:35:09 2002
+++ 2.5.21-sfr.3/arch/sparc64/kernel/ioctl32.c	Fri Jun 14 17:03:31 2002
@@ -100,6 +100,8 @@
 #include <linux/nbd.h>
 #include <linux/random.h>
 
+#include <asm/compat32.h>
+
 /* Use this to get at 32-bit user passed pointers. 
    See sys_sparc32.c for description about these. */
 #define A(__x) ((unsigned long)(__x))
diff -ruN 2.5.21/arch/sparc64/kernel/sys_sparc32.c 2.5.21-sfr.3/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.21/arch/sparc64/kernel/sys_sparc32.c	Mon Jun 10 23:13:44 2002
+++ 2.5.21-sfr.3/arch/sparc64/kernel/sys_sparc32.c	Fri Jun 14 17:04:30 2002
@@ -15,7 +15,6 @@
 #include <linux/mm.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -57,6 +56,7 @@
 #include <asm/uaccess.h>
 #include <asm/fpumacro.h>
 #include <asm/semaphore.h>
+#include <asm/compat32.h>
 
 #include <net/scm.h>
 
@@ -961,36 +961,6 @@
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
diff -ruN 2.5.21/arch/sparc64/kernel/sys_sunos32.c 2.5.21-sfr.3/arch/sparc64/kernel/sys_sunos32.c
--- 2.5.21/arch/sparc64/kernel/sys_sunos32.c	Sat May 18 22:59:44 2002
+++ 2.5.21-sfr.3/arch/sparc64/kernel/sys_sunos32.c	Fri Jun 14 17:02:41 2002
@@ -40,6 +40,7 @@
 #include <asm/idprom.h> /* for gethostid() */
 #include <asm/unistd.h>
 #include <asm/system.h>
+#include <asm/compat32.h>
 
 /* For the nfs mount emulation */
 #include <linux/socket.h>
diff -ruN 2.5.21/arch/x86_64/config.in 2.5.21-sfr.3/arch/x86_64/config.in
--- 2.5.21/arch/x86_64/config.in	Mon May  6 13:52:43 2002
+++ 2.5.21-sfr.3/arch/x86_64/config.in	Fri Jun 14 16:28:40 2002
@@ -87,6 +87,9 @@
 bool 'Power Management support' CONFIG_PM
 
 bool 'IA32 Emulation' CONFIG_IA32_EMULATION
+if [ "$CONFIG_IA32_EMULATION" = "y" ]; then
+   define_bool CONFIG_32BIT_COMPAT y
+fi
 
 endmenu
 
diff -ruN 2.5.21/arch/x86_64/ia32/ia32_ioctl.c 2.5.21-sfr.3/arch/x86_64/ia32/ia32_ioctl.c
--- 2.5.21/arch/x86_64/ia32/ia32_ioctl.c	Fri May 10 09:35:09 2002
+++ 2.5.21-sfr.3/arch/x86_64/ia32/ia32_ioctl.c	Fri Jun 14 17:06:20 2002
@@ -88,6 +88,8 @@
 #include <linux/sonet.h>
 #include <linux/atm_suni.h>
 
+#include <asm/compat32.h>
+
 #define A(__x) ((void *)(unsigned long)(__x))
 #define AA(__x)	A(__x)
 
diff -ruN 2.5.21/arch/x86_64/ia32/sys_ia32.c 2.5.21-sfr.3/arch/x86_64/ia32/sys_ia32.c
--- 2.5.21/arch/x86_64/ia32/sys_ia32.c	Sat May 18 22:59:44 2002
+++ 2.5.21-sfr.3/arch/x86_64/ia32/sys_ia32.c	Fri Jun 14 17:11:51 2002
@@ -26,7 +26,6 @@
 #include <linux/fs.h> 
 #include <linux/file.h> 
 #include <linux/signal.h>
-#include <linux/utime.h>
 #include <linux/resource.h>
 #include <linux/times.h>
 #include <linux/utsname.h>
@@ -63,6 +62,7 @@
 #include <asm/semaphore.h>
 #include <asm/ipc.h>
 #include <asm/atomic.h>
+#include <asm/compat32.h>
 
 #include <net/scm.h>
 #include <net/sock.h>
@@ -612,40 +612,8 @@
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
 
@@ -1745,38 +1713,6 @@
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
+++ 2.5.21-sfr.3/fs/open.c	Fri Jun 14 17:14:08 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/utime.h>
@@ -315,6 +316,52 @@
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
diff -ruN 2.5.21/include/asm-generic/compat32.h 2.5.21-sfr.3/include/asm-generic/compat32.h
--- 2.5.21/include/asm-generic/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.21-sfr.3/include/asm-generic/compat32.h	Fri Jun 14 16:42:45 2002
@@ -0,0 +1,12 @@
+/*
+ * Support for 32 bit compatibility layers
+ * This file will be included by include/asm-xxx/compat32.h
+ * in each 64 bit architecture that supports a 32 bit
+ * compatibility layer.
+ */
+#ifndef ASM_GENERIC_COMPAT32_H
+#define ASM_GENERIC_COMPAT32_H
+
+typedef int		__kernel_time_t32;
+
+#endif /* ASM_GENERIC_COMPAT32_H */
diff -ruN 2.5.21/include/asm-ia64/compat32.h 2.5.21-sfr.3/include/asm-ia64/compat32.h
--- 2.5.21/include/asm-ia64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.21-sfr.3/include/asm-ia64/compat32.h	Fri Jun 14 16:46:23 2002
@@ -0,0 +1,9 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_IA64_COMPAT32_H
+#define ASM_IA64_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+#endif /* ASM_IA64_COMPAT32_H */
diff -ruN 2.5.21/include/asm-ia64/ia32.h 2.5.21-sfr.3/include/asm-ia64/ia32.h
--- 2.5.21/include/asm-ia64/ia32.h	Tue Mar 19 15:12:06 2002
+++ 2.5.21-sfr.3/include/asm-ia64/ia32.h	Fri Jun 14 16:18:17 2002
@@ -15,7 +15,6 @@
 typedef unsigned int	__kernel_size_t32;
 typedef int		__kernel_ssize_t32;
 typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
 typedef int		__kernel_clock_t32;
 typedef int		__kernel_pid_t32;
 typedef unsigned short	__kernel_ipc_pid_t32;
diff -ruN 2.5.21/include/asm-mips64/compat32.h 2.5.21-sfr.3/include/asm-mips64/compat32.h
--- 2.5.21/include/asm-mips64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.21-sfr.3/include/asm-mips64/compat32.h	Fri Jun 14 16:47:38 2002
@@ -0,0 +1,9 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_MIPS64_COMPAT32_H
+#define ASM_MIPS64_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+#endif /* ASM_MIPS64_COMPAT32_H */
diff -ruN 2.5.21/include/asm-mips64/posix_types.h 2.5.21-sfr.3/include/asm-mips64/posix_types.h
--- 2.5.21/include/asm-mips64/posix_types.h	Mon Jul 10 15:18:15 2000
+++ 2.5.21-sfr.3/include/asm-mips64/posix_types.h	Fri Jun 14 16:48:14 2002
@@ -61,7 +61,6 @@
 typedef unsigned int	__kernel_size_t32;
 typedef int		__kernel_ssize_t32;
 typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
 typedef int		__kernel_suseconds_t32;
 typedef int		__kernel_clock_t32;
 typedef int		__kernel_daddr_t32;
diff -ruN 2.5.21/include/asm-mips64/stat.h 2.5.21-sfr.3/include/asm-mips64/stat.h
--- 2.5.21/include/asm-mips64/stat.h	Wed Nov 29 16:42:04 2000
+++ 2.5.21-sfr.3/include/asm-mips64/stat.h	Fri Jun 14 17:14:44 2002
@@ -10,6 +10,7 @@
 #define _ASM_STAT_H
 
 #include <linux/types.h>
+#include <linux/compat32.h>
 
 struct __old_kernel_stat {
 	unsigned int	st_dev;
diff -ruN 2.5.21/include/asm-parisc/compat32.h 2.5.21-sfr.3/include/asm-parisc/compat32.h
--- 2.5.21/include/asm-parisc/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.21-sfr.3/include/asm-parisc/compat32.h	Fri Jun 14 17:18:02 2002
@@ -0,0 +1,9 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_PARISC_COMPAT32_H
+#define ASM_PARISC_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+#endif /* ASM_PARISC_COMPAT32_H */
diff -ruN 2.5.21/include/asm-parisc/posix_types.h 2.5.21-sfr.3/include/asm-parisc/posix_types.h
--- 2.5.21/include/asm-parisc/posix_types.h	Wed Dec  6 07:29:39 2000
+++ 2.5.21-sfr.3/include/asm-parisc/posix_types.h	Fri Jun 14 17:18:49 2002
@@ -58,7 +58,6 @@
 typedef unsigned int		__kernel_size_t32;
 typedef int			__kernel_ssize_t32;
 typedef int			__kernel_ptrdiff_t32;
-typedef int			__kernel_time_t32;
 typedef int			__kernel_suseconds_t32;
 typedef int			__kernel_clock_t32;
 typedef int			__kernel_daddr_t32;
diff -ruN 2.5.21/include/asm-ppc64/compat32.h 2.5.21-sfr.3/include/asm-ppc64/compat32.h
--- 2.5.21/include/asm-ppc64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.21-sfr.3/include/asm-ppc64/compat32.h	Fri Jun 14 16:48:50 2002
@@ -0,0 +1,9 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_PPC64_COMPAT32_H
+#define ASM_PPC64_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+#endif /* ASM_PPC64_COMPAT32_H */
diff -ruN 2.5.21/include/asm-ppc64/ppc32.h 2.5.21-sfr.3/include/asm-ppc64/ppc32.h
--- 2.5.21/include/asm-ppc64/ppc32.h	Wed Feb 20 16:36:51 2002
+++ 2.5.21-sfr.3/include/asm-ppc64/ppc32.h	Fri Jun 14 17:20:31 2002
@@ -3,6 +3,7 @@
 
 #include <asm/siginfo.h>
 #include <asm/signal.h>
+#include <asm/compat32.h>
 
 /*
  * Data types and macros for providing 32b PowerPC support.
@@ -46,7 +47,6 @@
 typedef unsigned int           __kernel_size_t32;
 typedef int                    __kernel_ssize_t32;
 typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
 typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
diff -ruN 2.5.21/include/asm-s390x/compat32.h 2.5.21-sfr.3/include/asm-s390x/compat32.h
--- 2.5.21/include/asm-s390x/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.21-sfr.3/include/asm-s390x/compat32.h	Fri Jun 14 16:49:42 2002
@@ -0,0 +1,9 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_S390X_COMPAT32_H
+#define ASM_S390X_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+#endif /* ASM_S390X_COMPAT32_H */
diff -ruN 2.5.21/include/asm-sparc64/compat32.h 2.5.21-sfr.3/include/asm-sparc64/compat32.h
--- 2.5.21/include/asm-sparc64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.21-sfr.3/include/asm-sparc64/compat32.h	Fri Jun 14 16:50:55 2002
@@ -0,0 +1,9 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_SPARC64_COMPAT32_H
+#define ASM_SPARC64_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+#endif /* ASM_SPARC64_COMPAT32_H */
diff -ruN 2.5.21/include/asm-sparc64/posix_types.h 2.5.21-sfr.3/include/asm-sparc64/posix_types.h
--- 2.5.21/include/asm-sparc64/posix_types.h	Sat Oct 28 04:55:01 2000
+++ 2.5.21-sfr.3/include/asm-sparc64/posix_types.h	Fri Jun 14 16:51:20 2002
@@ -51,7 +51,6 @@
 typedef unsigned int           __kernel_size_t32;
 typedef int                    __kernel_ssize_t32;
 typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
 typedef int                    __kernel_clock_t32;
 typedef int                    __kernel_pid_t32;
 typedef unsigned short         __kernel_ipc_pid_t32;
diff -ruN 2.5.21/include/asm-sparc64/stat.h 2.5.21-sfr.3/include/asm-sparc64/stat.h
--- 2.5.21/include/asm-sparc64/stat.h	Sat Aug  5 11:16:11 2000
+++ 2.5.21-sfr.3/include/asm-sparc64/stat.h	Fri Jun 14 17:19:44 2002
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/time.h>
+#include <linux/compat32.h>
 
 struct stat32 {
 	__kernel_dev_t32   st_dev;
diff -ruN 2.5.21/include/asm-x86_64/compat32.h 2.5.21-sfr.3/include/asm-x86_64/compat32.h
--- 2.5.21/include/asm-x86_64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.21-sfr.3/include/asm-x86_64/compat32.h	Fri Jun 14 16:51:52 2002
@@ -0,0 +1,9 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_X86_64_COMPAT32_H
+#define ASM_X86_64_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+#endif /* ASM_X86_64_COMPAT32_H */
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
