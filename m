Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318627AbSH1Dhs>; Tue, 27 Aug 2002 23:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318630AbSH1Dhs>; Tue, 27 Aug 2002 23:37:48 -0400
Received: from ppp-217-133-221-76.dialup.tiscali.it ([217.133.221.76]:36333
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318627AbSH1Dha>; Tue, 27 Aug 2002 23:37:30 -0400
Subject: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-90C1bQUlyo/S/1LH7XbU"
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Aug 2002 05:41:46 +0200
Message-Id: <1030506106.1489.27.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-90C1bQUlyo/S/1LH7XbU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch implements a system that modifies the kernel code at runtime
depending on CPU features and SMPness.

In fact, I'm not really sure whether it's a good idea to do something
like this. When I started implementing this it seemed to be possible to
have a much simpler and cleaner implementation but unfortunately this
isn't the case especially due to the need of SMP correctness.

This patch requires the is_smp() patch I posted earlier and also
requires the new CPU selection code and the code that actually uses
both.
This code already exists, but needs a few adjustments so it may not
arrive immediately.

The code is invoked in the following ways:
        * Undefined exception handler: this is used to replace
          unsupported instructions with supported ones. Used for invlpg
          -> flushall, prefetchnta -> prefetch -> nop, *fence -> lock
          addl 0, (%esp), movntq -> movq
        * Int3 handler: this is used when a 1 byte opcode is desired.
          This is controlled by a config option so that debuggers and
          kprobe won't break. Used for lock/nop and APIC write
        * Int 0xfa handler: this is a dynamic fixup specific vector used
          to implement everything else. Used for: spin unlock, io fence,
          sfence, APIC write (if int3 not available).

Note that the int3 and int 0xfa handler are actually invoked by the code
to be modified, so the handlers replace calls to themselves.
For example for APIC writes we have <int3> 0x40 mem32 -> <xchgl/movl>
<%eax,> mem32.

No fixups are performed until SMP boot is completed. Instructions are
instead emulated in the interrupt/exception handlers.

Unfortunately with this patch executing invalid code will cause the
processor to enter an infinite exception loop rather than panic. Fixing
this is not trivial for SMP+preempt so it's not done at the moment.

This code needs special care for SMP safety. Here is a copy of the
comment explaining this:
/* If we are running on SMP any other processor might be executing the
   code that we are modifying. We must make sure that the other
   processor will either fault or will execute the complete
   replacement instruction.

   This is accomplished by using instructions that fault only
   depending on up to 4 bytes. When fixing up something we first write
   bytes after the first 4 and we then use a locked write to set the
   first 4.

   We depend on the processor execute unit to never see our locked
   write before it sees the other modifications.
   
   According to page 7-5 of the Intel Pentium 4 System Programming
   Manual, this is safe on 486 and Pentium <= 4.
   
   For other processors this may be unsafe. If this is the case, on
   such processors IPIs must be sent to all other processors to block
   them before the fixup is performed. dynamic_fixup_smp_(un)lock are
   reserved for this purpose.
*/
Comments on whether this would work on Athlon MPs are appreciated. If it
wouldn't an implementation of the send-IPIs-to-everyone code would also
be appreciated.

BTW, credit for the original idea goes to Linus.


diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/arch/i386/kernel/entry.S linux-2.5.32_fixup/arch/i386/kernel/entry.S
--- linux-2.5.32/arch/i386/kernel/entry.S	2002-08-27 21:26:38.000000000 +0200
+++ linux-2.5.32_fixup/arch/i386/kernel/entry.S	2002-08-27 22:52:12.000000000 +0200
@@ -445,6 +445,13 @@ ENTRY(nmi)
 	RESTORE_ALL
 
 ENTRY(int3)
+#ifdef CONFIG_X86_DYNAMIC_FIXUP_INT3
+	testl $(VM_MASK), 8(%esp)
+	jnz 1f
+	testl $0x3, 4(%esp)
+	jz dynamic_fixup_entry_int3
+1:	
+#endif
 	pushl $0
 	pushl $do_int3
 	jmp error_code
@@ -507,6 +514,46 @@ ENTRY(spurious_interrupt_bug)
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
 
+ENTRY(dynamic_fixup_entry_int)
+	pushl %eax
+	pushl %edx
+	pushl %ecx
+	call dynamic_fixup_x86_int
+	popl %ecx
+	popl %edx
+	popl %eax
+	iret	
+
+#ifdef CONFIG_X86_DYNAMIC_FIXUP_INT3
+ENTRY(dynamic_fixup_entry_int3)
+	pushl %eax
+	pushl %edx
+	pushl %ecx
+	call dynamic_fixup_x86_int3
+	popl %ecx
+	popl %edx
+	popl %eax
+	iret	
+#endif
+
+ENTRY(flush_tlb)
+	pushl %eax
+	movl %cr3, %eax
+	movl %eax, %cr3
+	popl %eax
+	ret
+
+ENTRY(emulate_rdtsc)
+	pushl %ecx
+	call do_gettimeofday64
+	movl %eax, %ecx
+	movl $1000000, %eax
+	mull %edx
+	addl %ecx, %eax
+	adcl $0, %edx
+	popl %ecx
+	ret
+	
 .data
 ENTRY(sys_call_table)
 	.long sys_ni_syscall	/* 0 - old "setup()" system call*/
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/arch/i386/kernel/fixup.c linux-2.5.32_fixup/arch/i386/kernel/fixup.c
--- linux-2.5.32/arch/i386/kernel/fixup.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.32_fixup/arch/i386/kernel/fixup.c	2002-08-27 22:49:50.000000000 +0200
@@ -0,0 +1,510 @@
+#include <linux/config.h>
+#include <asm/types.h>
+#include <linux/linkage.h>
+#include <linux/kernel.h>
+#include <linux/sysrq.h>
+#include <linux/init.h>
+#include <asm/processor.h>
+#include <asm/atomic.h>
+#include <asm/bitops.h>
+#include <asm/fixup.h>
+#include <asm/system.h>
+
+/* If we are running on SMP any other processor might be executing the
+   code that we are modifying. We must make sure that the other
+   processor will either fault or will execute the complete
+   replacement instruction.
+
+   This is accomplished by using instructions that fault only
+   depending on up to 4 bytes. When fixing up something we first write
+   bytes after the first 4 and we then use a locked write to set the
+   first 4.
+
+   We depend on the processor execute unit to never see our locked
+   write before it sees the other modifications.
+   
+   According to page 7-5 of the Intel Pentium 4 System Programming
+   Manual, this is safe on 486 and Pentium <= 4.
+   
+   For other processors this may be unsafe. If this is the case, on
+   such processors IPIs must be sent to all other processors to block
+   them before the fixup is performed. dynamic_fixup_smp_(un)lock are
+   reserved for this purpose.
+*/
+
+#define dynamic_fixup_smp_lock() do {} while(0)
+#define dynamic_fixup_smp_unlock() do {} while(0)
+
+#define non_atomic  0, 0,
+#define decl_atomic int atomic, u32 atomicv,
+#define pass_atomic atomic, atomicv,
+#define want_atomic 1, value,
+
+/* This variable is 0 before smp boot is completed and the value to
+   replace int3 with it is completed.
+   
+   When it is 0, no fixups that depend on CPU or SMP initialiazion are
+   done and instructions are emulated if necessary.
+*/
+u8 lock_fixup = 0;
+#define perform_fixup lock_fixup
+
+void flush_tlb(void);
+unsigned long long emulate_rdtsc(void);
+
+/* Only aligned 32-bit accesses are guaranteed to be atomic */
+static inline u32
+atomic_read_unaligned32(u32 * p)
+{
+	u32 value;
+	if (is_smp())
+		asm volatile ("lock; cmpxchg %0, %1" : "=a" (value) : "m" (*p));
+	else
+		value = *p;
+	return value;
+}
+
+static inline void
+atomic_write_unaligned32(u32 * p, u32 value)
+{
+	u32 xchgv = value;
+	/*
+	   u32 eax;
+	   if(is_smp())
+	   asm volatile(
+	   "1:\n\t"
+	   "lock; cmpxchg %2, %1\n\t"
+	   "jne 2f\n\t"
+	   ".subsection 2\n\t"
+	   "2: jmp 1b\n\t"
+	   ".previous"
+	   : "=a" (eax) : "m" (*(u32*)p), "r" (value), "0" (*(u32*)p));
+	   else
+	   *(u32*)p = value;
+	 */
+
+	/* xchg should be atomic since it implicitly locks */
+	asm volatile ("xchgl %1, %0":"=m" (*p), "=r"(xchgv):"1"(value));
+}
+
+static inline void
+set1(decl_atomic u8 * instr, u8 a)
+{
+	if (!atomic)
+		*instr = a;
+	else
+		atomic_write_unaligned32((u32 *) instr,
+					 (atomicv & 0xffffff00) | a);
+}
+
+static inline void
+set2(decl_atomic u8 * instr, u8 a, u8 b)
+{
+	if (!atomic) {
+		set1(non_atomic instr, a);
+		set1(non_atomic instr + 1, b);
+	} else
+		atomic_write_unaligned32((u32 *) instr,
+					 (atomicv & 0xffff0000) | a | (b << 8));
+}
+
+static inline void
+set3(decl_atomic u8 * instr, u8 a, u8 b, u8 c)
+{
+	if (!atomic) {
+		set1(non_atomic instr, a);
+		set2(non_atomic instr + 1, b, c);
+	} else
+		atomic_write_unaligned32((u32 *) instr,
+					 (atomicv & 0xff000000) | a | (b << 8) | (c << 16));
+}
+
+static inline void
+set4(decl_atomic u8 * instr, u8 a, u8 b, u8 c, u8 d)
+{
+	if (!atomic) {
+		set1(non_atomic instr, a);
+		set3(non_atomic instr + 1, b, c, d);
+	} else
+		atomic_write_unaligned32((u32 *) instr,
+					 a | (b << 8) | (c << 16) | (d << 24));
+}
+
+static inline void
+set5(decl_atomic u8 * instr, u8 a, u8 b, u8 c, u8 d, u8 e)
+{
+	set1(non_atomic instr + 4, e);
+	set4(pass_atomic instr, a, b, c, d);
+}
+
+static inline void
+set6(decl_atomic u8 * instr, u8 a, u8 b, u8 c, u8 d, u8 e, u8 f)
+{
+	set2(non_atomic instr + 4, e, f);
+	set4(pass_atomic instr, a, b, c, d);
+}
+
+static inline void
+set7(decl_atomic u8 * instr, u8 a, u8 b, u8 c, u8 d, u8 e, u8 f, u8 g)
+{
+	set3(non_atomic instr + 4, e, f, g);
+	set4(pass_atomic instr, a, b, c, d);
+}
+
+static inline void
+set8(decl_atomic u8 * instr, u8 a, u8 b, u8 c, u8 d, u8 e, u8 f, u8 g, u8 h)
+{
+	set4(non_atomic instr + 4, e, f, g, h);
+	set4(pass_atomic instr, a, b, c, d);
+}
+
+static inline void
+generate_nop(decl_atomic u8 * instr, unsigned size)
+{
+	switch (size) {
+	case 1:
+		set1(pass_atomic instr, 0x90);	/* xchgl %eax, %eax */
+		break;
+	case 2:
+		set2(pass_atomic instr, 0x89, 0xf6);	/* movl %esi, %esi */
+		break;
+	case 3:
+		set3(pass_atomic instr, 0x8d, 0x76, 0);	/* leal 0(%esi), %esi */
+		break;
+	case 4:
+		set4(pass_atomic instr, 0x8d, 0x74, 0x26, 0);	/* leal 0(%esi,1), %esi */
+		break;
+	case 5:
+		set5(pass_atomic instr, 0x36, 0x8d, 0x74, 0x26, 0);	/* leal %ss:0(%esi,1), %esi */
+		break;
+	case 6:
+		set6(pass_atomic instr, 0x8d, 0xb6, 0, 0, 0, 0);	/* leal 0(%esi), %esi */
+		break;
+	case 7:
+		set7(pass_atomic instr, 0x8d, 0xb4, 0x26, 0, 0, 0, 0);	/* leal 0(%esi,1), %esi */
+		break;
+	case 8:
+		set8(pass_atomic instr, 0x36, 0x8d, 0xb4, 0x26, 0, 0, 0, 0);	/* leal %ss:0(%esi,1), %esi */
+		break;
+	}
+}
+
+static inline void
+generate_call(decl_atomic u8 * instr, void *func)
+{
+	u32 value = (u8 *) func - instr - 5;
+	if (atomic) {
+		set1(non_atomic instr + 4, (u8) (value >> 24));
+		atomic_write_unaligned32((u32 *) instr, 0xe8 | (value << 8));
+	} else {
+		set1(non_atomic instr, 0xe8);	/* call rel32 */
+		*(u32 *) (instr + 1) = value;
+	}
+}
+
+static inline void
+generate_fence(decl_atomic u8 * instr)
+{
+	if (cpu_needs_lfence)
+		set5(pass_atomic instr, 0xf0, 0x83, 0x04, 0x24, 0);	/* lock; addl $0,(%%esp) */
+	else
+		generate_nop(pass_atomic instr, 5);
+}
+
+static inline void
+generate_sfence(decl_atomic u8 * instr)
+{
+	if (cpu_needs_sfence) {
+		if (cpu_has_mmxext)
+			set5(pass_atomic instr, 0x0f, 0xae, 0xf8, 0x89, 0xf6);	/* sfence; movl %esi, %esi */
+		else
+			generate_fence(pass_atomic instr);
+	} else
+		generate_nop(pass_atomic instr, 5);
+}
+
+/* #define DEBUG_DYNAMIC_FIXUP */
+
+#ifdef DEBUG_DYNAMIC_FIXUP
+#define DSTAT_(x) static atomic_t stat_fixup_##x = ATOMIC_INIT(0); static atomic_t stat_emu_##x = ATOMIC_INIT(0)
+#define DSTAT(x) static atomic_t stat_fixup_##x = ATOMIC_INIT(0)
+DSTAT_(unlock);
+DSTAT_(iofence);
+DSTAT_(sfence);
+DSTAT_(apic);
+DSTAT_(lock);
+DSTAT_(prefetch);
+DSTAT_(mfence);
+
+DSTAT(invlpg);
+DSTAT(rdtscnop);
+DSTAT(rdtscemu);
+DSTAT(movntq);
+
+#define STAT(x)  atomic_inc(&stat_fixup_##x)
+#define STAT_(x) do {if(perform_fixup) atomic_inc(&stat_fixup_##x); else atomic_inc(&stat_emu_##x);} while(0)
+
+#define PSTAT_(x) printk(#x " - emu: %u fixup: %u\n", atomic_read(&stat_emu_##x), atomic_read(&stat_fixup_##x))
+#define PSTAT(x) printk(#x " - fixup: %u\n", atomic_read(&stat_fixup_##x))
+
+void
+dynamic_fixup_sysrq_handler(int key)
+{
+	PSTAT_(unlock);
+	PSTAT_(iofence);
+	PSTAT_(sfence);
+	PSTAT_(apic);
+	PSTAT_(lock);
+	PSTAT_(prefetch);
+	PSTAT_(mfence);
+
+	PSTAT(invlpg);
+	PSTAT(rdtscnop);
+	PSTAT(rdtscemu);
+	PSTAT(movntq);
+}
+
+static struct sysrq_key_op dynamic_fixup_sysrq_ops = {
+	.handler = dynamic_fixup_sysrq_handler,
+	.help_msg = "Fixup",
+	.action_msg = "Show dynamic fixup stats"
+};
+
+static int
+dynamic_fixup_sysrq_init(void)
+{
+	return register_sysrq_key('f', &dynamic_fixup_sysrq_ops);
+}
+
+__initcall(dynamic_fixup_sysrq_init);
+
+#else
+#define STAT(x)
+#define STAT_(x)
+#endif
+
+/* called from smpboot.c */
+void
+dynamic_fixup_start(void)
+{
+	/* We use an %ss: segment override rather than a nop because it's faster
+	   (at least on 686). We can safely use it since %ss must always point to
+	   a kernel data segment and instructions with LOCK must reference memory. */
+	lock_fixup = can_be_smp() ? 0xf0 : 0x36;	/* lock / %ss */
+}
+
+void
+dynamic_fixup_x86_int(u32 ecx, u32 edx, u32 eax, u8 * eip)
+{
+	u8 *instr = eip - 2;
+	u32 value;
+	dynamic_fixup_smp_lock();
+	value = atomic_read_unaligned32((u32 *) instr);
+	if ((value & 0xffff) == (0xcd | (DYNAMIC_FIXUP_VECTOR << 8))) {
+		switch ((u8) (value >> 16)) {
+		case DYNAMIC_FIXUP_INT_SPIN_UNLOCK:
+			STAT_(unlock);
+			if (perform_fixup) {
+				if (cpu_needs_sfence)
+					set3(want_atomic instr, 0xb2, 0x01, 0x86);	/* movb $1, %dl; xchgb ... */
+				else
+					set3(want_atomic instr, 0xb2, 0x01, 0x88);	/* movb $1, %dl; movb ... */
+			} else {
+				instr += 2;
+				*(volatile u32 *) &edx = 1;
+			}
+			break;
+		case DYNAMIC_FIXUP_INT_IO_FENCE:
+			STAT_(iofence);
+			if (perform_fixup)
+				generate_sfence(want_atomic instr);
+			else
+				instr += 5;	/* iret is serializing */
+			break;
+		case DYNAMIC_FIXUP_INT_SFENCE:
+			STAT_(sfence);
+			if (perform_fixup) {
+				if (cpu_has_oostore)
+					generate_sfence(want_atomic instr);
+				else
+					generate_nop(want_atomic instr, 5);
+			} else
+				instr += 5;	/* iret is serializing */
+			break;
+		case DYNAMIC_FIXUP_INT3_APIC_WRITE:
+			STAT_(apic);
+			if (perform_fixup) {
+				if (cpu_has_good_apic)
+					set3(want_atomic instr, 0x36, 0x89, 0x05);	/* movl %eax, ... */
+				else
+					set3(want_atomic instr, 0x36, 0x87, 0x05);	/* xchgl %eax, ... */
+			} else {
+				xchg((volatile unsigned long*)(*(u32 *) (instr + 3)), eax);
+				instr += 7;
+			}
+			break;
+		default:
+			panic("unknown dynamic fixup code: 0x%02x",
+			      (u8) (value >> 16));
+			break;
+		}
+	}
+	*(u8 * volatile *) &eip = instr;
+	dynamic_fixup_smp_unlock();
+}
+
+void
+dynamic_fixup_x86_int3(u32 ecx, u32 edx, u32 eax, u8 * eip)
+{
+	u8 *instr = eip - 1;
+	u32 value;
+	dynamic_fixup_smp_lock();
+	value = atomic_read_unaligned32((u32 *) instr);
+	if ((u8) value == 0xcc) {
+		switch ((u8) (value >> 8)) {
+		case DYNAMIC_FIXUP_INT3_APIC_WRITE:
+			STAT_(apic);
+			if (perform_fixup) {
+				if (cpu_has_good_apic)
+					set2(want_atomic instr, 0x89, 0x05);	/* movl %eax, ... [disp32] */
+				else
+					set2(want_atomic instr, 0x87, 0x05);	/* xchgl %eax, ... [disp32] */
+			} else {
+				xchg((volatile unsigned long*) (*(u32 *) (instr + 2)), eax);
+				instr += 6;
+			}
+			break;
+		default:
+#ifdef DEBUG_DYNAMIC_FIXUP
+		      __asm__ __volatile__("lock; incl %0" : "=m" ((perform_fixup ? &stat_fixup_lock : &stat_emu_lock)->counter)
+		      : "m"((perform_fixup ? &stat_fixup_lock : &stat_emu_lock)->counter));
+#endif
+			if (perform_fixup)
+				set1(want_atomic instr, lock_fixup);
+			else
+				instr += 1;
+		}
+	}
+	*(u8 * volatile *) &eip = instr;
+	dynamic_fixup_smp_unlock();
+}
+
+#define mod (value & 0xc0)
+#define rm  (value & 0x7)
+#define modrm (value & 0xc7)
+#define basemod (value & 0x7c0)
+
+#define MOD_IND    0
+#define MOD_DISP8  0x40
+#define MOD_DISP32 0x80
+#define MOD_REG    0xc0
+
+#define MODRM_DISP32 5
+#define RM_SIB 4
+
+#define BASE_EBP 0x500
+#define BASEMOD_DISP32 (BASE_EBP | MOD_IND)
+
+static inline unsigned
+modrm_length(u32 value)
+{
+	return (modrm == MODRM_DISP32) ? 5
+	    : (((mod == MOD_DISP8) ? 1 : ((mod == MOD_DISP32) ? 4 : 0))
+	       + (((mod != MOD_REG) && (rm == RM_SIB))
+		  ? (2 + ((basemod == BASEMOD_DISP32) ? 4 : 0))
+		  : 1));
+}
+
+#undef mod
+#define regop ((value >> 11) & 7)
+#define mod ((value >> 8) & 0xc0)
+
+#define regop2 ((value >> 21) & 7)
+#define mod2 ((value >> 16) & 0xc0)
+
+static inline void
+handle_prefetch(decl_atomic u8 ** pinstr)
+{
+	u8 *instr = *pinstr;
+	STAT_(prefetch);
+	if (perform_fixup) {
+		if (cpu_has_mmxext || cpu_has_3dnow)
+			atomic_write_unaligned32((u32 *) instr, (atomicv & ~0x38ff00) |
+						 (cpu_has_3dnow ? 0x000d00 : 0x001800));
+		else
+			generate_nop(pass_atomic instr,
+				     modrm_length(atomicv >> 16) + 2);
+	} else
+		*pinstr += modrm_length(atomicv >> 16) + 2;
+}
+
+int
+dynamic_fixup_x86_ud(u8 ** pinstr)
+{
+	u8 *instr = *pinstr;
+	u32 value;
+	dynamic_fixup_smp_lock();
+	value = atomic_read_unaligned32((u32 *) instr);
+	switch ((u8) value) {
+	case 0x0f:
+		switch ((u8) (value >> 8)) {
+		case 0x01:	/* Group 7 */
+			switch (regop2) {
+			case 0x7:	/* invlpg */
+				/* We could make this inline by declaring that eax is clobbered,
+				   but the tlb flush penalty should be large enough to make
+				   optimizing this irrelevant */
+				STAT(invlpg);
+				generate_nop(non_atomic instr + 5, 2);
+				generate_call(want_atomic instr, flush_tlb);
+			}
+			break;
+		case 0x0d:	/* AMD prefetch group */
+			switch (regop2) {
+			case 0:	/* prefetch */
+			case 1:	/* prefetchw */
+				handle_prefetch(want_atomic pinstr);
+				break;
+			}
+			break;
+		case 0x18:	/* Intel prefetch group 16 */
+			if (mod2 != MOD_REG) {
+				if (regop2 <= 3) {	/* prefetch{nta,t[012]} */
+					handle_prefetch(want_atomic pinstr);
+				}
+			}
+			break;
+		case 0x31:	/* rdtsc */
+			if ((u8) (value >> 16) == 0x90) {
+				STAT(rdtscnop);
+				set3(want_atomic instr, 0x31, 0xc0, 0x99);	/* xorl %eax, %eax; cltd */
+			} else {
+				STAT(rdtscemu);
+				generate_call(want_atomic instr, emulate_rdtsc);
+			}
+			break;
+		case 0xae:	/* Group 15 */
+			STAT(mfence);
+			if (mod2 == MOD_REG) {	/* Mod == 11B */
+				if (regop2 >= 5) {	/* [sml]fence */
+					if (perform_fixup)
+						generate_fence(want_atomic instr);
+					else
+						instr += 3;
+					*pinstr = instr;
+				}
+			}
+			break;
+		case 0xe7:	/* movntq */
+			STAT(movntq);
+			set2(want_atomic instr, 0x0f, 0x7f);	/* movq */
+			break;
+		}
+		break;
+	}
+	dynamic_fixup_smp_unlock();
+
+	/* Checking whether this is bad code or not is difficult with
+	   preempt and smp, so let's just ignore it for now */
+	return 1;
+}
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/arch/i386/kernel/head.S linux-2.5.32_fixup/arch/i386/kernel/head.S
--- linux-2.5.32/arch/i386/kernel/head.S	2002-08-27 21:26:34.000000000 +0200
+++ linux-2.5.32_fixup/arch/i386/kernel/head.S	2002-08-27 22:49:50.000000000 +0200
@@ -15,7 +15,9 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/desc.h>
-
+#include <asm/irq_vectors.h>
+#include <asm/fixup.h>
+		
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
 #define OLD_CL_BASE_ADDR	0x90000
@@ -302,6 +304,23 @@ rp_sidt:
 	addl $8,%edi
 	dec %ecx
 	jne rp_sidt
+
+/* Setup dynamic fixup vectors */
+#ifdef CONFIG_X86_DYNAMIC_FIXUP_INT3
+	movl $(__KERNEL_CS << 16), %eax
+	movl $dynamic_fixup_entry_int3, %edx
+	movw %dx, %ax
+	movw $0x8f00, %dx
+	movl %eax, (idt_table + 3 * 8)
+	movl %edx, (idt_table + 3 * 8 + 4)
+#endif
+
+	movl $dynamic_fixup_entry_int, %edx
+	movw %dx, %ax
+	movw $0x8f00, %dx
+	movl %eax, (idt_table + DYNAMIC_FIXUP_VECTOR * 8)
+	movl %edx, (idt_table + DYNAMIC_FIXUP_VECTOR * 8 + 4)
+				
 	ret
 
 ENTRY(stack_start)
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/arch/i386/kernel/i8259.c linux-2.5.32_fixup/arch/i386/kernel/i8259.c
--- linux-2.5.32/arch/i386/kernel/i8259.c	2002-08-27 21:27:31.000000000 +0200
+++ linux-2.5.32_fixup/arch/i386/kernel/i8259.c	2002-08-27 22:49:50.000000000 +0200
@@ -385,7 +385,7 @@ void __init init_IRQ(void)
 	 */
 	for (i = 0; i < NR_IRQS; i++) {
 		int vector = FIRST_EXTERNAL_VECTOR + i;
-		if (vector != SYSCALL_VECTOR) 
+		if ((vector != SYSCALL_VECTOR) && (vector != DYNAMIC_FIXUP_VECTOR))
 			set_intr_gate(vector, interrupt[i]);
 	}
 
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/arch/i386/kernel/Makefile linux-2.5.32_fixup/arch/i386/kernel/Makefile
--- linux-2.5.32/arch/i386/kernel/Makefile	2002-08-27 21:26:36.000000000 +0200
+++ linux-2.5.32_fixup/arch/i386/kernel/Makefile	2002-08-27 22:49:50.000000000 +0200
@@ -11,7 +11,7 @@ export-objs     := mca.o msr.o i386_ksym
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bluesmoke.o dmi_scan.o \
-		bootflag.o
+		bootflag.o fixup.o
 
 obj-y				+= cpu/
 obj-$(CONFIG_MCA)		+= mca.o
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/arch/i386/kernel/time.c linux-2.5.32_fixup/arch/i386/kernel/time.c
--- linux-2.5.32/arch/i386/kernel/time.c	2002-08-27 21:26:42.000000000 +0200
+++ linux-2.5.32_fixup/arch/i386/kernel/time.c	2002-08-27 22:49:50.000000000 +0200
@@ -114,6 +114,9 @@ static inline unsigned long do_fast_gett
 	/* our adjusted time offset in microseconds */
 	return delay_at_last_interrupt + edx;
 }
