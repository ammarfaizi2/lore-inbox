Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVBWRSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVBWRSL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 12:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVBWRRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 12:17:46 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:4329 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261503AbVBWROU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 12:14:20 -0500
Date: Wed, 23 Feb 2005 11:10:16 -0600
To: Linus Torvalds <torvalds@osdl.org>
Cc: Joe Korty <joe.korty@ccur.com>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050223171015.GD10256@austin.ibm.com>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org> <20050223144940.GA880@tsunami.ccur.com> <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502230751140.2378@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2005 at 07:54:06AM -0800, Linus Torvalds wrote:

> > Otherwise, a preempt attempt in get_user would not be seen
> > until some future preempt_enable was executed.
> 
> True. I guess we should have a "preempt_check_resched()" there too. That's 
> what "kunmap_atomic()" does too (which is what we rely on in the other 
> case we do this..)

Ok, this is getting complex enough to warrant get_user_inatomic(),
which means adding it to every arch's uaccess.h.

Below patch does so. Unfortunately I don't have a Viro setup with cross
compilers for nearly every arch, so I can't make sure it doesn't break
anything. But since I pasted the same code everywhere it shouldn't.


-----

Some futex functions do get_user calls while holding mmap_sem for
reading. If get_user() faults, and another thread happens to be in mmap
(or somewhere else holding waiting on down_write for the same semaphore),
then do_page_fault will deadlock. Most architectures seem to be exposed
to this.

To avoid it, make sure the page is available. If not, release the
semaphore, fault it in and retry.

I also found another exposure by inspection, moving some of the code
around avoids the possible deadlock there.

Signed-off-by: Olof Johansson <olof@austin.ibm.com>


Index: linux-2.5/kernel/futex.c
===================================================================
--- linux-2.5.orig/kernel/futex.c	2005-02-21 16:09:38.000000000 -0600
+++ linux-2.5/kernel/futex.c	2005-02-23 10:55:37.000000000 -0600
@@ -329,6 +329,7 @@
 	int ret, drop_count = 0;
 	unsigned int nqueued;
 
+ retry:
 	down_read(&current->mm->mmap_sem);
 
 	ret = get_futex_key(uaddr1, &key1);
@@ -355,9 +356,17 @@
 		   before *uaddr1.  */
 		smp_mb();
 
