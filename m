Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264016AbTI2Rvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTI2Ru1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:50:27 -0400
Received: from colin2.muc.de ([193.149.48.15]:53009 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263969AbTI2RtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:49:00 -0400
Date: 29 Sep 2003 19:49:11 +0200
Date: Mon, 29 Sep 2003 19:49:10 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Message-ID: <20030929174910.GA90905@colin2.muc.de>
References: <20030929125629.GA1746@averell> <20030929170323.GC21798@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929170323.GC21798@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not 100% sure, but I see some possible dangerous race conditions.

Thanks for the review.
> 
>   1. Userspace thread A has a page fault at CS:EIP == 0x000f:0xbffff000.
> 
>      Simultaneously, userspace thread B calls modify_ldt() to change
>      the LDT descriptor base to 0x40000000.
> 
>      The LDT descriptor is changed after A enters the page fault
>      handler, but before it takes mmap_sem.  This can happen on SMP or
>      on a pre-empt kernel.
> 
>      __is_prefetch() calls __get_user(0xfffff000), or whatever
>      address userspace wants to trick it into reading.
> 
>      Result: unpriveleged userspace causes an MMIO read and crashes
>      the system, or worse.


Ok, I added access_ok() checks when the fault came from ring 3 code.

That should catch everything.

I guess they should be added to the AMD64 version too. It ignores
all bases, but I'm not sure if the CPU catches the case where the linear
address computation wraps.

> 
>   2. segment_base sets "desc = (u32 *)&cpu_gdt_table[smp_processor_id()]".
> 
>      Pre-empt switches CPU.

True. Fixed.

> 
>      desc now points to the _old_ CPU, where the GDT for this task is
>      no longer valid, and that is read in the next few lines.
> 
> I think for completeness you should check the segment type and limit
> too (because they can be changed, see 1.).  These are easier to check
> than they look (w.r.t. 16 bit segments etc.): you don't have to decode
> the descriptor; just use the "lar" and "lsl" instructions.

I don't want to do that, the code is already too complicated and I don't
plan to reimplement an x86 here (just dealing with this segmentation
horror is bad enough) 

If it gets any more complicated I would be inclined to just
handle the in kernel prefetches using __ex_table entries and give up
on user space.

The x86-64 version just ignores all bases, that should be fine
too. Anybody who uses non zero code segments likely doesn't care about
performance and won't use prefetch ;-)

-Andi

New patch with the fixes attached:

Linus, can you consider merging it?

------------------

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


diff -u linux-2.6.0test6-work/include/asm-i386/processor.h-PRE linux-2.6.0test6-work/include/asm-i386/processor.h
--- linux-2.6.0test6-work/include/asm-i386/processor.h-PRE	2003-09-11 04:12:39.000000000 +0200
+++ linux-2.6.0test6-work/include/asm-i386/processor.h	2003-09-28 10:52:55.000000000 +0200
@@ -578,8 +589,6 @@
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
 {
-	if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
-		return;		/* Some athlons fault if the address is bad */
 	alternative_input(ASM_NOP4,
 			  "prefetchnta (%1)",
 			  X86_FEATURE_XMM,
diff -u linux-2.6.0test6-work/arch/i386/mm/fault.c-PRE linux-2.6.0test6-work/arch/i386/mm/fault.c
--- linux-2.6.0test6-work/arch/i386/mm/fault.c-PRE	2003-05-27 03:00:20.000000000 +0200
+++ linux-2.6.0test6-work/arch/i386/mm/fault.c	2003-09-29 19:42:44.000000000 +0200
@@ -55,6 +55,108 @@
 	console_loglevel = loglevel_save;
 }
 
+/* 
+ * Find an segment base in the LDT/GDT.
+ * Don't need to do any boundary checking because the CPU did that already 
+ * when the instruction was executed 
+ */
+static unsigned long segment_base(unsigned seg) 
+{ 
+	u32 *desc;
+	/* 
+	 * No need to use get/put_cpu here because when we switch CPUs the
+	 * segment base is always switched too.
+	 */
+	if (seg & (1<<2))
+		desc = current->mm->context.ldt;
+	else
+		desc = (u32 *)&cpu_gdt_table[smp_processor_id()];
+	desc = (void *)desc + (seg & ~7); 	
+	return  (desc[0] >> 16) | 
+	       ((desc[1] & 0xFF) << 16) | 
+	        (desc[1] & 0xFF000000);
+}  
+
+/* 
+ * Sometimes AMD Athlon/Opteron CPUs report invalid exceptions on prefetch.
+ * Check that here and ignore it.
+ */
+static int __is_prefetch(struct pt_regs *regs, unsigned long addr)
+{ 
+	unsigned char *instr = (unsigned char *)(regs->eip);
+	int scan_more = 1;
+	int prefetch = 0; 
+	int i;
+
+	/* 
+	 * Avoid recursive faults. This catches the kernel jumping to nirvana.
+	 * More complicated races with unmapped EIP are handled elsewhere for 
+	 * user space.
+	 */
+	if (regs->eip == addr)
+		return 0; 
+
+	if (unlikely(regs->eflags & VM_MASK))
+		addr += regs->xcs << 4; 
+	else if (unlikely(regs->xcs != __USER_CS &&regs->xcs != __KERNEL_CS))
+		addr += segment_base(regs->xcs);
+
+	for (i = 0; scan_more && i < 15; i++) { 
+		unsigned char opcode;
+		unsigned char instr_hi;
+		unsigned char instr_lo;
+
+		if ((regs->xcs & 3) && !access_ok(VERIFY_READ, instr, 1))
+			break;
+		if (__get_user(opcode, instr))
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
+			if ((regs->xcs & 3) && !access_ok(VERIFY_READ, instr, 1))
+				break;
+			if (__get_user(opcode, instr)) 
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
+	if (likely(boot_cpu_data.x86_vendor != X86_VENDOR_AMD ||
+		   boot_cpu_data.x86 < 6))
+		return 0;
+	return __is_prefetch(regs, addr); 
+} 
+
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
 
 /*
@@ -110,7 +212,7 @@
 	 * atomic region then we must not take the fault..
 	 */
 	if (in_atomic() || !mm)
-		goto no_context;
+		goto bad_area_nosemaphore;
 
 	down_read(&mm->mmap_sem);
 
@@ -198,8 +300,16 @@
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
@@ -232,6 +342,14 @@
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
@@ -286,10 +404,14 @@
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
@@ -298,10 +420,6 @@
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void *)address;
 	force_sig_info(SIGBUS, &info, tsk);
-
-	/* Kernel mode? Handle exceptions or die */
-	if (!(error_code & 4))
-		goto no_context;
 	return;
 
 vmalloc_fault:



