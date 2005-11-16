Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030392AbVKPQNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbVKPQNJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbVKPQNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:13:08 -0500
Received: from ns1.suse.de ([195.135.220.2]:58589 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030392AbVKPQNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:13:07 -0500
Message-ID: <437B5A83.8090808@suse.de>
Date: Wed, 16 Nov 2005 17:12:51 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: [RFC] SMP alternatives
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com> <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de>
In-Reply-To: <437A0649.7010702@suse.de>
Content-Type: multipart/mixed;
 boundary="------------090000090007010405070204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090000090007010405070204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gerd Knorr wrote:

> i.e. something like this (as basic idea, patch is far away from doing 
> anything useful ...)?

Adapting $subject to the actual topic, so other lkml readers can catch up ;)

Ok, here new version of the SMP alternatives patch.  It features:

  * it actually compiles and boots, so you can start playing with it ;)
  * reuses the alternatives bits we have already as far as possible.
  * separate table for the SMP alternatives, so we can keep them and
    switch at runtime between SMP and UP (for virtual CPU hotplug).
  * two new alternatives macros, one generic which can handle quite
    comples stuff such as spinlocks, one for the "lock prefix" case.

TODO list:

  * convert more code (bitops, ...).
  * module support (using modules is fine, they run the safe SMP
    version of the code, they just don't benefit from the optimizations
    yet).
  * integrate with xen bits and CPU hotplug, at the moment it's a
    boot-time only thing.
  * benchmark it.
  * x86_64 version.
  * drop the printk's placed into the code for debugging.
  * probably more ...

How it works right now:

  * The patch switches to UP unconditionally when doing the usual
    alternatives stuff at boot time
  * Just before booting the second CPU it switches to SMP.

How to test:

  * boot with "maxcpus=1" to run the UP code.

Comments are welcome.

cheers,

   Gerd

--------------090000090007010405070204
Content-Type: text/x-patch;
 name="smp-alternatives-7.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp-alternatives-7.diff"

