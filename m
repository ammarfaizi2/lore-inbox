Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132396AbRA1RYe>; Sun, 28 Jan 2001 12:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129445AbRA1RYZ>; Sun, 28 Jan 2001 12:24:25 -0500
Received: from chiara.elte.hu ([157.181.150.200]:2052 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129235AbRA1RXw>;
	Sun, 28 Jan 2001 12:23:52 -0500
Date: Sun, 28 Jan 2001 18:21:54 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linux SMP mailinglist <linux-smp@vger.kernel.org>
Subject: [patch] new, scalable timer implementation, smptimers-2.4.0-B1
Message-ID: <Pine.LNX.4.30.0101281752090.2612-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


a new, 'ultra SMP scalable' implementation of Linux kernel timers is now
available for download:

    http://www.redhat.com/~mingo/scalable-timers/smptimers-2.4.0-B1

the patch is against 2.4.1-pre10 or ac12. The timer design in this
implementation is a work of David Miller, Alexey Kuznetsov and myself.

Internals: the current 2.4 timer implementation uses a global spinlock for
synchronizing access to the global timer lists. This causes excessive
cacheline ping-pongs and visible performance degradation under very high
TCP networking load (and other, timer-intensive operations).

The new implementation introduces per-CPU timer lists and per-CPU
spinlocks that protect them. All timer operations, add_timer(),
del_timer() and mod_timer() are still O(1) and cause no cacheline
contention at all (because all data structures are separated). All
existing semantics of Linux timers are preserved, so the patch is
'transparent' to all other subsystems.

In addition, the role of TIMER_BH has been redefined, and run_local_timers
is used directly from APIC timer interrupts to run timers (not from
TIMER_BH). This means that timer expiry is per-CPU as well - it is global
in vanilla 2.4. Every timer is started and expired on the CPU where it has
been added. Timers get migrated between CPUs if mod_timer() is done on
another CPU (because eg. a process using them migrates to another CPU.).
In the typical case timer handling is completely localized to one CPU.

The new timers still maintain 'semantical compatibility' with older
concepts such as the IRQ lock and manipulation of TIMER_BH state. These
constructs are quite rare already, in 2.5 they can be removed completely.

the patch has been sanity tested on UP-pure, UP-APIC, UP-IOAPIC and SMP
systems. Reports/comments/questions/suggestions welcome!

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
