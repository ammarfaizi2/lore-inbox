Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTDNSOW (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263630AbTDNSOV (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:14:21 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:3016 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id S263614AbTDNRpm (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:42 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (15/16): s390/s390x unification - part 6.
Date: Mon, 14 Apr 2003 19:54:14 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304141954.14854.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge s390x and s390 to one architecture.

diffstat:
 bitops.h      |  732 +++++++++++++++++++++++++++++++++++++++++++---------------
 byteorder.h   |   55 ++++
 ccwdev.h      |   10 
 checksum.h    |   73 +++++
 compat.h      |  122 +++++++++
 div64.h       |   13 -
 ebcdic.h      |    4 
 elf.h         |   27 ++
 fcntl.h       |    6 
 gdb-stub.h    |   22 -
 idals.h       |   14 -
 io.h          |    9 
 ipc.h         |    1 
 ipcbuf.h      |    2 
 lowcore.h     |  144 ++++++++++-
 mmu_context.h |    8 
 module.h      |    5 
 msgbuf.h      |    6 
 page.h        |   69 +++++
 pgalloc.h     |   53 ++++
 pgtable.h     |  249 +++++++++++++++++--
 21 files changed, 1370 insertions(+), 254 deletions(-)

diff -urN linux-2.5.67/include/asm-s390/bitops.h linux-2.5.67-s390/include/asm-s390/bitops.h
--- linux-2.5.67/include/asm-s390/bitops.h	Mon Apr 14 19:11:36 2003
+++ linux-2.5.67-s390/include/asm-s390/bitops.h	Mon Apr 14 19:11:58 2003
@@ -15,6 +15,7 @@
 #include <linux/config.h>
 
 /*
+ * 32 bit bitops format:
  * bit 0 is the LSB of *addr; bit 31 is the MSB of *addr;
  * bit 32 is the LSB of *(addr+4). That combined with the
  * big endian byte order on S390 give the following bit
@@ -28,6 +29,25 @@
  * in the architecture independent code bits operations
  * of the form "flags |= (1 << bitnr)" are used INTERMIXED
  * with operation of the form "set_bit(bitnr, flags)".
+ *
+ * 64 bit bitops format:
+ * bit 0 is the LSB of *addr; bit 63 is the MSB of *addr;
+ * bit 64 is the LSB of *(addr+8). That combined with the
+ * big endian byte order on S390 give the following bit
+ * order in memory:
+ *    3f 3e 3d 3c 3b 3a 39 38 37 36 35 34 33 32 31 30
+ *    2f 2e 2d 2c 2b 2a 29 28 27 26 25 24 23 22 21 20
+ *    1f 1e 1d 1c 1b 1a 19 18 17 16 15 14 13 12 11 10
+ *    0f 0e 0d 0c 0b 0a 09 08 07 06 05 04 03 02 01 00
+ * after that follows the next long with bit numbers
+ *    7f 7e 7d 7c 7b 7a 79 78 77 76 75 74 73 72 71 70
+ *    6f 6e 6d 6c 6b 6a 69 68 67 66 65 64 63 62 61 60
+ *    5f 5e 5d 5c 5b 5a 59 58 57 56 55 54 53 52 51 50
+ *    4f 4e 4d 4c 4b 4a 49 48 47 46 45 44 43 42 41 40
+ * The reason for this bit ordering is the fact that
+ * in the architecture independent code bits operations
+ * of the form "flags |= (1 << bitnr)" are used INTERMIXED
+ * with operation of the form "set_bit(bitnr, flags)".
  */
 
 /* set ALIGN_CS to 1 if the SMP safe bit operations should
@@ -49,106 +69,126 @@
 extern const char _zb_findmap[];
 extern const char _sb_findmap[];
 
+#ifndef __s390x__
+
+#define __BITOPS_ALIGN		3
+#define __BITOPS_WORDSIZE	32
+#define __BITOPS_OR		"or"
+#define __BITOPS_AND		"nr"
+#define __BITOPS_XOR		"xr"
+
+#define __BITOPS_LOOP(__old, __new, __addr, __val, __op_string)		\
+	__asm__ __volatile__("   l   %0,0(%4)\n"			\
+			     "0: lr  %1,%0\n"				\
+			     __op_string "  %1,%3\n"			\
+			     "   cs  %0,%1,0(%4)\n"			\
+			     "   jl  0b"				\
+			     : "=&d" (__old), "=&d" (__new),	       	\
+			       "=m" (*(unsigned long *) __addr)		\
+			     : "d" (__val), "a" (__addr),		\
+			       "m" (*(unsigned long *) __addr) : "cc" );
+
+#else /* __s390x__ */
+
+#define __BITOPS_ALIGN		7
+#define __BITOPS_WORDSIZE	64
+#define __BITOPS_OR		"ogr"
+#define __BITOPS_AND		"ngr"
+#define __BITOPS_XOR		"xgr"
+
+#define __BITOPS_LOOP(__old, __new, __addr, __val, __op_string)		\
+	__asm__ __volatile__("   lg  %0,0(%4)\n"			\
+			     "0: lgr %1,%0\n"				\
+			     __op_string "  %1,%3\n"			\
+			     "   csg %0,%1,0(%4)\n"			\
+			     "   jl  0b"				\
+			     : "=&d" (__old), "=&d" (__new),	       	\
+			       "=m" (*(unsigned long *) __addr)		\
+			     : "d" (__val), "a" (__addr),		\
+			       "m" (*(unsigned long *) __addr) : "cc" );
+
+#endif /* __s390x__ */
+
 #ifdef CONFIG_SMP
 /*
  * SMP safe set_bit routine based on compare and swap (CS)
  */
-static inline void set_bit_cs(int nr, volatile unsigned long *ptr)
+static inline void set_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	nr += (addr & 3) << 3;		/* add alignment to bit number */
-	addr ^= addr & 3;		/* align address to 4 */
+	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
+	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
 #endif
-	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
-	mask = 1UL << (nr & 31);	/* make OR mask */
-	asm volatile(
-		"   l   %0,0(%4)\n"
-		"0: lr  %1,%0\n"
-		"   or  %1,%3\n"
-		"   cs  %0,%1,0(%4)\n"
-		"   jl  0b"
-		: "=&d" (old), "=&d" (new), "+m" (*(unsigned int *) addr)
-		: "d" (mask), "a" (addr) 
-		: "cc" );
+	/* calculate address for CS */
+	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
+	/* make OR mask */
+	mask = 1UL << (nr & (__BITOPS_WORDSIZE - 1));
+	/* Do the atomic update. */
+	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_OR);
 }
 
 /*
  * SMP safe clear_bit routine based on compare and swap (CS)
  */
-static inline void clear_bit_cs(int nr, volatile unsigned long *ptr)
+static inline void clear_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	nr += (addr & 3) << 3;		/* add alignment to bit number */
-	addr ^= addr & 3;		/* align address to 4 */
+	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
+	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
 #endif
-	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
-	mask = ~(1UL << (nr & 31));	/* make AND mask */
-	asm volatile(
-		"   l   %0,0(%4)\n"
-		"0: lr  %1,%0\n"
-		"   nr  %1,%3\n"
-		"   cs  %0,%1,0(%4)\n"
-		"   jl  0b"
-		: "=&d" (old), "=&d" (new), "+m" (*(unsigned int *) addr)
-		: "d" (mask), "a" (addr) 
-		: "cc" );
+	/* calculate address for CS */
+	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
+	/* make AND mask */
+	mask = ~(1UL << (nr & (__BITOPS_WORDSIZE - 1)));
+	/* Do the atomic update. */
+	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_AND);
 }
 
 /*
  * SMP safe change_bit routine based on compare and swap (CS)
  */
-static inline void change_bit_cs(int nr, volatile unsigned long *ptr)
+static inline void change_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	nr += (addr & 3) << 3;		/* add alignment to bit number */
-	addr ^= addr & 3;		/* align address to 4 */
+	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
+	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
 #endif
-	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
-	mask = 1UL << (nr & 31);	/* make XOR mask */
-	asm volatile(
-		"   l   %0,0(%4)\n"
-		"0: lr  %1,%0\n"
-		"   xr  %1,%3\n"
-		"   cs  %0,%1,0(%4)\n"
-		"   jl  0b"
-		: "=&d" (old), "=&d" (new), "+m" (*(unsigned int *) addr)
-		: "d" (mask), "a" (addr) 
-		: "cc" );
+	/* calculate address for CS */
+	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
+	/* make XOR mask */
+	mask = 1UL << (nr & (__BITOPS_WORDSIZE - 1));
+	/* Do the atomic update. */
+	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_XOR);
 }
 
 /*
  * SMP safe test_and_set_bit routine based on compare and swap (CS)
  */
 static inline int
-test_and_set_bit_cs(int nr, volatile unsigned long *ptr)
+test_and_set_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	addr ^= addr & 3;		/* align address to 4 */
-	nr += (addr & 3) << 3;		/* add alignment to bit number */
+	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
+	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
 #endif
-	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
-	mask = 1UL << (nr & 31);	/* make OR/test mask */
-	asm volatile(
-		"   l   %0,0(%4)\n"
-		"0: lr  %1,%0\n"
-		"   or  %1,%3\n"
-		"   cs  %0,%1,0(%4)\n"
-		"   jl  0b"
-		: "=&d" (old), "=&d" (new), "+m" (*(unsigned int *) addr)
-		: "d" (mask), "a" (addr) 
-		: "cc" );
+	/* calculate address for CS */
+	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
+	/* make OR/test mask */
+	mask = 1UL << (nr & (__BITOPS_WORDSIZE - 1));
+	/* Do the atomic update. */
+	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_OR);
 	return (old & mask) != 0;
 }
 
@@ -156,26 +196,21 @@
  * SMP safe test_and_clear_bit routine based on compare and swap (CS)
  */
 static inline int
-test_and_clear_bit_cs(int nr, volatile unsigned long *ptr)
+test_and_clear_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	nr += (addr & 3) << 3;		/* add alignment to bit number */
-	addr ^= addr & 3;		/* align address to 4 */
+	nr += (addr & __BITOPS_ALIGN) << 3;    /* add alignment to bit number */
+	addr ^= addr & __BITOPS_ALIGN;	       /* align address to 8 */
 #endif
-	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
-	mask = ~(1UL << (nr & 31));	/* make AND mask */
-	asm volatile(
-		"   l   %0,0(%4)\n"
-		"0: lr  %1,%0\n"
-		"   nr  %1,%3\n"
-		"   cs  %0,%1,0(%4)\n"
-		"   jl  0b"
-		: "=&d" (old), "=&d" (new), "+m" (*(unsigned int *) addr)
-		: "d" (mask), "a" (addr) 
-		: "cc" );
+	/* calculate address for CS */
+	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
+	/* make AND/test mask */
+	mask = ~(1UL << (nr & (__BITOPS_WORDSIZE - 1)));
+	/* Do the atomic update. */
+	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_AND);
 	return (old ^ new) != 0;
 }
 
@@ -183,26 +218,21 @@
  * SMP safe test_and_change_bit routine based on compare and swap (CS) 
  */
 static inline int
-test_and_change_bit_cs(int nr, volatile unsigned long *ptr)
+test_and_change_bit_cs(unsigned long nr, volatile unsigned long *ptr)
 {
         unsigned long addr, old, new, mask;
 
 	addr = (unsigned long) ptr;
 #if ALIGN_CS == 1
-	nr += (addr & 3) << 3;		/* add alignment to bit number */
-	addr ^= addr & 3;		/* align address to 4 */
+	nr += (addr & __BITOPS_ALIGN) << 3;  /* add alignment to bit number */
+	addr ^= addr & __BITOPS_ALIGN;	     /* align address to 8 */
 #endif
-	addr += (nr ^ (nr & 31)) >> 3;	/* calculate address for CS */
-	mask = 1UL << (nr & 31);	/* make XOR mask */
-	asm volatile(
-		"   l   %0,0(%4)\n"
-		"0: lr  %1,%0\n"
-		"   xr  %1,%3\n"
-		"   cs  %0,%1,0(%4)\n"
-		"   jl  0b"
-		: "=&d" (old), "=&d" (new), "+m" (*(unsigned int *) addr)
-		: "d" (mask), "a" (addr) 
-		: "cc" );
+	/* calculate address for CS */
+	addr += (nr ^ (nr & (__BITOPS_WORDSIZE - 1))) >> 3;
+	/* make XOR/test mask */
+	mask = 1UL << (nr & (__BITOPS_WORDSIZE - 1));
+	/* Do the atomic update. */
+	__BITOPS_LOOP(old, new, addr, mask, __BITOPS_XOR);
 	return (old & mask) != 0;
 }
 #endif /* CONFIG_SMP */
