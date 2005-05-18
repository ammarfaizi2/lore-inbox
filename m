Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVEROzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVEROzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVEROyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:54:17 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:28404 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262284AbVEROvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:51:23 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [Fastboot] [1/2] kdump: Use real pt_regs from exception
From: Alexander Nyberg <alexn@telia.com>
To: vgoyal@in.ibm.com
Cc: Morton Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org
In-Reply-To: <20050518123500.GA3657@in.ibm.com>
References: <1116103798.6153.30.camel@localhost.localdomain>
	 <20050518123500.GA3657@in.ibm.com>
Content-Type: text/plain
Date: Wed, 18 May 2005 16:51:02 +0200
Message-Id: <1116427862.22324.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek, new version where comments are fixed and added
kexec_should_crash() instead of open-coding panic conditions.

Makes kexec_crashdump() take a pt_regs * as an argument. This allows to
get exact register state at the point of the crash. If we come from
direct panic assertion NULL will be passed and the current registers
saved before crashdump.

This hooks into two places:
die(): check the conditions under which we will panic when calling
do_exit and go there directly with the pt_regs that caused the fatal
fault.

die_nmi(): If we receive an NMI lockup while in the kernel use the
pt_regs and go directly to crash_kexec(). We're probably nested up badly
at this point so this might be the only chance to escape with proper
information.


Signed-off-by: Alexander Nyberg <alexn@telia.com> 

Index: mm/include/linux/reboot.h
===================================================================
--- mm.orig/include/linux/reboot.h	2005-05-16 18:28:52.000000000 +0200
+++ mm/include/linux/reboot.h	2005-05-18 16:25:03.000000000 +0200
@@ -52,7 +52,7 @@
 extern void machine_power_off(void);
 
 extern void machine_shutdown(void);
-extern void machine_crash_shutdown(void);
+extern void machine_crash_shutdown(struct pt_regs *);
 
 #endif
 
Index: mm/arch/i386/kernel/traps.c
===================================================================
--- mm.orig/arch/i386/kernel/traps.c	2005-05-16 18:28:45.000000000 +0200
+++ mm/arch/i386/kernel/traps.c	2005-05-18 16:42:36.000000000 +0200
@@ -27,6 +27,7 @@
 #include <linux/ptrace.h>
 #include <linux/utsname.h>
 #include <linux/kprobes.h>
+#include <linux/kexec.h>
 
 #ifdef CONFIG_EISA
 #include <linux/ioport.h>
@@ -326,6 +327,9 @@
 	printk("Kernel BUG\n");
 }
 
+/* This is gone through when something in the kernel
+ * has done something bad and is about to be terminated.
+*/
 void die(const char * str, struct pt_regs * regs, long err)
 {
 	static struct {
@@ -382,6 +386,10 @@
 	bust_spinlocks(0);
 	die.lock_owner = -1;
 	spin_unlock_irq(&die.lock);
+	
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
+	
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
@@ -616,6 +624,15 @@
 	console_silent();
 	spin_unlock(&nmi_print_lock);
 	bust_spinlocks(0);
+
+	/* If we are in kernel we are probably nested up pretty bad
+	 * and might aswell get out now while we still can.
+	*/
+	if (!user_mode(regs)) {
+		current->thread.trap_no = 2;
+		crash_kexec(regs);
+	}
+	
 	do_exit(SIGSEGV);
 }
 
Index: mm/arch/i386/kernel/crash.c
===================================================================
--- mm.orig/arch/i386/kernel/crash.c	2005-05-16 18:28:45.000000000 +0200
+++ mm/arch/i386/kernel/crash.c	2005-05-18 15:26:43.000000000 +0200
@@ -98,12 +98,31 @@
 	regs->eip = (unsigned long)current_text_addr();
 }
 
-static void crash_save_self(void)
+/* CPU does not save ss and esp on stack if execution is already
+ * running in kernel mode at the time of NMI occurrence. This code
+ * fixes it.
+ */
+static void crash_setup_regs(struct pt_regs *newregs, struct pt_regs *oldregs)
+{
+	memcpy(newregs, oldregs, sizeof(*newregs));
+	newregs->esp = (unsigned long)&(oldregs->esp);
+	__asm__ __volatile__("xorl %eax, %eax;");
+	__asm__ __volatile__ ("movw %%ss, %%ax;" :"=a"(newregs->xss));
+}
+
+/* We may have saved_regs from where the error came from
+ * or it is NULL if via a direct panic(). 
+ */
+static void crash_save_self(struct pt_regs *saved_regs)
 {
 	struct pt_regs regs;
 	int cpu;
 	cpu = smp_processor_id();
-	crash_get_current_regs(&regs);
+	
+	if (saved_regs)
+		crash_setup_regs(&regs, saved_regs);
+	else
+		crash_get_current_regs(&regs);
 	crash_save_this_cpu(&regs, cpu);
 }
 
