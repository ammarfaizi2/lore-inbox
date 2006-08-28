Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWH1OGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWH1OGX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWH1OGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:06:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:489 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750790AbWH1OGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:06:22 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 6/7] remove all remaining _syscallX macros
Date: Mon, 28 Aug 2006 16:05:58 +0200
User-Agent: KMail/1.9.1
Cc: Andi Kleen <ak@suse.de>, David Miller <davem@davemloft.net>,
       linux-arch@vger.kernel.org, jdike@addtoit.com, B.Steinbrink@gmx.de,
       arjan@infradead.org, chase.venters@clientec.com, akpm@osdl.org,
       rmk+lkml@arm.linux.org.uk, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
References: <200608281003.02757.ak@suse.de> <200608281053.11142.ak@suse.de> <1156759232.5340.36.camel@pmac.infradead.org>
In-Reply-To: <1156759232.5340.36.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608281606.00602.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 August 2006 12:00, David Woodhouse wrote:
> I'm trying to 'suddenly redefine' kernel headers as something that
> _isn't_ just a library of random crap for people to abuse in userspace
> as they see fit, then whine when something breaks even though it was
> never really guaranteed to work when abused in that way anyway.

Well, there are two points to consider here:

1. There is user space source code out that that used these macros
   in the past, without feeling ashamed of it. It's fairly well-documented
   and seems to be a common way for inexperienced people to use syscalls
   before they get formal libc support.

2. There is a long history of bugs with these calls. The version with more
   than 5 arguments is missing on some platforms, the assembly constraints
   break if your gcc is too old or too new, it doesn't work at all on
   non-gcc compiles, and libc and kernel are normally out of sync.
   Expect any platform other than x86 to be broken ;-).

The patch below should address both these issues, as long as the libc
has a working implementation of syscall(2).

Of course, if Andi prefers, we can do this for all architectures except
x86 and let him keep the old code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/include/asm-alpha/unistd.h
===================================================================
--- linux-cg.orig/include/asm-alpha/unistd.h	2006-08-28 11:08:52.000000000 +0200
+++ linux-cg/include/asm-alpha/unistd.h	2006-08-28 15:41:56.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ALPHA_UNISTD_H
 #define _ALPHA_UNISTD_H
 
+#include <asm-generic/unistd.h>
+
 #define __NR_osf_syscall	  0	/* not implemented */
 #define __NR_exit		  1
 #define __NR_fork		  2
Index: linux-cg/include/asm-arm/unistd.h
===================================================================
--- linux-cg.orig/include/asm-arm/unistd.h	2006-08-28 11:08:52.000000000 +0200
+++ linux-cg/include/asm-arm/unistd.h	2006-08-28 15:42:04.000000000 +0200
@@ -13,6 +13,8 @@
 #ifndef __ASM_ARM_UNISTD_H
 #define __ASM_ARM_UNISTD_H
 
+#include <asm-generic/unistd.h>
+
 #define __NR_OABI_SYSCALL_BASE	0x900000
 
 #if defined(__thumb__) || defined(__ARM_EABI__)
Index: linux-cg/include/asm-arm26/unistd.h
===================================================================
--- linux-cg.orig/include/asm-arm26/unistd.h	2006-08-28 11:08:52.000000000 +0200
+++ linux-cg/include/asm-arm26/unistd.h	2006-08-28 15:42:09.000000000 +0200
@@ -14,6 +14,8 @@
 #ifndef __ASM_ARM_UNISTD_H
 #define __ASM_ARM_UNISTD_H
 
