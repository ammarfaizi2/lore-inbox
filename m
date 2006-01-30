Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWA3Mov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWA3Mov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 07:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWA3Mov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 07:44:51 -0500
Received: from mail8.hitachi.co.jp ([133.145.228.43]:20610 "EHLO
	mail8.hitachi.co.jp") by vger.kernel.org with ESMTP id S932246AbWA3Moj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 07:44:39 -0500
Message-ID: <43DE0A53.3060801@sdl.hitachi.co.jp>
Date: Mon, 30 Jan 2006 21:45:07 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
CC: SystemTAP <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-kernel@vger.kernel.org,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: [PATCH] kretprobe: kretprobe-booster against 2.6.16-rc1 for i386
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

Here is a patch of the kretprobe-booster for i386 arch against
linux-2.6.16-rc1 and also appliable against 2.6.16-rc1-mm4.

Best Regards,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 kprobes.c |   56 ++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 20 deletions(-)
diff -Narup a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c	2006-01-24 19:07:26.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-01-30 18:40:12.000000000 +0900
@@ -255,17 +255,45 @@ no_kprobe:
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
+			"	subl $8, %esp\n"
+			"	pushf\n"
+			"	subl $20, %esp\n"
+			"	pushl %eax\n"
+			"	pushl %ebp\n"
+			"	pushl %edi\n"
+			"	pushl %esi\n"
+			"	pushl %edx\n"
+			"	pushl %ecx\n"
+			"	pushl %ebx\n"
+			"	movl %esp, %eax\n"
+			"	pushl %eax\n"
+			"	addl $60, %eax\n"
+			"	movl %eax, 56(%esp)\n"
+			"	movl $trampoline_handler, %eax\n"
+			"	call *%eax\n"
+			"	addl $4, %esp\n"
+			"	movl %eax, 56(%esp)\n"
+			"	popl %ebx\n"
+			"	popl %ecx\n"
+			"	popl %edx\n"
+			"	popl %esi\n"
+			"	popl %edi\n"
+			"	popl %ebp\n"
+			"	popl %eax\n"
+			"	addl $20, %esp\n"
+			"	popf\n"
+			"	addl $4, %esp\n"
+			"	ret\n");
+}

 /*
- * Called when we hit the probe point at kretprobe_trampoline
+ * Called from kretprobe_trampoline
  */
-int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+asmlinkage void *__kprobes trampoline_handler(struct pt_regs *regs)
 {
         struct kretprobe_instance *ri = NULL;
         struct hlist_head *head;
@@ -310,18 +338,11 @@ int __kprobes trampoline_probe_handler(s
 	}

 	BUG_ON(!orig_ret_address || (orig_ret_address == trampoline_address));
-	regs->eip = orig_ret_address;

-	reset_current_kprobe();
 	spin_unlock_irqrestore(&kretprobe_lock, flags);
 	preempt_enable_no_resched();

-	/*
-	 * By returning a non-zero value, we are telling
-	 * kprobe_handler() that we don't want the post_handler
-	 * to run (and have re-enabled preemption)
-	 */
-        return 1;
+	return (void*)orig_ret_address;
 }

 /*
@@ -552,12 +573,7 @@ int __kprobes longjmp_break_handler(stru
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





