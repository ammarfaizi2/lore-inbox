Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVIXCla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVIXCla (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 22:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVIXCl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 22:41:29 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:52347 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751362AbVIXCl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 22:41:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type;
  b=0ewn7FyVMuFrJsOjQDL9igNfJngbNgOZGMJ2+PeGsWNizhzRzrVQoT0yZ18wbYYZsA7Gi8XTzIHuZ4dcK8oAXsaFl0NvkrpJ4K5Yb0CZ4rsYVKFhSCBxF+vN/avBtNAwQZgFLk7uCPjAK0Wz3sx2Rnw8H9Z1nDNvBFofBfycJlc=  ;
Message-ID: <4334BCF3.1010908@yahoo.com.au>
Date: Sat, 24 Sep 2005 12:41:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] atomic_cmpxchg and friends
Content-Type: multipart/mixed;
 boundary="------------060205010002010409000106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060205010002010409000106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/4

This patchset introduces a couple of new arch atomic.h
operations, and simplifies some core code as a result.
Diffed against 2.6.14-rc2-git3.

Acked-in-theory by several arch maintainers (at least
objected to by none), by Dipankar for files-rcu, and by
David Miller for lib/dec_and_lock.c

Will need a bit of a run in -mm because it is sure to
have problems on some architectures (particularly ARM
will need to be careful because low level assembly is
introduced).

What do ya think?

-- 
SUSE Labs, Novell Inc.


--------------060205010002010409000106
Content-Type: text/plain;
 name="atomic_cmpxchg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic_cmpxchg.patch"

Introduce an atomic_cmpxchg operation.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-i386/atomic.h
+++ linux-2.6/include/asm-i386/atomic.h
@@ -215,6 +215,8 @@ static __inline__ int atomic_sub_return(
 	return atomic_add_return(-i,v);
 }
 