+#include <asm-generic/unistd.h>
+
 #define __NR_SYSCALL_BASE	0x900000
 
 /*
Index: linux-cg/include/asm-cris/unistd.h
===================================================================
--- linux-cg.orig/include/asm-cris/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-cris/unistd.h	2006-08-28 15:42:20.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _ASM_CRIS_UNISTD_H_
 #define _ASM_CRIS_UNISTD_H_
 
+#include <asm-generic/unistd.h>
 #include <asm/arch/unistd.h>
 
 /*
Index: linux-cg/include/asm-frv/unistd.h
===================================================================
--- linux-cg.orig/include/asm-frv/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-frv/unistd.h	2006-08-28 15:42:26.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_UNISTD_H_
 #define _ASM_UNISTD_H_
 
+#include <asm-generic/unistd.h>
+
 /*
  * This file contains the system call numbers.
  */
Index: linux-cg/include/asm-generic/Kbuild
===================================================================
--- linux-cg.orig/include/asm-generic/Kbuild	2006-08-28 15:39:39.000000000 +0200
+++ linux-cg/include/asm-generic/Kbuild	2006-08-28 15:39:52.000000000 +0200
@@ -1,3 +1,3 @@
 header-y += atomic.h errno-base.h errno.h fcntl.h ioctl.h ipc.h mman.h \
-	signal.h statfs.h
+	signal.h statfs.h unistd.h
 unifdef-y := resource.h siginfo.h
Index: linux-cg/include/asm-generic/unistd.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cg/include/asm-generic/unistd.h	2006-08-28 15:58:37.000000000 +0200
@@ -0,0 +1,76 @@
+#ifndef __ASM_GENERIC_UNISTD_H
+#define __ASM_GENERIC_UNISTD_H
+
+#ifndef __KERNEL__
+#include <sys/syscall.h>
+
+/*
+ * Applications should never rely on these macros, but instead
+ * use the syscall(2) function from libc.
+ *
+ * The purpose of the _syscallX() function is to generate a
+ * gcc warning about this.
+ */
+#ifdef __GNUC__
+static inline void __attribute__((deprecated)) _syscallX(void) { }
+#else
+static inline void _syscallX(void) { }
+#endif
+
+#define _syscall0(type, name)						\
+type name(void)								\
+{									\
+	_syscallX();							\
+	return (type)syscall(__NR_ ## name);				\
+}
+
+#define _syscall1(type, name, type1, arg1)				\
+type name(type1 arg1)							\
+{									\
+	_syscallX();							\
+	return (type)syscall(__NR_ ## name, arg1);			\
+}
+
+#define _syscall2(type, name, type1, arg1, type2, arg2)			\
+type name(type1 arg1, type2 arg2)					\
+{									\
+	_syscallX();							\
+	return (type)syscall(__NR_ ## name, arg1, arg2);		\
+}
+
+#define _syscall3(type, name, type1, arg1, type2, arg2, type3, arg3)	\
+type name(type1 arg1, type2 arg2, type3 arg3)				\
+{									\
+	_syscallX();							\
+	return (type)syscall(__NR_ ## name, arg1, arg2, arg3);		\
+}
+
+#define _syscall4(type, name, type1, arg1, type2, arg2, type3, arg3,	\
+			      type4, arg4)				\
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4)		\
+{									\
+	_syscallX();							\
+	return (type)syscall(__NR_ ## name, arg1, arg2, arg3, arg4)	\
+}
+
+#define _syscall5(type, name, type1, arg1, type2, arg2, type3, arg3,	\
+			      type4, arg4, type5, arg5)			\
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
+{									\
+	_syscallX();							\
+	return (type)syscall(__NR_ ## name, arg1, arg2, arg3,		\
+					    arg4, arg5);		\
+}
+
+#define _syscall6(type, name, type1, arg1, type2, arg2, type3, arg3,	\
+			      type4, arg4, type5, arg5, type6, arg6)	\
+type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5,	\
+							  type6 arg6)	\
+{									\
+	_syscallX();							\
+	return (type)syscall(__NR_ ## name, arg1, arg2, arg3,		\
+					    arg4, arg5, arg6);		\
+}
+
+#endif
+#endif
Index: linux-cg/include/asm-h8300/unistd.h
===================================================================
--- linux-cg.orig/include/asm-h8300/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-h8300/unistd.h	2006-08-28 15:42:34.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_H8300_UNISTD_H_
 #define _ASM_H8300_UNISTD_H_
 
