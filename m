Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbTI3Hiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 03:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbTI3Hip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 03:38:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:38021 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261180AbTI3Hi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 03:38:29 -0400
Date: Tue, 30 Sep 2003 08:38:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20030930073814.GA26649@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This builds upon Andi Kleen's excellent patch for the AMD prefetch bug
workaround.  It is applies to 2.6.0-test6.

There are four changes on top of Andi's recent patch:

   1. The workaround code is only included when compiling a kernel
      optimised for AMD processors with the bug.  For kernels optimised
      for a different processor, there is no code size overhead.

      This will make some people happier.

      It will make some people unhappier, because it means a generic
      kernel on an AMD will run fine, but won't fixup _userspace_
      prefetch faults.  More on this below.

   2. Nevertheless, when a kernel _not_ optimised for those AMD processors
      is run on one, the "alternative" mechanism now correctly replaces
      prefetch instructions with nops.

   3. The is_prefetch() instruction decoder now handles all cases of
      funny GDT and LDT segments, checks limits and so on.  As far as I
      can see, there are no further bugs or flaws in that part.

   4. A consequence of the is_prefetch() change is that, despite the
      longer C code (rarely used code, for segments), is_prefetch()
      should run marginally faster now because the access_ok() calls are
      not required.  They're subsumed into the segment limit
      calculation.
 
Like Andi's patch, this removes 10k or so from current x86 kernels by
removing the silly conditional from the prefetch() function.

Controversial point coming up!

It's a reasonable argument that if a kernel version, say 2.6.0, promises
to hide the errata from _userspace_ programs, then the generic or
not-AMD-optimised kernels should do that too.  Otherwise userspace may
as well provide the workaround itself, by catching SIGSEGV - because it
is perfectly normal and common to run a generic kernel on an AMD.

If userspace has to do that, then there's no point in the kernel having
the fixup at all - it may as well use __ex_table entries for the
kernel-space prefetch instructions, and give up on hiding the processor
bug from userspace.  That would be much simpler than any of the patches
so far.

Arguably the bug has been around for years already (all K7's), so the
rare userspace programs which use prefetch should be aware of this already.

Something to think about.

Here is Andi's comment from the patch this is derived from:

  Here is a new version of the Athlon/Opteron prefetch issue workaround
  for 2.6.0test6.  The issue was hit regularly by the 2.6 kernel
  while doing prefetches on NULL terminated hlists.

  These CPUs sometimes generate illegal exception for prefetch
  instructions. The operating system can work around this by checking
  if the faulting instruction is a prefetch and ignoring it when
  it's the case.

  The code is structured carefully to ensure that the page fault
  will never recurse more than once. Also unmapped EIPs are special
  cased to give more friendly oopses when the kernel jumps to
  unmapped addresses.

  It removes the previous dumb in kernel workaround for this and shrinks the
  kernel by >10k.

  Small behaviour change is that a SIGBUS fault for a *_user access will
  cause an EFAULT now, no SIGBUS.


I'm running this now, on my dual AMD Athlon, and it's working fine.  (It
works when I comment out the fast path and force the full segment check,
before you ask ;)

Enjoy,
-- Jamie

diff -urN --exclude-from=dontdiff orig-2.6.0-test6/arch/i386/Kconfig dual-2.6.0-test6/arch/i386/Kconfig
--- orig-2.6.0-test6/arch/i386/Kconfig	2003-09-30 05:39:33.467103692 +0100
+++ dual-2.6.0-test6/arch/i386/Kconfig	2003-09-30 06:05:19.868623767 +0100
@@ -397,6 +397,12 @@
 	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6
 	default y
 
+config X86_PREFETCH_FIXUP
+	bool
+	depends on MK7 || MK8
+	default y
+
+
 config HPET_TIMER
 	bool "HPET Timer Support"
 	help
diff -urN --exclude-from=dontdiff orig-2.6.0-test6/arch/i386/kernel/cpu/common.c dual-2.6.0-test6/arch/i386/kernel/cpu/common.c
--- orig-2.6.0-test6/arch/i386/kernel/cpu/common.c	2003-09-30 05:39:33.871035696 +0100
+++ dual-2.6.0-test6/arch/i386/kernel/cpu/common.c	2003-09-30 06:03:46.222851345 +0100
@@ -327,6 +327,17 @@
 	 * we do "generic changes."
 	 */
 
+	/* Prefetch works ok? */
+#ifndef CONFIG_X86_PREFETCH_FIXUP
+	if (c->x86_vendor != X86_VENDOR_AMD || c->x86 < 6)
+#endif
+	{
+		if (cpu_has(c, X86_FEATURE_XMM))
+			set_bit(X86_FEATURE_XMM_PREFETCH, c->x86_capability);
+		if (cpu_has(c, X86_FEATURE_3DNOW))
+			set_bit(X86_FEATURE_3DNOW_PREFETCH, c->x86_capability);
+	}
+
 	/* TSC disabled? */
 	if ( tsc_disable )
 		clear_bit(X86_FEATURE_TSC, c->x86_capability);
diff -urN --exclude-from=dontdiff orig-2.6.0-test6/arch/i386/mm/fault.c dual-2.6.0-test6/arch/i386/mm/fault.c
--- orig-2.6.0-test6/arch/i386/mm/fault.c	2003-07-08 21:31:09.000000000 +0100
+++ dual-2.6.0-test6/arch/i386/mm/fault.c	2003-09-30 06:03:46.284839268 +0100
@@ -55,6 +55,157 @@
 	console_loglevel = loglevel_save;
 }
 
