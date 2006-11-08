Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753808AbWKHB0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbWKHB0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 20:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbWKHB0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 20:26:36 -0500
Received: from mail9.hitachi.co.jp ([133.145.228.44]:47571 "EHLO
	mail9.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1753808AbWKHB0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 20:26:35 -0500
Message-ID: <4551322D.4020108@hitachi.com>
Date: Wed, 08 Nov 2006 10:26:05 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Organization: Systems Development Lab., Hitachi, Ltd., Japan
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       SystemTAP <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>, Satoshi Oshima <soshima@redhat.com>,
       Hideo Aoki <haoki@redhat.com>,
       Yumiko Sugita <yumiko.sugita.yf@hitachi.com>
Subject: [Patch][kretprobe] fix kretprobe-booster to save regs and set status
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here is a patch to fix bugs in the kretprobe-booster.

There are two bugs in the kretprobe-booster.
1) It doesn't make room for gs registers.
2) It doesn't change status of the current kprobe. This
 status will effect the fault handling.
This patch fixes these bugs and, additionally, saves
skipped registers for compatibility with the original
kretprobe.

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>


---
 arch/i386/kernel/kprobes.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

Index: linux-2.6.19-rc4-mm2/arch/i386/kernel/kprobes.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/arch/i386/kernel/kprobes.c
+++ linux-2.6.19-rc4-mm2/arch/i386/kernel/kprobes.c
@@ -361,8 +361,11 @@ no_kprobe:
 	asm volatile ( ".global kretprobe_trampoline\n"
 			"kretprobe_trampoline: \n"
 			"	pushf\n"
-			/* skip cs, eip, orig_eax, es, ds */
-			"	subl $20, %esp\n"
+			/* skip cs, eip, orig_eax */
+			"	subl $12, %esp\n"
+			"	pushl %gs\n"
+			"	pushl %ds\n"
+			"	pushl %es\n"
 			"	pushl %eax\n"
 			"	pushl %ebp\n"
 			"	pushl %edi\n"
@@ -373,10 +376,10 @@ no_kprobe:
 			"	movl %esp, %eax\n"
 			"	call trampoline_handler\n"
 			/* move eflags to cs */
-			"	movl 48(%esp), %edx\n"
-			"	movl %edx, 44(%esp)\n"
+			"	movl 52(%esp), %edx\n"
+			"	movl %edx, 48(%esp)\n"
 			/* save true return address on eflags */
-			"	movl %eax, 48(%esp)\n"
+			"	movl %eax, 52(%esp)\n"
 			"	popl %ebx\n"
 			"	popl %ecx\n"
 			"	popl %edx\n"
@@ -384,8 +387,8 @@ no_kprobe:
 			"	popl %edi\n"
 			"	popl %ebp\n"
 			"	popl %eax\n"
-			/* skip eip, orig_eax, es, ds */
-			"	addl $16, %esp\n"
+			/* skip eip, orig_eax, es, ds, gs */
+			"	addl $20, %esp\n"
 			"	popf\n"
 			"	ret\n");
 }
@@ -404,6 +407,10 @@ fastcall void *__kprobes trampoline_hand
 	INIT_HLIST_HEAD(&empty_rp);
 	spin_lock_irqsave(&kretprobe_lock, flags);
 	head = kretprobe_inst_table_head(current);
+	/* fixup registers */
+	regs->xcs = __KERNEL_CS;
+	regs->eip = trampoline_address;
+	regs->orig_eax = 0xffffffff;

 	/*
 	 * It is possible to have multiple instances associated with a given
@@ -425,6 +432,7 @@ fastcall void *__kprobes trampoline_hand

 		if (ri->rp && ri->rp->handler){
 			__get_cpu_var(current_kprobe) = &ri->rp->kp;
+			get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
 			ri->rp->handler(ri, regs);
 			__get_cpu_var(current_kprobe) = NULL;
 		}


