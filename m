Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTEBMNH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 08:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbTEBMNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 08:13:07 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:41600 "EHLO
	d06lmsgate-4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S262030AbTEBMMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 08:12:45 -0400
Date: Fri, 2 May 2003 14:24:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (2/3): optimize s390 inline assemblies.
Message-ID: <20030502122415.GC6110@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize s390 inline assemblies.

diffstat:
 arch/s390/kernel/smp.c      |    7 --
 include/asm-s390/system.h   |  147 ++++++++++++++++++++------------------------
 include/asm-s390/tlbflush.h |   11 ++-
 include/asm-s390/uaccess.h  |  106 ++++++++++++++++---------------
 4 files changed, 131 insertions(+), 140 deletions(-)

diff -urN linux-2.5.68/arch/s390/kernel/smp.c linux-2.5.68-s390/arch/s390/kernel/smp.c
--- linux-2.5.68/arch/s390/kernel/smp.c	Sun Apr 20 04:48:48 2003
+++ linux-2.5.68-s390/arch/s390/kernel/smp.c	Fri May  2 14:06:44 2003
@@ -512,10 +512,9 @@
 	cpu_lowcore->kernel_stack = (unsigned long)
 		idle->thread_info + (THREAD_SIZE);
 	__ctl_store(cpu_lowcore->cregs_save_area[0], 0, 15);
-	__asm__ __volatile__("la    1,%0\n\t"
-			     "stam  0,15,0(1)"
-			     : "=m" (cpu_lowcore->access_regs_save_area[0])
-			     : : "1", "memory");
+	__asm__ __volatile__("stam  0,15,0(%0)"
+			     : : "a" (&cpu_lowcore->access_regs_save_area)
+			     : "memory");
         eieio();
         signal_processor(cpu,sigp_restart);
 
diff -urN linux-2.5.68/include/asm-s390/system.h linux-2.5.68-s390/include/asm-s390/system.h
--- linux-2.5.68/include/asm-s390/system.h	Sun Apr 20 04:51:16 2003
+++ linux-2.5.68-s390/include/asm-s390/system.h	Fri May  2 14:06:44 2003
@@ -25,12 +25,9 @@
 
 #ifdef __s390x__
 #define __FLAG_SHIFT 56
-extern void __misaligned_u16(void);
-extern void __misaligned_u32(void);
-extern void __misaligned_u64(void);
-#else /* __s390x__ */
+#else /* ! __s390x__ */
 #define __FLAG_SHIFT 24
