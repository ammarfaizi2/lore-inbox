Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWDGKsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWDGKsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWDGKsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:48:21 -0400
Received: from mail.renesas.com ([202.234.163.13]:20441 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S932420AbWDGKsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:48:20 -0400
Date: Fri, 07 Apr 2006 19:48:14 +0900 (JST)
Message-Id: <20060407.194814.02303433.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gniibe@fsij.org, takata@linux-m32r.org
Subject: [PATCH 2.6.17-rc1-mm1] m32r: security fix of {get,put}_user macros
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update {get,put}_user macros for m32r kernel.
- Modify get_user to use __get_user_asm macro, instead of __get_user_x macro.
- Remove arch/m32r/lib/{get,put}user.S.
- Some cosmetic updates.

I would like to thank NIIBE Yutaka for his reporting about
the m32r kernel's security problem in {get,put}_user macros.

There were no address checking for user space access in
{get,put}_user macros.  ;-)

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
Cc: NIIBE Yutaka <gniibe@fsij.org>
---

 arch/m32r/kernel/m32r_ksyms.c |    4 
 arch/m32r/lib/Makefile        |    4 
 arch/m32r/lib/getuser.S       |   88 -------------
 arch/m32r/lib/putuser.S       |   84 -------------
 include/asm-m32r/uaccess.h    |  266 ++++++++++++++++++------------------------
 5 files changed, 117 insertions(+), 329 deletions(-)

Index: linux-2.6.17-rc1-mm1/include/asm-m32r/uaccess.h
===================================================================
--- linux-2.6.17-rc1-mm1.orig/include/asm-m32r/uaccess.h	2006-04-07 12:16:22.000000000 +0900
+++ linux-2.6.17-rc1-mm1/include/asm-m32r/uaccess.h	2006-04-07 12:54:44.045862148 +0900
@@ -5,17 +5,9 @@
  *  linux/include/asm-m32r/uaccess.h
  *
  *  M32R version.
- *    Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
+ *    Copyright (C) 2004, 2006  Hirokazu Takata <takata at linux-m32r.org>
  */
 
-#undef UACCESS_DEBUG
-
-#ifdef UACCESS_DEBUG
-#define UAPRINTK(args...) printk(args)
-#else
-#define UAPRINTK(args...)
-#endif /* UACCESS_DEBUG */
-
 /*
  * User space memory access functions
  */
@@ -38,27 +30,29 @@
 #define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
 
 #ifdef CONFIG_MMU
+
 #define KERNEL_DS	MAKE_MM_SEG(0xFFFFFFFF)
 #define USER_DS		MAKE_MM_SEG(PAGE_OFFSET)
-#else
-#define KERNEL_DS	MAKE_MM_SEG(0xFFFFFFFF)
-#define USER_DS		MAKE_MM_SEG(0xFFFFFFFF)
-#endif /* CONFIG_MMU */
-
 #define get_ds()	(KERNEL_DS)
-#ifdef CONFIG_MMU
 #define get_fs()	(current_thread_info()->addr_limit)
 #define set_fs(x)	(current_thread_info()->addr_limit = (x))
-#else
+
+#else /* not CONFIG_MMU */
+
+#define KERNEL_DS	MAKE_MM_SEG(0xFFFFFFFF)
+#define USER_DS		MAKE_MM_SEG(0xFFFFFFFF)
+#define get_ds()	(KERNEL_DS)
+
 static inline mm_segment_t get_fs(void)
 {
-  return USER_DS;
+	return USER_DS;
 }
 
 static inline void set_fs(mm_segment_t s)
 {
 }
-#endif /* CONFIG_MMU */
+
+#endif /* not CONFIG_MMU */
 
 #define segment_eq(a,b)	((a).seg == (b).seg)
 
@@ -83,9 +77,9 @@ static inline void set_fs(mm_segment_t s
 		"	subx	%0, %0\n"				\
 		"	cmpu	%4, %1\n"				\
 		"	subx	%0, %5\n"				\
-		: "=&r"(flag), "=r"(sum)				\
-		: "1"(addr), "r"((int)(size)), 				\
-		  "r"(current_thread_info()->addr_limit.seg), "r"(0)	\
+		: "=&r" (flag), "=r" (sum)				\
+		: "1" (addr), "r" ((int)(size)), 			\
+		  "r" (current_thread_info()->addr_limit.seg), "r" (0)	\
 		: "cbit" );						\
 	flag; })
 