+#ifdef CONFIG_X86_PREFETCH_FIXUP
+/*
+ * Return EIP plus the CS segment base.  The segment limit is also
+ * adjusted, clamped to the kernel/user address space (whichever is
+ * appropriate), and returned in *eip_limit.
+ *
+ * The segment is checked, because it might have been changed by another
+ * task between the original faulting instruction and here.
+ *
+ * If CS is no longer a valid code segment, or if EIP is beyond the
+ * limit, or if it is a kernel address when CS is not a kernel segment,
+ * then the returned value will be greater than *eip_limit.
+ */
+static inline unsigned long get_segment_eip(struct pt_regs *regs,
+					    unsigned long *eip_limit)
+{
+	unsigned long eip = regs->eip;
+	unsigned seg = regs->xcs & 0xffff;
+	u32 seg_ar, seg_limit, base, *desc;
+
+	/* The standard kernel/user address space limit. */
+	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
+
+	/* Unlikely, but must come before segment checks. */
+	if (unlikely((regs->eflags & VM_MASK) != 0))
+		return eip + (seg << 4);
+	
+	/* By far the commonest cases. */
+	if (likely(seg == __USER_CS || seg == __KERNEL_CS))
+		return eip;
+
+	/* Check the segment exists, is within the current LDT/GDT size,
+	   that kernel/user (ring 0..3) has the appropriate privelege,
+	   that it's a code segment, and get the limit. */
+	__asm__ ("larl %3,%0; lsll %3,%1"
+		 : "=&r" (seg_ar), "=r" (seg_limit) : "0" (0), "rm" (seg));
+	if ((~seg_ar & 0x9800) || eip > seg_limit) {
+		*eip_limit = 0;
+		return 1;	 /* So that returned eip > *eip_limit. */
+	}
+
+	/* Get the GDT/LDT descriptor base. */
+	if (seg & (1<<2)) {
+		/* Must lock the LDT while reading it. */
+		down(&current->mm->context.sem);
+		desc = current->mm->context.ldt;
+	} else {
+		/* Must disable preemption while reading the GDT. */
+		desc = (u32 *)&cpu_gdt_table[get_cpu()];
+	}
+	desc = (void *)desc + (seg & ~7);
+	base = (desc[0] >> 16) |
+		((desc[1] & 0xff) << 16) |
+		(desc[1] & 0xff000000);
+	if (seg & (1<<2))
+		up(&current->mm->context.sem);
+	else
+		put_cpu();
+
+	/* Adjust EIP and segment limit, and clamp at the kernel limit.
+	   It's legitimate for segments to wrap at 0xffffffff. */
+	seg_limit += base;
+	if (seg_limit < *eip_limit && seg_limit >= base)
+		*eip_limit = seg_limit;
+	return eip + base;
+}
+
+/* 
+ * Sometimes AMD Athlon/Opteron CPUs report invalid exceptions on prefetch.
+ * Check that here and ignore it.
+ */
+static int __is_prefetch(struct pt_regs *regs, unsigned long addr)
+{ 
+	unsigned long limit;
+	unsigned long instr = get_segment_eip (regs, &limit);
+	int scan_more = 1;
+	int prefetch = 0; 
+	int i;
+
+	/* 
+	 * Avoid recursive faults. This catches the kernel jumping to nirvana.
+	 * More complicated races with unmapped EIP are handled elsewhere for 
+	 * user space.
+	 */
+	if (instr == addr)
+		return 0; 
+
+	for (i = 0; scan_more && i < 15; i++) { 
+		unsigned char opcode;
+		unsigned char instr_hi;
+		unsigned char instr_lo;
+
+		if (instr > limit)
+			break;
+		if (__get_user(opcode, (unsigned char *) instr))
+			break; 
+
+		instr_hi = opcode & 0xf0; 
+		instr_lo = opcode & 0x0f; 
+		instr++;
+
+		switch (instr_hi) { 
+		case 0x20:
+		case 0x30:
+			/* Values 0x26,0x2E,0x36,0x3E are valid x86 prefixes. */
+			scan_more = ((instr_lo & 7) == 0x6);
+			break;
+			
+		case 0x60:
+			/* 0x64 thru 0x67 are valid prefixes in all modes. */
+			scan_more = (instr_lo & 0xC) == 0x4;
+			break;		
+		case 0xF0:
+			/* 0xF0, 0xF2, and 0xF3 are valid prefixes in all modes. */
+			scan_more = !instr_lo || (instr_lo>>1) == 1;
+			break;			
+		case 0x00:
+			/* Prefetch instruction is 0x0F0D or 0x0F18 */
+			scan_more = 0;
+			if (instr > limit)
+				break;
+			if (__get_user(opcode, (unsigned char *) instr)) 
+				break;
+			prefetch = (instr_lo == 0xF) &&
+				(opcode == 0x0D || opcode == 0x18);
+			break;			
+		default:
+			scan_more = 0;
+			break;
+		} 
+	}
+
+	return prefetch;
+}
+
+static inline int is_prefetch(struct pt_regs *regs, unsigned long addr)
+{
+	/* This code is included only when optimising for AMD, so we
+	   may as well bias in favour of it. */
+	if (likely(boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
+		   boot_cpu_data.x86 >= 6))
+		return __is_prefetch(regs, addr);
+	return 0;
+} 
+
+#else /* CONFIG_X86_PREFETCH_FIXUP */
+
+#define is_prefetch(regs, addr)	(0)
+
+#endif
+
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 
 /*
@@ -110,7 +261,7 @@
 	 * atomic region then we must not take the fault..
 	 */
 	if (in_atomic() || !mm)