+#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
Index: linux-2.6/include/asm-ppc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/atomic.h
+++ linux-2.6/include/asm-ppc64/atomic.h
@@ -162,6 +162,8 @@ static __inline__ int atomic_dec_return(
 	return t;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
 
Index: linux-2.6/include/asm-ia64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/atomic.h
+++ linux-2.6/include/asm-ia64/atomic.h
@@ -88,6 +88,8 @@ ia64_atomic64_sub (__s64 i, atomic64_t *
 	return new;
 }
 
+#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+
 #define atomic_add_return(i,v)						\
 ({									\
 	int __ia64_aar_i = (i);						\
Index: linux-2.6/include/asm-x86_64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/atomic.h
+++ linux-2.6/include/asm-x86_64/atomic.h
@@ -360,6 +360,8 @@ static __inline__ int atomic_sub_return(
 	return atomic_add_return(-i,v);
 }
 
+#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
Index: linux-2.6/Documentation/atomic_ops.txt
===================================================================
--- linux-2.6.orig/Documentation/atomic_ops.txt
+++ linux-2.6/Documentation/atomic_ops.txt
@@ -115,6 +115,21 @@ boolean is return which indicates whethe
 is negative.  It requires explicit memory barrier semantics around the
 operation.
 
+Finally:
+
+	int atomic_cmpxchg(atomic_t *v, int old, int new);
+
+This performs an atomic compare exchange operation on the atomic value v,
+with the given old and new values. Like all atomic_xxx operations,
+atomic_cmpxchg will only satisfy its atomicity semantics as long as all
+other accesses of *v are performed through atomic_xxx operations.
+
+atomic_cmpxchg requires explicit memory barriers around the operation.
+
+The semantics for atomic_cmpxchg are the same as those defined for 'cas'
+below.
+
+
 If a caller requires memory barrier semantics around an atomic_t
 operation which does not return a value, a set of interfaces are
 defined which accomplish this:
Index: linux-2.6/arch/sparc/lib/atomic32.c
===================================================================
--- linux-2.6.orig/arch/sparc/lib/atomic32.c
+++ linux-2.6/arch/sparc/lib/atomic32.c
@@ -38,6 +38,20 @@ int __atomic_add_return(int i, atomic_t 
 	return ret;
 }
 
+int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(ATOMIC_HASH(v), flags);
+
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+
+	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
+	return ret;
+}
+
 void atomic_set(atomic_t *v, int i)
 {
 	unsigned long flags;
Index: linux-2.6/include/asm-sparc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/atomic.h
+++ linux-2.6/include/asm-sparc/atomic.h
@@ -19,6 +19,7 @@ typedef struct { volatile int counter; }
 #define ATOMIC_INIT(i)  { (i) }
 
 extern int __atomic_add_return(int, atomic_t *);
+extern int atomic_cmpxchg(atomic_t *, int, int);
 extern void atomic_set(atomic_t *, int);
 
 #define atomic_read(v)          ((v)->counter)
Index: linux-2.6/include/asm-alpha/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/atomic.h
+++ linux-2.6/include/asm-alpha/atomic.h
@@ -171,6 +171,8 @@ static __inline__ long atomic64_sub_retu
 	return result;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic64_dec_return(v) atomic64_sub_return(1,(v))
 
Index: linux-2.6/include/asm-m68k/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/atomic.h
+++ linux-2.6/include/asm-m68k/atomic.h
@@ -139,6 +139,8 @@ static inline void atomic_set_mask(unsig
 	__asm__ __volatile__("orl %1,%0" : "+m" (*v) : "id" (mask));
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6/include/asm-m68knommu/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/atomic.h
+++ linux-2.6/include/asm-m68knommu/atomic.h
@@ -128,6 +128,8 @@ extern __inline__ int atomic_sub_return(
 	return temp;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
Index: linux-2.6/include/asm-mips/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-mips/atomic.h
+++ linux-2.6/include/asm-mips/atomic.h
@@ -267,6 +267,8 @@ static __inline__ int atomic_sub_if_posi
 	return result;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
Index: linux-2.6/include/asm-parisc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/atomic.h
+++ linux-2.6/include/asm-parisc/atomic.h
@@ -164,6 +164,7 @@ static __inline__ int atomic_read(const 
 }
 
 /* exported interface */
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
 #define atomic_add(i,v)	((void)(__atomic_add_return( ((int)i),(v))))
 #define atomic_sub(i,v)	((void)(__atomic_add_return(-((int)i),(v))))
Index: linux-2.6/include/asm-ppc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/atomic.h
+++ linux-2.6/include/asm-ppc/atomic.h
@@ -177,6 +177,8 @@ static __inline__ int atomic_dec_return(
 	return t;
 }
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
 
Index: linux-2.6/include/asm-s390/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-s390/atomic.h
+++ linux-2.6/include/asm-s390/atomic.h
@@ -198,6 +198,8 @@ atomic_compare_and_swap(int expected_old
         return retval;
 }
 
+#define atomic_cmpxchg(v, o, n) (atomic_compare_and_swap((o), (n), &((v)->counter)))
+
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
Index: linux-2.6/include/asm-sparc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/atomic.h
+++ linux-2.6/include/asm-sparc64/atomic.h
@@ -70,6 +70,8 @@ extern int atomic64_sub_ret(int, atomic6
 #define atomic_add_negative(i, v) (atomic_add_ret(i, v) < 0)
 #define atomic64_add_negative(i, v) (atomic64_add_ret(i, v) < 0)
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+
 /* Atomic operations are already serializing */
 #ifdef CONFIG_SMP
 #define smp_mb__before_atomic_dec()	membar_storeload_loadload();
Index: linux-2.6/include/asm-arm26/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-arm26/atomic.h
+++ linux-2.6/include/asm-arm26/atomic.h
@@ -62,6 +62,20 @@ static inline int atomic_sub_return(int 
         return val;
 }
 
+static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+	local_irq_restore(flags);
+
+	return ret;
+}
+
 static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 {
         unsigned long flags;
Index: linux-2.6/include/asm-frv/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-frv/atomic.h
+++ linux-2.6/include/asm-frv/atomic.h
@@ -414,4 +414,6 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 
 #endif
 
+#define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+
 #endif /* _ASM_ATOMIC_H */
Index: linux-2.6/include/asm-h8300/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-h8300/atomic.h
+++ linux-2.6/include/asm-h8300/atomic.h
@@ -82,6 +82,18 @@ static __inline__ int atomic_dec_and_tes
 	return ret == 0;
 }
 
+static __inline__ int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+	local_irq_save(flags);
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+	local_irq_restore(flags);
+	return ret;
+}
+
 static __inline__ void atomic_clear_mask(unsigned long mask, unsigned long *v)
 {
 	__asm__ __volatile__("stc ccr,r1l\n\t"
Index: linux-2.6/include/asm-sh64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sh64/atomic.h
+++ linux-2.6/include/asm-sh64/atomic.h
@@ -99,6 +99,20 @@ static __inline__ int atomic_sub_return(
 #define atomic_inc(v) atomic_add(1,(v))
 #define atomic_dec(v) atomic_sub(1,(v))
 
+static __inline__ int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+	local_irq_restore(flags);
+
+	return ret;
+}
+
 static __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
 	unsigned long flags;
Index: linux-2.6/include/asm-v850/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-v850/atomic.h
+++ linux-2.6/include/asm-v850/atomic.h
@@ -90,6 +90,20 @@ static __inline__ void atomic_clear_mask
 #define atomic_dec_and_test(v)		(atomic_sub_return (1, (v)) == 0)
 #define atomic_add_negative(i,v)	(atomic_add_return ((i), (v)) < 0)
 
+static __inline__ int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+	local_irq_restore(flags);
+
+	return ret;
+}
+
 /* Atomic operations are already serializing on ARM */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6/include/asm-xtensa/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-xtensa/atomic.h
+++ linux-2.6/include/asm-xtensa/atomic.h
@@ -223,6 +223,7 @@ static inline int atomic_sub_return(int 
  */
 #define atomic_add_negative(i,v) (atomic_add_return((i),(v)) < 0)
 
+#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
 static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
Index: linux-2.6/include/asm-sh/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sh/atomic.h
+++ linux-2.6/include/asm-sh/atomic.h
@@ -87,6 +87,20 @@ static __inline__ int atomic_sub_return(
 #define atomic_inc(v) atomic_add(1,(v))
 #define atomic_dec(v) atomic_sub(1,(v))
 
+static __inline__ int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+	local_irq_restore(flags);
+
+	return ret;
+}
+
 static __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
 	unsigned long flags;
Index: linux-2.6/include/asm-arm/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-arm/atomic.h
+++ linux-2.6/include/asm-arm/atomic.h
@@ -80,6 +80,23 @@ static inline int atomic_sub_return(int 
 	return result;
 }
 
+static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
+{
+	u32 oldval, res;
+
+	do {
+		__asm__ __volatile__("@ atomic_cmpxchg\n"
+		"ldrex	%1, [%2]\n"
+		"teq	%1, %3\n"
+		"strexeq %0, %4, [%2]\n"
+		    : "=&r" (res), "=&r" (oldval)
+		    : "r" (&ptr->counter), "r" (old), "r" (new)
+		    : "cc");
+	} while (res);
+
+	return oldval;
+}
+
 static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 {
 	unsigned long tmp, tmp2;
@@ -131,6 +148,21 @@ static inline int atomic_sub_return(int 
 	return val;
 }
 
+static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 {
 	unsigned long flags;
Index: linux-2.6/include/asm-cris/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-cris/atomic.h
+++ linux-2.6/include/asm-cris/atomic.h
@@ -123,6 +123,19 @@ extern __inline__ int atomic_inc_and_tes
 	return retval;
 }
 
+static __inline__ int atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	unsigned long flags;
+	cris_atomic_save(v, flags);
+	ret = v->counter;
+	if (likely(ret == old))
+		v->counter = new;
+	cris_atomic_restore(v, flags);
+	return ret;
+}
+
+static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()    barrier()
 #define smp_mb__after_atomic_dec()     barrier()

--------------060205010002010409000106--
Send instant messages to your online friends http://au.messenger.yahoo.com 
