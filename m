Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261466AbSJADgZ>; Mon, 30 Sep 2002 23:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261467AbSJADgZ>; Mon, 30 Sep 2002 23:36:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:38588 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261466AbSJADgX>;
	Mon, 30 Sep 2002 23:36:23 -0400
Date: Tue, 1 Oct 2002 05:51:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: george anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
In-Reply-To: <3D98C60B.9C1EA90B@mvista.com>
Message-ID: <Pine.LNX.4.44.0210010542240.2564-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Sep 2002, george anzinger wrote:

> As the APIC timers are currently set up they are undisciplined WRT the
> PIT which is still used to drive the clock.  This means that, since this
> patch drives the "run_timer_list" code from the APIC timers, the actual
> delay in timer servicing from the requested time will vary with a.) the
> cpu (since each cpu is set up to have its timer expire at a different
> time within the 1/HZ tick) and b.) over time as the PIT and the APIC
> clocks drift.  This may be acceptable with 1/HZ timer resolution
> (however I don't really think it is), but it is in no way acceptable WRT
> high resolution timers.

the smp_processor_id()/(HZ*num_cpus) 'interleaving' of every APIC clock
was an SMP scalability issue, and it was done as part of the smptimers
patch. It just got into the kernel much earlier.

but these days, with the removal of BHs, it might be less of a factor,
mainly because timers have no global synchronization anymore, so we can
again try to not interleave the APIC clocks. Only testing will tell,
because there might be some interaction between timer-generated code
still.

Dipankar, wli, would it be possible to try the attached simple patch with
some of the more complex networking loads? The patch gets rid of the APIC
timer interleaving.

	Ingo

--- arch/i386/kernel/apic.c.orig	Tue Oct  1 05:47:34 2002
+++ arch/i386/kernel/apic.c	Tue Oct  1 05:49:23 2002
@@ -813,24 +813,9 @@
 
 static void setup_APIC_timer(unsigned int clocks)
 {
-	unsigned int slice, t0, t1;
 	unsigned long flags;
-	int delta;
 
-	local_save_flags(flags);
-	local_irq_enable();
-	/*
-	 * ok, Intel has some smart code in their APIC that knows
-	 * if a CPU was in 'hlt' lowpower mode, and this increases
-	 * its APIC arbitration priority. To avoid the external timer
-	 * IRQ APIC event being in synchron with the APIC clock we
-	 * introduce an interrupt skew to spread out timer events.
-	 *
-	 * The number of slices within a 'big' timeslice is NR_CPUS+1
-	 */
-
-	slice = clocks / (NR_CPUS+1);
-	printk("cpu: %d, clocks: %d, slice: %d\n", smp_processor_id(), clocks, slice);
+	local_irq_save(flags);
 
 	/*
 	 * Wait for IRQ0's slice:
@@ -839,22 +824,6 @@
 
 	__setup_APIC_LVTT(clocks);
 
-	t0 = apic_read(APIC_TMICT)*APIC_DIVISOR;
-	/* Wait till TMCCT gets reloaded from TMICT... */
-	do {
-		t1 = apic_read(APIC_TMCCT)*APIC_DIVISOR;
-		delta = (int)(t0 - t1 - slice*(smp_processor_id()+1));
-	} while (delta >= 0);
-	/* Now wait for our slice for real. */
-	do {
-		t1 = apic_read(APIC_TMCCT)*APIC_DIVISOR;
-		delta = (int)(t0 - t1 - slice*(smp_processor_id()+1));
-	} while (delta < 0);
-
-	__setup_APIC_LVTT(clocks);
-
-	printk("CPU%d<T0:%d,T1:%d,D:%d,S:%d,C:%d>\n", smp_processor_id(), t0, t1, delta, slice, clocks);
-
 	local_irq_restore(flags);
 }
 

