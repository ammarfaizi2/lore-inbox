Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310303AbSCPMWi>; Sat, 16 Mar 2002 07:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310304AbSCPMWU>; Sat, 16 Mar 2002 07:22:20 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:49926 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S310303AbSCPMWC>;
	Sat, 16 Mar 2002 07:22:02 -0500
Message-ID: <3C9331C7.5BDDE3BA@yahoo.com>
Date: Sat, 16 Mar 2002 06:51:35 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Speedup SMP kernel on UP box
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[From the Futexes thread...]

Linus wrote:

> UP vs SMP - a UP system still wants to do locking, but it doesn't need the
> lock prefix. And that lock prefix makes a _huge_ difference
> performance-wise.

> The point being that the difference between a "decl" and a "lock ;  decl"
> is about 1:12 or so in performance.

> On SMP, it's a memory barrier. This is why a "lock ; decl" is more
> expensive than a "decl" - it's the implied memory ordering constraints (on
> other architectures they are explicit). On an intel CPU, this basically
> means that the pipeline is drained, so a locked instruction takes roughly
> 12 cycles on a PPro core (AMD's K7 core seems to be rather more graceful
> about this one). I haven't timed a P4 lately, I think it's worse.

I had a think on this from the perspective of increasing UP performance
of SMP kernels, and came up with the following rather interesting (IMHO)
patch.  Executive summary is that when a SMP kernel finds itself on a UP
box, it modifies itself (ooohh!) by going along and essentially doing a
sed '_text,_etext s/lock/nop/'    :)

Details:  Address of each relevant lock opcode is stored (similar to
the way an exception table is) in a separate section which is marked
init, and so it is zero cost.  After we determine smp_num_cpus==1,
a bit of code (also __init) uses the table to replace "lock" with "nop".
On a very basic system (IDE disk, net) I get about 3300 locks replaced.
For modules, insmod could detect the case of a SMP kernel on a UP box
and do the lock -> nop change prior to starting the module.

Patch is against 2.4.19pre2 - not that it is necessarily 2.4 material,
but rather that I just wanted a kernel that worked to start with.  :)

Paul.

--- ../linux/arch/i386/kernel/smpboot.c	Sun Mar  3 05:04:19 2002
+++ arch/i386/kernel/smpboot.c	Sat Mar 16 06:37:03 2002
@@ -30,6 +30,7 @@
  *		Tigran Aivazian	:	fixed "0.00 in /proc/uptime on SMP" bug.
  *	Maciej W. Rozycki	:	Bits for genuine 82489DX APICs
  *		Martin J. Bligh	: 	Added support for multi-quad systems
+ *		Paul Gortmaker	:	Self-modifying code; speedup UP boxes
  */
 
 #include <linux/config.h>
@@ -964,6 +965,44 @@
 }
 
 /*
+ * Self modifying kernel - oh my...  The lock.init section contains
+ * the address of all the "lock" opcodes (think like an exception table)
+ * and this just replaces all the "lock" with "nop".  Number of cycles
+ * saved depends on how processor handles "lock", but is substantial.
+ */
+
+extern const unsigned long __lock_tbl_start[];
+extern const unsigned long __lock_tbl_end[];
+extern char _text, _etext;
+
+#define IN_TEXT(x) (((char*)(x) >= &_text) && ((char*)(x) < &_etext))
+
+void __init modify_kernel_for_UP(void)
+{
+	unsigned long i, count = 0;
+
+	printk("Dynamically optimizing SMP kernel code for UP operation...\n");
+
+	for (i = 0; __lock_tbl_start[i] != __lock_tbl_end[0]; i++) {
+
+		u8 *here = (u8*)__lock_tbl_start[i];
+
+		if (!IN_TEXT(here))
+			continue;	/* skip _init, _exit, etc. */
+
+		if (*here != 0xf0) {
+			printk("0x%p is not 0xf0 (lock opcode)\n", here);
+			return;
+		}
+
+		*here = 0x90;	/* nop */
+		count++;
+	}
+
+	printk("OK, made %ld modifications to kernel code.\n", count);
+}
+
+/*
  * Cycle through the processors sending APIC IPIs to boot each.
  */
 
@@ -1220,5 +1259,8 @@
 		synchronize_tsc_bp();
 
 smp_done:
+	if (smp_num_cpus == 1)
+		modify_kernel_for_UP();
+
 	zap_low_mappings();
 }
--- ../linux/arch/i386/vmlinux.lds	Thu Feb 28 09:36:30 2002
+++ arch/i386/vmlinux.lds	Fri Mar 15 06:04:15 2002
@@ -49,6 +49,10 @@
   __initcall_start = .;
   .initcall.init : { *(.initcall.init) }
   __initcall_end = .;
