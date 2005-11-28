Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVK1NPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVK1NPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 08:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVK1NPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 08:15:47 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:31977 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S932090AbVK1NPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 08:15:47 -0500
Subject: [PATCH & RFC] kdump and stack overflows
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Mon, 28 Nov 2005 22:11:03 +0900
Message-Id: <1133183463.2327.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have observed that kdump's reboot path to the second kernel is not
stack overflow safe.

On the event of a stack overflow critical data that usually resides at
the bottom of the stack is likely to be stomped and, consequently, its
use should be avoided.

In particular, in the i386 and IA64 architectures the macro
smp_processor_id ultimately makes use of the "cpu" member of struct
thread_info which resides at the bottom of the stack (see code snips
below). x86_64, on the other hand, is not affected by this problem
because it benefits from the PDA infrastructure.

****
* i386: thread_info is stomped and thus no longer valid

(include/linux/smp.h)
#define smp_processor_id() __smp_processor_id() 

(include/asm-i386/smp.h)
#define __smp_processor_id() (current_thread_info()->cpu)

(include/asm-i386/thread_info.h)
static inline struct thread_info *current_thread_info(void)
{
         struct thread_info *ti;
         __asm__("andl %%esp,%0; ":"=r" (ti) : "" (~(THREAD_SIZE - 1)));
         return ti;
}

* x86_64: thread_info is overwritten but this does not affect
smp_processor_id

(include/linux/smp.h)
#define smp_processor_id() __smp_processor_id()

(include/asm-x86_64/smp.h)
#define __smp_processor_id() read_pda(cpunumber)

(arch/x86_64/kernel/setup64.c)
struct x8664_pda cpu_pda[NR_CPUS] __cacheline_aligned;

* IA64: both task_struct and thread_info are likely to be corrupted

(include/asm-ia64/smp.h)
#define smp_processor_id()      (current_thread_info()->cpu)

(include/asm-ia64/thread_info.h)
#define current_thread_info()   ((struct thread_info *) ((char *)
current + IA64_TASK_SIZE))

(include/asm-ia64/current.h)
#define current ((struct task_struct *) ia64_getreg(_IA64_REG_TP))
****

To circumvent this problem I suggest implementing
"safe_smp_processor_id()" (it already exists on x86_64) for i386 and
IA64 and use it as a replacement to smp_processor_id in the reboot path
to the dump capture kernel. A possible implementation for i386 is
attached below.

I would appreciante comments on this.

Regards,

Fernando

