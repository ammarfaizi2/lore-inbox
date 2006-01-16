Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWAPNZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWAPNZO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWAPNZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:25:14 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:23748 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750748AbWAPNZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:25:12 -0500
Subject: [PATCH 4/5] stack overflow safe kdump (2.6.15-i386) - nmi handler
	and trap vector replacement
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: ak@suse.de, vgoyal@in.ibm.com, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Mon, 16 Jan 2006 22:25:04 +0900
Message-Id: <1137417904.2256.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the nmi path, we have the problem that both nmi_enter and nmi_exit in
do_nmi (see code below) make extensive use of "current" (which might be
invalid) indirectly (specially through the kernel preemption code).
Create a new nmi trap handler robust against stack overflows and use it
on the crash dump path.

---
diff -urNp linux-2.6.15/arch/i386/kernel/crash.c
linux-2.6.15-sov/arch/i386/kernel/crash.c
--- linux-2.6.15/arch/i386/kernel/crash.c	2006-01-16 20:29:50.000000000
+0900
+++ linux-2.6.15-sov/arch/i386/kernel/crash.c	2006-01-16
20:33:55.000000000 +0900
@@ -22,6 +22,7 @@
 #include <asm/nmi.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
+#include <mach_traps.h>
 #include <mach_ipi.h>
 
 
