Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932929AbWFWIH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbWFWIH1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932930AbWFWIH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:07:27 -0400
Received: from mo30.po.2iij.net ([210.128.50.53]:13320 "EHLO mo30.po.2iij.net")
	by vger.kernel.org with ESMTP id S932929AbWFWIH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:07:26 -0400
Date: Fri, 23 Jun 2006 17:07:11 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp, Ralf Baechle <ralf@linux-mips.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][MIPS] wire up tee system call
Message-Id: <20060623170711.3a6d1ef8.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch wires up tee system call for MIPS.

[MIPS] Wire up tee(2).

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -pruN -X 2.6.17/Documentation/dontdiff 2.6.17-orig/arch/mips/kernel/scall32-o32.S 2.6.17/arch/mips/kernel/scall32-o32.S
--- 2.6.17-orig/arch/mips/kernel/scall32-o32.S	2006-06-23 10:28:02.285634500 +0900
+++ 2.6.17/arch/mips/kernel/scall32-o32.S	2006-06-23 10:28:07.569964750 +0900
@@ -647,6 +647,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_unshare		1
 	sys	sys_splice		4
 	sys	sys_sync_file_range	7	/* 4305 */
+	sys	sys_tee			4
 	.endm
 
 	/* We pre-compute the number of _instruction_ bytes needed to
diff -pruN -X 2.6.17/Documentation/dontdiff 2.6.17-orig/arch/mips/kernel/scall64-64.S 2.6.17/arch/mips/kernel/scall64-64.S
--- 2.6.17-orig/arch/mips/kernel/scall64-64.S	2006-06-23 10:00:07.028937500 +0900
+++ 2.6.17/arch/mips/kernel/scall64-64.S	2006-06-23 10:28:07.573965000 +0900
@@ -462,3 +462,4 @@ sys_call_table:
 	PTR	sys_unshare
 	PTR	sys_splice
 	PTR	sys_sync_file_range
+	PTR	sys_tee				/* 5265 */
diff -pruN -X 2.6.17/Documentation/dontdiff 2.6.17-orig/arch/mips/kernel/scall64-n32.S 2.6.17/arch/mips/kernel/scall64-n32.S
--- 2.6.17-orig/arch/mips/kernel/scall64-n32.S	2006-06-23 10:00:07.028937500 +0900
+++ 2.6.17/arch/mips/kernel/scall64-n32.S	2006-06-23 10:28:07.573965000 +0900
@@ -388,3 +388,4 @@ EXPORT(sysn32_call_table)
 	PTR	sys_unshare
 	PTR	sys_splice
 	PTR	sys_sync_file_range
+	PTR	sys_tee
diff -pruN -X 2.6.17/Documentation/dontdiff 2.6.17-orig/arch/mips/kernel/scall64-o32.S 2.6.17/arch/mips/kernel/scall64-o32.S
--- 2.6.17-orig/arch/mips/kernel/scall64-o32.S	2006-06-23 10:00:07.028937500 +0900
+++ 2.6.17/arch/mips/kernel/scall64-o32.S	2006-06-23 10:28:07.573965000 +0900
@@ -510,4 +510,5 @@ sys_call_table:
 	PTR	sys_unshare
 	PTR	sys_splice
 	PTR	sys32_sync_file_range		/* 4305 */
+	PTR	sys_tee
 	.size	sys_call_table,.-sys_call_table
diff -pruN -X 2.6.17/Documentation/dontdiff 2.6.17-orig/include/asm-mips/unistd.h 2.6.17/include/asm-mips/unistd.h
--- 2.6.17-orig/include/asm-mips/unistd.h	2006-06-23 10:00:16.129506250 +0900
+++ 2.6.17/include/asm-mips/unistd.h	2006-06-23 10:28:07.577965250 +0900
@@ -326,16 +326,17 @@
 #define __NR_unshare			(__NR_Linux + 303)
 #define __NR_splice			(__NR_Linux + 304)
 #define __NR_sync_file_range		(__NR_Linux + 305)
+#define __NR_tee			(__NR_Linux + 306)
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		305
+#define __NR_Linux_syscalls		306
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
 #define __NR_O32_Linux			4000
-#define __NR_O32_Linux_syscalls		305
+#define __NR_O32_Linux_syscalls		306
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64
 
@@ -608,16 +609,17 @@
 #define __NR_unshare			(__NR_Linux + 262)
 #define __NR_splice			(__NR_Linux + 263)
 #define __NR_sync_file_range		(__NR_Linux + 264)
+#define __NR_tee			(__NR_Linux + 265)
 
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		264
+#define __NR_Linux_syscalls		265
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
 #define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		264
+#define __NR_64_Linux_syscalls		265
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
@@ -894,16 +896,17 @@
 #define __NR_unshare			(__NR_Linux + 266)
 #define __NR_splice			(__NR_Linux + 267)
 #define __NR_sync_file_range		(__NR_Linux + 268)
+#define __NR_tee			(__NR_Linux + 269)
 
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		268
+#define __NR_Linux_syscalls		269
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define __NR_N32_Linux			6000
-#define __NR_N32_Linux_syscalls		268
+#define __NR_N32_Linux_syscalls		269
 
 #ifdef __KERNEL__
 