---
diff -urNp linux-2.6.15-rc2/arch/i386/kernel/crash.c
linux-2.6.15-rc2-sov/arch/i386/kernel/crash.c
--- linux-2.6.15-rc2/arch/i386/kernel/crash.c	2005-10-28
09:02:08.000000000 +0900
+++ linux-2.6.15-rc2-sov/arch/i386/kernel/crash.c	2005-11-28
21:54:19.000000000 +0900
@@ -120,7 +120,7 @@ static void crash_save_self(struct pt_re
 	struct pt_regs regs;
 	int cpu;
 
-	cpu = smp_processor_id();
+	cpu = safe_smp_processor_id();
 	if (saved_regs)
 		crash_setup_regs(&regs, saved_regs);
 	else
@@ -134,12 +134,14 @@ static atomic_t waiting_for_crash_ipi;
 static int crash_nmi_callback(struct pt_regs *regs, int cpu)
 {
 	struct pt_regs fixed_regs;
+	int scpu;
 
 	/* Don't do anything if this handler is invoked on crashing cpu.
 	 * Otherwise, system will completely hang. Crashing cpu can get
 	 * an NMI if system was initially booted with nmi_watchdog parameter.
 	 */
-	if (cpu == crashing_cpu)
+	scpu = safe_smp_processor_id();
+	if (scpu == crashing_cpu)
 		return 1;
 	local_irq_disable();
 
@@ -147,7 +149,7 @@ static int crash_nmi_callback(struct pt_
 		crash_setup_regs(&fixed_regs, regs);
 		regs = &fixed_regs;
 	}
-	crash_save_this_cpu(regs, cpu);
+	crash_save_this_cpu(regs, scpu);
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
@@ -211,7 +213,7 @@ void machine_crash_shutdown(struct pt_re
 	local_irq_disable();
 
 	/* Make a note of crashing cpu. Will be used in NMI callback.*/
-	crashing_cpu = smp_processor_id();
+	crashing_cpu = safe_smp_processor_id();
 	nmi_shootdown_cpus();
 	lapic_shutdown();
 #if defined(CONFIG_X86_IO_APIC)
diff -urNp linux-2.6.15-rc2/arch/i386/kernel/smp.c
linux-2.6.15-rc2-sov/arch/i386/kernel/smp.c
--- linux-2.6.15-rc2/arch/i386/kernel/smp.c	2005-10-28
09:02:08.000000000 +0900
+++ linux-2.6.15-rc2-sov/arch/i386/kernel/smp.c	2005-11-28
22:05:14.000000000 +0900
@@ -628,3 +628,26 @@ fastcall void smp_call_function_interrup
 	}
 }
 
+static int convert_apicid_to_cpu(int apic_id)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (x86_cpu_to_apicid[i] == apic_id)
+		return i;
+	}
+	return -1;
+}
+
+int safe_smp_processor_id(void) {
+	int apicid, cpuid;
+
+	apicid = hard_smp_processor_id();
+	if (apicid == BAD_APICID)
+		return 0;
+
+	cpuid = convert_apicid_to_cpu(apicid);
+	printk("Test %d\n", cpuid);
+
+	return cpuid >= 0 ? cpuid : 0;
+}
diff -urNp linux-2.6.15-rc2/arch/i386/mm/fault.c
linux-2.6.15-rc2-sov/arch/i386/mm/fault.c
--- linux-2.6.15-rc2/arch/i386/mm/fault.c	2005-11-22 19:48:18.000000000
+0900
+++ linux-2.6.15-rc2-sov/arch/i386/mm/fault.c	2005-11-24
14:04:12.000000000 +0900
@@ -245,6 +245,11 @@ fastcall void __kprobes do_page_fault(st
 		local_irq_enable();
 
 	tsk = current;
+	/* We may have invalid '*current' due to a stack overflow. */
+	if (!virt_addr_valid(tsk)) {
+		printk("do_page_fault: Discarding invalid 'current' struct
task_struct * = 0x%p\n", tsk);
+		tsk = NULL;
+	}
 
 	si_code = SEGV_MAPERR;
 
@@ -271,7 +276,14 @@ fastcall void __kprobes do_page_fault(st
 		goto bad_area_nosemaphore;
 	} 
 
-	mm = tsk->mm;
+	mm = NULL;
+	/* We may have invalid 'tsk' due to a i386 stack overflow */
+	if (tsk)
+		mm = tsk->mm;
+	if (mm && !virt_addr_valid(mm)) {
+		printk("do_page_fault: Discarding invalid current->mm struct
mm_struct * = 0x%p\n", mm);
+		mm = NULL;
+	}
 
 	/*
 	 * If we're in an interrupt, have no user context or are running in an
diff -urNp linux-2.6.15-rc2/include/asm-i386/smp.h
linux-2.6.15-rc2-sov/include/asm-i386/smp.h
--- linux-2.6.15-rc2/include/asm-i386/smp.h	2005-11-22
19:49:02.000000000 +0900
+++ linux-2.6.15-rc2-sov/include/asm-i386/smp.h	2005-11-28
21:30:26.000000000 +0900
@@ -90,12 +90,14 @@ static __inline int logical_smp_processo
 
 #endif
 
+extern int safe_smp_processor_id(void);
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 #endif /* !__ASSEMBLY__ */
 
 #else /* CONFIG_SMP */
 
+#define safe_smp_processor_id() 0
 #define cpu_physical_id(cpu)		boot_cpu_physical_apicid
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */


