Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUIKUw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUIKUw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUIKUw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:52:57 -0400
Received: from hcc022004.bai.ne.jp ([210.171.22.4]:42121 "HELO
	tigger.internet.email.ne.jp") by vger.kernel.org with SMTP
	id S268311AbUIKUvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:51:15 -0400
Date: Sun, 12 Sep 2004 05:51:13 +0900 (JST)
Message-Id: <20040912.055113.884011275.takata@linux-m32r.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm4 4/6] [m32r] Update uaccess.h
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
In-Reply-To: <20040912.052403.730551818.takata@linux-m32r.org>
References: <20040912.052403.730551818.takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.9-rc1-mm4 4/6] [m32r] Update uaccess.h
  This patch updates asm-m32r/uaccess.h.

	* include/asm-m32r/uaccess.h:
	(__copy_to_user_inatomic): Added.
	(__copy_from_user_inatomic): Added.
	Update comments.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/uaccess.h |  349 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 290 insertions(+), 59 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm4.orig/include/asm-m32r/uaccess.h linux-2.6.9-rc1-mm4/include/asm-m32r/uaccess.h
--- linux-2.6.9-rc1-mm4.orig/include/asm-m32r/uaccess.h	2004-09-08 08:14:17.000000000 +0900
+++ linux-2.6.9-rc1-mm4/include/asm-m32r/uaccess.h	2004-09-12 04:46:32.000000000 +0900
@@ -1,7 +1,12 @@
 #ifndef _ASM_M32R_UACCESS_H
 #define _ASM_M32R_UACCESS_H
 
-/* $Id$ */
+/*
+ *  linux/include/asm-m32r/uaccess.h
+ *
+ *  M32R version.
+ *    Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
+ */
 
 #undef UACCESS_DEBUG
 
@@ -61,7 +66,13 @@ static inline void set_fs(mm_segment_t s
 	((unsigned long)(addr) < (current_thread_info()->addr_limit.seg))
 
 /*
- * Uhhuh, this needs 33-bit arithmetic. We have a carry..
+ * Test whether a block of memory is a valid user space address.
+ * Returns 0 if the range is valid, nonzero otherwise.
+ *
+ * This is equivalent to the following test:
+ * (u33)addr + (u33)size >= (u33)current->addr_limit.seg
+ *
+ * This needs 33-bit arithmetic. We have a carry...
  */
 #define __range_ok(addr,size) ({					\
 	unsigned long flag, sum; 					\
@@ -78,8 +89,27 @@ static inline void set_fs(mm_segment_t s
 		: "cbit" );						\
 	flag; })
 
+/**
+ * access_ok: - Checks if a user space pointer is valid
+ * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
+ *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
+ *        to write to a block, it is always safe to read from it.
+ * @addr: User space pointer to start of block to check
+ * @size: Size of block to check
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Checks if a pointer to a block of memory in user space is valid.
+ *
+ * Returns true (nonzero) if the memory block may be valid, false (zero)
+ * if it is definitely invalid.
+ *
+ * Note that, depending on architecture, this function probably just
+ * checks that the pointer is in the user space range - after calling
+ * this function, memory access functions may still return -EFAULT.
+ */
 #ifdef CONFIG_MMU
