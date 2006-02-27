Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbWB0L5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWB0L5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 06:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWB0L5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 06:57:09 -0500
Received: from mail8.hitachi.co.jp ([133.145.228.43]:61591 "EHLO
	mail8.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1750849AbWB0L5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 06:57:08 -0500
Message-ID: <4402E914.9010206@sdl.hitachi.co.jp>
Date: Mon, 27 Feb 2006 20:57:08 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
CC: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       SystemTAP <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>, linux-kernel@vger.kernel.org,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: [PATCH][take2][1/2] kprobe: cleanup resume_execute against 2.6.16-rc5
 for i386
References: <43DE0A41.8020207@sdl.hitachi.co.jp>
In-Reply-To: <43DE0A41.8020207@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

The kprobe-booster's patches in current -mm tree
(kprobes-clean-up-resume_execute.patch and x86-kprobes-booster.patch)
are under the influence of the NX-protection support patch
which was merged into linus tree(2.6.16-rc5).
So I fixed those patches.

Here is a patch to clean up kprobe's resume_execute() for i386 arch
against linux-2.6.16-rc5.
This patch makes resume_execute() simple, and useful to simplify the
kprobe-booster patch.

Could you replace the previous patches with these patches?

Best Regards,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 kprobes.c |   26 ++++++++++----------------
 1 files changed, 10 insertions(+), 16 deletions(-)
diff -Narup a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c	2006-02-27 16:21:33.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-02-27 16:30:58.000000000 +0900
@@ -362,10 +362,10 @@ static void __kprobes resume_execution(s
 		struct pt_regs *regs, struct kprobe_ctlblk *kcb)
 {
 	unsigned long *tos = (unsigned long *)&regs->esp;
-	unsigned long next_eip = 0;
 	unsigned long copy_eip = (unsigned long)p->ainsn.insn;
 	unsigned long orig_eip = (unsigned long)p->addr;

+	regs->eflags &= ~TF_MASK;
 	switch (p->ainsn.insn[0]) {
 	case 0x9c:		/* pushfl */
 		*tos &= ~(TF_MASK | IF_MASK);
@@ -375,9 +375,9 @@ static void __kprobes resume_execution(s
 	case 0xcb:
 	case 0xc2:
 	case 0xca:
-		regs->eflags &= ~TF_MASK;
-		/* eip is already adjusted, no more changes required*/
-		return;
+	case 0xea:		/* jmp absolute -- eip is correct */
+		/* eip is already adjusted, no more changes required */
+		goto no_change;
 	case 0xe8:		/* call relative - Fix return addr */
 		*tos = orig_eip + (*tos - copy_eip);
 		break;
@@ -385,27 +385,21 @@ static void __kprobes resume_execution(s
 		if ((p->ainsn.insn[1] & 0x30) == 0x10) {
 			/* call absolute, indirect */
 			/* Fix return addr; eip is correct. */
-			next_eip = regs->eip;
 			*tos = orig_eip + (*tos - copy_eip);
+			goto no_change;
 		} else if (((p->ainsn.insn[1] & 0x31) == 0x20) ||	/* jmp near, absolute indirect */
 			   ((p->ainsn.insn[1] & 0x31) == 0x21)) {	/* jmp far, absolute indirect */
 			/* eip is correct. */
-			next_eip = regs->eip;
+			goto no_change;
 		}
-		break;
-	case 0xea:		/* jmp absolute -- eip is correct */
-		next_eip = regs->eip;
-		break;
 	default:
 		break;
 	}

-	regs->eflags &= ~TF_MASK;
-	if (next_eip) {
-		regs->eip = next_eip;
-	} else {
-		regs->eip = orig_eip + (regs->eip - copy_eip);
-	}
+	regs->eip = orig_eip + (regs->eip - copy_eip);
+
+no_change:
+	return;
 }

 /*


