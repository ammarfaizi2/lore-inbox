Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751579AbWJMDUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbWJMDUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 23:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWJMDUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 23:20:12 -0400
Received: from sccrmhc14.comcast.net ([63.240.77.84]:46532 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751579AbWJMDUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 23:20:10 -0400
Date: Thu, 12 Oct 2006 22:22:21 -0500
From: Corey Minyard <minyard@acm.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix i386 NMI watchdog checking
Message-ID: <20061013032221.GA10816@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was having a problem with the NMI testing hanging on an SMP system
in check_nmi_watchdog() when using nmi_watchdog=2.  It doesn't seem to
happen on a stock kernel, but I was working on something else and it
triggered this problem.

This patch solves the problem.  I'm not sure this is quite the right
solution, but I know that the local_irq_enable() is kind of pointless
here and it seems that having scheduling on while the other CPUs are
locked up with interrupts off is a bad idea.  And you can't call
smp_call_function() with interrupts off.  But adding the preempt
disable around this operation seems to solve the problem.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.18/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.18.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.18/arch/i386/kernel/nmi.c
@@ -134,12 +134,18 @@ static int __init check_nmi_watchdog(voi
 
 	printk(KERN_INFO "Testing NMI watchdog ... ");
 
+	/*
+	 * We must have preempt off while testing the local APIC
+	 * watchdog.  If we have an interrupt on this CPU while the
+	 * other CPUs are wedged, and that interrupt tries to schedule
+	 * (and possibly do an IPC), we would be hung.
+	 */
+	preempt_disable();
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
 
 	for_each_possible_cpu(cpu)
 		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
-	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for_each_possible_cpu(cpu) {
@@ -151,6 +157,7 @@ static int __init check_nmi_watchdog(voi
 #endif
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
 			endflag = 1;
+			preempt_enable();
 			printk("CPU#%d: NMI appears to be stuck (%d->%d)!\n",
 				cpu,
 				prev_nmi_count[cpu],
@@ -162,6 +169,7 @@ static int __init check_nmi_watchdog(voi
 		}
 	}
 	endflag = 1;
+	preempt_enable();
 	printk("OK.\n");
 
 	/* now that we know it works we can reduce NMI frequency to
