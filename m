Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSKRSXa>; Mon, 18 Nov 2002 13:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSKRSXa>; Mon, 18 Nov 2002 13:23:30 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:54148 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262826AbSKRSX2>;
	Mon, 18 Nov 2002 13:23:28 -0500
Date: Mon, 18 Nov 2002 19:30:37 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: torvalds@transmeta.com
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
Message-ID: <Pine.LNX.4.44.0211181920540.11872-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At least the 2nd hunk is bogus:

@@ -1179,13 +1180,18 @@ void __init smp_prepare_cpus(unsigned in
 int __devinit __cpu_up(unsigned int cpu)
 {
 	/* This only works at boot for x86.  See "rewrite" above. */
-	if (test_bit(cpu, &smp_commenced_mask))
+	if (test_bit(cpu, &smp_commenced_mask)) {
+		local_irq_enable();
 		return -ENOSYS;
+	}

__cpu_up is called in the context of the boot cpu, not in the context of 
the new cpu.

I think this patch should keep the interrupts disabled until after
smp_commenced is set. It's partially tested: bochs boots until all cpus
are up and then crashes.

I've tested the interrupt flag (pushfl;popfl), noone else enables them.

--
	Manfred

--- 2.5/arch/i386/kernel/smpboot.c	2002-11-04 23:30:27.000000000 +0100
+++ build-2.5/arch/i386/kernel/smpboot.c	2002-11-18 19:19:38.000000000 +0100
@@ -405,8 +405,6 @@
 		clear_local_APIC();
 	setup_local_APIC();
 
-	local_irq_enable();
-
 	/*
 	 * Get our bogomips.
 	 */
@@ -449,6 +447,8 @@
 	smp_callin();
 	while (!test_bit(smp_processor_id(), &smp_commenced_mask))
 		rep_nop();
+
+	local_irq_enable();
 	setup_secondary_APIC_clock();
 	if (nmi_watchdog == NMI_IO_APIC) {
 		disable_8259A_irq(0);

