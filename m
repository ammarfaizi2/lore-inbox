Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUFTRky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUFTRky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265806AbUFTRal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:30:41 -0400
Received: from nl-ams-slo-l4-01-pip-5.chellonetwork.com ([213.46.243.21]:7509
	"EHLO amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S265879AbUFTRZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:25:57 -0400
Date: Sun, 20 Jun 2004 19:25:55 +0200
Message-Id: <200406201725.i5KHPtUr001484@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 451] M68k new gcc optimizations
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k compiler updates from Roman Zippel:
  - Fix various lvalue warnings from newer gcc
  - Remove unnecessary volatile declarations
  - Change some constraints from "a" to "m" to generate slightly better code
  - Use "o" constraint for bitfield instructions
  - Use generic bitmap functions for some of the ext2/minix bitmap functions

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.7/include/asm-m68k/atomic.h	2004-04-27 16:26:12.000000000 +0200
+++ linux-m68k-2.6.7/include/asm-m68k/atomic.h	2004-05-23 10:56:37.000000000 +0200
@@ -18,36 +18,40 @@
 
 static __inline__ void atomic_add(int i, atomic_t *v)
 {
-	__asm__ __volatile__("addl %1,%0" : "=m" (*v) : "id" (i), "0" (*v));
+	__asm__ __volatile__("addl %1,%0" : "+m" (*v) : "id" (i));
 }
 
 static __inline__ void atomic_sub(int i, atomic_t *v)
 {
-	__asm__ __volatile__("subl %1,%0" : "=m" (*v) : "id" (i), "0" (*v));
+	__asm__ __volatile__("subl %1,%0" : "+m" (*v) : "id" (i));
 }
 
-static __inline__ void atomic_inc(volatile atomic_t *v)
+static __inline__ void atomic_inc(atomic_t *v)
 {
-	__asm__ __volatile__("addql #1,%0" : "=m" (*v): "0" (*v));
+	__asm__ __volatile__("addql #1,%0" : "+m" (*v));
 }
 
-static __inline__ void atomic_dec(volatile atomic_t *v)
+static __inline__ void atomic_dec(atomic_t *v)
 {
-	__asm__ __volatile__("subql #1,%0" : "=m" (*v): "0" (*v));
+	__asm__ __volatile__("subql #1,%0" : "+m" (*v));
 }
 
-static __inline__ int atomic_dec_and_test(volatile atomic_t *v)
+static __inline__ int atomic_dec_and_test(atomic_t *v)
 {
 	char c;
-	__asm__ __volatile__("subql #1,%1; seq %0" : "=d" (c), "=m" (*v): "1" (*v));
+	__asm__ __volatile__("subql #1,%1; seq %0" : "=d" (c), "+m" (*v));
 	return c != 0;
 }
 
-#define atomic_clear_mask(mask, v) \
-	__asm__ __volatile__("andl %1,%0" : "=m" (*v) : "id" (~(mask)),"0"(*v))
+static __inline__ void atomic_clear_mask(unsigned long mask, unsigned long *v)
+{
+	__asm__ __volatile__("andl %1,%0" : "+m" (*v) : "id" (~(mask)));
+}
 
-#define atomic_set_mask(mask, v) \
-	__asm__ __volatile__("orl %1,%0" : "=m" (*v) : "id" (mask),"0"(*v))
+static __inline__ void atomic_set_mask(unsigned long mask, unsigned long *v)
+{
+	__asm__ __volatile__("orl %1,%0" : "+m" (*v) : "id" (mask));
+}
 
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
--- linux-2.6.7/include/asm-m68k/bitops.h	2004-05-03 20:05:05.000000000 +0200
+++ linux-m68k-2.6.6/include/asm-m68k/bitops.h	2004-05-23 19:50:20.000000000 +0200
@@ -23,25 +23,24 @@
 
 #define __test_and_set_bit(nr,vaddr) test_and_set_bit(nr,vaddr)
 
-static inline int __constant_test_and_set_bit(int nr,
-					      volatile unsigned long *vaddr)
+static inline int __constant_test_and_set_bit(int nr, unsigned long *vaddr)
 {
+	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	char retval;
 
 	__asm__ __volatile__ ("bset %2,%1; sne %0"
-	     : "=d" (retval), "+m" (((volatile char *)vaddr)[(nr^31) >> 3])
-	     : "di" (nr & 7));
+			: "=d" (retval), "+m" (*p)
+			: "di" (nr & 7));
 
 	return retval;
 }
 