@@ -115,15 +134,8 @@
 	struct pt_regs fixed_regs;
 	local_irq_disable();
 
-	/* CPU does not save ss and esp on stack if execution is already
-	 * running in kernel mode at the time of NMI occurrence. This code
-	 * fixes it.
-	 */
 	if (!user_mode(regs)) {
-		memcpy(&fixed_regs, regs, sizeof(*regs));
-		fixed_regs.esp = (unsigned long)&(regs->esp);
-		__asm__ __volatile__("xorl %eax, %eax;");
-		__asm__ __volatile__ ("movw %%ss, %%ax;" :"=a"(fixed_regs.xss));
+		crash_setup_regs(&fixed_regs, regs);
 		regs = &fixed_regs;
 	}
 	crash_save_this_cpu(regs, cpu);
@@ -175,7 +187,7 @@
 }
 #endif
 
-void machine_crash_shutdown(void)
+void machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* This function is only called after the system
 	 * has paniced or is otherwise in a critical state.
@@ -192,5 +204,5 @@
 #if defined(CONFIG_X86_IO_APIC)
 	disable_IO_APIC();
 #endif
-	crash_save_self();
+	crash_save_self(regs);
 }
Index: mm/kernel/panic.c
===================================================================
--- mm.orig/kernel/panic.c	2005-05-16 18:28:52.000000000 +0200
+++ mm/kernel/panic.c	2005-05-18 15:06:21.000000000 +0200
@@ -83,7 +83,7 @@
 	 * everything else.
 	 * Do we want to call this before we try to display a message?
 	 */
-	crash_kexec();
+	crash_kexec(NULL);
 
 #ifdef CONFIG_SMP
 	/*
Index: mm/kernel/kexec.c
===================================================================
--- mm.orig/kernel/kexec.c	2005-05-16 18:28:52.000000000 +0200
+++ mm/kernel/kexec.c	2005-05-18 16:34:34.000000000 +0200
@@ -32,6 +32,13 @@
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
 };
 
+int kexec_should_crash(struct task_struct *p)
+{
+	if (in_interrupt() || !p->pid || p->pid == 1 || panic_on_oops)
+		return 1;
+	return 0;
+}
+
 /*
  * When kexec transitions to the new kernel there is a one-to-one
  * mapping between physical and virtual addresses.  On processors
@@ -1010,7 +1017,7 @@
 }
 #endif
 
-void crash_kexec(void)
+void crash_kexec(struct pt_regs *regs)
 {
 	struct kimage *image;
 	int locked;
@@ -1028,7 +1035,7 @@
 	if (!locked) {
 		image = xchg(&kexec_crash_image, NULL);
 		if (image) {
-			machine_crash_shutdown();
+			machine_crash_shutdown(regs);
 			machine_kexec(image);
 		}
 		xchg(&kexec_lock, 0);
Index: mm/include/linux/kexec.h
===================================================================
--- mm.orig/include/linux/kexec.h	2005-05-16 18:28:52.000000000 +0200
+++ mm/include/linux/kexec.h	2005-05-18 16:40:17.000000000 +0200
@@ -99,7 +99,8 @@
 	unsigned long flags);
 #endif
 extern struct page *kimage_alloc_control_pages(struct kimage *image, unsigned int order);
-extern void crash_kexec(void);
+extern void crash_kexec(struct pt_regs *);
+int kexec_should_crash(struct task_struct *);
 extern struct kimage *kexec_image;
 
 #define KEXEC_ON_CRASH  0x00000001
@@ -123,6 +124,7 @@
 extern struct resource crashk_res;
 
 #else /* !CONFIG_KEXEC */
-static inline void crash_kexec(void) { }
+static inline void crash_kexec(struct pt_regs *regs) { }
+static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */
 #endif /* LINUX_KEXEC_H */
Index: mm/drivers/char/sysrq.c
===================================================================
--- mm.orig/drivers/char/sysrq.c	2005-05-16 18:28:46.000000000 +0200
+++ mm/drivers/char/sysrq.c	2005-05-18 15:06:21.000000000 +0200
@@ -119,7 +119,7 @@
 static void sysrq_handle_crashdump(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty)
 {
-	crash_kexec();
+	crash_kexec(pt_regs);
 }
 static struct sysrq_key_op sysrq_crashdump_op = {
 	.handler	= sysrq_handle_crashdump,


