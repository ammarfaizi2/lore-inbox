Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161386AbWJSKZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161386AbWJSKZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161384AbWJSKZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:25:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161389AbWJSKZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:25:44 -0400
Message-Id: <20061019102309.418163000@chello.nl>
References: <20061019101722.805147000@chello.nl>
User-Agent: quilt/0.45-1
Date: Thu, 19 Oct 2006 12:17:26 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [RFC][PATCH 4/4] mm: move pagefault_{disable,enable}() into __copy_{to,from}_user_inatomic()
Content-Disposition: inline; filename=copy_from_user_inatomic.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the pagefault_{disable,enable}() calls into 
__copy_{to,from}_user_inatomic().

This breaks NTFS.

Also, if we take the previous patch where k{,un}map_atomic() create an
atomic scope this patch is not really needed since all calls to the
_inatomic copies are done from within k{,un}map_atomic() or interrupt
context (except NTFS).

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/x86_64/lib/copy_user.S     |    2 +-
 include/asm-alpha/uaccess.h     |   20 ++++++++++++++++++--
 include/asm-arm/uaccess.h       |   21 +++++++++++++++++++--
 include/asm-arm26/uaccess.h     |   21 +++++++++++++++++++--
 include/asm-avr32/uaccess.h     |   21 +++++++++++++++++++--
 include/asm-cris/uaccess.h      |   23 +++++++++++++++++++++--
 include/asm-frv/uaccess.h       |   33 +++++++++++++++++++++++++++------
 include/asm-h8300/uaccess.h     |   22 ++++++++++++++++++++--
 include/asm-i386/uaccess.h      |   36 +++++++++++++++++++++++-------------
 include/asm-ia64/uaccess.h      |   22 ++++++++++++++++++++--
 include/asm-m32r/uaccess.h      |   21 +++++++++++++++++++--
 include/asm-m68k/uaccess.h      |   21 +++++++++++++++++++--
 include/asm-m68knommu/uaccess.h |   22 ++++++++++++++++++++--
 include/asm-mips/uaccess.h      |   21 +++++++++++++++++++--
 include/asm-parisc/uaccess.h    |   22 ++++++++++++++++++++--
 include/asm-powerpc/uaccess.h   |   28 ++++++++++++++++++++++++----
 include/asm-s390/uaccess.h      |   21 +++++++++++++++++++--
 include/asm-sh/uaccess.h        |   20 ++++++++++++++++++--
 include/asm-sh64/uaccess.h      |   21 +++++++++++++++++++--
 include/asm-sparc/uaccess.h     |   21 +++++++++++++++++++--
 include/asm-sparc64/uaccess.h   |   22 ++++++++++++++++++++--
 include/asm-um/uaccess.h        |   21 +++++++++++++++++++--
 include/asm-v850/uaccess.h      |   21 +++++++++++++++++++--
 include/asm-x86_64/uaccess.h    |   18 ++++++++++++++++--
 include/asm-xtensa/uaccess.h    |   21 +++++++++++++++++++--
 include/linux/uaccess.h         |    3 ++-
 kernel/futex.c                  |    2 --
 27 files changed, 478 insertions(+), 69 deletions(-)

Index: linux-2.6/arch/x86_64/lib/copy_user.S
===================================================================
--- linux-2.6.orig/arch/x86_64/lib/copy_user.S
+++ linux-2.6/arch/x86_64/lib/copy_user.S
@@ -52,7 +52,7 @@ ENTRY(copy_user_generic)
 	ALTERNATIVE_JUMP X86_FEATURE_REP_GOOD,copy_user_generic_unrolled,copy_user_generic_string
 	CFI_ENDPROC
 
-ENTRY(__copy_from_user_inatomic)
+ENTRY(____copy_from_user_inatomic)
 	CFI_STARTPROC
 	xorl %ecx,%ecx	/* clear zero flag */
 	ALTERNATIVE_JUMP X86_FEATURE_REP_GOOD,copy_user_generic_unrolled,copy_user_generic_string
Index: linux-2.6/include/asm-alpha/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/uaccess.h
+++ linux-2.6/include/asm-alpha/uaccess.h
@@ -390,9 +390,25 @@ __copy_tofrom_user(void *to, const void 
 	__copy_tofrom_user_nocheck((to),(__force void *)(from),(n));	\
 })
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 extern inline long
 copy_to_user(void __user *to, const void *from, long n)
