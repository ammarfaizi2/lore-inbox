Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269007AbTCATuf>; Sat, 1 Mar 2003 14:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269008AbTCATuf>; Sat, 1 Mar 2003 14:50:35 -0500
Received: from smtp.eclipse.net.uk ([212.104.129.70]:4366 "HELO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with SMTP
	id <S269007AbTCATu2>; Sat, 1 Mar 2003 14:50:28 -0500
Message-ID: <3E611167.1080108@jon-foster.co.uk>
Date: Sat, 01 Mar 2003 20:00:39 +0000
From: Jon Foster <jon@jon-foster.co.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en
MIME-Version: 1.0
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.20] Kerneldoc for user space memory access
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch against 2.4.20 adds kerneldoc comments to the public API in these files:
- include/asm-i386/uaccess.h
- arch/i386/lib/usercopy.c

This patch only changes comments and one of the templates used by "make htmldocs",
it does not change any code.

Please cc me on any replies, I am not subscribed to linux-kernel.

Kind regards,

Jon Foster 


diff -urN -X /root/dontdiff -x Makefile linux-2.4.20/Documentation/DocBook/kernel-api.tmpl linux-2.4.20.patched/Documentation/DocBook/kernel-api.tmpl
--- linux-2.4.20/Documentation/DocBook/kernel-api.tmpl	2002-08-03 01:39:42.000000000 +0100
+++ linux-2.4.20.patched/Documentation/DocBook/kernel-api.tmpl	2003-03-01 11:27:55.000000000 +0000
@@ -85,7 +85,11 @@
      <title>Memory Management in Linux</title>
      <sect1><title>The Slab Cache</title>
 !Emm/slab.c
-      </sect1>
+     </sect1>
+     <sect1><title>User Space Memory Access</title>
+!Iinclude/asm-i386/uaccess.h
+!Iarch/i386/lib/usercopy.c
+     </sect1>
   </chapter>
 
   <chapter id="proc">
diff -urN -X /root/dontdiff -x Makefile linux-2.4.20/arch/i386/lib/usercopy.c linux-2.4.20.patched/arch/i386/lib/usercopy.c
--- linux-2.4.20/arch/i386/lib/usercopy.c	2001-11-09 21:58:02.000000000 +0000
+++ linux-2.4.20.patched/arch/i386/lib/usercopy.c	2003-03-01 11:27:16.000000000 +0000
@@ -95,6 +95,26 @@
 		: "memory");						   \
 } while (0)
 
+/**
+ * __strncpy_from_user: - Copy a NUL terminated string from userspace, with less checking.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @src:   Source address, in user space.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ * 
+ * Copies a NUL-terminated string from userspace to kernel space.
+ * Caller must check the specified block with access_ok() before calling
+ * this function.
+ *
+ * On success, returns the length of the string (not including the trailing
+ * NUL).
+ *
+ * If access to userspace fails, returns -EFAULT (some data may have been
+ * copied).
+ *
+ * If @count is smaller than the length of the string, copies @count bytes
+ * and returns @count.
+ */
 long
 __strncpy_from_user(char *dst, const char *src, long count)
 {
@@ -103,6 +123,24 @@
 	return res;
 }
 
+/**
+ * strncpy_from_user: - Copy a NUL terminated string from userspace.
+ * @dst:   Destination address, in kernel space.  This buffer must be at
+ *         least @count bytes long.
+ * @src:   Source address, in user space.
+ * @count: Maximum number of bytes to copy, including the trailing NUL.
+ * 
+ * Copies a NUL-terminated string from userspace to kernel space.
+ *
+ * On success, returns the length of the string (not including the trailing
+ * NUL).
+ *
+ * If access to userspace fails, returns -EFAULT (some data may have been
+ * copied).
+ *
+ * If @count is smaller than the length of the string, copies @count bytes
+ * and returns @count.
+ */
 long
 strncpy_from_user(char *dst, const char *src, long count)
 {
@@ -138,6 +176,16 @@
 		: "r"(size & 3), "0"(size / 4), "1"(addr), "a"(0));	\
 } while (0)
 
+/**
+ * clear_user: - Zero a block of memory in user space.
+ * @to:   Destination address, in user space.
+ * @n:    Number of bytes to zero.
+ *
+ * Zero a block of memory in user space.
+ *
+ * Returns number of bytes that could not be cleared.
+ * On success, this will be zero.
+ */
 unsigned long
 clear_user(void *to, unsigned long n)
 {
@@ -146,6 +194,17 @@
 	return n;
 }
 
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
 unsigned long
 __clear_user(void *to, unsigned long n)
 {
@@ -153,12 +212,17 @@
 	return n;
 }
 
-/*
- * Return the size of a string (including the ending 0)
+/**
+ * strlen_user: - Get the size of a string in user space.
+ * @str: The string to measure.
+ * @n:   The maximum valid length
  *
- * Return 0 on exception, a value greater than N if too long
+ * Get the size of a NUL-terminated string in user space.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ * On exception, returns 0.
+ * If the string is too long, returns a value greater than @n.
  */
-
 long strnlen_user(const char *s, long n)
 {
 	unsigned long mask = -__addr_ok(s);
diff -urN -X /root/dontdiff -x Makefile linux-2.4.20/include/asm-i386/uaccess.h linux-2.4.20.patched/include/asm-i386/uaccess.h
--- linux-2.4.20/include/asm-i386/uaccess.h	2001-11-22 19:46:20.000000000 +0000
+++ linux-2.4.20.patched/include/asm-i386/uaccess.h	2003-03-01 11:28:14.000000000 +0000
@@ -37,7 +37,13 @@
 #define __addr_ok(addr) ((unsigned long)(addr) < (current->addr_limit.seg))
 
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
@@ -48,6 +54,25 @@
 
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
@@ -59,6 +84,23 @@
 
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
@@ -111,7 +153,25 @@
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
@@ -131,11 +191,70 @@
 
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
 
@@ -576,21 +695,81 @@
 	return n;
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
 #define copy_to_user(to,from,n)				\
 	(__builtin_constant_p(n) ?			\
 	 __constant_copy_to_user((to),(from),(n)) :	\
 	 __generic_copy_to_user((to),(from),(n)))
 
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
 	(__builtin_constant_p(n) ?			\
 	 __constant_copy_from_user((to),(from),(n)) :	\
 	 __generic_copy_from_user((to),(from),(n)))
 
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
 #define __copy_to_user(to,from,n)			\
 	(__builtin_constant_p(n) ?			\
 	 __constant_copy_to_user_nocheck((to),(from),(n)) :	\
 	 __generic_copy_to_user_nocheck((to),(from),(n)))
 
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
 #define __copy_from_user(to,from,n)			\
 	(__builtin_constant_p(n) ?			\
 	 __constant_copy_from_user_nocheck((to),(from),(n)) :	\
@@ -598,7 +777,23 @@
 
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