-		goto no_context;
+		goto bad_area_nosemaphore;
 
 	down_read(&mm->mmap_sem);
 
@@ -198,8 +349,16 @@
 bad_area:
 	up_read(&mm->mmap_sem);
 
+bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
+		/* 
+		 * Valid to do another page fault here because this one came 
+		 * from user space.
+		 */
+		if (is_prefetch(regs, address))
+			return;
+
 		tsk->thread.cr2 = address;
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_no = 14;
@@ -232,6 +391,14 @@
 	if (fixup_exception(regs))
 		return;
 
+	/* 
+	 * Valid to do another page fault here, because if this fault
+	 * had been triggered by is_prefetch fixup_exception would have 
+	 * handled it.
+	 */
+ 	if (is_prefetch(regs, address))
+ 		return;
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
@@ -286,10 +453,14 @@
 do_sigbus:
 	up_read(&mm->mmap_sem);
 
-	/*
-	 * Send a sigbus, regardless of whether we were in kernel
-	 * or user mode.
-	 */
+	/* Kernel mode? Handle exceptions or die */
+	if (!(error_code & 4))
+		goto no_context;
+
+	/* User space => ok to do another page fault */
+	if (is_prefetch(regs, address))
+		return;
+
 	tsk->thread.cr2 = address;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = 14;
@@ -298,10 +469,6 @@
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *)address;
 	force_sig_info(SIGBUS, &info, tsk);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!(error_code & 4))
-		goto no_context;
 	return;
 
 vmalloc_fault:
diff -urN --exclude-from=dontdiff orig-2.6.0-test6/include/asm-i386/cpufeature.h dual-2.6.0-test6/include/asm-i386/cpufeature.h
--- orig-2.6.0-test6/include/asm-i386/cpufeature.h	2003-09-30 05:41:04.520720265 +0100
+++ dual-2.6.0-test6/include/asm-i386/cpufeature.h	2003-09-30 06:03:46.302835762 +0100
@@ -68,6 +68,9 @@
 #define X86_FEATURE_K7		(3*32+ 5) /* Athlon */
 #define X86_FEATURE_P3		(3*32+ 6) /* P3 */
 #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
+/* Prefetch insns without AMD spurious faults, or with fixup for them. */
+#define X86_FEATURE_XMM_PREFETCH	(3*32+ 8) /* SSE */
+#define X86_FEATURE_3DNOW_PREFETCH	(3*32+ 9) /* 3DNow! */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
diff -urN --exclude-from=dontdiff orig-2.6.0-test6/include/asm-i386/processor.h dual-2.6.0-test6/include/asm-i386/processor.h
--- orig-2.6.0-test6/include/asm-i386/processor.h	2003-09-30 05:41:04.861655987 +0100
+++ dual-2.6.0-test6/include/asm-i386/processor.h	2003-09-30 06:03:46.334829529 +0100
@@ -589,11 +589,9 @@
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
 {
-	if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
-		return;		/* Some athlons fault if the address is bad */
 	alternative_input(ASM_NOP4,
 			  "prefetchnta (%1)",
-			  X86_FEATURE_XMM,
+			  X86_FEATURE_XMM_PREFETCH,
 			  "r" (x));
 }
 
@@ -607,7 +605,7 @@
 {
 	alternative_input(ASM_NOP4,
 			  "prefetchw (%1)",
-			  X86_FEATURE_3DNOW,
+			  X86_FEATURE_3DNOW_PREFETCH,
 			  "r" (x));
 }
 #define spin_lock_prefetch(x)	prefetchw(x)
