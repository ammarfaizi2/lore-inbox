Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUIJNqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUIJNqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 09:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUIJNqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 09:46:25 -0400
Received: from mail.renesas.com ([202.234.163.13]:20634 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S267408AbUIJNqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 09:46:13 -0400
Date: Fri, 10 Sep 2004 22:45:54 +0900 (JST)
Message-Id: <20040910.224554.43002845.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm4] [m32r] Update headers to remove useless
 iBCS2 support code
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch to update headers, elf.h and poll.h, to remove 
useless iBCS2/SVR4 support code for m32r.

This patch is against 2.6.9-rc1-mm4.
Please apply.

From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.9-rc1-mm3] [m32r] Modify sys_ipc() to remove useless iBCS2 support code
Date: Mon, 6 Sep 2004 22:08:07 +0100
> On Mon, Sep 06, 2004 at 02:02:09PM -0700, Andrew Morton wrote:
> > Hirokazu Takata <takata@linux-m32r.org> wrote:
> > >
> > > The useless iBCS2 supporting code is removed.
> > 
> > I didn't really understand what Christoph was saying about this one, so
> > I'll apply it for now.
> 
> iBCS2 is a standard for binary compatiblity on x86.  The x86 SysV IPC code
> has hacks in there so it could be used by applications for x86 SVR3/4 system
> under binary emulation aswell.  This is obviously useless for any non-x86
> port, but lots of people blindly copied it.
> 

	* arch/m32r/elf.h:
	- SET_PERSONALITY: Remove PER_SVR4; m32r should not support it.
	- Update comments.

	* arch/m32r/poll.h:
	- POLLREMOVE: Add definition.
	- Remove comments about ibcs2, and so on.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/elf.h  |   75 ++++++++++++++++++++++--------------------------
 include/asm-m32r/poll.h |   12 ++++---
 2 files changed, 42 insertions(+), 45 deletions(-)


diff -rup linux-2.6.9-rc1-mm4.orig/include/asm-m32r/elf.h linux-2.6.9-rc1-mm4.remove_ibcs2_code/include/asm-m32r/elf.h
--- linux-2.6.9-rc1-mm4.orig/include/asm-m32r/elf.h	2004-09-08 08:14:17.000000000 +0900
+++ linux-2.6.9-rc1-mm4.remove_ibcs2_code/include/asm-m32r/elf.h	2004-09-10 21:52:20.000000000 +0900
@@ -1,16 +1,16 @@
 #ifndef _ASM_M32R__ELF_H
 #define _ASM_M32R__ELF_H
 
-/* $Id$ */
-
-/*
- * ELF register definitions..
- */
+/*
+ * ELF-specific definitions.
+ *
+ * Copyright (C) 1999-2004, Renesas Technology Corp.
+ *      Hirokazu Takata <takata at linux-m32r.org>
+ */
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
-
-#include <linux/utsname.h>
+#include <asm/page.h>
 
 /* M32R relocation types  */
 #define	R_M32R_NONE		0
@@ -48,7 +48,7 @@
 #define R_M32R_HI16_SLO_RELA	R_M32R_HI16_SLO
 #define R_M32R_LO16_RELA	R_M32R_LO16
 #define R_M32R_SDA16_RELA	R_M32R_SDA16
-#else /* OLD_TYPE */
+#else /* not OLD_TYPE */
 #define	R_M32R_GNU_VTINHERIT	11
 #define	R_M32R_GNU_VTENTRY	12
 
@@ -92,14 +92,16 @@
 #define R_M32R_GOTPC_HI_ULO	59
 #define R_M32R_GOTPC_HI_SLO	60
 #define R_M32R_GOTPC_LO		61
-
-#endif /* OLD_TYPE */
+#endif /* not OLD_TYPE */
 
 #define R_M32R_NUM		256
 
-typedef unsigned long elf_greg_t;
-
+/*
+ * ELF register definitions..
+ */
 #define ELF_NGREG (sizeof (struct pt_regs) / sizeof(elf_greg_t))
+
+typedef unsigned long elf_greg_t;
 typedef elf_greg_t elf_gregset_t[ELF_NGREG];
 
 /* We have no FP mumumu.  */
