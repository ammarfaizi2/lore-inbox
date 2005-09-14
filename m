Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965234AbVINPFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbVINPFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965235AbVINPFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:05:20 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:55140 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965234AbVINPFT (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 14 Sep 2005 11:05:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type;
  b=2AgFhNqwHeslYqXpqhollM9lNwatygCrQuNyg6Snt/8mHXhFiLhVaq+75nAPhozaBWbx1zgC0XeLOQ7CMLMWS9759TgNOqcljRiiJynJsoBbXdBmNz1E+pEy/kNOjP42Kad2jbBK3F3VYdIdW2nfEBeFLVRvJnXn6jmfO2lru7U=  ;
Message-ID: <4328387E.6050701@yahoo.com.au>
Date: Thu, 15 Sep 2005 00:49:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
CC: Dipankar Sarma <dipankar@in.ibm.com>
Subject: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
References: <43283825.7070309@yahoo.com.au>
In-Reply-To: <43283825.7070309@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------020101000009030105020604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020101000009030105020604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Also needs work on those same architectures. Other architectures
might want to look at providing a more optimal implementation.

-- 
SUSE Labs, Novell Inc.


--------------020101000009030105020604
Content-Type: text/plain;
 name="atomic_inc_not_zero.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic_inc_not_zero.patch"

Index: linux-2.6/include/asm-ppc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/atomic.h
+++ linux-2.6/include/asm-ppc64/atomic.h
@@ -164,6 +164,23 @@ static __inline__ int atomic_dec_return(
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+/**
+ * atomic_inc_not_zero - increment if not zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, so long as it was not 0.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
+
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
 
Index: linux-2.6/include/asm-alpha/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/atomic.h
+++ linux-2.6/include/asm-alpha/atomic.h
@@ -173,6 +173,15 @@ static __inline__ long atomic64_sub_retu
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic64_dec_return(v) atomic64_sub_return(1,(v))
 
Index: linux-2.6/include/asm-arm26/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-arm26/atomic.h
+++ linux-2.6/include/asm-arm26/atomic.h
@@ -76,6 +76,20 @@ static inline int atomic_cmpxchg(atomic_
 	return ret;
 }
 
+static inline int atomic_inc_not_zero(atomic_t *v)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (ret > 0)
+		v->counter++;
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
@@ -416,4 +416,13 @@ extern uint32_t __cmpxchg_32(uint32_t *v
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #endif /* _ASM_ATOMIC_H */
Index: linux-2.6/include/asm-h8300/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-h8300/atomic.h
+++ linux-2.6/include/asm-h8300/atomic.h
@@ -94,6 +94,18 @@ static __inline__ int atomic_cmpxchg(ato
         return ret;
 }
 
+static __inline__ int atomic_inc_not_zero(atomic_t *v)
+{
+	int ret;
+	unsigned long flags;
+	local_irq_save(flags);
+	ret = v->counter;
+	if (ret > 0)
+		v->counter++;
+	local_irq_restore(flags);
+	return ret;
+}
+
 static __inline__ void atomic_clear_mask(unsigned long mask, unsigned long *v)
 {
 	__asm__ __volatile__("stc ccr,r1l\n\t"
Index: linux-2.6/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-i386/atomic.h
+++ linux-2.6/include/asm-i386/atomic.h
@@ -217,6 +217,22 @@ static __inline__ int atomic_sub_return(
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 
+/**
+ * atomic_inc_not_zero - increment if not zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, so long as it was not 0.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
Index: linux-2.6/include/asm-ia64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/atomic.h
+++ linux-2.6/include/asm-ia64/atomic.h
@@ -90,6 +90,15 @@ ia64_atomic64_sub (__s64 i, atomic64_t *
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #define atomic_add_return(i,v)						\
 ({									\
 	int __ia64_aar_i = (i);						\
Index: linux-2.6/include/asm-m68k/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/atomic.h
+++ linux-2.6/include/asm-m68k/atomic.h
@@ -141,6 +141,15 @@ static inline void atomic_set_mask(unsig
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6/include/asm-m68knommu/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-m68knommu/atomic.h
+++ linux-2.6/include/asm-m68knommu/atomic.h
@@ -130,6 +130,15 @@ extern __inline__ int atomic_sub_return(
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
Index: linux-2.6/include/asm-mips/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-mips/atomic.h
+++ linux-2.6/include/asm-mips/atomic.h
@@ -269,6 +269,22 @@ static __inline__ int atomic_sub_if_posi
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+/**
+ * atomic_inc_not_zero - increment if not zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, so long as it was not 0.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #define atomic_dec_return(v) atomic_sub_return(1,(v))
 #define atomic_inc_return(v) atomic_add_return(1,(v))
 
Index: linux-2.6/include/asm-parisc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/atomic.h
+++ linux-2.6/include/asm-parisc/atomic.h
@@ -166,6 +166,22 @@ static __inline__ int atomic_read(const 
 /* exported interface */
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+/**
+ * atomic_inc_not_zero - increment if not zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, so long as it was not 0.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #define atomic_add(i,v)	((void)(__atomic_add_return( ((int)i),(v))))
 #define atomic_sub(i,v)	((void)(__atomic_add_return(-((int)i),(v))))
 #define atomic_inc(v)	((void)(__atomic_add_return(   1,(v))))
Index: linux-2.6/include/asm-ppc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc/atomic.h
+++ linux-2.6/include/asm-ppc/atomic.h
@@ -179,6 +179,22 @@ static __inline__ int atomic_dec_return(
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+/**
+ * atomic_inc_not_zero - increment if not zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, so long as it was not 0.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
 
Index: linux-2.6/include/asm-s390/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-s390/atomic.h
+++ linux-2.6/include/asm-s390/atomic.h
@@ -200,6 +200,15 @@ atomic_compare_and_swap(int expected_old
 
 #define atomic_cmpxchg(v, o, n) (atomic_compare_and_swap((o), (n), &((v)->counter)))
 
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
Index: linux-2.6/include/asm-sh/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sh/atomic.h
+++ linux-2.6/include/asm-sh/atomic.h
@@ -101,6 +101,20 @@ static __inline__ int atomic_cmpxchg(ato
         return ret;
 }
 
+static __inline__ int atomic_inc_not_zero(atomic_t *v)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (ret > 0)
+		v->counter++;
+	local_irq_restore(flags);
+
+	return ret;
+}
+
 static __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
 	unsigned long flags;
Index: linux-2.6/include/asm-sh64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sh64/atomic.h
+++ linux-2.6/include/asm-sh64/atomic.h
@@ -113,6 +113,20 @@ static __inline__ int atomic_cmpxchg(ato
         return ret;
 }
 
+static __inline__ int atomic_inc_not_zero(atomic_t *v)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (ret > 0)
+		v->counter++;
+	local_irq_restore(flags);
+
+	return ret;
+}
+
 static __inline__ void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
 	unsigned long flags;
Index: linux-2.6/include/asm-sparc/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sparc/atomic.h
+++ linux-2.6/include/asm-sparc/atomic.h
@@ -20,6 +20,7 @@ typedef struct { volatile int counter; }
 
 extern int __atomic_add_return(int, atomic_t *);
 extern int atomic_cmpxchg(atomic_t *, int, int);
+extern int atomic_inc_not_zero(atomic_t *);
 extern void atomic_set(atomic_t *, int);
 
 #define atomic_read(v)          ((v)->counter)
Index: linux-2.6/include/asm-sparc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/atomic.h
+++ linux-2.6/include/asm-sparc64/atomic.h
@@ -72,6 +72,15 @@ extern int atomic64_sub_ret(int, atomic6
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 /* Atomic operations are already serializing */
 #ifdef CONFIG_SMP
 #define smp_mb__before_atomic_dec()	membar_storeload_loadload();
Index: linux-2.6/include/asm-v850/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-v850/atomic.h
+++ linux-2.6/include/asm-v850/atomic.h
@@ -104,6 +104,20 @@ static __inline__ int atomic_cmpxchg(ato
         return ret;
 }
 
+static __inline__ int atomic_inc_not_zero(atomic_t *v)
+{
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ret = v->counter;
+	if (ret > 0)
+		v->counter++;
+	local_irq_restore(flags);
+
+	return ret;
+}
+
 /* Atomic operations are already serializing on ARM */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
Index: linux-2.6/include/asm-x86_64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/atomic.h
+++ linux-2.6/include/asm-x86_64/atomic.h
@@ -362,6 +362,22 @@ static __inline__ int atomic_sub_return(
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
 
+/**
+ * atomic_inc_not_zero - increment if not zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, so long as it was not 0.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
Index: linux-2.6/include/asm-xtensa/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-xtensa/atomic.h
+++ linux-2.6/include/asm-xtensa/atomic.h
@@ -225,6 +225,22 @@ static inline int atomic_sub_return(int 
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+/**
+ * atomic_inc_not_zero - increment if not zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, so long as it was not 0.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
 static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
 {
     unsigned int all_f = -1;
Index: linux-2.6/include/asm-cris/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-cris/atomic.h
+++ linux-2.6/include/asm-cris/atomic.h
@@ -135,6 +135,18 @@ static __inline__ int atomic_cmpxchg(ato
 	return ret;
 }
 
+static __inline__ int atomic_inc_not_zero(atomic_t *v)
+{
+	int ret;
+	unsigned long flags;
+	cris_atomic_save(v, flags);
+	ret = v->counter;
+	if (ret > 0)
+		v->counter++;
+	cris_atomic_restore(v, flags);
+	return ret;
+}
+
 static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()    barrier()
Index: linux-2.6/arch/sparc/lib/atomic32.c
===================================================================
--- linux-2.6.orig/arch/sparc/lib/atomic32.c
+++ linux-2.6/arch/sparc/lib/atomic32.c
@@ -52,6 +52,20 @@ int atomic_cmpxchg(atomic_t *v, int old,
 	return ret;
 }
 
+int atomic_inc_not_zero(atomic_t *v)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(ATOMIC_HASH(v), flags);
+	ret = v->counter;
+	if (ret > 0)
+		v->counter++;
+	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
+	return ret;
+}
+
+static inline void atomic_clear_mask(unsigned long mask, unsigned long *addr)
+/* Atomic operations are already serializing */
 void atomic_set(atomic_t *v, int i)
 {
 	unsigned long flags;
Index: linux-2.6/Documentation/atomic_ops.txt
===================================================================
--- linux-2.6.orig/Documentation/atomic_ops.txt
+++ linux-2.6/Documentation/atomic_ops.txt
@@ -115,7 +115,7 @@ boolean is return which indicates whethe
 is negative.  It requires explicit memory barrier semantics around the
 operation.
 
-Finally:
+Then:
 
 	int atomic_cmpxchg(atomic_t *v, int old, int new);
 
@@ -129,6 +129,16 @@ atomic_cmpxchg requires explicit memory 
 The semantics for atomic_cmpxchg are the same as those defined for 'cas'
 below.
 
+Finally:
+
+	int atomic_inc_not_zero(atomic_t *v);
+
+If the atomic value v is not zero, this function increments v and returns
+non zero. If v is zero then it returns zero. This is done as an atomic
+operation.
+
+atomic_inc_not_zero requires explicit memory barriers around the operation.
+
 
 If a caller requires memory barrier semantics around an atomic_t
 operation which does not return a value, a set of interfaces are

--------------020101000009030105020604--
Send instant messages to your online friends http://au.messenger.yahoo.com 
