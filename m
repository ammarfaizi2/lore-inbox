Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129568AbRABIl2>; Tue, 2 Jan 2001 03:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbRABIlS>; Tue, 2 Jan 2001 03:41:18 -0500
Received: from palrel3.hp.com ([156.153.255.226]:32787 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S129568AbRABIk6>;
	Tue, 2 Jan 2001 03:40:58 -0500
Date: Tue, 2 Jan 2001 00:11:57 -0800 (PST)
From: Grant Grundler <grundler@cup.hp.com>
Message-Id: <200101020811.AAA26525@milano.cup.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] move xchg/cmpxchg to atomic.h
Cc: alan@lxorguk.ukuu.org.uk, parisc-linux@thepuffingroup.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On parisc-linux mailing list, Grant Grundler wrote:
> After surveying all the arches that define __HAVE_ARCH_CMPXCHG:
> 
> ./include/asm-alpha/system.h:#define __HAVE_ARCH_CMPXCHG 1
> ./include/asm-i386/system.h:#define __HAVE_ARCH_CMPXCHG 1
> ./include/asm-ia64/system.h:#define __HAVE_ARCH_CMPXCHG 1
> ./include/asm-ppc/system.h:#define __HAVE_ARCH_CMPXCHG  1
> ./include/asm-sparc64/system.h:#define __HAVE_ARCH_CMPXCHG 1
> 
> I've come to the conclusion xchg/cmpxchg definitions do NOT
> belong in system.h.  AFAICT, all the above use Load Linked semantics
> (or in the i386 case, operation is atomic). In other words, xchg/cmpxchg
> are atomic operations.  Shouldn't xchg/cmpxchg definitions live
> with other atomic operations - asm/atomic.h?
 
On Sat, 30 Dec 2000 16:46:57 +0000 (GMT), Alan Cox replied:
| Seems a reasonable thing to try and move to atomic.h yes

Fundemental problem is parisc only supports one atomic operation
(LDCW/LDCD) and uses spinlocks for all atomic operations including
xchg/cmpxchg. Issue is dependencies between system.h, atomic.h
and spinlock.h are *really* ugly and prevented parisc port from
inlining xchg/cmpxchg definitions. This is a first step in fixing
that problem.

I've already made this change to the parisc-linux source tree for parisc
and parisc64 builds. Below is the i386 patch for linux-2.4.0-prerelease.
This is a simple cut/paste.

thanks,
grant

diff -ruNp linux/include/asm-i386/atomic.h linux.patch/include/asm-i386/atomic.h
--- linux/include/asm-i386/atomic.h	Sun Dec 31 11:10:16 2000
+++ linux.patch/include/asm-i386/atomic.h	Mon Jan  1 23:28:08 2001
@@ -2,6 +2,7 @@
 #define __ARCH_I386_ATOMIC__
 
 #include <linux/config.h>
