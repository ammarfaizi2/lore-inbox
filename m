Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTDNSIG (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbTDNSIF (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:08:05 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:55273 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263610AbTDNRpl (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:45:41 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (16/16): s390/s390x unification - part 7.
Date: Mon, 14 Apr 2003 19:56:19 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304141954.35473.schwidefsky@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge s390x and s390 to one architecture.

diffstat:
 posix_types.h |   47 ++-
 processor.h   |  162 +++++++++---
 ptrace.h      |  234 +++++++++++++-----
 qdio.h        |    4 
 rwsem.h       |   81 ++++++
 sembuf.h      |    6 
 setup.h       |   24 +
 shmbuf.h      |    8 
 sigcontext.h  |   21 +
 signal.h      |    6 
 sigp.h        |   28 ++
 smp.h         |    4 
 spinlock.h    |  100 +++++++
 stat.h        |   30 ++
 statfs.h      |   13 +
 string.h      |   53 +++-
 system.h      |  102 +++++++-
 thread_info.h |   28 +-
 tlbflush.h    |   12 
 types.h       |   28 +-
 uaccess.h     |  734 +++++++++++++++++++++++++++++++---------------------------
 unistd.h      |  109 +++++++-
 22 files changed, 1331 insertions(+), 503 deletions(-)

diff -urN linux-2.5.67/include/asm-s390/posix_types.h linux-2.5.67-s390/include/asm-s390/posix_types.h
--- linux-2.5.67/include/asm-s390/posix_types.h	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/include/asm-s390/posix_types.h	Mon Apr 14 19:11:59 2003
@@ -15,18 +15,9 @@
  * assume GCC is being used.
  */
 
-typedef unsigned short  __kernel_dev_t;
-typedef unsigned long   __kernel_ino_t;
-typedef unsigned short  __kernel_mode_t;
-typedef unsigned short  __kernel_nlink_t;
 typedef long            __kernel_off_t;
 typedef int             __kernel_pid_t;
-typedef unsigned short  __kernel_ipc_pid_t;
-typedef unsigned short  __kernel_uid_t;
-typedef unsigned short  __kernel_gid_t;
 typedef unsigned long   __kernel_size_t;
-typedef int             __kernel_ssize_t;
-typedef int             __kernel_ptrdiff_t;
 typedef long            __kernel_time_t;
 typedef long            __kernel_suseconds_t;
 typedef long            __kernel_clock_t;
@@ -36,15 +27,45 @@
 typedef char *          __kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
 typedef unsigned short	__kernel_gid16_t;
+
+#ifdef __GNUC__
+typedef long long       __kernel_loff_t;
+#endif
+
+#ifndef __s390x__
+
+typedef unsigned short  __kernel_dev_t;
+typedef unsigned long   __kernel_ino_t;
+typedef unsigned short  __kernel_mode_t;
+typedef unsigned short  __kernel_nlink_t;
+typedef unsigned short  __kernel_ipc_pid_t;
+typedef unsigned short  __kernel_uid_t;
+typedef unsigned short  __kernel_gid_t;
+typedef int             __kernel_ssize_t;
+typedef int             __kernel_ptrdiff_t;
 typedef unsigned int	__kernel_uid32_t;
 typedef unsigned int	__kernel_gid32_t;
-
 typedef unsigned short	__kernel_old_uid_t;
 typedef unsigned short	__kernel_old_gid_t;
 
-#ifdef __GNUC__
-typedef long long       __kernel_loff_t;
-#endif
+#else /* __s390x__ */
+
+typedef unsigned int    __kernel_dev_t;
+typedef unsigned int    __kernel_ino_t;
+typedef unsigned int    __kernel_mode_t;
+typedef unsigned int    __kernel_nlink_t;
+typedef int             __kernel_ipc_pid_t;
+typedef unsigned int    __kernel_uid_t;
+typedef unsigned int    __kernel_gid_t;
+typedef long            __kernel_ssize_t;
+typedef long            __kernel_ptrdiff_t;
+typedef unsigned long   __kernel_sigset_t;      /* at least 32 bits */
+typedef __kernel_uid_t __kernel_old_uid_t;
+typedef __kernel_gid_t __kernel_old_gid_t;
+typedef __kernel_uid_t __kernel_uid32_t;
+typedef __kernel_gid_t __kernel_gid32_t;
+
+#endif /* __s390x__ */
 
 typedef struct {
 #if defined(__KERNEL__) || defined(__USE_ALL)
diff -urN linux-2.5.67/include/asm-s390/processor.h linux-2.5.67-s390/include/asm-s390/processor.h
--- linux-2.5.67/include/asm-s390/processor.h	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/include/asm-s390/processor.h	Mon Apr 14 19:11:59 2003
@@ -44,6 +44,9 @@
         __u16    cpu_nr;
         unsigned long loops_per_jiffy;
         unsigned long *pgd_quick;
+#ifdef __s390x__
+        unsigned long *pmd_quick;
+#endif /* __s390x__ */
         unsigned long *pte_quick;
         unsigned long pgtable_cache_sz;
 };
@@ -54,58 +57,90 @@
 extern struct task_struct *last_task_used_math;
 
 /*
- * User space process size: 2GB (default).
+ * User space process size: 2GB for 31 bit, 4TB for 64 bit.
  */
-#define TASK_SIZE       (0x80000000)
-/* This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE      (TASK_SIZE / 2)
+#ifndef __s390x__
+
+# define TASK_SIZE		(0x80000000UL)
+# define TASK_UNMAPPED_BASE	(TASK_SIZE / 2)
+
+#else /* __s390x__ */
+
+# define TASK_SIZE		(0x20000000000UL)
+# define TASK31_SIZE		(0x80000000UL)
+# define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
+					(TASK31_SIZE / 2) : (TASK_SIZE / 2))
+
+#endif /* __s390x__ */
 
 typedef struct {
         __u32 ar4;
 } mm_segment_t;
 
-/* if you change the thread_struct structure, you must
- * update the _TSS_* defines in entry.S
+/*
+ * Thread structure
  */
-
-struct thread_struct
- {
+struct thread_struct {
 	s390_fp_regs fp_regs;
-        __u32   ar2;                   /* kernel access register 2         */
-        __u32   ar4;                   /* kernel access register 4         */
-        __u32   ksp;                   /* kernel stack pointer             */
-        __u32   user_seg;              /* HSTD                             */
-        __u32   error_code;            /* error-code of last prog-excep.   */
-        __u32   prot_addr;             /* address of protection-excep.     */
-        __u32   trap_no;
-        per_struct per_info;/* Must be aligned on an 4 byte boundary*/
+	unsigned int ar2;		/* kernel access register 2         */
+        unsigned int ar4;               /* kernel access register 4         */
+        unsigned long ksp;              /* kernel stack pointer             */
+        unsigned long user_seg;         /* HSTD                             */
+        unsigned long prot_addr;        /* address of protection-excep.     */
+        unsigned int error_code;        /* error-code of last prog-excep.   */
+        unsigned int trap_no;
+        per_struct per_info;
 	/* Used to give failing instruction back to user for ieee exceptions */
-	addr_t  ieee_instruction_pointer; 
+	unsigned long ieee_instruction_pointer; 
         /* pfault_wait is used to block the process on a pfault event */
-	addr_t  pfault_wait;
+	unsigned long pfault_wait;
 };
 
 typedef struct thread_struct thread_struct;
 
-#define INIT_THREAD {{0,{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}, \
-			    {0},{0},{0},{0},{0},{0}}},            \
-                     0, 0,                                        \
-                    sizeof(init_stack) + (__u32) &init_stack,     \
-              (__pa((__u32) &swapper_pg_dir[0]) + _SEGMENT_TABLE),\
-                     0,0,0,                                       \
-                     (per_struct) {{{{0,}}},0,0,0,0,{{0,}}},      \
-                     0, 0                                         \
-}
+#ifndef __s390x__
+# define __SWAPPER_PG_DIR __pa(&swapper_pg_dir[0]) + _SEGMENT_TABLE
+#else /* __s390x__ */
+# define __SWAPPER_PG_DIR __pa(&swapper_pg_dir[0]) + _REGION_TABLE
+#endif /* __s390x__ */
+
+#define INIT_THREAD {{0,{{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},	       \
+			    {0},{0},{0},{0},{0},{0}}},			       \
+		     0, 0,						       \
+		     sizeof(init_stack) + (unsigned long) &init_stack,	       \
+		     __SWAPPER_PG_DIR,					       \
+		     0,0,0,						       \
+		     (per_struct) {{{{0,}}},0,0,0,0,{{0,}}},		       \
+		     0, 0						       \
+} 
+
+/*
+ * Do necessary setup to start up a new thread.
+ */
+#ifndef __s390x__
 
-/* need to define ... */
 #define start_thread(regs, new_psw, new_stackp) do {            \
         regs->psw.mask  = PSW_USER_BITS;                        \
-        regs->psw.addr  = new_psw | PSW_ADDR_AMODE31;           \
+        regs->psw.addr  = new_psw | PSW_ADDR_AMODE;             \
         regs->gprs[15]  = new_stackp ;                          \
 } while (0)
 
+#else /* __s390x__ */
+
+#define start_thread(regs, new_psw, new_stackp) do {            \
+        regs->psw.mask  = PSW_USER_BITS;                        \
+        regs->psw.addr  = new_psw;                              \
+        regs->gprs[15]  = new_stackp;                           \
+} while (0)
+
+#define start_thread31(regs, new_psw, new_stackp) do {          \
+	regs->psw.mask  = PSW_USER32_BITS;			\
+        regs->psw.addr  = new_psw;                              \
+        regs->gprs[15]  = new_stackp;                           \
+} while (0)
+
+#endif /* __s390x__ */
+
 /* Forward declaration, a strange C thing */
 struct task_struct;
 struct mm_struct;
@@ -129,14 +164,19 @@
 
 unsigned long get_wchan(struct task_struct *p);
 #define __KSTK_PTREGS(tsk) ((struct pt_regs *) \
-        (((addr_t) tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs)) & -8L))
+        (((unsigned long) tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs)) & -8L))
 #define KSTK_EIP(tsk)	(__KSTK_PTREGS(tsk)->psw.addr)
 #define KSTK_ESP(tsk)	(__KSTK_PTREGS(tsk)->gprs[15])
 
 /*
  * Give up the time slice of the virtual PU.
  */
-#define cpu_relax()	asm volatile ("diag 0,0,68" : : : "memory")
+#ifndef __s390x__
+# define cpu_relax()	asm volatile ("diag 0,0,68" : : : "memory")
+#else /* __s390x__ */
+# define cpu_relax() \
+	asm volatile ("ex 0,%0" : : "i" (__LC_DIAG44_OPCODE) : "memory")
+#endif /* __s390x__ */
 
 /*
  * Set PSW mask to specified value, while leaving the
@@ -150,13 +190,22 @@
 	psw_t psw;
 	psw.mask = mask;
 
+#ifndef __s390x__
 	asm volatile (
 		"    basr %0,0\n"
 		"0:  ahi  %0,1f-0b\n"
-		"    st   %0,4(%1)\n"
+		"    st	  %0,4(%1)\n"
 		"    lpsw 0(%1)\n"
 		"1:"
 		: "=&d" (addr) : "a" (&psw) : "memory", "cc" );
+#else /* __s390x__ */
+	asm volatile (
+		"    larl  %0,1f\n"
+		"    stg   %0,8(%1)\n"
+		"    lpswe 0(%1)\n"
+		"1:"
+		: "=&d" (addr) : "a" (&psw) : "memory", "cc" );
+#endif /* __s390x__ */
 }
  
 /*
@@ -169,6 +218,7 @@
 
 	wait_psw.mask = PSW_BASE_BITS | PSW_MASK_IO | PSW_MASK_EXT |
 		PSW_MASK_MCHECK | PSW_MASK_WAIT;
+#ifndef __s390x__
 	asm volatile (
 		"    basr %0,0\n"
 		"0:  la   %0,1f-0b(%0)\n"
@@ -177,6 +227,14 @@
 		"    lpsw 0(%1)\n"
 		"1:"
 		: "=&a" (reg) : "a" (&wait_psw) : "memory", "cc" );
+#else /* __s390x__ */
+	asm volatile (
+		"    larl  %0,0f\n"
+		"    stg   %0,8(%1)\n"
+		"    lpswe 0(%1)\n"
+		"0:"
+		: "=&a" (reg) : "a" (&wait_psw) : "memory", "cc" );
+#endif /* __s390x__ */
 }
 
 /*
@@ -196,7 +254,7 @@
          * Store status and then load disabled wait psw,
          * the processor is dead afterwards
          */
-
+#ifndef __s390x__
         asm volatile ("    stctl 0,0,0(%1)\n"
                       "    ni    0(%1),0xef\n" /* switch off protection */
                       "    lctl  0,0,0(%1)\n"
@@ -213,6 +271,38 @@
                       "    oi    0(%1),0x10\n" /* fake protection bit */
                       "    lpsw 0(%0)"
                       : : "a" (dw_psw), "a" (&ctl_buf) : "cc" );