@@ -113,10 +107,10 @@ static inline void set_fs(mm_segment_t s
 #else
 static inline int access_ok(int type, const void *addr, unsigned long size)
 {
-  extern unsigned long memory_start, memory_end;
-  unsigned long val = (unsigned long)addr;
+	extern unsigned long memory_start, memory_end;
+	unsigned long val = (unsigned long)addr;
 
-  return ((val >= memory_start) && ((val + size) < memory_end));
+	return ((val >= memory_start) && ((val + size) < memory_end));
 }
 #endif /* CONFIG_MMU */
 
@@ -155,39 +149,6 @@ extern int fixup_exception(struct pt_reg
  * accesses to the same area of user memory).
  */
 
-extern void __get_user_1(void);
-extern void __get_user_2(void);
-extern void __get_user_4(void);
-
-#ifndef MODULE
-#define __get_user_x(size,ret,x,ptr) 					\
-	__asm__ __volatile__(						\
-		"	mv	r0, %0\n"				\
-		"	mv	r1, %1\n" 				\
-		"	bl __get_user_" #size "\n"			\
-		"	mv	%0, r0\n"				\
-		"	mv	%1, r1\n" 				\
-		: "=r"(ret), "=r"(x) 					\
-		: "0"(ptr)						\
-		: "r0", "r1", "r14" )
-#else /* MODULE */
-/*
- * Use "jl" instead of "bl" for MODULE
- */
-#define __get_user_x(size,ret,x,ptr) 					\
-	__asm__ __volatile__(						\
-		"	mv	r0, %0\n"				\
-		"	mv	r1, %1\n" 				\
-		"	seth	lr, #high(__get_user_" #size ")\n"	\
-		"	or3	lr, lr, #low(__get_user_" #size ")\n"	\
-		"	jl 	lr\n"					\
-		"	mv	%0, r0\n"				\
-		"	mv	%1, r1\n" 				\
-		: "=r"(ret), "=r"(x) 					\
-		: "0"(ptr)						\
-		: "r0", "r1", "r14" )
-#endif
-
 /* Careful: we have to cast the result to the type of the pointer for sign
    reasons */
 /**
@@ -208,20 +169,7 @@ extern void __get_user_4(void);
  * On error, the variable @x is set to zero.
  */
 #define get_user(x,ptr)							\
-({	int __ret_gu;							\
-	unsigned long __val_gu;						\
-	__chk_user_ptr(ptr);						\
-	switch(sizeof (*(ptr))) {					\
-	case 1:  __get_user_x(1,__ret_gu,__val_gu,ptr); break;		\
-	case 2:  __get_user_x(2,__ret_gu,__val_gu,ptr); break;		\
-	case 4:  __get_user_x(4,__ret_gu,__val_gu,ptr); break;		\
-	default: __get_user_x(X,__ret_gu,__val_gu,ptr); break;		\
-	}								\
-	(x) = (__typeof__(*(ptr)))__val_gu;				\
-	__ret_gu;							\
-})
-
-extern void __put_user_bad(void);
+	__get_user_check((x),(ptr),sizeof(*(ptr)))
 
 /**
  * put_user: - Write a simple value into user space.
@@ -240,8 +188,7 @@ extern void __put_user_bad(void);
  * Returns zero on success, or -EFAULT on error.
  */
 #define put_user(x,ptr)							\
-  __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
-
+	__put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
 
 /**
  * __get_user: - Get a simple variable from user space, with less checking.
@@ -264,8 +211,64 @@ extern void __put_user_bad(void);
  * On error, the variable @x is set to zero.
  */
 #define __get_user(x,ptr) \
-  __get_user_nocheck((x),(ptr),sizeof(*(ptr)))
+	__get_user_nocheck((x),(ptr),sizeof(*(ptr)))
 
+#define __get_user_nocheck(x,ptr,size)					\
+({									\
+	long __gu_err = 0;						\
+	unsigned long __gu_val;						\
+	might_sleep();							\
+	__get_user_size(__gu_val,(ptr),(size),__gu_err);		\
+	(x) = (__typeof__(*(ptr)))__gu_val;				\
+	__gu_err;							\
+})
+
+#define __get_user_check(x,ptr,size)					\
+({									\
+	long __gu_err = -EFAULT;					\
+	unsigned long __gu_val = 0;					\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
+	might_sleep();							\
+	if (access_ok(VERIFY_READ,__gu_addr,size))			\
+		__get_user_size(__gu_val,__gu_addr,(size),__gu_err);	\
+	(x) = (__typeof__(*(ptr)))__gu_val;				\
+	__gu_err;							\
+})
+
+extern long __get_user_bad(void);
+
+#define __get_user_size(x,ptr,size,retval)				\
+do {									\
+	retval = 0;							\
+	__chk_user_ptr(ptr);						\
+	switch (size) {							\
+	  case 1: __get_user_asm(x,ptr,retval,"ub"); break;		\
+	  case 2: __get_user_asm(x,ptr,retval,"uh"); break;		\
+	  case 4: __get_user_asm(x,ptr,retval,""); break;		\
+	  default: (x) = __get_user_bad();				\
+	}								\
+} while (0)
+
+#define __get_user_asm(x, addr, err, itype)				\
+	__asm__ __volatile__(						\
+		"	.fillinsn\n"					\
+		"1:	ld"itype" %1,@%2\n"				\
+		"	.fillinsn\n"					\
+		"2:\n"							\
+		".section .fixup,\"ax\"\n"				\
+		"	.balign 4\n"					\
+		"3:	ldi %0,%3\n"					\
+		"	seth r14,#high(2b)\n"				\
+		"	or3 r14,r14,#low(2b)\n"				\
+		"	jmp r14\n"					\
+		".previous\n"						\
+		".section __ex_table,\"a\"\n"				\
+		"	.balign 4\n"					\
+		"	.long 1b,3b\n"					\
+		".previous"						\
+		: "=&r" (err), "=&r" (x)				\
+		: "r" (addr), "i" (-EFAULT), "0" (err)			\
+		: "r14", "memory")
 
 /**
  * __put_user: - Write a simple value into user space, with less checking.
@@ -287,11 +290,13 @@ extern void __put_user_bad(void);
  * Returns zero on success, or -EFAULT on error.
  */
 #define __put_user(x,ptr) \
-  __put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
+	__put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
+
 
 #define __put_user_nocheck(x,ptr,size)					\
 ({									\
 	long __pu_err;							\
+	might_sleep();							\
 	__put_user_size((x),(ptr),(size),__pu_err);			\
 	__pu_err;							\
 })
@@ -308,28 +313,28 @@ extern void __put_user_bad(void);
 })
 
 #if defined(__LITTLE_ENDIAN__)
