Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261633AbTCUVRI>; Fri, 21 Mar 2003 16:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbTCUVQX>; Fri, 21 Mar 2003 16:16:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15748
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263769AbTCUSmE>; Fri, 21 Mar 2003 13:42:04 -0500
Date: Fri, 21 Mar 2003 19:57:18 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211957.h2LJvIQS026139@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: document user access functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/include/asm-i386/uaccess.h linux-2.5.65-ac2/include/asm-i386/uaccess.h
--- linux-2.5.65/include/asm-i386/uaccess.h	2003-03-06 17:04:33.000000000 +0000
+++ linux-2.5.65-ac2/include/asm-i386/uaccess.h	2003-03-06 23:12:31.000000000 +0000
@@ -47,7 +47,13 @@
 #define __addr_ok(addr) ((unsigned long)(addr) < (current_thread_info()->addr_limit.seg))
 
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
 #define __range_ok(addr,size) ({ \
 	unsigned long flag,sum; \
@@ -58,6 +64,25 @@
 
 #ifdef CONFIG_X86_WP_WORKS_OK
 
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
 #define access_ok(type,addr,size) (__range_ok(addr,size) == 0)
 
 #else
@@ -68,6 +93,23 @@
 
 #endif
 
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
 static inline int verify_area(int type, const void * addr, unsigned long size)
 {
 	return access_ok(type,addr,size) ? 0 : -EFAULT;
@@ -118,7 +160,25 @@
 		:"=a" (ret),"=d" (x) \
 		:"0" (ptr))
 
+
 /* Careful: we have to cast the result to the type of the pointer for sign reasons */
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
 	switch(sizeof (*(ptr))) {					\
@@ -138,11 +198,70 @@
 
 extern void __put_user_bad(void);
 
+
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
 
@@ -263,6 +382,21 @@
  * If a store crosses a page boundary and gets a fault, the x86 will not write
  * anything, so this is accurate.
  */
+
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
 static inline unsigned long
 __copy_to_user(void *to, const void *from, unsigned long n)
 {
@@ -284,6 +418,23 @@
 	return __copy_to_user_ll(to, from, n);
 }
 
+/**
+ * __copy_from_user: - Copy a block of data from user space, with less checking.
+ * @to:   Destination address, in kernel space.
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
 static inline unsigned long
 __copy_from_user(void *to, const void *from, unsigned long n)
 {
@@ -305,6 +456,19 @@
 	return __copy_from_user_ll(to, from, n);
 }
 
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
 static inline unsigned long
 copy_to_user(void *to, const void *from, unsigned long n)
 {
@@ -313,6 +477,22 @@
 	return n;
 }
 
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
 static inline unsigned long
 copy_from_user(void *to, const void *from, unsigned long n)
 {
@@ -323,7 +503,23 @@
 
 long strncpy_from_user(char *dst, const char *src, long count);
 long __strncpy_from_user(char *dst, const char *src, long count);
+
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
+
 long strnlen_user(const char *str, long n);
 unsigned long clear_user(void *mem, unsigned long len);
 unsigned long __clear_user(void *mem, unsigned long len);
