Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUIGENL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUIGENL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 00:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUIGENL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 00:13:11 -0400
Received: from ozlabs.org ([203.10.76.45]:18563 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267551AbUIGEMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 00:12:55 -0400
Date: Tue, 7 Sep 2004 14:08:16 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] Fix POWER5/JS20 SMP init
Message-ID: <20040907040815.GX7716@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

My recent change to dynamically allocate emergency stacks broke JS20
blades and POWER5. Since we use the emergency stacks in real mode during
secondary CPU bringup they must be below the RMO.

Signed-off-by: Anton Blanchard <anton@samba.org>

Anton

--

diff -puN arch/ppc64/kernel/setup.c~debug_js20_smp arch/ppc64/kernel/setup.c
--- foobar2/arch/ppc64/kernel/setup.c~debug_js20_smp	2004-09-06 22:05:07.170412339 +1000
+++ foobar2-anton/arch/ppc64/kernel/setup.c	2004-09-07 13:48:49.364245252 +1000
@@ -695,16 +695,23 @@ static void __init irqstack_early_init(v
  */
 static void __init emergency_stack_init(void)
 {
+	unsigned long limit;
 	unsigned int i;
 
 	/*
 	 * Emergency stacks must be under 256MB, we cannot afford to take
 	 * SLB misses on them. The ABI also requires them to be 128-byte
 	 * aligned.
+	 *
+	 * Since we use these as temporary stacks during secondary CPU
+	 * bringup, we need to get at them in real mode. This means they
+	 * must also be within the RMO region.
 	 */
+	limit = min(0x10000000UL, lmb.rmo_size);
+
 	for_each_cpu(i)
 		paca[i].emergency_sp = __va(lmb_alloc_base(PAGE_SIZE, 128,
-						0x10000000)) + PAGE_SIZE;
+						limit)) + PAGE_SIZE;
 }
 
 /*
_