+#else /* __s390x__ */
+        asm volatile ("    stctg 0,0,0(%1)\n"
+                      "    ni    4(%1),0xef\n" /* switch off protection */
+                      "    lctlg 0,0,0(%1)\n"
+                      "    lghi  1,0x1000\n"
+                      "    stpt  0x328(1)\n"      /* store timer */
+                      "    stckc 0x330(1)\n"      /* store clock comparator */
+                      "    stpx  0x318(1)\n"      /* store prefix register */
+                      "    stam  0,15,0x340(1)\n" /* store access registers */
+                      "    stfpc 0x31c(1)\n"      /* store fpu control */
+                      "    std   0,0x200(1)\n"    /* store f0 */
+                      "    std   1,0x208(1)\n"    /* store f1 */
+                      "    std   2,0x210(1)\n"    /* store f2 */
+                      "    std   3,0x218(1)\n"    /* store f3 */
+                      "    std   4,0x220(1)\n"    /* store f4 */
+                      "    std   5,0x228(1)\n"    /* store f5 */
+                      "    std   6,0x230(1)\n"    /* store f6 */
+                      "    std   7,0x238(1)\n"    /* store f7 */
+                      "    std   8,0x240(1)\n"    /* store f8 */
+                      "    std   9,0x248(1)\n"    /* store f9 */
+                      "    std   10,0x250(1)\n"   /* store f10 */
+                      "    std   11,0x258(1)\n"   /* store f11 */
+                      "    std   12,0x260(1)\n"   /* store f12 */
+                      "    std   13,0x268(1)\n"   /* store f13 */
+                      "    std   14,0x270(1)\n"   /* store f14 */
+                      "    std   15,0x278(1)\n"   /* store f15 */
+                      "    stmg  0,15,0x280(1)\n" /* store general registers */
+                      "    stctg 0,15,0x380(1)\n" /* store control registers */
+                      "    oi    0x384(1),0x10\n" /* fake protection bit */
+                      "    lpswe 0(%0)"
+                      : : "a" (dw_psw), "a" (&ctl_buf) : "cc", "0", "1");
+#endif /* __s390x__ */
 }
 
 #endif
diff -urN linux-2.5.67/include/asm-s390/ptrace.h linux-2.5.67-s390/include/asm-s390/ptrace.h
--- linux-2.5.67/include/asm-s390/ptrace.h	Mon Apr  7 19:32:16 2003
+++ linux-2.5.67-s390/include/asm-s390/ptrace.h	Mon Apr 14 19:11:59 2003
@@ -13,6 +13,8 @@
  * Offsets in the user_regs_struct. They are used for the ptrace
  * system call and in entry.S
  */
+#ifndef __s390x__
+
 #define PT_PSWMASK  0x00
 #define PT_PSWADDR  0x04
 #define PT_GPR0     0x08
@@ -92,18 +94,89 @@
 #define PT_LASTOFF  PT_IEEE_IP
 #define PT_ENDREGS  0x140-1
 
+#define GPR_SIZE	4
+#define CR_SIZE		4
+
+#define STACK_FRAME_OVERHEAD	96	/* size of minimum stack frame */
+
+#else /* __s390x__ */
+
+#define PT_PSWMASK  0x00
+#define PT_PSWADDR  0x08
+#define PT_GPR0     0x10
+#define PT_GPR1     0x18
+#define PT_GPR2     0x20
+#define PT_GPR3     0x28
+#define PT_GPR4     0x30
+#define PT_GPR5     0x38
+#define PT_GPR6     0x40
+#define PT_GPR7     0x48
+#define PT_GPR8     0x50
+#define PT_GPR9     0x58
+#define PT_GPR10    0x60
+#define PT_GPR11    0x68
+#define PT_GPR12    0x70
+#define PT_GPR13    0x78
+#define PT_GPR14    0x80
+#define PT_GPR15    0x88
+#define PT_ACR0     0x90
+#define PT_ACR1     0x94
+#define PT_ACR2     0x98
+#define PT_ACR3     0x9C
+#define PT_ACR4	    0xA0
+#define PT_ACR5	    0xA4
+#define PT_ACR6	    0xA8
+#define PT_ACR7	    0xAC
+#define PT_ACR8	    0xB0
+#define PT_ACR9	    0xB4
+#define PT_ACR10    0xB8
+#define PT_ACR11    0xBC
+#define PT_ACR12    0xC0
+#define PT_ACR13    0xC4
+#define PT_ACR14    0xC8
+#define PT_ACR15    0xCC
+#define PT_ORIGGPR2 0xD0
+#define PT_FPC	    0xD8
+#define PT_FPR0     0xE0
+#define PT_FPR1     0xE8
+#define PT_FPR2     0xF0
+#define PT_FPR3     0xF8
+#define PT_FPR4     0x100
+#define PT_FPR5     0x108
+#define PT_FPR6     0x110
+#define PT_FPR7     0x118
+#define PT_FPR8     0x120
+#define PT_FPR9     0x128
+#define PT_FPR10    0x130
+#define PT_FPR11    0x138
+#define PT_FPR12    0x140
+#define PT_FPR13    0x148
+#define PT_FPR14    0x150
+#define PT_FPR15    0x158
+#define PT_CR_9     0x160
+#define PT_CR_10    0x168
+#define PT_CR_11    0x170
+#define PT_IEEE_IP  0x1A8
+#define PT_LASTOFF  PT_IEEE_IP
+#define PT_ENDREGS  0x1B0-1
+
+#define GPR_SIZE	8
+#define CR_SIZE		8
+
+#define STACK_FRAME_OVERHEAD    160      /* size of minimum stack frame */
+
+#endif /* __s390x__ */
+
 #define NUM_GPRS	16
 #define NUM_FPRS	16
 #define NUM_CRS		16
 #define NUM_ACRS	16
-#define GPR_SIZE	4
+
 #define FPR_SIZE	8
 #define FPC_SIZE	4
 #define FPC_PAD_SIZE	4 /* gcc insists on aligning the fpregs */
-#define CR_SIZE		4
 #define ACR_SIZE	4
 
-#define STACK_FRAME_OVERHEAD	96	/* size of minimum stack frame */
 
 #define PTRACE_OLDSETOPTIONS         21
 
@@ -113,13 +186,39 @@
 #include <linux/types.h>
 #include <asm/setup.h>
 
+typedef union
+{
+	float   f;
+	double  d;
+        __u64   ui;
+	struct
+	{
+		__u32 hi;
+		__u32 lo;
+	} fp;
+} freg_t;
+
+typedef struct
+{
+	__u32   fpc;
+	freg_t  fprs[NUM_FPRS];              
+} s390_fp_regs;
+
+#define FPC_EXCEPTION_MASK      0xF8000000
+#define FPC_FLAGS_MASK          0x00F80000
+#define FPC_DXC_MASK            0x0000FF00
+#define FPC_RM_MASK             0x00000003
+#define FPC_VALID_MASK          0xF8F8FF03
+
 /* this typedef defines how a Program Status Word looks like */
 typedef struct 
 {
-        __u32   mask;
-        __u32   addr;
+        unsigned long mask;
+        unsigned long addr;
 } __attribute__ ((aligned(8))) psw_t;
 
+#ifndef __s390x__
+
 #define PSW_MASK_PER		0x40000000UL
 #define PSW_MASK_DAT		0x04000000UL
 #define PSW_MASK_IO		0x02000000UL
@@ -132,7 +231,7 @@
 #define PSW_MASK_CC		0x00003000UL
 #define PSW_MASK_PM		0x00000F00UL
 
-#define PSW_ADDR_AMODE31	0x80000000UL
+#define PSW_ADDR_AMODE		0x80000000UL
 #define PSW_ADDR_INSN		0x7FFFFFFFUL
 
 #define PSW_BASE_BITS		0x00080000UL
@@ -142,34 +241,41 @@
 #define PSW_ASC_SECONDARY	0x00008000UL
 #define PSW_ASC_HOME		0x0000C000UL
 
-#define PSW_KERNEL_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY)
-#define PSW_USER_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
+#else /* __s390x__ */
+
+#define PSW_MASK_PER		0x4000000000000000UL
+#define PSW_MASK_DAT		0x0400000000000000UL
+#define PSW_MASK_IO		0x0200000000000000UL
+#define PSW_MASK_EXT		0x0100000000000000UL
+#define PSW_MASK_KEY		0x00F0000000000000UL
+#define PSW_MASK_MCHECK		0x0004000000000000UL
+#define PSW_MASK_WAIT		0x0002000000000000UL
+#define PSW_MASK_PSTATE		0x0001000000000000UL
+#define PSW_MASK_ASC		0x0000C00000000000UL
+#define PSW_MASK_CC		0x0000300000000000UL
+#define PSW_MASK_PM		0x00000F0000000000UL
+
+#define PSW_ADDR_AMODE		0x0000000000000000UL
+#define PSW_ADDR_INSN		0xFFFFFFFFFFFFFFFFUL
+
+#define PSW_BASE_BITS		0x0000000180000000UL
+#define PSW_BASE32_BITS		0x0000000080000000UL
+
+#define PSW_ASC_PRIMARY		0x0000000000000000UL
+#define PSW_ASC_ACCREG		0x0000400000000000UL
+#define PSW_ASC_SECONDARY	0x0000800000000000UL
+#define PSW_ASC_HOME		0x0000C00000000000UL
+
+#define PSW_USER32_BITS (PSW_BASE32_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
 			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
 			 PSW_MASK_PSTATE)
 
-typedef union
-{
-	float   f;
-	double  d;
-        __u64   ui;
-	struct
-	{
-		__u32 hi;
-		__u32 lo;
-	} fp;
-} freg_t;
+#endif /* __s390x__ */
 
-typedef struct
-{
-	__u32   fpc;
-	freg_t  fprs[NUM_FPRS];              
-} s390_fp_regs;
-
-#define FPC_EXCEPTION_MASK      0xF8000000
-#define FPC_FLAGS_MASK          0x00F80000
-#define FPC_DXC_MASK            0x0000FF00
-#define FPC_RM_MASK             0x00000003
-#define FPC_VALID_MASK          0xF8F8FF03
+#define PSW_KERNEL_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY)
+#define PSW_USER_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
+			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
+			 PSW_MASK_PSTATE)
 
 /*
  * The first entries in pt_regs and user_regs_struct
@@ -180,9 +286,9 @@
 typedef struct
 {
 	psw_t psw;
-	__u32 gprs[NUM_GPRS];
-	__u32 acrs[NUM_ACRS];
-	__u32 orig_gpr2;
+	unsigned long gprs[NUM_GPRS];
+	unsigned int  acrs[NUM_ACRS];
+	unsigned long orig_gpr2;
 } s390_regs;
 
 /*
@@ -192,24 +298,27 @@
 struct pt_regs 
 {
 	psw_t psw;
-	__u32 gprs[NUM_GPRS];
-	__u32 acrs[NUM_ACRS];
-	__u32 orig_gpr2;
-	__u32 trap;
-};
+	unsigned long gprs[NUM_GPRS];
+	unsigned int  acrs[NUM_ACRS];
+	unsigned long orig_gpr2;
+	unsigned int  trap;
+} __attribute__ ((packed));
 
 /*
  * Now for the program event recording (trace) definitions.
  */
 typedef struct
 {
-	__u32 cr[3];
+	unsigned long cr[3];
 } per_cr_words;
 
-#define PER_EM_MASK 0xE8000000
+#define PER_EM_MASK 0xE8000000UL
 
 typedef	struct
 {
+#ifdef __s390x__
+	unsigned                       : 32;
+#endif /* __s390x__ */
 	unsigned em_branching          : 1;
 	unsigned em_instruction_fetch  : 1;
 	/*
@@ -224,33 +333,34 @@
 	unsigned                       : 1;
 	unsigned storage_alt_space_ctl : 1;
 	unsigned                       : 21;
-	addr_t   starting_addr;
-	addr_t   ending_addr;
+	unsigned long starting_addr;
+	unsigned long ending_addr;
 } per_cr_bits;
 
 typedef struct
 {
-	__u16          perc_atmid;          /* 0x096 */
-	__u32          address;             /* 0x098 */
-	__u8           access_id;           /* 0x0a1 */
+	unsigned short perc_atmid;
+	unsigned long address;
+	unsigned char access_id;
 } per_lowcore_words;
 
 typedef struct
 {
-	unsigned perc_branching          : 1; /* 0x096 */
+	unsigned perc_branching          : 1;
 	unsigned perc_instruction_fetch  : 1;
 	unsigned perc_storage_alteration : 1;
 	unsigned perc_gpr_alt_unused     : 1;
 	unsigned perc_store_real_address : 1;
-	unsigned                         : 4;
+	unsigned                         : 3;
+	unsigned atmid_psw_bit_31        : 1;
 	unsigned atmid_validity_bit      : 1;
 	unsigned atmid_psw_bit_32        : 1;
 	unsigned atmid_psw_bit_5         : 1;
 	unsigned atmid_psw_bit_16        : 1;
 	unsigned atmid_psw_bit_17        : 1;
 	unsigned si                      : 2;
-	addr_t   address;                     /* 0x098 */
-	unsigned                         : 4; /* 0x0a1 */
+	unsigned long address;
+	unsigned                         : 4;
 	unsigned access_id               : 4;
 } per_lowcore_bits;
 
@@ -272,8 +382,8 @@
 	 * These addresses are copied into cr10 & cr11 if single
 	 * stepping is switched off
 	 */