-#define access_ok(type,addr,size) (__range_ok(addr,size) == 0)
+#define access_ok(type,addr,size) (likely(__range_ok(addr,size) == 0))
 #else
 static inline int access_ok(int type, const void *addr, unsigned long size)
 {
@@ -90,8 +120,25 @@ static inline int access_ok(int type, co
 }
 #endif /* CONFIG_MMU */
 
-static __inline__ int verify_area(int type, const void __user *addr,
-	unsigned long size)
+/**
+ * verify_area: - Obsolete, use access_ok()
+ * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE
+ * @addr: User space pointer to start of block to check
+ * @size: Size of block to check
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This function has been replaced by access_ok().
+ *
+ * Checks if a pointer to a block of memory in user space is valid.
+ *
+ * Returns zero if the memory block may be valid, -EFAULT
+ * if it is definitely invalid.
+ *
+ * See access_ok() for more details.
+ */
+static inline int verify_area(int type, const void __user *addr,
+			      unsigned long size)
 {
 	return access_ok(type, addr, size) ? 0 : -EFAULT;
 }
@@ -167,6 +214,23 @@ extern void __get_user_4(void);
 
 /* Careful: we have to cast the result to the type of the pointer for sign
    reasons */
+/**
+ * get_user: - Get a simple variable from user space.
+ * @x:   Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple variable from user space to kernel
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and the result of
+ * dereferencing @ptr must be assignable to @x without a cast.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ * On error, the variable @x is set to zero.
+ */
 #define get_user(x,ptr)							\
 ({	int __ret_gu,__val_gu;						\
 	__chk_user_ptr(ptr);						\
@@ -182,11 +246,69 @@ extern void __get_user_4(void);
 
 extern void __put_user_bad(void);
 
+/**
+ * put_user: - Write a simple value into user space.
+ * @x:   Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple value from kernel space to user
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and @x must be assignable
+ * to the result of dereferencing @ptr.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ */
 #define put_user(x,ptr)							\
   __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
 
+
+/**
+ * __get_user: - Get a simple variable from user space, with less checking.
+ * @x:   Variable to store result.
+ * @ptr: Source address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple variable from user space to kernel
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and the result of
+ * dereferencing @ptr must be assignable to @x without a cast.
+ *
+ * Caller must check the pointer with access_ok() before calling this
+ * function.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ * On error, the variable @x is set to zero.
+ */
 #define __get_user(x,ptr) \
   __get_user_nocheck((x),(ptr),sizeof(*(ptr)))
+
+
+/**
+ * __put_user: - Write a simple value into user space, with less checking.
+ * @x:   Value to copy to user space.
+ * @ptr: Destination address, in user space.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * This macro copies a single simple value from kernel space to user
+ * space.  It supports simple types like char and int, but not larger
+ * data types like structures or arrays.
+ *
+ * @ptr must have pointer-to-simple-variable type, and @x must be assignable
+ * to the result of dereferencing @ptr.
+ *
+ * Caller must check the pointer with access_ok() before calling this
+ * function.
+ *
+ * Returns zero on success, or -EFAULT on error.
+ */
 #define __put_user(x,ptr) \
   __put_user_nocheck((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
 
@@ -208,48 +330,6 @@ extern void __put_user_bad(void);
 	__pu_err;							\
 })
 
-#define __put_user_size(x,ptr,size,retval)				\
-do {									\
-	retval = 0;							\
-	__chk_user_ptr(ptr);						\
-	switch (size) {							\
-	  case 1: __put_user_asm(x,ptr,retval,"b"); break;		\
-	  case 2: __put_user_asm(x,ptr,retval,"h"); break;		\
-	  case 4: __put_user_asm(x,ptr,retval,""); break;		\
-	  case 8: __put_user_u64((__typeof__(*ptr))(x),ptr,retval); break;\
-	  default: __put_user_bad();					\
-	}								\
-} while (0)
-
-struct __large_struct { unsigned long buf[100]; };
-#define __m(x) (*(struct __large_struct *)(x))
-
-/*
- * Tell gcc we read from memory instead of writing: this is because
- * we do not write to any memory gcc knows about, so there are no
- * aliasing issues.
- */
-#define __put_user_asm(x, addr, err, itype)				\
-	__asm__ __volatile__(						\
-		"	.fillinsn\n"					\
-		"1:	st"itype" %1,@%2\n"				\
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
-		: "=r"(err)						\
-		: "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
-		: "r14", "memory")
-
 #if defined(__LITTLE_ENDIAN__)
 #define __put_user_u64(x, addr, err)                                    \
         __asm__ __volatile__(                                           \
@@ -303,6 +383,48 @@ struct __large_struct { unsigned long bu
 #error no endian defined
 #endif
 
+#define __put_user_size(x,ptr,size,retval)				\
+do {									\
+	retval = 0;							\
+	__chk_user_ptr(ptr);						\
+	switch (size) {							\
+	  case 1: __put_user_asm(x,ptr,retval,"b"); break;		\
+	  case 2: __put_user_asm(x,ptr,retval,"h"); break;		\
+	  case 4: __put_user_asm(x,ptr,retval,""); break;		\
+	  case 8: __put_user_u64((__typeof__(*ptr))(x),ptr,retval); break;\
+	  default: __put_user_bad();					\
+	}								\
+} while (0)
+
+struct __large_struct { unsigned long buf[100]; };
+#define __m(x) (*(struct __large_struct *)(x))
+
+/*
+ * Tell gcc we read from memory instead of writing: this is because
+ * we do not write to any memory gcc knows about, so there are no
+ * aliasing issues.
+ */
+#define __put_user_asm(x, addr, err, itype)				\
+	__asm__ __volatile__(						\
+		"	.fillinsn\n"					\
+		"1:	st"itype" %1,@%2\n"				\
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
+		: "=r"(err)						\
+		: "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
+		: "r14", "memory")
+
 #define __get_user_nocheck(x,ptr,size)					\
 ({									\
 	long __gu_err, __gu_val;					\
@@ -346,6 +468,13 @@ do {									\
 		: "r"(addr), "i"(-EFAULT), "0"(err)			\
 		: "r14", "memory")
 
+/*
+ * Here we special-case 1, 2 and 4-byte copy_*_user invocations.  On a fault
+ * we return the initial request size (1, 2 or 4), as copy_*_user should do.
+ * If a store crosses a page boundary and gets a fault, the m32r will not write
+ * anything, so this is accurate.
+ */
+
 
 /*
  * Copy To/From Userspace
@@ -475,14 +604,14 @@ do {									\
 /* We let the __ versions of copy_from/to_user inline, because they're often
  * used in fast paths and have only a small space overhead.
  */
-static __inline__ unsigned long __generic_copy_from_user_nocheck(void *to,
+static inline unsigned long __generic_copy_from_user_nocheck(void *to,
 	const void __user *from, unsigned long n)
 {
 	__copy_user_zeroing(to,from,n);
 	return n;
 }
 
-static __inline__ unsigned long __generic_copy_to_user_nocheck(void __user *to,
+static inline unsigned long __generic_copy_to_user_nocheck(void __user *to,
 	const void *from, unsigned long n)
 {
 	__copy_user(to,from,n);
@@ -492,30 +621,132 @@ static __inline__ unsigned long __generi
 unsigned long __generic_copy_to_user(void *, const void *, unsigned long);
 unsigned long __generic_copy_from_user(void *, const void *, unsigned long);
 
+/**
+ * __copy_to_user: - Copy a block of data into user space, with less checking.
+ * @to:   Destination address, in user space.
+ * @from: Source address, in kernel space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from kernel space to user space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ */
+#define __copy_to_user(to,from,n)			\
+	__generic_copy_to_user_nocheck((to),(from),(n))
+
+#define __copy_to_user_inatomic __copy_to_user
+#define __copy_from_user_inatomic __copy_from_user
+
+/**
+ * copy_to_user: - Copy a block of data into user space.
+ * @to:   Destination address, in user space.
+ * @from: Source address, in kernel space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from kernel space to user space.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ */
 #define copy_to_user(to,from,n)				\
 ({							\
 	might_sleep();					\
 	__generic_copy_to_user((to),(from),(n));	\
 })
 
+/**
+ * __copy_from_user: - Copy a block of data from user space, with less checking. * @to:   Destination address, in kernel space.
+ * @from: Source address, in user space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from user space to kernel space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ *
+ * If some data could not be copied, this function will pad the copied
+ * data to the requested size using zero bytes.
+ */
+#define __copy_from_user(to,from,n)			\
+	__generic_copy_from_user_nocheck((to),(from),(n))
+
+/**
+ * copy_from_user: - Copy a block of data from user space.
+ * @to:   Destination address, in kernel space.
+ * @from: Source address, in user space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from user space to kernel space.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ *
+ * If some data could not be copied, this function will pad the copied
+ * data to the requested size using zero bytes.
+ */
 #define copy_from_user(to,from,n)			\
 ({							\
 	might_sleep();					\
-	__generic_copy_from_user((to),(from),(n));	\
+__generic_copy_from_user((to),(from),(n));	\
 })
 
-#define __copy_to_user(to,from,n)			\
-	__generic_copy_to_user_nocheck((to),(from),(n))
+long __must_check strncpy_from_user(char *dst, const char __user *src, 
+				long count);
+long __must_check __strncpy_from_user(char *dst, 
+				const char __user *src, long count);
+
+/**
+ * __clear_user: - Zero a block of memory in user space, with less checking.
+ * @to:   Destination address, in user space.
+ * @n:    Number of bytes to zero.
+ *
+ * Zero a block of memory in user space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be cleared.
+ * On success, this will be zero.
+ */
+unsigned long __clear_user(void __user *mem, unsigned long len);
 
-#define __copy_from_user(to,from,n)			\
-	__generic_copy_from_user_nocheck((to),(from),(n))
+/**
+ * clear_user: - Zero a block of memory in user space.
+ * @to:   Destination address, in user space.
+ * @n:    Number of bytes to zero.
+ *
+ * Zero a block of memory in user space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be cleared.
+ * On success, this will be zero.
+ */
+unsigned long clear_user(void __user *mem, unsigned long len);
 
-long strncpy_from_user(char *dst, const char __user *src, long count);
-long __strncpy_from_user(char *dst, const char __user *src, long count);
+/**
+ * strlen_user: - Get the size of a string in user space.
+ * @str: The string to measure.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Get the size of a NUL-terminated string in user space.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ * On exception, returns 0.
+ *
+ * If there is a limit on the length of a valid string, you may wish to
+ * consider using strnlen_user() instead.
+ */
 #define strlen_user(str) strnlen_user(str, ~0UL >> 1)
 long strnlen_user(const char __user *str, long n);
-unsigned long clear_user(void __user *mem, unsigned long len);
-unsigned long __clear_user(void __user *mem, unsigned long len);
 
 #endif /* _ASM_M32R_UACCESS_H */
-

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
