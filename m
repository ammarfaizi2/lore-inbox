Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbTAEAwn>; Sat, 4 Jan 2003 19:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbTAEAwn>; Sat, 4 Jan 2003 19:52:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:5328 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262296AbTAEAwj>;
	Sat, 4 Jan 2003 19:52:39 -0500
Message-ID: <3E1783D0.5A47A299@digeo.com>
Date: Sat, 04 Jan 2003 17:01:04 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>
CC: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
References: <94F20261551DC141B6B559DC4910867204491F@blr-m3-msg.wipro.com.suse.lists.linux.kernel> <3E155903.F8C22286@digeo.com.suse.lists.linux.kernel> <p734r8qnkkp.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jan 2003 01:01:05.0891 (UTC) FILETIME=[ECDCD330:01C2B455]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> P.S.: regarding recent lmbench slow downs: I'm a bit
> worried about the two wrmsrs which are in the i386 context switch
> in load_esp0 for sysenter now. Last time I benchmarked WRMSRs on
> Athlon they were really slow and knowing the P4 it is probably
> even slower there. Imho it would be better to undo that patch
> and use Linus' original trampoline stack.
> 

Looks like you're right.  The indications are that this change
has slowed context switches by ~5% on a PIII.   The backout patch
against 2.5.54 is below.  Testing on a P4 would be useful.

2.5.54, stock:

lmbench:

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
i686-linu  Linux 2.5.54    3     16     44    18     47      20      77

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
i686-linu  Linux 2.5.54     3    16   26    65          78        231

AIM9:

     3 tcp_test            10.00       2767  276.70000        24903.00 TCP/IP Messages/second
     4 udp_test            10.00       4658  465.80000        46580.00 UDP/IP DataGrams/second
     5 fifo_test           10.01       6507  650.04995        65005.00 FIFO Messages/second
     6 dgram_pipe          10.00      11228 1122.80000       112280.00 DataGram Pipe Messages/second
     7 pipe_cpy            10.00      15463 1546.30000       154630.00 Pipe Messages/second

pollbench:
pollbench 1 100 5000
  result with handles 1 processes 100 loops 5000:time  9.609487 sec.
pollbench 2 100 2000
  result with handles 2 processes 100 loops 2000:time  4.016496 sec.
pollbench 5 100 2000
  result with handles 5 processes 100 loops 2000:time  4.917921 sec.


2.5.54, with the below backout patch:

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
i686-linu  Linux 2.5.54    3     14     47    18     50      20      61

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
i686-linu  Linux 2.5.54     3    15   25    64          69        231


     3 tcp_test            10.00       2908  290.80000        26172.00 TCP/IP Messages/second
     4 udp_test            10.00       4971  497.10000        49710.00 UDP/IP DataGrams/second
     5 fifo_test           10.01       6642  663.53646        66353.65 FIFO Messages/second
     6 dgram_pipe          10.00      11516 1151.60000       115160.00 DataGram Pipe Messages/second
     7 pipe_cpy            10.00      15930 1593.00000       159300.00 Pipe Messages/second


pollbench 1 100 5000
  result with handles 1 processes 100 loops 5000:time  9.106732 sec.
pollbench 2 100 2000
  result with handles 2 processes 100 loops 2000:time  3.853814 sec.
pollbench 5 100 2000
  result with handles 5 processes 100 loops 2000:time  4.533519 sec.



 arch/i386/kernel/cpu/common.c |    2 +-
 arch/i386/kernel/process.c    |    2 +-
 arch/i386/kernel/sysenter.c   |   34 ++++++++++++++++++++++++++++++----
 arch/i386/kernel/vm86.c       |    4 +---
 include/asm-i386/cpufeature.h |    3 ---
 include/asm-i386/msr.h        |    4 ----
 include/asm-i386/processor.h  |   16 ----------------
 7 files changed, 33 insertions(+), 32 deletions(-)

--- 25/arch/i386/kernel/cpu/common.c~bad3	Fri Jan  3 16:36:48 2003
+++ 25-akpm/arch/i386/kernel/cpu/common.c	Fri Jan  3 16:36:48 2003
@@ -484,7 +484,7 @@ void __init cpu_init (void)
 		BUG();
 	enter_lazy_tlb(&init_mm, current, cpu);
 
-	load_esp0(t, thread->esp0);
+	t->esp0 = thread->esp0;
 	set_tss_desc(cpu,t);
 	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
