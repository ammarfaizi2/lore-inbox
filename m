Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWABRpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWABRpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 12:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWABRpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 12:45:05 -0500
Received: from mail.gmx.net ([213.165.64.21]:37795 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750873AbWABRpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 12:45:04 -0500
X-Authenticated: #4399952
Date: Mon, 2 Jan 2006 18:45:02 +0100
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
Subject: Re: another BUG in 2.6.15-rc7-rt1
Message-ID: <20060102184502.77a08bc6@mango.fruits.de>
In-Reply-To: <20060102124608.GB27243@elte.hu>
References: <20060102132718.292ff55c@mango.fruits.de>
	<20060102124608.GB27243@elte.hu>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jan 2006 13:46:08 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> > same config as last one. This one happened when a test program of mine 
> > using RTC was running (midi_timer - it just simply tries to send midi 
> > notes at a very regular interval). when additionally i started pmidi, 
> > i got this BUG in the logs (pmidi 1.6 seemingly uses RTC, too).
> > 
> > I also see some other problems with RTC used in sequencers like 
> > rosegarden. Sometimes everything just collapses and i get millions of 
> > "RTC: lost some interrupts at X hz". I never caught the original 
> > message. Will look out for it. I also suspected rosegarden tobe the 
> > culprit, but it seems something _is_ going on with RTC.
> 
> could you try -rc7-rt2, does it produce the same problems? (it includes 
> Steve's RTC patch, so try this only if you have not tried his patch yet)

Hi,

sorry for the late answer.. I still get this one on bootup (with some
context):

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS735 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
BUG: swapper:0 task might have lost a preemption check!
 [<c0100b3b>] cpu_idle+0x6b/0xb0 (8)
 [<c010026b>] _stext+0x4b/0x60 (4)
 [<c0364831>] start_kernel+0x191/0x210 (16)
 [<c0364350>] unknown_bootoption+0x0/0x200 (20)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (swapper/0 [c0319d20, 140]):
------------------------------

Time: tsc clocksource has been installed.
hda: ST340823A, ATA DISK drive
hdb: IC35L060AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x
...

ruinning pmidi only now produces:

Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225
Seq: oops. Trying to get pointer to client 225

in the dmesg output. Rosegarden produces this BUG:

BUG: scheduling while atomic: IRQ 8/0x00000001/18
caller is schedule+0x85/0x120
 [<c02d9c72>] __schedule+0x4a2/0x710 (8)
 [<c02d9f65>] schedule+0x85/0x120 (8)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (36)
 [<c013953a>] sub_preempt_count+0x1a/0x20 (4)
 [<c02d9f65>] schedule+0x85/0x120 (24)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (4)
 [<c013953a>] sub_preempt_count+0x1a/0x20 (12)
 [<c02db376>] __down_mutex+0x556/0x910 (12)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (16)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (72)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (8)
 [<c0142370>] do_irqd+0x0/0xa0 (8)
 [<c02ddac3>] _spin_lock_irqsave+0x23/0x60 (4)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (8)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (16)
 [<c011fd20>] __mod_timer+0x30/0xe0 (16)
 [<c02378ce>] rtc_interrupt+0x11e/0x140 (32)
 [<c0141126>] handle_IRQ_event+0x76/0xf0 (20)
 [<c0142370>] do_irqd+0x0/0xa0 (44)
 [<c0142215>] thread_edge_irq+0x85/0x130 (4)
 [<c01422f7>] do_hardirq+0x37/0xb0 (32)
 [<c01423d7>] do_irqd+0x67/0xa0 (16)
 [<c012c3d6>] kthread+0xb6/0xc0 (28)
 [<c012c320>] kthread+0x0/0xc0 (24)
 [<c0100ded>] kernel_thread_helper+0x5/0x18 (16)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013948a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x60)

------------------------------
| showing all locks held by: |  (IRQ 8/18 [efd1ce90,   1]):

------------------------------

BUG: scheduling while atomic: IRQ 8/0x00000001/18
caller is schedule+0x85/0x120
 [<c02d9c72>] __schedule+0x4a2/0x710 (8)
 [<c02d9f65>] schedule+0x85/0x120 (8)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (36)
 [<c013953a>] sub_preempt_count+0x1a/0x20 (4)
 [<c02d9f65>] schedule+0x85/0x120 (24)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (4)
 [<c013953a>] sub_preempt_count+0x1a/0x20 (12)
 [<c02db376>] __down_mutex+0x556/0x910 (12)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (16)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (72)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (8)
 [<c0142370>] do_irqd+0x0/0xa0 (8)
 [<c02ddac3>] _spin_lock_irqsave+0x23/0x60 (4)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (8)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (16)
 [<c011fd20>] __mod_timer+0x30/0xe0 (16)
 [<c02378ce>] rtc_interrupt+0x11e/0x140 (32)
 [<c0141126>] handle_IRQ_event+0x76/0xf0 (20)
 [<c0142370>] do_irqd+0x0/0xa0 (44)
 [<c0142215>] thread_edge_irq+0x85/0x130 (4)
 [<c01422f7>] do_hardirq+0x37/0xb0 (32)
 [<c01423d7>] do_irqd+0x67/0xa0 (16)
 [<c012c3d6>] kthread+0xb6/0xc0 (28)
 [<c012c320>] kthread+0x0/0xc0 (24)
 [<c0100ded>] kernel_thread_helper+0x5/0x18 (16)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013948a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x60)

------------------------------
| showing all locks held by: |  (IRQ 8/18 [efd1ce90,   1]):
------------------------------

BUG: scheduling while atomic: IRQ 8/0x00000001/18
caller is schedule+0x85/0x120
 [<c02d9c72>] __schedule+0x4a2/0x710 (8)
 [<c02d9f65>] schedule+0x85/0x120 (8)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (36)
 [<c013953a>] sub_preempt_count+0x1a/0x20 (4)
 [<c02d9f65>] schedule+0x85/0x120 (24)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (4)
 [<c013953a>] sub_preempt_count+0x1a/0x20 (12)
 [<c02db376>] __down_mutex+0x556/0x910 (12)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (16)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (72)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (8)
 [<c0142370>] do_irqd+0x0/0xa0 (8)
 [<c02ddac3>] _spin_lock_irqsave+0x23/0x60 (4)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (8)
 [<c011fcc4>] lock_timer_base+0x24/0x50 (16)
 [<c011fd20>] __mod_timer+0x30/0xe0 (16)
 [<c02378ce>] rtc_interrupt+0x11e/0x140 (32)
 [<c0141126>] handle_IRQ_event+0x76/0xf0 (20)
 [<c0142370>] do_irqd+0x0/0xa0 (44)
 [<c0142215>] thread_edge_irq+0x85/0x130 (4)
 [<c01422f7>] do_hardirq+0x37/0xb0 (32)
 [<c01423d7>] do_irqd+0x67/0xa0 (16)
 [<c012c3d6>] kthread+0xb6/0xc0 (28)
 [<c012c320>] kthread+0x0/0xc0 (24)
 [<c0100ded>] kernel_thread_helper+0x5/0x18 (16)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013948a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= _stext+0x3feffde0/0x60)

------------------------------
| showing all locks held by: |  (IRQ 8/18 [efd1ce90,   1]):
------------------------------

and even more of these. So something is still not right..

IRQ 8 is RTC on my box.

Regards, 
Flo

P.S.: will send .config to you provately to save lkml bandwidth :)

-- 
Palimm Palimm!
http://tapas.affenbande.org
