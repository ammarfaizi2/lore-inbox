Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267138AbSLRFRy>; Wed, 18 Dec 2002 00:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267141AbSLRFRy>; Wed, 18 Dec 2002 00:17:54 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:22657 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267138AbSLRFRv>; Wed, 18 Dec 2002 00:17:51 -0500
Message-ID: <3E0006D2.3000907@quark.didntduck.org>
Date: Wed, 18 Dec 2002 00:25:38 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@suse.de>, mingo@elte.hu, linux-kernel@vger.kernel.org,
       davej@suse.de
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212170850250.2702-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212170850250.2702-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------050407040806040205010201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050407040806040205010201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On 17 Dec 2002, Andi Kleen wrote:
> 
>>Linus Torvalds <torvalds@transmeta.com> writes:
>>
>>>That NMI problem is pretty fundamentally unfixable due to the stupid
>>>sysenter semantics, but we could just make the NMI handlers be real
>>>careful about it and fix it up if it happens.
>>
>>You just have to make the NMI a task gate with an own TSS, then the
>>microcode will set up an own stack for you.
> 
> 
> Actually, I came up with a much simpler solution (which I didn't yet
> implement, but should be just a few lines).
> 
> The simpler solution is to just make the temporary ESP stack _look_ like
> it's a real process - ie make it 8kB per CPU (instead of the current 4kB)
> and put a fake "thread_info" at the bottom of it with the right CPU
> number etc. That way if an NMI comes in (in the _extremely_ tiny window),
> it will still see a sane picture of the system. It will basically think
> that we had a micro-task-switch between two instructions.
> 
> It's also entirely possible that the NMI window may not actually even
> exist, since I'm not even sure that Intel checks for pending interrupt
> before the first instruction of a trap handler.

How about this patch?  Instead of making a per-cpu trampoline, write to 
the msr during each context switch.  This means that the stack pointer 
is valid at all times, and also saves memory and a cache line bounce.  I 
also included some misc cleanups.

Tested on an Athlon XP.
sysenter: 158.854423 cycles
int80:    273.658134 cycles

--
				Brian Gerst

--------------050407040806040205010201
Content-Type: text/plain;
 name="sysenter-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sysenter-1"

diff -urN linux-2.5.52-bk2/arch/i386/kernel/cpu/common.c linux/arch/i386/kernel/cpu/common.c
--- linux-2.5.52-bk2/arch/i386/kernel/cpu/common.c	Sat Dec 14 12:32:00 2002
+++ linux/arch/i386/kernel/cpu/common.c	Tue Dec 17 23:21:55 2002
@@ -487,7 +487,7 @@
 		BUG();
 	enter_lazy_tlb(&init_mm, current, cpu);
 
-	t->esp0 = thread->esp0;
+	load_esp0(t, thread->esp0);
 	set_tss_desc(cpu,t);
 	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
diff -urN linux-2.5.52-bk2/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
--- linux-2.5.52-bk2/arch/i386/kernel/process.c	Sat Dec 14 12:32:04 2002
+++ linux/arch/i386/kernel/process.c	Tue Dec 17 23:29:54 2002
@@ -440,7 +440,7 @@
 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
-	tss->esp0 = next->esp0;
+	load_esp0(tss, next->esp0);
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
diff -urN linux-2.5.52-bk2/arch/i386/kernel/sysenter.c linux/arch/i386/kernel/sysenter.c
--- linux-2.5.52-bk2/arch/i386/kernel/sysenter.c	Tue Dec 17 23:21:45 2002
+++ linux/arch/i386/kernel/sysenter.c	Tue Dec 17 23:31:01 2002
@@ -20,22 +20,12 @@
 
 static void __init enable_sep_cpu(void *info)
 {
-	unsigned long page = __get_free_page(GFP_ATOMIC);
 	int cpu = get_cpu();
-	unsigned long *esp0_ptr = &(init_tss + cpu)->esp0;
-	unsigned long rel32;
+	struct tss_struct *tss = init_tss + cpu;
 
-	rel32 = (unsigned long) sysenter_entry - (page+11);
-
-	
-	*(short *) (page+0) = 0x258b;		/* movl xxxxx,%esp */
-	*(long **) (page+2) = esp0_ptr;
-	*(char *)  (page+6) = 0xe9;		/* jmp rl32 */
-	*(long *)  (page+7) = rel32;
-
-	wrmsr(0x174, __KERNEL_CS, 0);		/* SYSENTER_CS_MSR */
-	wrmsr(0x175, page+PAGE_SIZE, 0);	/* SYSENTER_ESP_MSR */
-	wrmsr(0x176, page, 0);			/* SYSENTER_EIP_MSR */
+	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
+	wrmsr(MSR_IA32_SYSENTER_ESP, tss->esp0, 0);
+	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long) sysenter_entry, 0);
 
 	printk("Enabling SEP on CPU %d\n", cpu);
 	put_cpu();	