+  . = ALIGN(4);
+  __lock_tbl_start = .;
+  .lock.init : { *(.lock.init) }
+  __lock_tbl_end = .;
   . = ALIGN(4096);
   __init_end = .;
 
diff -u ../linux/include/asm-i386/atomic.h include/asm-i386/atomic.h
--- ../linux/include/asm-i386/atomic.h	Mon Feb 18 05:22:14 2002
+++ include/asm-i386/atomic.h	Fri Mar 15 04:07:46 2002
@@ -9,9 +9,15 @@
  */
 
 #ifdef CONFIG_SMP
-#define LOCK "lock ; "
+#define LOCK "\n1:\tlock ; "
+#define LOCK_ADDR	"\n" \
+			".section .lock.init,\"a\"\n\t" \
+			".align 4\n\t" \
+			".long 1b\n" \
+			".previous\n"
 #else
 #define LOCK ""
+#define LOCK_ADDR ""
 #endif
 
 /*
@@ -54,6 +60,7 @@
 {
 	__asm__ __volatile__(
 		LOCK "addl %1,%0"
+		LOCK_ADDR
 		:"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
@@ -70,6 +77,7 @@
 {
 	__asm__ __volatile__(
 		LOCK "subl %1,%0"
+		LOCK_ADDR
 		:"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
@@ -90,6 +98,7 @@
 
 	__asm__ __volatile__(
 		LOCK "subl %2,%0; sete %1"
+		LOCK_ADDR
 		:"=m" (v->counter), "=qm" (c)
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
@@ -106,6 +115,7 @@
 {
 	__asm__ __volatile__(
 		LOCK "incl %0"
+		LOCK_ADDR
 		:"=m" (v->counter)
 		:"m" (v->counter));
 }
@@ -121,6 +131,7 @@
 {
 	__asm__ __volatile__(
 		LOCK "decl %0"
+		LOCK_ADDR
 		:"=m" (v->counter)
 		:"m" (v->counter));
 }
@@ -140,6 +151,7 @@
 
 	__asm__ __volatile__(
 		LOCK "decl %0; sete %1"
+		LOCK_ADDR
 		:"=m" (v->counter), "=qm" (c)
 		:"m" (v->counter) : "memory");
 	return c != 0;
@@ -160,6 +172,7 @@
 
 	__asm__ __volatile__(
 		LOCK "incl %0; sete %1"
+		LOCK_ADDR
 		:"=m" (v->counter), "=qm" (c)
 		:"m" (v->counter) : "memory");
 	return c != 0;
@@ -181,6 +194,7 @@
 
 	__asm__ __volatile__(
 		LOCK "addl %2,%0; sets %1"
+		LOCK_ADDR
 		:"=m" (v->counter), "=qm" (c)
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
@@ -189,10 +203,12 @@
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
 __asm__ __volatile__(LOCK "andl %0,%1" \
+LOCK_ADDR \
 : : "r" (~(mask)),"m" (*addr) : "memory")
 
 #define atomic_set_mask(mask, addr) \
 __asm__ __volatile__(LOCK "orl %0,%1" \
+LOCK_ADDR \
 : : "r" (mask),"m" (*addr) : "memory")
 
 /* Atomic operations are already serializing on x86 */
diff -u ../linux/include/asm-i386/bitops.h include/asm-i386/bitops.h
--- ../linux/include/asm-i386/bitops.h	Mon Feb 18 05:22:14 2002
+++ include/asm-i386/bitops.h	Sat Mar 16 05:17:08 2002
@@ -16,9 +16,15 @@
  */
 
 #ifdef CONFIG_SMP
-#define LOCK_PREFIX "lock ; "
+#define LOCK_PREFIX "\n1:\tlock ; "
+#define LOCK_SUFFIX	"\n" \
+			".section .lock.init,\"a\"\n\t" \
+			".align 4\n\t" \
+			".long 1b\n" \
+			".previous"
 #else
 #define LOCK_PREFIX ""
+#define LOCK_SUFFIX ""
 #endif
 
 #define ADDR (*(volatile long *) addr)
@@ -37,6 +43,7 @@
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %1,%0"
+		LOCK_SUFFIX
 		:"=m" (ADDR)
 		:"Ir" (nr));
 }
@@ -72,6 +79,7 @@
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrl %1,%0"
+		LOCK_SUFFIX
 		:"=m" (ADDR)
 		:"Ir" (nr));
 }
@@ -108,6 +116,7 @@
 {
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcl %1,%0"
+		LOCK_SUFFIX
 		:"=m" (ADDR)
 		:"Ir" (nr));
 }
@@ -126,6 +135,7 @@
 
 	__asm__ __volatile__( LOCK_PREFIX
 		"btsl %2,%1\n\tsbbl %0,%0"
+		LOCK_SUFFIX
 		:"=r" (oldbit),"=m" (ADDR)
 		:"Ir" (nr) : "memory");
 	return oldbit;