-#define __put_user_u64(x, addr, err)                                    \
-        __asm__ __volatile__(                                           \
-                "       .fillinsn\n"                                    \
-                "1:     st %L1,@%2\n"                                    \
-                "       .fillinsn\n"                                    \
-                "2:     st %H1,@(4,%2)\n"                                \
-                "       .fillinsn\n"                                    \
-                "3:\n"                                                  \
-                ".section .fixup,\"ax\"\n"                              \
-                "       .balign 4\n"                                    \
-                "4:     ldi %0,%3\n"                                    \
-                "       seth r14,#high(3b)\n"                           \
-                "       or3 r14,r14,#low(3b)\n"                         \
-                "       jmp r14\n"                                      \
-                ".previous\n"                                           \
-                ".section __ex_table,\"a\"\n"                           \
-                "       .balign 4\n"                                    \
-                "       .long 1b,4b\n"                                  \
-                "       .long 2b,4b\n"                                  \
-                ".previous"                                             \
-                : "=&r"(err)                                             \
-                : "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
+#define __put_user_u64(x, addr, err)					\
+        __asm__ __volatile__(						\
+                "       .fillinsn\n"					\
+                "1:     st %L1,@%2\n"					\
+                "       .fillinsn\n"					\
+                "2:     st %H1,@(4,%2)\n"				\
+                "       .fillinsn\n"					\
+                "3:\n"							\
+                ".section .fixup,\"ax\"\n"				\
+                "       .balign 4\n"					\
+                "4:     ldi %0,%3\n"					\
+                "       seth r14,#high(3b)\n"				\
+                "       or3 r14,r14,#low(3b)\n"				\
+                "       jmp r14\n"					\
+                ".previous\n"						\
+                ".section __ex_table,\"a\"\n"				\
+                "       .balign 4\n"					\
+                "       .long 1b,4b\n"					\
+                "       .long 2b,4b\n"					\
+                ".previous"						\
+                : "=&r" (err)						\
+                : "r" (x), "r" (addr), "i" (-EFAULT), "0" (err)		\
                 : "r14", "memory")
 
 #elif defined(__BIG_ENDIAN__)
@@ -353,13 +358,15 @@ extern void __put_user_bad(void);
 		"	.long 1b,4b\n"					\
 		"	.long 2b,4b\n"					\
 		".previous"						\
-		: "=&r"(err)						\
-		: "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
+		: "=&r" (err)						\
+		: "r" (x), "r" (addr), "i" (-EFAULT), "0" (err)		\
 		: "r14", "memory")
 #else
 #error no endian defined
 #endif
 
