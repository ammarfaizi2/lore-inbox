Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316763AbSFQGeF>; Mon, 17 Jun 2002 02:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316766AbSFQGeF>; Mon, 17 Jun 2002 02:34:05 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:62081 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S316763AbSFQGd6>;
	Mon, 17 Jun 2002 02:33:58 -0400
Date: Mon, 17 Jun 2002 16:32:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ralf@gnu.org, engebret@us.ibm.com,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@redhat.com,
       ak@suse.de, davidm@hpl.hp.com, anton@samba.org, paulus@samba.org
Subject: [PATCH] Create include/asm/compat32.h
Message-Id: <20020617163225.5f8856b5.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

In Dave Miller's suggestion, I have created and started to populate
include/asm/compat32.h.  This patch:
	creates include/asm-generic/compat32.h with all the
		common type definitions for 32 compatibility
	creates include/asm*/compat32.h for all the 64 bit architectures
		that have a 32 bit compatibility layer
	include <asm/compat32.h> where necessary
	adds CONFIG_32BIT_COMPAT for use in generic code later

Please apply. Some 32 compatibility consolidation patches will
follow that depend on this one.

This patch has been seen by the relevant arch maintainers without to
much comment.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.22/arch/ia64/config.in 2.5.22-sfr.3/arch/ia64/config.in
--- 2.5.22/arch/ia64/config.in	Thu May 30 09:44:27 2002
+++ 2.5.22-sfr.3/arch/ia64/config.in	Fri Jun 14 16:24:08 2002
@@ -91,6 +91,9 @@
 
 bool 'SMP support' CONFIG_SMP
 bool 'Support running of Linux/x86 binaries' CONFIG_IA32_SUPPORT
+if [ "$CONFIG_IA32_SUPPORT" = "y" ]; then
+   define_bool CONFIG_32BIT_COMPAT y
+fi
 bool 'Performance monitor support' CONFIG_PERFMON
 tristate '/proc/pal support' CONFIG_IA64_PALINFO
 tristate '/proc/efi/vars support' CONFIG_EFI_VARS
diff -ruN 2.5.22/arch/ia64/ia32/sys_ia32.c 2.5.22-sfr.3/arch/ia64/ia32/sys_ia32.c
--- 2.5.22/arch/ia64/ia32/sys_ia32.c	Mon Jun 10 23:13:43 2002
+++ 2.5.22-sfr.3/arch/ia64/ia32/sys_ia32.c	Mon Jun 17 16:09:22 2002
@@ -50,6 +50,7 @@
 #include <linux/ipc.h>
 
 #include <asm/types.h>
+#include <asm/compat32.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
 
diff -ruN 2.5.22/arch/mips64/config.in 2.5.22-sfr.3/arch/mips64/config.in
--- 2.5.22/arch/mips64/config.in	Tue Apr 23 10:42:12 2002
+++ 2.5.22-sfr.3/arch/mips64/config.in	Fri Jun 14 16:27:16 2002
@@ -115,6 +115,7 @@
 tristate 'Kernel support for 64-bit ELF binaries' CONFIG_BINFMT_ELF
 bool 'Kernel support for Linux/MIPS 32-bit binary compatibility' CONFIG_MIPS32_COMPAT
 if [ "$CONFIG_MIPS32_COMPAT" = "y" ]; then
+   define_bool CONFIG_32BIT_COMPAT y
    define_bool CONFIG_BINFMT_ELF32 y
 fi
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
diff -ruN 2.5.22/arch/mips64/kernel/ioctl32.c 2.5.22-sfr.3/arch/mips64/kernel/ioctl32.c
--- 2.5.22/arch/mips64/kernel/ioctl32.c	Mon Apr 29 14:57:05 2002
+++ 2.5.22-sfr.3/arch/mips64/kernel/ioctl32.c	Sat Jun 15 00:23:29 2002
@@ -29,6 +29,7 @@
 #include <linux/raid/md_u.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
+#include <asm/compat32.h>
 
 long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg);
 
diff -ruN 2.5.22/arch/mips64/kernel/linux32.c 2.5.22-sfr.3/arch/mips64/kernel/linux32.c
--- 2.5.22/arch/mips64/kernel/linux32.c	Wed Feb 20 16:36:37 2002
+++ 2.5.22-sfr.3/arch/mips64/kernel/linux32.c	Mon Jun 17 16:10:14 2002
@@ -32,6 +32,7 @@
 #include <asm/uaccess.h>
 #include <asm/mman.h>
 #include <asm/ipc.h>
+#include <asm/compat32.h>
 
 
 #define A(__x) ((unsigned long)(__x))
diff -ruN 2.5.22/arch/mips64/kernel/signal32.c 2.5.22-sfr.3/arch/mips64/kernel/signal32.c
--- 2.5.22/arch/mips64/kernel/signal32.c	Thu May 30 09:44:28 2002
+++ 2.5.22-sfr.3/arch/mips64/kernel/signal32.c	Sat Jun 15 00:24:53 2002
@@ -25,6 +25,7 @@
 #include <asm/uaccess.h>
 #include <asm/ucontext.h>
 #include <asm/system.h>
