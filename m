Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVAQCeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVAQCeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 21:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVAQCeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 21:34:44 -0500
Received: from ozlabs.org ([203.10.76.45]:16537 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262670AbVAQCei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 21:34:38 -0500
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, manpreet@fabric7.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
In-Reply-To: <20050115040951.GC13525@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 13:34:24 +1100
Message-Id: <1105929264.3954.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 05:09 +0100, Andi Kleen wrote:
> Fix boot up SMP race in timer setup on i386/x86-64.

How's this?  Didn't do x86-64, but tested on i386.

Rusty.

Name: x86: no interrupts from secondary CPUs until officially online
Status: Tested on dual Pentium II, 2.6.11-rc1-bk2
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Andi Kleen reported a problem where a very slow boot caused the timer
interrupt on a secondary CPU to go off before the CPU was actually
brought up by the core code, so the CPU_PREPARE notifier hadn't been
called, so the per-cpu timer code wasn't set up.

This was caused by enabling interrupts around calibrate_delay() on
secondary CPUs, which is not actually neccessary (interrupts on CPU 0
increments jiffies, which is all that is required).  So delay enabling
interrupts until the actual __cpu_up() call for that CPU.

Index: linux-2.6.11-rc1-bk2-Misc/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.11-rc1-bk2-Misc.orig/arch/i386/kernel/smpboot.c	2005-01-13 12:10:07.000000000 +1100
+++ linux-2.6.11-rc1-bk2-Misc/arch/i386/kernel/smpboot.c	2005-01-17 12:29:40.000000000 +1100
@@ -383,8 +383,6 @@
 	setup_local_APIC();
 	map_cpu_to_logical_apicid();
 
-	local_irq_enable();
-
 	/*
 	 * Get our bogomips.
 	 */
@@ -397,7 +395,7 @@
  	smp_store_cpu_info(cpuid);
 
 	disable_APIC_timer();
-	local_irq_disable();
+
 	/*
 	 * Allow the master to continue.
 	 */
@@ -439,6 +438,10 @@
 	 */
 	local_flush_tlb();
 	cpu_set(smp_processor_id(), cpu_online_map);
+
+	/* We can take interrupts now: we're officially "up". */
+	local_irq_enable();
+
 	wmb();
 	cpu_idle();
 }
Index: linux-2.6.11-rc1-bk2-Misc/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.11-rc1-bk2-Misc.orig/arch/i386/kernel/apic.c	2005-01-13 12:10:07.000000000 +1100
+++ linux-2.6.11-rc1-bk2-Misc/arch/i386/kernel/apic.c	2005-01-17 12:29:22.000000000 +1100
@@ -1046,9 +1046,7 @@
 
 void __init setup_secondary_APIC_clock(void)
 {
-	local_irq_disable(); /* FIXME: Do we need this? --RR */
 	setup_APIC_timer(calibration_result);
-	local_irq_enable();
 }
 
 void __init disable_APIC_timer(void)

-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