Index: linux-2.6/include/asm-arm/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-arm/uaccess.h
+++ linux-2.6/include/asm-arm/uaccess.h
@@ -411,8 +411,25 @@ static inline unsigned long copy_to_user
 	return n;
 }
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 static inline unsigned long clear_user(void __user *to, unsigned long n)
 {
Index: linux-2.6/include/asm-arm26/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-arm26/uaccess.h
+++ linux-2.6/include/asm-arm26/uaccess.h
@@ -247,8 +247,25 @@ static __inline__ unsigned long __copy_t
 	return n;
 }
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 static __inline__ unsigned long clear_user (void *to, unsigned long n)
 {
Index: linux-2.6/include/asm-avr32/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-avr32/uaccess.h
+++ linux-2.6/include/asm-avr32/uaccess.h
@@ -95,8 +95,25 @@ static inline __kernel_size_t __copy_fro
 	return __copy_user(to, (const void __force *)from, n);
 }
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 /*
  * put_user: - Write a simple value into user space.
Index: linux-2.6/include/asm-cris/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-cris/uaccess.h
+++ linux-2.6/include/asm-cris/uaccess.h
@@ -428,8 +428,27 @@ __generic_clear_user_nocheck(void *to, u
 
 #define __copy_to_user(to,from,n)   __generic_copy_to_user_nocheck((to),(from),(n))
 #define __copy_from_user(to,from,n) __generic_copy_from_user_nocheck((to),(from),(n))
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
 #define __clear_user(to,n) __generic_clear_user_nocheck((to),(n))
 
 #define strlen_user(str)	strnlen_user((str), 0x7ffffffe)
Index: linux-2.6/include/asm-frv/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-frv/uaccess.h
+++ linux-2.6/include/asm-frv/uaccess.h
@@ -266,29 +266,50 @@ extern long __memset_user(void *dst, uns
 extern long __memcpy_user(void *dst, const void *src, unsigned long count);
 
 #define clear_user(dst,count)			__memset_user(____force(dst), (count))
-#define __copy_from_user_inatomic(to, from, n)	__memcpy_user((to), ____force(from), (n))
-#define __copy_to_user_inatomic(to, from, n)	__memcpy_user(____force(to), (from), (n))
+#define ____copy_from_user(to, from, n)		__memcpy_user((to), ____force(from), (n))
+#define ____copy_to_user(to, from, n)		__memcpy_user(____force(to), (from), (n))
 
 #else
 
 #define clear_user(dst,count)			(memset(____force(dst), 0, (count)), 0)
-#define __copy_from_user_inatomic(to, from, n)	(memcpy((to), ____force(from), (n)), 0)
-#define __copy_to_user_inatomic(to, from, n)	(memcpy(____force(to), (from), (n)), 0)
+#define ____copy_from_user(to, from, n)		(memcpy((to), ____force(from), (n)), 0)
+#define ____copy_to_user(to, from, n)		(memcpy(____force(to), (from), (n)), 0)
 
 #endif
 
+
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = ____copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = ____copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
 static inline unsigned long __must_check
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
        might_sleep();
-       return __copy_to_user_inatomic(to, from, n);
+       return ____copy_to_user(to, from, n);
 }
 
 static inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
        might_sleep();
-       return __copy_from_user_inatomic(to, from, n);
+       return ____copy_from_user(to, from, n);
 }
 
 static inline long copy_from_user(void *to, const void __user *from, unsigned long n)
Index: linux-2.6/include/asm-h8300/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-h8300/uaccess.h
+++ linux-2.6/include/asm-h8300/uaccess.h
@@ -118,8 +118,26 @@ extern int __get_user_bad(void);
 
 #define __copy_from_user(to, from, n) copy_from_user(to, from, n)
 #define __copy_to_user(to, from, n) copy_to_user(to, from, n)
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 #define copy_to_user_ret(to,from,n,retval) ({ if (copy_to_user(to,from,n)) return retval; })
 
Index: linux-2.6/include/asm-i386/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-i386/uaccess.h
+++ linux-2.6/include/asm-i386/uaccess.h
@@ -407,22 +407,25 @@ unsigned long __must_check __copy_from_u
 static __always_inline unsigned long __must_check
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
+	unsigned long ret;
+	pagefault_disable();
 	if (__builtin_constant_p(n)) {
-		unsigned long ret;
-
 		switch (n) {
 		case 1:
 			__put_user_size(*(u8 *)from, (u8 __user *)to, 1, ret, 1);
-			return ret;
+			goto out;
 		case 2:
 			__put_user_size(*(u16 *)from, (u16 __user *)to, 2, ret, 2);
-			return ret;
+			goto out;
 		case 4:
 			__put_user_size(*(u32 *)from, (u32 __user *)to, 4, ret, 4);
-			return ret;
+			goto out;
 		}
 	}
-	return __copy_to_user_ll(to, from, n);
+	ret = __copy_to_user_ll(to, from, n);
+out:
+	pagefault_enable();
+	return ret;
 }
 
 /**
@@ -449,27 +452,30 @@ __copy_to_user(void __user *to, const vo
 static __always_inline unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
+	unsigned long ret;
+	pagefault_dislabe();
 	/* Avoid zeroing the tail if the copy fails..
 	 * If 'n' is constant and 1, 2, or 4, we do still zero on a failure,
 	 * but as the zeroing behaviour is only significant when n is not
 	 * constant, that shouldn't be a problem.
 	 */
 	if (__builtin_constant_p(n)) {
-		unsigned long ret;
-
 		switch (n) {
 		case 1:
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
-			return ret;
+			goto out;
 		case 2:
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
-			return ret;
+			goto out;
 		case 4:
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
-			return ret;
+			goto out;
 		}
 	}
