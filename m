Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbUCZShz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264119AbUCZShz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:37:55 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6579 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S264123AbUCZSVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:21:55 -0500
Date: Fri, 26 Mar 2004 19:21:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (7/7): system call speedup part 2.
Message-ID: <20040326182141.GH2523@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System call speedup part 2.

diffstat:
 include/asm-s390/elf.h         |   26 +
 include/asm-s390/lowcore.h     |   27 +
 include/asm-s390/mmu_context.h |   22 -
 include/asm-s390/processor.h   |    9 
 include/asm-s390/ptrace.h      |   10 
 include/asm-s390/system.h      |   19 +
 include/asm-s390/uaccess.h     |  603 +++++++++++++----------------------------
 7 files changed, 278 insertions(+), 438 deletions(-)

diff -urN linux-2.6/include/asm-s390/elf.h linux-2.6-s390/include/asm-s390/elf.h
--- linux-2.6/include/asm-s390/elf.h	Thu Mar 11 03:55:44 2004
+++ linux-2.6-s390/include/asm-s390/elf.h	Fri Mar 26 18:26:00 2004
@@ -155,9 +155,31 @@
 /* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
    now struct_user_regs, they are different) */
 
-#define ELF_CORE_COPY_REGS(pr_reg, regs)	\
-	memcpy(&pr_reg,regs,sizeof(elf_gregset_t)); \
+static inline int dump_regs(struct pt_regs *ptregs, elf_gregset_t *regs)
+{
+	memcpy(&regs->psw, &ptregs->psw, sizeof(regs->psw)+sizeof(regs->gprs));
+	regs->orig_gpr2 = ptregs->orig_gpr2;
+	return 1;
+}
 
+#define ELF_CORE_COPY_REGS(pr_reg, regs) dump_regs(regs, &pr_reg);
+
+static inline int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
+{
+	dump_regs(__KSTK_PTREGS(tsk), regs);
+	memcpy(regs->acrs, tsk->thread.acrs, sizeof(regs->acrs));
+	return 1;
+}
+
+#define ELF_CORE_COPY_TASK_REGS(tsk, regs) dump_task_regs(tsk, regs)
+
+static inline int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
+{
+	memcpy(fpregs, &tsk->thread.fp_regs, sizeof(elf_fpregset_t));
+	return 1;
+}
+
+#define ELF_CORE_COPY_FPREGS(tsk, fpregs) dump_task_fpu(tsk, fpregs)
 
 
 /* This yields a mask that user programs can use to figure out what
diff -urN linux-2.6/include/asm-s390/lowcore.h linux-2.6-s390/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	Fri Mar 26 18:24:56 2004
+++ linux-2.6-s390/include/asm-s390/lowcore.h	Fri Mar 26 18:26:00 2004
@@ -64,7 +64,10 @@
 
 #ifndef __s390x__
 #define __LC_KERNEL_STACK               0xC40
-#define __LC_ASYNC_STACK                0xC44
+#define __LC_THREAD_INFO		0xC44
+#define __LC_ASYNC_STACK                0xC48
+#define __LC_KERNEL_ASCE		0xC4C
+#define __LC_USER_ASCE			0xC50
 #define __LC_CPUID                      0xC60
 #define __LC_CPUADDR                    0xC68
 #define __LC_IPLDEV                     0xC7C
@@ -73,13 +76,16 @@
 #define __LC_INT_CLOCK			0xC98
 #else /* __s390x__ */
 #define __LC_KERNEL_STACK               0xD40
-#define __LC_ASYNC_STACK                0xD48
+#define __LC_THREAD_INFO		0xD48
+#define __LC_ASYNC_STACK                0xD50
+#define __LC_KERNEL_ASCE		0xD58
+#define __LC_USER_ASCE			0xD60
 #define __LC_CPUID                      0xD90
 #define __LC_CPUADDR                    0xD98
 #define __LC_IPLDEV                     0xDB8
 #define __LC_JIFFY_TIMER		0xDC0
 #define __LC_CURRENT			0xDD8
-#define __LC_INT_CLOCK			0xDE8
+#define __LC_INT_CLOCK			0xDe8
 #endif /* __s390x__ */
 
 #define __LC_PANIC_MAGIC                0xE00
@@ -99,7 +105,6 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/types.h>
-#include <asm/atomic.h>
 #include <asm/sigp.h>
 
 void restart_int_handler(void);
@@ -167,9 +172,12 @@
         /* System info area */
 	__u32        save_area[16];            /* 0xc00 */
 	__u32        kernel_stack;             /* 0xc40 */
