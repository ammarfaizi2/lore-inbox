Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161424AbWJKVIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161424AbWJKVIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161425AbWJKVH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:07:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:21408 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161420AbWJKVGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:48 -0400
Date: Wed, 11 Oct 2006 14:06:24 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Woodhouse <dwmw2@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 35/67] Clean up exported headers on CRIS
Message-ID: <20061011210624.GJ16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0013-Clean-up-exported-headers-on-CRIS.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Woodhouse <dwmw2@infradead.org>

This fixes most of the issues with exported headers on CRIS, although
we do still need to deal with the asm/arch symlink.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-cris/Kbuild          |    4 ++++
 include/asm-cris/arch-v10/Kbuild |    2 ++
 include/asm-cris/arch-v32/Kbuild |    2 ++
 include/asm-cris/byteorder.h     |    3 ++-
 include/asm-cris/elf.h           |    8 +++++---
 include/asm-cris/page.h          |    8 ++++----
 include/asm-cris/posix_types.h   |    9 +++------
 include/asm-cris/unistd.h        |    4 +---
 8 files changed, 23 insertions(+), 17 deletions(-)

--- linux-2.6.18.orig/include/asm-cris/Kbuild
+++ linux-2.6.18/include/asm-cris/Kbuild
@@ -1 +1,5 @@
 include include/asm-generic/Kbuild.asm
+
+header-y += arch-v10/ arch-v32/
+
+unifdef-y += rs485.h
--- /dev/null
+++ linux-2.6.18/include/asm-cris/arch-v10/Kbuild
@@ -0,0 +1,2 @@
+header-y += ptrace.h
+header-y += user.h
--- /dev/null
+++ linux-2.6.18/include/asm-cris/arch-v32/Kbuild
@@ -0,0 +1,2 @@
+header-y += ptrace.h
+header-y += user.h
--- linux-2.6.18.orig/include/asm-cris/byteorder.h
+++ linux-2.6.18/include/asm-cris/byteorder.h
@@ -3,14 +3,15 @@
 
 #ifdef __GNUC__
 
+#ifdef __KERNEL__
 #include <asm/arch/byteorder.h>
 
 /* defines are necessary because the other files detect the presence
  * of a defined __arch_swab32, not an inline
  */
-
 #define __arch__swab32(x) ___arch__swab32(x)
 #define __arch__swab16(x) ___arch__swab16(x)
+#endif /* __KERNEL__ */
 
 #if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
 #  define __BYTEORDER_HAS_U64__
--- linux-2.6.18.orig/include/asm-cris/elf.h
+++ linux-2.6.18/include/asm-cris/elf.h
@@ -5,7 +5,6 @@
  * ELF register definitions..
  */
 
-#include <asm/arch/elf.h>
 #include <asm/user.h>
 
 #define R_CRIS_NONE             0
@@ -46,6 +45,9 @@ typedef unsigned long elf_fpregset_t;
 #define ELF_DATA	ELFDATA2LSB
 #define ELF_ARCH	EM_CRIS
 
+#ifdef __KERNEL__
+#include <asm/arch/elf.h>
+
 /* The master for these definitions is {binutils}/include/elf/cris.h:  */
 /* User symbols in this file have a leading underscore.  */
 #define EF_CRIS_UNDERSCORE		0x00000001
@@ -87,8 +89,8 @@ typedef unsigned long elf_fpregset_t;
 
 #define ELF_PLATFORM  (NULL)
 
-#ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
-#endif
+
+#endif /* __KERNEL__ */
 
 #endif
--- linux-2.6.18.orig/include/asm-cris/page.h
+++ linux-2.6.18/include/asm-cris/page.h
@@ -1,6 +1,8 @@
 #ifndef _CRIS_PAGE_H
 #define _CRIS_PAGE_H
 
+#ifdef __KERNEL__
+
 #include <asm/arch/page.h>
 
 /* PAGE_SHIFT determines the page size */
@@ -12,8 +14,6 @@
 #endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
-#ifdef __KERNEL__
-
 #define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
 #define copy_page(to,from)      memcpy((void *)(to), (void *)(from), PAGE_SIZE)
 
@@ -73,10 +73,10 @@ typedef struct { unsigned long pgprot; }
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#endif /* __KERNEL__ */
-
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#endif /* __KERNEL__ */
+
 #endif /* _CRIS_PAGE_H */
 
--- linux-2.6.18.orig/include/asm-cris/posix_types.h
+++ linux-2.6.18/include/asm-cris/posix_types.h
@@ -6,8 +6,6 @@
 #ifndef __ARCH_CRIS_POSIX_TYPES_H
 #define __ARCH_CRIS_POSIX_TYPES_H
 
-#include <asm/bitops.h>
-
 /*
  * This file is generally used by user-level software, so you need to
  * be a little careful about namespace pollution etc.  Also, we cannot
@@ -53,9 +51,8 @@ typedef struct {
 #endif /* !defined(__KERNEL__) && !defined(__USE_ALL) */
 } __kernel_fsid_t;
 
-/* should this ifdef be here ?  */
-
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
+#ifdef __KERNEL__
+#include <asm/bitops.h>
 
 #undef	__FD_SET
 #define __FD_SET(fd,fdsetp) set_bit(fd, (void *)(fdsetp))
@@ -69,6 +66,6 @@ typedef struct {
 #undef	__FD_ZERO
 #define __FD_ZERO(fdsetp) memset((void *)(fdsetp), 0, __FDSET_LONGS << 2)
 
-#endif /* defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2) */
+#endif /* __KERNEL__ */
 
 #endif /* __ARCH_CRIS_POSIX_TYPES_H */
--- linux-2.6.18.orig/include/asm-cris/unistd.h
+++ linux-2.6.18/include/asm-cris/unistd.h
@@ -1,8 +1,6 @@
 #ifndef _ASM_CRIS_UNISTD_H_
 #define _ASM_CRIS_UNISTD_H_
 
-#include <asm/arch/unistd.h>
-
 /*
  * This file contains the system call numbers, and stub macros for libc.
  */
@@ -299,6 +297,7 @@
 
 #define NR_syscalls 289
 
+#include <asm/arch/unistd.h>
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
@@ -322,7 +321,6 @@
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
-#endif
 
 #ifdef __KERNEL_SYSCALLS__
 

--