-		if (get_user(curval, (int __user *)uaddr1) != 0) {
-			ret = -EFAULT;
-			goto out;
+		ret = get_user_inatomic(curval, (int __user *)uaddr1);
+
+		if (unlikely(ret)) {
+			up_read(&current->mm->mmap_sem);
+			/* Re-do the access outside the lock */
+			ret = get_user(curval, (int __user *)uaddr1);
+
+			if (!ret)
+				goto retry;
+
+			return ret;
 		}
 		if (curval != *valp) {
 			ret = -EAGAIN;
@@ -480,6 +489,7 @@
 	int ret, curval;
 	struct futex_q q;
 
+ retry:
 	down_read(&current->mm->mmap_sem);
 
 	ret = get_futex_key(uaddr, &q.key);
@@ -508,9 +518,21 @@
 	 * We hold the mmap semaphore, so the mapping cannot have changed
 	 * since we looked it up in get_futex_key.
 	 */
-	if (get_user(curval, (int __user *)uaddr) != 0) {
-		ret = -EFAULT;
-		goto out_unqueue;
+
+	ret = get_user_inatomic(curval, (int __user *)uaddr);
+
+	if (unlikely(ret)) {
+		up_read(&current->mm->mmap_sem);
+
+		if (!unqueue_me(&q)) /* There's a chance we got woken already */
+			return 0;
+
+		/* Re-do the access outside the lock */
+		ret = get_user(curval, (int __user *)uaddr);
+
+		if (!ret)
+			goto retry;
+		return ret;
 	}
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
Index: linux-2.5/mm/mempolicy.c
===================================================================
--- linux-2.5.orig/mm/mempolicy.c	2005-02-04 00:27:40.000000000 -0600
+++ linux-2.5/mm/mempolicy.c	2005-02-23 10:16:46.000000000 -0600
@@ -524,9 +524,13 @@
 	} else
 		pval = pol->policy;
 
-	err = -EFAULT;
+	if (vma) {
+		up_read(&current->mm->mmap_sem);
+		vma = NULL;
+	}
+
 	if (policy && put_user(pval, policy))
-		goto out;
+		return -EFAULT;
 
 	err = 0;
 	if (nmask) {
Index: linux-2.5/include/asm-ppc64/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-ppc64/uaccess.h	2005-02-04 00:27:13.000000000 -0600
+++ linux-2.5/include/asm-ppc64/uaccess.h	2005-02-23 11:01:44.000000000 -0600
@@ -217,6 +217,17 @@
 		: "=r"(err), "=r"(x)			\
 		: "b"(addr), "i"(errret), "0"(err))
 
+
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 /* more complex routines */
 
 extern unsigned long __copy_tofrom_user(void __user *to, const void __user *from,
Index: linux-2.5/include/asm-alpha/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-alpha/uaccess.h	2005-02-04 00:26:53.000000000 -0600
+++ linux-2.5/include/asm-alpha/uaccess.h	2005-02-23 10:59:33.000000000 -0600
@@ -341,6 +341,16 @@
 }
 #endif
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 
 /*
  * Complex access routines
Index: linux-2.5/include/asm-arm26/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-arm26/uaccess.h	2005-02-04 00:26:58.000000000 -0600
+++ linux-2.5/include/asm-arm26/uaccess.h	2005-02-23 10:59:49.000000000 -0600
@@ -224,6 +224,17 @@
         }                                                               \
 } while (0)
 
+
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 static __inline__ unsigned long copy_from_user(void *to, const void *from, unsigned long n)
 {
 	if (access_ok(VERIFY_READ, from, n))
Index: linux-2.5/include/asm-arm/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-arm/uaccess.h	2005-02-04 00:26:54.000000000 -0600
+++ linux-2.5/include/asm-arm/uaccess.h	2005-02-23 11:00:00.000000000 -0600
@@ -362,6 +362,16 @@
 	: "r" (x), "i" (-EFAULT)				\
 	: "cc")
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 extern unsigned long __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long __arch_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __arch_clear_user(void __user *addr, unsigned long n);
Index: linux-2.5/include/asm-cris/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-cris/uaccess.h	2005-02-04 00:26:58.000000000 -0600
+++ linux-2.5/include/asm-cris/uaccess.h	2005-02-23 11:00:11.000000000 -0600
@@ -210,6 +210,16 @@
 	__gu_err;							\
 })
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 extern long __get_user_bad(void);
 
 /* More complex functions.  Most are inline, but some call functions that
Index: linux-2.5/include/asm-frv/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-frv/uaccess.h	2005-02-04 00:26:59.000000000 -0600
+++ linux-2.5/include/asm-frv/uaccess.h	2005-02-23 11:00:21.000000000 -0600
@@ -249,6 +249,17 @@
 
 #endif
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
+
 /*****************************************************************************/
 /*
  *
Index: linux-2.5/include/asm-h8300/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-h8300/uaccess.h	2005-02-04 00:26:59.000000000 -0600
+++ linux-2.5/include/asm-h8300/uaccess.h	2005-02-23 11:00:31.000000000 -0600
@@ -130,6 +130,17 @@
 
 #define copy_from_user_ret(to,from,n,retval) ({ if (copy_from_user(to,from,n)) return retval; })
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
+
 /*
  * Copy a null terminated string from userspace.
  */
Index: linux-2.5/include/asm-i386/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-i386/uaccess.h	2005-02-04 00:27:00.000000000 -0600
+++ linux-2.5/include/asm-i386/uaccess.h	2005-02-23 11:00:41.000000000 -0600
@@ -377,6 +377,17 @@
 		: "m"(__m(addr)), "i"(errret), "0"(err))
 
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
+
 unsigned long __must_check __copy_to_user_ll(void __user *to,
 				const void *from, unsigned long n);
 unsigned long __must_check __copy_from_user_ll(void *to,
Index: linux-2.5/include/asm-ia64/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-ia64/uaccess.h	2005-02-04 00:27:02.000000000 -0600
+++ linux-2.5/include/asm-ia64/uaccess.h	2005-02-23 11:00:48.000000000 -0600
@@ -299,6 +299,16 @@
 	__cu_len;						\
 })
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 
 /*
  * Returns: -EFAULT if exception before terminator, N if the entire buffer filled, else
Index: linux-2.5/include/asm-m32r/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-m32r/uaccess.h	2005-02-04 00:27:03.000000000 -0600
+++ linux-2.5/include/asm-m32r/uaccess.h	2005-02-23 11:00:56.000000000 -0600
@@ -706,6 +706,17 @@
 long __must_check __strncpy_from_user(char *dst,
 				const char __user *src, long count);
 
+
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 /**
  * __clear_user: - Zero a block of memory in user space, with less checking.
  * @to:   Destination address, in user space.
Index: linux-2.5/include/asm-m68knommu/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-m68knommu/uaccess.h	2005-02-04 00:27:04.000000000 -0600
+++ linux-2.5/include/asm-m68knommu/uaccess.h	2005-02-23 11:01:05.000000000 -0600
@@ -141,6 +141,17 @@
 
 #define copy_from_user_ret(to,from,n,retval) ({ if (copy_from_user(to,from,n)) return retval; })
 
+
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 /*
  * Copy a null terminated string from userspace.
  */
