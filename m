Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVGEVNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVGEVNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 17:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVGEVNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 17:13:16 -0400
Received: from ozlabs.org ([203.10.76.45]:13763 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261965AbVGEVGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 17:06:55 -0400
Date: Wed, 6 Jul 2005 07:02:04 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: add ioprio syscalls
Message-ID: <20050705210204.GH12786@krispykreme>
References: <20050705205632.GF12786@krispykreme> <20050705205804.GG12786@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050705205804.GG12786@krispykreme>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Clean up sys32_getpriority comment.
- Add ioprio syscalls, and sign extend 32bit versions.

Signed-off-by: Anton Blanchard <anton@samba.org>

Index: linux-2.6.git-work/arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- linux-2.6.git-work.orig/arch/ppc64/kernel/sys_ppc32.c	2005-07-06 01:16:21.000000000 +1000
+++ linux-2.6.git-work/arch/ppc64/kernel/sys_ppc32.c	2005-07-06 01:16:35.000000000 +1000
@@ -822,16 +822,6 @@
 }
 
 
-/* Note: it is necessary to treat which and who as unsigned ints,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long sys32_getpriority(u32 which, u32 who)
-{
-	return sys_getpriority((int)which, (int)who);
-}
-
 
 /* Note: it is necessary to treat pid as an unsigned int,
  * with the corresponding cast to a signed int to insure that the 
@@ -1023,6 +1013,11 @@
 	return sys_setpgid((int)pid, (int)pgid);
 }
 
+long sys32_getpriority(u32 which, u32 who)
+{
+	/* sign extend which and who */
+	return sys_getpriority((int)which, (int)who);
+}
 
 long sys32_setpriority(u32 which, u32 who, u32 niceval)
 {
@@ -1030,6 +1025,18 @@
 	return sys_setpriority((int)which, (int)who, (int)niceval);
 }
 
+long sys32_ioprio_get(u32 which, u32 who)
+{
+	/* sign extend which and who */
+	return sys_ioprio_get((int)which, (int)who);
+}
+
+long sys32_ioprio_set(u32 which, u32 who, u32 ioprio)
+{
+	/* sign extend which, who and ioprio */
+	return sys_ioprio_set((int)which, (int)who, (int)ioprio);
+}
+
 /* Note: it is necessary to treat newmask as an unsigned int,
  * with the corresponding cast to a signed int to insure that the 
  * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
Index: linux-2.6.git-work/include/asm-ppc64/unistd.h
===================================================================
--- linux-2.6.git-work.orig/include/asm-ppc64/unistd.h	2005-07-06 01:16:17.000000000 +1000
+++ linux-2.6.git-work/include/asm-ppc64/unistd.h	2005-07-06 01:16:35.000000000 +1000
@@ -283,8 +283,10 @@
 #define __NR_request_key	270
 #define __NR_keyctl		271
 #define __NR_waitid		272
+#define __NR_ioprio_set		273
+#define __NR_ioprio_get		274
 
-#define __NR_syscalls		273
+#define __NR_syscalls		275
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
Index: linux-2.6.git-work/arch/ppc64/kernel/misc.S
===================================================================
--- linux-2.6.git-work.orig/arch/ppc64/kernel/misc.S	2005-07-06 01:04:40.000000000 +1000
+++ linux-2.6.git-work/arch/ppc64/kernel/misc.S	2005-07-06 01:16:35.000000000 +1000
@@ -1124,9 +1124,11 @@
 	.llong .compat_sys_mq_getsetattr
 	.llong .compat_sys_kexec_load
 	.llong .sys32_add_key
-	.llong .sys32_request_key
+	.llong .sys32_request_key	/* 270 */
 	.llong .compat_sys_keyctl
 	.llong .compat_sys_waitid
+	.llong .sys32_ioprio_set
+	.llong .sys32_ioprio_get
 
 	.balign 8
 _GLOBAL(sys_call_table)
@@ -1403,3 +1405,5 @@
 	.llong .sys_request_key		/* 270 */
 	.llong .sys_keyctl
 	.llong .sys_waitid
+	.llong .sys_ioprio_set
+	.llong .sys_ioprio_get
