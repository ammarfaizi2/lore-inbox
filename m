Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVDLSV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVDLSV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVDLKb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:31:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:54215 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262107AbVDLKaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:30:55 -0400
Message-Id: <200504121030.j3CAUmY1005151@shell0.pdx.osdl.net>
Subject: [patch 010/198] fix crash in entry.S restore_all
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, stsp@aknet.ru
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Stas Sergeev <stsp@aknet.ru>

Fix the access-above-bottom-of-stack crash.

1. Allows to preserve the valueable optimization

2. Works for NMIs

3.  Doesn't care whether or not there are more of the like instances
   where the stack is left empty.

4. Seems to work for me without the crashes:) 

(akpm: this is still under discussion, although I _think_ it's OK.  You might
want to hold off)

Signed-off-by: Stas Sergeev <stsp@aknet.ru> 
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/entry.S   |    3 +++
 25-akpm/arch/i386/kernel/process.c |   12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/process.c~fix-crash-in-entrys-restore_all arch/i386/kernel/process.c
--- 25/arch/i386/kernel/process.c~fix-crash-in-entrys-restore_all	2005-04-12 03:21:05.840249048 -0700
+++ 25-akpm/arch/i386/kernel/process.c	2005-04-12 03:21:05.845248288 -0700
@@ -405,7 +405,17 @@ int copy_thread(int nr, unsigned long cl
 	childregs->esp = esp;
 
 	p->thread.esp = (unsigned long) childregs;
-	p->thread.esp0 = (unsigned long) (childregs+1);
+	/*
+	 * The below -8 is to reserve 8 bytes on top of the ring0 stack.
+	 * This is necessary to guarantee that the entire "struct pt_regs"
+	 * is accessable even if the CPU haven't stored the SS/ESP registers
+	 * on the stack (interrupt gate does not save these registers
+	 * when switching to the same priv ring).
+	 * Therefore beware: accessing the xss/esp fields of the
+	 * "struct pt_regs" is possible, but they may contain the
+	 * completely wrong values.
+	 */
+	p->thread.esp0 = (unsigned long) (childregs+1) - 8;
 
 	p->thread.eip = (unsigned long) ret_from_fork;
 
diff -puN arch/i386/kernel/entry.S~fix-crash-in-entrys-restore_all arch/i386/kernel/entry.S
--- 25/arch/i386/kernel/entry.S~fix-crash-in-entrys-restore_all	2005-04-12 03:21:05.841248896 -0700
+++ 25-akpm/arch/i386/kernel/entry.S	2005-04-12 03:21:05.846248136 -0700
@@ -245,6 +245,9 @@ syscall_exit:
 
 restore_all:
 	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
+	# Warning: OLDSS(%esp) contains the wrong/random values if we
+	# are returning to the kernel.
+	# See comments in process.c:copy_thread() for details.
 	movb OLDSS(%esp), %ah
 	movb CS(%esp), %al
 	andl $(VM_MASK | (4 << 8) | 3), %eax
_
