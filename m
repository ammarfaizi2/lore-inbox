Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSKRHP0>; Mon, 18 Nov 2002 02:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSKRHPZ>; Mon, 18 Nov 2002 02:15:25 -0500
Received: from holomorphy.com ([66.224.33.161]:43485 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261568AbSKRHPZ>;
	Mon, 18 Nov 2002 02:15:25 -0500
Date: Sun, 17 Nov 2002 23:19:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
Message-ID: <20021118071946.GH23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com> <20021118065705.GG11776@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021118065705.GG11776@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 10:57:05PM -0800, William Lee Irwin III wrote:
> This oopses on NUMA-Q sometime prior to TSC synch and then hangs in TSC
> synch because not all cpus are responding where 2.5.47-mm3 (which
> included some intermediate bk stuff) did not. This is because AP's are
> taking timer interrupts before they are prepared to do so. Please apply
> the following patch from Martin Bligh which resolves this issue:

Actually, please apply this one instead. The prior patch did not
re-enable interrupts appropriately in its return paths (pointed out
by Andrew Morton):


diff -urpN linux-2.5.48/arch/i386/kernel/smpboot.c numaq-2.5.48/arch/i386/kernel/smpboot.c
--- linux-2.5.48/arch/i386/kernel/smpboot.c	2002-11-17 20:29:45.000000000 -0800
+++ numaq-2.5.48/arch/i386/kernel/smpboot.c	2002-11-17 22:35:05.000000000 -0800
@@ -419,6 +419,7 @@ void __init smp_callin(void)
  	smp_store_cpu_info(cpuid);
 
 	disable_APIC_timer();
+	local_irq_disable();
 	/*
 	 * Allow the master to continue.
 	 */
@@ -1179,13 +1180,18 @@ void __init smp_prepare_cpus(unsigned in
 int __devinit __cpu_up(unsigned int cpu)
 {
 	/* This only works at boot for x86.  See "rewrite" above. */
-	if (test_bit(cpu, &smp_commenced_mask))
+	if (test_bit(cpu, &smp_commenced_mask)) {
+		local_irq_enable();
 		return -ENOSYS;
+	}
 
 	/* In case one didn't come up */
-	if (!test_bit(cpu, &cpu_callin_map))
+	if (!test_bit(cpu, &cpu_callin_map)) {
+		local_irq_enable();
 		return -EIO;
+	}
 
+	local_irq_enable();
 	/* Unleash the CPU! */
 	set_bit(cpu, &smp_commenced_mask);
 	while (!test_bit(cpu, &cpu_online_map))