+#else
+#define do_fast_gettimeoffset() 0
+#endif
 
 #define TICK_SIZE tick
 
@@ -122,8 +125,6 @@ EXPORT_SYMBOL(i8253_lock);
 
 extern spinlock_t i8259A_lock;
 
-#ifndef CONFIG_X86_TSC
-
 /* This function must be called with interrupts disabled 
  * It was inspired by Steve McCanne's microtime-i386 for BSD.  -- jrs
  * 
@@ -254,42 +255,66 @@ static unsigned long do_slow_gettimeoffs
 
 	return count;
 }
-
-static unsigned long (*do_gettimeoffset)(void) = do_slow_gettimeoffset;
-
 #else
-
-#define do_gettimeoffset()	do_fast_gettimeoffset()
-
+#define do_slow_gettimeoffset() 0
 #endif
 
+static inline unsigned long do_gettimeoffset(void)
+{
+	if(likely(cpu_has_tsc))
+		return do_fast_gettimeoffset();
+	else
+		return do_slow_gettimeoffset();
+}
+
 /*
  * This version of gettimeofday has microsecond resolution
  * and better than microsecond precision on fast x86 machines with TSC.
  */
-void do_gettimeofday(struct timeval *tv)
+inline unsigned long long do_gettimeofday64(void)
 {
 	unsigned long flags;
-	unsigned long usec, sec;
+	union
+	{
+		struct
+		{
+			unsigned long usec, sec;
+		} s;
+		unsigned long long val;
+	} u;
 
 	read_lock_irqsave(&xtime_lock, flags);
-	usec = do_gettimeoffset();
+	u.s.usec = do_gettimeoffset();
 	{
 		unsigned long lost = jiffies - wall_jiffies;
 		if (lost)
-			usec += lost * (1000000 / HZ);
+			u.s.usec += lost * (1000000 / HZ);
 	}
-	sec = xtime.tv_sec;
-	usec += xtime.tv_usec;
+	u.s.sec = xtime.tv_sec;
+	u.s.usec += xtime.tv_usec;
 	read_unlock_irqrestore(&xtime_lock, flags);
+	return u.val;
+}
 
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
+void do_gettimeofday(struct timeval *tv)
+{
+	union
+	{
+		struct
+		{
+			unsigned long usec, sec;
+		} s;
+		unsigned long long val;
+	} u;
+	u.val = do_gettimeofday64();
+
+	while (u.s.usec >= 1000000) {
+		u.s.usec -= 1000000;
+		u.s.sec++;
 	}
 
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
+	tv->tv_sec = u.s.sec;
+	tv->tv_usec = u.s.usec;
 }
 
 void do_settimeofday(struct timeval *tv)
