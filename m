Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUHIPRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUHIPRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUHIPPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:15:33 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:9675 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262406AbUHIPL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:11:56 -0400
Date: Mon, 9 Aug 2004 08:11:53 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH][PPC32] Optimize/fix timer_interrupt loop
Message-ID: <20040809081153.A22692@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes the situation where the loop condition could
generate a next_dec of zero while exiting the loop.  This is suboptimal
on Classic PPC because it forces another interrupt to occur and
reenter the handler. It is fatal on Book E cores, because their
decrementer is stopped when writing a zero (Classic interrupts on
a 0->-1 transition, Book E interrupts on a 1->0 transition). Instead,
stay in the loop on a next_dec==0.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

===== arch/ppc/kernel/time.c 1.29 vs edited =====
--- 1.29/arch/ppc/kernel/time.c	Tue Jun 22 12:05:08 2004
+++ edited/arch/ppc/kernel/time.c	Tue Aug  3 13:32:22 2004
@@ -161,7 +161,7 @@
 
 	irq_enter();
 
-	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
+	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) <= 0) {
 		jiffy_stamp += tb_ticks_per_jiffy;
 		
 		ppc_do_profile(regs);
