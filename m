Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUIPCpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUIPCpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 22:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUIPCpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 22:45:36 -0400
Received: from mail.renesas.com ([202.234.163.13]:2531 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S266835AbUIPCpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 22:45:09 -0400
Date: Thu, 16 Sep 2004 11:44:39 +0900 (JST)
Message-Id: <20040916.114439.115926265.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm5] [m32r] Upgrade include/asm-m32r/atomic.h
From: Hirokazu Takata <takata.hirokazu@renesas.com>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I made a patch to upgrade include/asm-m32r/atomic.h.
Please apply.

	* include/asm-m32r/atomic.h
	- Change atomic_add(), atomic_sub(), atomic_inc() and atomic_dec()
	  from function to macro.
	- Change not to use fixed woking register in atomic_clear_mask() and 
	  atomic_set_mask().
	- Update comments: "return" to "return it", and so on.

From: Hugh Dickins <hugh@veritas.com>
Date: Fri, 10 Sep 2004 14:19:34 +0100 (BST)
> There does seem to be a lot of code duplication in there.  I can imagine
> it may be optimal to have a separate atomic_inc and atomic_dec, the
> most common operations.  But do you really need atomic_add, atomic_sub,
> atomic_add_return, atomic_sub_return, atomic_inc_return, atomic_dec_return
> all with their own code blocks?  Maybe, but looks excessive to an outsider.
> 
> Perhaps "and return it" rather than just "and return"
> in those function comments?
Thank you.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 atomic.h |  180 ++++++++++++++++++---------------------------------------------
 1 files changed, 53 insertions(+), 127 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm5.orig/include/asm-m32r/atomic.h linux-2.6.9-rc1-mm5/include/asm-m32r/atomic.h
--- linux-2.6.9-rc1-mm5.orig/include/asm-m32r/atomic.h	2004-09-13 21:44:38.000000000 +0900
+++ linux-2.6.9-rc1-mm5/include/asm-m32r/atomic.h	2004-09-15 18:15:27.000000000 +0900
@@ -54,63 +54,7 @@ typedef struct { volatile int counter; }
 #define atomic_set(v,i)	(((v)->counter) = (i))
 
 /**
- * atomic_add - add integer to atomic variable
- * @i: integer value to add
- * @v: pointer of type atomic_t
- *
- * Atomically adds @i to @v.
- */
-static inline void atomic_add(int i, atomic_t *v)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__asm__ __volatile__ (
-		"# atomic_add			\n\t"
-		DCACHE_CLEAR("r4", "r5", "%0")
-		LOAD"	r4, @%0;		\n\t"
-		"add	r4, %1;			\n\t"
-		STORE"	r4, @%0;		\n\t"
-		: /* no outputs */
-		: "r" (&v->counter), "r" (i)
-		: "memory", "r4"
-#ifdef CONFIG_CHIP_M32700_TS1
-		, "r5"
-#endif	/* CONFIG_CHIP_M32700_TS1 */
-	);
-	local_irq_restore(flags);
-}
-
-/**
- * atomic_sub - subtract the atomic variable
- * @i: integer value to subtract
- * @v: pointer of type atomic_t
- *
- * Atomically subtracts @i from @v.
- */
-static inline void atomic_sub(int i, atomic_t *v)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__asm__ __volatile__ (
-		"# atomic_sub			\n\t"
-		DCACHE_CLEAR("r4", "r5", "%0")
-		LOAD"	r4, @%0;		\n\t"
-		"sub	r4, %1;			\n\t"
-		STORE"	r4, @%0;		\n\t"
-		: /* no outputs */
-		: "r" (&v->counter), "r" (i)
-		: "memory", "r4"
-#ifdef CONFIG_CHIP_M32700_TS1
-		, "r5"
-#endif	/* CONFIG_CHIP_M32700_TS1 */
-	);
-	local_irq_restore(flags);
-}
-
-/**
- * atomic_add_return - add integer to atomic variable and return
+ * atomic_add_return - add integer to atomic variable and return it
  * @i: integer value to add
  * @v: pointer of type atomic_t
  *
@@ -123,7 +67,7 @@ static inline int atomic_add_return(int 
 
 	local_irq_save(flags);
 	__asm__ __volatile__ (
-		"# atomic_add			\n\t"
+		"# atomic_add_return		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
 		LOAD"	%0, @%1;		\n\t"
 		"add	%0, %2;			\n\t"
@@ -141,7 +85,7 @@ static inline int atomic_add_return(int 
 }
 
 /**
- * atomic_sub_return - subtract the atomic variable and return
+ * atomic_sub_return - subtract integer from atomic variable and return it
  * @i: integer value to subtract
  * @v: pointer of type atomic_t
  *
@@ -154,7 +98,7 @@ static inline int atomic_sub_return(int 
 
 	local_irq_save(flags);
 	__asm__ __volatile__ (
-		"# atomic_sub			\n\t"
+		"# atomic_sub_return		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
 		LOAD"	%0, @%1;		\n\t"
 		"sub	%0, %2;			\n\t"
@@ -172,72 +116,36 @@ static inline int atomic_sub_return(int 
 }
 
 /**
- * atomic_sub_and_test - subtract value from variable and test result
- * @i: integer value to subtract
+ * atomic_add - add integer to atomic variable
+ * @i: integer value to add
  * @v: pointer of type atomic_t
  *
- * Atomically subtracts @i from @v and returns
- * true if the result is zero, or false for all
- * other cases.
+ * Atomically adds @i to @v.
  */
-#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
+#define atomic_add(i,v) ((void) atomic_add_return((i), (v)))
 
 /**
- * atomic_inc - increment atomic variable
+ * atomic_sub - subtract the atomic variable
+ * @i: integer value to subtract
  * @v: pointer of type atomic_t
  *
- * Atomically increments @v by 1.
+ * Atomically subtracts @i from @v.
  */