-	__u32     starting_addr;
-	__u32     ending_addr;
+	unsigned long starting_addr;
+	unsigned long ending_addr;
 	union {
 		per_lowcore_words words;
 		per_lowcore_bits  bits;
@@ -282,9 +392,9 @@
 
 typedef struct
 {
-	__u32  len;
-	addr_t kernel_addr;
-	addr_t process_addr;
+	unsigned int  len;
+	unsigned long kernel_addr;
+	unsigned long process_addr;
 } ptrace_area;
 
 /*
@@ -313,9 +423,9 @@
 
 typedef struct
 {
-	addr_t           lowaddr;
-	addr_t           hiaddr;
-	ptprot_flags     prot;
+	unsigned long lowaddr;
+	unsigned long hiaddr;
+	ptprot_flags prot;
 } ptprot_area;                     
 
 /* Sequence of bytes for breakpoint illegal instruction.  */
@@ -331,9 +441,9 @@
 struct user_regs_struct
 {
 	psw_t psw;
-	__u32 gprs[NUM_GPRS];
-	__u32 acrs[NUM_ACRS];
-	__u32 orig_gpr2;
+	unsigned long gprs[NUM_GPRS];
+	unsigned int  acrs[NUM_ACRS];
+	unsigned long orig_gpr2;
 	s390_fp_regs fp_regs;
 	/*
 	 * These per registers are in here so that gdb can modify them
@@ -341,13 +451,13 @@
 	 * watchpoints. This is the way intel does it.
 	 */
 	per_struct per_info;
-	addr_t  ieee_instruction_pointer; 
+	unsigned long ieee_instruction_pointer; 
 	/* Used to give failing instruction back to user for ieee exceptions */
 };
 
 #ifdef __KERNEL__
 #define user_mode(regs) (((regs)->psw.mask & PSW_MASK_PSTATE) != 0)
-#define instruction_pointer(regs) ((regs)->psw.addr & PSW_MASK_INSN)
+#define instruction_pointer(regs) ((regs)->psw.addr & PSW_ADDR_INSN)
 extern void show_regs(struct pt_regs * regs);
 #endif
 
diff -urN linux-2.5.67/include/asm-s390/qdio.h linux-2.5.67-s390/include/asm-s390/qdio.h
--- linux-2.5.67/include/asm-s390/qdio.h	Mon Apr  7 19:30:44 2003
+++ linux-2.5.67-s390/include/asm-s390/qdio.h	Mon Apr 14 19:11:59 2003
@@ -20,9 +20,9 @@
 
 #define QDIO_NAME "qdio "
 
-#ifndef CONFIG_ARCH_S390X
+#ifndef __s390x__
 #define QDIO_32_BIT
-#endif /* CONFIG_ARCH_S390X */
+#endif /* __s390x__ */
 
 /**** CONSTANTS, that are relied on without using these symbols *****/
 #define QDIO_MAX_QUEUES_PER_IRQ 32 /* used in width of unsigned int */
diff -urN linux-2.5.67/include/asm-s390/rwsem.h linux-2.5.67-s390/include/asm-s390/rwsem.h
--- linux-2.5.67/include/asm-s390/rwsem.h	Mon Apr  7 19:31:18 2003
+++ linux-2.5.67-s390/include/asm-s390/rwsem.h	Mon Apr 14 19:11:59 2003
@@ -63,10 +63,17 @@
 	struct list_head	wait_list;
 };
 
+#ifndef __s390x__
 #define RWSEM_UNLOCKED_VALUE	0x00000000
 #define RWSEM_ACTIVE_BIAS	0x00000001
 #define RWSEM_ACTIVE_MASK	0x0000ffff
 #define RWSEM_WAITING_BIAS	(-0x00010000)
+#else /* __s390x__ */
+#define RWSEM_UNLOCKED_VALUE	0x0000000000000000L
+#define RWSEM_ACTIVE_BIAS	0x0000000000000001L
+#define RWSEM_ACTIVE_MASK	0x00000000ffffffffL
+#define RWSEM_WAITING_BIAS	(-0x0000000100000000L)
+#endif /* __s390x__ */
 #define RWSEM_ACTIVE_READ_BIAS	RWSEM_ACTIVE_BIAS
 #define RWSEM_ACTIVE_WRITE_BIAS	(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
 
@@ -94,11 +101,19 @@
 	signed long old, new;
 
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"   l    %0,0(%2)\n"
 		"0: lr   %1,%0\n"
 		"   ahi  %1,%3\n"
 		"   cs   %0,%1,0(%2)\n"
 		"   jl   0b"
+#else /* __s390x__ */
+		"   lg   %0,0(%2)\n"
+		"0: lgr  %1,%0\n"
+		"   aghi %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b"
+#endif /* __s390x__ */
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "i" (RWSEM_ACTIVE_READ_BIAS)
 		: "cc", "memory" );
@@ -114,6 +129,7 @@
 	signed long old, new;
 
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"   l    %0,0(%2)\n"
 		"0: ltr  %1,%0\n"
 		"   jm   1f\n"
@@ -121,6 +137,15 @@
 		"   cs   %0,%1,0(%2)\n"
 		"   jl   0b\n"
 		"1:"
+#else /* __s390x__ */
+		"   lg   %0,0(%2)\n"
+		"0: ltgr %1,%0\n"
+		"   jm   1f\n"
+		"   aghi %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b\n"
+		"1:"
+#endif /* __s390x__ */
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "i" (RWSEM_ACTIVE_READ_BIAS)
 		: "cc", "memory" );
@@ -136,11 +161,19 @@
 
 	tmp = RWSEM_ACTIVE_WRITE_BIAS;
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"   l    %0,0(%2)\n"
 		"0: lr   %1,%0\n"
 		"   a    %1,%3\n"
 		"   cs   %0,%1,0(%2)\n"
 		"   jl   0b"
+#else /* __s390x__ */
+		"   lg   %0,0(%2)\n"
+		"0: lgr  %1,%0\n"
+		"   ag   %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b"
+#endif /* __s390x__ */
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "m" (tmp)
 		: "cc", "memory" );
@@ -156,11 +189,19 @@
 	signed long old;
 
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"   l    %0,0(%1)\n"
 		"0: ltr  %0,%0\n"
 		"   jnz  1f\n"
 		"   cs   %0,%2,0(%1)\n"
 		"   jl   0b\n"
+#else /* __s390x__ */
+		"   lg   %0,0(%1)\n"
+		"0: ltgr %0,%0\n"
+		"   jnz  1f\n"
+		"   csg  %0,%2,0(%1)\n"
+		"   jl   0b\n"
+#endif /* __s390x__ */
 		"1:"
                 : "=&d" (old)
 		: "a" (&sem->count), "d" (RWSEM_ACTIVE_WRITE_BIAS)
@@ -176,11 +217,19 @@
 	signed long old, new;
 
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"   l    %0,0(%2)\n"
 		"0: lr   %1,%0\n"
 		"   ahi  %1,%3\n"
 		"   cs   %0,%1,0(%2)\n"
 		"   jl   0b"
+#else /* __s390x__ */
+		"   lg   %0,0(%2)\n"
+		"0: lgr  %1,%0\n"
+		"   aghi %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b"
+#endif /* __s390x__ */
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "i" (-RWSEM_ACTIVE_READ_BIAS)
 		: "cc", "memory" );
@@ -198,11 +247,19 @@
 
 	tmp = -RWSEM_ACTIVE_WRITE_BIAS;
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"   l    %0,0(%2)\n"
 		"0: lr   %1,%0\n"
 		"   a    %1,%3\n"
 		"   cs   %0,%1,0(%2)\n"
 		"   jl   0b"
+#else /* __s390x__ */
+		"   lg   %0,0(%2)\n"
+		"0: lgr  %1,%0\n"
+		"   ag   %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b"
+#endif /* __s390x__ */
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "m" (tmp)
 		: "cc", "memory" );
@@ -220,11 +277,19 @@
 
 	tmp = -RWSEM_WAITING_BIAS;
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"   l    %0,0(%2)\n"
 		"0: lr   %1,%0\n"
 		"   a    %1,%3\n"
 		"   cs   %0,%1,0(%2)\n"
 		"   jl   0b"
+#else /* __s390x__ */
+		"   lg   %0,0(%2)\n"
+		"0: lgr  %1,%0\n"
+		"   ag   %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b"
+#endif /* __s390x__ */
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "m" (tmp)
 		: "cc", "memory" );
@@ -240,11 +305,19 @@
 	signed long old, new;
 
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"   l    %0,0(%2)\n"
 		"0: lr   %1,%0\n"
 		"   ar   %1,%3\n"
 		"   cs   %0,%1,0(%2)\n"
 		"   jl   0b"
+#else /* __s390x__ */
+		"   lg   %0,0(%2)\n"
+		"0: lgr  %1,%0\n"
+		"   agr  %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b"
+#endif /* __s390x__ */
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "d" (delta)
 		: "cc", "memory" );
@@ -258,11 +331,19 @@
 	signed long old, new;
 
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"   l    %0,0(%2)\n"
 		"0: lr   %1,%0\n"
 		"   ar   %1,%3\n"
 		"   cs   %0,%1,0(%2)\n"
 		"   jl   0b"
+#else /* __s390x__ */
+		"   lg   %0,0(%2)\n"
+		"0: lgr  %1,%0\n"
+		"   agr  %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b"
+#endif /* __s390x__ */
                 : "=&d" (old), "=&d" (new)
 		: "a" (&sem->count), "d" (delta)
 		: "cc", "memory" );
diff -urN linux-2.5.67/include/asm-s390/sembuf.h linux-2.5.67-s390/include/asm-s390/sembuf.h
--- linux-2.5.67/include/asm-s390/sembuf.h	Mon Apr  7 19:31:41 2003
+++ linux-2.5.67-s390/include/asm-s390/sembuf.h	Mon Apr 14 19:11:59 2003
@@ -7,16 +7,20 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
+ * - 64-bit time_t to solve y2038 problem (for !__s390x__)
  * - 2 miscellaneous 32-bit values
  */
 
 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
 	__kernel_time_t	sem_otime;		/* last semop time */
+#ifndef __s390x__
 	unsigned long	__unused1;
+#endif /* ! __s390x__ */
 	__kernel_time_t	sem_ctime;		/* last change time */
+#ifndef __s390x__
 	unsigned long	__unused2;
+#endif /* ! __s390x__ */
 	unsigned long	sem_nsems;		/* no. of semaphores in array */
 	unsigned long	__unused3;
 	unsigned long	__unused4;
diff -urN linux-2.5.67/include/asm-s390/setup.h linux-2.5.67-s390/include/asm-s390/setup.h
--- linux-2.5.67/include/asm-s390/setup.h	Mon Apr  7 19:32:48 2003
+++ linux-2.5.67-s390/include/asm-s390/setup.h	Mon Apr 14 19:11:59 2003
@@ -15,9 +15,15 @@
 
 #ifndef __ASSEMBLY__
 
+#ifndef __s390x__
 #define IPL_DEVICE        (*(unsigned long *)  (0x10404))
 #define INITRD_START      (*(unsigned long *)  (0x1040C))
 #define INITRD_SIZE       (*(unsigned long *)  (0x10414))
+#else /* __s390x__ */
+#define IPL_DEVICE        (*(unsigned long *)  (0x10400))
+#define INITRD_START      (*(unsigned long *)  (0x10408))
+#define INITRD_SIZE       (*(unsigned long *)  (0x10410))
+#endif /* __s390x__ */
 #define COMMAND_LINE      ((char *)            (0x10480))
 
 /*
@@ -26,10 +32,18 @@
 extern unsigned long machine_flags;
 
 #define MACHINE_IS_VM		(machine_flags & 1)
-#define MACHINE_HAS_IEEE	(machine_flags & 2)
 #define MACHINE_IS_P390		(machine_flags & 4)
-#define MACHINE_HAS_CSP		(machine_flags & 8)
 #define MACHINE_HAS_MVPG	(machine_flags & 16)
+#define MACHINE_HAS_DIAG44	(machine_flags & 32)
+
+#ifndef __s390x__
+#define MACHINE_HAS_IEEE	(machine_flags & 2)
+#define MACHINE_HAS_CSP		(machine_flags & 8)
+#else /* __s390x__ */
+#define MACHINE_HAS_IEEE	(1)
+#define MACHINE_HAS_CSP		(1)
+#endif /* __s390x__ */
+
 
 #define MACHINE_HAS_SCLP	(!MACHINE_IS_P390)
 
@@ -50,9 +64,15 @@
 
 #else 
 
+#ifndef __s390x__
 #define IPL_DEVICE        0x10404
 #define INITRD_START      0x1040C
 #define INITRD_SIZE       0x10414
+#else /* __s390x__ */
+#define IPL_DEVICE        0x10400
+#define INITRD_START      0x10408
+#define INITRD_SIZE       0x10410
+#endif /* __s390x__ */
 #define COMMAND_LINE      0x10480
 
 #endif
diff -urN linux-2.5.67/include/asm-s390/shmbuf.h linux-2.5.67-s390/include/asm-s390/shmbuf.h
--- linux-2.5.67/include/asm-s390/shmbuf.h	Mon Apr  7 19:33:02 2003
+++ linux-2.5.67-s390/include/asm-s390/shmbuf.h	Mon Apr 14 19:11:59 2003
@@ -7,7 +7,7 @@
  * between kernel and user space.
  *
  * Pad space is left for:
