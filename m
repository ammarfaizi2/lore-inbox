Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbVLaGme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbVLaGme (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 01:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbVLaGme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 01:42:34 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:50050 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750833AbVLaGme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 01:42:34 -0500
Date: Sat, 31 Dec 2005 01:37:17 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 03/13] mutex subsystem, add
  include/asm-i386/mutex.h
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Ingo Molnar <mingo@redhat.com>
Message-ID: <200512310140_MC3-1-B501-E855@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20051229210336.GD665@elte.hu>

On Thu, 29 Dec 2005 at 22:03:36 +0100, Ingo Molnar wrote:

> +#define __mutex_fastpath_lock(count, fn_name)                                \
> +do {                                                                 \
> +     /* type-check the function too: */                              \
> +     void fastcall (*__tmp)(atomic_t *) = fn_name;                   \
> +     unsigned int dummy;                                             \
> +                                                                     \
> +     (void)__tmp;                                                    \
> +     typecheck(atomic_t *, count);                                   \

 The function type checking is ugly.  Wouldn't this be better?

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 include/asm-arm/mutex.h    |   12 +++---------
 include/asm-i386/mutex.h   |    8 ++------
 include/asm-x86_64/mutex.h |    8 ++------
 include/linux/kernel.h     |    9 +++++++++
 include/linux/mutex.h      |    4 ++++
 5 files changed, 20 insertions(+), 21 deletions(-)

--- 2.6.15-rc7b.orig/include/asm-arm/mutex.h
+++ 2.6.15-rc7b/include/asm-arm/mutex.h
@@ -25,11 +25,9 @@
  */
 #define __mutex_fastpath_lock(count, fail_fn)				\
 do {									\
-	/* type-check the function too: */				\
-	void fastcall (*__tmp)(atomic_t *) = fail_fn;			\
 	int __ex_flag, __res;						\
 									\
-	(void)__tmp;							\
+	typecheck_fn(mutex_void_fail_fn_t, fail_fn);			\
 	typecheck(atomic_t *, count);					\
 									\
 	__asm__ (							\
@@ -47,11 +45,9 @@ do {									\
 
 #define __mutex_fastpath_lock_retval(count, fail_fn)			\
 ({									\
-	/* type-check the function too: */				\
-	int fastcall (*__tmp)(atomic_t *) = fail_fn;			\
 	int __ex_flag, __res;						\
 									\
-	(void)__tmp;							\
+	typecheck_fn(mutex_int_fail_fn_t, fail_fn);			\
 	typecheck(atomic_t *, count);					\
 									\
 	__asm__ (							\
@@ -76,11 +72,9 @@ do {									\
  */
 #define __mutex_fastpath_unlock(count, fail_fn)				\
 do {									\
-	/* type-check the function too: */				\
-	void fastcall (*__tmp)(atomic_t *) = fail_fn;			\
 	int __ex_flag, __res, __orig;					\
 									\
-	(void)__tmp;							\
+	typecheck_fn(mutex_void_fail_fn_t, fail_fn);			\
 	typecheck(atomic_t *, count);					\
 									\
 	__asm__ (							\
--- 2.6.15-rc7b.orig/include/asm-i386/mutex.h
+++ 2.6.15-rc7b/include/asm-i386/mutex.h
@@ -21,11 +21,9 @@
  */
 #define __mutex_fastpath_lock(count, fn_name)				\
 do {									\
-	/* type-check the function too: */				\
-	void fastcall (*__tmp)(atomic_t *) = fn_name;			\
 	unsigned int dummy;						\
 									\
-	(void)__tmp;							\
+	typecheck_fn(mutex_void_fail_fn_t, fn_name);			\
 	typecheck(atomic_t *, count);					\
 									\
 	__asm__ __volatile__(						\
@@ -79,11 +77,9 @@ __mutex_fastpath_lock_retval(atomic_t *c
  */
 #define __mutex_fastpath_unlock(count, fn_name)				\
 do {									\
-	/* type-check the function too: */				\
-	void fastcall (*__tmp)(atomic_t *) = fn_name;			\
 	unsigned int dummy;						\
 									\
-	(void)__tmp;							\
+	typecheck_fn(mutex_void_fail_fn_t, fn_name);			\
 	typecheck(atomic_t *, count);					\
 									\
 	__asm__ __volatile__(						\
--- 2.6.15-rc7b.orig/include/asm-x86_64/mutex.h
+++ 2.6.15-rc7b/include/asm-x86_64/mutex.h
@@ -18,11 +18,9 @@
  */
 #define __mutex_fastpath_lock(v, fn_name)				\
 do {									\
-	/* type-check the function too: */				\
-	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
 	unsigned long dummy;						\
 									\
-	(void)__tmp;							\
+	typecheck_fn(mutex_void_fail_fn_t, fn_name);			\
 	typecheck(atomic_t *, v);					\
 									\
 	__asm__ __volatile__(						\
@@ -50,11 +48,9 @@ do {									\
  */
 #define __mutex_fastpath_unlock(v, fn_name)				\
 do {									\
-	/* type-check the function too: */				\
-	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
 	unsigned long dummy;						\
 									\
-	(void)__tmp;							\
+	typecheck_fn(mutex_void_fail_fn_t, fn_name);			\
 	typecheck(atomic_t *, v);					\
 									\
 	__asm__ __volatile__(						\
--- 2.6.15-rc7b.orig/include/linux/mutex.h
+++ 2.6.15-rc7b/include/linux/mutex.h
@@ -69,6 +69,10 @@ struct mutex_waiter {
 #endif
 };
 
+/* mutex functions called when extra work needs to be done have these types  */
+typedef void fastcall mutex_void_fail_fn_t(atomic_t *);
+typedef int fastcall mutex_int_fail_fn_t(atomic_t *);
+
 #ifdef CONFIG_DEBUG_MUTEXES
 # include <linux/mutex-debug.h>
 #else
--- 2.6.15-rc7b.orig/include/linux/kernel.h
+++ 2.6.15-rc7b/include/linux/kernel.h
@@ -286,6 +286,15 @@ extern void dump_stack(void);
 	1; \
 })
 
+/*
+ * Check at compile time that 'function' is a certain type, or is a pointer
+ * to that type (needs to use typedef for the function type.)
+ */
+#define typecheck_fn(type,function) \
+({	type *__dummy = function; \
+	(void)__dummy; \
+})
+
 #endif /* __KERNEL__ */
 
 #define SI_LOAD_SHIFT	16
-- 
Chuck