-static inline void atomic_inc(atomic_t *v)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__asm__ __volatile__ (
-		"# atomic_inc			\n\t"
-		DCACHE_CLEAR("r4", "r5", "%0")
-		LOAD"	r4, @%0; 		\n\t"
-		"addi	r4, #1;			\n\t"
-		STORE"	r4, @%0;		\n\t"
-		: /* no outputs */
-		: "r" (&v->counter)
-		: "memory", "r4"
-#ifdef CONFIG_CHIP_M32700_TS1
-		, "r5"
-#endif	/* CONFIG_CHIP_M32700_TS1 */
-	);
-	local_irq_restore(flags);
-}
+#define atomic_sub(i,v) ((void) atomic_sub_return((i), (v)))
 
 /**
- * atomic_dec - decrement atomic variable
+ * atomic_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
  * @v: pointer of type atomic_t
  *
- * Atomically decrements @v by 1.
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
  */
-static inline void atomic_dec(atomic_t *v)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__asm__ __volatile__ (
-		"# atomic_dec			\n\t"
-		DCACHE_CLEAR("r4", "r5", "%0")
-		LOAD"	r4, @%0;		\n\t"
-		"addi	r4, #-1;		\n\t"
-		STORE"	r4, @%0;		\n\t"
-		: /* no outputs */
-		: "r" (&v->counter)
-		: "memory", "r4"
-#ifdef CONFIG_CHIP_M32700_TS1
-		, "r5"
-#endif	/* CONFIG_CHIP_M32700_TS1 */
-	);
-	local_irq_restore(flags);
-}
+#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
 
 /**
- * atomic_inc_return - increment atomic variable and return
+ * atomic_inc_return - increment atomic variable and return it
  * @v: pointer of type atomic_t
  *
  * Atomically increments @v by 1 and returns the result.
@@ -249,7 +157,7 @@ static inline int atomic_inc_return(atom
 
 	local_irq_save(flags);
 	__asm__ __volatile__ (
-		"# atomic_dec_and_test		\n\t"
+		"# atomic_inc_return		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
 		LOAD"	%0, @%1;		\n\t"
 		"addi	%0, #1;			\n\t"
@@ -267,7 +175,7 @@ static inline int atomic_inc_return(atom
 }
 
 /**
- * atomic_dec_return - decrement atomic variable and return
+ * atomic_dec_return - decrement atomic variable and return it
  * @v: pointer of type atomic_t
  *
  * Atomically decrements @v by 1 and returns the result.
@@ -279,7 +187,7 @@ static inline int atomic_dec_return(atom
 
 	local_irq_save(flags);
 	__asm__ __volatile__ (
-		"# atomic_dec_and_test		\n\t"
+		"# atomic_dec_return		\n\t"
 		DCACHE_CLEAR("%0", "r4", "%1")
 		LOAD"	%0, @%1;		\n\t"
 		"addi	%0, #-1;		\n\t"
@@ -297,6 +205,22 @@ static inline int atomic_dec_return(atom
 }
 
 /**
+ * atomic_inc - increment atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1.
+ */
+#define atomic_inc(v) ((void)atomic_inc_return(v))
+
+/**
+ * atomic_dec - decrement atomic variable
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1.
+ */
+#define atomic_dec(v) ((void)atomic_dec_return(v))
+
+/**
  * atomic_inc_and_test - increment and test
  * @v: pointer of type atomic_t
  *
@@ -330,17 +254,18 @@ static inline int atomic_dec_return(atom
 static inline void atomic_clear_mask(unsigned long  mask, atomic_t *addr)
 {
 	unsigned long flags;
+	unsigned long tmp;
 
 	local_irq_save(flags);
 	__asm__ __volatile__ (
-		"# atomic_set_mask		\n\t"
-		DCACHE_CLEAR("r4", "r5", "%0")
-		LOAD"	r4, @%0;		\n\t"
-		"and	r4, %1;			\n\t"
-		STORE"	r4, @%0;		\n\t"
-		: /* no outputs */
+		"# atomic_clear_mask		\n\t"
+		DCACHE_CLEAR("%0", "r5", "%1")
+		LOAD"	%0, @%1;		\n\t"
+		"and	%0, %2;			\n\t"
+		STORE"	%0, @%1;		\n\t"
+		: "=&r" (tmp)
 		: "r" (addr), "r" (~mask)
-		: "memory", "r4"
+		: "memory"
 #ifdef CONFIG_CHIP_M32700_TS1
 		, "r5"
 #endif	/* CONFIG_CHIP_M32700_TS1 */
@@ -351,17 +276,18 @@ static inline void atomic_clear_mask(uns
 static inline void atomic_set_mask(unsigned long  mask, atomic_t *addr)
 {
 	unsigned long flags;
+	unsigned long tmp;
 
 	local_irq_save(flags);
 	__asm__ __volatile__ (
 		"# atomic_set_mask		\n\t"
-		DCACHE_CLEAR("r4", "r5", "%0")
-		LOAD"	r4, @%0;		\n\t"
-		"or	r4, %1;			\n\t"
-		STORE"	r4, @%0;		\n\t"
-		: /* no outputs */
+		DCACHE_CLEAR("%0", "r5", "%1")
+		LOAD"	%0, @%1;		\n\t"
+		"or	%0, %2;			\n\t"
+		STORE"	%0, @%1;		\n\t"
+		: "=&r" (tmp)
 		: "r" (addr), "r" (mask)
-		: "memory", "r4"
+		: "memory"
 #ifdef CONFIG_CHIP_M32700_TS1
 		, "r5"
 #endif	/* CONFIG_CHIP_M32700_TS1 */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
