Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSLPFwr>; Mon, 16 Dec 2002 00:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSLPFwq>; Mon, 16 Dec 2002 00:52:46 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:30690 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265402AbSLPFwo>; Mon, 16 Dec 2002 00:52:44 -0500
Message-ID: <3DFD6BB7.9000302@us.ibm.com>
Date: Sun, 15 Dec 2002 21:59:19 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] (4/4) stack updates for x86
Content-Type: multipart/mixed;
 boundary="------------030203090806070107060603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030203090806070107060603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


D-4k-stack-2.5.52+bk-6.patch
	make a config option to turn on 4k stacks.

Make sure this is applied too, or you'll oops when bringing up 
secondary cpus:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103956921711074&w=2

-- 
Dave Hansen
haveblue@us.ibm.com



--------------030203090806070107060603
Content-Type: text/plain;
 name="D-4k-stack-2.5.52-6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="D-4k-stack-2.5.52-6.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.862.1.4 -> 1.867  
#	include/asm-i386/thread_info.h	1.13.1.1 -> 1.17   
#	   arch/i386/Kconfig	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/15	haveblue@elm3b96.(none)	1.867
# Merge elm3b96.(none):/work/dave/bk/linux-2.5-irq-stack+overflow-detect
# into elm3b96.(none):/work/dave/bk/linux-2.5-4k_stack
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Sun Dec 15 21:27:56 2002
+++ b/arch/i386/Kconfig	Sun Dec 15 21:27:56 2002
@@ -622,6 +622,16 @@
 	  low memory.  Setting this option will put user-space page table
 	  entries in high memory.
 
+config 4K_STACK
+	bool "Use smaller 4k per-task stacks"
+	help
+	  This option will shrink the kernel's per-task stack from 8k to
+	  4k.  This will greatly increase your chance of overflowing it.
+	  But, if you use the per-cpu interrupt stacks as well, your chances
+	  go way down.  Also try the CONFIG_X86_STACK_CHECK overflow
+	  detection.  It is much more reliable than the currently in-kernel
+	  version.
+
 config MATH_EMULATION
 	bool "Math emulation"
 	---help---
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	Sun Dec 15 21:27:56 2002
+++ b/include/asm-i386/thread_info.h	Sun Dec 15 21:27:56 2002
@@ -61,10 +61,16 @@
  *
  * preempt_count needs to be 1 initially, until the scheduler is functional.
  */
-#define THREAD_ORDER 1 
+#ifdef CONFIG_4K_STACK
+#define THREAD_ORDER 0
+#define STACK_WARN		0x200
+#define STACK_PANIC		0x100
+#else
+#define THREAD_ORDER 1
+#define STACK_WARN              ((THREAD_SIZE)>>1)
+#define STACK_PANIC             0x100
+#endif
 #define INIT_THREAD_SIZE       THREAD_SIZE
-#define STACK_PANIC		0x200ul
-#define STACK_WARN		((THREAD_SIZE)>>1)
 
 #ifndef __ASSEMBLY__
 

--------------030203090806070107060603--

