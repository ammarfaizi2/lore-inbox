Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbSLLSIm>; Thu, 12 Dec 2002 13:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSLLSI1>; Thu, 12 Dec 2002 13:08:27 -0500
Received: from d06lmsgate-6.uk.ibm.com ([194.196.100.252]:27618 "EHLO
	d06lmsgate-6.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S264963AbSLLSHJ> convert rfc822-to-8bit; Thu, 12 Dec 2002 13:07:09 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (7/8): warnings.
Date: Thu, 12 Dec 2002 19:09:49 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212121909.49641.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warning fixes: remove an unused variable and make bitops complain if the
pointer isn't of type long. Make 31 bit BUG() emit 4 0-bytes instead of 2.
This improves the readability of the listing. 

diffstat:
 arch/s390x/mm/extable.c         |    1 
 include/asm-s390/bitops.h       |   70 ++++++++++++++++++++++++----------------
 include/asm-s390/page.h         |    2 -
 include/asm-s390/posix_types.h  |    6 +--
 include/asm-s390/rwsem.h        |    2 -
 include/asm-s390/setup.h        |   12 +++---
 include/asm-s390x/bitops.h      |   64 +++++++++++++++++++-----------------
 include/asm-s390x/posix_types.h |    6 +--
 include/asm-s390x/rwsem.h       |    2 -
 9 files changed, 92 insertions(+), 73 deletions(-)

diff -urN linux-2.5.51/arch/s390x/mm/extable.c linux-2.5.51-s390/arch/s390x/mm/extable.c
--- linux-2.5.51/arch/s390x/mm/extable.c	Tue Dec 10 03:45:53 2002
+++ linux-2.5.51-s390/arch/s390x/mm/extable.c	Thu Dec 12 18:03:36 2002
@@ -40,7 +40,6 @@
 unsigned long
 search_exception_table(unsigned long addr)
 {
-	struct list_head *i;
 	unsigned long ret = 0;
 	
 #ifndef CONFIG_MODULES
diff -urN linux-2.5.51/include/asm-s390/bitops.h linux-2.5.51-s390/include/asm-s390/bitops.h
--- linux-2.5.51/include/asm-s390/bitops.h	Tue Dec 10 03:45:42 2002
+++ linux-2.5.51-s390/include/asm-s390/bitops.h	Thu Dec 12 18:03:36 2002
@@ -53,7 +53,7 @@
 /*
  * SMP save set_bit routine based on compare and swap (CS)
  */
-static inline void set_bit_cs(int nr, volatile void *ptr)
+static inline void set_bit_cs(int nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -78,7 +78,7 @@
 /*
  * SMP save clear_bit routine based on compare and swap (CS)
  */
-static inline void clear_bit_cs(int nr, volatile void *ptr)
+static inline void clear_bit_cs(int nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -103,7 +103,7 @@
 /*
  * SMP save change_bit routine based on compare and swap (CS)
  */
-static inline void change_bit_cs(int nr, volatile void *ptr)
+static inline void change_bit_cs(int nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -128,7 +128,8 @@
 /*
  * SMP save test_and_set_bit routine based on compare and swap (CS)
  */
-static inline int test_and_set_bit_cs(int nr, volatile void *ptr)
+static inline int
+test_and_set_bit_cs(int nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -154,7 +155,8 @@
 /*
  * SMP save test_and_clear_bit routine based on compare and swap (CS)
  */
-static inline int test_and_clear_bit_cs(int nr, volatile void *ptr)
+static inline int
+test_and_clear_bit_cs(int nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -180,7 +182,8 @@
 /*
  * SMP save test_and_change_bit routine based on compare and swap (CS) 
  */
-static inline int test_and_change_bit_cs(int nr, volatile void *ptr)
+static inline int
+test_and_change_bit_cs(int nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -207,7 +210,7 @@
 /*
  * fast, non-SMP set_bit routine
  */
-static inline void __set_bit(int nr, volatile void *ptr)
+static inline void __set_bit(int nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -219,7 +222,7 @@
 }
 
 static inline void 
-__constant_set_bit(const int nr, volatile void *ptr)
+__constant_set_bit(const int nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -269,7 +272,7 @@
  * fast, non-SMP clear_bit routine
  */
 static inline void 
-__clear_bit(int nr, volatile void *ptr)
+__clear_bit(int nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -281,7 +284,7 @@
 }
 
 static inline void 
-__constant_clear_bit(const int nr, volatile void *ptr)
+__constant_clear_bit(const int nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -330,7 +333,7 @@
 /* 
  * fast, non-SMP change_bit routine 
  */
-static inline void __change_bit(int nr, volatile void *ptr)
+static inline void __change_bit(int nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -342,7 +345,7 @@
 }
 
 static inline void 
-__constant_change_bit(const int nr, volatile void *ptr) 
+__constant_change_bit(const int nr, volatile unsigned long *ptr) 
 {
 	unsigned long addr;
 
@@ -391,7 +394,8 @@
 /*
  * fast, non-SMP test_and_set_bit routine
  */
-static inline int test_and_set_bit_simple(int nr, volatile void *ptr)
+static inline int
+test_and_set_bit_simple(int nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -409,7 +413,8 @@
 /*
  * fast, non-SMP test_and_clear_bit routine
  */
-static inline int test_and_clear_bit_simple(int nr, volatile void *ptr)
+static inline int
+test_and_clear_bit_simple(int nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -427,7 +432,8 @@
 /*
  * fast, non-SMP test_and_change_bit routine
  */
-static inline int test_and_change_bit_simple(int nr, volatile void *ptr)
+static inline int
+test_and_change_bit_simple(int nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -463,7 +469,7 @@
  * This routine doesn't need to be atomic.
  */
 
-static inline int __test_bit(int nr, volatile void *ptr)
+static inline int __test_bit(int nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -473,7 +479,8 @@
 	return (ch >> (nr & 7)) & 1;
 }
 
-static inline int __constant_test_bit(int nr, volatile void * addr) {
+static inline int 
+__constant_test_bit(int nr, volatile unsigned long * addr) {
     return (((volatile char *) addr)[(nr>>3)^3] & (1<<(nr&7))) != 0;
 }
 
@@ -485,7 +492,8 @@
 /*
  * Find-bit routines..
  */
-static inline int find_first_zero_bit(void * addr, unsigned size)
+static inline int
+find_first_zero_bit(unsigned long * addr, unsigned size)
 {
 	unsigned long cmp, count;
         int res;
@@ -523,7 +531,8 @@
         return (res < size) ? res : size;
 }
 
-static inline int find_first_bit(void * addr, unsigned size)
+static inline int
+find_first_bit(unsigned long * addr, unsigned size)
 {
 	unsigned long cmp, count;
         int res;
@@ -561,7 +570,8 @@
         return (res < size) ? res : size;
 }
 
-static inline int find_next_zero_bit (void * addr, int size, int offset)
+static inline int
+find_next_zero_bit (unsigned long * addr, int size, int offset)
 {
         unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
         unsigned long bitvec, reg;
@@ -599,7 +609,8 @@
         return (offset + res);
 }
 
-static inline int find_next_bit (void * addr, int size, int offset)
+static inline int
+find_next_bit (unsigned long * addr, int size, int offset)
 {
         unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
         unsigned long bitvec, reg;
@@ -668,7 +679,7 @@
  * __ffs = find first bit in word. Undefined if no bit exists,
  * so code should check against 0UL first..
  */
-static inline unsigned long __ffs(unsigned long word)
+static inline unsigned long __ffs (unsigned long word)
 {
 	unsigned long reg, result;
 
@@ -707,7 +718,7 @@
  * differs in spirit from the above ffz (man ffs).
  */
 
-extern int inline ffs (int x)
+extern inline int ffs (int x)
 {
         int r = 1;
 
@@ -792,10 +803,15 @@
  *    23 22 21 20 19 18 17 16 31 30 29 28 27 26 25 24
  */
 
-#define ext2_set_bit(nr, addr)       test_and_set_bit((nr)^24, addr)
-#define ext2_clear_bit(nr, addr)     test_and_clear_bit((nr)^24, addr)
-#define ext2_test_bit(nr, addr)      test_bit((nr)^24, addr)
-static inline int ext2_find_first_zero_bit(void *vaddr, unsigned size)
+#define ext2_set_bit(nr, addr)       \
+	test_and_set_bit((nr)^24, (unsigned long *)addr)
+#define ext2_clear_bit(nr, addr)     \
+	test_and_clear_bit((nr)^24, (unsigned long *)addr)
+#define ext2_test_bit(nr, addr)      \
+	test_bit((nr)^24, (unsigned long *)addr)
+
+static inline int 
+ext2_find_first_zero_bit(void *vaddr, unsigned size)
 {
 	unsigned long cmp, count;
         int res;
diff -urN linux-2.5.51/include/asm-s390/page.h linux-2.5.51-s390/include/asm-s390/page.h
--- linux-2.5.51/include/asm-s390/page.h	Tue Dec 10 03:45:44 2002
+++ linux-2.5.51-s390/include/asm-s390/page.h	Thu Dec 12 18:03:36 2002
@@ -64,7 +64,7 @@
 
 #define BUG() do { \
         printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-        __asm__ __volatile__(".word 0x0000"); \
+        __asm__ __volatile__(".long 0"); \
 } while (0)                                       
 
 #define PAGE_BUG(page) do { \
diff -urN linux-2.5.51/include/asm-s390/posix_types.h linux-2.5.51-s390/include/asm-s390/posix_types.h
--- linux-2.5.51/include/asm-s390/posix_types.h	Tue Dec 10 03:45:39 2002
+++ linux-2.5.51-s390/include/asm-s390/posix_types.h	Thu Dec 12 18:03:36 2002
@@ -60,13 +60,13 @@
 #endif
 
 #undef  __FD_SET
-#define __FD_SET(fd,fdsetp)  set_bit(fd,fdsetp)
+#define __FD_SET(fd,fdsetp)  set_bit(fd,fdsetp->fds_bits)
 
 #undef  __FD_CLR
-#define __FD_CLR(fd,fdsetp)  clear_bit(fd,fdsetp)
+#define __FD_CLR(fd,fdsetp)  clear_bit(fd,fdsetp->fds_bits)
 
 #undef  __FD_ISSET
-#define __FD_ISSET(fd,fdsetp)  test_bit(fd,fdsetp)
+#define __FD_ISSET(fd,fdsetp)  test_bit(fd,fdsetp->fds_bits)
 
 #undef  __FD_ZERO
 #define __FD_ZERO(fdsetp) (memset (fdsetp, 0, sizeof(*(fd_set *)fdsetp)))
diff -urN linux-2.5.51/include/asm-s390/rwsem.h linux-2.5.51-s390/include/asm-s390/rwsem.h
--- linux-2.5.51/include/asm-s390/rwsem.h	Tue Dec 10 03:45:57 2002
+++ linux-2.5.51-s390/include/asm-s390/rwsem.h	Thu Dec 12 18:03:36 2002
@@ -228,7 +228,7 @@
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "m" (tmp)
 		: "cc", "memory" );
-	if (new > 1) // FIXME: is this correct ?!?
+	if (new > 1)
 		rwsem_downgrade_wake(sem);
 }
 
diff -urN linux-2.5.51/include/asm-s390/setup.h linux-2.5.51-s390/include/asm-s390/setup.h
--- linux-2.5.51/include/asm-s390/setup.h	Tue Dec 10 03:46:20 2002
+++ linux-2.5.51-s390/include/asm-s390/setup.h	Thu Dec 12 18:03:36 2002
@@ -25,13 +25,13 @@
  */
 extern unsigned long machine_flags;
 
-#define MACHINE_IS_VM    (machine_flags & 1)
-#define MACHINE_HAS_IEEE (machine_flags & 2)
-#define MACHINE_IS_P390  (machine_flags & 4)
-#define MACHINE_HAS_CSP  (machine_flags & 8)
-#define MACHINE_HAS_MVPG (machine_flags & 16)
+#define MACHINE_IS_VM		(machine_flags & 1)
+#define MACHINE_HAS_IEEE	(machine_flags & 2)
+#define MACHINE_IS_P390		(machine_flags & 4)
+#define MACHINE_HAS_CSP		(machine_flags & 8)
+#define MACHINE_HAS_MVPG	(machine_flags & 16)
 
-#define MACHINE_HAS_SCLP (!MACHINE_IS_P390)
+#define MACHINE_HAS_SCLP	(!MACHINE_IS_P390)
 
 /*
  * Console mode. Override with conmode=
diff -urN linux-2.5.51/include/asm-s390x/bitops.h linux-2.5.51-s390/include/asm-s390x/bitops.h
--- linux-2.5.51/include/asm-s390x/bitops.h	Tue Dec 10 03:46:24 2002
+++ linux-2.5.51-s390/include/asm-s390x/bitops.h	Thu Dec 12 18:03:36 2002
@@ -1,3 +1,6 @@
+#ifndef _S390_BITOPS_H
+#define _S390_BITOPS_H
+
 /*
  *  include/asm-s390/bitops.h
  *
@@ -9,9 +12,7 @@
  *    Copyright (C) 1992, Linus Torvalds
  *
  */
-
-#ifndef _S390_BITOPS_H
-#define _S390_BITOPS_H
+#include <linux/config.h>
 
 /*
  * bit 0 is the LSB of *addr; bit 63 is the MSB of *addr;
@@ -32,7 +33,6 @@
  * of the form "flags |= (1 << bitnr)" are used INTERMIXED
  * with operation of the form "set_bit(bitnr, flags)".
  */
-#include <linux/config.h>
 
 /* set ALIGN_CS to 1 if the SMP safe bit operations should
  * align the address to 4 byte boundary. It seems to work
@@ -57,7 +57,7 @@
 /*
  * SMP save set_bit routine based on compare and swap (CS)
  */
-static inline void set_bit_cs(unsigned long nr, volatile void *ptr)
+static inline void set_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -82,7 +82,7 @@
 /*
  * SMP save clear_bit routine based on compare and swap (CS)
  */
-static inline void clear_bit_cs(unsigned long nr, volatile void *ptr)
+static inline void clear_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -107,7 +107,7 @@
 /*
  * SMP save change_bit routine based on compare and swap (CS)
  */
-static inline void change_bit_cs(unsigned long nr, volatile void *ptr)
+static inline void change_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -132,8 +132,8 @@
 /*
  * SMP save test_and_set_bit routine based on compare and swap (CS)
  */
-static inline int 
-test_and_set_bit_cs(unsigned long nr, volatile void *ptr)
+static inline int
+test_and_set_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -160,7 +160,7 @@
  * SMP save test_and_clear_bit routine based on compare and swap (CS)
  */
 static inline int
-test_and_clear_bit_cs(unsigned long nr, volatile void *ptr)
+test_and_clear_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -187,7 +187,7 @@
  * SMP save test_and_change_bit routine based on compare and swap (CS) 
  */
 static inline int
-test_and_change_bit_cs(unsigned long nr, volatile void *ptr)
+test_and_change_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
@@ -214,7 +214,7 @@
 /*
  * fast, non-SMP set_bit routine
  */
-static inline void __set_bit(unsigned long nr, volatile void *ptr)
+static inline void __set_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -226,7 +226,7 @@
 }
 
 static inline void 
-__constant_set_bit(const unsigned long nr, volatile void *ptr)
+__constant_set_bit(const unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -276,7 +276,7 @@
  * fast, non-SMP clear_bit routine
  */
 static inline void 
-__clear_bit(unsigned long nr, volatile void *ptr)
+__clear_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -288,7 +288,7 @@
 }
 
 static inline void 
-__constant_clear_bit(const unsigned long nr, volatile void *ptr)
+__constant_clear_bit(const unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -337,7 +337,7 @@
 /* 
  * fast, non-SMP change_bit routine 
  */
-static inline void __change_bit(unsigned long nr, volatile void *ptr)
+static inline void __change_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
@@ -349,7 +349,7 @@
 }
 
 static inline void 
-__constant_change_bit(const unsigned long nr, volatile void *ptr) 
+__constant_change_bit(const unsigned long nr, volatile unsigned long *ptr) 
 {
 	unsigned long addr;
 
@@ -399,7 +399,7 @@
  * fast, non-SMP test_and_set_bit routine
  */
 static inline int
-test_and_set_bit_simple(unsigned long nr, volatile void *ptr)
+test_and_set_bit_simple(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -418,7 +418,7 @@
  * fast, non-SMP test_and_clear_bit routine
  */
 static inline int
-test_and_clear_bit_simple(unsigned long nr, volatile void *ptr)
+test_and_clear_bit_simple(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -437,7 +437,7 @@
  * fast, non-SMP test_and_change_bit routine
  */
 static inline int
-test_and_change_bit_simple(unsigned long nr, volatile void *ptr)
+test_and_change_bit_simple(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -473,7 +473,7 @@
  * This routine doesn't need to be atomic.
  */
 
-static inline int __test_bit(unsigned long nr, volatile void *ptr)
+static inline int __test_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
@@ -484,7 +484,7 @@
 }
 
 static inline int 
-__constant_test_bit(unsigned long nr, volatile void *addr) {
+__constant_test_bit(unsigned long nr, volatile unsigned long *addr) {
     return (((volatile char *) addr)[(nr>>3)^7] & (1<<(nr&7))) != 0;
 }
 
@@ -497,7 +497,7 @@
  * Find-bit routines..
  */
 static inline unsigned long
-find_first_zero_bit(void * addr, unsigned long size)
+find_first_zero_bit(unsigned long * addr, unsigned long size)
 {
         unsigned long res, cmp, count;
 
@@ -539,7 +539,7 @@
 }
 
 static inline unsigned long
-find_first_bit(void * addr, unsigned long size)
+find_first_bit(unsigned long * addr, unsigned long size)
 {
         unsigned long res, cmp, count;
 
@@ -581,7 +581,7 @@
 }
 
 static inline unsigned long
-find_next_zero_bit (void * addr, unsigned long size, unsigned long offset)
+find_next_zero_bit (unsigned long * addr, unsigned long size, unsigned long offset)
 {
         unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
         unsigned long bitvec, reg;
@@ -625,7 +625,7 @@
 }
 
 static inline unsigned long
-find_next_bit (void * addr, unsigned long size, unsigned long offset)
+find_next_bit (unsigned long * addr, unsigned long size, unsigned long offset)
 {
         unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
         unsigned long bitvec, reg;
@@ -744,7 +744,7 @@
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-extern int inline ffs (int x)
+extern inline int ffs (int x)
 {
         int r = 1;
 
@@ -836,9 +836,13 @@
  *    23 22 21 20 19 18 17 16 31 30 29 28 27 26 25 24
  */
 
-#define ext2_set_bit(nr, addr)       test_and_set_bit((nr)^56, addr)
-#define ext2_clear_bit(nr, addr)     test_and_clear_bit((nr)^56, addr)
-#define ext2_test_bit(nr, addr)      test_bit((nr)^56, addr)
+#define ext2_set_bit(nr, addr)       \
+	test_and_set_bit((nr)^56, (unsigned long *)addr)
+#define ext2_clear_bit(nr, addr)     \
+	test_and_clear_bit((nr)^56, (unsigned long *)addr)
+#define ext2_test_bit(nr, addr)      \
+	test_bit((nr)^56, (unsigned long *)addr)
+
 static inline unsigned long
 ext2_find_first_zero_bit(void *vaddr, unsigned long size)
 {
diff -urN linux-2.5.51/include/asm-s390x/posix_types.h linux-2.5.51-s390/include/asm-s390x/posix_types.h
--- linux-2.5.51/include/asm-s390x/posix_types.h	Tue Dec 10 03:46:25 2002
+++ linux-2.5.51-s390/include/asm-s390x/posix_types.h	Thu Dec 12 18:03:36 2002
@@ -58,13 +58,13 @@
 #endif
 
 #undef  __FD_SET
-#define __FD_SET(fd,fdsetp)  set_bit(fd,fdsetp)
+#define __FD_SET(fd,fdsetp)  set_bit(fd,fdsetp->fds_bits)
 
 #undef  __FD_CLR
-#define __FD_CLR(fd,fdsetp)  clear_bit(fd,fdsetp)
+#define __FD_CLR(fd,fdsetp)  clear_bit(fd,fdsetp->fds_bits)
 
 #undef  __FD_ISSET
-#define __FD_ISSET(fd,fdsetp)  test_bit(fd,fdsetp)
+#define __FD_ISSET(fd,fdsetp)  test_bit(fd,fdsetp->fds_bits)
 
 #undef  __FD_ZERO
 #define __FD_ZERO(fdsetp) (memset (fdsetp, 0, sizeof(*(fd_set *)fdsetp)))
diff -urN linux-2.5.51/include/asm-s390x/rwsem.h linux-2.5.51-s390/include/asm-s390x/rwsem.h
--- linux-2.5.51/include/asm-s390x/rwsem.h	Tue Dec 10 03:45:52 2002
+++ linux-2.5.51-s390/include/asm-s390x/rwsem.h	Thu Dec 12 18:03:36 2002
@@ -228,7 +228,7 @@
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "m" (tmp)
 		: "cc", "memory" );
-	if (new > 1) // FIXME: is this correct ?!?
+	if (new > 1)
 		rwsem_downgrade_wake(sem);
 }
 