--- 25/arch/i386/kernel/process.c~bad3	Fri Jan  3 16:36:48 2003
+++ 25-akpm/arch/i386/kernel/process.c	Fri Jan  3 16:36:48 2003
@@ -437,7 +437,7 @@ void __switch_to(struct task_struct *pre
 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
-	load_esp0(tss, next->esp0);
+	tss->esp0 = next->esp0;
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
--- 25/arch/i386/kernel/sysenter.c~bad3	Fri Jan  3 16:36:48 2003
+++ 25-akpm/arch/i386/kernel/sysenter.c	Fri Jan  3 16:36:48 2003
@@ -34,14 +34,40 @@ struct fake_sep_struct {
 	unsigned char stack[0];
 } __attribute__((aligned(8192)));
 	
+static struct fake_sep_struct *alloc_sep_thread(int cpu)
+{
+	struct fake_sep_struct *entry;
+
+	entry = (struct fake_sep_struct *) __get_free_pages(GFP_ATOMIC, 1);
+	if (!entry)
+		return NULL;
+
+	memset(entry, 0, PAGE_SIZE<<1);
+	entry->thread.task = &entry->task;
+	entry->task.thread_info = &entry->thread;
+	entry->thread.preempt_count = 1;
+	entry->thread.cpu = cpu;	
+
+	return entry;
+}
+
 static void __init enable_sep_cpu(void *info)
 {
 	int cpu = get_cpu();
-	struct tss_struct *tss = init_tss + cpu;
+	struct fake_sep_struct *sep = alloc_sep_thread(cpu);
+	unsigned long *esp0_ptr = &(init_tss + cpu)->esp0;
+	unsigned long rel32;
+
+	rel32 = (unsigned long) sysenter_entry - (unsigned long) (sep->trampoline+11);
+	
+	*(short *) (sep->trampoline+0) = 0x258b;		/* movl xxxxx,%esp */
+	*(long **) (sep->trampoline+2) = esp0_ptr;
+	*(char *)  (sep->trampoline+6) = 0xe9;			/* jmp rl32 */
+	*(long *)  (sep->trampoline+7) = rel32;
 
-	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
-	wrmsr(MSR_IA32_SYSENTER_ESP, tss->esp0, 0);
-	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long) sysenter_entry, 0);
+	wrmsr(0x174, __KERNEL_CS, 0);				/* SYSENTER_CS_MSR */
+	wrmsr(0x175, PAGE_SIZE*2 + (unsigned long) sep, 0);	/* SYSENTER_ESP_MSR */
+	wrmsr(0x176, (unsigned long) &sep->trampoline, 0);	/* SYSENTER_EIP_MSR */
 
 	printk("Enabling SEP on CPU %d\n", cpu);
 	put_cpu();	
--- 25/arch/i386/kernel/vm86.c~bad3	Fri Jan  3 16:36:48 2003
+++ 25-akpm/arch/i386/kernel/vm86.c	Fri Jan  3 16:36:48 2003
@@ -113,8 +113,7 @@ struct pt_regs * save_v86_state(struct k
 		do_exit(SIGSEGV);
 	}
 	tss = init_tss + smp_processor_id();
-	current->thread.esp0 = current->thread.saved_esp0;
-	load_esp0(tss, current->thread.esp0);
+	tss->esp0 = current->thread.esp0 = current->thread.saved_esp0;
 	current->thread.saved_esp0 = 0;
 	loadsegment(fs, current->thread.saved_fs);
 	loadsegment(gs, current->thread.saved_gs);
@@ -290,7 +289,6 @@ static void do_sys_vm86(struct kernel_vm
 
 	tss = init_tss + smp_processor_id();
 	tss->esp0 = tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
-	disable_sysenter();
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)
--- 25/include/asm-i386/cpufeature.h~bad3	Fri Jan  3 16:36:48 2003
+++ 25-akpm/include/asm-i386/cpufeature.h	Fri Jan  3 16:36:48 2003
@@ -7,8 +7,6 @@
 #ifndef __ASM_I386_CPUFEATURE_H
 #define __ASM_I386_CPUFEATURE_H
 
-#include <linux/bitops.h>
-
 #define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
 
 /* Intel-defined CPU features, CPUID level 0x00000001, word 0 */
@@ -77,7 +75,6 @@
 #define cpu_has_pge		boot_cpu_has(X86_FEATURE_PGE)
 #define cpu_has_sse2		boot_cpu_has(X86_FEATURE_XMM2)
 #define cpu_has_apic		boot_cpu_has(X86_FEATURE_APIC)
-#define cpu_has_sep		boot_cpu_has(X86_FEATURE_SEP)
 #define cpu_has_mtrr		boot_cpu_has(X86_FEATURE_MTRR)
 #define cpu_has_mmx		boot_cpu_has(X86_FEATURE_MMX)
 #define cpu_has_fxsr		boot_cpu_has(X86_FEATURE_FXSR)
--- 25/include/asm-i386/msr.h~bad3	Fri Jan  3 16:36:48 2003
+++ 25-akpm/include/asm-i386/msr.h	Fri Jan  3 16:36:48 2003
@@ -53,10 +53,6 @@
 
 #define MSR_IA32_BBL_CR_CTL		0x119
 
-#define MSR_IA32_SYSENTER_CS		0x174
-#define MSR_IA32_SYSENTER_ESP		0x175
-#define MSR_IA32_SYSENTER_EIP		0x176
-
 #define MSR_IA32_MCG_CAP		0x179
 #define MSR_IA32_MCG_STATUS		0x17a
 #define MSR_IA32_MCG_CTL		0x17b
--- 25/include/asm-i386/processor.h~bad3	Fri Jan  3 16:36:48 2003
+++ 25-akpm/include/asm-i386/processor.h	Fri Jan  3 16:36:48 2003
@@ -14,7 +14,6 @@
 #include <asm/types.h>
 #include <asm/sigcontext.h>
 #include <asm/cpufeature.h>
-#include <asm/msr.h>
 #include <linux/cache.h>
 #include <linux/config.h>
 #include <linux/threads.h>
@@ -411,21 +410,6 @@ struct thread_struct {
 	.io_bitmap	= { [ 0 ... IO_BITMAP_SIZE ] = ~0 },		\
 }
 
-static inline void load_esp0(struct tss_struct *tss, unsigned long esp0)
-{
-	tss->esp0 = esp0;
-	if (cpu_has_sep) {
-		wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
-		wrmsr(MSR_IA32_SYSENTER_ESP, esp0, 0);
-	}
-}
-
-static inline void disable_sysenter(void)
-{
-	if (cpu_has_sep)  
-		wrmsr(MSR_IA32_SYSENTER_CS, 0, 0);
-}
-
 #define start_thread(regs, new_eip, new_esp) do {		\
 	__asm__("movl %0,%%fs ; movl %0,%%gs": :"r" (0));	\
 	set_fs(USER_DS);					\

_