-	__u32        async_stack;              /* 0xc44 */
+	__u32        thread_info;              /* 0xc44 */
+	__u32        async_stack;              /* 0xc48 */
+	__u32        kernel_asce;              /* 0xc4c */
+	__u32        user_asce;                /* 0xc50 */
+	__u8         pad10[0xc60-0xc54];       /* 0xc54 */
 	/* entry.S sensitive area start */
-	__u8         pad10[0xc60-0xc48];       /* 0xc5c */
 	struct       cpuinfo_S390 cpu_data;    /* 0xc60 */
 	__u32        ipl_device;               /* 0xc7c */
 	/* entry.S sensitive area end */
@@ -245,9 +253,12 @@
 	__u64        save_area[16];            /* 0xc00 */
         __u8         pad9[0xd40-0xc80];        /* 0xc80 */
  	__u64        kernel_stack;             /* 0xd40 */
-	__u64        async_stack;              /* 0xd48 */
+	__u64        thread_info;              /* 0xd48 */
+	__u64        async_stack;              /* 0xd50 */
+	__u64        kernel_asce;              /* 0xd58 */
+	__u64        user_asce;                /* 0xd60 */
+	__u8         pad10[0xd80-0xd68];       /* 0xd68 */
 	/* entry.S sensitive area start */
-	__u8         pad10[0xd80-0xd50];       /* 0xd64 */
 	struct       cpuinfo_S390 cpu_data;    /* 0xd80 */
 	__u32        ipl_device;               /* 0xdb8 */
 	__u32        pad11;                    /* 0xdbc */
diff -urN linux-2.6/include/asm-s390/mmu_context.h linux-2.6-s390/include/asm-s390/mmu_context.h
--- linux-2.6/include/asm-s390/mmu_context.h	Thu Mar 11 03:55:26 2004
+++ linux-2.6-s390/include/asm-s390/mmu_context.h	Fri Mar 26 18:26:00 2004
@@ -24,22 +24,19 @@
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
                              struct task_struct *tsk)
 {
-        unsigned long pgd;
-
         if (prev != next) {
 #ifndef __s390x__
-	        pgd = (__pa(next->pgd)&PAGE_MASK) | 
+	        S390_lowcore.user_asce = (__pa(next->pgd)&PAGE_MASK) | 
                       (_SEGMENT_TABLE|USER_STD_MASK);
-                /* Load page tables */
-                asm volatile("    lctl  7,7,%0\n"   /* secondary space */
-                             "    lctl  13,13,%0\n" /* home space */
-                             : : "m" (pgd) );
+                /* Load home space page table origin. */
+                asm volatile("lctl  13,13,%0"
+			     : : "m" (S390_lowcore.user_asce) );
 #else /* __s390x__ */
-                pgd = (__pa(next->pgd)&PAGE_MASK) | (_REGION_TABLE|USER_STD_MASK);
-                /* Load page tables */
-                asm volatile("    lctlg 7,7,%0\n"   /* secondary space */
-                             "    lctlg 13,13,%0\n" /* home space */
-                             : : "m" (pgd) );
+                S390_lowcore.user_asce = (__pa(next->pgd) & PAGE_MASK) |
+			(_REGION_TABLE|USER_STD_MASK);
+		/* Load home space page table origin. */
+		asm volatile("lctlg  13,13,%0"
+			     : : "m" (S390_lowcore.user_asce) );
 #endif /* __s390x__ */
         }
 	cpu_set(smp_processor_id(), next->cpu_vm_mask);
@@ -51,6 +48,7 @@
                                struct mm_struct *next)
 {
         switch_mm(prev, next, current);
+	set_fs(current->thread.mm_segment);
 }
 
 #endif
diff -urN linux-2.6/include/asm-s390/processor.h linux-2.6-s390/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	Thu Mar 11 03:55:27 2004
+++ linux-2.6-s390/include/asm-s390/processor.h	Fri Mar 26 18:26:00 2004
@@ -82,10 +82,10 @@
  */
 struct thread_struct {
 	s390_fp_regs fp_regs;
-	unsigned int ar2;		/* kernel access register 2         */
-        unsigned int ar4;               /* kernel access register 4         */
+	unsigned int  acrs[NUM_ACRS];
         unsigned long ksp;              /* kernel stack pointer             */
         unsigned long user_seg;         /* HSTD                             */
+	mm_segment_t mm_segment;
         unsigned long prot_addr;        /* address of protection-excep.     */
         unsigned int error_code;        /* error-code of last prog-excep.   */
         unsigned int trap_no;
@@ -106,9 +106,10 @@
 
 #define INIT_THREAD {{0,{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},	       \
 			    {0},{0},{0},{0},{0},{0}}},			       \
