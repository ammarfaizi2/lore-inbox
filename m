Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTI2RH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbTI2RHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:07:07 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:20663 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263793AbTI2REy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:04:54 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] K7 MCE handler fixes.
Message-Id: <E1A41Rq-0000N7-00@hardwired>
Date: Mon, 29 Sep 2003 18:04:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't poke bank 0 on Athlon, some of them don't like it
and raise spurious MCEs.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/mcheck/k7.c linux-2.5/arch/i386/kernel/cpu/mcheck/k7.c
--- bk-linus/arch/i386/kernel/cpu/mcheck/k7.c	2003-09-08 00:44:57.000000000 +0100
+++ linux-2.5/arch/i386/kernel/cpu/mcheck/k7.c	2003-09-29 03:34:58.000000000 +0100
@@ -31,7 +31,7 @@ static void k7_machine_check(struct pt_r
 	printk (KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n",
 		smp_processor_id(), mcgsth, mcgstl);
 
-	for (i=0; i<nr_mce_banks; i++) {
+	for (i=1; i<nr_mce_banks; i++) {
 		rdmsr (MSR_IA32_MC0_STATUS+i*4,low, high);
 		if (high&(1<<31)) {
 			if (high & (1<<29))
@@ -81,6 +81,9 @@ void __init amd_mcheck_init(struct cpuin
 		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 	nr_mce_banks = l & 0xff;
 
+	/* Clear status for MC index 0 separately, we don't touch CTL,
+	 * as some Athlons cause spurious MCEs when its enabled. */
+	wrmsr (MSR_IA32_MC0_STATUS, 0x0, 0x0);
 	for (i=1; i<nr_mce_banks; i++) {
 		wrmsr (MSR_IA32_MC0_CTL+4*i, 0xffffffff, 0xffffffff);
 		wrmsr (MSR_IA32_MC0_STATUS+4*i, 0x0, 0x0);