+extern void __put_user_bad(void);
+
 #define __put_user_size(x,ptr,size,retval)				\
 do {									\
 	retval = 0;							\
@@ -398,52 +405,8 @@ struct __large_struct { unsigned long bu
 		"	.balign 4\n"					\
 		"	.long 1b,3b\n"					\
 		".previous"						\
-		: "=&r"(err)						\
-		: "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
-		: "r14", "memory")
-
-#define __get_user_nocheck(x,ptr,size)					\
-({									\
-	long __gu_err;							\
-	unsigned long __gu_val;						\
-	__get_user_size(__gu_val,(ptr),(size),__gu_err);		\
-	(x) = (__typeof__(*(ptr)))__gu_val;				\
-	__gu_err;							\
-})
-
-extern long __get_user_bad(void);
-
-#define __get_user_size(x,ptr,size,retval)				\
-do {									\
-	retval = 0;							\
-	__chk_user_ptr(ptr);						\
-	switch (size) {							\
-	  case 1: __get_user_asm(x,ptr,retval,"ub"); break;		\
-	  case 2: __get_user_asm(x,ptr,retval,"uh"); break;		\
-	  case 4: __get_user_asm(x,ptr,retval,""); break;		\
-	  default: (x) = __get_user_bad();				\
-	}								\
-} while (0)
-
-#define __get_user_asm(x, addr, err, itype)				\
-	__asm__ __volatile__(						\
-		"	.fillinsn\n"					\
-		"1:	ld"itype" %1,@%2\n"				\
-		"	.fillinsn\n"					\
-		"2:\n"							\
-		".section .fixup,\"ax\"\n"				\
-		"	.balign 4\n"					\
-		"3:	ldi %0,%3\n"					\
-		"	seth r14,#high(2b)\n"				\
-		"	or3 r14,r14,#low(2b)\n"				\
-		"	jmp r14\n"					\
-		".previous\n"						\
-		".section __ex_table,\"a\"\n"				\
-		"	.balign 4\n"					\
-		"	.long 1b,3b\n"					\
-		".previous"						\
-		: "=&r"(err), "=&r"(x)					\
-		: "r"(addr), "i"(-EFAULT), "0"(err)			\
+		: "=&r" (err)						\
+		: "r" (x), "r" (addr), "i" (-EFAULT), "0" (err)		\
 		: "r14", "memory")
 
 /*
@@ -453,7 +416,6 @@ do {									\
  * anything, so this is accurate.
  */
 
-
 /*
  * Copy To/From Userspace
  */
@@ -511,8 +473,9 @@ do {									\
 		"	.long 2b,9b\n"					\
 		"	.long 3b,9b\n"					\
 		".previous\n"						\
-		: "=&r"(__dst), "=&r"(__src), "=&r"(size), "=&r"(__c)	\
-		: "0"(to), "1"(from), "2"(size), "3"(size / 4)		\
+		: "=&r" (__dst), "=&r" (__src), "=&r" (size),		\
+		  "=&r" (__c)						\
+		: "0" (to), "1" (from), "2" (size), "3" (size / 4)	\
 		: "r14", "memory");					\
 } while (0)
 