-		     0, 0,						       \
+		     {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},	       \
 		     sizeof(init_stack) + (unsigned long) &init_stack,	       \
 		     __SWAPPER_PG_DIR,					       \
+		     {0},						       \
 		     0,0,0,						       \
 		     (per_struct) {{{{0,}}},0,0,0,0,{{0,}}},		       \
 		     0, 0						       \
@@ -167,7 +168,7 @@
 
 unsigned long get_wchan(struct task_struct *p);
 #define __KSTK_PTREGS(tsk) ((struct pt_regs *) \
-        (((unsigned long) tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs)) & -8L))
+        ((unsigned long) tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs)))
 #define KSTK_EIP(tsk)	(__KSTK_PTREGS(tsk)->psw.addr)
 #define KSTK_ESP(tsk)	(__KSTK_PTREGS(tsk)->gprs[15])
 
diff -urN linux-2.6/include/asm-s390/ptrace.h linux-2.6-s390/include/asm-s390/ptrace.h
--- linux-2.6/include/asm-s390/ptrace.h	Fri Mar 26 18:24:56 2004
+++ linux-2.6-s390/include/asm-s390/ptrace.h	Fri Mar 26 18:26:00 2004
@@ -286,10 +286,7 @@
 	 ((NEW) & (PSW_MASK_CC|PSW_MASK_PM)))
 
 /*
- * The first entries in pt_regs and user_regs_struct
- * are common for the two structures. The s390_regs structure
- * covers the common parts. It simplifies copying the common part
- * between the three structures.
+ * The s390_regs structure is used to define the elf_gregset_t.
  */
 typedef struct
 {
@@ -299,6 +296,7 @@
 	unsigned long orig_gpr2;
 } s390_regs;
 
+#ifdef __KERNEL__
 /*
  * The pt_regs struct defines the way the registers are stored on
  * the stack during a system call.
@@ -307,11 +305,11 @@
 {
 	psw_t psw;
 	unsigned long gprs[NUM_GPRS];
-	unsigned int  acrs[NUM_ACRS];
 	unsigned long orig_gpr2;
 	unsigned short ilc;
 	unsigned short trap;
-} __attribute__ ((packed));
+};
+#endif
 
 /*
  * Now for the program event recording (trace) definitions.
diff -urN linux-2.6/include/asm-s390/system.h linux-2.6-s390/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	Thu Mar 11 03:55:54 2004
+++ linux-2.6-s390/include/asm-s390/system.h	Fri Mar 26 18:26:00 2004
@@ -83,14 +83,33 @@
 		: : "a" (fpregs), "m" (*fpregs) );
 }
 
+static inline void save_access_regs(unsigned int *acrs)
+{
+	asm volatile ("stam 0,15,0(%0)" : : "a" (acrs) : "memory" );
+}
+
+static inline void restore_access_regs(unsigned int *acrs)
+{
+	asm volatile ("lam 0,15,0(%0)" : : "a" (acrs) );
+}
+
 #define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
+	save_access_regs(&prev->thread.acrs[0]);			     \
+	restore_access_regs(&next->thread.acrs[0]);			     \
 	prev = __switch_to(prev,next);					     \
 } while (0)
 
+#define prepare_arch_switch(rq, next)	do { } while(0)
+#define task_running(rq, p)		((rq)->curr == (p))
+#define finish_arch_switch(rq, prev) do {				     \
+	set_fs(current->thread.mm_segment);				     \
+	spin_unlock_irq(&(rq)->lock);					     \
+} while (0)
+
 #define nop() __asm__ __volatile__ ("nop")
 
 #define xchg(ptr,x) \
diff -urN linux-2.6/include/asm-s390/uaccess.h linux-2.6-s390/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	Thu Mar 11 03:55:23 2004
+++ linux-2.6-s390/include/asm-s390/uaccess.h	Fri Mar 26 18:26:00 2004
@@ -36,10 +36,27 @@
 #define USER_DS         MAKE_MM_SEG(1)
 
 #define get_ds()        (KERNEL_DS)
-#define get_fs()        ({ mm_segment_t __x; \
-			   asm volatile("ear   %0,4":"=a" (__x)); \
-			   __x;})
-#define set_fs(x)       ({asm volatile("sar   4,%0"::"a" ((x).ar4));})
+#define get_fs()        (current->thread.mm_segment)
+
+#ifdef __s390x__
+#define set_fs(x) \
+({									\
+	unsigned long __pto;						\
+	current->thread.mm_segment = (x);				\
+	__pto = current->thread.mm_segment.ar4 ?			\
+		S390_lowcore.user_asce : S390_lowcore.kernel_asce;	\
+	asm volatile ("lctlg 7,7,%0" : : "m" (__pto) );			\
+})
+#else
+#define set_fs(x) \
+({									\
+	unsigned long __pto;						\
+	current->thread.mm_segment = (x);				\
+	__pto = current->thread.mm_segment.ar4 ?			\
+		S390_lowcore.user_asce : S390_lowcore.kernel_asce;	\
+	asm volatile ("lctl  7,7,%0" : : "m" (__pto) );			\
+})
+#endif
 
 #define segment_eq(a,b) ((a).ar4 == (b).ar4)
 
@@ -71,126 +88,64 @@
         unsigned long insn, fixup;
 };
 
-/*
- * Standard fixup section for uaccess inline functions.
- * local label 0: is the fault point
- * local label 1: is the return point
- * %0 is the error variable
- * %3 is the error value -EFAULT
- */
 #ifndef __s390x__
 #define __uaccess_fixup \
 	".section .fixup,\"ax\"\n"	\