-#endif /* __s390x__ */
+#endif /* ! __s390x__ */
 
 static inline void save_fp_regs(s390_fp_regs *fpregs)
 {
@@ -301,56 +298,52 @@
 
 #define __ctl_load(array, low, high) ({ \
 	__asm__ __volatile__ ( \
-		"   la    1,%0\n" \
-		"   bras  2,0f\n" \
-                "   lctlg 0,0,0(1)\n" \
-		"0: ex    %1,0(2)" \
-		: : "m" (array), "a" (((low)<<4)+(high)) : "1", "2" ); \
+		"   bras  1,0f\n" \
+                "   lctlg 0,0,0(%0)\n" \
+		"0: ex    %1,0(1)" \
+		: : "a" (&array), "a" (((low)<<4)+(high)) : "1" ); \
 	})
 
 #define __ctl_store(array, low, high) ({ \
 	__asm__ __volatile__ ( \
-		"   la    1,%0\n" \
-		"   bras  2,0f\n" \
-		"   stctg 0,0,0(1)\n" \
-		"0: ex    %1,0(2)" \
-		: "=m" (array) : "a" (((low)<<4)+(high)): "1", "2" ); \
+		"   bras  1,0f\n" \
+		"   stctg 0,0,0(%1)\n" \
+		"0: ex    %2,0(1)" \
+		: "=m" (array) : "a" (&array), "a" (((low)<<4)+(high)) : "1" ); \
 	})
 
 #define __ctl_set_bit(cr, bit) ({ \
         __u8 __dummy[24]; \
         __asm__ __volatile__ ( \
-                "    la    1,%0\n"       /* align to 8 byte */ \
-                "    aghi  1,7\n" \
-                "    nill  1,0xfff8\n" \
-                "    bras  2,0f\n"       /* skip indirect insns */ \
-                "    stctg 0,0,0(1)\n" \
-                "    lctlg 0,0,0(1)\n" \
-                "0:  ex    %1,0(2)\n"    /* execute stctl */ \
-                "    lg    0,0(1)\n" \
-                "    ogr   0,%2\n"       /* set the bit */ \
-                "    stg   0,0(1)\n" \
-                "1:  ex    %1,6(2)"      /* execute lctl */ \
-                : "=m" (__dummy) : "a" (cr*17), "a" (1L<<(bit)) \
-                : "cc", "0", "1", "2"); \
+                "    bras  1,0f\n"       /* skip indirect insns */ \
+                "    stctg 0,0,0(%1)\n" \
+                "    lctlg 0,0,0(%1)\n" \
+                "0:  ex    %2,0(1)\n"    /* execute stctl */ \
+                "    lg    0,0(%1)\n" \
+                "    ogr   0,%3\n"       /* set the bit */ \
+                "    stg   0,0(%1)\n" \
+                "1:  ex    %2,6(1)"      /* execute lctl */ \
+                : "=m" (__dummy) \
+		: "a" ((((unsigned long) &__dummy) + 7) & ~7UL), \
+		  "a" (cr*17), "a" (1L<<(bit)) \
+                : "cc", "0", "1" ); \
         })
 
 #define __ctl_clear_bit(cr, bit) ({ \
-        __u8 __dummy[24]; \
+        __u8 __dummy[16]; \
         __asm__ __volatile__ ( \
-                "    la    1,%0\n"       /* align to 8 byte */ \
-                "    aghi  1,7\n" \
-                "    nill  1,0xfff8\n" \
-                "    bras  2,0f\n"       /* skip indirect insns */ \
-                "    stctg 0,0,0(1)\n" \
-                "    lctlg 0,0,0(1)\n" \
-                "0:  ex    %1,0(2)\n"    /* execute stctl */ \
-                "    lg    0,0(1)\n" \
-                "    ngr   0,%2\n"       /* set the bit */ \
-                "    stg   0,0(1)\n" \
-                "1:  ex    %1,6(2)"      /* execute lctl */ \
-                : "=m" (__dummy) : "a" (cr*17), "a" (~(1L<<(bit))) \
-                : "cc", "0", "1", "2"); \
+                "    bras  1,0f\n"       /* skip indirect insns */ \
+                "    stctg 0,0,0(%1)\n" \
+                "    lctlg 0,0,0(%1)\n" \
+                "0:  ex    %2,0(1)\n"    /* execute stctl */ \
+                "    lg    0,0(%1)\n" \
+                "    ngr   0,%3\n"       /* set the bit */ \
+                "    stg   0,0(%1)\n" \
+                "1:  ex    %2,6(1)"      /* execute lctl */ \
+                : "=m" (__dummy) \
+		: "a" ((((unsigned long) &__dummy) + 7) & ~7UL), \
+		  "a" (cr*17), "a" (~(1L<<(bit))) \
+                : "cc", "0", "1" ); \
         })
 
 #else /* __s390x__ */