@@ -210,55 +240,55 @@
 /*
  * fast, non-SMP set_bit routine
  */
-static inline void __set_bit(int nr, volatile unsigned long *ptr)
+static inline void __set_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
-	addr = (unsigned long) ptr + ((nr ^ 24) >> 3);
+	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
         asm volatile("oc 0(1,%1),0(%2)"
-		     : "+m" (*(char *) addr)
-		     : "a" (addr), "a" (_oi_bitmap + (nr & 7))
-		     : "cc" );
+		     : "=m" (*(char *) addr)
+		     : "a" (addr), "a" (_oi_bitmap + (nr & 7)),
+		       "m" (*(char *) addr) : "cc" );
 }
 
 static inline void 
-__constant_set_bit(const int nr, volatile unsigned long *ptr)
+__constant_set_bit(const unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
-	addr = ((unsigned long) ptr) + ((nr >> 3) ^ 3);
+	addr = ((unsigned long) ptr) + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	switch (nr&7) {
 	case 0:
-		asm volatile ("oi 0(%1),0x01"
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("oi 0(%1),0x01" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 1:
-		asm volatile ("oi 0(%1),0x02"
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("oi 0(%1),0x02" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 2:
-		asm volatile ("oi 0(%1),0x04" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("oi 0(%1),0x04" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 3:
-		asm volatile ("oi 0(%1),0x08" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("oi 0(%1),0x08" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 4:
-		asm volatile ("oi 0(%1),0x10" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("oi 0(%1),0x10" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 5:
-		asm volatile ("oi 0(%1),0x20" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("oi 0(%1),0x20" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 6:
-		asm volatile ("oi 0(%1),0x40" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("oi 0(%1),0x40" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 7:
-		asm volatile ("oi 0(%1),0x80" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("oi 0(%1),0x80" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	}
 }
@@ -272,55 +302,55 @@
  * fast, non-SMP clear_bit routine
  */
 static inline void 
-__clear_bit(int nr, volatile unsigned long *ptr)
+__clear_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
-	addr = (unsigned long) ptr + ((nr ^ 24) >> 3);
+	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
         asm volatile("nc 0(1,%1),0(%2)"
-		     : "+m" (*(char *) addr)
-		     : "a" (addr), "a" (_ni_bitmap + (nr & 7))
-		     : "cc" );
+		     : "=m" (*(char *) addr)
+		     : "a" (addr), "a" (_ni_bitmap + (nr & 7)),
+		       "m" (*(char *) addr) : "cc" );
 }
 
 static inline void 
-__constant_clear_bit(const int nr, volatile unsigned long *ptr)
+__constant_clear_bit(const unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
-	addr = ((unsigned long) ptr) + ((nr >> 3) ^ 3);
+	addr = ((unsigned long) ptr) + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	switch (nr&7) {
 	case 0:
-		asm volatile ("ni 0(%1),0xFE"
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("ni 0(%1),0xFE" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 1:
-		asm volatile ("ni 0(%1),0xFD" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("ni 0(%1),0xFD": "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 2:
-		asm volatile ("ni 0(%1),0xFB" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("ni 0(%1),0xFB" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 3:
-		asm volatile ("ni 0(%1),0xF7" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("ni 0(%1),0xF7" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 4:
-		asm volatile ("ni 0(%1),0xEF" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("ni 0(%1),0xEF" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 5:
-		asm volatile ("ni 0(%1),0xDF" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("ni 0(%1),0xDF" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 6:
-		asm volatile ("ni 0(%1),0xBF" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("ni 0(%1),0xBF" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 7:
-		asm volatile ("ni 0(%1),0x7F" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("ni 0(%1),0x7F" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	}
 }
@@ -333,55 +363,55 @@
 /* 
  * fast, non-SMP change_bit routine 
  */
-static inline void __change_bit(int nr, volatile unsigned long *ptr)
+static inline void __change_bit(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 
-	addr = (unsigned long) ptr + ((nr ^ 24) >> 3);
+	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
         asm volatile("xc 0(1,%1),0(%2)"
-		     : "+m" (*(char *) addr)
-		     : "a" (addr), "a" (_oi_bitmap + (nr & 7))
-		     : "cc" );
+		     :  "=m" (*(char *) addr)
+		     : "a" (addr), "a" (_oi_bitmap + (nr & 7)),
+		       "m" (*(char *) addr) : "cc" );
 }
 
 static inline void 
-__constant_change_bit(const int nr, volatile unsigned long *ptr) 
+__constant_change_bit(const unsigned long nr, volatile unsigned long *ptr) 
 {
 	unsigned long addr;
 
-	addr = ((unsigned long) ptr) + ((nr >> 3) ^ 3);
+	addr = ((unsigned long) ptr) + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	switch (nr&7) {
 	case 0:
-		asm volatile ("xi 0(%1),0x01" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("xi 0(%1),0x01" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 1:
-		asm volatile ("xi 0(%1),0x02" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("xi 0(%1),0x02" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 2:
-		asm volatile ("xi 0(%1),0x04" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("xi 0(%1),0x04" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 3:
-		asm volatile ("xi 0(%1),0x08" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("xi 0(%1),0x08" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 4:
-		asm volatile ("xi 0(%1),0x10" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("xi 0(%1),0x10" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 5:
-		asm volatile ("xi 0(%1),0x20" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("xi 0(%1),0x20" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 6:
-		asm volatile ("xi 0(%1),0x40" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("xi 0(%1),0x40" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	case 7:
-		asm volatile ("xi 0(%1),0x80" 
-			      : "+m" (*(char *) addr) : "a" (addr) : "cc" );
+		asm volatile ("xi 0(%1),0x80" : "=m" (*(char *) addr)
+			      : "a" (addr), "m" (*(char *) addr) : "cc" );
 		break;
 	}
 }
@@ -395,17 +425,17 @@
  * fast, non-SMP test_and_set_bit routine
  */
 static inline int
-test_and_set_bit_simple(int nr, volatile unsigned long *ptr)
+test_and_set_bit_simple(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
 
-	addr = (unsigned long) ptr + ((nr ^ 24) >> 3);
+	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	ch = *(unsigned char *) addr;
         asm volatile("oc 0(1,%1),0(%2)"
-		     : "+m" (*(char *) addr)
-		     : "a" (addr), "a" (_oi_bitmap + (nr & 7))
-		     : "cc" );
+		     : "=m" (*(char *) addr)
+		     : "a" (addr), "a" (_oi_bitmap + (nr & 7)),
+		       "m" (*(char *) addr) : "cc" );
 	return (ch >> (nr & 7)) & 1;
 }
 #define __test_and_set_bit(X,Y)		test_and_set_bit_simple(X,Y)
@@ -414,17 +444,17 @@
  * fast, non-SMP test_and_clear_bit routine
  */
 static inline int
-test_and_clear_bit_simple(int nr, volatile unsigned long *ptr)
+test_and_clear_bit_simple(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
 
-	addr = (unsigned long) ptr + ((nr ^ 24) >> 3);
+	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	ch = *(unsigned char *) addr;
         asm volatile("nc 0(1,%1),0(%2)"
-		     : "+m" (*(char *) addr)
-		     : "a" (addr), "a" (_ni_bitmap + (nr & 7))
-		     : "cc" );
+		     : "=m" (*(char *) addr)
+		     : "a" (addr), "a" (_ni_bitmap + (nr & 7)),
+		       "m" (*(char *) addr) : "cc" );
 	return (ch >> (nr & 7)) & 1;
 }
 #define __test_and_clear_bit(X,Y)	test_and_clear_bit_simple(X,Y)
@@ -433,17 +463,17 @@
  * fast, non-SMP test_and_change_bit routine
  */
 static inline int
-test_and_change_bit_simple(int nr, volatile unsigned long *ptr)
+test_and_change_bit_simple(unsigned long nr, volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
 
-	addr = (unsigned long) ptr + ((nr ^ 24) >> 3);
+	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	ch = *(unsigned char *) addr;
         asm volatile("xc 0(1,%1),0(%2)"
-		     : "+m" (*(char *) addr)
-		     : "a" (addr), "a" (_oi_bitmap + (nr & 7))
-		     : "cc" );
+		     : "=m" (*(char *) addr)
+		     : "a" (addr), "a" (_oi_bitmap + (nr & 7)),
+		       "m" (*(char *) addr) : "cc" );
 	return (ch >> (nr & 7)) & 1;
 }
 #define __test_and_change_bit(X,Y)	test_and_change_bit_simple(X,Y)
@@ -469,19 +499,20 @@
  * This routine doesn't need to be atomic.
  */
 
-static inline int __test_bit(int nr, const volatile unsigned long *ptr)
+static inline int __test_bit(unsigned long nr, const volatile unsigned long *ptr)
 {
 	unsigned long addr;
 	unsigned char ch;
 
-	addr = (unsigned long) ptr + ((nr ^ 24) >> 3);
+	addr = (unsigned long) ptr + ((nr ^ (__BITOPS_WORDSIZE - 8)) >> 3);
 	ch = *(unsigned char *) addr;
 	return (ch >> (nr & 7)) & 1;
 }
 
 static inline int 
-__constant_test_bit(int nr, const volatile unsigned long * addr) {
-    return (((volatile char *) addr)[(nr>>3)^3] & (1<<(nr&7))) != 0;
+__constant_test_bit(unsigned long nr, const volatile unsigned long *addr) {
+    return (((volatile char *) addr)
+	    [(nr^(__BITOPS_WORDSIZE-8))>>3] & (1<<(nr&7)));
 }
 
 #define test_bit(nr,addr) \
@@ -489,6 +520,8 @@
  __constant_test_bit((nr),(addr)) : \
  __test_bit((nr),(addr)) )
 
+#ifndef __s390x__
+
 /*
  * Find-bit routines..
  */
@@ -701,6 +734,245 @@
         return result;
 }
 
+#else /* __s390x__ */
+
+/*
+ * Find-bit routines..
+ */
+static inline unsigned long
+find_first_zero_bit(unsigned long * addr, unsigned long size)
+{
+        unsigned long res, cmp, count;
+
+        if (!size)
+                return 0;
+        __asm__("   lghi  %1,-1\n"
+                "   lgr   %2,%3\n"
+                "   slgr  %0,%0\n"
+                "   aghi  %2,63\n"
+                "   srlg  %2,%2,6\n"
+                "0: cg    %1,0(%0,%4)\n"
+                "   jne   1f\n"
+                "   aghi  %0,8\n"
+                "   brct  %2,0b\n"
+                "   lgr   %0,%3\n"
+                "   j     5f\n"
+                "1: lg    %2,0(%0,%4)\n"
+                "   sllg  %0,%0,3\n"
+                "   clr   %2,%1\n"
+		"   jne   2f\n"
+		"   aghi  %0,32\n"
+                "   srlg  %2,%2,32\n"
+		"2: lghi  %1,0xff\n"
+                "   tmll  %2,0xffff\n"
+                "   jno   3f\n"
+                "   aghi  %0,16\n"
+                "   srl   %2,16\n"
+                "3: tmll  %2,0x00ff\n"
+                "   jno   4f\n"
+                "   aghi  %0,8\n"
+                "   srl   %2,8\n"
+                "4: ngr   %2,%1\n"
+                "   ic    %2,0(%2,%5)\n"
+                "   algr  %0,%2\n"
+                "5:"
+                : "=&a" (res), "=&d" (cmp), "=&a" (count)
+		: "a" (size), "a" (addr), "a" (&_zb_findmap) : "cc" );
+        return (res < size) ? res : size;
+}
+
+static inline unsigned long
+find_first_bit(unsigned long * addr, unsigned long size)
+{
+        unsigned long res, cmp, count;
+
+        if (!size)
+                return 0;
+        __asm__("   slgr  %1,%1\n"
+                "   lgr   %2,%3\n"
+                "   slgr  %0,%0\n"
+                "   aghi  %2,63\n"
+                "   srlg  %2,%2,6\n"
+                "0: cg    %1,0(%0,%4)\n"
+                "   jne   1f\n"
+                "   aghi  %0,8\n"
+                "   brct  %2,0b\n"
+                "   lgr   %0,%3\n"
+                "   j     5f\n"
+                "1: lg    %2,0(%0,%4)\n"
+                "   sllg  %0,%0,3\n"
+                "   clr   %2,%1\n"
+		"   jne   2f\n"
+		"   aghi  %0,32\n"
+                "   srlg  %2,%2,32\n"
+		"2: lghi  %1,0xff\n"
+                "   tmll  %2,0xffff\n"
+                "   jnz   3f\n"
+                "   aghi  %0,16\n"
+                "   srl   %2,16\n"
+                "3: tmll  %2,0x00ff\n"
+                "   jnz   4f\n"
+                "   aghi  %0,8\n"
+                "   srl   %2,8\n"
+                "4: ngr   %2,%1\n"
+                "   ic    %2,0(%2,%5)\n"
+                "   algr  %0,%2\n"
+                "5:"
+                : "=&a" (res), "=&d" (cmp), "=&a" (count)
+		: "a" (size), "a" (addr), "a" (&_sb_findmap) : "cc" );
+        return (res < size) ? res : size;
+}
+
+static inline unsigned long
+find_next_zero_bit (unsigned long * addr, unsigned long size, unsigned long offset)
+{
+        unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
+        unsigned long bitvec, reg;
+        unsigned long set, bit = offset & 63, res;
+
+        if (bit) {
+                /*
+                 * Look for zero in first word
+                 */
+                bitvec = (*p) >> bit;
+                __asm__("   lhi  %2,-1\n"
+                        "   slgr %0,%0\n"
+                        "   clr  %1,%2\n"
+                        "   jne  0f\n"
+                        "   aghi %0,32\n"
+                        "   srlg %1,%1,32\n"
+			"0: lghi %2,0xff\n"
+                        "   tmll %1,0xffff\n"
+                        "   jno  1f\n"
+                        "   aghi %0,16\n"
+                        "   srlg %1,%1,16\n"
+                        "1: tmll %1,0x00ff\n"
+                        "   jno  2f\n"
+                        "   aghi %0,8\n"
+                        "   srlg %1,%1,8\n"
+                        "2: ngr  %1,%2\n"
+                        "   ic   %1,0(%1,%3)\n"
+                        "   algr %0,%1"
+                        : "=&d" (set), "+a" (bitvec), "=&d" (reg)
+                        : "a" (&_zb_findmap) : "cc" );
+                if (set < (64 - bit))
+                        return set + offset;
+                offset += 64 - bit;
+                p++;
+        }
+        /*
+         * No zero yet, search remaining full words for a zero
+         */
+        res = find_first_zero_bit (p, size - 64 * (p - (unsigned long *) addr));
+        return (offset + res);
+}
+
+static inline unsigned long
+find_next_bit (unsigned long * addr, unsigned long size, unsigned long offset)
+{
+        unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
+        unsigned long bitvec, reg;
+        unsigned long set, bit = offset & 63, res;
+
+        if (bit) {
+                /*
+                 * Look for zero in first word
+                 */
+                bitvec = (*p) >> bit;
+                __asm__("   slgr %0,%0\n"
+                        "   ltr  %1,%1\n"
+                        "   jnz  0f\n"
+                        "   aghi %0,32\n"
+                        "   srlg %1,%1,32\n"
+			"0: lghi %2,0xff\n"
+                        "   tmll %1,0xffff\n"
+                        "   jnz  1f\n"
+                        "   aghi %0,16\n"
+                        "   srlg %1,%1,16\n"
+                        "1: tmll %1,0x00ff\n"
+                        "   jnz  2f\n"
+                        "   aghi %0,8\n"
+                        "   srlg %1,%1,8\n"
+                        "2: ngr  %1,%2\n"
+                        "   ic   %1,0(%1,%3)\n"
+                        "   algr %0,%1"
+                        : "=&d" (set), "+a" (bitvec), "=&d" (reg)
+                        : "a" (&_sb_findmap) : "cc" );
+                if (set < (64 - bit))
+                        return set + offset;
+                offset += 64 - bit;
+                p++;
+        }
+        /*
+         * No set bit yet, search remaining full words for a bit
+         */
+        res = find_first_bit (p, size - 64 * (p - (unsigned long *) addr));
+        return (offset + res);
+}
+
+/*
+ * ffz = Find First Zero in word. Undefined if no zero exists,
+ * so code should check against ~0UL first..
+ */
+static inline unsigned long ffz(unsigned long word)
+{
+	unsigned long reg, result;
+
+        __asm__("   lhi  %2,-1\n"
+                "   slgr %0,%0\n"
+                "   clr  %1,%2\n"
+                "   jne  0f\n"
+                "   aghi %0,32\n"
+                "   srlg %1,%1,32\n"
+                "0: lghi %2,0xff\n"
+                "   tmll %1,0xffff\n"
+                "   jno  1f\n"
+                "   aghi %0,16\n"
+                "   srlg %1,%1,16\n"
+                "1: tmll %1,0x00ff\n"
+                "   jno  2f\n"
+                "   aghi %0,8\n"
+                "   srlg %1,%1,8\n"
+                "2: ngr  %1,%2\n"
+                "   ic   %1,0(%1,%3)\n"
+                "   algr %0,%1"
+                : "=&d" (result), "+a" (word), "=&d" (reg)
+                : "a" (&_zb_findmap) : "cc" );
+        return result;
+}
+
+/*
+ * __ffs = find first bit in word. Undefined if no bit exists,
+ * so code should check against 0UL first..
+ */
+static inline unsigned long __ffs (unsigned long word)
+{
+        unsigned long reg, result;
+
+        __asm__("   slgr %0,%0\n"
+                "   ltr  %1,%1\n"
+                "   jnz  0f\n"
+                "   aghi %0,32\n"
+                "   srlg %1,%1,32\n"
+                "0: lghi %2,0xff\n"
+                "   tmll %1,0xffff\n"
+                "   jnz  1f\n"
+                "   aghi %0,16\n"
+                "   srlg %1,%1,16\n"
+                "1: tmll %1,0x00ff\n"
+                "   jnz  2f\n"
+                "   aghi %0,8\n"
+                "   srlg %1,%1,8\n"
+                "2: ngr  %1,%2\n"
+                "   ic   %1,0(%1,%3)\n"
+                "   algr %0,%1"
+                : "=&d" (result), "+a" (word), "=&d" (reg)
+                : "a" (&_sb_findmap) : "cc" );
+        return result;
+}
+
+#endif /* __s390x__ */
+
 /*
  * Every architecture must define this function. It's the fastest
  * way of searching a 140-bit bitmap where the first 100 bits are
@@ -717,7 +989,6 @@
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-
 extern inline int ffs (int x)
 {
         int r = 1;
@@ -785,7 +1056,14 @@
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
  */
-
+#define hweight64(x)						\
+({								\
+	unsigned long __x = (x);				\
+	unsigned int __w;					\
+	__w = generic_hweight32((unsigned int) __x);		\
+	__w += generic_hweight32((unsigned int) (__x>>32));	\
+	__w;							\
+})
 #define hweight32(x) generic_hweight32(x)
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
@@ -804,15 +1082,17 @@
  */
 
 #define ext2_set_bit(nr, addr)       \
-	test_and_set_bit((nr)^24, (unsigned long *)addr)
+	test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_set_bit_atomic(lock, nr, addr)       \
-	        test_and_set_bit((nr)^24, (unsigned long *)addr)
+	test_and_set_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_clear_bit(nr, addr)     \
-	test_and_clear_bit((nr)^24, (unsigned long *)addr)
+	test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_clear_bit_atomic(lock, nr, addr)     \
-	        test_and_clear_bit((nr)^24, (unsigned long *)addr)
+	test_and_clear_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
 #define ext2_test_bit(nr, addr)      \
-	test_bit((nr)^24, (unsigned long *)addr)
+	test_bit((nr)^(__BITOPS_WORDSIZE - 8), (unsigned long *)addr)
+
+#ifndef __s390x__
 
 static inline int 
 ext2_find_first_zero_bit(void *vaddr, unsigned size)
@@ -897,6 +1177,100 @@
         return (p - addr) * 32 + res;
 }
 
+#else /* __s390x__ */
+
+static inline unsigned long
+ext2_find_first_zero_bit(void *vaddr, unsigned long size)
+{
+        unsigned long res, cmp, count;
+
+        if (!size)
+                return 0;
+        __asm__("   lghi  %1,-1\n"
+                "   lgr   %2,%3\n"
+                "   aghi  %2,63\n"
+                "   srlg  %2,%2,6\n"
+                "   slgr  %0,%0\n"
+                "0: clg   %1,0(%0,%4)\n"
+                "   jne   1f\n"
+                "   aghi  %0,8\n"
+                "   brct  %2,0b\n"
+                "   lgr   %0,%3\n"
+                "   j     5f\n"
+                "1: cl    %1,0(%0,%4)\n"
+		"   jne   2f\n"
+		"   aghi  %0,4\n"
+		"2: l     %2,0(%0,%4)\n"
+                "   sllg  %0,%0,3\n"
+                "   aghi  %0,24\n"
+                "   lghi  %1,0xff\n"
+                "   tmlh  %2,0xffff\n"
+                "   jo    3f\n"
+                "   aghi  %0,-16\n"
+                "   srl   %2,16\n"
+                "3: tmll  %2,0xff00\n"
+                "   jo    4f\n"
+                "   aghi  %0,-8\n"
+                "   srl   %2,8\n"
+                "4: ngr   %2,%1\n"
+                "   ic    %2,0(%2,%5)\n"
+                "   algr  %0,%2\n"
+                "5:"
+                : "=&a" (res), "=&d" (cmp), "=&a" (count)
+		: "a" (size), "a" (vaddr), "a" (&_zb_findmap) : "cc" );
+        return (res < size) ? res : size;
+}
+
+static inline unsigned long
+ext2_find_next_zero_bit(void *vaddr, unsigned long size, unsigned long offset)
+{
+        unsigned long *addr = vaddr;
+        unsigned long *p = addr + (offset >> 6);
+        unsigned long word, reg;
+        unsigned long bit = offset & 63UL, res;
+
+        if (offset >= size)
+                return size;
+
+        if (bit) {
+                __asm__("   lrvg %0,%1" /* load reversed, neat instruction */
+                        : "=a" (word) : "m" (*p) );
+                word >>= bit;
+                res = bit;
+                /* Look for zero in first 8 byte word */
+                __asm__("   lghi %2,0xff\n"
+			"   tmll %1,0xffff\n"
+			"   jno  2f\n"
+			"   ahi  %0,16\n"
+			"   srlg %1,%1,16\n"
+                	"0: tmll %1,0xffff\n"
+                        "   jno  2f\n"
+                        "   ahi  %0,16\n"
+                        "   srlg %1,%1,16\n"
+                        "1: tmll %1,0xffff\n"
+                        "   jno  2f\n"
+                        "   ahi  %0,16\n"
+                        "   srl  %1,16\n"
+                        "2: tmll %1,0x00ff\n"
+                	"   jno  3f\n"
+                	"   ahi  %0,8\n"
+                	"   srl  %1,8\n"
+                	"3: ngr  %1,%2\n"
+                	"   ic   %1,0(%1,%3)\n"
+                	"   alr  %0,%1"
+                	: "+&d" (res), "+a" (word), "=&d" (reg)
+                  	: "a" (&_zb_findmap) : "cc" );
+                if (res < 64)
+			return (p - addr)*64 + res;
+                p++;
+        }
+        /* No zero yet, search remaining full bytes for a zero */
+        res = ext2_find_first_zero_bit (p, size - 64 * (p - addr));
+        return (p - addr) * 64 + res;
+}
+
+#endif /* __s390x__ */
+
 /* Bitmap functions for the minix filesystem.  */
 /* FIXME !!! */
 #define minix_test_and_set_bit(nr,addr) test_and_set_bit(nr,addr)
diff -urN linux-2.5.67/include/asm-s390/byteorder.h linux-2.5.67-s390/include/asm-s390/byteorder.h
--- linux-2.5.67/include/asm-s390/byteorder.h	Mon Apr  7 19:33:01 2003
+++ linux-2.5.67-s390/include/asm-s390/byteorder.h	Mon Apr 14 19:11:58 2003
@@ -13,22 +13,63 @@
 
 #ifdef __GNUC__
 
+#ifdef __s390x__
+static __inline__ __const__ __u64 ___arch__swab64p(__u64 *x)
+{
+	__u64 result;
+
+	__asm__ __volatile__ (
+		"   lrvg %0,%1"
+		: "=d" (result) : "m" (*x) );
+	return result;
+}
+
+static __inline__ __const__ __u64 ___arch__swab64(__u64 x)
+{
+	__u64 result;
+
+	__asm__ __volatile__ (
+		"   lrvgr %0,%1"
+		: "=d" (result) : "d" (x) );
+	return result;
+}
+
+static __inline__ void ___arch__swab64s(__u64 *x)
+{
+	*x = ___arch__swab64p(x);
+}
+#endif /* __s390x__ */
+
 static __inline__ __const__ __u32 ___arch__swab32p(__u32 *x)
 {
 	__u32 result;
 	
 	__asm__ __volatile__ (
+#ifndef __s390x__
 		"        icm   %0,8,3(%1)\n"
 		"        icm   %0,4,2(%1)\n"
 		"        icm   %0,2,1(%1)\n"
 		"        ic    %0,0(%1)"
 		: "=&d" (result) : "a" (x) : "cc" );
+#else /* __s390x__ */
+		"   lrv  %0,%1"
+		: "=d" (result) : "m" (*x) );
+#endif /* __s390x__ */
 	return result;
 }
 
 static __inline__ __const__ __u32 ___arch__swab32(__u32 x)
 {
+#ifndef __s390x__
 	return ___arch__swab32p(&x);
+#else /* __s390x__ */
+	__u32 result;
+	
+	__asm__ __volatile__ (
+		"   lrvr  %0,%1"
+		: "=d" (result) : "d" (x) );
+	return result;
+#endif /* __s390x__ */
 }
 
 static __inline__ void ___arch__swab32s(__u32 *x)
@@ -41,9 +82,14 @@
 	__u16 result;
 	
 	__asm__ __volatile__ (
+#ifndef __s390x__
 		"        icm   %0,2,1(%1)\n"
 		"        ic    %0,0(%1)\n"
 		: "=&d" (result) : "a" (x) : "cc" );
+#else /* __s390x__ */
+		"   lrvh %0,%1"
+		: "=d" (result) : "m" (*x) );
+#endif /* __s390x__ */
 	return result;
 }
 
@@ -57,6 +103,11 @@
 	*x = ___arch__swab16p(x);
 }
 
+#ifdef __s390x__
+#define __arch__swab64(x) ___arch__swab64(x)
+#define __arch__swab64p(x) ___arch__swab64p(x)
+#define __arch__swab64s(x) ___arch__swab64s(x)
+#endif /* __s390x__ */
 #define __arch__swab32(x) ___arch__swab32(x)
 #define __arch__swab16(x) ___arch__swab16(x)
 #define __arch__swab32p(x) ___arch__swab32p(x)
@@ -64,10 +115,14 @@
 #define __arch__swab32s(x) ___arch__swab32s(x)
 #define __arch__swab16s(x) ___arch__swab16s(x)
 
+#ifndef __s390x__
 #if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
 #  define __BYTEORDER_HAS_U64__
 #  define __SWAB_64_THRU_32__
 #endif
+#else /* __s390x__ */
+#define __BYTEORDER_HAS_U64__
+#endif /* __s390x__ */
 
 #endif /* __GNUC__ */
 
diff -urN linux-2.5.67/include/asm-s390/ccwdev.h linux-2.5.67-s390/include/asm-s390/ccwdev.h
--- linux-2.5.67/include/asm-s390/ccwdev.h	Mon Apr  7 19:32:27 2003
+++ linux-2.5.67-s390/include/asm-s390/ccwdev.h	Mon Apr 14 19:11:58 2003
@@ -157,6 +157,16 @@
  */
 extern int ccw_device_start(struct ccw_device *, struct ccw1 *,
 			    unsigned long, __u8, unsigned long);
+/*
+ * ccw_device_start_timeout()
+ *
+ * This function notifies the device driver if the channel program has not
+ * completed during the specified time. If a timeout occurs, the channel
+ * program is terminated via xsch(), hsch() or csch().
+ */
+extern int ccw_device_start_timeout(struct ccw_device *, struct ccw1 *,
+				    unsigned long, __u8, unsigned long, int);
+
 extern int ccw_device_resume(struct ccw_device *);
 extern int ccw_device_halt(struct ccw_device *, unsigned long);
 extern int ccw_device_clear(struct ccw_device *, unsigned long);
diff -urN linux-2.5.67/include/asm-s390/checksum.h linux-2.5.67-s390/include/asm-s390/checksum.h
--- linux-2.5.67/include/asm-s390/checksum.h	Mon Apr  7 19:30:34 2003
+++ linux-2.5.67-s390/include/asm-s390/checksum.h	Mon Apr 14 19:11:58 2003
@@ -30,17 +30,29 @@
 static inline unsigned int
 csum_partial(const unsigned char * buff, int len, unsigned int sum)
 {
-	register_pair rp;
 	/*
 	 * Experiments with ethernet and slip connections show that buf
 	 * is aligned on either a 2-byte or 4-byte boundary.
 	 */
+#ifndef __s390x__
+	register_pair rp;
+
 	rp.subreg.even = (unsigned long) buff;
 	rp.subreg.odd = (unsigned long) len;
 	__asm__ __volatile__ (
 		"0:  cksm %0,%1\n"	/* do checksum on longs */
 		"    jo   0b\n"
 		: "+&d" (sum), "+&a" (rp) : : "cc" );
+#else /* __s390x__ */
+        __asm__ __volatile__ (
+                "    lgr  2,%1\n"    /* address in gpr 2 */
+                "    lgfr 3,%2\n"    /* length in gpr 3 */
+                "0:  cksm %0,2\n"    /* do checksum on longs */
+                "    jo   0b\n"
+                : "+&d" (sum)
+                : "d" (buff), "d" (len)
+                : "cc", "2", "3" );
+#endif /* __s390x__ */
 	return sum;
 }
 
@@ -50,6 +62,7 @@
 static inline unsigned int 
 csum_partial_inline(const unsigned char * buff, int len, unsigned int sum)
 {
+#ifndef __s390x__
 	register_pair rp;
 
 	rp.subreg.even = (unsigned long) buff;
@@ -58,6 +71,16 @@
 		"0:  cksm %0,%1\n"    /* do checksum on longs */
 		"    jo   0b\n"
                 : "+&d" (sum), "+&a" (rp) : : "cc" );
+#else /* __s390x__ */
+	__asm__ __volatile__ (
+		"    lgr  2,%1\n"    /* address in gpr 2 */
+		"    lgfr 3,%2\n"    /* length in gpr 3 */
+		"0:  cksm %0,2\n"    /* do checksum on longs */
+		"    jo   0b\n"
+                : "+&d" (sum)
+		: "d" (buff), "d" (len)
+                : "cc", "2", "3" );
+#endif /* __s390x__ */
 	return sum;
 }
 
@@ -100,6 +123,7 @@
 static inline unsigned short
 csum_fold(unsigned int sum)
 {
+#ifndef __s390x__
 	register_pair rp;
 
 	__asm__ __volatile__ (
@@ -110,6 +134,16 @@
 		"    alr  %0,%1\n"   /* %0 = H+L+C L+H */
 		"    srl  %0,16\n"   /* %0 = H+L+C */
 		: "+&d" (sum), "=d" (rp) : : "cc" );
+#else /* __s390x__ */
+	__asm__ __volatile__ (
+		"    sr   3,3\n"   /* %0 = H*65536 + L */
+		"    lr   2,%0\n"  /* %0 = H L, R2/R3 = H L / 0 0 */
+		"    srdl 2,16\n"  /* %0 = H L, R2/R3 = 0 H / L 0 */
+		"    alr  2,3\n"   /* %0 = H L, R2/R3 = L H / L 0 */
+		"    alr  %0,2\n"  /* %0 = H+L+C L+H */
+                "    srl  %0,16\n" /* %0 = H+L+C */
+		: "+&d" (sum) : : "cc", "2", "3");
+#endif /* __s390x__ */
 	return ((unsigned short) ~sum);
 }
 
@@ -121,8 +155,9 @@
 static inline unsigned short
 ip_fast_csum(unsigned char *iph, unsigned int ihl)
 {
-	register_pair rp;
 	unsigned long sum;
+#ifndef __s390x__
+	register_pair rp;
 
 	rp.subreg.even = (unsigned long) iph;
 	rp.subreg.odd = (unsigned long) ihl*4;
@@ -131,6 +166,17 @@
                 "0:  cksm %0,%1\n"   /* do checksum on longs */
                 "    jo   0b\n"
                 : "=&d" (sum), "+&a" (rp) : : "cc" );
+#else /* __s390x__ */
+        __asm__ __volatile__ (
+		"    slgr %0,%0\n"   /* set sum to zero */
+                "    lgr  2,%1\n"    /* address in gpr 2 */
+                "    lgfr 3,%2\n"    /* length in gpr 3 */
+                "0:  cksm %0,2\n"    /* do checksum on ints */
+                "    jo   0b\n"
+                : "=&d" (sum)
+                : "d" (iph), "d" (ihl*4)
+                : "cc", "2", "3" );
+#endif /* __s390x__ */
         return csum_fold(sum);
 }
 
@@ -143,6 +189,7 @@
                    unsigned short len, unsigned short proto,
                    unsigned int sum)
 {
+#ifndef __s390x__
 	__asm__ __volatile__ (
                 "    alr   %0,%1\n"  /* sum += saddr */
                 "    brc   12,0f\n"
@@ -163,6 +210,28 @@
 		: "+&d" (sum)
 		: "d" (((unsigned int) len<<16) + (unsigned int) proto)
 		: "cc" );
+#else /* __s390x__ */
+	__asm__ __volatile__ (
+                "    lgfr  %0,%0\n"
+                "    algr  %0,%1\n"  /* sum += saddr */
+                "    brc   12,0f\n"
+		"    aghi  %0,1\n"   /* add carry */
+		"0:  algr  %0,%2\n"  /* sum += daddr */
+                "    brc   12,1f\n"
+                "    aghi  %0,1\n"   /* add carry */
+		"1:  algfr %0,%3\n"  /* sum += (len<<16) + proto */
+		"    brc   12,2f\n"
+		"    aghi  %0,1\n"   /* add carry */
+		"2:  srlg  0,%0,32\n"
+                "    alr   %0,0\n"   /* fold to 32 bits */
+                "    brc   12,3f\n"
+                "    ahi   %0,1\n"   /* add carry */
+                "3:  llgfr %0,%0"
+		: "+&d" (sum)
+		: "d" (saddr), "d" (daddr),
+		  "d" (((unsigned int) len<<16) + (unsigned int) proto)
+		: "cc", "0" );
+#endif /* __s390x__ */
 	return sum;
 }
 
diff -urN linux-2.5.67/include/asm-s390/compat.h linux-2.5.67-s390/include/asm-s390/compat.h
--- linux-2.5.67/include/asm-s390/compat.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.67-s390/include/asm-s390/compat.h	Mon Apr 14 19:11:58 2003
@@ -0,0 +1,122 @@
+#ifndef _ASM_S390X_COMPAT_H
+#define _ASM_S390X_COMPAT_H
+/*
+ * Architecture specific compatibility types
+ */
+#include <linux/types.h>
+
+#define COMPAT_USER_HZ	100
+
+typedef u32		compat_size_t;
+typedef s32		compat_ssize_t;
+typedef s32		compat_time_t;
+typedef s32		compat_clock_t;
+typedef s32		compat_pid_t;
+typedef u16		compat_uid_t;
+typedef u16		compat_gid_t;
+typedef u16		compat_mode_t;
+typedef u32		compat_ino_t;
+typedef u16		compat_dev_t;
+typedef s32		compat_off_t;
+typedef s64		compat_loff_t;
+typedef u16		compat_nlink_t;
+typedef u16		compat_ipc_pid_t;
+typedef s32		compat_daddr_t;
+typedef u32		compat_caddr_t;
+typedef __kernel_fsid_t	compat_fsid_t;
+
+typedef s32		compat_int_t;
+typedef s32		compat_long_t;
+typedef u32		compat_uint_t;
+typedef u32		compat_ulong_t;
+
+struct compat_timespec {
+	compat_time_t	tv_sec;
+	s32		tv_nsec;
+};
+
+struct compat_timeval {
+	compat_time_t	tv_sec;
+	s32		tv_usec;
+};
+
+struct compat_stat {
+	compat_dev_t	st_dev;
+	u16		__pad1;
+	compat_ino_t	st_ino;
+	compat_mode_t	st_mode;
+	compat_nlink_t	st_nlink;
+	compat_uid_t	st_uid;
+	compat_gid_t	st_gid;
+	compat_dev_t	st_rdev;
+	u16		__pad2;
+	u32		st_size;
+	u32		st_blksize;
+	u32		st_blocks;
+	u32		st_atime;
+	u32		st_atime_nsec;
+	u32		st_mtime;
+	u32		st_mtime_nsec;
+	u32		st_ctime;
+	u32		st_ctime_nsec;
+	u32		__unused4;
+	u32		__unused5;
+};
+
+struct compat_flock {
+	short		l_type;
+	short		l_whence;
+	compat_off_t	l_start;
+	compat_off_t	l_len;
+	compat_pid_t	l_pid;
+};
+
+#define F_GETLK64       12
+#define F_SETLK64       13
+#define F_SETLKW64      14    
+
+struct compat_flock64 {
+	short		l_type;
+	short		l_whence;
+	compat_loff_t	l_start;
+	compat_loff_t	l_len;
+	compat_pid_t	l_pid;
+};
+
+struct compat_statfs {
+	s32		f_type;
+	s32		f_bsize;
+	s32		f_blocks;
+	s32		f_bfree;
+	s32		f_bavail;
+	s32		f_files;
+	s32		f_ffree;
+	compat_fsid_t	f_fsid;
+	s32		f_namelen;
+	s32		f_spare[6];
+};
+
+typedef u32		compat_old_sigset_t;	/* at least 32 bits */
+
+#define _COMPAT_NSIG		64
+#define _COMPAT_NSIG_BPW	32
+
+typedef u32		compat_sigset_word;
+
+#define COMPAT_OFF_T_MAX	0x7fffffff
+#define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
+
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+
+static inline void *compat_ptr(compat_uptr_t uptr)
+{
+	return (void *)(unsigned long)(uptr & 0x7fffffffUL);
+}
+
+#endif /* _ASM_S390X_COMPAT_H */
diff -urN linux-2.5.67/include/asm-s390/div64.h linux-2.5.67-s390/include/asm-s390/div64.h
--- linux-2.5.67/include/asm-s390/div64.h	Mon Apr  7 19:31:55 2003
+++ linux-2.5.67-s390/include/asm-s390/div64.h	Mon Apr 14 19:11:58 2003
@@ -1,8 +1,9 @@
 #ifndef __S390_DIV64
 #define __S390_DIV64
 
+#ifndef __s390x__
+
 /* for do_div "base" needs to be smaller than 2^31-1 */
- 
 #define do_div(n, base) ({                                      \
 	unsigned long long __n = (n);				\
 	unsigned long __r;					\
@@ -41,4 +42,14 @@
         __r;                                                    \
 })
 
+#else /* __s390x__ */
+
+#define do_div(n,base) ({ \
+int __res; \
+__res = ((unsigned long) n) % (unsigned) base; \
+n = ((unsigned long) n) / (unsigned) base; \
+__res; })
+
+#endif /* __s390x__ */
+
 #endif
diff -urN linux-2.5.67/include/asm-s390/ebcdic.h linux-2.5.67-s390/include/asm-s390/ebcdic.h
--- linux-2.5.67/include/asm-s390/ebcdic.h	Mon Apr  7 19:31:09 2003
+++ linux-2.5.67-s390/include/asm-s390/ebcdic.h	Mon Apr 14 19:11:58 2003
@@ -21,8 +21,8 @@
 extern __u8 _ebc_tolower[]; /* EBCDIC -> lowercase */
 extern __u8 _ebc_toupper[]; /* EBCDIC -> uppercase */
 
-extern __inline__ 
-void codepage_convert(const __u8 *codepage, volatile __u8 * addr, int nr)
+extern __inline__ void
+codepage_convert(const __u8 *codepage, volatile __u8 * addr, unsigned long nr)
 {
 	if (nr-- <= 0)
 		return;
diff -urN linux-2.5.67/include/asm-s390/elf.h linux-2.5.67-s390/include/asm-s390/elf.h
--- linux-2.5.67/include/asm-s390/elf.h	Mon Apr  7 19:32:48 2003
+++ linux-2.5.67-s390/include/asm-s390/elf.h	Mon Apr 14 19:11:58 2003
@@ -23,7 +23,11 @@
 /*
  * These are used to set parameters in the core dumps.
  */
+#ifndef __s390x__
 #define ELF_CLASS	ELFCLASS32
+#else /* __s390x__ */
+#define ELF_CLASS	ELFCLASS64
+#endif /* __s390x__ */
 #define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
@@ -36,8 +40,16 @@
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
+#ifndef __s390x__
 #define ELF_PLAT_INIT(_r, load_addr) \
 	_r->gprs[14] = 0
+#else /* __s390x__ */
+#define ELF_PLAT_INIT(_r, load_addr) \
+	do { \
+	_r->gprs[14] = 0; \
+	clear_thread_flag(TIF_31BIT); \
+	} while(0)
+#endif /* __s390x__ */
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE	4096
@@ -47,9 +59,13 @@
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
+#ifndef __s390x__
 #define ELF_ET_DYN_BASE         ((TASK_SIZE & 0x80000000) \
                                 ? TASK_SIZE / 3 * 2 \
                                 : 2 * TASK_SIZE / 3)
+#else /* __s390x__ */
+#define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
+#endif /* __s390x__ */
 
 /* Wow, the "main" arch needs arch dependent functions too.. :) */
 
@@ -76,7 +92,18 @@
 #define ELF_PLATFORM (NULL)
 
 #ifdef __KERNEL__
+#ifndef __s390x__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
+#else /* __s390x__ */
+#define SET_PERSONALITY(ex, ibcs2)			\
+do {							\
+	if (ibcs2)					\
+		set_personality(PER_SVR4);		\
+	else if (current->personality != PER_LINUX32)	\
+		set_personality(PER_LINUX);		\
+	clear_thread_flag(TIF_31BIT);			\
+} while (0)
+#endif /* __s390x__ */
 #endif
 
 #endif
diff -urN linux-2.5.67/include/asm-s390/fcntl.h linux-2.5.67-s390/include/asm-s390/fcntl.h
--- linux-2.5.67/include/asm-s390/fcntl.h	Mon Apr  7 19:30:33 2003
+++ linux-2.5.67-s390/include/asm-s390/fcntl.h	Mon Apr 14 19:11:58 2003
@@ -42,10 +42,11 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */
 
+#ifndef __s390x__
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
-                               
+#endif /* ! __s390x__ */
 
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
@@ -82,6 +83,7 @@
 	pid_t l_pid;
 };
 
+#ifndef __s390x__
 struct flock64 {
 	short  l_type;
 	short  l_whence;
@@ -89,6 +91,6 @@
 	loff_t l_len;
 	pid_t  l_pid;
 };
-
+#endif
 #define F_LINUX_SPECIFIC_BASE	1024
 #endif
diff -urN linux-2.5.67/include/asm-s390/gdb-stub.h linux-2.5.67-s390/include/asm-s390/gdb-stub.h
--- linux-2.5.67/include/asm-s390/gdb-stub.h	Mon Apr  7 19:31:56 2003
+++ linux-2.5.67-s390/include/asm-s390/gdb-stub.h	Thu Jan  1 01:00:00 1970
@@ -1,22 +0,0 @@
-/*
- *  include/asm-s390/gdb-stub.h
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
- */
-
-#ifndef __S390_GDB_STUB__
-#define __S390_GDB_STUB__
-#include <linux/config.h>
-#if CONFIG_REMOTE_DEBUG
-#include <asm/ptrace.h>
-extern int    gdb_stub_initialised;
-extern void gdb_stub_handle_exception(struct gdb_pt_regs *regs,int sigval);
-struct net_device;
-extern struct net_device *gdb_dev;
-void gdb_do_timers(void);
-extern int putDebugChar(char c);    /* write a single character      */
-extern char getDebugChar(void);     /* read and return a single char */
-#endif
-#endif
diff -urN linux-2.5.67/include/asm-s390/idals.h linux-2.5.67-s390/include/asm-s390/idals.h
--- linux-2.5.67/include/asm-s390/idals.h	Mon Apr  7 19:30:40 2003
+++ linux-2.5.67-s390/include/asm-s390/idals.h	Mon Apr 14 19:11:58 2003
@@ -21,7 +21,7 @@
 #include <asm/cio.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_ARCH_S390X
+#ifdef __s390x__
 #define IDA_SIZE_LOG 12 /* 11 for 2k , 12 for 4k */
 #else
 #define IDA_SIZE_LOG 11 /* 11 for 2k , 12 for 4k */
@@ -34,7 +34,7 @@
 static inline int
 idal_is_needed(void *vaddr, unsigned int length)
 {
-#if defined(CONFIG_ARCH_S390X)
+#ifdef __s390x__
 	return ((__pa(vaddr) + length) >> 31) != 0;
 #else
 	return 0;
@@ -48,7 +48,7 @@
 static inline unsigned int
 idal_nr_words(void *vaddr, unsigned int length)
 {
-#if defined(CONFIG_ARCH_S390X)
+#ifdef __s390x__
 	if (idal_is_needed(vaddr, length))
 		return ((__pa(vaddr) & (IDA_BLOCK_SIZE-1)) + length + 
 			(IDA_BLOCK_SIZE-1)) >> IDA_SIZE_LOG;
@@ -62,7 +62,7 @@
 static inline unsigned long *
 idal_create_words(unsigned long *idaws, void *vaddr, unsigned int length)
 {
-#if defined(CONFIG_ARCH_S390X)
+#ifdef __s390x__
 	unsigned long paddr;
 	unsigned int cidaw;
 
@@ -86,7 +86,7 @@
 static inline int
 set_normalized_cda(struct ccw1 * ccw, void *vaddr)
 {
-#if defined (CONFIG_ARCH_S390X)
+#ifdef __s390x__
 	unsigned int nridaws;
 	unsigned long *idal;
 
@@ -113,7 +113,7 @@
 static inline void
 clear_normalized_cda(struct ccw1 * ccw)
 {
-#if defined(CONFIG_ARCH_S390X)
+#ifdef __s390x__
 	if (ccw->flags & CCW_FLAG_IDA) {
 		kfree((void *)(unsigned long) ccw->cda);
 		ccw->flags &= ~CCW_FLAG_IDA;
@@ -190,7 +190,7 @@
 static inline int
 __idal_buffer_is_needed(struct idal_buffer *ib)
 {
-#ifdef CONFIG_ARCH_S390X
+#ifdef __s390x__
 	return ib->size > (4096ul << ib->page_order) ||
 		idal_is_needed(ib->data[0], ib->size);
 #else
diff -urN linux-2.5.67/include/asm-s390/io.h linux-2.5.67-s390/include/asm-s390/io.h
--- linux-2.5.67/include/asm-s390/io.h	Mon Apr  7 19:31:56 2003
+++ linux-2.5.67-s390/include/asm-s390/io.h	Mon Apr 14 19:11:58 2003
@@ -27,9 +27,16 @@
 extern inline unsigned long virt_to_phys(volatile void * address)
 {
 	unsigned long real_address;
-	__asm__ ("   lra    %0,0(%1)\n"
+	__asm__ (
+#ifndef __s390x__
+		 "   lra    %0,0(%1)\n"
                  "   jz     0f\n"
                  "   sr     %0,%0\n"
+#else /* __s390x__ */
+		 "   lrag   %0,0(%1)\n"
+                 "   jz     0f\n"
+                 "   slgr   %0,%0\n"
+#endif /* __s390x__ */
                  "0:"
                  : "=a" (real_address) : "a" (address) : "cc" );
         return real_address;
diff -urN linux-2.5.67/include/asm-s390/ipc.h linux-2.5.67-s390/include/asm-s390/ipc.h
--- linux-2.5.67/include/asm-s390/ipc.h	Mon Apr  7 19:32:54 2003
+++ linux-2.5.67-s390/include/asm-s390/ipc.h	Mon Apr 14 19:11:58 2003
@@ -22,6 +22,7 @@
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -urN linux-2.5.67/include/asm-s390/ipcbuf.h linux-2.5.67-s390/include/asm-s390/ipcbuf.h
--- linux-2.5.67/include/asm-s390/ipcbuf.h	Mon Apr  7 19:31:15 2003
+++ linux-2.5.67-s390/include/asm-s390/ipcbuf.h	Mon Apr 14 19:11:58 2003
@@ -21,7 +21,9 @@
 	__kernel_mode_t		mode;
 	unsigned short		__pad1;
 	unsigned short		seq;
+#ifndef __s390x__
 	unsigned short		__pad2;
+#endif /* ! __s390x__ */
 	unsigned long		__unused1;
 	unsigned long		__unused2;
 };
diff -urN linux-2.5.67/include/asm-s390/lowcore.h linux-2.5.67-s390/include/asm-s390/lowcore.h
--- linux-2.5.67/include/asm-s390/lowcore.h	Mon Apr  7 19:31:19 2003
+++ linux-2.5.67-s390/include/asm-s390/lowcore.h	Mon Apr 14 19:11:58 2003
@@ -11,6 +11,7 @@
 #ifndef _ASM_S390_LOWCORE_H
 #define _ASM_S390_LOWCORE_H
 
+#ifndef __s390x__
 #define __LC_EXT_OLD_PSW                0x018
 #define __LC_SVC_OLD_PSW                0x020
 #define __LC_PGM_OLD_PSW                0x028
@@ -21,43 +22,76 @@
 #define __LC_PGM_NEW_PSW                0x068
 #define __LC_MCK_NEW_PSW                0x070
 #define __LC_IO_NEW_PSW                 0x078
+#else /* !__s390x__ */
+#define __LC_EXT_OLD_PSW                0x0130
+#define __LC_SVC_OLD_PSW                0x0140
+#define __LC_PGM_OLD_PSW                0x0150
+#define __LC_MCK_OLD_PSW                0x0160
+#define __LC_IO_OLD_PSW                 0x0170
+#define __LC_EXT_NEW_PSW                0x01b0
+#define __LC_SVC_NEW_PSW                0x01c0
+#define __LC_PGM_NEW_PSW                0x01d0
+#define __LC_MCK_NEW_PSW                0x01e0
+#define __LC_IO_NEW_PSW                 0x01f0
+#endif /* !__s390x__ */
+
 #define __LC_EXT_PARAMS                 0x080
 #define __LC_CPU_ADDRESS                0x084
 #define __LC_EXT_INT_CODE               0x086
-#define __LC_SVC_INT_CODE               0x08B
+
+#define __LC_SVC_ILC                    0x088
+#define __LC_SVC_INT_CODE               0x08A
 #define __LC_PGM_ILC                    0x08C
 #define __LC_PGM_INT_CODE               0x08E
-#define __LC_TRANS_EXC_ADDR             0x090
+
 #define __LC_SUBCHANNEL_ID              0x0B8
 #define __LC_SUBCHANNEL_NR              0x0BA
 #define __LC_IO_INT_PARM                0x0BC
 #define __LC_IO_INT_WORD                0x0C0
 #define __LC_MCCK_CODE                  0x0E8
-#define __LC_AREGS_SAVE_AREA            0x120
-#define __LC_CREGS_SAVE_AREA            0x1C0
 
 #define __LC_RETURN_PSW                 0x200
-#define __LC_IRB			0x208
+
+#define __LC_IRB			0x210
+
+#define __LC_DIAG44_OPCODE		0x250
 
 #define __LC_SAVE_AREA                  0xC00
+
+#ifndef __s390x__
 #define __LC_KERNEL_STACK               0xC40
 #define __LC_ASYNC_STACK                0xC44
 #define __LC_CPUID                      0xC60
 #define __LC_CPUADDR                    0xC68
 #define __LC_IPLDEV                     0xC7C
-
 #define __LC_JIFFY_TIMER		0xC80
+#else /* __s390x__ */
+#define __LC_KERNEL_STACK               0xD40
+#define __LC_ASYNC_STACK                0xD48
+#define __LC_CPUID                      0xD90
+#define __LC_CPUADDR                    0xD98
+#define __LC_IPLDEV                     0xDB8
+#define __LC_JIFFY_TIMER		0xDC0
+#endif /* __s390x__ */
 
 #define __LC_PANIC_MAGIC                0xE00
 
+#ifndef __s390x__
 #define __LC_PFAULT_INTPARM             0x080
+#define __LC_AREGS_SAVE_AREA            0x120
+#define __LC_CREGS_SAVE_AREA            0x1C0
+#else /* __s390x__ */
+#define __LC_PFAULT_INTPARM             0x11B8
+#define __LC_AREGS_SAVE_AREA            0x1340
+#define __LC_CREGS_SAVE_AREA            0x1380
+#endif /* __s390x__ */
 
 #ifndef __ASSEMBLY__
 
 #include <linux/config.h>
+#include <asm/processor.h>
 #include <linux/types.h>
 #include <asm/atomic.h>
-#include <asm/processor.h>
 #include <asm/sigp.h>
 
 void restart_int_handler(void);
@@ -69,6 +103,7 @@
 
 struct _lowcore
 {
+#ifndef __s390x__
         /* prefix area: defined by architecture */
 	psw_t        restart_psw;              /* 0x000 */
 	__u32        ccw2[4];                  /* 0x008 */
@@ -142,6 +177,101 @@
 
         /* Align to the top 1k of prefix area */
 	__u8         pad12[0x1000-0xe04];      /* 0xe04 */
+#else /* !__s390x__ */
+        /* prefix area: defined by architecture */
+	__u32        ccw1[2];                  /* 0x000 */
+	__u32        ccw2[4];                  /* 0x008 */
+	__u8         pad1[0x80-0x18];          /* 0x018 */
+	__u32        ext_params;               /* 0x080 */
+	__u16        cpu_addr;                 /* 0x084 */
+	__u16        ext_int_code;             /* 0x086 */
+        __u16        svc_ilc;                  /* 0x088 */
+        __u16        svc_code;                 /* 0x08a */
+        __u16        pgm_ilc;                  /* 0x08c */
+        __u16        pgm_code;                 /* 0x08e */
+	__u32        data_exc_code;            /* 0x090 */
+	__u16        mon_class_num;            /* 0x094 */
+	__u16        per_perc_atmid;           /* 0x096 */
+	addr_t       per_address;              /* 0x098 */
+	__u8         exc_access_id;            /* 0x0a0 */
+	__u8         per_access_id;            /* 0x0a1 */
+	__u8         op_access_id;             /* 0x0a2 */
+	__u8         ar_access_id;             /* 0x0a3 */
+	__u8         pad2[0xA8-0xA4];          /* 0x0a4 */
+	addr_t       trans_exc_code;           /* 0x0A0 */
+	addr_t       monitor_code;             /* 0x09c */
+	__u16        subchannel_id;            /* 0x0b8 */
+	__u16        subchannel_nr;            /* 0x0ba */
+	__u32        io_int_parm;              /* 0x0bc */
+	__u32        io_int_word;              /* 0x0c0 */
+	__u8         pad3[0xc8-0xc4];          /* 0x0c4 */
+	__u32        stfl_fac_list;            /* 0x0c8 */
+	__u8         pad4[0xe8-0xcc];          /* 0x0cc */
+	__u32        mcck_interruption_code[2]; /* 0x0e8 */
+	__u8         pad5[0xf4-0xf0];          /* 0x0f0 */
+	__u32        external_damage_code;     /* 0x0f4 */
+	addr_t       failing_storage_address;  /* 0x0f8 */
+	__u8         pad6[0x120-0x100];        /* 0x100 */
+	psw_t        restart_old_psw;          /* 0x120 */
+	psw_t        external_old_psw;         /* 0x130 */
+	psw_t        svc_old_psw;              /* 0x140 */
+	psw_t        program_old_psw;          /* 0x150 */
+	psw_t        mcck_old_psw;             /* 0x160 */
+	psw_t        io_old_psw;               /* 0x170 */
+	__u8         pad7[0x1a0-0x180];        /* 0x180 */
+	psw_t        restart_psw;              /* 0x1a0 */
+	psw_t        external_new_psw;         /* 0x1b0 */
+	psw_t        svc_new_psw;              /* 0x1c0 */
+	psw_t        program_new_psw;          /* 0x1d0 */
+	psw_t        mcck_new_psw;             /* 0x1e0 */
+	psw_t        io_new_psw;               /* 0x1f0 */
+        psw_t        return_psw;               /* 0x200 */
+	__u8	     irb[64];		       /* 0x210 */
+	__u32        diag44_opcode;            /* 0x250 */
+        __u8         pad8[0xc00-0x254];        /* 0x254 */
+        /* System info area */
+	__u64        save_area[16];            /* 0xc00 */
+        __u8         pad9[0xd40-0xc80];        /* 0xc80 */
+ 	__u64        kernel_stack;             /* 0xd40 */
+	__u64        async_stack;              /* 0xd48 */
+	/* entry.S sensitive area start */
+	__u8         pad10[0xd80-0xd50];       /* 0xd64 */
+	struct       cpuinfo_S390 cpu_data;    /* 0xd80 */
+	__u32        ipl_device;               /* 0xdb8 */
+	__u32        pad11;                    /* 0xdbc */
+	/* entry.S sensitive area end */
+
+        /* SMP info area: defined by DJB */
+        __u64        jiffy_timer;              /* 0xdc0 */
+	__u64        ext_call_fast;            /* 0xdc8 */
+        __u8         pad12[0xe00-0xdd0];       /* 0xdd0 */
+
+        /* 0xe00 is used as indicator for dump tools */
+        /* whether the kernel died with panic() or not */
+        __u32        panic_magic;              /* 0xe00 */
+
+	__u8         pad13[0x1200-0xe04];      /* 0xe04 */
+
+        /* System info area */ 
+
+	__u64        floating_pt_save_area[16]; /* 0x1200 */
+	__u64        gpregs_save_area[16];      /* 0x1280 */
+	__u32        st_status_fixed_logout[4]; /* 0x1300 */
+	__u8         pad14[0x1318-0x1310];      /* 0x1310 */
+	__u32        prefixreg_save_area;       /* 0x1318 */
+	__u32        fpt_creg_save_area;        /* 0x131c */
+	__u8         pad15[0x1324-0x1320];      /* 0x1320 */
+	__u32        tod_progreg_save_area;     /* 0x1324 */
+	__u32        cpu_timer_save_area[2];    /* 0x1328 */
+	__u32        clock_comp_save_area[2];   /* 0x1330 */
+	__u8         pad16[0x1340-0x1338];      /* 0x1338 */ 
+	__u32        access_regs_save_area[16]; /* 0x1340 */ 
+	__u64        cregs_save_area[16];       /* 0x1380 */
+
+	/* align to the top of the prefix area */
+
+	__u8         pad17[0x2000-0x1400];      /* 0x1400 */
+#endif /* !__s390x__ */
 } __attribute__((packed)); /* End structure*/
 
 #define S390_lowcore (*((struct _lowcore *) 0))
diff -urN linux-2.5.67/include/asm-s390/mmu_context.h linux-2.5.67-s390/include/asm-s390/mmu_context.h
--- linux-2.5.67/include/asm-s390/mmu_context.h	Mon Apr  7 19:31:14 2003
+++ linux-2.5.67-s390/include/asm-s390/mmu_context.h	Mon Apr 14 19:11:58 2003
@@ -27,12 +27,20 @@
         unsigned long pgd;
 
         if (prev != next) {
+#ifndef __s390x__
 	        pgd = (__pa(next->pgd)&PAGE_MASK) | 
                       (_SEGMENT_TABLE|USER_STD_MASK);
                 /* Load page tables */
                 asm volatile("    lctl  7,7,%0\n"   /* secondary space */
                              "    lctl  13,13,%0\n" /* home space */
                              : : "m" (pgd) );
+#else /* __s390x__ */
+                pgd = (__pa(next->pgd)&PAGE_MASK) | (_REGION_TABLE|USER_STD_MASK);
+                /* Load page tables */
+                asm volatile("    lctlg 7,7,%0\n"   /* secondary space */
+                             "    lctlg 13,13,%0\n" /* home space */
+                             : : "m" (pgd) );
+#endif /* __s390x__ */
         }
 	set_bit(cpu, &next->cpu_vm_mask);
 }
diff -urN linux-2.5.67/include/asm-s390/module.h linux-2.5.67-s390/include/asm-s390/module.h
--- linux-2.5.67/include/asm-s390/module.h	Mon Apr  7 19:30:33 2003
+++ linux-2.5.67-s390/include/asm-s390/module.h	Mon Apr 14 19:11:58 2003
@@ -28,7 +28,7 @@
 	struct mod_arch_syminfo *syminfo;
 };
 
-#ifdef CONFIG_ARCH_S390X
+#ifdef __s390x__
 #define ElfW(x) Elf64_ ## x
 #define ELFW(x) ELF64_ ## x
 #else
@@ -36,8 +36,11 @@
 #define ELFW(x) ELF32_ ## x
 #endif
 
+#define Elf_Addr ElfW(Addr)
+#define Elf_Rela ElfW(Rela)
 #define Elf_Shdr ElfW(Shdr)
 #define Elf_Sym ElfW(Sym)
 #define Elf_Ehdr ElfW(Ehdr)
+#define ELF_R_SYM ELFW(R_SYM)
 #define ELF_R_TYPE ELFW(R_TYPE)
 #endif /* _ASM_S390_MODULE_H */
diff -urN linux-2.5.67/include/asm-s390/msgbuf.h linux-2.5.67-s390/include/asm-s390/msgbuf.h
--- linux-2.5.67/include/asm-s390/msgbuf.h	Mon Apr  7 19:31:43 2003
+++ linux-2.5.67-s390/include/asm-s390/msgbuf.h	Mon Apr 14 19:11:58 2003
@@ -14,11 +14,17 @@
 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
 	__kernel_time_t msg_stime;	/* last msgsnd time */
+#ifndef __s390x__
 	unsigned long	__unused1;
+#endif /* ! __s390x__ */
 	__kernel_time_t msg_rtime;	/* last msgrcv time */
+#ifndef __s390x__
 	unsigned long	__unused2;
+#endif /* ! __s390x__ */
 	__kernel_time_t msg_ctime;	/* last change time */
+#ifndef __s390x__
 	unsigned long	__unused3;
+#endif /* ! __s390x__ */
 	unsigned long  msg_cbytes;	/* current number of bytes on queue */
 	unsigned long  msg_qnum;	/* number of messages in queue */
 	unsigned long  msg_qbytes;	/* max number of bytes on queue */
diff -urN linux-2.5.67/include/asm-s390/page.h linux-2.5.67-s390/include/asm-s390/page.h
--- linux-2.5.67/include/asm-s390/page.h	Mon Apr  7 19:30:44 2003
+++ linux-2.5.67-s390/include/asm-s390/page.h	Mon Apr 14 19:11:58 2003
@@ -20,6 +20,8 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
+#ifndef __s390x__
+
 static inline void clear_page(void *page)
 {
 	register_pair rp;
@@ -59,6 +61,48 @@
 			      : "memory" );
 }
 
+#else /* __s390x__ */
+
+static inline void clear_page(void *page)
+{
+        asm volatile ("   lgr  2,%0\n"
+                      "   lghi 3,4096\n"
+                      "   slgr 1,1\n"
+                      "   mvcl 2,0"
+                      : : "a" ((void *) (page))
+		      : "memory", "cc", "1", "2", "3" );
+}
+
+static inline void copy_page(void *to, void *from)
+{
+        if (MACHINE_HAS_MVPG)
+		asm volatile ("   sgr  0,0\n"
+			      "   mvpg %0,%1"
+			      : : "a" ((void *)(to)), "a" ((void *)(from))
+			      : "memory", "cc", "0" );
+	else
+		asm volatile ("   mvc  0(256,%0),0(%1)\n"
+			      "   mvc  256(256,%0),256(%1)\n"
+			      "   mvc  512(256,%0),512(%1)\n"
+			      "   mvc  768(256,%0),768(%1)\n"
+			      "   mvc  1024(256,%0),1024(%1)\n"
+			      "   mvc  1280(256,%0),1280(%1)\n"
+			      "   mvc  1536(256,%0),1536(%1)\n"
+			      "   mvc  1792(256,%0),1792(%1)\n"
+			      "   mvc  2048(256,%0),2048(%1)\n"
+			      "   mvc  2304(256,%0),2304(%1)\n"
+			      "   mvc  2560(256,%0),2560(%1)\n"
+			      "   mvc  2816(256,%0),2816(%1)\n"
+			      "   mvc  3072(256,%0),3072(%1)\n"
+			      "   mvc  3328(256,%0),3328(%1)\n"
+			      "   mvc  3584(256,%0),3584(%1)\n"
+			      "   mvc  3840(256,%0),3840(%1)\n"
+			      : : "a"((void *)(to)),"a"((void *)(from)) 
+			      : "memory" );
+}
+
+#endif /* __s390x__ */
+
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
@@ -79,7 +123,15 @@
 /*
  * These are used to make use of C type-checking..
  */
+
+typedef struct { unsigned long pgprot; } pgprot_t;
 typedef struct { unsigned long pte; } pte_t;
+
+#define pte_val(x)      ((x).pte)
+#define pgprot_val(x)   ((x).pgprot)
+
+#ifndef __s390x__
+
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct {
         unsigned long pgd0;
@@ -87,12 +139,23 @@
         unsigned long pgd2;
         unsigned long pgd3;
         } pgd_t;
-typedef struct { unsigned long pgprot; } pgprot_t;
 
-#define pte_val(x)      ((x).pte)
 #define pmd_val(x)      ((x).pmd)
 #define pgd_val(x)      ((x).pgd0)
-#define pgprot_val(x)   ((x).pgprot)
+
+#else /* __s390x__ */
+
+typedef struct { 
+        unsigned long pmd0;
+        unsigned long pmd1; 
+        } pmd_t;
+typedef struct { unsigned long pgd; } pgd_t;
+
+#define pmd_val(x)      ((x).pmd0)
+#define pmd_val1(x)     ((x).pmd1)
+#define pgd_val(x)      ((x).pgd)
+
+#endif /* __s390x__ */
 
 #define __pte(x)        ((pte_t) { (x) } )
 #define __pmd(x)        ((pmd_t) { (x) } )
diff -urN linux-2.5.67/include/asm-s390/pgalloc.h linux-2.5.67-s390/include/asm-s390/pgalloc.h
--- linux-2.5.67/include/asm-s390/pgalloc.h	Mon Apr  7 19:31:51 2003
+++ linux-2.5.67-s390/include/asm-s390/pgalloc.h	Mon Apr 14 19:11:58 2003
@@ -1,5 +1,5 @@
 /*
- *  include/asm-s390/bugs.h
+ *  include/asm-s390/pgalloc.h
  *
  *  S390 version
  *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
@@ -32,35 +32,79 @@
 	pgd_t *pgd;
 	int i;
 
+#ifndef __s390x__
 	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,1);
         if (pgd != NULL)
 		for (i = 0; i < USER_PTRS_PER_PGD; i++)
 			pmd_clear(pmd_offset(pgd + i, i*PGDIR_SIZE));
+#else /* __s390x__ */
+	pgd = (pgd_t *) __get_free_pages(GFP_KERNEL,2);
+        if (pgd != NULL)
+		for (i = 0; i < PTRS_PER_PGD; i++)
+			pgd_clear(pgd + i);
+#endif /* __s390x__ */
 	return pgd;
 }
 
 static inline void pgd_free(pgd_t *pgd)
 {
+#ifndef __s390x__
         free_pages((unsigned long) pgd, 1);
+#else /* __s390x__ */
+        free_pages((unsigned long) pgd, 2);
+#endif /* __s390x__ */
 }
 
+#ifndef __s390x__
 /*
  * page middle directory allocation/free routines.
- * We don't use pmd cache, so these are dummy routines. This
+ * We use pmd cache only on s390x, so these are dummy routines. This
  * code never triggers because the pgd will always be present.
  */
 #define pmd_alloc_one(mm,address)       ({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)                     do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
 #define pgd_populate(mm, pmd, pte)      BUG()
+#else /* __s390x__ */
+static inline pmd_t * pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
+{
+	pmd_t *pmd;
+        int i;
+
+	pmd = (pmd_t *) __get_free_pages(GFP_KERNEL, 2);
+	if (pmd != NULL) {
+		for (i=0; i < PTRS_PER_PMD; i++)
+			pmd_clear(pmd+i);
+	}
+	return pmd;
+}
+
+static inline void pmd_free (pmd_t *pmd)
+{
+	free_pages((unsigned long) pmd, 2);
+}
+
+#define __pmd_free_tlb(tlb,pmd) pmd_free(pmd)
+
+static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmd)
+{
+	pgd_val(*pgd) = _PGD_ENTRY | __pa(pmd);
+}
+
+#endif /* __s390x__ */
 
 static inline void 
 pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
 {
+#ifndef __s390x__
 	pmd_val(pmd[0]) = _PAGE_TABLE + __pa(pte);
 	pmd_val(pmd[1]) = _PAGE_TABLE + __pa(pte+256);
 	pmd_val(pmd[2]) = _PAGE_TABLE + __pa(pte+512);
 	pmd_val(pmd[3]) = _PAGE_TABLE + __pa(pte+768);
+#else /* __s390x__ */
+	pmd_val(*pmd) = _PMD_ENTRY + __pa(pte);
+	pmd_val1(*pmd) = _PMD_ENTRY + __pa(pte+256);
+#endif /* __s390x__ */
 }
 
 static inline void
@@ -122,11 +166,16 @@
                                     unsigned long address, pte_t *ptep)
 {
 	pte_t pte = *ptep;
+#ifndef __s390x__
 	if (!(pte_val(pte) & _PAGE_INVALID)) {
 		/* S390 has 1mb segments, we are emulating 4MB segments */
 		pte_t *pto = (pte_t *) (((unsigned long) ptep) & 0x7ffffc00);
 		__asm__ __volatile__ ("ipte %0,%1" : : "a" (pto), "a" (address));
 	}
+#else /* __s390x__ */
+	if (!(pte_val(pte) & _PAGE_INVALID)) 
+		__asm__ __volatile__ ("ipte %0,%1" : : "a" (ptep), "a" (address));
+#endif /* __s390x__ */
 	pte_clear(ptep);
 	return pte;
 }
diff -urN linux-2.5.67/include/asm-s390/pgtable.h linux-2.5.67-s390/include/asm-s390/pgtable.h
--- linux-2.5.67/include/asm-s390/pgtable.h	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/include/asm-s390/pgtable.h	Mon Apr 14 19:11:58 2003
@@ -14,10 +14,12 @@
 #define _ASM_S390_PGTABLE_H
 
 /*
- * The Linux memory management assumes a three-level page table setup. On
- * the S390, we use that, but "fold" the mid level into the top-level page
- * table, so that we physically have the same two-level page table as the
- * S390 mmu expects.
+ * The Linux memory management assumes a three-level page table setup. For
+ * s390 31 bit we "fold" the mid level into the top-level page table, so
+ * that we physically have the same two-level page table as the s390 mmu
+ * expects in 31 bit mode. For s390 64 bit we use three of the five levels
+ * the hardware provides (region first and region second tables are not
+ * used).
  *
  * The "pgd_xxx()" functions are trivial for a folded two-level
  * setup: the pgd is never bad, and a pmd always exists (as it's folded
@@ -50,13 +52,18 @@
 /*
  * PMD_SHIFT determines the size of the area a second-level page
  * table can map
+ * PGDIR_SHIFT determines what a third-level page table entry can map
  */
-#define PMD_SHIFT       22
+#ifndef __s390x__
+# define PMD_SHIFT	22
+# define PGDIR_SHIFT	22
+#else /* __s390x__ */
+# define PMD_SHIFT	21
+# define PGDIR_SHIFT	31
+#endif /* __s390x__ */
+
 #define PMD_SIZE        (1UL << PMD_SHIFT)
 #define PMD_MASK        (~(PMD_SIZE-1))
-
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
-#define PGDIR_SHIFT     22
 #define PGDIR_SIZE      (1UL << PGDIR_SHIFT)
 #define PGDIR_MASK      (~(PGDIR_SIZE-1))
 
@@ -66,24 +73,37 @@
  * for S390 segment-table entries are combined to one PGD
  * that leads to 1024 pte per pgd
  */
-#define PTRS_PER_PTE    1024
-#define PTRS_PER_PMD    1
-#define PTRS_PER_PGD    512
+#ifndef __s390x__
+# define PTRS_PER_PTE    1024
+# define PTRS_PER_PMD    1
+# define PTRS_PER_PGD    512
+#else /* __s390x__ */
+# define PTRS_PER_PTE    512
+# define PTRS_PER_PMD    1024
+# define PTRS_PER_PGD    2048
+#endif /* __s390x__ */
 
 /*
  * pgd entries used up by user/kernel:
  */
-#define USER_PTRS_PER_PGD  512
-#define USER_PGD_PTRS      512
-#define KERNEL_PGD_PTRS    512
-#define FIRST_USER_PGD_NR  0
+#ifndef __s390x__
+# define USER_PTRS_PER_PGD  512
+# define USER_PGD_PTRS      512
+# define KERNEL_PGD_PTRS    512
+# define FIRST_USER_PGD_NR  0
+#else /* __s390x__ */
+# define USER_PTRS_PER_PGD  2048
+# define USER_PGD_PTRS      2048
+# define KERNEL_PGD_PTRS    2048
+# define FIRST_USER_PGD_NR  0
+#endif /* __s390x__ */
 
 #define pte_ERROR(e) \
-	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
+	printk("%s:%d: bad pte %p.\n", __FILE__, __LINE__, (void *) pte_val(e))
 #define pmd_ERROR(e) \
-	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
+	printk("%s:%d: bad pmd %p.\n", __FILE__, __LINE__, (void *) pmd_val(e))
 #define pgd_ERROR(e) \
-	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+	printk("%s:%d: bad pgd %p.\n", __FILE__, __LINE__, (void *) pgd_val(e))
 
 #ifndef __ASSEMBLY__
 /*
@@ -98,11 +118,15 @@
 #define VMALLOC_START   (((unsigned long) high_memory + VMALLOC_OFFSET) \
 			 & ~(VMALLOC_OFFSET-1))
 #define VMALLOC_VMADDR(x) ((unsigned long)(x))
-#define VMALLOC_END     (0x7fffffffL)
+#ifndef __s390x__
+# define VMALLOC_END     (0x7fffffffL)
+#else /* __s390x__ */
+# define VMALLOC_END     (0x40000000000L)
+#endif /* __s390x__ */
 
 
 /*
- * A pagetable entry of S390 has following format:
+ * A 31 bit pagetable entry of S390 has following format:
  *  |   PFRA          |    |  OS  |
  * 0                   0IP0
  * 00000000001111111111222222222233
@@ -111,7 +135,7 @@
  * I Page-Invalid Bit:    Page is not available for address-translation
  * P Page-Protection Bit: Store access not possible for page
  *
- * A segmenttable entry of S390 has following format:
+ * A 31 bit segmenttable entry of S390 has following format:
  *  |   P-table origin      |  |PTL
  * 0                         IC
  * 00000000001111111111222222222233
@@ -121,7 +145,7 @@
  * C Common-Segment Bit:     Segment is not private (PoP 3-30)
  * PTL Page-Table-Length:    Page-table length (PTL+1*16 entries -> up to 256)
  *
- * The segmenttable origin of S390 has following format:
+ * The 31 bit segmenttable origin of S390 has following format:
  *
  *  |S-table origin   |     | STL |
  * X                   **GPS
@@ -134,6 +158,46 @@
  * S Storage-Alteration:
  * STL Segment-Table-Length:  Segment-table length (STL+1*16 entries -> up to 2048)
  *
+ * A 64 bit pagetable entry of S390 has following format:
+ * |                     PFRA                         |0IP0|  OS  |
+ * 0000000000111111111122222222223333333333444444444455555555556666
+ * 0123456789012345678901234567890123456789012345678901234567890123
+ *
+ * I Page-Invalid Bit:    Page is not available for address-translation
+ * P Page-Protection Bit: Store access not possible for page
+ *
+ * A 64 bit segmenttable entry of S390 has following format:
+ * |        P-table origin                              |      TT
+ * 0000000000111111111122222222223333333333444444444455555555556666
+ * 0123456789012345678901234567890123456789012345678901234567890123
+ *
+ * I Segment-Invalid Bit:    Segment is not available for address-translation
+ * C Common-Segment Bit:     Segment is not private (PoP 3-30)
+ * P Page-Protection Bit: Store access not possible for page
+ * TT Type 00
+ *
+ * A 64 bit region table entry of S390 has following format:
+ * |        S-table origin                             |   TF  TTTL
+ * 0000000000111111111122222222223333333333444444444455555555556666
+ * 0123456789012345678901234567890123456789012345678901234567890123
+ *
+ * I Segment-Invalid Bit:    Segment is not available for address-translation
+ * TT Type 01
+ * TF
+ * TL Table lenght
+ *
+ * The 64 bit regiontable origin of S390 has following format:
+ * |      region table origon                          |       DTTL
+ * 0000000000111111111122222222223333333333444444444455555555556666
+ * 0123456789012345678901234567890123456789012345678901234567890123
+ *
+ * X Space-Switch event:
+ * G Segment-Invalid Bit:  
+ * P Private-Space Bit:    
+ * S Storage-Alteration:
+ * R Real space
+ * TL Table-Length:
+ *
  * A storage key has the following format:
  * | ACC |F|R|C|0|
  *  0   3 4 5 6 7
@@ -158,6 +222,8 @@
 #define _PAGE_INVALID_SWAP	0x200
 #define _PAGE_INVALID_FILE	0x201
 
+#ifndef __s390x__
+
 /* Bits in the segment table entry */
 #define _PAGE_TABLE_LEN 0xf            /* only full page-tables            */
 #define _PAGE_TABLE_COM 0x10           /* common page-table                */
@@ -186,6 +252,32 @@
 
 #define USER_STD_MASK	0x00000080UL
 
+#else /* __s390x__ */
+
+/* Bits in the segment table entry */
+#define _PMD_ENTRY_INV   0x20          /* invalid segment table entry      */
+#define _PMD_ENTRY       0x00        
+
+/* Bits in the region third table entry */
+#define _PGD_ENTRY_INV   0x20          /* invalid region table entry       */
+#define _PGD_ENTRY       0x07
+
+/*
+ * User and kernel page directory
+ */
+#define _REGION_THIRD       0x4
+#define _REGION_THIRD_LEN   0x3 
+#define _REGION_TABLE       (_REGION_THIRD|_REGION_THIRD_LEN|0x40|0x100)
+#define _KERN_REGION_TABLE  (_REGION_THIRD|_REGION_THIRD_LEN)
+
+#define USER_STD_MASK           0x0000000000000080UL
+
+/* Bits in the storage key */
+#define _PAGE_CHANGED    0x02          /* HW changed bit                   */
+#define _PAGE_REFERENCED 0x04          /* HW referenced bit                */
+
+#endif /* __s390x__ */
+
 /*
  * No mapping available
  */
@@ -195,7 +287,7 @@
 #define PAGE_RO_PRIVATE	  __pgprot(_PAGE_RO|_PAGE_ISCLEAN)
 #define PAGE_COPY	  __pgprot(_PAGE_RO|_PAGE_ISCLEAN)
 #define PAGE_SHARED	  __pgprot(0)
-#define PAGE_KERNEL	  __pgprot(0)
+#define PAGE_KERNEL	  __pgprot(_PAGE_ISCLEAN)
 
 /*
  * The S390 can't do page protection for execute, and considers that the
@@ -243,6 +335,8 @@
 /*
  * pgd/pmd/pte query functions
  */
+#ifndef __s390x__
+
 extern inline int pgd_present(pgd_t pgd) { return 1; }
 extern inline int pgd_none(pgd_t pgd)    { return 0; }
 extern inline int pgd_bad(pgd_t pgd)     { return 0; }
@@ -254,6 +348,40 @@
 	return (pmd_val(pmd) & (~PAGE_MASK & ~_PAGE_TABLE_INV)) != _PAGE_TABLE;
 }
 
+#else /* __s390x__ */
+
+extern inline int pgd_present(pgd_t pgd)
+{
+	return (pgd_val(pgd) & ~PAGE_MASK) == _PGD_ENTRY;
+}
+
+extern inline int pgd_none(pgd_t pgd)
+{
+	return pgd_val(pgd) & _PGD_ENTRY_INV;
+}
+
+extern inline int pgd_bad(pgd_t pgd)
+{
+	return (pgd_val(pgd) & (~PAGE_MASK & ~_PGD_ENTRY_INV)) != _PGD_ENTRY;
+}
+
+extern inline int pmd_present(pmd_t pmd)
+{
+	return (pmd_val(pmd) & ~PAGE_MASK) == _PMD_ENTRY;
+}
+
+extern inline int pmd_none(pmd_t pmd)
+{
+	return pmd_val(pmd) & _PMD_ENTRY_INV;
+}
+
+extern inline int pmd_bad(pmd_t pmd)
+{
+	return (pmd_val(pmd) & (~PAGE_MASK & ~_PMD_ENTRY_INV)) != _PMD_ENTRY;
+}
+
+#endif /* __s390x__ */
+
 extern inline int pte_none(pte_t pte)
 {
 	return (pte_val(pte) & _PAGE_INVALID_MASK) == _PAGE_INVALID_EMPTY;
@@ -302,6 +430,9 @@
 /*
  * pgd/pmd/pte modification functions
  */
+
+#ifndef __s390x__
+
 extern inline void pgd_clear(pgd_t * pgdp)      { }
 
 extern inline void pmd_clear(pmd_t * pmdp)
@@ -312,6 +443,21 @@
 	pmd_val(pmdp[3]) = _PAGE_TABLE_INV;
 }
 
+#else /* __s390x__ */
+
+extern inline void pgd_clear(pgd_t * pgdp)
+{
+	pgd_val(*pgdp) = _PGD_ENTRY_INV | _PGD_ENTRY;
+}
+
+extern inline void pmd_clear(pmd_t * pmdp)
+{
+	pmd_val(*pmdp) = _PMD_ENTRY_INV | _PMD_ENTRY;
+	pmd_val1(*pmdp) = _PMD_ENTRY_INV | _PMD_ENTRY;
+}
+
+#endif /* __s390x__ */
+
 extern inline void pte_clear(pte_t *ptep)
 {
 	pte_val(*ptep) = _PAGE_INVALID_EMPTY;
@@ -460,6 +606,18 @@
 	__pte;                                                            \
 })
 
+#ifdef __s390x__
+
+#define pfn_pmd(pfn, pgprot)                                              \
+({                                                                        \
+	pgprot_t __pgprot = (pgprot);                                     \
+	unsigned long __physpage = __pa((pfn) << PAGE_SHIFT);             \
+	pmd_t __pmd = __pmd(__physpage + pgprot_val(__pgprot));           \
+	__pmd;                                                            \
+})
+
+#endif /* __s390x__ */
+
 #define pte_pfn(x) (pte_val(x) >> PAGE_SHIFT)
 #define pte_page(x) pfn_to_page(pte_pfn(x))
 
@@ -476,12 +634,23 @@
 /* to find an entry in a kernel page-table-directory */
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
+#ifndef __s390x__
+
 /* Find an entry in the second-level page table.. */
 extern inline pmd_t * pmd_offset(pgd_t * dir, unsigned long address)
 {
         return (pmd_t *) dir;
 }
 
+#else /* __s390x__ */
+
+/* Find an entry in the second-level page table.. */
+#define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+#define pmd_offset(dir,addr) \
+	((pmd_t *) pgd_page_kernel(*(dir)) + pmd_index(addr))
+
+#endif /* __s390x__ */
+
 /* Find an entry in the third-level page table.. */
 #define pte_index(address) (((address) >> PAGE_SHIFT) & (PTRS_PER_PTE-1))
 #define pte_offset_kernel(pmd, address) \
@@ -492,6 +661,7 @@
 #define pte_unmap_nested(pte) do { } while (0)
 
 /*
+ * 31 bit swap entry format:
  * A page-table entry has some bits we have to treat in a special way.
  * Bits 0, 20 and bit 23 have to be zero, otherwise an specification
  * exception will occur instead of a page translation exception. The
@@ -507,17 +677,38 @@
  * 0|     offset      |0110|type |0
  * 00000000001111111111222222222233
  * 01234567890123456789012345678901
+ *
+ * 64 bit swap entry format:
+ * A page-table entry has some bits we have to treat in a special way.
+ * Bits 52 and bit 55 have to be zero, otherwise an specification
+ * exception will occur instead of a page translation exception. The
+ * specifiation exception has the bad habit not to store necessary
+ * information in the lowcore.
+ * Bit 53 and bit 54 are the page invalid bit and the page protection
+ * bit. We set both to indicate a swapped page.
+ * Bit 63 is used as the software page present bit. If a page is
+ * swapped this obviously has to be zero.
+ * This leaves the bits 0-51 and bits 56-62 to store type and offset.
+ * We use the 7 bits from 56-62 for the type and the 52 bits from 0-51
+ * for the offset.
+ * |                     offset                       |0110|type |0
+ * 0000000000111111111122222222223333333333444444444455555555556666
+ * 0123456789012345678901234567890123456789012345678901234567890123
  */
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 {
 	pte_t pte;
 	pte_val(pte) = (type << 1) | (offset << 12) | _PAGE_INVALID_SWAP;
+#ifndef __s390x__
 	pte_val(pte) &= 0x7ffff6fe;  /* better to be paranoid */
+#else /* __s390x__ */
+	pte_val(pte) &= 0xfffffffffffff6fe;  /* better to be paranoid */
+#endif /* __s390x__ */
 	return pte;
 }
 
 #define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
-#define __swp_offset(entry)	(((entry).val >> 12) & 0x7FFFF )
+#define __swp_offset(entry)	((entry).val >> 12)
 #define __swp_entry(type,offset) ((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
@@ -525,7 +716,11 @@
 
 typedef pte_t *pte_addr_t;
 
-#define PTE_FILE_MAX_BITS	26
+#ifndef __s390x__
+# define PTE_FILE_MAX_BITS	26
+#else /* __s390x__ */
+# define PTE_FILE_MAX_BITS	59
+#endif /* __s390x__ */
 
 #define pte_to_pgoff(__pte) \
 	((((__pte).pte >> 12) << 7) + (((__pte).pte >> 1) & 0x7f))
@@ -543,5 +738,9 @@
  */
 #define pgtable_cache_init()	do { } while (0)
 
+#ifdef __s390x__
+# define HAVE_ARCH_UNMAPPED_AREA
+#endif /* __s390x__ */
+
 #endif /* _S390_PAGE_H */
 