-	"8: sacf  0\n"			\
-	"   lhi	  %0,%h3\n"		\
-	"   bras  4,9f\n"		\
-	"   .long 1b\n"			\
-	"9: l	  4,0(4)\n"		\
-	"   br	  4\n"			\
+	"2: lhi    %0,%4\n"		\
+	"   bras   1,3f\n"		\
+	"   .long  1b\n"		\
+	"3: l      1,0(1)\n"		\
+	"   br     1\n"			\
 	".previous\n"			\
 	".section __ex_table,\"a\"\n"	\
 	"   .align 4\n"			\
-	"   .long  0b,8b\n"		\
+	"   .long  0b,2b\n"		\
 	".previous"
+#define __uaccess_clobber "cc", "1"
 #else /* __s390x__ */
 #define __uaccess_fixup \
 	".section .fixup,\"ax\"\n"	\
-	"9: sacf  0\n"			\
-	"   lhi	  %0,%h3\n"		\
-	"   jg	  1b\n"			\
+	"2: lghi   %0,%4\n"		\
+	"   jg     1b\n"		\
 	".previous\n"			\
 	".section __ex_table,\"a\"\n"	\
 	"   .align 8\n"			\
-	"   .quad  0b,9b\n"		\
+	"   .quad  0b,2b\n"		\
 	".previous"
+#define __uaccess_clobber "cc"
 #endif /* __s390x__ */
 
 /*
  * These are the main single-value transfer routines.  They automatically
  * use the right size if we just have the right pointer type.
  */
-#ifndef __s390x__
-
-#define __put_user_asm_8(x, ptr, err) \
-({								\
-	register __typeof__(x) const * __from asm("2");		\
-	register __typeof__(*(ptr)) * __to asm("4");		\
-	__from = &(x);						\
-	__to = (ptr);						\
-	__asm__ __volatile__ (					\
-		"   sacf  512\n"				\
-		"0: mvc	  0(8,%1),0(%2)\n"			\
-		"   sacf  0\n"					\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "=&d" (err)					\
-		: "a" (__to),"a" (__from),"K" (-EFAULT),"0" (0),\
-		  "m" (x) : "cc" );				\
-})
-
-#else /* __s390x__ */
-
-#define __put_user_asm_8(x, ptr, err) \
-({								\
-	register __typeof__(*(ptr)) * __ptr asm("4");		\
-	__ptr = (ptr);						\
-	__asm__ __volatile__ (					\
-		"   sacf  512\n"				\
-		"0: stg	  %2,0(%1)\n"				\
-		"   sacf  0\n"					\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "=&d" (err)					\
-		: "a" (__ptr), "d" (x), "K" (-EFAULT), "0" (0)	\
-		: "cc" );					\
-})
-
-#endif /* __s390x__ */
-
-#define __put_user_asm_4(x, ptr, err) \
-({								\
-	register __typeof__(*(ptr)) * __ptr asm("4");		\
-	__ptr = (ptr);						\
-	__asm__ __volatile__ (					\
-		"   sacf  512\n"				\
-		"0: st	  %2,0(%1)\n"				\
-		"   sacf  0\n"					\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "=&d" (err)					\
-		: "a" (__ptr), "d" (x), "K" (-EFAULT), "0" (0)	\
-		: "cc" );					\
-})
-
-#define __put_user_asm_2(x, ptr, err) \
+#if __GNUC__ > 2
+#define __put_user_asm(x, ptr, err) \
 ({								\
-	register __typeof__(*(ptr)) * __ptr asm("4");		\
-	__ptr = (ptr);						\
-	__asm__ __volatile__ (					\
-		"   sacf  512\n"				\
-		"0: sth	  %2,0(%1)\n"				\
-		"   sacf  0\n"					\
+	err = 0;						\
+	asm volatile(						\
+		"0: mvcs  0(%1,%2),%3,%0\n"			\
 		"1:\n"						\
 		__uaccess_fixup					\
-		: "=&d" (err)					\
-		: "a" (__ptr), "d" (x), "K" (-EFAULT), "0" (0)	\
-		: "cc" );					\
+		: "+&d" (err)					\
+		: "d" (sizeof(*(ptr))), "a" (ptr), "Q" (x),	\
+		  "K" (-EFAULT)					\
+		: __uaccess_clobber );				\
 })