+#include <asm/compat32.h>
 
 #define DEBUG_SIG 0
 
diff -ruN 2.5.22/arch/ppc64/config.in 2.5.22-sfr.3/arch/ppc64/config.in
--- 2.5.22/arch/ppc64/config.in	Mon Jun  3 12:16:58 2002
+++ 2.5.22-sfr.3/arch/ppc64/config.in	Fri Jun 14 16:28:27 2002
@@ -7,6 +7,7 @@
 define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM y
 define_bool CONFIG_GENERIC_ISA_DMA y
 define_bool CONFIG_HAVE_DEC_LOCK y
+define_bool CONFIG_32BIT_COMPAT y
 
 source init/Config.in
 
diff -ruN 2.5.22/arch/ppc64/kernel/ioctl32.c 2.5.22-sfr.3/arch/ppc64/kernel/ioctl32.c
--- 2.5.22/arch/ppc64/kernel/ioctl32.c	Mon Jun  3 12:16:58 2002
+++ 2.5.22-sfr.3/arch/ppc64/kernel/ioctl32.c	Fri Jun 14 17:05:08 2002
@@ -106,6 +106,7 @@
 #include <linux/random.h>
 #include <asm/ppc32.h>
 #include <asm/ppcdebug.h>
+#include <asm/compat32.h>
 
 /* Aiee. Someone does not find a difference between int and long */
 #define EXT2_IOC32_GETFLAGS               _IOR('f', 1, int)
diff -ruN 2.5.22/arch/ppc64/kernel/signal32.c 2.5.22-sfr.3/arch/ppc64/kernel/signal32.c
--- 2.5.22/arch/ppc64/kernel/signal32.c	Mon Jun  3 12:16:59 2002
+++ 2.5.22-sfr.3/arch/ppc64/kernel/signal32.c	Sat Jun 15 00:33:33 2002
@@ -51,6 +51,7 @@
 #include <asm/ppc32.h>
 #include <asm/ppcdebug.h>
 #include <asm/unistd.h>
+#include <asm/compat32.h>
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 /* 
diff -ruN 2.5.22/arch/ppc64/kernel/sys_ppc32.c 2.5.22-sfr.3/arch/ppc64/kernel/sys_ppc32.c
--- 2.5.22/arch/ppc64/kernel/sys_ppc32.c	Mon Jun  3 12:16:59 2002
+++ 2.5.22-sfr.3/arch/ppc64/kernel/sys_ppc32.c	Mon Jun 17 16:11:03 2002
@@ -57,6 +57,7 @@
 #include <asm/types.h>
 #include <asm/ipc.h>
 #include <asm/uaccess.h>
+#include <asm/compat32.h>
 
 #include <asm/semaphore.h>
 
diff -ruN 2.5.22/arch/s390x/config.in 2.5.22-sfr.3/arch/s390x/config.in
--- 2.5.22/arch/s390x/config.in	Mon Jun 10 23:13:43 2002
+++ 2.5.22-sfr.3/arch/s390x/config.in	Fri Jun 14 17:36:07 2002
@@ -21,6 +21,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Kernel support for 31 bit emulation' CONFIG_S390_SUPPORT
 if [ "$CONFIG_S390_SUPPORT" = "y" ]; then
+  define_bool CONFIG_32BIT_COMPAT y
   tristate 'Kernel support for 31 bit ELF binaries' CONFIG_BINFMT_ELF32 
 fi
 endmenu
diff -ruN 2.5.22/arch/s390x/kernel/ioctl32.c 2.5.22-sfr.3/arch/s390x/kernel/ioctl32.c
--- 2.5.22/arch/s390x/kernel/ioctl32.c	Mon Jun 10 23:13:43 2002
+++ 2.5.22-sfr.3/arch/s390x/kernel/ioctl32.c	Sat Jun 15 00:25:34 2002
@@ -35,6 +35,7 @@
 #include <asm/tape390.h>
 #include <asm/sockios.h>
 #include <asm/ioctls.h>
+#include <asm/compat32.h>
 
 #include "linux32.h"
 
diff -ruN 2.5.22/arch/s390x/kernel/linux32.c 2.5.22-sfr.3/arch/s390x/kernel/linux32.c
--- 2.5.22/arch/s390x/kernel/linux32.c	Mon Jun 10 23:13:43 2002
+++ 2.5.22-sfr.3/arch/s390x/kernel/linux32.c	Mon Jun 17 16:11:33 2002
@@ -62,6 +62,7 @@
 #include <asm/ipc.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
+#include <asm/compat32.h>
 
 #include <net/scm.h>
 #include <net/sock.h>
diff -ruN 2.5.22/arch/s390x/kernel/linux32.h 2.5.22-sfr.3/arch/s390x/kernel/linux32.h
--- 2.5.22/arch/s390x/kernel/linux32.h	Wed Oct 24 16:12:21 2001
+++ 2.5.22-sfr.3/arch/s390x/kernel/linux32.h	Fri Jun 14 23:11:58 2002
@@ -8,6 +8,8 @@
 #include <linux/nfsd/nfsd.h>
 #include <linux/nfsd/export.h>
 
+#include <asm/compat32.h>
+
 #ifdef CONFIG_S390_SUPPORT
 
 /* Macro that masks the high order bit of an 32 bit pointer and converts it*/
