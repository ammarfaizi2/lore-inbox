Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316079AbSE3Bf5>; Wed, 29 May 2002 21:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316156AbSE3Bf4>; Wed, 29 May 2002 21:35:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10234 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316079AbSE3Bfa>; Wed, 29 May 2002 21:35:30 -0400
Subject: [PATCH] 2.4: preempt-kernel for PPC
From: Robert Love <rml@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-FBA/0PZTqKrEw5d6JLTQ"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 18:35:29 -0700
Message-Id: <1022722530.1145.325.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FBA/0PZTqKrEw5d6JLTQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached patch provides preemptive kernel support for the PPC
architecture.  This patch is against kernel 2.4.19-pre9 and is meant to
be applied on top of the standard preempt-kernel patch available from:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel

If all goes well I will integrate this into the next release of the
preempt-kernel patch.

Much thanks to MontaVista for providing this work to the community.

Enjoy,

	Robert Love


--=-FBA/0PZTqKrEw5d6JLTQ
Content-Disposition: attachment; filename=preempt-kernel-ppc-rml-2.4.19-pre9-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=preempt-kernel-ppc-rml-2.4.19-pre9-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre9-preempt/arch/ppc/config.in linux/arch/ppc/confi=
g.in
--- linux-2.4.19-pre9-preempt/arch/ppc/config.in	Wed May 29 18:31:26 2002
+++ linux/arch/ppc/config.in	Wed May 29 18:32:00 2002
@@ -109,6 +109,8 @@
   bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPU=
S
 fi
=20
+bool 'Preemptible kernel support' CONFIG_PREEMPT
+
 if [ "$CONFIG_6xx" =3D "y" -a "$CONFIG_8260" =3D "n" ];then
   bool 'AltiVec Support' CONFIG_ALTIVEC
   bool 'Thermal Management Support' CONFIG_TAU
diff -urN linux-2.4.19-pre9-preempt/arch/ppc/kernel/entry.S linux/arch/ppc/=
kernel/entry.S
--- linux-2.4.19-pre9-preempt/arch/ppc/kernel/entry.S	Wed May 29 18:31:24 2=
002
+++ linux/arch/ppc/kernel/entry.S	Wed May 29 18:32:00 2002
@@ -277,6 +277,41 @@
 	 */
 	cmpi	0,r3,0
 	beq	restore
+#ifdef CONFIG_PREEMPT
+	lwz	r3,PREEMPT_COUNT(r2)
+	cmpi	0,r3,1
+	bge	ret_from_except
+	lwz	r5,_MSR(r1)
+	andi.	r5,r5,MSR_PR
+	bne	do_signal_ret
+	lwz	r5,NEED_RESCHED(r2)
+	cmpi	0,r5,0
+	beq	ret_from_except
+	lis	r3,irq_stat@h
+	ori	r3,r3,irq_stat@l
+	lwz	r5,4(r3)
+	lwz	r3,8(r3)
+	add	r3,r3,r5
+	cmpi	0,r3,0
+	bne	ret_from_except
+	lwz	r3,PREEMPT_COUNT(r2)
+	addi	r3,r3,1
+	stw	r3,PREEMPT_COUNT(r2)
+	mfmsr	r0
+	ori	r0,r0,MSR_EE
+	mtmsr	r0
+	sync
+	bl	preempt_schedule
+	mfmsr	r0
+	rlwinm	r0,r0,0,17,15
+	mtmsr	r0
+	sync
+	lwz	r3,PREEMPT_COUNT(r2)
+	subi	r3,r3,1
+	stw	r3,PREEMPT_COUNT(r2)
+	li	r3,1
+	b	ret_from_intercept
+#endif /* CONFIG_PREEMPT */
 	.globl	ret_from_except
 ret_from_except:
 	lwz	r3,_MSR(r1)	/* Returning to user mode? */