+#include <asm-generic/unistd.h>
+
 /*
  * This file contains the system call numbers.
  */
Index: linux-cg/include/asm-i386/unistd.h
===================================================================
--- linux-cg.orig/include/asm-i386/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-i386/unistd.h	2006-08-28 15:42:37.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_I386_UNISTD_H_
 #define _ASM_I386_UNISTD_H_
 
+#include <asm-generic/unistd.h>
+
 /*
  * This file contains the system call numbers.
  */
Index: linux-cg/include/asm-ia64/unistd.h
===================================================================
--- linux-cg.orig/include/asm-ia64/unistd.h	2006-08-28 11:08:53.000000000 +0200
+++ linux-cg/include/asm-ia64/unistd.h	2006-08-28 15:42:46.000000000 +0200
@@ -9,6 +9,7 @@
  */
 
 #include <asm/break.h>
+#include <asm-generic/unistd.h>
 
 #define __BREAK_SYSCALL			__IA64_BREAK_SYSCALL
 
Index: linux-cg/include/asm-m32r/unistd.h
===================================================================
--- linux-cg.orig/include/asm-m32r/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-m32r/unistd.h	2006-08-28 15:42:55.000000000 +0200
@@ -4,6 +4,7 @@
 /* $Id$ */
 
 #include <asm/syscall.h>	/* SYSCALL_* */
+#include <asm-generic/unistd.h>
 
 /*
  * This file contains the system call numbers.
Index: linux-cg/include/asm-m68k/unistd.h
===================================================================
--- linux-cg.orig/include/asm-m68k/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-m68k/unistd.h	2006-08-28 15:42:59.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_M68K_UNISTD_H_
 #define _ASM_M68K_UNISTD_H_
 
+#include <asm-generic/unistd.h>
+
 /*
  * This file contains the system call numbers.
  */
Index: linux-cg/include/asm-m68knommu/unistd.h
===================================================================
--- linux-cg.orig/include/asm-m68knommu/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-m68knommu/unistd.h	2006-08-28 15:43:02.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_M68K_UNISTD_H_
 #define _ASM_M68K_UNISTD_H_
 
+#include <asm-generic/unistd.h>
+
 /*
  * This file contains the system call numbers.
  */
Index: linux-cg/include/asm-mips/unistd.h
===================================================================
--- linux-cg.orig/include/asm-mips/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-mips/unistd.h	2006-08-28 15:43:08.000000000 +0200
@@ -13,6 +13,7 @@
 #define _ASM_UNISTD_H
 
 #include <asm/sgidefs.h>
+#include <asm-generic/unistd.h>
 
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
Index: linux-cg/include/asm-parisc/unistd.h
===================================================================
--- linux-cg.orig/include/asm-parisc/unistd.h	2006-08-28 11:08:52.000000000 +0200
+++ linux-cg/include/asm-parisc/unistd.h	2006-08-28 15:43:12.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_PARISC_UNISTD_H_
 #define _ASM_PARISC_UNISTD_H_
 
+#include <asm-generic/unistd.h>
+
 /*
  * This file contains the system call numbers.
  */
Index: linux-cg/include/asm-powerpc/unistd.h
===================================================================
--- linux-cg.orig/include/asm-powerpc/unistd.h	2006-08-28 11:08:52.000000000 +0200
+++ linux-cg/include/asm-powerpc/unistd.h	2006-08-28 15:43:14.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_PPC_UNISTD_H_
 #define _ASM_PPC_UNISTD_H_
 
