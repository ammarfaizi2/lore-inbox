Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319037AbSH1W7h>; Wed, 28 Aug 2002 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319038AbSH1W7h>; Wed, 28 Aug 2002 18:59:37 -0400
Received: from ppp-217-133-216-255.dialup.tiscali.it ([217.133.216.255]:32185
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S319037AbSH1W7d>; Wed, 28 Aug 2002 18:59:33 -0400
Subject: [PATCH 2 / ...] i386 dynamic fixup SMP workaround
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Mikael Pettersson <mikpe@csd.uu.se>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-zSHMM+wg/mHILUr1hcMR"
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2002 01:03:52 +0200
Message-Id: <1030575832.1463.39.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zSHMM+wg/mHILUr1hcMR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This code implements the send-IPIs-to-lock-everyone-else workaround that
allows the code to run on Intel P6 processors.
Currently the code is enabled on all SMP systems since reliably
determining whether a given processor is broken or not is hard.
This may be changed in future.
Note that due to lack of suitable hardware, the SMP part has not been
tested.

I'd like to now whether this whole idea of self modifying code has some
hope of being accepted or not.

If no serious problems are raised and no notices of unacceptability are
made, I'll proceed to send the CPU selection patch and, after that, the
final patch that implements both things all over the tree.

BTW the CPU selection patch changes the interface so that each CPU has
its own y/n switch and the kernel automagically chooses the best options
for the set of selected CPUs. This is a wholly different issue that will
be explained in depth in the message including the patch.


diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup/arch/i386/kernel/entry.S linux-2.5.32_fixup_smp/arch/i386/kernel/entry.S
--- linux-2.5.32_fixup/arch/i386/kernel/entry.S	2002-08-29 00:02:10.000000000 +0200
+++ linux-2.5.32_fixup_smp/arch/i386/kernel/entry.S	2002-08-28 19:49:04.000000000 +0200
@@ -353,6 +353,7 @@ ENTRY(name)				\
 BUILD_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
 BUILD_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
 BUILD_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
+BUILD_INTERRUPT(dynamic_fixup_smp_lock_interrupt, DYNAMIC_FIXUP_SMP_LOCK_VECTOR)
 #endif
 
 /*
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup/arch/i386/kernel/fixup.c linux-2.5.32_fixup_smp/arch/i386/kernel/fixup.c
--- linux-2.5.32_fixup/arch/i386/kernel/fixup.c	2002-08-29 00:02:10.000000000 +0200
+++ linux-2.5.32_fixup_smp/arch/i386/kernel/fixup.c	2002-08-29 00:01:15.000000000 +0200
@@ -4,11 +4,15 @@
 #include <linux/kernel.h>
 #include <linux/sysrq.h>
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/atomic.h>
 #include <asm/bitops.h>
 #include <asm/fixup.h>
 #include <asm/system.h>
+#include <asm/apic.h>
+#include <asm/irq_vectors.h>
+#include <asm/smpboot.h>
 
 /* If we are running on SMP any other processor might be executing the
    code that we are modifying. We must make sure that the other
@@ -30,10 +34,13 @@
    such processors IPIs must be sent to all other processors to block
    them before the fixup is performed. dynamic_fixup_smp_(un)lock are
    reserved for this purpose.
-*/
 
-#define dynamic_fixup_smp_lock() do {} while(0)
-#define dynamic_fixup_smp_unlock() do {} while(0)
+   Update: this is now implemented and always enabled on SMP since
+   determining whether a given processor is not broken is hard and
+   error-prone (this decision might be revisited in future if someone
+   provides documentation and actual testing results for working CPUs
+   or if the maintainers are willing to take the risk anyway).
+*/
 
 #define non_atomic  0, 0,
 #define decl_atomic int atomic, u32 atomicv,
@@ -49,10 +56,134 @@
 u8 lock_fixup = 0;
 #define perform_fixup lock_fixup
 
+#ifdef CONFIG_SMP
+static spinlock_t smp_lock = SPIN_LOCK_UNLOCKED;
+static volatile unsigned long /* cpu_mask_t */ smp_lock_spinning_cpus = 0;
+
+static inline void dynamic_fixup_spin_lock(spinlock_t *lock)
+{
+	__asm__ __volatile__(
+		"\n1:\t" \
+		"lock; decb %0\n\t" \
+		"js 2f\n" \
+		LOCK_SECTION_START("") \
+		"2:\t" \
+		"cmpb $0,%0\n\t" \
+		"rep;nop\n\t" \
+		"jle 2b\n\t" \
+		"jmp 1b\n" \
+		LOCK_SECTION_END
+		:"=m" (lock->lock) : : "memory");
+}
+
+static inline void dynamic_fixup_spin_unlock(spinlock_t *lock)
+{
+	char oldval = 1;
+	__asm__ __volatile__(
+		"xchgb %b0, %1" \
+		:"=q" (oldval), "=m" (lock->lock) \
+		:"0" (oldval) : "memory"
+	);
+}
+
+static inline void dynamic_fixup_smp_mask_lock(void)
+{
+	asm("lock; orl %1, %0" : "=m" (smp_lock_spinning_cpus) : "r" (1 << smp_processor_id()));
+	dynamic_fixup_spin_lock(&smp_lock);
+}
+
+static inline void dynamic_fixup_smp_mask_unlock(void)
+{
+	asm("lock; andl %1, %0" : "=m" (smp_lock_spinning_cpus) : "r" (~(1 << smp_processor_id())));
+	dynamic_fixup_spin_unlock(&smp_lock);
+}
+
+asmlinkage void smp_dynamic_fixup_smp_lock_interrupt(void)
+{
+	/* We must avoid invoking dynamic fixup routines here */
+	apic_write_atomic(APIC_EOI, 0);
+
+	dynamic_fixup_smp_mask_lock();
+	dynamic_fixup_smp_mask_unlock();
+}
+
+/* Need to duplicate all this to avoid recursing in dynamic_fixup */
+static inline int __prepare_ICR (unsigned int shortcut, int vector)
+{
+	return APIC_DM_FIXED | shortcut | vector | APIC_DEST_LOGICAL;
+}
+
+static inline int __prepare_ICR2 (unsigned int mask)
+{
+	return SET_APIC_DEST_FIELD(mask);
+}
+
+static inline void dynamic_fixup_send_IPIs(int vector)
+{
+	unsigned int cfg;
+	if (clustered_apic_mode) {
+		int cpu;
+
+		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+			if (cpu_online(cpu) && !(cpu & smp_lock_spinning_cpus) && cpu != smp_processor_id())
+			{
+				apic_wait_icr_idle();
+		
+				/* prepare target chip field */
+				cfg = __prepare_ICR2(cpu_to_logical_apicid(cpu));
+				apic_write_atomic(APIC_ICR2, cfg);
+		
+				cfg = __prepare_ICR(0, vector);
+				apic_write_atomic(APIC_ICR, cfg);
+			}
+		}
+	} else {
+		apic_wait_icr_idle();
+
+		/* prepare target chip field */
+		cfg = __prepare_ICR2((~smp_lock_spinning_cpus &~ (1 << smp_processor_id())));
+		apic_write_atomic(APIC_ICR2, cfg);
+		
+		cfg = __prepare_ICR(0, vector);
+			
+		apic_write_atomic(APIC_ICR, cfg);
+	}
+}
+
+static void __dynamic_fixup_smp_lock(void)
+{
+	local_irq_disable();
+	dynamic_fixup_smp_mask_lock();
+
+	dynamic_fixup_send_IPIs(DYNAMIC_FIXUP_SMP_LOCK_VECTOR);
+	while (smp_lock_spinning_cpus != cpu_online_map) {}
+}
+
+static inline void dynamic_fixup_smp_lock(void)
+{
+	/* check if we are fixing up and we are smp */	
+	if(lock_fixup == 0xf0)
+		__dynamic_fixup_smp_lock();
+}
+
+static inline void dynamic_fixup_smp_unlock(void)
+{
+	/* check if we are fixing up and we are smp */
+	if(lock_fixup == 0xf0)
+	{
+		dynamic_fixup_smp_mask_unlock();
+		/* keep interrupts disabled, we are just about to iret */
+	}
+}
+#else
+#define dynamic_fixup_smp_lock() do {} while(0)
+#define dynamic_fixup_smp_unlock() do {} while(0)
+#endif
+
 void flush_tlb(void);
 unsigned long long emulate_rdtsc(void);
 