- * - 64-bit time_t to solve y2038 problem
+ * - 64-bit time_t to solve y2038 problem (for !__s390x__)
  * - 2 miscellaneous 32-bit values
  */
 
@@ -15,11 +15,17 @@
 	struct ipc64_perm	shm_perm;	/* operation perms */
 	size_t			shm_segsz;	/* size of segment (bytes) */
 	__kernel_time_t		shm_atime;	/* last attach time */
+#ifndef __s390x__
 	unsigned long		__unused1;
+#endif /* ! __s390x__ */
 	__kernel_time_t		shm_dtime;	/* last detach time */
+#ifndef __s390x__
 	unsigned long		__unused2;
+#endif /* ! __s390x__ */
 	__kernel_time_t		shm_ctime;	/* last change time */
+#ifndef __s390x__
 	unsigned long		__unused3;
+#endif /* ! __s390x__ */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
diff -urN linux-2.5.67/include/asm-s390/sigcontext.h linux-2.5.67-s390/include/asm-s390/sigcontext.h
--- linux-2.5.67/include/asm-s390/sigcontext.h	Mon Apr  7 19:31:51 2003
+++ linux-2.5.67-s390/include/asm-s390/sigcontext.h	Mon Apr 14 19:11:59 2003
@@ -12,13 +12,24 @@
 #define __NUM_FPRS 16
 #define __NUM_ACRS 16
 
-/*
-  Has to be at least _NSIG_WORDS from asm/signal.h
- */
-#define _SIGCONTEXT_NSIG      64
-#define _SIGCONTEXT_NSIG_BPW  32
+#ifndef __s390x__
+
+/* Has to be at least _NSIG_WORDS from asm/signal.h */
+#define _SIGCONTEXT_NSIG	64
+#define _SIGCONTEXT_NSIG_BPW	32
 /* Size of stack frame allocated when calling signal handler. */
 #define __SIGNAL_FRAMESIZE	96
+
+#else /* __s390x__ */
+
+/* Has to be at least _NSIG_WORDS from asm/signal.h */
+#define _SIGCONTEXT_NSIG	64
+#define _SIGCONTEXT_NSIG_BPW	64 
+/* Size of stack frame allocated when calling signal handler. */
+#define __SIGNAL_FRAMESIZE	160
+
+#endif /* __s390x__ */
+
 #define _SIGCONTEXT_NSIG_WORDS	(_SIGCONTEXT_NSIG / _SIGCONTEXT_NSIG_BPW)
 #define _SIGMASK_COPY_SIZE	(sizeof(unsigned long)*_SIGCONTEXT_NSIG_WORDS)
 
diff -urN linux-2.5.67/include/asm-s390/signal.h linux-2.5.67-s390/include/asm-s390/signal.h
--- linux-2.5.67/include/asm-s390/signal.h	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/include/asm-s390/signal.h	Mon Apr 14 19:11:59 2003
@@ -171,9 +171,15 @@
           __sighandler_t _sa_handler;
           void (*_sa_sigaction)(int, struct siginfo *, void *);
         } _u;
+#ifndef __s390x__ /* lovely */
         sigset_t sa_mask;
         unsigned long sa_flags;
         void (*sa_restorer)(void);
+#else  /* __s390x__ */
+        unsigned long sa_flags;
+        void (*sa_restorer)(void);
+	sigset_t sa_mask;
+#endif /* __s390x__ */
 };
 
 #define sa_handler      _u._sa_handler
diff -urN linux-2.5.67/include/asm-s390/sigp.h linux-2.5.67-s390/include/asm-s390/sigp.h
--- linux-2.5.67/include/asm-s390/sigp.h	Mon Apr  7 19:31:23 2003
+++ linux-2.5.67-s390/include/asm-s390/sigp.h	Mon Apr 14 19:11:59 2003
@@ -72,10 +72,17 @@
 	sigp_ccode ccode;
 
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"    sr     1,1\n"        /* parameter=0 in gpr 1 */
 		"    sigp   1,%1,0(%2)\n"
 		"    ipm    %0\n"
 		"    srl    %0,28\n"
+#else /* __s390x__ */
+		"    sgr    1,1\n"        /* parameter=0 in gpr 1 */
+		"    sigp   1,%1,0(%2)\n"
+		"    ipm    %0\n"
+		"    srl    %0,28"
+#endif /* __s390x__ */
 		: "=d" (ccode)
 		: "d" (__cpu_logical_map[cpu_addr]), "a" (order_code)
 		: "cc" , "memory", "1" );
@@ -86,15 +93,23 @@
  * Signal processor with parameter
  */
 extern __inline__ sigp_ccode
