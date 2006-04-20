Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWDTR1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWDTR1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWDTR1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:27:40 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:25295 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751196AbWDTR1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:27:39 -0400
Date: Thu, 20 Apr 2006 19:27:33 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] -mm: hard/softirq_ctx __read_mostly (CONFIG_4KSTACKS)
Message-ID: <20060420172733.GA13852@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

the hardirq_ctx and softirq_ctx variables are written to on init only,
but in the final kernel image they may easily get linked together with other
often-written variables in the same cacheline, so put them into __read_mostly
section since they are in the highly critical IRQ path.

Patch compiled and tested on 2.6.17-rc1-mm3.
I did not test the powerpc part, though, for obvious reasons.

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.17-rc1-mm3.orig/arch/i386/kernel/irq.c	2006-04-18 11:46:04.000000000 +0200
+++ linux-2.6.17-rc1-mm3/arch/i386/kernel/irq.c	2006-04-20 18:33:14.000000000 +0200
@@ -42,8 +42,8 @@
 	u32                     stack[THREAD_SIZE/sizeof(u32)];
 };
 
-static union irq_ctx *hardirq_ctx[NR_CPUS];
-static union irq_ctx *softirq_ctx[NR_CPUS];
+static union irq_ctx *hardirq_ctx[NR_CPUS] __read_mostly;
+static union irq_ctx *softirq_ctx[NR_CPUS] __read_mostly;
 #endif
 
 /*
--- linux-2.6.17-rc1-mm3.orig/arch/powerpc/kernel/irq.c	2006-04-20 18:47:22.000000000 +0200
+++ linux-2.6.17-rc1-mm3/arch/powerpc/kernel/irq.c	2006-04-20 19:19:25.000000000 +0200
@@ -379,8 +379,8 @@
 #endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_IRQSTACKS
-struct thread_info *softirq_ctx[NR_CPUS];
-struct thread_info *hardirq_ctx[NR_CPUS];
+struct thread_info *softirq_ctx[NR_CPUS] __read_mostly;
+struct thread_info *hardirq_ctx[NR_CPUS] __read_mostly;
 
 void irq_ctx_init(void)
 {



-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
(or alternatively buy nicely packaged Linux distros/OSS software to help
support Linux developers creating shiny new things for you?)
