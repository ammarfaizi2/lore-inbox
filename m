Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280744AbRKGCRa>; Tue, 6 Nov 2001 21:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280743AbRKGCRU>; Tue, 6 Nov 2001 21:17:20 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:45252 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280750AbRKGCQ5>; Tue, 6 Nov 2001 21:16:57 -0500
From: "Paul E. McKenney" <pmckenne@us.ibm.com>
Message-Id: <200111070216.fA72GY602242@eng4.beaverton.ibm.com>
Subject: [RFC][PATCH] read_barrier.v2.4.14.patch.2001.11.06
To: linux-kernel@vger.kernel.org
Date: Tue, 6 Nov 2001 18:16:32 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Interpreting silence as assent...  ;-)

Here is a patch containing read_barrier_depends(), memory_barrier(),
read_barrier(), and write_barrier(), as discussed on lkml a while back.
(See http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.1/1430.html)

This patch defines read_barrier_depends() as in the previous patch.
In the name of backwards compatibility, it defines mb(), rmb(), and wmb()
in terms of the new memory_barrier(), read_barrier(), and write_barrier()
in each architecture.  If this approach is acceptable, I will follow up
with patches to change the existing uses of smp_mb(), smp_rmb(), smp_wmb(),
mb(), rmb(), and wmb() to instead use the new names.  Finally, I will
produce patches to remove the definitions of the old names.

Thoughts?

						Thanx, Paul


diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-alpha/system.h linux-2.4.14.read_barrier/include/asm-alpha/system.h
--- linux-2.4.14/include/asm-alpha/system.h	Thu Oct  4 18:47:08 2001
+++ linux-2.4.14.read_barrier/include/asm-alpha/system.h	Tue Nov  6 16:46:52 2001
@@ -142,22 +142,31 @@
 
 extern struct task_struct* alpha_switch_to(unsigned long, struct task_struct*);
 
-#define mb() \
+#define memory_barrier() \
 __asm__ __volatile__("mb": : :"memory")
 
-#define rmb() \
+#define read_barrier() \
 __asm__ __volatile__("mb": : :"memory")
 
-#define wmb() \
+#define read_barrier_depends() \
+__asm__ __volatile__("mb": : :"memory")
+
+#define write_barrier() \
 __asm__ __volatile__("wmb": : :"memory")
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	barrier()
 #define smp_wmb()	barrier()
 #endif
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-arm/system.h linux-2.4.14.read_barrier/include/asm-arm/system.h
--- linux-2.4.14/include/asm-arm/system.h	Mon Nov 27 17:07:59 2000
+++ linux-2.4.14.read_barrier/include/asm-arm/system.h	Tue Nov  6 16:48:09 2001
@@ -36,11 +36,16 @@
  */
 #include <asm/proc/system.h>
 