@@ -60,14 +50,15 @@
 	};
 	unsigned long page = get_zeroed_page(GFP_ATOMIC);
 
+	if (cpu_has_sep) {
+		memcpy((void *) page, sysent, sizeof(sysent));
+		enable_sep_cpu(NULL);
+		smp_call_function(enable_sep_cpu, NULL, 1, 1);
+	} else
+		memcpy((void *) page, int80, sizeof(int80));
+
 	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY);
-	memcpy((void *) page, int80, sizeof(int80));
-	if (!boot_cpu_has(X86_FEATURE_SEP))
-		return 0;
-
-	memcpy((void *) page, sysent, sizeof(sysent));
-	enable_sep_cpu(NULL);
-	smp_call_function(enable_sep_cpu, NULL, 1, 1);
+
 	return 0;
 }
 
diff -urN linux-2.5.52-bk2/arch/i386/kernel/vm86.c linux/arch/i386/kernel/vm86.c
--- linux-2.5.52-bk2/arch/i386/kernel/vm86.c	Sat Dec 14 12:32:02 2002
+++ linux/arch/i386/kernel/vm86.c	Tue Dec 17 23:21:55 2002
@@ -113,7 +113,7 @@
 		do_exit(SIGSEGV);
 	}
 	tss = init_tss + smp_processor_id();
-	tss->esp0 = current->thread.esp0 = current->thread.saved_esp0;
+	load_esp0(tss, current->thread.saved_esp0);
 	current->thread.saved_esp0 = 0;
 	ret = KVM86->regs32;
 	return ret;
@@ -283,7 +283,8 @@
 	info->regs32->eax = 0;
 	tsk->thread.saved_esp0 = tsk->thread.esp0;
 	tss = init_tss + smp_processor_id();
-	tss->esp0 = tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
+	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
+	load_esp0(tss, tsk->thread.esp0);
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
diff -urN linux-2.5.52-bk2/include/asm-i386/cpufeature.h linux/include/asm-i386/cpufeature.h
--- linux-2.5.52-bk2/include/asm-i386/cpufeature.h	Sun Sep 15 22:18:22 2002
+++ linux/include/asm-i386/cpufeature.h	Tue Dec 17 23:29:27 2002
@@ -7,6 +7,8 @@
 #ifndef __ASM_I386_CPUFEATURE_H
 #define __ASM_I386_CPUFEATURE_H
 
+#include <linux/bitops.h>
+
 #define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
 
 /* Intel-defined CPU features, CPUID level 0x00000001, word 0 */
@@ -74,6 +76,7 @@
 #define cpu_has_pae		boot_cpu_has(X86_FEATURE_PAE)
 #define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
 #define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
+#define cpu_has_sep		boot_cpu_has(X86_FEATURE_SEP)
 #define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
 #define cpu_has_mmx		boot_cpu_has(X86_FEATURE_MMX)
 #define cpu_has_fxsr		boot_cpu_has(X86_FEATURE_FXSR)
diff -urN linux-2.5.52-bk2/include/asm-i386/msr.h linux/include/asm-i386/msr.h
--- linux-2.5.52-bk2/include/asm-i386/msr.h	Sat Dec 14 12:32:05 2002
+++ linux/include/asm-i386/msr.h	Tue Dec 17 23:21:55 2002
@@ -53,6 +53,10 @@
 
 #define MSR_IA32_BBL_CR_CTL		0x119
 
+#define MSR_IA32_SYSENTER_CS		0x174
+#define MSR_IA32_SYSENTER_ESP		0x175
+#define MSR_IA32_SYSENTER_EIP		0x176
+
 #define MSR_IA32_MCG_CAP		0x179
 #define MSR_IA32_MCG_STATUS		0x17a
 #define MSR_IA32_MCG_CTL		0x17b
diff -urN linux-2.5.52-bk2/include/asm-i386/processor.h linux/include/asm-i386/processor.h
--- linux-2.5.52-bk2/include/asm-i386/processor.h	Sat Dec 14 12:32:08 2002
+++ linux/include/asm-i386/processor.h	Tue Dec 17 23:26:16 2002
@@ -14,6 +14,7 @@
 #include <asm/types.h>
 #include <asm/sigcontext.h>
 #include <asm/cpufeature.h>
+#include <asm/msr.h>
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -416,6 +417,13 @@
 	{~0, } /* ioperm */					\
 }
 
+static inline void load_esp0(struct tss_struct *tss, unsigned long esp0)
+{
+	tss->esp0 = esp0;
+	if (cpu_has_sep)
+		wrmsr(MSR_IA32_SYSENTER_ESP, esp0, 0);
+}
+
 #define start_thread(regs, new_eip, new_esp) do {		\
 	__asm__("movl %0,%%fs ; movl %0,%%gs": :"r" (0));	\
 	set_fs(USER_DS);					\

--------------050407040806040205010201--