@@ -142,6 +143,7 @@ static int crash_nmi_callback(struct pt_
 	if (cpu == crashing_cpu)
 		return 1;
 	local_irq_disable();
+	disable_nmi();
 
 	if (!user_mode(regs)) {
 		crash_setup_regs(&fixed_regs, regs);
@@ -167,13 +169,18 @@ static void smp_send_nmi_allbutself(void
 	send_IPI_allbutself(APIC_DM_NMI);
 }
 
+static void set_crash_nmi(void)
+{
+	set_crash_nmi_callback(crash_nmi_callback);
+}
+
 static void nmi_shootdown_cpus(void)
 {
 	unsigned long msecs;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	/* Would it be better to replace the trap vector here? */
-	set_nmi_callback(crash_nmi_callback);
+	/* Set the nmi handler appropriately for the crash case */
+	set_crash_nmi();
 	/* Ensure the new callback function is set before sending
 	 * out the NMI
 	 */
diff -urNp linux-2.6.15/arch/i386/kernel/entry.S
linux-2.6.15-sov/arch/i386/kernel/entry.S
--- linux-2.6.15/arch/i386/kernel/entry.S	2006-01-03 12:21:10.000000000
+0900
+++ linux-2.6.15-sov/arch/i386/kernel/entry.S	2006-01-16
21:52:24.000000000 +0900
@@ -590,6 +590,41 @@ nmi_16bit_stack:
 	.long 1b,iret_exc
 .previous
 
+ENTRY(crash_nmi)
+	pushl %eax
+	movl %ss, %eax
+	cmpw $__ESPFIX_SS, %ax
+	popl %eax
+	je crash_nmi_16bit_stack
+	pushl %eax
+	SAVE_ALL
+	xorl %edx,%edx		# zero error code
+	movl %esp,%eax		# pt_regs pointer
+	call do_crash_nmi
+	jmp restore_all
+crash_nmi_16bit_stack:
+	/* create the pointer to lss back */
+	pushl %ss
+	pushl %esp
+	movzwl %sp, %esp
+	addw $4, (%esp)
+	/* copy the iret frame of 12 bytes */
+        .rept 3
+	pushl 16(%esp)
+	.endr
+	pushl %eax
+	SAVE_ALL
+	FIXUP_ESPFIX_STACK              # %eax == %esp
+	xorl %edx,%edx                  # zero error code
+	call do_crash_nmi
+	RESTORE_REGS
+	lss 12+4(%esp), %esp            # back to 16bit stack
+1:      iret
+.section __ex_table,"a"
+	.align 4
+	.long 1b,iret_exc
+.previous
+
 KPROBE_ENTRY(int3)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
diff -urNp linux-2.6.15/arch/i386/kernel/traps.c
linux-2.6.15-sov/arch/i386/kernel/traps.c
--- linux-2.6.15/arch/i386/kernel/traps.c	2006-01-03 12:21:10.000000000
+0900
+++ linux-2.6.15-sov/arch/i386/kernel/traps.c	2006-01-16
20:51:31.000000000 +0900
@@ -74,6 +74,7 @@ struct desc_struct idt_table[256] __attr
 asmlinkage void divide_error(void);
 asmlinkage void debug(void);
 asmlinkage void nmi(void);
+asmlinkage void crash_nmi(void);
 asmlinkage void int3(void);
 asmlinkage void overflow(void);
 asmlinkage void bounds(void);
@@ -641,23 +642,37 @@ static int dummy_nmi_callback(struct pt_
 }
  
 static nmi_callback_t nmi_callback = dummy_nmi_callback;
- 
-fastcall void do_nmi(struct pt_regs * regs, long error_code)
+
+static fastcall unsigned int __do_nmi(struct pt_regs * regs, long
error_code)
 {
 	int cpu;
 
-	nmi_enter();
-
-	cpu = smp_processor_id();
+	cpu = safe_smp_processor_id();
 
 	++nmi_count(cpu);
 
 	if (!rcu_dereference(nmi_callback)(regs, cpu))
 		default_do_nmi(regs);
 
+	return 0;
+}
+
+#define _do_nmi(regs, error_code, nmih) nmih(regs, error_code);
+
+fastcall void do_nmi(struct pt_regs * regs, long error_code)
+{
+	nmi_enter();
+
+	_do_nmi(regs, error_code, __do_nmi);
+
 	nmi_exit();
 }
 
+fastcall void do_crash_nmi(struct pt_regs * regs, long error_code)
+{
+	_do_nmi(regs, error_code, __do_nmi);
+}
+
 void set_nmi_callback(nmi_callback_t callback)
 {
 	rcu_assign_pointer(nmi_callback, callback);
@@ -670,6 +685,17 @@ void unset_nmi_callback(void)
 }
 EXPORT_SYMBOL_GPL(unset_nmi_callback);
 
+void set_crash_nmi_callback(nmi_callback_t callback)
+{
+	/* XXX Do we need to do this atomically? */
+	disable_nmi();
+	unset_nmi_callback();
+	/* Replace the trap vector */
+	set_intr_gate(2,&crash_nmi);
+	rcu_assign_pointer(nmi_callback, callback);
+}
+EXPORT_SYMBOL_GPL(set_crash_nmi_callback);
+
 #ifdef CONFIG_KPROBES
 fastcall void __kprobes do_int3(struct pt_regs *regs, long error_code)
 {
diff -urNp linux-2.6.15/include/asm-i386/mach-default/mach_traps.h
linux-2.6.15-sov/include/asm-i386/mach-default/mach_traps.h
--- linux-2.6.15/include/asm-i386/mach-default/mach_traps.h	2006-01-03
12:21:10.000000000 +0900
+++ linux-2.6.15-sov/include/asm-i386/mach-default/mach_traps.h
2006-01-16 20:33:55.000000000 +0900
@@ -20,6 +20,11 @@ static inline unsigned char get_nmi_reas
 	return inb(0x61);
 }
 
+static inline void disable_nmi(void)
+{
+	outb(0x8f, 0x70);
+}
+
 static inline void reassert_nmi(void)
 {
 	int old_reg = -1;
diff -urNp linux-2.6.15/include/asm-i386/nmi.h
linux-2.6.15-sov/include/asm-i386/nmi.h
--- linux-2.6.15/include/asm-i386/nmi.h	2006-01-03 12:21:10.000000000
+0900
+++ linux-2.6.15-sov/include/asm-i386/nmi.h	2006-01-16
20:33:55.000000000 +0900
@@ -17,6 +17,7 @@ typedef int (*nmi_callback_t)(struct pt_
  * set. Return 1 if the NMI was handled.
  */
 void set_nmi_callback(nmi_callback_t callback);
+void set_crash_nmi_callback(nmi_callback_t callback);
  
 /** 
  * unset_nmi_callback


