Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbUKLQj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbUKLQj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbUKLQjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:39:16 -0500
Received: from fsmlabs.com ([168.103.115.128]:43139 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S262559AbUKLQiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:38:04 -0500
Date: Fri, 12 Nov 2004 09:37:35 -0700 (MST)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Alan Cox <alan@redhat.com>
Subject: [PATCH] lockless MCE i386 port
Message-ID: <Pine.LNX.4.61.0411090126190.3047@musoma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi fixed the locking issues with respect to printk and MCEs on x86_64, 
this is a port of said code with a few small changes due to i386 currently 
supporting the extended MCE MSRs on intel processors (also present on 
intel x86_64). The addition of hooks allows for the Pentium and P4 MCE 
drivers to print additional/extended information. I've also converted the 
P4 thermal monitor driver to avoid printing from interrupt context.

Tested on P4 and K7

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

 arch/i386/kernel/cpu/mcheck/k7.c  |   68 ++++++++++-----
 arch/i386/kernel/cpu/mcheck/mce.c |  109 ++++++++++++++++++++++++-
 arch/i386/kernel/cpu/mcheck/mce.h |   53 ++++++++++++
 arch/i386/kernel/cpu/mcheck/p4.c  |  165 ++++++++++++++++++++++++++------------
 arch/i386/kernel/cpu/mcheck/p5.c  |   27 ++++--
 arch/i386/kernel/cpu/mcheck/p6.c  |   66 +++++++++------
 6 files changed, 382 insertions(+), 106 deletions(-)

Index: linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/k7.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/k7.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 k7.c
--- linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/k7.c	9 Nov 2004 21:54:52 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/k7.c	12 Nov 2004 04:20:38 -0000
@@ -20,36 +20,54 @@
 /* Machine Check Handler For AMD Athlon/Duron */
 static asmlinkage void k7_machine_check(struct pt_regs * regs, long error_code)
 {
-	int recover=1;
-	u32 alow, ahigh, high, low;
-	u32 mcgstl, mcgsth;
-	int i;
-
-	rdmsr (MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
-	if (mcgstl & (1<<0))	/* Recoverable ? */
+	int i, recover=1;
+	u32 high, low;
+	u64 mcestart;
+	struct mce m, panicm;
+	int panicm_found = 0;
+
+	memset(&m, 0, sizeof(m));
+	m.cpu = smp_processor_id();
+	rdtscll(mcestart);
+	rdmsr (MSR_IA32_MCG_STATUS, m.mcgstl, m.mcgsth);
+	if (m.mcgstl & (1<<0))	/* Recoverable ? */
 		recover=0;
-
-	printk (KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n",
-		smp_processor_id(), mcgsth, mcgstl);
-
+	
 	for (i=1; i<nr_mce_banks; i++) {
+		m.bank = i;
+		m.tsc = 0;
+		m.stsl = m.stsh = 0;
+		m.addrl = m.addrh = 0;
+		m.miscl = m.misch = 0;
 		rdmsr (MSR_IA32_MC0_STATUS+i*4,low, high);
 		if (high&(1<<31)) {
 			if (high & (1<<29))
 				recover |= 1;
 			if (high & (1<<25))
 				recover |= 2;
-			printk (KERN_EMERG "Bank %d: %08x%08x", i, high, low);
+			m.stsl = low;
+			m.stsh = high;
 			high &= ~(1<<31);
-			if (high & (1<<27)) {
-				rdmsr (MSR_IA32_MC0_MISC+i*4, alow, ahigh);
-				printk ("[%08x%08x]", ahigh, alow);
+			if (high & (1<<27))
+				rdmsr (MSR_IA32_MC0_MISC+i*4, m.miscl, m.misch);
+			if (high & (1<<26))
+				rdmsr (MSR_IA32_MC0_ADDR+i*4, m.addrl, m.addrh);
+
+			/* Error at %eip ? */
+			if (m.mcgstl & (1<<1)) {
+				m.eip = regs->eip;
+				m.cs = regs->xcs;
+			} else {
+				m.eip = 0;
+				m.cs = 0;
 			}
-			if (high & (1<<26)) {
-				rdmsr (MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
-				printk (" at %08x%08x", ahigh, alow);
+			
+			rdtscll(m.tsc);
+			mce_log(&m);
+			if (recover) {
+				panicm = m;
+				panicm_found = 1;
 			}
-			printk ("\n");
 			/* Clear it */
 			wrmsr (MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
 			/* Serialize */
@@ -58,13 +76,15 @@ static asmlinkage void k7_machine_check(
 		}
 	}
 
+	if (!panicm_found)
+		panicm = m;
+
 	if (recover&2)
-		panic ("CPU context corrupt");
+		mce_panic("CPU context corrupt", &panicm, mcestart);
 	if (recover&1)
-		panic ("Unable to continue");
-	printk (KERN_EMERG "Attempting to continue.\n");
-	mcgstl &= ~(1<<2);
-	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+		mce_panic("Unable to continue", &panicm, mcestart);
+	wrmsr (MSR_IA32_MCG_STATUS, m.mcgstl & ~(1 << 2), m.mcgsth);
+	mce_dump();
 }
 
 
Index: linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/mce.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/mce.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mce.c
--- linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/mce.c	9 Nov 2004 21:54:52 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/mce.c	12 Nov 2004 15:08:04 -0000
@@ -1,6 +1,7 @@
 /*
  * mce.c - x86 Machine Check Exception Reporting
  * (c) 2002 Alan Cox <alan@redhat.com>, Dave Jones <davej@codemonkey.org.uk>
+ * (c) 2004 Andi Kleen <ak@suse.de>, Zwane Mwaikambo <zwane@fsmlabs.com>
  */
 
 #include <linux/init.h>
@@ -10,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/smp.h>
 #include <linux/thread_info.h>
+#include <linux/rcupdate.h>
+#include <linux/kallsyms.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
@@ -23,7 +26,7 @@ EXPORT_SYMBOL_GPL(nr_mce_banks);	/* non-
 
 /* Handle unconfigured int18 (should never happen) */
 static asmlinkage void unexpected_machine_check(struct pt_regs * regs, long error_code)
-{	
+{
 	printk(KERN_ERR "CPU#%d: Unexpected int18 (Machine Check).\n", smp_processor_id());
 }
 
@@ -61,6 +64,110 @@ void __init mcheck_init(struct cpuinfo_x
 	}
 }
 
+/*
+ * Lockless MCE logging infrastructure.
+ * This avoids deadlocks on printk locks without having to break locks. Also
+ * separate MCEs from kernel messages to avoid bogus bug reports.
+ */
+
+struct mce_log mcelog = { 
+	MCE_LOG_SIGNATURE,
+	MCE_LOG_LEN,
+}; 
+
+static void print_mce(struct mce *);
+static void __mce_dump_log(unsigned long data)
+{
+	int i;
+
+	for (i = 0; i < MCE_LOG_LEN; i++) {
+		smp_rmb();
+		if (!mcelog.entry[i].finished)
+			continue;
+		print_mce(&mcelog.entry[i]);
+	}
+}
+
+DECLARE_TASKLET(mce_tasklet, __mce_dump_log, 0);
+
+void mce_log(struct mce *mce)
+{
+	unsigned next, entry;
+	mce->finished = 0;
+	smp_wmb();
+	for (;;) {
+		entry = rcu_dereference(mcelog.next);
+		/* When the buffer fills up discard new entries. Assume 
+		   that the earlier errors are the more interesting. */
+		if (entry >= MCE_LOG_LEN) {
+			set_bit(MCE_OVERFLOW, &mcelog.flags);
+			return;
+		}
+		/* Old left over entry. Skip. */
+		if (mcelog.entry[entry].finished)
+			continue;
+		smp_rmb();
+		next = entry + 1;
+		if (cmpxchg(&mcelog.next, entry, next) == entry)
+			break;
+	}
+	if (mcelog.ext_entry_len && mce->ext_arg) {
+		char *p = (char *)mcelog.ext_buffer + (entry * mcelog.ext_entry_len);
+		memcpy(p, mce->ext_arg, mcelog.ext_entry_len);
+		mce->ext_arg = p;
+	}
+	memcpy(mcelog.entry + entry, mce, sizeof(struct mce));
+	smp_wmb();
+	mcelog.entry[entry].finished = 1;
+	smp_wmb();
+}
+
+static void print_mce(struct mce *m)
+{
+	printk(KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n",
+		m->cpu, m->mcgsth, m->mcgstl);
+
+	printk(KERN_EMERG "Bank %d: %08x%08x", m->bank, m->stsh, m->stsl);
+	if (m->miscl || m->misch)
+		printk("[%08x%08x]", m->misch, m->miscl);
+	if (m->addrl || m->addrh)
+		printk(" at %08x%08x", m->addrl, m->addrh);
+	printk("\n");
+
+	if (m->eip) {
+		printk(KERN_EMERG "EIP %02x:<%08x> ",
+			m->cs, m->eip);
+		if (m->cs == __KERNEL_CS)
+			print_symbol("{%s}", m->eip);
+		printk("\n");
+	}
+
+	if (m->tsc)
+		printk(KERN_EMERG "TSC %016Lx\n", m->tsc);
+	if (m->ext_arg)
+		mcelog.ext_call(m->ext_arg);
+}
+
+void mce_panic(char *msg, struct mce *backup, u64 start)
+{
+	int i;
+
+	oops_in_progress = 1;
+	for (i = 0; i < MCE_LOG_LEN; i++) {
+		if (mcelog.entry[i].tsc < start)
+			continue;
+
+		print_mce(&mcelog.entry[i]);
+		if (backup && mcelog.entry[i].tsc == backup->tsc)
+			backup = NULL;
+	}
+
+	if (backup)
+		print_mce(backup);
+
+	panic(msg);
+}
+
 static int __init mcheck_disable(char *str)
 {
 	mce_disabled = 1;
Index: linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/mce.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/mce.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mce.h
--- linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/mce.h	9 Nov 2004 21:54:52 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/mce.h	12 Nov 2004 04:21:34 -0000
@@ -1,5 +1,58 @@
 #include <linux/init.h>
+#include <linux/interrupt.h>
 
+/*
+ * This structure contains all data related to the MCE log.
+ * Also carries a signature to make it easier to find from external debugging tools.
+ * Each entry is only valid when its finished flag is set.
+ */
+
+#define MCE_LOG_LEN 32
+#define MCE_OVERFLOW 0		/* bit 0 in flags means overflow */
+#define MCE_LOG_SIGNATURE	"MACHINECHECK"
+#define MCE_GET_RECORD_LEN	_IOR('M', 1, int)
+#define MCE_GET_LOG_LEN		_IOR('M', 2, int)
+#define MCE_GETCLEAR_FLAGS	_IOR('M', 3, int)
+
+struct mce {
+	u64 tsc;	/* cpu timestamp counter */
+	u32 stsl;
+	u32 stsh;
+	u32 miscl;
+	u32 misch;
+	u32 addrl;
+	u32 addrh;
+	u32 mcgstl;
+	u32 mcgsth;
+	u32 eip;
+	u8  cs;		/* code segment */
+	u8  bank;	/* machine check bank */
+	u8  cpu;	/* cpu that raised the error */
+	u8  finished;	/* entry is valid */
+	void *ext_arg;	/* extended feature arg */
+};
+
+struct mce_log {
+	char signature[12];	/* "MACHINECHECK" */
+	unsigned long len;		/* = MCE_LOG_LEN */
+	unsigned long next;
+	unsigned long flags;
+	unsigned long pad0;
+	struct mce entry[MCE_LOG_LEN];
+	void *ext_buffer;	/* extended feature storage */
+	void (*ext_call)(void *); /* extended feature callback */
+	unsigned long ext_entry_len;	/* extended feature argument length */
+};
+
+extern struct tasklet_struct mce_tasklet;
+extern struct mce_log mcelog;
+static void inline mce_dump(void)
+{
+	tasklet_hi_schedule(&mce_tasklet);
+}
+
+void mce_log(struct mce *m);
+void mce_panic(char *msg, struct mce *backup, u64 start);
 void amd_mcheck_init(struct cpuinfo_x86 *c);
 void intel_p4_mcheck_init(struct cpuinfo_x86 *c);
 void intel_p5_mcheck_init(struct cpuinfo_x86 *c);
Index: linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p4.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p4.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 p4.c
--- linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p4.c	9 Nov 2004 21:54:52 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p4.c	12 Nov 2004 05:48:00 -0000
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <linux/bootmem.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
@@ -32,39 +33,65 @@ struct intel_mce_extended_msrs {
 	/* u32 *reserved[]; */
 };
 
+static struct intel_mce_extended_msrs mce_ext_buffer[MCE_LOG_LEN];
+
 static int mce_num_extended_msrs = 0;
 
 
 #ifdef CONFIG_X86_MCE_P4THERMAL
 static void unexpected_thermal_interrupt(struct pt_regs *regs)
-{	
+{
+	ack_APIC_irq();
 	printk(KERN_ERR "CPU%d: Unexpected LVT TMR interrupt!\n",
 			smp_processor_id());
 	add_taint(TAINT_MACHINE_CHECK);
 }
 
 /* P4/Xeon Thermal transition interrupt handler */
+static cpumask_t cpu_thermal_status;
+static unsigned long next_thermal_check;
+
+static void intel_thermal_check(unsigned long data)
+{
+	static cpumask_t log;
+	int cpu;
+
+	next_thermal_check = jiffies + HZ*10;
+	for_each_online_cpu(cpu) {
+		if (cpu_isset(cpu, cpu_thermal_status)) {
+			if (cpu_isset(cpu, log))
+				continue;
+
+			printk(KERN_EMERG
+				"CPU%d: Temperature above threshold, cpu clock throttled\n", cpu);
+			cpu_set(cpu, log);
+		} else if (cpu_isset(cpu, log)) {
+			printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
+			cpu_clear(cpu, log);
+		}
+	}
+}
+
+static DECLARE_TASKLET(thermal_tasklet, intel_thermal_check, 0);
+
 static void intel_thermal_interrupt(struct pt_regs *regs)
 {
-	u32 l, h;
-	unsigned int cpu = smp_processor_id();
-	static unsigned long next[NR_CPUS];
+	unsigned long  l, h;
 
 	ack_APIC_irq();
 
-	if (time_after(next[cpu], jiffies))
-		return;
-
-	next[cpu] = jiffies + HZ*5;
 	rdmsr(MSR_IA32_THERM_STATUS, l, h);
 	if (l & 0x1) {
-		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
-		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n",
-				cpu);
+		cpu_set(smp_processor_id(), cpu_thermal_status);
 		add_taint(TAINT_MACHINE_CHECK);
 	} else {
-		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
+		cpu_clear(smp_processor_id(), cpu_thermal_status);
 	}
+
+	if (time_before(jiffies, next_thermal_check))
+		return;
+	
+	tasklet_schedule(&thermal_tasklet);
 }
 
 /* Thermal interrupt handler for this CPU setup */
@@ -159,57 +186,83 @@ done:
 	return mce_num_extended_msrs;
 }
 
+static void intel_print_extended_msr(void *__dbg_msrs)
+{
+	struct intel_mce_extended_msrs *dbg = __dbg_msrs;
+
+	printk(KERN_EMERG "EIP: %08x EFLAGS: %08x\n",
+		dbg->eip, dbg->eflags);
+	printk(KERN_EMERG "EAX: %08x EBX: %08x ECX: %08x EDX: %08x\n",
+		dbg->eax, dbg->ebx, dbg->ecx, dbg->edx);
+	printk (KERN_EMERG "ESI: %08x EDI: %08x EBP: %08x ESP: %08x\n",
+		dbg->esi, dbg->edi, dbg->ebp, dbg->esp);
+}
+
 static asmlinkage void intel_machine_check(struct pt_regs * regs, long error_code)
 {
-	int recover=1;
-	u32 alow, ahigh, high, low;
-	u32 mcgstl, mcgsth;
-	int i;
+	int i, recover = 1;
+	u32 high, low;
+	u64 mcestart;
 	struct intel_mce_extended_msrs dbg;
+	struct mce m, panicm;
+	int panicm_found = 0;
 
-	rdmsr (MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
-	if (mcgstl & (1<<0))	/* Recoverable ? */
-		recover=0;
-
-	printk (KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n",
-		smp_processor_id(), mcgsth, mcgstl);
-
-	if (intel_get_extended_msrs(&dbg)) {
-		printk (KERN_DEBUG "CPU %d: EIP: %08x EFLAGS: %08x\n",
-			smp_processor_id(), dbg.eip, dbg.eflags);
-		printk (KERN_DEBUG "\teax: %08x ebx: %08x ecx: %08x edx: %08x\n",
-			dbg.eax, dbg.ebx, dbg.ecx, dbg.edx);
-		printk (KERN_DEBUG "\tesi: %08x edi: %08x ebp: %08x esp: %08x\n",
-			dbg.esi, dbg.edi, dbg.ebp, dbg.esp);
-	}
+	memset(&m, 0, sizeof(m));
+	m.cpu = smp_processor_id();
+	rdtscll(mcestart);
+	rdmsr(MSR_IA32_MCG_STATUS, m.mcgstl, m.mcgsth);
+	if (m.mcgstl & (1<<0))	/* Recoverable ? */
+		recover = 0;
+	
+	if (intel_get_extended_msrs(&dbg))
+		m.ext_arg = &dbg;
 
 	for (i=0; i<nr_mce_banks; i++) {
-		rdmsr (MSR_IA32_MC0_STATUS+i*4,low, high);
+		m.bank = i;
+		m.tsc = 0;
+		m.stsl = m.stsh = 0;
+		m.addrl = m.addrh = 0;
+		m.miscl = m.misch = 0;
+		rdmsr (MSR_IA32_MC0_STATUS+i*4, low, high);
 		if (high & (1<<31)) {
 			if (high & (1<<29))
 				recover |= 1;
 			if (high & (1<<25))
 				recover |= 2;
-			printk (KERN_EMERG "Bank %d: %08x%08x", i, high, low);
+			m.stsl = low;
+			m.stsh = high;
 			high &= ~(1<<31);
-			if (high & (1<<27)) {
-				rdmsr (MSR_IA32_MC0_MISC+i*4, alow, ahigh);
-				printk ("[%08x%08x]", ahigh, alow);
+			if (high & (1<<27))
+				rdmsr (MSR_IA32_MC0_MISC+i*4, m.miscl, m.misch);
+			if (high & (1<<26))
+				rdmsr (MSR_IA32_MC0_ADDR+i*4, m.addrl, m.addrh);
+
+			/* Error at %eip ? */
+			if (m.mcgstl & (1<<1)) {
+				m.eip = regs->eip;
+				m.cs = regs->xcs;
+			} else {
+				m.eip = 0;
+				m.cs = 0;
 			}
-			if (high & (1<<26)) {
-				rdmsr (MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
-				printk (" at %08x%08x", ahigh, alow);
+
+			rdtscll(m.tsc);
+			mce_log(&m);
+			if (recover) {
+				panicm = m;
+				panicm_found = 1;
 			}
-			printk ("\n");
 		}
 	}
 
+	if (!panicm_found)
+		panicm = m;
+
 	if (recover & 2)
-		panic ("CPU context corrupt");
+		mce_panic("CPU context corrupt", &panicm, mcestart);
 	if (recover & 1)
-		panic ("Unable to continue");
+		mce_panic("Unable to continue", &panicm, mcestart);
 
-	printk(KERN_EMERG "Attempting to continue.\n");
 	/* 
 	 * Do not clear the MSR_IA32_MCi_STATUS if the error is not 
 	 * recoverable/continuable.This will allow BIOS to look at the MSRs
@@ -218,7 +271,7 @@ static asmlinkage void intel_machine_che
 	for (i=0; i<nr_mce_banks; i++) {
 		u32 msr;
 		msr = MSR_IA32_MC0_STATUS+i*4;
-		rdmsr (msr, low, high);
+		rdmsr(msr, low, high);
 		if (high&(1<<31)) {
 			/* Clear it */
 			wrmsr(msr, 0UL, 0UL);
@@ -227,11 +280,10 @@ static asmlinkage void intel_machine_che
 			add_taint(TAINT_MACHINE_CHECK);
 		}
 	}
-	mcgstl &= ~(1<<2);
-	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+	wrmsr(MSR_IA32_MCG_STATUS, m.mcgstl & ~(1 << 2), m.mcgsth);
+	mce_dump();
 }
 
-
 void __init intel_p4_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
@@ -258,14 +310,25 @@ void __init intel_p4_mcheck_init(struct 
 	/* Check for P4/Xeon extended MCE MSRs */
 	rdmsr (MSR_IA32_MCG_CAP, l, h);
 	if (l & (1<<9))	{/* MCG_EXT_P */
+		struct intel_mce_extended_msrs *p;
+		
+		if (smp_processor_id() != 0)
+			goto skip;
+
+		p = mce_ext_buffer;
+		memset(p, 0, sizeof(*p) * MCE_LOG_LEN);
+		mcelog.ext_buffer = p;
+		mcelog.ext_call = intel_print_extended_msr;
+		mcelog.ext_entry_len = sizeof(*p);
 		mce_num_extended_msrs = (l >> 16) & 0xff;
+skip:
 		printk (KERN_INFO "CPU%d: Intel P4/Xeon Extended MCE MSRs (%d)"
-				" available\n",
+			" available\n",
 			smp_processor_id(), mce_num_extended_msrs);
+	}
 
 #ifdef CONFIG_X86_MCE_P4THERMAL
-		/* Check for P4/Xeon Thermal monitor */
-		intel_init_thermal(c);
+	/* Check for P4/Xeon Thermal monitor */
+	intel_init_thermal(c);
 #endif
-	}
 }
Index: linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p5.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p5.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 p5.c
--- linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p5.c	9 Nov 2004 21:54:52 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p5.c	12 Nov 2004 04:36:16 -0000
@@ -16,23 +16,32 @@
 
 #include "mce.h"
 
+static void pentium_print_status(void *mc_typel)
+{
+	if ((u32)mc_typel & (1 << 5))
+		printk("Possible thermal failure (CPU on fire?).\n");
+}
+
 /* Machine check handler for Pentium class Intel */
 static asmlinkage void pentium_machine_check(struct pt_regs * regs, long error_code)
 {
-	u32 loaddr, hi, lotype;
-	rdmsr(MSR_IA32_P5_MC_ADDR, loaddr, hi);
-	rdmsr(MSR_IA32_P5_MC_TYPE, lotype, hi);
-	printk(KERN_EMERG "CPU#%d: Machine Check Exception:  0x%8X (type 0x%8X).\n", smp_processor_id(), loaddr, lotype);
-	if(lotype&(1<<5))
-		printk(KERN_EMERG "CPU#%d: Possible thermal failure (CPU on fire ?).\n", smp_processor_id());
+	struct mce m;
+
+	memset(&m, 0, sizeof(m));
+	m.cpu = smp_processor_id();
+	rdmsr(MSR_IA32_P5_MC_ADDR, m.addrl, m.addrh);
+	rdmsr(MSR_IA32_P5_MC_TYPE, m.mcgstl, m.mcgsth);
+	m.ext_arg = (void *)m.mcgstl;
+	mce_log(&m);
 	add_taint(TAINT_MACHINE_CHECK);
+	mce_dump();
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
 void __init intel_p5_mcheck_init(struct cpuinfo_x86 *c)
 {
 	u32 l, h;
-	
+		
 	/*Check for MCE support */
 	if( !cpu_has(c, X86_FEATURE_MCE) )
 		return;	
@@ -40,6 +49,10 @@ void __init intel_p5_mcheck_init(struct 
 	/* Default P5 to off as its often misconnected */
 	if(mce_disabled != -1)
 		return;
+	
+	mcelog.ext_call = pentium_print_status;
+	mcelog.ext_entry_len = 0;
+
 	machine_check_vector = pentium_machine_check;
 	wmb();
 
Index: linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p6.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p6.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 p6.c
--- linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p6.c	9 Nov 2004 21:54:52 -0000	1.1.1.1
+++ linux-2.6.10-rc1-mm4/arch/i386/kernel/cpu/mcheck/p6.c	11 Nov 2004 14:42:58 -0000
@@ -19,45 +19,65 @@
 /* Machine Check Handler For PII/PIII */
 static asmlinkage void intel_machine_check(struct pt_regs * regs, long error_code)
 {
-	int recover=1;
-	u32 alow, ahigh, high, low;
-	u32 mcgstl, mcgsth;
-	int i;
-
-	rdmsr (MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
-	if (mcgstl & (1<<0))	/* Recoverable ? */
+	int i, recover=1;
+	u32 high, low;
+	u64 mcestart;
+	struct mce m, panicm;
+	int panicm_found = 0;
+
+	memset(&m, 0, sizeof(m));
+	m.cpu = smp_processor_id();
+	rdtscll(mcestart);
+	rdmsr (MSR_IA32_MCG_STATUS, m.mcgstl, m.mcgsth);
+	if (m.mcgstl & (1<<0))	/* Recoverable ? */
 		recover=0;
 
-	printk (KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n",
-		smp_processor_id(), mcgsth, mcgstl);
-
 	for (i=0; i<nr_mce_banks; i++) {
+		m.bank = i;
+		m.tsc = 0;
+		m.stsl = m.stsh = 0;
+		m.addrl = m.addrh = 0;
+		m.miscl = m.misch = 0;
 		rdmsr (MSR_IA32_MC0_STATUS+i*4,low, high);
 		if (high & (1<<31)) {
 			if (high & (1<<29))
 				recover |= 1;
 			if (high & (1<<25))
 				recover |= 2;
-			printk (KERN_EMERG "Bank %d: %08x%08x", i, high, low);
+			m.stsl = low;
+			m.stsh = high;
 			high &= ~(1<<31);
-			if (high & (1<<27)) {
-				rdmsr (MSR_IA32_MC0_MISC+i*4, alow, ahigh);
-				printk ("[%08x%08x]", ahigh, alow);
+			if (high & (1<<27))
+				rdmsr (MSR_IA32_MC0_MISC+i*4, m.miscl, m.misch);
+			if (high & (1<<26))
+				rdmsr (MSR_IA32_MC0_ADDR+i*4, m.addrl, m.addrh);
+
+			/* Error at %eip ? */
+			if (m.mcgstl & (1<<1)) {
+				m.eip = regs->eip;
+				m.cs = regs->xcs;
+			} else {
+				m.eip = 0;
+				m.cs = 0;
 			}
-			if (high & (1<<26)) {
-				rdmsr (MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
-				printk (" at %08x%08x", ahigh, alow);
+
+			rdtscll(m.tsc);
+			mce_log(&m);
+			if (recover) {
+				panicm = m;
+				panicm_found = 1;
 			}
-			printk ("\n");
 		}
 	}
 
+	if (!panicm_found)
+		panicm = m;
+
 	if (recover & 2)
-		panic ("CPU context corrupt");
+		mce_panic ("CPU context corrupt", &panicm, mcestart);
 	if (recover & 1)
-		panic ("Unable to continue");
+		mce_panic ("Unable to continue", &panicm, mcestart);
 
-	printk (KERN_EMERG "Attempting to continue.\n");
 	/* 
 	 * Do not clear the MSR_IA32_MCi_STATUS if the error is not 
 	 * recoverable/continuable.This will allow BIOS to look at the MSRs
@@ -75,8 +95,8 @@ static asmlinkage void intel_machine_che
 			add_taint(TAINT_MACHINE_CHECK);
 		}
 	}
-	mcgstl &= ~(1<<2);
-	wrmsr (MSR_IA32_MCG_STATUS,mcgstl, mcgsth);
+	wrmsr (MSR_IA32_MCG_STATUS, m.mcgstl & ~(1 << 2), m.mcgsth);
+	mce_dump();
 }
 
 /* Set up machine check reporting for processors with Intel style MCE */
