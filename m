Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268118AbUHFNCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268118AbUHFNCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUHFNCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:02:40 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:50568 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268118AbUHFNCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:02:25 -0400
Date: Fri, 6 Aug 2004 18:07:57 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com, shemminger@osdl.org,
       vamsi_krishna@in.ibm.com, prasanna@in.ibm.com
Subject: Re: [0/3]kprobes-base-268-rc3.patch
Message-ID: <20040806123757.GB3376@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <2pMzT-XA-21@gated-at.bofh.it> <m3hdrhyhuy.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <m3hdrhyhuy.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,

Please find the exception notifiers patch for i386 architecture ported from 
x86_64 architecture.
Also I would like to mention that:

Earlier Stephen Hemminger ported notifiers to i386. The reason to drop the patch was
was, there were some bad interaction issues with using the hooks for NMI (trap
2), locking and oprofile. 

Please review and provide your comments.

Thanks
Prasanna
Aug 05, 2004 at 12:55:17PM +0200, Andi Kleen wrote:
> Prasanna S Panchamukhi <prasanna@in.ibm.com> writes:
> 
> Hallo,
> 
> Overall it looks good, but some issues noted below. 
> 
> > @@ -437,6 +437,9 @@ asmlinkage void do_general_protection(st
> >  	if (regs->eflags & VM_MASK)
> >  		goto gp_in_vm86;
> >  
> > +	if (kprobe_running() && kprobe_fault_handler(regs, 13))
> > +		return;
> 
> Please port the notifier lists from x86-64 first to give a clean
> interface (see include/asm-x86_64/kdebug.h and the trap handlers there). 
> Otherwise this  will always conflict with everybody who wants to 
> add exception handlers too.
> 

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i386_exception_notifiers-268-rc3.patch"



This patch provides notifiers for i386 architecture exceptions. This
patch has been ported from x86_64 architecture as suggested by Andi Kleen.


---


diff -puN /dev/null include/asm-i386/kdebug.h
--- /dev/null	2004-06-16 06:40:55.000000000 -0700
+++ linux-2.6.8-rc3-root/include/asm-i386/kdebug.h	2004-08-07 07:47:13.349752488 -0700
@@ -0,0 +1,50 @@
+#ifndef _I386_KDEBUG_H
+#define _I386_KDEBUG_H 1
+
+/*
+ * Aug-05 2004 Ported by Prasanna S Panchamukhi <prasanna@in.ibm.com>
+ * from x86_64 architecture.
+ */
+#include <linux/notifier.h>
+
+struct pt_regs;
+
+struct die_args {
+	struct pt_regs *regs;
+	const char *str;
+	long err;
+	int trapnr;
+	int signr;
+};
+
+/* Note - you should never unregister because that can race with NMIs.
+   If you really want to do it first unregister - then synchronize_kernel - then free.
+  */
+int register_i386die_chain_notify(struct notifier_block *nb);
+extern struct notifier_block *i386die_chain;
+
+
+/* Grossly misnamed. */
+enum die_val {
+	DIE_OOPS = 1,
+	DIE_INT3,
+	DIE_DEBUG,
+	DIE_PANIC,
+	DIE_NMI,
+	DIE_DIE,
+	DIE_NMIWATCHDOG,
+	DIE_KERNELDEBUG,
+	DIE_TRAP,
+	DIE_GPF,
+	DIE_CALL,
+	DIE_NMI_IPI,
+	DIE_PAGE_FAULT,
+};
+
+static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)
+{
+	struct die_args args = { .regs=regs, .str=str, .err=err, .trapnr=trap,.signr=sig };
+	return notifier_call_chain(&i386die_chain, val, &args);
+}
+
+#endif
diff -puN arch/i386/kernel/traps.c~notify-traps arch/i386/kernel/traps.c
--- linux-2.6.8-rc3/arch/i386/kernel/traps.c~notify-traps	2004-08-07 05:44:24.000000000 -0700
+++ linux-2.6.8-rc3-root/arch/i386/kernel/traps.c	2004-08-07 07:56:27.917445384 -0700
@@ -48,6 +48,7 @@
 
 #include <asm/smp.h>
 #include <asm/arch_hooks.h>
