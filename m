Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266246AbSLIWE7>; Mon, 9 Dec 2002 17:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbSLIWE6>; Mon, 9 Dec 2002 17:04:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:33156 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266246AbSLIWDs>;
	Mon, 9 Dec 2002 17:03:48 -0500
Message-ID: <3DF514A1.9070502@us.ibm.com>
Date: Mon, 09 Dec 2002 14:09:37 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCHES] (4/4) stack updates for x86
Content-Type: multipart/mixed;
 boundary="------------070709000206030602050305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070709000206030602050305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The kernel currently uses an 8k stack, per task.  Here is the
infrastructure needed to allow us to halve that.

D-4k-stack-2.5.50+bk-5.patch
	make a config option to turn on 4k stacks.  (there appears to
	be a problem with this right now).

-- 
Dave Hansen
haveblue@us.ibm.com


--------------070709000206030602050305
Content-Type: text/plain;
 name="D-4k-stack-2.5.50+bk-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="D-4k-stack-2.5.50+bk-5.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.862   -> 1.864  
#	include/asm-i386/thread_info.h	1.13    -> 1.15   
#	   arch/i386/Kconfig	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.863
# Merge elm3b96.(none):/work/dave/bk/linux-2.5-stack_size-config
# into elm3b96.(none):/work/dave/bk/linux-2.5-4k_stack
# --------------------------------------------
# 02/12/09	haveblue@elm3b96.(none)	1.864
# thread_info.h:
#   do sane overflow detection with 4k stack
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Dec  9 13:33:26 2002
+++ b/arch/i386/Kconfig	Mon Dec  9 13:33:26 2002
@@ -720,6 +720,16 @@
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
--- a/include/asm-i386/thread_info.h	Mon Dec  9 13:33:26 2002
+++ b/include/asm-i386/thread_info.h	Mon Dec  9 13:33:26 2002
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
 

--------------070709000206030602050305--

