Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWBVLFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWBVLFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWBVLFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:05:55 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:31172 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S932096AbWBVLFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:05:44 -0500
From: Jan Beulich <jbeulich@novell.com>
To: akpm@osdl.org
Subject: [PATCH] i386: fix uses of user_mode() vs. user_mode_vm()
Date: Wed, 22 Feb 2006 12:05:16 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, vincent.hanquez@cl.cam.ac.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221205.16812.jbeulich@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>commit 76381fee7e8feb4c22be636aa5d4765dbe4fbf9e
>Author: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
>Date:   Thu Jun 23 00:08:46 2005 -0700
>
>    [PATCH] xen: x86_64: use more usermode macro
>    
>    Make use of the user_mode macro where it's possible.  This is useful for Xen
>    because it will need only to redefine only the macro to a hypervisor call.
   
I am of the opinion that the above changeset is incomplete, i.e. it missed
converting some previous uses of user_mode to user_mode_vm. While most of
them could be considered just cosmetical, at least the one in die_nmi doesn't
appear to be.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>
Cc: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/crash.c 2.6.16-rc4-i386-user_mode_vm/arch/i386/kernel/crash.c
--- /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/crash.c	2006-02-20 09:12:32.000000000 +0100
+++ 2.6.16-rc4-i386-user_mode_vm/arch/i386/kernel/crash.c	2006-02-20 09:59:29.000000000 +0100
@@ -105,7 +105,7 @@ static int crash_nmi_callback(struct pt_
 		return 1;
 	local_irq_disable();
 
-	if (!user_mode(regs)) {
+	if (!user_mode_vm(regs)) {
 		crash_fixup_ss_esp(&fixed_regs, regs);
 		regs = &fixed_regs;
 	}
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/process.c 2.6.16-rc4-i386-user_mode_vm/arch/i386/kernel/process.c
--- /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/process.c	2006-02-20 09:12:32.000000000 +0100
+++ 2.6.16-rc4-i386-user_mode_vm/arch/i386/kernel/process.c	2006-02-20 09:59:29.000000000 +0100
@@ -295,7 +295,7 @@ void show_regs(struct pt_regs * regs)
 	printk("EIP: %04x:[<%08lx>] CPU: %d\n",0xffff & regs->xcs,regs->eip, smp_processor_id());
 	print_symbol("EIP is at %s\n", regs->eip);
 
-	if (user_mode(regs))
+	if (user_mode_vm(regs))
 		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
 	printk(" EFLAGS: %08lx    %s  (%s %.*s)\n",
 	       regs->eflags, print_tainted(), system_utsname.release,
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/traps.c 2.6.16-rc4-i386-user_mode_vm/arch/i386/kernel/traps.c
--- /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/traps.c	2006-02-20 09:12:32.000000000 +0100
+++ 2.6.16-rc4-i386-user_mode_vm/arch/i386/kernel/traps.c	2006-02-20 09:59:29.000000000 +0100
@@ -233,7 +233,7 @@ void show_registers(struct pt_regs *regs
 
 	esp = (unsigned long) (&regs->esp);
 	savesegment(ss, ss);
-	if (user_mode(regs)) {
+	if (user_mode_vm(regs)) {
 		in_kernel = 0;
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
@@ -623,7 +623,7 @@ void die_nmi (struct pt_regs *regs, cons
 	/* If we are in kernel we are probably nested up pretty bad
 	 * and might aswell get out now while we still can.
 	*/
-	if (!user_mode(regs)) {
+	if (!user_mode_vm(regs)) {
 		current->thread.trap_no = 2;
 		crash_kexec(regs);
 	}
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/mach-default/do_timer.h 2.6.16-rc4-i386-user_mode_vm/include/asm-i386/mach-default/do_timer.h
--- /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/mach-default/do_timer.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc4-i386-user_mode_vm/include/asm-i386/mach-default/do_timer.h	2006-02-20 09:59:30.000000000 +0100
@@ -18,7 +18,7 @@ static inline void do_timer_interrupt_ho
 {
 	do_timer(regs);
 #ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode_vm(regs));
 #endif
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/mach-visws/do_timer.h 2.6.16-rc4-i386-user_mode_vm/include/asm-i386/mach-visws/do_timer.h
--- /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/mach-visws/do_timer.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc4-i386-user_mode_vm/include/asm-i386/mach-visws/do_timer.h	2006-02-20 09:59:30.000000000 +0100
@@ -11,7 +11,7 @@ static inline void do_timer_interrupt_ho
 
 	do_timer(regs);
 #ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode_vm(regs));
 #endif
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/mach-voyager/do_timer.h 2.6.16-rc4-i386-user_mode_vm/include/asm-i386/mach-voyager/do_timer.h
--- /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/mach-voyager/do_timer.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc4-i386-user_mode_vm/include/asm-i386/mach-voyager/do_timer.h	2006-02-20 09:59:30.000000000 +0100
@@ -5,7 +5,7 @@ static inline void do_timer_interrupt_ho
 {
 	do_timer(regs);
 #ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode_vm(regs));
 #endif
 
 	voyager_timer_interrupt(regs);