+#include <linux/bitops.h> /* for LOCK_PREFIX */
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -111,4 +112,136 @@ __asm__ __volatile__(LOCK "andl %0,%1" \
 __asm__ __volatile__(LOCK "orl %0,%1" \
 : : "r" (mask),"m" (*addr) : "memory")
 
+
+/* xchg/cmpxchg moved from asm/system.h */
+#define xchg(ptr,v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v),(ptr),sizeof(*(ptr))))
+
+#define tas(ptr) (xchg((ptr),1))
+
+struct __xchg_dummy { unsigned long a[100]; };
+#define __xg(x) ((struct __xchg_dummy *)(x))
+
+
+/*
+ * The semantics of XCHGCMP8B are a bit strange, this is why
+ * there is a loop and the loading of %%eax and %%edx has to
+ * be inside. This inlines well in most cases, the cached
+ * cost is around ~38 cycles. (in the future we might want
+ * to do an SIMD/3DNOW!/MMX/FPU 64-bit store here, but that
+ * might have an implicit FPU-save as a cost, so it's not
+ * clear which path to go.)
+ */
+extern inline void __set_64bit (unsigned long long * ptr,
+		unsigned int low, unsigned int high)
+{
+__asm__ __volatile__ (
+	"1:	movl (%0), %%eax;
+		movl 4(%0), %%edx;
+		cmpxchg8b (%0);
+		jnz 1b"
+	::		"D"(ptr),
+			"b"(low),
+			"c"(high)
+	:
+			"ax","dx","memory");
+}
+
+extern void inline __set_64bit_constant (unsigned long long *ptr,
+						 unsigned long long value)
+{
+	__set_64bit(ptr,(unsigned int)(value), (unsigned int)((value)>>32ULL));
+}
+#define ll_low(x)	*(((unsigned int*)&(x))+0)
+#define ll_high(x)	*(((unsigned int*)&(x))+1)
+
+extern void inline __set_64bit_var (unsigned long long *ptr,
+			 unsigned long long value)
+{
+	__set_64bit(ptr,ll_low(value), ll_high(value));
+}
+
+#define set_64bit(ptr,value) \
+(__builtin_constant_p(value) ? \
+ __set_64bit_constant(ptr, value) : \
+ __set_64bit_var(ptr, value) )
+
+#define _set_64bit(ptr,value) \
+(__builtin_constant_p(value) ? \
+ __set_64bit(ptr, (unsigned int)(value), (unsigned int)((value)>>32ULL) ) : \
+ __set_64bit(ptr, ll_low(value), ll_high(value)) )
+
+/*
+ * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
+ * Note 2: xchg has side effect, so that attribute volatile is necessary,
+ *	  but generally the primitive is invalid, *ptr is output argument. --ANK
+ */
+static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
+{
+	switch (size) {
+		case 1:
+			__asm__ __volatile__("xchgb %b0,%1"
+				:"=q" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+		case 2:
+			__asm__ __volatile__("xchgw %w0,%1"
+				:"=r" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+		case 4:
+			__asm__ __volatile__("xchgl %0,%1"
+				:"=r" (x)
+				:"m" (*__xg(ptr)), "0" (x)
+				:"memory");
+			break;
+	}
+	return x;
+}
+
+/*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+
+#ifdef CONFIG_X86_CMPXCHG
+#define __HAVE_ARCH_CMPXCHG 1
+
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+				      unsigned long new, int size)
+{
+	unsigned long prev;
+	switch (size) {
+	case 1:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 2:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	case 4:
+		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
+				     : "=a"(prev)
+				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
+				     : "memory");
+		return prev;
+	}
+	return old;
+}
+
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
+    
+#else
+/* Compiling for a 386 proper.	Is it worth implementing via cli/sti?  */
 #endif
+
+#endif /* __ARCH_I386_ATOMIC__ */
diff -ruNp linux/include/asm-i386/system.h linux.patch/include/asm-i386/system.h
--- linux/include/asm-i386/system.h	Sun Dec 31 11:10:16 2000
+++ linux.patch/include/asm-i386/system.h	Mon Jan  1 23:27:58 2001
@@ -4,7 +4,6 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <asm/segment.h>
-#include <linux/bitops.h> /* for LOCK_PREFIX */
 
 #ifdef __KERNEL__
 
@@ -123,136 +122,6 @@ static inline unsigned long get_limit(un
 }
 
 #define nop() __asm__ __volatile__ ("nop")
-
-#define xchg(ptr,v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v),(ptr),sizeof(*(ptr))))
-
-#define tas(ptr) (xchg((ptr),1))
-
-struct __xchg_dummy { unsigned long a[100]; };
-#define __xg(x) ((struct __xchg_dummy *)(x))
-
-
-/*
- * The semantics of XCHGCMP8B are a bit strange, this is why
- * there is a loop and the loading of %%eax and %%edx has to
- * be inside. This inlines well in most cases, the cached
- * cost is around ~38 cycles. (in the future we might want
- * to do an SIMD/3DNOW!/MMX/FPU 64-bit store here, but that
- * might have an implicit FPU-save as a cost, so it's not
- * clear which path to go.)
- */
-extern inline void __set_64bit (unsigned long long * ptr,
-		unsigned int low, unsigned int high)
-{
-__asm__ __volatile__ (
-	"1:	movl (%0), %%eax;
-		movl 4(%0), %%edx;
-		cmpxchg8b (%0);
-		jnz 1b"
-	::		"D"(ptr),
-			"b"(low),
-			"c"(high)
-	:
-			"ax","dx","memory");
-}
-
-extern void inline __set_64bit_constant (unsigned long long *ptr,
-						 unsigned long long value)
-{
-	__set_64bit(ptr,(unsigned int)(value), (unsigned int)((value)>>32ULL));
-}
-#define ll_low(x)	*(((unsigned int*)&(x))+0)
-#define ll_high(x)	*(((unsigned int*)&(x))+1)
-
-extern void inline __set_64bit_var (unsigned long long *ptr,
-			 unsigned long long value)
-{
-	__set_64bit(ptr,ll_low(value), ll_high(value));
-}
-
-#define set_64bit(ptr,value) \
-(__builtin_constant_p(value) ? \
- __set_64bit_constant(ptr, value) : \
- __set_64bit_var(ptr, value) )
-
-#define _set_64bit(ptr,value) \
-(__builtin_constant_p(value) ? \
- __set_64bit(ptr, (unsigned int)(value), (unsigned int)((value)>>32ULL) ) : \
- __set_64bit(ptr, ll_low(value), ll_high(value)) )
-
-/*
- * Note: no "lock" prefix even on SMP: xchg always implies lock anyway
- * Note 2: xchg has side effect, so that attribute volatile is necessary,
- *	  but generally the primitive is invalid, *ptr is output argument. --ANK
- */
-static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int size)
-{
-	switch (size) {
-		case 1:
-			__asm__ __volatile__("xchgb %b0,%1"
-				:"=q" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-		case 2:
-			__asm__ __volatile__("xchgw %w0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-		case 4:
-			__asm__ __volatile__("xchgl %0,%1"
-				:"=r" (x)
-				:"m" (*__xg(ptr)), "0" (x)
-				:"memory");
-			break;
-	}
-	return x;
-}
-
-/*
- * Atomic compare and exchange.  Compare OLD with MEM, if identical,
- * store NEW in MEM.  Return the initial value in MEM.  Success is
- * indicated by comparing RETURN with OLD.
- */
-
-#ifdef CONFIG_X86_CMPXCHG
-#define __HAVE_ARCH_CMPXCHG 1
-
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, int size)
-{
-	unsigned long prev;
-	switch (size) {
-	case 1:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 2:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	case 4:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
-				     : "=a"(prev)
-				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
-				     : "memory");
-		return prev;
-	}
-	return old;
-}
-
-#define cmpxchg(ptr,o,n)\
-	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
-					(unsigned long)(n),sizeof(*(ptr))))
-    
-#else
-/* Compiling for a 386 proper.	Is it worth implementing via cli/sti?  */
-#endif
 
 /*
  * Force strict CPU ordering.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