-	return __copy_from_user_ll_nozero(to, from, n);
+	ret = __copy_from_user_ll_nozero(to, from, n);
+out:
+	pagefault_enable();
+	return ret;
 }
 
 /**
@@ -543,7 +549,11 @@ static __always_inline unsigned long __c
 static __always_inline unsigned long
 __copy_from_user_inatomic_nocache(void *to, const void __user *from, unsigned long n)
 {
-       return __copy_from_user_ll_nocache_nozero(to, from, n);
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user_ll_nocache_nozero(to, from, n);
+	pagefault_enable();
+	return ret;
 }
 
 unsigned long __must_check copy_to_user(void __user *to,
Index: linux-2.6/include/asm-ia64/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/uaccess.h
+++ linux-2.6/include/asm-ia64/uaccess.h
@@ -249,8 +249,26 @@ __copy_from_user (void *to, const void _
 	return __copy_user((__force void __user *) to, from, count);
 }
 
-#define __copy_to_user_inatomic		__copy_to_user
-#define __copy_from_user_inatomic	__copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
 #define copy_to_user(to, from, n)							\
 ({											\
 	void __user *__cu_to = (to);							\
Index: linux-2.6/include/asm-m32r/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-m32r/uaccess.h
+++ linux-2.6/include/asm-m32r/uaccess.h
@@ -579,8 +579,25 @@ unsigned long __generic_copy_from_user(v
 #define __copy_to_user(to,from,n)			\
 	__generic_copy_to_user_nocheck((to),(from),(n))
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 /**
  * copy_to_user: - Copy a block of data into user space.
Index: linux-2.6/include/asm-m68k/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/uaccess.h
+++ linux-2.6/include/asm-m68k/uaccess.h
@@ -352,8 +352,25 @@ __constant_copy_to_user(void __user *to,
  __constant_copy_to_user(to, from, n) :		\
  __generic_copy_to_user(to, from, n))
 
-#define __copy_to_user_inatomic		__copy_to_user
-#define __copy_from_user_inatomic	__copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 #define copy_from_user(to, from, n)	__copy_from_user(to, from, n)
 #define copy_to_user(to, from, n)	__copy_to_user(to, from, n)
Index: linux-2.6/include/asm-m68knommu/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/uaccess.h
+++ linux-2.6/include/asm-m68knommu/uaccess.h
@@ -129,8 +129,26 @@ extern int __get_user_bad(void);
 
 #define __copy_from_user(to, from, n) copy_from_user(to, from, n)
 #define __copy_to_user(to, from, n) copy_to_user(to, from, n)
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 #define copy_to_user_ret(to,from,n,retval) ({ if (copy_to_user(to,from,n)) return retval; })
 
Index: linux-2.6/include/asm-mips/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-mips/uaccess.h
+++ linux-2.6/include/asm-mips/uaccess.h
@@ -432,8 +432,25 @@ extern size_t __copy_user(void *__to, co
 	__cu_len;							\
 })
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 /*
  * copy_to_user: - Copy a block of data into user space.
Index: linux-2.6/include/asm-parisc/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/uaccess.h
+++ linux-2.6/include/asm-parisc/uaccess.h
@@ -282,7 +282,25 @@ unsigned long copy_from_user(void *dst, 
 #define __copy_from_user copy_from_user
 unsigned long copy_in_user(void __user *dst, const void __user *src, unsigned long len);
 #define __copy_in_user copy_in_user
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 #endif /* __PARISC_UACCESS_H */
Index: linux-2.6/include/asm-powerpc/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/uaccess.h
+++ linux-2.6/include/asm-powerpc/uaccess.h
@@ -348,7 +348,7 @@ extern unsigned long copy_in_user(void _
 
 #endif /* __powerpc64__ */
 
-static inline unsigned long __copy_from_user_inatomic(void *to,
+static inline unsigned long ____copy_from_user(void *to,
 		const void __user *from, unsigned long n)
 {
 	if (__builtin_constant_p(n) && (n <= 8)) {
@@ -374,7 +374,7 @@ static inline unsigned long __copy_from_
 	return __copy_tofrom_user((__force void __user *)to, from, n);
 }
 
-static inline unsigned long __copy_to_user_inatomic(void __user *to,
+static inline unsigned long ____copy_to_user(void __user *to,
 		const void *from, unsigned long n)
 {
 	if (__builtin_constant_p(n) && (n <= 8)) {
@@ -400,18 +400,38 @@ static inline unsigned long __copy_to_us
 	return __copy_tofrom_user(to, (__force const void __user *)from, n);
 }
 
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = ____copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = ____copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
 static inline unsigned long __copy_from_user(void *to,
 		const void __user *from, unsigned long size)
 {
 	might_sleep();
-	return __copy_from_user_inatomic(to, from, size);
+	return ____copy_from_user(to, from, size);
 }
 
 static inline unsigned long __copy_to_user(void __user *to,
 		const void *from, unsigned long size)
 {
 	might_sleep();
-	return __copy_to_user_inatomic(to, from, size);
+	return ____copy_to_user(to, from, size);
 }
 
 extern unsigned long __clear_user(void __user *addr, unsigned long size);
Index: linux-2.6/include/asm-s390/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-s390/uaccess.h
+++ linux-2.6/include/asm-s390/uaccess.h
@@ -210,8 +210,25 @@ __copy_to_user(void __user *to, const vo
 		return uaccess.copy_to_user(n, to, from);
 }
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 /**
  * copy_to_user: - Copy a block of data into user space.
Index: linux-2.6/include/asm-sh/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-sh/uaccess.h
+++ linux-2.6/include/asm-sh/uaccess.h
@@ -424,9 +424,25 @@ __copy_res; })
 	__copy_user((void *)(to),		\
 		    (void *)(from), n)
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 #define copy_from_user(to,from,n) ({ \
 void *__copy_to = (void *) (to); \
Index: linux-2.6/include/asm-sh64/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-sh64/uaccess.h
+++ linux-2.6/include/asm-sh64/uaccess.h
@@ -251,8 +251,25 @@ if (__copy_from_user(to,from,n)) \
 	return retval; \
 })
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 /* XXX: Not sure it works well..
    should be such that: 4byte clear and the rest. */
Index: linux-2.6/include/asm-sparc/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/uaccess.h
+++ linux-2.6/include/asm-sparc/uaccess.h
@@ -271,8 +271,25 @@ static inline unsigned long __copy_from_
 	return __copy_user((__force void __user *) to, from, n);
 }
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 static inline unsigned long __clear_user(void __user *addr, unsigned long size)
 {
Index: linux-2.6/include/asm-sparc64/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/uaccess.h
+++ linux-2.6/include/asm-sparc64/uaccess.h
@@ -265,8 +265,26 @@ extern long __strnlen_user(const char __
 
 #define strlen_user __strlen_user
 #define strnlen_user __strnlen_user
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 #endif  /* __ASSEMBLY__ */
 
Index: linux-2.6/include/asm-um/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-um/uaccess.h
+++ linux-2.6/include/asm-um/uaccess.h
@@ -36,8 +36,25 @@
 
 #define __copy_to_user(to, from, n) copy_to_user(to, from, n)
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 #define __get_user(x, ptr) \
 ({ \
Index: linux-2.6/include/asm-v850/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-v850/uaccess.h
+++ linux-2.6/include/asm-v850/uaccess.h
@@ -107,8 +107,25 @@ extern int bad_user_access_length (void)
 #define __copy_from_user(to, from, n)	(memcpy (to, from, n), 0)
 #define __copy_to_user(to, from, n)	(memcpy(to, from, n), 0)
 
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 #define copy_from_user(to, from, n)	__copy_from_user (to, from, n)
 #define copy_to_user(to, from, n) 	__copy_to_user(to, from, n)
Index: linux-2.6/include/asm-x86_64/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/uaccess.h
+++ linux-2.6/include/asm-x86_64/uaccess.h
@@ -360,12 +360,26 @@ __must_check long strlen_user(const char
 __must_check unsigned long clear_user(void __user *mem, unsigned long len);
 __must_check unsigned long __clear_user(void __user *mem, unsigned long len);
 
-__must_check long __copy_from_user_inatomic(void *dst, const void __user *src, unsigned size);
+__must_check long ____copy_from_user_inatomic(void *dst, const void __user *src, unsigned size);
+
+static __must_check __always_inline long
+__copy_from_user_inatomic(void *dst, const void __user *src, unsigned size)
+{
+	long ret;
+	pagefault_disable();
+	ret = ____copy_from_user_inatomic(dst, src, size);
+	pagefault_enable();
+	return ret;
+}
 
 static __must_check __always_inline int
 __copy_to_user_inatomic(void __user *dst, const void *src, unsigned size)
 {
-	return copy_user_generic((__force void *)dst, src, size);
+	int ret;
+	pagefault_disable();
+	ret = copy_user_generic((__force void *)dst, src, size);
+	pagefault_enable();
+	return ret;
 }
 
 #endif /* __X86_64_UACCESS_H */
Index: linux-2.6/include/asm-xtensa/uaccess.h
===================================================================
--- linux-2.6.orig/include/asm-xtensa/uaccess.h
+++ linux-2.6/include/asm-xtensa/uaccess.h
@@ -419,9 +419,26 @@ __generic_copy_from_user(void *to, const
 #define copy_from_user(to,from,n) __generic_copy_from_user((to),(from),(n))
 #define __copy_to_user(to,from,n) __generic_copy_to_user_nocheck((to),(from),(n))
 #define __copy_from_user(to,from,n) __generic_copy_from_user_nocheck((to),(from),(n))
-#define __copy_to_user_inatomic __copy_to_user
-#define __copy_from_user_inatomic __copy_from_user
 
+static __always_inline unsigned long __must_check
+__copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_to_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
+
+static __always_inline unsigned long __must_check
+__copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long ret;
+	pagefault_disable();
+	ret = __copy_from_user(to, from, n);
+	pagefault_enable();
+	return ret;
+}
 
 /*
  * We need to return the number of bytes not cleared.  Our memset()
Index: linux-2.6/include/linux/uaccess.h
===================================================================
--- linux-2.6.orig/include/linux/uaccess.h
+++ linux-2.6/include/linux/uaccess.h
@@ -2,7 +2,6 @@
 #define __LINUX_UACCESS_H__
 
 #include <linux/preempt.h>
-#include <asm/uaccess.h>
 
 /*
  * These routines enable/disable the pagefault handler in that
@@ -38,6 +37,8 @@ static inline void pagefault_enable(void
 	preempt_check_resched();
 }
 
+#include <asm/uaccess.h>
+
 #ifndef ARCH_HAS_NOCACHE_UACCESS
 
 static inline unsigned long __copy_from_user_inatomic_nocache(void *to,
Index: linux-2.6/kernel/futex.c
===================================================================
--- linux-2.6.orig/kernel/futex.c
+++ linux-2.6/kernel/futex.c
@@ -282,9 +282,7 @@ static inline int get_futex_value_locked
 {
 	int ret;
 
-	pagefault_disable();
 	ret = __copy_from_user_inatomic(dest, from, sizeof(u32));
-	pagefault_enable();
 
 	return ret ? -EFAULT : 0;
 }

--

