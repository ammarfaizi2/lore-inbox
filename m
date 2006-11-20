Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966332AbWKTSKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966332AbWKTSKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934286AbWKTSHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:07:10 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:31482 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934277AbWKTSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:06:59 -0500
Message-Id: <20061120180520.902060000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:44:56 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 02/22] powerpc: change ppc_rtas declaration to weak
Content-Disposition: inline; filename=spufs-fix-weak-symbols-3.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geoff Levand <geoffrey.levand@am.sony.com>
Change the definition of powerpc's cond_syscall() to use the standard gcc
weak attribute specifier which provides proper support for C linkage as
needed by spu_syscall_table[].

Fixes this powerpc build error with CONFIG_SPU_FS=y, CONFIG_PPC_RTAS=n:

 arch/powerpc/platforms/built-in.o: undefined reference to `ppc_rtas'


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 include/asm-powerpc/unistd.h |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

Index: linux-2.6/include/asm-powerpc/unistd.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/unistd.h
+++ linux-2.6/include/asm-powerpc/unistd.h
@@ -446,7 +446,6 @@ type name(type1 arg1, type2 arg2, type3 
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/linkage.h>
-#include <asm/syscalls.h>
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
@@ -481,16 +480,9 @@ type name(type1 arg1, type2 arg2, type3 
 
 /*
  * "Conditional" syscalls
- *
- * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
- * but it doesn't work on all toolchains, so we just do it by hand
  */
-#ifdef CONFIG_PPC32
-#define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
-#else
-#define cond_syscall(x) asm(".weak\t." #x "\n\t.set\t." #x ",.sys_ni_syscall")
-#endif
-
+#define cond_syscall(x) \
+	asmlinkage long x (void) __attribute__((weak,alias("sys_ni_syscall")))
 
 #endif		/* __ASSEMBLY__ */
 #endif		/* __KERNEL__ */

--