@@ -17,25 +19,6 @@
 	((unsigned long)(__x))
 
 /* Now 32bit compatibility types */
-typedef unsigned int           __kernel_size_t32;
-typedef int                    __kernel_ssize_t32;
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
-typedef int                    __kernel_clock_t32;
-typedef int                    __kernel_pid_t32;
-typedef unsigned short         __kernel_ipc_pid_t32;
-typedef unsigned short         __kernel_uid_t32;
-typedef unsigned short         __kernel_gid_t32;
-typedef unsigned short         __kernel_dev_t32;
-typedef unsigned int           __kernel_ino_t32;
-typedef unsigned short         __kernel_mode_t32;
-typedef unsigned short         __kernel_umode_t32;
-typedef short                  __kernel_nlink_t32;
-typedef int                    __kernel_daddr_t32;
-typedef int                    __kernel_off_t32;
-typedef unsigned int           __kernel_caddr_t32;
-typedef long                   __kernel_loff_t32;
-typedef __kernel_fsid_t        __kernel_fsid_t32;  
 
 struct ipc_kludge_32 {
         __u32   msgp;                           /* pointer              */
diff -ruN 2.5.22/arch/sparc64/config.in 2.5.22-sfr.3/arch/sparc64/config.in
--- 2.5.22/arch/sparc64/config.in	Mon May  6 13:52:43 2002
+++ 2.5.22-sfr.3/arch/sparc64/config.in	Fri Jun 14 16:28:08 2002
@@ -54,6 +54,7 @@
 fi
 bool 'Kernel support for Linux/Sparc 32bit binary compatibility' CONFIG_SPARC32_COMPAT
 if [ "$CONFIG_SPARC32_COMPAT" != "n" ]; then
+   define_bool CONFIG_32BIT_COMPAT y
    tristate '  Kernel support for 32-bit ELF binaries' CONFIG_BINFMT_ELF32
    bool '  Kernel support for 32-bit (ie. SunOS) a.out binaries' CONFIG_BINFMT_AOUT32
 fi
diff -ruN 2.5.22/arch/sparc64/kernel/ioctl32.c 2.5.22-sfr.3/arch/sparc64/kernel/ioctl32.c
--- 2.5.22/arch/sparc64/kernel/ioctl32.c	Fri May 10 09:35:09 2002
+++ 2.5.22-sfr.3/arch/sparc64/kernel/ioctl32.c	Fri Jun 14 17:03:31 2002
@@ -100,6 +100,8 @@
 #include <linux/nbd.h>
 #include <linux/random.h>
 
+#include <asm/compat32.h>
+
 /* Use this to get at 32-bit user passed pointers. 
    See sys_sparc32.c for description about these. */
 #define A(__x) ((unsigned long)(__x))
diff -ruN 2.5.22/arch/sparc64/kernel/signal32.c 2.5.22-sfr.3/arch/sparc64/kernel/signal32.c
--- 2.5.22/arch/sparc64/kernel/signal32.c	Fri May 10 09:35:09 2002
+++ 2.5.22-sfr.3/arch/sparc64/kernel/signal32.c	Sat Jun 15 00:32:00 2002
@@ -28,6 +28,7 @@
 #include <asm/psrcompat.h>
 #include <asm/fpumacro.h>
 #include <asm/visasm.h>
+#include <asm/compat32.h>
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
diff -ruN 2.5.22/arch/sparc64/kernel/sunos_ioctl32.c 2.5.22-sfr.3/arch/sparc64/kernel/sunos_ioctl32.c
--- 2.5.22/arch/sparc64/kernel/sunos_ioctl32.c	Sat Aug  5 11:16:11 2000
+++ 2.5.22-sfr.3/arch/sparc64/kernel/sunos_ioctl32.c	Sat Jun 15 00:30:13 2002
@@ -23,6 +23,7 @@
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
 #include <asm/kbio.h>
+#include <asm/compat32.h>
 
 /* Use this to get at 32-bit user passed pointers. */
 #define A(__x)				\
diff -ruN 2.5.22/arch/sparc64/kernel/sys_sparc32.c 2.5.22-sfr.3/arch/sparc64/kernel/sys_sparc32.c
--- 2.5.22/arch/sparc64/kernel/sys_sparc32.c	Mon Jun 17 14:09:50 2002
+++ 2.5.22-sfr.3/arch/sparc64/kernel/sys_sparc32.c	Mon Jun 17 16:13:02 2002
@@ -57,6 +57,7 @@
 #include <asm/uaccess.h>
 #include <asm/fpumacro.h>
 #include <asm/semaphore.h>
+#include <asm/compat32.h>
 
 #include <net/scm.h>
 
diff -ruN 2.5.22/arch/sparc64/kernel/sys_sunos32.c 2.5.22-sfr.3/arch/sparc64/kernel/sys_sunos32.c
--- 2.5.22/arch/sparc64/kernel/sys_sunos32.c	Mon Jun 17 14:09:50 2002
+++ 2.5.22-sfr.3/arch/sparc64/kernel/sys_sunos32.c	Mon Jun 17 16:13:18 2002
@@ -40,6 +40,7 @@
 #include <asm/idprom.h> /* for gethostid() */
 #include <asm/unistd.h>
 #include <asm/system.h>
+#include <asm/compat32.h>
 
 /* For the nfs mount emulation */
 #include <linux/socket.h>
diff -ruN 2.5.22/arch/sparc64/solaris/socket.c 2.5.22-sfr.3/arch/sparc64/solaris/socket.c
--- 2.5.22/arch/sparc64/solaris/socket.c	Mon Feb 11 17:37:20 2002
+++ 2.5.22-sfr.3/arch/sparc64/solaris/socket.c	Sat Jun 15 00:32:41 2002
@@ -18,6 +18,7 @@
 #include <asm/string.h>
 #include <asm/oplib.h>
 #include <asm/idprom.h>
+#include <asm/compat32.h>
 
 #include "conv.h"
 
diff -ruN 2.5.22/arch/x86_64/config.in 2.5.22-sfr.3/arch/x86_64/config.in
--- 2.5.22/arch/x86_64/config.in	Mon Jun 17 14:09:50 2002
+++ 2.5.22-sfr.3/arch/x86_64/config.in	Mon Jun 17 16:14:09 2002
@@ -107,6 +107,9 @@
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
 
 bool 'IA32 Emulation' CONFIG_IA32_EMULATION
+if [ "$CONFIG_IA32_EMULATION" = "y" ]; then
+   define_bool CONFIG_32BIT_COMPAT y
+fi
 
 endmenu
 
diff -ruN 2.5.22/arch/x86_64/ia32/ia32_ioctl.c 2.5.22-sfr.3/arch/x86_64/ia32/ia32_ioctl.c
--- 2.5.22/arch/x86_64/ia32/ia32_ioctl.c	Mon Jun 17 14:09:50 2002
+++ 2.5.22-sfr.3/arch/x86_64/ia32/ia32_ioctl.c	Mon Jun 17 16:15:43 2002
@@ -88,6 +88,8 @@
 #include <linux/sonet.h>
 #include <linux/atm_suni.h>
 
+#include <asm/compat32.h>
+
 #define A(__x) ((void *)(unsigned long)(__x))
 #define AA(__x)	A(__x)
 
diff -ruN 2.5.22/arch/x86_64/ia32/socket32.c 2.5.22-sfr.3/arch/x86_64/ia32/socket32.c
--- 2.5.22/arch/x86_64/ia32/socket32.c	Wed Feb 20 16:36:40 2002
+++ 2.5.22-sfr.3/arch/x86_64/ia32/socket32.c	Sat Jun 15 00:36:48 2002
@@ -25,6 +25,7 @@
 #include <asm/ia32.h>
 #include <asm/uaccess.h>
 #include <asm/socket32.h>
+#include <asm/compat32.h>
 
 #define A(__x)		((unsigned long)(__x))
 #define AA(__x)		((unsigned long)(__x))
diff -ruN 2.5.22/arch/x86_64/ia32/sys_ia32.c 2.5.22-sfr.3/arch/x86_64/ia32/sys_ia32.c
--- 2.5.22/arch/x86_64/ia32/sys_ia32.c	Mon Jun 17 14:09:50 2002
+++ 2.5.22-sfr.3/arch/x86_64/ia32/sys_ia32.c	Mon Jun 17 16:16:22 2002
@@ -63,6 +63,7 @@
 #include <asm/semaphore.h>
 #include <asm/ipc.h>
 #include <asm/atomic.h>
+#include <asm/compat32.h>
 
 #include <net/scm.h>
 #include <net/sock.h>
diff -ruN 2.5.22/include/asm-generic/compat32.h 2.5.22-sfr.3/include/asm-generic/compat32.h
--- 2.5.22/include/asm-generic/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.22-sfr.3/include/asm-generic/compat32.h	Sat Jun 15 01:08:07 2002
@@ -0,0 +1,40 @@
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
+typedef int		__kernel_clock_t32;
+typedef int		__kernel_daddr_t32;
+typedef int		__kernel_off_t32;
+typedef int		__kernel_pid_t32;
+typedef int		__kernel_ssize_t32;
+typedef unsigned int	__kernel_caddr_t32;
+typedef unsigned int	__kernel_ino_t32;
+typedef unsigned int	__kernel_size_t32;
+
+#ifndef HAVE_ARCH___KERNEL_DEV_T32
+typedef unsigned short	__kernel_dev_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_GID_T32
+typedef unsigned short	__kernel_gid_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_UID_T32
+typedef unsigned short	__kernel_uid_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_IPC_PID_T32
+typedef unsigned short	__kernel_ipc_pid_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_MODE_T32
+typedef unsigned short	__kernel_mode_t32;
+#endif
+#ifndef HAVE_ARCH___KERNEL_FSID_T32
+#include <linux/types.h>
+typedef __kernel_fsid_t	__kernel_fsid_t32;
+#endif
+
+#endif /* ASM_GENERIC_COMPAT32_H */
diff -ruN 2.5.22/include/asm-ia64/compat32.h 2.5.22-sfr.3/include/asm-ia64/compat32.h
--- 2.5.22/include/asm-ia64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.22-sfr.3/include/asm-ia64/compat32.h	Sat Jun 15 00:19:04 2002
@@ -0,0 +1,12 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_IA64_COMPAT32_H
+#define ASM_IA64_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+typedef unsigned int	__kernel_gid32_t32;
+typedef unsigned int	__kernel_uid32_t32;
+
+#endif /* ASM_IA64_COMPAT32_H */
diff -ruN 2.5.22/include/asm-ia64/ia32.h 2.5.22-sfr.3/include/asm-ia64/ia32.h
--- 2.5.22/include/asm-ia64/ia32.h	Tue Mar 19 15:12:06 2002
+++ 2.5.22-sfr.3/include/asm-ia64/ia32.h	Fri Jun 14 22:55:54 2002
@@ -6,33 +6,13 @@
 #ifdef CONFIG_IA32_SUPPORT
 
 #include <linux/binfmts.h>
+#include <asm/compat32.h>
 
 /*
  * 32 bit structures for IA32 support.
  */
 
 /* 32bit compatibility types */
-typedef unsigned int	__kernel_size_t32;
-typedef int		__kernel_ssize_t32;
-typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
-typedef int		__kernel_clock_t32;
-typedef int		__kernel_pid_t32;
-typedef unsigned short	__kernel_ipc_pid_t32;
-typedef unsigned short	__kernel_uid_t32;
-typedef unsigned int	__kernel_uid32_t32;
-typedef unsigned short	__kernel_gid_t32;
-typedef unsigned int	__kernel_gid32_t32;
-typedef unsigned short	__kernel_dev_t32;
-typedef unsigned int	__kernel_ino_t32;
-typedef unsigned short	__kernel_mode_t32;
-typedef unsigned short	__kernel_umode_t32;
-typedef short		__kernel_nlink_t32;
-typedef int		__kernel_daddr_t32;
-typedef int		__kernel_off_t32;
-typedef unsigned int	__kernel_caddr_t32;
-typedef long		__kernel_loff_t32;
-typedef __kernel_fsid_t	__kernel_fsid_t32;
 
 #define IA32_PAGE_SHIFT		12	/* 4KB pages */
 #define IA32_PAGE_SIZE		(1UL << IA32_PAGE_SHIFT)
diff -ruN 2.5.22/include/asm-mips64/compat32.h 2.5.22-sfr.3/include/asm-mips64/compat32.h
--- 2.5.22/include/asm-mips64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.22-sfr.3/include/asm-mips64/compat32.h	Sat Jun 15 01:08:19 2002
@@ -0,0 +1,22 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_MIPS64_COMPAT32_H
+#define ASM_MIPS64_COMPAT32_H
+
+#define HAVE_ARCH___KERNEL_DEV_T32
+#define HAVE_ARCH___KERNEL_GID_T32
+#define HAVE_ARCH___KERNEL_UID_T32
+#define HAVE_ARCH___KERNEL_IPC_PID_T32
+#define HAVE_ARCH___KERNEL_MODE_T32
+
+#include <asm-generic/compat32.h>
+
+typedef int		__kernel_gid_t32;
+typedef int		__kernel_ipc_pid_t32;
+typedef int		__kernel_uid_t32;
+typedef unsigned int	__kernel_dev_t32;
+typedef unsigned int	__kernel_mode_t32;
+typedef unsigned int	__kernel_nlink_t32;
+
+#endif /* ASM_MIPS64_COMPAT32_H */
diff -ruN 2.5.22/include/asm-mips64/posix_types.h 2.5.22-sfr.3/include/asm-mips64/posix_types.h
--- 2.5.22/include/asm-mips64/posix_types.h	Mon Jul 10 15:18:15 2000
+++ 2.5.22-sfr.3/include/asm-mips64/posix_types.h	Fri Jun 14 22:58:23 2002
@@ -48,26 +48,6 @@
         int    val[2];
 } __kernel_fsid_t;
 
