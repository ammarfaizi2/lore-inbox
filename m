Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUD1Tmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUD1Tmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUD1TlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:41:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52946 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265040AbUD1SYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 14:24:51 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16527.63123.869014.733258@segfault.boston.redhat.com>
Date: Wed, 28 Apr 2004 14:23:15 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
In-Reply-To: <20040428142753.GE28459@waste.org>
References: <16519.58589.773562.492935@segfault.boston.redhat.com>
	<20040425191543.GV28459@waste.org>
	<16527.42815.447695.474344@segfault.boston.redhat.com>
	<20040428140353.GC28459@waste.org>
	<16527.47765.286783.249944@segfault.boston.redhat.com>
	<20040428142753.GE28459@waste.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netconsole hangs w/ alt-sysrq-t; Matt Mackall <mpm@selenic.com> adds:

[snip]

mpm> Well process context defeats the purpose. Ok, I've more closely read
mpm> your report and if I understand correctly, you're using the NAPI
mpm> version of e100? There's some magic NAPI bits in netpoll_poll that
mpm> might help here:
>> Yes, sorry I didn't specify that earlier.
>> 
mpm> if(trapped && np->dev->poll && test_bit(__LINK_STATE_RX_SCHED,
mpm> &np->dev->state))
np-> dev->poll(np->dev, &budget);
>>
mpm> Perhaps we need to pull the trapped test out of there. Then with any
mpm> luck, dev->hard_start_xmit will return non-zero in netpoll_send_skb,
mpm> we'll call netpoll_poll to pump the card, and we'll be able to flush
mpm> it.
>> I don't think so.  You can end up in code running in interrupt context
>> that is not designed to (ip routing code, etc).  I've been down that
>> path already.  I only defer to process context if irqs_disabled().

mpm> Fair enough. Turning on trapped basically short circuits the rest of
mpm> the NAPI code so that stuff doesn't hit the stack when we call ->poll.
mpm> Could you try doing a netpoll_set_trap(1)/(0) around the call to
mpm> ->poll and see if that actually lets the thing work? Then we can try
mpm> to figure out the right way to do this.

Okay, I tried that before and I still ran into problems.  Just to be sure,
I grabbed 2.6.6-rc3 and tried your suggestion.  The resulting stack trace
is at the end of this message.  I can't explain how we get from
netif_receive_skb to anywhere up the stack, though.  Perhaps you'll have
better luck with it.

Note that this is alt-sysrq-t output, so the first bits of stack you see
are not relevant.  What counts is everything after the Badness in
local_bh_enable.

mpm> My point about deferring still stands, as when we're dumping an oops,
mpm> we can't really expect that we'll ever get to a process context.

Sure, but you can explicitly flush the queue in such a circumstance, though
this is still not an ideal solution.

-Jeff


pdflush       S 00000000     0     9      4            10     8 (L-TLB)
cfe03f7c 00000046 00000000 00000000 00000000 00000000 cfe03f48 c011fa9c
       5ec54655 123c321a 00000000 00000002 cff725d0 cff736b0 cff736d0 c1244ce0
       0000119b 4318ade1 00000006 cfe12650 cfe12808 00000046 00000000 00000003
Call Trace:
 [<c011fa9c>] recalc_task_prio+0x8c/0x1a0
 [<c014bb80>] pdflush+0x0/0x20
 [<c014b918>] __pdflush+0xb8/0x320
 [<c014bb9a>] pdflush+0x1a/0x20
 [<c014bb80>] pdflush+0x0/0x20
 [<c013b09c>] Badness in local_bh_enable at kernel/softirq.c:136
Call Trace:
 [<c012ab64>] local_bh_enable+0x84/0x90
 [<c02b638e>] neigh_lookup+0x7e/0xb0
 [<c02f3260>] arp_process+0x200/0x530
 [<c0120e9b>] rebalance_tick+0x3b/0xf0
 [<c02b1363>] netif_receive_skb+0x1d3/0x280
 [<d08ff2d7>] e100_poll+0x6e7/0x760 [e100]
 [<d08fe4b4>] e100_xmit_frame+0x284/0x400 [e100]
 [<d08febf0>] e100_poll+0x0/0x760 [e100]
 [<c02bd13e>] netpoll_poll+0x5e/0x60
 [<c02bd413>] netpoll_send_skb+0xc3/0x120
 [<d086a058>] write_msg+0x58/0x60 [netconsole]
 [<d086a000>] write_msg+0x0/0x60 [netconsole]
 [<c01263c6>] __call_console_drivers+0x56/0x60
 [<c0126927>] release_console_sem+0x77/0x140
 [<c0126790>] printk+0x1c0/0x270
 [<c014bb80>] pdflush+0x0/0x20
 [<c013b09c>] kthread+0x9c/0xb0
 [<c0107f35>] show_trace+0xa5/0xc0
 [<c013b09c>] kthread+0x9c/0xb0
 [<c0107fcb>] show_stack+0x7b/0x90
 [<c012280c>] show_state+0x5c/0x90
 [<c022042e>] __handle_sysrq_nolock+0x6e/0xe6
 [<c02203a0>] handle_sysrq+0x40/0x60
 [<c021a662>] kbd_event+0x32/0x70
 [<c0294ab5>] input_event+0xf5/0x400
 [<c0297cbf>] atkbd_report_key+0x2f/0x80
 [<c0297f33>] atkbd_interrupt+0x223/0x530
 [<c029bb46>] serio_interrupt+0x66/0x70
 [<c029c464>] i8042_interrupt+0xf4/0x190
 [<c0109560>] handle_IRQ_event+0x30/0x60
 [<c01099f1>] do_IRQ+0x121/0x290
 =======================
 [<c0107ba4>] common_interrupt+0x18/0x20
 [<c011007b>] transmeta_identify+0x2b/0x60
 [<c011856f>] apm_bios_call_simple+0x9f/0xe0
 [<c01186d8>] apm_do_idle+0x18/0x70
 [<c01187dc>] apm_cpu_idle+0x7c/0x150
 [<c0105030>] default_idle+0x0/0x40
 [<c01050f6>] cpu_idle+0x46/0x50
 [<c03dd8ff>] start_kernel+0x19f/0x200
 [<c03dd480>] unknown_bootoption+0x0/0x130
