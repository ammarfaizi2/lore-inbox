Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269142AbTB0All>; Wed, 26 Feb 2003 19:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269143AbTB0All>; Wed, 26 Feb 2003 19:41:41 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:24288 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S269142AbTB0Ali>; Wed, 26 Feb 2003 19:41:38 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Remove v850 dependency on NR_syscalls
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030227005145.5109F3736@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu, 27 Feb 2003 09:51:45 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.63-uc0.orig/arch/v850/kernel/entry.S linux-2.5.63-uc0/arch/v850/kernel/entry.S
--- linux-2.5.63-uc0.orig/arch/v850/kernel/entry.S	2003-02-25 10:44:59.000000000 +0900
+++ linux-2.5.63-uc0/arch/v850/kernel/entry.S	2003-02-25 15:16:28.000000000 +0900
@@ -438,11 +438,11 @@
    LP register should point to the location where the called function
    should return.  [note that MAKE_SYS_CALL uses label 1]  */
 #define MAKE_SYS_CALL							      \
-	/* See if the system call number is valid.  */			      \
-	addi	-NR_syscalls, r12, r0;					      \
-	bnh	1f;							      \
 	/* Figure out which function to use for this system call.  */	      \
 	shl	2, r12;							      \
+	/* See if the system call number is valid.  */			      \
+	addi	lo(CSYM(sys_call_table) - sys_call_table_end), r12, r0;	      \
+	bnh	1f;							      \
 	mov	hilo(CSYM(sys_call_table)), r19;			      \
 	add	r19, r12;						      \
 	ld.w	0[r12], r12;						      \
@@ -982,8 +982,5 @@
 	.long CSYM(sys_pivot_root)	// 200
 	.long CSYM(sys_gettid)
 	.long CSYM(sys_tkill)
-	.long CSYM(sys_ni_syscall)	// sys_mincore
-	.long CSYM(sys_ni_syscall)	// sys_madvise
-
-	.space (NR_syscalls-205)*4
+sys_call_table_end:
 C_END(sys_call_table)
diff -ruN -X../cludes linux-2.5.63-uc0.orig/include/asm-v850/unistd.h linux-2.5.63-uc0/include/asm-v850/unistd.h
--- linux-2.5.63-uc0.orig/include/asm-v850/unistd.h	2002-12-24 15:01:24.000000000 +0900
+++ linux-2.5.63-uc0/include/asm-v850/unistd.h	2003-02-25 15:13:01.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/unistd.h -- System call numbers and invocation mechanism
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -205,8 +205,6 @@
 #define __NR_pivot_root		200
 #define __NR_gettid		201
 #define __NR_tkill		202
-/* #define __NR_mincore		203 */
-/* #define __NR_madvise		204 */
 
 
 /* Syscall protocol:
