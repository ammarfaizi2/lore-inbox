Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUIPDBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUIPDBR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 23:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267383AbUIPDBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 23:01:17 -0400
Received: from mail.renesas.com ([202.234.163.13]:6378 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S267377AbUIPDA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 23:00:58 -0400
Date: Thu, 16 Sep 2004 12:00:23 +0900 (JST)
Message-Id: <20040916.120023.276774957.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm5] [m32r] Upgrade for -mm5 changes
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here's a patch to upgrade 2.6.9-rc1-mm5 for m32r.
Please apply.

Thank you.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/Makefile             |    2 +-
 arch/m32r/kernel/vmlinux.lds.S |    4 +---
 arch/m32r/mm/ioremap.c         |   10 +++++-----
 include/asm-m32r/resource.h    |    2 +-
 include/asm-m32r/socket.h      |   20 --------------------
 include/asm-m32r/unistd.h      |   20 ++++++++++++++++----
 6 files changed, 24 insertions(+), 34 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/Makefile linux-2.6.9-rc1-mm5/arch/m32r/Makefile
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/Makefile	2004-09-13 21:44:06.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/Makefile	2004-09-15 13:17:30.000000000 +0900
@@ -25,7 +25,7 @@ aflags-$(CONFIG_ISA_M32R)	+= -DNO_FPU -W
 CFLAGS += $(cflags-y)
 AFLAGS += $(aflags-y)
 
-CHECK	:= $(CHECK) -D__m32r__=1
+CHECKFLAGS	:= $(CHECK) -D__m32r__=1
 
 head-y	:= arch/m32r/kernel/head.o arch/m32r/kernel/init_task.o
 
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/vmlinux.lds.S linux-2.6.9-rc1-mm5/arch/m32r/kernel/vmlinux.lds.S
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/kernel/vmlinux.lds.S	2004-09-13 21:44:05.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/kernel/vmlinux.lds.S	2004-09-14 15:42:33.000000000 +0900
@@ -27,6 +27,7 @@ SECTIONS
   .text : {
 	*(.text)
 	SCHED_TEXT
+	LOCK_TEXT
 	*(.fixup)
 	*(.gnu.warning)
 	} = 0x9090
