Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVKRNak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVKRNak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 08:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVKRNak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 08:30:40 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:43429
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750717AbVKRNaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 08:30:39 -0500
Message-Id: <437DE59C.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 18 Nov 2005 14:30:52 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Cc: <vincent.hanquez@cl.cam.ac.uk>
Subject: [PATCH] i386: change more uses of user_mode to user_mode_vm
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part1D3F2E9C.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part1D3F2E9C.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>commit 76381fee7e8feb4c22be636aa5d4765dbe4fbf9e
>Author: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
>Date:   Thu Jun 23 00:08:46 2005 -0700
>
>    [PATCH] xen: x86_64: use more usermode macro
>    
>    Make use of the user_mode macro where it's possible.  This is
useful for Xen
>    because it will need only to redefine only the macro to a
hypervisor call.
   
Having just learned about the existance of user_mode_vm, I am of the
opinion that the above changeset is incomplete, i.e. it missed
converting some previous uses of user_mode to user_mode_vm. While most
of them could be considered just cosmentical, at least the one in
die_nmi isn't.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

(actual patch attached)

--=__Part1D3F2E9C.1__=
Content-Type: text/plain; name="linux-2.6.15-rc1-i386-user_mode_vm.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.15-rc1-i386-user_mode_vm.patch"

>commit 76381fee7e8feb4c22be636aa5d4765dbe4fbf9e
>Author: Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>
>Date:   Thu Jun 23 00:08:46 2005 -0700
>
>    [PATCH] xen: x86_64: use more usermode macro
>    
>    Make use of the user_mode macro where it's possible.  This is useful for Xen
>    because it will need only to redefine only the macro to a hypervisor call.
   
Having just learned about the existance of user_mode_vm, I am of the
opinion that the above changeset is incomplete, i.e. it missed
converting some previous uses of user_mode to user_mode_vm. While most
of them could be considered just cosmentical, at least the one in
die_nmi isn't.

From: Jan Beulich <jbeulich@novell.com>

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.15-rc1/arch/i386/kernel/crash.c	2005-11-18 13:11:59.000000000 +0100
+++ 2.6.15-rc1/arch/i386/kernel/crash.c	2005-11-18 13:17:57.000000000 +0100
@@ -142,7 +142,7 @@ static int crash_nmi_callback(struct pt_
 		return 1;
 	local_irq_disable();
 
-	if (!user_mode(regs)) {
+	if (!user_mode_vm(regs)) {
 		crash_setup_regs(&fixed_regs, regs);
 		regs = &fixed_regs;
 	}
--- linux-2.6.15-rc1/arch/i386/kernel/process.c	2005-11-18 13:11:59.000000000 +0100
+++ 2.6.15-rc1/arch/i386/kernel/process.c	2005-11-18 13:20:12.000000000 +0100
@@ -294,7 +294,7 @@ void show_regs(struct pt_regs * regs)
 	printk("EIP: %04x:[<%08lx>] CPU: %d\n",0xffff & regs->xcs,regs->eip, smp_processor_id());
 	print_symbol("EIP is at %s\n", regs->eip);
 
-	if (user_mode(regs))
+	if (user_mode_vm(regs))
 		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
 	printk(" EFLAGS: %08lx    %s  (%s)\n",
 	       regs->eflags, print_tainted(), system_utsname.release);
--- linux-2.6.15-rc1/arch/i386/kernel/traps.c	2005-11-18 13:11:59.000000000 +0100
+++ 2.6.15-rc1/arch/i386/kernel/traps.c	2005-11-18 13:21:19.000000000 +0100
@@ -210,7 +210,7 @@ void show_registers(struct pt_regs *regs
 
 	esp = (unsigned long) (&regs->esp);
 	savesegment(ss, ss);
-	if (user_mode(regs)) {
+	if (user_mode_vm(regs)) {
 		in_kernel = 0;
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
@@ -589,7 +589,7 @@ void die_nmi (struct pt_regs *regs, cons
 	/* If we are in kernel we are probably nested up pretty bad
 	 * and might aswell get out now while we still can.
 	*/
-	if (!user_mode(regs)) {
+	if (!user_mode_vm(regs)) {
 		current->thread.trap_no = 2;
 		crash_kexec(regs);
 	}
--- linux-2.6.15-rc1/include/asm-i386/mach-default/do_timer.h	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.15-rc1/include/asm-i386/mach-default/do_timer.h	2005-11-18 13:16:52.000000000 +0100
@@ -18,7 +18,7 @@ static inline void do_timer_interrupt_ho
 {
 	do_timer(regs);
 #ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode_vm(regs));
 #endif
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
--- linux-2.6.15-rc1/include/asm-i386/mach-visws/do_timer.h	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.15-rc1/include/asm-i386/mach-visws/do_timer.h	2005-11-18 13:17:05.000000000 +0100
@@ -11,7 +11,7 @@ static inline void do_timer_interrupt_ho
 
 	do_timer(regs);
 #ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode_vm(regs));
 #endif
 /*
  * In the SMP case we use the local APIC timer interrupt to do the
--- linux-2.6.15-rc1/include/asm-i386/mach-voyager/do_timer.h	2005-10-28 02:02:08.000000000 +0200
+++ 2.6.15-rc1/include/asm-i386/mach-voyager/do_timer.h	2005-11-18 13:17:16.000000000 +0100
@@ -5,7 +5,7 @@ static inline void do_timer_interrupt_ho
 {
 	do_timer(regs);
 #ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode_vm(regs));
 #endif
 
 	voyager_timer_interrupt(regs);

--=__Part1D3F2E9C.1__=--