diff -pu -urp linux-2.6.14/arch/i386/kernel/setup.c work-2.6.14/arch/i386/kernel/setup.c
--- linux-2.6.14/arch/i386/kernel/setup.c	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/setup.c	2005-11-16 14:48:57.000000000 +0100
@@ -1423,10 +1423,10 @@ static struct nop { 
    self modifying code. This implies that assymetric systems where
    APs have less capabilities than the boot processor are not handled. 
    Tough. Make sure you disable such features by hand. */ 
-void apply_alternatives(void *start, void *end) 
+int apply_alternatives(void *start, void *end) 
 { 
 	struct alt_instr *a; 
-	int diff, i, k;
+	int diff, i, k, count=0;
         unsigned char **noptable = intel_nops; 
 	for (i = 0; noptypes[i].cpuid >= 0; i++) { 
 		if (boot_cpu_has(noptypes[i].cpuid)) { 
@@ -1435,9 +1435,9 @@ void apply_alternatives(void *start, voi
 		}
 	} 
 	for (a = start; (void *)a < end; a++) { 
+		BUG_ON(a->replacementlen > a->instrlen); 
 		if (!boot_cpu_has(a->cpuid))
 			continue;
-		BUG_ON(a->replacementlen > a->instrlen); 
 		memcpy(a->instr, a->replacement, a->replacementlen); 
 		diff = a->instrlen - a->replacementlen; 
 		/* Pad the rest with nops */
@@ -1446,14 +1446,49 @@ void apply_alternatives(void *start, voi
 			if (k > ASM_NOP_MAX)
 				k = ASM_NOP_MAX;
 			memcpy(a->instr + i, noptable[k], k); 
-		} 
+		}
+		count++;
 	}
+	return count;
+} 
+
+extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
+extern struct alt_instr __smp_alt_instructions[], __smp_alt_instructions_end[];
+
+void switch_alternatives_up(void) 
+{ 
+	int n;
+
+	set_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+	n = apply_alternatives(__smp_alt_instructions, __smp_alt_instructions_end);
+	/* TODO: handle modules */
+	printk("%s: %d replacements\n", __FUNCTION__, n);
+} 
+
+void switch_alternatives_smp(void) 
+{ 
+	struct alt_instr *a   = __smp_alt_instructions;
+	struct alt_instr *end = __smp_alt_instructions_end;
+	int count = 0;
+
+	clear_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+	for (; a < end; a++) { 
+		memcpy(a->instr,
+		       a->replacement + a->replacementlen,
+		       a->instrlen);
+		count++;
+	}
+	/* TODO: handle modules */
+	printk("%s: %d replacements\n", __FUNCTION__, count);
 } 
 
 void __init alternative_instructions(void)
 {
-	extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
-	apply_alternatives(__alt_instructions, __alt_instructions_end);
+	int n;
+
+	n = apply_alternatives(__alt_instructions, __alt_instructions_end);
+	printk("%s: %d replacements\n", __FUNCTION__, n);
+	switch_alternatives_up();
 }
 
 static char * __init machine_specific_memory_setup(void);
diff -pu -urp linux-2.6.14/arch/i386/kernel/smpboot.c work-2.6.14/arch/i386/kernel/smpboot.c
--- linux-2.6.14/arch/i386/kernel/smpboot.c	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/smpboot.c	2005-11-16 14:48:57.000000000 +0100
@@ -1074,6 +1074,8 @@ void *xquad_portio;
 EXPORT_SYMBOL(xquad_portio);
 #endif
 
+extern void switch_alternatives_smp(void);
+
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit, kicked;
@@ -1184,6 +1186,8 @@ static void __init smp_boot_cpus(unsigne
 			continue;
 		if (max_cpus <= cpucount+1)
 			continue;
+		if (1 == kicked)
+			switch_alternatives_smp();
 
 		if (((cpu = alloc_cpu_id()) <= 0) || do_boot_cpu(apicid, cpu))
 			printk("CPU #%d not responding - cannot use it.\n",
diff -pu -urp linux-2.6.14/arch/i386/kernel/vmlinux.lds.S work-2.6.14/arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.14/arch/i386/kernel/vmlinux.lds.S	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/vmlinux.lds.S	2005-11-16 09:50:35.000000000 +0100
@@ -68,6 +68,16 @@ SECTIONS
 	*(.data.init_task)
   }
 
+  . = ALIGN(4);
+  __smp_alt_instructions = .;
+  .smp_altinstructions : AT(ADDR(.smp_altinstructions) - LOAD_OFFSET) {
+	*(.smp_altinstructions)
+  }
+  __smp_alt_instructions_end = .; 
+  .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
+	*(.smp_altinstr_replacement)
+  }
+
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
diff -pu -urp linux-2.6.14/include/asm-i386/atomic.h work-2.6.14/include/asm-i386/atomic.h
--- linux-2.6.14/include/asm-i386/atomic.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/atomic.h	2005-11-16 16:20:46.000000000 +0100
@@ -51,9 +51,9 @@ typedef struct { volatile int counter; }
  */
 static __inline__ void atomic_add(int i, atomic_t *v)
 {
-	__asm__ __volatile__(
-		LOCK "addl %1,%0"
-		:"=m" (v->counter)
+	alternative_smp_lock(
+		"addl %1,%0",
+		"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
 
@@ -66,9 +66,9 @@ static __inline__ void atomic_add(int i,
  */
 static __inline__ void atomic_sub(int i, atomic_t *v)
 {
-	__asm__ __volatile__(
-		LOCK "subl %1,%0"
-		:"=m" (v->counter)
+	alternative_smp_lock(
+		"subl %1,%0",
+		"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
 
@@ -85,9 +85,9 @@ static __inline__ int atomic_sub_and_tes
 {
 	unsigned char c;
 
-	__asm__ __volatile__(
-		LOCK "subl %2,%0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
+	alternative_smp_lock(
+		"subl %2,%0; sete %1",
+		"=m" (v->counter), "=qm" (c)
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
 }
@@ -100,9 +100,9 @@ static __inline__ int atomic_sub_and_tes
  */ 
 static __inline__ void atomic_inc(atomic_t *v)
 {
-	__asm__ __volatile__(
-		LOCK "incl %0"
-		:"=m" (v->counter)
+	alternative_smp_lock(
+		"incl %0",
+		"=m" (v->counter)
 		:"m" (v->counter));
 }
 
@@ -114,9 +114,9 @@ static __inline__ void atomic_inc(atomic
  */ 
 static __inline__ void atomic_dec(atomic_t *v)
 {
-	__asm__ __volatile__(
-		LOCK "decl %0"
-		:"=m" (v->counter)
+	alternative_smp_lock(
+		"decl %0",
+		"=m" (v->counter)
 		:"m" (v->counter));
 }
 
@@ -132,9 +132,9 @@ static __inline__ int atomic_dec_and_tes
 {
 	unsigned char c;
 
-	__asm__ __volatile__(
-		LOCK "decl %0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
+	alternative_smp_lock(
+		"decl %0; sete %1",
+		"=m" (v->counter), "=qm" (c)
 		:"m" (v->counter) : "memory");
 	return c != 0;
 }
@@ -151,9 +151,9 @@ static __inline__ int atomic_inc_and_tes
 {
 	unsigned char c;
 
-	__asm__ __volatile__(
-		LOCK "incl %0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
+	alternative_smp_lock(
+		"incl %0; sete %1",
+		"=m" (v->counter), "=qm" (c)
 		:"m" (v->counter) : "memory");
 	return c != 0;
 }
@@ -171,9 +171,9 @@ static __inline__ int atomic_add_negativ
 {
 	unsigned char c;
 
-	__asm__ __volatile__(
-		LOCK "addl %2,%0; sets %1"
-		:"=m" (v->counter), "=qm" (c)
+	alternative_smp_lock(
+		"addl %2,%0; sets %1",
+		"=m" (v->counter), "=qm" (c)
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
 }
@@ -194,9 +194,9 @@ static __inline__ int atomic_add_return(
 #endif
 	/* Modern 486+ processor */
 	__i = i;
-	__asm__ __volatile__(
-		LOCK "xaddl %0, %1;"
-		:"=r"(i)
+	alternative_smp_lock(
+		"xaddl %0, %1;",
+		"=r"(i)
 		:"m"(v->counter), "0"(i));
 	return i + __i;
 
@@ -220,12 +220,12 @@ static __inline__ int atomic_sub_return(
 
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
-__asm__ __volatile__(LOCK "andl %0,%1" \
-: : "r" (~(mask)),"m" (*addr) : "memory")
+alternative_smp_lock("andl %0,%1", \
+: "r" (~(mask)),"m" (*addr) : "memory")
 
 #define atomic_set_mask(mask, addr) \
-__asm__ __volatile__(LOCK "orl %0,%1" \
-: : "r" (mask),"m" (*(addr)) : "memory")
+alternative_smp_lock("orl %0,%1", \
+: "r" (mask),"m" (*(addr)) : "memory")
 
 /* Atomic operations are already serializing on x86 */
 #define smp_mb__before_atomic_dec()	barrier()
diff -pu -urp linux-2.6.14/include/asm-i386/cpufeature.h work-2.6.14/include/asm-i386/cpufeature.h
--- linux-2.6.14/include/asm-i386/cpufeature.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/cpufeature.h	2005-11-16 09:43:47.000000000 +0100
@@ -70,6 +70,8 @@
 #define X86_FEATURE_P3		(3*32+ 6) /* P3 */
 #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
 
+#define X86_FEATURE_UP		(3*32+ 8) /* smp kernel running on up */
+
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
 #define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
diff -pu -urp linux-2.6.14/include/asm-i386/spinlock.h work-2.6.14/include/asm-i386/spinlock.h
--- linux-2.6.14/include/asm-i386/spinlock.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/spinlock.h	2005-11-16 16:22:12.000000000 +0100
@@ -48,18 +48,23 @@
 	"jmp 1b\n" \
 	"4:\n\t"
 
+#define __raw_spin_lock_string_up \
+	"\n\tdecb %0"
+
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
-	__asm__ __volatile__(
-		__raw_spin_lock_string
-		:"=m" (lock->slock) : : "memory");
+	alternative_smp(
+		__raw_spin_lock_string,
+		__raw_spin_lock_string_up,
+		"=m" (lock->slock) : : "memory");
 }
 
 static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
 {
-	__asm__ __volatile__(
-		__raw_spin_lock_string_flags
-		:"=m" (lock->slock) : "r" (flags) : "memory");
+	alternative_smp(
+		__raw_spin_lock_string_flags,
+		__raw_spin_lock_string_up,
+		"=m" (lock->slock) : "r" (flags) : "memory");
 }
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
@@ -178,13 +183,16 @@ static inline int __raw_write_trylock(ra
 
 static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+	alternative_smp_lock(
+		"incl %0",
+		"=m" (rw->lock) : : "memory");
 }
 
 static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ", %0"
-				 : "=m" (rw->lock) : : "memory");
+	alternative_smp_lock(
+		"addl $" RW_LOCK_BIAS_STR ", %0",
+		"=m" (rw->lock) : : "memory");
 }
 
 #endif /* __ASM_SPINLOCK_H */
diff -pu -urp linux-2.6.14/include/asm-i386/system.h work-2.6.14/include/asm-i386/system.h
--- linux-2.6.14/include/asm-i386/system.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/system.h	2005-11-16 16:16:47.000000000 +0100
@@ -329,6 +329,42 @@ struct alt_instr { 
 		      "663:\n\t" newinstr "\n664:\n"   /* replacement */    \
 		      ".previous" :: "i" (feature) : "memory")  
 
+#ifdef CONFIG_SMP
+#define alternative_smp(smpinstr, upinstr, args...) 	\
+	asm volatile ("661:\n\t" smpinstr "\n662:\n" 		     \
+		      ".section .smp_altinstructions,\"a\"\n"          \
+		      "  .align 4\n"				       \
+		      "  .long 661b\n"            /* label */          \
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte 0x68\n"            /* X86_FEATURE_UP */    \
+		      "  .byte 662b-661b\n"       /* sourcelen */      \
+		      "  .byte 664f-663f\n"       /* replacementlen */ \
+		      ".previous\n"						\
+		      ".section .smp_altinstr_replacement,\"ax\"\n"    		\
+		      "663:\n\t" upinstr "\n"     /* replacement */    \
+		      "664:\n\t" smpinstr "\n"    /* original again */ \
+		      ".previous" : args)
+#define alternative_smp_lock(lockinstr, args...) 	\
+	asm volatile ("661:\n\tlock; " lockinstr "\n" 		     \
+		      ".section .smp_altinstructions,\"a\"\n"          \
+		      "  .align 4\n"				       \
+		      "  .long 661b\n"            /* label */          \
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte 0x68\n"            /* X86_FEATURE_UP */    \
+		      "  .byte 1\n"               /* sourcelen */      \
+		      "  .byte 0\n"               /* replacementlen */ \
+		      ".previous\n"						\
+		      ".section .smp_altinstr_replacement,\"ax\"\n"    		\
+		      "663:\n"                    /* replacement */    \
+		      "664:\n\tlock\n"            /* original again */ \
+		      ".previous" : args)
+#else
+#define alternative_smp(smpinstr, upinstr, args...) \
+	asm volatile (upinstr : args)
+#define alternative_smp_lock(lockinstr, args...) \
+	asm volatile (lockinstr : args)
+#endif
+
 /*
  * Alternative inline assembly with input.
  * 

--------------090000090007010405070204--
