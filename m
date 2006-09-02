Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWIBDNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWIBDNj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 23:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIBDNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 23:13:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbWIBDNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 23:13:39 -0400
Date: Fri, 1 Sep 2006 20:13:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Frank v Waveren <fvw@var.cx>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-Id: <20060901201305.f01ec7d2.akpm@osdl.org>
In-Reply-To: <1157103042.29250.337.camel@localhost.localdomain>
References: <1156927468.29250.113.camel@localhost.localdomain>
	<20060831204612.73ed7f33.akpm@osdl.org>
	<1157100979.29250.319.camel@localhost.localdomain>
	<20060901020404.c8038837.akpm@osdl.org>
	<1157103042.29250.337.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Sep 2006 11:30:42 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> > 
> > With that patch the machine emits 88 bigabytes of stuff then locks up. 
> > Something a little less aggressive is needed, methinks.
> 
> Fun, here is a version with a bigabyte blocker.

Your patch triggers waaaaaaay early.

netconsole: remote IP 192.168.2.33
netconsole: remote ethernet address 00:0d:56:c6:c6:cc
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 3400.238 MHz processor.
ktime_set: -1157140842 : 0
BUG: warning at include/linux/ktime.h:84/ktime_set()

Call Trace:
 <IRQ> [<ffffffff80247021>] hrtimer_run_queues+0x10e/0x211
 [<ffffffff8023a5ca>] run_timer_softirq+0x28/0x1dc
 [<ffffffff802368f1>] __do_softirq+0x58/0xcf
 [<ffffffff8020ac28>] call_softirq+0x1c/0x28
 [<ffffffff8020c7b5>] do_softirq+0x31/0x84
 [<ffffffff802365ea>] irq_exit+0x3f/0x4b
 [<ffffffff8020c77a>] do_IRQ+0x62/0x6c
 [<ffffffff80209f1d>] ret_from_intr+0x0/0xa
 <EOI> [<ffffffff806a46ec>] console_init+0x0/0x37
 [<ffffffff80691749>] start_kernel+0x123/0x1d0
 [<ffffffff8069127a>] _sinittext+0x27a/0x281

Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)


So I modified it to only trigger if current->mm!=NULL and:

EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 156k freed
ktime_set: -1157141318 : 0
BUG: warning at kernel/hrtimer.c:892/ktime_set()

Call Trace:
 <IRQ> [<ffffffff80246957>] ktime_set+0x73/0x8b
 [<ffffffff80246de4>] hrtimer_run_queues+0x55/0x140
 [<ffffffff8023a4f2>] run_timer_softirq+0x28/0x1dc
 [<ffffffff80236819>] __do_softirq+0x58/0xcf
 [<ffffffff8020ac28>] call_softirq+0x1c/0x28
 [<ffffffff8020c7b5>] do_softirq+0x31/0x84
 [<ffffffff80236512>] irq_exit+0x3f/0x4b
 [<ffffffff802193b1>] smp_apic_timer_interrupt+0x42/0x46
 [<ffffffff8020a5c6>] apic_timer_interrupt+0x66/0x6c
 <EOI> [<ffffffff8026611b>] __handle_mm_fault+0x42a/0x990
 [<ffffffff802660fa>] __handle_mm_fault+0x409/0x990
 [<ffffffff804d6629>] _spin_unlock_irqrestore+0x1a/0x38
 [<ffffffff8021f656>] do_page_fault+0x3b6/0x75c
 [<ffffffff8025d214>] free_hot_cold_page+0x12c/0x14f
 [<ffffffff8025d28a>] free_hot_page+0xb/0xd
 [<ffffffff8025d2b5>] __free_pages+0x29/0x32
 [<ffffffff8025d33e>] free_pages+0x80/0x82
 [<ffffffff8020a721>] error_exit+0x0/0x84

I wonder if this is related to the occasional hrtimr_run_queues() lockup
which Andi is encountering.


-- 
VGER BF report: H 9.0096e-09
