Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277692AbRJIBzX>; Mon, 8 Oct 2001 21:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277686AbRJIBzP>; Mon, 8 Oct 2001 21:55:15 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:40161 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277692AbRJIBzI>; Mon, 8 Oct 2001 21:55:08 -0400
From: "Paul E. McKenney" <pmckenne@us.ibm.com>
Message-Id: <200110090155.f991tPt22329@eng4.beaverton.ibm.com>
Subject: RFC: patch to allow lock-free traversal of lists with insertion
To: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Mon, 8 Oct 2001 18:55:24 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Request for comments...

This is a proposal to provide a wmb()-like primitive that enables
lock-free traversal of lists while elements are concurrently being
inserted into these lists.

This is already possible on many popular architectures, but not on
some CPUs with very weak memory consistency models.  See:

	http://lse.sourceforge.net/locking/wmbdd.html

for more details.

I am particularly interested in comments from people who understand
the detailed operation of the SPARC membar instruction and the PARISC
SYNC instruction.  My belief is that the membar("#SYNC") and SYNC
instructions are sufficient, but the PA-RISC 2.0 Architecture book by
Kane is not completely clear, and I have not yet received my copy of
the SPARC architecture manual.

Thoughts?

						Thanx, Paul

PS.  This patch applies cleanly to 2.4.9 and 2.4.10.  I have tested
     the Alpha algorithm in an emulated environment, but do not have
     access to most of the machines with interesting changes.


diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/arch/alpha/kernel/smp.c linux-v2.4.9.wmbdd/arch/alpha/kernel/smp.c
--- linux-v2.4.9/arch/alpha/kernel/smp.c	Sun Aug 12 10:51:41 2001
+++ linux-v2.4.9.wmbdd/arch/alpha/kernel/smp.c	Fri Sep 21 13:13:52 2001
@@ -55,8 +55,20 @@
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
+	IPI_MB,
 };
 
+/* Global and per-CPU state for global MB shootdown. */
+static struct {
+	spinlock_t mutex;
+	unsigned long need_mb;	/* bitmask of CPUs that need to do "mb". */
+	long curgen;		/* Each "generation" is a group of requests */
+	long maxgen;		/*  that is handled by one set of "mb"s. */
+} mb_global_data __cacheline_aligned = { SPIN_LOCK_UNLOCKED, 0, 1, 0 };
+static struct {
+	unsigned long mygen ____cacheline_aligned;
+} mb_data[NR_CPUS] __cacheline_aligned;
+
 spinlock_t kernel_flag = SPIN_LOCK_UNLOCKED;
 
 /* Set to a secondary's cpuid when it comes online.  */
@@ -764,6 +776,41 @@
 	goto again;
 }
 