-static inline int __generic_test_and_set_bit(int nr,
-					     volatile unsigned long *vaddr)
+static inline int __generic_test_and_set_bit(int nr, unsigned long *vaddr)
 {
 	char retval;
 
-	__asm__ __volatile__ ("bfset %2@{%1:#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^31), "a" (vaddr) : "memory");
+	__asm__ __volatile__ ("bfset %2{%1:#1}; sne %0"
+			: "=d" (retval) : "d" (nr^31), "o" (*vaddr) : "memory");
 
 	return retval;
 }
@@ -53,16 +52,17 @@
 
 #define __set_bit(nr,vaddr) set_bit(nr,vaddr)
 
-static inline void __constant_set_bit(int nr, volatile unsigned long *vaddr)
+static inline void __constant_set_bit(int nr, unsigned long *vaddr)
 {
+	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	__asm__ __volatile__ ("bset %1,%0"
-	     : "+m" (((volatile char *)vaddr)[(nr^31) >> 3]) : "di" (nr & 7));
+			: "+m" (*p) : "di" (nr & 7));
 }
 
-static inline void __generic_set_bit(int nr, volatile unsigned long *vaddr)
+static inline void __generic_set_bit(int nr, unsigned long *vaddr)
 {
-	__asm__ __volatile__ ("bfset %1@{%0:#1}"
-	     : : "d" (nr^31), "a" (vaddr) : "memory");
+	__asm__ __volatile__ ("bfset %1{%0:#1}"
+			: : "d" (nr^31), "o" (*vaddr) : "memory");
 }
 
 #define test_and_clear_bit(nr,vaddr) \
@@ -72,25 +72,24 @@
 
 #define __test_and_clear_bit(nr,vaddr) test_and_clear_bit(nr,vaddr)
 
-static inline int __constant_test_and_clear_bit(int nr,
-						volatile unsigned long *vaddr)
+static inline int __constant_test_and_clear_bit(int nr, unsigned long *vaddr)
 {
+	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	char retval;
 
 	__asm__ __volatile__ ("bclr %2,%1; sne %0"
-	     : "=d" (retval), "+m" (((volatile char *)vaddr)[(nr^31) >> 3])
-	     : "di" (nr & 7));
+			: "=d" (retval), "+m" (*p)
+			: "di" (nr & 7));
 
 	return retval;
 }
 
-static inline int __generic_test_and_clear_bit(int nr,
-					       volatile unsigned long *vaddr)
+static inline int __generic_test_and_clear_bit(int nr, unsigned long *vaddr)
 {
 	char retval;
 
-	__asm__ __volatile__ ("bfclr %2@{%1:#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^31), "a" (vaddr) : "memory");
+	__asm__ __volatile__ ("bfclr %2{%1:#1}; sne %0"
+			: "=d" (retval) : "d" (nr^31), "o" (*vaddr) : "memory");
 
 	return retval;
 }
@@ -107,16 +106,17 @@
    __generic_clear_bit(nr, vaddr))
 #define __clear_bit(nr,vaddr) clear_bit(nr,vaddr)
 
-static inline void __constant_clear_bit(int nr, volatile unsigned long *vaddr)
+static inline void __constant_clear_bit(int nr, unsigned long *vaddr)
 {
+	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	__asm__ __volatile__ ("bclr %1,%0"
-	     : "+m" (((volatile char *)vaddr)[(nr^31) >> 3]) : "di" (nr & 7));
+			: "+m" (*p) : "di" (nr & 7));
 }
 
-static inline void __generic_clear_bit(int nr, volatile unsigned long *vaddr)
+static inline void __generic_clear_bit(int nr, unsigned long *vaddr)
 {
-	__asm__ __volatile__ ("bfclr %1@{%0:#1}"
-	     : : "d" (nr^31), "a" (vaddr) : "memory");
+	__asm__ __volatile__ ("bfclr %1{%0:#1}"
+			: : "d" (nr^31), "o" (*vaddr) : "memory");
 }
 
 #define test_and_change_bit(nr,vaddr) \
@@ -127,25 +127,24 @@
 #define __test_and_change_bit(nr,vaddr) test_and_change_bit(nr,vaddr)
 #define __change_bit(nr,vaddr) change_bit(nr,vaddr)
 