-/* Only aligned 32-bit accesses are guaranteed to be atomic */
+/* Only aligned 32-bit accesses are guaranteed to be atomic. */
 static inline u32
 atomic_read_unaligned32(u32 * p)
 {
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup/arch/i386/kernel/i8259.c linux-2.5.32_fixup_smp/arch/i386/kernel/i8259.c
--- linux-2.5.32_fixup/arch/i386/kernel/i8259.c	2002-08-29 00:02:10.000000000 +0200
+++ linux-2.5.32_fixup_smp/arch/i386/kernel/i8259.c	2002-08-28 19:50:22.000000000 +0200
@@ -407,6 +407,9 @@ void __init init_IRQ(void)
 
 	/* IPI for generic function call */
 	set_intr_gate(CALL_FUNCTION_VECTOR, call_function_interrupt);
+
+	/* IPI for smp lock by dynamic fixup code */
+	set_intr_gate(DYNAMIC_FIXUP_SMP_LOCK_VECTOR, dynamic_fixup_smp_lock_interrupt);
 #endif	
 
 #ifdef CONFIG_X86_LOCAL_APIC
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup/include/asm-i386/hw_irq.h linux-2.5.32_fixup_smp/include/asm-i386/hw_irq.h
--- linux-2.5.32_fixup/include/asm-i386/hw_irq.h	2002-08-27 21:27:33.000000000 +0200
+++ linux-2.5.32_fixup_smp/include/asm-i386/hw_irq.h	2002-08-29 00:01:15.000000000 +0200
@@ -32,6 +32,7 @@ extern void (*interrupt[NR_IRQS])(void);
 extern asmlinkage void reschedule_interrupt(void);
 extern asmlinkage void invalidate_interrupt(void);
 extern asmlinkage void call_function_interrupt(void);
+extern asmlinkage void dynamic_fixup_smp_lock_interrupt(void);
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32_fixup/include/asm-i386/irq_vectors.h linux-2.5.32_fixup_smp/include/asm-i386/irq_vectors.h
--- linux-2.5.32_fixup/include/asm-i386/irq_vectors.h	2002-08-29 00:02:10.000000000 +0200
+++ linux-2.5.32_fixup_smp/include/asm-i386/irq_vectors.h	2002-08-29 00:01:15.000000000 +0200
@@ -27,8 +27,9 @@
 #define INVALIDATE_TLB_VECTOR	0xfd
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
+#define DYNAMIC_FIXUP_SMP_LOCK_VECTOR	0xfa
 
-#define DYNAMIC_FIXUP_VECTOR	0xfa
+#define DYNAMIC_FIXUP_VECTOR	0xf1
 
 #define THERMAL_APIC_VECTOR	0xf0
 /*

--=-zSHMM+wg/mHILUr1hcMR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bVbXdjkty3ft5+cRAr6NAJ0Z9aizHdYTbj5KxCyYhtnsgzFRGACglAit
TmErkxI2QsWi9s+7XITnyu4=
=PEjF
-----END PGP SIGNATURE-----

--=-zSHMM+wg/mHILUr1hcMR--