@@ -694,9 +719,6 @@ void __init time_init(void)
 			 *	and just enable this for the next intel chips ?
 			 */
 			x86_udelay_tsc = 1;
-#ifndef do_gettimeoffset
-			do_gettimeoffset = do_fast_gettimeoffset;
-#endif
 
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/arch/i386/kernel/traps.c linux-2.5.32_fixup/arch/i386/kernel/traps.c
--- linux-2.5.32/arch/i386/kernel/traps.c	2002-08-27 21:26:36.000000000 +0200
+++ linux-2.5.32_fixup/arch/i386/kernel/traps.c	2002-08-27 22:49:50.000000000 +0200
@@ -311,21 +311,6 @@ static void inline do_trap(int trapnr, i
 	if (vm86 && regs->eflags & VM_MASK)
 		goto vm86_trap;
 
-#ifdef CONFIG_PNPBIOS		
-	if (regs->xcs == 0x60 || regs->xcs == 0x68)
-	{
-		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
-		extern u32 pnp_bios_is_utter_crap;
-		pnp_bios_is_utter_crap = 1;
-		printk(KERN_CRIT "PNPBIOS fault.. attempting recovery.\n");
-		__asm__ volatile(
-			"movl %0, %%esp\n\t"
-			"jmp *%1\n\t"
-			: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
-		panic("do_trap: can't hit this");
-	}
-#endif	
-
 	if (!(regs->xcs & 3))
 		goto kernel_trap;
 
@@ -341,11 +326,39 @@ static void inline do_trap(int trapnr, i
 	}
 
 	kernel_trap: {
-		unsigned long fixup = search_exception_table(regs->eip);
-		if (fixup)
-			regs->eip = fixup;
-		else	
-			die(str, regs, error_code);
+#ifdef CONFIG_PNPBIOS		
+		if (regs->xcs == 0x60 || regs->xcs == 0x68)
+		{
+			extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
+			extern u32 pnp_bios_is_utter_crap;
+			pnp_bios_is_utter_crap = 1;
+
+			/* Fix int3 -> lock done by fixup.c */
+			if((trapnr == 6) && *(u8*)regs->eip == 0xf0)
+				*(u8*)regs->eip = 0x90;
+			
+			printk(KERN_CRIT "PNPBIOS fault.. attempting recovery.\n");
+			__asm__ volatile(
+			"movl %0, %%esp\n\t"
+			"jmp *%1\n\t"
+			: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
+			panic("do_trap: can't hit this");
+		}
+#endif	
+		
+		if(trapnr == 6)
+		{
+			if(!dynamic_fixup_x86_ud((u8**)&regs->eip))
+				die(str, regs, error_code);
+		}
+		else
+		{
+			unsigned long fixup = search_exception_table(regs->eip);
+			if (fixup)
+				regs->eip = fixup;
+			else	
+				die(str, regs, error_code);
+		}
 		return;
 	}
 
@@ -964,6 +977,9 @@ void __init trap_init(void)
 
 	set_system_gate(SYSCALL_VECTOR,&system_call);
 
+	/* already set in head.S
+	   set_trap_gate(DYNAMIC_FIXUP_VECTOR, &__dynamic_fixup_int); */
+	
 	/*
 	 * default LDT is a single-entry callgate to lcall7 for iBCS
 	 * and a callgate to lcall27 for Solaris/x86 binaries
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/include/asm-i386/fixup.h linux-2.5.32_fixup/include/asm-i386/fixup.h
--- linux-2.5.32/include/asm-i386/fixup.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.32_fixup/include/asm-i386/fixup.h	2002-08-27 22:49:50.000000000 +0200
@@ -0,0 +1,41 @@
+#ifndef __ASM_FIXUP_H
+#define __ASM_FIXUP_H
+
+#include <linux/config.h>
+#include <asm/irq_vectors.h>
+
+/* must match movb opcode */
+#define DYNAMIC_FIXUP_INT_SPIN_UNLOCK	  0x88
+#define DYNAMIC_FIXUP_INT_IO_FENCE	  1
+#define DYNAMIC_FIXUP_INT_SFENCE	  2
+
+/* those must match unlockable opcodes and must be valid for int too */
+#define DYNAMIC_FIXUP_INT3_APIC_WRITE	  0x40
+
+#define __asm_byte(x) "\n\t.byte " #x "\n\t"
+#define asm_byte(x) __asm_byte(x)
+
+/* This should be only used for padding or single-byte nops,
+   not for efficient multibyte nops */
+#define asm_nop asm_byte(0x90)
+
+#define dynamic_fixup_int \
+	asm_byte(0xcd) asm_byte(DYNAMIC_FIXUP_VECTOR) 
+
+#ifdef CONFIG_X86_DYNAMIC_FIXUP_INT3
+#define dynamic_fixup_int3 \
+	asm_byte(0xcc)
+#else
+#define dynamic_fixup_int3 dynamic_fixup_int
+#endif
+
+/* void FASTCALL(x86_dynamic_fixup_call(u8* instr));
+   void __dynamic_fixup(void);
+ */
+
+#ifndef __ASSEMBLY__
+#include <asm/types.h>
+int dynamic_fixup_x86_ud(u8** instr);
+#endif
+
+#endif /* __ASM_FIXUP_H */
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/include/asm-i386/irq_vectors.h linux-2.5.32_fixup/include/asm-i386/irq_vectors.h
--- linux-2.5.32/include/asm-i386/irq_vectors.h	2002-08-27 21:26:37.000000000 +0200
+++ linux-2.5.32_fixup/include/asm-i386/irq_vectors.h	2002-08-27 22:49:50.000000000 +0200
@@ -28,6 +28,8 @@
 #define RESCHEDULE_VECTOR	0xfc
 #define CALL_FUNCTION_VECTOR	0xfb
 
+#define DYNAMIC_FIXUP_VECTOR	0xfa
+
 #define THERMAL_APIC_VECTOR	0xf0
 /*
  * Local APIC timer IRQ vector is on a different priority level,
diff --exclude-from=/home/ldb/src/linux-exclude -urNdp linux-2.5.32/init/main.c linux-2.5.32_fixup/init/main.c
--- linux-2.5.32/init/main.c	2002-08-27 21:26:36.000000000 +0200
+++ linux-2.5.32_fixup/init/main.c	2002-08-27 22:49:50.000000000 +0200
@@ -539,6 +539,13 @@ static void do_pre_smp_initcalls(void)
 	migration_init();
 #endif
 	spawn_ksoftirqd();
+
+#ifdef __i386__
+	{
+		extern void dynamic_fixup_start(void);
+		dynamic_fixup_start();
+	}
+#endif	
 }
 
 extern void prepare_namespace(void);


--=-90C1bQUlyo/S/1LH7XbU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9bEZ6djkty3ft5+cRAmYAAJ9EferIF9Ze69oQ7tVvmxLR2raLPACfVuHg
eu3+JVNW7ffwM/RnnxmaCQs=
=2DdC
-----END PGP SIGNATURE-----

--=-90C1bQUlyo/S/1LH7XbU--
