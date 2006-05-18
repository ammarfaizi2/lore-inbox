Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWERVct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWERVct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 17:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWERVct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 17:32:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22672 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751400AbWERVcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 17:32:48 -0400
Message-ID: <446CE7E2.8050302@redhat.com>
Date: Thu, 18 May 2006 17:32:18 -0400
From: Satoshi Oshima <soshima@redhat.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Ananth N Mavinakayanahalli <mananth@in.ibm.com>,
       Jim Keniston <jkenisto@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       sugita <sugita@sdl.hitachi.co.jp>
Subject: [PATCH] kprobes: bad manupilation of 2 byte opcode on x86_64
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi and Andrew,

I found a bug of kprobes on x86_64.
I attached the fix of this bug.


Problem:

If we put a probe onto a callq instruction and the probe
is executed, kernel panic of Bad RIP value occurs.

Root cause:

If resume_execution() found 0xff at first byte of 
p->ainsn.insn, it must check the _second_ byte.
But current resume_execution check _first_ byte again.


I changed it checks second byte of p->ainsn.insn.

Kprobes on i386 don't have this problem, because
the implementation is a little bit different from
x86_64.


Regards,

Satoshi Oshima
Hitachi Computer Product (America) Inc.

----------------------------------------------

diff -Narup linux-2.6.17-rc3-mm1.orig/arch/x86_64/kernel/kprobes.c x86_64_bugifx/arch/x86_64/kernel/kprobes.c
--- linux-2.6.17-rc3-mm1.orig/arch/x86_64/kernel/kprobes.c	2006-05-04 12:34:44.000000000 -0400
+++ x86_64_bugifx/arch/x86_64/kernel/kprobes.c	2006-05-12 16:02:35.000000000 -0400
@@ -514,13 +514,13 @@ static void __kprobes resume_execution(s
 		*tos = orig_rip + (*tos - copy_rip);
 		break;
 	case 0xff:
-		if ((*insn & 0x30) == 0x10) {
+		if ((insn[1] & 0x30) == 0x10) {
 			/* call absolute, indirect */
 			/* Fix return addr; rip is correct. */
 			next_rip = regs->rip;
 			*tos = orig_rip + (*tos - copy_rip);
-		} else if (((*insn & 0x31) == 0x20) ||	/* jmp near, absolute indirect */
-			   ((*insn & 0x31) == 0x21)) {	/* jmp far, absolute indirect */
+		} else if (((insn[1] & 0x31) == 0x20) ||	/* jmp near, absolute indirect */
+			   ((insn[1] & 0x31) == 0x21)) {	/* jmp far, absolute indirect */
 			/* rip is correct. */
 			next_rip = regs->rip;
 		}

