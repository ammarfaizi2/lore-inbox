Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSKRGwo>; Mon, 18 Nov 2002 01:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbSKRGwo>; Mon, 18 Nov 2002 01:52:44 -0500
Received: from holomorphy.com ([66.224.33.161]:38109 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261550AbSKRGwn>;
	Mon, 18 Nov 2002 01:52:43 -0500
Date: Sun, 17 Nov 2002 22:57:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
Message-ID: <20021118065705.GG11776@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 08:41:05PM -0800, Linus Torvalds wrote:
> Hmm.. All over the place, best you see the changelog. Lots of small 
> cleanups (remove unnecessary header files etc), but a few more fundamental 
> changes too. Times in nsecs in stat64(), for example, and the 
> oft-discussed kernel module loader changes..

This oopses on NUMA-Q sometime prior to TSC synch and then hangs in TSC
synch because not all cpus are responding where 2.5.47-mm3 (which
included some intermediate bk stuff) did not. This is because AP's are
taking timer interrupts before they are prepared to do so. Please apply
the following patch from Martin Bligh which resolves this issue:


Thanks,
Bill


diff -purN -X /home/mbligh/.diff.exclude virgin/arch/i386/kernel/smpboot.c noearlyirq/arch/i386/kernel/smpboot.c
--- virgin/arch/i386/kernel/smpboot.c	Mon Nov  4 14:30:27 2002
+++ noearlyirq/arch/i386/kernel/smpboot.c	Wed Nov  6 15:22:12 2002
@@ -419,6 +419,7 @@ void __init smp_callin(void)
  	smp_store_cpu_info(cpuid);
 
 	disable_APIC_timer();
+	local_irq_disable();
 	/*
 	 * Allow the master to continue.
 	 */
@@ -1186,6 +1187,7 @@ int __devinit __cpu_up(unsigned int cpu)
 	if (!test_bit(cpu, &cpu_callin_map))
 		return -EIO;
 
+	local_irq_enable();
 	/* Unleash the CPU! */
 	set_bit(cpu, &smp_commenced_mask);
 	while (!test_bit(cpu, &cpu_online_map))