-#define mb() __asm__ __volatile__ ("" : : : "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define memory_barrier() __asm__ __volatile__ ("" : : : "memory")
+#define read_barrier() mb()
+#define read_barrier_depends() do { } while(0)
+#define write_barrier() mb()
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #define prepare_to_switch()    do { } while(0)
 
 /*
@@ -67,12 +72,14 @@
 
 #define smp_mb()		mb()
 #define smp_rmb()		rmb()
+#define smp_read_barrier_depends()		read_barrier_depends()
 #define smp_wmb()		wmb()
 
 #else
 
 #define smp_mb()		barrier()
 #define smp_rmb()		barrier()
+#define smp_read_barrier_depends()		do { } while(0)
 #define smp_wmb()		barrier()
 
 #define cli()			__cli()
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-cris/system.h linux-2.4.14.read_barrier/include/asm-cris/system.h
--- linux-2.4.14/include/asm-cris/system.h	Mon Oct  8 11:43:54 2001
+++ linux-2.4.14.read_barrier/include/asm-cris/system.h	Tue Nov  6 16:48:38 2001
@@ -147,17 +147,24 @@
 #endif
 }
 
-#define mb() __asm__ __volatile__ ("" : : : "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define memory_barrier() __asm__ __volatile__ ("" : : : "memory")
+#define read_barrier() mb()
+#define read_barrier_depends() do { } while(0)
+#define write_barrier() mb()
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #ifdef CONFIG_SMP
 #define smp_mb()        mb()
 #define smp_rmb()       rmb()
+#define smp_read_barrier_depends()     read_barrier_depends()
 #define smp_wmb()       wmb()
 #else
 #define smp_mb()        barrier()
 #define smp_rmb()       barrier()
+#define smp_read_barrier_depends()     do { } while(0)
 #define smp_wmb()       barrier()
 #endif
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-cris/system.h.orig linux-2.4.14.read_barrier/include/asm-cris/system.h.orig
--- linux-2.4.14/include/asm-cris/system.h.orig	Wed Dec 31 16:00:00 1969
+++ linux-2.4.14.read_barrier/include/asm-cris/system.h.orig	Mon Oct  8 11:43:54 2001
@@ -0,0 +1,173 @@
+#ifndef __ASM_CRIS_SYSTEM_H
+#define __ASM_CRIS_SYSTEM_H
+
+#include <linux/config.h>
+
+#include <asm/segment.h>
+
+/* the switch_to macro calls resume, an asm function in entry.S which does the actual
+ * task switching.
+ */
+
+extern struct task_struct *resume(struct task_struct *prev, struct task_struct *next, int);
+#define prepare_to_switch()     do { } while(0)
+#define switch_to(prev,next,last) last = resume(prev,next, \
+					 (int)&((struct task_struct *)0)->thread)
+
+/* read the CPU version register */
+
+static inline unsigned long rdvr(void) { 
+	unsigned long vr;
+	__asm__ volatile ("move $vr,%0" : "=rm" (vr));
+	return vr;
+}
+
+/* read/write the user-mode stackpointer */
+
+static inline unsigned long rdusp(void) {
+	unsigned long usp;
+	__asm__ __volatile__("move $usp,%0" : "=rm" (usp));
+	return usp;
+}
+
+#define wrusp(usp) \
+	__asm__ __volatile__("move %0,$usp" : /* no outputs */ : "rm" (usp))
+
+/* read the current stackpointer */
+
+static inline unsigned long rdsp(void) {
+	unsigned long sp;
+	__asm__ __volatile__("move.d $sp,%0" : "=rm" (sp));
+	return sp;
+}
+
+static inline unsigned long _get_base(char * addr)
+{
+  return 0;
+}
+
+#define nop() __asm__ __volatile__ ("nop");
+
+#define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
+#define tas(ptr) (xchg((ptr),1))
+
+struct __xchg_dummy { unsigned long a[100]; };
+#define __xg(x) ((struct __xchg_dummy *)(x))
+
+#if 0
+/* use these and an oscilloscope to see the fraction of time we're running with IRQ's disabled */
+/* it assumes the LED's are on port 0x90000000 of course. */
+#define sti() __asm__ __volatile__ ( "ei\n\tpush $r0\n\tmoveq 0,$r0\n\tmove.d $r0,[0x90000000]\n\tpop $r0" );
+#define cli() __asm__ __volatile__ ( "di\n\tpush $r0\n\tmove.d 0x40000,$r0\n\tmove.d $r0,[0x90000000]\n\tpop $r0");
+#define save_flags(x) __asm__ __volatile__ ("move $ccr,%0" : "=rm" (x) : : "memory");
+#define restore_flags(x) __asm__ __volatile__ ("move %0,$ccr\n\tbtstq 5,%0\n\tbpl 1f\n\tnop\n\tpush $r0\n\tmoveq 0,$r0\n\tmove.d $r0,[0x90000000]\n\tpop $r0\n1:\n" : : "r" (x) : "memory");
+#else
+#define __cli() __asm__ __volatile__ ( "di");
+#define __sti() __asm__ __volatile__ ( "ei" );
+#define __save_flags(x) __asm__ __volatile__ ("move $ccr,%0" : "=rm" (x) : : "memory");
+#define __restore_flags(x) __asm__ __volatile__ ("move %0,$ccr" : : "rm" (x) : "memory");
+
+/* For spinlocks etc */
+#define local_irq_save(x) __asm__ __volatile__ ("move $ccr,%0\n\tdi" : "=rm" (x) : : "memory"); 
+#define local_irq_restore(x) restore_flags(x)
+
+#define local_irq_disable()  cli()
+#define local_irq_enable()   sti()
+
+#endif
+
+#define cli() __cli()
+#define sti() __sti()
+#define save_flags(x) __save_flags(x)
+#define restore_flags(x) __restore_flags(x)
+#define save_and_cli(x) do { __save_flags(x); cli(); } while(0)
+
+static inline unsigned long __xchg(unsigned long x, void * ptr, int size)
+{
+  /* since Etrax doesn't have any atomic xchg instructions, we need to disable
+     irq's (if enabled) and do it with move.d's */
+#if 0
+  unsigned int flags;
+  save_flags(flags); /* save flags, including irq enable bit */
+  cli();             /* shut off irq's */
+  switch (size) {
+  case 1:
+    __asm__ __volatile__ (
+       "move.b %0,r0\n\t"
+       "move.b %1,%0\n\t"
+       "move.b r0,%1\n\t"
+       : "=r" (x)
+       : "m" (*__xg(ptr)), "r" (x)
+       : "memory","r0");    
+    break;
+  case 2:
+    __asm__ __volatile__ (
+       "move.w %0,r0\n\t"
+       "move.w %1,%0\n\t"
+       "move.w r0,%1\n\t"
+       : "=r" (x)
+       : "m" (*__xg(ptr)), "r" (x)
+       : "memory","r0");
+    break;
+  case 4:
+    __asm__ __volatile__ (
+       "move.d %0,r0\n\t"
+       "move.d %1,%0\n\t"
+       "move.d r0,%1\n\t"
+       : "=r" (x)
+       : "m" (*__xg(ptr)), "r" (x)
+       : "memory","r0");
+    break;
+  }
+  restore_flags(flags); /* restore irq enable bit */
+  return x;
+#else
+  unsigned long flags,temp;
+  save_flags(flags); /* save flags, including irq enable bit */
+  cli();             /* shut off irq's */
+  switch (size) {
+  case 1:
+    *((unsigned char *)&temp) = x;
+    x = *(unsigned char *)ptr;
+    *(unsigned char *)ptr = *((unsigned char *)&temp);
+    break;
+  case 2:
+    *((unsigned short *)&temp) = x;
+    x = *(unsigned short *)ptr;
+    *(unsigned short *)ptr = *((unsigned short *)&temp);
+    break;
+  case 4:
+    temp = x;
+    x = *(unsigned long *)ptr;
+    *(unsigned long *)ptr = temp;
+    break;
+  }
+  restore_flags(flags); /* restore irq enable bit */
+  return x;
+#endif
+}
+
+#define mb() __asm__ __volatile__ ("" : : : "memory")
+#define rmb() mb()
+#define wmb() mb()
+
+#ifdef CONFIG_SMP
+#define smp_mb()        mb()
+#define smp_rmb()       rmb()
+#define smp_wmb()       wmb()
+#else
+#define smp_mb()        barrier()
+#define smp_rmb()       barrier()
+#define smp_wmb()       barrier()
+#endif
+
+#define iret()
+
+/*
+ * disable hlt during certain critical i/o operations
+ */
+#define HAVE_DISABLE_HLT
+void disable_hlt(void);
+void enable_hlt(void);
+
+#endif
Binary files linux-2.4.14/include/asm-i386/.system.h.rej.swp and linux-2.4.14.read_barrier/include/asm-i386/.system.h.rej.swp differ
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-i386/system.h linux-2.4.14.read_barrier/include/asm-i386/system.h
--- linux-2.4.14/include/asm-i386/system.h	Mon Nov  5 12:42:13 2001
+++ linux-2.4.14.read_barrier/include/asm-i386/system.h	Tue Nov  6 16:49:45 2001
@@ -286,22 +286,32 @@
  * nop for these.
  */
  