+#include <asm-generic/unistd.h>
+
 /*
  * This file contains the system call numbers.
  *
Index: linux-cg/include/asm-s390/unistd.h
===================================================================
--- linux-cg.orig/include/asm-s390/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-s390/unistd.h	2006-08-28 15:43:19.000000000 +0200
@@ -9,6 +9,8 @@
 #ifndef _ASM_S390_UNISTD_H_
 #define _ASM_S390_UNISTD_H_
 
+#include <asm-generic/unistd.h>
+
 /*
  * This file contains the system call numbers.
  */
Index: linux-cg/include/asm-sh/unistd.h
===================================================================
--- linux-cg.orig/include/asm-sh/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-sh/unistd.h	2006-08-28 15:43:23.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __ASM_SH_UNISTD_H
 #define __ASM_SH_UNISTD_H
 
+#include <asm-generic/unistd.h>
+
 /*
  * Copyright (C) 1999  Niibe Yutaka
  */
Index: linux-cg/include/asm-sh64/unistd.h
===================================================================
--- linux-cg.orig/include/asm-sh64/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-sh64/unistd.h	2006-08-28 15:43:27.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef __ASM_SH64_UNISTD_H
 #define __ASM_SH64_UNISTD_H
 
+#include <asm-generic/unistd.h>
+
 /*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
Index: linux-cg/include/asm-sparc/unistd.h
===================================================================
--- linux-cg.orig/include/asm-sparc/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-sparc/unistd.h	2006-08-28 15:43:31.000000000 +0200
@@ -2,6 +2,8 @@
 #ifndef _SPARC_UNISTD_H
 #define _SPARC_UNISTD_H
 
+#include <asm-generic/unistd.h>
+
 /*
  * System calls under the Sparc.
  *
Index: linux-cg/include/asm-sparc64/unistd.h
===================================================================
--- linux-cg.orig/include/asm-sparc64/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-sparc64/unistd.h	2006-08-28 15:43:34.000000000 +0200
@@ -2,6 +2,8 @@
 #ifndef _SPARC64_UNISTD_H
 #define _SPARC64_UNISTD_H
 
+#include <asm-generic/unistd.h>
+
 /*
  * System calls under the Sparc.
  *
Index: linux-cg/include/asm-v850/unistd.h
===================================================================
--- linux-cg.orig/include/asm-v850/unistd.h	2006-08-28 15:21:50.000000000 +0200
+++ linux-cg/include/asm-v850/unistd.h	2006-08-28 15:44:07.000000000 +0200
@@ -14,6 +14,8 @@
 #ifndef __V850_UNISTD_H__
 #define __V850_UNISTD_H__
 
+#include <asm-generic/unistd.h>
+
 #define __NR_restart_syscall	  0
 #define __NR_exit		  1
 #define __NR_fork		  2
Index: linux-cg/include/asm-x86_64/unistd.h
===================================================================
--- linux-cg.orig/include/asm-x86_64/unistd.h	2006-08-28 11:08:52.000000000 +0200
+++ linux-cg/include/asm-x86_64/unistd.h	2006-08-28 15:44:11.000000000 +0200
@@ -1,6 +1,8 @@
 #ifndef _ASM_X86_64_UNISTD_H_
 #define _ASM_X86_64_UNISTD_H_
 
+#include <asm-generic/unistd.h>
+
 #ifndef __SYSCALL
 #define __SYSCALL(a,b) 
 #endif
Index: linux-cg/include/asm-xtensa/unistd.h
===================================================================
--- linux-cg.orig/include/asm-xtensa/unistd.h	2006-08-28 15:21:51.000000000 +0200
+++ linux-cg/include/asm-xtensa/unistd.h	2006-08-28 15:44:15.000000000 +0200
@@ -11,6 +11,8 @@
 #ifndef _XTENSA_UNISTD_H
 #define _XTENSA_UNISTD_H
 
+#include <asm-generic/unistd.h>
+
 #define __NR_spill		  0
 #define __NR_exit		  1
 #define __NR_read		  3