-/* Now 32bit compatibility types */
-typedef unsigned int	__kernel_dev_t32;
-typedef unsigned int	__kernel_ino_t32;
-typedef unsigned int	__kernel_mode_t32;
-typedef unsigned int	__kernel_nlink_t32;
-typedef int		__kernel_off_t32;
-typedef int		__kernel_pid_t32;
-typedef int		__kernel_ipc_pid_t32;
-typedef int		__kernel_uid_t32;
-typedef int		__kernel_gid_t32;
-typedef unsigned int	__kernel_size_t32;
-typedef int		__kernel_ssize_t32;
-typedef int		__kernel_ptrdiff_t32;
-typedef int		__kernel_time_t32;
-typedef int		__kernel_suseconds_t32;
-typedef int		__kernel_clock_t32;
-typedef int		__kernel_daddr_t32;
-typedef unsigned int	__kernel_caddr_t32;
-typedef __kernel_fsid_t	__kernel_fsid_t32;
-
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
 #undef __FD_SET
diff -ruN 2.5.22/include/asm-mips64/stat.h 2.5.22-sfr.3/include/asm-mips64/stat.h
--- 2.5.22/include/asm-mips64/stat.h	Wed Nov 29 16:42:04 2000
+++ 2.5.22-sfr.3/include/asm-mips64/stat.h	Fri Jun 14 17:14:44 2002
@@ -10,6 +10,7 @@
 #define _ASM_STAT_H
 
 #include <linux/types.h>
