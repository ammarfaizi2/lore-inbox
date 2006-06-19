Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWFSMZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWFSMZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWFSMZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53693 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932392AbWFSMZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:03 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 01/15] frv: __user infrastructure
Date: Mon, 19 Jun 2006 13:24:45 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Add general annotations to the FRV arch for sparse.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/uaccess.c |    6 ++--
 include/asm-frv/uaccess.h |   64 ++++++++++++++++++++++++++-------------------
 2 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/arch/frv/kernel/uaccess.c b/arch/frv/kernel/uaccess.c
index 9b751c0..9fb771a 100644
--- a/arch/frv/kernel/uaccess.c
+++ b/arch/frv/kernel/uaccess.c
@@ -17,7 +17,7 @@ #include <asm/uaccess.h>
 /*
  * copy a null terminated string from userspace
  */
-long strncpy_from_user(char *dst, const char *src, long count)
+long strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	unsigned long max;
 	char *p, ch;
@@ -70,9 +70,9 @@ EXPORT_SYMBOL(strncpy_from_user);
  *
  * Return 0 on exception, a value greater than N if too long
  */
-long strnlen_user(const char *src, long count)
+long strnlen_user(const char __user *src, long count)
 {
-	const char *p;
+	const char __user *p;
 	long err = 0;
 	char ch;
 
diff --git a/include/asm-frv/uaccess.h b/include/asm-frv/uaccess.h
index a1d1404..3d90e10 100644
--- a/include/asm-frv/uaccess.h
+++ b/include/asm-frv/uaccess.h
@@ -22,7 +22,7 @@ #include <asm/sections.h>
 
 #define HAVE_ARCH_UNMAPPED_AREA	/* we decide where to put mmaps */
 
-#define __ptr(x) ((unsigned long *)(x))
+#define __ptr(x) ((unsigned long __force *)(x))
 
 #define VERIFY_READ	0
 #define VERIFY_WRITE	1
@@ -64,7 +64,7 @@ #endif
 
 #define __range_ok(addr,size) ___range_ok((unsigned long) (addr), (unsigned long) (size))
 
-#define access_ok(type,addr,size) (__range_ok((addr), (size)) == 0)
+#define access_ok(type,addr,size) (__range_ok((void __user *)(addr), (size)) == 0)
 #define __access_ok(addr,size) (__range_ok((addr), (size)) == 0)
 
 /*
@@ -97,6 +97,7 @@ ({									\
 	int __pu_err = 0;						\
 									\
 	typeof(*(ptr)) __pu_val = (x);					\
+	__chk_user_ptr(ptr);						\
 									\
 	switch (sizeof (*(ptr))) {					\
 	case 1:								\
@@ -120,7 +121,7 @@ ({									\
 
 #define put_user(x, ptr)			\
 ({						\
-	typeof(&*ptr) _p = (ptr);		\
+	typeof(*(ptr)) __user *_p = (ptr);	\
 	int _e;					\
 						\
 	_e = __range_ok(_p, sizeof(*_p));	\
@@ -175,33 +176,44 @@ #endif
  */
 #define __get_user(x, ptr)						\
 ({									\
-	typeof(*(ptr)) __gu_val = 0;					\
 	int __gu_err = 0;						\
+	__chk_user_ptr(ptr);						\
 									\
 	switch (sizeof(*(ptr))) {					\
-	case 1:								\
-		__get_user_asm(__gu_err, *(u8*)&__gu_val, ptr, "ub", "=r"); \
+	case 1: {							\
+		unsigned char __gu_val;					\
+		__get_user_asm(__gu_err, __gu_val, ptr, "ub", "=r");	\
+		(x) = *(__force __typeof__(*(ptr)) *) &__gu_val;	\
 		break;							\
-	case 2:								\
-		__get_user_asm(__gu_err, *(u16*)&__gu_val, ptr, "uh", "=r"); \
+	}								\
+	case 2: {							\
+		unsigned short __gu_val;				\
+		__get_user_asm(__gu_err, __gu_val, ptr, "uh", "=r");	\
+		(x) = *(__force __typeof__(*(ptr)) *) &__gu_val;	\
 		break;							\
-	case 4:								\
-		__get_user_asm(__gu_err, *(u32*)&__gu_val, ptr, "", "=r"); \
+	}								\
+	case 4: {							\
+		unsigned int __gu_val;					\
+		__get_user_asm(__gu_err, __gu_val, ptr, "", "=r");	\
+		(x) = *(__force __typeof__(*(ptr)) *) &__gu_val;	\
 		break;							\
-	case 8:								\
-		__get_user_asm(__gu_err, *(u64*)&__gu_val, ptr, "d", "=e"); \
+	}								\
+	case 8: {							\
+		unsigned long long __gu_val;				\
+		__get_user_asm(__gu_err, __gu_val, ptr, "d", "=e");	\
+		(x) = *(__force __typeof__(*(ptr)) *) &__gu_val;	\
 		break;							\
+	}								\
 	default:							\
 		__gu_err = __get_user_bad();				\
 		break;							\
 	}								\
-	(x) = __gu_val;							\
 	__gu_err;							\
 })
 
 #define get_user(x, ptr)			\
 ({						\
-	typeof(&*ptr) _p = (ptr);		\
+	const typeof(*(ptr)) __user *_p = (ptr);\
 	int _e;					\
 						\
 	_e = __range_ok(_p, sizeof(*_p));	\
@@ -248,19 +260,20 @@ #endif
 /*
  *
  */
+#define ____force(x) (__force void *)(void __user *)(x)
 #ifdef CONFIG_MMU
 extern long __memset_user(void *dst, unsigned long count);
 extern long __memcpy_user(void *dst, const void *src, unsigned long count);
 
-#define clear_user(dst,count)			__memset_user((dst), (count))
-#define __copy_from_user_inatomic(to, from, n)	__memcpy_user((to), (from), (n))
-#define __copy_to_user_inatomic(to, from, n)	__memcpy_user((to), (from), (n))
+#define clear_user(dst,count)			__memset_user(____force(dst), (count))
+#define __copy_from_user_inatomic(to, from, n)	__memcpy_user((to), ____force(from), (n))
+#define __copy_to_user_inatomic(to, from, n)	__memcpy_user(____force(to), (from), (n))
 
 #else
 
-#define clear_user(dst,count)			(memset((dst), 0, (count)), 0)
-#define __copy_from_user_inatomic(to, from, n)	(memcpy((to), (from), (n)), 0)
-#define __copy_to_user_inatomic(to, from, n)	(memcpy((to), (from), (n)), 0)
+#define clear_user(dst,count)			(memset(____force(dst), 0, (count)), 0)
+#define __copy_from_user_inatomic(to, from, n)	(memcpy((to), ____force(from), (n)), 0)
+#define __copy_to_user_inatomic(to, from, n)	(memcpy(____force(to), (from), (n)), 0)
 
 #endif
 
@@ -278,7 +291,7 @@ __copy_from_user(void *to, const void __
        return __copy_from_user_inatomic(to, from, n);
 }
 
-static inline long copy_from_user(void *to, const void *from, unsigned long n)
+static inline long copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	unsigned long ret = n;
 
@@ -291,16 +304,13 @@ static inline long copy_from_user(void *
 	return ret;
 }
 
-static inline long copy_to_user(void *to, const void *from, unsigned long n)
+static inline long copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	return likely(__access_ok(to, n)) ? __copy_to_user(to, from, n) : n;
 }
 
-#define copy_to_user_ret(to,from,n,retval)	({ if (copy_to_user(to,from,n)) return retval; })
-#define copy_from_user_ret(to,from,n,retval)	({ if (copy_from_user(to,from,n)) return retval; })
-
-extern long strncpy_from_user(char *dst, const char *src, long count);
-extern long strnlen_user(const char *src, long count);
+extern long strncpy_from_user(char *dst, const char __user *src, long count);
+extern long strnlen_user(const char __user *src, long count);
 
 #define strlen_user(str) strnlen_user(str, 32767)
 