+#include <asm/kdebug.h>
 
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -92,6 +93,17 @@ asmlinkage void spurious_interrupt_bug(v
 asmlinkage void machine_check(void);
 
 static int kstack_depth_to_print = 24;
+struct notifier_block *i386die_chain;
+static DECLARE_MUTEX(i386die_chain_mutex);
+
+int register_i386die_chain_notify(struct notifier_block *nb)
+{
+	int err = 0;
+	down(&i386die_chain_mutex);
+	err = notifier_chain_register(&i386die_chain, nb);
+	up(&i386die_chain_mutex);
+	return err;
+}
 
 static int valid_stack_ptr(struct task_struct *task, void *p)
 {
@@ -318,6 +330,7 @@ void die(const char * str, struct pt_reg
 #endif
 	if (nl)
 		printk("\n");
+	notify_die(DIE_OOPS, (char *)str, regs, err, 255, SIGSEGV);
 	show_registers(regs);
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
@@ -387,6 +400,9 @@ static inline void do_trap(int trapnr, i
 #define DO_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+						== NOTIFY_OK) \
+		return; \
 	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
 }
 
@@ -398,12 +414,18 @@ asmlinkage void do_##name(struct pt_regs
 	info.si_errno = 0; \
 	info.si_code = sicode; \
 	info.si_addr = (void __user *)siaddr; \
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+						== NOTIFY_BAD) \
+		return; \
 	do_trap(trapnr, signr, str, 0, regs, error_code, &info); \
 }
 
 #define DO_VM86_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+						== NOTIFY_OK) \
+		return; \
 	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
 }
 
@@ -415,6 +437,9 @@ asmlinkage void do_##name(struct pt_regs
 	info.si_errno = 0; \
 	info.si_code = sicode; \
 	info.si_addr = (void __user *)siaddr; \
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+						== NOTIFY_OK) \
+		return; \
 	do_trap(trapnr, signr, str, 1, regs, error_code, &info); \
 }
 
@@ -451,8 +476,12 @@ gp_in_vm86:
 	return;
 
 gp_in_kernel:
-	if (!fixup_exception(regs))
+	if (!fixup_exception(regs)) {
+		if (notify_die(DIE_GPF, "general protection fault", regs,
+				error_code, 13, SIGSEGV) == NOTIFY_OK);
+			return;
 		die("general protection fault", regs, error_code);
+	}
 }
 
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
@@ -501,6 +530,9 @@ static void default_do_nmi(struct pt_reg
 	unsigned char reason = get_nmi_reason();
  
 	if (!(reason & 0xc0)) {
+		if (notify_die(DIE_NMI_IPI, "nmi_ipi", regs, reason, 0, SIGINT)
+							== NOTIFY_BAD)
+			return;
 #ifdef CONFIG_X86_LOCAL_APIC
 		/*
 		 * Ok, so this is none of the documented NMI sources,
@@ -514,6 +546,8 @@ static void default_do_nmi(struct pt_reg
 		unknown_nmi_error(reason, regs);
 		return;
 	}
+	if (notify_die(DIE_NMI, "nmi", regs, reason, 0, SIGINT) == NOTIFY_BAD)
+		return;
 	if (reason & 0x80)
 		mem_parity_error(reason, regs);
 	if (reason & 0x40)
@@ -587,6 +621,9 @@ asmlinkage void do_debug(struct pt_regs 
 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
+	if (notify_die(DIE_DEBUG, "debug", regs, condition, error_code,
+					SIGTRAP) == NOTIFY_OK)
+		return;
 	/* It's safe to allow irq's after DR6 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
 		local_irq_enable();
diff -puN arch/i386/kernel/i386_ksyms.c~notify-traps arch/i386/kernel/i386_ksyms.c
--- linux-2.6.8-rc3/arch/i386/kernel/i386_ksyms.c~notify-traps	2004-08-07 05:44:24.000000000 -0700
+++ linux-2.6.8-rc3-root/arch/i386/kernel/i386_ksyms.c	2004-08-07 05:44:24.000000000 -0700
@@ -32,6 +32,7 @@
 #include <asm/tlbflush.h>
 #include <asm/nmi.h>
 #include <asm/ist.h>
+#include <asm/kdebug.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
 extern spinlock_t rtc_lock;
@@ -177,6 +178,7 @@ EXPORT_SYMBOL_GPL(unset_nmi_callback);
 extern int memcmp(const void *,const void *,__kernel_size_t);
 EXPORT_SYMBOL_NOVERS(memcmp);
 
+EXPORT_SYMBOL(register_i386die_chain_notify);
 #ifdef CONFIG_HAVE_DEC_LOCK
 EXPORT_SYMBOL(atomic_dec_and_lock);
 #endif
diff -puN arch/i386/mm/fault.c~notify-traps arch/i386/mm/fault.c
--- linux-2.6.8-rc3/arch/i386/mm/fault.c~notify-traps	2004-08-07 05:44:24.000000000 -0700
+++ linux-2.6.8-rc3-root/arch/i386/mm/fault.c	2004-08-07 07:57:12.817619520 -0700
@@ -26,6 +26,7 @@
 #include <asm/uaccess.h>
 #include <asm/hardirq.h>
 #include <asm/desc.h>
+#include <asm/kdebug.h>
 
 extern void die(const char *,struct pt_regs *,long);
 
@@ -226,6 +227,9 @@ asmlinkage void do_page_fault(struct pt_
 	/* get the address */
 	__asm__("movl %%cr2,%0":"=r" (address));
 
+	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+					SIGSEGV) == NOTIFY_OK)
+		return;
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
 		local_irq_enable();

_

--0ntfKIWw70PvrIHh--