-signal_processor_p(__u32 parameter,__u16 cpu_addr,sigp_order_code order_code)
+signal_processor_p(unsigned long parameter,__u16 cpu_addr,
+		   sigp_order_code order_code)
 {
 	sigp_ccode ccode;
 	
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"    lr     1,%1\n"       /* parameter in gpr 1 */
 		"    sigp   1,%2,0(%3)\n"
 		"    ipm    %0\n"
 		"    srl    %0,28\n"
+#else /* __s390x__ */
+		"    lgr    1,%1\n"       /* parameter in gpr 1 */
+		"    sigp   1,%2,0(%3)\n"
+		"    ipm    %0\n"
+		"    srl    %0,28\n"
+#endif /* __s390x__ */
 		: "=d" (ccode)
 		: "d" (parameter), "d" (__cpu_logical_map[cpu_addr]),
                   "a" (order_code)
@@ -106,18 +121,27 @@
  * Signal processor with parameter and return status
  */
 extern __inline__ sigp_ccode
-signal_processor_ps(__u32 *statusptr, __u32 parameter,
+signal_processor_ps(__u32 *statusptr, unsigned long parameter,
 		    __u16 cpu_addr, sigp_order_code order_code)
 {
 	sigp_ccode ccode;
 	
 	__asm__ __volatile__(
+#ifndef __s390x__
 		"    sr     2,2\n"        /* clear status so it doesn't contain rubbish if not saved. */
 		"    lr     3,%2\n"       /* parameter in gpr 3 */
 		"    sigp   2,%3,0(%4)\n"
 		"    st     2,%1\n"
 		"    ipm    %0\n"
 		"    srl    %0,28\n"
+#else /* __s390x__ */
+		"    sgr    2,2\n"        /* clear status so it doesn't contain rubbish if not saved. */
+		"    lgr    3,%2\n"       /* parameter in gpr 3 */
+		"    sigp   2,%3,0(%4)\n"
+		"    stg    2,%1\n"
+		"    ipm    %0\n"
+		"    srl    %0,28\n"
+#endif /* __s390x__ */
 		: "=d" (ccode), "=m" (*statusptr)
 		: "d" (parameter), "d" (__cpu_logical_map[cpu_addr]),
                   "a" (order_code)
diff -urN linux-2.5.67/include/asm-s390/smp.h linux-2.5.67-s390/include/asm-s390/smp.h
--- linux-2.5.67/include/asm-s390/smp.h	Mon Apr  7 19:31:20 2003
+++ linux-2.5.67-s390/include/asm-s390/smp.h	Mon Apr 14 19:11:59 2003
@@ -52,7 +52,11 @@
 
 extern inline unsigned int num_online_cpus(void)
 {
+#ifndef __s390x__
 	return hweight32(cpu_online_map);
+#else /* __s390x__ */
+	return hweight64(cpu_online_map);
+#endif /* __s390x__ */
 }
 
 extern inline int any_online_cpu(unsigned int mask)
diff -urN linux-2.5.67/include/asm-s390/spinlock.h linux-2.5.67-s390/include/asm-s390/spinlock.h
--- linux-2.5.67/include/asm-s390/spinlock.h	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/include/asm-s390/spinlock.h	Mon Apr 14 19:11:59 2003
@@ -11,6 +11,22 @@
 #ifndef __ASM_SPINLOCK_H
 #define __ASM_SPINLOCK_H
 
+#ifdef __s390x__
+/*
+ * Grmph, take care of %&#! user space programs that include
+ * asm/spinlock.h. The diagnose is only available in kernel
+ * context.
+ */
+#ifdef __KERNEL__
+#include <asm/lowcore.h>
+#define __DIAG44_INSN "ex"
+#define __DIAG44_OPERAND __LC_DIAG44_OPCODE
+#else
+#define __DIAG44_INSN "#"
+#define __DIAG44_OPERAND 0
+#endif
+#endif /* __s390x__ */
+
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
@@ -19,8 +35,13 @@
  */
 
 typedef struct {
+#ifndef __s390x__
 	volatile unsigned long lock;
 } spinlock_t;
+#else /* __s390x__ */
+	volatile unsigned int lock;
+} __attribute__ ((aligned (4))) spinlock_t;
+#endif /* __s390x__ */
 
 #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
 #define spin_lock_init(lp) do { (lp)->lock = 0; } while(0)
@@ -29,6 +50,7 @@
 
 extern inline void _raw_spin_lock(spinlock_t *lp)
 {
+#ifndef __s390x__
 	unsigned int reg1, reg2;
         __asm__ __volatile("    bras  %0,1f\n"
                            "0:  diag  0,0,68\n"
@@ -37,11 +59,26 @@
                            "    jl    0b\n"
                            : "=&d" (reg1), "=&d" (reg2), "+m" (lp->lock)
 			   : "a" (&lp->lock) : "cc" );
+#else /* __s390x__ */
+	unsigned long reg1, reg2;
+        __asm__ __volatile("    bras  %1,1f\n"
+                           "0:  " __DIAG44_INSN " 0,%4\n"
+                           "1:  slr   %0,%0\n"
+                           "    cs    %0,%1,0(%3)\n"
+                           "    jl    0b\n"
+                           : "=&d" (reg1), "=&d" (reg2), "+m" (lp->lock)
+                           : "a" (&lp->lock), "i" (__DIAG44_OPERAND)
+			   : "cc" );
+#endif /* __s390x__ */
 }
 
 extern inline int _raw_spin_trylock(spinlock_t *lp)
 {
+#ifndef __s390x__
 	unsigned long result, reg;
+#else /* __s390x__ */
+	unsigned int result, reg;
+#endif /* __s390x__ */
 	__asm__ __volatile("    slr   %0,%0\n"
 			   "    basr  %1,0\n"
 			   "0:  cs    %0,%1,0(%3)"
@@ -80,6 +117,7 @@
 
 #define rwlock_is_locked(x) ((x)->lock != 0)
 
+#ifndef __s390x__
 #define _raw_read_lock(rw)   \
         asm volatile("   l     2,0(%1)\n"   \
                      "   j     1f\n"     \
@@ -90,7 +128,21 @@
                      "   jl    0b"       \
                      : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
 		     : "2", "3", "cc" )
+#else /* __s390x__ */
+#define _raw_read_lock(rw)   \
+        asm volatile("   lg    2,0(%1)\n"   \
+                     "   j     1f\n"     \
+                     "0: " __DIAG44_INSN " 0,%2\n" \
+                     "1: nihh  2,0x7fff\n" /* clear high (=write) bit */ \
+                     "   la    3,1(2)\n"   /* one more reader */  \
+                     "   csg   2,3,0(%1)\n" /* try to write new value */ \
+                     "   jl    0b"       \
+                     : "+m" ((rw)->lock) \
+		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
+		     : "2", "3", "cc" )
+#endif /* __s390x__ */
 
+#ifndef __s390x__
 #define _raw_read_unlock(rw) \
         asm volatile("   l     2,0(%1)\n"   \
                      "   j     1f\n"     \
@@ -101,7 +153,21 @@
                      "   jl    0b"       \
                      : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
 		     : "2", "3", "cc" )
+#else /* __s390x__ */
+#define _raw_read_unlock(rw) \
+        asm volatile("   lg    2,0(%1)\n"   \
+                     "   j     1f\n"     \
+                     "0: " __DIAG44_INSN " 0,%2\n" \
+                     "1: lgr   3,2\n"    \
+                     "   bctgr 3,0\n"    /* one less reader */ \
+                     "   csg   2,3,0(%1)\n" \
+                     "   jl    0b"       \
+                     : "+m" ((rw)->lock) \
+		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
+		     : "2", "3", "cc" )
+#endif /* __s390x__ */
 
+#ifndef __s390x__
 #define _raw_write_lock(rw) \
         asm volatile("   lhi   3,1\n"    \
                      "   sll   3,31\n"    /* new lock value = 0x80000000 */ \
@@ -112,7 +178,20 @@
                      "   jl    0b"       \
                      : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
 		     : "2", "3", "cc" )
+#else /* __s390x__ */
+#define _raw_write_lock(rw) \
+        asm volatile("   llihh 3,0x8000\n" /* new lock value = 0x80...0 */ \
+                     "   j     1f\n"       \
+                     "0: " __DIAG44_INSN " 0,%2\n"   \
+                     "1: slgr  2,2\n"      /* old lock value must be 0 */ \
+                     "   csg   2,3,0(%1)\n" \
+                     "   jl    0b"         \
+                     : "+m" ((rw)->lock) \
+		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
+		     : "2", "3", "cc" )
+#endif /* __s390x__ */
 
+#ifndef __s390x__
 #define _raw_write_unlock(rw) \
         asm volatile("   slr   3,3\n"     /* new lock value = 0 */ \
                      "   j     1f\n"     \
@@ -123,15 +202,34 @@
                      "   jl    0b"       \
                      : "+m" ((rw)->lock) : "a" (&(rw)->lock) \
 		     : "2", "3", "cc" )
+#else /* __s390x__ */
+#define _raw_write_unlock(rw) \
+        asm volatile("   slgr  3,3\n"      /* new lock value = 0 */ \
+                     "   j     1f\n"       \
+                     "0: " __DIAG44_INSN " 0,%2\n"   \
+                     "1: llihh 2,0x8000\n" /* old lock value must be 0x8..0 */\
+                     "   csg   2,3,0(%1)\n"   \
+                     "   jl    0b"         \
+                     : "+m" ((rw)->lock) \
+		     : "a" (&(rw)->lock), "i" (__DIAG44_OPERAND) \
+		     : "2", "3", "cc" )
+#endif /* __s390x__ */
 
 extern inline int _raw_write_trylock(rwlock_t *rw)
 {
 	unsigned int result, reg;
 	
-	__asm__ __volatile__("   lhi  %0,1\n"
+	__asm__ __volatile__(
+#ifndef __s390x__
+			     "   lhi  %0,1\n"
 			     "   sll  %0,31\n"
 			     "   basr %1,0\n"
 			     "0: cs   %0,%1,0(%3)\n"
+#else /* __s390x__ */
+			     "   llihh %0,0x8000\n"
+			     "   basr  %1,0\n"
+			     "0: csg %0,%1,0(%3)\n"
+#endif /* __s390x__ */
 			     : "=&d" (result), "=&d" (reg), "+m" (rw->lock)
 			     : "a" (&rw->lock) : "cc" );
 	return !result;
diff -urN linux-2.5.67/include/asm-s390/stat.h linux-2.5.67-s390/include/asm-s390/stat.h
--- linux-2.5.67/include/asm-s390/stat.h	Mon Apr  7 19:32:51 2003
+++ linux-2.5.67-s390/include/asm-s390/stat.h	Mon Apr 14 19:11:59 2003
@@ -9,6 +9,7 @@
 #ifndef _S390_STAT_H
 #define _S390_STAT_H
 
+#ifndef __s390x__
 struct __old_kernel_stat {
         unsigned short st_dev;
         unsigned short st_ino;
@@ -46,8 +47,6 @@
         unsigned long  __unused5;
 };
 
-#define STAT_HAVE_NSEC 1
-
 /* This matches struct stat64 in glibc2.1, hence the absolutely
  * insane amounts of padding around dev_t's.
  */
@@ -76,4 +75,31 @@
         unsigned long long	st_ino;
 };
 
+#else /* __s390x__ */
+
+struct stat {
+        unsigned long  st_dev;
+        unsigned long  st_ino;
+        unsigned long  st_nlink;
+        unsigned int   st_mode;
+        unsigned int   st_uid;
+        unsigned int   st_gid;
+        unsigned int   __pad1;
+        unsigned long  st_rdev;
+        unsigned long  st_size;
+        unsigned long  st_atime;
+	unsigned long  st_atime_nsec;
+        unsigned long  st_mtime;
+	unsigned long  st_mtime_nsec;
+        unsigned long  st_ctime;
+	unsigned long  st_ctime_nsec;
+        unsigned long  st_blksize;
+        long           st_blocks;
+        unsigned long  __unused[3];
+};
+
+#endif /* __s390x__ */
+
+#define STAT_HAVE_NSEC 1
+
 #endif
diff -urN linux-2.5.67/include/asm-s390/statfs.h linux-2.5.67-s390/include/asm-s390/statfs.h
--- linux-2.5.67/include/asm-s390/statfs.h	Mon Apr  7 19:32:56 2003
+++ linux-2.5.67-s390/include/asm-s390/statfs.h	Mon Apr 14 19:11:59 2003
@@ -18,6 +18,7 @@
 #endif
 
 struct statfs {
+#ifndef __s390x__
 	long f_type;
 	long f_bsize;
 	long f_blocks;
@@ -28,6 +29,18 @@
 	__kernel_fsid_t f_fsid;
 	long f_namelen;
 	long f_spare[6];
+#else /* __s390x__ */
+	int  f_type;
+	int  f_bsize;
+	long f_blocks;
+	long f_bfree;
+	long f_bavail;
+	long f_files;
+	long f_ffree;
+	__kernel_fsid_t f_fsid;
+	int  f_namelen;
+	int  f_spare[6];
+#endif /* __s390x__ */
 };
 
 #endif
diff -urN linux-2.5.67/include/asm-s390/string.h linux-2.5.67-s390/include/asm-s390/string.h
--- linux-2.5.67/include/asm-s390/string.h	Mon Apr  7 19:33:03 2003
+++ linux-2.5.67-s390/include/asm-s390/string.h	Mon Apr 14 19:11:59 2003
@@ -49,13 +49,24 @@
 {
     void *ptr;
 
-    __asm__ __volatile__ ("   lr    0,%2\n"
+    __asm__ __volatile__ (
+#ifndef __s390x__
+                          "   lr    0,%2\n"
                           "   lr    1,%1\n"
                           "   la    %0,0(%3,%1)\n"
                           "0: srst  %0,1\n"
                           "   jo    0b\n"
                           "   brc   13,1f\n"
                           "   slr   %0,%0\n"
+#else /* __s390x__ */
+                          "   lgr   0,%2\n"
+                          "   lgr   1,%1\n"
+                          "   la    %0,0(%3,%1)\n"
+                          "0: srst  %0,1\n"
+                          "   jo    0b\n"
+                          "   brc   13,1f\n"
+                          "   slgr  %0,%0\n"
+#endif /* __s390x__ */
                           "1:"
                           : "=&a" (ptr) : "a" (cs), "d" (c), "d" (count)
                           : "cc", "0", "1" );
@@ -66,9 +77,16 @@
 {
     char *tmp = dest;
 
-    __asm__ __volatile__ ("   sr    0,0\n"
+    __asm__ __volatile__ (
+#ifndef __s390x__
+                          "   sr    0,0\n"
                           "0: mvst  %0,%1\n"
                           "   jo    0b"
+#else /* __s390x__ */
+                          "   slgr  0,0\n"
+                          "0: mvst  %0,%1\n"
+                          "   jo    0b"
+#endif /* __s390x__ */
                           : "+&a" (dest), "+&a" (src) :
                           : "cc", "memory", "0" );
     return tmp;
@@ -78,12 +96,22 @@
 {
     size_t len;
 
-    __asm__ __volatile__ ("   sr    0,0\n"
+    __asm__ __volatile__ (
+#ifndef __s390x__
+                          "   sr    0,0\n"
                           "   lr    %0,%1\n"
                           "0: srst  0,%0\n"
                           "   jo    0b\n"
                           "   lr    %0,0\n"
                           "   sr    %0,%1"
+#else /* __s390x__ */
+                          "   slgr  0,0\n"
+                          "   lgr   %0,%1\n"
+                          "0: srst  0,%0\n"
+                          "   jo    0b\n"
+                          "   lgr   %0,0\n"
+                          "   sgr   %0,%1"
+#endif /* __s390x__ */
                           : "=&a" (len) : "a" (s) 
                           : "cc", "0" );
     return len;
@@ -93,25 +121,30 @@
 {
     char *tmp = dest;
 
-    __asm__ __volatile__ ("   sr    0,0\n"
+    __asm__ __volatile__ (
+#ifndef __s390x__
+                          "   sr    0,0\n"
                           "0: srst  0,%0\n"
                           "   jo    0b\n"
                           "   lr    %0,0\n"
                           "   sr    0,0\n"
                           "1: mvst  %0,%1\n"
                           "   jo    1b"
+#else /* __s390x__ */
+                          "   slgr  0,0\n"
+                          "0: srst  0,%0\n"
+                          "   jo    0b\n"
+                          "   lgr   %0,0\n"
+                          "   slgr  0,0\n"
+                          "1: mvst  %0,%1\n"
+                          "   jo    1b"
+#endif /* __s390x__ */
                           : "+&a" (dest), "+&a" (src) :
                           : "cc", "memory", "0" );
     return tmp;
 }
 
 extern void *alloca(size_t);
-
 #endif /* __KERNEL__ */
 
 #endif /* __S390_STRING_H_ */
-
-
-
-
-
diff -urN linux-2.5.67/include/asm-s390/system.h linux-2.5.67-s390/include/asm-s390/system.h
--- linux-2.5.67/include/asm-s390/system.h	Mon Apr 14 19:11:45 2003
+++ linux-2.5.67-s390/include/asm-s390/system.h	Mon Apr 14 19:11:59 2003
@@ -23,6 +23,15 @@
 
 extern struct task_struct *resume(void *, void *);
 
+#ifdef __s390x__
+#define __FLAG_SHIFT 56
+extern void __misaligned_u16(void);
+extern void __misaligned_u32(void);
+extern void __misaligned_u64(void);
+#else /* __s390x__ */
+#define __FLAG_SHIFT 24
+#endif /* __s390x__ */
+
 static inline void save_fp_regs(s390_fp_regs *fpregs)
 {
 	asm volatile (
@@ -88,7 +97,7 @@
 #define nop() __asm__ __volatile__ ("nop")
 
 #define xchg(ptr,x) \
-  ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
+  ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(void *)(ptr),sizeof(*(ptr))))
 
 static inline unsigned long __xchg(unsigned long x, void * ptr, int size)
 {
@@ -137,6 +146,17 @@
 			: "memory", "cc", "0" );
 		x = old;
 		break;
+#ifdef __s390x__
+	case 8:
+		asm volatile (
+			"    lg  %0,0(%2)\n"
+			"0:  csg %0,%1,0(%2)\n"
+			"    jl  0b\n"
+			: "=&d" (old) : "d" (x), "a" (ptr)
+			: "memory", "cc", "0" );
+		x = old;
+		break;
+#endif /* __s390x__ */
         }
         return x;
 }
@@ -208,6 +228,14 @@
 			: "=&d" (prev) : "0" (old), "d" (new), "a" (ptr)
 			: "memory", "cc" );
 		return prev;
+#ifdef __s390x__
+	case 8:
+		asm volatile (
+			"    csg %0,%2,0(%3)\n"
+			: "=&d" (prev) : "0" (old), "d" (new), "a" (ptr)
+			: "memory", "cc" );
+		return prev;
+#endif /* __s390x__ */
         }
         return old;
 }
@@ -241,15 +269,15 @@
 
 /* interrupt control.. */
 #define local_irq_enable() ({ \
-        __u8 __dummy; \
+        unsigned long  __dummy; \
         __asm__ __volatile__ ( \
                 "stosm 0(%1),0x03" : "=m" (__dummy) : "a" (&__dummy) ); \
         })
 
 #define local_irq_disable() ({ \
-        __u32 __flags; \
+        unsigned long __flags; \
         __asm__ __volatile__ ( \
-                "stnsm 0(%1),0xFC" : "=m" (__flags) : "a" (&__flags) ); \
+                "stnsm 0(%1),0xfc" : "=m" (__flags) : "a" (&__flags) ); \
         __flags; \
         })
 
@@ -263,9 +291,70 @@
 ({					\
 	unsigned long flags;		\
 	local_save_flags(flags);	\
-        !((flags >> 24) & 3);		\
+        !((flags >> __FLAG_SHIFT) & 3);	\
 })
 
+#ifdef __s390x__
+
+#define __load_psw(psw) \
+        __asm__ __volatile__("lpswe 0(%0)" : : "a" (&psw) : "cc" );
+
+#define __ctl_load(array, low, high) ({ \
+	__asm__ __volatile__ ( \
+		"   la    1,%0\n" \
+		"   bras  2,0f\n" \
+                "   lctlg 0,0,0(1)\n" \
+		"0: ex    %1,0(2)" \
+		: : "m" (array), "a" (((low)<<4)+(high)) : "1", "2" ); \
+	})
+
+#define __ctl_store(array, low, high) ({ \
+	__asm__ __volatile__ ( \
+		"   la    1,%0\n" \
+		"   bras  2,0f\n" \
+		"   stctg 0,0,0(1)\n" \
+		"0: ex    %1,0(2)" \
+		: "=m" (array) : "a" (((low)<<4)+(high)): "1", "2" ); \
+	})
+
+#define __ctl_set_bit(cr, bit) ({ \
+        __u8 __dummy[24]; \
+        __asm__ __volatile__ ( \
+                "    la    1,%0\n"       /* align to 8 byte */ \
+                "    aghi  1,7\n" \
+                "    nill  1,0xfff8\n" \
+                "    bras  2,0f\n"       /* skip indirect insns */ \
+                "    stctg 0,0,0(1)\n" \
+                "    lctlg 0,0,0(1)\n" \
+                "0:  ex    %1,0(2)\n"    /* execute stctl */ \
+                "    lg    0,0(1)\n" \
+                "    ogr   0,%2\n"       /* set the bit */ \
+                "    stg   0,0(1)\n" \
+                "1:  ex    %1,6(2)"      /* execute lctl */ \
+                : "=m" (__dummy) : "a" (cr*17), "a" (1L<<(bit)) \
+                : "cc", "0", "1", "2"); \
+        })
+
+#define __ctl_clear_bit(cr, bit) ({ \
+        __u8 __dummy[24]; \
+        __asm__ __volatile__ ( \
+                "    la    1,%0\n"       /* align to 8 byte */ \
+                "    aghi  1,7\n" \
+                "    nill  1,0xfff8\n" \
+                "    bras  2,0f\n"       /* skip indirect insns */ \
+                "    stctg 0,0,0(1)\n" \
+                "    lctlg 0,0,0(1)\n" \
+                "0:  ex    %1,0(2)\n"    /* execute stctl */ \
+                "    lg    0,0(1)\n" \
+                "    ngr   0,%2\n"       /* set the bit */ \
+                "    stg   0,0(1)\n" \
+                "1:  ex    %1,6(2)"      /* execute lctl */ \
+                : "=m" (__dummy) : "a" (cr*17), "a" (~(1L<<(bit))) \
+                : "cc", "0", "1", "2"); \
+        })
+
+#else /* __s390x__ */
+
 #define __load_psw(psw) \
 	__asm__ __volatile__("lpsw 0(%0)" : : "a" (&psw) : "cc" );
 
