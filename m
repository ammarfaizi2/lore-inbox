Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUCXLwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 06:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUCXLwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 06:52:34 -0500
Received: from ozlabs.org ([203.10.76.45]:65483 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263307AbUCXLwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 06:52:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.30397.114257.314001@cargo.ozlabs.ibm.com>
Date: Wed, 24 Mar 2004 22:53:33 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: torvalds@osdl.org, trini@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix ppc32 sys_swapcontext
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a bug in the swapcontext system call on ppc32.
On ppc32, the system call entry only saves the volatile registers,
except in the case of a few system calls (e.g. fork) which need all
the registers saved.  Swapcontext needs all the registers but we
weren't saving them all.  This patch fixes that.

Please apply.

Thanks,
Paul.

diff -urN pmac-2.5/arch/ppc/kernel/entry.S g5-ppc64/arch/ppc/kernel/entry.S
--- pmac-2.5/arch/ppc/kernel/entry.S	2004-02-16 08:19:48.000000000 +1100
+++ g5-ppc64/arch/ppc/kernel/entry.S	2004-03-24 09:47:12.000000000 +1100
@@ -414,6 +414,14 @@
 	stw	r0,TRAP(r1)		/* register set saved */
 	b	sys_clone
 
+	.globl	ppc_swapcontext
+ppc_swapcontext:
+	SAVE_NVGPRS(r1)
+	lwz	r0,TRAP(r1)
+	rlwinm	r0,r0,0,0,30		/* clear LSB to indicate full */
+	stw	r0,TRAP(r1)		/* register set saved */
+	b	sys_swapcontext
+
 /*
  * This routine switches between two different tasks.  The process
  * state of one is saved on its kernel stack.  Then the state
diff -urN pmac-2.5/arch/ppc/kernel/misc.S g5-ppc64/arch/ppc/kernel/misc.S
--- pmac-2.5/arch/ppc/kernel/misc.S	2004-03-16 20:11:56.000000000 +1100
+++ g5-ppc64/arch/ppc/kernel/misc.S	2004-03-24 09:46:40.000000000 +1100
@@ -1363,7 +1363,7 @@
 	.long sys_clock_gettime
 	.long sys_clock_getres
 	.long sys_clock_nanosleep
-	.long sys_swapcontext
+	.long ppc_swapcontext
 	.long sys_tgkill	/* 250 */
 	.long sys_utimes
 	.long sys_statfs64
