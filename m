Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264810AbSKRT1V>; Mon, 18 Nov 2002 14:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSKRT1S>; Mon, 18 Nov 2002 14:27:18 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:20439 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S264620AbSKRTYx> convert rfc822-to-8bit; Mon, 18 Nov 2002 14:24:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.48 s390 (7/16): uaccess bug.
Date: Mon, 18 Nov 2002 20:19:40 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211182019.40542.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't rely on lowcore information in __copy_{from,to}_user_asm. Fix compile
for peculiar get_user() usage in drivers/scsi/scsi_ioctl.c

diff -urN linux-2.5.48/arch/s390/lib/uaccess.S linux-2.5.48-s390/arch/s390/lib/uaccess.S
--- linux-2.5.48/arch/s390/lib/uaccess.S	Mon Nov 18 05:29:50 2002
+++ linux-2.5.48-s390/arch/s390/lib/uaccess.S	Mon Nov 18 20:11:34 2002
@@ -1,9 +1,9 @@
 /*
  *  arch/s390/lib/uaccess.S
- *    fixup routines for copy_{from|to}_user functions.
+ *    __copy_{from|to}_user functions.
  *
  *  s390
- *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 2000,2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Authors(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  *  These functions have standard call interface
@@ -22,17 +22,23 @@
 1:	sacf	0
 	lr	%r2,%r5
 	br	%r14
-2:      sll	%r4,1
-        srl	%r4,1
-        lhi	%r3,-4096
-        sll	%r3,1
-        srl	%r3,1
-        n	%r3,__LC_TRANS_EXC_ADDR
-        sr	%r3,%r4
-        jm	1b
-	j	0b
+2:	lhi	%r1,-4096
+	lr	%r3,%r4
+	slr	%r3,%r1      # %r3 = %r4 + 4096
+	nr	%r3,%r1      # %r3 = (%r4 + 4096) & -4096
+	slr	%r3,%r4      # %r3 = #bytes to next user page boundary
+	clr	%r5,%r3      # copy crosses next page boundary ?
+	jnh	1b           # no, this page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r2,%r4,0
+	jo	3b
+	j	1b
         .section __ex_table,"a"
 	.long	0b,2b
+	.long	3b,1b
         .previous
 
         .align 4
@@ -46,17 +52,23 @@
 1:	sacf	0
 	lr	%r2,%r3
 	br	%r14
-2:      sll	%r4,1
-        srl	%r4,1
-        lhi	%r5,-4096
-        sll	%r5,1
-        srl	%r5,1
-        n	%r5,__LC_TRANS_EXC_ADDR
-        sr	%r5,%r4
-        jm	1b
-	j	0b
+2:	lhi	%r1,-4096
+	lr	%r5,%r4
+	slr	%r5,%r1      # %r5 = %r4 + 4096
+	nr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clr	%r3,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
         .section __ex_table,"a"
-	.long   0b,2b
+	.long	0b,2b
+	.long	3b,1b
         .previous
 
         .align 4
@@ -71,18 +83,26 @@
 0:	mvcle	%r4,%r2,0
 	jo	0b
 1:	sacf	0
-	lr	%r2,%r3
 	br	%r14
-2:      sll	%r4,1
-        srl	%r4,1
-        lhi	%r5,-4096
-        sll	%r5,1
-        srl	%r5,1
-        n	%r5,__LC_TRANS_EXC_ADDR
-        sr	%r5,%r4
-	jm	1b
-	j	0b
+2:	lr	%r2,%r5
+	lhi	%r1,-4096
+	slr	%r5,%r1      # %r5 = %r4 + 4096
+	nr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clr	%r2,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+	slr	%r2,%r5
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
+4:	alr	%r2,%r5
+	j	1b
         .section __ex_table,"a"
-	.long   0b,2b
+	.long	0b,2b
+        .long	3b,4b
         .previous
 
diff -urN linux-2.5.48/arch/s390x/lib/uaccess.S linux-2.5.48-s390/arch/s390x/lib/uaccess.S
--- linux-2.5.48/arch/s390x/lib/uaccess.S	Mon Nov 18 05:29:52 2002
+++ linux-2.5.48-s390/arch/s390x/lib/uaccess.S	Mon Nov 18 20:11:34 2002
@@ -1,9 +1,9 @@
 /*
  *  arch/s390x/lib/uaccess.S
- *    fixup routines for copy_{from|to}_user functions.
+ *    __copy_{from|to}_user functions.
  *
- *  S390
- *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *  s390
+ *    Copyright (C) 2000,2002 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Authors(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  *
  *  These functions have standard call interface
@@ -22,14 +22,23 @@
 1:	sacf	0
 	lgr	%r2,%r5
 	br	%r14
-2:	lghi	%r3,-4096
-        ng	%r3,__LC_TRANS_EXC_ADDR
-        sgr	%r3,%r4
-        jm	1b
-	j	0b
+2:	lghi	%r1,-4096
+	lgr	%r3,%r4
+	slgr	%r3,%r1      # %r3 = %r4 + 4096
+	ngr	%r3,%r1      # %r3 = (%r4 + 4096) & -4096
+	slgr	%r3,%r4      # %r3 = #bytes to next user page boundary
+	clgr	%r5,%r3      # copy crosses next page boundary ?
+	jnh	1b           # no, this page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r2,%r4,0
+	jo	3b
+	j	1b
         .section __ex_table,"a"
-        .align	8
 	.quad	0b,2b
+	.quad	3b,1b
         .previous
 
         .align 4
@@ -43,14 +52,23 @@
 1:	sacf	0
 	lgr	%r2,%r3
 	br	%r14
-2:      lghi	%r5,-4096
-        ng	%r5,__LC_TRANS_EXC_ADDR
-        sgr	%r5,%r4
-	jm	1b
-	j	0b
+2:	lghi	%r1,-4096
+	lgr	%r5,%r4
+	slgr	%r5,%r1      # %r5 = %r4 + 4096
+	ngr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slgr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clgr	%r3,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
         .section __ex_table,"a"
-        .align	8
-        .quad	0b,2b
+	.quad	0b,2b
+	.quad	3b,1b
         .previous
 
         .align 4
@@ -65,14 +83,25 @@
 0:	mvcle	%r4,%r2,0
 	jo	0b
 1:	sacf	0
-	lgr	%r2,%r5
 	br	%r14
-2:      lghi	%r5,-4096
-        ng	%r5,__LC_TRANS_EXC_ADDR
-        sgr	%r5,%r4
-	jm	1b
-	j	0b
+2:	lgr	%r2,%r5
+	lghi	%r1,-4096
+	slgr	%r5,%r1      # %r5 = %r4 + 4096
+	ngr	%r5,%r1      # %r5 = (%r4 + 4096) & -4096
+	slgr	%r5,%r4      # %r5 = #bytes to next user page boundary
+	clgr	%r2,%r5      # copy crosses next page boundary ?
+	jnh	1b           # no, the current page fauled
+	# The page after the current user page might have faulted.
+	# We cant't find out which page because the program check handler
+	# might have callled schedule, destroying all lowcore information.
+	# We retry with the shortened length.
+	slgr	%r2,%r5
+3:	mvcle	%r4,%r2,0
+	jo	3b
+	j	1b
+4:	algr	%r2,%r5
+	j	1b
         .section __ex_table,"a"
-        .align	8
-        .quad	0b,2b
+	.quad	0b,2b
+        .quad	3b,4b
         .previous
diff -urN linux-2.5.48/include/asm-s390/uaccess.h linux-2.5.48-s390/include/asm-s390/uaccess.h
--- linux-2.5.48/include/asm-s390/uaccess.h	Mon Nov 18 05:29:27 2002
+++ linux-2.5.48-s390/include/asm-s390/uaccess.h	Mon Nov 18 20:11:34 2002
@@ -199,24 +199,23 @@
  */
 #define __put_user(x, ptr)                                      \
 ({                                                              \
-        __typeof__(*(ptr)) *__pu_addr = (ptr);                  \
         __typeof__(*(ptr)) __x = (x);                           \
         int __pu_err;                                           \
         switch (sizeof (*(ptr))) {                              \
         case 1:                                                 \
                 __pu_err = __put_user_asm_1((__u8)(__u32) __x,  \
-                                            __pu_addr);         \
+                                            ptr);               \
                 break;                                          \
         case 2:                                                 \
                 __pu_err = __put_user_asm_2((__u16)(__u32) __x, \
-                                            __pu_addr);         \
+                                            ptr);               \
                 break;                                          \
         case 4:                                                 \
                 __pu_err = __put_user_asm_4((__u32) __x,        \
-                                            __pu_addr);         \
+                                            ptr);               \
                 break;                                          \
         case 8:                                                 \
