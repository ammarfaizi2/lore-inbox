Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWBMMNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWBMMNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 07:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWBMMNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 07:13:05 -0500
Received: from mail7.hitachi.co.jp ([133.145.228.42]:28045 "EHLO
	mail7.hitachi.co.jp") by vger.kernel.org with ESMTP id S932099AbWBMMNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 07:13:04 -0500
Message-ID: <43F077C7.8060706@sdl.hitachi.co.jp>
Date: Mon, 13 Feb 2006 21:12:55 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, ananth@in.ibm.com, prasanna@in.ibm.com,
       anil.s.keshavamurthy@intel.com
CC: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       systemtap@sources.redhat.com, jkenisto@us.ibm.com,
       linux-kernel@vger.kernel.org, sugita@sdl.hitachi.co.jp,
       soshima@redhat.com, haoki@redhat.com
Subject: [PATCH][take 2] kretprobe: kretprobe-booster against 2.6.16-rc2 for
 i386
References: <43DE0A53.3060801@sdl.hitachi.co.jp>	<43DEC13E.8020200@sdl.hitachi.co.jp> <20060131145540.3e9a78be.akpm@osdl.org> <43E0B177.9020607@sdl.hitachi.co.jp>
In-Reply-To: <43E0B177.9020607@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

Here is a patch of kretprobe-booster for i386 against linux-2.6.16-rc2.
In the previous kretprobe-booster patch, I had a mistake about stack
register. In this patch, the bug is fixed.

This bug was pointed by Chuck Ebbert, and there were two different
patches(Chuck's and mine) to fix it. But both patches were dropped
from -mm tree. So, I merged my patch into kretprobe-booster patch
and attached it to this mail.

Could you replace the previous kretprobe-booster patch with this
patch?

The description of kretprobe-booster:
====================================
In the normal operation, kretprobe make a target function return
to trampoline code. A kprobe (called trampoline_probe) has
been inserted at the trampoline code. When the kernel hits this
kprobe, it calls kretprobe's handler and it returns to original
return address.

Kretprobe-booster patch removes the trampoline_probe. It allows
the tranpoline code to call kretprobe's handler directly instead
of invoking kprobe. The trampoline code returns to original return
address.

This new tranpoline code stores and restores registers, so the
kretprobe handler is still able to access those registers.

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 kprobes.c |   56 +++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 35 insertions(+), 21 deletions(-)
diff -Narup a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c	2006-02-13 15:01:31.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-02-13 15:06:37.000000000 +0900
@@ -255,17 +255,44 @@ no_kprobe:
  * here. When a retprobed function returns, this probe is hit and
  * trampoline_probe_handler() runs, calling the kretprobe's handler.
  */
- void kretprobe_trampoline_holder(void)
+ void __kprobes kretprobe_trampoline_holder(void)
  {
- 	asm volatile (  ".global kretprobe_trampoline\n"
+	 asm volatile ( ".global kretprobe_trampoline\n"
  			"kretprobe_trampoline: \n"
- 			"nop\n");
- }
+			"	pushf\n"
+			/* skip cs, eip, orig_eax, es, ds */
+			"	subl $20, %esp\n"
+			"	pushl %eax\n"
+			"	pushl %ebp\n"
+			"	pushl %edi\n"
+			"	pushl %esi\n"
+			"	pushl %edx\n"
+			"	pushl %ecx\n"
+			"	pushl %ebx\n"
+			"	movl %esp, %eax\n"
+			"	call trampoline_handler\n"
+			/* move eflags to cs */
+			"	movl 48(%esp), %edx\n"
+			"	movl %edx, 44(%esp)\n"
+			/* save true return address on eflags */
+			"	movl %eax, 48(%esp)\n"
+			"	popl %ebx\n"
+			"	popl %ecx\n"
+			"	popl %edx\n"
+			"	popl %esi\n"
+			"	popl %edi\n"
+			"	popl %ebp\n"
+			"	popl %eax\n"
+			/* skip eip, orig_eax, es, ds */
+			"	addl $16, %esp\n"
+			"	popf\n"
+			"	ret\n");
+}

 /*
- * Called when we hit the probe point at kretprobe_trampoline
+ * Called from kretprobe_trampoline
  */
-int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+fastcall void *__kprobes trampoline_handler(struct pt_regs *regs)
 {
         struct kretprobe_instance *ri = NULL;
         struct hlist_head *head;
@@ -310,18 +337,10 @@ int __kprobes trampoline_probe_handler(s
 	}

 	BUG_ON(!orig_ret_address || (orig_ret_address == trampoline_address));
-	regs->eip = orig_ret_address;

-	reset_current_kprobe();
 	spin_unlock_irqrestore(&kretprobe_lock, flags);
-	preempt_enable_no_resched();

-	/*
-	 * By returning a non-zero value, we are telling
-	 * kprobe_handler() that we don't want the post_handler
-	 * to run (and have re-enabled preemption)
-	 */
-        return 1;
+	return (void*)orig_ret_address;
 }

 /*
@@ -552,12 +571,7 @@ int __kprobes longjmp_break_handler(stru
 	return 0;
 }

-static struct kprobe trampoline_p = {
-	.addr = (kprobe_opcode_t *) &kretprobe_trampoline,
-	.pre_handler = trampoline_probe_handler
-};
-
 int __init arch_init_kprobes(void)
 {
-	return register_kprobe(&trampoline_p);
+	return 0;
 }