@@ -360,58 +353,52 @@
 
 #define __ctl_load(array, low, high) ({ \
 	__asm__ __volatile__ ( \
-		"   la    1,%0\n" \
-		"   bras  2,0f\n" \
-                "   lctl 0,0,0(1)\n" \
-		"0: ex    %1,0(2)" \
-		: : "m" (array), "a" (((low)<<4)+(high)) : "1", "2" ); \
+		"   bras  1,0f\n" \
+                "   lctl 0,0,0(%0)\n" \
+		"0: ex    %1,0(1)" \
+		: : "a" (&array), "a" (((low)<<4)+(high)) : "1" ); \
 	})
 
 #define __ctl_store(array, low, high) ({ \
 	__asm__ __volatile__ ( \
-		"   la    1,%0\n" \
-		"   bras  2,0f\n" \
-		"   stctl 0,0,0(1)\n" \
-		"0: ex    %1,0(2)" \
-		: "=m" (array) : "a" (((low)<<4)+(high)): "1", "2" ); \
+		"   bras  1,0f\n" \
+		"   stctl 0,0,0(%1)\n" \
+		"0: ex    %2,0(1)" \
+		: "=m" (array) : "a" (&array), "a" (((low)<<4)+(high)): "1" ); \
 	})
 
 #define __ctl_set_bit(cr, bit) ({ \
         __u8 __dummy[16]; \
         __asm__ __volatile__ ( \
-                "    la    1,%0\n"       /* align to 8 byte */ \
-                "    ahi   1,7\n" \
-                "    srl   1,3\n" \
-                "    sll   1,3\n" \
-                "    bras  2,0f\n"       /* skip indirect insns */ \
-                "    stctl 0,0,0(1)\n" \
-                "    lctl  0,0,0(1)\n" \
-                "0:  ex    %1,0(2)\n"    /* execute stctl */ \
-                "    l     0,0(1)\n" \
-                "    or    0,%2\n"       /* set the bit */ \
-                "    st    0,0(1)\n" \
-                "1:  ex    %1,4(2)"      /* execute lctl */ \
-                : "=m" (__dummy) : "a" (cr*17), "a" (1<<(bit)) \
-                : "cc", "0", "1", "2"); \
+                "    bras  1,0f\n"       /* skip indirect insns */ \
+                "    stctl 0,0,0(%1)\n" \
+                "    lctl  0,0,0(%1)\n" \
+                "0:  ex    %2,0(1)\n"    /* execute stctl */ \
+                "    l     0,0(%1)\n" \
+                "    or    0,%3\n"       /* set the bit */ \
+                "    st    0,0(%1)\n" \
+                "1:  ex    %2,4(1)"      /* execute lctl */ \
+                : "=m" (__dummy) \
+		: "a" ((((unsigned long) &__dummy) + 7) & ~7UL), \
+		  "a" (cr*17), "a" (1<<(bit)) \
+                : "cc", "0", "1" ); \
         })
 
 #define __ctl_clear_bit(cr, bit) ({ \
         __u8 __dummy[16]; \
         __asm__ __volatile__ ( \
-                "    la    1,%0\n"       /* align to 8 byte */ \
-                "    ahi   1,7\n" \
-                "    srl   1,3\n" \
-                "    sll   1,3\n" \
-                "    bras  2,0f\n"       /* skip indirect insns */ \
-                "    stctl 0,0,0(1)\n" \
-                "    lctl  0,0,0(1)\n" \
-                "0:  ex    %1,0(2)\n"    /* execute stctl */ \
-                "    l     0,0(1)\n" \
-                "    nr    0,%2\n"       /* set the bit */ \
-                "    st    0,0(1)\n" \
-                "1:  ex    %1,4(2)"      /* execute lctl */ \
-                : "=m" (__dummy) : "a" (cr*17), "a" (~(1<<(bit))) \
-                : "cc", "0", "1", "2"); \
+                "    bras  1,0f\n"       /* skip indirect insns */ \
+                "    stctl 0,0,0(%1)\n" \
+                "    lctl  0,0,0(%1)\n" \
+                "0:  ex    %2,0(1)\n"    /* execute stctl */ \
+                "    l     0,0(%1)\n" \
+                "    nr    0,%3\n"       /* set the bit */ \
+                "    st    0,0(%1)\n" \
+                "1:  ex    %2,4(1)"      /* execute lctl */ \
+                : "=m" (__dummy) \
+		: "a" ((((unsigned long) &__dummy) + 7) & ~7UL), \
+		  "a" (cr*17), "a" (~(1<<(bit))) \
+                : "cc", "0", "1" ); \
         })
 #endif /* __s390x__ */
 