@@ -273,7 +362,7 @@
 	__asm__ __volatile__ ( \
 		"   la    1,%0\n" \
 		"   bras  2,0f\n" \
-                "   lctl  0,0,0(1)\n" \
+                "   lctl 0,0,0(1)\n" \
 		"0: ex    %1,0(2)" \
 		: : "m" (array), "a" (((low)<<4)+(high)) : "1", "2" ); \
 	})
@@ -324,6 +413,7 @@
                 : "=m" (__dummy) : "a" (cr*17), "a" (~(1<<(bit))) \
                 : "cc", "0", "1", "2"); \
         })
+#endif /* __s390x__ */
 
 /* For spinlocks etc */
 #define local_irq_save(x)	((x) = local_irq_disable())
diff -urN linux-2.5.67/include/asm-s390/thread_info.h linux-2.5.67-s390/include/asm-s390/thread_info.h
--- linux-2.5.67/include/asm-s390/thread_info.h	Mon Apr  7 19:31:57 2003
+++ linux-2.5.67-s390/include/asm-s390/thread_info.h	Mon Apr 14 19:11:59 2003
@@ -13,6 +13,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/processor.h>
+#include <asm/lowcore.h>
 
 /*
  * low level task data that entry.S needs immediate access to
@@ -46,27 +47,36 @@
 #define init_thread_info	(init_thread_union.thread_info)
 #define init_stack		(init_thread_union.stack)
 
+/*
+ * Size of kernel stack for each process
+ */
+#ifndef __s390x__
+#define THREAD_ORDER 1
+#define ASYNC_ORDER  1
+#else /* __s390x__ */
+#define THREAD_ORDER 2
+#define ASYNC_ORDER  2
+#endif /* __s390x__ */
+
+#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
+#define ASYNC_SIZE  (PAGE_SIZE << ASYNC_ORDER)
+
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
-	return (struct thread_info *)((*(unsigned long *) 0xc40)-8192);
+	return (struct thread_info *)((*(unsigned long *) __LC_KERNEL_STACK)-THREAD_SIZE);
 }
 
 /* thread information allocation */
 #define alloc_thread_info() ((struct thread_info *) \
-	__get_free_pages(GFP_KERNEL,1))
-#define free_thread_info(ti) free_pages((unsigned long) (ti), 1)
+	__get_free_pages(GFP_KERNEL,THREAD_ORDER))
+#define free_thread_info(ti) free_pages((unsigned long) (ti),THREAD_ORDER)
 #define get_thread_info(ti) get_task_struct((ti)->task)
 #define put_thread_info(ti) put_task_struct((ti)->task)
 
 #endif
 
 /*
- * Size of kernel stack for each process
- */
-#define THREAD_SIZE (2*PAGE_SIZE)
-
-/*
  * thread information flags bit numbers
  */
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
@@ -77,6 +87,7 @@
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
+#define TIF_31BIT		18	/* 32bit process */ 
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -85,6 +96,7 @@
 #define _TIF_RESTART_SVC	(1<<TIF_RESTART_SVC)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
+#define _TIF_31BIT		(1<<TIF_31BIT)
 
 #endif /* __KERNEL__ */
 
diff -urN linux-2.5.67/include/asm-s390/tlbflush.h linux-2.5.67-s390/include/asm-s390/tlbflush.h
--- linux-2.5.67/include/asm-s390/tlbflush.h	Mon Apr  7 19:32:57 2003
+++ linux-2.5.67-s390/include/asm-s390/tlbflush.h	Mon Apr 14 19:11:59 2003
@@ -28,7 +28,6 @@
 #define local_flush_tlb() \
 do {  __asm__ __volatile__("ptlb": : :"memory"); } while (0)
 
-
 #ifndef CONFIG_SMP
 
 /*
@@ -70,7 +69,13 @@
 
 static inline void global_flush_tlb(void)
 {
-	if (MACHINE_HAS_CSP) {
+#ifndef __s390x__
+	if (!MACHINE_HAS_CSP) {
+		smp_ptlb_all();
+		return;
+	}
+#endif /* __s390x__ */
+	{
 		long dummy = 0;
 		__asm__ __volatile__ (
 			"    la   4,1(%0)\n"
@@ -78,8 +83,7 @@
 			"    slr  3,3\n"
 			"    csp  2,4"
 			: : "a" (&dummy) : "cc", "2", "3", "4" );
-	} else
-		smp_ptlb_all();
+	}
 }
 
 /*
diff -urN linux-2.5.67/include/asm-s390/types.h linux-2.5.67-s390/include/asm-s390/types.h
--- linux-2.5.67/include/asm-s390/types.h	Mon Apr  7 19:31:22 2003
+++ linux-2.5.67-s390/include/asm-s390/types.h	Mon Apr 14 19:11:59 2003
@@ -27,15 +27,21 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;
 
+#ifndef __s390x__
 #if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
+#else /* __s390x__ */
+typedef __signed__ long __s64;
+typedef unsigned long __u64;
+#endif
+
 /* A address type so that arithmetic can be done on it & it can be upgraded to
    64 bit when necessary 
 */
-typedef __u32  addr_t; 
-typedef __s32  saddr_t;
+typedef unsigned long addr_t; 
+typedef __signed__ long saddr_t;
 
 #endif /* __ASSEMBLY__ */
 
@@ -44,7 +50,11 @@
  */
 #ifdef __KERNEL__
 
+#ifndef __s390x__
 #define BITS_PER_LONG 32
+#else
+#define BITS_PER_LONG 64
+#endif
 
 #ifndef __ASSEMBLY__
 
@@ -57,11 +67,17 @@
 typedef signed int s32;
 typedef unsigned int u32;
 
+#ifndef __s390x__
 typedef signed long long s64;
 typedef unsigned long long u64;
+#else /* __s390x__ */
+typedef signed long s64;
+typedef unsigned  long u64;
+#endif /* __s390x__ */
 
 typedef u32 dma_addr_t;
 
+#ifndef __s390x__
 typedef union {
 	unsigned long long pair;
 	struct {
@@ -75,7 +91,7 @@
 #define HAVE_SECTOR_T
 #endif
 
-#endif /* __ASSEMBLY__ */
-
-#endif                                 /* __KERNEL__                       */
-#endif
+#endif /* ! __s390x__   */
+#endif /* __ASSEMBLY__  */
+#endif /* __KERNEL__    */
+#endif /* _S390_TYPES_H */
diff -urN linux-2.5.67/include/asm-s390/uaccess.h linux-2.5.67-s390/include/asm-s390/uaccess.h
--- linux-2.5.67/include/asm-s390/uaccess.h	Mon Apr  7 19:30:44 2003
+++ linux-2.5.67-s390/include/asm-s390/uaccess.h	Mon Apr 14 19:11:59 2003
@@ -72,284 +72,261 @@
 };
 
 /*
- * These are the main single-value transfer routines.  They automatically
- * use the right size if we just have the right pointer type.
+ * Standard fixup section for uaccess inline functions.
+ * local label 0: is the fault point
+ * local label 1: is the return point
+ * %0 is the error variable
+ * %3 is the error value -EFAULT
  */
-
-extern inline int __put_user_asm_8(void *x, void *ptr)
-{
-        int err;
-
-        __asm__ __volatile__ (  "   sr    %0,%0\n"
-				"   lr    2,%1\n"
-				"   lr    4,%2\n"
-                                "   sacf  512\n"
-                                "0: mvc   0(8,4),0(2)\n"
-                                "   sacf  0\n"
-				"1:\n"
-				".section .fixup,\"ax\"\n"
-				"2: sacf  0\n"
-				"   lhi   %0,%h3\n"
-				"   bras  4,3f\n"
-				"   .long 1b\n"
-				"3: l     4,0(4)\n"
-				"   br    4\n"
-				".previous\n"
-				".section __ex_table,\"a\"\n"
-				"   .align 4\n"
-				"   .long  0b,2b\n"
-				".previous"
-                                : "=&d" (err)
-                                : "d" (x), "d" (ptr), "K" (-EFAULT)
-                                : "cc", "2", "4" );
-        return err;
-}
-
-extern inline int __put_user_asm_4(__u32 x, void *ptr)
-{
-        int err;
-
-        __asm__ __volatile__ (  "   sr    %0,%0\n"
-				"   lr    4,%2\n"
-                                "   sacf  512\n"
-                                "0: st    %1,0(4)\n"
-                                "   sacf  0\n"
-				"1:\n"
-				".section .fixup,\"ax\"\n"
-				"2: sacf  0\n"
-				"   lhi   %0,%h3\n"
-				"   bras  4,3f\n"
-				"   .long 1b\n"
-				"3: l     4,0(4)\n"
-				"   br    4\n"
-				".previous\n"
-				".section __ex_table,\"a\"\n"
-				"   .align 4\n"
-				"   .long  0b,2b\n"
-				".previous"
-                                : "=&d" (err)
-                                : "d" (x), "d" (ptr), "K" (-EFAULT)
-                                : "cc", "4" );
-        return err;
-}
-
-extern inline int __put_user_asm_2(__u16 x, void *ptr)
-{
-        int err;
-
-        __asm__ __volatile__ (  "   sr    %0,%0\n"
-				"   lr    4,%2\n"
-                                "   sacf  512\n"
-                                "0: sth   %1,0(4)\n"
-                                "   sacf  0\n"
-				"1:\n"
-				".section .fixup,\"ax\"\n"
-				"2: sacf  0\n"
-				"   lhi   %0,%h3\n"
-				"   bras  4,3f\n"
-				"   .long 1b\n"
-				"3: l     4,0(4)\n"
-				"   br    4\n"
-				".previous\n"
-				".section __ex_table,\"a\"\n"
-				"   .align 4\n"
-				"   .long  0b,2b\n"
-				".previous"
-                                : "=&d" (err)
-                                : "d" (x), "d" (ptr), "K" (-EFAULT)
-                                : "cc", "4" );
-        return err;
-}
-
-extern inline int __put_user_asm_1(__u8 x, void *ptr)
-{
-        int err;
-
-        __asm__ __volatile__ (  "   sr    %0,%0\n"
-				"   lr    4,%2\n"
-                                "   sacf  512\n"
-                                "0: stc   %1,0(4)\n"
-                                "   sacf  0\n"
-				"1:\n"
-				".section .fixup,\"ax\"\n"
-				"2: sacf  0\n"
-				"   lhi   %0,%h3\n"
-				"   bras  4,3f\n"
-				"   .long 1b\n"
-				"3: l     4,0(4)\n"
-				"   br    4\n"
-				".previous\n"
-				".section __ex_table,\"a\"\n"
-				"   .align 4\n"
-				"   .long  0b,2b\n"
-				".previous"
-                                : "=&d" (err)
-                                : "d" (x), "d" (ptr), "K" (-EFAULT)
-                                : "cc", "4" );
-        return err;
-}
+#ifndef __s390x__
+#define __uaccess_fixup \
+	".section .fixup,\"ax\"\n"	\
+	"8: sacf  0\n"			\
+	"   lhi	  %0,%h3\n"		\
+	"   bras  4,9f\n"		\
+	"   .long 1b\n"			\
+	"9: l	  4,0(4)\n"		\
+	"   br	  4\n"			\
+	".previous\n"			\
+	".section __ex_table,\"a\"\n"	\
+	"   .align 4\n"			\
+	"   .long  0b,8b\n"		\
+	".previous"
+#else /* __s390x__ */
+#define __uaccess_fixup \
+	".section .fixup,\"ax\"\n"	\
+	"9: sacf  0\n"			\
+	"   lhi	  %0,%h3\n"		\
+	"   jg	  1b\n"			\
+	".previous\n"			\
+	".section __ex_table,\"a\"\n"	\
+	"   .align 8\n"			\
+	"   .quad  0b,9b\n"		\
+	".previous"
+#endif /* __s390x__ */
 
 /*
- * (u8)(u32) ... autsch, but that the only way we can suppress the
- * warnings when compiling binfmt_elf.c
+ * These are the main single-value transfer routines.  They automatically
+ * use the right size if we just have the right pointer type.
  */
-#define __put_user(x, ptr)                                      \
-({                                                              \
-        __typeof__(*(ptr)) __x = (x);                           \
-        int __pu_err;                                           \
-        switch (sizeof (*(ptr))) {                              \
-        case 1:                                                 \
-                __pu_err = __put_user_asm_1((__u8)(__u32) __x,  \
-                                            ptr);               \
-                break;                                          \
-        case 2:                                                 \
-                __pu_err = __put_user_asm_2((__u16)(__u32) __x, \
-                                            ptr);               \
-                break;                                          \
-        case 4:                                                 \
-                __pu_err = __put_user_asm_4((__u32) __x,        \
-                                            ptr);               \
-                break;                                          \
-        case 8:                                                 \
-                __pu_err = __put_user_asm_8(&__x, ptr);         \
-                break;                                          \
-        default:                                                \
-                __pu_err = __put_user_bad();                    \
-                break;                                          \
-         }                                                      \
-        __pu_err;                                               \
+#ifndef __s390x__
+
+#define __put_user_asm_8(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  2,%2\n"				\
+		"   la	  4,%1\n"				\
+		"   sacf  512\n"				\
+		"0: mvc	  0(8,4),0(2)\n"			\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err)					\
+		: "m" (*(__u64*)(ptr)), "m" (x), "K" (-EFAULT)	\
+		: "cc", "2", "4" );				\
+})
+
+#else /* __s390x__ */
+
+#define __put_user_asm_8(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  4,%1\n"				\
+		"   sacf  512\n"				\
+		"0: stg	  %2,0(4)\n"				\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err)					\
+		: "m" (*(__u64*)(ptr)), "d" (x), "K" (-EFAULT)	\
+		: "cc", "4" );					\
+})
+
+#endif /* __s390x__ */
+
+#define __put_user_asm_4(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  4,%1\n"				\
+		"   sacf  512\n"				\
+		"0: st	  %2,0(4)\n"				\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err)					\
+		: "m" (*(__u32*)(ptr)), "d" (x), "K" (-EFAULT)	\
+		: "cc", "4" );					\
+})
+
+#define __put_user_asm_2(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  4,%1\n"				\
+		"   sacf  512\n"				\
+		"0: sth	  %2,0(4)\n"				\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err)					\
+		: "m" (*(__u16*)(ptr)), "d" (x), "K" (-EFAULT)	\
+		: "cc", "4" );					\
+})
+
+#define __put_user_asm_1(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  4,%1\n"				\
+		"   sacf  512\n"				\
+		"0: stc	  %2,0(4)\n"				\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err)					\
+		: "m" (*(__u8*)(ptr)), "d" (x),	"K" (-EFAULT)	\
+		: "cc", "4" );					\
+})
+
+#define __put_user(x, ptr) \
+({								\
+	__typeof__(*(ptr)) __x = (x);				\
+	int __pu_err;						\
+	switch (sizeof (*(ptr))) {				\
+	case 1:							\
+		__put_user_asm_1(__x, ptr, __pu_err);		\
+		break;						\
+	case 2:							\
+		__put_user_asm_2(__x, ptr, __pu_err);		\
+		break;						\
+	case 4:							\
+		__put_user_asm_4(__x, ptr, __pu_err);		\
+		break;						\
+	case 8:							\
+		__put_user_asm_8(__x, ptr, __pu_err);		\
+		break;						\
+	default:						\
+		__pu_err = __put_user_bad();			\
+		break;						\
+	 }							\
+	__pu_err;						\
 })
 
 #define put_user(x, ptr) __put_user(x, ptr)
 
 extern int __put_user_bad(void);
 
