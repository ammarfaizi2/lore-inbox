Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWJEJne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWJEJne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 05:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWJEJnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 05:43:33 -0400
Received: from www.osadl.org ([213.239.205.134]:28803 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751573AbWJEJnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 05:43:32 -0400
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <20061005015052.4b4f14e8.akpm@osdl.org>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
	 <20061005011608.b69e3461.akpm@osdl.org>
	 <20061005011909.3e1a9fec.akpm@osdl.org> <20061005082348.GA30940@elte.hu>
	 <20061005015052.4b4f14e8.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 11:48:25 +0200
Message-Id: <1160041705.9060.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 01:50 -0700, Andrew Morton wrote:
> The stock kernel shows a local-apic interrupt rate of 18Hz (HZ=250).  Other
> times I've seen 13Hz.
> 
> With this patch series applied, disabling the local apic in config fixes
> things up (using the PIT).
> 
> With the stock kernel and SMP, the system is slow, but not _as_ slow. 
> Bootup takes maybe twice as long, but not all week.  This time the local
> APIC interrupt rate is 8Hz, so something peculiar is happening here -
> nothing is proportional.

The stock SMP kernel increases jiffies in IRQ0, while HIGH_RES=y
emulates the tick via the lapic timer. If you disable lapic, hrtimer
emulates via PIT in the HIGH_RES=y case.

> It'd be nice to fix the local apic rather than working around it.  Any idea
> why it's doing this?

Not at all. Can you please apply the patch below and add "apic=verbose"
to the commandline ? This should give use some hint.

Watch out for "calibrating APIC timer ..." in the boot messages.

	tglx

Index: linux-2.6.18-mm3/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.18-mm3.orig/arch/i386/kernel/apic.c	2006-10-04 19:11:08.000000000 +0200
+++ linux-2.6.18-mm3/arch/i386/kernel/apic.c	2006-10-05 11:33:04.000000000 +0200
@@ -1147,7 +1147,7 @@ static int __init calibrate_APIC_clock(v
 	lapic_clockevent.min_delta_ns =
 		clockevent_delta2ns(0xF, &lapic_clockevent);
 
-	apic_printk(APIC_VERBOSE, "..... tt1-tt2 %ld\n", tt1 - tt2);
+	apic_printk(APIC_VERBOSE, "..... tt1: %ld tt2: %ld\n", tt1, tt2);
 	apic_printk(APIC_VERBOSE, "..... mult: %ld\n", lapic_clockevent.mult);
 	apic_printk(APIC_VERBOSE, "..... calibration result: %ld\n", result);
 


