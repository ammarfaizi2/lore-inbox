Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUHUMlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUHUMlP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 08:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUHUMlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 08:41:15 -0400
Received: from main.gmane.org ([80.91.224.249]:24993 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264648AbUHUMlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 08:41:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Karl Vogel <karl.vogel@seagha.com>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P5
Date: Sat, 21 Aug 2004 14:41:37 +0200
Message-ID: <cg7fsv$tao$1@sea.gmane.org>
References: <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: d51a4788e.kabel.telenet.be
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm regularly seeing acpi_ec_read latencies. (e.g. when closing the lid of
my notebook, when the processor cooler activates, ...)

I'm guessing there isn't much that can be done about this, right?!


preemption latency trace v1.0.1
-------------------------------
 latency: 1151 us, entries: 94 (94)
    -----------------
    | task: kacpid/6, uid:0 nice:-10 policy:0 rt_prio:0
    -----------------
 => started at: acpi_ec_read+0x6b/0xf7
 => ended at:   acpi_ec_read+0xc8/0xf7
=======>
00000001 0.000ms (+0.000ms): acpi_ec_read (acpi_ec_space_handler)
00000001 0.000ms (+0.000ms): acpi_hw_low_level_write (acpi_ec_read)
00000001 0.000ms (+0.000ms): acpi_os_write_port (acpi_hw_low_level_write)
00000001 0.001ms (+0.001ms): acpi_ec_wait (acpi_ec_read)
00000001 0.001ms (+0.000ms): acpi_hw_low_level_read (acpi_ec_wait)
00000001 0.001ms (+0.000ms): acpi_os_read_port (acpi_hw_low_level_read)
00000001 0.003ms (+0.001ms): __const_udelay (acpi_ec_wait)
00000001 0.003ms (+0.000ms): __delay (acpi_ec_wait)
00000001 0.003ms (+0.000ms): delay_tsc (__delay)
[...]
00000001 1.113ms (+0.001ms): smp_apic_timer_interrupt (acpi_ec_read)
00010001 1.113ms (+0.000ms): profile_hook (smp_apic_timer_interrupt)
00010002 1.113ms (+0.000ms): notifier_call_chain (profile_hook)
00000002 1.113ms (+0.000ms): do_softirq (smp_apic_timer_interrupt)
00000100 1.113ms (+0.000ms): __do_softirq (do_softirq)
00010001 1.113ms (+0.000ms): do_IRQ (acpi_ec_read)
00010002 1.113ms (+0.000ms): ack_edge_ioapic_irq (do_IRQ)
00010002 1.113ms (+0.000ms): generic_redirect_hardirq (do_IRQ)
00010000 1.113ms (+0.000ms): generic_handle_IRQ_event (do_IRQ)
00010000 1.113ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
00010001 1.113ms (+0.000ms): mark_offset_tsc (timer_interrupt)
00010001 1.123ms (+0.009ms): do_timer (timer_interrupt)
00010001 1.123ms (+0.000ms): update_process_times (do_timer)
00010001 1.123ms (+0.000ms): update_one_process (update_process_times)
00010001 1.123ms (+0.000ms): run_local_timers (update_process_times)
00010001 1.123ms (+0.000ms): raise_softirq (update_process_times)
00010001 1.123ms (+0.000ms): scheduler_tick (update_process_times)
00010001 1.123ms (+0.000ms): sched_clock (scheduler_tick)
00010002 1.123ms (+0.000ms): task_timeslice (scheduler_tick)
00010001 1.123ms (+0.000ms): update_wall_time (do_timer)
00010001 1.123ms (+0.000ms): update_wall_time_one_tick (update_wall_time)
00010002 1.123ms (+0.000ms): generic_note_interrupt (do_IRQ)
00010002 1.123ms (+0.000ms): end_edge_ioapic_irq (do_IRQ)
00000002 1.123ms (+0.000ms): do_softirq (do_IRQ)
00000100 1.123ms (+0.000ms): __do_softirq (do_softirq)
00000001 1.124ms (+0.000ms): sub_preempt_count (acpi_ec_read)

Full trace output available on:
 http://users.telenet.be/kvogel/ec-latency.txt

Culprit is the following code in drivers/acpi/ec.c
function acpi_ec_wait (edited for mail):

----
#define ACPI_EC_UDELAY          100     /* Poll @ 100us increments */
#define ACPI_EC_UDELAY_COUNT    1000    /* Wait 10ms max. during EC ops */

u32                     i = ACPI_EC_UDELAY_COUNT;

do {
    acpi_hw_low_level_read(8, &acpi_ec_status, &ec->status_addr);
    if (acpi_ec_status & ACPI_EC_FLAG_OBF)
            return 0;
    udelay(ACPI_EC_UDELAY);
} while (--i>0);
----

NOTE: isn't the comment on the ACPI_EC_UDELAY_COUNT wrong?! Or is my
arithmetic not what it used to be. (1000 loops of 100us = 100ms instead of
10ms, no?)



