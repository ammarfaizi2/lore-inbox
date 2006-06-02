Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWFBL4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWFBL4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 07:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWFBL4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 07:56:45 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51100 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751138AbWFBL4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 07:56:44 -0400
Date: Fri, 2 Jun 2006 13:57:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fall back to old-style call trace if no unwinding is possible
Message-ID: <20060602115709.GA29066@elte.hu>
References: <448042C1.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448042C1.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5032]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hm, could you please merge this ontop of the stacktrace-output 
beautification patch below that Andrew already has in his post-mm2 tree? 
(or the other way around - whichever you prefer)

	Ingo

-----------------------------------
Subject: beautify x86_64 backtraces
From: Ingo Molnar <mingo@elte.hu>

make x86_64 stack backtraces human-readable.

Before:

sshd          S ffff810033d05bf8     0  3119   2816  3121               (NOTLB)
ffff810033d05bf8 00000000000614d7 ffff810034b230b8 ffff810034b22ee0 
       ffffffff8062c900 0000003835024076 0000000034b23680 ffff810034b22ee0 
       0000000000000000 ffffffff80502099 
Call Trace:
  [<ffffffff804ffc51>] schedule_timeout+0x22/0xb3
        [<ffffffff804e98a3>] unix_stream_recvmsg+0x274/0x561
        [<ffffffff80497124>] do_sock_read+0x9b/0x9f
        [<ffffffff80497271>] sock_aio_read+0x57/0x67
        [<ffffffff8027976e>] do_sync_read+0xf0/0x12e
        [<ffffffff80279a10>] vfs_read+0xe5/0x17e  [<ffffffff8027a505>] sys_read+0x45/0x6e
        [<ffffffff8020946a>] system_call+0x7e/0x83

After:

sshd          S ffff81003981dbf8     0  2875   2805  2878               (NOTLB)
 ffff81003981dbf8 0000000000001592 ffff81003f5ce3e8 ffff81003f5ce210
 ffff81003ffaa0d0 00000009afd9e025 000000013f5ce9b0 ffff81003f5ce210
 0000000000000000 ffffffff80502049
Call Trace:
 [<ffffffff804ffc01>] schedule_timeout+0x22/0xb3
 [<ffffffff804e9853>] unix_stream_recvmsg+0x274/0x561
 [<ffffffff804970d4>] do_sock_read+0x9b/0x9f
 [<ffffffff80497221>] sock_aio_read+0x57/0x67
 [<ffffffff8027971e>] do_sync_read+0xf0/0x12e
 [<ffffffff802799c0>] vfs_read+0xe5/0x17e
 [<ffffffff8027a4b5>] sys_read+0x45/0x6e
 [<ffffffff8020946a>] system_call+0x7e/0x83

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/process.c |    2 +-
 arch/x86_64/kernel/traps.c   |   27 +++++++++++----------------
 arch/x86_64/mm/fault.c       |    1 -
 include/asm-x86_64/kdebug.h  |    2 +-
 4 files changed, 13 insertions(+), 19 deletions(-)

Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -296,7 +296,7 @@ void __show_regs(struct pt_regs * regs)
 		init_utsname()->version);
 	printk("RIP: %04lx:[<%016lx>] ", regs->cs & 0xffff, regs->rip);
 	printk_address(regs->rip); 
-	printk("\nRSP: %04lx:%016lx  EFLAGS: %08lx\n", regs->ss, regs->rsp,
+	printk("RSP: %04lx:%016lx  EFLAGS: %08lx\n", regs->ss, regs->rsp,
 		regs->eflags);
 	printk("RAX: %016lx RBX: %016lx RCX: %016lx\n",
 	       regs->rax, regs->rbx, regs->rcx);
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -110,7 +110,7 @@ static int kstack_depth_to_print = 10;
 
 #ifdef CONFIG_KALLSYMS
 # include <linux/kallsyms.h>
-int printk_address(unsigned long address)
+void printk_address(unsigned long address)
 {
 	unsigned long offset = 0, symsize;
 	const char *symname;
@@ -120,17 +120,19 @@ int printk_address(unsigned long address
 
 	symname = kallsyms_lookup(address, &symsize, &offset,
 					&modname, namebuf);
-	if (!symname)
-		return printk(" [<%016lx>]", address);
+	if (!symname) {
+		printk(" [<%016lx>]\n", address);
+		return;
+	}
 	if (!modname)
 		modname = delim = ""; 		
-	return printk(" [<%016lx>] %s%s%s%s+0x%lx/0x%lx",
+	printk(" [<%016lx>] %s%s%s%s+0x%lx/0x%lx\n",
 		address, delim, modname, delim, symname, offset, symsize);
 }
 #else
-int printk_address(unsigned long address)
+void printk_address(unsigned long address)
 {
-	return printk(" [<%016lx>]", address);
+	printk(" [<%016lx>]\n", address);
 }
 #endif
 
@@ -230,15 +232,8 @@ in_exception_stack(unsigned cpu, unsigne
 
 static void show_trace_unwind(struct unwind_frame_info *info, void *context)
 {
-	int i = 11;
-
 	while (unwind(info) == 0 && UNW_PC(info)) {
-		if (i > 50) {
-			printk("\n       ");
-			i = 7;
-		} else
-			i += printk(" ");
-		i += printk_address(UNW_PC(info));
+		printk_address(UNW_PC(info));
 		if (arch_unw_user_mode(info))
 			break;
 	}
@@ -385,8 +380,8 @@ static void _show_stack(struct task_stru
 			break;
 		}
 		if (i && ((i % 4) == 0))
-			printk("\n       ");
-		printk("%016lx ", *stack++);
+			printk("\n");
+		printk(" %016lx", *stack++);
 		touch_nmi_watchdog();
 	}
 	show_trace(tsk, regs, rsp);
Index: linux/arch/x86_64/mm/fault.c
===================================================================
--- linux.orig/arch/x86_64/mm/fault.c
+++ linux/arch/x86_64/mm/fault.c
@@ -569,7 +569,6 @@ no_context:
 		printk(KERN_ALERT "Unable to handle kernel paging request");
 	printk(" at %016lx RIP: \n" KERN_ALERT,address);
 	printk_address(regs->rip);
-	printk("\n");
 	dump_pagetable(address);
 	tsk->thread.cr2 = address;
 	tsk->thread.trap_no = 14;
Index: linux/include/asm-x86_64/kdebug.h
===================================================================
--- linux.orig/include/asm-x86_64/kdebug.h
+++ linux/include/asm-x86_64/kdebug.h
@@ -49,7 +49,7 @@ static inline int notify_die(enum die_va
 	return atomic_notifier_call_chain(&die_chain, val, &args);
 } 
 
-extern int printk_address(unsigned long address);
+extern void printk_address(unsigned long address);
 extern void die(const char *,struct pt_regs *,long);
 extern void __die(const char *,struct pt_regs *,long);
 extern void show_registers(struct pt_regs *regs);