-static inline int __constant_test_and_change_bit(int nr,
-						 volatile unsigned long *vaddr)
+static inline int __constant_test_and_change_bit(int nr, unsigned long *vaddr)
 {
+	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	char retval;
 
 	__asm__ __volatile__ ("bchg %2,%1; sne %0"
-	     : "=d" (retval), "+m" (((volatile char *)vaddr)[(nr^31) >> 3])
-	     : "di" (nr & 7));
+			: "=d" (retval), "+m" (*p)
+			: "di" (nr & 7));
 
 	return retval;
 }
 
-static inline int __generic_test_and_change_bit(int nr,
-						volatile unsigned long *vaddr)
+static inline int __generic_test_and_change_bit(int nr, unsigned long *vaddr)
 {
 	char retval;
 
-	__asm__ __volatile__ ("bfchg %2@{%1:#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^31), "a" (vaddr) : "memory");
+	__asm__ __volatile__ ("bfchg %2{%1:#1}; sne %0"
+			: "=d" (retval) : "d" (nr^31), "o" (*vaddr) : "memory");
 
 	return retval;
 }
@@ -155,21 +154,22 @@
    __constant_change_bit(nr, vaddr) : \
    __generic_change_bit(nr, vaddr))
 
-static inline void __constant_change_bit(int nr, volatile unsigned long *vaddr)
+static inline void __constant_change_bit(int nr, unsigned long *vaddr)
 {
+	char *p = (char *)vaddr + (nr ^ 31) / 8;
 	__asm__ __volatile__ ("bchg %1,%0"
-	     : "+m" (((volatile char *)vaddr)[(nr^31) >> 3]) : "di" (nr & 7));
+			: "+m" (*p) : "di" (nr & 7));
 }
 
-static inline void __generic_change_bit(int nr, volatile unsigned long *vaddr)
+static inline void __generic_change_bit(int nr, unsigned long *vaddr)
 {
-	__asm__ __volatile__ ("bfchg %1@{%0:#1}"
-	     : : "d" (nr^31), "a" (vaddr) : "memory");
+	__asm__ __volatile__ ("bfchg %1{%0:#1}"
+			: : "d" (nr^31), "o" (*vaddr) : "memory");
 }
 
-static inline int test_bit(int nr, const volatile unsigned long *vaddr)
+static inline int test_bit(int nr, const unsigned long *vaddr)
 {
-	return ((1UL << (nr & 31)) & (((const volatile unsigned long *) vaddr)[nr >> 5])) != 0;
+	return (vaddr[nr >> 5] & (1UL << (nr & 31))) != 0;
 }
 
 static inline int find_first_zero_bit(const unsigned long *vaddr,
@@ -364,76 +364,27 @@
 	return ((p - addr) << 4) + (res ^ 31);
 }
 
