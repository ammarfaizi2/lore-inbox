Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUDRFn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbUDRFn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:43:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:46487 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264138AbUDRFnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:43:53 -0400
Subject: [PATCH] ppc64: Fix CPU hot unplug deadlock
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082266707.2135.325.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Apr 2004 15:38:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

My RTAS locking fixes incorrectly added a spinlock around the function
used to stop a CPU, that function never returns, thus the lock becomes
stale. The correct fix is to disable interrupts instead (the RTAS params
beeing per-CPU, this should be safe enough)

Ben.

diff -urN linux-2.5/arch/ppc64/kernel/rtas.c ppc64-linux-2.5/arch/ppc64/kernel/rtas.c
--- linux-2.5/arch/ppc64/kernel/rtas.c	2004-04-17 12:39:03.253986984 +1000
+++ ppc64-linux-2.5/arch/ppc64/kernel/rtas.c	2004-04-18 15:35:41.871029480 +1000
@@ -504,9 +504,9 @@
 void rtas_stop_self(void)
 {
 	struct rtas_args *rtas_args = &(get_paca()->xRtas);
-	unsigned long s;
 
-	spin_lock_irqsave(&rtas.lock, s);
+	local_irq_disable(s);
+
 	rtas_args->token = rtas_token("stop-self");
 	BUG_ON(rtas_args->token == RTAS_UNKNOWN_SERVICE);
 	rtas_args->nargs = 0;
@@ -516,7 +516,6 @@
 	printk("%u %u Ready to die...\n",
 	       smp_processor_id(), hard_smp_processor_id());
 	enter_rtas((void *)__pa(rtas_args));
-	spin_unlock_irqrestore(&rtas.lock, s);
 
 	panic("Alas, I survived.\n");
 }