-#define __get_user_asm_8(x, ptr, err)                                      \
-({                                                                         \
-        __asm__ __volatile__ (  "   sr    %1,%1\n"                         \
-				"   la    2,%0\n"			   \
-                                "   la    4,%2\n"                          \
-                                "   sacf  512\n"                           \
-                                "0: mvc   0(8,2),0(4)\n"                   \
-                                "   sacf  0\n"                             \
-                                "1:\n"                                     \
-                                ".section .fixup,\"ax\"\n"                 \
-                                "2: sacf  0\n"                             \
-                                "   lhi   %1,%h3\n"                        \
-                                "   bras  4,3f\n"                          \
-                                "   .long 1b\n"                            \
-                                "3: l     4,0(4)\n"                        \
-                                "   br    4\n"                             \
-                                ".previous\n"                              \
-                                ".section __ex_table,\"a\"\n"              \
-                                "   .align 4\n"                            \
-                                "   .long 0b,2b\n"                         \
-                                ".previous"                                \
-                                : "=m" (x) , "=&d" (err)                   \
-                                : "m" (*(const __u64*)(ptr)),"K" (-EFAULT) \
-                                : "cc", "2", "4" );                        \
-})
-
-#define __get_user_asm_4(x, ptr, err)                                      \
-({                                                                         \
-        __asm__ __volatile__ (  "   sr    %1,%1\n"                         \
-                                "   la    4,%2\n"                          \
-                                "   sacf  512\n"                           \
-                                "0: l     %0,0(4)\n"                       \
-                                "   sacf  0\n"                             \
-                                "1:\n"                                     \
-                                ".section .fixup,\"ax\"\n"                 \
-                                "2: sacf  0\n"                             \
-                                "   lhi   %1,%h3\n"                        \
-                                "   bras  4,3f\n"                          \
-                                "   .long 1b\n"                            \
-                                "3: l     4,0(4)\n"                        \
-                                "   br    4\n"                             \
-                                ".previous\n"                              \
-                                ".section __ex_table,\"a\"\n"              \
-                                "   .align 4\n"                            \
-                                "   .long 0b,2b\n"                         \
-                                ".previous"                                \
-                                : "=d" (x) , "=&d" (err)                   \
-                                : "m" (*(const __u32*)(ptr)),"K" (-EFAULT) \
-                                : "cc", "4" );                             \
-})
-
-#define __get_user_asm_2(x, ptr, err)                                      \
-({                                                                         \
-        __asm__ __volatile__ (  "   sr    %1,%1\n"                         \
-                                "   la    4,%2\n"                          \
-                                "   sacf  512\n"                           \
-                                "0: lh    %0,0(4)\n"                       \
-                                "   sacf  0\n"                             \
-                                "1:\n"                                     \
-                                ".section .fixup,\"ax\"\n"                 \
-                                "2: sacf  0\n"                             \
-                                "   lhi   %1,%h3\n"                        \
-                                "   bras  4,3f\n"                          \
-                                "   .long 1b\n"                            \
-                                "3: l     4,0(4)\n"                        \
-                                "   br    4\n"                             \
-                                ".previous\n"                              \
-                                ".section __ex_table,\"a\"\n"              \
-                                "   .align 4\n"                            \
-                                "   .long 0b,2b\n"                         \
-                                ".previous"                                \
-                                : "=d" (x) , "=&d" (err)                   \
-                                : "m" (*(const __u16*)(ptr)),"K" (-EFAULT) \
-                                : "cc", "4" );                             \
-})
-
-#define __get_user_asm_1(x, ptr, err)                                     \
-({                                                                        \
-        __asm__ __volatile__ (  "   sr    %1,%1\n"                        \
-                                "   la    4,%2\n"                         \
-                                "   sr    %0,%0\n"                        \
-                                "   sacf  512\n"                          \
-                                "0: ic    %0,0(4)\n"                      \
-                                "   sacf  0\n"                            \
-                                "1:\n"                                    \
-                                ".section .fixup,\"ax\"\n"                \
-                                "2: sacf  0\n"                            \
-                                "   lhi   %1,%h3\n"                       \
-                                "   bras  4,3f\n"                         \
-                                "   .long 1b\n"                           \
-                                "3: l     4,0(4)\n"                       \
-                                "   br    4\n"                            \
-                                ".previous\n"                             \
-                                ".section __ex_table,\"a\"\n"             \
-                                "   .align 4\n"                           \
-                                "   .long 0b,2b\n"                        \
-                                ".previous"                               \
-                                : "=d" (x) , "=&d" (err)                  \
-                                : "m" (*(const __u8*)(ptr)),"K" (-EFAULT) \
-                                : "cc", "4" );                            \
-})
+#ifndef __s390x__
 
-#define __get_user(x, ptr)                                      \
-({                                                              \
-        __typeof__(*(ptr)) __x;                                 \
-        int __gu_err;                                           \
-        switch (sizeof(*(ptr))) {                               \
-        case 1:                                                 \
-                __get_user_asm_1(__x, ptr, __gu_err);           \
-                break;                                          \
-        case 2:                                                 \
-                __get_user_asm_2(__x, ptr, __gu_err);           \
-                break;                                          \
-        case 4:                                                 \
-                __get_user_asm_4(__x, ptr, __gu_err);           \
-                break;                                          \
-        case 8:                                                 \
-                __get_user_asm_8(__x, ptr, __gu_err);           \
-                break;                                          \
-        default:                                                \
-                __x = 0;                                        \
-                __gu_err = __get_user_bad();                    \
-                break;                                          \
-        }                                                       \
-        (x) = __x;                                              \
-        __gu_err;                                               \
+#define __get_user_asm_8(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  2,%1\n"				\
+		"   la	  4,%2\n"				\
+		"   sacf  512\n"				\
+		"0: mvc	  0(8,2),0(4)\n"			\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err), "=m" (x)				\
+		: "m" (*(const __u64*)(ptr)),"K" (-EFAULT)	\
+		: "cc", "2", "4" );				\
+})
+
+#else /* __s390x__ */
+
+#define __get_user_asm_8(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  4,%2\n"				\
+		"   sacf  512\n"				\
+		"0: lg	  %1,0(4)\n"				\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err), "=d" (x)				\
+		: "m" (*(const __u64*)(ptr)),"K" (-EFAULT)	\
+		: "cc", "4" );					\
+})
+
+#endif /* __s390x__ */
+
+
+#define __get_user_asm_4(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  4,%2\n"				\
+		"   sacf  512\n"				\
+		"0: l	  %1,0(4)\n"				\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err), "=d" (x)				\
+		: "m" (*(const __u32*)(ptr)),"K" (-EFAULT)	\
+		: "cc", "4" );					\
+})
+
+#define __get_user_asm_2(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  4,%2\n"				\
+		"   sacf  512\n"				\
+		"0: lh	  %1,0(4)\n"				\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err), "=d" (x)				\
+		: "m" (*(const __u16*)(ptr)),"K" (-EFAULT)	\
+		: "cc", "4" );					\
+})
+
+#define __get_user_asm_1(x, ptr, err) \
+({								\
+	__asm__ __volatile__ (					\
+		"   sr	  %0,%0\n"				\
+		"   la	  4,%2\n"				\
+		"   sr	  %1,%1\n"				\
+		"   sacf  512\n"				\
+		"0: ic	  %1,0(4)\n"				\
+		"   sacf  0\n"					\
+		"1:\n"						\
+		__uaccess_fixup					\
+		: "=&d" (err), "=d" (x)				\
+		: "m" (*(const __u8*)(ptr)),"K" (-EFAULT)	\
+		: "cc", "4" );					\
+})
+
+#define __get_user(x, ptr)					\
+({								\
+	__typeof__(*(ptr)) __x;					\
+	int __gu_err;						\
+	switch (sizeof(*(ptr))) {				\
+	case 1:							\
+		__get_user_asm_1(__x, ptr, __gu_err);		\
+		break;						\
+	case 2:							\
+		__get_user_asm_2(__x, ptr, __gu_err);		\
+		break;						\
+	case 4:							\
+		__get_user_asm_4(__x, ptr, __gu_err);		\
+		break;						\
+	case 8:							\
+		__get_user_asm_8(__x, ptr, __gu_err);		\
+		break;						\
+	default:						\
+		__x = 0;					\
+		__gu_err = __get_user_bad();			\
+		break;						\
+	}							\
+	(x) = __x;						\
+	__gu_err;						\
 })
 
 #define get_user(x, ptr) __get_user(x, ptr)
@@ -357,7 +334,8 @@
 extern int __get_user_bad(void);
 
 /*
- * access register are set up, that 4 points to secondary (user) , 2 to primary (kernel)
+ * access register are set up, that 4 points to secondary (user),
+ * 2 to primary (kernel)
  */
 
 extern long __copy_to_user_asm(const void *from, long n, const void *to);
@@ -402,42 +380,81 @@
  * Copy a null terminated string from userspace.
  */
 
+#ifndef __s390x__
+
 static inline long
 __strncpy_from_user(char *dst, const char *src, long count)
 {
         int len;
-        __asm__ __volatile__ (  "   slr   %0,%0\n"
-				"   lr    2,%1\n"
-                                "   lr    4,%2\n"
-                                "   slr   3,3\n"
-                                "   sacf  512\n"
-                                "0: ic    3,0(%0,4)\n"
-                                "1: stc   3,0(%0,2)\n"
-                                "   ltr   3,3\n"
-                                "   jz    2f\n"
-                                "   ahi   %0,1\n"
-                                "   clr   %0,%3\n"
-                                "   jl    0b\n"
-                                "2: sacf  0\n"
-				".section .fixup,\"ax\"\n"
-                                "3: lhi   %0,%h4\n"
-				"   basr  3,0\n"
-                                "   l     3,4f-.(3)\n"
-                                "   br    3\n"
-				"4: .long 2b\n"
-				".previous\n"
-				".section __ex_table,\"a\"\n"
-				"   .align 4\n"
-				"   .long  0b,3b\n"
-                                "   .long  1b,3b\n"
-				".previous"
-                                : "=&a" (len)
-                                : "a" (dst), "d" (src), "d" (count),
-                                  "K" (-EFAULT)
-                                : "2", "3", "4", "memory", "cc" );
-        return len;
+        __asm__ __volatile__ (
+		"   slr   %0,%0\n"
+		"   lr    2,%1\n"
+                "   lr    4,%2\n"
+                "   slr   3,3\n"
+                "   sacf  512\n"
+		"0: ic	  3,0(%0,4)\n"
+		"1: stc	  3,0(%0,2)\n"
+		"   ltr	  3,3\n"
+		"   jz	  2f\n"
+		"   ahi	  %0,1\n"
+		"   clr	  %0,%3\n"
+		"   jl	  0b\n"
+		"2: sacf  0\n"
+		".section .fixup,\"ax\"\n"
+		"3: lhi	  %0,%h4\n"
+		"   basr  3,0\n"
+		"   l	  3,4f-.(3)\n"
+		"   br	  3\n"
+		"4: .long 2b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"   .align 4\n"
+		"   .long  0b,3b\n"
+		"   .long  1b,3b\n"
+		".previous"
+		: "=&a" (len)
+		: "a" (dst), "d" (src), "d" (count), "K" (-EFAULT)
+		: "2", "3", "4", "memory", "cc" );
+	return len;
 }
 