-#define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
-#define rmb()	mb()
+#define memory_barrier() \
+		__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#define read_barrier()	mb()
+#define read_barrier_depends()	do { } while(0)
 
 #ifdef CONFIG_X86_OOSTORE
-#define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#define write_barrier() \
+		__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #else
-#define wmb()	__asm__ __volatile__ ("": : :"memory")
+#define write_barrier() \
+		__asm__ __volatile__ ("": : :"memory")
 #endif
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 #endif
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-i386/system.h.orig linux-2.4.14.read_barrier/include/asm-i386/system.h.orig
--- linux-2.4.14/include/asm-i386/system.h.orig	Wed Dec 31 16:00:00 1969
+++ linux-2.4.14.read_barrier/include/asm-i386/system.h.orig	Mon Nov  5 12:42:13 2001
@@ -0,0 +1,354 @@
+#ifndef __ASM_SYSTEM_H
+#define __ASM_SYSTEM_H
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <asm/segment.h>
+#include <linux/bitops.h> /* for LOCK_PREFIX */
+
+#ifdef __KERNEL__
+
+struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
+extern void FASTCALL(__switch_to(struct task_struct *prev, struct task_struct *next));
+
+#define prepare_to_switch()	do { } while(0)
+#define switch_to(prev,next,last) do {					\
+	asm volatile("pushl %%esi\n\t"					\
+		     "pushl %%edi\n\t"					\
+		     "pushl %%ebp\n\t"					\
+		     "movl %%esp,%0\n\t"	/* save ESP */		\
+		     "movl %3,%%esp\n\t"	/* restore ESP */	\
+		     "movl $1f,%1\n\t"		/* save EIP */		\
+		     "pushl %4\n\t"		/* restore EIP */	\
+		     "jmp __switch_to\n"				\
+		     "1:\t"						\
+		     "popl %%ebp\n\t"					\
+		     "popl %%edi\n\t"					\
+		     "popl %%esi\n\t"					\
+		     :"=m" (prev->thread.esp),"=m" (prev->thread.eip),	\
+		      "=b" (last)					\
+		     :"m" (next->thread.esp),"m" (next->thread.eip),	\
+		      "a" (prev), "d" (next),				\
+		      "b" (prev));					\
+} while (0)
+
+#define _set_base(addr,base) do { unsigned long __pr; \
+__asm__ __volatile__ ("movw %%dx,%1\n\t" \
+	"rorl $16,%%edx\n\t" \
+	"movb %%dl,%2\n\t" \
+	"movb %%dh,%3" \
+	:"=&d" (__pr) \
+	:"m" (*((addr)+2)), \
+	 "m" (*((addr)+4)), \
+	 "m" (*((addr)+7)), \
+         "0" (base) \
+        ); } while(0)
+
+#define _set_limit(addr,limit) do { unsigned long __lr; \
+__asm__ __volatile__ ("movw %%dx,%1\n\t" \
+	"rorl $16,%%edx\n\t" \
+	"movb %2,%%dh\n\t" \
+	"andb $0xf0,%%dh\n\t" \
+	"orb %%dh,%%dl\n\t" \
+	"movb %%dl,%2" \
+	:"=&d" (__lr) \
+	:"m" (*(addr)), \
+	 "m" (*((addr)+6)), \
+	 "0" (limit) \
+        ); } while(0)
+
+#define set_base(ldt,base) _set_base( ((char *)&(ldt)) , (base) )
+#define set_limit(ldt,limit) _set_limit( ((char *)&(ldt)) , ((limit)-1)>>12 )
+
+static inline unsigned long _get_base(char * addr)
+{
+	unsigned long __base;
+	__asm__("movb %3,%%dh\n\t"
+		"movb %2,%%dl\n\t"
+		"shll $16,%%edx\n\t"
+		"movw %1,%%dx"
+		:"=&d" (__base)
+		:"m" (*((addr)+2)),
+		 "m" (*((addr)+4)),
+		 "m" (*((addr)+7)));
+	return __base;
+}
+
+#define get_base(ldt) _get_base( ((char *)&(ldt)) )
+
+/*
+ * Load a segment. Fall back on loading the zero
+ * segment if something goes wrong..
+ */
+#define loadsegment(seg,value)			\
+	asm volatile("\n"			\
+		"1:\t"				\
+		"movl %0,%%" #seg "\n"		\
+		"2:\n"				\
+		".section .fixup,\"ax\"\n"	\
+		"3:\t"				\
+		"pushl $0\n\t"			\
+		"popl %%" #seg "\n\t"		\
+		"jmp 2b\n"			\
+		".previous\n"			\
+		".section __ex_table,\"a\"\n\t"	\
+		".align 4\n\t"			\
+		".long 1b,3b\n"			\
+		".previous"			\
+		: :"m" (*(unsigned int *)&(value)))
+
+/*
+ * Clear and set 'TS' bit respectively
+ */
+#define clts() __asm__ __volatile__ ("clts")
+#define read_cr0() ({ \
+	unsigned int __dummy; \
+	__asm__( \
+		"movl %%cr0,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr0(x) \
+	__asm__("movl %0,%%cr0": :"r" (x));
+
+#define read_cr4() ({ \
+	unsigned int __dummy; \
+	__asm__( \
+		"movl %%cr4,%0\n\t" \
+		:"=r" (__dummy)); \
+	__dummy; \
+})
+#define write_cr4(x) \
+	__asm__("movl %0,%%cr4": :"r" (x));
+#define stts() write_cr0(8 | read_cr0())
+
+#endif	/* __KERNEL__ */
+
+#define wbinvd() \
+	__asm__ __volatile__ ("wbinvd": : :"memory");
+
+static inline unsigned long get_limit(unsigned long segment)
+{
+	unsigned long __limit;
+	__asm__("lsll %1,%0"
+		:"=r" (__limit):"r" (segment));
+	return __limit+1;
+}
+
+#define nop() __asm__ __volatile__ ("nop")
+
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
+static inline void __set_64bit (unsigned long long * ptr,
+		unsigned int low, unsigned int high)
+{
+	__asm__ __volatile__ (
+		"\n1:\t"
+		"movl (%0), %%eax\n\t"
+		"movl 4(%0), %%edx\n\t"
+		"cmpxchg8b (%0)\n\t"
+		"jnz 1b"
+		: /* no outputs */
+		:	"D"(ptr),
+			"b"(low),
+			"c"(high)
+		:	"ax","dx","memory");
+}
+
+static inline void __set_64bit_constant (unsigned long long *ptr,
+						 unsigned long long value)
+{
+	__set_64bit(ptr,(unsigned int)(value), (unsigned int)((value)>>32ULL));
+}
+#define ll_low(x)	*(((unsigned int*)&(x))+0)
+#define ll_high(x)	*(((unsigned int*)&(x))+1)
+
+static inline void __set_64bit_var (unsigned long long *ptr,
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
+#endif
+
+/*
+ * Force strict CPU ordering.
+ * And yes, this is required on UP too when we're talking
+ * to devices.
+ *
+ * For now, "wmb()" doesn't actually do anything, as all
+ * Intel CPU's follow what Intel calls a *Processor Order*,
+ * in which all writes are seen in the program order even
+ * outside the CPU.
+ *
+ * I expect future Intel CPU's to have a weaker ordering,
+ * but I'd also expect them to finally get their act together
+ * and add some real memory barriers if so.
+ *
+ * Some non intel clones support out of order store. wmb() ceases to be a
+ * nop for these.
+ */
+ 
+#define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#define rmb()	mb()
+
+#ifdef CONFIG_X86_OOSTORE
+#define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#else
+#define wmb()	__asm__ __volatile__ ("": : :"memory")
+#endif
+
+#ifdef CONFIG_SMP
+#define smp_mb()	mb()
+#define smp_rmb()	rmb()
+#define smp_wmb()	wmb()
+#else
+#define smp_mb()	barrier()
+#define smp_rmb()	barrier()
+#define smp_wmb()	barrier()
+#endif
+
+#define set_mb(var, value) do { xchg(&var, value); } while (0)
+#define set_wmb(var, value) do { var = value; wmb(); } while (0)
+
+/* interrupt control.. */
+#define __save_flags(x)		__asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)
+#define __restore_flags(x) 	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
+#define __cli() 		__asm__ __volatile__("cli": : :"memory")
+#define __sti()			__asm__ __volatile__("sti": : :"memory")
+/* used in the idle loop; sti takes one instruction cycle to complete */
+#define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
+
+/* For spinlocks etc */
+#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+#define local_irq_restore(x)	__restore_flags(x)
+#define local_irq_disable()	__cli()
+#define local_irq_enable()	__sti()
+
+#ifdef CONFIG_SMP
+
+extern void __global_cli(void);
+extern void __global_sti(void);
+extern unsigned long __global_save_flags(void);
+extern void __global_restore_flags(unsigned long);
+#define cli() __global_cli()
+#define sti() __global_sti()
+#define save_flags(x) ((x)=__global_save_flags())
+#define restore_flags(x) __global_restore_flags(x)
+
+#else
+
+#define cli() __cli()
+#define sti() __sti()
+#define save_flags(x) __save_flags(x)
+#define restore_flags(x) __restore_flags(x)
+
+#endif
+
+/*
+ * disable hlt during certain critical i/o operations
+ */
+#define HAVE_DISABLE_HLT
+void disable_hlt(void);
+void enable_hlt(void);
+
+extern int is_sony_vaio_laptop;
+
+#endif
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-i386/system.h.rej linux-2.4.14.read_barrier/include/asm-i386/system.h.rej
--- linux-2.4.14/include/asm-i386/system.h.rej	Wed Dec 31 16:00:00 1969
+++ linux-2.4.14.read_barrier/include/asm-i386/system.h.rej	Tue Nov  6 16:15:50 2001
@@ -0,0 +1,36 @@
+***************
+*** 284,298 ****
+   */
+  #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+  #define rmb()	mb()
+  #define wmb()	__asm__ __volatile__ ("": : :"memory")
+  
+  #ifdef CONFIG_SMP
+  #define smp_mb()	mb()
+  #define smp_rmb()	rmb()
+  #define smp_wmb()	wmb()
+  #else
+  #define smp_mb()	barrier()
+  #define smp_rmb()	barrier()
+  #define smp_wmb()	barrier()
+  #endif
+  
+--- 284,301 ----
+   */
+  #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+  #define rmb()	mb()
++ #define read_barrier_depends()	do { } while(0)
+  #define wmb()	__asm__ __volatile__ ("": : :"memory")
+  
+  #ifdef CONFIG_SMP
+  #define smp_mb()	mb()
+  #define smp_rmb()	rmb()
++ #define smp_read_barrier_depends()	read_barrier_depends()
+  #define smp_wmb()	wmb()
+  #else
+  #define smp_mb()	barrier()
+  #define smp_rmb()	barrier()
++ #define smp_read_barrier_depends()	do { } while(0)
+  #define smp_wmb()	barrier()
+  #endif
+  
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-ia64/system.h linux-2.4.14.read_barrier/include/asm-ia64/system.h
--- linux-2.4.14/include/asm-ia64/system.h	Tue Jul 31 10:30:09 2001
+++ linux-2.4.14.read_barrier/include/asm-ia64/system.h	Tue Nov  6 16:50:56 2001
@@ -80,33 +80,43 @@
  * architecturally visible effects of a memory access have occurred
  * (at a minimum, this means the memory has been read or written).
  *
- *   wmb():	Guarantees that all preceding stores to memory-
+ *   write_barrier():	Guarantees that all preceding stores to memory-
  *		like regions are visible before any subsequent
  *		stores and that all following stores will be
  *		visible only after all previous stores.
- *   rmb():	Like wmb(), but for reads.
- *   mb():	wmb()/rmb() combo, i.e., all previous memory
+ *   read_barrier():	Like wmb(), but for reads.
+ *   read_barrier_depends():	Like rmb(), but only for pairs
+ *		of loads where the second load depends on the
+ *		value loaded by the first.
+ *   memory_barrier():	wmb()/rmb() combo, i.e., all previous memory
  *		accesses are visible before all subsequent
  *		accesses and vice versa.  This is also known as
  *		a "fence."
  *
- * Note: "mb()" and its variants cannot be used as a fence to order
- * accesses to memory mapped I/O registers.  For that, mf.a needs to
+ * Note: "memory_barrier()" and its variants cannot be used as a fence to
+ * order accesses to memory mapped I/O registers.  For that, mf.a needs to
  * be used.  However, we don't want to always use mf.a because (a)
  * it's (presumably) much slower than mf and (b) mf.a is supported for
  * sequential memory pages only.
  */
-#define mb()	__asm__ __volatile__ ("mf" ::: "memory")
-#define rmb()	mb()
-#define wmb()	mb()
+#define memory_barrier()	__asm__ __volatile__ ("mf" ::: "memory")
+#define read_barrier()		mb()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		mb()
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #ifdef CONFIG_SMP
 # define smp_mb()	mb()
 # define smp_rmb()	rmb()
+# define smp_read_barrier_depends()	read_barrier_depends()
 # define smp_wmb()	wmb()
 #else
 # define smp_mb()	barrier()
 # define smp_rmb()	barrier()
+# define smp_read_barrier_depends()	do { } while(0)
 # define smp_wmb()	barrier()
 #endif
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-m68k/system.h linux-2.4.14.read_barrier/include/asm-m68k/system.h
--- linux-2.4.14/include/asm-m68k/system.h	Thu Oct 25 13:53:55 2001
+++ linux-2.4.14.read_barrier/include/asm-m68k/system.h	Tue Nov  6 16:51:50 2001
@@ -78,14 +78,20 @@
  * Not really required on m68k...
  */
 #define nop()		do { asm volatile ("nop"); barrier(); } while (0)
-#define mb()		barrier()
-#define rmb()		barrier()
-#define wmb()		barrier()
+#define memory_barrier()	barrier()
+#define read_barrier()		barrier()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		barrier()
 #define set_mb(var, value)    do { xchg(&var, value); } while (0)
 #define set_wmb(var, value)    do { var = value; wmb(); } while (0)
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-mips/system.h linux-2.4.14.read_barrier/include/asm-mips/system.h
--- linux-2.4.14/include/asm-mips/system.h	Sun Sep  9 10:43:01 2001
+++ linux-2.4.14.read_barrier/include/asm-mips/system.h	Tue Nov  6 16:53:02 2001
@@ -149,13 +149,14 @@
 #ifdef CONFIG_CPU_HAS_WB
 
 #include <asm/wbflush.h>
-#define rmb()	do { } while(0)
-#define wmb()	wbflush()
-#define mb()	wbflush()
+#define read_barrier()		do { } while(0)
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		wbflush()
+#define memory_barrier()	wbflush()
 
 #else /* CONFIG_CPU_HAS_WB  */
 
-#define mb()						\
+#define memory_barrier()				\
 __asm__ __volatile__(					\
 	"# prevent instructions being moved around\n\t"	\
 	".set\tnoreorder\n\t"				\
@@ -165,18 +166,25 @@
 	: /* no output */				\
 	: /* no input */				\
 	: "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define read_barrier() mb()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier() mb()
 
 #endif /* CONFIG_CPU_HAS_WB  */
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 #endif
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-mips64/system.h linux-2.4.14.read_barrier/include/asm-mips64/system.h
--- linux-2.4.14/include/asm-mips64/system.h	Wed Jul  4 11:50:39 2001
+++ linux-2.4.14.read_barrier/include/asm-mips64/system.h	Tue Nov  6 16:53:35 2001
@@ -137,7 +137,7 @@
 /*
  * These are probably defined overly paranoid ...
  */
-#define mb()						\
+#define memory_barrier()				\
 __asm__ __volatile__(					\
 	"# prevent instructions being moved around\n\t"	\
 	".set\tnoreorder\n\t"				\
@@ -146,16 +146,23 @@
 	: /* no output */				\
 	: /* no input */				\
 	: "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define read_barrier() mb()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier() mb()
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 #endif
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-parisc/system.h linux-2.4.14.read_barrier/include/asm-parisc/system.h
--- linux-2.4.14/include/asm-parisc/system.h	Wed Dec  6 11:46:39 2000
+++ linux-2.4.14.read_barrier/include/asm-parisc/system.h	Tue Nov  6 16:54:55 2001
@@ -50,6 +50,7 @@
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	wmb()
 #else
 /* This is simply the barrier() macro from linux/kernel.h but when serial.c
@@ -58,6 +59,7 @@
  */
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
 #endif
 
@@ -120,8 +122,14 @@
 		: "r" (gr), "i" (cr))
 
 
-#define mb()  __asm__ __volatile__ ("sync" : : :"memory")
-#define wmb() mb()
+#define memory_barrier()  __asm__ __volatile__ ("sync" : : :"memory")
+#define read_barrier() mb()
+#define write_barrier() mb()
+#define read_barrier_depends()	do { } while(0)
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 extern unsigned long __xchg(unsigned long, unsigned long *, int);
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-ppc/system.h linux-2.4.14.read_barrier/include/asm-ppc/system.h
--- linux-2.4.14/include/asm-ppc/system.h	Tue Aug 28 06:58:33 2001
+++ linux-2.4.14.read_barrier/include/asm-ppc/system.h	Tue Nov  6 16:55:47 2001
@@ -22,17 +22,24 @@
  * providing an ordering (separately) for (a) cacheable stores and (b)
  * loads and stores to non-cacheable memory (e.g. I/O devices).
  *
- * mb() prevents loads and stores being reordered across this point.
- * rmb() prevents loads being reordered across this point.
- * wmb() prevents stores being reordered across this point.
+ * memory_barrier() prevents loads and stores being reordered across this point.
+ * read_barrier() prevents loads being reordered across this point.
+ * read_barrier_depends() prevents data-dependant loads being reordered
+ *	across this point (nop on PPC).
+ * write_barrier() prevents stores being reordered across this point.
  *
  * We can use the eieio instruction for wmb, but since it doesn't
  * give any ordering guarantees about loads, we have to use the
  * stronger but slower sync instruction for mb and rmb.
  */
-#define mb()  __asm__ __volatile__ ("sync" : : : "memory")
-#define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
-#define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
+#define memory_barrier()  __asm__ __volatile__ ("sync" : : : "memory")
+#define read_barrier()  __asm__ __volatile__ ("sync" : : : "memory")
+#define read_barrier_depends()  do { } while(0)
+#define write_barrier()  __asm__ __volatile__ ("eieio" : : : "memory")
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
 #define set_wmb(var, value)	do { var = value; wmb(); } while (0)
@@ -40,10 +47,12 @@
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	__asm__ __volatile__("": : :"memory")
 #define smp_rmb()	__asm__ __volatile__("": : :"memory")
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("": : :"memory")
 #endif /* CONFIG_SMP */
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-s390/system.h linux-2.4.14.read_barrier/include/asm-s390/system.h
--- linux-2.4.14/include/asm-s390/system.h	Wed Jul 25 14:12:02 2001
+++ linux-2.4.14.read_barrier/include/asm-s390/system.h	Tue Nov  6 16:56:13 2001
@@ -115,14 +115,20 @@
 
 #define eieio()  __asm__ __volatile__ ("BCR 15,0") 
 # define SYNC_OTHER_CORES(x)   eieio() 
-#define mb()    eieio()
-#define rmb()   eieio()
-#define wmb()   eieio()
+#define memory_barrier()    eieio()
+#define read_barrier()   eieio()
+#define read_barrier_depends() do { } while(0)
+#define write_barrier()   eieio()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
+#define smp_read_barrier_depends()    read_barrier_depends()
 #define smp_wmb()      wmb()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 
 #define set_mb(var, value)      do { var = value; mb(); } while (0)
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-s390x/system.h linux-2.4.14.read_barrier/include/asm-s390x/system.h
--- linux-2.4.14/include/asm-s390x/system.h	Wed Jul 25 14:12:03 2001
+++ linux-2.4.14.read_barrier/include/asm-s390x/system.h	Tue Nov  6 16:56:44 2001
@@ -128,17 +128,23 @@
 
 #define eieio()  __asm__ __volatile__ ("BCR 15,0") 
 # define SYNC_OTHER_CORES(x)   eieio() 
-#define mb()    eieio()
-#define rmb()   eieio()
-#define wmb()   eieio()
+#define memory_barrier()    eieio()
+#define read_barrier()   eieio()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()   eieio()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
+#define smp_read_barrier_depends()    read_barrier_depends()
 #define smp_wmb()      wmb()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
 
 #define set_mb(var, value)      do { var = value; mb(); } while (0)
 #define set_wmb(var, value)     do { var = value; wmb(); } while (0)
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 /* interrupt control.. */
 #define __sti() ({ \
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-sh/system.h linux-2.4.14.read_barrier/include/asm-sh/system.h
--- linux-2.4.14/include/asm-sh/system.h	Sat Sep  8 12:29:09 2001
+++ linux-2.4.14.read_barrier/include/asm-sh/system.h	Tue Nov  6 16:57:42 2001
@@ -86,17 +86,24 @@
 
 extern void __xchg_called_with_bad_pointer(void);
 
-#define mb()	__asm__ __volatile__ ("": : :"memory")
-#define rmb()	mb()
-#define wmb()	__asm__ __volatile__ ("": : :"memory")
+#define memory_barrier()	__asm__ __volatile__ ("": : :"memory")
+#define read_barrier()		mb()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		__asm__ __volatile__ ("": : :"memory")
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	barrier()
 #endif
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-sparc/system.h linux-2.4.14.read_barrier/include/asm-sparc/system.h
--- linux-2.4.14/include/asm-sparc/system.h	Tue Oct 30 15:08:11 2001
+++ linux-2.4.14.read_barrier/include/asm-sparc/system.h	Tue Nov  6 16:58:11 2001
@@ -275,14 +275,20 @@
 #endif
 
 /* XXX Change this if we ever use a PSO mode kernel. */
-#define mb()	__asm__ __volatile__ ("" : : : "memory")
-#define rmb()	mb()
-#define wmb()	mb()
+#define memory_barrier()	__asm__ __volatile__ ("" : : : "memory")
+#define read_barrier()		mb()
+#define read_barrier_depends()	do { } while(0)
+#define write_barrier()		mb()
 #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
 #define set_wmb(__var, __value) set_mb(__var, __value)
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
+
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
 
 #define nop() __asm__ __volatile__ ("nop");
 
diff -urN -x /home/mckenney/dontdiff linux-2.4.14/include/asm-sparc64/system.h linux-2.4.14.read_barrier/include/asm-sparc64/system.h
--- linux-2.4.14/include/asm-sparc64/system.h	Fri Sep  7 11:01:20 2001
+++ linux-2.4.14.read_barrier/include/asm-sparc64/system.h	Tue Nov  6 16:59:02 2001
@@ -96,22 +96,29 @@
 #define nop() 		__asm__ __volatile__ ("nop")
 
 #define membar(type)	__asm__ __volatile__ ("membar " type : : : "memory");
-#define mb()		\
+#define memory_barrier()		\
 	membar("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad");
-#define rmb()		membar("#LoadLoad")
-#define wmb()		membar("#StoreStore")
+#define read_barrier()			membar("#LoadLoad")
+#define read_barrier_depends()		do { } while(0)
+#define write_barrier()			membar("#StoreStore")
 #define set_mb(__var, __value) \
 	do { __var = __value; membar("#StoreLoad | #StoreStore"); } while(0)
 #define set_wmb(__var, __value) \
 	do { __var = __value; membar("#StoreStore"); } while(0)
 
+#define mb()	memory_barrier()
+#define rmb()	read_barrier()
+#define wmb()	write_barrier()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
+#define smp_read_barrier_depends()	read_barrier_depends()
 #define smp_wmb()	wmb()
 #else
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
+#define smp_read_barrier_depends()	do { } while(0)
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
 #endif
 