@@ -81,9 +82,6 @@ SECTIONS
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;
-  __start___param = .;
-  __param : { *(__param) }
-  __stop___param = .;
   __initcall_start = .;
   .initcall.init : {
 	*(.initcall1.init)
diff -ruNp linux-2.6.9-rc1-mm5.orig/arch/m32r/mm/ioremap.c linux-2.6.9-rc1-mm5/arch/m32r/mm/ioremap.c
--- linux-2.6.9-rc1-mm5.orig/arch/m32r/mm/ioremap.c	2004-09-13 21:44:06.000000000 +0900
+++ linux-2.6.9-rc1-mm5/arch/m32r/mm/ioremap.c	2004-09-15 16:17:13.000000000 +0900
@@ -122,9 +122,9 @@ static int remap_area_pages(unsigned lon
 
 #define IS_LOW512(addr) (!((unsigned long)(addr) & ~0x1fffffffUL))
 
-void * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
+void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
 {
-	void * addr;
+	void __iomem * addr;
 	struct vm_struct * area;
 	unsigned long offset, last_addr;
 
@@ -169,13 +169,13 @@ void * __ioremap(unsigned long phys_addr
 	if (!area)
 		return NULL;
 	area->phys_addr = phys_addr;
-	addr = area->addr;
+	addr = (void __iomem *) area->addr;
 	if (remap_area_pages((unsigned long)addr, phys_addr, size, flags)) {
-		vunmap(addr);
+		vunmap((void __force *) addr);
 		return NULL;
 	}
 
-	return (void *) (offset + (char *)addr);
+	return (void __iomem *) (offset + (char __iomem *)addr);
 }
 
 #define IS_KSEG1(addr) (((unsigned long)(addr) & ~0x1fffffffUL) == KSEG1)
diff -ruNp linux-2.6.9-rc1-mm5.orig/include/asm-m32r/resource.h linux-2.6.9-rc1-mm5/include/asm-m32r/resource.h
--- linux-2.6.9-rc1-mm5.orig/include/asm-m32r/resource.h	2004-09-13 21:44:38.000000000 +0900
+++ linux-2.6.9-rc1-mm5/include/asm-m32r/resource.h	2004-09-14 20:25:25.000000000 +0900
@@ -43,7 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{ MLOCK_LIMIT,   MLOCK_LIMIT   },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ MAX_SIGPENDING, MAX_SIGPENDING },		\
diff -ruNp linux-2.6.9-rc1-mm5.orig/include/asm-m32r/socket.h linux-2.6.9-rc1-mm5/include/asm-m32r/socket.h
--- linux-2.6.9-rc1-mm5.orig/include/asm-m32r/socket.h	2004-09-13 21:44:38.000000000 +0900
+++ linux-2.6.9-rc1-mm5/include/asm-m32r/socket.h	2004-09-14 14:04:59.000000000 +0900
@@ -1,10 +1,6 @@
 #ifndef _ASM_M32R_SOCKET_H
 #define _ASM_M32R_SOCKET_H
 
-/* $Id$ */
-
-/* orig : i386 2.4.18 */
-
 #include <asm/sockios.h>
 
 /* For setsockoptions(2) */
@@ -51,20 +47,4 @@
 
 #define SO_PEERSEC		31
 
-/* Nasty libc5 fixup - bletch */
-#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
-/* Socket types. */
-#define SOCK_STREAM	1		/* stream (connection) socket	*/
-#define SOCK_DGRAM	2		/* datagram (conn.less) socket	*/
-#define SOCK_RAW	3		/* raw socket			*/
-#define SOCK_RDM	4		/* reliably-delivered message	*/
-#define SOCK_SEQPACKET	5		/* sequential packet socket	*/
-#define SOCK_PACKET	10		/* linux specific way of	*/
-					/* getting packets at the dev	*/
-					/* level.  For writing rarp and	*/
-					/* other similar things on the	*/
-					/* user level.			*/
-#define	SOCK_MAX	(SOCK_PACKET+1)
-#endif
-
 #endif /* _ASM_M32R_SOCKET_H */
diff -ruNp linux-2.6.9-rc1-mm5.orig/include/asm-m32r/unistd.h linux-2.6.9-rc1-mm5/include/asm-m32r/unistd.h
--- linux-2.6.9-rc1-mm5.orig/include/asm-m32r/unistd.h	2004-09-13 21:44:38.000000000 +0900
+++ linux-2.6.9-rc1-mm5/include/asm-m32r/unistd.h	2004-09-15 17:13:17.000000000 +0900
@@ -292,15 +292,27 @@
 #define __NR_mq_timedreceive    (__NR_mq_open+3)
 #define __NR_mq_notify          (__NR_mq_open+4)
 #define __NR_mq_getsetattr      (__NR_mq_open+5)
-#define __NR_kexec_load		283
+#define __NR_sys_kexec_load    283
+#define __NR_waitid            284
+#define __NR_perfctr_info      285
+#define __NR_vperfctr_open     (__NR_perfctr_info+1)
+#define __NR_vperfctr_control  (__NR_perfctr_info+2)
+#define __NR_vperfctr_unlink   (__NR_perfctr_info+3)
+#define __NR_vperfctr_iresume  (__NR_perfctr_info+4)
+#define __NR_vperfctr_read     (__NR_perfctr_info+5)
+#define __NR_add_key           291
+#define __NR_request_key       292
+#define __NR_keyctl            293
 
-#define NR_syscalls     284
+#define NR_syscalls 294
 
-/* user-visible error numbers are in the range -1 - -124: see <asm-m32r/errno.h> */
+/* user-visible error numbers are in the range -1 - -128: see
+ * <asm-m32r/errno.h>
+ */
 
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
+	if ((unsigned long)(res) >= (unsigned long)(-(128 + 1))) { \
 	/* Avoid using "res" which is declared to be in register r0; \
 	   errno might expand to a function call and clobber it.  */ \
 		int __err = -(res); \

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