@@ -165,6 +175,7 @@
 
 	__asm__ __volatile__( LOCK_PREFIX
 		"btrl %2,%1\n\tsbbl %0,%0"
+		LOCK_SUFFIX
 		:"=r" (oldbit),"=m" (ADDR)
 		:"Ir" (nr) : "memory");
 	return oldbit;
@@ -216,6 +227,7 @@
 
 	__asm__ __volatile__( LOCK_PREFIX
 		"btcl %2,%1\n\tsbbl %0,%0"
+		LOCK_SUFFIX
 		:"=r" (oldbit),"=m" (ADDR)
 		:"Ir" (nr) : "memory");
 	return oldbit;
diff -u ../linux/include/asm-i386/rwlock.h include/asm-i386/rwlock.h
--- ../linux/include/asm-i386/rwlock.h	Sun Mar  3 05:05:10 2002
+++ include/asm-i386/rwlock.h	Fri Mar 15 03:50:13 2002
@@ -22,6 +22,7 @@
 
 #define __build_read_lock_ptr(rw, helper)   \
 	asm volatile(LOCK "subl $1,(%0)\n\t" \
+		     LOCK_ADDR "\t" \
 		     "js 2f\n" \
 		     "1:\n" \
 		     LOCK_SECTION_START("") \
@@ -32,6 +33,7 @@
 
 #define __build_read_lock_const(rw, helper)   \
 	asm volatile(LOCK "subl $1,%0\n\t" \
+		     LOCK_ADDR "\t" \
 		     "js 2f\n" \
 		     "1:\n" \
 		     LOCK_SECTION_START("") \
@@ -52,6 +54,7 @@
 
 #define __build_write_lock_ptr(rw, helper) \
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
+		     LOCK_ADDR "\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
 		     LOCK_SECTION_START("") \
@@ -62,6 +65,7 @@
 
 #define __build_write_lock_const(rw, helper) \
 	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
+		     LOCK_ADDR "\t" \
 		     "jnz 2f\n" \
 		     "1:\n" \
 		     LOCK_SECTION_START("") \
diff -u ../linux/include/asm-i386/semaphore.h include/asm-i386/semaphore.h
--- ../linux/include/asm-i386/semaphore.h	Sun Mar  3 05:05:10 2002
+++ include/asm-i386/semaphore.h	Fri Mar 15 03:51:20 2002
@@ -120,6 +120,7 @@
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
 		LOCK "decl %0\n\t"     /* --sem->count */
+		LOCK_ADDR "\t"
 		"js 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
@@ -146,6 +147,7 @@
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK_ADDR "\t"
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -174,6 +176,7 @@
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
 		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK_ADDR "\t"
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -201,6 +204,7 @@
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
 		LOCK "incl %0\n\t"     /* ++sem->count */
+		LOCK_ADDR "\t"
 		"jle 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
diff -u ../linux/include/asm-i386/spinlock.h include/asm-i386/spinlock.h
--- ../linux/include/asm-i386/spinlock.h	Sun Mar  3 05:05:10 2002
+++ include/asm-i386/spinlock.h	Fri Mar 15 04:05:42 2002
@@ -54,7 +54,11 @@
 
 #define spin_lock_string \
 	"\n1:\t" \
-	"lock ; decb %0\n\t" \
+	"lock ; decb %0\n" \
+	".section .lock.init,\"a\"\n\t" \
+	".align 4\n\t" \
+	".long 1b\n" \
+	".previous\n\t" \
 	"js 2f\n" \
 	LOCK_SECTION_START("") \
 	"2:\t" \
@@ -197,8 +201,21 @@
 	__build_write_lock(rw, "__write_lock_failed");
 }
 
-#define read_unlock(rw)		asm volatile("lock ; incl %0" :"=m" ((rw)->lock) : : "memory")
-#define write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%0":"=m" ((rw)->lock) : : "memory")
+#define read_unlock(rw)		asm volatile( \
+	"\n1:\tlock ; incl %0\n" \
+	".section .lock.init,\"a\"\n\t" \
+	".align 4\n\t" \
+	".long 1b\n" \
+	".previous" \
+	:"=m" ((rw)->lock) : : "memory")
+
+#define write_unlock(rw)	asm volatile( \
+	"\n1:\tlock ; addl $" RW_LOCK_BIAS_STR ",%0\n" \
+	".section .lock.init,\"a\"\n\t" \
+	".align 4\n\t" \
+	".long 1b\n" \
+	".previous" \
+	:"=m" ((rw)->lock) : : "memory")
 
 static inline int write_trylock(rwlock_t *lock)
 {