-static inline int minix_test_and_set_bit(int nr, volatile void *vaddr)
-{
-	char retval;
-
-	__asm__ __volatile__ ("bfset %2{%1:#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^15), "m" (*(volatile char *)vaddr) : "memory");
-
-	return retval;
-}
-
-#define minix_set_bit(nr,addr)	((void)minix_test_and_set_bit(nr,addr))
-
-static inline int minix_test_and_clear_bit(int nr, volatile void *vaddr)
-{
-	char retval;
-
-	__asm__ __volatile__ ("bfclr %2{%1:#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^15), "m" (*(volatile char *) vaddr) : "memory");
-
-	return retval;
-}
+#define minix_test_and_set_bit(nr, addr)	test_and_set_bit((nr) ^ 16, (unsigned long *)(addr))
+#define minix_set_bit(nr,addr)			set_bit((nr) ^ 16, (unsigned long *)(addr))
+#define minix_test_and_clear_bit(nr, addr)	test_and_clear_bit((nr) ^ 16, (unsigned long *)(addr))
 
-static inline int minix_test_bit(int nr, const volatile void *vaddr)
+static inline int minix_test_bit(int nr, const void *vaddr)
 {
-	return ((1U << (nr & 15)) & (((const volatile unsigned short *) vaddr)[nr >> 4])) != 0;
+	const unsigned short *p = vaddr;
+	return (p[nr >> 4] & (1U << (nr & 15))) != 0;
 }
 
 /* Bitmap functions for the ext2 filesystem. */
 
-static inline int ext2_set_bit(int nr, volatile void *vaddr)
-{
-	char retval;
-
-	__asm__ __volatile__ ("bfset %2{%1,#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^7), "m" (*(volatile char *) vaddr) : "memory");
-
-	return retval;
-}
-
-static inline int ext2_clear_bit(int nr, volatile void *vaddr)
-{
-	char retval;
-
-	__asm__ __volatile__ ("bfclr %2{%1,#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^7), "m" (*(volatile char *) vaddr) : "memory");
-
-	return retval;
-}
-
-#define ext2_set_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_set_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
-
-#define ext2_clear_bit_atomic(lock, nr, addr)		\
-	({						\
-		int ret;				\
-		spin_lock(lock);			\
-		ret = ext2_clear_bit((nr), (addr));	\
-		spin_unlock(lock);			\
-		ret;					\
-	})
+#define ext2_set_bit(nr, addr)			test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
+#define ext2_set_bit_atomic(lock, nr, addr)	test_and_set_bit((nr) ^ 24, (unsigned long *)(addr))
+#define ext2_clear_bit(nr, addr)		test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
+#define ext2_clear_bit_atomic(lock, nr, addr)	test_and_clear_bit((nr) ^ 24, (unsigned long *)(addr))
 
-static inline int ext2_test_bit(int nr, const volatile void *vaddr)
+static inline int ext2_test_bit(int nr, const void *vaddr)
 {
-	return ((1U << (nr & 7)) & (((const volatile unsigned char *) vaddr)[nr >> 3])) != 0;
+	const unsigned char *p = vaddr;
+	return (p[nr >> 3] & (1U << (nr & 7))) != 0;
 }
 
 static inline int ext2_find_first_zero_bit(const void *vaddr, unsigned size)
--- linux-2.6.7/include/asm-m68k/page.h	2004-05-03 11:01:24.000000000 +0200
+++ linux-m68k-2.6.7/include/asm-m68k/page.h	2004-05-23 10:56:37.000000000 +0200
@@ -52,15 +52,13 @@
 
 static inline void clear_page(void *page)
 {
-	unsigned long data, tmp;
-	void *sp = page;
+	unsigned long tmp;
+	unsigned long *sp = page;
 
-	data = 0;
-
-	*((unsigned long *)(page))++ = 0;
-	*((unsigned long *)(page))++ = 0;
-	*((unsigned long *)(page))++ = 0;
-	*((unsigned long *)(page))++ = 0;
+	*sp++ = 0;
+	*sp++ = 0;
+	*sp++ = 0;
+	*sp++ = 0;
 
 	__asm__ __volatile__("1:\t"
 			     ".chip 68040\n\t"
@@ -69,8 +67,8 @@
 			     "subqw  #8,%2\n\t"
 			     "subqw  #8,%2\n\t"
 			     "dbra   %1,1b\n\t"
-			     : "=a" (page), "=d" (tmp)
-			     : "a" (sp), "0" (page),
+			     : "=a" (sp), "=d" (tmp)
+			     : "a" (page), "0" (sp),
 			       "1" ((PAGE_SIZE - 16) / 16 - 1));
 }
 
--- linux-2.6.7/include/asm-m68k/string.h	2004-05-03 11:01:24.000000000 +0200
+++ linux-m68k-2.6.7/include/asm-m68k/string.h	2004-05-23 10:56:37.000000000 +0200
@@ -290,9 +290,7 @@
 static inline void * __memset_page(void * s,int c,size_t count)
 {
   unsigned long data, tmp;
-  void *xs, *sp;
-
-  xs = sp = s;
+  void *xs = s;
 
   c = c & 255;
   data = c | (c << 8);
@@ -303,10 +301,11 @@
   if (((unsigned long) s) & 0x0f)
 	  __memset_g(s, c, count);
   else{
-	  *((unsigned long *)(s))++ = data;
-	  *((unsigned long *)(s))++ = data;
-	  *((unsigned long *)(s))++ = data;
-	  *((unsigned long *)(s))++ = data;
+	  unsigned long *sp = s;
+	  *sp++ = data;
+	  *sp++ = data;
+	  *sp++ = data;
+	  *sp++ = data;
 
 	  __asm__ __volatile__("1:\t"
 			       ".chip 68040\n\t"
@@ -315,8 +314,8 @@
 			       "subqw  #8,%2\n\t"
 			       "subqw  #8,%2\n\t"
 			       "dbra   %1,1b\n\t"
-			       : "=a" (s), "=d" (tmp)
-			       : "a" (sp), "0" (s), "1" ((count - 16) / 16 - 1)
+			       : "=a" (sp), "=d" (tmp)
+			       : "a" (s), "0" (sp), "1" ((count - 16) / 16 - 1)
 			       );
   }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