diff -urN linux-2.4.19-pre9-preempt/arch/ppc/kernel/irq.c linux/arch/ppc/ke=
rnel/irq.c
--- linux-2.4.19-pre9-preempt/arch/ppc/kernel/irq.c	Wed May 29 18:31:24 200=
2
+++ linux/arch/ppc/kernel/irq.c	Wed May 29 18:32:00 2002
@@ -568,6 +568,34 @@
 	return 1; /* lets ret_from_int know we can do checks */
 }
=20
+#ifdef CONFIG_PREEMPT
+int
+preempt_intercept(struct pt_regs *regs)
+{
+	int ret;
+
+	preempt_disable();
+
+	switch(regs->trap) {
+	case 0x500:
+		ret =3D do_IRQ(regs);
+		break;
+#ifndef CONFIG_4xx
+	case 0x900:
+#else
+	case 0x1000:
+#endif
+		ret =3D timer_interrupt(regs);
+		break;
+	default:
+		BUG();
+	}
+
+	preempt_enable();
+	return ret;
+}
+#endif /* CONFIG_PREEMPT */
+
 unsigned long probe_irq_on (void)
 {
 	return 0;
diff -urN linux-2.4.19-pre9-preempt/arch/ppc/kernel/mk_defs.c linux/arch/pp=
c/kernel/mk_defs.c
--- linux-2.4.19-pre9-preempt/arch/ppc/kernel/mk_defs.c	Wed May 29 18:31:24=
 2002
+++ linux/arch/ppc/kernel/mk_defs.c	Wed May 29 18:32:00 2002
@@ -42,6 +42,9 @@
 	DEFINE(SIGPENDING, offsetof(struct task_struct, sigpending));
 	DEFINE(THREAD, offsetof(struct task_struct, thread));
 	DEFINE(MM, offsetof(struct task_struct, mm));
+#ifdef CONFIG_PREEMPT
+	DEFINE(PREEMPT_COUNT, offsetof(struct task_struct, preempt_count));
+#endif
 	DEFINE(ACTIVE_MM, offsetof(struct task_struct, active_mm));
 	DEFINE(TASK_STRUCT_SIZE, sizeof(struct task_struct));
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
diff -urN linux-2.4.19-pre9-preempt/arch/ppc/kernel/setup.c linux/arch/ppc/=
kernel/setup.c
--- linux-2.4.19-pre9-preempt/arch/ppc/kernel/setup.c	Wed May 29 18:31:24 2=
002
+++ linux/arch/ppc/kernel/setup.c	Wed May 29 18:32:00 2002
@@ -504,6 +504,20 @@
=20
 	parse_bootinfo();
=20
+#ifdef CONFIG_PREEMPT
+	/* Override the irq routines for external & timer interrupts here,
+	 * as the MMU has only been minimally setup at this point and
+	 * there are no protections on page zero.
+	 */
+	{
+		extern int preempt_intercept(struct pt_regs *);
+=09
+		do_IRQ_intercept =3D (unsigned long) &preempt_intercept;
+		timer_interrupt_intercept =3D (unsigned long) &preempt_intercept;
+
+	}
+#endif /* CONFIG_PREEMPT */
+
 	platform_init(r3, r4, r5, r6, r7);
=20
 	if (ppc_md.progress)
diff -urN linux-2.4.19-pre9-preempt/arch/ppc/lib/dec_and_lock.c linux/arch/=
ppc/lib/dec_and_lock.c
--- linux-2.4.19-pre9-preempt/arch/ppc/lib/dec_and_lock.c	Wed May 29 18:31:=
26 2002
+++ linux/arch/ppc/lib/dec_and_lock.c	Wed May 29 18:32:00 2002
@@ -1,4 +1,5 @@
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 #include <asm/system.h>
diff -urN linux-2.4.19-pre9-preempt/include/asm-ppc/dma.h linux/include/asm=
-ppc/dma.h
--- linux-2.4.19-pre9-preempt/include/asm-ppc/dma.h	Wed May 29 18:30:31 200=
2
+++ linux/include/asm-ppc/dma.h	Wed May 29 18:32:00 2002
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <asm/io.h>
 #include <linux/spinlock.h>
+#include <linux/sched.h>
 #include <asm/system.h>
=20
 /*
diff -urN linux-2.4.19-pre9-preempt/include/asm-ppc/hardirq.h linux/include=
/asm-ppc/hardirq.h
--- linux-2.4.19-pre9-preempt/include/asm-ppc/hardirq.h	Wed May 29 18:30:31=
 2002
+++ linux/include/asm-ppc/hardirq.h	Wed May 29 18:32:00 2002
@@ -44,6 +44,7 @@
 #define hardirq_exit(cpu)	(local_irq_count(cpu)--)
=20
 #define synchronize_irq()	do { } while (0)
+#define release_irqlock(cpu)	do { } while (0)
=20
 #else /* CONFIG_SMP */
=20
diff -urN linux-2.4.19-pre9-preempt/include/asm-ppc/highmem.h linux/include=
/asm-ppc/highmem.h
--- linux-2.4.19-pre9-preempt/include/asm-ppc/highmem.h	Wed May 29 18:30:31=
 2002
+++ linux/include/asm-ppc/highmem.h	Wed May 29 18:32:00 2002
@@ -84,6 +84,7 @@
 	unsigned int idx;
 	unsigned long vaddr;
=20
+	preempt_disable();
 	if (page < highmem_start_page)
 		return page_address(page);
=20
@@ -105,8 +106,10 @@
 	unsigned long vaddr =3D (unsigned long) kvaddr;
 	unsigned int idx =3D type + KM_TYPE_NR*smp_processor_id();
=20
-	if (vaddr < KMAP_FIX_BEGIN) // FIXME
+	if (vaddr < KMAP_FIX_BEGIN) { // FIXME
+		preempt_enable();
 		return;
+	}
=20
 	if (vaddr !=3D KMAP_FIX_BEGIN + idx * PAGE_SIZE)
 		BUG();
@@ -118,6 +121,7 @@
 	pte_clear(kmap_pte+idx);
 	flush_tlb_page(0, vaddr);
 #endif
+	preempt_enable();
 }