@@ -573,8 +536,9 @@ do {									\
 		"	.long 2b,7b\n"					\
 		"	.long 3b,7b\n"					\
 		".previous\n"						\
-		: "=&r"(__dst), "=&r"(__src), "=&r"(size), "=&r"(__c)	\
-		: "0"(to), "1"(from), "2"(size), "3"(size / 4)		\
+		: "=&r" (__dst), "=&r" (__src), "=&r" (size),		\
+		  "=&r" (__c)						\
+		: "0" (to), "1" (from), "2" (size), "3" (size / 4)	\
 		: "r14", "memory");					\
 } while (0)
 
@@ -676,7 +640,7 @@ unsigned long __generic_copy_from_user(v
 #define copy_from_user(to,from,n)			\
 ({							\
 	might_sleep();					\
-__generic_copy_from_user((to),(from),(n));	\
+	__generic_copy_from_user((to),(from),(n));	\
 })
 
 long __must_check strncpy_from_user(char *dst, const char __user *src,
Index: linux-2.6.17-rc1-mm1/arch/m32r/kernel/m32r_ksyms.c
===================================================================
--- linux-2.6.17-rc1-mm1.orig/arch/m32r/kernel/m32r_ksyms.c	2006-04-07 12:52:48.000000000 +0900
+++ linux-2.6.17-rc1-mm1/arch/m32r/kernel/m32r_ksyms.c	2006-04-07 12:56:36.868028610 +0900
@@ -38,10 +38,6 @@ EXPORT_SYMBOL(__udelay);
 EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(__const_udelay);
 
-EXPORT_SYMBOL(__get_user_1);
-EXPORT_SYMBOL(__get_user_2);
-EXPORT_SYMBOL(__get_user_4);
-
 EXPORT_SYMBOL(strstr);
 
 EXPORT_SYMBOL(strncpy_from_user);
Index: linux-2.6.17-rc1-mm1/arch/m32r/lib/Makefile
===================================================================
--- linux-2.6.17-rc1-mm1.orig/arch/m32r/lib/Makefile	2006-04-07 12:12:17.000000000 +0900
+++ linux-2.6.17-rc1-mm1/arch/m32r/lib/Makefile	2006-04-07 12:54:44.085855832 +0900
@@ -2,6 +2,6 @@
 # Makefile for M32R-specific library files..
 #
 
-lib-y  := checksum.o ashxdi3.o memset.o memcpy.o getuser.o \
-	  putuser.o delay.o strlen.o usercopy.o csum_partial_copy.o
+lib-y  := checksum.o ashxdi3.o memset.o memcpy.o \
+	  delay.o strlen.o usercopy.o csum_partial_copy.o
 
Index: linux-2.6.17-rc1-mm1/arch/m32r/lib/getuser.S
===================================================================
--- linux-2.6.17-rc1-mm1.orig/arch/m32r/lib/getuser.S	2006-04-07 12:12:17.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,88 +0,0 @@
-/*
- * __get_user functions.
- *
- * (C) Copyright 2001 Hirokazu Takata
- *
- * These functions have a non-standard call interface
- * to make them more efficient, especially as they
- * return an error value in addition to the "real"
- * return value.
- */
-
-#include <linux/config.h>
-
-/*
- * __get_user_X
- *
- * Inputs:	r0 contains the address
- *
- * Outputs:	r0 is error code (0 or -EFAULT)
- *		r1 contains zero-extended value
- *
- * These functions should not modify any other registers,
- * as they get called from within inline assembly.
- */
-
-#ifdef CONFIG_ISA_DUAL_ISSUE
-
-	.text
-	.balign 4
-	.globl __get_user_1
-__get_user_1:
-1:	ldub	r1, @r0		    ||	ldi	r0, #0
-	jmp	r14
-
-	.balign 4
-	.globl __get_user_2
-__get_user_2:
-2:	lduh	r1, @r0		    ||	ldi	r0, #0
-	jmp	r14
-
-	.balign 4
-	.globl __get_user_4
-__get_user_4:
-3:	ld	r1, @r0		    ||	ldi	r0, #0
-	jmp	r14
-
-bad_get_user:
-	ldi	r1, #0		    ||	ldi	r0, #-14
-	jmp	r14
-
-#else /* not CONFIG_ISA_DUAL_ISSUE */
-
-	.text
-	.balign 4
-	.globl __get_user_1
-__get_user_1:
-1:	ldub	r1, @r0
-	ldi	r0, #0
-	jmp	r14
-
-	.balign 4
-	.globl __get_user_2
-__get_user_2:
-2:	lduh	r1, @r0
-	ldi	r0, #0
-	jmp	r14
-
-	.balign 4
-	.globl __get_user_4
-__get_user_4:
-3:	ld	r1, @r0
-	ldi	r0, #0
-	jmp	r14
-
-bad_get_user:
-	ldi	r1, #0
-	ldi	r0, #-14
-	jmp	r14
-
-#endif /* not CONFIG_ISA_DUAL_ISSUE */
-
-.section __ex_table,"a"
-	.long 1b,bad_get_user
-	.long 2b,bad_get_user
-	.long 3b,bad_get_user
-.previous
-
-	.end
Index: linux-2.6.17-rc1-mm1/arch/m32r/lib/putuser.S
===================================================================
--- linux-2.6.17-rc1-mm1.orig/arch/m32r/lib/putuser.S	2006-04-07 12:12:17.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,84 +0,0 @@
-/*
- * __put_user functions.
- *
- * (C) Copyright 1998 Linus Torvalds
- * (C) Copyright 2001 Hirokazu Takata
- *
- * These functions have a non-standard call interface
- * to make them more efficient.
- */
-
-#include <linux/config.h>
-
-/*
- * __put_user_X
- *
- * Inputs:	r0 contains the address
- *		r1 contains the value
- *
- * Outputs:	r0 is error code (0 or -EFAULT)
- *		r1 is corrupted (will contain "current_task").
- *
- * These functions should not modify any other registers,
- * as they get called from within inline assembly.
- */
-
-#ifdef CONFIG_ISA_DUAL_ISSUE
-
-	.text
-	.balign 4
-	.globl __put_user_1
-__put_user_1:
-1:	stb	r1, @r0		    ||	ldi	r0, #0
-	jmp	r14
-
-	.balign 4
-	.globl __put_user_2
-__put_user_2:
-2:	sth	r1, @r0		    ||	ldi	r0, #0
-	jmp	r14
-
-	.balign 4
-	.globl __put_user_4
-__put_user_4:
-3:	st	r1, @r0		    ||	ldi	r0, #0
-	jmp	r14
-
-bad_put_user:
-	ldi	r0, #-14	    ||	jmp	r14
-
-#else /* not CONFIG_ISA_DUAL_ISSUE */
-
-	.text
-	.balign 4
-	.globl __put_user_1
-__put_user_1:
-1:	stb	r1, @r0
-	ldi	r0, #0
-	jmp	r14
-
-	.balign 4
-	.globl __put_user_2
-__put_user_2:
-2:	sth	r1, @r0
-	ldi	r0, #0
-	jmp	r14
-
-	.balign 4
-	.globl __put_user_4
-__put_user_4:
-3:	st	r1, @r0
-	ldi	r0, #0
-	jmp	r14
-
-bad_put_user:
-	ldi	r0, #-14
-	jmp	r14
-
-#endif /* not CONFIG_ISA_DUAL_ISSUE */
-
-.section __ex_table,"a"
-	.long 1b,bad_put_user
-	.long 2b,bad_put_user
-	.long 3b,bad_put_user
-.previous

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
 