Index: linux-2.5/include/asm-m68k/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-m68k/uaccess.h	2005-02-04 00:27:04.000000000 -0600
+++ linux-2.5/include/asm-m68k/uaccess.h	2005-02-23 11:01:14.000000000 -0600
@@ -766,6 +766,17 @@
 #define __copy_from_user(to, from, n) copy_from_user(to, from, n)
 #define __copy_to_user(to, from, n) copy_to_user(to, from, n)
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
+
 /*
  * Copy a null terminated string from userspace.
  */
Index: linux-2.5/include/asm-mips/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-mips/uaccess.h	2005-02-04 00:27:08.000000000 -0600
+++ linux-2.5/include/asm-mips/uaccess.h	2005-02-23 11:01:26.000000000 -0600
@@ -604,6 +604,17 @@
 	__cu_len;							\
 })
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
+
 /*
  * __clear_user: - Zero a block of memory in user space, with less checking.
  * @to:   Destination address, in user space.
Index: linux-2.5/include/asm-parisc/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-parisc/uaccess.h	2005-02-04 00:27:11.000000000 -0600
+++ linux-2.5/include/asm-parisc/uaccess.h	2005-02-23 11:01:36.000000000 -0600
@@ -245,6 +245,16 @@
 
 #endif /* !__LP64__ */
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 
 /*
  * Complex access routines -- external declarations
Index: linux-2.5/include/asm-ppc/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-ppc/uaccess.h	2005-02-04 00:27:12.000000000 -0600
+++ linux-2.5/include/asm-ppc/uaccess.h	2005-02-23 11:01:53.000000000 -0600
@@ -296,6 +296,16 @@
 		: "=r"(err), "=&r"(x)			\
 		: "b"(addr), "i"(-EFAULT), "0"(err))
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 /* more complex routines */
 
 extern int __copy_tofrom_user(void __user *to, const void __user *from,
Index: linux-2.5/include/asm-s390/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-s390/uaccess.h	2005-02-04 00:27:14.000000000 -0600
+++ linux-2.5/include/asm-s390/uaccess.h	2005-02-23 11:02:02.000000000 -0600
@@ -278,6 +278,18 @@
 #define __copy_to_user_inatomic __copy_to_user
 #define __copy_from_user_inatomic __copy_from_user
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
+
+
 /**
  * copy_to_user: - Copy a block of data into user space.
  * @to:   Destination address, in user space.
Index: linux-2.5/include/asm-sh64/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-sh64/uaccess.h	2005-02-04 00:27:15.000000000 -0600
+++ linux-2.5/include/asm-sh64/uaccess.h	2005-02-23 11:02:23.000000000 -0600
@@ -264,6 +264,17 @@
 #define __copy_to_user_inatomic __copy_to_user
 #define __copy_from_user_inatomic __copy_from_user
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
+
 /* XXX: Not sure it works well..
    should be such that: 4byte clear and the rest. */
 extern __kernel_size_t __clear_user(void *addr, __kernel_size_t size);
Index: linux-2.5/include/asm-sh/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-sh/uaccess.h	2005-02-04 00:27:15.000000000 -0600
+++ linux-2.5/include/asm-sh/uaccess.h	2005-02-23 11:02:29.000000000 -0600
@@ -464,6 +464,16 @@
 	__copy_user((void *)(to),		\
 		    (void *)(from), n)
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 /*
  * Clear the area and return remaining number of bytes
  * (on failure.  Usually it's 0.)
Index: linux-2.5/include/asm-sparc64/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-sparc64/uaccess.h	2005-02-04 00:27:17.000000000 -0600
+++ linux-2.5/include/asm-sparc64/uaccess.h	2005-02-23 11:02:37.000000000 -0600
@@ -312,6 +312,16 @@
 
 #define clear_user __clear_user
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 extern long __must_check __strncpy_from_user(char *dest, const char __user *src, long count);
 
 #define strncpy_from_user __strncpy_from_user
Index: linux-2.5/include/asm-sparc/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-sparc/uaccess.h	2005-02-04 00:27:16.000000000 -0600
+++ linux-2.5/include/asm-sparc/uaccess.h	2005-02-23 11:02:46.000000000 -0600
@@ -325,6 +325,16 @@
 #define __copy_to_user_inatomic __copy_to_user
 #define __copy_from_user_inatomic __copy_from_user
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 static inline unsigned long __clear_user(void __user *addr, unsigned long size)
 {
 	unsigned long ret;
Index: linux-2.5/include/asm-um/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-um/uaccess.h	2005-02-04 00:27:19.000000000 -0600
+++ linux-2.5/include/asm-um/uaccess.h	2005-02-23 11:02:54.000000000 -0600
@@ -80,6 +80,17 @@
 	 __put_user(x, private_ptr) : -EFAULT); \
 })
 
+
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 #define strlen_user(str) strnlen_user(str, ~0UL >> 1)
 
 struct exception_table_entry
Index: linux-2.5/include/asm-v850/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-v850/uaccess.h	2005-02-04 00:27:21.000000000 -0600
+++ linux-2.5/include/asm-v850/uaccess.h	2005-02-23 11:03:02.000000000 -0600
@@ -124,6 +124,16 @@
 #define copy_from_user_ret(to,from,n,retval) \
   ({ if (copy_from_user (to,from,n)) return retval; })
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 /*
  * Copy a null terminated string from userspace.
  */
Index: linux-2.5/include/asm-x86_64/uaccess.h
===================================================================
--- linux-2.5.orig/include/asm-x86_64/uaccess.h	2005-02-04 00:27:21.000000000 -0600
+++ linux-2.5/include/asm-x86_64/uaccess.h	2005-02-23 11:03:09.000000000 -0600
@@ -235,6 +235,16 @@
 		: "=r"(err), ltype (x)				\
 		: "m"(__m(addr)), "i"(errno), "0"(err))
 
+#define get_user_inatomic(x,ptr)					\
+({									\
+	int __ret;							\
+	inc_preempt_count();						\
+ 	__ret = __copy_from_user_inatomic(&(x),(ptr),sizeof(*(ptr)));	\
+ 	dec_preempt_count();						\
+ 	preempt_check_resched();					\
+	__ret;								\
+})
+
 /*
  * Copy To/From Userspace
  */