-                __pu_err = __put_user_asm_8(&__x, __pu_addr);   \
+                __pu_err = __put_user_asm_8(&__x, ptr);         \
                 break;                                          \
         default:                                                \
                 __pu_err = __put_user_bad();                    \
@@ -333,21 +332,20 @@
 
 #define __get_user(x, ptr)                                      \
 ({                                                              \
-        __typeof__(ptr) __gu_addr = (ptr);                      \
         __typeof__(*(ptr)) __x;                                 \
         int __gu_err;                                           \
-        switch (sizeof(*(__gu_addr))) {                         \
+        switch (sizeof(*(ptr))) {                               \
         case 1:                                                 \
-                __get_user_asm_1(__x, __gu_addr, __gu_err);     \
+                __get_user_asm_1(__x, ptr, __gu_err);           \
                 break;                                          \
         case 2:                                                 \
-                __get_user_asm_2(__x, __gu_addr, __gu_err);     \
+                __get_user_asm_2(__x, ptr, __gu_err);           \
                 break;                                          \
         case 4:                                                 \
-                __get_user_asm_4(__x, __gu_addr, __gu_err);     \
+                __get_user_asm_4(__x, ptr, __gu_err);           \
                 break;                                          \
         case 8:                                                 \
-                __get_user_asm_8(__x, __gu_addr, __gu_err);     \
+                __get_user_asm_8(__x, ptr, __gu_err);           \
                 break;                                          \
         default:                                                \
                 __x = 0;                                        \
diff -urN linux-2.5.48/include/asm-s390x/uaccess.h linux-2.5.48-s390/include/asm-s390x/uaccess.h
--- linux-2.5.48/include/asm-s390x/uaccess.h	Mon Nov 18 05:29:22 2002
+++ linux-2.5.48-s390/include/asm-s390x/uaccess.h	Mon Nov 18 20:11:34 2002
@@ -177,25 +177,24 @@
  */
 #define __put_user(x, ptr)                                      \
 ({                                                              \
-        __typeof__(*(ptr)) *__pu_addr = (ptr);                  \
         __typeof__(*(ptr)) __x = (x);                           \
         int __pu_err;                                           \
-        switch (sizeof (*(__pu_addr))) {                        \
+        switch (sizeof (*(ptr))) {                              \
         case 1:                                                 \
                 __pu_err = __put_user_asm_1((__u8)(__u64)(__x), \
-                                            __pu_addr);         \
+                                            ptr);               \
                 break;                                          \
         case 2:                                                 \
                 __pu_err = __put_user_asm_2((__u16)(__u64)(__x),\
-                                            __pu_addr);         \
+                                            ptr);               \
                 break;                                          \
         case 4:                                                 \
                 __pu_err = __put_user_asm_4((__u32)(__u64)(__x),\
-                                            __pu_addr);         \
+                                            ptr);               \
                 break;                                          \
         case 8:                                                 \
                 __pu_err = __put_user_asm_8((__u64)(__x),       \
-                                            __pu_addr);         \
+                                            ptr);               \
                 break;                                          \
         default:                                                \
                 __pu_err = __put_user_bad();                    \
@@ -290,21 +289,20 @@
 
 #define __get_user(x, ptr)                                      \
 ({                                                              \
-        __typeof__(ptr) __gu_addr = (ptr);                      \
         __typeof__(*(ptr)) __x;                                 \
         int __gu_err;                                           \
         switch (sizeof(*(ptr))) {                               \
         case 1:                                                 \
-                __get_user_asm_1(__x,__gu_addr,__gu_err);       \
+                __get_user_asm_1(__x,ptr,__gu_err);             \
                 break;                                          \
         case 2:                                                 \
-                __get_user_asm_2(__x,__gu_addr,__gu_err);       \
+                __get_user_asm_2(__x,ptr,__gu_err);             \
                 break;                                          \
         case 4:                                                 \
-                __get_user_asm_4(__x,__gu_addr,__gu_err);       \
+                __get_user_asm_4(__x,ptr,__gu_err);             \
                 break;                                          \
         case 8:                                                 \
-                __get_user_asm_8(__x,__gu_addr,__gu_err);       \
+                __get_user_asm_8(__x,ptr,__gu_err);             \
                 break;                                          \
         default:                                                \
                 __x = 0;                                        \