=20
 #endif /* __KERNEL__ */
diff -urN linux-2.4.19-pre9-preempt/include/asm-ppc/mmu_context.h linux/inc=
lude/asm-ppc/mmu_context.h
--- linux-2.4.19-pre9-preempt/include/asm-ppc/mmu_context.h	Wed May 29 18:3=
0:31 2002
+++ linux/include/asm-ppc/mmu_context.h	Wed May 29 18:32:00 2002
@@ -158,6 +158,10 @@
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *nex=
t,
 			     struct task_struct *tsk, int cpu)
 {
+#ifdef CONFIG_PREEMPT
+	if (preempt_get_count() =3D=3D 0)
+		BUG();
+#endif
 	tsk->thread.pgdir =3D next->pgd;
 	get_mmu_context(next);
 	set_context(next->context, next->pgd);
diff -urN linux-2.4.19-pre9-preempt/include/asm-ppc/pgalloc.h linux/include=
/asm-ppc/pgalloc.h
--- linux-2.4.19-pre9-preempt/include/asm-ppc/pgalloc.h	Wed May 29 18:30:31=
 2002
+++ linux/include/asm-ppc/pgalloc.h	Wed May 29 18:32:00 2002
@@ -68,20 +68,25 @@
 {
         unsigned long *ret;
=20
+	preempt_disable();
         if ((ret =3D pgd_quicklist) !=3D NULL) {
                 pgd_quicklist =3D (unsigned long *)(*ret);
                 ret[0] =3D 0;
                 pgtable_cache_size--;
+		preempt_enable();
         } else
+		preempt_enable();
                 ret =3D (unsigned long *)get_pgd_slow();
         return (pgd_t *)ret;
 }
=20
 extern __inline__ void free_pgd_fast(pgd_t *pgd)
 {
+	preempt_disable();
         *(unsigned long **)pgd =3D pgd_quicklist;
         pgd_quicklist =3D (unsigned long *) pgd;
         pgtable_cache_size++;
+	preempt_enable();
 }
=20
 extern __inline__ void free_pgd_slow(pgd_t *pgd)
@@ -120,19 +125,23 @@
 {
         unsigned long *ret;
=20
+	preempt_disable();
         if ((ret =3D pte_quicklist) !=3D NULL) {
                 pte_quicklist =3D (unsigned long *)(*ret);
                 ret[0] =3D 0;
                 pgtable_cache_size--;
 	}
+	preempt_enable();
         return (pte_t *)ret;
 }
=20
 extern __inline__ void pte_free_fast(pte_t *pte)
 {
+	preempt_disable();
         *(unsigned long **)pte =3D pte_quicklist;
         pte_quicklist =3D (unsigned long *) pte;
         pgtable_cache_size++;
+	preempt_enable();
 }
=20
 extern __inline__ void pte_free_slow(pte_t *pte)
diff -urN linux-2.4.19-pre9-preempt/include/asm-ppc/smplock.h linux/include=
/asm-ppc/smplock.h
--- linux-2.4.19-pre9-preempt/include/asm-ppc/smplock.h	Wed May 29 18:30:31=
 2002
+++ linux/include/asm-ppc/smplock.h	Wed May 29 18:32:00 2002
@@ -15,7 +15,15 @@
=20
 extern spinlock_t kernel_flag;
=20
+#ifdef CONFIG_SMP
 #define kernel_locked()		spin_is_locked(&kernel_flag)
+#else
+#ifdef CONFIG_PREEMPT
+#define kernel_locked()		preempt_get_count()
+#else
+#define kernel_locked()		1
+#endif
+#endif
=20
 /*
  * Release global kernel lock and global interrupt lock
@@ -47,8 +55,14 @@
  */
 static __inline__ void lock_kernel(void)
 {
+#ifdef CONFIG_PREEMPT
+	if (current->lock_depth =3D=3D -1)
+		spin_lock(&kernel_flag);
+	++current->lock_depth;
+#else
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
+#endif
 }
=20
 static __inline__ void unlock_kernel(void)
diff -urN linux-2.4.19-pre9-preempt/include/asm-ppc/softirq.h linux/include=
/asm-ppc/softirq.h
--- linux-2.4.19-pre9-preempt/include/asm-ppc/softirq.h	Wed May 29 18:30:31=
 2002
+++ linux/include/asm-ppc/softirq.h	Wed May 29 18:32:00 2002
@@ -10,6 +10,7 @@
=20
 #define local_bh_disable()			\
 do {						\
+	preempt_disable();			\
 	local_bh_count(smp_processor_id())++;	\
 	barrier();				\
 } while (0)
@@ -18,9 +19,10 @@
 do {						\
 	barrier();				\
 	local_bh_count(smp_processor_id())--;	\
+	preempt_enable();			\
 } while (0)
=20
-#define local_bh_enable()				\
+#define _local_bh_enable()				\
 do {							\
 	if (!--local_bh_count(smp_processor_id())	\
 	    && softirq_pending(smp_processor_id())) {	\
@@ -28,6 +30,12 @@
 	}						\
 } while (0)
=20
+#define local_bh_enable()			\
+do {						\
+	_local_bh_enable();			\
+	preempt_enable();			\
+} while (0)
+
 #define in_softirq() (local_bh_count(smp_processor_id()) !=3D 0)
=20
 #endif	/* __ASM_SOFTIRQ_H */

--=-FBA/0PZTqKrEw5d6JLTQ--

