Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVDLRxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVDLRxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 13:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVDLKgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:36:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:5064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbVDLKbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:09 -0400
Message-Id: <200504121031.j3CAV5ZI005233@shell0.pdx.osdl.net>
Subject: [patch 028/198] ppc32: oops on kernel altivec assist exceptions
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, paulus@samba.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Mackerras <paulus@samba.org>

If we should happen to get an altivec assist exception while executing in
the kernel, we will currently try to handle it and fail, and end up oopsing
with (apparently) a segfault.  (An altivec assist exception occurs for
floating-point altivec instructions with denormalized inputs or outputs if
the altivec unit is in java mode.)

This patch checks explicitly if we are in user mode and prints a useful
message if not.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/kernel/traps.c |    7 +++++++
 1 files changed, 7 insertions(+)

diff -puN arch/ppc/kernel/traps.c~ppc32-oops-on-kernel-altivec-assist-exceptions arch/ppc/kernel/traps.c
--- 25/arch/ppc/kernel/traps.c~ppc32-oops-on-kernel-altivec-assist-exceptions	2005-04-12 03:21:10.167591192 -0700
+++ 25-akpm/arch/ppc/kernel/traps.c	2005-04-12 03:21:10.171590584 -0700
@@ -805,6 +805,13 @@ void AltivecAssistException(struct pt_re
 	if (regs->msr & MSR_VEC)
 		giveup_altivec(current);
 	preempt_enable();
+	if (!user_mode(regs)) {
+		printk(KERN_ERR "altivec assist exception in kernel mode"
+		       " at %lx\n", regs->nip);
+		debugger(regs);
+		die("altivec assist exception", regs, SIGFPE);
+		return;
+	}
 
 	err = emulate_altivec(regs);
 	if (err == 0) {
_