+#else /* __s390x__ */
+
+static inline long
+__strncpy_from_user(char *dst, const char *src, long count)
+{
+	long len;
+	__asm__ __volatile__ (
+		"   slgr  %0,%0\n"
+		"   lgr	  2,%1\n"
+		"   lgr	  4,%2\n"
+		"   slr	  3,3\n"
+		"   sacf  512\n"
+		"0: ic	  3,0(%0,4)\n"
+		"1: stc	  3,0(%0,2)\n"
+		"   ltr	  3,3\n"
+		"   jz	  2f\n"
+		"   aghi  %0,1\n"
+		"   cgr	  %0,%3\n"
+		"   jl	  0b\n"
+		"2: sacf  0\n"
+		".section .fixup,\"ax\"\n"
+		"3: lghi  %0,%h4\n"
+		"   jg	  2b\n"	 
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"   .align 8\n"
+		"   .quad  0b,3b\n"
+		"   .quad  1b,3b\n"
+		".previous"
+		: "=&a" (len)
+		: "a"  (dst), "d" (src), "d" (count), "K" (-EFAULT)
+		: "cc", "2" ,"3", "4" );
+	return len;
+}
+
+#endif /* __s390x__ */
+
 static inline long
 strncpy_from_user(char *dst, const char *src, long count)
 {
@@ -453,35 +470,92 @@
  *
  * Return 0 for error
  */
+#ifndef __s390x__
+
+static inline unsigned long
+strnlen_user(const char * src, unsigned long n)
+{
+	__asm__ __volatile__ (
+		"   alr   %0,%1\n"
+		"   slr   0,0\n"
+		"   lr    4,%1\n"
+		"   sacf  512\n"
+		"0: srst  %0,4\n"
+		"   jo    0b\n"
+		"   slr   %0,%1\n"
+		"   ahi   %0,1\n"
+		"   sacf  0\n"
+		"1:\n"
+		".section .fixup,\"ax\"\n"
+		"2: sacf  0\n"
+		"   slr   %0,%0\n"
+		"   bras  4,3f\n"
+		"   .long 1b\n"
+		"3: l     4,0(4)\n"
+		"   br    4\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"  .align 4\n"
+		"  .long  0b,2b\n"
+		".previous"
+		: "+&a" (n) : "d" (src)
+		: "cc", "0", "4" );
+	return n;
+}
+
+#else /* __s390x__ */
+
 static inline unsigned long
 strnlen_user(const char * src, unsigned long n)
 {
-	__asm__ __volatile__ ("   alr   %0,%1\n"
-			      "   slr   0,0\n"
-			      "   lr    4,%1\n"
-			      "   sacf  512\n"
-			      "0: srst  %0,4\n"
-			      "   jo    0b\n"
-			      "   slr   %0,%1\n"
-			      "   ahi   %0,1\n"
-			      "   sacf  0\n"
-                              "1:\n"
-                              ".section .fixup,\"ax\"\n"
-                              "2: sacf  0\n"
-                              "   slr   %0,%0\n"
-                              "   bras  4,3f\n"
-                              "   .long 1b\n"
-                              "3: l     4,0(4)\n"
-                              "   br    4\n"
-                              ".previous\n"
-			      ".section __ex_table,\"a\"\n"
-			      "   .align 4\n"
-			      "   .long  0b,2b\n"
-			      ".previous"
-			      : "+&a" (n) : "d" (src)
-			      : "cc", "0", "4" );
-        return n;
+#if 0
+	__asm__ __volatile__ (
+		"   algr  %0,%1\n"
+		"   slgr  0,0\n"
+		"   lgr	  4,%1\n"
+		"   sacf  512\n"
+		"0: srst  %0,4\n"
+		"   jo	0b\n"
+		"   slgr  %0,%1\n"
+		"   aghi  %0,1\n"
+		"1: sacf  0\n"
+		".section .fixup,\"ax\"\n"
+		"2: slgr  %0,%0\n"
+		"   jg	  1b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"  .align 8\n"
+		"  .quad  0b,2b\n"
+		".previous"
+		: "+&a" (n) : "d" (src)
+		: "cc", "0", "4" );
+#else
+	__asm__ __volatile__ (
+		"   lgr	  4,%1\n"
+		"   sacf  512\n"
+		"0: cli   0(4),0x00\n"
+		"   la    4,1(4)\n"
+		"   je    1f\n"
+		"   brctg %0,0b\n"
+		"1: lgr	  %0,4\n"
+		"   slgr  %0,%1\n"
+		"2: sacf  0\n"
+		".section .fixup,\"ax\"\n"
+		"3: slgr  %0,%0\n"
+		"   jg    2b\n"  
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"  .align 8\n"
+		"  .quad  0b,3b\n"
+		".previous"
+		: "+&a" (n) : "d" (src)
+		: "cc", "4" );
+#endif
+	return n;
 }
+
+#endif /* __s390x__ */
+
 #define strlen_user(str) strnlen_user(str, ~0UL)
 
 /*
@@ -490,18 +564,18 @@
 
 extern long __clear_user_asm(void *to, long n);
 
-#define __clear_user(to, n)                                     \
-({                                                              \
-        __clear_user_asm(to, n);                                \
+#define __clear_user(to, n)					\
+({								\
+	__clear_user_asm(to, n);				\
 })
 
 static inline unsigned long
 clear_user(void *to, unsigned long n)
 {
-        if (access_ok(VERIFY_WRITE, to, n))
-                n = __clear_user(to, n);
-        return n;
+	if (access_ok(VERIFY_WRITE, to, n))
+		n = __clear_user(to, n);
+	return n;
 }
 
 
-#endif                                 /* _S390_UACCESS_H                  */
+#endif				       /* _S390_UACCESS_H		   */
diff -urN linux-2.5.67/include/asm-s390/unistd.h linux-2.5.67-s390/include/asm-s390/unistd.h
--- linux-2.5.67/include/asm-s390/unistd.h	Mon Apr 14 19:11:50 2003
+++ linux-2.5.67-s390/include/asm-s390/unistd.h	Mon Apr 14 19:11:59 2003
@@ -261,6 +261,91 @@
 
 #define NR_syscalls 263
 
+/* 
+ * There are some system calls that are not present on 64 bit, some
+ * have a different name although they do the same (e.g. __NR_chown32
+ * is __NR_chown on 64 bit).
+ */
+#ifdef __s390x__
+#undef  __NR_time
+#undef  __NR_lchown
+#undef  __NR_setuid
+#undef  __NR_getuid
+#undef  __NR_stime
+#undef  __NR_setgid
+#undef  __NR_getgid
+#undef  __NR_geteuid
+#undef  __NR_getegid
+#undef  __NR_setreuid
+#undef  __NR_setregid
+#undef  __NR_getrlimit
+#undef  __NR_getgroups
+#undef  __NR_setgroups
+#undef  __NR_fchown
+#undef  __NR_ioperm
+#undef  __NR_setfsuid
+#undef  __NR_setfsgid
+#undef  __NR__llseek
+#undef  __NR__newselect
+#undef  __NR_setresuid
+#undef  __NR_getresuid
+#undef  __NR_setresgid
+#undef  __NR_getresgid
+#undef  __NR_chown
+#undef  __NR_ugetrlimit
+#undef  __NR_mmap2
+#undef  __NR_truncate64
+#undef  __NR_ftruncate64
+#undef  __NR_stat64
+#undef  __NR_lstat64
+#undef  __NR_fstat64
+#undef  __NR_lchown32
+#undef  __NR_getuid32
+#undef  __NR_getgid32
+#undef  __NR_geteuid32
+#undef  __NR_getegid32
+#undef  __NR_setreuid32
+#undef  __NR_setregid32
+#undef  __NR_getgroups32
+#undef  __NR_setgroups32
+#undef  __NR_fchown32
+#undef  __NR_setresuid32
+#undef  __NR_getresuid32
+#undef  __NR_setresgid32
+#undef  __NR_getresgid32
+#undef  __NR_chown32
+#undef  __NR_setuid32
+#undef  __NR_setgid32
+#undef  __NR_setfsuid32
+#undef  __NR_setfsgid32
+#undef  __NR_getdents64
+#undef  __NR_fcntl64
+#undef  __NR_sendfile64
+
+#define __NR_select		142
+#define __NR_getrlimit		191	/* SuS compliant getrlimit */
+#define __NR_lchown  		198
+#define __NR_getuid  		199
+#define __NR_getgid  		200
+#define __NR_geteuid  		201
+#define __NR_getegid  		202
+#define __NR_setreuid  		203
+#define __NR_setregid  		204
+#define __NR_getgroups  	205
+#define __NR_setgroups  	206
+#define __NR_fchown  		207
+#define __NR_setresuid  	208
+#define __NR_getresuid  	209
+#define __NR_setresgid  	210
+#define __NR_getresgid  	211
+#define __NR_chown  		212
+#define __NR_setuid  		213
+#define __NR_setgid  		214
+#define __NR_setfsuid  		215
+#define __NR_setfsgid  		216
+
+#endif
+
 /* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
 
 #define __syscall_return(type, res)			     \
@@ -279,10 +364,10 @@
 	register long __svcres asm("2");		     \
 	long __res;					     \
 	__asm__ __volatile__ (				     \
-		"    .if %b1 < 256\n"			     \
+		"    .if %1 < 256\n"			     \
 		"    svc %b1\n"				     \
 		"    .else\n"				     \
-		"    lhi %%r1,%b1\n"			     \
+		"    la  %%r1,%1\n"			     \
 		"    svc 0\n"				     \
 		"    .endif"				     \
 		: "=d" (__svcres)			     \
@@ -298,10 +383,10 @@
 	register long __svcres asm("2");		     \
 	long __res;					     \
 	__asm__ __volatile__ (				     \
-		"    .if %b1 < 256\n"			     \
+		"    .if %1 < 256\n"			     \
 		"    svc %b1\n"				     \
 		"    .else\n"				     \
-		"    lhi %%r1,%b1\n"			     \
+		"    la  %%r1,%1\n"			     \
 		"    svc 0\n"				     \
 		"    .endif"				     \
 		: "=d" (__svcres)			     \
@@ -319,10 +404,10 @@
 	register long __svcres asm("2");		     \
 	long __res;					     \
 	__asm__ __volatile__ (				     \
-		"    .if %b1 < 256\n"			     \
+		"    .if %1 < 256\n"			     \
 		"    svc %b1\n"				     \
 		"    .else\n"				     \
-		"    lhi %%r1,%b1\n"			     \
+		"    la %%r1,%1\n"			     \
 		"    svc 0\n"				     \
 		"    .endif"				     \
 		: "=d" (__svcres)			     \
@@ -342,10 +427,10 @@
 	register long __svcres asm("2");		     \
 	long __res;					     \
 	__asm__ __volatile__ (				     \
-		"    .if %b1 < 256\n"			     \
+		"    .if %1 < 256\n"			     \
 		"    svc %b1\n"				     \
 		"    .else\n"				     \
-		"    lhi %%r1,%b1\n"			     \
+		"    la  %%r1,%1\n"			     \
 		"    svc 0\n"				     \
 		"    .endif"				     \
 		: "=d" (__svcres)			     \
@@ -368,10 +453,10 @@
 	register long __svcres asm("2");		     \
 	long __res;					     \
 	__asm__ __volatile__ (				     \
-		"    .if %b1 < 256\n"			     \
+		"    .if %1 < 256\n"			     \
 		"    svc %b1\n"				     \
 		"    .else\n"				     \
-		"    lhi %%r1,%b1\n"			     \
+		"    la  %%r1,%1\n"			     \
 		"    svc 0\n"				     \
 		"    .endif"				     \
 		: "=d" (__svcres)			     \
@@ -397,10 +482,10 @@
 	register long __svcres asm("2");		     \
 	long __res;					     \
 	__asm__ __volatile__ (				     \
-		"    .if %b1 < 256\n"			     \
+		"    .if %1 < 256\n"			     \
 		"    svc %b1\n"				     \
 		"    .else\n"				     \
-		"    lhi %%r1,%b1\n"			     \
+		"    la  %%r1,%1\n"			     \
 		"    svc 0\n"				     \
 		"    .endif"				     \
 		: "=d" (__svcres)			     \

