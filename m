Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUAWP6p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266577AbUAWP6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:58:45 -0500
Received: from smtp3.libero.it ([193.70.192.127]:60643 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S266574AbUAWP6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:58:39 -0500
From: Danilo Piazzalunga <danilopiazza@libero.it>
Subject: [PATCH] hardcoded errno numbers in assembly code
Date: Fri, 23 Jan 2004 16:58:32 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401231658.33190.danilopiazza@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Some assembly code (on various archs) either 
 1. uses hardcoded errno numbers instead of the canonical macro names, or
 2. defines them locally, instead of including the appropriate header (while 
including other headers).

This patch "fixes" such usage in
 - getuser.S for arm, arm26 and i386
 - putuser.S for arm and arm26
 - entry.S for h8300 and sh

Version: 2.6.2-rc1, but applies cleanly to 2.6.1 and 2.6.0.

Cheers,
	Danilo


--- linux-2.6.2-rc1/arch/arm26/lib/getuser.S	2004-01-09 08:00:05.000000000 
+0100
+++ linux/arch/arm26/lib/getuser.S	2004-01-22 20:36:31.000000000 +0100
@@ -28,6 +28,7 @@
  */
 #include <asm/asm_offsets.h>
 #include <asm/thread_info.h>
+#include <asm/errno.h>
 
         .global __get_user_1
 __get_user_1:
@@ -98,7 +99,7 @@
         mov     r2, #0
 __get_user_bad:
         mov     r1, #0
-        mov     r0, #-14
+        mov     r0, #-EFAULT
         ldmfd   sp!, {pc}^
 
 .section __ex_table, "a"
--- linux-2.6.2-rc1/arch/arm26/lib/putuser.S	2004-01-09 07:59:44.000000000 
+0100
+++ linux/arch/arm26/lib/putuser.S	2004-01-22 20:35:56.000000000 +0100
@@ -28,6 +28,7 @@
  */
 #include <asm/asm_offsets.h>
 #include <asm/thread_info.h>
+#include <asm/errno.h>
 
         .global __put_user_1
 __put_user_1:
@@ -95,7 +96,7 @@
         ldmfd   sp!, {pc}^
 
 __put_user_bad:
-	mov	r0, #-14
+	mov	r0, #-EFAULT
 	mov	pc, lr
 
 .section __ex_table, "a"
--- linux-2.6.2-rc1/arch/arm/lib/getuser.S	2004-01-09 08:00:13.000000000 +0100
+++ linux/arch/arm/lib/getuser.S	2004-01-22 20:26:36.000000000 +0100
@@ -28,6 +28,7 @@
  */
 #include <asm/constants.h>
 #include <asm/thread_info.h>
+#include <asm/errno.h>
 
 	.global	__get_user_1
 __get_user_1:
@@ -89,7 +90,7 @@
 	mov	r2, #0
 __get_user_bad:
 	mov	r1, #0
-	mov	r0, #-14
+	mov	r0, #-EFAULT
 	mov	pc, lr
 
 .section __ex_table, "a"
--- linux-2.6.2-rc1/arch/arm/lib/putuser.S	2004-01-09 08:00:02.000000000 +0100
+++ linux/arch/arm/lib/putuser.S	2004-01-22 20:26:15.000000000 +0100
@@ -28,6 +28,7 @@
  */
 #include <asm/constants.h>
 #include <asm/thread_info.h>
+#include <asm/errno.h>
 
 	.global	__put_user_1
 __put_user_1:
@@ -87,7 +88,7 @@
 	/* fall through */
 
 __put_user_bad:
-	mov	r0, #-14
+	mov	r0, #-EFAULT
 	mov	pc, lr
 
 .section __ex_table, "a"
--- linux-2.6.2-rc1/arch/h8300/platform/h8300h/entry.S	2004-01-09 
07:59:26.000000000 +0100
+++ linux/arch/h8300/platform/h8300h/entry.S	2004-01-22 20:50:36.000000000 
+0100
@@ -21,8 +21,7 @@
 #include <asm/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
-			
-ENOSYS = 38
+#include <asm/errno.h>
 
 LSIGTRAP = 5
 
--- linux-2.6.2-rc1/arch/h8300/platform/h8s/entry.S	2004-01-09 
07:59:56.000000000 +0100
+++ linux/arch/h8300/platform/h8s/entry.S	2004-01-22 20:51:24.000000000 +0100
@@ -22,8 +22,7 @@
 #include <asm/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
-
-ENOSYS = 38
+#include <asm/errno.h>
 
 LSIGTRAP = 5
 
--- linux-2.6.2-rc1/arch/i386/lib/getuser.S	2004-01-09 07:59:03.000000000 
+0100
+++ linux/arch/i386/lib/getuser.S	2004-01-22 19:53:23.000000000 +0100
@@ -9,6 +9,7 @@
  * return value.
  */
 #include <asm/thread_info.h>
+#include <asm/errno.h>
 
 
 /*
@@ -60,7 +61,7 @@
 
 bad_get_user:
 	xorl %edx,%edx
-	movl $-14,%eax
+	movl $-EFAULT,%eax
 	ret
 
 .section __ex_table,"a"
--- linux-2.6.2-rc1/arch/sh/kernel/entry.S	2004-01-23 01:59:03.000000000 +0100
+++ linux/arch/sh/kernel/entry.S	2004-01-23 02:30:58.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/config.h>
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
+#include <asm/errno.h>
 
 #if !defined(CONFIG_NFSD) && !defined(CONFIG_NFSD_MODULE)
 #define sys_nfsservctl		sys_ni_syscall
@@ -71,9 +72,6 @@
  *
  */
 
-ENOSYS = 38
-EINVAL = 22
-
 #if defined(CONFIG_CPU_SH3)
 TRA     = 0xffffffd0
 EXPEVT  = 0xffffffd4