diff -urN linux-2.5.68/include/asm-s390/tlbflush.h linux-2.5.68-s390/include/asm-s390/tlbflush.h
--- linux-2.5.68/include/asm-s390/tlbflush.h	Sun Apr 20 04:51:13 2003
+++ linux-2.5.68-s390/include/asm-s390/tlbflush.h	Fri May  2 14:06:44 2003
@@ -76,13 +76,16 @@
 	}
 #endif /* __s390x__ */
 	{
-		long dummy = 0;
+		register unsigned long addr asm("4");
+		long dummy;
+
+		dummy = 0;
+		addr = ((unsigned long) &dummy) + 1;
 		__asm__ __volatile__ (
-			"    la   4,1(%0)\n"
 			"    slr  2,2\n"
 			"    slr  3,3\n"
-			"    csp  2,4"
-			: : "a" (&dummy) : "cc", "2", "3", "4" );
+			"    csp  2,%0"
+			: : "a" (addr) : "cc", "2", "3" );
 	}
 }
 
diff -urN linux-2.5.68/include/asm-s390/uaccess.h linux-2.5.68-s390/include/asm-s390/uaccess.h
--- linux-2.5.68/include/asm-s390/uaccess.h	Sun Apr 20 04:48:54 2003
+++ linux-2.5.68-s390/include/asm-s390/uaccess.h	Fri May  2 14:06:44 2003
@@ -113,82 +113,83 @@
 
 #define __put_user_asm_8(x, ptr, err) \
 ({								\
+	register __typeof__(x) const * __from asm("2");		\
+	register __typeof__(*(ptr)) * __to asm("4");		\
+	__from = &(x);						\
+	__to = (ptr);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  2,%2\n"				\
-		"   la	  4,%1\n"				\
 		"   sacf  512\n"				\
-		"0: mvc	  0(8,4),0(2)\n"			\
+		"0: mvc	  0(8,%1),0(%2)\n"			\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err)					\
-		: "m" (*(__u64*)(ptr)), "m" (x), "K" (-EFAULT)	\
-		: "cc", "2", "4" );				\
+		: "a" (__to),"a" (__from),"K" (-EFAULT),"0" (0)	\
+		: "cc" );					\
 })
 
 #else /* __s390x__ */
 
 #define __put_user_asm_8(x, ptr, err) \
 ({								\
+	register __typeof__(*(ptr)) * __ptr asm("4");		\
+	__ptr = (ptr);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  4,%1\n"				\
 		"   sacf  512\n"				\
-		"0: stg	  %2,0(4)\n"				\
+		"0: stg	  %2,0(%1)\n"				\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err)					\
-		: "m" (*(__u64*)(ptr)), "d" (x), "K" (-EFAULT)	\
-		: "cc", "4" );					\
+		: "a" (__ptr), "d" (x), "K" (-EFAULT), "0" (0)	\
+		: "cc" );					\
 })
 
 #endif /* __s390x__ */
 
 #define __put_user_asm_4(x, ptr, err) \
 ({								\
+	register __typeof__(*(ptr)) * __ptr asm("4");		\
+	__ptr = (ptr);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  4,%1\n"				\
 		"   sacf  512\n"				\
-		"0: st	  %2,0(4)\n"				\
+		"0: st	  %2,0(%1)\n"				\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err)					\
-		: "m" (*(__u32*)(ptr)), "d" (x), "K" (-EFAULT)	\
-		: "cc", "4" );					\
+		: "a" (__ptr), "d" (x), "K" (-EFAULT), "0" (0)	\
+		: "cc" );					\
 })
 
 #define __put_user_asm_2(x, ptr, err) \
 ({								\
+	register __typeof__(*(ptr)) * __ptr asm("4");		\
+	__ptr = (ptr);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  4,%1\n"				\
 		"   sacf  512\n"				\
-		"0: sth	  %2,0(4)\n"				\
+		"0: sth	  %2,0(%1)\n"				\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err)					\
-		: "m" (*(__u16*)(ptr)), "d" (x), "K" (-EFAULT)	\
-		: "cc", "4" );					\
+		: "a" (__ptr), "d" (x), "K" (-EFAULT), "0" (0)	\
+		: "cc" );					\
 })
 
 #define __put_user_asm_1(x, ptr, err) \
 ({								\
+	register __typeof__(*(ptr)) * __ptr asm("4");		\
+	__ptr = (ptr);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  4,%1\n"				\
 		"   sacf  512\n"				\
-		"0: stc	  %2,0(4)\n"				\
+		"0: stc	  %2,0(%1)\n"				\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err)					\
-		: "m" (*(__u8*)(ptr)), "d" (x),	"K" (-EFAULT)	\
-		: "cc", "4" );					\
+		: "a" (__ptr), "d" (x),	"K" (-EFAULT), "0" (0)	\
+		: "cc" );					\
 })
 
 #define __put_user(x, ptr) \
@@ -223,35 +224,36 @@
 
 #define __get_user_asm_8(x, ptr, err) \
 ({								\
+	register __typeof__(*(ptr)) const * __from asm("2");	\
+	register __typeof__(x) * __to asm("4");			\
+	__from = (ptr);						\
+	__to = &(x);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  2,%1\n"				\
-		"   la	  4,%2\n"				\
 		"   sacf  512\n"				\
-		"0: mvc	  0(8,2),0(4)\n"			\
+		"0: mvc	  0(8,%1),0(%2)\n"			\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err), "=m" (x)				\
-		: "m" (*(const __u64*)(ptr)),"K" (-EFAULT)	\
-		: "cc", "2", "4" );				\
+		: "a" (__to),"a" (__from),"K" (-EFAULT),"0" (0)	\
+		: "cc" );					\
 })
 
 #else /* __s390x__ */
 
 #define __get_user_asm_8(x, ptr, err) \
 ({								\
+	register __typeof__(*(ptr)) const * __ptr asm("4");	\
+	__ptr = (ptr);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  4,%2\n"				\
 		"   sacf  512\n"				\
-		"0: lg	  %1,0(4)\n"				\
+		"0: lg	  %1,0(%2)\n"				\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err), "=d" (x)				\
-		: "m" (*(const __u64*)(ptr)),"K" (-EFAULT)	\
-		: "cc", "4" );					\
+		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
+		: "cc" );					\
 })
 
 #endif /* __s390x__ */
@@ -259,48 +261,48 @@
 
 #define __get_user_asm_4(x, ptr, err) \
 ({								\
+	register __typeof__(*(ptr)) const * __ptr asm("4");	\
+	__ptr = (ptr);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  4,%2\n"				\
 		"   sacf  512\n"				\
-		"0: l	  %1,0(4)\n"				\
+		"0: l	  %1,0(%2)\n"				\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err), "=d" (x)				\
-		: "m" (*(const __u32*)(ptr)),"K" (-EFAULT)	\
-		: "cc", "4" );					\
+		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
+		: "cc" );					\
 })
 
 #define __get_user_asm_2(x, ptr, err) \
 ({								\
+	register __typeof__(*(ptr)) const * __ptr asm("4");	\
+	__ptr = (ptr);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  4,%2\n"				\
 		"   sacf  512\n"				\
-		"0: lh	  %1,0(4)\n"				\
+		"0: lh	  %1,0(%2)\n"				\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err), "=d" (x)				\
-		: "m" (*(const __u16*)(ptr)),"K" (-EFAULT)	\
-		: "cc", "4" );					\
+		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
+		: "cc" );					\
 })
 
 #define __get_user_asm_1(x, ptr, err) \
 ({								\
+	register __typeof__(*(ptr)) const * __ptr asm("4");	\
+	__ptr = (ptr);						\
 	__asm__ __volatile__ (					\
-		"   sr	  %0,%0\n"				\
-		"   la	  4,%2\n"				\
 		"   sr	  %1,%1\n"				\
 		"   sacf  512\n"				\
-		"0: ic	  %1,0(4)\n"				\
+		"0: ic	  %1,0(%2)\n"				\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err), "=d" (x)				\
-		: "m" (*(const __u8*)(ptr)),"K" (-EFAULT)	\
-		: "cc", "4" );					\
+		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
+		: "cc" );					\
 })
 
 #define __get_user(x, ptr)					\
