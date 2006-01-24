Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWAXBSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWAXBSR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWAXBR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:17:58 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:61613 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030250AbWAXBRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:17:52 -0500
Date: Mon, 23 Jan 2006 20:16:26 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 7/9] ia32 syscalls: switch x86_64 to new table
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Jeff Dike <jdike@addtoit.com>
Message-ID: <200601232017_MC3-1-B683-9F3F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <200601231938_MC3-1-B687-7C42@compuserve.com>
In-Reply-To: <200601231938_MC3-1-B687-7C42@compuserve.com>

Shared ia32 syscall table 7/9:

Switch x86_64 to the new ia32 syscall table.
Some functions need to be overridden.

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/x86_64/ia32/ia32entry.S     |   40 +++++++++++++++++++++++++++++++++++++++
 include/asm-x86_64/ia32_unistd.h |    7 ++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

--- 2.6.16-rc1-mm2.orig/arch/x86_64/ia32/ia32entry.S
+++ 2.6.16-rc1-mm2/arch/x86_64/ia32/ia32entry.S
@@ -373,6 +373,47 @@
 	.align 8
 	.globl ia32_sys_call_table
 ia32_sys_call_table:
+
+#define syscall_ptr_type	.quad
+#define SYSCALL(func)		RAWSYSCALL(sys_ ## func)
+#define SYS32CALL(func)		RAWSYSCALL(sys32_ ## func)
+#define STUB32CALL(func)	RAWSYSCALL(stub32_ ## func)
+#define COMPATCALL(func)	RAWSYSCALL(compat_sys_ ## func)
+
+/*
+ * Don't allow uselib() if a.out support is disabled.
+ */
+#ifndef CONFIG_IA32_AOUT
+#  define sys_uselib		sys32_ni_syscall
+#endif
+
+/*
+ * Two function names do not match i386.
+ */
+#define old_readdir		compat_sys_old_readdir
+#define compat_sys_fcntl	compat_sys_fcntl64
+
+/*
+ * vm86 is not possible on x86_64.
+ */
+#define sys32_vm86old		sys32_vm86_warning
+#define sys32_vm86		sys32_vm86_warning
+
+/*
+ * bdflush is unsupported
+ */
+#define sys_bdflush		sys32_ni_syscall
+
+/*
+ * Not implemented on this arch yet.
+ */
+#define sys_pselect6		sys32_ni_syscall
+#define sys_ppoll		sys32_ni_syscall
+#define sys_epoll_pwait		sys32_ni_syscall
+
+#include "../../i386/kernel/syscall_tbl.S"
+
+#if 0
 	.quad sys_restart_syscall
 	.quad sys_exit
 	.quad stub32_fork
@@ -686,6 +727,10 @@
 	.quad sys_fchmodat
 	.quad sys_faccessat
 	.quad sys_unshare
+#endif
+
+/* RED-PEN: find a way to determine IA32_NR_syscalls automatically */
+
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
 		.quad ni_syscall
--- 2.6.16-rc1-mm2.orig/include/asm-x86_64/ia32_unistd.h
+++ 2.6.16-rc1-mm2/include/asm-x86_64/ia32_unistd.h
@@ -313,8 +313,11 @@
 #define __NR_ia32_readlinkat		305
 #define __NR_ia32_fchmodat		306
 #define __NR_ia32_faccessat		307
-#define __NR_ia32_unshare		308
+#define __NR_ia32_pselect6		308
+#define __NR_ia32_ppoll			309
+#define __NR_ia32_unshare		310
+#define __NR_ia32_epoll_pwait		311
 
-#define IA32_NR_syscalls 309	/* must be > than biggest syscall! */
+#define IA32_NR_syscalls 312	/* must be > than biggest syscall! */
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
-- 
Chuck
