Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWA3Mo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWA3Mo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 07:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWA3Mo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 07:44:29 -0500
Received: from mail8.hitachi.co.jp ([133.145.228.43]:3970 "EHLO
	mail8.hitachi.co.jp") by vger.kernel.org with ESMTP id S932246AbWA3Mo1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 07:44:27 -0500
Message-ID: <43DE0A41.8020207@sdl.hitachi.co.jp>
Date: Mon, 30 Jan 2006 21:44:49 +0900
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
Subject: [PATCH][1/2] kprobe: kprobe-booster against 2.6.16-rc1 for i386
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

Here is a patch to clean up kprobe's resume_execute() for i386 arch
against linux-2.6.16-rc1 and also appliable against 2.6.16-rc1-mm4.

Before applying kprobe-booster, I'd like to cleanup codes. It is useful
to simplify (and easy to understand) kprobe-booster patch.

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
--- a/arch/i386/kernel/kprobes.c	2006-01-24 19:07:26.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-01-30 18:17:17.000000000 +0900
@@ -350,10 +350,10 @@ static void __kprobes resume_execution(s
 		struct pt_regs *regs, struct kprobe_ctlblk *kcb)
 {
 	unsigned long *tos = (unsigned long *)&regs->esp;
-	unsigned long next_eip = 0;
 	unsigned long copy_eip = (unsigned long)&p->ainsn.insn;
 	unsigned long orig_eip = (unsigned long)p->addr;

+	regs->eflags &= ~TF_MASK;
 	switch (p->ainsn.insn[0]) {
 	case 0x9c:		/* pushfl */
 		*tos &= ~(TF_MASK | IF_MASK);
@@ -363,9 +363,9 @@ static void __kprobes resume_execution(s
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
@@ -373,27 +373,21 @@ static void __kprobes resume_execution(s
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