@@ -125,28 +127,27 @@ typedef elf_fpreg_t elf_fpregset_t;
 #endif
 #define ELF_ARCH	EM_M32R
 
-/* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program starts %edx
-   contains a pointer to a function which might be registered using `atexit'.
-   This provides a mean for the dynamic linker to call DT_FINI functions for
-   shared libraries that have been loaded before the code runs.
-
-   A value of 0 tells we have no such handler.
-
-   We might as well make sure everything else is cleared too (except for %esp),
-   just to make things more deterministic.
+/* r0 is set by ld.so to a pointer to a function which might be
+ * registered using 'atexit'.  This provides a mean for the dynamic
+ * linker to call DT_FINI functions for shared libraries that have
+ * been loaded before the code runs.
+ *
+ * So that we can use the same startup file with static executables,
+ * we start programs with a value of 0 to indicate that there is no
+ * such function.
  */
-#define ELF_PLAT_INIT(_r, load_addr)	do { \
-	_r->r0 = 0; \
-} while (0)
+#define ELF_PLAT_INIT(_r, load_addr)	(_r)->r0 = 0
 
 #define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE	4096
-
-/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
-   use of this is to invoke "./ld.so someprog" to test out a new version of
-   the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
+#define ELF_EXEC_PAGESIZE	PAGE_SIZE
 
+/*
+ * This is the location that an ET_DYN program is loaded if exec'ed.
+ * Typical use of this is to invoke "./ld.so someprog" to test out a
+ * new version of the loader.  We need to make sure that it is out of
+ * the way of the program that it will "exec", and that there is
+ * sufficient room for the brk.
+ */
 #define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
 
 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
@@ -156,22 +157,16 @@ typedef elf_fpreg_t elf_fpregset_t;
 	memcpy((char *)&pr_reg, (char *)&regs, sizeof (struct pt_regs));
 
 /* This yields a mask that user programs can use to figure out what
-   instruction set this CPU supports.  This could be done in user space,
-   but it's not easy, and we've already done it here.  */
-
+   instruction set this CPU supports.  */
 #define ELF_HWCAP	(0)
 
 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in
-   intent than poking at uname or /proc/cpuinfo.
-
-   For the moment, we have only optimizations for the Intel generations,
-   but that could change... */
-
-#define ELF_PLATFORM  (NULL)
+   intent than poking at uname or /proc/cpuinfo.  */
+#define ELF_PLATFORM	(NULL)
 
 #ifdef __KERNEL__
-#define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#define SET_PERSONALITY(ex, ibcs2) set_personality(PER_LINUX)
 #endif
 
 #endif  /* _ASM_M32R__ELF_H */
diff -rup linux-2.6.9-rc1-mm4.orig/include/asm-m32r/poll.h linux-2.6.9-rc1-mm4.remove_ibcs2_code/include/asm-m32r/poll.h
--- linux-2.6.9-rc1-mm4.orig/include/asm-m32r/poll.h	2004-09-08 08:14:17.000000000 +0900
+++ linux-2.6.9-rc1-mm4.remove_ibcs2_code/include/asm-m32r/poll.h	2004-09-10 21:52:15.000000000 +0900
@@ -1,11 +1,13 @@
 #ifndef _ASM_M32R_POLL_H
 #define _ASM_M32R_POLL_H
 
-/* $Id$ */
+/*
+ * poll(2) bit definitions.  Based on <asm-i386/poll.h>.
+ *
+ * Modified 2004
+ *      Hirokazu Takata <takata at linux-m32r.org>
+ */
 
-/* orig : i386 2.4.18 */
-
-/* These are specified by iBCS2 */
 #define POLLIN		0x0001
 #define POLLPRI		0x0002
 #define POLLOUT		0x0004
@@ -13,12 +15,12 @@
 #define POLLHUP		0x0010
 #define POLLNVAL	0x0020
 
-/* The rest seem to be more-or-less nonstandard. Check them! */
 #define POLLRDNORM	0x0040
 #define POLLRDBAND	0x0080
 #define POLLWRNORM	0x0100
 #define POLLWRBAND	0x0200
 #define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
 
 struct pollfd {
 	int fd;

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
