Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbUKYGVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUKYGVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 01:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbUKYGVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 01:21:53 -0500
Received: from ozlabs.org ([203.10.76.45]:5069 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262979AbUKYGVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 01:21:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16805.31192.805328.538179@cargo.ozlabs.ibm.com>
Date: Thu, 25 Nov 2004 17:21:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix hang on legacy iSeries
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we have uncovered a bug in the kernel exception exit path
which can cause iSeries machines to hang with interrupts disabled,
typically when unloading a module.  This patch fixes the bug and
should go in 2.6.10.  Here is the detailed explanation:

There are a couple of places in the exception exit path in entry.S
where we disable interrupts and then later reenable them.  We
hard-disable interrupts even on legacy iSeries (rather than
soft-disabling them) because the final part of the exception exit path
needs interrupts hard-disabled (even on legacy iSeries), because
otherwise an incoming interrupt could trash SRR0 and SRR1 and cause us
to lose state.

The intention was that each path that hard-disabled interrupts would
hard-enable them again, either explicitly or by executing an rfid
instruction (return from interrupt, doubleword).  However there was
one path where we didn't correctly hard-enable interrupts.  This meant
we could end up calling schedule() with interrupts hard-disabled and
then switch to the stopmachine thread (used in removing a module),
which spins polling a variable until another cpu changes it.  Since
local_irq_enable() etc. on legacy iSeries only soft-enable interrupts,
we got into the stopmachine thread with interrupts hard-disabled, and
the machine hung at that point.

This patch fixes it by making sure that when we go to re-enable
interrupts, the MSR value we are loading up actually does have the
MSR.EE (external interrupt enable) bit set.  Stephen Rothwell has
verified that this actually does fix the bug on iSeries.  The bug
also potentially exists on pSeries (and this patch fixes it), but
there it doesn't really matter, because schedule() will enable
interrupts (and on pSeries that means hard-enabling them), and because
the hypervisor doesn't mind you having interrupts hard-disabled for
extended periods on pSeries.  Note that all these comments about
pSeries also apply to POWER5 iSeries (i5) machines.

While I was there I noticed that we were jumping to ret_from_except
after calling do_IRQ on iSeries, rather than ret_from_except_lite,
meaning that we will restore registers 14-31 twice, unnecessarily.  I
changed it to jump to ret_from_except_lite instead, and Stephen
checked that this change doesn't cause any breakage.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -ruN linus-bk/arch/ppc64/kernel/entry.S linus-bk.fix.1/arch/ppc64/kernel/entry.S
--- linus-bk/arch/ppc64/kernel/entry.S	2004-10-09 15:46:33.000000000 +1000
+++ linus-bk.fix.1/arch/ppc64/kernel/entry.S	2004-11-25 09:39:02.000000000 +1100
@@ -497,10 +497,11 @@
 
 	li	r3,0
 	stb	r3,PACAPROCENABLED(r13)	/* ensure we are soft-disabled */
+	ori	r10,r10,MSR_EE
 	mtmsrd	r10			/* hard-enable again */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_IRQ
-	b	.ret_from_except		/* loop back and handle more */
+	b	.ret_from_except_lite		/* loop back and handle more */
 
 4:	stb	r5,PACAPROCENABLED(r13)
 #endif
@@ -574,6 +575,7 @@
 	li	r0,1
 	stb	r0,PACAPROCENABLED(r13)
 #endif
+	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1		/* reenable interrupts */
 	bl	.schedule
 	mfmsr	r10
@@ -591,6 +593,7 @@
 user_work:
 #endif
 	/* Enable interrupts */
+	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1
 
 	andi.	r0,r4,_TIF_NEED_RESCHED