+/*
+ * Execute an "mb" instruction in response to an IPI_MB.  Also directly
+ * called by smp_global_mb().  If this is the last CPU to respond to
+ * an smp_global_mb(), then check to see if an additional generation of
+ * requests needs to be satisfied.
+ */
+
+void
+handle_mb_ipi(void)
+{
+	int this_cpu = smp_processor_id();
+	unsigned long this_cpu_mask = 1UL << this_cpu;
+	unsigned long flags;
+	unsigned long to_whom = cpu_present_mask ^ this_cpu_mask;
+
+	/* Avoid lock contention when extra IPIs arrive (due to race) and
+	   when waiting for global mb shootdown. */
+	if ((mb_global_data.need_mb & this_cpu_mask) == 0) {
+		return;
+	}
+	spin_lock_irqsave(&mb_global_data.mutex, flags); /* implied mb */
+	if ((mb_global_data.need_mb & this_cpu_mask) == 0) {
+		spin_unlock_irqrestore(&mb_global_data.mutex, flags);
+		return;
+	}
+	mb_global_data.need_mb &= this_cpu_mask;
+	if (mb_global_data.need_mb == 0) {
+		if (++mb_global_data.curgen - mb_global_data.maxgen <= 0) {
+			mb_global_data.need_mb = to_whom;
+			send_ipi_message(to_whom, IPI_MB);
+		}
+	}
+	spin_unlock_irqrestore(&mb_global_data.mutex, flags); /* implied mb */
+}
+
 void
 handle_ipi(struct pt_regs *regs)
 {
@@ -817,6 +864,9 @@
 		else if (which == IPI_CPU_STOP) {
 			halt();
 		}
+		else if (which == IPI_MB) {
+			handle_mb_ipi();
+		}
 		else {
 			printk(KERN_CRIT "Unknown IPI on CPU %d: %lu\n",
 			       this_cpu, which);
@@ -852,6 +902,58 @@
 		printk(KERN_WARNING "smp_send_stop: Not on boot cpu.\n");
 #endif
 	send_ipi_message(to_whom, IPI_CPU_STOP);
+}
+
+/*
+ * Execute an "mb" instruction, then force all other CPUs to execute "mb"
+ * instructions.  Does not block.  Once this function returns, the caller
+ * is guaranteed that all of its memory writes preceding the call to
+ * smp_global_mb() will be seen by all CPUs as preceding all memory
+ * writes following the call to smp_global_mb().
+ *
+ * For example, if CPU 0 does:
+ *	a.data = 1;
+ *	smp_global_mb();
+ *	p = &a;
+ * and CPU 1 does:
+ *	d = p->data;
+ * where a.data is initially garbage and p initially points to another
+ * structure with the "data" field being zero, then CPU 1 will be
+ * guaranteed to have "d" set to either 0 or 1, never garbage.
+ *
+ * Note that the Alpha "wmb" instruction is -not- sufficient!!!  If CPU 0
+ * were replace the smp_global_mb() with a wmb(), then CPU 1 could end
+ * up with garbage in "d"!
+ *
+ * This function sends IPIs to all other CPUs, then spins waiting for
+ * them to receive the IPI and execute an "mb" instruction.  While
+ * spinning, this function -must- respond to other CPUs executing
+ * smp_global_mb() concurrently, otherwise, deadlock would result.
+ */
+
+void
+smp_global_mb(void)
+{
+	int this_cpu = smp_processor_id();
+	unsigned long this_cpu_mask = 1UL << this_cpu;
+	unsigned long flags;
+	unsigned long to_whom = cpu_present_mask ^ this_cpu_mask;
+
+	spin_lock_irqsave(&mb_global_data.mutex, flags); /* implied mb */
+	if (mb_global_data.curgen - mb_global_data.maxgen <= 0) {
+		mb_global_data.maxgen = mb_global_data.curgen + 1;
+	} else {
+		mb_global_data.maxgen = mb_global_data.curgen;
+		mb_global_data.need_mb = to_whom;
+		send_ipi_message(to_whom, IPI_MB);
+	}
+	mb_data[this_cpu].mygen = mb_global_data.maxgen;
+	spin_unlock_irqrestore(&mb_global_data.mutex, flags);
+	while (mb_data[this_cpu].mygen - mb_global_data.curgen >= 0) {
+		handle_mb_ipi();
+		barrier();
+	}
+	
 }
 
 /*
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-alpha/system.h linux-v2.4.9.wmbdd/include/asm-alpha/system.h
--- linux-v2.4.9/include/asm-alpha/system.h	Sun Aug 12 10:38:47 2001
+++ linux-v2.4.9.wmbdd/include/asm-alpha/system.h	Fri Sep 21 13:14:37 2001
@@ -151,14 +151,21 @@
 #define wmb() \
 __asm__ __volatile__("wmb": : :"memory")
 
+#define mbdd()		smp_mbdd()
+#define wmbdd()		smp_wmbdd()
+
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_mbdd()	smp_global_mb()
+#define smp_wmbdd()	smp_mbdd()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_mbdd()	barrier()
+#define smp_wmbdd()	barrier()
 #endif
 
 #define set_mb(var, value) \
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-arm/system.h linux-v2.4.9.wmbdd/include/asm-arm/system.h
--- linux-v2.4.9/include/asm-arm/system.h	Mon Nov 27 17:07:59 2000
+++ linux-v2.4.9.wmbdd/include/asm-arm/system.h	Wed Sep 19 14:35:07 2001
@@ -39,6 +39,8 @@
 #define mb() __asm__ __volatile__ ("" : : : "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define mbdd() mb()
+#define wmbdd() wmb()
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
 #define prepare_to_switch()    do { } while(0)
@@ -68,12 +70,16 @@
 #define smp_mb()		mb()
 #define smp_rmb()		rmb()
 #define smp_wmb()		wmb()
+#define smp_mbdd()		rmbdd()
+#define smp_wmbdd()		wmbdd()
 
 #else
 
 #define smp_mb()		barrier()
 #define smp_rmb()		barrier()
 #define smp_wmb()		barrier()
+#define smp_mbdd()		barrier()
+#define smp_wmbdd()		barrier()
 
 #define cli()			__cli()
 #define sti()			__sti()
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-cris/system.h linux-v2.4.9.wmbdd/include/asm-cris/system.h
--- linux-v2.4.9/include/asm-cris/system.h	Tue May  1 16:05:00 2001
+++ linux-v2.4.9.wmbdd/include/asm-cris/system.h	Wed Sep 19 14:36:26 2001
@@ -144,15 +144,21 @@
 #define mb() __asm__ __volatile__ ("" : : : "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define mbdd() mb()
+#define wmbdd() wmb()
 
 #ifdef CONFIG_SMP
 #define smp_mb()        mb()
 #define smp_rmb()       rmb()
 #define smp_wmb()       wmb()
+#define smp_mbdd()      mbdd()
+#define smp_wmbdd()     wmbdd()
 #else
 #define smp_mb()        barrier()
 #define smp_rmb()       barrier()
 #define smp_wmb()       barrier()
+#define smp_mbdd()      barrier()
+#define smp_wmbdd()     barrier()
 #endif
 
 #define iret()
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-i386/system.h linux-v2.4.9.wmbdd/include/asm-i386/system.h
--- linux-v2.4.9/include/asm-i386/system.h	Wed Aug 15 14:21:11 2001
+++ linux-v2.4.9.wmbdd/include/asm-i386/system.h	Thu Sep 20 10:09:09 2001
@@ -272,15 +272,21 @@
 #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #define rmb()	mb()
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
+#define mbdd()	mb()
+#define wmbdd()	wmb()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_mbdd()	mbdd()
+#define smp_wmbdd()	wmbdd()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_mbdd()	barrier()
+#define smp_wmbdd()	barrier()
 #endif
 
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-ia64/system.h linux-v2.4.9.wmbdd/include/asm-ia64/system.h
--- linux-v2.4.9/include/asm-ia64/system.h	Tue Jul 31 10:30:09 2001
+++ linux-v2.4.9.wmbdd/include/asm-ia64/system.h	Fri Sep 21 13:17:01 2001
@@ -84,11 +84,36 @@
  *		like regions are visible before any subsequent
  *		stores and that all following stores will be
  *		visible only after all previous stores.
- *   rmb():	Like wmb(), but for reads.
+ *		In common code, any reads that depend on this
+ *		ordering must be separated by an mb() or rmb().
+ *   rmb():	Guarantees that all preceding loads to memory-
+ *		like regions are executed before any subsequent
+ *		loads.
  *   mb():	wmb()/rmb() combo, i.e., all previous memory
  *		accesses are visible before all subsequent
  *		accesses and vice versa.  This is also known as
- *		a "fence."
+ *		a "fence."  Again, in common code, any reads that
+ *		depend on the order of writes must themselves be
+ *		separated by an mb() or rmb().
+ *   wmbdd():	Guarantees that all preceding stores to memory-
+ *		like regions are visible before any subsequent
+ *		stores and that all following stores will be
+ *		visible only after all previous stores.
+ *		In common code, any reads that depend on this
+ *		ordering either must be separated by an mb()
+ *		or rmb(), or the later reads must depend on
+ *		data loaded by the earlier reads.  For an example
+ *		of the latter, consider "p->next".  The read of
+ *		the "next" field depends on the read of the
+ *		pointer "p".
+ *   mbdd():	wmb()/rmb() combo, i.e., all previous memory
+ *		accesses are visible before all subsequent
+ *		accesses and vice versa.  This is also known as
+ *		a "fence."  Again, in common code, any reads that
+ *		depend on the order of writes must themselves be
+ *		separated by an mb() or rmb(), or there must be
+ *		a data dependency that forces the second to
+ *		wait until the first completes.
  *
  * Note: "mb()" and its variants cannot be used as a fence to order
  * accesses to memory mapped I/O registers.  For that, mf.a needs to
@@ -99,15 +124,21 @@
 #define mb()	__asm__ __volatile__ ("mf" ::: "memory")
 #define rmb()	mb()
 #define wmb()	mb()
+#define rmbdd()	mb()
+#define wmbdd()	mb()
 
 #ifdef CONFIG_SMP
 # define smp_mb()	mb()
 # define smp_rmb()	rmb()
 # define smp_wmb()	wmb()
+# define smp_mbdd()	mbdd()
+# define smp_wmbdd()	wmbdd()
 #else
 # define smp_mb()	barrier()
 # define smp_rmb()	barrier()
 # define smp_wmb()	barrier()
+# define smp_mbdd()	barrier()
+# define smp_wmbdd()	barrier()
 #endif
 
 /*
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-m68k/system.h linux-v2.4.9.wmbdd/include/asm-m68k/system.h
--- linux-v2.4.9/include/asm-m68k/system.h	Mon Jun 11 19:15:27 2001
+++ linux-v2.4.9.wmbdd/include/asm-m68k/system.h	Wed Sep 19 14:39:18 2001
@@ -81,12 +81,16 @@
 #define mb()		barrier()
 #define rmb()		barrier()
 #define wmb()		barrier()
+#define rmbdd()		barrier()
+#define wmbdd()		barrier()
 #define set_mb(var, value)    do { xchg(&var, value); } while (0)
 #define set_wmb(var, value)    do { var = value; wmb(); } while (0)
 
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_mbdd()	barrier()
+#define smp_wmbdd()	barrier()
 
 
 #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-mips/system.h linux-v2.4.9.wmbdd/include/asm-mips/system.h
--- linux-v2.4.9/include/asm-mips/system.h	Mon Jul  2 13:56:40 2001
+++ linux-v2.4.9.wmbdd/include/asm-mips/system.h	Wed Sep 19 14:41:26 2001
@@ -152,6 +152,8 @@
 #define rmb()	do { } while(0)
 #define wmb()	wbflush()
 #define mb()	wbflush()
+#define wmbdd()	wbflush()
+#define mbdd()	wbflush()
 
 #else /* CONFIG_CPU_HAS_WB  */
 
@@ -167,6 +169,8 @@
 	: "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define wmbdd()	mb()
+#define mbdd()	mb()
 
 #endif /* CONFIG_CPU_HAS_WB  */
 
@@ -174,10 +178,14 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_mbdd()	mbdd()
+#define smp_wmbdd()	wmbdd()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_mbdd()	barrier()
+#define smp_wmbdd()	barrier()
 #endif
 
 #define set_mb(var, value) \
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-mips64/system.h linux-v2.4.9.wmbdd/include/asm-mips64/system.h
--- linux-v2.4.9/include/asm-mips64/system.h	Wed Jul  4 11:50:39 2001
+++ linux-v2.4.9.wmbdd/include/asm-mips64/system.h	Wed Sep 19 14:42:41 2001
@@ -148,15 +148,21 @@
 	: "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define rmbdd() mb()
+#define wmbdd() mb()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_mbdd()	mbdd()
+#define smp_wmbdd()	wmbdd()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_mbdd()	barrier()
+#define smp_wmbdd()	barrier()
 #endif
 
 #define set_mb(var, value) \
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-parisc/system.h linux-v2.4.9.wmbdd/include/asm-parisc/system.h
--- linux-v2.4.9/include/asm-parisc/system.h	Wed Dec  6 11:46:39 2000
+++ linux-v2.4.9.wmbdd/include/asm-parisc/system.h	Wed Sep 19 14:06:31 2001
@@ -51,6 +51,8 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_mbdd()	rmb()
+#define smp_wmbdd()	wmb()
 #else
 /* This is simply the barrier() macro from linux/kernel.h but when serial.c
  * uses tqueue.h uses smp_mb() defined using barrier(), linux/kernel.h
@@ -59,6 +61,8 @@
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_mbdd()	__asm__ __volatile__("":::"memory");
+#define smp_wmbdd()	__asm__ __volatile__("":::"memory");
 #endif
 
 /* interrupt control */
@@ -122,6 +126,8 @@
 
 #define mb()  __asm__ __volatile__ ("sync" : : :"memory")
 #define wmb() mb()
+#define mbdd() mb()
+#define wmbdd() mb()
 
 extern unsigned long __xchg(unsigned long, unsigned long *, int);
 
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-ppc/system.h linux-v2.4.9.wmbdd/include/asm-ppc/system.h
--- linux-v2.4.9/include/asm-ppc/system.h	Mon May 21 15:02:06 2001
+++ linux-v2.4.9.wmbdd/include/asm-ppc/system.h	Wed Sep 19 14:07:51 2001
@@ -33,6 +33,8 @@
 #define mb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("eieio" : : : "memory")
+#define mbdd()	mb()
+#define wmbdd()	wmb()
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
 #define set_wmb(var, value)	do { var = value; wmb(); } while (0)
@@ -41,10 +43,14 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_mbdd()	mb()
+#define smp_wmbdd()	wmb()
 #else
 #define smp_mb()	__asm__ __volatile__("": : :"memory")
 #define smp_rmb()	__asm__ __volatile__("": : :"memory")
 #define smp_wmb()	__asm__ __volatile__("": : :"memory")
+#define smp_mbdd()	__asm__ __volatile__("": : :"memory")
+#define smp_wmbdd()	__asm__ __volatile__("": : :"memory")
 #endif /* CONFIG_SMP */
 
 #ifdef __KERNEL__
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-s390/system.h linux-v2.4.9.wmbdd/include/asm-s390/system.h
--- linux-v2.4.9/include/asm-s390/system.h	Wed Jul 25 14:12:02 2001
+++ linux-v2.4.9.wmbdd/include/asm-s390/system.h	Wed Sep 19 14:09:47 2001
@@ -118,9 +118,13 @@
 #define mb()    eieio()
 #define rmb()   eieio()
 #define wmb()   eieio()
+#define mbdd()	mb()
+#define wmbdd()	wmb()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
 #define smp_wmb()      wmb()
+#define smp_mbdd()     mb()
+#define smp_wmbdd()    wmb()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
 
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-s390x/system.h linux-v2.4.9.wmbdd/include/asm-s390x/system.h
--- linux-v2.4.9/include/asm-s390x/system.h	Wed Jul 25 14:12:03 2001
+++ linux-v2.4.9.wmbdd/include/asm-s390x/system.h	Wed Sep 19 14:10:11 2001
@@ -131,9 +131,13 @@
 #define mb()    eieio()
 #define rmb()   eieio()
 #define wmb()   eieio()
+#define mbdd()	mb()
+#define wmbdd()	wmb()
 #define smp_mb()       mb()
 #define smp_rmb()      rmb()
 #define smp_wmb()      wmb()
+#define smp_mbdd()     mb()
+#define smp_wmbdd()    wmb()
 #define smp_mb__before_clear_bit()     smp_mb()
 #define smp_mb__after_clear_bit()      smp_mb()
 
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-sh/system.h linux-v2.4.9.wmbdd/include/asm-sh/system.h
--- linux-v2.4.9/include/asm-sh/system.h	Sun Jan 28 18:56:00 2001
+++ linux-v2.4.9.wmbdd/include/asm-sh/system.h	Wed Sep 19 14:11:44 2001
@@ -89,15 +89,21 @@
 #define mb()	__asm__ __volatile__ ("": : :"memory")
 #define rmb()	mb()
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
+#define mbdd()	mb()
+#define wmbdd()	wmb()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_mbdd()	mb()
+#define smp_wmbdd()	wmb()
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define smp_mbdd()	barrier()
+#define smp_wmbdd()	barrier()
 #endif
 
 #define set_mb(var, value) do { xchg(&var, value); } while (0)
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-sparc/system.h linux-v2.4.9.wmbdd/include/asm-sparc/system.h
--- linux-v2.4.9/include/asm-sparc/system.h	Tue Oct  3 09:24:41 2000
+++ linux-v2.4.9.wmbdd/include/asm-sparc/system.h	Wed Sep 19 14:26:40 2001
@@ -278,11 +278,15 @@
 #define mb()	__asm__ __volatile__ ("" : : : "memory")
 #define rmb()	mb()
 #define wmb()	mb()
+#define mbdd()	mb()
+#define wmbdd()	wmb()
 #define set_mb(__var, __value)  do { __var = __value; mb(); } while(0)
 #define set_wmb(__var, __value) set_mb(__var, __value)
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_mbdd()	__asm__ __volatile__("":::"memory");
+#define smp_wmbdd()	__asm__ __volatile__("":::"memory");
 
 #define nop() __asm__ __volatile__ ("nop");
 
diff -urN -X /home/mckenney/dontdiff linux-v2.4.9/include/asm-sparc64/system.h linux-v2.4.9.wmbdd/include/asm-sparc64/system.h
--- linux-v2.4.9/include/asm-sparc64/system.h	Thu Apr 26 22:17:26 2001
+++ linux-v2.4.9.wmbdd/include/asm-sparc64/system.h	Wed Sep 19 14:34:10 2001
@@ -102,6 +102,8 @@
 	membar("#LoadLoad | #LoadStore | #StoreStore | #StoreLoad");
 #define rmb()		membar("#LoadLoad")
 #define wmb()		membar("#StoreStore")
+#define mbdd()		membar("#Sync")
+#define wmbdd()		membar("#Sync")
 #define set_mb(__var, __value) \
 	do { __var = __value; membar("#StoreLoad | #StoreStore"); } while(0)
 #define set_wmb(__var, __value) \
@@ -111,10 +113,14 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define smp_mbdd()	mbdd()
+#define smp_wmbdd()	wmbdd()
 #else
 #define smp_mb()	__asm__ __volatile__("":::"memory");
 #define smp_rmb()	__asm__ __volatile__("":::"memory");
 #define smp_wmb()	__asm__ __volatile__("":::"memory");
+#define smp_mbdd()	__asm__ __volatile__("":::"memory");
+#define smp_wmbdd()	__asm__ __volatile__("":::"memory");
 #endif
 
 #define flushi(addr)	__asm__ __volatile__ ("flush %0" : : "r" (addr) : "memory")
