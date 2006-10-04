Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030814AbWJDLR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030814AbWJDLR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030816AbWJDLR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:17:26 -0400
Received: from www.osadl.org ([213.239.205.134]:22495 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030814AbWJDLRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:17:24 -0400
Subject: Re: [patch] clockevents: drivers for i386, fix #2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <20061004105315.GA24940@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	 <20061002210053.16e5d23c.akpm@osdl.org> <20061003084729.GA24961@elte.hu>
	 <20061003103503.GA6350@elte.hu> <20061003203620.d85df9c6.akpm@osdl.org>
	 <20061004064620.GA22364@elte.hu> <20061004003228.98ec3b39.akpm@osdl.org>
	 <20061004075540.GA31415@elte.hu> <20061004011544.d49308de.akpm@osdl.org>
	 <20061004105315.GA24940@elte.hu>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 13:19:35 +0200
Message-Id: <1159960776.1386.244.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 12:53 +0200, Ingo Molnar wrote:
> there's one material difference we just found: in the !hres case we'll 
> do the timer IRQ handling mostly from the lapic vector - while in 
> mainline we do it from the irq0 vector. So, how does your 
> /proc/interrupts look like? How frequently does LOC increase, and how 
> frequently does IRQ 0 increase?
> 
> (meanwhile we'll fix and restore things so that it matches mainline 
> behavior.)

Andrew, does the patch below fix your problem ?

You should see the same weird behaviour when you run a plain -mm3 with
CONFIG_SMP=y on that box. This moves update_process_times() to the lapic
too.
	tglx


Index: linux-2.6.18-mm3/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.18-mm3.orig/arch/i386/kernel/apic.c	2006-10-04 13:02:35.000000000 +0200
+++ linux-2.6.18-mm3/arch/i386/kernel/apic.c	2006-10-04 12:59:06.000000000 +0200
@@ -84,7 +84,9 @@ static void lapic_timer_setup(enum clock
 static struct clock_event_device lapic_clockevent = {
 	.name = "lapic",
 	.capabilities = CLOCK_CAP_NEXTEVT | CLOCK_CAP_PROFILE
+#ifdef CONFIG_SMP
 			| CLOCK_CAP_UPDATE,
+#endif
 	.shift = 32,
 	.set_mode = lapic_timer_setup,
 	.set_next_event = lapic_next_event,