-
-#define __put_user_asm_1(x, ptr, err) \
+#else
+#define __put_user_asm(x, ptr, err) \
 ({								\
-	register __typeof__(*(ptr)) * __ptr asm("4");		\
-	__ptr = (ptr);						\
-	__asm__ __volatile__ (					\
-		"   sacf  512\n"				\
-		"0: stc	  %2,0(%1)\n"				\
-		"   sacf  0\n"					\
+	err = 0;						\
+	asm volatile(						\
+		"0: mvcs  0(%1,%2),0(%3),%0\n"			\
 		"1:\n"						\
 		__uaccess_fixup					\
-		: "=&d" (err)					\
-		: "a" (__ptr), "d" (x),	"K" (-EFAULT), "0" (0)	\
-		: "cc" );					\
+		: "+&d" (err)					\
+		: "d" (sizeof(*(ptr))), "a" (ptr), "a" (&(x)),	\
+		  "K" (-EFAULT), "m" (x)			\
+		: __uaccess_clobber );				\
 })
+#endif
 
 #define __put_user(x, ptr) \
 ({								\
@@ -198,16 +153,10 @@
 	int __pu_err;						\
 	switch (sizeof (*(ptr))) {				\
 	case 1:							\
-		__put_user_asm_1(__x, ptr, __pu_err);		\
-		break;						\
 	case 2:							\
-		__put_user_asm_2(__x, ptr, __pu_err);		\
-		break;						\
 	case 4:							\
-		__put_user_asm_4(__x, ptr, __pu_err);		\
-		break;						\
 	case 8:							\
-		__put_user_asm_8(__x, ptr, __pu_err);		\
+		__put_user_asm(__x, ptr, __pu_err);		\
 		break;						\
 	default:						\
 		__pu_err = __put_user_bad();			\
@@ -225,90 +174,33 @@
 
 extern int __put_user_bad(void);
 
-#ifndef __s390x__
-
-#define __get_user_asm_8(x, ptr, err) \
+#if __GNUC__ > 2
+#define __get_user_asm(x, ptr, err) \
 ({								\
-	register __typeof__(*(ptr)) const * __from asm("4");	\
-	register __typeof__(x) * __to asm("2");			\
-	__from = (ptr);						\
-	__to = &(x);						\
-	__asm__ __volatile__ (					\
-		"   sacf  512\n"				\
-		"0: mvc	  0(8,%2),0(%4)\n"			\
-		"   sacf  0\n"					\
+	err = 0;						\
+	asm volatile (						\
+		"0: mvcp  %O1(%2,%R1),0(%3),%0\n"		\
 		"1:\n"						\
 		__uaccess_fixup					\
-		: "=&d" (err), "=m" (x)				\
-		: "a" (__to),"K" (-EFAULT),"a" (__from),"0" (0)	\
-		: "cc" );					\
+		: "+&d" (err), "=Q" (x)				\
+		: "d" (sizeof(*(ptr))), "a" (ptr),		\
+		  "K" (-EFAULT)					\
+		: __uaccess_clobber );				\
 })
-
-#else /* __s390x__ */
-
-#define __get_user_asm_8(x, ptr, err) \
-({								\
-	register __typeof__(*(ptr)) const * __ptr asm("4");	\
-	__ptr = (ptr);						\
-	__asm__ __volatile__ (					\
-		"   sacf  512\n"				\
-		"0: lg	  %1,0(%2)\n"				\
-		"   sacf  0\n"					\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "=&d" (err), "=d" (x)				\
-		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
-		: "cc" );					\
-})
-
-#endif /* __s390x__ */
-
-
-#define __get_user_asm_4(x, ptr, err) \
-({								\
-	register __typeof__(*(ptr)) const * __ptr asm("4");	\
-	__ptr = (ptr);						\
-	__asm__ __volatile__ (					\
-		"   sacf  512\n"				\
-		"0: l	  %1,0(%2)\n"				\
-		"   sacf  0\n"					\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "=&d" (err), "=d" (x)				\
-		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
-		: "cc" );					\
-})
-
-#define __get_user_asm_2(x, ptr, err) \
-({								\
-	register __typeof__(*(ptr)) const * __ptr asm("4");	\
-	__ptr = (ptr);						\
-	__asm__ __volatile__ (					\
-		"   sacf  512\n"				\
-		"0: lh	  %1,0(%2)\n"				\
-		"   sacf  0\n"					\
-		"1:\n"						\
-		__uaccess_fixup					\
-		: "=&d" (err), "=d" (x)				\
-		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
-		: "cc" );					\
-})
-
-#define __get_user_asm_1(x, ptr, err) \
+#else
+#define __get_user_asm(x, ptr, err) \
 ({								\
-	register __typeof__(*(ptr)) const * __ptr asm("4");	\
-	__ptr = (ptr);						\
-	__asm__ __volatile__ (					\
-		"   sr	  %1,%1\n"				\
-		"   sacf  512\n"				\
-		"0: ic	  %1,0(%2)\n"				\
-		"   sacf  0\n"					\
+	err = 0;						\
+	asm volatile (						\
+		"0: mvcp  0(%2,%5),0(%3),%0\n"			\
 		"1:\n"						\
 		__uaccess_fixup					\
-		: "=&d" (err), "=&d" (x)			\
-		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
-		: "cc" );					\
+		: "+&d" (err), "=m" (x)				\
+		: "d" (sizeof(*(ptr))), "a" (ptr),		\
+		  "K" (-EFAULT), "a" (&(x))			\
+		: __uaccess_clobber );				\
 })
+#endif
 
 #define __get_user(x, ptr)					\
 ({								\
@@ -316,16 +208,10 @@
 	int __gu_err;						\
 	switch (sizeof(*(ptr))) {				\
 	case 1:							\
-		__get_user_asm_1(__x, ptr, __gu_err);		\
-		break;						\
 	case 2:							\
-		__get_user_asm_2(__x, ptr, __gu_err);		\
-		break;						\
 	case 4:							\
-		__get_user_asm_4(__x, ptr, __gu_err);		\
-		break;						\
 	case 8:							\
-		__get_user_asm_8(__x, ptr, __gu_err);		\
+		__get_user_asm(__x, ptr, __gu_err);		\
 		break;						\
 	default:						\
 		__x = 0;					\
@@ -344,149 +230,123 @@
 
 extern int __get_user_bad(void);
 
-/*
- * access register are set up, that 4 points to secondary (user),
- * 2 to primary (kernel)
- */
-
-extern long __copy_to_user_asm(const void *from, long n, const void *to);
+extern long __copy_to_user_asm(const void *from, long n, void *to);
 
-#define __copy_to_user(to, from, n)                             \
-({                                                              \
-        __copy_to_user_asm(from, n, to);                        \
-})
+/**
+ * __copy_to_user: - Copy a block of data into user space, with less checking.
+ * @to:   Destination address, in user space.
+ * @from: Source address, in kernel space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from kernel space to user space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ */
+static inline unsigned long
+__copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	return __copy_to_user_asm(from, n, to);
+}
 
-#define copy_to_user(to, from, n)                               \
-({                                                              \
-        long err = 0;                                           \
-        __typeof__(n) __n = (n);                                \
-        might_sleep();						\
-        if (__access_ok(to,__n)) {                              \
-                err = __copy_to_user_asm(from, __n, to);        \
-        }                                                       \
-        else                                                    \
-                err = __n;                                      \
-        err;                                                    \
-})
+/**
+ * copy_to_user: - Copy a block of data into user space.
+ * @to:   Destination address, in user space.
+ * @from: Source address, in kernel space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from kernel space to user space.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ */
+static inline unsigned long
+copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	might_sleep();
+	if (access_ok(VERIFY_WRITE, to, n))
+		n = __copy_to_user(to, from, n);
+	return n;
+}
 
 extern long __copy_from_user_asm(void *to, long n, const void *from);
 
-#define __copy_from_user(to, from, n)                           \
-({                                                              \
-        __copy_from_user_asm(to, n, from);                      \
-})
-
-#define copy_from_user(to, from, n)                             \
-({                                                              \
-        long err = 0;                                           \
-        __typeof__(n) __n = (n);                                \
-        might_sleep();						\
-        if (__access_ok(from,__n)) {                            \
-                err = __copy_from_user_asm(to, __n, from);      \
-        }                                                       \
-        else                                                    \
-                err = __n;                                      \
-        err;                                                    \
-})
-
-extern long __copy_in_user_asm(const void *from, long n, void *to);
-
-#define __copy_in_user(to, from, n)				\
-({								\
-	__copy_in_user_asm(from, n, to);			\
-})
-
-#define copy_in_user(to, from, n)				\
-({								\
-	long err = 0;						\
-	__typeof__(n) __n = (n);				\
-	might_sleep();						\
-	if (__access_ok(from,__n) && __access_ok(to,__n)) {	\
-		err = __copy_in_user_asm(from, __n, to);	\
-	}							\
-	else							\
-		err = __n;					\
-	err;							\
-})
+/**
+ * __copy_from_user: - Copy a block of data from user space, with less checking.
+ * @to:   Destination address, in kernel space.
+ * @from: Source address, in user space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from user space to kernel space.  Caller must check
+ * the specified block with access_ok() before calling this function.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ *
+ * If some data could not be copied, this function will pad the copied
+ * data to the requested size using zero bytes.
+ */
+static inline unsigned long
+__copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	return __copy_from_user_asm(to, n, from);
+}
 
-/*
- * Copy a null terminated string from userspace.
+/**
+ * copy_from_user: - Copy a block of data from user space.
+ * @to:   Destination address, in kernel space.
+ * @from: Source address, in user space.
+ * @n:    Number of bytes to copy.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Copy data from user space to kernel space.
+ *
+ * Returns number of bytes that could not be copied.
+ * On success, this will be zero.
+ *
+ * If some data could not be copied, this function will pad the copied
+ * data to the requested size using zero bytes.
  */
+static inline unsigned long
+copy_from_user(void *to, const void __user *from, unsigned long n)
+{
+	might_sleep();
+	if (access_ok(VERIFY_READ, from, n))
+		n = __copy_from_user(to, from, n);
+	else
+		memset(to, 0, n);
+	return n;
+}
 
-#ifndef __s390x__
+extern long __copy_in_user_asm(const void *from, long n, void *to);
 
-static inline long
-__strncpy_from_user(char *dst, const char *src, long count)
+static inline unsigned long
+__copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
-        int len;
-        __asm__ __volatile__ (
-		"   slr   %0,%0\n"
-		"   lr    2,%1\n"
-                "   lr    4,%2\n"
-                "   slr   3,3\n"
-                "   sacf  512\n"
-		"0: ic	  3,0(%0,4)\n"
-		"1: stc	  3,0(%0,2)\n"
-		"   ltr	  3,3\n"
-		"   jz	  2f\n"
-		"   ahi	  %0,1\n"
-		"   clr	  %0,%3\n"
-		"   jl	  0b\n"
-		"2: sacf  0\n"
-		".section .fixup,\"ax\"\n"
-		"3: lhi	  %0,%h4\n"
-		"   basr  3,0\n"
-		"   l	  3,4f-.(3)\n"
-		"   br	  3\n"
-		"4: .long 2b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"   .align 4\n"
-		"   .long  0b,3b\n"
-		"   .long  1b,3b\n"
-		".previous"
-		: "=&a" (len)
-		: "a" (dst), "d" (src), "d" (count), "K" (-EFAULT)
-		: "2", "3", "4", "memory", "cc" );
-	return len;
+	__copy_in_user_asm(from, n, to);
 }
 
-#else /* __s390x__ */
-
-static inline long
-__strncpy_from_user(char *dst, const char *src, long count)
+static inline unsigned long
+copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
-	long len;
-	__asm__ __volatile__ (
-		"   slgr  %0,%0\n"
-		"   lgr	  2,%1\n"
-		"   lgr	  4,%2\n"
-		"   slr	  3,3\n"
-		"   sacf  512\n"
-		"0: ic	  3,0(%0,4)\n"
-		"1: stc	  3,0(%0,2)\n"
-		"   ltr	  3,3\n"
-		"   jz	  2f\n"
-		"   aghi  %0,1\n"
-		"   cgr	  %0,%3\n"
-		"   jl	  0b\n"
-		"2: sacf  0\n"
-		".section .fixup,\"ax\"\n"
-		"3: lghi  %0,%h4\n"
-		"   jg	  2b\n"	 
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"   .align 8\n"
-		"   .quad  0b,3b\n"
-		"   .quad  1b,3b\n"
-		".previous"
-		: "=&a" (len)
-		: "a"  (dst), "d" (src), "d" (count), "K" (-EFAULT)
-		: "cc", "2" ,"3", "4" );
-	return len;
+	might_sleep();
+	if (__access_ok(from,n) && __access_ok(to,n))
+		n = __copy_in_user_asm(from, n, to);
+	return n;
 }
 
-#endif /* __s390x__ */
+/*
+ * Copy a null terminated string from userspace.
+ */
+extern long __strncpy_from_user_asm(char *dst, const char *src, long count);
 
 static inline long
 strncpy_from_user(char *dst, const char *src, long count)
@@ -494,104 +354,34 @@
         long res = -EFAULT;
         might_sleep();
         if (access_ok(VERIFY_READ, src, 1))
-                res = __strncpy_from_user(dst, src, count);
+                res = __strncpy_from_user_asm(dst, src, count);
         return res;
 }
 
 
