Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVDDFkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVDDFkG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 01:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDDFkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 01:40:06 -0400
Received: from ozlabs.org ([203.10.76.45]:37567 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261545AbVDDFjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 01:39:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16976.53909.321274.501445@cargo.ozlabs.ibm.com>
Date: Mon, 4 Apr 2005 15:37:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc: oops on kernel altivec assist exceptions
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we should happen to get an altivec assist exception while executing
in the kernel, we will currently try to handle it and fail, and end up
oopsing with (apparently) a segfault.  (An altivec assist exception
occurs for floating-point altivec instructions with denormalized
inputs or outputs if the altivec unit is in java mode.)

This patch checks explicitly if we are in user mode and prints a
useful message if not.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/traps.c pmac-2.5/arch/ppc/kernel/traps.c
--- linux-2.5/arch/ppc/kernel/traps.c	2005-03-29 16:24:53.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/traps.c	2005-03-31 08:37:53.000000000 +1000
@@ -805,6 +828,13 @@
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
