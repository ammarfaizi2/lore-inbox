Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWDZHvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWDZHvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 03:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDZHvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 03:51:06 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:15819 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP
	id S1751143AbWDZHvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 03:51:05 -0400
Message-ID: <444F262D.3020402@sdl.hitachi.co.jp>
Date: Wed, 26 Apr 2006 16:50:05 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: SystemTAP <systemtap@sources.redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jim Keniston <jkenisto@us.ibm.com>,
       Yumiko Sugita <sugita@sdl.hitachi.co.jp>,
       Satoshi Oshima <soshima@redhat.com>, Hideo Aoki <haoki@redhat.com>
Subject: [PATCH] kprobe: fix resume execution on i386
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

Here is a patch to fix resume_execution() to handle
iret and absolute jump opcode correctly on i386.
This patch can be applied against 2.6.17-rc2.

Best regards,
-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
 kprobes.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)
diff -Narup a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c	2006-04-21 12:23:45.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-04-21 21:26:51.000000000 +0900
@@ -452,10 +452,11 @@ static void __kprobes resume_execution(s
 		*tos &= ~(TF_MASK | IF_MASK);
 		*tos |= kcb->kprobe_old_eflags;
 		break;
-	case 0xc3:		/* ret/lret */
-	case 0xcb:
-	case 0xc2:
+	case 0xc2:		/* iret/ret/lret */
+	case 0xc3:
 	case 0xca:
+	case 0xcb:
+	case 0xcf:
 	case 0xea:		/* jmp absolute -- eip is correct */
 		/* eip is already adjusted, no more changes required */
 		p->ainsn.boostable = 1;
@@ -463,10 +464,13 @@ static void __kprobes resume_execution(s
 	case 0xe8:		/* call relative - Fix return addr */
 		*tos = orig_eip + (*tos - copy_eip);
 		break;
+	case 0x9a:		/* call absolute -- same as call absolute, indirect */
+		*tos = orig_eip + (*tos - copy_eip);
+		goto no_change;
 	case 0xff:
 		if ((p->ainsn.insn[1] & 0x30) == 0x10) {
-			/* call absolute, indirect */
-			/*
+			/*
+			 * call absolute, indirect
 			 * Fix return addr; eip is correct.
 			 * But this is not boostable
 			 */