-/*
- * Return the size of a string (including the ending 0)
- *
- * Return 0 for error
- */
-#ifndef __s390x__
+extern long __strnlen_user_asm(const char *src, long count);
 
 static inline unsigned long
 strnlen_user(const char * src, unsigned long n)
 {
 	might_sleep();
-	__asm__ __volatile__ (
-		"   alr   %0,%1\n"
-		"   slr   0,0\n"
-		"   lr    4,%1\n"
-		"   sacf  512\n"
-		"0: srst  %0,4\n"
-		"   jo    0b\n"
-		"   slr   %0,%1\n"
-		"   ahi   %0,1\n"
-		"   sacf  0\n"
-		"1:\n"
-		".section .fixup,\"ax\"\n"
-		"2: sacf  0\n"
-		"   slr   %0,%0\n"
-		"   bras  4,3f\n"
-		"   .long 1b\n"
-		"3: l     4,0(4)\n"
-		"   br    4\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"  .align 4\n"
-		"  .long  0b,2b\n"
-		".previous"
-		: "+&a" (n) : "d" (src)
-		: "cc", "0", "4" );
-	return n;
+	return __strnlen_user_asm(src, n);
 }
 
-#else /* __s390x__ */
-
-static inline unsigned long
-strnlen_user(const char * src, unsigned long n)
-{
-	might_sleep();
-#if 0
-	__asm__ __volatile__ (
-		"   algr  %0,%1\n"
-		"   slgr  0,0\n"
-		"   lgr	  4,%1\n"
-		"   sacf  512\n"
-		"0: srst  %0,4\n"
-		"   jo	0b\n"
-		"   slgr  %0,%1\n"
-		"   aghi  %0,1\n"
-		"1: sacf  0\n"
-		".section .fixup,\"ax\"\n"
-		"2: slgr  %0,%0\n"
-		"   jg	  1b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"  .align 8\n"
-		"  .quad  0b,2b\n"
-		".previous"
-		: "+&a" (n) : "d" (src)
-		: "cc", "0", "4" );
-#else
-	__asm__ __volatile__ (
-		"   lgr	  4,%1\n"
-		"   sacf  512\n"
-		"0: cli   0(4),0x00\n"
-		"   la    4,1(4)\n"
-		"   je    1f\n"
-		"   brctg %0,0b\n"
-		"1: lgr	  %0,4\n"
-		"   slgr  %0,%1\n"
-		"2: sacf  0\n"
-		".section .fixup,\"ax\"\n"
-		"3: slgr  %0,%0\n"
-		"   jg    2b\n"  
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"  .align 8\n"
-		"  .quad  0b,3b\n"
-		".previous"
-		: "+&a" (n) : "d" (src)
-		: "cc", "4" );
-#endif
-	return n;
-}
-
-#endif /* __s390x__ */
-
+/**
+ * strlen_user: - Get the size of a string in user space.
+ * @str: The string to measure.
+ *
+ * Context: User context only.  This function may sleep.
+ *
+ * Get the size of a NUL-terminated string in user space.
+ *
+ * Returns the size of the string INCLUDING the terminating NUL.
+ * On exception, returns 0.
+ *
+ * If there is a limit on the length of a valid string, you may wish to
+ * consider using strnlen_user() instead.
+ */
 #define strlen_user(str) strnlen_user(str, ~0UL)
 
 /*
@@ -600,17 +390,18 @@
 
 extern long __clear_user_asm(void *to, long n);
 
-#define __clear_user(to, n)					\
-({								\
-	__clear_user_asm(to, n);				\
-})
+static inline unsigned long
+__clear_user(void *to, unsigned long n)
+{
+	return __clear_user_asm(to, n);
+}
 
 static inline unsigned long
 clear_user(void *to, unsigned long n)
 {
 	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
-		n = __clear_user(to, n);
+		n = __clear_user_asm(to, n);
 	return n;
 }
 