+#include <linux/compat32.h>
 
 struct __old_kernel_stat {
 	unsigned int	st_dev;
diff -ruN 2.5.22/include/asm-parisc/compat32.h 2.5.22-sfr.3/include/asm-parisc/compat32.h
--- 2.5.22/include/asm-parisc/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.22-sfr.3/include/asm-parisc/compat32.h	Sat Jun 15 01:08:26 2002
@@ -0,0 +1,18 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_PARISC_COMPAT32_H
+#define ASM_PARISC_COMPAT32_H
+
+#define HAVE_ARCH___KERNEL_DEV_T32
+#define HAVE_ARCH___KERNEL_GID_T32
+#define HAVE_ARCH___KERNEL_UID_T32
+#define HAVE_ARCH___KERNEL_FSID_T32
+
+#include <asm-generic/compat32.h>
+
+typedef unsigned int		__kernel_dev_t32;
+typedef unsigned int		__kernel_gid_t32;
+typedef unsigned int		__kernel_uid_t32;
+
+#endif /* ASM_PARISC_COMPAT32_H */
diff -ruN 2.5.22/include/asm-parisc/posix_types.h 2.5.22-sfr.3/include/asm-parisc/posix_types.h
--- 2.5.22/include/asm-parisc/posix_types.h	Wed Dec  6 07:29:39 2000
+++ 2.5.22-sfr.3/include/asm-parisc/posix_types.h	Sat Jun 15 01:17:19 2002
@@ -44,27 +44,6 @@
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-#if defined(__KERNEL__) && defined(__LP64__)
-/* Now 32bit compatibility types */
-typedef unsigned int		__kernel_dev_t32;
-typedef unsigned int		__kernel_ino_t32;
-typedef unsigned short		__kernel_mode_t32;
-typedef unsigned short		__kernel_nlink_t32;
-typedef int			__kernel_off_t32;
-typedef int			__kernel_pid_t32;
-typedef unsigned short		__kernel_ipc_pid_t32;
-typedef unsigned int		__kernel_uid_t32;
-typedef unsigned int		__kernel_gid_t32;
-typedef unsigned int		__kernel_size_t32;
-typedef int			__kernel_ssize_t32;
-typedef int			__kernel_ptrdiff_t32;
-typedef int			__kernel_time_t32;
-typedef int			__kernel_suseconds_t32;
-typedef int			__kernel_clock_t32;
-typedef int			__kernel_daddr_t32;
-typedef unsigned int		__kernel_caddr_t32;
-#endif
-
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
 #undef __FD_SET
diff -ruN 2.5.22/include/asm-ppc64/compat32.h 2.5.22-sfr.3/include/asm-ppc64/compat32.h
--- 2.5.22/include/asm-ppc64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.22-sfr.3/include/asm-ppc64/compat32.h	Sat Jun 15 01:08:36 2002
@@ -0,0 +1,25 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_PPC64_COMPAT32_H
+#define ASM_PPC64_COMPAT32_H
+
+#define HAVE_ARCH___KERNEL_DEV_T32
+#define HAVE_ARCH___KERNEL_GID_T32
+#define HAVE_ARCH___KERNEL_UID_T32
+#define HAVE_ARCH___KERNEL_MODE_T32
+#define HAVE_ARCH___KERNEL_FSID_T32
+
+#include <asm-generic/compat32.h>
+
+#ifndef __KERNEL_STRICT_NAMES
+#include <linux/types.h>
+typedef __kernel_fsid_t __kernel_fsid_t32;
+#endif
+
+typedef unsigned int           __kernel_dev_t32;
+typedef unsigned int           __kernel_gid_t32;
+typedef unsigned int           __kernel_mode_t32;
+typedef unsigned int           __kernel_uid_t32;
+
+#endif /* ASM_PPC64_COMPAT32_H */
diff -ruN 2.5.22/include/asm-ppc64/ppc32.h 2.5.22-sfr.3/include/asm-ppc64/ppc32.h
--- 2.5.22/include/asm-ppc64/ppc32.h	Wed Feb 20 16:36:51 2002
+++ 2.5.22-sfr.3/include/asm-ppc64/ppc32.h	Fri Jun 14 23:09:01 2002
@@ -3,6 +3,7 @@
 
 #include <asm/siginfo.h>
 #include <asm/signal.h>
+#include <asm/compat32.h>
 
 /*
  * Data types and macros for providing 32b PowerPC support.
@@ -13,11 +14,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifndef __KERNEL_STRICT_NAMES
-#include <linux/types.h>
-typedef __kernel_fsid_t __kernel_fsid_t32;
-#endif
-
 /* Use this to get at 32-bit user passed pointers. */
 /* Things to consider: the low-level assembly stub does
    srl x, 0, x for first four arguments, so if you have
@@ -43,25 +39,6 @@
 })
 
 /* These are here to support 32-bit syscalls on a 64-bit kernel. */
-typedef unsigned int           __kernel_size_t32;
-typedef int                    __kernel_ssize_t32;
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
-typedef int                    __kernel_clock_t32;
-typedef int                    __kernel_pid_t32;
-typedef unsigned short         __kernel_ipc_pid_t32;
-typedef unsigned int           __kernel_uid_t32;
-typedef unsigned int           __kernel_gid_t32;
-typedef unsigned int           __kernel_dev_t32;
-typedef unsigned int           __kernel_ino_t32;
-typedef unsigned int           __kernel_mode_t32;
-typedef unsigned int           __kernel_umode_t32;
-typedef short                  __kernel_nlink_t32;
-typedef int                    __kernel_daddr_t32;
-typedef int                    __kernel_off_t32;
-typedef unsigned int           __kernel_caddr_t32;
-typedef int 		       __kernel_loff_t32;
-/* typedef __kernel_fsid_t        __kernel_fsid_t32; */
 
 struct statfs32 {
 	int f_type;
diff -ruN 2.5.22/include/asm-s390x/compat32.h 2.5.22-sfr.3/include/asm-s390x/compat32.h
--- 2.5.22/include/asm-s390x/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.22-sfr.3/include/asm-s390x/compat32.h	Sat Jun 15 00:58:48 2002
@@ -0,0 +1,11 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_S390X_COMPAT32_H
+#define ASM_S390X_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+typedef long		__kernel_loff_t32;
+
+#endif /* ASM_S390X_COMPAT32_H */
diff -ruN 2.5.22/include/asm-sparc64/compat32.h 2.5.22-sfr.3/include/asm-sparc64/compat32.h
--- 2.5.22/include/asm-sparc64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.22-sfr.3/include/asm-sparc64/compat32.h	Sat Jun 15 00:58:43 2002
@@ -0,0 +1,11 @@
+/*
+ * Support for the 32 bit compatibility layer.
+ */
+#ifndef ASM_SPARC64_COMPAT32_H
+#define ASM_SPARC64_COMPAT32_H
+
+#include <asm-generic/compat32.h>
+
+typedef long		__kernel_loff_t32;
+
+#endif /* ASM_SPARC64_COMPAT32_H */
diff -ruN 2.5.22/include/asm-sparc64/fcntl.h 2.5.22-sfr.3/include/asm-sparc64/fcntl.h
--- 2.5.22/include/asm-sparc64/fcntl.h	Mon Sep 24 05:13:18 2001
+++ 2.5.22-sfr.3/include/asm-sparc64/fcntl.h	Sat Jun 15 00:41:11 2002
@@ -79,6 +79,8 @@
 };
 
 #ifdef __KERNEL__
+#include <asm/compat32.h>
+
 struct flock32 {
 	short l_type;
 	short l_whence;
diff -ruN 2.5.22/include/asm-sparc64/posix_types.h 2.5.22-sfr.3/include/asm-sparc64/posix_types.h
--- 2.5.22/include/asm-sparc64/posix_types.h	Sat Oct 28 04:55:01 2000
+++ 2.5.22-sfr.3/include/asm-sparc64/posix_types.h	Fri Jun 14 22:49:41 2002
@@ -47,27 +47,6 @@
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-/* Now 32bit compatibility types */
-typedef unsigned int           __kernel_size_t32;
-typedef int                    __kernel_ssize_t32;
-typedef int                    __kernel_ptrdiff_t32;
-typedef int                    __kernel_time_t32;
-typedef int                    __kernel_clock_t32;
-typedef int                    __kernel_pid_t32;
-typedef unsigned short         __kernel_ipc_pid_t32;
-typedef unsigned short         __kernel_uid_t32;
-typedef unsigned short         __kernel_gid_t32;
-typedef unsigned short         __kernel_dev_t32;
-typedef unsigned int           __kernel_ino_t32;
-typedef unsigned short         __kernel_mode_t32;
-typedef unsigned short         __kernel_umode_t32;
-typedef short                  __kernel_nlink_t32;
-typedef int                    __kernel_daddr_t32;
-typedef int                    __kernel_off_t32;
-typedef unsigned int           __kernel_caddr_t32;
-typedef long		       __kernel_loff_t32;
-typedef __kernel_fsid_t        __kernel_fsid_t32;
-
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
 #undef __FD_SET
diff -ruN 2.5.22/include/asm-sparc64/siginfo.h 2.5.22-sfr.3/include/asm-sparc64/siginfo.h
--- 2.5.22/include/asm-sparc64/siginfo.h	Mon Jun  3 12:17:08 2002
+++ 2.5.22-sfr.3/include/asm-sparc64/siginfo.h	Sat Jun 15 00:42:31 2002
@@ -74,6 +74,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm-generic/compat32.h>
+
 typedef struct siginfo32 {
 	int si_signo;
 	int si_errno;
diff -ruN 2.5.22/include/asm-sparc64/signal.h 2.5.22-sfr.3/include/asm-sparc64/signal.h
--- 2.5.22/include/asm-sparc64/signal.h	Thu May 30 09:44:39 2002
+++ 2.5.22-sfr.3/include/asm-sparc64/signal.h	Sat Jun 15 00:43:07 2002
@@ -247,6 +247,9 @@
 } stack_t;
 
 #ifdef __KERNEL__
+
+#include <asm/compat32.h>
+
 typedef struct sigaltstack32 {
 	u32			ss_sp;
 	int			ss_flags;
diff -ruN 2.5.22/include/asm-sparc64/stat.h 2.5.22-sfr.3/include/asm-sparc64/stat.h
--- 2.5.22/include/asm-sparc64/stat.h	Sat Aug  5 11:16:11 2000
+++ 2.5.22-sfr.3/include/asm-sparc64/stat.h	Fri Jun 14 17:19:44 2002
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/time.h>
+#include <linux/compat32.h>
 
 struct stat32 {
 	__kernel_dev_t32   st_dev;
diff -ruN 2.5.22/include/asm-sparc64/statfs.h 2.5.22-sfr.3/include/asm-sparc64/statfs.h
--- 2.5.22/include/asm-sparc64/statfs.h	Thu Apr 24 12:01:28 1997
+++ 2.5.22-sfr.3/include/asm-sparc64/statfs.h	Sat Jun 15 00:43:57 2002
@@ -2,6 +2,8 @@
 #ifndef _SPARC64_STATFS_H
 #define _SPARC64_STATFS_H
 
+#include <asm/compat32.h>
+
 #ifndef __KERNEL_STRICT_NAMES
 
 #include <linux/types.h>
diff -ruN 2.5.22/include/asm-x86_64/compat32.h 2.5.22-sfr.3/include/asm-x86_64/compat32.h
--- 2.5.22/include/asm-x86_64/compat32.h	Thu Jan  1 10:00:00 1970
+++ 2.5.22-sfr.3/include/asm-x86_64/compat32.h	Sat Jun 15 00:20:10 2002
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
diff -ruN 2.5.22/include/asm-x86_64/ia32.h 2.5.22-sfr.3/include/asm-x86_64/ia32.h
--- 2.5.22/include/asm-x86_64/ia32.h	Tue Apr 23 10:42:33 2002
+++ 2.5.22-sfr.3/include/asm-x86_64/ia32.h	Fri Jun 14 23:14:40 2002
@@ -2,6 +2,7 @@
 #define _ASM_X86_64_IA32_H
 
 #include <linux/config.h>
+#include <asm/compat32.h>
 
 #ifdef CONFIG_IA32_EMULATION
 
@@ -10,26 +11,6 @@
  */
 
 /* 32bit compatibility types */
-typedef unsigned int	       __kernel_size_t32;
-typedef int		       __kernel_ssize_t32;
-typedef int		       __kernel_ptrdiff_t32;
-typedef int		       __kernel_time_t32;
-typedef int		       __kernel_clock_t32;
-typedef int		       __kernel_pid_t32;
-typedef unsigned short	       __kernel_ipc_pid_t32;
-typedef unsigned short	       __kernel_uid_t32;
-typedef unsigned short	       __kernel_gid_t32;
-typedef unsigned short	       __kernel_dev_t32;
-typedef unsigned int	       __kernel_ino_t32;
-typedef unsigned short	       __kernel_mode_t32;
-typedef unsigned short	       __kernel_umode_t32;
-typedef short		       __kernel_nlink_t32;
-typedef int		       __kernel_daddr_t32;
-typedef int		       __kernel_off_t32;
-typedef unsigned int	       __kernel_caddr_t32;
-typedef long		       __kernel_loff_t32;
-typedef __kernel_fsid_t	       __kernel_fsid_t32;
-
 
 /* fcntl.h */
 struct flock32 {
diff -ruN 2.5.22/include/asm-x86_64/socket32.h 2.5.22-sfr.3/include/asm-x86_64/socket32.h
--- 2.5.22/include/asm-x86_64/socket32.h	Wed Feb 20 16:36:51 2002
+++ 2.5.22-sfr.3/include/asm-x86_64/socket32.h	Sat Jun 15 00:46:24 2002
@@ -1,6 +1,8 @@
 #ifndef SOCKET32_H
 #define SOCKET32_H 1
 
+#include <asm/compat32.h>
+
 /* XXX This really belongs in some header file... -DaveM */
 #define MAX_SOCK_ADDR	128		/* 108 for Unix domain - 
 					   16 for IP, 16 for IPX,
